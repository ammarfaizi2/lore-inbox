Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUJYHrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUJYHrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbUJYHqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:46:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:17824 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261688AbUJYHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:42 -0400
Date: Mon, 25 Oct 2004 09:23:50 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 13/17] 4level support for sh
Message-ID: <417CAA06.mail3ZK11VJ7Y@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for sh

Converted, but doesn't compile for other reasons

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh/mm/cache-sh4.c linux-2.6.10rc1-4level/arch/sh/mm/cache-sh4.c
--- linux-2.6.10rc1/arch/sh/mm/cache-sh4.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh/mm/cache-sh4.c	2004-10-25 04:48:09.000000000 +0200
@@ -301,7 +301,7 @@ void flush_cache_range(struct vm_area_st
 	unsigned long phys;
 	unsigned long d = 0;
 
-	dir = pgd_offset(vma->vm_mm, p);
+	dir = pml4_pgd_offset(pml4_offset(vma->vm_mm, p), p);
 	pmd = pmd_offset(dir, p);
 
 	do {
@@ -354,7 +354,7 @@ void flush_cache_page(struct vm_area_str
 	pte_t entry;
 	unsigned long phys;
 
-	dir = pgd_offset(vma->vm_mm, address);
+	dir = pml4_pgd_offset(pml4_offset(vma->vm_mm, address), address);
 	pmd = pmd_offset(dir, address);
 	if (pmd_none(*pmd) || pmd_bad(*pmd))
 		return;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh/mm/fault.c linux-2.6.10rc1-4level/arch/sh/mm/fault.c
--- linux-2.6.10rc1/arch/sh/mm/fault.c	2004-10-19 01:55:06.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -209,13 +209,13 @@ asmlinkage int __do_page_fault(struct pt
 #endif
 
 	if (address >= P3SEG && address < addrmax)
-		dir = pgd_offset_k(address);
+		dir = pml4_pgd_offset(pml4_offset_k(address), address);
 	else if (address >= TASK_SIZE)
 		return 1;
 	else if (!current->mm)
 		return 1;
 	else
-		dir = pgd_offset(current->mm, address);
+		dir = pml4_pgd_offset(pml4_offset(current->mm,address),address);
 
 	pmd = pmd_offset(dir, address);
 	if (pmd_none(*pmd))
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh/mm/hugetlbpage.c linux-2.6.10rc1-4level/arch/sh/mm/hugetlbpage.c
--- linux-2.6.10rc1/arch/sh/mm/hugetlbpage.c	2004-06-16 12:22:52.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh/mm/hugetlbpage.c	2004-10-25 04:48:09.000000000 +0200
@@ -30,7 +30,7 @@ static pte_t *huge_pte_alloc(struct mm_s
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pgd = pgd_offset(mm, addr);
+	pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 	if (pgd) {
 		pmd = pmd_alloc(mm, pgd, addr);
 		if (pmd)
@@ -45,7 +45,7 @@ static pte_t *huge_pte_offset(struct mm_
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pgd = pgd_offset(mm, addr);
+	pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 	if (pgd) {
 		pmd = pmd_offset(pgd, addr);
 		if (pmd)
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh/mm/init.c linux-2.6.10rc1-4level/arch/sh/mm/init.c
--- linux-2.6.10rc1/arch/sh/mm/init.c	2004-10-19 01:55:06.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -313,3 +313,14 @@ void free_initrd_mem(unsigned long start
 }
 #endif
 
+
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *dummy, unsigned long addr)
+{
+	unsigned int pgd_size = (USER_PTRS_PER_PGD * sizeof(pgd_t));
+	pgd_t *pgd = (pgd_t *)kmalloc(pgd_size, GFP_KERNEL);
+
+	if (pgd)
+		memset(pgd, 0, pgd_size);
+
+	return pgd;
+}
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh/mm/ioremap.c linux-2.6.10rc1-4level/arch/sh/mm/ioremap.c
--- linux-2.6.10rc1/arch/sh/mm/ioremap.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh/mm/ioremap.c	2004-10-25 04:48:09.000000000 +0200
@@ -75,7 +75,7 @@ int remap_area_pages(unsigned long addre
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset_k(address);
+	dir = pml4_pgd_offset(pml4_offset_k(address), address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh/mm/pg-sh4.c linux-2.6.10rc1-4level/arch/sh/mm/pg-sh4.c
--- linux-2.6.10rc1/arch/sh/mm/pg-sh4.c	2004-08-15 19:45:12.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh/mm/pg-sh4.c	2004-10-25 04:48:09.000000000 +0200
@@ -42,7 +42,7 @@ void clear_user_page(void *to, unsigned 
 					   _PAGE_HW_SHARED | _PAGE_FLAGS_HARD);
 		unsigned long phys_addr = PHYSADDR(to);
 		unsigned long p3_addr = P3SEG + (address & CACHE_ALIAS);
-		pgd_t *dir = pgd_offset_k(p3_addr);
+		pgd_t *dir = pml4_pgd_offset(pml4_offset_k(p3_addr), p3_addr);
 		pmd_t *pmd = pmd_offset(dir, p3_addr);
 		pte_t *pte = pte_offset_kernel(pmd, p3_addr);
 		pte_t entry;
@@ -81,7 +81,7 @@ void copy_user_page(void *to, void *from
 					   _PAGE_HW_SHARED | _PAGE_FLAGS_HARD);
 		unsigned long phys_addr = PHYSADDR(to);
 		unsigned long p3_addr = P3SEG + (address & CACHE_ALIAS);
-		pgd_t *dir = pgd_offset_k(p3_addr);
+		pgd_t *dir = pml4_pgd_offset(pml4_offset_k(p3_addr), p3_addr);
 		pmd_t *pmd = pmd_offset(dir, p3_addr);
 		pte_t *pte = pte_offset_kernel(pmd, p3_addr);
 		pte_t entry;
diff -urpN -X ../KDIFX linux-2.6.10rc1/drivers/macintosh/via-pmu.c linux-2.6.10rc1-4level/drivers/macintosh/via-pmu.c
--- linux-2.6.10rc1/drivers/macintosh/via-pmu.c	2004-10-19 01:55:14.000000000 +0200
+++ linux-2.6.10rc1-4level/drivers/macintosh/via-pmu.c	2004-10-25 04:48:10.000000000 +0200
@@ -2504,7 +2504,7 @@ powerbook_sleep_grackle(void)
  		_set_L2CR(save_l2cr);
 	
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
+	set_context(current->active_mm->context, (pml4_t *)current->active_mm->pml4);
 
 	/* Power things up */
 	pmu_unlock();
@@ -2604,7 +2604,7 @@ powerbook_sleep_Core99(void)
  		_set_L3CR(save_l3cr);
 	
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
+	set_context(current->active_mm->context, (pgd_t *)current->active_mm->pml4);
 
 	/* Tell PMU we are ready */
 	pmu_unlock();
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-parisc/cacheflush.h linux-2.6.10rc1-4level/include/asm-parisc/cacheflush.h
--- linux-2.6.10rc1/include/asm-parisc/cacheflush.h	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-parisc/cacheflush.h	2004-10-25 04:48:10.000000000 +0200
@@ -113,7 +113,7 @@ static inline void flush_cache_range(str
 static inline pte_t *__translation_exists(struct mm_struct *mm,
 					  unsigned long addr)
 {
-	pgd_t *pgd = pgd_offset(mm, addr);
+	pgd_t *pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 	pmd_t *pmd;
 	pte_t *pte;
 
@@ -155,7 +155,7 @@ flush_user_cache_page_non_current(struct
 	preempt_disable();
 
 	/* make us current */
-	mtctl(__pa(vma->vm_mm->pgd), 25);
+	mtctl(__pa(vma->vm_mm->pml4), 25);
 	mtsp(vma->vm_mm->context, 3);
 
 	flush_user_dcache_page(vmaddr);
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-s390/tlbflush.h linux-2.6.10rc1-4level/include/asm-s390/tlbflush.h
--- linux-2.6.10rc1/include/asm-s390/tlbflush.h	2004-03-21 21:11:56.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-s390/tlbflush.h	2004-10-25 04:48:10.000000000 +0200
@@ -105,7 +105,7 @@ static inline void __flush_tlb_mm(struct
 	if (MACHINE_HAS_IDTE) {
 		asm volatile (".insn rrf,0xb98e0000,0,%0,%1,0"
 			      : : "a" (2048),
-			      "a" (__pa(mm->pgd)&PAGE_MASK) : "cc" );
+			      "a" (__pa(mm->pml4)&PAGE_MASK) : "cc" );
 		return;
 	}
 	preempt_disable();
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sh/mmu_context.h linux-2.6.10rc1-4level/include/asm-sh/mmu_context.h
--- linux-2.6.10rc1/include/asm-sh/mmu_context.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sh/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -133,7 +133,7 @@ static __inline__ void switch_mm(struct 
 				 struct task_struct *tsk)
 {
 	if (likely(prev != next)) {
-		unsigned long __pgdir = (unsigned long)next->pgd;
+		unsigned long __pgdir = (unsigned long)next->pml4;
 
 		__asm__ __volatile__("mov.l	%0, %1"
 				     : /* no output */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sh/page.h linux-2.6.10rc1-4level/include/asm-sh/page.h
--- linux-2.6.10rc1/include/asm-sh/page.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sh/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -139,6 +139,8 @@ static __inline__ int get_order(unsigned
 
 #endif
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_SH_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sh/pgalloc.h linux-2.6.10rc1-4level/include/asm-sh/pgalloc.h
--- linux-2.6.10rc1/include/asm-sh/pgalloc.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sh/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -23,16 +23,6 @@ static inline void pmd_populate(struct m
 /*
  * Allocate and free page tables.
  */
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	unsigned int pgd_size = (USER_PTRS_PER_PGD * sizeof(pgd_t));
-	pgd_t *pgd = (pgd_t *)kmalloc(pgd_size, GFP_KERNEL);
-
-	if (pgd)
-		memset(pgd, 0, pgd_size);
-
-	return pgd;
-}
 
 static inline void pgd_free(pgd_t *pgd)
 {
@@ -90,4 +80,6 @@ static inline void pte_free(struct page 
 #define PG_mapped			PG_arch_1
 #endif
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* __ASM_SH_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sh/pgtable.h linux-2.6.10rc1-4level/include/asm-sh/pgtable.h
--- linux-2.6.10rc1/include/asm-sh/pgtable.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sh/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -41,7 +41,7 @@ extern unsigned long empty_zero_page[102
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PGDS_IN_LAST_PML4	(TASK_SIZE/PGDIR_SIZE)
 #define FIRST_USER_PGD_NR	0
 
 #define PTE_PHYS_MASK	0x1ffff000
@@ -231,10 +231,7 @@ static inline pte_t pte_modify(pte_t pte
 
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
-#define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
-
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+#define pgd_index_k(address) pgd_index(address)
 
 /* Find an entry in the third-level page table.. */
 #define pte_index(address) \
@@ -293,5 +290,7 @@ extern inline pte_t ptep_get_and_clear(p
 
 #include <asm-generic/pgtable.h>
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* __ASM_SH_PAGE_H */
 
