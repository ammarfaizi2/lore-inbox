Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWFGKUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWFGKUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 06:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWFGKUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 06:20:55 -0400
Received: from mog.warmcat.com ([62.193.232.24]:24034 "EHLO
	mailserver.mog.warmcat.com") by vger.kernel.org with ESMTP
	id S932218AbWFGKUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 06:20:54 -0400
Message-ID: <4486A7FC.2090904@warmcat.com>
Date: Wed, 07 Jun 2006 11:18:36 +0100
From: Andy Green <andy@warmcat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060501 Fedora/1.5.0.2-1.1.fc5 Thunderbird/1.5.0.2 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: Black box flight recorder for Linux
References: <44379AB8.6050808@superbug.co.uk>	<m3psjqeeor.fsf@defiant.localdomain>	<443A4927.5040801@warmcat.com>	<m3zmgqxjs8.fsf@defiant.localdomain> <20060607100349.a990e054.khali@linux-fr.org>
In-Reply-To: <20060607100349.a990e054.khali@linux-fr.org>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms030101030606030600010100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030101030606030600010100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:

Hi Folks -

Impressed with Krzysztof doing the work!

>> The first part is the "console" driver (obvious parts removed). It works
>> with both my Asus A7V333 (VIA KT333, VIA SMBUS driver) and with VGA DDC
>> interface on a Cirrus Logic GD 5446 VGA chip (simplified source attached
>> as well). Using respectively 2464 and 24512 set to ID 0x57.
> 
> How do you intend to connect your device to the DDC channel if there's
> already a monitor connected to the VGA or DVI port?

For both VGA and DVI I think the optimal answer is to build a small 
back-back breakout adapter.  The parts seem to be quite reasonably 
priced and reasonably available, eg from Farnell (www.farnell.co.uk):

VGA: Plug partcode 1071807 GBP 1.76   Socket partcode 1071811 GBP 2.10

DVI: Plug partcode 9965190 GBP 1.38   Socket partcode 1012227 GBP 2.01


If the original cabling looks like this:

   <Video card Socket>
     |
   <Original Cable Plug>
     |
     |
     |
   <Original Cable Plug>
     |
   <Monitor Socket>


then the breakout concept looks like this:

   <Video card Socket>
     |
   <Adapter Plug>
     |--------------------- I2C signal wires broken out
     |                      All wires passed to corresponding pins
   <Adapter Socket>
     |
   <Original Cable Plug>
     |
     |
     |
   <Original Cable Plug>
     |
   <Monitor Socket>

> Beware that many monitors have EDID EEPROMs responding to all I2C
> addresses within the 0x50 - 0x57 range, so it'll be hard to add an
> EEPROM on the bus for your own purpose without hitting an address
> conflict.

The adapter does give an opportunity to interrupt the connectivity of 
the I2C to the monitor if worst comes to worst, I guess no traffic is 
typically present after X init or Linux touching it.  Pretty ugly that 
things ignore b2-b0 of the I2C address.

A whole other way forward is to consider to replace the EEPROM from the 
original proposal (which does provide its own advantages such as 
simplicity, I accept) with something else that ends up on another PC. 
In this concept some logic presents a fake I2C peripheral to the DDC 
interface at an I2C address of our choosing.  This logic acts as a 
bidirectional "UART" type of thing, allowing transfer of data in both 
directions between the Linux box being debugged and another PC.

I designed something conceptually similar for the effort to hack the 
original Xbox, which was very effective (and is GPL'd):

http://warmcat.com/milksop/filtror.html

However this would be much simpler, not even needing RAM.  It can hook 
to the second PC by the same I2C method, parallel printer port, RS232 or 
USB depending on the level of complexity of the design.

I guess the link will feel quite like a 9600 or 19200 baud serial port 
in terms of throughput.

>> The following is an adapter for Cirrus Logic 5446 VGA on my old R440LX
>> test machine:
>>
>> There is a locking problem - the VGA is (can be) shared between VT console,
>> X11 and the driver. I'll look at CL FB driver to see how/if it's done.
> 
> The current trend is to merge the DDC access driver into the
> framebuffer driver. This solves one of the conflicts, and also makes
> sense because the EDID data can be used to automatically setup the
> framebuffer. We still have a few standalone DDC access drivers
> (i2c-i810, i2c-savage4...) but they are considered deprecated and will
> probably be deleted in a near feature.
>
> This will be a second problem for you though. Most distributions don't
> make use of hardware-specific framebuffer drivers by default, but use
> the VESA framebuffer driver. This driver doesn't have DDC support.

Maybe this effort is considered too esoteric, but it seems to me to be a 
reason to keep the DDC access drivers standalone, the hardware-specific 
framebuffer drivers can call through to them and we can use them in a 
clean way.  I realize this is a bit of a late objection and that there 
was not previously much point to keeping them as separate things in the 
world.

> Note that I am not trying to dicourage you, Andy's idea has merit for
> sure. I just mean that it won't be usable by everyone out of the box.
> People will have to use the right driver and pay attention to address
> conflicts.

Address conflicts we can solve by widening the scope and powers of the 
interface into a generic communications link by adding a little 
hardware, removing the address clash.  If basically magic-ing a 
cheap-to-drive comms link out of nowhere, on most all PC-type hardware, 
has value then maybe it can sway people to keep the separated DDC drivers.

-Andy

--------------ms030101030606030600010100
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMpDCC
A2IwggLLoAMCAQICEAvaCxfBP4mOqwl0erTOLjMwDQYJKoZIhvcNAQECBQAwXzELMAkGA1UE
BhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMTcwNQYDVQQLEy5DbGFzcyAxIFB1Ymxp
YyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTk4MDUxMjAwMDAwMFoXDTA4
MDUxMjIzNTk1OVowgcwxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJp
U2lnbiBUcnVzdCBOZXR3b3JrMUYwRAYDVQQLEz13d3cudmVyaXNpZ24uY29tL3JlcG9zaXRv
cnkvUlBBIEluY29ycC4gQnkgUmVmLixMSUFCLkxURChjKTk4MUgwRgYDVQQDEz9WZXJpU2ln
biBDbGFzcyAxIENBIEluZGl2aWR1YWwgU3Vic2NyaWJlci1QZXJzb25hIE5vdCBWYWxpZGF0
ZWQwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALtaRIoEFrtV/QN6ii2UTxV4NrgNSrJv
nFS/vOh3Kp258Gi7ldkxQXB6gUu5SBNWLccI4YRCq8CikqtEXKpC8IIOAukv+8I7u77JJwpd
trA2QjO1blSIT4dKvxna+RXoD4e2HOPMxpqOf2okkuP84GW6p7F+78nbN2rISsgJBuSZAgMB
AAGjgbAwga0wDwYDVR0TBAgwBgEB/wIBADBHBgNVHSAEQDA+MDwGC2CGSAGG+EUBBwEBMC0w
KwYIKwYBBQUHAgEWH3d3dy52ZXJpc2lnbi5jb20vcmVwb3NpdG9yeS9SUEEwMQYDVR0fBCow
KDAmoCSgIoYgaHR0cDovL2NybC52ZXJpc2lnbi5jb20vcGNhMS5jcmwwCwYDVR0PBAQDAgEG
MBEGCWCGSAGG+EIBAQQEAwIBBjANBgkqhkiG9w0BAQIFAAOBgQACfZ5vRUs4oLje6VNkIbzk
TCuPHv6SQKzYCjlqoTIhLAebq1n+0mIafVU4sDdz3PQHZmNiveFTcFKH56jYUulbLarh3s+s
MVTUixnI2COo7wQrMn0sGBzIfImoLnfyRNFlCk10te7TG5JzdC6JOzUTcudAMZrTssSr51a+
i+P7FTCCBJswggQEoAMCAQICEAll5IguNdKurnal3pXm16MwDQYJKoZIhvcNAQEFBQAwgcwx
FzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3
b3JrMUYwRAYDVQQLEz13d3cudmVyaXNpZ24uY29tL3JlcG9zaXRvcnkvUlBBIEluY29ycC4g
QnkgUmVmLixMSUFCLkxURChjKTk4MUgwRgYDVQQDEz9WZXJpU2lnbiBDbGFzcyAxIENBIElu
ZGl2aWR1YWwgU3Vic2NyaWJlci1QZXJzb25hIE5vdCBWYWxpZGF0ZWQwHhcNMDUwOTE1MDAw
MDAwWhcNMDYwOTE1MjM1OTU5WjCCAQ0xFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYD
VQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMUYwRAYDVQQLEz13d3cudmVyaXNpZ24uY29t
L3JlcG9zaXRvcnkvUlBBIEluY29ycC4gYnkgUmVmLixMSUFCLkxURChjKTk4MR4wHAYDVQQL
ExVQZXJzb25hIE5vdCBWYWxpZGF0ZWQxMzAxBgNVBAsTKkRpZ2l0YWwgSUQgQ2xhc3MgMSAt
IE5ldHNjYXBlIEZ1bGwgU2VydmljZTETMBEGA1UEAxQKQW5keSBHcmVlbjEfMB0GCSqGSIb3
DQEJARYQYW5keUB3YXJtY2F0LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANVXhXb2ER/6xqRdPiTDMKAhHrAGM1d98Da4sQXNVXozfDiMoEgFAH/TqemjfT3+8pLqoQIL
3U/3sLe3OObeKdnr3fqqVsWsKYr8xG+gfF9I8iqoDcClyHynYKYvlJHZLE8dRSq4yzzEOl+3
XaDNaoCqH3Ib5BdJoewdHRmr/gEd3XHMcHzbpRs4a25ypX3iIOi4SLEUZzisenqZpneTnImS
OjbopmPMQ3YAyF7bOqT3KBSFbDWwa4gb/qBw8xH/dn1RdH51FoJptwcu2NNZDnLcXU7ypmzT
zhCDYk+b5+OYRG+vlLN/pcpXi0MZjHLluF2QOnKDmwjBHfCr/S/16KsCAwEAAaOBtTCBsjAJ
BgNVHRMEAjAAMEQGA1UdIAQ9MDswOQYLYIZIAYb4RQEHFwMwKjAoBggrBgEFBQcCARYcaHR0
cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYTALBgNVHQ8EBAMCBaAwHQYDVR0lBBYwFAYIKwYB
BQUHAwQGCCsGAQUFBwMCMDMGA1UdHwQsMCowKKAmoCSGImh0dHA6Ly9jcmwudmVyaXNpZ24u
Y29tL2NsYXNzMS5jcmwwDQYJKoZIhvcNAQEFBQADgYEAbF6fDKkfo8tb37H9zFd0p4xSAeyi
ujHP0fmAlBpic8zEIIysMGhPvX2vZZrV46rI6yYq0KYSRdG98UKjXDimYxe48lwL/QRJ54m9
iIdsp7+kw5yo9fmj7micjVQ0tHHZYFIzC5ogaDmWVEBuJYNznLF52d2wtwlmJ29nOjkZx5Mw
ggSbMIIEBKADAgECAhAJZeSILjXSrq52pd6V5tejMA0GCSqGSIb3DQEBBQUAMIHMMRcwFQYD
VQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazFG
MEQGA1UECxM9d3d3LnZlcmlzaWduLmNvbS9yZXBvc2l0b3J5L1JQQSBJbmNvcnAuIEJ5IFJl
Zi4sTElBQi5MVEQoYyk5ODFIMEYGA1UEAxM/VmVyaVNpZ24gQ2xhc3MgMSBDQSBJbmRpdmlk
dWFsIFN1YnNjcmliZXItUGVyc29uYSBOb3QgVmFsaWRhdGVkMB4XDTA1MDkxNTAwMDAwMFoX
DTA2MDkxNTIzNTk1OVowggENMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMW
VmVyaVNpZ24gVHJ1c3QgTmV0d29yazFGMEQGA1UECxM9d3d3LnZlcmlzaWduLmNvbS9yZXBv
c2l0b3J5L1JQQSBJbmNvcnAuIGJ5IFJlZi4sTElBQi5MVEQoYyk5ODEeMBwGA1UECxMVUGVy
c29uYSBOb3QgVmFsaWRhdGVkMTMwMQYDVQQLEypEaWdpdGFsIElEIENsYXNzIDEgLSBOZXRz
Y2FwZSBGdWxsIFNlcnZpY2UxEzARBgNVBAMUCkFuZHkgR3JlZW4xHzAdBgkqhkiG9w0BCQEW
EGFuZHlAd2FybWNhdC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDVV4V2
9hEf+sakXT4kwzCgIR6wBjNXffA2uLEFzVV6M3w4jKBIBQB/06npo309/vKS6qECC91P97C3
tzjm3inZ6936qlbFrCmK/MRvoHxfSPIqqA3Apch8p2CmL5SR2SxPHUUquMs8xDpft12gzWqA
qh9yG+QXSaHsHR0Zq/4BHd1xzHB826UbOGtucqV94iDouEixFGc4rHp6maZ3k5yJkjo26KZj
zEN2AMhe2zqk9ygUhWw1sGuIG/6gcPMR/3Z9UXR+dRaCabcHLtjTWQ5y3F1O8qZs084Qg2JP
m+fjmERvr5Szf6XKV4tDGYxy5bhdkDpyg5sIwR3wq/0v9eirAgMBAAGjgbUwgbIwCQYDVR0T
BAIwADBEBgNVHSAEPTA7MDkGC2CGSAGG+EUBBxcDMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8v
d3d3LnZlcmlzaWduLmNvbS9ycGEwCwYDVR0PBAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwME
BggrBgEFBQcDAjAzBgNVHR8ELDAqMCigJqAkhiJodHRwOi8vY3JsLnZlcmlzaWduLmNvbS9j
bGFzczEuY3JsMA0GCSqGSIb3DQEBBQUAA4GBAGxenwypH6PLW9+x/cxXdKeMUgHsoroxz9H5
gJQaYnPMxCCMrDBoT719r2Wa1eOqyOsmKtCmEkXRvfFCo1w4pmMXuPJcC/0ESeeJvYiHbKe/
pMOcqPX5o+5onI1UNLRx2WBSMwuaIGg5llRAbiWDc5yxedndsLcJZidvZzo5GceTMYIEqjCC
BKYCAQEwgeEwgcwxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJpU2ln
biBUcnVzdCBOZXR3b3JrMUYwRAYDVQQLEz13d3cudmVyaXNpZ24uY29tL3JlcG9zaXRvcnkv
UlBBIEluY29ycC4gQnkgUmVmLixMSUFCLkxURChjKTk4MUgwRgYDVQQDEz9WZXJpU2lnbiBD
bGFzcyAxIENBIEluZGl2aWR1YWwgU3Vic2NyaWJlci1QZXJzb25hIE5vdCBWYWxpZGF0ZWQC
EAll5IguNdKurnal3pXm16MwCQYFKw4DAhoFAKCCAp0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMDYwNjA3MTAxODM2WjAjBgkqhkiG9w0BCQQxFgQUfpb/
RuRqKmXF4pNL8pKsnKNBaVkwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG
9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgfIGCSsG
AQQBgjcQBDGB5DCB4TCBzDEXMBUGA1UEChMOVmVyaVNpZ24sIEluYy4xHzAdBgNVBAsTFlZl
cmlTaWduIFRydXN0IE5ldHdvcmsxRjBEBgNVBAsTPXd3dy52ZXJpc2lnbi5jb20vcmVwb3Np
dG9yeS9SUEEgSW5jb3JwLiBCeSBSZWYuLExJQUIuTFREKGMpOTgxSDBGBgNVBAMTP1ZlcmlT
aWduIENsYXNzIDEgQ0EgSW5kaXZpZHVhbCBTdWJzY3JpYmVyLVBlcnNvbmEgTm90IFZhbGlk
YXRlZAIQCWXkiC410q6udqXelebXozCB9AYLKoZIhvcNAQkQAgsxgeSggeEwgcwxFzAVBgNV
BAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMUYw
RAYDVQQLEz13d3cudmVyaXNpZ24uY29tL3JlcG9zaXRvcnkvUlBBIEluY29ycC4gQnkgUmVm
LixMSUFCLkxURChjKTk4MUgwRgYDVQQDEz9WZXJpU2lnbiBDbGFzcyAxIENBIEluZGl2aWR1
YWwgU3Vic2NyaWJlci1QZXJzb25hIE5vdCBWYWxpZGF0ZWQCEAll5IguNdKurnal3pXm16Mw
DQYJKoZIhvcNAQEBBQAEggEAsEp21NH4bQ3dqbUWlK1MWWjyT+F7d7dIVEiSD285n5PuuAsr
ldRoAVnlO14MYPJlHpsYqouPCs3lub16jw44CBsWskZVQvh9oONO+zxkfg0IxTierBKc5PTr
W3a8Z3tQ+YWIVLZGyPWLpT68LnGqrcM7Ek4W5MPP5J0LmiyrUg5Zrt6i9YBARjIZw8rmcAhH
z+In/8CMtLf/2V4JeUbtefYne1NmVBX9+EUxD6XLjDush/NZc38gGLZOX8oR4LXpppUQ+8NZ
sOyU0m846H3oS3hy6/+iqEycjFwDBJZZEBfTAhcoBxcTu5XtPf39iRBSyO+LrTkQII8OvQBo
aPAAeQAAAAAAAA==
--------------ms030101030606030600010100--
