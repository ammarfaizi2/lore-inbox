Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbUJYHk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbUJYHk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUJYHk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:40:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:14240 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261683AbUJYHZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:41 -0400
Date: Mon, 25 Oct 2004 09:23:49 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 7/17] 4level support for ia64
Message-ID: <417CAA05.mail3YQ1IU38Z@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for ia64

ia64		works with 3 levels 

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ia64/mm/fault.c linux-2.6.10rc1-4level/arch/ia64/mm/fault.c
--- linux-2.6.10rc1/arch/ia64/mm/fault.c	2004-10-25 04:47:13.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ia64/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -54,7 +54,7 @@ mapped_kernel_page_is_present (unsigned 
 	pmd_t *pmd;
 	pte_t *ptep, pte;
 
-	pgd = pgd_offset_k(address);
+	pgd = pml4_pgd_offset_k(pml4_offset_k(address), address);
 	if (pgd_none(*pgd) || pgd_bad(*pgd))
 		return 0;
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ia64/mm/hugetlbpage.c linux-2.6.10rc1-4level/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.10rc1/arch/ia64/mm/hugetlbpage.c	2004-08-15 19:45:05.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ia64/mm/hugetlbpage.c	2004-10-25 04:48:09.000000000 +0200
@@ -28,11 +28,13 @@ static pte_t *
 huge_pte_alloc (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pgd = pgd_offset(mm, taddr);
+	pml4 = pml4_offset(mm, taddr);
+	pgd = pml4_pgd_offset(pml4, taddr);
 	pmd = pmd_alloc(mm, pgd, taddr);
 	if (pmd)
 		pte = pte_alloc_map(mm, pmd, taddr);
@@ -43,11 +45,13 @@ static pte_t *
 huge_pte_offset (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pgd = pgd_offset(mm, taddr);
+	pml4 = pml4_offset(mm, taddr);
+	pgd = pml4_pgd_offset(pml4, taddr);
 	if (pgd_present(*pgd)) {
 		pmd = pmd_offset(pgd, taddr);
 		if (pmd_present(*pmd))
@@ -187,7 +191,7 @@ void hugetlb_free_pgtables(struct mmu_ga
 {
 	unsigned long first = start & HUGETLB_PGDIR_MASK;
 	unsigned long last = end + HUGETLB_PGDIR_SIZE - 1;
-	unsigned long start_index, end_index;
+	unsigned long start_pml4_index, start_pgd_index;
 	struct mm_struct *mm = tlb->mm;
 
 	if (!prev) {
@@ -211,23 +215,25 @@ void hugetlb_free_pgtables(struct mmu_ga
 			if (last > next->vm_start)
 				last = next->vm_start;
 		}
-		if (prev->vm_end > first)
+		if (prev->vm_end > first) {
 			first = prev->vm_end + HUGETLB_PGDIR_SIZE - 1;
+			/* mm version cheecks for TASK_SIZE here. Needed too? -AK */
+		}
 		break;
 	}
 no_mmaps:
-	if (last < first)	/* for arches with discontiguous pgd indices */
+	if (last < first)	/* for arches with discontiguous indices */
 		return;
-	/*
-	 * If the PGD bits are not consecutive in the virtual address, the
-	 * old method of shifting the VA >> by PGDIR_SHIFT doesn't work.
-	 */
-
-	start_index = pgd_index(htlbpage_to_page(first));
-	end_index = pgd_index(htlbpage_to_page(last));
-
-	if (end_index > start_index) {
-		clear_page_tables(tlb, start_index, end_index - start_index);
+	start_pml4_index = pml4_index(htlbpage_to_page(first));
+	start_pgd_index = pgd_index(htlbpage_to_page(first));
+	if (start_pml4_index == 0 && start_pgd_index < FIRST_USER_PGD_NR) { 
+		start_pgd_index = FIRST_USER_PGD_NR;
+		first = start_pgd_index * PGDIR_SIZE;
+	}
+	if (pml4_index(htlbpage_to_page(last)) > start_pml4_index || 
+	    pgd_index(htlbpage_to_page(last)) > start_pgd_index) {
+		clear_page_range(tlb, first, last);
+		flush_tlb_pgtables(mm, first & PML4_MASK, last & PML4_MASK);
 	}
 }
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ia64/mm/init.c linux-2.6.10rc1-4level/arch/ia64/mm/init.c
--- linux-2.6.10rc1/arch/ia64/mm/init.c	2004-10-25 04:47:13.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ia64/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -232,8 +232,7 @@ put_kernel_page (struct page *page, unsi
 		printk(KERN_ERR "put_kernel_page: page at 0x%p not in reserved memory\n",
 		       page_address(page));
 
-	pgd = pgd_offset_k(address);		/* note: this is NOT pgd_offset()! */
-
+	pgd = pml4_pgd_offset_k(pml4_offset_k(address), address);
 	spin_lock(&init_mm.page_table_lock);
 	{
 		pmd = pmd_alloc(&init_mm, pgd, address);
@@ -380,7 +379,7 @@ create_mem_map_page_table (u64 start, u6
 	node = paddr_to_nid(__pa(start));
 
 	for (address = start_page; address < end_page; address += PAGE_SIZE) {
-		pgd = pgd_offset_k(address);
+		pgd = pml4_pgd_offset_k(pml4_offset_k(address), address);
 		if (pgd_none(*pgd))
 			pgd_populate(&init_mm, pgd, alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE));
 		pmd = pmd_offset(pgd, address);
@@ -590,3 +589,16 @@ mem_init (void)
 	ia32_mem_init();
 #endif
 }
+
+pgd_t *__pgd_alloc (struct mm_struct *mm, pml4_t *dummy, unsigned long address)
+{
+	/* the VM system never calls pgd_alloc_one_fast(), so we do it here. */
+	pgd_t *pgd = pgd_alloc_one_fast(mm);
+
+	if (unlikely(pgd == NULL)) {
+		pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+		if (likely(pgd != NULL))
+			clear_page(pgd);
+	}
+	return pgd;
+}
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ia64/mmu_context.h linux-2.6.10rc1-4level/include/asm-ia64/mmu_context.h
--- linux-2.6.10rc1/include/asm-ia64/mmu_context.h	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ia64/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -160,7 +160,7 @@ activate_mm (struct mm_struct *prev, str
 	 * We may get interrupts here, but that's OK because interrupt handlers cannot
 	 * touch user-space.
 	 */
-	ia64_set_kr(IA64_KR_PT_BASE, __pa(next->pgd));
+	ia64_set_kr(IA64_KR_PT_BASE, __pa(next->pml4));
 	activate_context(next);
 }
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ia64/page.h linux-2.6.10rc1-4level/include/asm-ia64/page.h
--- linux-2.6.10rc1/include/asm-ia64/page.h	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ia64/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -146,6 +146,7 @@ get_order (unsigned long size)
 }
 
 # endif /* __KERNEL__ */
+
 #endif /* !__ASSEMBLY__ */
 
 #ifdef STRICT_MM_TYPECHECKS
@@ -193,4 +194,7 @@ get_order (unsigned long size)
 					 (((current->personality & READ_IMPLIES_EXEC) != 0)	\
 					  ? VM_EXEC : 0))
 
+
+#include <asm-generic/nopml4-page.h>
+
 #endif /* _ASM_IA64_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ia64/pgalloc.h linux-2.6.10rc1-4level/include/asm-ia64/pgalloc.h
--- linux-2.6.10rc1/include/asm-ia64/pgalloc.h	2004-08-15 19:45:47.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ia64/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -54,20 +54,6 @@ pgd_alloc_one_fast (struct mm_struct *mm
 	return (pgd_t *) ret;
 }
 
-static inline pgd_t*
-pgd_alloc (struct mm_struct *mm)
-{
-	/* the VM system never calls pgd_alloc_one_fast(), so we do it here. */
-	pgd_t *pgd = pgd_alloc_one_fast(mm);
-
-	if (unlikely(pgd == NULL)) {
-		pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-		if (likely(pgd != NULL))
-			clear_page(pgd);
-	}
-	return pgd;
-}
-
 static inline void
 pgd_free (pgd_t *pgd)
 {
@@ -174,4 +160,6 @@ pte_free_kernel (pte_t *pte)
 
 extern void check_pgt_cache (void);
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _ASM_IA64_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ia64/pgtable.h linux-2.6.10rc1-4level/include/asm-ia64/pgtable.h
--- linux-2.6.10rc1/include/asm-ia64/pgtable.h	2004-10-25 04:47:36.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ia64/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -92,7 +92,7 @@
 #define PGDIR_SIZE		(__IA64_UL(1) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(__IA64_UL(1) << (PAGE_SHIFT-3))
-#define USER_PTRS_PER_PGD	(5*PTRS_PER_PGD/8)	/* regions 0-4 are user regions */
+#define USER_PTRS_IN_LAST_PML4	(5*PTRS_PER_PGD/8)	/* regions 0-4 are user regions */
 #define FIRST_USER_PGD_NR	0
 
 /*
@@ -308,23 +308,15 @@ pgd_index (unsigned long address)
 	return (region << (PAGE_SHIFT - 6)) | l1index;
 }
 
-/* The offset in the 1-level directory is given by the 3 region bits
-   (61..63) and the seven level-1 bits (33-39).  */
-static inline pgd_t*
-pgd_offset (struct mm_struct *mm, unsigned long address)
-{
-	return mm->pgd + pgd_index(address);
-}
-
-/* In the kernel's mapped region we have a full 43 bit space available and completely
-   ignore the region number (since we know its in region number 5). */
-#define pgd_offset_k(addr) \
-	(init_mm.pgd + (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)))
+/* In the kernel's mapped region we have a full 43 bit space available
+   and completely ignore the region number (since we know its in region
+   number 5). */
+#define pgd_index_k(addr) (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 
 /* Look up a pgd entry in the gate area.  On IA-64, the gate-area
    resides in the kernel-mapped segment, hence we use pgd_offset_k()
    here.  */
-#define pgd_offset_gate(mm, addr)	pgd_offset_k(addr)
+#define pml4_offset_gate(mm, addr)	pml4_pgd_offset_k(pml4_offset_k(addr),addr)
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir,addr) \
@@ -562,4 +554,6 @@ do {											\
 #define __HAVE_ARCH_PGD_OFFSET_GATE
 #include <asm-generic/pgtable.h>
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* _ASM_IA64_PGTABLE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ia64/tlb.h linux-2.6.10rc1-4level/include/asm-ia64/tlb.h
--- linux-2.6.10rc1/include/asm-ia64/tlb.h	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ia64/tlb.h	2004-10-25 04:48:10.000000000 +0200
@@ -236,4 +236,10 @@ do {							\
 	__pmd_free_tlb(tlb, ptep);			\
 } while (0)
 
+#define pgd_free_tlb(tlb, pgdp)				\
+do {							\
+	tlb->need_flush = 1;				\
+	__pgd_free_tlb(tlb, pgdp);			\
+} while (0)
+
 #endif /* _ASM_IA64_TLB_H */
