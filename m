Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbTIJEus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264565AbTIJEus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:50:48 -0400
Received: from fmr09.intel.com ([192.52.57.35]:17407 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264561AbTIJEuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:50:19 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C37757.05C8CFB8"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [Patch] asm workarounds in generic header files
Date: Tue, 9 Sep 2003 21:50:13 -0700
Message-ID: <A609E6D693908E4697BF8BB87E76A07A022114C1@fmsmsx408.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] asm workarounds in generic header files
Thread-Index: AcN3LHzuOmNvBJCLSzOWNjEJQmt+GQAJPF5g
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: <davidm@HPL.HP.COM>, "Linus Torvalds" <torvalds@osdl.org>
Cc: "Jes Sorensen" <jes@wildopensource.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 10 Sep 2003 04:50:14.0505 (UTC) FILETIME=[061ED590:01C37757]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C37757.05C8CFB8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> How about something like this?
> (the patch has Works-for-Me status...)
>=20
> 	--david

Attached the patch with minor changes to David's patch.

include/linux/compiler.h defines the generic=20
definitions which are overwritten by per-compiler definitions.

include/linux/compiler-gcc.h contains the common definitions=20
for all gcc versions.

include/linux/compiler-gcc[2,3,+].h contains gcc version=20
specific definitions.

And intel.diff patch adds Intel compiler specific definitions.

thanks,
suresh

diff -Nru linux/include/linux/compiler-gcc+.h =
linux-/include/linux/compiler-gcc+.h
--- linux/include/linux/compiler-gcc+.h	Wed Dec 31 16:00:00 1969
+++ linux-/include/linux/compiler-gcc+.h	Tue Sep  9 21:26:03 2003
@@ -0,0 +1,14 @@
+/* Never include this file directly.  Include <linux/compiler.h> =
instead.  */
+
+/*
+ * These definitions are for Ueber-GCC: always newer than the latest
+ * version and hence sporting everything plus a kitchen-sink.
+ */
+#include <linux/compiler-gcc.h>
+
+#define inline			__inline__ __attribute__((always_inline))
+#define __inline__		__inline__ __attribute__((always_inline))
+#define __inline		__inline__ __attribute__((always_inline))
+#define __deprecated		__attribute__((deprecated))
+#define __attribute_used__	__attribute__((__used__))
+#define __attribute_pure__	__attribute__((pure))
diff -Nru linux/include/linux/compiler-gcc.h =
linux-/include/linux/compiler-gcc.h
--- linux/include/linux/compiler-gcc.h	Wed Dec 31 16:00:00 1969
+++ linux-/include/linux/compiler-gcc.h	Tue Sep  9 21:26:03 2003
@@ -0,0 +1,17 @@
+/* Never include this file directly.  Include <linux/compiler.h> =
instead.  */
+
+/*
+ * Common definitions for all gcc versions go here.
+ */
+
+
+/* Optimization barrier */
+/* The "volatile" is due to gcc bugs */
+#define barrier() __asm__ __volatile__("": : :"memory")
+
+/* This macro obfuscates arithmetic on a variable address so that gcc
+   shouldn't recognize the original var, and make assumptions about it =
*/
+#define RELOC_HIDE(ptr, off)					\
+  ({ unsigned long __ptr;					\
+    __asm__ ("" : "=3Dg"(__ptr) : "0"(ptr));		\
+    (typeof(ptr)) (__ptr + (off)); })
diff -Nru linux/include/linux/compiler-gcc2.h =
linux-/include/linux/compiler-gcc2.h
--- linux/include/linux/compiler-gcc2.h	Wed Dec 31 16:00:00 1969
+++ linux-/include/linux/compiler-gcc2.h	Tue Sep  9 21:26:03 2003
@@ -0,0 +1,23 @@
+/* Never include this file directly.  Include <linux/compiler.h> =
instead.  */
+
+/* These definitions are for GCC v2.x.  */
+
+/* Somewhere in the middle of the GCC 2.96 development cycle, we =
implemented
+   a mechanism by which the user can annotate likely branch directions =
and
+   expect the blocks to be reordered appropriately.  Define =
__builtin_expect
+   to nothing for earlier compilers.  */
+#include <linux/compiler-gcc.h>
+
+#if __GNUC_MINOR__ < 96
+# define __builtin_expect(x, expected_value) (x)
+#endif
+
+#define __attribute_used__	__attribute__((__unused__))
+
+/*
+ * The attribute `pure' is not implemented in GCC versions earlier
+ * than 2.96.
+ */
+#if __GNUC_MINOR__ >=3D 96
+# define __attribute_pure__	__attribute__((pure))
+#endif
diff -Nru linux/include/linux/compiler-gcc3.h =
linux-/include/linux/compiler-gcc3.h
--- linux/include/linux/compiler-gcc3.h	Wed Dec 31 16:00:00 1969
+++ linux-/include/linux/compiler-gcc3.h	Tue Sep  9 21:26:03 2003
@@ -0,0 +1,22 @@
+/* Never include this file directly.  Include <linux/compiler.h> =
instead.  */
+
+/* These definitions are for GCC v3.x.  */
+#include <linux/compiler-gcc.h>
+
+#if __GNUC_MINOR__ >=3D 1
+# define inline		__inline__ __attribute__((always_inline))
+# define __inline__	__inline__ __attribute__((always_inline))
+# define __inline	__inline__ __attribute__((always_inline))
+#endif
+
+#if __GNUC_MINOR__ > 0
+# define __deprecated	__attribute__((deprecated))
+#endif
+
+#if __GNUC_MINOR__ >=3D 3
+# define __attribute_used__	__attribute__((__used__))
+#else
+# define __attribute_used__	__attribute__((__unused__))
+#endif
+
+#define __attribute_pure__	__attribute__((pure))
diff -Nru linux/include/linux/compiler.h linux-/include/linux/compiler.h
--- linux/include/linux/compiler.h	Mon Sep  8 11:51:00 2003
+++ linux-/include/linux/compiler.h	Tue Sep  9 21:32:44 2003
@@ -2,28 +2,28 @@
 #define __LINUX_COMPILER_H
=20
 #ifdef __CHECKER__
-  #define __user	__attribute__((noderef, address_space(1)))
-  #define __kernel	/* default address space */
+# define __user		__attribute__((noderef, address_space(1)))
+# define __kernel	/* default address space */
 #else
-  #define __user
-  #define __kernel
+# define __user
+# define __kernel
 #endif
=20
-#if (__GNUC__ > 3) || (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 1)
-#define inline		__inline__ __attribute__((always_inline))
-#define __inline__	__inline__ __attribute__((always_inline))
-#define __inline	__inline__ __attribute__((always_inline))
-#endif
-
-/* Somewhere in the middle of the GCC 2.96 development cycle, we =
implemented
-   a mechanism by which the user can annotate likely branch directions =
and
-   expect the blocks to be reordered appropriately.  Define =
__builtin_expect
-   to nothing for earlier compilers.  */
-
-#if __GNUC__ =3D=3D 2 && __GNUC_MINOR__ < 96
-#define __builtin_expect(x, expected_value) (x)
+#if __GNUC__ > 3
+# include <linux/compiler-gcc+.h>	/* catch-all for GCC 4, 5, etc. */
+#elif __GNUC__ =3D=3D 3
+# include <linux/compiler-gcc3.h>
+#elif __GNUC__ =3D=3D 2
+# include <linux/compiler-gcc2.h>
+#else
+# error Sorry, your compiler is too old/not recognized.
 #endif
=20
+/*=20
+ * Below are the generic compiler related macros required for kernel
+ * build. Actual compiler/compiler version specific implementations=20
+ * come from the above header files
+ */
 #define likely(x)	__builtin_expect(!!(x), 1)
 #define unlikely(x)	__builtin_expect(!!(x), 0)
=20
@@ -33,10 +33,8 @@
  * Usage is:
  * 		int __deprecated foo(void)
  */
-#if ( __GNUC__ =3D=3D 3 && __GNUC_MINOR__ > 0 ) || __GNUC__ > 3
-#define __deprecated	__attribute__((deprecated))
-#else
-#define __deprecated
+#ifndef __deprecated
+# define __deprecated		/* unimplemented */
 #endif
=20
 /*
@@ -50,10 +48,8 @@
  * In prior versions of gcc, such functions and data would be emitted, =
but
  * would be warned about except with attribute((unused)).
  */
-#if __GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 3 || __GNUC__ > 3
-#define __attribute_used__	__attribute__((__used__))
-#else
-#define __attribute_used__	__attribute__((__unused__))
+#ifndef __attribute_used__
+# define __attribute_used__	/* unimplemented */
 #endif
=20
 /*
@@ -65,19 +61,21 @@
  * elimination and loop optimization just as an arithmetic operator
  * would be.
  * [...]
- * The attribute `pure' is not implemented in GCC versions earlier
- * than 2.96.
  */
-#if (__GNUC__ =3D=3D 2 && __GNUC_MINOR__ >=3D 96) || __GNUC__ > 2
-#define __attribute_pure__	__attribute__((pure))
-#else
-#define __attribute_pure__	/* unimplemented */
+#ifndef __attribute_pure__
+# define __attribute_pure__	/* unimplemented */
+#endif
+
+/* Optimization barrier */
+#ifndef barrier
+# define barrier() __memory_barrier();
 #endif
=20
-/* This macro obfuscates arithmetic on a variable address so that gcc
-   shouldn't recognize the original var, and make assumptions about it =
*/
-#define RELOC_HIDE(ptr, off)					\
+#ifndef RELOC_HIDE
+# define RELOC_HIDE(ptr, off)					\
   ({ unsigned long __ptr;					\
-    __asm__ ("" : "=3Dg"(__ptr) : "0"(ptr));		\
+     __ptr =3D (unsigned long) (ptr);				\
     (typeof(ptr)) (__ptr + (off)); })
+#endif
+
 #endif /* __LINUX_COMPILER_H */
diff -Nru linux/include/linux/kernel.h linux-/include/linux/kernel.h
--- linux/include/linux/kernel.h	Mon Sep  8 11:51:01 2003
+++ linux-/include/linux/kernel.h	Tue Sep  9 21:26:03 2003
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
diff -Nru linux/include/linux/compiler-intel.h =
linux-/include/linux/compiler-intel.h
--- linux/include/linux/compiler-intel.h	Wed Dec 31 16:00:00 1969
+++ linux-/include/linux/compiler-intel.h	Tue Sep  9 21:34:19 2003
@@ -0,0 +1,21 @@
+/* Never include this file directly.  Include <linux/compiler.h> =
instead.  */
+
+#ifdef __ECC
+
+/* Some compiler specific definitions are overwritten here
+ * for Intel ECC compiler=20
+ */
+
+#include <asm/intrinsics.h>
+
+#undef barrier
+#undef RELOC_HIDE
+
+#define barrier() __memory_barrier()
+
+#define RELOC_HIDE(ptr, off)					\
+  ({ unsigned long __ptr;					\
+     __ptr =3D (unsigned long) (ptr);				\
+    (typeof(ptr)) (__ptr + (off)); })
+
+#endif
diff -Nru linux/include/linux/compiler.h linux-/include/linux/compiler.h
--- linux/include/linux/compiler.h	Tue Sep  9 21:34:11 2003
+++ linux-/include/linux/compiler.h	Tue Sep  9 21:35:08 2003
@@ -19,6 +19,13 @@
 # error Sorry, your compiler is too old/not recognized.
 #endif
=20
+/* Intel compiler defines __GNUC__. So we will overwrite =
implementations
+ * coming from above header files here
+ */
+#ifdef __INTEL_COMPILER
+# include <linux/compiler-intel.h>
+#endif
+
 /*=20
  * Below are the generic compiler related macros required for kernel
  * build. Actual compiler/compiler version specific implementations=20





------_=_NextPart_001_01C37757.05C8CFB8
Content-Type: application/octet-stream;
	name="compiler.h.diff"
Content-Transfer-Encoding: base64
Content-Description: compiler.h.diff
Content-Disposition: attachment;
	filename="compiler.h.diff"

ZGlmZiAtTnJ1IGxpbnV4L2luY2x1ZGUvbGludXgvY29tcGlsZXItZ2NjKy5oIGxpbnV4LS9pbmNs
dWRlL2xpbnV4L2NvbXBpbGVyLWdjYysuaAotLS0gbGludXgvaW5jbHVkZS9saW51eC9jb21waWxl
ci1nY2MrLmgJV2VkIERlYyAzMSAxNjowMDowMCAxOTY5CisrKyBsaW51eC0vaW5jbHVkZS9saW51
eC9jb21waWxlci1nY2MrLmgJVHVlIFNlcCAgOSAyMToyNjowMyAyMDAzCkBAIC0wLDAgKzEsMTQg
QEAKKy8qIE5ldmVyIGluY2x1ZGUgdGhpcyBmaWxlIGRpcmVjdGx5LiAgSW5jbHVkZSA8bGludXgv
Y29tcGlsZXIuaD4gaW5zdGVhZC4gICovCisKKy8qCisgKiBUaGVzZSBkZWZpbml0aW9ucyBhcmUg
Zm9yIFVlYmVyLUdDQzogYWx3YXlzIG5ld2VyIHRoYW4gdGhlIGxhdGVzdAorICogdmVyc2lvbiBh
bmQgaGVuY2Ugc3BvcnRpbmcgZXZlcnl0aGluZyBwbHVzIGEga2l0Y2hlbi1zaW5rLgorICovCisj
aW5jbHVkZSA8bGludXgvY29tcGlsZXItZ2NjLmg+CisKKyNkZWZpbmUgaW5saW5lCQkJX19pbmxp
bmVfXyBfX2F0dHJpYnV0ZV9fKChhbHdheXNfaW5saW5lKSkKKyNkZWZpbmUgX19pbmxpbmVfXwkJ
X19pbmxpbmVfXyBfX2F0dHJpYnV0ZV9fKChhbHdheXNfaW5saW5lKSkKKyNkZWZpbmUgX19pbmxp
bmUJCV9faW5saW5lX18gX19hdHRyaWJ1dGVfXygoYWx3YXlzX2lubGluZSkpCisjZGVmaW5lIF9f
ZGVwcmVjYXRlZAkJX19hdHRyaWJ1dGVfXygoZGVwcmVjYXRlZCkpCisjZGVmaW5lIF9fYXR0cmli
dXRlX3VzZWRfXwlfX2F0dHJpYnV0ZV9fKChfX3VzZWRfXykpCisjZGVmaW5lIF9fYXR0cmlidXRl
X3B1cmVfXwlfX2F0dHJpYnV0ZV9fKChwdXJlKSkKZGlmZiAtTnJ1IGxpbnV4L2luY2x1ZGUvbGlu
dXgvY29tcGlsZXItZ2NjLmggbGludXgtL2luY2x1ZGUvbGludXgvY29tcGlsZXItZ2NjLmgKLS0t
IGxpbnV4L2luY2x1ZGUvbGludXgvY29tcGlsZXItZ2NjLmgJV2VkIERlYyAzMSAxNjowMDowMCAx
OTY5CisrKyBsaW51eC0vaW5jbHVkZS9saW51eC9jb21waWxlci1nY2MuaAlUdWUgU2VwICA5IDIx
OjI2OjAzIDIwMDMKQEAgLTAsMCArMSwxNyBAQAorLyogTmV2ZXIgaW5jbHVkZSB0aGlzIGZpbGUg
ZGlyZWN0bHkuICBJbmNsdWRlIDxsaW51eC9jb21waWxlci5oPiBpbnN0ZWFkLiAgKi8KKworLyoK
KyAqIENvbW1vbiBkZWZpbml0aW9ucyBmb3IgYWxsIGdjYyB2ZXJzaW9ucyBnbyBoZXJlLgorICov
CisKKworLyogT3B0aW1pemF0aW9uIGJhcnJpZXIgKi8KKy8qIFRoZSAidm9sYXRpbGUiIGlzIGR1
ZSB0byBnY2MgYnVncyAqLworI2RlZmluZSBiYXJyaWVyKCkgX19hc21fXyBfX3ZvbGF0aWxlX18o
IiI6IDogOiJtZW1vcnkiKQorCisvKiBUaGlzIG1hY3JvIG9iZnVzY2F0ZXMgYXJpdGhtZXRpYyBv
biBhIHZhcmlhYmxlIGFkZHJlc3Mgc28gdGhhdCBnY2MKKyAgIHNob3VsZG4ndCByZWNvZ25pemUg
dGhlIG9yaWdpbmFsIHZhciwgYW5kIG1ha2UgYXNzdW1wdGlvbnMgYWJvdXQgaXQgKi8KKyNkZWZp
bmUgUkVMT0NfSElERShwdHIsIG9mZikJCQkJCVwKKyAgKHsgdW5zaWduZWQgbG9uZyBfX3B0cjsJ
CQkJCVwKKyAgICBfX2FzbV9fICgiIiA6ICI9ZyIoX19wdHIpIDogIjAiKHB0cikpOwkJXAorICAg
ICh0eXBlb2YocHRyKSkgKF9fcHRyICsgKG9mZikpOyB9KQpkaWZmIC1OcnUgbGludXgvaW5jbHVk
ZS9saW51eC9jb21waWxlci1nY2MyLmggbGludXgtL2luY2x1ZGUvbGludXgvY29tcGlsZXItZ2Nj
Mi5oCi0tLSBsaW51eC9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWdjYzIuaAlXZWQgRGVjIDMxIDE2
OjAwOjAwIDE5NjkKKysrIGxpbnV4LS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWdjYzIuaAlUdWUg
U2VwICA5IDIxOjI2OjAzIDIwMDMKQEAgLTAsMCArMSwyMyBAQAorLyogTmV2ZXIgaW5jbHVkZSB0
aGlzIGZpbGUgZGlyZWN0bHkuICBJbmNsdWRlIDxsaW51eC9jb21waWxlci5oPiBpbnN0ZWFkLiAg
Ki8KKworLyogVGhlc2UgZGVmaW5pdGlvbnMgYXJlIGZvciBHQ0MgdjIueC4gICovCisKKy8qIFNv
bWV3aGVyZSBpbiB0aGUgbWlkZGxlIG9mIHRoZSBHQ0MgMi45NiBkZXZlbG9wbWVudCBjeWNsZSwg
d2UgaW1wbGVtZW50ZWQKKyAgIGEgbWVjaGFuaXNtIGJ5IHdoaWNoIHRoZSB1c2VyIGNhbiBhbm5v
dGF0ZSBsaWtlbHkgYnJhbmNoIGRpcmVjdGlvbnMgYW5kCisgICBleHBlY3QgdGhlIGJsb2NrcyB0
byBiZSByZW9yZGVyZWQgYXBwcm9wcmlhdGVseS4gIERlZmluZSBfX2J1aWx0aW5fZXhwZWN0Cisg
ICB0byBub3RoaW5nIGZvciBlYXJsaWVyIGNvbXBpbGVycy4gICovCisjaW5jbHVkZSA8bGludXgv
Y29tcGlsZXItZ2NjLmg+CisKKyNpZiBfX0dOVUNfTUlOT1JfXyA8IDk2CisjIGRlZmluZSBfX2J1
aWx0aW5fZXhwZWN0KHgsIGV4cGVjdGVkX3ZhbHVlKSAoeCkKKyNlbmRpZgorCisjZGVmaW5lIF9f
YXR0cmlidXRlX3VzZWRfXwlfX2F0dHJpYnV0ZV9fKChfX3VudXNlZF9fKSkKKworLyoKKyAqIFRo
ZSBhdHRyaWJ1dGUgYHB1cmUnIGlzIG5vdCBpbXBsZW1lbnRlZCBpbiBHQ0MgdmVyc2lvbnMgZWFy
bGllcgorICogdGhhbiAyLjk2LgorICovCisjaWYgX19HTlVDX01JTk9SX18gPj0gOTYKKyMgZGVm
aW5lIF9fYXR0cmlidXRlX3B1cmVfXwlfX2F0dHJpYnV0ZV9fKChwdXJlKSkKKyNlbmRpZgpkaWZm
IC1OcnUgbGludXgvaW5jbHVkZS9saW51eC9jb21waWxlci1nY2MzLmggbGludXgtL2luY2x1ZGUv
bGludXgvY29tcGlsZXItZ2NjMy5oCi0tLSBsaW51eC9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWdj
YzMuaAlXZWQgRGVjIDMxIDE2OjAwOjAwIDE5NjkKKysrIGxpbnV4LS9pbmNsdWRlL2xpbnV4L2Nv
bXBpbGVyLWdjYzMuaAlUdWUgU2VwICA5IDIxOjI2OjAzIDIwMDMKQEAgLTAsMCArMSwyMiBAQAor
LyogTmV2ZXIgaW5jbHVkZSB0aGlzIGZpbGUgZGlyZWN0bHkuICBJbmNsdWRlIDxsaW51eC9jb21w
aWxlci5oPiBpbnN0ZWFkLiAgKi8KKworLyogVGhlc2UgZGVmaW5pdGlvbnMgYXJlIGZvciBHQ0Mg
djMueC4gICovCisjaW5jbHVkZSA8bGludXgvY29tcGlsZXItZ2NjLmg+CisKKyNpZiBfX0dOVUNf
TUlOT1JfXyA+PSAxCisjIGRlZmluZSBpbmxpbmUJCV9faW5saW5lX18gX19hdHRyaWJ1dGVfXygo
YWx3YXlzX2lubGluZSkpCisjIGRlZmluZSBfX2lubGluZV9fCV9faW5saW5lX18gX19hdHRyaWJ1
dGVfXygoYWx3YXlzX2lubGluZSkpCisjIGRlZmluZSBfX2lubGluZQlfX2lubGluZV9fIF9fYXR0
cmlidXRlX18oKGFsd2F5c19pbmxpbmUpKQorI2VuZGlmCisKKyNpZiBfX0dOVUNfTUlOT1JfXyA+
IDAKKyMgZGVmaW5lIF9fZGVwcmVjYXRlZAlfX2F0dHJpYnV0ZV9fKChkZXByZWNhdGVkKSkKKyNl
bmRpZgorCisjaWYgX19HTlVDX01JTk9SX18gPj0gMworIyBkZWZpbmUgX19hdHRyaWJ1dGVfdXNl
ZF9fCV9fYXR0cmlidXRlX18oKF9fdXNlZF9fKSkKKyNlbHNlCisjIGRlZmluZSBfX2F0dHJpYnV0
ZV91c2VkX18JX19hdHRyaWJ1dGVfXygoX191bnVzZWRfXykpCisjZW5kaWYKKworI2RlZmluZSBf
X2F0dHJpYnV0ZV9wdXJlX18JX19hdHRyaWJ1dGVfXygocHVyZSkpCmRpZmYgLU5ydSBsaW51eC9p
bmNsdWRlL2xpbnV4L2NvbXBpbGVyLmggbGludXgtL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaAot
LS0gbGludXgvaW5jbHVkZS9saW51eC9jb21waWxlci5oCU1vbiBTZXAgIDggMTE6NTE6MDAgMjAw
MworKysgbGludXgtL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaAlUdWUgU2VwICA5IDIxOjMyOjQ0
IDIwMDMKQEAgLTIsMjggKzIsMjggQEAKICNkZWZpbmUgX19MSU5VWF9DT01QSUxFUl9ICiAKICNp
ZmRlZiBfX0NIRUNLRVJfXwotICAjZGVmaW5lIF9fdXNlcglfX2F0dHJpYnV0ZV9fKChub2RlcmVm
LCBhZGRyZXNzX3NwYWNlKDEpKSkKLSAgI2RlZmluZSBfX2tlcm5lbAkvKiBkZWZhdWx0IGFkZHJl
c3Mgc3BhY2UgKi8KKyMgZGVmaW5lIF9fdXNlcgkJX19hdHRyaWJ1dGVfXygobm9kZXJlZiwgYWRk
cmVzc19zcGFjZSgxKSkpCisjIGRlZmluZSBfX2tlcm5lbAkvKiBkZWZhdWx0IGFkZHJlc3Mgc3Bh
Y2UgKi8KICNlbHNlCi0gICNkZWZpbmUgX191c2VyCi0gICNkZWZpbmUgX19rZXJuZWwKKyMgZGVm
aW5lIF9fdXNlcgorIyBkZWZpbmUgX19rZXJuZWwKICNlbmRpZgogCi0jaWYgKF9fR05VQ19fID4g
MykgfHwgKF9fR05VQ19fID09IDMgJiYgX19HTlVDX01JTk9SX18gPj0gMSkKLSNkZWZpbmUgaW5s
aW5lCQlfX2lubGluZV9fIF9fYXR0cmlidXRlX18oKGFsd2F5c19pbmxpbmUpKQotI2RlZmluZSBf
X2lubGluZV9fCV9faW5saW5lX18gX19hdHRyaWJ1dGVfXygoYWx3YXlzX2lubGluZSkpCi0jZGVm
aW5lIF9faW5saW5lCV9faW5saW5lX18gX19hdHRyaWJ1dGVfXygoYWx3YXlzX2lubGluZSkpCi0j
ZW5kaWYKLQotLyogU29tZXdoZXJlIGluIHRoZSBtaWRkbGUgb2YgdGhlIEdDQyAyLjk2IGRldmVs
b3BtZW50IGN5Y2xlLCB3ZSBpbXBsZW1lbnRlZAotICAgYSBtZWNoYW5pc20gYnkgd2hpY2ggdGhl
IHVzZXIgY2FuIGFubm90YXRlIGxpa2VseSBicmFuY2ggZGlyZWN0aW9ucyBhbmQKLSAgIGV4cGVj
dCB0aGUgYmxvY2tzIHRvIGJlIHJlb3JkZXJlZCBhcHByb3ByaWF0ZWx5LiAgRGVmaW5lIF9fYnVp
bHRpbl9leHBlY3QKLSAgIHRvIG5vdGhpbmcgZm9yIGVhcmxpZXIgY29tcGlsZXJzLiAgKi8KLQot
I2lmIF9fR05VQ19fID09IDIgJiYgX19HTlVDX01JTk9SX18gPCA5NgotI2RlZmluZSBfX2J1aWx0
aW5fZXhwZWN0KHgsIGV4cGVjdGVkX3ZhbHVlKSAoeCkKKyNpZiBfX0dOVUNfXyA+IDMKKyMgaW5j
bHVkZSA8bGludXgvY29tcGlsZXItZ2NjKy5oPgkvKiBjYXRjaC1hbGwgZm9yIEdDQyA0LCA1LCBl
dGMuICovCisjZWxpZiBfX0dOVUNfXyA9PSAzCisjIGluY2x1ZGUgPGxpbnV4L2NvbXBpbGVyLWdj
YzMuaD4KKyNlbGlmIF9fR05VQ19fID09IDIKKyMgaW5jbHVkZSA8bGludXgvY29tcGlsZXItZ2Nj
Mi5oPgorI2Vsc2UKKyMgZXJyb3IgU29ycnksIHlvdXIgY29tcGlsZXIgaXMgdG9vIG9sZC9ub3Qg
cmVjb2duaXplZC4KICNlbmRpZgogCisvKiAKKyAqIEJlbG93IGFyZSB0aGUgZ2VuZXJpYyBjb21w
aWxlciByZWxhdGVkIG1hY3JvcyByZXF1aXJlZCBmb3Iga2VybmVsCisgKiBidWlsZC4gQWN0dWFs
IGNvbXBpbGVyL2NvbXBpbGVyIHZlcnNpb24gc3BlY2lmaWMgaW1wbGVtZW50YXRpb25zIAorICog
Y29tZSBmcm9tIHRoZSBhYm92ZSBoZWFkZXIgZmlsZXMKKyAqLwogI2RlZmluZSBsaWtlbHkoeCkJ
X19idWlsdGluX2V4cGVjdCghISh4KSwgMSkKICNkZWZpbmUgdW5saWtlbHkoeCkJX19idWlsdGlu
X2V4cGVjdCghISh4KSwgMCkKIApAQCAtMzMsMTAgKzMzLDggQEAKICAqIFVzYWdlIGlzOgogICog
CQlpbnQgX19kZXByZWNhdGVkIGZvbyh2b2lkKQogICovCi0jaWYgKCBfX0dOVUNfXyA9PSAzICYm
IF9fR05VQ19NSU5PUl9fID4gMCApIHx8IF9fR05VQ19fID4gMwotI2RlZmluZSBfX2RlcHJlY2F0
ZWQJX19hdHRyaWJ1dGVfXygoZGVwcmVjYXRlZCkpCi0jZWxzZQotI2RlZmluZSBfX2RlcHJlY2F0
ZWQKKyNpZm5kZWYgX19kZXByZWNhdGVkCisjIGRlZmluZSBfX2RlcHJlY2F0ZWQJCS8qIHVuaW1w
bGVtZW50ZWQgKi8KICNlbmRpZgogCiAvKgpAQCAtNTAsMTAgKzQ4LDggQEAKICAqIEluIHByaW9y
IHZlcnNpb25zIG9mIGdjYywgc3VjaCBmdW5jdGlvbnMgYW5kIGRhdGEgd291bGQgYmUgZW1pdHRl
ZCwgYnV0CiAgKiB3b3VsZCBiZSB3YXJuZWQgYWJvdXQgZXhjZXB0IHdpdGggYXR0cmlidXRlKCh1
bnVzZWQpKS4KICAqLwotI2lmIF9fR05VQ19fID09IDMgJiYgX19HTlVDX01JTk9SX18gPj0gMyB8
fCBfX0dOVUNfXyA+IDMKLSNkZWZpbmUgX19hdHRyaWJ1dGVfdXNlZF9fCV9fYXR0cmlidXRlX18o
KF9fdXNlZF9fKSkKLSNlbHNlCi0jZGVmaW5lIF9fYXR0cmlidXRlX3VzZWRfXwlfX2F0dHJpYnV0
ZV9fKChfX3VudXNlZF9fKSkKKyNpZm5kZWYgX19hdHRyaWJ1dGVfdXNlZF9fCisjIGRlZmluZSBf
X2F0dHJpYnV0ZV91c2VkX18JLyogdW5pbXBsZW1lbnRlZCAqLwogI2VuZGlmCiAKIC8qCkBAIC02
NSwxOSArNjEsMjEgQEAKICAqIGVsaW1pbmF0aW9uIGFuZCBsb29wIG9wdGltaXphdGlvbiBqdXN0
IGFzIGFuIGFyaXRobWV0aWMgb3BlcmF0b3IKICAqIHdvdWxkIGJlLgogICogWy4uLl0KLSAqIFRo
ZSBhdHRyaWJ1dGUgYHB1cmUnIGlzIG5vdCBpbXBsZW1lbnRlZCBpbiBHQ0MgdmVyc2lvbnMgZWFy
bGllcgotICogdGhhbiAyLjk2LgogICovCi0jaWYgKF9fR05VQ19fID09IDIgJiYgX19HTlVDX01J
Tk9SX18gPj0gOTYpIHx8IF9fR05VQ19fID4gMgotI2RlZmluZSBfX2F0dHJpYnV0ZV9wdXJlX18J
X19hdHRyaWJ1dGVfXygocHVyZSkpCi0jZWxzZQotI2RlZmluZSBfX2F0dHJpYnV0ZV9wdXJlX18J
LyogdW5pbXBsZW1lbnRlZCAqLworI2lmbmRlZiBfX2F0dHJpYnV0ZV9wdXJlX18KKyMgZGVmaW5l
IF9fYXR0cmlidXRlX3B1cmVfXwkvKiB1bmltcGxlbWVudGVkICovCisjZW5kaWYKKworLyogT3B0
aW1pemF0aW9uIGJhcnJpZXIgKi8KKyNpZm5kZWYgYmFycmllcgorIyBkZWZpbmUgYmFycmllcigp
IF9fbWVtb3J5X2JhcnJpZXIoKTsKICNlbmRpZgogCi0vKiBUaGlzIG1hY3JvIG9iZnVzY2F0ZXMg
YXJpdGhtZXRpYyBvbiBhIHZhcmlhYmxlIGFkZHJlc3Mgc28gdGhhdCBnY2MKLSAgIHNob3VsZG4n
dCByZWNvZ25pemUgdGhlIG9yaWdpbmFsIHZhciwgYW5kIG1ha2UgYXNzdW1wdGlvbnMgYWJvdXQg
aXQgKi8KLSNkZWZpbmUgUkVMT0NfSElERShwdHIsIG9mZikJCQkJCVwKKyNpZm5kZWYgUkVMT0Nf
SElERQorIyBkZWZpbmUgUkVMT0NfSElERShwdHIsIG9mZikJCQkJCVwKICAgKHsgdW5zaWduZWQg
bG9uZyBfX3B0cjsJCQkJCVwKLSAgICBfX2FzbV9fICgiIiA6ICI9ZyIoX19wdHIpIDogIjAiKHB0
cikpOwkJXAorICAgICBfX3B0ciA9ICh1bnNpZ25lZCBsb25nKSAocHRyKTsJCQkJXAogICAgICh0
eXBlb2YocHRyKSkgKF9fcHRyICsgKG9mZikpOyB9KQorI2VuZGlmCisKICNlbmRpZiAvKiBfX0xJ
TlVYX0NPTVBJTEVSX0ggKi8KZGlmZiAtTnJ1IGxpbnV4L2luY2x1ZGUvbGludXgva2VybmVsLmgg
bGludXgtL2luY2x1ZGUvbGludXgva2VybmVsLmgKLS0tIGxpbnV4L2luY2x1ZGUvbGludXgva2Vy
bmVsLmgJTW9uIFNlcCAgOCAxMTo1MTowMSAyMDAzCisrKyBsaW51eC0vaW5jbHVkZS9saW51eC9r
ZXJuZWwuaAlUdWUgU2VwICA5IDIxOjI2OjAzIDIwMDMKQEAgLTE1LDEwICsxNSw2IEBACiAjaW5j
bHVkZSA8YXNtL2J5dGVvcmRlci5oPgogI2luY2x1ZGUgPGFzbS9idWcuaD4KIAotLyogT3B0aW1p
emF0aW9uIGJhcnJpZXIgKi8KLS8qIFRoZSAidm9sYXRpbGUiIGlzIGR1ZSB0byBnY2MgYnVncyAq
LwotI2RlZmluZSBiYXJyaWVyKCkgX19hc21fXyBfX3ZvbGF0aWxlX18oIiI6IDogOiJtZW1vcnki
KQotCiAjZGVmaW5lIElOVF9NQVgJCSgoaW50KSh+MFU+PjEpKQogI2RlZmluZSBJTlRfTUlOCQko
LUlOVF9NQVggLSAxKQogI2RlZmluZSBVSU5UX01BWAkofjBVKQo=

------_=_NextPart_001_01C37757.05C8CFB8
Content-Type: application/octet-stream;
	name="intel.diff"
Content-Transfer-Encoding: base64
Content-Description: intel.diff
Content-Disposition: attachment;
	filename="intel.diff"

ZGlmZiAtTnJ1IGxpbnV4L2luY2x1ZGUvbGludXgvY29tcGlsZXItaW50ZWwuaCBsaW51eC0vaW5j
bHVkZS9saW51eC9jb21waWxlci1pbnRlbC5oCi0tLSBsaW51eC9pbmNsdWRlL2xpbnV4L2NvbXBp
bGVyLWludGVsLmgJV2VkIERlYyAzMSAxNjowMDowMCAxOTY5CisrKyBsaW51eC0vaW5jbHVkZS9s
aW51eC9jb21waWxlci1pbnRlbC5oCVR1ZSBTZXAgIDkgMjE6MzQ6MTkgMjAwMwpAQCAtMCwwICsx
LDIxIEBACisvKiBOZXZlciBpbmNsdWRlIHRoaXMgZmlsZSBkaXJlY3RseS4gIEluY2x1ZGUgPGxp
bnV4L2NvbXBpbGVyLmg+IGluc3RlYWQuICAqLworCisjaWZkZWYgX19FQ0MKKworLyogU29tZSBj
b21waWxlciBzcGVjaWZpYyBkZWZpbml0aW9ucyBhcmUgb3ZlcndyaXR0ZW4gaGVyZQorICogZm9y
IEludGVsIEVDQyBjb21waWxlciAKKyAqLworCisjaW5jbHVkZSA8YXNtL2ludHJpbnNpY3MuaD4K
KworI3VuZGVmIGJhcnJpZXIKKyN1bmRlZiBSRUxPQ19ISURFCisKKyNkZWZpbmUgYmFycmllcigp
IF9fbWVtb3J5X2JhcnJpZXIoKQorCisjZGVmaW5lIFJFTE9DX0hJREUocHRyLCBvZmYpCQkJCQlc
CisgICh7IHVuc2lnbmVkIGxvbmcgX19wdHI7CQkJCQlcCisgICAgIF9fcHRyID0gKHVuc2lnbmVk
IGxvbmcpIChwdHIpOwkJCQlcCisgICAgKHR5cGVvZihwdHIpKSAoX19wdHIgKyAob2ZmKSk7IH0p
CisKKyNlbmRpZgpkaWZmIC1OcnUgbGludXgvaW5jbHVkZS9saW51eC9jb21waWxlci5oIGxpbnV4
LS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgKLS0tIGxpbnV4L2luY2x1ZGUvbGludXgvY29tcGls
ZXIuaAlUdWUgU2VwICA5IDIxOjM0OjExIDIwMDMKKysrIGxpbnV4LS9pbmNsdWRlL2xpbnV4L2Nv
bXBpbGVyLmgJVHVlIFNlcCAgOSAyMTozNTowOCAyMDAzCkBAIC0xOSw2ICsxOSwxMyBAQAogIyBl
cnJvciBTb3JyeSwgeW91ciBjb21waWxlciBpcyB0b28gb2xkL25vdCByZWNvZ25pemVkLgogI2Vu
ZGlmCiAKKy8qIEludGVsIGNvbXBpbGVyIGRlZmluZXMgX19HTlVDX18uIFNvIHdlIHdpbGwgb3Zl
cndyaXRlIGltcGxlbWVudGF0aW9ucworICogY29taW5nIGZyb20gYWJvdmUgaGVhZGVyIGZpbGVz
IGhlcmUKKyAqLworI2lmZGVmIF9fSU5URUxfQ09NUElMRVIKKyMgaW5jbHVkZSA8bGludXgvY29t
cGlsZXItaW50ZWwuaD4KKyNlbmRpZgorCiAvKiAKICAqIEJlbG93IGFyZSB0aGUgZ2VuZXJpYyBj
b21waWxlciByZWxhdGVkIG1hY3JvcyByZXF1aXJlZCBmb3Iga2VybmVsCiAgKiBidWlsZC4gQWN0
dWFsIGNvbXBpbGVyL2NvbXBpbGVyIHZlcnNpb24gc3BlY2lmaWMgaW1wbGVtZW50YXRpb25zIAo=

------_=_NextPart_001_01C37757.05C8CFB8--
