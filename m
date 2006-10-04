Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbWJDSAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWJDSAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161813AbWJDSAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:00:20 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:4189 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422631AbWJDSAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:00:08 -0400
Date: Wed, 4 Oct 2006 20:00:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Remove open-coded mem_map usage.
Message-ID: <20061004180010.GI26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Remove open-coded mem_map usage.

Use page_to_phys and pfn_to_page to avoid open-coded mem_map usage.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/mm/init.c        |   10 ++++++----
 include/asm-s390/io.h      |    5 -----
 include/asm-s390/page.h    |    1 +
 include/asm-s390/pgalloc.h |    2 +-
 include/asm-s390/pgtable.h |   18 +++++++++---------
 5 files changed, 17 insertions(+), 19 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2006-10-04 19:53:52.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/init.c	2006-10-04 19:53:52.000000000 +0200
@@ -62,19 +62,21 @@ void show_mem(void)
 {
         int i, total = 0, reserved = 0;
         int shared = 0, cached = 0;
+	struct page *page;
 
         printk("Mem-info:\n");
         show_free_areas();
         printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
         i = max_mapnr;
         while (i-- > 0) {
+		page = pfn_to_page(i);
                 total++;
-                if (PageReserved(mem_map+i))
+		if (PageReserved(page))
                         reserved++;
-                else if (PageSwapCache(mem_map+i))
+		else if (PageSwapCache(page))
                         cached++;
-                else if (page_count(mem_map+i))
-                        shared += page_count(mem_map+i) - 1;
+		else if (page_count(page))
+			shared += page_count(page) - 1;
         }
         printk("%d pages of RAM\n",total);
         printk("%d reserved pages\n",reserved);
diff -urpN linux-2.6/include/asm-s390/io.h linux-2.6-patched/include/asm-s390/io.h
--- linux-2.6/include/asm-s390/io.h	2006-10-04 19:53:37.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/io.h	2006-10-04 19:53:52.000000000 +0200
@@ -45,11 +45,6 @@ static inline void * phys_to_virt(unsign
         return __io_virt(address);
 }
 
-/*
- * Change "struct page" to physical address.
- */
-#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
-
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
 static inline void * ioremap (unsigned long offset, unsigned long size)
diff -urpN linux-2.6/include/asm-s390/page.h linux-2.6-patched/include/asm-s390/page.h
--- linux-2.6/include/asm-s390/page.h	2006-10-04 19:53:37.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/page.h	2006-10-04 19:53:52.000000000 +0200
@@ -137,6 +137,7 @@ page_get_storage_key(unsigned long addr)
 #define __pa(x)                 (unsigned long)(x)
 #define __va(x)                 (void *)(unsigned long)(x)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
diff -urpN linux-2.6/include/asm-s390/pgalloc.h linux-2.6-patched/include/asm-s390/pgalloc.h
--- linux-2.6/include/asm-s390/pgalloc.h	2006-10-04 19:53:37.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/pgalloc.h	2006-10-04 19:53:52.000000000 +0200
@@ -116,7 +116,7 @@ pmd_populate_kernel(struct mm_struct *mm
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
 {
-	pmd_populate_kernel(mm, pmd, (pte_t *)((page-mem_map) << PAGE_SHIFT));
+	pmd_populate_kernel(mm, pmd, (pte_t *)page_to_phys(page));
 }
 
 /*
diff -urpN linux-2.6/include/asm-s390/pgtable.h linux-2.6-patched/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2006-10-04 19:53:37.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/pgtable.h	2006-10-04 19:53:52.000000000 +0200
@@ -599,7 +599,7 @@ ptep_establish(struct vm_area_struct *vm
  */
 static inline int page_test_and_clear_dirty(struct page *page)
 {
-	unsigned long physpage = __pa((page - mem_map) << PAGE_SHIFT);
+	unsigned long physpage = page_to_phys(page);
 	int skey = page_get_storage_key(physpage);
 
 	if (skey & _PAGE_CHANGED)
@@ -612,13 +612,13 @@ static inline int page_test_and_clear_di
  */
 static inline int page_test_and_clear_young(struct page *page)
 {
-	unsigned long physpage = __pa((page - mem_map) << PAGE_SHIFT);
+	unsigned long physpage = page_to_phys(page);
 	int ccode;
 
-	asm volatile (
-		"rrbe 0,%1\n"
-		"ipm  %0\n"
-		"srl  %0,28\n"
+	asm volatile(
+		"	rrbe	0,%1\n"
+		"	ipm	%0\n"
+		"	srl	%0,28\n"
 		: "=d" (ccode) : "a" (physpage) : "cc" );
 	return ccode & 2;
 }
@@ -636,7 +636,7 @@ static inline pte_t mk_pte_phys(unsigned
 
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
-	unsigned long physpage = __pa((page - mem_map) << PAGE_SHIFT);
+	unsigned long physpage = page_to_phys(page);
 
 	return mk_pte_phys(physpage, pgprot);
 }
@@ -664,11 +664,11 @@ static inline pmd_t pfn_pmd(unsigned lon
 
 #define pmd_page_vaddr(pmd) (pmd_val(pmd) & PAGE_MASK)
 
-#define pmd_page(pmd) (mem_map+(pmd_val(pmd) >> PAGE_SHIFT))
+#define pmd_page(pmd) pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 
 #define pgd_page_vaddr(pgd) (pgd_val(pgd) & PAGE_MASK)
 
-#define pgd_page(pgd) (mem_map+(pgd_val(pgd) >> PAGE_SHIFT))
+#define pgd_page(pgd) pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
 
 /* to find an entry in a page-table-directory */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
