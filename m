Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291462AbSBMJVn>; Wed, 13 Feb 2002 04:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291453AbSBMJV1>; Wed, 13 Feb 2002 04:21:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32779 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291448AbSBMJVF>;
	Wed, 13 Feb 2002 04:21:05 -0500
Message-ID: <3C6A2FCA.C4F49062@zip.com.au>
Date: Wed, 13 Feb 2002 01:20:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Ralf Baechle <ralf@uni-koblenz.de>
Subject: [patch] printk and dma_addr_t
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of drivers like to print out the values of variables
which have type dma_addr_t.   But there's no sane safe way
of doing this, because the size of the dma_addr_t type depends
upon platform and config.

This code:

	dma_addr_t a;
	char *s;
	printk("stuff: %lx %s", a, s);

will crash the kernel if dma_addr_t is 64-bit, because printk
will get the string's address wrong.

The patch introduces a DMA_ADDR_T_FMT macro which is the
appropriate printf conversion string for the selected
dma_addr_t type.   So the above usage will become

	printk("stuff: " DMA_ADDR_T_FMT " %s", a, s);

A patch which fixes all the drivers which I could find
follows.

Ralf, could you please double-check the mips implementation?



--- linux-2.4.18-pre9/include/asm-i386/types.h	Fri Oct 12 15:35:54 2001
+++ linux-akpm/include/asm-i386/types.h	Tue Feb 12 21:48:04 2002
@@ -47,8 +47,10 @@ typedef unsigned long long u64;
 
 #ifdef CONFIG_HIGHMEM
 typedef u64 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%Lx"
 #else
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 #endif
 typedef u64 dma64_addr_t;
 
--- linux-2.4.18-pre9/include/asm-alpha/types.h	Fri Oct 12 15:35:54 2001
+++ linux-akpm/include/asm-alpha/types.h	Tue Feb 12 21:48:07 2002
@@ -50,5 +50,7 @@ typedef unsigned long u64;
 typedef u64 dma_addr_t;
 typedef u64 dma64_addr_t;
 
+#define DMA_ADDR_T_FMT		"%Lx"
+
 #endif /* __KERNEL__ */
 #endif /* _ALPHA_TYPES_H */
--- linux-2.4.18-pre9/include/asm-arm/types.h	Sun Feb  6 17:45:26 2000
+++ linux-akpm/include/asm-arm/types.h	Tue Feb 12 21:48:12 2002
@@ -44,6 +44,7 @@ typedef unsigned long long u64;
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 #endif /* __KERNEL__ */
 
--- linux-2.4.18-pre9/include/asm-cris/types.h	Thu Feb  8 16:32:44 2001
+++ linux-akpm/include/asm-cris/types.h	Tue Feb 12 21:48:15 2002
@@ -44,6 +44,7 @@ typedef unsigned long long u64;
 /* Dma addresses are 32-bits wide, just like our other addresses.  */
  
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 #endif /* __KERNEL__ */
 
--- linux-2.4.18-pre9/include/asm-ia64/types.h	Fri Apr 21 15:21:24 2000
+++ linux-akpm/include/asm-ia64/types.h	Tue Feb 12 21:48:18 2002
@@ -63,6 +63,7 @@ typedef __u64 u64;
 /* DMA addresses are 64-bits wide, in general.  */
 
 typedef u64 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%Lx"
 
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
--- linux-2.4.18-pre9/include/asm-m68k/types.h	Mon Nov 27 18:00:49 2000
+++ linux-akpm/include/asm-m68k/types.h	Tue Feb 12 21:48:21 2002
@@ -52,6 +52,7 @@ typedef unsigned long long u64;
 /* DMA addresses are 32-bits wide */
 
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 #endif /* __KERNEL__ */
 
--- linux-2.4.18-pre9/include/asm-mips64/types.h	Sun Sep  9 10:43:02 2001
+++ linux-akpm/include/asm-mips64/types.h	Tue Feb 12 21:48:26 2002
@@ -70,6 +70,7 @@ typedef unsigned long long u64;
 #define BITS_PER_LONG _MIPS_SZLONG
 
 typedef unsigned long dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 #endif /* __KERNEL__ */
 
--- linux-2.4.18-pre9/include/asm-mips/types.h	Sun Jul  9 22:18:15 2000
+++ linux-akpm/include/asm-mips/types.h	Tue Feb 12 21:48:30 2002
@@ -71,6 +71,7 @@ typedef unsigned long long u64;
 #define BITS_PER_LONG _MIPS_SZLONG
 
 typedef unsigned long dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 #endif /* __KERNEL__ */
 
--- linux-2.4.18-pre9/include/asm-parisc/types.h	Tue Dec  5 12:29:39 2000
+++ linux-akpm/include/asm-parisc/types.h	Tue Feb 12 21:48:35 2002
@@ -48,6 +48,7 @@ typedef unsigned long long u64;
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 #endif /* __KERNEL__ */
 
--- linux-2.4.18-pre9/include/asm-ppc/types.h	Sun Oct 21 10:13:07 2001
+++ linux-akpm/include/asm-ppc/types.h	Tue Feb 12 21:48:38 2002
@@ -46,6 +46,8 @@ typedef __vector128 vector128;
 
 /* DMA addresses are 32-bits wide */
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
+
 typedef u64 dma64_addr_t;
 
 #endif /* __KERNEL__ */
--- linux-2.4.18-pre9/include/asm-s390/types.h	Wed Apr 11 19:02:28 2001
+++ linux-akpm/include/asm-s390/types.h	Tue Feb 12 21:48:42 2002
@@ -54,6 +54,7 @@ typedef unsigned long long u64;
 #define BITS_PER_LONG 32
 
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 typedef union {
 	unsigned long long pair;
--- linux-2.4.18-pre9/include/asm-s390x/types.h	Wed Apr 11 19:02:29 2001
+++ linux-akpm/include/asm-s390x/types.h	Tue Feb 12 21:48:45 2002
@@ -56,6 +56,7 @@ typedef unsigned  long u64;
 #define BITS_PER_LONG 64
 
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 #endif                                 /* __KERNEL__                       */
 #endif
--- linux-2.4.18-pre9/include/asm-sh/types.h	Sun Mar  5 09:33:55 2000
+++ linux-akpm/include/asm-sh/types.h	Tue Feb 12 21:48:49 2002
@@ -44,6 +44,7 @@ typedef unsigned long long u64;
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
 
 #endif /* __KERNEL__ */
 
--- linux-2.4.18-pre9/include/asm-sparc64/types.h	Fri Oct 12 15:35:54 2001
+++ linux-akpm/include/asm-sparc64/types.h	Tue Feb 12 21:48:53 2002
@@ -48,6 +48,8 @@ typedef unsigned long u64;
 /* Dma addresses come in generic and 64-bit flavours.  */
 
 typedef u32 dma_addr_t;
+#define DMA_ADDR_T_FMT		"%lx"
+
 typedef u64 dma64_addr_t;
 
 #endif /* __KERNEL__ */

-
