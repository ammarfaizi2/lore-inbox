Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUB0XXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbUB0XU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:20:26 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:51603 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263205AbUB0XSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:18:52 -0500
Subject: [patch] u64 casts
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1077915522.2255.28.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Feb 2004 15:58:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casts are considered harmful, because they bypass
type checking, but how do you print a u64 value?
You cast it to "unsigned long long" like this:

  printk("%llu\n", (unsigned long long)foo);

Well, this is silly and ugly. As x86-64 has shown,
even a 64-bit port can use "long long" for 64-bit
values. This patch changes all other 64-bit ports.
It now becomes possible to avoid adding new casts
all over the place; existing ones may be removed
if so desired.

diff -Naurd old/include/asm-alpha/types.h new/include/asm-alpha/types.h
--- old/include/asm-alpha/types.h	2004-02-21 03:25:04.000000000 -0500
+++ new/include/asm-alpha/types.h	2004-02-27 15:37:40.000000000 -0500
@@ -27,8 +27,8 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
 
 #endif /* __ASSEMBLY__ */
 
@@ -50,8 +50,8 @@
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
+++ new/include/asm-ia64/types.h	2004-02-27 15:40:14.000000000 -0500
@@ -41,8 +41,8 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
diff -Naurd old/include/asm-mips/types.h new/include/asm-mips/types.h
--- old/include/asm-mips/types.h	2004-02-21 03:19:29.000000000 -0500
+++ new/include/asm-mips/types.h	2004-02-27 15:39:51.000000000 -0500
@@ -34,20 +34,11 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if (_MIPS_SZLONG == 64)
-
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
-
-#else
-
 #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
 
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -68,20 +59,11 @@
 typedef __signed int s32;
 typedef unsigned int u32;
 
-#if (_MIPS_SZLONG == 64)
-
-typedef __signed__ long s64;
-typedef unsigned long u64;
-
-#else
-
 #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __signed__ long long s64;
 typedef unsigned long long u64;
 #endif
 
-#endif
-
 #if (defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR)) \
     || defined(CONFIG_MIPS64)
 typedef u64 dma_addr_t;
diff -Naurd old/include/asm-ppc64/types.h new/include/asm-ppc64/types.h
--- old/include/asm-ppc64/types.h	2004-02-21 03:21:11.000000000 -0500
+++ new/include/asm-ppc64/types.h	2004-02-27 15:41:06.000000000 -0500
@@ -32,8 +32,8 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
 
 typedef struct {
 	__u32 u[4];
@@ -58,8 +58,8 @@
 typedef signed int s32;
 typedef unsigned int u32;
 
-typedef signed long s64;
-typedef unsigned long u64;
+typedef signed long long s64;
+typedef unsigned long long u64;
 
 typedef __vector128 vector128;
 
diff -Naurd old/include/asm-s390/types.h new/include/asm-s390/types.h
--- old/include/asm-s390/types.h	2004-02-21 03:22:57.000000000 -0500
+++ new/include/asm-s390/types.h	2004-02-27 15:43:42.000000000 -0500
@@ -27,15 +27,10 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#ifndef __s390x__
 #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
-#else /* __s390x__ */
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
-#endif
 
 /* A address type so that arithmetic can be done on it & it can be upgraded to
    64 bit when necessary 
@@ -67,13 +62,8 @@
 typedef signed int s32;
 typedef unsigned int u32;
 
-#ifndef __s390x__
 typedef signed long long s64;
 typedef unsigned long long u64;
-#else /* __s390x__ */
-typedef signed long s64;
-typedef unsigned  long u64;
-#endif /* __s390x__ */
 
 typedef u32 dma_addr_t;
 
diff -Naurd old/include/asm-sparc64/types.h new/include/asm-sparc64/types.h
--- old/include/asm-sparc64/types.h	2004-02-21 03:28:23.000000000 -0500
+++ new/include/asm-sparc64/types.h	2004-02-27 15:42:19.000000000 -0500
@@ -28,8 +28,8 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
 
 #endif /* __ASSEMBLY__ */
 
@@ -48,8 +48,8 @@
 typedef __signed__ int s32;
 typedef unsigned int u32;
 
-typedef __signed__ long s64;
-typedef unsigned long u64;
+typedef __signed__ long long s64;
+typedef unsigned long long u64;
 
 /* Dma addresses come in generic and 64-bit flavours.  */
 



