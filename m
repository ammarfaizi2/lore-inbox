Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbUJYHwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUJYHwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUJYHuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:50:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:20128 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261691AbUJYHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:42 -0400
Date: Mon, 25 Oct 2004 09:23:50 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 10/17] 4level support for ppc
Message-ID: <417CAA06.mail3Z41C592G@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for ppc

ppc64		works with 3 levels (thanks to dwmw2) 
ppc32		works with 2 levels (thanks to hch, Mikael P. for testing)

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/kernel/asm-offsets.c linux-2.6.10rc1-4level/arch/ppc/kernel/asm-offsets.c
--- linux-2.6.10rc1/arch/ppc/kernel/asm-offsets.c	2004-10-19 01:55:04.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc/kernel/asm-offsets.c	2004-10-25 04:48:09.000000000 +0200
@@ -120,7 +120,7 @@ main(void)
 	DEFINE(TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
-	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
+	DEFINE(MM_PGD, offsetof(struct mm_struct, pml4));
 
 	/* About the CPU features table */
 	DEFINE(CPU_SPEC_ENTRY_SIZE, sizeof(struct cpu_spec));
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/kernel/dma-mapping.c linux-2.6.10rc1-4level/arch/ppc/kernel/dma-mapping.c
--- linux-2.6.10rc1/arch/ppc/kernel/dma-mapping.c	2004-10-19 01:55:04.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc/kernel/dma-mapping.c	2004-10-25 04:48:09.000000000 +0200
@@ -333,7 +333,8 @@ static int __init dma_alloc_init(void)
 	spin_lock(&init_mm.page_table_lock);
 
 	do {
-		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
+		pgd = pml4_pgd_offset(pml4_offset_k(CONSISTENT_BASE), 
+				      CONSISTENT_BASE);
 		pmd = pmd_alloc(&init_mm, pgd, CONSISTENT_BASE);
 		if (!pmd) {
 			printk(KERN_ERR "%s: no pmd tables\n", __func__);
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/mm/4xx_mmu.c linux-2.6.10rc1-4level/arch/ppc/mm/4xx_mmu.c
--- linux-2.6.10rc1/arch/ppc/mm/4xx_mmu.c	2004-10-19 01:55:04.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc/mm/4xx_mmu.c	2004-10-25 04:48:09.000000000 +0200
@@ -112,7 +112,7 @@ unsigned long __init mmu_mapin_ram(void)
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
 		spin_lock(&init_mm.page_table_lock);
-		pmdp = pmd_offset(pgd_offset_k(v), v);
+		pmdp = pmd_offset(pml4_pgd_offset(pml4_offset_k(v), v), v);
 		pmd_val(*pmdp++) = val;
 		pmd_val(*pmdp++) = val;
 		pmd_val(*pmdp++) = val;
@@ -129,7 +129,7 @@ unsigned long __init mmu_mapin_ram(void)
 		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
 		spin_lock(&init_mm.page_table_lock);
-		pmdp = pmd_offset(pgd_offset_k(v), v);
+		pmdp = pmd_offset(pml4_pgd_offset(pml4_offset_k(v), v), v);
 		pmd_val(*pmdp) = val;
 		spin_unlock(&init_mm.page_table_lock);
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/mm/fault.c linux-2.6.10rc1-4level/arch/ppc/mm/fault.c
--- linux-2.6.10rc1/arch/ppc/mm/fault.c	2004-08-15 19:45:09.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -354,7 +354,7 @@ pte_t *va_to_pte(unsigned long address)
 	if (address < TASK_SIZE)
 		return NULL;
 
-	dir = pgd_offset(&init_mm, address);
+	dir = pml4_pgd_offset(pml4_offset_k(address), address);
 	if (dir) {
 		pmd = pmd_offset(dir, address & PAGE_MASK);
 		if (pmd && pmd_present(*pmd)) {
@@ -384,7 +384,8 @@ print_8xx_pte(struct mm_struct *mm, unsi
         pte_t * pte;
 
         printk(" pte @ 0x%8lx: ", addr);
-        pgd = pgd_offset(mm, addr & PAGE_MASK);
+        pgd = pml4_pgd_offset(pml4_offset(mm, addr & PAGE_MASK), 
+			      addr & PAGE_MASK);
         if (pgd) {
                 pmd = pmd_offset(pgd, addr & PAGE_MASK);
                 if (pmd && pmd_present(*pmd)) {
@@ -425,7 +426,8 @@ get_8xx_pte(struct mm_struct *mm, unsign
         pte_t * pte;
         int     retval = 0;
 
-        pgd = pgd_offset(mm, addr & PAGE_MASK);
+        pgd = pml4_pgd_offset(pml4_offset(mm, addr & PAGE_MASK), 
+			      addr & PAGE_MASK);
         if (pgd) {
                 pmd = pmd_offset(pgd, addr & PAGE_MASK);
                 if (pmd && pmd_present(*pmd)) {
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/mm/init.c linux-2.6.10rc1-4level/arch/ppc/mm/init.c
--- linux-2.6.10rc1/arch/ppc/mm/init.c	2004-10-19 01:55:04.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -378,12 +378,20 @@ void __init paging_init(void)
 	unsigned long zones_size[MAX_NR_ZONES], i;
 
 #ifdef CONFIG_HIGHMEM
+	pml4_t *pml4;
+	pgd_t *pgd;
+	pmd_t *pmd;
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
-	pkmap_page_table = pte_offset_kernel(pmd_offset(pgd_offset_k
-			(PKMAP_BASE), PKMAP_BASE), PKMAP_BASE);
+
+	pml4 = pml4_offset_k(PKMAP_BASE);
+	pgd = pml4_pgd_offset(pml4, PKMAP_BASE);
+	pmd = pgd_offset(pgd, PKMAP_BASE);
+	pkmap_page_table = pte_offset_kernel(pmd, PKMAP_BASE);
 	map_page(KMAP_FIX_BEGIN, 0, 0);	/* XXX gross */
-	kmap_pte = pte_offset_kernel(pmd_offset(pgd_offset_k
-			(KMAP_FIX_BEGIN), KMAP_FIX_BEGIN), KMAP_FIX_BEGIN);
+	pml4 = pml4_offset_k(KMAP_FIX_BEGIN);
+	pgd = pml4_pgd_offset(pml4, KMAP_FIX_BEGIN);
+	pmd = pmd_offset(pgd, KMAP_FIX_BEGIN);
+	kmap_pte = pte_offset_kernel(pmd, KMAP_FIX_BEGIN);
 	kmap_prot = PAGE_KERNEL;
 #endif /* CONFIG_HIGHMEM */
 
@@ -494,7 +502,8 @@ void __init mem_init(void)
 	   and page->index set correctly. */
 	for (addr = KERNELBASE; addr != 0; addr += PGDIR_SIZE) {
 		struct page *pg;
-		pmd_t *pmd = pmd_offset(pgd_offset_k(addr), addr);
+		pmd_t *pmd = pmd_offset(pml4_pgd_offset(
+				   pml4_offset_k(addr), addr), addr);
 		if (pmd_present(*pmd)) {
 			pg = pmd_page(*pmd);
 			pg->mapping = (void *) &init_mm;
@@ -647,7 +656,8 @@ void update_mmu_cache(struct vm_area_str
 		pmd_t *pmd;
 
 		mm = (address < TASK_SIZE)? vma->vm_mm: &init_mm;
-		pmd = pmd_offset(pgd_offset(mm, address), address);
+		pmd = pmd_offset(pml4_pgd_offset(pml4_offset(mm, address), 
+						 address), address);
 		if (!pmd_none(*pmd))
 			add_hash_page(mm->context, address, pmd_val(*pmd));
 	}
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/mm/pgtable.c linux-2.6.10rc1-4level/arch/ppc/mm/pgtable.c
--- linux-2.6.10rc1/arch/ppc/mm/pgtable.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc/mm/pgtable.c	2004-10-25 04:48:09.000000000 +0200
@@ -81,7 +81,7 @@ extern unsigned long p_mapped_by_tlbcam(
 #define PGDIR_ORDER	0
 #endif
 
-pgd_t *pgd_alloc(struct mm_struct *mm)
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long addr)
 {
 	pgd_t *ret;
 
@@ -293,7 +293,7 @@ map_page(unsigned long va, phys_addr_t p
 
 	spin_lock(&init_mm.page_table_lock);
 	/* Use upper 10 bits of VA to index the first level map */
-	pd = pmd_offset(pgd_offset_k(va), va);
+	pd = pmd_offset(pml4_pgd_offset(pml4_offset_k(va), va), va);
 	/* Use middle 10 bits of VA to index the second-level map */
 	pg = pte_alloc_kernel(&init_mm, pd, va);
 	if (pg != 0) {
@@ -388,7 +388,8 @@ get_pteptr(struct mm_struct *mm, unsigne
         pte_t	*pte;
         int     retval = 0;
 
-        pgd = pgd_offset(mm, addr & PAGE_MASK);
+        pgd = pml4_pgd_offset(pml4_offset(mm, addr & PAGE_MASK), 
+			      addr & PAGE_MASK);
         if (pgd) {
                 pmd = pmd_offset(pgd, addr & PAGE_MASK);
                 if (pmd_present(*pmd)) {
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/mm/tlb.c linux-2.6.10rc1-4level/arch/ppc/mm/tlb.c
--- linux-2.6.10rc1/arch/ppc/mm/tlb.c	2004-06-16 12:22:51.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc/mm/tlb.c	2004-10-25 04:48:09.000000000 +0200
@@ -132,7 +132,7 @@ static void flush_range(struct mm_struct
 	if (start >= end)
 		return;
 	end = (end - 1) | ~PAGE_MASK;
-	pmd = pmd_offset(pgd_offset(mm, start), start);
+	pmd = pmd_offset(pml4_pgd_offset(pml4_offset(mm, start), start),start);
 	for (;;) {
 		pmd_end = ((start + PGDIR_SIZE) & PGDIR_MASK) - 1;
 		if (pmd_end > end)
@@ -184,7 +184,8 @@ void flush_tlb_page(struct vm_area_struc
 		return;
 	}
 	mm = (vmaddr < TASK_SIZE)? vma->vm_mm: &init_mm;
-	pmd = pmd_offset(pgd_offset(mm, vmaddr), vmaddr);
+	pmd = pmd_offset(pml4_pgd_offset(pml4_offset(mm, vmaddr), vmaddr), 
+			 vmaddr);
 	if (!pmd_none(*pmd))
 		flush_hash_pages(mm->context, vmaddr, pmd_val(*pmd), 1);
 	FINISH_FLUSH;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/platforms/apus_setup.c linux-2.6.10rc1-4level/arch/ppc/platforms/apus_setup.c
--- linux-2.6.10rc1/arch/ppc/platforms/apus_setup.c	2004-03-21 21:12:06.000000000 +0100
+++ linux-2.6.10rc1-4level/arch/ppc/platforms/apus_setup.c	2004-10-25 04:48:09.000000000 +0200
@@ -329,7 +329,7 @@ static __inline__ pte_t *my_find_pte(str
 
 	va &= PAGE_MASK;
 
-	dir = pgd_offset( mm, va );
+	dir = pml4_pgd_offset(pml4_offset( mm, va ), va);
 	if (dir)
 	{
 		pmd = pmd_offset(dir, va & PAGE_MASK);
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/ppc/platforms/pmac_cpufreq.c linux-2.6.10rc1-4level/arch/ppc/platforms/pmac_cpufreq.c
--- linux-2.6.10rc1/arch/ppc/platforms/pmac_cpufreq.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/ppc/platforms/pmac_cpufreq.c	2004-10-25 04:48:09.000000000 +0200
@@ -262,7 +262,7 @@ static int __pmac pmu_set_cpu_speed(int 
  		_set_L3CR(save_l3cr);
 
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
+	set_context(current->active_mm->context, (pgd_t *)current->active_mm->pml4);
 
 #ifdef DEBUG_FREQ
 	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ppc/mmu_context.h linux-2.6.10rc1-4level/include/asm-ppc/mmu_context.h
--- linux-2.6.10rc1/include/asm-ppc/mmu_context.h	2004-08-15 19:45:48.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ppc/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -172,7 +172,7 @@ static inline void switch_mm(struct mm_s
 	 : : );
 #endif /* CONFIG_ALTIVEC */
 
-	tsk->thread.pgdir = next->pgd;
+	tsk->thread.pgdir = (pgd_t *)next->pml4;
 
 	/* No need to flush userspace segments if the mm doesnt change */
 	if (prev == next)
@@ -180,7 +180,7 @@ static inline void switch_mm(struct mm_s
 
 	/* Setup new userspace context */
 	get_mmu_context(next);
-	set_context(next->context, next->pgd);
+	set_context(next->context, (pgd_t *)next->pml4);
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ppc/page.h linux-2.6.10rc1-4level/include/asm-ppc/page.h
--- linux-2.6.10rc1/include/asm-ppc/page.h	2004-05-10 09:44:23.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ppc/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -163,5 +163,7 @@ extern __inline__ int get_order(unsigned
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __KERNEL__ */
 #endif /* _PPC_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ppc/pgalloc.h linux-2.6.10rc1-4level/include/asm-ppc/pgalloc.h
--- linux-2.6.10rc1/include/asm-ppc/pgalloc.h	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-ppc/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -7,7 +7,6 @@
 
 extern void __bad_pte(pmd_t *pmd);
 
-extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(pgd_t *pgd);
 
 /*
@@ -40,5 +39,7 @@ extern void pte_free(struct page *pte);
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _PPC_PGALLOC_H */
 #endif /* __KERNEL__ */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-ppc/pgtable.h linux-2.6.10rc1-4level/include/asm-ppc/pgtable.h
--- linux-2.6.10rc1/include/asm-ppc/pgtable.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-ppc/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -625,12 +625,9 @@ static inline void __ptep_set_access_fla
 	(mem_map + (__pa(pmd_val(pmd)) >> PAGE_SHIFT))
 #endif
 
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
-
 /* to find an entry in a page-table-directory */
 #define pgd_index(address)	 ((address) >> PGDIR_SHIFT)
-#define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
+#define pgd_index_k(address)     pgd_index(address)
 
 /* Find an entry in the second-level page table.. */
 static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
@@ -734,5 +731,7 @@ extern int get_pteptr(struct mm_struct *
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* _PPC_PGTABLE_H */
 #endif /* __KERNEL__ */
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
