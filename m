Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269267AbUIYHyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269267AbUIYHyl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269270AbUIYHyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:54:09 -0400
Received: from holomorphy.com ([207.189.100.168]:742 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269267AbUIYHxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:53:33 -0400
Date: Sat, 25 Sep 2004 00:53:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 4/6] convert users of remap_page_range() under include/asm-*/ to use remap_pfn_range()
Message-ID: <20040925075328.GH9106@holomorphy.com>
References: <20040925074445.GD9106@holomorphy.com> <20040925074712.GE9106@holomorphy.com> <20040925074915.GF9106@holomorphy.com> <20040925075102.GG9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925075102.GG9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:51:02AM -0700, William Lee Irwin III wrote:
> This patch converts all callers of remap_page_range() under arch/ and
> net/ to use remap_pfn_range() instead.

This patch converts uses of remap_page_range() via io_remap_page_range()
in include/asm-*/ to use remap_pfn_range(). io_remap_page_range() has a
similar physical address overflow issue that needs to be addressed later.


Index: mm3-2.6.9-rc2/include/asm-alpha/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-alpha/pgtable.h	2004-09-25 00:15:52.645769136 -0700
+++ mm3-2.6.9-rc2/include/asm-alpha/pgtable.h	2004-09-25 00:24:00.869547840 -0700
@@ -328,7 +328,7 @@
 #endif
 
 #define io_remap_page_range(vma, start, busaddr, size, prot) \
-    remap_page_range(vma, start, virt_to_phys((void *)__ioremap(busaddr, size)), size, prot)
+    remap_pfn_range(vma, start, virt_to_phys((void *)__ioremap(busaddr, size)) >> PAGE_SHIFT, size, prot)
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
Index: mm3-2.6.9-rc2/include/asm-arm/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-arm/pgtable.h	2004-09-25 00:15:53.175688576 -0700
+++ mm3-2.6.9-rc2/include/asm-arm/pgtable.h	2004-09-25 00:24:08.254425168 -0700
@@ -412,7 +412,7 @@
  * into virtual address `from'
  */
 #define io_remap_page_range(vma,from,phys,size,prot) \
-		remap_page_range(vma,from,phys,size,prot)
+		remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
 
 #define pgtable_cache_init() do { } while (0)
 
Index: mm3-2.6.9-rc2/include/asm-arm26/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-arm26/pgtable.h	2004-09-25 00:15:52.418803640 -0700
+++ mm3-2.6.9-rc2/include/asm-arm26/pgtable.h	2004-09-25 00:24:05.602828272 -0700
@@ -288,7 +288,7 @@
  * into virtual address `from'
  */
 #define io_remap_page_range(vma,from,phys,size,prot) \
-		remap_page_range(vma,from,phys,size,prot)
+		remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
 
 #endif /* !__ASSEMBLY__ */
 
Index: mm3-2.6.9-rc2/include/asm-h8300/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-h8300/pgtable.h	2004-09-25 00:15:52.500791176 -0700
+++ mm3-2.6.9-rc2/include/asm-h8300/pgtable.h	2004-09-25 00:24:11.947863680 -0700
@@ -50,7 +50,8 @@
  * No page table caches to initialise
  */
 #define pgtable_cache_init()   do { } while (0)
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * All 32bit addresses are effectively valid for vmalloc...
Index: mm3-2.6.9-rc2/include/asm-i386/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-i386/pgtable.h	2004-09-25 00:15:52.570780536 -0700
+++ mm3-2.6.9-rc2/include/asm-i386/pgtable.h	2004-09-25 00:24:15.331349312 -0700
@@ -404,7 +404,8 @@
 #define kern_addr_valid(addr)	(1)
 #endif /* !CONFIG_DISCONTIGMEM */
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
Index: mm3-2.6.9-rc2/include/asm-ia64/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-ia64/pgtable.h	2004-09-25 00:15:53.354661368 -0700
+++ mm3-2.6.9-rc2/include/asm-ia64/pgtable.h	2004-09-25 00:26:25.331586272 -0700
@@ -452,7 +452,9 @@
 #define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 3)
 #define pgoff_to_pte(off)		((pte_t) { ((off) << 2) | _PAGE_FILE })
 
-#define io_remap_page_range remap_page_range	/* XXX is this right? */
+/* XXX is this right? */
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
Index: mm3-2.6.9-rc2/include/asm-m32r/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-m32r/pgtable.h	2004-09-25 00:15:52.258827960 -0700
+++ mm3-2.6.9-rc2/include/asm-m32r/pgtable.h	2004-09-25 00:26:29.748914736 -0700
@@ -408,7 +408,8 @@
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
Index: mm3-2.6.9-rc2/include/asm-m68k/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-m68k/pgtable.h	2004-09-25 00:15:52.948723080 -0700
+++ mm3-2.6.9-rc2/include/asm-m68k/pgtable.h	2004-09-25 00:26:38.698554184 -0700
@@ -138,7 +138,8 @@
 
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /* MMU-specific headers */
 
Index: mm3-2.6.9-rc2/include/asm-m68knommu/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-m68knommu/pgtable.h	2004-09-25 00:15:52.805744816 -0700
+++ mm3-2.6.9-rc2/include/asm-m68knommu/pgtable.h	2004-09-25 00:26:33.911281960 -0700
@@ -54,7 +54,8 @@
  * No page table caches to initialise.
  */
 #define pgtable_cache_init()	do { } while (0)
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * All 32bit addresses are effectively valid for vmalloc...
Index: mm3-2.6.9-rc2/include/asm-mips/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-mips/pgtable.h	2004-09-25 00:15:53.022711832 -0700
+++ mm3-2.6.9-rc2/include/asm-mips/pgtable.h	2004-09-25 00:26:43.204869120 -0700
@@ -245,7 +245,8 @@
  */
 #define HAVE_ARCH_UNMAPPED_AREA
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm3-2.6.9-rc2/include/asm-parisc/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-parisc/pgtable.h	2004-09-25 00:15:53.233679760 -0700
+++ mm3-2.6.9-rc2/include/asm-parisc/pgtable.h	2004-09-25 00:26:46.632348064 -0700
@@ -505,7 +505,8 @@
 
 #endif /* !__ASSEMBLY__ */
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /* We provide our own get_unmapped_area to provide cache coherency */
 
Index: mm3-2.6.9-rc2/include/asm-ppc/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-ppc/pgtable.h	2004-09-25 00:15:52.878733720 -0700
+++ mm3-2.6.9-rc2/include/asm-ppc/pgtable.h	2004-09-25 00:26:56.175897224 -0700
@@ -714,7 +714,8 @@
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm3-2.6.9-rc2/include/asm-ppc64/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-ppc64/pgtable.h	2004-09-25 00:15:53.290671096 -0700
+++ mm3-2.6.9-rc2/include/asm-ppc64/pgtable.h	2004-09-25 00:26:52.666430744 -0700
@@ -492,7 +492,8 @@
  */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range 
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 void pgtable_cache_init(void);
 
Index: mm3-2.6.9-rc2/include/asm-sh/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-sh/pgtable.h	2004-09-25 00:15:52.336816104 -0700
+++ mm3-2.6.9-rc2/include/asm-sh/pgtable.h	2004-09-25 00:27:27.159187048 -0700
@@ -274,7 +274,8 @@
 
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm3-2.6.9-rc2/include/asm-sh64/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-sh64/pgtable.h	2004-09-25 00:15:52.732755912 -0700
+++ mm3-2.6.9-rc2/include/asm-sh64/pgtable.h	2004-09-25 00:27:00.543233288 -0700
@@ -479,7 +479,8 @@
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 #endif /* !__ASSEMBLY__ */
 
 /*
Index: mm3-2.6.9-rc2/include/asm-x86_64/pgtable.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/asm-x86_64/pgtable.h	2004-09-25 00:15:53.098700280 -0700
+++ mm3-2.6.9-rc2/include/asm-x86_64/pgtable.h	2004-09-25 00:27:52.830284448 -0700
@@ -421,7 +421,8 @@
 
 extern int kern_addr_valid(unsigned long addr); 
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define HAVE_ARCH_UNMAPPED_AREA
 
