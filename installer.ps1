#install Microsoft.UI.2.8.6.Xaml
$progressPreference = 'silentlyContinue'
Invoke-WebRequest `
    -URI https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6 `
    -OutFile xaml.zip -UseBasicParsing
New-Item -ItemType Directory -Path xaml
Expand-Archive -Path xaml.zip -DestinationPath xaml
Remove-Item xaml.zip
Remove-Item xaml -Recurse

# install latest winget version
$API_URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
$DOWNLOAD_URL = $(Invoke-RestMethod $API_URL).assets.browser_download_url |
    Where-Object {$_.EndsWith(".msixbundle")}
Invoke-WebRequest -URI $DOWNLOAD_URL -OutFile winget.msixbundle -UseBasicParsing
Add-AppxPackage winget.msixbundle
Remove-Item winget.msixbundle

# winget script
Function main() {
    $exists = Test-CommandExists winget

    if ($exists) {
        # install programs
        winget install -h -e --id Google.Chrome --accept-source-agreements
        winget install -h -e --id BelgianGovernment.Belgium-eIDmiddleware
        winget install -h -e --id BelgianGovernment.eIDViewer
        winget install -h -e --id Adobe.Acrobat.Reader.64-bit
        # uninstall programs
        winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe --silent
        winget uninstall 9NBLGGH42THS --silent
        winget uninstall 9NBLGGH5FV99 --silent
        winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.People_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.Wallet_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.WindowsMaps_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.MixedReality.Portal_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.BingNews_8wekyb3d8bbwe --silent
        winget uninstall MicrosoftTeams_8wekyb3d8bbwe --silent
        winget uninstall MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe --silent
        winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe --silent
        winget uninstall disney+ --silent
        winget uninstall Clipchamp.Clipchamp_yxz26nhyzhsrt --silent
        winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe --silent
        winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe  --silent
        winget uninstall cortana --silent
        winget uninstall Microsoft.DevHome --silent
        # update existing programs
        winget upgrade --all --accept-source-agreements
    }
}

# check main function
Function Test-CommandExists
{
    Param ($command)
 
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
 
    Try { if (Get-Command $command) { $true } }
    Catch { $false }
    Finally { $ErrorActionPreference = $oldPreference }
}

# run the main function
main
# complete message
echo "!SCRIPT HAS FINISHED, YOU MAY CLOSE THE WINDOW!"
