Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbUJYHmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbUJYHmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUJYHmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:42:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:14496 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261684AbUJYHZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:41 -0400
Date: Mon, 25 Oct 2004 09:23:50 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 12/17] 4level support for s390
Message-ID: <417CAA06.mail3ZF1H2BS1@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for s390

s390/s390x	works with 3 levels (thanks to Martin S.) 

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/s390/mm/init.c linux-2.6.10rc1-4level/arch/s390/mm/init.c
--- linux-2.6.10rc1/arch/s390/mm/init.c	2004-08-15 19:45:11.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/s390/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -40,6 +40,26 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_ga
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((__aligned__(PAGE_SIZE)));
 char  empty_zero_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
+pgd_t *
+__pgd_alloc(struct mm_struct *mm, pml4_t *dummy, unsigned long addr)
+{
+	pgd_t *pgd;
+	int i;
+
+#ifndef __s390x__
+	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,1);
+        if (pgd != NULL)
+		for (i = 0; i < PTRS_PER_PGD; i++)
+			pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
+#else /* __s390x__ */
+	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,2);
+        if (pgd != NULL)
+		for (i = 0; i < PTRS_PER_PGD; i++)
+			pgd_clear(pgd + i);
+#endif /* __s390x__ */
+	return pgd;
+}
+
 void diag10(unsigned long addr)
 {
         if (addr >= 0x7ff00000)
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/s390/mm/ioremap.c linux-2.6.10rc1-4level/arch/s390/mm/ioremap.c
--- linux-2.6.10rc1/arch/s390/mm/ioremap.c	2004-06-16 12:22:52.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/s390/mm/ioremap.c	2004-10-25 04:48:09.000000000 +0200
@@ -76,7 +76,7 @@ static int remap_area_pages(unsigned lon
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	dir = pml4_pgd_offset(&init_mm, address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-s390/mmu_context.h linux-2.6.10rc1-4level/include/asm-s390/mmu_context.h
--- linux-2.6.10rc1/include/asm-s390/mmu_context.h	2004-04-06 13:12:20.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-s390/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -26,13 +26,13 @@ static inline void switch_mm(struct mm_s
 {
         if (prev != next) {
 #ifndef __s390x__
-	        S390_lowcore.user_asce = (__pa(next->pgd)&PAGE_MASK) |
+	        S390_lowcore.user_asce = (__pa(next->pml4)&PAGE_MASK) |
                       (_SEGMENT_TABLE|USER_STD_MASK);
                 /* Load home space page table origin. */
                 asm volatile("lctl  13,13,%0"
 			     : : "m" (S390_lowcore.user_asce) );
 #else /* __s390x__ */
-                S390_lowcore.user_asce = (__pa(next->pgd) & PAGE_MASK) |
+                S390_lowcore.user_asce = (__pa(next->pml4) & PAGE_MASK) |
 			(_REGION_TABLE|USER_STD_MASK);
 		/* Load home space page table origin. */
 		asm volatile("lctlg  13,13,%0"
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-s390/page.h linux-2.6.10rc1-4level/include/asm-s390/page.h
--- linux-2.6.10rc1/include/asm-s390/page.h	2004-10-19 01:55:34.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-s390/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -200,6 +200,8 @@ page_get_storage_key(unsigned long addr)
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _S390_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-s390/pgalloc.h linux-2.6.10rc1-4level/include/asm-s390/pgalloc.h
--- linux-2.6.10rc1/include/asm-s390/pgalloc.h	2004-05-10 09:44:23.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-s390/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -29,25 +29,6 @@ extern void diag10(unsigned long addr);
  * if any.
  */
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd;
-	int i;
-
-#ifndef __s390x__
-	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,1);
-        if (pgd != NULL)
-		for (i = 0; i < USER_PTRS_PER_PGD; i++)
-			pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
-#else /* __s390x__ */
-	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,2);
-        if (pgd != NULL)
-		for (i = 0; i < PTRS_PER_PGD; i++)
-			pgd_clear(pgd + i);
-#endif /* __s390x__ */
-	return pgd;
-}
-
 static inline void pgd_free(pgd_t *pgd)
 {
 #ifndef __s390x__
@@ -164,4 +145,6 @@ static inline void pte_free(struct page 
  */
 #define set_pgdir(addr,entry) do { } while(0)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _S390_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-s390/pgtable.h linux-2.6.10rc1-4level/include/asm-s390/pgtable.h
--- linux-2.6.10rc1/include/asm-s390/pgtable.h	2004-10-19 01:55:34.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-s390/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -90,15 +90,15 @@ extern char empty_zero_page[PAGE_SIZE];
  * pgd entries used up by user/kernel:
  */
 #ifndef __s390x__
-# define USER_PTRS_PER_PGD  512
-# define USER_PGD_PTRS      512
-# define KERNEL_PGD_PTRS    512
-# define FIRST_USER_PGD_NR  0
+# define USER_PGDS_IN_LAST_PML4	512
+# define USER_PGD_PTRS      	512
+# define KERNEL_PGD_PTRS    	512
+# define FIRST_USER_PGD_NR  	0
 #else /* __s390x__ */
-# define USER_PTRS_PER_PGD  2048
-# define USER_PGD_PTRS      2048
-# define KERNEL_PGD_PTRS    2048
-# define FIRST_USER_PGD_NR  0
+# define USER_PGDS_IN_LAST_PML4	2048
+# define USER_PGD_PTRS      	2048
+# define KERNEL_PGD_PTRS    	2048
+# define FIRST_USER_PGD_NR  	0
 #endif /* __s390x__ */
 
 #define pte_ERROR(e) \
@@ -680,10 +680,7 @@ static inline pte_t mk_pte_phys(unsigned
 
 /* to find an entry in a page-table-directory */
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
-#define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
-
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+#define pgd_index_k(address) pgd_index(address)
 
 #ifndef __s390x__
 
@@ -798,5 +795,7 @@ extern inline pte_t mk_swap_pte(unsigned
 #define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_YOUNG
 #include <asm-generic/pgtable.h>
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* _S390_PAGE_H */
 
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
