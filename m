Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVHXSkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVHXSkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVHXSkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:40:51 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:36614 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751381AbVHXSku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:40:50 -0400
Date: Wed, 24 Aug 2005 11:41:06 -0700
Message-Id: <200508241841.j7OIf6q4001874@zach-dev.vmware.com>
Subject: [PATCH 1/5] Add pagetable allocation notifiers
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Virtualization Mailing List <virtualization@lists.osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
To: Pratap Subrahmanyam <pratap@vmware.com>
To: Christopher Li <chrisl@vmware.com>
To: Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 24 Aug 2005 18:41:07.0257 (UTC) FILETIME=[639E9A90:01C5A8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hooks are provided for the mach-XXX subarchitecture at the time prior to a
page being used as a page table at all levels, for PAE and non-PAE kernels.
Note that in PAE mode, multiple PDP roots may exist on the same page with
other data, so the root must be shadowed instead.  This is not a performance
issue, since PAE only uses 4 top level PDPEs.

The hooks are:

SetPagePTE(ppn) - indicates that a given physical page is going to be used
as a page table.

SetPagePDE(ppn) - indicates that a given physical page is going to be used
as a page directory.

ClearPageXXX(ppn) - indicates that the physical page is now done being
used as a certain type of page.

These hooks can be used in two ways; for shadow mode, they serve as
requests to pre-allocate and deallocate shadow page tables, and for
direct page table mode, they serve as write protect/unprotect requests.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Patch-subject: Add pagetable allocation notifiers
Index: linux-2.6.13/arch/i386/mm/init.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/init.c	2005-08-24 09:31:05.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/init.c	2005-08-24 09:31:31.000000000 -0700
@@ -79,6 +79,7 @@ static pte_t * __init one_page_table_ini
 {
 	if (pmd_none(*pmd)) {
 		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		SetPagePTE(virt_to_page(page_table));
 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
 		if (page_table != pte_offset_kernel(pmd, 0))
 			BUG();	
Index: linux-2.6.13/arch/i386/mm/pageattr.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pageattr.c	2005-08-24 09:31:05.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pageattr.c	2005-08-24 09:31:31.000000000 -0700
@@ -52,8 +52,9 @@ static struct page *split_large_page(uns
 	address = __pa(address);
 	addr = address & LARGE_PAGE_MASK; 
 	pbase = (pte_t *)page_address(base);
+	SetPagePTE(virt_to_page(pbase));
 	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
-               set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
+		set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
                                           addr == address ? prot : PAGE_KERNEL));
 	}
 	return base;
@@ -146,6 +147,7 @@ __change_page_attr(struct page *page, pg
 		BUG_ON(!page_count(kpte_page));
 
 		if (cpu_has_pse && (page_count(kpte_page) == 1)) {
+			ClearPagePTE(virt_to_page(kpte));
 			list_add(&kpte_page->lru, &df_list);
 			revert_page(kpte_page, address);
 		}
Index: linux-2.6.13/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pgtable.c	2005-08-24 09:31:05.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pgtable.c	2005-08-24 09:40:22.000000000 -0700
@@ -209,6 +209,7 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 
 	if (PTRS_PER_PMD == 1) {
 		memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
+		SetPagePDE(virt_to_page(pgd));
 		spin_lock_irqsave(&pgd_lock, flags);
 	}
 
@@ -227,6 +228,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 {
 	unsigned long flags; /* can be called from interrupt context */
 
+	ClearPagePDE(virt_to_page(pgd));
 	spin_lock_irqsave(&pgd_lock, flags);
 	pgd_list_del(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
@@ -244,13 +246,16 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		if (!pmd)
 			goto out_oom;
+		SetPagePDE(virt_to_page(pmd));
 		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
 	}
 	return pgd;
 
 out_oom:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
+		ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> PAGE_SHIFT));
 		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	}
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -261,8 +266,10 @@ void pgd_free(pgd_t *pgd)
 
 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+			ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> PAGE_SHIFT));
+			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i]) & PAGE_MASK));
+		}
 	/* in the non-PAE case, free_pgtables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
Index: linux-2.6.13/include/asm-i386/pgalloc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgalloc.h	2005-08-24 09:31:05.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgalloc.h	2005-08-24 09:34:17.000000000 -0700
@@ -5,14 +5,22 @@
 #include <asm/fixmap.h>
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */
+#include <mach_pgalloc.h>
 
-#define pmd_populate_kernel(mm, pmd, pte) \
-		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
+#define pmd_populate_kernel(mm, pmd, pte) 			\
+do {								\
+	SetPagePTE(virt_to_page(pte));				\
+	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)));		\
+} while (0)
 
 #define pmd_populate(mm, pmd, pte) 				\
+do {								\
+	SetPagePTE(pte);					\
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
 		((unsigned long long)page_to_pfn(pte) <<	\
-			(unsigned long long) PAGE_SHIFT)))
+			(unsigned long long) PAGE_SHIFT)));	\
+} while (0)
+
 /*
  * Allocate and free page tables.
  */
@@ -33,7 +41,11 @@ static inline void pte_free(struct page 
 }
 
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte) 		\
+do {						\
+	tlb_remove_page((tlb),(pte));		\
+	ClearPagePTE(pte);			\
+} while (0)
 
 #ifdef CONFIG_X86_PAE
 /*
Index: linux-2.6.13/include/asm-i386/mach-default/mach_pgalloc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_pgalloc.h	2005-08-24 09:31:05.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_pgalloc.h	2005-08-24 09:31:31.000000000 -0700
@@ -1,7 +1,40 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
 #ifndef __ASM_MACH_PGALLOC_H
 #define __ASM_MACH_PGALLOC_H
 
+/*
+ * These hooks allow the hypervisor to be notified about page type
+ * transition events.
+ */
+
+#define SetPagePTE(_page)
+#define ClearPagePTE(_page)
+#define SetPagePDE(_page)
+#define ClearPagePDE(_page)
+
 #define SetPagesLDT(_va, _pages)
 #define ClearPagesLDT(_va, _pages)
 
-#endif
+#endif /* _ASM_MACH_PGALLOC_H */
