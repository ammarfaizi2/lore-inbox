Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWBMB2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWBMB2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWBMB2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:28:16 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:29935 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751122AbWBMB2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:28:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type;
        b=DjWhpCzIEpHb7Tt3JEaaSo/Vy6SktGTrGQIIdi8YpY9pl9TOga03Hz9Yf3kqpyDl01RoYJV8lHw94XG69zbQXKzjQC79he9Q+R7/MprJUUFwqWh9gjqMnOJZQf7SlTchUmvblcAJYwCMIUEZ1oE8GgVqpWkK20GVDGhuxBgs8nE=
Date: Mon, 13 Feb 2006 02:27:57 +0100
From: Diego Calleja <diegocg@gmail.com>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: AGP serverworks chipset not being initializated properly?
Message-Id: <20060213022757.bfc2af7f.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__13_Feb_2006_02_27_57_+0100_GDmjULPMJW22O.Z2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__13_Feb_2006_02_27_57_+0100_GDmjULPMJW22O.Z2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

For a while, I've been having this on my dmesg:

agpgart: Xorg tried to set rate=x12. Setting to AGP3 x8 mode.
agpgart: Putting AGP V2 device at 0000:00:00.1 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
[drm] Loading R200 Microcode

This is really weird since my motherboard (CNB20HE chipset)
only supports 2x AGP cards and my xorg.conf file has this: 

Section "Device"
        Identifier      "RADEON9200SE"
        Driver          "radeon"
        Option     "AGPMode" "2"
EndSection


Looking at the code I found out that the code path being run  to get
this printk is:
------------------------------------------------------------------
    /* Check to see if we are operating in 3.0 mode */
    if (agp_bridge->mode & AGPSTAT_MODE_3_0)     
	agp_v3_parse_one(&requested_mode, &bridge_agpstat, &vga_agpstat); <----------
    else
	agp_v2_parse_one(&requested_mode, &bridge_agpstat, &vga_agpstat);
------------------------------------------------------------------


so it looks like agp_brige->mode is not being initializated properly, it is
sworks-agp.c:serverworks_configure() who initializates it in my box so
something has to be wrong with one of these 2 lines?:
------------------------------------------------------------------
        agp_bridge->capndx = pci_find_capability(serverworks_private.svrwrks_dev, PCI_CAP_ID_AGP);

        /* Fill in the mode register */
        pci_read_config_dword(serverworks_private.svrwrks_dev,
                              agp_bridge->capndx+PCI_AGP_STATUS, &agp_bridge->mode);
------------------------------------------------------------------


What is going on, is this a know bug, should I just ignore it (it doesn't
harms anything), file a bugzilla bug? My dmesg says:
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: AGP aperture is 128M @ 0xd0000000
agpgart: Detected ServerWorks CNB20HE chipset: No AGP present.
agpgart: Detected ServerWorks CNB20HE chipset: No AGP present.

Full lspci output is included. 




--Multipart=_Mon__13_Feb_2006_02_27_57_+0100_GDmjULPMJW22O.Z2
Content-Type: application/octet-stream;
 name="lspci"
Content-Disposition: attachment;
 filename="lspci"
Content-Transfer-Encoding: base64

MDAwMDowMDowMC4wIEhvc3QgYnJpZGdlOiBCcm9hZGNvbSBDTkIyMC1MRSBIb3N0IEJyaWRnZSAo
cmV2IDIzKQoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5W
LSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2Fw
LSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0KCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZDAwMDAwMDAg
KDMyLWJpdCwgcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTEyOE1dCglSZWdpb24gMTog
TWVtb3J5IGF0IGNmZmZmMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0g
W3NpemU9NEtdCgowMDAwOjAwOjAwLjEgUENJIGJyaWRnZTogQnJvYWRjb20gQ05CMjAtTEUgSG9z
dCBCcmlkZ2UgKHJldiAwMSkgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNvZGVdKQoJQ29udHJvbDog
SS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJy
LSBTdGVwcGluZy0gU0VSUisgRmFzdEIyQi0KCVN0YXR1czogQ2FwKyA2Nk1IeisgVURGLSBGYXN0
QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydCsgPlNF
UlItIDxQRVJSLQoJTGF0ZW5jeTogNjQsIENhY2hlIExpbmUgU2l6ZTogMHgwOCAoMzIgYnl0ZXMp
CglCdXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0wMSwgc3Vib3JkaW5hdGU9MDEsIHNlYy1sYXRl
bmN5PTY0CglJL08gYmVoaW5kIGJyaWRnZTogMDAwMGMwMDAtMDAwMGNmZmYKCU1lbW9yeSBiZWhp
bmQgYnJpZGdlOiBmZTcwMDAwMC1mZTdmZmZmZgoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQg
YnJpZGdlOiBkZTQwMDAwMC1mZTRmZmZmZgoJQnJpZGdlQ3RsOiBQYXJpdHkrIFNFUlIrIE5vSVNB
LSBWR0ErIE1BYm9ydC0gPlJlc2V0LSBGYXN0QjJCLQoJQ2FwYWJpbGl0aWVzOiA8YXZhaWxhYmxl
IG9ubHkgdG8gcm9vdD4KCjAwMDA6MDA6MDAuMiBIb3N0IGJyaWRnZTogQnJvYWRjb20gQ05CMjBI
RSBIb3N0IEJyaWRnZSAocmV2IDAxKQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rlci0gU3Bl
Y0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIy
Qi0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRp
dW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydCsgPlNFUlItIDxQRVJSLQoKMDAwMDowMDowMC4z
IEhvc3QgYnJpZGdlOiBCcm9hZGNvbSBDTkIyMEhFIEhvc3QgQnJpZGdlIChyZXYgMDEpCglDb250
cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQ
YXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYt
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0
KyA+U0VSUi0gPFBFUlItCgowMDAwOjAwOjA2LjAgRXRoZXJuZXQgY29udHJvbGxlcjogSW50ZWwg
Q29ycG9yYXRpb24gODI1NTcvOC85IFtFdGhlcm5ldCBQcm8gMTAwXSAocmV2IDA4KQoJU3Vic3lz
dGVtOiBJbnRlbCBDb3Jwb3JhdGlvbiBFdGhlckV4cHJlc3MgUFJPLzEwMCsgU2VydmVyIEFkYXB0
ZXIgKFBJTEE4NDcwQikKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0g
TWVtV0lOVisgVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIrIEZhc3RCMkItCglTdGF0
dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJv
cnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0KCUxhdGVuY3k6IDY0ICgyMDAwbnMg
bWluLCAxNDAwMG5zIG1heCksIENhY2hlIExpbmUgU2l6ZTogMHgwOCAoMzIgYnl0ZXMpCglJbnRl
cnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTcKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZmVhZmUw
MDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtdCglSZWdpb24gMTogSS9PIHBv
cnRzIGF0IGQ4MDAgW3NpemU9NjRdCglSZWdpb24gMjogTWVtb3J5IGF0IGZlOTAwMDAwICgzMi1i
aXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTFNXQoJQ2FwYWJpbGl0aWVzOiA8YXZhaWxhYmxl
IG9ubHkgdG8gcm9vdD4KCjAwMDA6MDA6MGYuMCBJU0EgYnJpZGdlOiBCcm9hZGNvbSBPU0I0IFNv
dXRoIEJyaWRnZSAocmV2IDUwKQoJU3Vic3lzdGVtOiBCcm9hZGNvbSBPU0I0IFNvdXRoIEJyaWRn
ZQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FT
bm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2FwLSA2Nk1I
ei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5jeTogMAoKMDAwMDowMDowZi4xIElERSBpbnRl
cmZhY2U6IEJyb2FkY29tIE9TQjQgSURFIENvbnRyb2xsZXIgKHByb2ctaWYgOGEgW01hc3RlciBT
ZWNQIFByaVBdKQoJQ29udHJvbDogSS9PKyBNZW0tIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1X
SU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czog
Q2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0g
PFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5jeTogNjQKCVJlZ2lvbiA0OiBJ
L08gcG9ydHMgYXQgZmZhMCBbc2l6ZT0xNl0KCjAwMDA6MDA6MGYuMiBVU0IgQ29udHJvbGxlcjog
QnJvYWRjb20gT1NCNC9DU0I1IE9IQ0kgVVNCIENvbnRyb2xsZXIgKHJldiAwNCkgKHByb2ctaWYg
MTAgW09IQ0ldKQoJU3Vic3lzdGVtOiBCcm9hZGNvbSBPU0I0L0NTQjUgT0hDSSBVU0IgQ29udHJv
bGxlcgoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WKyBW
R0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUisgRmFzdEIyQi0KCVN0YXR1czogQ2FwLSA2
Nk1Iei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9y
dC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5jeTogNjQgKDIwMDAwbnMgbWF4KSwgQ2Fj
aGUgTGluZSBTaXplOiAweDA4ICgzMiBieXRlcykKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRv
IElSUSAxMAoJUmVnaW9uIDA6IE1lbW9yeSBhdCBmZWFmZjAwMCAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT00S10KCjAwMDA6MDE6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVy
OiBBVEkgVGVjaG5vbG9naWVzIEluYyBSVjI4MCBbUmFkZW9uIDkyMDAgU0VdIChyZXYgMDEpIChw
cm9nLWlmIDAwIFtWR0FdKQoJU3Vic3lzdGVtOiBIaWdodGVjaCBJbmZvcm1hdGlvbiBTeXN0ZW0g
THRkLjogVW5rbm93biBkZXZpY2UgMjAwMgoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3Rlcisg
U3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUisgRmFz
dEIyQi0KCVN0YXR1czogQ2FwKyA2Nk1IeisgVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1t
ZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5jeTog
NjQgKDIwMDBucyBtaW4pLCBDYWNoZSBMaW5lIFNpemU6IDB4MDggKDMyIGJ5dGVzKQoJSW50ZXJy
dXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE4CglSZWdpb24gMDogTWVtb3J5IGF0IGUwMDAwMDAw
ICgzMi1iaXQsIHByZWZldGNoYWJsZSkgW3NpemU9MjU2TV0KCVJlZ2lvbiAxOiBJL08gcG9ydHMg
YXQgYzgwMCBbc2l6ZT0yNTZdCglSZWdpb24gMjogTWVtb3J5IGF0IGZlN2YwMDAwICgzMi1iaXQs
IG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTY0S10KCUV4cGFuc2lvbiBST00gYXQgZmU3YzAwMDAg
W2Rpc2FibGVkXSBbc2l6ZT0xMjhLXQoJQ2FwYWJpbGl0aWVzOiA8YXZhaWxhYmxlIG9ubHkgdG8g
cm9vdD4KCjAwMDA6MDI6MDIuMCBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXI6IENyZWF0aXZl
IExhYnMgU0IgQXVkaWd5IExTCglTdWJzeXN0ZW06IENyZWF0aXZlIExhYnMgU0IwNDEwIFNCTGl2
ZSEgMjQtYml0CglDb250cm9sOiBJL08rIE1lbS0gQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSKyBGYXN0QjJCLQoJU3RhdHVzOiBD
YXArIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8
VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItCglMYXRlbmN5OiA2NCAoNTAwbnMgbWluLCA1
MDAwbnMgbWF4KQoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE2CglSZWdpb24gMDog
SS9PIHBvcnRzIGF0IGVmODAgW3NpemU9MzJdCglDYXBhYmlsaXRpZXM6IDxhdmFpbGFibGUgb25s
eSB0byByb290PgoK

--Multipart=_Mon__13_Feb_2006_02_27_57_+0100_GDmjULPMJW22O.Z2--
