Return-Path: <linux-kernel-owner+w=401wt.eu-S1751255AbWLOGxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWLOGxi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 01:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLOGxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 01:53:05 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47549 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbWLOGwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 01:52:34 -0500
Date: Thu, 14 Dec 2006 22:51:49 -0800
Message-Id: <200612150651.kBF6pnhH025507@zach-dev.vmware.com>
Subject: [PATCH 1/6] Page allocation hooks for VMI backend
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 15 Dec 2006 06:51:50.0020 (UTC) FILETIME=[7EFC1440:01C72015]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VMI backend uses explicit page type notification to track shadow
page tables.  The allocation of page table roots is especially tricky.
We need to clone the root for non-PAE mode while it is protected under
the pgd lock to correctly copy the shadow.

We don't need to allocate pgds in PAE mode, (PDPs in Intel terminology)
as they only have 4 entries, and are cached entirely by the processor,
which makes shadowing them rather simple.

For base page table level allocation, pmd_populate provides the exact hook
point we need.  Also, we need to allocate pages when splitting a large page,
and we must release pages before returning the page to any free pool.

Despite being required with these slightly odd semantics for VMI, Xen also 
uses these hooks to determine the exact moment when page tables are created
or released.

Subject: Page allocation hooks for VMI backend
Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -545,6 +545,12 @@ struct paravirt_ops paravirt_ops = {
 	.flush_tlb_kernel = native_flush_tlb_global,
 	.flush_tlb_single = native_flush_tlb_single,
 
+	.alloc_pt = (void *)native_nop,
+	.alloc_pd = (void *)native_nop,
+	.alloc_pd_clone = (void *)native_nop,
+	.release_pt = (void *)native_nop,
+	.release_pd = (void *)native_nop,
+
 	.set_pte = native_set_pte,
 	.set_pte_at = native_set_pte_at,
 	.set_pmd = native_set_pmd,
===================================================================
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -62,6 +62,7 @@ static pmd_t * __init one_md_table_init(
 		
 #ifdef CONFIG_X86_PAE
 	pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	paravirt_alloc_pd(__pa(pmd_table) >> PAGE_SHIFT);
 	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
 	pud = pud_offset(pgd, 0);
 	if (pmd_table != pmd_offset(pud, 0)) 
@@ -82,6 +83,7 @@ static pte_t * __init one_page_table_ini
 {
 	if (pmd_none(*pmd)) {
 		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		paravirt_alloc_pt(__pa(page_table) >> PAGE_SHIFT);
 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
 		if (page_table != pte_offset_kernel(pmd, 0))
 			BUG();	
@@ -347,6 +349,8 @@ static void __init pagetable_init (void)
 	/* Init entries of the first-level page table to the zero page */
 	for (i = 0; i < PTRS_PER_PGD; i++)
 		set_pgd(pgd_base + i, __pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
+#else
+	paravirt_alloc_pd(__pa(swapper_pg_dir) >> PAGE_SHIFT);
 #endif
 
 	/* Enable PSE if available */
===================================================================
--- a/arch/i386/mm/pageattr.c
+++ b/arch/i386/mm/pageattr.c
@@ -60,6 +60,7 @@ static struct page *split_large_page(uns
 	address = __pa(address);
 	addr = address & LARGE_PAGE_MASK; 
 	pbase = (pte_t *)page_address(base);
+	paravirt_alloc_pt(page_to_pfn(base));
 	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
                set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
                                           addr == address ? prot : ref_prot));
@@ -166,6 +167,7 @@ __change_page_attr(struct page *page, pg
 	if (!PageReserved(kpte_page)) {
 		if (cpu_has_pse && (page_private(kpte_page) == 0)) {
 			ClearPagePrivate(kpte_page);
+			paravirt_release_pt(page_to_pfn(kpte_page));
 			list_add(&kpte_page->lru, &df_list);
 			revert_page(kpte_page, address);
 		}
===================================================================
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -245,8 +245,14 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
 			KERNEL_PGD_PTRS);
+
 	if (PTRS_PER_PMD > 1)
 		return;
+
+	/* must happen under lock */
+	paravirt_alloc_pd_clone(__pa(pgd) >> PAGE_SHIFT,
+			__pa(swapper_pg_dir) >> PAGE_SHIFT,
+			USER_PTRS_PER_PGD, PTRS_PER_PGD - USER_PTRS_PER_PGD);
 
 	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
@@ -257,6 +263,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 {
 	unsigned long flags; /* can be called from interrupt context */
 
+	paravirt_release_pd(__pa(pgd) >> PAGE_SHIFT);
 	spin_lock_irqsave(&pgd_lock, flags);
 	pgd_list_del(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
@@ -274,13 +281,18 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		if (!pmd)
 			goto out_oom;
+		paravirt_alloc_pd(__pa(pmd) >> PAGE_SHIFT);
 		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
 	}
 	return pgd;
 
 out_oom:
-	for (i--; i >= 0; i--)
-		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	for (i--; i >= 0; i--) {
+		pgd_t pgdent = pgd[i];
+		void* pmd = (void *)__va(pgd_val(pgdent)-1);
+		paravirt_release_pd(__pa(pmd) >> PAGE_SHIFT);
+		kmem_cache_free(pmd_cache, pmd);
+	}
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -291,8 +303,12 @@ void pgd_free(pgd_t *pgd)
 
 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+			pgd_t pgdent = pgd[i];
+			void* pmd = (void *)__va(pgd_val(pgdent)-1);
+			paravirt_release_pd(__pa(pmd) >> PAGE_SHIFT);
+			kmem_cache_free(pmd_cache, pmd);
+		}
 	/* in the non-PAE case, free_pgtables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -126,6 +126,12 @@ struct paravirt_ops
 	void (fastcall *flush_tlb_user)(void);
 	void (fastcall *flush_tlb_kernel)(void);
 	void (fastcall *flush_tlb_single)(u32 addr);
+
+	void (fastcall *alloc_pt)(u32 pfn);
+	void (fastcall *alloc_pd)(u32 pfn);
+	void (fastcall *alloc_pd_clone)(u32 pfn, u32 clonepfn, u32 start, u32 count);
+	void (fastcall *release_pt)(u32 pfn);
+	void (fastcall *release_pd)(u32 pfn);
 
 	void (fastcall *set_pte)(pte_t *ptep, pte_t pteval);
 	void (fastcall *set_pte_at)(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval);
@@ -325,6 +331,14 @@ static __inline unsigned long apic_read(
 #define __flush_tlb_global() paravirt_ops.flush_tlb_kernel()
 #define __flush_tlb_single(addr) paravirt_ops.flush_tlb_single(addr)
 
+#define paravirt_alloc_pt(pfn) paravirt_ops.alloc_pt(pfn)
+#define paravirt_release_pt(pfn) paravirt_ops.release_pt(pfn)
+
+#define paravirt_alloc_pd(pfn) paravirt_ops.alloc_pd(pfn)
+#define paravirt_alloc_pd_clone(pfn, clonepfn, start, count) \
+	paravirt_ops.alloc_pd_clone(pfn, clonepfn, start, count)
+#define paravirt_release_pd(pfn) paravirt_ops.release_pd(pfn)
+
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
 	paravirt_ops.set_pte(ptep, pteval);
===================================================================
--- a/include/asm-i386/pgalloc.h
+++ b/include/asm-i386/pgalloc.h
@@ -5,13 +5,31 @@
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */
 
-#define pmd_populate_kernel(mm, pmd, pte) \
-		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define paravirt_alloc_pt(pfn) do { } while (0)
+#define paravirt_alloc_pd(pfn) do { } while (0)
+#define paravirt_alloc_pd(pfn) do { } while (0)
+#define paravirt_alloc_pd_clone(pfn, clonepfn, start, count) do { } while (0)
+#define paravirt_release_pt(pfn) do { } while (0)
+#define paravirt_release_pd(pfn) do { } while (0)
+#endif
+
+#define pmd_populate_kernel(mm, pmd, pte)			\
+do {								\
+	paravirt_alloc_pt(__pa(pte) >> PAGE_SHIFT);		\
+	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)));		\
+} while (0)
 
 #define pmd_populate(mm, pmd, pte) 				\
+do {								\
+	paravirt_alloc_pt(page_to_pfn(pte));			\
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
 		((unsigned long long)page_to_pfn(pte) <<	\
-			(unsigned long long) PAGE_SHIFT)))
+			(unsigned long long) PAGE_SHIFT)));	\
+} while (0)
+
 /*
  * Allocate and free page tables.
  */
@@ -32,7 +50,11 @@ static inline void pte_free(struct page 
 }
 
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte) 					\
+do {									\
+	paravirt_release_pt(page_to_pfn(pte));				\
+	tlb_remove_page((tlb),(pte));					\
+} while (0)
 
 #ifdef CONFIG_X86_PAE
 /*
