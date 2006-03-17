Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWCQSTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWCQSTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWCQSTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:19:43 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:7947 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030251AbWCQSTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:19:42 -0500
Message-ID: <441AFDBD.2060609@vmware.com>
Date: Fri, 17 Mar 2006 10:19:41 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Anthony Liguori <aliguori@us.ibm.com>,
       Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       xen-devel <xen-devel@lists.xensource.com>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [RFC] VMI for Xen?
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9D86@liverpoolst.ad.cl.cam.ac.uk>	<4419F5DD.70100@us.ibm.com> <f5223af6b2ced67e70d3ae5254a784b5@cl.cam.ac.uk>
In-Reply-To: <f5223af6b2ced67e70d3ae5254a784b5@cl.cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------050908070509080805070104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050908070509080805070104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Keir Fraser wrote:
>
> On 16 Mar 2006, at 23:33, Anthony Liguori wrote:
>
>> Actually, the new spec does support non-shadow paging.  All page 
>> table updates are done via the VMI ROM.  Normally, these are just 
>> normal get/set operations but they could be get/sets with p2m looks.  
>> The first version of the spec definitely didn't support non-shadow 
>> paging though.
>
> I don't see any hooks for pte reads, which need m2p conversion in a 
> non-shadow environment.

I've attached a patch.  It is complete, but rather scary to maintain.  I 
think with help from Linus' sparse checker, it might be more easily 
maintained by using noderef on the PTE types.  We would like to propose 
it as an alternative to the m2p conversion layer.

>
> And the documentation is out of whack with the code patches now I look 
> more closely at the mmu patch. VMI_xxxPxExxx functions are not defined 
> in the spec, nor is VMI_AllocatePage.

Yes, as mentioned in the documentation, the MMU part of the spec is out 
of date - specifically because we know there are changes that need to be 
made there to accommodate Xen, and because we would like to shake out 
exactly what the simplest and cleanest interface is.

Zach

--------------050908070509080805070104
Content-Type: text/plain;
 name="mmu-pte-accessors"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmu-pte-accessors"

Introduce the get_pte family of macros.

These will be the hook points for vmi_get_pxe.  I tried to find all
the places a pte_t*, pgd_t*, etc were dereferenced using the compiler,
and compiling for many combinations of CONFIG options.

Testing: verify kernel binary unchanged from this change. Boot kernel.

Signed-off-by: Dan Hecht <dhecht@vmware.com>

Index: linux-2.6.16-rc6/arch/i386/kernel/vm86.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/vm86.c	2006-03-12 19:49:53.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/vm86.c	2006-03-12 19:57:58.000000000 -0800
@@ -155,8 +155,8 @@ static void mark_screen_rdonly(struct mm
 		goto out;
 	pte = pte_offset_map_lock(mm, pmd, 0xA0000, &ptl);
 	for (i = 0; i < 32; i++) {
-		if (pte_present(*pte))
-			set_pte(pte, pte_wrprotect(*pte));
+		if (pte_present(get_pte(pte)))
+			set_pte(pte, pte_wrprotect(get_pte(pte)));
 		pte++;
 	}
 	pte_unmap_unlock(pte, ptl);
Index: linux-2.6.16-rc6/arch/i386/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/acpi/sleep.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/acpi/sleep.c	2006-03-12 19:57:58.000000000 -0800
@@ -26,7 +26,7 @@ static void init_low_mapping(pgd_t * pgd
 
 	while ((pgd_ofs < pgd_limit)
 	       && (pgd_ofs + USER_PTRS_PER_PGD < PTRS_PER_PGD)) {
-		set_pgd(pgd, *(pgd + USER_PTRS_PER_PGD));
+		set_pgd(pgd, get_pgd(pgd + USER_PTRS_PER_PGD));
 		pgd_ofs++, pgd++;
 	}
 	flush_tlb_all();
Index: linux-2.6.16-rc6/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mm/fault.c	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mm/fault.c	2006-03-12 19:57:58.000000000 -0800
@@ -444,7 +444,7 @@ no_context:
 	if (error_code & 16) {
 		pte_t *pte = lookup_address(address);
 
-		if (pte && pte_present(*pte) && !pte_exec_kernel(*pte))
+		if (pte && pte_present(get_pte(pte)) && !pte_exec_kernel(get_pte(pte)))
 			printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
 	}
 #endif
@@ -456,6 +456,7 @@ no_context:
 	printk(KERN_ALERT " printing eip:\n");
 	printk("%08lx\n", regs->eip);
 	page = read_cr3();
+	/* XXXPara: reads page tables without get_pxe. */
 	page = ((unsigned long *) __va(page))[address >> 22];
 	printk(KERN_ALERT "*pde = %08lx\n", page);
 	/*
@@ -532,7 +533,7 @@ vmalloc_fault:
 		pgd = index + (pgd_t *)__va(pgd_paddr);
 		pgd_k = init_mm.pgd + index;
 
-		if (!pgd_present(*pgd_k))
+		if (!pgd_present(get_pgd(pgd_k)))
 			goto no_context;
 
 		/*
@@ -543,24 +544,26 @@ vmalloc_fault:
 
 		pud = pud_offset(pgd, address);
 		pud_k = pud_offset(pgd_k, address);
-		if (!pud_present(*pud_k))
+		if (!pud_present(get_pud(pud_k)))
 			goto no_context;
 		
 		pmd = pmd_offset(pud, address);
 		pmd_k = pmd_offset(pud_k, address);
-		if (!pmd_present(*pmd_k))
+		if (!pmd_present(get_pmd(pmd_k)))
 			goto no_context;
-		set_pmd(pmd, *pmd_k);
+		set_pmd(pmd, get_pmd(pmd_k));
 
 		/*
 		 * Needed.  We have just updated this root with a copy of
 		 * the kernel pmd.  To return without flushing would
 		 * introduce a fault loop.
+		 *
+		 * XXXPara: update_mmu_cache args: fixme
 		 */
-		update_mmu_cache(NULL, pmd, pmd_k->pmd);
+		update_mmu_cache(NULL, pmd, get_pmd(pmd_k).pmd);
 
 		pte_k = pte_offset_kernel(pmd_k, address);
-		if (!pte_present(*pte_k))
+		if (!pte_present(get_pte(pte_k)))
 			goto no_context;
 		return;
 	}
Index: linux-2.6.16-rc6/arch/i386/mm/highmem.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mm/highmem.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mm/highmem.c	2006-03-12 19:57:58.000000000 -0800
@@ -39,7 +39,7 @@ void *kmap_atomic(struct page *page, enu
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
-	if (!pte_none(*(kmap_pte-idx)))
+	if (!pte_none(get_pte(kmap_pte-idx)))
 		BUG();
 #endif
 	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
@@ -103,7 +103,7 @@ struct page *kmap_atomic_to_page(void *p
 
 	idx = virt_to_fix(vaddr);
 	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
-	return pte_page(*pte);
+	return pte_page(get_pte(pte));
 }
 
 EXPORT_SYMBOL(kmap);
Index: linux-2.6.16-rc6/arch/i386/mm/hugetlbpage.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mm/hugetlbpage.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mm/hugetlbpage.c	2006-03-12 19:57:58.000000000 -0800
@@ -28,7 +28,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
 	pud = pud_alloc(mm, pgd, addr);
 	if (pud)
 		pte = (pte_t *) pmd_alloc(mm, pud, addr);
-	BUG_ON(pte && !pte_none(*pte) && !pte_huge(*pte));
+	BUG_ON(pte && !pte_none(get_pte(pte)) && !pte_huge(get_pte(pte)));
 
 	return pte;
 }
@@ -40,9 +40,9 @@ pte_t *huge_pte_offset(struct mm_struct 
 	pmd_t *pmd = NULL;
 
 	pgd = pgd_offset(mm, addr);
-	if (pgd_present(*pgd)) {
+	if (pgd_present(get_pgd(pgd))) {
 		pud = pud_offset(pgd, addr);
-		if (pud_present(*pud))
+		if (pud_present(get_pud(pud)))
 			pmd = pmd_offset(pud, addr);
 	}
 	return (pte_t *) pmd;
@@ -77,9 +77,9 @@ follow_huge_addr(struct mm_struct *mm, u
 	pte = huge_pte_offset(mm, address);
 
 	/* hugetlb should be locked, and hence, prefaulted */
-	WARN_ON(!pte || pte_none(*pte));
+	WARN_ON(!pte || pte_none(get_pte(pte)));
 
-	page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
+	page = &pte_page(get_pte(pte))[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
 
 	WARN_ON(!PageCompound(page));
 
@@ -117,7 +117,7 @@ follow_huge_pmd(struct mm_struct *mm, un
 {
 	struct page *page;
 
-	page = pte_page(*(pte_t *)pmd);
+	page = pte_page(get_pte((pte_t *)pmd));
 	if (page)
 		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
 	return page;
Index: linux-2.6.16-rc6/arch/i386/mm/init.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mm/init.c	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mm/init.c	2006-03-12 19:57:58.000000000 -0800
@@ -78,7 +78,7 @@ static pmd_t * __init one_md_table_init(
  */
 static pte_t * __init one_page_table_init(pmd_t *pmd)
 {
-	if (pmd_none(*pmd)) {
+	if (pmd_none(get_pmd(pmd))) {
 		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 		mach_setup_pte(__pa(page_table) >> PAGE_SHIFT);
 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
@@ -116,12 +116,12 @@ static void __init page_table_range_init
 	pgd = pgd_base + pgd_idx;
 
 	for ( ; (pgd_idx < PTRS_PER_PGD) && (vaddr != end); pgd++, pgd_idx++) {
-		if (pgd_none(*pgd)) 
+		if (pgd_none(get_pgd(pgd))) 
 			one_md_table_init(pgd);
 		pud = pud_offset(pgd, vaddr);
 		pmd = pmd_offset(pud, vaddr);
 		for (; (pmd_idx < PTRS_PER_PMD) && (vaddr != end); pmd++, pmd_idx++) {
-			if (pmd_none(*pmd)) 
+			if (pmd_none(get_pmd(pmd))) 
 				one_page_table_init(pmd);
 
 			vaddr += PMD_SIZE;
@@ -339,7 +339,7 @@ extern void __init remap_numa_kva(void);
 static void __init pagetable_init (void)
 {
 	unsigned long vaddr;
-	pgd_t *pgd_base = swapper_pg_dir;
+	pgd_t *pgd_base = (pgd_t*)swapper_pg_dir;
 
 #ifdef CONFIG_X86_PAE
 	int i;
@@ -380,7 +380,7 @@ static void __init pagetable_init (void)
 	 * All user-space mappings are explicitly cleared after
 	 * SMP startup.
 	 */
-	set_pgd(&pgd_base[0], pgd_base[USER_PTRS_PER_PGD]);
+	set_pgd(&pgd_base[0], get_pgd(&pgd_base[USER_PTRS_PER_PGD]));
 #endif
 
 }
@@ -395,6 +395,7 @@ char __nosavedata swsusp_pg_dir[PAGE_SIZ
 
 static inline void save_pg_dir(void)
 {
+	/* XXXPara: unfiltered read of PD. */
 	memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
 }
 #else
@@ -480,9 +481,10 @@ int __init set_kernel_exec(unsigned long
 	pte = lookup_address(vaddr);
 	BUG_ON(!pte);
 
-	if (!pte_exec_kernel(*pte))
+	if (!pte_exec_kernel(get_pte(pte)))
 		ret = 0;
 
+	/*XXXPara: fixme. */
 	if (enable)
 		pte->pte_high &= ~(1 << (_PAGE_BIT_NX - 32));
 	else
Index: linux-2.6.16-rc6/arch/i386/mm/ioremap.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mm/ioremap.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mm/ioremap.c	2006-03-12 19:57:58.000000000 -0800
@@ -32,7 +32,7 @@ static int ioremap_pte_range(pmd_t *pmd,
 	if (!pte)
 		return -ENOMEM;
 	do {
-		BUG_ON(!pte_none(*pte));
+		BUG_ON(!pte_none(get_pte(pte)));
 		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
 					_PAGE_DIRTY | _PAGE_ACCESSED | flags)));
 		pfn++;
Index: linux-2.6.16-rc6/arch/i386/mm/pageattr.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mm/pageattr.c	2006-03-12 19:49:53.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mm/pageattr.c	2006-03-12 19:57:58.000000000 -0800
@@ -24,15 +24,15 @@ pte_t *lookup_address(unsigned long addr
 	pgd_t *pgd = pgd_offset_k(address);
 	pud_t *pud;
 	pmd_t *pmd;
-	if (pgd_none(*pgd))
+	if (pgd_none(get_pgd(pgd)))
 		return NULL;
 	pud = pud_offset(pgd, address);
-	if (pud_none(*pud))
+	if (pud_none(get_pud(pud)))
 		return NULL;
 	pmd = pmd_offset(pud, address);
-	if (pmd_none(*pmd))
+	if (pmd_none(get_pmd(pmd)))
 		return NULL;
-	if (pmd_large(*pmd))
+	if (pmd_large(get_pmd(pmd)))
 		return (pte_t *)pmd;
         return pte_offset_kernel(pmd, address);
 } 
@@ -129,7 +129,7 @@ __change_page_attr(struct page *page, pg
 		return -EINVAL;
 	kpte_page = virt_to_page(kpte);
 	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) { 
-		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
+		if ((pte_val(get_pte(kpte)) & _PAGE_PSE) == 0) { 
 			set_pte_atomic(kpte, mk_pte(page, prot)); 
 		} else {
 			pgprot_t ref_prot;
@@ -145,7 +145,7 @@ __change_page_attr(struct page *page, pg
 			kpte_page = split;
 		}	
 		get_page(kpte_page);
-	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
+	} else if ((pte_val(get_pte(kpte)) & _PAGE_PSE) == 0) { 
 		set_pte_atomic(kpte, mk_pte(page, PAGE_KERNEL));
 		__put_page(kpte_page);
 	} else
Index: linux-2.6.16-rc6/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mm/pgtable.c	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mm/pgtable.c	2006-03-12 19:57:58.000000000 -0800
@@ -78,17 +78,17 @@ static void set_pte_pfn(unsigned long va
 	pte_t *pte;
 
 	pgd = swapper_pg_dir + pgd_index(vaddr);
-	if (pgd_none(*pgd)) {
+	if (pgd_none(get_pgd(pgd))) {
 		BUG();
 		return;
 	}
 	pud = pud_offset(pgd, vaddr);
-	if (pud_none(*pud)) {
+	if (pud_none(get_pud(pud))) {
 		BUG();
 		return;
 	}
 	pmd = pmd_offset(pud, vaddr);
-	if (pmd_none(*pmd)) {
+	if (pmd_none(get_pmd(pmd))) {
 		BUG();
 		return;
 	}
@@ -124,7 +124,7 @@ void set_pmd_pfn(unsigned long vaddr, un
 		return; /* BUG(); */
 	}
 	pgd = swapper_pg_dir + pgd_index(vaddr);
-	if (pgd_none(*pgd)) {
+	if (pgd_none(get_pgd(pgd))) {
 		printk(KERN_WARNING "set_pmd_pfn: pgd_none\n");
 		return; /* BUG(); */
 	}
@@ -267,8 +267,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 out_oom:
 	for (i--; i >= 0; i--) {
-		mach_release_pmd(pgd_val(pgd[i]) >> PAGE_SHIFT);
-		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+		pgd_t pgdent = get_pgd(&pgd[i]);
+		mach_release_pmd(pgd_val(pgdent) >> PAGE_SHIFT);
+		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgdent)-1));
 	}
 	mach_release_pgd(__pa(pgd) >> PAGE_SHIFT);
 	kmem_cache_free(pgd_cache, pgd);
@@ -282,8 +283,9 @@ void pgd_free(pgd_t *pgd)
 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1) {
 		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-			mach_release_pmd(pgd_val(pgd[i]) >> PAGE_SHIFT);
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+			pgd_t pgdent = get_pgd(&pgd[i]);
+			mach_release_pmd(pgd_val(pgdent) >> PAGE_SHIFT);
+			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgdent)-1));
 		}
 	}
 	/* in the non-PAE case, clear_page_range() clears user pgd entries */
Index: linux-2.6.16-rc6/fs/exec.c
===================================================================
--- linux-2.6.16-rc6.orig/fs/exec.c	2006-03-12 19:49:57.000000000 -0800
+++ linux-2.6.16-rc6/fs/exec.c	2006-03-12 19:57:58.000000000 -0800
@@ -316,7 +316,7 @@ void install_arg_page(struct vm_area_str
 	pte = get_locked_pte(mm, address, &ptl);
 	if (!pte)
 		goto out;
-	if (!pte_none(*pte)) {
+	if (!pte_none(get_pte(pte))) {
 		pte_unmap_unlock(pte, ptl);
 		goto out;
 	}
Index: linux-2.6.16-rc6/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.16-rc6.orig/fs/proc/task_mmu.c	2006-03-12 19:49:57.000000000 -0800
+++ linux-2.6.16-rc6/fs/proc/task_mmu.c	2006-03-12 19:57:58.000000000 -0800
@@ -208,7 +208,7 @@ static void smaps_pte_range(struct vm_ar
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	do {
-		ptent = *pte;
+		ptent = get_pte(pte);
 		if (!pte_present(ptent))
 			continue;
 
Index: linux-2.6.16-rc6/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-generic/pgtable.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-generic/pgtable.h	2006-03-12 19:57:58.000000000 -0800
@@ -1,6 +1,22 @@
 #ifndef _ASM_GENERIC_PGTABLE_H
 #define _ASM_GENERIC_PGTABLE_H
 
+#ifndef __HAVE_ARCH_GET_PTE
+#define get_pte(__ptep) (*(__ptep))
+#endif
+
+#ifndef __HAVE_ARCH_GET_PMD
+#define get_pmd(__pmdp) (*(__pmdp))
+#endif
+
+#ifndef __HAVE_ARCH_GET_PUD
+#define get_pud(__pudp) (*(__pudp))
+#endif
+
+#ifndef __HAVE_ARCH_GET_PGD
+#define get_pgd(__pgdp) (*(__pgdp))
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_ESTABLISH
 /*
  * Establish a new mapping:
@@ -45,7 +61,7 @@ do {				  					  \
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define ptep_test_and_clear_young(__vma, __address, __ptep)		\
 ({									\
-	pte_t __pte = *(__ptep);					\
+	pte_t __pte = get_pte(__ptep);		                        \
 	int r = 1;							\
 	if (!pte_young(__pte))						\
 		r = 0;							\
@@ -70,7 +86,7 @@ do {				  					  \
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define ptep_test_and_clear_dirty(__vma, __address, __ptep)		\
 ({									\
-	pte_t __pte = *__ptep;						\
+	pte_t __pte = get_pte(__ptep);					\
 	int r = 1;							\
 	if (!pte_dirty(__pte))						\
 		r = 0;							\
@@ -95,7 +111,7 @@ do {				  					  \
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear(__mm, __address, __ptep)			\
 ({									\
-	pte_t __pte = *(__ptep);					\
+	pte_t __pte = get_pte(__ptep);					\
 	pte_clear((__mm), (__address), (__ptep));			\
 	__pte;								\
 })
@@ -131,7 +147,7 @@ do {									\
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
-	pte_t old_pte = *ptep;
+	pte_t old_pte = get_pte(ptep);
 	set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
 }
 #endif
@@ -209,9 +225,9 @@ void pmd_clear_bad(pmd_t *);
 
 static inline int pgd_none_or_clear_bad(pgd_t *pgd)
 {
-	if (pgd_none(*pgd))
+	if (pgd_none(get_pgd(pgd)))
 		return 1;
-	if (unlikely(pgd_bad(*pgd))) {
+	if (unlikely(pgd_bad(get_pgd(pgd)))) {
 		pgd_clear_bad(pgd);
 		return 1;
 	}
@@ -220,9 +236,9 @@ static inline int pgd_none_or_clear_bad(
 
 static inline int pud_none_or_clear_bad(pud_t *pud)
 {
-	if (pud_none(*pud))
+	if (pud_none(get_pud(pud)))
 		return 1;
-	if (unlikely(pud_bad(*pud))) {
+	if (unlikely(pud_bad(get_pud(pud)))) {
 		pud_clear_bad(pud);
 		return 1;
 	}
@@ -231,9 +247,9 @@ static inline int pud_none_or_clear_bad(
 
 static inline int pmd_none_or_clear_bad(pmd_t *pmd)
 {
-	if (pmd_none(*pmd))
+	if (pmd_none(get_pmd(pmd)))
 		return 1;
-	if (unlikely(pmd_bad(*pmd))) {
+	if (unlikely(pmd_bad(get_pmd(pmd)))) {
 		pmd_clear_bad(pmd);
 		return 1;
 	}
Index: linux-2.6.16-rc6/include/asm-i386/pgalloc.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/pgalloc.h	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/pgalloc.h	2006-03-12 19:57:58.000000000 -0800
@@ -4,9 +4,10 @@
 #include <linux/config.h>
 #include <asm/fixmap.h>
 #include <linux/threads.h>
-#include <linux/mm.h>		/* for struct page */
 #include <mach_pgalloc.h>
 
+struct page;
+
 #define pmd_populate_kernel(mm, pmd, pte) 			\
 do {								\
 	mach_setup_pte(__pa(pte) >> PAGE_SHIFT);		\
Index: linux-2.6.16-rc6/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/pgtable-3level.h	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/pgtable-3level.h	2006-03-12 19:57:58.000000000 -0800
@@ -52,7 +52,7 @@ static inline int pte_exec_kernel(pte_t 
 
 
 /* Find an entry in the second-level page table.. */
-#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
+#define pmd_offset(pud, address) ((pmd_t *) pud_page(get_pud(pud)) + \
 			pmd_index(address))
 
 static inline int pte_same(pte_t a, pte_t b)
Index: linux-2.6.16-rc6/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/pgtable.h	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/pgtable.h	2006-03-12 19:57:58.000000000 -0800
@@ -260,14 +260,14 @@ static inline pte_t pte_mkhuge(pte_t pte
 #ifndef __HAVE_SUBARCH_PTE_WRITE_FUNCTIONS
 static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
-	if (!pte_dirty(*ptep))
+	if (!pte_dirty(get_pte(ptep)))
 		return 0;
 	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
 }
  
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
-	if (!pte_young(*ptep))
+	if (!pte_young(get_pte(ptep)))
 		return 0;
 	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low);
 }
@@ -276,7 +276,7 @@ static inline pte_t ptep_get_and_clear_f
 {
 	pte_t pte;
 	if (full) {
-		pte = *ptep;
+		pte = get_pte(ptep);
 		*ptep = __pte(0);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
@@ -385,7 +385,7 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_index(address) \
 		(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) \
-	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
+	((pte_t *) pmd_page_kernel(get_pmd(dir)) +  pte_index(address))
 
 #define pmd_page(pmd) (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
@@ -419,7 +419,7 @@ extern void noexec_setup(const char *str
 #define pte_offset_map(dir, address) 					\
 ({									\
 	pte_t *__ptep;							\
-	unsigned pfn = pmd_val(*dir) >> PAGE_SHIFT;			\
+	unsigned pfn = pmd_val(get_pmd(dir)) >> PAGE_SHIFT;		\
 	__ptep = (pte_t *)kmap_atomic(pfn_to_page(pfn),KM_PTE0);	\
 	mach_map_linear_pt(0, __ptep, pfn);				\
 	__ptep = __ptep + pte_index(address);				\
@@ -428,7 +428,7 @@ extern void noexec_setup(const char *str
 #define pte_offset_map_nested(dir, address) 				\
 ({									\
 	pte_t *__ptep;							\
-	unsigned pfn = pmd_val(*dir) >> PAGE_SHIFT;			\
+	unsigned pfn = pmd_val(get_pmd(dir)) >> PAGE_SHIFT;		\
 	__ptep = (pte_t *)kmap_atomic(pfn_to_page(pfn),KM_PTE1);	\
 	mach_map_linear_pt(1, __ptep, pfn);				\
 	__ptep = __ptep + pte_index(address);				\
@@ -438,7 +438,7 @@ extern void noexec_setup(const char *str
 #define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
 #else
 #define pte_offset_map(dir, address) \
-	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
+	((pte_t *)page_address(pmd_page(get_pmd(dir))) + pte_index(address))
 #define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
 #define pte_unmap(pte) do { } while (0)
 #define pte_unmap_nested(pte) do { } while (0)
Index: linux-2.6.16-rc6/include/asm-i386/mach-default/mach_pgtable.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-default/mach_pgtable.h	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-default/mach_pgtable.h	2006-03-12 19:57:58.000000000 -0800
@@ -1,6 +1,18 @@
 #ifndef _MACH_PGTABLE_H
 #define _MACH_PGTABLE_H
 
+#define __HAVE_ARCH_GET_PTE
+#define get_pte(__ptep) (*(__ptep))
+
+#define __HAVE_ARCH_GET_PMD
+#define get_pmd(__pmdp) (*(__pmdp))
+
+#define __HAVE_ARCH_GET_PUD
+#define get_pud(__pudp) (*(__pudp))
+
+#define __HAVE_ARCH_GET_PGD
+#define get_pgd(__pgdp) (*(__pgdp))
+
 /*
  * The i386 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
Index: linux-2.6.16-rc6/include/asm-i386/mach-vmi/mach_pgtable.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-vmi/mach_pgtable.h	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-vmi/mach_pgtable.h	2006-03-12 19:57:58.000000000 -0800
@@ -45,7 +45,7 @@ static inline pte_t ptep_get_and_clear_f
 {
 	pte_t pte;
 	if (full) {
-		pte = *ptep;
+		pte = get_pte(ptep);
 		*ptep = __pte(0);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
Index: linux-2.6.16-rc6/include/asm-i386/mach-vmi/pgtable-2level-ops.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-vmi/pgtable-2level-ops.h	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-vmi/pgtable-2level-ops.h	2006-03-12 19:57:58.000000000 -0800
@@ -26,6 +26,18 @@
 #ifndef _MACH_PGTABLE_LEVEL_OPS_H
 #define _MACH_PGTABLE_LEVEL_OPS_H
 
+#define __HAVE_ARCH_GET_PTE
+#define get_pte(__ptep) (*(__ptep))
+
+#define __HAVE_ARCH_GET_PMD
+#define get_pmd(__pmdp) (*(__pmdp))
+
+#define __HAVE_ARCH_GET_PUD
+#define get_pud(__pudp) (*(__pudp))
+
+#define __HAVE_ARCH_GET_PGD
+#define get_pgd(__pgdp) (*(__pgdp))
+
 /*
  * Certain architectures need to do special things when PTEs
  * within a page table are directly modified.  Thus, the following
Index: linux-2.6.16-rc6/include/asm-i386/mach-vmi/pgtable-3level-ops.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-vmi/pgtable-3level-ops.h	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-vmi/pgtable-3level-ops.h	2006-03-12 19:57:58.000000000 -0800
@@ -1,6 +1,18 @@
 #ifndef _MACH_PGTABLE_LEVEL_OPS_H
 #define _MACH_PGTABLE_LEVEL_OPS_H
 
+#define __HAVE_ARCH_GET_PTE
+#define get_pte(__ptep) (*(__ptep))
+
+#define __HAVE_ARCH_GET_PMD
+#define get_pmd(__pmdp) (*(__pmdp))
+
+#define __HAVE_ARCH_GET_PUD
+#define get_pud(__pudp) (*(__pudp))
+
+#define __HAVE_ARCH_GET_PGD
+#define get_pgd(__pgdp) (*(__pgdp))
+
 /* Rules for using set_pte: the pte being assigned *must* be
  * either not present or in a state where the hardware will
  * not attempt to update the pte.  In places where this is
Index: linux-2.6.16-rc6/include/linux/mm.h
===================================================================
--- linux-2.6.16-rc6.orig/include/linux/mm.h	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/include/linux/mm.h	2006-03-12 19:57:58.000000000 -0800
@@ -802,13 +802,13 @@ int __pte_alloc_kernel(pmd_t *pmd, unsig
 #if defined(CONFIG_MMU) && !defined(__ARCH_HAS_4LEVEL_HACK)
 static inline pud_t *pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
-	return (unlikely(pgd_none(*pgd)) && __pud_alloc(mm, pgd, address))?
+	return (unlikely(pgd_none(get_pgd(pgd))) && __pud_alloc(mm, pgd, address))?
 		NULL: pud_offset(pgd, address);
 }
 
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
-	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
+	return (unlikely(pud_none(get_pud(pud))) && __pmd_alloc(mm, pud, address))?
 		NULL: pmd_offset(pud, address);
 }
 #endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
@@ -825,7 +825,7 @@ static inline pmd_t *pmd_alloc(struct mm
 	spin_lock_init(__pte_lockptr(_page));				\
 } while (0)
 #define pte_lock_deinit(page)	((page)->mapping = NULL)
-#define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(*(pmd)));})
+#define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(get_pmd(pmd)));})
 #else
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
@@ -850,15 +850,15 @@ static inline pmd_t *pmd_alloc(struct mm
 } while (0)
 
 #define pte_alloc_map(mm, pmd, address)			\
-	((unlikely(!pmd_present(*(pmd))) && __pte_alloc(mm, pmd, address))? \
+	((unlikely(!pmd_present(get_pmd(pmd))) && __pte_alloc(mm, pmd, address))? \
 		NULL: pte_offset_map(pmd, address))
 
 #define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
-	((unlikely(!pmd_present(*(pmd))) && __pte_alloc(mm, pmd, address))? \
+	((unlikely(!pmd_present(get_pmd(pmd))) && __pte_alloc(mm, pmd, address))? \
 		NULL: pte_offset_map_lock(mm, pmd, address, ptlp))
 
 #define pte_alloc_kernel(pmd, address)			\
-	((unlikely(!pmd_present(*(pmd))) && __pte_alloc_kernel(pmd, address))? \
+	((unlikely(!pmd_present(get_pmd(pmd))) && __pte_alloc_kernel(pmd, address))? \
 		NULL: pte_offset_kernel(pmd, address))
 
 extern void free_area_init(unsigned long * zones_size);
Index: linux-2.6.16-rc6/mm/fremap.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/fremap.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/mm/fremap.c	2006-03-12 19:57:58.000000000 -0800
@@ -23,7 +23,7 @@
 static int zap_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = *ptep;
+	pte_t pte = get_pte(ptep);
 	struct page *page = NULL;
 
 	if (pte_present(pte)) {
@@ -75,13 +75,13 @@ int install_page(struct mm_struct *mm, s
 	if (page_mapcount(page) > INT_MAX/2)
 		goto unlock;
 
-	if (pte_none(*pte) || !zap_pte(mm, vma, addr, pte))
+	if (pte_none(get_pte(pte)) || !zap_pte(mm, vma, addr, pte))
 		inc_mm_counter(mm, file_rss);
 
 	flush_icache_page(vma, page);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
-	pte_val = *pte;
+	pte_val = get_pte(pte);
 	update_mmu_cache(vma, addr, pte_val);
 	err = 0;
 unlock:
@@ -107,13 +107,13 @@ int install_file_pte(struct mm_struct *m
 	if (!pte)
 		goto out;
 
-	if (!pte_none(*pte) && zap_pte(mm, vma, addr, pte)) {
+	if (!pte_none(get_pte(pte)) && zap_pte(mm, vma, addr, pte)) {
 		update_hiwater_rss(mm);
 		dec_mm_counter(mm, file_rss);
 	}
 
 	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
-	pte_val = *pte;
+	pte_val = get_pte(pte);
 	update_mmu_cache(vma, addr, pte_val);
 	pte_unmap_unlock(pte, ptl);
 	err = 0;
Index: linux-2.6.16-rc6/mm/highmem.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/highmem.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/mm/highmem.c	2006-03-12 19:57:58.000000000 -0800
@@ -83,7 +83,7 @@ static void flush_all_zero_pkmaps(void)
 		pkmap_count[i] = 0;
 
 		/* sanity check */
-		if (pte_none(pkmap_page_table[i]))
+		if (pte_none(get_pte(&pkmap_page_table[i])))
 			BUG();
 
 		/*
@@ -93,7 +93,7 @@ static void flush_all_zero_pkmaps(void)
 		 * getting the kmap_lock (which is held here).
 		 * So no dangers, even with speculative execution.
 		 */
-		page = pte_page(pkmap_page_table[i]);
+		page = pte_page(get_pte(&pkmap_page_table[i]));
 		pte_clear(&init_mm, (unsigned long)page_address(page),
 			  &pkmap_page_table[i]);
 
Index: linux-2.6.16-rc6/mm/hugetlb.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/hugetlb.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/mm/hugetlb.c	2006-03-12 19:57:58.000000000 -0800
@@ -290,7 +290,7 @@ static void set_huge_ptep_writable(struc
 {
 	pte_t entry;
 
-	entry = pte_mkwrite(pte_mkdirty(*ptep));
+	entry = pte_mkwrite(pte_mkdirty(get_pte(ptep)));
 	ptep_set_access_flags(vma, address, ptep, entry, 1);
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
@@ -316,10 +316,10 @@ int copy_hugetlb_page_range(struct mm_st
 			goto nomem;
 		spin_lock(&dst->page_table_lock);
 		spin_lock(&src->page_table_lock);
-		if (!pte_none(*src_pte)) {
+		if (!pte_none(get_pte(src_pte))) {
 			if (cow)
 				ptep_set_wrprotect(src, addr, src_pte);
-			entry = *src_pte;
+			entry = get_pte(src_pte);
 			ptepage = pte_page(entry);
 			get_page(ptepage);
 			add_mm_counter(dst, file_rss, HPAGE_SIZE / PAGE_SIZE);
@@ -401,7 +401,7 @@ static int hugetlb_cow(struct mm_struct 
 	spin_lock(&mm->page_table_lock);
 
 	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
-	if (likely(pte_same(*ptep, pte))) {
+	if (likely(pte_same(get_pte(ptep), pte))) {
 		/* Break COW */
 		set_huge_pte_at(mm, address, ptep,
 				make_huge_pte(vma, new_page, 1));
@@ -464,7 +464,7 @@ retry:
 		goto backout;
 
 	ret = VM_FAULT_MINOR;
-	if (!pte_none(*ptep))
+	if (!pte_none(get_pte(ptep)))
 		goto backout;
 
 	add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
@@ -501,7 +501,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 	if (!ptep)
 		return VM_FAULT_OOM;
 
-	entry = *ptep;
+	entry = get_pte(ptep);
 	if (pte_none(entry))
 		return hugetlb_no_page(mm, vma, address, ptep, write_access);
 
@@ -509,7 +509,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 
 	spin_lock(&mm->page_table_lock);
 	/* Check for a racing update before calling hugetlb_cow */
-	if (likely(pte_same(entry, *ptep)))
+	if (likely(pte_same(entry, get_pte(ptep))))
 		if (write_access && !pte_write(entry))
 			ret = hugetlb_cow(mm, vma, address, ptep, entry);
 	spin_unlock(&mm->page_table_lock);
@@ -537,7 +537,7 @@ int follow_hugetlb_page(struct mm_struct
 		 */
 		pte = huge_pte_offset(mm, vaddr & HPAGE_MASK);
 
-		if (!pte || pte_none(*pte)) {
+		if (!pte || pte_none(get_pte(pte))) {
 			int ret;
 
 			spin_unlock(&mm->page_table_lock);
@@ -553,7 +553,7 @@ int follow_hugetlb_page(struct mm_struct
 		}
 
 		if (pages) {
-			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
+			page = &pte_page(get_pte(pte))[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
 			get_page(page);
 			pages[i] = page;
 		}
Index: linux-2.6.16-rc6/mm/memory.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/memory.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/mm/memory.c	2006-03-12 19:57:58.000000000 -0800
@@ -100,19 +100,19 @@ __setup("norandmaps", disable_randmaps);
 
 void pgd_clear_bad(pgd_t *pgd)
 {
-	pgd_ERROR(*pgd);
+	pgd_ERROR(get_pgd(pgd));
 	pgd_clear(pgd);
 }
 
 void pud_clear_bad(pud_t *pud)
 {
-	pud_ERROR(*pud);
+	pud_ERROR(get_pud(pud));
 	pud_clear(pud);
 }
 
 void pmd_clear_bad(pmd_t *pmd)
 {
-	pmd_ERROR(*pmd);
+	pmd_ERROR(get_pmd(pmd));
 	pmd_clear(pmd);
 }
 
@@ -122,7 +122,7 @@ void pmd_clear_bad(pmd_t *pmd)
  */
 static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	struct page *page = pmd_page(*pmd);
+	struct page *page = pmd_page(get_pmd(pmd));
 	pmd_clear(pmd);
 	pte_lock_deinit(page);
 	pte_free_tlb(tlb, page);
@@ -307,7 +307,7 @@ int __pte_alloc(struct mm_struct *mm, pm
 
 	pte_lock_init(new);
 	spin_lock(&mm->page_table_lock);
-	if (pmd_present(*pmd)) {	/* Another has populated it */
+	if (pmd_present(get_pmd(pmd))) {	/* Another has populated it */
 		pte_lock_deinit(new);
 		pte_free(new);
 	} else {
@@ -326,7 +326,7 @@ int __pte_alloc_kernel(pmd_t *pmd, unsig
 		return -ENOMEM;
 
 	spin_lock(&init_mm.page_table_lock);
-	if (pmd_present(*pmd))		/* Another has populated it */
+	if (pmd_present(get_pmd(pmd)))		/* Another has populated it */
 		pte_free_kernel(new);
 	else
 		pmd_populate_kernel(&init_mm, pmd, new);
@@ -431,7 +431,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 		unsigned long addr, int *rss)
 {
 	unsigned long vm_flags = vma->vm_flags;
-	pte_t pte = *src_pte;
+	pte_t pte = get_pte(src_pte);
 	struct page *page;
 
 	/* pte contains position in swap or file, so copy. */
@@ -456,7 +456,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	 */
 	if (is_cow_mapping(vm_flags)) {
 		ptep_set_wrprotect(src_mm, addr, src_pte);
-		pte = *src_pte;
+		pte = get_pte(src_pte);
 	}
 
 	/*
@@ -508,7 +508,7 @@ again:
 			    need_lockbreak(dst_ptl))
 				break;
 		}
-		if (pte_none(*src_pte)) {
+		if (pte_none(get_pte(src_pte))) {
 			progress++;
 			continue;
 		}
@@ -618,7 +618,7 @@ static unsigned long zap_pte_range(struc
 
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
-		pte_t ptent = *pte;
+		pte_t ptent = get_pte(pte);
 		if (pte_none(ptent)) {
 			(*zap_work)--;
 			continue;
@@ -903,18 +903,18 @@ struct page *follow_page(struct vm_area_
 
 	page = NULL;
 	pgd = pgd_offset(mm, address);
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+	if (pgd_none(get_pgd(pgd)) || unlikely(pgd_bad(get_pgd(pgd))))
 		goto no_page_table;
 
 	pud = pud_offset(pgd, address);
-	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+	if (pud_none(get_pud(pud)) || unlikely(pud_bad(get_pud(pud))))
 		goto no_page_table;
 	
 	pmd = pmd_offset(pud, address);
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+	if (pmd_none(get_pmd(pmd)) || unlikely(pmd_bad(get_pmd(pmd))))
 		goto no_page_table;
 
-	if (pmd_huge(*pmd)) {
+	if (pmd_huge(get_pmd(pmd))) {
 		BUG_ON(flags & FOLL_GET);
 		page = follow_huge_pmd(mm, address, pmd, flags & FOLL_WRITE);
 		goto out;
@@ -924,7 +924,7 @@ struct page *follow_page(struct vm_area_
 	if (!ptep)
 		goto out;
 
-	pte = *ptep;
+	pte = get_pte(ptep);
 	if (!pte_present(pte))
 		goto unlock;
 	if ((flags & FOLL_WRITE) && !pte_write(pte))
@@ -993,19 +993,19 @@ int get_user_pages(struct task_struct *t
 				pgd = pgd_offset_k(pg);
 			else
 				pgd = pgd_offset_gate(mm, pg);
-			BUG_ON(pgd_none(*pgd));
+			BUG_ON(pgd_none(get_pgd(pgd)));
 			pud = pud_offset(pgd, pg);
-			BUG_ON(pud_none(*pud));
+			BUG_ON(pud_none(get_pud(pud)));
 			pmd = pmd_offset(pud, pg);
-			if (pmd_none(*pmd))
+			if (pmd_none(get_pmd(pmd)))
 				return i ? : -EFAULT;
 			pte = pte_offset_map(pmd, pg);
-			if (pte_none(*pte)) {
+			if (pte_none(get_pte(pte))) {
 				pte_unmap(pte);
 				return i ? : -EFAULT;
 			}
 			if (pages) {
-				struct page *page = vm_normal_page(gate_vma, start, *pte);
+				struct page *page = vm_normal_page(gate_vma, start, get_pte(pte));
 				pages[i] = page;
 				if (page)
 					get_page(page);
@@ -1101,7 +1101,7 @@ static int zeromap_pte_range(struct mm_s
 		page_cache_get(page);
 		page_add_file_rmap(page);
 		inc_mm_counter(mm, file_rss);
-		BUG_ON(!pte_none(*pte));
+		BUG_ON(!pte_none(get_pte(pte)));
 		set_pte_at(mm, addr, pte, zero_pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(pte - 1, ptl);
@@ -1197,7 +1197,7 @@ static int insert_page(struct mm_struct 
 	if (!pte)
 		goto out;
 	retval = -EBUSY;
-	if (!pte_none(*pte))
+	if (!pte_none(get_pte(pte)))
 		goto out_unlock;
 
 	/* Ok, finally just insert the thing.. */
@@ -1259,7 +1259,7 @@ static int remap_pte_range(struct mm_str
 	if (!pte)
 		return -ENOMEM;
 	do {
-		BUG_ON(!pte_none(*pte));
+		BUG_ON(!pte_none(get_pte(pte)));
 		set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
@@ -1375,7 +1375,7 @@ static inline int pte_unmap_same(struct 
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
 		spinlock_t *ptl = pte_lockptr(mm, pmd);
 		spin_lock(ptl);
-		same = pte_same(*page_table, orig_pte);
+		same = pte_same(get_pte(page_table), orig_pte);
 		spin_unlock(ptl);
 	}
 #endif
@@ -1492,7 +1492,7 @@ gotten:
 	 * Re-check the pte - we dropped the lock
 	 */
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
-	if (likely(pte_same(*page_table, orig_pte))) {
+	if (likely(pte_same(get_pte(page_table), orig_pte))) {
 		if (old_page) {
 			page_remove_rmap(old_page);
 			if (!PageAnon(old_page)) {
@@ -1892,7 +1892,7 @@ again:
 			 * while we released the pte lock.
 			 */
 			page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
-			if (likely(pte_same(*page_table, orig_pte)))
+			if (likely(pte_same(get_pte(page_table), orig_pte)))
 				ret = VM_FAULT_OOM;
 			goto unlock;
 		}
@@ -1916,7 +1916,7 @@ again:
 	 * Back out if somebody else already faulted in this pte.
 	 */
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
-	if (unlikely(!pte_same(*page_table, orig_pte)))
+	if (unlikely(!pte_same(get_pte(page_table), orig_pte)))
 		goto out_nomap;
 
 	if (unlikely(!PageUptodate(page))) {
@@ -1990,7 +1990,7 @@ static int do_anonymous_page(struct mm_s
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 
 		page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
-		if (!pte_none(*page_table))
+		if (!pte_none(get_pte(page_table)))
 			goto release;
 		inc_mm_counter(mm, anon_rss);
 		lru_cache_add_active(page);
@@ -2003,7 +2003,7 @@ static int do_anonymous_page(struct mm_s
 
 		ptl = pte_lockptr(mm, pmd);
 		spin_lock(ptl);
-		if (!pte_none(*page_table))
+		if (!pte_none(get_pte(page_table)))
 			goto release;
 		inc_mm_counter(mm, file_rss);
 		page_add_file_rmap(page);
@@ -2116,7 +2116,7 @@ retry:
 	 * handle that later.
 	 */
 	/* Only go through if we didn't race with anybody else... */
-	if (pte_none(*page_table)) {
+	if (pte_none(get_pte(page_table))) {
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
@@ -2206,7 +2206,7 @@ static inline int handle_pte_fault(struc
 	pte_t old_entry;
 	spinlock_t *ptl;
 
-	old_entry = entry = *pte;
+	old_entry = entry = get_pte(pte);
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
@@ -2224,7 +2224,7 @@ static inline int handle_pte_fault(struc
 
 	ptl = pte_lockptr(mm, pmd);
 	spin_lock(ptl);
-	if (unlikely(!pte_same(*pte, entry)))
+	if (unlikely(!pte_same(get_pte(pte), entry)))
 		goto unlock;
 	if (write_access) {
 		if (!pte_write(entry))
@@ -2298,7 +2298,7 @@ int __pud_alloc(struct mm_struct *mm, pg
 		return -ENOMEM;
 
 	spin_lock(&mm->page_table_lock);
-	if (pgd_present(*pgd))		/* Another has populated it */
+	if (pgd_present(get_pgd(pgd)))		/* Another has populated it */
 		pud_free(new);
 	else
 		pgd_populate(mm, pgd, new);
@@ -2326,12 +2326,12 @@ int __pmd_alloc(struct mm_struct *mm, pu
 
 	spin_lock(&mm->page_table_lock);
 #ifndef __ARCH_HAS_4LEVEL_HACK
-	if (pud_present(*pud))		/* Another has populated it */
+	if (pud_present(get_pud(pud)))		/* Another has populated it */
 		pmd_free(new);
 	else
 		pud_populate(mm, pud, new);
 #else
-	if (pgd_present(*pud))		/* Another has populated it */
+	if (pgd_present(get_pud(pud)))		/* Another has populated it */
 		pmd_free(new);
 	else
 		pgd_populate(mm, pud, new);
@@ -2380,13 +2380,13 @@ struct page * vmalloc_to_page(void * vma
 	pmd_t *pmd;
 	pte_t *ptep, pte;
   
-	if (!pgd_none(*pgd)) {
+	if (!pgd_none(get_pgd(pgd))) {
 		pud = pud_offset(pgd, addr);
-		if (!pud_none(*pud)) {
+		if (!pud_none(get_pud(pud))) {
 			pmd = pmd_offset(pud, addr);
-			if (!pmd_none(*pmd)) {
+			if (!pmd_none(get_pmd(pmd))) {
 				ptep = pte_offset_map(pmd, addr);
-				pte = *ptep;
+				pte = get_pte(ptep);
 				if (pte_present(pte))
 					page = pte_page(pte);
 				pte_unmap(ptep);
Index: linux-2.6.16-rc6/mm/mempolicy.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/mempolicy.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/mm/mempolicy.c	2006-03-12 19:57:58.000000000 -0800
@@ -216,9 +216,9 @@ static int check_pte_range(struct vm_are
 		struct page *page;
 		unsigned int nid;
 
-		if (!pte_present(*pte))
+		if (!pte_present(get_pte(pte)))
 			continue;
-		page = vm_normal_page(vma, addr, *pte);
+		page = vm_normal_page(vma, addr, get_pte(pte));
 		if (!page)
 			continue;
 		/*
Index: linux-2.6.16-rc6/mm/mprotect.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/mprotect.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/mm/mprotect.c	2006-03-12 19:57:58.000000000 -0800
@@ -33,7 +33,7 @@ static void change_pte_range(struct mm_s
 
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
-		if (pte_present(*pte)) {
+		if (pte_present(get_pte(pte))) {
 			pte_t ptent;
 
 			/* Avoid an SMP race with hardware updated dirty/clean
Index: linux-2.6.16-rc6/mm/mremap.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/mremap.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/mm/mremap.c	2006-03-12 19:57:58.000000000 -0800
@@ -59,7 +59,7 @@ static pmd_t *alloc_new_pmd(struct mm_st
 	if (!pmd)
 		return NULL;
 
-	if (!pmd_present(*pmd) && __pte_alloc(mm, pmd, addr))
+	if (!pmd_present(get_pmd(pmd)) && __pte_alloc(mm, pmd, addr))
 		return NULL;
 
 	return pmd;
@@ -101,7 +101,7 @@ static void move_ptes(struct vm_area_str
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
-		if (pte_none(*old_pte))
+		if (pte_none(get_pte(old_pte)))
 			continue;
 		pte = ptep_clear_flush(vma, old_addr, old_pte);
 		/* ZERO_PAGE can be dependant on virtual addr */
Index: linux-2.6.16-rc6/mm/msync.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/msync.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/mm/msync.c	2006-03-12 19:57:58.000000000 -0800
@@ -35,11 +35,11 @@ again:
 				break;
 		}
 		progress++;
-		if (!pte_present(*pte))
+		if (!pte_present(get_pte(pte)))
 			continue;
-		if (!pte_maybe_dirty(*pte))
+		if (!pte_maybe_dirty(get_pte(pte)))
 			continue;
-		page = vm_normal_page(vma, addr, *pte);
+		page = vm_normal_page(vma, addr, get_pte(pte));
 		if (!page)
 			continue;
 		if (ptep_clear_flush_dirty(vma, addr, pte) ||
Index: linux-2.6.16-rc6/mm/rmap.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/rmap.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/mm/rmap.c	2006-03-12 19:57:58.000000000 -0800
@@ -296,27 +296,27 @@ pte_t *page_check_address(struct page *p
 	spinlock_t *ptl;
 
 	pgd = pgd_offset(mm, address);
-	if (!pgd_present(*pgd))
+	if (!pgd_present(get_pgd(pgd)))
 		return NULL;
 
 	pud = pud_offset(pgd, address);
-	if (!pud_present(*pud))
+	if (!pud_present(get_pud(pud)))
 		return NULL;
 
 	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
+	if (!pmd_present(get_pmd(pmd)))
 		return NULL;
 
 	pte = pte_offset_map(pmd, address);
 	/* Make a quick check before getting the lock */
-	if (!pte_present(*pte)) {
+	if (!pte_present(get_pte(pte))) {
 		pte_unmap(pte);
 		return NULL;
 	}
 
 	ptl = pte_lockptr(mm, pmd);
 	spin_lock(ptl);
-	if (pte_present(*pte) && page_to_pfn(page) == pte_pfn(*pte)) {
+	if (pte_present(get_pte(pte)) && page_to_pfn(page) == pte_pfn(get_pte(pte))) {
 		*ptlp = ptl;
 		return pte;
 	}
@@ -633,7 +633,7 @@ static int try_to_unmap_one(struct page 
 			spin_unlock(&mmlist_lock);
 		}
 		set_pte_at(mm, address, pte, swp_entry_to_pte(entry));
-		BUG_ON(pte_file(*pte));
+		BUG_ON(pte_file(get_pte(pte)));
 		dec_mm_counter(mm, anon_rss);
 	} else
 		dec_mm_counter(mm, file_rss);
@@ -691,15 +691,15 @@ static void try_to_unmap_cluster(unsigne
 		end = vma->vm_end;
 
 	pgd = pgd_offset(mm, address);
-	if (!pgd_present(*pgd))
+	if (!pgd_present(get_pgd(pgd)))
 		return;
 
 	pud = pud_offset(pgd, address);
-	if (!pud_present(*pud))
+	if (!pud_present(get_pud(pud)))
 		return;
 
 	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
+	if (!pmd_present(get_pmd(pmd)))
 		return;
 
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
@@ -708,9 +708,9 @@ static void try_to_unmap_cluster(unsigne
 	update_hiwater_rss(mm);
 
 	for (; address < end; pte++, address += PAGE_SIZE) {
-		if (!pte_present(*pte))
+		if (!pte_present(get_pte(pte)))
 			continue;
-		page = vm_normal_page(vma, address, *pte);
+		page = vm_normal_page(vma, address, get_pte(pte));
 		BUG_ON(!page || PageAnon(page));
 
 		if (ptep_clear_flush_young(vma, address, pte))
Index: linux-2.6.16-rc6/mm/swapfile.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/swapfile.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/mm/swapfile.c	2006-03-12 19:57:58.000000000 -0800
@@ -453,7 +453,7 @@ static int unuse_pte_range(struct vm_are
 		 * swapoff spends a _lot_ of time in this loop!
 		 * Test inline before going to call unuse_pte.
 		 */
-		if (unlikely(pte_same(*pte, swp_pte))) {
+		if (unlikely(pte_same(get_pte(pte), swp_pte))) {
 			unuse_pte(vma, pte++, addr, entry, page);
 			found = 1;
 			break;
Index: linux-2.6.16-rc6/mm/vmalloc.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/vmalloc.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/mm/vmalloc.c	2006-03-12 19:57:58.000000000 -0800
@@ -94,7 +94,7 @@ static int vmap_pte_range(pmd_t *pmd, un
 		return -ENOMEM;
 	do {
 		struct page *page = **pages;
-		WARN_ON(!pte_none(*pte));
+		WARN_ON(!pte_none(get_pte(pte)));
 		if (!page)
 			return -ENOMEM;
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));

--------------050908070509080805070104--
