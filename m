Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUB1RGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 12:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUB1RGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 12:06:19 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:41176 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261886AbUB1RGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 12:06:12 -0500
Subject: [patch] new version, u64 cast avoidance
From: Albert Cahalan <albert@users.sf.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: davem@redhat.com, davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <20040228104252.GG31589@devserv.devel.redhat.com>
References: <1077915522.2255.28.camel@cube>
	 <16447.56941.774257.925722@napali.hpl.hp.com>
	 <1077920213.2233.44.camel@cube>
	 <20040228104252.GG31589@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077979564.2233.70.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Feb 2004 09:46:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 05:42, Jakub Jelinek wrote:
> On Fri, Feb 27, 2004 at 05:16:53PM -0500, Albert Cahalan wrote:

>> Supposing that this is the case, you may get warnings.
> 
> It wouldn't be just about warnings if somebody uses current kernel
> headers for /usr/include/linux and /usr/include/asm.
> Think about C++ name mangling, there it matters a lot of
> a type is long long or just long, although they are the same size.

That's disgusting.

> So if you want to change that, I'd suggest to
> #ifdef __KERNEL__
> typedef unsigned long long __u64;
> #else
> typedef unsigned long __u64; /* Provided it has been defined that way before */
> #endif

OK, got it. For the changelog:

If the u64 type is "unsigned long" on some platforms
and "unsigned long long" on others, a cast is often
required to avoid warnings. Type safety goes away
when you do that; even a pointer is accepted. Thus
the u64 type should be "unsigned long long" on all
platforms. Now this:
  printk("%llu\n", (unsigned long long)some_u64_value);
can become this:
  printk("%llu\n", some_u64_value);

 asm-alpha/types.h   |   14 ++++++++++++--
 asm-ia64/types.h    |   10 ++++++++++
 asm-mips/types.h    |   25 ++++++++++++-------------
 asm-ppc64/types.h   |   14 ++++++++++++--
 asm-s390/types.h    |   17 +++++++++--------
 asm-sparc64/types.h |   14 ++++++++++++--
 6 files changed, 67 insertions(+), 27 deletions(-)

diff -Naurd old/include/asm-alpha/types.h new/include/asm-alpha/types.h
--- old/include/asm-alpha/types.h	2004-02-21 03:25:04.000000000 -0500
+++ new/include/asm-alpha/types.h	2004-02-28 09:13:04.000000000 -0500
@@ -27,8 +27,18 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
+/*
+ * We want "long long" in the kernel to reduce the need for casts,
+ * but foul user-space C++ code might rely on this being "long".
+ * (name mangling leads to a purely user-space ABI problem)
+ */
+#ifdef __KERNEL__
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#else
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
+#endif
 
 #endif /* __ASSEMBLY__ */
 
@@ -50,8 +60,8 @@
 typedef signed int s32;
 typedef unsigned int u32;
 
-typedef signed long s64;
-typedef unsigned long u64;
+typedef signed long long s64;
+typedef unsigned long long u64;
 
 typedef u64 dma_addr_t;
 typedef u64 dma64_addr_t;
diff -Naurd old/include/asm-ia64/types.h new/include/asm-ia64/types.h
--- old/include/asm-ia64/types.h	2004-02-21 03:20:17.000000000 -0500
+++ new/include/asm-ia64/types.h	2004-02-28 09:14:49.000000000 -0500
@@ -41,8 +41,18 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
+/*
+ * We want "long long" in the kernel to reduce the need for casts,
+ * but foul user-space C++ code might rely on this being "long".
+ * (name mangling leads to a purely user-space ABI problem)
+ */
+#ifdef __KERNEL__
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#else
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
+#endif
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
diff -Naurd old/include/asm-mips/types.h new/include/asm-mips/types.h
--- old/include/asm-mips/types.h	2004-02-21 03:19:29.000000000 -0500
+++ new/include/asm-mips/types.h	2004-02-28 09:23:05.000000000 -0500
@@ -36,8 +36,18 @@
 
 #if (_MIPS_SZLONG == 64)
 
+/*
+ * We want "long long" in the kernel to reduce the need for casts,
+ * but foul user-space C++ code might rely on this being "long".
+ * (name mangling leads to a purely user-space ABI problem)
+ */
+#ifdef __KERNEL__
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#else
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
+#endif
 
 #else
 
@@ -68,19 +78,8 @@
 typedef __signed int s32;
 typedef unsigned int u32;
 
-#if (_MIPS_SZLONG == 64)
-
-typedef __signed__ long s64;
-typedef unsigned long u64;
-
-#else
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long s64;
-typedef unsigned long long u64;
-#endif
-
-#endif
+typedef __s64 s64;
+typedef __u64 u64;
 
 #if (defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR)) \
     || defined(CONFIG_MIPS64)
diff -Naurd old/include/asm-ppc64/types.h new/include/asm-ppc64/types.h
--- old/include/asm-ppc64/types.h	2004-02-21 03:21:11.000000000 -0500
+++ new/include/asm-ppc64/types.h	2004-02-28 09:25:01.000000000 -0500
@@ -32,8 +32,18 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
+/*
+ * We want "long long" in the kernel to reduce the need for casts,
+ * but foul user-space C++ code might rely on this being "long".
+ * (name mangling leads to a purely user-space ABI problem)
+ */
+#ifdef __KERNEL__
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#else
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
+#endif
 
 typedef struct {
 	__u32 u[4];
@@ -58,8 +68,8 @@
 typedef signed int s32;
 typedef unsigned int u32;
 
-typedef signed long s64;
-typedef unsigned long u64;
+typedef __s64 s64;
+typedef __u64 u64;
 
 typedef __vector128 vector128;
 
diff -Naurd old/include/asm-s390/types.h new/include/asm-s390/types.h
--- old/include/asm-s390/types.h	2004-02-21 03:22:57.000000000 -0500
+++ new/include/asm-s390/types.h	2004-02-28 09:31:14.000000000 -0500
@@ -27,7 +27,13 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#ifndef __s390x__
+
+/*
+ * We want "long long" in the kernel to reduce the need for casts,
+ * but foul 64-bit user-space C++ code might rely on this being "long". 
+ * (name mangling leads to a purely user-space ABI problem) 
+ */
+#if defined(__KERNEL__) || !defined(__s390x__)
 #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
@@ -67,13 +73,8 @@
 typedef signed int s32;
 typedef unsigned int u32;
 
-#ifndef __s390x__
-typedef signed long long s64;
-typedef unsigned long long u64;
-#else /* __s390x__ */
-typedef signed long s64;
-typedef unsigned  long u64;
-#endif /* __s390x__ */
+typedef __s64 s64;
+typedef __u64 u64;
 
 typedef u32 dma_addr_t;
 
diff -Naurd old/include/asm-sparc64/types.h new/include/asm-sparc64/types.h
--- old/include/asm-sparc64/types.h	2004-02-21 03:28:23.000000000 -0500
+++ new/include/asm-sparc64/types.h	2004-02-28 09:29:53.000000000 -0500
@@ -28,8 +28,18 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
+/*
+ * We want "long long" in the kernel to reduce the need for casts,
+ * but foul user-space C++ code might rely on this being "long".
+ * (name mangling leads to a purely user-space ABI problem)
+ */
+#ifdef __KERNEL__
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#else
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
+#endif
 
 #endif /* __ASSEMBLY__ */
 
@@ -48,8 +58,8 @@
 typedef __signed__ int s32;
 typedef unsigned int u32;
 
-typedef __signed__ long s64;
-typedef unsigned long u64;
+typedef __s64 s64;
+typedef __u64 u64;
 
 /* Dma addresses come in generic and 64-bit flavours.  */
 



