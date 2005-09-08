Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVIHOkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVIHOkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVIHOkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:40:32 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:13917
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751376AbVIHOkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:40:31 -0400
Message-Id: <432069C3020000780002442B@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 16:41:39 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] free initrd mem adjustment
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartF5D79BB3.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartF5D79BB3.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Besides freeing initrd memory, also clear out the now dangling
pointers
to it, to make sure accidental late use attempts can be detected.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/init/initramfs.c 2.6.13-free-initrd/init/initramfs.c
--- 2.6.13/init/initramfs.c	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-free-initrd/init/initramfs.c	2005-04-29
08:51:21.000000000 +0200
@@ -466,6 +466,14 @@ static char * __init unpack_to_rootfs(ch
 extern char __initramfs_start[], __initramfs_end[];
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/initrd.h>
+
+static inline void __init free_initrd(void)
+{
+	free_initrd_mem(initrd_start, initrd_end);
+	initrd_start = 0;
+	initrd_end = 0;
+}
+
 #endif
 
 void __init populate_rootfs(void)
@@ -484,7 +492,7 @@ void __init populate_rootfs(void)
 			printk(" it is\n");
 			unpack_to_rootfs((char *)initrd_start,
 				initrd_end - initrd_start, 0);
-			free_initrd_mem(initrd_start, initrd_end);
+			free_initrd();
 			return;
 		}
 		printk("it isn't (%s); looks like an initrd\n", err);
@@ -493,7 +501,7 @@ void __init populate_rootfs(void)
 			sys_write(fd, (char *)initrd_start,
 					initrd_end - initrd_start);
 			sys_close(fd);
-			free_initrd_mem(initrd_start, initrd_end);
+			free_initrd();
 		}
 	}
 #endif


--=__PartF5D79BB3.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-free-initrd.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-free-initrd.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkJlc2lkZXMgZnJlZWluZyBpbml0cmQgbWVt
b3J5LCBhbHNvIGNsZWFyIG91dCB0aGUgbm93IGRhbmdsaW5nIHBvaW50ZXJzCnRvIGl0LCB0byBt
YWtlIHN1cmUgYWNjaWRlbnRhbCBsYXRlIHVzZSBhdHRlbXB0cyBjYW4gYmUgZGV0ZWN0ZWQuCgpT
aWduZWQtb2ZmLWJ5OiBKYW4gQmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCmRpZmYgLU5w
cnUgMi42LjEzL2luaXQvaW5pdHJhbWZzLmMgMi42LjEzLWZyZWUtaW5pdHJkL2luaXQvaW5pdHJh
bWZzLmMKLS0tIDIuNi4xMy9pbml0L2luaXRyYW1mcy5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAw
MDAwMDAwICswMjAwCisrKyAyLjYuMTMtZnJlZS1pbml0cmQvaW5pdC9pbml0cmFtZnMuYwkyMDA1
LTA0LTI5IDA4OjUxOjIxLjAwMDAwMDAwMCArMDIwMApAQCAtNDY2LDYgKzQ2NiwxNCBAQCBzdGF0
aWMgY2hhciAqIF9faW5pdCB1bnBhY2tfdG9fcm9vdGZzKGNoCiBleHRlcm4gY2hhciBfX2luaXRy
YW1mc19zdGFydFtdLCBfX2luaXRyYW1mc19lbmRbXTsKICNpZmRlZiBDT05GSUdfQkxLX0RFVl9J
TklUUkQKICNpbmNsdWRlIDxsaW51eC9pbml0cmQuaD4KKworc3RhdGljIGlubGluZSB2b2lkIF9f
aW5pdCBmcmVlX2luaXRyZCh2b2lkKQoreworCWZyZWVfaW5pdHJkX21lbShpbml0cmRfc3RhcnQs
IGluaXRyZF9lbmQpOworCWluaXRyZF9zdGFydCA9IDA7CisJaW5pdHJkX2VuZCA9IDA7Cit9CisK
ICNlbmRpZgogCiB2b2lkIF9faW5pdCBwb3B1bGF0ZV9yb290ZnModm9pZCkKQEAgLTQ4NCw3ICs0
OTIsNyBAQCB2b2lkIF9faW5pdCBwb3B1bGF0ZV9yb290ZnModm9pZCkKIAkJCXByaW50aygiIGl0
IGlzXG4iKTsKIAkJCXVucGFja190b19yb290ZnMoKGNoYXIgKilpbml0cmRfc3RhcnQsCiAJCQkJ
aW5pdHJkX2VuZCAtIGluaXRyZF9zdGFydCwgMCk7Ci0JCQlmcmVlX2luaXRyZF9tZW0oaW5pdHJk
X3N0YXJ0LCBpbml0cmRfZW5kKTsKKwkJCWZyZWVfaW5pdHJkKCk7CiAJCQlyZXR1cm47CiAJCX0K
IAkJcHJpbnRrKCJpdCBpc24ndCAoJXMpOyBsb29rcyBsaWtlIGFuIGluaXRyZFxuIiwgZXJyKTsK
QEAgLTQ5Myw3ICs1MDEsNyBAQCB2b2lkIF9faW5pdCBwb3B1bGF0ZV9yb290ZnModm9pZCkKIAkJ
CXN5c193cml0ZShmZCwgKGNoYXIgKilpbml0cmRfc3RhcnQsCiAJCQkJCWluaXRyZF9lbmQgLSBp
bml0cmRfc3RhcnQpOwogCQkJc3lzX2Nsb3NlKGZkKTsKLQkJCWZyZWVfaW5pdHJkX21lbShpbml0
cmRfc3RhcnQsIGluaXRyZF9lbmQpOworCQkJZnJlZV9pbml0cmQoKTsKIAkJfQogCX0KICNlbmRp
Zgo=

--=__PartF5D79BB3.0__=--
