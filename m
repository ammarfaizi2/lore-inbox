Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUJYH37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUJYH37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUJYH2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:28:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:11936 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261680AbUJYHZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:40 -0400
Date: Mon, 25 Oct 2004 09:23:49 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 4/17] 4level support for cris
Message-ID: <417CAA05.mail3YC11QTD5@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for cris

cris		works (thanks to Mikael Starvik)

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/cris/arch-v10/mm/fault.c linux-2.6.10rc1-4level/arch/cris/arch-v10/mm/fault.c
--- linux-2.6.10rc1/arch/cris/arch-v10/mm/fault.c	2004-06-16 12:22:42.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/cris/arch-v10/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -24,7 +24,7 @@
 #define D(x)
 #endif
 
-extern volatile pgd_t *current_pgd;
+extern volatile pml4_t *current_pml4;
 
 extern const struct exception_table_entry
 	*search_exception_tables(unsigned long addr);
@@ -92,7 +92,7 @@ handle_mmu_bus_fault(struct pt_regs *reg
 		 * refer through current_pgd, dont use mm->pgd
 		 */
 
-		pmd = (pmd_t *)(current_pgd + pgd_index(address));
+		pmd = (pmd_t *)(current_pml4 + pgd_index(address));
 		if (pmd_none(*pmd)) {
 			do_page_fault(address, regs, 0, writeac);
 			return;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/cris/arch-v10/mm/init.c linux-2.6.10rc1-4level/arch/cris/arch-v10/mm/init.c
--- linux-2.6.10rc1/arch/cris/arch-v10/mm/init.c	2004-10-19 01:55:00.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/cris/arch-v10/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -37,12 +37,12 @@ paging_init(void)
 	for(i = 0; i < PTRS_PER_PGD; i++)
 		swapper_pg_dir[i] = __pgd(0);
 	
-	/* make sure the current pgd table points to something sane
+	/* make sure the current pml4 table points to something sane
 	 * (even if it is most probably not used until the next 
 	 *  switch_mm)
 	 */
 
-	current_pgd = init_mm.pgd;
+	current_pml4 = init_mm.pml4;
 
 	/* initialise the TLB (tlb.c) */
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/cris/arch-v10/mm/tlb.c linux-2.6.10rc1-4level/arch/cris/arch-v10/mm/tlb.c
--- linux-2.6.10rc1/arch/cris/arch-v10/mm/tlb.c	2004-06-16 12:22:42.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/cris/arch-v10/mm/tlb.c	2004-10-25 04:48:09.000000000 +0200
@@ -225,7 +225,7 @@ switch_mm(struct mm_struct *prev, struct
 	 * the pgd.
 	 */
 
-	current_pgd = next->pgd;
+	current_pml4 = next->pml4;
 
 	/* switch context in the MMU */
 	
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/cris/mm/fault.c linux-2.6.10rc1-4level/arch/cris/mm/fault.c
--- linux-2.6.10rc1/arch/cris/mm/fault.c	2004-06-16 12:22:42.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/cris/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -118,7 +118,7 @@ extern void die_if_kernel(const char *, 
 
 /* current active page directory */
 
-volatile pgd_t *current_pgd;
+volatile pml4_t *current_pml4;
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -337,7 +337,7 @@ vmalloc_fault:
 		 * Synchronize this task's top level page-table
 		 * with the 'reference' page table.
 		 *
-		 * Use current_pgd instead of tsk->active_mm->pgd
+		 * Use current_pml4 instead of tsk->active_mm->pgd
 		 * since the latter might be unavailable if this
 		 * code is executed in a misfortunately run irq
 		 * (like inside schedule() between switch_mm and
@@ -349,9 +349,9 @@ vmalloc_fault:
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 
-		pgd = (pgd_t *)current_pgd + offset;
-		pgd_k = init_mm.pgd + offset;
-
+		pgd = (pgd_t *)current_pml4 + offset;
+		pgd_k = ((pgd_t *)(init_mm.pml4)) + offset;
+ 
 		/* Since we're two-level, we don't need to do both
 		 * set_pgd and set_pmd (they do the same thing). If
 		 * we go three-level at some point, do the right thing
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/cris/mm/ioremap.c linux-2.6.10rc1-4level/arch/cris/mm/ioremap.c
--- linux-2.6.10rc1/arch/cris/mm/ioremap.c	2004-06-16 12:22:42.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/cris/mm/ioremap.c	2004-10-25 04:48:09.000000000 +0200
@@ -71,7 +71,7 @@ static int remap_area_pages(unsigned lon
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	dir = pml4_pgd_offset(pml4_offset(&init_mm, address), address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-cris/mmu_context.h linux-2.6.10rc1-4level/include/asm-cris/mmu_context.h
--- linux-2.6.10rc1/include/asm-cris/mmu_context.h	2004-03-21 21:11:57.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-cris/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -11,11 +11,11 @@ extern void switch_mm(struct mm_struct *
 
 #define activate_mm(prev,next) switch_mm((prev),(next),NULL)
 
-/* current active pgd - this is similar to other processors pgd 
+/* current active pml4 - this is similar to other processors pgd 
  * registers like cr3 on the i386
  */
 
-extern volatile pgd_t *current_pgd;   /* defined in arch/cris/mm/fault.c */
+extern volatile pml4_t *current_pml4;   /* defined in arch/cris/mm/fault.c */
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-cris/page.h linux-2.6.10rc1-4level/include/asm-cris/page.h
--- linux-2.6.10rc1/include/asm-cris/page.h	2004-06-16 12:23:24.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-cris/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -95,6 +95,7 @@ static inline int get_order(unsigned lon
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#include <asm-generic/nopml4-page.h>
 
 #endif /* __KERNEL__ */
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-cris/pgalloc.h linux-2.6.10rc1-4level/include/asm-cris/pgalloc.h
--- linux-2.6.10rc1/include/asm-cris/pgalloc.h	2004-03-21 21:11:57.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-cris/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -12,9 +12,9 @@
  * Allocate and free page tables.
  */
 
-extern inline pgd_t *pgd_alloc (struct mm_struct *mm)
+extern inline pgd_t *__pgd_alloc (struct mm_struct *mm, pml4_t *pml4, unsigned long address)
 {
-	return (pgd_t *)get_zeroed_page(GFP_KERNEL);
+ 	return (pgd_t *)get_zeroed_page(GFP_KERNEL);
 }
 
 extern inline void pgd_free (pgd_t *pgd)
@@ -64,4 +64,6 @@ extern inline void pte_free(struct page 
 
 #define check_pgt_cache()          do { } while (0)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-cris/pgtable.h linux-2.6.10rc1-4level/include/asm-cris/pgtable.h
--- linux-2.6.10rc1/include/asm-cris/pgtable.h	2004-06-16 12:23:24.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-cris/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -272,12 +272,7 @@ extern inline void pmd_set(pmd_t * pmdp,
 
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
-
-/* to find an entry in a page-table-directory */
-extern inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long address)
-{
-	return mm->pgd + pgd_index(address);
-}
+#define pgd_index_k(addr) pgd_index(addr)
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
@@ -344,5 +339,8 @@ extern inline void update_mmu_cache(stru
 #define pte_to_pgoff(x)	(pte_val(x) >> 6)
 #define pgoff_to_pte(x)	__pte(((x) << 6) | _PAGE_FILE)
 
+#include <asm-generic/pgtable.h>
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* __ASSEMBLY__ */
 #endif /* _CRIS_PGTABLE_H */
