Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVHXVnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVHXVnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVHXVnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:43:19 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:42758 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932287AbVHXVnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:43:16 -0400
Message-ID: <430CE9F2.4070605@vmware.com>
Date: Wed, 24 Aug 2005 14:43:14 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
Subject: [UPDATED] Re: [PATCH 1/5] Add pagetable allocation notifiers
References: <200508241841.j7OIf6q4001874@zach-dev.vmware.com> <20050824194816.GK7762@shell0.pdx.osdl.net> <430CE30F.7050408@vmware.com> <20050824211826.GO7762@shell0.pdx.osdl.net>
In-Reply-To: <20050824211826.GO7762@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------070801060404070609020406"
X-OriginalArrivalTime: 24 Aug 2005 21:43:32.0976 (UTC) FILETIME=[DFC6C700:01C5A8F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070801060404070609020406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:

>* Zachary Amsden (zach@vmware.com) wrote:
>  
>
>>Chris Wright wrote:
>>
>>    
>>
>>>* Zachary Amsden (zach@vmware.com) wrote:
>>>
>>>
>>>      
>>>
>>>>--- linux-2.6.13.orig/arch/i386/mm/init.c	2005-08-24 
>>>>09:31:05.000000000 -0700
>>>>+++ linux-2.6.13/arch/i386/mm/init.c	2005-08-24 09:31:31.000000000 -0700
>>>>@@ -79,6 +79,7 @@ static pte_t * __init one_page_table_ini
>>>>{
>>>>	if (pmd_none(*pmd)) {
>>>>		pte_t *page_table = (pte_t *) 
>>>>		alloc_bootmem_low_pages(PAGE_SIZE);
>>>>+		SetPagePTE(virt_to_page(page_table));
>>>>  
>>>>
>>>>        
>>>>
>>>Xen has this on one_md_table_init() as well for pmd.
>>>      
>>>
>>I'll add that in another patch.  It's easy to miss some of the init time 
>>call sites (we don't actually depend on them for correctness).
>>    
>>
>
>You could just respin this patch.
>  
>

Done.  Looks like you want empty_zero_page write protected too.  That 
seems like a fine idea to me unless something really wants to do atomic 
64-bit reads on it.

>>>>        
>>>>
>>>Why the switch of kmem_cache_free call?
>>>      
>>>
>>Because pgd_val(pgd[i])-1 is confusing.
>>    
>>
>
>Yes, I agree it is.  That's why I was wondering about the ClearPagePDE calls
>which don't use them.
>  
>

The -1 is quite useless when you're going to shift  >> 12 anyways to get 
a frame number to index into mem_map, which is why they are not there.  
Plus, it just seems scary if you got it wrong - let's say you had a not 
present page - not that you could, but now you are freeing a misaligned 
address in the _previous_ page.  I really don't like that -1 at all.  I 
will clean it up, but it does certainly deserve another patch.

>  
>
>>Using (pgd_val(pgd[i]) - 
>>_PAGE_PRESENT) would be better, but the +/- 1s all over the place here 
>>could use some general cleanup as well.  I smell a cleanup fit coming 
>>on.  Using (pgd_val(pgd[i]) & PAGE_MASK) is a less error prone way to 
>>get the physical frame bits, since it is not wrong if you turn on PCD or 
>>PWD.
>>    
>>
>
>Please save all that for later cleanup.  As it stands it's just a conversion
>of one random call site, which should be dropped from the patch.
>  
>

Working on it now.

--------------070801060404070609020406
Content-Type: text/plain;
 name="add-pgtable-allocation-notifiers"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-pgtable-allocation-notifiers"

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
--- linux-2.6.13.orig/arch/i386/mm/init.c	2005-08-24 14:34:30.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/init.c	2005-08-24 14:35:50.000000000 -0700
@@ -59,6 +59,7 @@ static pmd_t * __init one_md_table_init(
 		
 #ifdef CONFIG_X86_PAE
 	pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	SetPagePDE(virt_to_page(pmd_table));
 	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
 	pud = pud_offset(pgd, 0);
 	if (pmd_table != pmd_offset(pud, 0)) 
@@ -79,6 +80,7 @@ static pte_t * __init one_page_table_ini
 {
 	if (pmd_none(*pmd)) {
 		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		SetPagePTE(virt_to_page(page_table));
 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
 		if (page_table != pte_offset_kernel(pmd, 0))
 			BUG();	
@@ -313,6 +315,7 @@ static void __init pagetable_init (void)
 #ifdef CONFIG_X86_PAE
 	int i;
 	/* Init entries of the first-level page table to the zero page */
+	SetPagePDE(virt_to_page(empty_zero_page));
 	for (i = 0; i < PTRS_PER_PGD; i++)
 		set_pgd(pgd_base + i, __pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
 #endif
Index: linux-2.6.13/arch/i386/mm/pageattr.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pageattr.c	2005-08-24 14:34:30.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pageattr.c	2005-08-24 14:36:09.000000000 -0700
@@ -52,6 +52,7 @@ static struct page *split_large_page(uns
 	address = __pa(address);
 	addr = address & LARGE_PAGE_MASK; 
 	pbase = (pte_t *)page_address(base);
+	SetPagePTE(virt_to_page(pbase));
 	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
                set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
                                           addr == address ? prot : PAGE_KERNEL));
@@ -146,6 +147,7 @@ __change_page_attr(struct page *page, pg
 		BUG_ON(!page_count(kpte_page));
 
 		if (cpu_has_pse && (page_count(kpte_page) == 1)) {
+			ClearPagePTE(virt_to_page(kpte));
 			list_add(&kpte_page->lru, &df_list);
 			revert_page(kpte_page, address);
 		}
Index: linux-2.6.13/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pgtable.c	2005-08-24 14:34:30.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pgtable.c	2005-08-24 14:35:50.000000000 -0700
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
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+			ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> PAGE_SHIFT));
 			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+		}
 	/* in the non-PAE case, free_pgtables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
Index: linux-2.6.13/include/asm-i386/pgalloc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgalloc.h	2005-08-24 14:34:30.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgalloc.h	2005-08-24 14:35:50.000000000 -0700
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
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_pgalloc.h	2005-08-24 14:34:30.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_pgalloc.h	2005-08-24 14:35:50.000000000 -0700
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

--------------070801060404070609020406--
