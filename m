Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268948AbTBSQRo>; Wed, 19 Feb 2003 11:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268950AbTBSQRW>; Wed, 19 Feb 2003 11:17:22 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:34786
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S268948AbTBSQQg>; Wed, 19 Feb 2003 11:16:36 -0500
Date: Wed, 19 Feb 2003 11:26:27 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add new DMA_ADDR_T_SIZE define
Message-ID: <Pine.LNX.4.44.0302191050290.29393-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch adds a new preprocessor define called DMA_ADDR_T_SIZE for all 
architectures, for the benefit of those drivers who care about its size 
(and yes, starfire is one of them).

Alternatives are:

1. a really ugly #ifdef in every single driver, which is error-prone and 
likely to break (see drivers/net/starfire.c around line 274 and have a 
barf bag ready).

2. always cast it to u64, which adds unnecessary overhead to 32-bit 
platforms.

3. use run-time checks all over the place, of the 
"sizeof(dma_addr_t)==sizeof(u64)" kind, which adds unnecessary overhead to 
all platforms.

4. use the results from pci_set_dma_mask(), which still amounts to 
unnecessary run-time overhead on platforms which have a 32-bit dma_addr_t 
to begin with.

So I think a define in each architecture's types.h file is the cleanest 
way to approach this, and that's what my patch does.

Comments and/or suggestions are appreciated.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-------------------------------------------------------
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-alpha/types.h linux-2.5.62/include/asm-alpha/types.h
--- linux-2.5.62.vanilla/include/asm-alpha/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-alpha/types.h	Wed Feb 19 10:19:57 2003
@@ -53,6 +53,7 @@
 typedef signed long s64;
 typedef unsigned long u64;
 
+#define DMA_ADDR_T_SIZE 64
 typedef u64 dma_addr_t;
 typedef u64 dma64_addr_t;
 
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-arm/types.h linux-2.5.62/include/asm-arm/types.h
--- linux-2.5.62.vanilla/include/asm-arm/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-arm/types.h	Wed Feb 19 10:19:40 2003
@@ -48,7 +48,7 @@
 typedef unsigned long long u64;
 
 /* Dma addresses are 32-bits wide.  */
-
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-cris/types.h linux-2.5.62/include/asm-cris/types.h
--- linux-2.5.62.vanilla/include/asm-cris/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-cris/types.h	Wed Feb 19 10:19:24 2003
@@ -48,7 +48,7 @@
 typedef unsigned long long u64;
 
 /* Dma addresses are 32-bits wide, just like our other addresses.  */
- 
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 
 #endif /* __ASSEMBLY__ */
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-i386/types.h linux-2.5.62/include/asm-i386/types.h
--- linux-2.5.62.vanilla/include/asm-i386/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-i386/types.h	Wed Feb 19 10:19:10 2003
@@ -52,8 +52,10 @@
 /* DMA addresses come in generic and 64-bit flavours.  */
 
 #ifdef CONFIG_HIGHMEM
+#define DMA_ADDR_T_SIZE 64
 typedef u64 dma_addr_t;
 #else
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 #endif
 typedef u64 dma64_addr_t;
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-ia64/types.h linux-2.5.62/include/asm-ia64/types.h
--- linux-2.5.62.vanilla/include/asm-ia64/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-ia64/types.h	Wed Feb 19 10:18:31 2003
@@ -62,7 +62,7 @@
 #define BITS_PER_LONG 64
 
 /* DMA addresses are 64-bits wide, in general.  */
-
+#define DMA_ADDR_T_SIZE 64
 typedef u64 dma_addr_t;
 
 # endif /* __KERNEL__ */
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-m68k/types.h linux-2.5.62/include/asm-m68k/types.h
--- linux-2.5.62.vanilla/include/asm-m68k/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-m68k/types.h	Wed Feb 19 10:18:20 2003
@@ -56,7 +56,7 @@
 typedef unsigned long long u64;
 
 /* DMA addresses are always 32-bits wide */
-
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-m68knommu/types.h linux-2.5.62/include/asm-m68knommu/types.h
--- linux-2.5.62.vanilla/include/asm-m68knommu/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-m68knommu/types.h	Wed Feb 19 10:18:02 2003
@@ -56,7 +56,7 @@
 typedef unsigned long long u64;
 
 /* Dma addresses are 32-bits wide.  */
-
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 
 #endif /* __ASSEMBLY__ */
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-mips/types.h linux-2.5.62/include/asm-mips/types.h
--- linux-2.5.62.vanilla/include/asm-mips/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-mips/types.h	Wed Feb 19 10:17:50 2003
@@ -76,6 +76,7 @@
 
 #endif
 
+#define DMA_ADDR_T_SIZE 32			/* XXX is this right? */
 typedef unsigned long dma_addr_t;
 
 #endif /* __ASSEMBLY__ */
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-mips64/types.h linux-2.5.62/include/asm-mips64/types.h
--- linux-2.5.62.vanilla/include/asm-mips64/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-mips64/types.h	Wed Feb 19 10:17:05 2003
@@ -75,6 +75,7 @@
 
 #endif
 
+#define DMA_ADDR_T_SIZE 64			/* XXX is this right? */
 typedef unsigned long dma_addr_t;
 
 #endif /* __ASSEMBLY__ */
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-parisc/types.h linux-2.5.62/include/asm-parisc/types.h
--- linux-2.5.62.vanilla/include/asm-parisc/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-parisc/types.h	Wed Feb 19 10:16:22 2003
@@ -52,7 +52,7 @@
 typedef unsigned long long u64;
 
 /* Dma addresses are 32-bits wide.  */
-
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-ppc/types.h linux-2.5.62/include/asm-ppc/types.h
--- linux-2.5.62.vanilla/include/asm-ppc/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-ppc/types.h	Wed Feb 19 10:16:10 2003
@@ -52,6 +52,7 @@
 typedef __vector128 vector128;
 
 /* DMA addresses are 32-bits wide */
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-ppc64/types.h linux-2.5.62/include/asm-ppc64/types.h
--- linux-2.5.62.vanilla/include/asm-ppc64/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-ppc64/types.h	Wed Feb 19 10:15:43 2003
@@ -63,6 +63,7 @@
 
 typedef __vector128 vector128;
 
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-s390/types.h linux-2.5.62/include/asm-s390/types.h
--- linux-2.5.62.vanilla/include/asm-s390/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-s390/types.h	Wed Feb 19 10:15:32 2003
@@ -60,6 +60,7 @@
 typedef signed long long s64;
 typedef unsigned long long u64;
 
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 
 typedef union {
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-s390x/types.h linux-2.5.62/include/asm-s390x/types.h
--- linux-2.5.62.vanilla/include/asm-s390x/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-s390x/types.h	Wed Feb 19 10:15:18 2003
@@ -61,6 +61,7 @@
 typedef signed long s64;
 typedef unsigned  long u64;
 
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 
 #endif /* __ASSEMBLY__ */
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-sh/types.h linux-2.5.62/include/asm-sh/types.h
--- linux-2.5.62.vanilla/include/asm-sh/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-sh/types.h	Wed Feb 19 10:15:05 2003
@@ -48,7 +48,7 @@
 typedef unsigned long long u64;
 
 /* Dma addresses are 32-bits wide.  */
-
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 
 #endif /* __ASSEMBLY__ */
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-sparc/types.h linux-2.5.62/include/asm-sparc/types.h
--- linux-2.5.62.vanilla/include/asm-sparc/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-sparc/types.h	Wed Feb 19 10:14:47 2003
@@ -51,6 +51,7 @@
 typedef __signed__ long long s64;
 typedef unsigned long long u64;
 
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-sparc64/types.h linux-2.5.62/include/asm-sparc64/types.h
--- linux-2.5.62.vanilla/include/asm-sparc64/types.h	Thu Feb 13 15:22:22 2003
+++ linux-2.5.62/include/asm-sparc64/types.h	Wed Feb 19 10:14:31 2003
@@ -52,7 +52,7 @@
 typedef unsigned long u64;
 
 /* Dma addresses come in generic and 64-bit flavours.  */
-
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-v850/types.h linux-2.5.62/include/asm-v850/types.h
--- linux-2.5.62.vanilla/include/asm-v850/types.h	Thu Feb 13 15:22:23 2003
+++ linux-2.5.62/include/asm-v850/types.h	Wed Feb 19 10:13:34 2003
@@ -56,7 +56,7 @@
 typedef unsigned long long u64;
 
 /* Dma addresses are 32-bits wide.  */
-
+#define DMA_ADDR_T_SIZE 32
 typedef u32 dma_addr_t;
 
 #endif /* !__ASSEMBLY__ */
diff -urX diff_kernel_excludes linux-2.5.62.vanilla/include/asm-x86_64/types.h linux-2.5.62/include/asm-x86_64/types.h
--- linux-2.5.62.vanilla/include/asm-x86_64/types.h	Thu Feb 13 15:22:23 2003
+++ linux-2.5.62/include/asm-x86_64/types.h	Wed Feb 19 10:13:21 2003
@@ -45,6 +45,7 @@
 typedef signed long long s64;
 typedef unsigned long long u64;
 
+#define DMA_ADDR_T_SIZE 64
 typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 


