Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTIIBFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 21:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTIIBFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 21:05:07 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:29419 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263870AbTIIBEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 21:04:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3766E.588EA4C4"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [Patch] asm workarounds in generic header files
Date: Mon, 8 Sep 2003 18:04:40 -0700
Message-ID: <A609E6D693908E4697BF8BB87E76A07A022114BC@fmsmsx408.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] asm workarounds in generic header files
Thread-Index: AcN2blh6yIzeFTtzTdqmKY7NfoqQgQ==
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 09 Sep 2003 01:04:40.0725 (UTC) FILETIME=[58F22450:01C3766E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3766E.588EA4C4
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Intel ecc compiler doesn't support inline assembly.=20
Attached patch is required to enable linux kernel build with Intel ecc =
compiler.
Please apply.

thanks,
suresh

diff -Nru linux/include/linux/compiler.h =
linux-2.5/include/linux/compiler.h
--- linux/include/linux/compiler.h	Mon Sep  8 11:51:00 2003
+++ linux-2.5/include/linux/compiler.h	Mon Sep  8 13:22:13 2003
@@ -74,10 +74,26 @@
 #define __attribute_pure__	/* unimplemented */
 #endif
=20
+#if defined(__INTEL_COMPILER) && defined(__ECC)
+/* Optimization barrier */
+#include <asm/intrinsics.h>
+#define barrier()	__memory_barrier()
+
+#define RELOC_HIDE(ptr, off)					\
+  ({ unsigned long __ptr;					\
+     __ptr =3D (unsigned long) (ptr);				\
+    (typeof(ptr)) (__ptr + (off)); })
+#else
+/* Optimization barrier */
+/* The "volatile" is due to gcc bugs */
+#define barrier()	asm volatile ("":::"memory")
+
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it =
*/
 #define RELOC_HIDE(ptr, off)					\
   ({ unsigned long __ptr;					\
     __asm__ ("" : "=3Dg"(__ptr) : "0"(ptr));		\
     (typeof(ptr)) (__ptr + (off)); })
+#endif
+
 #endif /* __LINUX_COMPILER_H */
diff -Nru linux/include/linux/kernel.h linux-2.5/include/linux/kernel.h
--- linux/include/linux/kernel.h	Mon Sep  8 11:51:01 2003
+++ linux-2.5/include/linux/kernel.h	Mon Sep  8 12:06:14 2003
@@ -15,10 +15,6 @@
 #include <asm/byteorder.h>
 #include <asm/bug.h>
=20
-/* Optimization barrier */
-/* The "volatile" is due to gcc bugs */
-#define barrier() __asm__ __volatile__("": : :"memory")
-
 #define INT_MAX		((int)(~0U>>1))
 #define INT_MIN		(-INT_MAX - 1)
 #define UINT_MAX	(~0U)

------_=_NextPart_001_01C3766E.588EA4C4
Content-Type: application/octet-stream;
	name="asm.patch"
Content-Transfer-Encoding: base64
Content-Description: asm.patch
Content-Disposition: attachment;
	filename="asm.patch"

ZGlmZiAtTnJ1IGxpbnV4L2luY2x1ZGUvbGludXgvY29tcGlsZXIuaCBsaW51eC0yLjUvaW5jbHVk
ZS9saW51eC9jb21waWxlci5oCi0tLSBsaW51eC9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgJTW9u
IFNlcCAgOCAxMTo1MTowMCAyMDAzCisrKyBsaW51eC0yLjUvaW5jbHVkZS9saW51eC9jb21waWxl
ci5oCU1vbiBTZXAgIDggMTM6MjI6MTMgMjAwMwpAQCAtNzQsMTAgKzc0LDI2IEBACiAjZGVmaW5l
IF9fYXR0cmlidXRlX3B1cmVfXwkvKiB1bmltcGxlbWVudGVkICovCiAjZW5kaWYKIAorI2lmIGRl
ZmluZWQoX19JTlRFTF9DT01QSUxFUikgJiYgZGVmaW5lZChfX0VDQykKKy8qIE9wdGltaXphdGlv
biBiYXJyaWVyICovCisjaW5jbHVkZSA8YXNtL2ludHJpbnNpY3MuaD4KKyNkZWZpbmUgYmFycmll
cigpCV9fbWVtb3J5X2JhcnJpZXIoKQorCisjZGVmaW5lIFJFTE9DX0hJREUocHRyLCBvZmYpCQkJ
CQlcCisgICh7IHVuc2lnbmVkIGxvbmcgX19wdHI7CQkJCQlcCisgICAgIF9fcHRyID0gKHVuc2ln
bmVkIGxvbmcpIChwdHIpOwkJCQlcCisgICAgKHR5cGVvZihwdHIpKSAoX19wdHIgKyAob2ZmKSk7
IH0pCisjZWxzZQorLyogT3B0aW1pemF0aW9uIGJhcnJpZXIgKi8KKy8qIFRoZSAidm9sYXRpbGUi
IGlzIGR1ZSB0byBnY2MgYnVncyAqLworI2RlZmluZSBiYXJyaWVyKCkJYXNtIHZvbGF0aWxlICgi
Ijo6OiJtZW1vcnkiKQorCiAvKiBUaGlzIG1hY3JvIG9iZnVzY2F0ZXMgYXJpdGhtZXRpYyBvbiBh
IHZhcmlhYmxlIGFkZHJlc3Mgc28gdGhhdCBnY2MKICAgIHNob3VsZG4ndCByZWNvZ25pemUgdGhl
IG9yaWdpbmFsIHZhciwgYW5kIG1ha2UgYXNzdW1wdGlvbnMgYWJvdXQgaXQgKi8KICNkZWZpbmUg
UkVMT0NfSElERShwdHIsIG9mZikJCQkJCVwKICAgKHsgdW5zaWduZWQgbG9uZyBfX3B0cjsJCQkJ
CVwKICAgICBfX2FzbV9fICgiIiA6ICI9ZyIoX19wdHIpIDogIjAiKHB0cikpOwkJXAogICAgICh0
eXBlb2YocHRyKSkgKF9fcHRyICsgKG9mZikpOyB9KQorI2VuZGlmCisKICNlbmRpZiAvKiBfX0xJ
TlVYX0NPTVBJTEVSX0ggKi8KZGlmZiAtTnJ1IGxpbnV4L2luY2x1ZGUvbGludXgva2VybmVsLmgg
bGludXgtMi41L2luY2x1ZGUvbGludXgva2VybmVsLmgKLS0tIGxpbnV4L2luY2x1ZGUvbGludXgv
a2VybmVsLmgJTW9uIFNlcCAgOCAxMTo1MTowMSAyMDAzCisrKyBsaW51eC0yLjUvaW5jbHVkZS9s
aW51eC9rZXJuZWwuaAlNb24gU2VwICA4IDEyOjA2OjE0IDIwMDMKQEAgLTE1LDEwICsxNSw2IEBA
CiAjaW5jbHVkZSA8YXNtL2J5dGVvcmRlci5oPgogI2luY2x1ZGUgPGFzbS9idWcuaD4KIAotLyog
T3B0aW1pemF0aW9uIGJhcnJpZXIgKi8KLS8qIFRoZSAidm9sYXRpbGUiIGlzIGR1ZSB0byBnY2Mg
YnVncyAqLwotI2RlZmluZSBiYXJyaWVyKCkgX19hc21fXyBfX3ZvbGF0aWxlX18oIiI6IDogOiJt
ZW1vcnkiKQotCiAjZGVmaW5lIElOVF9NQVgJCSgoaW50KSh+MFU+PjEpKQogI2RlZmluZSBJTlRf
TUlOCQkoLUlOVF9NQVggLSAxKQogI2RlZmluZSBVSU5UX01BWAkofjBVKQo=

------_=_NextPart_001_01C3766E.588EA4C4--
