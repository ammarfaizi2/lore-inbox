Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbUJYIAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbUJYIAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUJYH7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:59:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:22688 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261696AbUJYHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:42 -0400
Date: Mon, 25 Oct 2004 09:23:50 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 16/17] 4level support for sparc64
Message-ID: <417CAA06.mail3ZZ115IML@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for sparc64

sparc64 conversion to 4levels. Thanks to DaveM for testing.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc64/kernel/process.c linux-2.6.10rc1-4level/arch/sparc64/kernel/process.c
--- linux-2.6.10rc1/arch/sparc64/kernel/process.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc64/kernel/process.c	2004-10-25 04:48:09.000000000 +0200
@@ -433,7 +433,7 @@ void flush_thread(void)
 		unsigned long pgd_cache = 0UL;
 		if (test_thread_flag(TIF_32BIT)) {
 			struct mm_struct *mm = t->task->mm;
-			pgd_t *pgd0 = &mm->pgd[0];
+			pgd_t *pgd0 = &((pgd_t *)mm->pml4)[0];
 
 			if (pgd_none(*pgd0)) {
 				pmd_t *page = pmd_alloc_one_fast(NULL, 0);
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc64/kernel/setup.c linux-2.6.10rc1-4level/arch/sparc64/kernel/setup.c
--- linux-2.6.10rc1/arch/sparc64/kernel/setup.c	2004-10-19 01:55:07.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc64/kernel/setup.c	2004-10-25 04:48:09.000000000 +0200
@@ -163,7 +163,7 @@ int prom_callback(long *args)
 			    CTX_HWBITS(mm->context) != ctx)
 				goto done;
 
-			pgdp = pgd_offset(mm, va);
+			pgdp = pml4_pgd_offset(pml4_offset(mm, va), va);
 			if (pgd_none(*pgdp))
 				goto done;
 			pmdp = pmd_offset(pgdp, va);
@@ -218,7 +218,7 @@ int prom_callback(long *args)
 					res = PROM_TRUE;
 				goto done;
 			}
-			pgdp = pgd_offset_k(va);
+			pgdp = pml4_pgd_offset(pml4_offset_k(va), va);
 			if (pgd_none(*pgdp))
 				goto done;
 			pmdp = pmd_offset(pgdp, va);
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc64/kernel/signal32.c linux-2.6.10rc1-4level/arch/sparc64/kernel/signal32.c
--- linux-2.6.10rc1/arch/sparc64/kernel/signal32.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc64/kernel/signal32.c	2004-10-25 04:48:09.000000000 +0200
@@ -856,7 +856,8 @@ static void new_setup_frame32(struct k_s
 	} else {
 		/* Flush instruction space. */
 		unsigned long address = ((unsigned long)&(sf->insns[0]));
-		pgd_t *pgdp = pgd_offset(current->mm, address);
+		pml4_t *pml4 = pml4_offset(current->mm, address);
+		pgd_t *pgdp = pml4_pgd_offset(pml4, address);
 		pmd_t *pmdp = pmd_offset(pgdp, address);
 		pte_t *ptep;
 
@@ -1267,7 +1268,8 @@ static void setup_rt_frame32(struct k_si
 	else {
 		/* Flush instruction space. */
 		unsigned long address = ((unsigned long)&(sf->insns[0]));
-		pgd_t *pgdp = pgd_offset(current->mm, address);
+		pml4_t *pml4 = pml4_offset(current->mm, address);
+		pgd_t *pgdp = pml4_pgd_offset(pml4, address);
 		pmd_t *pmdp = pmd_offset(pgdp, address);
 		pte_t *ptep;
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc64/kernel/unaligned.c linux-2.6.10rc1-4level/arch/sparc64/kernel/unaligned.c
--- linux-2.6.10rc1/arch/sparc64/kernel/unaligned.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc64/kernel/unaligned.c	2004-10-25 04:48:09.000000000 +0200
@@ -382,8 +382,8 @@ void kernel_mna_trap_fault(struct pt_reg
 			(current->mm ? current->mm->context :
 			current->active_mm->context));
 		printk(KERN_ALERT "current->{mm,active_mm}->pgd = %016lx\n",
-			(current->mm ? (unsigned long) current->mm->pgd :
-			(unsigned long) current->active_mm->pgd));
+			(current->mm ? (unsigned long) current->mm->pml4 :
+			(unsigned long) current->active_mm->pml4));
 	        die_if_kernel("Oops", regs);
 		/* Not reached */
 	}
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc64/mm/fault.c linux-2.6.10rc1-4level/arch/sparc64/mm/fault.c
--- linux-2.6.10rc1/arch/sparc64/mm/fault.c	2004-10-19 01:55:07.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc64/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -146,8 +146,8 @@ static void unhandled_fault(unsigned lon
 	printk(KERN_ALERT "tsk->{mm,active_mm}->context = %016lx\n",
 	       (tsk->mm ? tsk->mm->context : tsk->active_mm->context));
 	printk(KERN_ALERT "tsk->{mm,active_mm}->pgd = %016lx\n",
-	       (tsk->mm ? (unsigned long) tsk->mm->pgd :
-		          (unsigned long) tsk->active_mm->pgd));
+	       (tsk->mm ? (unsigned long) tsk->mm->pml4 :
+		          (unsigned long) tsk->active_mm->pml4));
 	if (notify_die(DIE_GPF, "general protection fault", regs,
 		       0, 0, SIGSEGV) == NOTIFY_STOP)
 		return;
@@ -174,7 +174,8 @@ static void bad_kernel_pc(struct pt_regs
  */
 static unsigned int get_user_insn(unsigned long tpc)
 {
-	pgd_t *pgdp = pgd_offset(current->mm, tpc);
+	pml4_t *pml4 = pml4_offset(current->mm, tpc);
+	pgd_t *pgdp = pml4_pgd_offset(pml4, tpc);
 	pmd_t *pmdp;
 	pte_t *ptep, pte;
 	unsigned long pa;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc64/mm/generic.c linux-2.6.10rc1-4level/arch/sparc64/mm/generic.c
--- linux-2.6.10rc1/arch/sparc64/mm/generic.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc64/mm/generic.c	2004-10-25 04:48:09.000000000 +0200
@@ -117,7 +117,7 @@ int io_remap_page_range(struct vm_area_s
 
 	prot = __pgprot(pg_iobits);
 	offset -= from;
-	dir = pgd_offset(mm, from);
+	dir = pml4_pgd_offset(pml4_offset(mm, from), from);
 	flush_cache_range(vma, beg, end);
 
 	spin_lock(&mm->page_table_lock);
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc64/mm/hugetlbpage.c linux-2.6.10rc1-4level/arch/sparc64/mm/hugetlbpage.c
--- linux-2.6.10rc1/arch/sparc64/mm/hugetlbpage.c	2004-06-16 12:22:53.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc64/mm/hugetlbpage.c	2004-10-25 04:48:09.000000000 +0200
@@ -27,7 +27,7 @@ static pte_t *huge_pte_alloc(struct mm_s
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pgd = pgd_offset(mm, addr);
+	pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 	if (pgd) {
 		pmd = pmd_alloc(mm, pgd, addr);
 		if (pmd)
@@ -42,7 +42,7 @@ static pte_t *huge_pte_offset(struct mm_
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pgd = pgd_offset(mm, addr);
+	pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 	if (pgd) {
 		pmd = pmd_offset(pgd, addr);
 		if (pmd)
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sparc64/mm/init.c linux-2.6.10rc1-4level/arch/sparc64/mm/init.c
--- linux-2.6.10rc1/arch/sparc64/mm/init.c	2004-10-19 01:55:07.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sparc64/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -1457,7 +1457,7 @@ void __init paging_init(void)
 	/* Now set kernel pgd to upper alias so physical page computations
 	 * work.
 	 */
-	init_mm.pgd += ((shift) / (sizeof(pgd_t)));
+	init_mm.pml4 += ((shift) / (sizeof(pgd_t)));
 	
 	memset(swapper_pmd_dir, 0, sizeof(swapper_pmd_dir));
 
@@ -1465,9 +1465,9 @@ void __init paging_init(void)
 	pgd_set(&swapper_pg_dir[0], swapper_pmd_dir + (shift / sizeof(pgd_t)));
 	
 	sparc64_vpte_patchme1[0] |=
-		(((unsigned long)pgd_val(init_mm.pgd[0])) >> 10);
+		(((unsigned long)pgd_val(((pgd_t *)init_mm.pml4)[0])) >> 10);
 	sparc64_vpte_patchme2[0] |=
-		(((unsigned long)pgd_val(init_mm.pgd[0])) & 0x3ff);
+		(((unsigned long)pgd_val(((pgd_t *)init_mm.pml4)[0])) & 0x3ff);
 	flushi((long)&sparc64_vpte_patchme1[0]);
 	
 	/* Setup bootmem... */
@@ -1771,3 +1771,8 @@ void free_initrd_mem(unsigned long start
 	}
 }
 #endif
+
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long addr)
+{
+	return get_pgd_fast();
+} 
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sparc64/mmu_context.h linux-2.6.10rc1-4level/include/asm-sparc64/mmu_context.h
--- linux-2.6.10rc1/include/asm-sparc64/mmu_context.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sparc64/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -80,11 +80,11 @@ do {	spin_lock(&ctx_alloc_lock);				\
 do { \
 	register unsigned long paddr asm("o5"); \
 	register unsigned long pgd_cache asm("o4"); \
-	paddr = __pa((__mm)->pgd); \
+	paddr = __pa((__mm)->pml4); \
 	pgd_cache = 0UL; \
 	if ((__tsk)->thread_info->flags & _TIF_32BIT) \
 		pgd_cache = \
-		  ((unsigned long)pgd_val((__mm)->pgd[0])) << 11UL; \
+		  ((unsigned long)pgd_val(((pgd_t *)(__mm)->pml4)[0])) << 11UL; \
 	__asm__ __volatile__("wrpr	%%g0, 0x494, %%pstate\n\t" \
 			     "mov	%3, %%g4\n\t" \
 			     "mov	%0, %%g7\n\t" \
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sparc64/page.h linux-2.6.10rc1-4level/include/asm-sparc64/page.h
--- linux-2.6.10rc1/include/asm-sparc64/page.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sparc64/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -165,6 +165,8 @@ static __inline__ int get_order(unsigned
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* !(__KERNEL__) */
 
 #endif /* !(_SPARC64_PAGE_H) */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sparc64/pgalloc.h linux-2.6.10rc1-4level/include/asm-sparc64/pgalloc.h
--- linux-2.6.10rc1/include/asm-sparc64/pgalloc.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sparc64/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -259,6 +259,7 @@ static inline void pte_free(struct page 
 
 #define pmd_free(pmd)		free_pmd_fast(pmd)
 #define pgd_free(pgd)		free_pgd_fast(pgd)
-#define pgd_alloc(mm)		get_pgd_fast()
+
+#include <asm-generic/nopml4-pgalloc.h>
 
 #endif /* _SPARC64_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sparc64/pgtable.h linux-2.6.10rc1-4level/include/asm-sparc64/pgtable.h
--- linux-2.6.10rc1/include/asm-sparc64/pgtable.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sparc64/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -92,7 +92,7 @@ extern unsigned long __ptrs_per_pmd(void
 		      (PAGE_SHIFT-3) + PMD_BITS)))
 
 /* Kernel has a separate 44bit address space. */
-#define USER_PTRS_PER_PGD	((const int)(test_thread_flag(TIF_32BIT)) ? \
+#define USER_PGDS_IN_LAST_PML4	((const int)(test_thread_flag(TIF_32BIT)) ? \
 				 (1) : (PTRS_PER_PGD))
 #define FIRST_USER_PGD_NR	0
 
@@ -305,10 +305,7 @@ static inline pte_t pte_modify(pte_t ori
 
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD))
-#define pgd_offset(mm, address)	((mm)->pgd + pgd_index(address))
-
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+#define pgd_index_k(address) 	pgd_index(address)
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir, address)	\
@@ -378,6 +375,8 @@ static inline pte_t mk_pte_io(unsigned l
 
 extern unsigned long prom_virt_to_phys(unsigned long, int *);
 
+#include <asm-generic/nopml4-pgtable.h>
+
 static __inline__ unsigned long
 sun4u_get_pte (unsigned long addr)
 {
@@ -389,7 +388,7 @@ sun4u_get_pte (unsigned long addr)
 		return addr & _PAGE_PADDR;
 	if ((addr >= LOW_OBP_ADDRESS) && (addr < HI_OBP_ADDRESS))
 		return prom_virt_to_phys(addr, NULL);
-	pgdp = pgd_offset_k(addr);
+	pgdp = pml4_pgd_offset(pml4_offset_k(addr), addr);
 	pmdp = pmd_offset(pgdp, addr);
 	ptep = pte_offset_kernel(pmdp, addr);
 	return pte_val(*ptep) & _PAGE_PADDR;
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sparc64/tlb.h linux-2.6.10rc1-4level/include/asm-sparc64/tlb.h
--- linux-2.6.10rc1/include/asm-sparc64/tlb.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sparc64/tlb.h	2004-10-25 04:48:10.000000000 +0200
@@ -126,4 +126,10 @@ static inline void tlb_remove_page(struc
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
 
+#define pgd_free_tlb(tlb, pgdp)				\
+do {							\
+	tlb->need_flush = 1;				\
+	__pgd_free_tlb(tlb, pgdp);			\
+} while (0)
+
 #endif /* _SPARC64_TLB_H */
