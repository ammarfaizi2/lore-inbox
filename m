Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbUJYHuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbUJYHuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUJYHsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:48:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:21664 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261692AbUJYHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:42 -0400
Date: Mon, 25 Oct 2004 09:23:50 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 14/17] 4level support for sh64
Message-ID: <417CAA06.mail3ZP11OWGX@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for sh64

sh64		converted

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh64/mm/cache.c linux-2.6.10rc1-4level/arch/sh64/mm/cache.c
--- linux-2.6.10rc1/arch/sh64/mm/cache.c	2004-08-15 19:45:12.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh64/mm/cache.c	2004-10-25 04:48:09.000000000 +0200
@@ -581,7 +581,7 @@ static void sh64_dcache_purge_virt_page(
 	pte_t *pte;
 	pte_t entry;
 
-	pgd = pgd_offset(mm, eaddr);
+	pgd = pml4_pgd_offset(pml4_offset(mm, eaddr),eaddr);
 	pmd = pmd_offset(pgd, eaddr);
 
 	if (pmd_none(*pmd) || pmd_bad(*pmd))
@@ -610,7 +610,7 @@ static void sh64_dcache_purge_user_page(
 	   following page table traversal is safe even on SMP/pre-emptible. */
 
 	if (!mm) return; /* No way to find physical address of page */
-	pgd = pgd_offset(mm, eaddr);
+	pgd = pml4_pgd_offset(pml4_offset(mm, eaddr), eaddr);
 	if (pgd_bad(*pgd)) return;
 
 	pmd = pmd_offset(pgd, eaddr);
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh64/mm/fault.c linux-2.6.10rc1-4level/arch/sh64/mm/fault.c
--- linux-2.6.10rc1/arch/sh64/mm/fault.c	2004-10-19 01:55:06.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh64/mm/fault.c	2004-10-25 04:48:09.000000000 +0200
@@ -92,7 +92,7 @@ static pte_t *lookup_pte(struct mm_struc
 	pte_t *pte;
 	pte_t entry;
 
-	dir = pgd_offset(mm, address);
+	dir = pml4_pgd_offset(pml4_offset(mm, address), address);
 	if (pgd_none(*dir)) {
 		return NULL;
 	}
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh64/mm/hugetlbpage.c linux-2.6.10rc1-4level/arch/sh64/mm/hugetlbpage.c
--- linux-2.6.10rc1/arch/sh64/mm/hugetlbpage.c	2004-08-15 19:45:12.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh64/mm/hugetlbpage.c	2004-10-25 04:48:09.000000000 +0200
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
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh64/mm/init.c linux-2.6.10rc1-4level/arch/sh64/mm/init.c
--- linux-2.6.10rc1/arch/sh64/mm/init.c	2004-10-19 01:55:06.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh64/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -32,7 +32,7 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_ga
  * Cache of MMU context last used.
  */
 unsigned long mmu_context_cache;
-pgd_t * mmu_pdtp_cache;
+pml4_t * mmu_pdtp_cache;
 int after_bootmem = 0;
 
 /*
@@ -197,3 +197,19 @@ void free_initrd_mem(unsigned long start
 }
 #endif
 
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long addr)
+{
+	unsigned long *ret;
+
+	if ((ret = pgd_quicklist) != NULL) {
+		pgd_quicklist = (unsigned long *)(*ret);
+		ret[0] = 0;
+		pgtable_cache_size--;
+	} else
+		ret = (unsigned long *)get_pgd_slow();
+
+	if (ret) {
+		memset(ret, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+	}
+	return (pgd_t *)ret;
+}
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh64/mm/ioremap.c linux-2.6.10rc1-4level/arch/sh64/mm/ioremap.c
--- linux-2.6.10rc1/arch/sh64/mm/ioremap.c	2004-08-15 19:45:12.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh64/mm/ioremap.c	2004-10-25 04:48:09.000000000 +0200
@@ -97,7 +97,7 @@ static int remap_area_pages(unsigned lon
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset_k(address);
+	dir = pml4_pgd_offset_k(pml4_offset_k(address), address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
@@ -355,7 +355,7 @@ static void shmedia_mapioaddr(unsigned l
 
 	pr_debug("shmedia_mapiopage pa %08lx va %08lx\n",  pa, va);
 
-	pgdp = pgd_offset_k(va);
+	pgdp = pml4_pgd_offset_k(pml4_offset_k(va), va);
 	if (pgd_none(*pgdp) || !pgd_present(*pgdp)) {
 		pmdp = (pmd_t *)sh64_get_page();
 		set_pgd(pgdp, __pgd((unsigned long)pmdp | _KERNPG_TABLE));
@@ -388,7 +388,7 @@ static void shmedia_unmapioaddr(unsigned
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	pgdp = pgd_offset_k(vaddr);
+	pgdp = pml4_pgd_offset_k(pml4_offset_k(vaddr), vaddr);
 	pmdp = pmd_offset(pgdp, vaddr);
 
 	if (pmd_none(*pmdp) || pmd_bad(*pmdp))
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/sh64/mm/tlbmiss.c linux-2.6.10rc1-4level/arch/sh64/mm/tlbmiss.c
--- linux-2.6.10rc1/arch/sh64/mm/tlbmiss.c	2004-10-19 01:55:06.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/sh64/mm/tlbmiss.c	2004-10-25 04:48:09.000000000 +0200
@@ -99,7 +99,7 @@ static int handle_vmalloc_fault(struct m
 	static pte_t *pte;
 	pte_t entry;
 
-	dir = pgd_offset_k(address);
+	dir = pml4_pgd_offset_k(pml4_offset_k(address), address);
 	pmd = pmd_offset(dir, address);
 
 	if (pmd_none(*pmd)) {
@@ -150,7 +150,7 @@ static int handle_tlbmiss(struct mm_stru
 		/* upper half - never has page table entries. */
 		return 0;
 	}
-	dir = pgd_offset(mm, address);
+	dir = pml4_pgd_offset(pml4_offset(mm, address), address);
 	if (pgd_none(*dir)) {
 		return 0;
 	}
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sh64/mmu_context.h linux-2.6.10rc1-4level/include/asm-sh64/mmu_context.h
--- linux-2.6.10rc1/include/asm-sh64/mmu_context.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sh64/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -31,7 +31,7 @@ extern unsigned long mmu_context_cache;
 
 
 /* Current mm's pgd */
-extern pgd_t *mmu_pdtp_cache;
+extern pml4_t *mmu_pdtp_cache;
 
 #define SR_ASID_MASK		0xffffffffff00ffffULL
 #define SR_ASID_SHIFT		16
@@ -189,7 +189,7 @@ static __inline__ void switch_mm(struct 
 				 struct task_struct *tsk)
 {
 	if (prev != next) {
-		mmu_pdtp_cache = next->pgd;
+		mmu_pdtp_cache = next->pml4;
 		activate_context(next);
 	}
 }
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sh64/page.h linux-2.6.10rc1-4level/include/asm-sh64/page.h
--- linux-2.6.10rc1/include/asm-sh64/page.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sh64/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -130,6 +130,8 @@ extern __inline__ int get_order(unsigned
 	return order;
 }
 
+#include <asm-generic/nopml4-page.h>
+
 #endif
 
 #endif /* __KERNEL__ */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sh64/pgalloc.h linux-2.6.10rc1-4level/include/asm-sh64/pgalloc.h
--- linux-2.6.10rc1/include/asm-sh64/pgalloc.h	2004-08-15 19:45:49.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sh64/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -46,23 +46,6 @@ extern __inline__ pgd_t *get_pgd_slow(vo
 	return ret;
 }
 
-extern __inline__ pgd_t *get_pgd_fast(void)
-{
-	unsigned long *ret;
-
-	if ((ret = pgd_quicklist) != NULL) {
-		pgd_quicklist = (unsigned long *)(*ret);
-		ret[0] = 0;
-		pgtable_cache_size--;
-	} else
-		ret = (unsigned long *)get_pgd_slow();
-
-	if (ret) {
-		memset(ret, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-	}
-	return (pgd_t *)ret;
-}
-
 extern __inline__ void free_pgd_fast(pgd_t *pgd)
 {
 	*(unsigned long *)pgd = (unsigned long) pgd_quicklist;
@@ -170,7 +153,6 @@ static __inline__ void pmd_free(pmd_t *p
 
 #define check_pgt_cache()		do { } while (0)
 #define pgd_free(pgd)		free_pgd_slow(pgd)
-#define pgd_alloc(mm)		get_pgd_fast()
 
 extern int do_check_pgt_cache(int, int);
 
@@ -199,4 +181,6 @@ static inline void pmd_populate(struct m
 	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) page_address (pte)));
 }
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* __ASM_SH64_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-sh64/pgtable.h linux-2.6.10rc1-4level/include/asm-sh64/pgtable.h
--- linux-2.6.10rc1/include/asm-sh64/pgtable.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-sh64/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -146,11 +146,8 @@ static __inline__ void pmd_set(pmd_t *pm
 
 /* To find an entry in a generic PGD. */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#define pgd_index_k(address) pgd_index(address)
 #define __pgd_offset(address) pgd_index(address)
-#define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
-
-/* To find an entry in a kernel PGD. */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 /*
  * PGD level access routines.
@@ -234,7 +231,7 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define pte_unmap_nested(pte)	do { } while (0)
 
 /* Round it up ! */
-#define USER_PTRS_PER_PGD	((TASK_SIZE+PGDIR_SIZE-1)/PGDIR_SIZE)
+#define USER_PPGDS_IN_LAST_PML4	((TASK_SIZE+PGDIR_SIZE-1)/PGDIR_SIZE)
 #define FIRST_USER_PGD_NR	0
 
 #ifndef __ASSEMBLY__
@@ -495,5 +492,6 @@ extern void update_mmu_cache(struct vm_a
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
 #include <asm-generic/pgtable.h>
+#include <asm-generic/nopml4-pgtable.h>
 
 #endif /* __ASM_SH64_PGTABLE_H */
