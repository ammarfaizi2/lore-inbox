Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbSIYM1H>; Wed, 25 Sep 2002 08:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSIYM1H>; Wed, 25 Sep 2002 08:27:07 -0400
Received: from [217.167.51.129] ([217.167.51.129]:51674 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261952AbSIYM1F>;
	Wed, 25 Sep 2002 08:27:05 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <axboe@suse.de>
Subject: [PATCH] fix ide-iops for big endian archs
Date: Wed, 25 Sep 2002 14:32:23 +0200
Message-Id: <20020925123223.16082@192.168.4.1>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==_20020925123223.28378-1_=="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_20020925123223.28378-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Curently in 2.5 (afaik in -ac too), the ide-iops "s" routines used
to transfer datas in/out the data port are incorrect for big endian
machines. They are implemented with a loop of inw/outw which are
byteswapping, but a fifo transfer like that mustn't be swapped.

Here's a patch against current 2.5 (that should apply to 2.4 -ac too)
that fixes those with a #define for now. I have done some further
cleanup of the iops (removing the {IN,OUT}{BYTE,WORD,LONG} macros
and removing the "P" iops from the hwif structure) too, but Alan
didn't accept those yet.

I enclosed the patch as an attachement too in case the mailer screws
it up...


===== drivers/ide/ide-iops.c 1.1 vs edited =====
--- 1.1/drivers/ide/ide-iops.c	Wed Sep 11 08:54:11 2002
+++ edited/drivers/ide/ide-iops.c	Wed Sep 25 14:19:58 2002
@@ -54,12 +54,20 @@
 
 static inline void ide_insw (u32 port, void *addr, u32 count)
 {
+#ifdef __BIG_ENDIAN
+	insw(port, addr, count);
+#else	
 	while (count--) { *(u16 *)addr = IN_WORD(port); addr += 2; }
+#endif	
 }
 
 static inline void ide_insw_p (u32 port, void *addr, u32 count)
 {
-	while (count--) { *(u16 *)addr = IN_WORD_P(port); addr += 2; }
+#ifdef __BIG_ENDIAN
+	insw(port, addr, count);
+#else	
+	while (count--) { *(u16 *)addr = IN_WORD(port); addr += 2; }
+#endif	
 }
 
 static inline u32 ide_inl (u32 port)
@@ -106,12 +114,20 @@
 
 static inline void ide_outsw (u32 port, void *addr, u32 count)
 {
+#ifdef __BIG_ENDIAN
+	outsw(port, addr, count);
+#else
 	while (count--) { OUT_WORD(*(u16 *)addr, port); addr += 2; }
+#endif
 }
 
 static inline void ide_outsw_p (u32 port, void *addr, u32 count)
 {
+#ifdef __BIG_ENDIAN
+	outsw(port, addr, count);
+#else
 	while (count--) { OUT_WORD_P(*(u16 *)addr, port); addr += 2; }
+#endif
 }
 
 static inline void ide_outl (u32 addr, u32 port)

--==_20020925123223.28378-1_==
Content-Type: application/text; name="ide-fix.diff"; x-mac-type="54455854";
 x-mac-creator="74747874"
Content-Disposition: attachment
Content-Transfer-Encoding: base64

PT09PT0gZHJpdmVycy9pZGUvaWRlLWlvcHMuYyAxLjEgdnMgZWRpdGVkID09PT09Ci0tLSAx
LjEvZHJpdmVycy9pZGUvaWRlLWlvcHMuYwlXZWQgU2VwIDExIDA4OjU0OjExIDIwMDIKKysr
IGVkaXRlZC9kcml2ZXJzL2lkZS9pZGUtaW9wcy5jCVdlZCBTZXAgMjUgMTQ6MTk6NTggMjAw
MgpAQCAtNTQsMTIgKzU0LDIwIEBACiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBpZGVfaW5zdyAo
dTMyIHBvcnQsIHZvaWQgKmFkZHIsIHUzMiBjb3VudCkKIHsKKyNpZmRlZiBfX0JJR19FTkRJ
QU4KKwlpbnN3KHBvcnQsIGFkZHIsIGNvdW50KTsKKyNlbHNlCQogCXdoaWxlIChjb3VudC0t
KSB7ICoodTE2ICopYWRkciA9IElOX1dPUkQocG9ydCk7IGFkZHIgKz0gMjsgfQorI2VuZGlm
CQogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgaWRlX2luc3dfcCAodTMyIHBvcnQsIHZvaWQg
KmFkZHIsIHUzMiBjb3VudCkKIHsKLQl3aGlsZSAoY291bnQtLSkgeyAqKHUxNiAqKWFkZHIg
PSBJTl9XT1JEX1AocG9ydCk7IGFkZHIgKz0gMjsgfQorI2lmZGVmIF9fQklHX0VORElBTgor
CWluc3cocG9ydCwgYWRkciwgY291bnQpOworI2Vsc2UJCisJd2hpbGUgKGNvdW50LS0pIHsg
Kih1MTYgKilhZGRyID0gSU5fV09SRChwb3J0KTsgYWRkciArPSAyOyB9CisjZW5kaWYJCiB9
CiAKIHN0YXRpYyBpbmxpbmUgdTMyIGlkZV9pbmwgKHUzMiBwb3J0KQpAQCAtMTA2LDEyICsx
MTQsMjAgQEAKIAogc3RhdGljIGlubGluZSB2b2lkIGlkZV9vdXRzdyAodTMyIHBvcnQsIHZv
aWQgKmFkZHIsIHUzMiBjb3VudCkKIHsKKyNpZmRlZiBfX0JJR19FTkRJQU4KKwlvdXRzdyhw
b3J0LCBhZGRyLCBjb3VudCk7CisjZWxzZQogCXdoaWxlIChjb3VudC0tKSB7IE9VVF9XT1JE
KCoodTE2ICopYWRkciwgcG9ydCk7IGFkZHIgKz0gMjsgfQorI2VuZGlmCiB9CiAKIHN0YXRp
YyBpbmxpbmUgdm9pZCBpZGVfb3V0c3dfcCAodTMyIHBvcnQsIHZvaWQgKmFkZHIsIHUzMiBj
b3VudCkKIHsKKyNpZmRlZiBfX0JJR19FTkRJQU4KKwlvdXRzdyhwb3J0LCBhZGRyLCBjb3Vu
dCk7CisjZWxzZQogCXdoaWxlIChjb3VudC0tKSB7IE9VVF9XT1JEX1AoKih1MTYgKilhZGRy
LCBwb3J0KTsgYWRkciArPSAyOyB9CisjZW5kaWYKIH0KIAogc3RhdGljIGlubGluZSB2b2lk
IGlkZV9vdXRsICh1MzIgYWRkciwgdTMyIHBvcnQpCg==
--==_20020925123223.28378-1_==--

