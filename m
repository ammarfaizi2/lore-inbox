Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVHQDBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVHQDBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 23:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVHQDBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 23:01:33 -0400
Received: from ozlabs.org ([203.10.76.45]:4253 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750802AbVHQDBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 23:01:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17154.43166.351018.356055@cargo.ozlabs.ibm.com>
Date: Wed, 17 Aug 2005 13:01:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH for 2.6.13] iSeries build with newer assemblers and compilers
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>

Paulus suggested that we put xLparMap in its own .c file so that we can
generate a .s file to be included into head.S.  This doesn't get around
the problem of having it at a fixed address, but it makes it more
palatable.

It would be good if this could be included in 2.6.13 as it solves our
build problems with various versions of binutils and gcc.  In
particular, it allows us to build an iSeries kernel on Debian unstable
using their biarch compiler.

This has been built and booted on iSeries and built for pSeries and g5.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/ppc64/kernel/LparData.c        |   79 ------------------------------------
 arch/ppc64/kernel/Makefile          |    5 ++
 arch/ppc64/kernel/head.S            |    6 ++
 arch/ppc64/kernel/lparmap.c         |   31 ++++++++++++++
 include/asm-ppc64/iSeries/LparMap.h |    9 +++-
 5 files changed, 51 insertions(+), 79 deletions(-)

diff -ruN linus/arch/ppc64/kernel/LparData.c linus-lparmap.2/arch/ppc64/kernel/LparData.c
--- linus/arch/ppc64/kernel/LparData.c	2005-07-28 11:23:11.000000000 +1000
+++ linus-lparmap.2/arch/ppc64/kernel/LparData.c	2005-08-16 17:13:16.000000000 +1000
@@ -32,32 +32,12 @@
 /* The HvReleaseData is the root of the information shared between 
  * the hypervisor and Linux.  
  */
-
-/*
- * WARNING - magic here
- *
- * Ok, this is a horrid hack below, but marginally better than the
- * alternatives.  What we really want is just to initialize
- * hvReleaseData in C as in the #if 0 section here.  However, gcc
- * refuses to believe that (u32)&x is a constant expression, so will
- * not allow the xMsNucDataOffset field to be properly initialized.
- * So, we declare hvReleaseData in inline asm instead.  We use inline
- * asm, rather than a .S file, because the assembler won't generate
- * the necessary relocation for the LparMap either, unless that symbol
- * is declared in the same source file.  Finally, we put the asm in a
- * dummy, attribute-used function, instead of at file scope, because
- * file scope asms don't allow contraints.  We want to use the "i"
- * constraints to put sizeof() and offsetof() expressions in there,
- * because including asm/offsets.h in C code then stringifying causes
- * all manner of warnings.
- */
-#if 0
 struct HvReleaseData hvReleaseData = {
 	.xDesc = 0xc8a5d9c4,	/* "HvRD" ebcdic */
 	.xSize = sizeof(struct HvReleaseData),
 	.xVpdAreasPtrOffset = offsetof(struct naca_struct, xItVpdAreas),
 	.xSlicNacaAddr = &naca,		/* 64-bit Naca address */
-	.xMsNucDataOffset = (u32)((unsigned long)&xLparMap - KERNELBASE),
+	.xMsNucDataOffset = LPARMAP_PHYS,
 	.xFlags = HVREL_TAGSINACTIVE	/* tags inactive       */
 					/* 64 bit              */
 					/* shared processors   */
@@ -70,63 +50,6 @@
 		0xa7, 0x40, 0xf2, 0x4b,
 		0xf4, 0x4b, 0xf6, 0xf4 },
 };
-#endif
-
-
-extern struct HvReleaseData hvReleaseData;
-
-static void __attribute_used__ hvReleaseData_wrapper(void)
-{
-	/* This doesn't appear to need any alignment (even 4 byte) */
-	asm volatile (
-		"	lparMapPhys = xLparMap - %3\n"
-		"	.data\n"
-		"	.globl	hvReleaseData\n"
-		"hvReleaseData:\n"
-		"	.long	0xc8a5d9c4\n"	/* xDesc */
-						/* "HvRD" in ebcdic */
-		"	.short	%0\n"		/* xSize */
-		"	.short	%1\n"		/* xVpdAreasPtrOffset */
-		"	.llong	naca\n"		/* xSlicNacaAddr */
-		"	.long	lparMapPhys\n"	/* xMsNucDataOffset */
-		"	.long	0\n"		/* xRsvd1 */
-		"	.short	%2\n"		/* xFlags */
-		"	.short	4\n"	/* xVrmIndex  - v5r2m0 */
-		"	.short	3\n"	/* xMinSupportedPlicVrmIndex - v5r1m0 */
-		"	.short	3\n"	/* xMinCompatablePlicVrmIndex - v5r1m0 */
-		"	.long	0xd38995a4\n"	/* xVrmName */
-		"	.long	0xa740f24b\n"	/*   "Linux 2.4.64" ebcdic */
-		"	.long	0xf44bf6f4\n"
-		"	. = hvReleaseData + %0\n"
-		"	.previous\n"
-		: : "i"(sizeof(hvReleaseData)),
-		"i"(offsetof(struct naca_struct, xItVpdAreas)),
-		"i"(HVREL_TAGSINACTIVE /* tags inactive, 64 bit, */
-				       /* shared processors, HMT allowed */
-		    | 6), /* TEMP: This allows non-GA drivers */
-		"i"(KERNELBASE)
-		);
-}
-
-struct LparMap __attribute__((aligned (16))) xLparMap = {
-	.xNumberEsids = HvEsidsToMap,
-	.xNumberRanges = HvRangesToMap,
-	.xSegmentTableOffs = STAB0_PAGE,
-
-	.xEsids = {
-		{ .xKernelEsid = GET_ESID(KERNELBASE),
-		  .xKernelVsid = KERNEL_VSID(KERNELBASE), },
-		{ .xKernelEsid = GET_ESID(VMALLOCBASE),
-		  .xKernelVsid = KERNEL_VSID(VMALLOCBASE), },
-	},
-
-	.xRanges = {
-		{ .xPages = HvPagesToMap,
-		  .xOffset = 0,
-		  .xVPN = KERNEL_VSID(KERNELBASE) << (SID_SHIFT - PAGE_SHIFT),
-		},
-	},
-};
 
 extern void system_reset_iSeries(void);
 extern void machine_check_iSeries(void);
diff -ruN linus/arch/ppc64/kernel/Makefile linus-lparmap.2/arch/ppc64/kernel/Makefile
--- linus/arch/ppc64/kernel/Makefile	2005-06-27 16:08:00.000000000 +1000
+++ linus-lparmap.2/arch/ppc64/kernel/Makefile	2005-08-16 17:13:16.000000000 +1000
@@ -73,3 +73,8 @@
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 
 CFLAGS_ioctl32.o += -Ifs/
+
+ifeq ($(CONFIG_PPC_ISERIES),y)
+arch/ppc64/kernel/head.o: arch/ppc64/kernel/lparmap.s
+AFLAGS_head.o += -Iarch/ppc64/kernel
+endif
diff -ruN linus/arch/ppc64/kernel/head.S linus-lparmap.2/arch/ppc64/kernel/head.S
--- linus/arch/ppc64/kernel/head.S	2005-08-05 09:12:57.000000000 +1000
+++ linus-lparmap.2/arch/ppc64/kernel/head.S	2005-08-16 17:24:59.000000000 +1000
@@ -38,6 +38,7 @@
 #include <asm/cputable.h>
 #include <asm/setup.h>
 #include <asm/hvcall.h>
+#include <asm/iSeries/LparMap.h>
 
 #ifdef CONFIG_PPC_ISERIES
 #define DO_SOFT_DISABLE
@@ -679,6 +680,11 @@
 	.globl fwnmi_data_area
 fwnmi_data_area:
 
+#ifdef CONFIG_PPC_ISERIES
+	. = LPARMAP_PHYS
+#include "lparmap.s"
+#endif /* CONFIG_PPC_ISERIES */
+
 /*
  * Vectors for the FWNMI option.  Share common code.
  */
diff -ruN linus/arch/ppc64/kernel/lparmap.c linus-lparmap.2/arch/ppc64/kernel/lparmap.c
--- linus/arch/ppc64/kernel/lparmap.c	1970-01-01 10:00:00.000000000 +1000
+++ linus-lparmap.2/arch/ppc64/kernel/lparmap.c	2005-08-16 17:13:16.000000000 +1000
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2005  Stephen Rothwell  IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <asm/mmu.h>
+#include <asm/page.h>
+#include <asm/iSeries/LparMap.h>
+
+const struct LparMap __attribute__((__section__(".text"))) xLparMap = {
+	.xNumberEsids = HvEsidsToMap,
+	.xNumberRanges = HvRangesToMap,
+	.xSegmentTableOffs = STAB0_PAGE,
+
+	.xEsids = {
+		{ .xKernelEsid = GET_ESID(KERNELBASE),
+		  .xKernelVsid = KERNEL_VSID(KERNELBASE), },
+		{ .xKernelEsid = GET_ESID(VMALLOCBASE),
+		  .xKernelVsid = KERNEL_VSID(VMALLOCBASE), },
+	},
+
+	.xRanges = {
+		{ .xPages = HvPagesToMap,
+		  .xOffset = 0,
+		  .xVPN = KERNEL_VSID(KERNELBASE) << (SID_SHIFT - PAGE_SHIFT),
+		},
+	},
+};
diff -ruN linus/include/asm-ppc64/iSeries/LparMap.h linus-lparmap.2/include/asm-ppc64/iSeries/LparMap.h
--- linus/include/asm-ppc64/iSeries/LparMap.h	2005-07-28 11:23:11.000000000 +1000
+++ linus-lparmap.2/include/asm-ppc64/iSeries/LparMap.h	2005-08-16 17:14:33.000000000 +1000
@@ -19,6 +19,8 @@
 #ifndef _LPARMAP_H
 #define _LPARMAP_H
 
+#ifndef __ASSEMBLY__
+
 #include <asm/types.h>
 
 /*
@@ -71,6 +73,11 @@
 	} xRanges[HvRangesToMap];
 };
 
-extern struct LparMap		xLparMap;
+extern const struct LparMap	xLparMap;
+
+#endif /* __ASSEMBLY__ */
+
+/* the fixed address where the LparMap exists */
+#define LPARMAP_PHYS		0x7000
 
 #endif /* _LPARMAP_H */
