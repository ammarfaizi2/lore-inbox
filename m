Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSHSKSu>; Mon, 19 Aug 2002 06:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHSKSu>; Mon, 19 Aug 2002 06:18:50 -0400
Received: from holomorphy.com ([66.224.33.161]:59082 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318230AbSHSKSs>;
	Mon, 19 Aug 2002 06:18:48 -0400
Date: Mon, 19 Aug 2002 03:21:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@zip.com.au, gone@us.ibm.com,
       Martin.Bligh@us.ibm.com
Subject: 2.5.31 i386 mem_map usage corrections
Message-ID: <20020819102156.GJ18350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au,
	gone@us.ibm.com, Martin.Bligh@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With these fixes (modulo merging), most notably the fix for
pmd_populate(), I was able to boot and run userspace on a 16x/16G NUMA-Q
in combination with Pat Gaughen's x86 discontigmem patches.

The fundamental issue is that mem_map is assumed to start at pfn 0 and
provide a strictly linear mapping from pfn's to page numbers. The linear
relationship as well as starting pfn are broken by the discontigmem
bits, which start mem_map at PAGE_OFFSET. This at least corrects the
trivial offenders for the discontigmem case.

Remaining issues to be addressed are auditing the correctness of the
non-discontigmem i386 case, and determining whether the exec() path
calls rmap code with NULL mm's (the pte pages are tagged with the mm
at the time of pte instantiation) even with these fixes applied.

Against current 2.5.31 bk.


Cheers,
Bill

===== include/asm-i386/io.h 1.16 vs edited =====
--- 1.16/include/asm-i386/io.h	Mon Jun 17 18:52:02 2002
+++ edited/include/asm-i386/io.h	Mon Aug 19 06:13:39 2002
@@ -97,9 +97,9 @@
  * Change "struct page" to physical address.
  */
 #ifdef CONFIG_HIGHMEM64G
-#define page_to_phys(page)	((u64)(page - mem_map) << PAGE_SHIFT)
+#define page_to_phys(page)	((u64)page_to_pfn(page) << PAGE_SHIFT)
 #else
-#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
+#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 #endif
 
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
===== include/asm-i386/pci.h 1.15 vs edited =====
--- 1.15/include/asm-i386/pci.h	Mon Jun 10 14:54:11 2002
+++ edited/include/asm-i386/pci.h	Mon Aug 19 06:14:34 2002
@@ -109,7 +109,7 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	return (dma_addr_t)(page - mem_map) * PAGE_SIZE + offset;
+	return (dma_addr_t)page_to_pfn(page) * PAGE_SIZE + offset;
 }
 
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
@@ -238,9 +238,7 @@
 static __inline__ struct page *
 pci_dac_dma_to_page(struct pci_dev *pdev, dma64_addr_t dma_addr)
 {
-	unsigned long poff = (dma_addr >> PAGE_SHIFT);
-
-	return mem_map + poff;
+	return pfn_to_page(dma_addr >> PAGE_SHIFT);
 }
 
 static __inline__ unsigned long
===== include/asm-i386/pgalloc.h 1.16 vs edited =====
--- 1.16/include/asm-i386/pgalloc.h	Thu Jun  6 03:19:21 2002
+++ edited/include/asm-i386/pgalloc.h	Mon Aug 19 06:14:59 2002
@@ -13,7 +13,7 @@
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
 	set_pmd(pmd, __pmd(_PAGE_TABLE +
-		((unsigned long long)(pte - mem_map) <<
+		((unsigned long long)page_to_pfn(pte) <<
 			(unsigned long long) PAGE_SHIFT)));
 }
 /*
===== include/asm-i386/pgtable.h 1.17 vs edited =====
--- 1.17/include/asm-i386/pgtable.h	Mon Jun 17 20:14:46 2002
+++ edited/include/asm-i386/pgtable.h	Mon Aug 19 06:15:29 2002
@@ -234,8 +234,7 @@
 #define pmd_page_kernel(pmd) \
 ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
-#define pmd_page(pmd) \
-	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
+#define pmd_page(pmd)	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 
 #define pmd_large(pmd) \
 	((pmd_val(pmd) & (_PAGE_PSE|_PAGE_PRESENT)) == (_PAGE_PSE|_PAGE_PRESENT))
