Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268349AbUI2Mw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268349AbUI2Mw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268356AbUI2Mw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:52:29 -0400
Received: from mail.renesas.com ([202.234.163.13]:15091 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268349AbUI2Mvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:51:55 -0400
Date: Wed, 29 Sep 2004 21:51:41 +0900 (JST)
Message-Id: <20040929.215141.115902895.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc2-mm4] [m32r] Update ioremap routine
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here is a patch to update ioremap*.c for m32r, taken from 
"Add __iomem modifier to the return value type of __ioremap()
for much stricter type-checking."

Please apply.
Thank you.

	* arch/m32r/mm/ioremap.c: ditto.
	- Add __iomem modifier to the return value type of __ioremap()
	  for much stricter type-checking.

	* arch/m32r/mm/ioremap-nommu.c: ditto.
	
	* include/asm-m32r/io.h:
	- Modified for much stricter type-checking.
	- Change __inline__ to inline.
	
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/mm/ioremap-nommu.c |    7 +++---
 arch/m32r/mm/ioremap.c       |   22 +++++++++++---------
 include/asm-m32r/io.h        |   47 ++++++++++++++++++++++++++++---------------
 3 files changed, 48 insertions(+), 28 deletions(-)


diff -ruNp a/arch/m32r/mm/ioremap-nommu.c b/arch/m32r/mm/ioremap-nommu.c
--- a/arch/m32r/mm/ioremap-nommu.c	2004-09-28 10:19:11.000000000 +0900
+++ b/arch/m32r/mm/ioremap-nommu.c	2004-09-29 10:08:30.000000000 +0900
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/m32r/mm/io_remap.c
+ *  linux/arch/m32r/mm/ioremap-nommu.c
  *
  *  Copyright (c) 2001, 2002  Hiroyuki Kondo
  *
@@ -38,14 +38,15 @@
 
 #define IS_LOW512(addr) (!((unsigned long)(addr) & ~0x1fffffffUL))
 
-void * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+void __iomem *
+__ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
 {
 	return (void *)phys_addr;
 }
 
 #define IS_KSEG1(addr) (((unsigned long)(addr) & ~0x1fffffffUL) == KSEG1)
 
-void iounmap(void *addr)
+void iounmap(volatile void __iomem *addr)
 {
 }
 
diff -ruNp a/arch/m32r/mm/ioremap.c b/arch/m32r/mm/ioremap.c
--- a/arch/m32r/mm/ioremap.c	2004-09-28 10:19:11.000000000 +0900
+++ b/arch/m32r/mm/ioremap.c	2004-09-29 10:08:10.000000000 +0900
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/m32r/mm/io_remap.c
+ *  linux/arch/m32r/mm/ioremap.c
  *
  *  Copyright (c) 2001, 2002  Hiroyuki Kondo
  *
@@ -25,8 +25,9 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
+static inline void
+remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
+	       unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
 	unsigned long pfn;
@@ -52,8 +53,9 @@ static inline void remap_area_pte(pte_t 
 	} while (address && (address < end));
 }
 
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
+static inline int
+remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
+	       unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
 
@@ -75,8 +77,9 @@ static inline int remap_area_pmd(pmd_t *
 	return 0;
 }
 
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
-				 unsigned long size, unsigned long flags)
+static int
+remap_area_pages(unsigned long address, unsigned long phys_addr,
+		 unsigned long size, unsigned long flags)
 {
 	int error;
 	pgd_t * dir;
@@ -122,7 +125,8 @@ static int remap_area_pages(unsigned lon
 
 #define IS_LOW512(addr) (!((unsigned long)(addr) & ~0x1fffffffUL))
 
-void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+void __iomem *
+__ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
 {
 	void __iomem * addr;
 	struct vm_struct * area;
@@ -180,7 +184,7 @@ void __iomem * __ioremap(unsigned long p
 
 #define IS_KSEG1(addr) (((unsigned long)(addr) & ~0x1fffffffUL) == KSEG1)
 
-void iounmap(void *addr)
+void iounmap(volatile void __iomem *addr)
 {
 	if (!IS_KSEG1(addr))
 		vfree((void *) (PAGE_MASK & (unsigned long) addr));
diff -ruNp a/include/asm-m32r/io.h b/include/asm-m32r/io.h
--- a/include/asm-m32r/io.h	2004-09-28 10:19:53.000000000 +0900
+++ b/include/asm-m32r/io.h	2004-09-28 12:38:24.000000000 +0900
@@ -1,8 +1,8 @@
 #ifndef _ASM_M32R_IO_H
 #define _ASM_M32R_IO_H
 
-/* $Id$ */
-
+#include <linux/string.h>
+#include <linux/compiler.h>
 #include <asm/page.h>  /* __va */
 
 #ifdef __KERNEL__
@@ -22,7 +22,7 @@
  *	this function
  */
 
-static __inline__ unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile void * address)
 {
 	return __pa(address);
 }
@@ -40,12 +40,13 @@ static __inline__ unsigned long virt_to_
  *	this function
  */
 
-static __inline__ void *phys_to_virt(unsigned long address)
+static inline void *phys_to_virt(unsigned long address)
 {
 	return __va(address);
 }
 
-extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
+extern void __iomem *
+__ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
 /**
  *	ioremap		-	map bus memory into CPU space
@@ -59,12 +60,12 @@ extern void * __ioremap(unsigned long of
  *	address.
  */
 
-static __inline__ void * ioremap(unsigned long offset, unsigned long size)
+static inline void * ioremap(unsigned long offset, unsigned long size)
 {
 	return __ioremap(offset, size, 0);
 }
 
-extern void iounmap(void *addr);
+extern void iounmap(volatile void __iomem *addr);
 #define ioremap_nocache(off,size) ioremap(off,size)
 
 /*
@@ -95,32 +96,32 @@ extern void _outsl(unsigned int, const v
 
 static inline unsigned char _readb(unsigned long addr)
 {
-	return *(volatile unsigned char *)addr;
+	return *(volatile unsigned char __force *)addr;
 }
 
 static inline unsigned short _readw(unsigned long addr)
 {
-	return *(volatile unsigned short *)addr;
+	return *(volatile unsigned short __force *)addr;
 }
 
 static inline unsigned long _readl(unsigned long addr)
 {
-	return *(volatile unsigned long *)addr;
+	return *(volatile unsigned long __force *)addr;
 }
 
 static inline void _writeb(unsigned char b, unsigned long addr)
 {
-	*(volatile unsigned char *)addr = b;
+	*(volatile unsigned char __force *)addr = b;
 }
 
 static inline void _writew(unsigned short w, unsigned long addr)
 {
-	*(volatile unsigned short *)addr = w;
+	*(volatile unsigned short __force *)addr = w;
 }
 
 static inline void _writel(unsigned long l, unsigned long addr)
 {
-	*(volatile unsigned long *)addr = l;
+	*(volatile unsigned long __force *)addr = l;
 }
 
 #define inb     _inb
@@ -192,9 +193,23 @@ out:
         return retval;
 }
 
-#define memset_io(a, b, c)	memset((void *)(a), (b), (c))
-#define memcpy_fromio(a, b, c)	memcpy((a), (void *)(b), (c))
-#define memcpy_toio(a, b, c)	memcpy((void *)(a), (b), (c))
+static inline void
+memset_io(volatile void __iomem *addr, unsigned char val, int count)
+{
+	memset((void __force *) addr, val, count);
+}
+
+static inline void
+memcpy_fromio(void *dst, volatile void __iomem *src, int count)
+{
+	memcpy(dst, (void __force *) src, count);
+}
+
+static inline void
+memcpy_toio(volatile void __iomem *dst, const void *src, int count)
+{
+	memcpy((void __force *) dst, src, count);
+}
 
 #endif  /* __KERNEL__ */
 

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

