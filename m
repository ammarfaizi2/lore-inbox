Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbUJYHuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbUJYHuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUJYHpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:45:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:17568 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261687AbUJYHZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:41 -0400
Date: Mon, 25 Oct 2004 09:23:49 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 8/17] 4level support for m32r
Message-ID: <417CAA05.mail3YV11VZXC@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for m32r

m32r		converted

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/m32r/mm/init.c linux-2.6.10rc1-4level/arch/m32r/mm/init.c
--- linux-2.6.10rc1/arch/m32r/mm/init.c	2004-10-25 04:47:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/m32r/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -248,3 +248,16 @@ void free_initrd_mem(unsigned long start
 }
 #endif
 
+
+/*
+ * Allocate and free page tables.
+ */
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long addr)
+{
+	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+
+	if (pgd)
+		clear_page(pgd);
+
+	return pgd;
+}
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/m32r/mm/ioremap.c linux-2.6.10rc1-4level/arch/m32r/mm/ioremap.c
--- linux-2.6.10rc1/arch/m32r/mm/ioremap.c	2004-10-19 01:55:02.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/m32r/mm/ioremap.c	2004-10-25 04:48:09.000000000 +0200
@@ -86,7 +86,7 @@ remap_area_pages(unsigned long address, 
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	dir = pml4_pgd_offset_k(pml4_offset_k(address), address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-m32r/mmu_context.h linux-2.6.10rc1-4level/include/asm-m32r/mmu_context.h
--- linux-2.6.10rc1/include/asm-m32r/mmu_context.h	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-m32r/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -133,8 +133,8 @@ static __inline__ void switch_mm(struct 
 #ifdef CONFIG_SMP
 		cpu_set(cpu, next->cpu_vm_mask);
 #endif /* CONFIG_SMP */
-		/* Set MPTB = next->pgd */
-		*(volatile unsigned long *)MPTB = (unsigned long)next->pgd;
+		/* Set MPTB = next->pml4 */
+		*(volatile unsigned long *)MPTB = (unsigned long)next->pml4;
 		activate_context(next);
 	}
 #ifdef CONFIG_SMP
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-m32r/page.h linux-2.6.10rc1-4level/include/asm-m32r/page.h
--- linux-2.6.10rc1/include/asm-m32r/page.h	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-m32r/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -106,6 +106,8 @@ static __inline__ int get_order(unsigned
 
 #define devmem_is_allowed(x) 1
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_M32R_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-m32r/pgalloc.h linux-2.6.10rc1-4level/include/asm-m32r/pgalloc.h
--- linux-2.6.10rc1/include/asm-m32r/pgalloc.h	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-m32r/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -18,19 +18,6 @@ static __inline__ void pmd_populate(stru
 	set_pmd(pmd, __pmd(_PAGE_TABLE + page_to_phys(pte)));
 }
 
-/*
- * Allocate and free page tables.
- */
-static __inline__ pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-
-	if (pgd)
-		clear_page(pgd);
-
-	return pgd;
-}
-
 static __inline__ void pgd_free(pgd_t *pgd)
 {
 	free_page((unsigned long)pgd);
@@ -83,5 +70,7 @@ static __inline__ void pte_free(struct p
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _ASM_M32R_PGALLOC_H */
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-m32r/pgtable.h linux-2.6.10rc1-4level/include/asm-m32r/pgtable.h
--- linux-2.6.10rc1/include/asm-m32r/pgtable.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-m32r/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -54,7 +54,7 @@ extern unsigned long empty_zero_page[102
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE - 1))
 
-#define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PGDS_IN_LAST_PML4	(TASK_SIZE / PGDIR_SIZE)
 #define FIRST_USER_PGD_NR	0
 
 #ifndef __ASSEMBLY__
@@ -377,10 +377,7 @@ static __inline__ void pmd_set(pmd_t * p
 #define pgd_index(address)	\
 	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 
-#define pgd_offset(mm, address)	((mm)->pgd + pgd_index(address))
-
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address)	pgd_offset(&init_mm, address)
+#define pgd_index_k(addr) pgd_index(addr)
 
 #define pmd_index(address)	\
 	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
@@ -419,5 +416,7 @@ static __inline__ void pmd_set(pmd_t * p
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* _ASM_M32R_PGTABLE_H */
 
