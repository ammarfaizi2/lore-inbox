Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbUJYH0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUJYH0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUJYH0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:26:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:9120 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261675AbUJYHZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:39 -0400
Date: Mon, 25 Oct 2004 09:23:49 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 1/17] 4level support for alpha
Message-ID: <417CAA05.mail3Y11100N0@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for alpha

alpha		works with 3 levels (thanks to viro for testing) 

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/alpha/mm/fault.c linux-2.6.10rc1-4level/arch/alpha/mm/fault.c
--- linux-2.6.10rc1/arch/alpha/mm/fault.c	2004-10-19 01:54:59.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/alpha/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -51,7 +51,7 @@ __load_new_mm_context(struct mm_struct *
 
 	pcb = &current_thread_info()->pcb;
 	pcb->asn = mmc & HARDWARE_ASN_MASK;
-	pcb->ptbr = ((unsigned long) next_mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
+	pcb->ptbr = ((unsigned long) next_mm->pml4 - IDENT_ADDR) >> PAGE_SHIFT;
 
 	__reload_thread(pcb);
 }
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/alpha/mm/init.c linux-2.6.10rc1-4level/arch/alpha/mm/init.c
--- linux-2.6.10rc1/arch/alpha/mm/init.c	2004-08-15 19:45:01.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/alpha/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -38,12 +38,12 @@ extern void die_if_kernel(char *,struct 
 static struct pcb_struct original_pcb;
 
 pgd_t *
-pgd_alloc(struct mm_struct *mm)
+__pgd_alloc(struct mm_struct *mm, pml4_t *dummy, unsigned long addr)
 {
 	pgd_t *ret, *init;
 
 	ret = (pgd_t *)__get_free_page(GFP_KERNEL);
-	init = pgd_offset(&init_mm, 0UL);
+	init = pml4_pgd_offset(pml4_offset_k(0UL), 0UL);
 	if (ret) {
 		clear_page(ret);
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
@@ -222,7 +222,7 @@ callback_init(void * kernel_end)
 	kernel_end = two_pages + 2*PAGE_SIZE;
 	memset(two_pages, 0, 2*PAGE_SIZE);
 
-	pgd = pgd_offset_k(VMALLOC_START);
+	pgd = pml4_pgd_offset(pml4_offset_k(VMALLOC_START), VMALLOC_START);
 	pgd_set(pgd, (pmd_t *)two_pages);
 	pmd = pmd_offset(pgd, VMALLOC_START);
 	pmd_set(pmd, (pte_t *)(two_pages + PAGE_SIZE));
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/alpha/mm/remap.c linux-2.6.10rc1-4level/arch/alpha/mm/remap.c
--- linux-2.6.10rc1/arch/alpha/mm/remap.c	2004-03-21 21:12:07.000000000 +0100
+++ linux-2.6.10rc1-4level/arch/alpha/mm/remap.c	2004-10-25 04:48:09.000000000 +0200
@@ -66,7 +66,7 @@ __alpha_remap_area_pages(unsigned long a
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	dir = pml4_pgd_offset(pml4_offset_k(address), address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-alpha/mmu_context.h linux-2.6.10rc1-4level/include/asm-alpha/mmu_context.h
--- linux-2.6.10rc1/include/asm-alpha/mmu_context.h	2004-10-19 01:55:31.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-alpha/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -236,7 +236,7 @@ init_new_context(struct task_struct *tsk
 			mm->context[i] = 0;
 	if (tsk != current)
 		tsk->thread_info->pcb.ptbr
-		  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
+		  = ((unsigned long)mm->pml4 - IDENT_ADDR) >> PAGE_SHIFT;
 	return 0;
 }
 
@@ -250,7 +250,7 @@ static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 	tsk->thread_info->pcb.ptbr
-	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
+	  = ((unsigned long)mm->pml4 - IDENT_ADDR) >> PAGE_SHIFT;
 }
 
 #ifdef __MMU_EXTERN_INLINE
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-alpha/page.h linux-2.6.10rc1-4level/include/asm-alpha/page.h
--- linux-2.6.10rc1/include/asm-alpha/page.h	2004-10-19 01:55:31.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-alpha/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -109,4 +109,6 @@ extern __inline__ int get_order(unsigned
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* _ALPHA_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-alpha/pgalloc.h linux-2.6.10rc1-4level/include/asm-alpha/pgalloc.h
--- linux-2.6.10rc1/include/asm-alpha/pgalloc.h	2004-08-15 19:45:44.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-alpha/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -29,8 +29,6 @@ pgd_populate(struct mm_struct *mm, pgd_t
 	pgd_set(pgd, pmd);
 }
 
-extern pgd_t *pgd_alloc(struct mm_struct *mm);
-
 static inline void
 pgd_free(pgd_t *pgd)
 {
@@ -77,4 +75,6 @@ pte_free(struct page *page)
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _ALPHA_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-alpha/pgtable.h linux-2.6.10rc1-4level/include/asm-alpha/pgtable.h
--- linux-2.6.10rc1/include/asm-alpha/pgtable.h	2004-10-25 04:47:34.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-alpha/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -38,7 +38,7 @@
 #define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PMD	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PGD	(1UL << (PAGE_SHIFT-3))
-#define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PGDS_IN_FIRST_PML4	(TASK_SIZE / PGDIR_SIZE)
 #define FIRST_USER_PGD_NR	0
 
 /* Number of pointers that fit on a page:  this will go away. */
@@ -269,12 +269,9 @@ extern inline pte_t pte_mkyoung(pte_t pt
 
 #define PAGE_DIR_OFFSET(tsk,address) pgd_offset((tsk),(address))
 
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
-
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address)	((address >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
-#define pgd_offset(mm, address)	((mm)->pgd+pgd_index(address))
+#define pgd_index_k(address) pgd_index(address)
 
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
@@ -349,4 +346,6 @@ extern void paging_init(void);
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* _ALPHA_PGTABLE_H */
