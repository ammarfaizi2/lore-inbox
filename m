Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266152AbUF3Gdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbUF3Gdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUF3Gdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:33:45 -0400
Received: from webmail-benelux.tiscali.be ([62.235.14.106]:41328 "EHLO
	mail.tiscali.be") by vger.kernel.org with ESMTP id S266152AbUF3Gd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:33:29 -0400
Date: Wed, 30 Jun 2004 08:33:27 +0200
Message-ID: <40BDA020000127E5@ocpmta3.freegates.net>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: FW: Some cleanup patches for: '...lvalues is deprecated'
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========/40BDA020000127E5/mail.tiscali.be"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--========/40BDA020000127E5/mail.tiscali.be
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable



-------------------------------------------------------------------------=
--
NEW: Tiscali ADSL LIGHT, 28,95 EUR/mois, c'est le moment de faire le pas!=

http://reg.tiscali.be/default.asp?lg=3Dfr





--========/40BDA020000127E5/mail.tiscali.be
Content-Type: message/rfc822
Content-Disposition: inline

Received: from [57.67.177.33] by mail.tiscali.be with HTTP; Wed, 30 Jun 2004 08:30:30 +0200
Date: Wed, 30 Jun 2004 08:30:30 +0200
Message-ID: <40BDA020000127DB@ocpmta3.freegates.net>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: Some cleanup patches for: '...lvalues is deprecated'
To: marcelo@logos.cnet
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========/40BDA020000127DB/mail.tiscali.be"


--========/40BDA020000127DB/mail.tiscali.be
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

Here are some backport to clean up some warning of type: use of cast expe=
rssion
as lvalues is deprecated.
--- linux-2.4.27-rc2-pa4mm/kernel/sysctl.c.Orig	2004-06-29 09:03:42.00000=
0000
+0200
+++ linux-2.4.27-rc2-pa4mm/kernel/sysctl.c	2004-06-29 10:10:31.588030256
+0200
@@ -890,7 +890,7 @@
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				buffer +=3D sizeof(char);
 			}
 			if (!left)
 				break;
@@ -1043,7 +1043,7 @@
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				buffer +=3D sizeof(char);
 			}
 			if (!left)
 				break;
@@ -1144,7 +1144,7 @@
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				buffer +=3D sizeof(char);
 			}
 			if (!left)
 				break;
=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.27-rc2-pa4mm/fs/readdir.c.Orig	2004-06-29 11:18:46.63648826=
4
+0200
+++ linux-2.4.27-rc2-pa4mm/fs/readdir.c	2004-06-29 11:25:40.281604648 +02=
00
@@ -264,7 +264,7 @@
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) +=3D reclen;
+	dirent =3D (void *)dirent + reclen;
 	buf->current_dir =3D dirent;
 	buf->count -=3D reclen;
 	return 0;
@@ -347,7 +347,7 @@
 	copy_to_user(dirent, &d, NAME_OFFSET(&d));
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) +=3D reclen;
+	dirent =3D (void *)dirent + reclen;
 	buf->current_dir =3D dirent;
 	buf->count -=3D reclen;
 	return 0;
=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c.Orig	2004-06-29 10:47:31=
.901491304
+0200
+++ linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c	2004-06-29 11:13:31.8463=
43640
+0200
@@ -1877,7 +1877,10 @@
        font length must be multiple of 256, at least. And 256 is multipl=
e
        of 4 */
     k =3D 0;
-    while (p > new_data) k +=3D *--(u32 *)p;
+    while (p > new_data) {
+        p =3D (u8 *)((u32 *)p - 1);
+        k +=3D *(u32 *)p;
+    }
     FNTSUM(new_data) =3D k;
     /* Check if the same font is on some other console already */
     for (i =3D 0; i < MAX_NR_CONSOLES; i++) {
=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.27-rc2-pa4mm/lib/crc32.c.Orig	2004-06-29 11:29:31.721420448=

+0200
+++ linux-2.4.27-rc2-pa4mm/lib/crc32.c	2004-06-29 11:36:19.964358088 +020=
0
@@ -99,7 +99,9 @@
 	/* Align it */
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p =3D (u8 *)b;
+			DO_CRC(*p++);
+			b =3D (void *)p;
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >=3D 4)){
@@ -120,7 +122,9 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p =3D (u8 *)b;
+			DO_CRC(*p++);
+			b =3D (void *)p;
 		} while (--len);
 	}
 
@@ -200,7 +204,9 @@
 	/* Align it */
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p =3D (u8 *)b;
+			DO_CRC(*p++);
+			b =3D (void *)p;
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >=3D 4)){
@@ -221,7 +227,9 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p =3D (u8 *)b;
+			DO_CRC(*p++);
+			b =3D (void *)p;
 		} while (--len);
 	}
 	return __be32_to_cpu(crc);
=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D

hth,
    Joel

PS: because of bad wrapping pb with mail interface I also join original
files

-------------------------------------------------------------------------=
--
NEW: Tiscali ADSL LIGHT, 28,95 EUR/mois, c'est le moment de faire le pas!=

http://reg.tiscali.be/default.asp?lg=3Dfr





--========/40BDA020000127DB/mail.tiscali.be
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="k-2.4.27-rc2_sysctl.c.diff"

LS0tIGxpbnV4LTIuNC4yNy1yYzItcGE0bW0va2VybmVsL3N5c2N0bC5jLk9yaWcJMjAwNC0wNi0y
OSAwOTowMzo0Mi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNC4yNy1yYzItcGE0bW0va2Vy
bmVsL3N5c2N0bC5jCTIwMDQtMDYtMjkgMTA6MTA6MzEuNTg4MDMwMjU2ICswMjAwCkBAIC04OTAs
NyArODkwLDcgQEAKIAkJCQlpZiAoIWlzc3BhY2UoYykpCiAJCQkJCWJyZWFrOwogCQkJCWxlZnQt
LTsKLQkJCQkoKGNoYXIgKikgYnVmZmVyKSsrOworCQkJCWJ1ZmZlciArPSBzaXplb2YoY2hhcik7
CiAJCQl9CiAJCQlpZiAoIWxlZnQpCiAJCQkJYnJlYWs7CkBAIC0xMDQzLDcgKzEwNDMsNyBAQAog
CQkJCWlmICghaXNzcGFjZShjKSkKIAkJCQkJYnJlYWs7CiAJCQkJbGVmdC0tOwotCQkJCSgoY2hh
ciAqKSBidWZmZXIpKys7CisJCQkJYnVmZmVyICs9IHNpemVvZihjaGFyKTsKIAkJCX0KIAkJCWlm
ICghbGVmdCkKIAkJCQlicmVhazsKQEAgLTExNDQsNyArMTE0NCw3IEBACiAJCQkJaWYgKCFpc3Nw
YWNlKGMpKQogCQkJCQlicmVhazsKIAkJCQlsZWZ0LS07Ci0JCQkJKChjaGFyICopIGJ1ZmZlcikr
KzsKKwkJCQlidWZmZXIgKz0gc2l6ZW9mKGNoYXIpOwogCQkJfQogCQkJaWYgKCFsZWZ0KQogCQkJ
CWJyZWFrOwo=


--========/40BDA020000127DB/mail.tiscali.be
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="k-2.4.27-rc2_readdir.c.diff"

LS0tIGxpbnV4LTIuNC4yNy1yYzItcGE0bW0vZnMvcmVhZGRpci5jLk9yaWcJMjAwNC0wNi0yOSAx
MToxODo0Ni42MzY0ODgyNjQgKzAyMDAKKysrIGxpbnV4LTIuNC4yNy1yYzItcGE0bW0vZnMvcmVh
ZGRpci5jCTIwMDQtMDYtMjkgMTE6MjU6NDAuMjgxNjA0NjQ4ICswMjAwCkBAIC0yNjQsNyArMjY0
LDcgQEAKIAlwdXRfdXNlcihyZWNsZW4sICZkaXJlbnQtPmRfcmVjbGVuKTsKIAljb3B5X3RvX3Vz
ZXIoZGlyZW50LT5kX25hbWUsIG5hbWUsIG5hbWxlbik7CiAJcHV0X3VzZXIoMCwgZGlyZW50LT5k
X25hbWUgKyBuYW1sZW4pOwotCSgoY2hhciAqKSBkaXJlbnQpICs9IHJlY2xlbjsKKwlkaXJlbnQg
PSAodm9pZCAqKWRpcmVudCArIHJlY2xlbjsKIAlidWYtPmN1cnJlbnRfZGlyID0gZGlyZW50Owog
CWJ1Zi0+Y291bnQgLT0gcmVjbGVuOwogCXJldHVybiAwOwpAQCAtMzQ3LDcgKzM0Nyw3IEBACiAJ
Y29weV90b191c2VyKGRpcmVudCwgJmQsIE5BTUVfT0ZGU0VUKCZkKSk7CiAJY29weV90b191c2Vy
KGRpcmVudC0+ZF9uYW1lLCBuYW1lLCBuYW1sZW4pOwogCXB1dF91c2VyKDAsIGRpcmVudC0+ZF9u
YW1lICsgbmFtbGVuKTsKLQkoKGNoYXIgKikgZGlyZW50KSArPSByZWNsZW47CisJZGlyZW50ID0g
KHZvaWQgKilkaXJlbnQgKyByZWNsZW47CiAJYnVmLT5jdXJyZW50X2RpciA9IGRpcmVudDsKIAli
dWYtPmNvdW50IC09IHJlY2xlbjsKIAlyZXR1cm4gMDsK


--========/40BDA020000127DB/mail.tiscali.be
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="k-2.4.27-rc2_fbcon.c.diff"

LS0tIGxpbnV4LTIuNC4yNy1yYzItcGE0bW0vZHJpdmVycy92aWRlby9mYmNvbi5jLk9yaWcJMjAw
NC0wNi0yOSAxMDo0NzozMS45MDE0OTEzMDQgKzAyMDAKKysrIGxpbnV4LTIuNC4yNy1yYzItcGE0
bW0vZHJpdmVycy92aWRlby9mYmNvbi5jCTIwMDQtMDYtMjkgMTE6MTM6MzEuODQ2MzQzNjQwICsw
MjAwCkBAIC0xODc3LDcgKzE4NzcsMTAgQEAKICAgICAgICBmb250IGxlbmd0aCBtdXN0IGJlIG11
bHRpcGxlIG9mIDI1NiwgYXQgbGVhc3QuIEFuZCAyNTYgaXMgbXVsdGlwbGUKICAgICAgICBvZiA0
ICovCiAgICAgayA9IDA7Ci0gICAgd2hpbGUgKHAgPiBuZXdfZGF0YSkgayArPSAqLS0odTMyICop
cDsKKyAgICB3aGlsZSAocCA+IG5ld19kYXRhKSB7CisgICAgICAgIHAgPSAodTggKikoKHUzMiAq
KXAgLSAxKTsKKyAgICAgICAgayArPSAqKHUzMiAqKXA7CisgICAgfQogICAgIEZOVFNVTShuZXdf
ZGF0YSkgPSBrOwogICAgIC8qIENoZWNrIGlmIHRoZSBzYW1lIGZvbnQgaXMgb24gc29tZSBvdGhl
ciBjb25zb2xlIGFscmVhZHkgKi8KICAgICBmb3IgKGkgPSAwOyBpIDwgTUFYX05SX0NPTlNPTEVT
OyBpKyspIHsK


--========/40BDA020000127DB/mail.tiscali.be
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="k-2.4.27-rc2_crc32.c.diff"

LS0tIGxpbnV4LTIuNC4yNy1yYzItcGE0bW0vbGliL2NyYzMyLmMuT3JpZwkyMDA0LTA2LTI5IDEx
OjI5OjMxLjcyMTQyMDQ0OCArMDIwMAorKysgbGludXgtMi40LjI3LXJjMi1wYTRtbS9saWIvY3Jj
MzIuYwkyMDA0LTA2LTI5IDExOjM2OjE5Ljk2NDM1ODA4OCArMDIwMApAQCAtOTksNyArOTksOSBA
QAogCS8qIEFsaWduIGl0ICovCiAJaWYodW5saWtlbHkoKChsb25nKWIpJjMgJiYgbGVuKSl7CiAJ
CWRvIHsKLQkJCURPX0NSQygqKCh1OCAqKWIpKyspOworCQkJdTggKnAgPSAodTggKiliOworCQkJ
RE9fQ1JDKCpwKyspOworCQkJYiA9ICh2b2lkICopcDsKIAkJfSB3aGlsZSAoKC0tbGVuKSAmJiAo
KGxvbmcpYikmMyApOwogCX0KIAlpZihsaWtlbHkobGVuID49IDQpKXsKQEAgLTEyMCw3ICsxMjIs
OSBAQAogCS8qIEFuZCB0aGUgbGFzdCBmZXcgYnl0ZXMgKi8KIAlpZihsZW4pewogCQlkbyB7Ci0J
CQlET19DUkMoKigodTggKiliKSsrKTsKKwkJCXU4ICpwID0gKHU4ICopYjsKKwkJCURPX0NSQygq
cCsrKTsKKwkJCWIgPSAodm9pZCAqKXA7CiAJCX0gd2hpbGUgKC0tbGVuKTsKIAl9CiAKQEAgLTIw
MCw3ICsyMDQsOSBAQAogCS8qIEFsaWduIGl0ICovCiAJaWYodW5saWtlbHkoKChsb25nKWIpJjMg
JiYgbGVuKSl7CiAJCWRvIHsKLQkJCURPX0NSQygqKCh1OCAqKWIpKyspOworCQkJdTggKnAgPSAo
dTggKiliOworCQkJRE9fQ1JDKCpwKyspOworCQkJYiA9ICh2b2lkICopcDsKIAkJfSB3aGlsZSAo
KC0tbGVuKSAmJiAoKGxvbmcpYikmMyApOwogCX0KIAlpZihsaWtlbHkobGVuID49IDQpKXsKQEAg
LTIyMSw3ICsyMjcsOSBAQAogCS8qIEFuZCB0aGUgbGFzdCBmZXcgYnl0ZXMgKi8KIAlpZihsZW4p
ewogCQlkbyB7Ci0JCQlET19DUkMoKigodTggKiliKSsrKTsKKwkJCXU4ICpwID0gKHU4ICopYjsK
KwkJCURPX0NSQygqcCsrKTsKKwkJCWIgPSAodm9pZCAqKXA7CiAJCX0gd2hpbGUgKC0tbGVuKTsK
IAl9CiAJcmV0dXJuIF9fYmUzMl90b19jcHUoY3JjKTsK

--========/40BDA020000127DB/mail.tiscali.be--


--========/40BDA020000127E5/mail.tiscali.be--
