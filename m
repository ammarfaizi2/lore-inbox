Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTLAQqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 11:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTLAQqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 11:46:32 -0500
Received: from holomorphy.com ([199.26.172.102]:25801 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263880AbTLAQqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 11:46:23 -0500
Date: Mon, 1 Dec 2003 08:46:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031201164619.GI19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com> <20031130164301.GK8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130164301.GK8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 08:43:01AM -0800, William Lee Irwin III wrote:
> @@ -107,6 +108,12 @@ enum fixed_addresses {
>  	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
>  	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS - 1,
>  	FIX_WP_TEST,
> +#ifdef CONFIG_HIGHMEM
> +	FIX_KMAP_BEGIN = __virt_to_fix(__fix_to_virt(FIX_WP_TEST+1) & PAGE_MASK) - PAGE_MMUCOUNT + 1,
> +	FIX_KMAP_END = FIX_KMAP_BEGIN+((KM_TYPE_NR*NR_CPUS+1)*PAGE_MMUCOUNT)-1,
> +	FIX_PKMAP_BEGIN = __virt_to_fix(__fix_to_virt(FIX_KMAP_END+1) & PKMAP_MASK) - PAGE_MMUCOUNT + 1,
> +	FIX_PKMAP_END = FIX_PKMAP_BEGIN + (LAST_PKMAP+1)*PAGE_MMUCOUNT - 1,
> +#endif
>  	__end_of_fixed_addresses

BZZZT. kmap_atomic_to_pfn() et al all check vaddr < FIXADDR_START
and FIXADDR_START == __fix_to_virt(__end_of_permanent_fixed_addresses);
hence, plopping these guys down out by the FIX_BTMAP_*'s is bogus.
Worse yet, vmallocspace will overlap the bastards since we have
VMALLOC_END == FIXADDR_START - 2*MMUPAGE_SIZE.

Conservative and unnecessarily invasive fix (debug code and all) below.

I wonder if at some point I'll get buried under all the pr_debug()'s.
I guess it might give ppl an idea of exactly how much I've had to debug
over the course of all this, assuming anyone bothers looking. At any
rate, this does have the distinct advantage of running userspace.


-- wli


diff -prauN pgcl-2.6.0-test11-8/arch/i386/mm/highmem.c pgcl-2.6.0-test11-9/arch/i386/mm/highmem.c
--- pgcl-2.6.0-test11-8/arch/i386/mm/highmem.c	2003-11-30 18:57:20.000000000 -0800
+++ pgcl-2.6.0-test11-9/arch/i386/mm/highmem.c	2003-12-01 08:29:54.000000000 -0800
@@ -45,6 +45,9 @@ void *kmap_atomic(struct page *page, enu
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_END) + PAGE_SIZE*idx;
+	pr_debug("kmap_atomic(%d) has pfn 0x%lx, idx %d, vaddr 0x%lx\n",
+		type, page_to_pfn(page), idx, vaddr);
+	BUG_ON(vaddr % PAGE_SIZE);
 	BUG_ON(vaddr > __fix_to_virt(FIX_KMAP_BEGIN));
 	BUG_ON(vaddr < __fix_to_virt(FIX_KMAP_END));
 
@@ -54,6 +57,9 @@ void *kmap_atomic(struct page *page, enu
 	pgd = pgd_offset_k(addr);
 	pmd = pmd_offset(pgd, addr);
 
+	/* barf on non-present pagetables */
+	BUG_ON(pmd_none(*pmd));
+
 	/* barf on highmem-allocated pagetables */
 	BUG_ON((pmd_val(*pmd) >> MMUPAGE_SHIFT) >= max_low_pfn);
 
@@ -66,8 +72,13 @@ void *kmap_atomic(struct page *page, enu
 		BUG_ON(addr < vaddr);
 		BUG_ON(addr - vaddr >= PAGE_SIZE);
 		BUG_ON(!pfn_valid(pfn + k));
-		if (pte_pfn(pte[k]) == pfn + k)
+		pr_debug("%s: mapping pfn 0x%lx at vaddr 0x%lx\n",
+				__FUNCTION__, pfn, vaddr);
+		if (pte_pfn(pte[k]) == pfn + k) {
+			pr_debug("%s: skipping already-set kmap_atomic() pte\n",
+				__FUNCTION__);
 			continue;
+		}
 
 		set_pte(&pte[k], pfn_pte(pfn + k, kmap_prot));
 		__flush_tlb_one(addr);
@@ -86,7 +97,7 @@ void kunmap_atomic(void *kvaddr, enum km
 	pmd_t *pmd;
 	pte_t *pte;
 
-	if (vaddr < FIXADDR_START) { // FIXME
+	if (vaddr < __fix_to_virt(__end_of_fixed_addresses)) { // FIXME
 		dec_preempt_count();
 		return;
 	}
@@ -106,7 +117,9 @@ void kunmap_atomic(void *kvaddr, enum km
 	for (k = 0; k < PAGE_MMUCOUNT; ++k, vaddr += MMUPAGE_SIZE) {
 		pte_clear(&pte[k]);
 		__flush_tlb_one(vaddr);
-	}
+	} else
+		pr_debug("%s: skipping already-set kmap_atomic() pte\n",
+				__FUNCTION__);
 
 	dec_preempt_count();
 }
@@ -119,17 +132,18 @@ unsigned long kmap_atomic_to_pfn(void *p
 	pmd_t *pmd;
 	pte_t *pte;
 
-	if (vaddr < FIXADDR_START)
+	/*
+	 * Not for vmallocspace!!!
+	 */
+	BUG_ON(vaddr >= VMALLOC_START && vaddr < __VMALLOC_END);
+	if (vaddr < VMALLOC_START)
 		return __pa(vaddr)/MMUPAGE_SIZE;
 
 	pgd = pgd_offset_k(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
+	BUG_ON(pmd_none(*pmd));
 	pte = pte_offset_kernel(pmd, vaddr);
 
-	/*
-	 * unsigned long idx = virt_to_fix(vaddr);
-	 * pte = &kmap_pte[idx*PAGE_MMUCOUNT];
-	 */
 	return pte_pfn(*pte);
 }
 
@@ -145,11 +159,15 @@ void kmap_atomic_sg(pte_t *ptes[], pte_a
 	inc_preempt_count();
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	base = vaddr = __fix_to_virt(FIX_KMAP_END) + PAGE_SIZE*idx;
+	pr_debug("kmap_atomic_sg(%d) has idx %d, vaddr 0x%lx\n",
+		type, idx, vaddr);
+	BUG_ON(vaddr % PAGE_SIZE);
 	BUG_ON(vaddr > __fix_to_virt(FIX_KMAP_BEGIN));
 	BUG_ON(vaddr < __fix_to_virt(FIX_KMAP_END));
 
 	pgd = pgd_offset_k(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
+	BUG_ON(pmd_none(*pmd));
 	pte = pte_offset_kernel(pmd, vaddr);
 	for (k = 0; k < PAGE_MMUCOUNT; ++k, vaddr += MMUPAGE_SIZE) {
 		unsigned long pfn = paddrs[k]/MMUPAGE_SIZE;
@@ -163,6 +181,8 @@ void kmap_atomic_sg(pte_t *ptes[], pte_a
 		BUG_ON((u32)ptes[k] < base);
 		BUG_ON((u32)ptes[k] - base >= PAGE_SIZE);
 
+		pr_debug("%s: mapping pfn 0x%lx at vaddr 0x%lx\n",
+				__FUNCTION__, pfn, vaddr);
 		if (pte_pfn(pte[k]) != pfn) {
 			set_pte(&pte[k], pfn_pte(pfn, kmap_prot));
 			__flush_tlb_one(vaddr);
diff -prauN pgcl-2.6.0-test11-8/arch/i386/mm/init.c pgcl-2.6.0-test11-9/arch/i386/mm/init.c
--- pgcl-2.6.0-test11-8/arch/i386/mm/init.c	2003-11-30 12:45:48.000000000 -0800
+++ pgcl-2.6.0-test11-9/arch/i386/mm/init.c	2003-12-01 01:29:26.000000000 -0800
@@ -212,11 +212,6 @@ EXPORT_SYMBOL(kmap_prot);
 
 #define kmap_init()	do { kmap_prot = PAGE_KERNEL; } while (0)
 
-void __init permanent_kmaps_init(pgd_t *pgd_base)
-{
-	page_table_range_init(PKMAP_BASE, PKMAP_BASE + PAGE_SIZE*LAST_PKMAP, pgd_base);
-}
-
 void __init one_highpage_init(struct page *page, unsigned long pfn, int bad_ppro)
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
@@ -243,7 +238,6 @@ extern void set_highmem_pages_init(int);
 
 #else
 #define kmap_init() do { } while (0)
-#define permanent_kmaps_init(pgd_base) do { } while (0)
 #define set_highmem_pages_init(bad_ppro) do { } while (0)
 #endif /* CONFIG_HIGHMEM */
 
@@ -288,8 +282,6 @@ static void __init pagetable_init (void)
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	page_table_range_init(vaddr, 0, pgd_base);
 
-	permanent_kmaps_init(pgd_base);
-
 #ifdef CONFIG_X86_PAE
 	/*
 	 * Add low memory identity-mappings - SMP needs it when
diff -prauN pgcl-2.6.0-test11-8/include/asm-generic/rmap.h pgcl-2.6.0-test11-9/include/asm-generic/rmap.h
--- pgcl-2.6.0-test11-8/include/asm-generic/rmap.h	2003-11-27 21:55:19.000000000 -0800
+++ pgcl-2.6.0-test11-9/include/asm-generic/rmap.h	2003-12-01 07:21:48.000000000 -0800
@@ -57,6 +57,8 @@ static inline void pgtable_add_rmap(stru
 	page->mapping = (void *)mm;
 	page->index = address & ~(VIRT_AREA_MAPPED_PER_PTE_PAGE - 1);
 	inc_page_state(nr_page_table_pages);
+	pr_debug("%s: installing pte page at pfn 0x%lx at uvaddr 0x%lx\n",
+			__FUNCTION__, page_to_pfn(page), page->index);
 }
 
 static inline void pgtable_remove_rmap(struct page * page)
@@ -75,6 +77,8 @@ static inline void pgtable_remove_rmap(s
 			BUG_ON(atomic_read(&page->count) <= 0);
 	}
 
+	pr_debug("%s: removing pte page at pfn 0x%lx at uvaddr 0x%lx\n",
+			__FUNCTION__, page_to_pfn(page), page->index);
 	page->mapping = NULL;
 	page->index = 0;
 	dec_page_state(nr_page_table_pages);
@@ -109,24 +113,36 @@ static inline unsigned long ptep_to_addr
 	unsigned long kvaddr = (unsigned long)ptep;
 	unsigned long swpage_voff = kvaddr/sizeof(pte_t);
 
+	pr_debug("entered ptep_to_address(%p)\n", ptep);
+	pr_debug("swpage_voff = 0x%lx\n", swpage_voff);
+
 	if (1) {
 		pgd_t *pgd;
 		pmd_t *pmd;
 		pte_t *pte;
-		unsigned long pfn;
+		unsigned long vaddr, pfn;
 		struct page *page;
 
 		pgd = pgd_offset_k(kvaddr);
+		pr_debug("ptep_to_address() saw pgd mapping ptep at %p\n", pgd);
 		pmd = pmd_offset(pgd, kvaddr);
+		pr_debug("ptep_to_address() saw pmd mapping ptep at %p\n", pmd);
 		pte = pte_offset_kernel(pmd, kvaddr);
+		pr_debug("ptep_to_address() saw pte mapping ptep at %p\n", pte);
 		pfn = pte_pfn(*pte);
+		pr_debug("ptep_to_address() saw ptep held in pfn 0x%lx\n",
+			pfn);
+		if (pfn != kmap_atomic_to_pfn(ptep))
+			pr_debug("pfn doesn't match kmap_atomic_to_pfn()!\n");
 		page = pfn_to_page(pfn);
-		return page->index + PMD_SIZE*(pfn % PAGE_MMUCOUNT)
+		vaddr = page->index + PMD_SIZE*(pfn % PAGE_MMUCOUNT)
 			+ MMUPAGE_SIZE*(swpage_voff % PTRS_PER_PTE);
+		pr_debug("ptep_to_address() returning 0x%lx\n", vaddr);
+		return vaddr;
 	} else {
 		struct page *page = pfn_to_page(kmap_atomic_to_pfn(ptep));
 
-		WARN_ON(kvaddr > (unsigned long)(-PAGE_SIZE));
+		WARN_ON(kvaddr > (unsigned long)(-MMUPAGE_SIZE));
 
 		swpage_voff %= MMUPAGES_MAPPED_PER_PTE_PAGE;
 		/* WARN_ON(swpage_voff != pfn - page_to_pfn(page)); */
diff -prauN pgcl-2.6.0-test11-8/include/asm-i386/fixmap.h pgcl-2.6.0-test11-9/include/asm-i386/fixmap.h
--- pgcl-2.6.0-test11-8/include/asm-i386/fixmap.h	2003-11-30 18:57:20.000000000 -0800
+++ pgcl-2.6.0-test11-9/include/asm-i386/fixmap.h	2003-12-01 07:33:29.000000000 -0800
@@ -69,11 +69,12 @@
  * worth of virtualspace.
  */
 #define FIXADDR_TOP	(-MMUPAGE_SIZE)
-#define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << MMUPAGE_SHIFT)
+#define __FIXADDR_SIZE	(__end_of_fixed_addresses << MMUPAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << MMUPAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x) & MMUPAGE_MASK)) >> MMUPAGE_SHIFT)
+#define __fixmap_align(x,a)	__virt_to_fix(__fix_to_virt(x) & (a))
 
 enum fixed_addresses {
 	/* reserved pte's for temporary kernel mappings */
@@ -102,18 +103,19 @@ enum fixed_addresses {
 	FIX_ACPI_BEGIN,
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
 #endif
+#ifdef CONFIG_HIGHMEM
+	FIX_HIGHMEM_HOLE,
+	FIX_KMAP_BEGIN = __fixmap_align(FIX_HIGHMEM_HOLE+1, PAGE_MASK) + 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + KM_TYPE_NR*NR_CPUS*PAGE_MMUCOUNT - 1,
+	FIX_PKMAP_BEGIN = __fixmap_align(FIX_KMAP_END+1, PKMAP_MASK) + 1,
+	FIX_PKMAP_END = FIX_PKMAP_BEGIN + LAST_PKMAP*PAGE_MMUCOUNT - 1,
+#endif
 	__end_of_permanent_fixed_addresses,
 	/* temporary boot-time mappings, used before ioremap() is functional */
 #define NR_FIX_BTMAPS	16
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS - 1,
 	FIX_WP_TEST,
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN = __virt_to_fix(__fix_to_virt(FIX_WP_TEST+1) & PAGE_MASK) - PAGE_MMUCOUNT + 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+((KM_TYPE_NR*NR_CPUS+1)*PAGE_MMUCOUNT)-1,
-	FIX_PKMAP_BEGIN = __virt_to_fix(__fix_to_virt(FIX_KMAP_END+1) & PKMAP_MASK) - PAGE_MMUCOUNT + 1,
-	FIX_PKMAP_END = FIX_PKMAP_BEGIN + (LAST_PKMAP+1)*PAGE_MMUCOUNT - 1,
-#endif
 	__end_of_fixed_addresses
 };
 
diff -prauN pgcl-2.6.0-test11-8/include/asm-i386/pgtable.h pgcl-2.6.0-test11-9/include/asm-i386/pgtable.h
--- pgcl-2.6.0-test11-8/include/asm-i386/pgtable.h	2003-11-29 00:02:03.000000000 -0800
+++ pgcl-2.6.0-test11-9/include/asm-i386/pgtable.h	2003-12-01 07:26:11.000000000 -0800
@@ -81,7 +81,8 @@ void paging_init(void);
  * The vmalloc() routines leaves a hole of 4kB between each vmalloced
  * area for the same reason. ;)
  */
-#define VMALLOC_END	(FIXADDR_START-2*MMUPAGE_SIZE)
+#define __VMALLOC_END	__fix_to_virt(__end_of_fixed_addresses)
+#define VMALLOC_END	((__VMALLOC_END-2*MMUPAGE_SIZE) & PMD_MASK)
 #define __VMALLOC_START	(VMALLOC_END - VMALLOC_RESERVE - 2*MMUPAGE_SIZE)
 #define VMALLOC_START							\
 	(high_memory							\
