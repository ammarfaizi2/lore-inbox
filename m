Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUJYHpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUJYHpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUJYHli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:41:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:16032 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261685AbUJYHZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:41 -0400
Date: Mon, 25 Oct 2004 09:23:50 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 11/17] 4level support for ppc64
Message-ID: <417CAA06.mail3ZA1191K6@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for ppc64

ppc64		works with 3 levels (thanks to dwmw2) 

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc64/kernel/eeh.c linux-2.6.10rc1-4level/arch/ppc64/kernel/eeh.c
--- linux-2.6.10rc1/arch/ppc64/kernel/eeh.c	2004-10-19 01:55:05.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc64/kernel/eeh.c	2004-10-25 04:48:09.000000000 +0200
@@ -342,7 +342,7 @@ static inline unsigned long eeh_token_to
 	pte_t *ptep;
 	unsigned long pa;
 
-	ptep = find_linux_pte(ioremap_mm.pgd, token);
+	ptep = find_linux_pte((pgd_t *)ioremap_mm.pml4, token);
 	if (!ptep)
 		return token;
 	pa = pte_pfn(*ptep) << PAGE_SHIFT;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc64/kernel/process.c linux-2.6.10rc1-4level/arch/ppc64/kernel/process.c
--- linux-2.6.10rc1/arch/ppc64/kernel/process.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc64/kernel/process.c	2004-10-25 04:48:09.000000000 +0200
@@ -58,7 +58,7 @@ struct task_struct *last_task_used_altiv
 #endif
 
 struct mm_struct ioremap_mm = {
-	.pgd		= ioremap_dir,
+	.pml4		= (pml4_t *)ioremap_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
 	.cpu_vm_mask	= CPU_MASK_ALL,
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc64/mm/hash_utils.c linux-2.6.10rc1-4level/arch/ppc64/mm/hash_utils.c
--- linux-2.6.10rc1/arch/ppc64/mm/hash_utils.c	2004-10-19 01:55:06.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc64/mm/hash_utils.c	2004-10-25 04:48:09.000000000 +0200
@@ -315,7 +315,7 @@ int hash_page(unsigned long ea, unsigned
 		break;
 	}
 
-	pgdir = mm->pgd;
+	pgdir = (pgd_t *)mm->pml4;
 
 	if (pgdir == NULL)
 		return 1;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc64/mm/hugetlbpage.c linux-2.6.10rc1-4level/arch/ppc64/mm/hugetlbpage.c
--- linux-2.6.10rc1/arch/ppc64/mm/hugetlbpage.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc64/mm/hugetlbpage.c	2004-10-25 04:48:09.000000000 +0200
@@ -91,7 +91,7 @@ static hugepte_t *hugepte_alloc(struct m
 
 	BUG_ON(!in_hugepage_area(mm->context, addr));
 
-	pgd = pgd_offset(mm, addr);
+	pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 	pmd = pmd_alloc(mm, pgd, addr);
 
 	/* We shouldn't find a (normal) PTE page pointer here */
@@ -107,7 +107,7 @@ static hugepte_t *hugepte_offset(struct 
 
 	BUG_ON(!in_hugepage_area(mm->context, addr));
 
-	pgd = pgd_offset(mm, addr);
+	pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 	if (pgd_none(*pgd))
 		return NULL;
 
@@ -189,7 +189,7 @@ static int prepare_low_seg_for_htlb(stru
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
 	for (addr = start; addr < end; addr += PMD_SIZE) {
-		pgd_t *pgd = pgd_offset(mm, addr);
+		pgd_t *pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 		pmd_t *pmd;
 		struct page *page;
 		pte_t *pte;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc64/mm/init.c linux-2.6.10rc1-4level/arch/ppc64/mm/init.c
--- linux-2.6.10rc1/arch/ppc64/mm/init.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc64/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -853,7 +853,7 @@ void update_mmu_cache(struct vm_area_str
 	if (!pte_young(pte))
 		return;
 
-	pgdir = vma->vm_mm->pgd;
+	pgdir = (pgd_t *)vma->vm_mm->pml4;
 	if (pgdir == NULL)
 		return;
 
@@ -904,3 +904,8 @@ void pgtable_cache_init(void)
 	if (!zero_cache)
 		panic("pgtable_cache_init(): could not create zero_cache!\n");
 }
+
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *dummy, unsigned long address)
+{
+	return kmem_cache_alloc(zero_cache, GFP_KERNEL);
+}
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ppc64/page.h linux-2.6.10rc1-4level/include/asm-ppc64/page.h
--- linux-2.6.10rc1/include/asm-ppc64/page.h	2004-10-19 01:55:34.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ppc64/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -236,5 +236,7 @@ extern int page_is_ram(unsigned long pfn
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __KERNEL__ */
 #endif /* _PPC64_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ppc64/pgalloc.h linux-2.6.10rc1-4level/include/asm-ppc64/pgalloc.h
--- linux-2.6.10rc1/include/asm-ppc64/pgalloc.h	2004-10-19 01:55:34.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ppc64/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -18,12 +18,6 @@ extern kmem_cache_t *zero_cache;
  * 2 of the License, or (at your option) any later version.
  */
 
-static inline pgd_t *
-pgd_alloc(struct mm_struct *mm)
-{
-	return kmem_cache_alloc(zero_cache, GFP_KERNEL);
-}
-
 static inline void
 pgd_free(pgd_t *pgd)
 {
@@ -107,4 +101,6 @@ void __pte_free_tlb(struct mmu_gather *t
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _PPC64_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ppc64/pgtable.h linux-2.6.10rc1-4level/include/asm-ppc64/pgtable.h
--- linux-2.6.10rc1/include/asm-ppc64/pgtable.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ppc64/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -38,7 +38,7 @@
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
-#define USER_PTRS_PER_PGD	(1024)
+#define USER_PGDS_IN_LAST_PML4	(1024)
 #define FIRST_USER_PGD_NR	0
 
 #define EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
@@ -235,7 +235,7 @@ int hash_huge_page(struct mm_struct *mm,
 /* to avoid overflow in free_pgtables we don't use PTRS_PER_PGD here */
 #define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & 0x7ff)
 
-#define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
+#define pgd_index_k(address) pgd_index(address)
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir,addr) \
@@ -250,10 +250,6 @@ int hash_huge_page(struct mm_struct *mm,
 #define pte_unmap(pte)			do { } while(0)
 #define pte_unmap_nested(pte)		do { } while(0)
 
-/* to find an entry in a kernel page-table-directory */
-/* This now only contains the vmalloc pages */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
-
 /* to find an entry in the ioremap page-table-directory */
 #define pgd_offset_i(address) (ioremap_pgd + pgd_index(address))
 
@@ -558,4 +554,6 @@ static inline pte_t *find_linux_pte(pgd_
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* _PPC64_PGTABLE_H */
