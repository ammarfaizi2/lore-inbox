Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbTIDJ3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTIDJ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:29:51 -0400
Received: from verein.lst.de ([212.34.189.10]:38348 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264867AbTIDJ33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:29:29 -0400
Date: Thu, 4 Sep 2003 11:29:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@redhat.com>
Cc: paulus@samba.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904092915.GA16344@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"David S. Miller" <davem@redhat.com>, paulus@samba.org,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk> <20030904073845.GA14669@lst.de> <20030904010940.5fa0e560.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904010940.5fa0e560.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5.5 () EMAIL_ATTRIBUTION,IN_REP_TO,PATCH_UNIFIED_DIFF,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:09:40AM -0700, David S. Miller wrote:
> On Thu, 4 Sep 2003 09:38:45 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Umm, right, so the typedef name is also completly bogus, if we're
> > going to go that route it needs to be something likeb iocookie_t.
> 
> My suggestion is to just pass a resource and an offset to ioremap().

Here's a ioremap_resource implementation.  Tested on ppc32 with a
converted sungem driver.


--- 1.13/arch/ppc/mm/pgtable.c	Wed Sep  3 14:16:34 2003
+++ edited/arch/ppc/mm/pgtable.c	Thu Sep  4 10:53:17 2003
@@ -27,6 +27,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/ioport.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -62,6 +63,10 @@
 #define PGDIR_ORDER	0
 #endif
 
+#ifndef CONFIG_44x
+#define fixup_bigphys_addr(addr, size)	(addr)
+#endif
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret;
@@ -117,27 +122,18 @@
 	__free_page(pte);
 }
 
-#ifndef CONFIG_44x
 void *
-ioremap(phys_addr_t addr, unsigned long size)
+ioremap_resource(struct resource *res, unsigned long offset, unsigned long size)
 {
-	return __ioremap(addr, size, _PAGE_NO_CACHE);
-}
-#else /* CONFIG_44x */
-void *
-ioremap64(unsigned long long addr, unsigned long size)
-{
-	return __ioremap(addr, size, _PAGE_NO_CACHE);
+	return __ioremap(res->start + offset, size, _PAGE_NO_CACHE);
 }
 
 void *
-ioremap(phys_addr_t addr, unsigned long size)
+ioremap(unsigned long addr, unsigned long size)
 {
 	phys_addr_t addr64 = fixup_bigphys_addr(addr, size);;
-
-	return ioremap64(addr64, size);
+	return __ioremap(addr64, size, _PAGE_NO_CACHE);
 }
-#endif /* CONFIG_44x */
 
 void *
 __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
--- 1.14/include/asm-alpha/io.h	Mon Feb 17 09:27:53 2003
+++ edited/include/asm-alpha/io.h	Thu Sep  4 10:40:25 2003
@@ -325,6 +325,7 @@
 {
 	return (void *) __ioremap(offset, size);
 } 
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 static inline void iounmap(void *addr)
 {
===== include/asm-arm/io.h 1.15 vs edited =====
--- 1.15/include/asm-arm/io.h	Sat Jan 25 19:32:47 2003
+++ edited/include/asm-arm/io.h	Thu Sep  4 10:40:34 2003
@@ -274,6 +274,7 @@
 #define ioremap_nocache(cookie,size)	__arch_ioremap((cookie),(size),0,1)
 #define iounmap(cookie)			__arch_iounmap(cookie)
 #endif
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 /*
  * can the hardware map this into one segment or not, given no other
===== include/asm-arm26/io.h 1.1 vs edited =====
--- 1.1/include/asm-arm26/io.h	Wed Jun  4 13:14:10 2003
+++ edited/include/asm-arm26/io.h	Thu Sep  4 10:40:44 2003
@@ -397,6 +397,7 @@
 #define ioremap_nocache(cookie,size)	__arch_ioremap((cookie),(size),0,1)
 #define iounmap(cookie)			__arch_iounmap(cookie)
 #endif
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 /*
  * DMA-consistent mapping functions.  These allocate/free a region of
===== include/asm-cris/io.h 1.8 vs edited =====
--- 1.8/include/asm-cris/io.h	Fri Jul  4 12:35:55 2003
+++ edited/include/asm-cris/io.h	Thu Sep  4 10:40:48 2003
@@ -24,6 +24,7 @@
 {
 	return __ioremap(offset, size, 0);
 }
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 extern void iounmap(void *addr);
 
===== include/asm-h8300/io.h 1.3 vs edited =====
--- 1.3/include/asm-h8300/io.h	Thu Aug 21 17:55:15 2003
+++ edited/include/asm-h8300/io.h	Thu Sep  4 10:40:55 2003
@@ -165,6 +165,7 @@
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 extern void iounmap(void *addr);
 
===== include/asm-i386/io.h 1.24 vs edited =====
--- 1.24/include/asm-i386/io.h	Mon Mar 24 18:23:37 2003
+++ edited/include/asm-i386/io.h	Thu Sep  4 10:41:01 2003
@@ -98,6 +98,7 @@
 #define page_to_phys(page)    ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
+#define ioremap_resource(res, off, size)	__ioremap((res)->start + (off), (size), 0)
 
 /**
  * ioremap     -   map bus memory into CPU space
===== include/asm-ia64/io.h 1.17 vs edited =====
--- 1.17/include/asm-ia64/io.h	Wed Aug 20 08:13:39 2003
+++ edited/include/asm-ia64/io.h	Thu Sep  4 10:35:56 2003
@@ -383,6 +383,7 @@
 {
 	return (void *) (__IA64_UNCACHED_OFFSET | (offset));
 }
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 static inline void
 iounmap (void *addr)
===== include/asm-m68k/io.h 1.8 vs edited =====
--- 1.8/include/asm-m68k/io.h	Wed Mar  5 14:19:40 2003
+++ edited/include/asm-m68k/io.h	Thu Sep  4 10:36:30 2003
@@ -303,6 +303,7 @@
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 
 /* m68k caches aren't DMA coherent */
===== include/asm-m68knommu/io.h 1.2 vs edited =====
--- 1.2/include/asm-m68knommu/io.h	Thu Jul  3 03:18:30 2003
+++ edited/include/asm-m68knommu/io.h	Thu Sep  4 10:36:38 2003
@@ -157,6 +157,7 @@
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 extern void iounmap(void *addr);
 
===== include/asm-mips/io.h 1.5 vs edited =====
--- 1.5/include/asm-mips/io.h	Tue Jul 29 03:38:07 2003
+++ edited/include/asm-mips/io.h	Thu Sep  4 10:37:17 2003
@@ -190,6 +190,8 @@
  */
 #define ioremap(offset, size)						\
 	__ioremap((offset), (size), _CACHE_UNCACHED)
+#define ioremap_resource(res, off, size) \
+	__ioremap((res)->start + (off), (size), _CACHE_UNCACHED)
 
 /*
  * ioremap_nocache     -   map bus memory into CPU space
===== include/asm-parisc/io.h 1.4 vs edited =====
--- 1.4/include/asm-parisc/io.h	Sat Jan 11 17:46:56 2003
+++ edited/include/asm-parisc/io.h	Thu Sep  4 10:37:12 2003
@@ -26,6 +26,7 @@
 /* Memory mapped IO */
 
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
+#define ioremap_resource(res, off, size)	__ioremap((res)->start + (off), (size), 0)
 
 extern inline void * ioremap(unsigned long offset, unsigned long size)
 {
===== include/asm-ppc/io.h 1.14 vs edited =====
--- 1.14/include/asm-ppc/io.h	Wed Sep  3 14:16:34 2003
+++ edited/include/asm-ppc/io.h	Thu Sep  4 10:46:59 2003
@@ -199,12 +199,12 @@
  * Map in an area of physical address space, for accessing
  * I/O devices etc.
  */
+struct resource;
 extern void *__ioremap(phys_addr_t address, unsigned long size,
 		       unsigned long flags);
-extern void *ioremap(phys_addr_t address, unsigned long size);
-#ifdef CONFIG_44x
-extern void *ioremap64(unsigned long long address, unsigned long size);
-#endif
+extern void *ioremap_resource(struct resource *res, unsigned long offset,
+			      unsigned long size);
+extern void *ioremap(unsigned long address, unsigned long size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 extern void iounmap(void *addr);
 extern unsigned long iopa(unsigned long addr);
===== include/asm-ppc64/io.h 1.8 vs edited =====
--- 1.8/include/asm-ppc64/io.h	Sun Apr 27 23:32:15 2003
+++ edited/include/asm-ppc64/io.h	Thu Sep  4 10:37:44 2003
@@ -118,6 +118,7 @@
 		       unsigned long flags);
 extern void *ioremap(unsigned long address, unsigned long size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 extern void iounmap(void *addr);
 
 /*
===== include/asm-s390/io.h 1.6 vs edited =====
--- 1.6/include/asm-s390/io.h	Mon Apr 14 21:11:58 2003
+++ edited/include/asm-s390/io.h	Thu Sep  4 10:38:00 2003
@@ -53,6 +53,7 @@
 #define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
 
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
+#define ioremap_resource(res, off, size)	__ioremap((res)->start + (off), (size), 0)
 
 extern inline void * ioremap (unsigned long offset, unsigned long size)
 {
===== include/asm-sh/io.h 1.5 vs edited =====
--- 1.5/include/asm-sh/io.h	Sun May  4 17:30:01 2003
+++ edited/include/asm-sh/io.h	Thu Sep  4 10:39:18 2003
@@ -72,6 +72,8 @@
 # define __ioremap(a,s)	sh_mv.mv_ioremap((a), (s))
 # define __iounmap(a)	sh_mv.mv_iounmap((a))
 
+# define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
+
 # define __isa_port2addr(a)	sh_mv.mv_isa_port2addr(a)
 
 # define inb		__inb
@@ -399,6 +401,7 @@
 {
 	return __ioremap(offset, size);
 }
+#define ioremap_resource(res, off, size)	__ioremap((res)->start + (off), (size))
 
 static __inline__ void iounmap(void *addr)
 {
===== include/asm-sparc/io.h 1.5 vs edited =====
--- 1.5/include/asm-sparc/io.h	Mon Dec  2 09:23:54 2002
+++ edited/include/asm-sparc/io.h	Thu Sep  4 10:39:56 2003
@@ -176,7 +176,8 @@
  * This is why we have no bus number argument to ioremap().
  */
 extern void *ioremap(unsigned long offset, unsigned long size);
-#define ioremap_nocache(X,Y)	ioremap((X),(Y))
+#define ioremap_nocache(X,Y)	ioremap((X),(Y)) 
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 extern void iounmap(void *addr);
 
 /*
===== include/asm-sparc64/io.h 1.7 vs edited =====
--- 1.7/include/asm-sparc64/io.h	Sat Dec 21 03:02:57 2002
+++ edited/include/asm-sparc64/io.h	Thu Sep  4 10:40:03 2003
@@ -435,6 +435,7 @@
  */
 #define ioremap(__offset, __size)	((void *)(__offset))
 #define ioremap_nocache(X,Y)		ioremap((X),(Y))
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 #define iounmap(__addr)			do { (void)(__addr); } while(0)
 
 /* Similarly for SBUS. */
===== include/asm-v850/io.h 1.2 vs edited =====
--- 1.2/include/asm-v850/io.h	Tue Jun 17 07:23:12 2003
+++ edited/include/asm-v850/io.h	Thu Sep  4 10:40:13 2003
@@ -97,6 +97,7 @@
 #define ioremap_nocache(physaddr, size)		(physaddr)
 #define ioremap_writethrough(physaddr, size)	(physaddr)
 #define ioremap_fullcache(physaddr, size)	(physaddr)
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 #define page_to_phys(page)      ((page - mem_map) << PAGE_SHIFT)
 #if 0
===== include/asm-x86_64/io.h 1.9 vs edited =====
--- 1.9/include/asm-x86_64/io.h	Fri Jul 11 13:34:21 2003
+++ edited/include/asm-x86_64/io.h	Thu Sep  4 10:40:18 2003
@@ -152,6 +152,7 @@
 {
 	return __ioremap(offset, size, 0);
 }
+#define ioremap_resource(res, off, size)	ioremap((res)->start + (off), (size))
 
 /*
  * This one maps high address device memory and turns off caching for that area.
