Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265933AbTGCK35 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbTGCK35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:29:57 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:38784 "HELO
	develer.com") by vger.kernel.org with SMTP id S265933AbTGCK3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:29:06 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix do_div() for all architectures
Date: Thu, 3 Jul 2003 12:43:02 +0200
User-Agent: KMail/1.5.9
Cc: Andrea Arcangeli <andrea@suse.de>, Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307020914210.4380-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307020914210.4380-100000@home.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307031243.02940.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 18:16, Linus Torvalds wrote:

 > Don't do this as a in-line thing. Do it as an out-of-line function,
 > something like
 >
 > 	#define do_div64(n,base) ({			\
 > 		u32 __rem;				\
 > 		n = lib_do_div64(n, base, &__rem);	\
 > 		__rem; })
 >
 > instead. Add the out-of-line thing to lib/lib.a or something.

Good point, however I feel the fast path for n <= 32bit
should still be left inline for best performance.

Full patch against 2.5.74 follows. I will provide a 2.4
backport after it has received some testing in 2.5.

I've used C99 types instead of Linux specific types because
I somewhat prefer them. Is using C99 types in the kernel ok?

Both ppc and sh were already providing an assembly
optimized __div64_32(). I called my function the same, so
it will automatically override mine in lib.a.

I've only tested extensively on m68knommu (uClinux) and made
sure generated code is reasonably short. Should be ok also on
parisc, since it's the same algorithm they were using before.

  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

-----------------------------------------------------------------

 - add generic C implementations of the do_div() for 32bit and 64bit
   archs in asm-generic/div64.h;

 - add generic library support function __div64_32() to handle the
   full 64/32 case on 32bit archs;

 - kill multiple copies of generic do_div() in architecture
   specific subdirs. Most copies were either buggy or not doing
   what they were supposed to do;

 - ensure all surviving instances of do_div() have their parameters
   correctly parenthesized to avoid funny side-effects;

 include/asm-alpha/div64.h     |   15 -----------
 include/asm-arm26/div64.h     |   15 -----------
 include/asm-cris/div64.h      |   17 ------------
 include/asm-generic/div64.h   |   53 ++++++++++++++++++++++++++++++++++++++++
 include/asm-h8300/div64.h     |   14 ----------
 include/asm-ia64/div64.h      |   21 ----------------
 include/asm-m68k/div64.h      |    9 ------
 include/asm-m68knommu/div64.h |   14 ----------
 include/asm-mips64/div64.h    |   19 --------------
 include/asm-parisc/div64.h    |   55 ------------------------------------------
 include/asm-ppc/div64.h       |   24 ------------------
 include/asm-ppc64/div64.h     |   19 --------------
 include/asm-s390/div64.h      |    8 ------
 include/asm-sh/div64.h        |   21 ----------------
 include/asm-sparc/div64.h     |   12 ---------
 include/asm-sparc64/div64.h   |   15 -----------
 include/asm-v850/div64.h      |   12 ---------
 include/asm-x86_64/div64.h    |   15 -----------
 lib/Makefile                  |    2 -
 lib/div64.c                   |   45 ++++++++++++++++++++++++++++++++++
 20 files changed, 115 insertions(+), 290 deletions(-)

diff -Nru linux-2.5.74-uc0/include/asm-alpha/div64.h linux-2.5.74-uc0-develer/include/asm-alpha/div64.h
--- linux-2.5.74-uc0/include/asm-alpha/div64.h	2003-07-02 22:54:43.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-alpha/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,14 +1 @@
-#ifndef __ALPHA_DIV64
-#define __ALPHA_DIV64
-
-/*
- * Hey, we're already 64-bit, no
- * need to play games..
- */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) (n)) % (unsigned) (base); \
-	(n) = ((unsigned long) (n)) / (unsigned) (base); \
-	__res; })
-
-#endif
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-arm26/div64.h linux-2.5.74-uc0-develer/include/asm-arm26/div64.h
--- linux-2.5.74-uc0/include/asm-arm26/div64.h	2003-07-02 22:42:11.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-arm26/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,14 +1 @@
-#ifndef __ASM_ARM_DIV64
-#define __ASM_ARM_DIV64
-
-/* We're not 64-bit, but... */
-#define do_div(n,base)						\
-({								\
-	int __res;						\
-	__res = ((unsigned long)n) % (unsigned int)base;	\
-	n = ((unsigned long)n) / (unsigned int)base;		\
-	__res;							\
-})
-
-#endif
-
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-cris/div64.h linux-2.5.74-uc0-develer/include/asm-cris/div64.h
--- linux-2.5.74-uc0/include/asm-cris/div64.h	2003-07-02 22:42:06.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-cris/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,16 +1 @@
-#ifndef __ASM_CRIS_DIV64
-#define __ASM_CRIS_DIV64
-
-/* copy from asm-arm */
-
-/* We're not 64-bit, but... */
-#define do_div(n,base)						\
-({								\
-	int __res;						\
-	__res = ((unsigned long)n) % (unsigned int)base;	\
-	n = ((unsigned long)n) / (unsigned int)base;		\
-	__res;							\
-})
-
-#endif
-
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-generic/div64.h linux-2.5.74-uc0-develer/include/asm-generic/div64.h
--- linux-2.5.74-uc0/include/asm-generic/div64.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.74-uc0-develer/include/asm-generic/div64.h	2003-07-03 09:55:04.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_GENERIC_DIV64_H
+#define _ASM_GENERIC_DIV64_H
+/*
+ * Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>
+ * Based on former asm-ppc/div64.h and asm-m68knommu/div64.h
+ *
+ * The semantics of do_div() are:
+ *
+ * uint32_t do_div(uint64_t *n, uint32_t base)
+ * {
+ * 	uint32_t remainder = *n % base;
+ * 	*n = *n / base;
+ * 	return remainder;
+ * }
+ *
+ * NOTE: macro parameter n is evaluated multiple times,
+ *       beware of side effects!
+ */
+
+#include <linux/types.h>
+
+#if BITS_PER_LONG == 64
+
+# define do_div(n,base) ({					\
+	uint32_t __base = (base);				\
+	uint32_t __rem;						\
+	__rem = ((uint64_t)(n)) % __base;			\
+	(n) = ((uint64_t)(n)) / __base;				\
+	__rem;							\
+ })
+
+#elif BITS_PER_LONG == 32
+
+extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
+
+# define do_div(n,base) ({				\
+	uint32_t __base = (base);			\
+	uint32_t __rem;					\
+	if (((n) >> 32) == 0) {				\
+		__rem = (uint32_t)(n) % __base;		\
+		(n) = (uint32_t)(n) / __base;		\
+	} else 						\
+		__rem = __div64_32(&(n), __base);	\
+	__rem;						\
+ })
+
+#else /* BITS_PER_LONG == ?? */
+
+# error do_div() does not yet support the C64
+
+#endif /* BITS_PER_LONG */
+
+#endif /* _ASM_GENERIC_DIV64_H */
diff -Nru linux-2.5.74-uc0/include/asm-h8300/div64.h linux-2.5.74-uc0-develer/include/asm-h8300/div64.h
--- linux-2.5.74-uc0/include/asm-h8300/div64.h	2003-07-02 22:39:25.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-h8300/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,13 +1 @@
-#ifndef H8300_DIV64_H
-#define H8300_DIV64_H
-
-/* n = n / base; return rem; */
-
-#define do_div(n,base) ({					\
-	int __res;						\
-	__res = ((unsigned long) n) % (unsigned) base;		\
-	n = ((unsigned long) n) / (unsigned) base;		\
-	__res;							\
-})
-
-#endif /* _H8300_DIV64_H */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-ia64/div64.h linux-2.5.74-uc0-develer/include/asm-ia64/div64.h
--- linux-2.5.74-uc0/include/asm-ia64/div64.h	2003-07-02 22:58:14.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-ia64/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,20 +1 @@
-#ifndef _ASM_IA64_DIV64_H
-#define _ASM_IA64_DIV64_H
-
-/*
- * Copyright (C) 1999 Hewlett-Packard Co
- * Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
- *
- * vsprintf uses this to divide a 64-bit integer N by a small integer BASE.
- * This is incredibly hard on IA-64...
- */
-
-#define do_div(n,base)						\
-({								\
-	int _res;						\
-	_res = ((unsigned long) (n)) % (unsigned) (base);	\
-	(n) = ((unsigned long) (n)) / (unsigned) (base);	\
-	_res;							\
-})
-
-#endif /* _ASM_IA64_DIV64_H */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-m68k/div64.h linux-2.5.74-uc0-develer/include/asm-m68k/div64.h
--- linux-2.5.74-uc0/include/asm-m68k/div64.h	2003-07-02 22:55:53.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-m68k/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -3,7 +3,6 @@
 
 /* n = n / base; return rem; */
 
-#if 1
 #define do_div(n, base) ({					\
 	union {							\
 		unsigned long n32[2];				\
@@ -23,13 +22,5 @@
 	(n) = __n.n64;						\
 	__rem;							\
 })
-#else
-#define do_div(n,base) ({					\
-	int __res;						\
-	__res = ((unsigned long) n) % (unsigned) base;		\
-	n = ((unsigned long) n) / (unsigned) base;		\
-	__res;							\
-})
-#endif
 
 #endif /* _M68K_DIV64_H */
diff -Nru linux-2.5.74-uc0/include/asm-m68knommu/div64.h linux-2.5.74-uc0-develer/include/asm-m68knommu/div64.h
--- linux-2.5.74-uc0/include/asm-m68knommu/div64.h	2003-07-03 10:40:35.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-m68knommu/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,13 +1 @@
-#ifndef _M68KNOMMU_DIV64_H
-#define _M68KNOMMU_DIV64_H
-
-/* n = n / base; return rem; */
-
-#define do_div(n,base) ({					\
-	int __res;						\
-	__res = ((unsigned long) n) % (unsigned) base;		\
-	n = ((unsigned long) n) / (unsigned) base;		\
-	__res;							\
-})
-
-#endif /* _M68K_DIV64_H */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-mips64/div64.h linux-2.5.74-uc0-develer/include/asm-mips64/div64.h
--- linux-2.5.74-uc0/include/asm-mips64/div64.h	2003-07-02 22:47:26.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-mips64/div64.h	2003-07-03 09:39:28.000000000 +0200
@@ -27,23 +27,6 @@
 	(res) = __quot; \
 	__mod; })
 
-/*
- * Hey, we're already 64-bit, no
- * need to play games..
- */
-#define do_div(n, base) ({ \
-	unsigned long __quot; \
-	unsigned int __mod; \
-	unsigned long __div; \
-	unsigned int __base; \
-	\
-	__div = (n); \
-	__base = (base); \
-	\
-	__mod = __div % __base; \
-	__quot = __div / __base; \
-	\
-	(n) = __quot; \
-	__mod; })
+#include <asm-generic.h>
 
 #endif /* _ASM_DIV64_H */
diff -Nru linux-2.5.74-uc0/include/asm-parisc/div64.h linux-2.5.74-uc0-develer/include/asm-parisc/div64.h
--- linux-2.5.74-uc0/include/asm-parisc/div64.h	2003-07-02 22:48:40.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-parisc/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,54 +1 @@
-#ifndef __ASM_PARISC_DIV64
-#define __ASM_PARISC_DIV64
-
-#ifdef __LP64__
-
-/*
- * Copyright (C) 1999 Hewlett-Packard Co
- * Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
- *
- * vsprintf uses this to divide a 64-bit integer N by a small integer BASE.
- * This is incredibly hard on IA-64 and HPPA
- */
-
-#define do_div(n,base)						\
-({								\
-	int _res;						\
-	_res = ((unsigned long) (n)) % (unsigned) (base);	\
-	(n) = ((unsigned long) (n)) / (unsigned) (base);	\
-	_res;							\
-})
-
-#else
-/*
- * unsigned long long division.  Yuck Yuck!  What is Linux coming to?
- * This is 100% disgusting
- */
-#define do_div(n,base)							\
-({									\
-	unsigned long __low, __low2, __high, __rem;			\
-	__low  = (n) & 0xffffffff;					\
-	__high = (n) >> 32;						\
-	if (__high) {							\
-		__rem   = __high % (unsigned long)base;			\
-		__high  = __high / (unsigned long)base;			\
-		__low2  = __low >> 16;					\
-		__low2 += __rem << 16;					\
-		__rem   = __low2 % (unsigned long)base;			\
-		__low2  = __low2 / (unsigned long)base;			\
-		__low   = __low & 0xffff;				\
-		__low  += __rem << 16;					\
-		__rem   = __low  % (unsigned long)base;			\
-		__low   = __low  / (unsigned long)base;			\
-		n = __low  + ((long long)__low2 << 16) +		\
-			((long long) __high << 32);			\
-	} else {							\
-		__rem = __low % (unsigned long)base;			\
-		n = (__low / (unsigned long)base);			\
-	}								\
-	__rem;								\
-})
-#endif
-
-#endif
-
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-ppc/div64.h linux-2.5.74-uc0-develer/include/asm-ppc/div64.h
--- linux-2.5.74-uc0/include/asm-ppc/div64.h	2003-07-02 22:57:06.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-ppc/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,23 +1 @@
-#ifndef __PPC_DIV64
-#define __PPC_DIV64
-
-#include <linux/types.h>
-
-extern u32 __div64_32(u64 *dividend, u32 div);
-
-#define do_div(n, div)	({			\
-	u64 __n = (n);				\
-	u32 __d = (div);			\
-	u32 __q, __r;				\
-	if ((__n >> 32) == 0) {			\
-		__q = (u32)__n / __d;		\
-		__r = (u32)__n - __q * __d;	\
-		(n) = __q;			\
-	} else {				\
-		__r = __div64_32(&__n, __d);	\
-		(n) = __n;			\
-	}					\
-	__r;					\
-})
-
-#endif
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-ppc64/div64.h linux-2.5.74-uc0-develer/include/asm-ppc64/div64.h
--- linux-2.5.74-uc0/include/asm-ppc64/div64.h	2003-07-02 22:39:34.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-ppc64/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,18 +1 @@
-#ifndef __PPC_DIV64
-#define __PPC_DIV64
-
-/* Copyright 2001 PPC64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) (n)) % (unsigned) (base); \
-	(n) = ((unsigned long) (n)) / (unsigned) (base); \
-	__res; })
-
-#endif
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-s390/div64.h linux-2.5.74-uc0-develer/include/asm-s390/div64.h
--- linux-2.5.74-uc0/include/asm-s390/div64.h	2003-07-02 22:50:17.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-s390/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -43,13 +43,7 @@
 })
 
 #else /* __s390x__ */
-
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
+#include <asm-generic/div64.h>
 #endif /* __s390x__ */
 
 #endif
diff -Nru linux-2.5.74-uc0/include/asm-sh/div64.h linux-2.5.74-uc0-develer/include/asm-sh/div64.h
--- linux-2.5.74-uc0/include/asm-sh/div64.h	2003-07-02 22:39:36.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-sh/div64.h	2003-07-03 09:38:59.000000000 +0200
@@ -1,20 +1 @@
-#ifndef __ASM_SH_DIV64
-#define __ASM_SH_DIV64
-
-extern u64 __div64_32(u64 n, u32 d);
-
-#define do_div(n,base) ({ \
-u64 __n = (n), __q; \
-u32 __base = (base); \
-u32 __res; \
-if ((__n >> 32) == 0) { \
-	__res = ((unsigned long) __n) % (unsigned) __base; \
-	(n) = ((unsigned long) __n) / (unsigned) __base; \
-} else { \
-	__q = __div64_32(__n, __base); \
-	__res = __n - __q * __base; \
-	(n) = __q; \
-} \
-__res; })
-
-#endif /* __ASM_SH_DIV64 */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-sparc/div64.h linux-2.5.74-uc0-develer/include/asm-sparc/div64.h
--- linux-2.5.74-uc0/include/asm-sparc/div64.h	2003-07-02 22:51:01.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-sparc/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,11 +1 @@
-#ifndef __SPARC_DIV64
-#define __SPARC_DIV64
-
-/* We're not 64-bit, but... */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) n) % (unsigned) base; \
-	n = ((unsigned long) n) / (unsigned) base; \
-	__res; })
-
-#endif /* __SPARC_DIV64 */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-sparc64/div64.h linux-2.5.74-uc0-develer/include/asm-sparc64/div64.h
--- linux-2.5.74-uc0/include/asm-sparc64/div64.h	2003-07-02 22:46:06.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-sparc64/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,14 +1 @@
-#ifndef __SPARC64_DIV64
-#define __SPARC64_DIV64
-
-/*
- * Hey, we're already 64-bit, no
- * need to play games..
- */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) n) % (unsigned) base; \
-	n = ((unsigned long) n) / (unsigned) base; \
-	__res; })
-
-#endif /* __SPARC64_DIV64 */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-v850/div64.h linux-2.5.74-uc0-develer/include/asm-v850/div64.h
--- linux-2.5.74-uc0/include/asm-v850/div64.h	2003-07-02 22:53:46.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-v850/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,11 +1 @@
-#ifndef __V850_DIV64_H__
-#define __V850_DIV64_H__
-
-/* We're not 64-bit, but... */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) n) % (unsigned) base; \
-	n = ((unsigned long) n) / (unsigned) base; \
-	__res; })
-
-#endif /* __V850_DIV64_H__ */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/include/asm-x86_64/div64.h linux-2.5.74-uc0-develer/include/asm-x86_64/div64.h
--- linux-2.5.74-uc0/include/asm-x86_64/div64.h	2003-07-02 22:54:30.000000000 +0200
+++ linux-2.5.74-uc0-develer/include/asm-x86_64/div64.h	2003-07-03 09:37:22.000000000 +0200
@@ -1,14 +1 @@
-#ifndef __X86_64_DIV64
-#define __X86_64_DIV64
-
-/*
- * Hey, we're already 64-bit, no
- * need to play games..
- */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) (n)) % (unsigned) (base); \
-	(n) = ((unsigned long) (n)) / (unsigned) (base); \
-	__res; })
-
-#endif
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.74-uc0/lib/Makefile linux-2.5.74-uc0-develer/lib/Makefile
--- linux-2.5.74-uc0/lib/Makefile	2003-07-02 22:40:29.000000000 +0200
+++ linux-2.5.74-uc0-develer/lib/Makefile	2003-07-03 09:37:22.000000000 +0200
@@ -5,7 +5,7 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o
+	 kobject.o idr.o div64.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru linux-2.5.74-uc0/lib/div64.c linux-2.5.74-uc0-develer/lib/div64.c
--- linux-2.5.74-uc0/lib/div64.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.74-uc0-develer/lib/div64.c	2003-07-03 09:37:22.000000000 +0200
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>
+ *
+ * Based on former do_div() implementation from asm-parisc/div64.h:
+ *	Copyright (C) 1999 Hewlett-Packard Co
+ *	Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ *
+ * Generic C version of 64bit/32bit division and modulo, with
+ * 64bit result and 32bit remainder.
+ *
+ * The fast case for (n>>32 == 0) is handled inline by do_div(). 
+ *
+ * Code generated for this function might be very inefficient
+ * for some CPUs. div64_32() can be overridden by linking arch-specific
+ * assembly versions such as arch/ppc/lib/div64.S and arch/sh/lib/div64.S.
+ */
+
+#include <linux/types.h>
+#include <asm/div64.h>
+
+uint32_t __div64_32(uint64_t *n, uint32_t base)
+{
+	uint32_t low, low2, high, rem;
+
+	low   = *n   & 0xffffffff;
+	high  = *n  >> 32;
+	rem   = high % (uint32_t)base;
+	high  = high / (uint32_t)base;
+	low2  = low >> 16;
+	low2 += rem << 16;
+	rem   = low2 % (uint32_t)base;
+	low2  = low2 / (uint32_t)base;
+	low   = low  & 0xffff;
+	low  += rem << 16;
+	rem   = low  % (uint32_t)base;
+	low   = low  / (uint32_t)base;
+
+	*n = low +
+		((uint64_t)low2 << 16) +
+		((uint64_t)high << 32);
+
+	return rem;
+}
+


