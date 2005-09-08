Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVIHPAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVIHPAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVIHPAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:00:52 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:45152
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932522AbVIHPAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:00:51 -0400
Message-Id: <43206E87020000780002444B@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:01:59 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] matroxfb adjustments
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part2E0C4077.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part2E0C4077.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Some adjustments to the matroxfb code, for one part preventing the
display to be disabled for longer than necessary, and for the other
part
to make information about the frame buffer position available so that
a kernel debugger might obtain that before the initial mode change.

Finally, some return code corrections to fit the generic fb code.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/drivers/video/matrox/matroxfb_base.c
2.6.13-matroxfb/drivers/video/matrox/matroxfb_base.c
--- 2.6.13/drivers/video/matrox/matroxfb_base.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-matroxfb/drivers/video/matrox/matroxfb_base.c	2005-09-01
11:32:11.000000000 +0200
@@ -1285,7 +1285,7 @@ static int matroxfb_getmemory(WPMINFO un
 	vaddr_t vm;
 	unsigned int offs;
 	unsigned int offs2;
-	unsigned char store;
+	unsigned char store, orig;
 	unsigned char bytes[32];
 	unsigned char* tmp;
 
@@ -1298,7 +1298,8 @@ static int matroxfb_getmemory(WPMINFO un
 	if (maxSize > 0x2000000) maxSize = 0x2000000;
 
 	mga_outb(M_EXTVGA_INDEX, 0x03);
-	mga_outb(M_EXTVGA_DATA, mga_inb(M_EXTVGA_DATA) | 0x80);
+	orig = mga_inb(M_EXTVGA_DATA);
+	mga_outb(M_EXTVGA_DATA, orig | 0x80);
 
 	store = mga_readb(vm, 0x1234);
 	tmp = bytes;
@@ -1323,7 +1324,7 @@ static int matroxfb_getmemory(WPMINFO un
 	mga_writeb(vm, 0x1234, store);
 
 	mga_outb(M_EXTVGA_INDEX, 0x03);
-	mga_outb(M_EXTVGA_DATA, mga_inb(M_EXTVGA_DATA) & ~0x80);
+	mga_outb(M_EXTVGA_DATA, orig);
 
 	*realSize = offs - 0x100000;
 #ifdef CONFIG_FB_MATROX_MILLENIUM
@@ -1858,6 +1859,8 @@ static int initMatrox2(WPMINFO struct bo
 							to yres_virtual
* xres_virtual < 2^32 */
 	}
 	matroxfb_init_fix(PMINFO2);
+	ACCESS_FBINFO(fbcon.screen_base) =
vaddr_va(ACCESS_FBINFO(video.vbase));
+	matroxfb_update_fix(PMINFO2);
 	/* Normalize values (namely yres_virtual) */
 	matroxfb_check_var(&vesafb_defined, &ACCESS_FBINFO(fbcon));
 	/* And put it into "current" var. Do NOT program hardware yet,
or we'll not take over
@@ -2010,11 +2013,11 @@ static int matroxfb_probe(struct pci_dev
 	}
 	/* not match... */
 	if (!b->vendor)
-		return -1;
+		return -ENODEV;
 	if (dev > 0) {
 		/* not requested one... */
 		dev--;
-		return -1;
+		return -ENODEV;
 	}
 	pci_read_config_dword(pdev, PCI_COMMAND, &cmd);
 	if (pci_enable_device(pdev)) {


--=__Part2E0C4077.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-matroxfb.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-matroxfb.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClNvbWUgYWRqdXN0bWVudHMgdG8gdGhlIG1h
dHJveGZiIGNvZGUsIGZvciBvbmUgcGFydCBwcmV2ZW50aW5nIHRoZQpkaXNwbGF5IHRvIGJlIGRp
c2FibGVkIGZvciBsb25nZXIgdGhhbiBuZWNlc3NhcnksIGFuZCBmb3IgdGhlIG90aGVyIHBhcnQK
dG8gbWFrZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgZnJhbWUgYnVmZmVyIHBvc2l0aW9uIGF2YWls
YWJsZSBzbyB0aGF0CmEga2VybmVsIGRlYnVnZ2VyIG1pZ2h0IG9idGFpbiB0aGF0IGJlZm9yZSB0
aGUgaW5pdGlhbCBtb2RlIGNoYW5nZS4KCkZpbmFsbHksIHNvbWUgcmV0dXJuIGNvZGUgY29ycmVj
dGlvbnMgdG8gZml0IHRoZSBnZW5lcmljIGZiIGNvZGUuCgpTaWduZWQtb2ZmLWJ5OiBKYW4gQmV1
bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCmRpZmYgLU5wcnUgMi42LjEzL2RyaXZlcnMvdmlk
ZW8vbWF0cm94L21hdHJveGZiX2Jhc2UuYyAyLjYuMTMtbWF0cm94ZmIvZHJpdmVycy92aWRlby9t
YXRyb3gvbWF0cm94ZmJfYmFzZS5jCi0tLSAyLjYuMTMvZHJpdmVycy92aWRlby9tYXRyb3gvbWF0
cm94ZmJfYmFzZS5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYu
MTMtbWF0cm94ZmIvZHJpdmVycy92aWRlby9tYXRyb3gvbWF0cm94ZmJfYmFzZS5jCTIwMDUtMDkt
MDEgMTE6MzI6MTEuMDAwMDAwMDAwICswMjAwCkBAIC0xMjg1LDcgKzEyODUsNyBAQCBzdGF0aWMg
aW50IG1hdHJveGZiX2dldG1lbW9yeShXUE1JTkZPIHVuCiAJdmFkZHJfdCB2bTsKIAl1bnNpZ25l
ZCBpbnQgb2ZmczsKIAl1bnNpZ25lZCBpbnQgb2ZmczI7Ci0JdW5zaWduZWQgY2hhciBzdG9yZTsK
Kwl1bnNpZ25lZCBjaGFyIHN0b3JlLCBvcmlnOwogCXVuc2lnbmVkIGNoYXIgYnl0ZXNbMzJdOwog
CXVuc2lnbmVkIGNoYXIqIHRtcDsKIApAQCAtMTI5OCw3ICsxMjk4LDggQEAgc3RhdGljIGludCBt
YXRyb3hmYl9nZXRtZW1vcnkoV1BNSU5GTyB1bgogCWlmIChtYXhTaXplID4gMHgyMDAwMDAwKSBt
YXhTaXplID0gMHgyMDAwMDAwOwogCiAJbWdhX291dGIoTV9FWFRWR0FfSU5ERVgsIDB4MDMpOwot
CW1nYV9vdXRiKE1fRVhUVkdBX0RBVEEsIG1nYV9pbmIoTV9FWFRWR0FfREFUQSkgfCAweDgwKTsK
KwlvcmlnID0gbWdhX2luYihNX0VYVFZHQV9EQVRBKTsKKwltZ2Ffb3V0YihNX0VYVFZHQV9EQVRB
LCBvcmlnIHwgMHg4MCk7CiAKIAlzdG9yZSA9IG1nYV9yZWFkYih2bSwgMHgxMjM0KTsKIAl0bXAg
PSBieXRlczsKQEAgLTEzMjMsNyArMTMyNCw3IEBAIHN0YXRpYyBpbnQgbWF0cm94ZmJfZ2V0bWVt
b3J5KFdQTUlORk8gdW4KIAltZ2Ffd3JpdGViKHZtLCAweDEyMzQsIHN0b3JlKTsKIAogCW1nYV9v
dXRiKE1fRVhUVkdBX0lOREVYLCAweDAzKTsKLQltZ2Ffb3V0YihNX0VYVFZHQV9EQVRBLCBtZ2Ff
aW5iKE1fRVhUVkdBX0RBVEEpICYgfjB4ODApOworCW1nYV9vdXRiKE1fRVhUVkdBX0RBVEEsIG9y
aWcpOwogCiAJKnJlYWxTaXplID0gb2ZmcyAtIDB4MTAwMDAwOwogI2lmZGVmIENPTkZJR19GQl9N
QVRST1hfTUlMTEVOSVVNCkBAIC0xODU4LDYgKzE4NTksOCBAQCBzdGF0aWMgaW50IGluaXRNYXRy
b3gyKFdQTUlORk8gc3RydWN0IGJvCiAJCQkJCQkJdG8geXJlc192aXJ0dWFsICogeHJlc192aXJ0
dWFsIDwgMl4zMiAqLwogCX0KIAltYXRyb3hmYl9pbml0X2ZpeChQTUlORk8yKTsKKwlBQ0NFU1Nf
RkJJTkZPKGZiY29uLnNjcmVlbl9iYXNlKSA9IHZhZGRyX3ZhKEFDQ0VTU19GQklORk8odmlkZW8u
dmJhc2UpKTsKKwltYXRyb3hmYl91cGRhdGVfZml4KFBNSU5GTzIpOwogCS8qIE5vcm1hbGl6ZSB2
YWx1ZXMgKG5hbWVseSB5cmVzX3ZpcnR1YWwpICovCiAJbWF0cm94ZmJfY2hlY2tfdmFyKCZ2ZXNh
ZmJfZGVmaW5lZCwgJkFDQ0VTU19GQklORk8oZmJjb24pKTsKIAkvKiBBbmQgcHV0IGl0IGludG8g
ImN1cnJlbnQiIHZhci4gRG8gTk9UIHByb2dyYW0gaGFyZHdhcmUgeWV0LCBvciB3ZSdsbCBub3Qg
dGFrZSBvdmVyCkBAIC0yMDEwLDExICsyMDEzLDExIEBAIHN0YXRpYyBpbnQgbWF0cm94ZmJfcHJv
YmUoc3RydWN0IHBjaV9kZXYKIAl9CiAJLyogbm90IG1hdGNoLi4uICovCiAJaWYgKCFiLT52ZW5k
b3IpCi0JCXJldHVybiAtMTsKKwkJcmV0dXJuIC1FTk9ERVY7CiAJaWYgKGRldiA+IDApIHsKIAkJ
Lyogbm90IHJlcXVlc3RlZCBvbmUuLi4gKi8KIAkJZGV2LS07Ci0JCXJldHVybiAtMTsKKwkJcmV0
dXJuIC1FTk9ERVY7CiAJfQogCXBjaV9yZWFkX2NvbmZpZ19kd29yZChwZGV2LCBQQ0lfQ09NTUFO
RCwgJmNtZCk7CiAJaWYgKHBjaV9lbmFibGVfZGV2aWNlKHBkZXYpKSB7Cg==

--=__Part2E0C4077.0__=--
