Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTGBASc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTGBASc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:18:32 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:42157 "HELO
	develer.com") by vger.kernel.org with SMTP id S264152AbTGBASW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:18:22 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Date: Wed, 2 Jul 2003 02:32:20 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307020232.20726.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

sorry for coming up with this patch in a short time frame, but
it needs to be applied in order to fix real do_div() brokenness
on many architectures.

If you'd prefer me to fix just the bugs without moving
stuff around, I'd be glad to provide another patch. I'd push
this one through a mantainer, but this patch really doesn't
belong to any specific architecture or subsystem, so...

---------------------------------------------------------------------

 - move the 64/32bit do_div() macro to a new asm-generic/div64.h
   header;

 - kill multiple copies of the generic version in architecture
   specific subdirs. Most copies were either buggy or subtly
   different from each other;

 - ensure all surviving instances of do_div() have their parameters
   correctly parenthesized to avoid funny results;

Note that the arm26, cris, m68knommu, sh, sparc and v850 architectures
are silently clipping 64bit dividend to 32bit! This patch doesn't try
to fix this because I can't test on all architectures.

Patch submitted by Bernardo Innocenti <bernie@develer.com>

Applies to 2.5.73. Backporting to 2.4.21 is trivial.


FOOT NOTE: what's the point with do_div()? Isn't gcc's long long
arithmetic support good enough on all platforms? If not, why
doesn't that get fixed in libgcc instead of polluting the kernel
with silly (and sometimes bogus) implementations?


 asm-alpha/div64.h     |   15 +--------------
 asm-arm26/div64.h     |   15 +--------------
 asm-cris/div64.h      |   17 +----------------
 asm-generic/div64.h   |   13 +++++++++++++
 asm-h8300/div64.h     |   14 +-------------
 asm-ia64/div64.h      |   21 +--------------------
 asm-m68k/div64.h      |    9 ---------
 asm-m68knommu/div64.h |   14 +-------------
 asm-mips64/div64.h    |   20 +-------------------
 asm-parisc/div64.h    |   36 ++++++++++--------------------------
 asm-ppc64/div64.h     |   19 +------------------
 asm-s390/div64.h      |    8 +-------
 asm-sh/div64.h        |   11 +----------
 asm-sparc/div64.h     |   12 +-----------
 asm-sparc64/div64.h   |   15 +--------------
 asm-v850/div64.h      |   12 +-----------
 asm-x86_64/div64.h    |   15 +--------------
 17 files changed, 37 insertions(+), 229 deletions(-)

diff -Nru linux-2.5.73-uc0/include/asm-generic/div64.h linux-2.5.x/include/asm-generic/div64.h
--- linux-2.5.73-uc0/include/asm-generic/div64.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.x/include/asm-generic/div64.h	2003-06-26 01:26:49.000000000 +0200
@@ -0,0 +1,13 @@
+#ifndef _ASM_GENERIC_DIV64_H
+#define _ASM_GENERIC_DIV64_H
+
+/* n = n / base; return rem; */
+
+#define do_div(n,base) ({					\
+	int __res;						\
+	__res = ((unsigned long)(n)) % (unsigned)(base);	\
+	(n) = ((unsigned long)(n)) / (unsigned)(base);		\
+	__res;							\
+})
+
+#endif /* _ASM_GENERIC_DIV64_H */
diff -Nru linux-2.5.73-uc0/include/asm-alpha/div64.h linux-2.5.x/include/asm-alpha/div64.h
--- linux-2.5.73-uc0/include/asm-alpha/div64.h	2003-06-22 20:33:15.000000000 +0200
+++ linux-2.5.x/include/asm-alpha/div64.h	2003-06-26 01:21:03.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-arm26/div64.h linux-2.5.x/include/asm-arm26/div64.h
--- linux-2.5.73-uc0/include/asm-arm26/div64.h	2003-06-22 20:32:35.000000000 +0200
+++ linux-2.5.x/include/asm-arm26/div64.h	2003-06-26 01:21:39.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-cris/div64.h linux-2.5.x/include/asm-cris/div64.h
--- linux-2.5.73-uc0/include/asm-cris/div64.h	2003-06-22 20:32:35.000000000 +0200
+++ linux-2.5.x/include/asm-cris/div64.h	2003-06-26 01:21:49.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-h8300/div64.h linux-2.5.x/include/asm-h8300/div64.h
--- linux-2.5.73-uc0/include/asm-h8300/div64.h	2003-06-22 20:32:28.000000000 +0200
+++ linux-2.5.x/include/asm-h8300/div64.h	2003-06-26 01:22:10.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-ia64/div64.h linux-2.5.x/include/asm-ia64/div64.h
--- linux-2.5.73-uc0/include/asm-ia64/div64.h	2003-06-22 20:33:36.000000000 +0200
+++ linux-2.5.x/include/asm-ia64/div64.h	2003-06-26 01:23:05.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-m68k/div64.h linux-2.5.x/include/asm-m68k/div64.h
--- linux-2.5.73-uc0/include/asm-m68k/div64.h	2003-06-22 20:33:17.000000000 +0200
+++ linux-2.5.x/include/asm-m68k/div64.h	2003-06-26 01:23:35.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-m68knommu/div64.h linux-2.5.x/include/asm-m68knommu/div64.h
--- linux-2.5.73-uc0/include/asm-m68knommu/div64.h	2003-06-22 20:32:37.000000000 +0200
+++ linux-2.5.x/include/asm-m68knommu/div64.h	2003-06-26 01:23:54.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-mips64/div64.h linux-2.5.x/include/asm-mips64/div64.h
--- linux-2.5.73-uc0/include/asm-mips64/div64.h	2003-06-22 20:32:45.000000000 +0200
+++ linux-2.5.x/include/asm-mips64/div64.h	2003-06-26 01:24:41.000000000 +0200
@@ -1,19 +1 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef _ASM_DIV64_H
-#define _ASM_DIV64_H
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
-#endif /* _ASM_DIV64_H */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.73-uc0/include/asm-parisc/div64.h linux-2.5.x/include/asm-parisc/div64.h
--- linux-2.5.73-uc0/include/asm-parisc/div64.h	2003-06-22 20:32:55.000000000 +0200
+++ linux-2.5.x/include/asm-parisc/div64.h	2003-06-26 01:25:25.000000000 +0200
@@ -2,23 +2,7 @@
 #define __ASM_PARISC_DIV64
 
 #ifdef __LP64__
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
+#include <asm-generic/div64.h>
 #else
 /*
  * unsigned long long division.  Yuck Yuck!  What is Linux coming to?
@@ -30,21 +14,21 @@
 	__low  = (n) & 0xffffffff;					\
 	__high = (n) >> 32;						\
 	if (__high) {							\
-		__rem   = __high % (unsigned long)base;			\
-		__high  = __high / (unsigned long)base;			\
+		__rem   = __high % (unsigned long)(base);		\
+		__high  = __high / (unsigned long)(base);		\
 		__low2  = __low >> 16;					\
 		__low2 += __rem << 16;					\
-		__rem   = __low2 % (unsigned long)base;			\
-		__low2  = __low2 / (unsigned long)base;			\
+		__rem   = __low2 % (unsigned long)(base);		\
+		__low2  = __low2 / (unsigned long)(base);		\
 		__low   = __low & 0xffff;				\
 		__low  += __rem << 16;					\
-		__rem   = __low  % (unsigned long)base;			\
-		__low   = __low  / (unsigned long)base;			\
-		n = __low  + ((long long)__low2 << 16) +		\
+		__rem   = __low  % (unsigned long)(base);		\
+		__low   = __low  / (unsigned long)(base);		\
+		(n) = __low  + ((long long)__low2 << 16) +		\
 			((long long) __high << 32);			\
 	} else {							\
-		__rem = __low % (unsigned long)base;			\
-		n = (__low / (unsigned long)base);			\
+		__rem = __low % (unsigned long)(base);			\
+		(n) = (__low / (unsigned long)(base));			\
 	}								\
 	__rem;								\
 })
diff -Nru linux-2.5.73-uc0/include/asm-ppc64/div64.h linux-2.5.x/include/asm-ppc64/div64.h
--- linux-2.5.73-uc0/include/asm-ppc64/div64.h	2003-06-22 20:32:28.000000000 +0200
+++ linux-2.5.x/include/asm-ppc64/div64.h	2003-06-26 01:27:20.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-s390/div64.h linux-2.5.x/include/asm-s390/div64.h
--- linux-2.5.73-uc0/include/asm-s390/div64.h	2003-06-22 20:32:57.000000000 +0200
+++ linux-2.5.x/include/asm-s390/div64.h	2003-06-26 01:27:51.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-sh/div64.h linux-2.5.x/include/asm-sh/div64.h
--- linux-2.5.73-uc0/include/asm-sh/div64.h	2003-06-22 20:32:28.000000000 +0200
+++ linux-2.5.x/include/asm-sh/div64.h	2003-06-26 01:28:08.000000000 +0200
@@ -1,10 +1 @@
-#ifndef __ASM_SH_DIV64
-#define __ASM_SH_DIV64
-
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
-#endif /* __ASM_SH_DIV64 */
+#include <asm-generic/div64.h>
diff -Nru linux-2.5.73-uc0/include/asm-sparc/div64.h linux-2.5.x/include/asm-sparc/div64.h
--- linux-2.5.73-uc0/include/asm-sparc/div64.h	2003-06-22 20:32:58.000000000 +0200
+++ linux-2.5.x/include/asm-sparc/div64.h	2003-06-26 01:28:25.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-sparc64/div64.h linux-2.5.x/include/asm-sparc64/div64.h
--- linux-2.5.73-uc0/include/asm-sparc64/div64.h	2003-06-22 20:32:42.000000000 +0200
+++ linux-2.5.x/include/asm-sparc64/div64.h	2003-06-26 01:28:47.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-v850/div64.h linux-2.5.x/include/asm-v850/div64.h
--- linux-2.5.73-uc0/include/asm-v850/div64.h	2003-06-22 20:33:08.000000000 +0200
+++ linux-2.5.x/include/asm-v850/div64.h	2003-06-26 01:29:07.000000000 +0200
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
diff -Nru linux-2.5.73-uc0/include/asm-x86_64/div64.h linux-2.5.x/include/asm-x86_64/div64.h
--- linux-2.5.73-uc0/include/asm-x86_64/div64.h	2003-06-22 20:33:12.000000000 +0200
+++ linux-2.5.x/include/asm-x86_64/div64.h	2003-06-26 01:29:16.000000000 +0200
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

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


