Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTIIXoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbTIIXoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:44:39 -0400
Received: from palrel10.hp.com ([156.153.255.245]:55492 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265091AbTIIXoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:44:32 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16222.26077.28147.350570@napali.hpl.hp.com>
Date: Tue, 9 Sep 2003 16:44:29 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@HPL.HP.COM, Jes Sorensen <jes@wildopensource.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [Patch] asm workarounds in generic header files
In-Reply-To: <Pine.LNX.4.44.0309091329570.30594-100000@home.osdl.org>
References: <16222.14136.21774.211178@napali.hpl.hp.com>
	<Pine.LNX.4.44.0309091329570.30594-100000@home.osdl.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@HPL.HP.COM
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 9 Sep 2003 13:33:51 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> said:

  Linus> I might agree, but "compiler.h" is getting increasingly
  Linus> messy, and this just makes it worse (and sets the stage for
  Linus> making it even worse in the future).

  Linus> Is somebody willing to split up compiler.h into a
  Linus> per-compiler file (and yes, I think "gcc-2.95" is a different
  Linus> compiler from "gcc-3.2" in this case, since that is what most
  Linus> of the compiler.h #ifdef's are all about).

How about something like this?
(the patch has Works-for-Me status...)

	--david

===== include/linux/compiler.h 1.18 vs edited =====
--- 1.18/include/linux/compiler.h	Thu Aug 14 18:17:28 2003
+++ edited/include/linux/compiler.h	Tue Sep  9 16:28:07 2003
@@ -2,26 +2,21 @@
 #define __LINUX_COMPILER_H
 
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
 
-#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
-#define inline		__inline__ __attribute__((always_inline))
-#define __inline__	__inline__ __attribute__((always_inline))
-#define __inline	__inline__ __attribute__((always_inline))
-#endif
-
-/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
-   a mechanism by which the user can annotate likely branch directions and
-   expect the blocks to be reordered appropriately.  Define __builtin_expect
-   to nothing for earlier compilers.  */
-
-#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
-#define __builtin_expect(x, expected_value) (x)
+#if __GNUC__ > 3
+# include <linux/compiler-gcc+.h>	/* catch-all for GCC 4, 5, etc. */
+#elif __GNUC__ == 3
+# include <linux/compiler-gcc3.h>
+#elif __GNUC__ == 2
+# include <linux/compiler-gcc2.h>
+#else
+# error Sorry, your compiler is too old/not recognized.
 #endif
 
 #define likely(x)	__builtin_expect(!!(x), 1)
@@ -33,10 +28,8 @@
  * Usage is:
  * 		int __deprecated foo(void)
  */
-#if ( __GNUC__ == 3 && __GNUC_MINOR__ > 0 ) || __GNUC__ > 3
-#define __deprecated	__attribute__((deprecated))
-#else
-#define __deprecated
+#ifndef __deprecated
+# define __deprecated		/* unimplemented */
 #endif
 
 /*
@@ -50,10 +43,8 @@
  * In prior versions of gcc, such functions and data would be emitted, but
  * would be warned about except with attribute((unused)).
  */
-#if __GNUC__ == 3 && __GNUC_MINOR__ >= 3 || __GNUC__ > 3
-#define __attribute_used__	__attribute__((__used__))
-#else
-#define __attribute_used__	__attribute__((__unused__))
+#ifndef __attribute_used__
+# define __attribute_used__	/* unimplemented */
 #endif
 
 /*
@@ -65,19 +56,9 @@
  * elimination and loop optimization just as an arithmetic operator
  * would be.
  * [...]
- * The attribute `pure' is not implemented in GCC versions earlier
- * than 2.96.
  */
-#if (__GNUC__ == 2 && __GNUC_MINOR__ >= 96) || __GNUC__ > 2
-#define __attribute_pure__	__attribute__((pure))
-#else
-#define __attribute_pure__	/* unimplemented */
+#ifndef __attribute_pure__
+# define __attribute_pure__	/* unimplemented */
 #endif
 
-/* This macro obfuscates arithmetic on a variable address so that gcc
-   shouldn't recognize the original var, and make assumptions about it */
-#define RELOC_HIDE(ptr, off)					\
-  ({ unsigned long __ptr;					\
-    __asm__ ("" : "=g"(__ptr) : "0"(ptr));		\
-    (typeof(ptr)) (__ptr + (off)); })
 #endif /* __LINUX_COMPILER_H */
--- /dev/null	2003-03-27 10:58:26.000000000 -0800
+++ include/linux/compiler-gcc+.h	2003-09-09 16:39:42.000000000 -0700
@@ -0,0 +1,13 @@
+/* Never include this file directly.  Include <linux/compiler.h> instead.  */
+
+/*
+ * These definitions are for Ueber-GCC: always newer than the latest
+ * version and hence sporting everything plus a kitchen-sink.
+ */
+
+#define inline			__inline__ __attribute__((always_inline))
+#define __inline__		__inline__ __attribute__((always_inline))
+#define __inline		__inline__ __attribute__((always_inline))
+#define __deprecated		__attribute__((deprecated))
+#define __attribute_used__	__attribute__((__used__))
+#define __attribute_pure__	__attribute__((pure))
--- /dev/null	2003-03-27 10:58:26.000000000 -0800
+++ include/linux/compiler-gcc3.h	2003-09-09 16:40:11.000000000 -0700
@@ -0,0 +1,21 @@
+/* Never include this file directly.  Include <linux/compiler.h> instead.  */
+
+/* These definitions are for GCC v3.x.  */
+
+#if __GNUC_MINOR__ >= 1
+# define inline		__inline__ __attribute__((always_inline))
+# define __inline__	__inline__ __attribute__((always_inline))
+# define __inline	__inline__ __attribute__((always_inline))
+#endif
+
+#if __GNUC_MINOR__ > 0
+# define __deprecated	__attribute__((deprecated))
+#endif
+
+#if __GNUC_MINOR__ >= 3
+# define __attribute_used__	__attribute__((__used__))
+#else
+# define __attribute_used__	__attribute__((__unused__))
+#endif
+
+#define __attribute_pure__	__attribute__((pure))
--- /dev/null	2003-03-27 10:58:26.000000000 -0800
+++ include/linux/compiler-gcc2.h	2003-09-09 16:40:06.000000000 -0700
@@ -0,0 +1,22 @@
+/* Never include this file directly.  Include <linux/compiler.h> instead.  */
+
+/* These definitions are for GCC v2.x.  */
+
+/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
+   a mechanism by which the user can annotate likely branch directions and
+   expect the blocks to be reordered appropriately.  Define __builtin_expect
+   to nothing for earlier compilers.  */
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
+#if __GNUC_MINOR__ >= 96
+# define __attribute_pure__	__attribute__((pure))
+#endif
