Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVIHPEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVIHPEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVIHPEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:04:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:17505
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932534AbVIHPEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:04:01 -0400
Message-Id: <43206F420200007800024455@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:05:06 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] add stricmp
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part6A480432.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part6A480432.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

While strnicmp existed in the set of string support routines, stricmp
didn't, which this patch adjusts.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/include/linux/string.h
2.6.13-stricmp/include/linux/string.h
--- 2.6.13/include/linux/string.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-stricmp/include/linux/string.h	2005-09-01
11:32:12.000000000 +0200
@@ -47,6 +47,9 @@ extern int strcmp(const char *,const cha
 #ifndef __HAVE_ARCH_STRNCMP
 extern int strncmp(const char *,const char *,__kernel_size_t);
 #endif
+#ifndef __HAVE_ARCH_STRICMP
+extern int stricmp(const char *, const char *);
+#endif
 #ifndef __HAVE_ARCH_STRNICMP
 extern int strnicmp(const char *, const char *, __kernel_size_t);
 #endif
diff -Npru 2.6.13/lib/string.c 2.6.13-stricmp/lib/string.c
--- 2.6.13/lib/string.c	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-stricmp/lib/string.c	2005-09-01 11:32:13.000000000
+0200
@@ -24,6 +24,31 @@
 #include <linux/ctype.h>
 #include <linux/module.h>
 
+#ifndef __HAVE_ARCH_STRICMP
+/**
+ * stricmp - Compare two strings case-insensitively
+ * @s1: One string
+ * @s2: Another string
+ */
+int stricmp(const char *s1, const char *s2)
+{
+	unsigned char c1, c2;
+
+	for (;;) {
+		c1 = *s1++;
+		c2 = *s2++;
+		if (!c1 || !c2)
+			break;
+		if (c1 == c2)
+			continue;
+		if ((c1 = tolower(c1)) != (c2 = tolower(c2)))
+			break;
+	}
+	return (int)c1 - (int)c2;
+}
+#endif
+EXPORT_SYMBOL(stricmp);
+
 #ifndef __HAVE_ARCH_STRNICMP
 /**
  * strnicmp - Case insensitive, length-limited string comparison


--=__Part6A480432.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-stricmp.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-stricmp.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCldoaWxlIHN0cm5pY21wIGV4aXN0ZWQgaW4g
dGhlIHNldCBvZiBzdHJpbmcgc3VwcG9ydCByb3V0aW5lcywgc3RyaWNtcApkaWRuJ3QsIHdoaWNo
IHRoaXMgcGF0Y2ggYWRqdXN0cy4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxqYmV1bGlj
aEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvaW5jbHVkZS9saW51eC9zdHJpbmcuaCAy
LjYuMTMtc3RyaWNtcC9pbmNsdWRlL2xpbnV4L3N0cmluZy5oCi0tLSAyLjYuMTMvaW5jbHVkZS9s
aW51eC9zdHJpbmcuaAkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42
LjEzLXN0cmljbXAvaW5jbHVkZS9saW51eC9zdHJpbmcuaAkyMDA1LTA5LTAxIDExOjMyOjEyLjAw
MDAwMDAwMCArMDIwMApAQCAtNDcsNiArNDcsOSBAQCBleHRlcm4gaW50IHN0cmNtcChjb25zdCBj
aGFyICosY29uc3QgY2hhCiAjaWZuZGVmIF9fSEFWRV9BUkNIX1NUUk5DTVAKIGV4dGVybiBpbnQg
c3RybmNtcChjb25zdCBjaGFyICosY29uc3QgY2hhciAqLF9fa2VybmVsX3NpemVfdCk7CiAjZW5k
aWYKKyNpZm5kZWYgX19IQVZFX0FSQ0hfU1RSSUNNUAorZXh0ZXJuIGludCBzdHJpY21wKGNvbnN0
IGNoYXIgKiwgY29uc3QgY2hhciAqKTsKKyNlbmRpZgogI2lmbmRlZiBfX0hBVkVfQVJDSF9TVFJO
SUNNUAogZXh0ZXJuIGludCBzdHJuaWNtcChjb25zdCBjaGFyICosIGNvbnN0IGNoYXIgKiwgX19r
ZXJuZWxfc2l6ZV90KTsKICNlbmRpZgpkaWZmIC1OcHJ1IDIuNi4xMy9saWIvc3RyaW5nLmMgMi42
LjEzLXN0cmljbXAvbGliL3N0cmluZy5jCi0tLSAyLjYuMTMvbGliL3N0cmluZy5jCTIwMDUtMDgt
MjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtc3RyaWNtcC9saWIvc3RyaW5n
LmMJMjAwNS0wOS0wMSAxMTozMjoxMy4wMDAwMDAwMDAgKzAyMDAKQEAgLTI0LDYgKzI0LDMxIEBA
CiAjaW5jbHVkZSA8bGludXgvY3R5cGUuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KIAor
I2lmbmRlZiBfX0hBVkVfQVJDSF9TVFJJQ01QCisvKioKKyAqIHN0cmljbXAgLSBDb21wYXJlIHR3
byBzdHJpbmdzIGNhc2UtaW5zZW5zaXRpdmVseQorICogQHMxOiBPbmUgc3RyaW5nCisgKiBAczI6
IEFub3RoZXIgc3RyaW5nCisgKi8KK2ludCBzdHJpY21wKGNvbnN0IGNoYXIgKnMxLCBjb25zdCBj
aGFyICpzMikKK3sKKwl1bnNpZ25lZCBjaGFyIGMxLCBjMjsKKworCWZvciAoOzspIHsKKwkJYzEg
PSAqczErKzsKKwkJYzIgPSAqczIrKzsKKwkJaWYgKCFjMSB8fCAhYzIpCisJCQlicmVhazsKKwkJ
aWYgKGMxID09IGMyKQorCQkJY29udGludWU7CisJCWlmICgoYzEgPSB0b2xvd2VyKGMxKSkgIT0g
KGMyID0gdG9sb3dlcihjMikpKQorCQkJYnJlYWs7CisJfQorCXJldHVybiAoaW50KWMxIC0gKGlu
dCljMjsKK30KKyNlbmRpZgorRVhQT1JUX1NZTUJPTChzdHJpY21wKTsKKwogI2lmbmRlZiBfX0hB
VkVfQVJDSF9TVFJOSUNNUAogLyoqCiAgKiBzdHJuaWNtcCAtIENhc2UgaW5zZW5zaXRpdmUsIGxl
bmd0aC1saW1pdGVkIHN0cmluZyBjb21wYXJpc29uCg==

--=__Part6A480432.0__=--
