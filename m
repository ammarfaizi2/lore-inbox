Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUJYIB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUJYIB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUJYIBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:01:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:21920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261694AbUJYHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:42 -0400
Date: Mon, 25 Oct 2004 09:23:50 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 15/17] 4level support for sparc
Message-ID: <417CAA06.mail3ZU1C1EIH@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for sparc

sparc32		converted, not compiled.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc/mm/fault.c linux-2.6.10rc1-4level/arch/sparc/mm/fault.c
--- linux-2.6.10rc1/arch/sparc/mm/fault.c	2004-08-15 19:45:13.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -148,8 +148,8 @@ static void unhandled_fault(unsigned lon
 	printk(KERN_ALERT "tsk->{mm,active_mm}->context = %08lx\n",
 		(tsk->mm ? tsk->mm->context : tsk->active_mm->context));
 	printk(KERN_ALERT "tsk->{mm,active_mm}->pgd = %08lx\n",
-		(tsk->mm ? (unsigned long) tsk->mm->pgd :
-		 	(unsigned long) tsk->active_mm->pgd));
+		(tsk->mm ? (unsigned long) tsk->mm->pml4 :
+		 	(unsigned long) tsk->active_mm->pml4));
 	die_if_kernel("Oops", regs);
 }
 
@@ -396,8 +396,8 @@ vmalloc_fault:
 		pgd_t *pgd, *pgd_k;
 		pmd_t *pmd, *pmd_k;
 
-		pgd = tsk->active_mm->pgd + offset;
-		pgd_k = init_mm.pgd + offset;
+		pgd = (pgd_t *)(tsk->active_mm->pml4) + offset;
+		pgd_k = (pgd_t *)(init_mm.pml4) + offset;
 
 		if (!pgd_present(*pgd)) {
 			if (!pgd_present(*pgd_k))
@@ -446,7 +446,7 @@ asmlinkage void do_sun4c_fault(struct pt
 		BUG();	/* P3 Oops already, you bitch */
 	}
 
-	pgdp = pgd_offset(mm, address);
+	pgdp = pml4_pgd_offset(pml4_offset(mm, address), address);
 	ptep = sun4c_pte_offset_kernel((pmd_t *) pgdp, address);
 
 	if (pgd_val(*pgdp)) {
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc/mm/generic.c linux-2.6.10rc1-4level/arch/sparc/mm/generic.c
--- linux-2.6.10rc1/arch/sparc/mm/generic.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc/mm/generic.c	2004-10-25 04:48:09.000000000 +0200
@@ -98,7 +98,7 @@ int io_remap_page_range(struct vm_area_s
 
 	prot = __pgprot(pg_iobits);
 	offset -= from;
-	dir = pgd_offset(mm, from);
+	dir = pml4_pgd_offset(pml4_offset(mm, from), from);
 	flush_cache_range(vma, beg, end);
 
 	spin_lock(&mm->page_table_lock);
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc/mm/init.c linux-2.6.10rc1-4level/arch/sparc/mm/init.c
--- linux-2.6.10rc1/arch/sparc/mm/init.c	2004-08-15 19:45:13.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -63,7 +63,7 @@ EXPORT_SYMBOL(kmap_prot);
 EXPORT_SYMBOL(kmap_pte);
 
 #define kmap_get_fixmap_pte(vaddr) \
-	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
+	pte_offset_kernel(pmd_offset(pml4_pgd_offset_k(pml4_offset_k(vaddr), vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
@@ -518,3 +518,8 @@ void sparc_flush_page_to_ram(struct page
 	if (vaddr)
 		__flush_page_to_ram(vaddr);
 }
+
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long addr)
+{
+	return get_pgd_fast();
+}
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc/mm/io-unit.c linux-2.6.10rc1-4level/arch/sparc/mm/io-unit.c
--- linux-2.6.10rc1/arch/sparc/mm/io-unit.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc/mm/io-unit.c	2004-10-25 04:48:09.000000000 +0200
@@ -196,7 +196,7 @@ static int iounit_map_dma_area(dma_addr_
 			pte_t *ptep;
 			long i;
 
-			pgdp = pgd_offset(init_task.mm, addr);
+			pgdp = pml4_pgd_offset(pml4_offset(init_task.mm, addr), addr);
 			pmdp = pmd_offset(pgdp, addr);
 			ptep = pte_offset_map(pmdp, addr);
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc/mm/iommu.c linux-2.6.10rc1-4level/arch/sparc/mm/iommu.c
--- linux-2.6.10rc1/arch/sparc/mm/iommu.c	2004-08-15 19:45:13.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc/mm/iommu.c	2004-10-25 04:48:09.000000000 +0200
@@ -348,7 +348,7 @@ static int iommu_map_dma_area(dma_addr_t
 			else
 				__flush_page_to_ram(page);
 
-			pgdp = pgd_offset(&init_mm, addr);
+			pgdp = pml4_pgd_offset(pml4_offset(&init_mm,addr),addr);
 			pmdp = pmd_offset(pgdp, addr);
 			ptep = pte_offset_map(pmdp, addr);
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc/mm/srmmu.c linux-2.6.10rc1-4level/arch/sparc/mm/srmmu.c
--- linux-2.6.10rc1/arch/sparc/mm/srmmu.c	2004-10-19 01:55:07.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc/mm/srmmu.c	2004-10-25 04:48:09.000000000 +0200
@@ -257,7 +257,7 @@ static inline pte_t srmmu_pte_modify(pte
 
 /* to find an entry in a top-level page table... */
 extern inline pgd_t *srmmu_pgd_offset(struct mm_struct * mm, unsigned long address)
-{ return mm->pgd + (address >> SRMMU_PGDIR_SHIFT); }
+{ return (pgd_t *)(mm->pml4) + (address >> SRMMU_PGDIR_SHIFT); }
 
 /* Find an entry in the second-level page table.. */
 static inline pmd_t *srmmu_pmd_offset(pgd_t * dir, unsigned long address)
@@ -419,7 +419,7 @@ void srmmu_nocache_init(void)
 
 	srmmu_swapper_pg_dir = (pgd_t *)__srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
 	memset(__nocache_fix(srmmu_swapper_pg_dir), 0, SRMMU_PGD_TABLE_SIZE);
-	init_mm.pgd = srmmu_swapper_pg_dir;
+	init_mm.pml4 = (pgd_t *)srmmu_swapper_pg_dir;
 
 	srmmu_early_allocate_ptable_skeleton(SRMMU_NOCACHE_VADDR, srmmu_nocache_end);
 
@@ -427,7 +427,7 @@ void srmmu_nocache_init(void)
 	vaddr = SRMMU_NOCACHE_VADDR;
 
 	while (vaddr < srmmu_nocache_end) {
-		pgd = pgd_offset_k(vaddr);
+		pgd = pml4_pgd_offset_k(pml4_offset_k(vaddr), vaddr);
 		pmd = srmmu_pmd_offset(__nocache_fix(pgd), vaddr);
 		pte = srmmu_pte_offset(__nocache_fix(pmd), vaddr);
 
@@ -452,7 +452,7 @@ static inline pgd_t *srmmu_get_pgd_fast(
 
 	pgd = (pgd_t *)__srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
 	if (pgd) {
-		pgd_t *init = pgd_offset_k(0);
+		pgd_t *init = pml4_pgd_offset_k(pml4_offset_k(0), 0);
 		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 		memcpy(pgd + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
 						(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
@@ -562,7 +562,8 @@ static void srmmu_switch_mm(struct mm_st
 		spin_lock(&srmmu_context_spinlock);
 		alloc_context(old_mm, mm);
 		spin_unlock(&srmmu_context_spinlock);
-		srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
+		srmmu_ctxd_set(&srmmu_context_table[mm->context], 
+			       (pgd_t *)mm->pml4);
 	}
 
 	if (is_hypersparc)
@@ -581,7 +582,7 @@ static inline void srmmu_mapioaddr(unsig
 	unsigned long tmp;
 
 	physaddr &= PAGE_MASK;
-	pgdp = pgd_offset_k(virt_addr);
+	pgdp = pml4_pgd_offset_k(pml4_offset_k(virt_addr), virt_addr);
 	pmdp = srmmu_pmd_offset(pgdp, virt_addr);
 	ptep = srmmu_pte_offset(pmdp, virt_addr);
 	tmp = (physaddr >> 4) | SRMMU_ET_PTE;
@@ -615,7 +616,7 @@ static inline void srmmu_unmapioaddr(uns
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	pgdp = pgd_offset_k(virt_addr);
+	pgdp = pml4_pgd_offset_k(pml4_offset_k(virt_addr), virt_addr);
 	pmdp = srmmu_pmd_offset(pgdp, virt_addr);
 	ptep = srmmu_pte_offset(pmdp, virt_addr);
 
@@ -1056,7 +1057,7 @@ void __init srmmu_early_allocate_ptable_
 	pte_t *ptep;
 
 	while(start < end) {
-		pgdp = pgd_offset_k(start);
+		pgdp = pml4_pgd_offset_k(pml4_offset_k(start), start);
 		if(srmmu_pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
 			pmdp = (pmd_t *) __srmmu_get_nocache(
 			    SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
@@ -1086,7 +1087,7 @@ void __init srmmu_allocate_ptable_skelet
 	pte_t *ptep;
 
 	while(start < end) {
-		pgdp = pgd_offset_k(start);
+		pgdp = pml4_pgd_offset_k(pml4_offset_k(start), start);
 		if(srmmu_pgd_none(*pgdp)) {
 			pmdp = (pmd_t *)__srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp == NULL)
@@ -1146,7 +1147,7 @@ void __init srmmu_inherit_prom_mappings(
 				what = 2;
 		}
     
-		pgdp = pgd_offset_k(start);
+		pgdp = pml4_pgd_offset_k(pml4_offset_k(start), start);
 		if(what == 2) {
 			*(pgd_t *)__nocache_fix(pgdp) = __pgd(prompte);
 			start += SRMMU_PGDIR_SIZE;
@@ -1191,7 +1192,7 @@ void __init srmmu_inherit_prom_mappings(
 /* Create a third-level SRMMU 16MB page mapping. */
 static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base)
 {
-	pgd_t *pgdp = pgd_offset_k(vaddr);
+	pgd_t *pgdp = pml4_pgd_offset_k(pml4_offset_k(vaddr), vaddr);
 	unsigned long big_pte;
 
 	big_pte = KERNEL_PTE(phys_base >> 4);
@@ -1311,7 +1312,7 @@ void __init srmmu_paging_init(void)
 		__fix_to_virt(__end_of_fixed_addresses - 1), FIXADDR_TOP);
 	srmmu_allocate_ptable_skeleton(PKMAP_BASE, PKMAP_END);
 
-	pgd = pgd_offset_k(PKMAP_BASE);
+	pgd = pml4_pgd_offset_k(pml4_offset_k(PKMAP_BASE), PKMAP_BASE);
 	pmd = srmmu_pmd_offset(pgd, PKMAP_BASE);
 	pte = srmmu_pte_offset(pmd, PKMAP_BASE);
 	pkmap_page_table = pte;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc/mm/sun4c.c linux-2.6.10rc1-4level/arch/sparc/mm/sun4c.c
--- linux-2.6.10rc1/arch/sparc/mm/sun4c.c	2004-10-19 01:55:07.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc/mm/sun4c.c	2004-10-25 04:48:09.000000000 +0200
@@ -1847,7 +1847,7 @@ static unsigned long sun4c_pgd_page(pgd_
 /* to find an entry in a page-table-directory */
 static inline pgd_t *sun4c_pgd_offset(struct mm_struct * mm, unsigned long address)
 {
-	return mm->pgd + (address >> SUN4C_PGDIR_SHIFT);
+	return (pgd_t *)mm->pml4 + (address >> SUN4C_PGDIR_SHIFT);
 }
 
 /* Find an entry in the second-level page table.. */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sparc/page.h linux-2.6.10rc1-4level/include/asm-sparc/page.h
--- linux-2.6.10rc1/include/asm-sparc/page.h	2004-04-06 13:12:20.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sparc/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -176,6 +176,8 @@ extern unsigned long pfn_base;
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _SPARC_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sparc/pgalloc.h linux-2.6.10rc1-4level/include/asm-sparc/pgalloc.h
--- linux-2.6.10rc1/include/asm-sparc/pgalloc.h	2004-03-21 21:11:56.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-sparc/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -34,7 +34,6 @@ BTFIXUPDEF_CALL(void, free_pgd_fast, pgd
 #define free_pgd_fast(pgd)	BTFIXUP_CALL(free_pgd_fast)(pgd)
 
 #define pgd_free(pgd)	free_pgd_fast(pgd)
-#define pgd_alloc(mm)	get_pgd_fast()
 
 BTFIXUPDEF_CALL(void, pgd_set, pgd_t *, pmd_t *)
 #define pgd_set(pgdp,pmdp) BTFIXUP_CALL(pgd_set)(pgdp,pmdp)
@@ -66,4 +65,6 @@ BTFIXUPDEF_CALL(void, pte_free, struct p
 #define pte_free(pte)		BTFIXUP_CALL(pte_free)(pte)
 #define __pte_free_tlb(tlb, pte)	pte_free(pte)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _SPARC_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sparc/pgtable.h linux-2.6.10rc1-4level/include/asm-sparc/pgtable.h
--- linux-2.6.10rc1/include/asm-sparc/pgtable.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sparc/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -60,7 +60,7 @@ BTFIXUPDEF_INT(page_kernel)
 #define PTRS_PER_PTE    	1024
 #define PTRS_PER_PMD    	BTFIXUP_SIMM13(ptrs_per_pmd)
 #define PTRS_PER_PGD    	BTFIXUP_SIMM13(ptrs_per_pgd)
-#define USER_PTRS_PER_PGD	BTFIXUP_SIMM13(user_ptrs_per_pgd)
+#define USER_PGDS_IN_LAST_PML4	BTFIXUP_SIMM13(user_ptrs_per_pgd)
 #define FIRST_USER_PGD_NR	0
 #define PTE_SIZE		(PTRS_PER_PTE*4)
 
@@ -280,12 +280,7 @@ extern __inline__ pte_t pte_modify(pte_t
 }
 
 #define pgd_index(address) ((address) >> PGDIR_SHIFT)
-
-/* to find an entry in a page-table-directory */
-#define pgd_offset(mm, address) ((mm)->pgd + pgd_index(address))
-
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+#define pgd_index_k(address) pgd_index(address)
 
 /* Find an entry in the second-level page table.. */
 BTFIXUPDEF_CALL(pmd_t *, pmd_offset, pgd_t *, unsigned long)
@@ -434,6 +429,7 @@ extern int io_remap_page_range(struct vm
 			       unsigned long size, pgprot_t prot, int space);
 
 #include <asm-generic/pgtable.h>
+#include <asm-generic/nopml4-pgtable.h>
 
 #endif /* !(__ASSEMBLY__) */
 
