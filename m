Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUIXC2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUIXC2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUIXCZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:25:00 -0400
Received: from holomorphy.com ([207.189.100.168]:1500 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267312AbUIXCV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:21:27 -0400
Date: Thu, 23 Sep 2004 19:21:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Fusco <fusco_john@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 2/4] convert io_remap_page_range() to call remap_pfn_range()
Message-ID: <20040924022123.GN9106@holomorphy.com>
References: <41535AAE.6090700@yahoo.com> <20040924021735.GL9106@holomorphy.com> <20040924021954.GM9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924021954.GM9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 07:19:54PM -0700, William Lee Irwin III wrote:
> Convert remap_page_range() to remap_pfn_range(), with a temporary
> remap_page_range() wrapper inline (to be eliminated in the sequel).

Eliminate callers of remap_page_range() via io_remap_page_range().

Index: mm2-2.6.9-rc2/include/asm-ia64/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-ia64/pgtable.h	2004-09-12 22:32:00.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-ia64/pgtable.h	2004-09-23 17:03:29.491560730 -0700
@@ -452,7 +452,9 @@
 #define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 3)
 #define pgoff_to_pte(off)		((pte_t) { ((off) << 2) | _PAGE_FILE })
 
-#define io_remap_page_range remap_page_range	/* XXX is this right? */
+/* XXX is this right? */
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
Index: mm2-2.6.9-rc2/include/asm-arm/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-arm/pgtable.h	2004-09-12 22:31:58.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-arm/pgtable.h	2004-09-23 17:03:29.494560274 -0700
@@ -412,7 +412,7 @@
  * into virtual address `from'
  */
 #define io_remap_page_range(vma,from,phys,size,prot) \
-		remap_page_range(vma,from,phys,size,prot)
+		remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
 
 #define pgtable_cache_init() do { } while (0)
 
Index: mm2-2.6.9-rc2/include/asm-x86_64/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-x86_64/pgtable.h	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-x86_64/pgtable.h	2004-09-23 17:03:29.496559970 -0700
@@ -421,7 +421,8 @@
 
 extern int kern_addr_valid(unsigned long addr); 
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define HAVE_ARCH_UNMAPPED_AREA
 
Index: mm2-2.6.9-rc2/include/asm-ppc64/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-ppc64/pgtable.h	2004-09-22 21:31:14.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-ppc64/pgtable.h	2004-09-23 17:03:29.500559362 -0700
@@ -492,7 +492,8 @@
  */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range 
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 void pgtable_cache_init(void);
 
Index: mm2-2.6.9-rc2/include/asm-parisc/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-parisc/pgtable.h	2004-09-12 22:33:23.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-parisc/pgtable.h	2004-09-23 17:03:29.503558906 -0700
@@ -505,7 +505,8 @@
 
 #endif /* !__ASSEMBLY__ */
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /* We provide our own get_unmapped_area to provide cache coherency */
 
Index: mm2-2.6.9-rc2/include/asm-sh/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-sh/pgtable.h	2004-09-12 22:33:39.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-sh/pgtable.h	2004-09-23 17:03:29.505558602 -0700
@@ -274,7 +274,8 @@
 
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+	remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm2-2.6.9-rc2/include/asm-h8300/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-h8300/pgtable.h	2004-09-12 22:32:26.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-h8300/pgtable.h	2004-09-23 17:03:29.507558298 -0700
@@ -50,7 +50,8 @@
  * No page table caches to initialise
  */
 #define pgtable_cache_init()   do { } while (0)
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * All 32bit addresses are effectively valid for vmalloc...
Index: mm2-2.6.9-rc2/include/asm-i386/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-i386/pgtable.h	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-i386/pgtable.h	2004-09-23 17:03:29.510557842 -0700
@@ -404,7 +404,8 @@
 #define kern_addr_valid(addr)	(1)
 #endif /* !CONFIG_DISCONTIGMEM */
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
Index: mm2-2.6.9-rc2/include/asm-mips/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-mips/pgtable.h	2004-09-12 22:31:59.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-mips/pgtable.h	2004-09-23 17:03:29.512557538 -0700
@@ -245,7 +245,8 @@
  */
 #define HAVE_ARCH_UNMAPPED_AREA
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm2-2.6.9-rc2/include/asm-arm26/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-arm26/pgtable.h	2004-09-12 22:31:31.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-arm26/pgtable.h	2004-09-23 17:03:29.515557082 -0700
@@ -288,7 +288,7 @@
  * into virtual address `from'
  */
 #define io_remap_page_range(vma,from,phys,size,prot) \
-		remap_page_range(vma,from,phys,size,prot)
+		remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
 
 #endif /* !__ASSEMBLY__ */
 
Index: mm2-2.6.9-rc2/include/asm-ppc/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-ppc/pgtable.h	2004-09-12 22:31:57.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-ppc/pgtable.h	2004-09-23 17:03:29.518556626 -0700
@@ -714,7 +714,8 @@
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm2-2.6.9-rc2/include/asm-m32r/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-m32r/pgtable.h	2004-09-22 21:31:14.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-m32r/pgtable.h	2004-09-23 17:03:29.530554802 -0700
@@ -408,7 +408,8 @@
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
Index: mm2-2.6.9-rc2/include/asm-sh64/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-sh64/pgtable.h	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-sh64/pgtable.h	2004-09-23 17:03:29.533554346 -0700
@@ -479,7 +479,8 @@
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 #endif /* !__ASSEMBLY__ */
 
 /*
Index: mm2-2.6.9-rc2/include/asm-m68knommu/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-m68knommu/pgtable.h	2004-09-12 22:32:54.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-m68knommu/pgtable.h	2004-09-23 17:03:29.535554042 -0700
@@ -54,7 +54,8 @@
  * No page table caches to initialise.
  */
 #define pgtable_cache_init()	do { } while (0)
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * All 32bit addresses are effectively valid for vmalloc...
Index: mm2-2.6.9-rc2/include/asm-m68k/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-m68k/pgtable.h	2004-09-12 22:33:23.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-m68k/pgtable.h	2004-09-23 17:03:29.537553738 -0700
@@ -138,7 +138,8 @@
 
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /* MMU-specific headers */
 
Index: mm2-2.6.9-rc2/include/asm-alpha/pgtable.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/asm-alpha/pgtable.h	2004-09-12 22:31:59.000000000 -0700
+++ mm2-2.6.9-rc2/include/asm-alpha/pgtable.h	2004-09-23 17:03:29.540553282 -0700
@@ -328,7 +328,7 @@
 #endif
 
 #define io_remap_page_range(vma, start, busaddr, size, prot) \
-    remap_page_range(vma, start, virt_to_phys((void *)__ioremap(busaddr, size)), size, prot)
+    remap_pfn_range(vma, start, virt_to_phys((void *)__ioremap(busaddr, size)) >> PAGE_SHIFT, size, prot)
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
