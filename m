Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUCRXwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUCRXwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:52:02 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32467 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263330AbUCRX1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:27:40 -0500
Date: Thu, 18 Mar 2004 23:27:33 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: [PATCH] anobjrmap 6/6 cleanup
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403182326170.16928-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 6/6 remove remnants of pte_chain rmap

Cleanup, mostly of arch headers: only bother with this patch
if you're sure pte_chain rmap is finished.  No special page table
initialization is needed for full objrmap (though it can still be
helpful in debugging).  But ppc and ppc64 have come to rely on it for
their ptep_test_and_clear_young, so reinstate there.  Delete pte_addr_t
from asm/pgtable.h, KM_PTE2 from asm/kmap_types.h; delete asm/rmap.h.

 arch/arm/mm/mm-armv.c           |    3 -
 arch/ppc/mm/pgtable.c           |   28 ++++++++----
 arch/ppc64/mm/hugetlbpage.c     |    3 -
 arch/ppc64/mm/tlb.c             |    4 -
 include/asm-alpha/pgtable.h     |    2 
 include/asm-alpha/rmap.h        |    7 ---
 include/asm-arm/kmap_types.h    |    1 
 include/asm-arm/pgtable.h       |    2 
 include/asm-arm/rmap.h          |    6 --
 include/asm-arm26/pgtable.h     |    2 
 include/asm-arm26/rmap.h        |   66 -----------------------------
 include/asm-cris/pgtable.h      |    2 
 include/asm-cris/rmap.h         |    7 ---
 include/asm-generic/rmap.h      |   90 ----------------------------------------
 include/asm-h8300/pgtable.h     |    2 
 include/asm-i386/kmap_types.h   |    1 
 include/asm-i386/pgtable.h      |   12 -----
 include/asm-i386/rmap.h         |   21 ---------
 include/asm-ia64/pgtable.h      |    2 
 include/asm-ia64/rmap.h         |    7 ---
 include/asm-m68k/pgtable.h      |    2 
 include/asm-m68k/rmap.h         |    7 ---
 include/asm-m68knommu/pgtable.h |    2 
 include/asm-m68knommu/rmap.h    |    2 
 include/asm-mips/kmap_types.h   |    1 
 include/asm-mips/pgtable-32.h   |    6 --
 include/asm-mips/pgtable-64.h   |    2 
 include/asm-mips/rmap.h         |    7 ---
 include/asm-parisc/pgtable.h    |    2 
 include/asm-parisc/rmap.h       |    7 ---
 include/asm-ppc/pgtable.h       |    2 
 include/asm-ppc/rmap.h          |    9 ----
 include/asm-ppc64/pgalloc.h     |   31 ++++++++++---
 include/asm-ppc64/pgtable.h     |    2 
 include/asm-ppc64/rmap.h        |    9 ----
 include/asm-s390/pgtable.h      |    2 
 include/asm-s390/rmap.h         |    7 ---
 include/asm-sh/pgtable.h        |    2 
 include/asm-sh/rmap.h           |    7 ---
 include/asm-sparc/kmap_types.h  |    1 
 include/asm-sparc/pgtable.h     |    2 
 include/asm-sparc/rmap.h        |    7 ---
 include/asm-sparc64/pgtable.h   |    2 
 include/asm-sparc64/rmap.h      |    7 ---
 include/asm-um/pgtable.h        |   12 -----
 include/asm-um/rmap.h           |    6 --
 include/asm-v850/pgtable.h      |    2 
 include/asm-v850/rmap.h         |    1 
 include/asm-x86_64/pgtable.h    |    2 
 include/asm-x86_64/rmap.h       |    7 ---
 mm/memory.c                     |    6 --
 51 files changed, 48 insertions(+), 384 deletions(-)

--- anobjrmap5/arch/arm/mm/mm-armv.c	2004-03-11 01:56:10.000000000 +0000
+++ anobjrmap6/arch/arm/mm/mm-armv.c	2004-03-18 21:27:38.330064664 +0000
@@ -19,7 +19,6 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/page.h>
-#include <asm/rmap.h>
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/tlbflush.h>
@@ -232,7 +231,7 @@ void free_pgd_slow(pgd_t *pgd)
 
 	pte = pmd_page(*pmd);
 	pmd_clear(pmd);
-	pgtable_remove_rmap(pte);
+	dec_page_state(nr_page_table_pages);
 	pte_free(pte);
 	pmd_free(pmd);
 free:
--- anobjrmap5/arch/ppc/mm/pgtable.c	2004-02-18 03:00:06.000000000 +0000
+++ anobjrmap6/arch/ppc/mm/pgtable.c	2004-03-18 21:27:38.331064512 +0000
@@ -86,9 +86,14 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 	extern int mem_init_done;
 	extern void *early_get_page(void);
 
-	if (mem_init_done)
+	if (mem_init_done) {
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	else
+		if (pte) {
+			struct page *ptepage = virt_to_page(pte);
+			ptepage->mapping = (void *) mm;
+			ptepage->index = address & PMD_MASK;
+		}
+	} else
 		pte = (pte_t *)early_get_page();
 	if (pte)
 		clear_page(pte);
@@ -97,7 +102,7 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 
 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *pte;
+	struct page *ptepage;
 
 #ifdef CONFIG_HIGHPTE
 	int flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT;
@@ -105,10 +110,13 @@ struct page *pte_alloc_one(struct mm_str
 	int flags = GFP_KERNEL | __GFP_REPEAT;
 #endif
 
-	pte = alloc_pages(flags, 0);
-	if (pte)
-		clear_highpage(pte);
-	return pte;
+	ptepage = alloc_pages(flags, 0);
+	if (ptepage) {
+		ptepage->mapping = (void *) mm;
+		ptepage->index = address & PMD_MASK;
+		clear_highpage(ptepage);
+	}
+	return ptepage;
 }
 
 void pte_free_kernel(pte_t *pte)
@@ -116,15 +124,17 @@ void pte_free_kernel(pte_t *pte)
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
+	virt_to_page(pte)->mapping = NULL;
 	free_page((unsigned long)pte);
 }
 
-void pte_free(struct page *pte)
+void pte_free(struct page *ptepage)
 {
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
-	__free_page(pte);
+	ptepage->mapping = NULL;
+	__free_page(ptepage);
 }
 
 #ifndef CONFIG_44x
--- anobjrmap5/arch/ppc64/mm/hugetlbpage.c	2004-03-11 01:56:09.000000000 +0000
+++ anobjrmap6/arch/ppc64/mm/hugetlbpage.c	2004-03-18 21:27:38.333064208 +0000
@@ -25,7 +25,6 @@
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/tlb.h>
-#include <asm/rmap.h>
 
 #include <linux/sysctl.h>
 
@@ -273,7 +272,7 @@ static int open_32bit_htlbpage_range(str
 			}
 
 			pmd_clear(pmd);
-			pgtable_remove_rmap(page);
+			dec_page_state(nr_page_table_pages);
 			pte_free(page);
 		}
 	}
--- anobjrmap5/arch/ppc64/mm/tlb.c	2004-03-11 01:56:13.000000000 +0000
+++ anobjrmap6/arch/ppc64/mm/tlb.c	2004-03-18 21:27:38.334064056 +0000
@@ -31,7 +31,6 @@
 #include <asm/tlb.h>
 #include <asm/hardirq.h>
 #include <linux/highmem.h>
-#include <asm/rmap.h>
 
 DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
@@ -59,7 +58,8 @@ void hpte_update(pte_t *ptep, unsigned l
 
 	ptepage = virt_to_page(ptep);
 	mm = (struct mm_struct *) ptepage->mapping;
-	addr = ptep_to_address(ptep);
+	addr = ptepage->index +
+		(((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
 
 	if (REGION_ID(addr) == USER_REGION_ID)
 		context = mm->context.id;
--- anobjrmap5/include/asm-alpha/pgtable.h	2003-10-08 20:24:56.000000000 +0100
+++ anobjrmap6/include/asm-alpha/pgtable.h	2004-03-18 21:27:38.335063904 +0000
@@ -349,6 +349,4 @@ extern void paging_init(void);
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
 
-typedef pte_t *pte_addr_t;
-
 #endif /* _ALPHA_PGTABLE_H */
--- anobjrmap5/include/asm-alpha/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-alpha/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _ALPHA_RMAP_H
-#define _ALPHA_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-arm/kmap_types.h	2004-01-09 06:00:24.000000000 +0000
+++ anobjrmap6/include/asm-arm/kmap_types.h	2004-03-18 21:27:38.345062384 +0000
@@ -14,7 +14,6 @@ enum km_type {
 	KM_BIO_DST_IRQ,
 	KM_PTE0,
 	KM_PTE1,
-	KM_PTE2,
 	KM_IRQ0,
 	KM_IRQ1,
 	KM_SOFTIRQ0,
--- anobjrmap5/include/asm-arm/pgtable.h	2004-01-09 06:00:23.000000000 +0000
+++ anobjrmap6/include/asm-arm/pgtable.h	2004-03-18 21:27:38.346062232 +0000
@@ -353,8 +353,6 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD
 #define io_remap_page_range(vma,from,phys,size,prot) \
 		remap_page_range(vma,from,phys,size,prot)
 
-typedef pte_t *pte_addr_t;
-
 #define pgtable_cache_init() do { } while (0)
 
 #endif /* !__ASSEMBLY__ */
--- anobjrmap5/include/asm-arm/rmap.h	2002-08-01 22:17:36.000000000 +0100
+++ anobjrmap6/include/asm-arm/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,6 +0,0 @@
-#ifndef _ARM_RMAP_H
-#define _ARM_RMAP_H
-
-#include <asm-generic/rmap.h>
-
-#endif /* _ARM_RMAP_H */
--- anobjrmap5/include/asm-arm26/pgtable.h	2003-10-08 20:24:55.000000000 +0100
+++ anobjrmap6/include/asm-arm26/pgtable.h	2004-03-18 21:27:38.348061928 +0000
@@ -290,8 +290,6 @@ static inline pte_t mk_pte_phys(unsigned
 #define io_remap_page_range(vma,from,phys,size,prot) \
 		remap_page_range(vma,from,phys,size,prot)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASMARM_PGTABLE_H */
--- anobjrmap5/include/asm-arm26/rmap.h	2003-06-14 20:18:58.000000000 +0100
+++ anobjrmap6/include/asm-arm26/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,66 +0,0 @@
-#ifndef _ARM_RMAP_H
-#define _ARM_RMAP_H
-
-/*
- * linux/include/asm-arm26/proc-armv/rmap.h
- *
- * Architecture dependant parts of the reverse mapping code,
- *
- * ARM is different since hardware page tables are smaller than
- * the page size and Linux uses a "duplicate" one with extra info.
- * For rmap this means that the first 2 kB of a page are the hardware
- * page tables and the last 2 kB are the software page tables.
- */
-
-static inline void pgtable_add_rmap(struct page *page, struct mm_struct * mm, unsigned long address)
-{
-        page->mapping = (void *)mm;
-        page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
-        inc_page_state(nr_page_table_pages);
-}
-
-static inline void pgtable_remove_rmap(struct page *page)
-{
-        page->mapping = NULL;
-        page->index = 0;
-        dec_page_state(nr_page_table_pages);
-}
-
-static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
-{
-	struct page * page = virt_to_page(ptep);
-        return (struct mm_struct *)page->mapping;
-}
-
-/* The page table takes half of the page */
-#define PTE_MASK  ((PAGE_SIZE / 2) - 1)
-
-static inline unsigned long ptep_to_address(pte_t * ptep)
-{
-        struct page * page = virt_to_page(ptep);
-        unsigned long low_bits;
-
-        low_bits = ((unsigned long)ptep & PTE_MASK) * PTRS_PER_PTE;
-        return page->index + low_bits;
-}
- 
-//FIXME!!! IS these correct?
-static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
-{
-        return (pte_addr_t)ptep;
-}
-
-static inline pte_t *rmap_ptep_map(pte_addr_t pte_paddr)
-{
-        return (pte_t *)pte_paddr;
-}
-
-static inline void rmap_ptep_unmap(pte_t *pte)
-{
-        return;
-}
-
-
-//#include <asm-generic/rmap.h>
-
-#endif /* _ARM_RMAP_H */
--- anobjrmap5/include/asm-cris/pgtable.h	2003-07-10 21:16:26.000000000 +0100
+++ anobjrmap6/include/asm-cris/pgtable.h	2004-03-18 21:27:38.350061624 +0000
@@ -337,6 +337,4 @@ extern inline void update_mmu_cache(stru
 #define pte_to_pgoff(x)	(pte_val(x) >> 6)
 #define pgoff_to_pte(x)	__pte(((x) << 6) | _PAGE_FILE)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* _CRIS_PGTABLE_H */
--- anobjrmap5/include/asm-cris/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-cris/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _CRIS_RMAP_H
-#define _CRIS_RMAP_H
-
-/* nothing to see, move along :) */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-generic/rmap.h	2003-05-27 02:01:29.000000000 +0100
+++ anobjrmap6/include/asm-generic/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,90 +0,0 @@
-#ifndef _GENERIC_RMAP_H
-#define _GENERIC_RMAP_H
-/*
- * linux/include/asm-generic/rmap.h
- *
- * Architecture dependent parts of the reverse mapping code,
- * this version should work for most architectures with a
- * 'normal' page table layout.
- *
- * We use the struct page of the page table page to find out
- * the process and full address of a page table entry:
- * - page->mapping points to the process' mm_struct
- * - page->index has the high bits of the address
- * - the lower bits of the address are calculated from the
- *   offset of the page table entry within the page table page
- *
- * For CONFIG_HIGHPTE, we need to represent the address of a pte in a
- * scalar pte_addr_t.  The pfn of the pte's page is shifted left by PAGE_SIZE
- * bits and is then ORed with the byte offset of the pte within its page.
- *
- * For CONFIG_HIGHMEM4G, the pte_addr_t is 32 bits.  20 for the pfn, 12 for
- * the offset.
- *
- * For CONFIG_HIGHMEM64G, the pte_addr_t is 64 bits.  52 for the pfn, 12 for
- * the offset.
- */
-#include <linux/mm.h>
-
-static inline void pgtable_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
-{
-#ifdef BROKEN_PPC_PTE_ALLOC_ONE
-	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
-	extern int mem_init_done;
-
-	if (!mem_init_done)
-		return;
-#endif
-	page->mapping = (void *)mm;
-	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
-	inc_page_state(nr_page_table_pages);
-}
-
-static inline void pgtable_remove_rmap(struct page * page)
-{
-	page->mapping = NULL;
-	page->index = 0;
-	dec_page_state(nr_page_table_pages);
-}
-
-static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
-{
-	struct page * page = kmap_atomic_to_page(ptep);
-	return (struct mm_struct *) page->mapping;
-}
-
-static inline unsigned long ptep_to_address(pte_t * ptep)
-{
-	struct page * page = kmap_atomic_to_page(ptep);
-	unsigned long low_bits;
-	low_bits = ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
-	return page->index + low_bits;
-}
-
-#ifdef CONFIG_HIGHPTE
-static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
-{
-	pte_addr_t paddr;
-	paddr = ((pte_addr_t)page_to_pfn(kmap_atomic_to_page(ptep))) << PAGE_SHIFT;
-	return paddr + (pte_addr_t)((unsigned long)ptep & ~PAGE_MASK);
-}
-#else
-static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
-{
-	return (pte_addr_t)ptep;
-}
-#endif
-
-#ifndef CONFIG_HIGHPTE
-static inline pte_t *rmap_ptep_map(pte_addr_t pte_paddr)
-{
-	return (pte_t *)pte_paddr;
-}
-
-static inline void rmap_ptep_unmap(pte_t *pte)
-{
-	return;
-}
-#endif
-
-#endif /* _GENERIC_RMAP_H */
--- anobjrmap5/include/asm-h8300/pgtable.h	2003-08-09 05:44:10.000000000 +0100
+++ anobjrmap6/include/asm-h8300/pgtable.h	2004-03-18 21:27:38.355060864 +0000
@@ -7,8 +7,6 @@
 #include <asm/page.h>
 #include <asm/io.h>
 
-typedef pte_t *pte_addr_t;
-
 #define pgd_present(pgd)     (1)       /* pages are always present on NO_MM */
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
--- anobjrmap5/include/asm-i386/kmap_types.h	2003-05-27 02:01:30.000000000 +0100
+++ anobjrmap6/include/asm-i386/kmap_types.h	2004-03-18 21:27:38.356060712 +0000
@@ -19,7 +19,6 @@ D(5)	KM_BIO_SRC_IRQ,
 D(6)	KM_BIO_DST_IRQ,
 D(7)	KM_PTE0,
 D(8)	KM_PTE1,
-D(9)	KM_PTE2,
 D(10)	KM_IRQ0,
 D(11)	KM_IRQ1,
 D(12)	KM_SOFTIRQ0,
--- anobjrmap5/include/asm-i386/pgtable.h	2004-03-16 07:00:20.000000000 +0000
+++ anobjrmap6/include/asm-i386/pgtable.h	2004-03-18 21:27:38.357060560 +0000
@@ -308,18 +308,6 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_unmap_nested(pte) do { } while (0)
 #endif
 
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM4G)
-typedef u32 pte_addr_t;
-#endif
-
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM64G)
-typedef u64 pte_addr_t;
-#endif
-
-#if !defined(CONFIG_HIGHPTE)
-typedef pte_t *pte_addr_t;
-#endif
-
 /*
  * The i386 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
--- anobjrmap5/include/asm-i386/rmap.h	2002-09-16 03:19:56.000000000 +0100
+++ anobjrmap6/include/asm-i386/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,21 +0,0 @@
-#ifndef _I386_RMAP_H
-#define _I386_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#ifdef CONFIG_HIGHPTE
-static inline pte_t *rmap_ptep_map(pte_addr_t pte_paddr)
-{
-	unsigned long pfn = (unsigned long)(pte_paddr >> PAGE_SHIFT);
-	unsigned long off = ((unsigned long)pte_paddr) & ~PAGE_MASK;
-	return (pte_t *)((char *)kmap_atomic(pfn_to_page(pfn), KM_PTE2) + off);
-}
-
-static inline void rmap_ptep_unmap(pte_t *pte)
-{
-	kunmap_atomic(pte, KM_PTE2);
-}
-#endif
-
-#endif
--- anobjrmap5/include/asm-ia64/pgtable.h	2004-02-04 02:45:17.000000000 +0000
+++ anobjrmap6/include/asm-ia64/pgtable.h	2004-03-18 21:27:38.359060256 +0000
@@ -468,8 +468,6 @@ extern void hugetlb_free_pgtables(struct
 	struct vm_area_struct * prev, unsigned long start, unsigned long end);
 #endif
 
-typedef pte_t *pte_addr_t;
-
 /*
  * IA-64 doesn't have any external MMU info: the page tables contain all the necessary
  * information.  However, we use this routine to take care of any (delayed) i-cache
--- anobjrmap5/include/asm-ia64/rmap.h	2002-08-27 20:28:05.000000000 +0100
+++ anobjrmap6/include/asm-ia64/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _ASM_IA64_RMAP_H
-#define _ASM_IA64_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif /* _ASM_IA64_RMAP_H */
--- anobjrmap5/include/asm-m68k/pgtable.h	2004-02-04 02:45:41.000000000 +0000
+++ anobjrmap6/include/asm-m68k/pgtable.h	2004-03-18 21:27:38.361059952 +0000
@@ -168,8 +168,6 @@ static inline void update_mmu_cache(stru
 	    ? (__pgprot((pgprot_val(prot) & _CACHEMASK040) | _PAGE_NOCACHE_S))	\
 	    : (prot)))
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 /*
--- anobjrmap5/include/asm-m68k/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-m68k/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _M68K_RMAP_H
-#define _M68K_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-m68knommu/pgtable.h	2003-05-27 02:01:29.000000000 +0100
+++ anobjrmap6/include/asm-m68knommu/pgtable.h	2004-03-18 21:27:38.362059800 +0000
@@ -11,8 +11,6 @@
 #include <asm/page.h>
 #include <asm/io.h>
 
-typedef pte_t *pte_addr_t;
-
 /*
  * Trivial page table functions.
  */
--- anobjrmap5/include/asm-m68knommu/rmap.h	2002-11-04 21:31:04.000000000 +0000
+++ anobjrmap6/include/asm-m68knommu/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,2 +0,0 @@
-/* Do not need anything here */
-
--- anobjrmap5/include/asm-mips/kmap_types.h	2003-07-02 22:00:48.000000000 +0100
+++ anobjrmap6/include/asm-mips/kmap_types.h	2004-03-18 21:27:38.364059496 +0000
@@ -19,7 +19,6 @@ D(5)	KM_BIO_SRC_IRQ,
 D(6)	KM_BIO_DST_IRQ,
 D(7)	KM_PTE0,
 D(8)	KM_PTE1,
-D(9)	KM_PTE2,
 D(10)	KM_IRQ0,
 D(11)	KM_IRQ1,
 D(12)	KM_SOFTIRQ0,
--- anobjrmap5/include/asm-mips/pgtable-32.h	2004-03-11 01:56:09.000000000 +0000
+++ anobjrmap6/include/asm-mips/pgtable-32.h	2004-03-18 21:27:38.365059344 +0000
@@ -216,10 +216,4 @@ static inline pmd_t *pmd_offset(pgd_t *d
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#ifdef CONFIG_64BIT_PHYS_ADDR
-typedef u64 pte_addr_t;
-#else
-typedef pte_t *pte_addr_t;
-#endif
-
 #endif /* _ASM_PGTABLE_32_H */
--- anobjrmap5/include/asm-mips/pgtable-64.h	2004-03-11 01:56:07.000000000 +0000
+++ anobjrmap6/include/asm-mips/pgtable-64.h	2004-03-18 21:27:38.365059344 +0000
@@ -214,6 +214,4 @@ static inline pte_t mk_swap_pte(unsigned
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #endif /* _ASM_PGTABLE_64_H */
--- anobjrmap5/include/asm-mips/rmap.h	2003-07-02 22:00:11.000000000 +0100
+++ anobjrmap6/include/asm-mips/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef __ASM_RMAP_H
-#define __ASM_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif /* __ASM_RMAP_H */
--- anobjrmap5/include/asm-parisc/pgtable.h	2004-02-04 02:45:42.000000000 +0000
+++ anobjrmap6/include/asm-parisc/pgtable.h	2004-03-18 21:27:38.367059040 +0000
@@ -450,8 +450,6 @@ static inline void ptep_mkdirty(pte_t *p
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define io_remap_page_range remap_page_range
--- anobjrmap5/include/asm-parisc/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-parisc/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _PARISC_RMAP_H
-#define _PARISC_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-ppc/pgtable.h	2004-02-18 03:00:06.000000000 +0000
+++ anobjrmap6/include/asm-ppc/pgtable.h	2004-03-18 21:27:38.369058736 +0000
@@ -670,8 +670,6 @@ extern void kernel_set_cachemode (unsign
  */
 #define pgtable_cache_init()	do { } while (0)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
--- anobjrmap5/include/asm-ppc/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-ppc/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,9 +0,0 @@
-#ifndef _PPC_RMAP_H
-#define _PPC_RMAP_H
-
-/* PPC calls pte_alloc() before mem_map[] is setup ... */
-#define BROKEN_PPC_PTE_ALLOC_ONE
-
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-ppc64/pgalloc.h	2004-02-04 02:45:16.000000000 +0000
+++ anobjrmap6/include/asm-ppc64/pgalloc.h	2004-03-18 21:27:38.371058432 +0000
@@ -48,28 +48,43 @@ pmd_free(pmd_t *pmd)
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))
 
 static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
+pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
+	pte_t *pte;
+	pte = kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
+	if (pte) {
+		struct page *ptepage = virt_to_page(pte);
+		ptepage->mapping = (void *) mm;
+		ptepage->index = address & PMD_MASK;
+	}
+	return pte;
 }
 
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = pte_alloc_one_kernel(mm, address);
-
-	if (pte)
-		return virt_to_page(pte);
-
+	pte_t *pte;
+	pte = kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
+	if (pte) {
+		struct page *ptepage = virt_to_page(pte);
+		ptepage->mapping = (void *) mm;
+		ptepage->index = address & PMD_MASK;
+		return ptepage;
+	}
 	return NULL;
 }
 		
 static inline void pte_free_kernel(pte_t *pte)
 {
+	virt_to_page(pte)->mapping = NULL;
 	kmem_cache_free(zero_cache, pte);
 }
 
-#define pte_free(pte_page)	pte_free_kernel(page_address(pte_page))
+static inline void pte_free(struct page *ptepage)
+{
+	ptepage->mapping = NULL;
+	kmem_cache_free(zero_cache, page_address(ptepage));
+}
 
 struct pte_freelist_batch
 {
--- anobjrmap5/include/asm-ppc64/pgtable.h	2004-03-11 01:56:12.000000000 +0000
+++ anobjrmap6/include/asm-ppc64/pgtable.h	2004-03-18 21:27:38.372058280 +0000
@@ -488,8 +488,6 @@ extern struct vm_struct * im_get_area(un
 			int region_type);
 unsigned long im_free(void *addr);
 
-typedef pte_t *pte_addr_t;
-
 long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 			      unsigned long va, unsigned long prpn,
 			      int secondary, unsigned long hpteflags,
--- anobjrmap5/include/asm-ppc64/rmap.h	2002-07-24 22:03:39.000000000 +0100
+++ anobjrmap6/include/asm-ppc64/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,9 +0,0 @@
-#ifndef _PPC64_RMAP_H
-#define _PPC64_RMAP_H
-
-/* PPC64 calls pte_alloc() before mem_map[] is setup ... */
-#define BROKEN_PPC_PTE_ALLOC_ONE
-
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-s390/pgtable.h	2004-02-04 02:45:37.000000000 +0000
+++ anobjrmap6/include/asm-s390/pgtable.h	2004-03-18 21:27:38.375057824 +0000
@@ -764,8 +764,6 @@ extern inline pte_t mk_swap_pte(unsigned
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #ifndef __s390x__
 # define PTE_FILE_MAX_BITS	26
 #else /* __s390x__ */
--- anobjrmap5/include/asm-s390/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-s390/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _S390_RMAP_H
-#define _S390_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-sh/pgtable.h	2004-02-04 02:45:43.000000000 +0000
+++ anobjrmap6/include/asm-sh/pgtable.h	2004-03-18 21:27:38.376057672 +0000
@@ -263,8 +263,6 @@ extern void update_mmu_cache(struct vm_a
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)	(1)
--- anobjrmap5/include/asm-sh/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-sh/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _SH_RMAP_H
-#define _SH_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-sparc/kmap_types.h	2004-01-09 06:00:23.000000000 +0000
+++ anobjrmap6/include/asm-sparc/kmap_types.h	2004-03-18 21:27:38.378057368 +0000
@@ -11,7 +11,6 @@ enum km_type {
 	KM_BIO_DST_IRQ,
 	KM_PTE0,
 	KM_PTE1,
-	KM_PTE2,
 	KM_IRQ0,
 	KM_IRQ1,
 	KM_SOFTIRQ0,
--- anobjrmap5/include/asm-sparc/pgtable.h	2004-02-18 03:00:07.000000000 +0000
+++ anobjrmap6/include/asm-sparc/pgtable.h	2004-03-18 21:27:38.379057216 +0000
@@ -490,8 +490,6 @@ extern int io_remap_page_range(struct vm
 
 #include <asm-generic/pgtable.h>
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !(__ASSEMBLY__) */
 
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
--- anobjrmap5/include/asm-sparc/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-sparc/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _SPARC_RMAP_H
-#define _SPARC_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-sparc64/pgtable.h	2004-01-09 06:00:23.000000000 +0000
+++ anobjrmap6/include/asm-sparc64/pgtable.h	2004-03-18 21:27:38.380057064 +0000
@@ -384,8 +384,6 @@ extern unsigned long get_fb_unmapped_are
 
 extern void check_pgt_cache(void);
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC64_PGTABLE_H) */
--- anobjrmap5/include/asm-sparc64/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ anobjrmap6/include/asm-sparc64/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _SPARC64_RMAP_H
-#define _SPARC64_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-um/pgtable.h	2003-10-08 20:24:57.000000000 +0100
+++ anobjrmap6/include/asm-um/pgtable.h	2004-03-18 21:27:38.382056760 +0000
@@ -384,18 +384,6 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define pte_unmap(pte) kunmap_atomic((pte), KM_PTE0)
 #define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
 
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM4G)
-typedef u32 pte_addr_t;
-#endif
-
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM64G)
-typedef u64 pte_addr_t;
-#endif
-
-#if !defined(CONFIG_HIGHPTE)
-typedef pte_t *pte_addr_t;
-#endif
-
 #define update_mmu_cache(vma,address,pte) do ; while (0)
 
 /* Encode and de-code a swap entry */
--- anobjrmap5/include/asm-um/rmap.h	2002-09-16 03:20:25.000000000 +0100
+++ anobjrmap6/include/asm-um/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,6 +0,0 @@
-#ifndef __UM_RMAP_H
-#define __UM_RMAP_H
-
-#include "asm/arch/rmap.h"
-
-#endif
--- anobjrmap5/include/asm-v850/pgtable.h	2002-11-04 21:31:04.000000000 +0000
+++ anobjrmap6/include/asm-v850/pgtable.h	2004-03-18 21:27:38.384056456 +0000
@@ -5,8 +5,6 @@
 #include <asm/page.h>
 
 
-typedef pte_t *pte_addr_t;
-
 #define pgd_present(pgd)	(1) /* pages are always present on NO_MM */
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
--- anobjrmap5/include/asm-v850/rmap.h	2002-11-04 21:31:04.000000000 +0000
+++ anobjrmap6/include/asm-v850/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1 +0,0 @@
-/* Do not need anything here */
--- anobjrmap5/include/asm-x86_64/pgtable.h	2004-03-11 01:56:11.000000000 +0000
+++ anobjrmap6/include/asm-x86_64/pgtable.h	2004-03-18 21:27:38.386056152 +0000
@@ -390,8 +390,6 @@ extern inline pte_t pte_modify(pte_t pte
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 extern int kern_addr_valid(unsigned long addr); 
--- anobjrmap5/include/asm-x86_64/rmap.h	2002-10-16 04:29:25.000000000 +0100
+++ anobjrmap6/include/asm-x86_64/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _X8664_RMAP_H
-#define _X8664_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/mm/memory.c	2004-03-18 21:27:15.351557928 +0000
+++ anobjrmap6/mm/memory.c	2004-03-18 21:27:38.388055848 +0000
@@ -48,7 +48,6 @@
 #include <linux/init.h>
 
 #include <asm/pgalloc.h>
-#include <asm/rmap.h>
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -105,7 +104,7 @@ static inline void free_one_pmd(struct m
 	}
 	page = pmd_page(*dir);
 	pmd_clear(dir);
-	pgtable_remove_rmap(page);
+	dec_page_state(nr_page_table_pages);
 	pte_free_tlb(tlb, page);
 }
 
@@ -164,7 +163,7 @@ pte_t fastcall * pte_alloc_map(struct mm
 			pte_free(new);
 			goto out;
 		}
-		pgtable_add_rmap(new, mm, address);
+		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
 out:
@@ -190,7 +189,6 @@ pte_t fastcall * pte_alloc_kernel(struct
 			pte_free_kernel(new);
 			goto out;
 		}
-		pgtable_add_rmap(virt_to_page(new), mm, address);
 		pmd_populate_kernel(mm, pmd, new);
 	}
 out:

