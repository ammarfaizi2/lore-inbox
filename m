Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWDNC1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWDNC1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWDNC1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:27:53 -0400
Received: from fmr18.intel.com ([134.134.136.17]:47521 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S965093AbWDNC1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:27:50 -0400
Subject: Re: [PATCH 4/8] IA64 various hugepage size - modify HPAGE related
	macros
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-IA64 <linux-ia64@vger.kernel.org>, Tony <tony.luck@intel.com>,
       Kenneth W <kenneth.w.chen@intel.com>
In-Reply-To: <1144975292.5817.74.camel@linux-znh>
References: <1144974367.5817.39.camel@linux-znh>
	 <1144974667.5817.51.camel@linux-znh>  <1144974881.5817.59.camel@linux-znh>
	 <1144975292.5817.74.camel@linux-znh>
Content-Type: text/plain
Organization: 
Message-Id: <1144975523.5817.84.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2006 08:45:24 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify HPAGE related macros to mm related. 
Also change some variable in hugetlb.c into array. 
Since those variable will not be accessed in hot path. the impact to performance should be limited.


Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

diff -Nraup a/arch/i386/mm/hugetlbpage.c b/arch/i386/mm/hugetlbpage.c
--- a/arch/i386/mm/hugetlbpage.c	2006-04-12 10:12:43.000000000 +0800
+++ b/arch/i386/mm/hugetlbpage.c	2006-04-12 10:09:37.000000000 +0800
@@ -107,7 +107,7 @@ follow_huge_pmd(struct mm_struct *mm, un
 
 	page = pte_page(*(pte_t *)pmd);
 	if (page)
-		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
+		page += ((address & ~HPAGE_MASK(mm)) >> PAGE_SHIFT);
 	return page;
 }
 #endif
@@ -131,7 +131,7 @@ static unsigned long hugetlb_get_unmappe
 	}
 
 full_search:
-	addr = ALIGN(start_addr, HPAGE_SIZE);
+	addr = ALIGN(start_addr, HPAGE_SIZE(mm));
 
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
@@ -153,7 +153,7 @@ full_search:
 		}
 		if (addr + mm->cached_hole_size < vma->vm_start)
 		        mm->cached_hole_size = vma->vm_start - addr;
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
+		addr = ALIGN(vma->vm_end, HPAGE_SIZE(mm));
 	}
 }
 
@@ -181,7 +181,7 @@ try_again:
 		goto fail;
 
 	/* either no address requested or cant fit in requested address hole */
-	addr = (mm->free_area_cache - len) & HPAGE_MASK;
+	addr = (mm->free_area_cache - len) & HPAGE_MASK(mm);
 	do {
 		/*
 		 * Lookup failure means no vma is above this address,
@@ -212,7 +212,7 @@ try_again:
 		        largest_hole = vma->vm_start - addr;
 
 		/* try just below the current vma->vm_start */
-		addr = (vma->vm_start - len) & HPAGE_MASK;
+		addr = (vma->vm_start - len) & HPAGE_MASK(mm);
 	} while (len <= vma->vm_start);
 
 fail:
@@ -253,13 +253,13 @@ hugetlb_get_unmapped_area(struct file *f
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 
-	if (len & ~HPAGE_MASK)
+	if (len & ~HPAGE_MASK(mm))
 		return -EINVAL;
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
 	if (addr) {
-		addr = ALIGN(addr, HPAGE_SIZE);
+		addr = ALIGN(addr, HPAGE_SIZE(mm));
 		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
diff -Nraup a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
--- a/arch/ia64/mm/hugetlbpage.c	2006-04-12 10:13:53.000000000 +0800
+++ b/arch/ia64/mm/hugetlbpage.c	2006-04-12 10:09:37.000000000 +0800
@@ -22,12 +22,12 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-unsigned int hpage_shift=HPAGE_SHIFT_DEFAULT;
+unsigned int init_hpage_shift=HPAGE_SHIFT_DEFAULT;
 
 pte_t *
 huge_pte_alloc (struct mm_struct *mm, unsigned long addr)
 {
-	unsigned long taddr = htlbpage_to_page(addr);
+	unsigned long taddr = htlbpage_to_page(mm, addr);
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
@@ -46,7 +46,7 @@ huge_pte_alloc (struct mm_struct *mm, un
 pte_t *
 huge_pte_offset (struct mm_struct *mm, unsigned long addr)
 {
-	unsigned long taddr = htlbpage_to_page(addr);
+	unsigned long taddr = htlbpage_to_page(mm, addr);
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
@@ -73,9 +73,9 @@ huge_pte_offset (struct mm_struct *mm, u
  */
 int prepare_hugepage_range(unsigned long addr, unsigned long len)
 {
-	if (len & ~HPAGE_MASK)
+	if (len & ~HPAGE_MASK(current->mm))
 		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
+	if (addr & ~HPAGE_MASK(current->mm))
 		return -EINVAL;
 	if (REGION_NUMBER(addr) != RGN_HPAGE)
 		return -EINVAL;
@@ -95,7 +95,7 @@ struct page *follow_huge_addr(struct mm_
 	if (!ptep || pte_none(*ptep))
 		return NULL;
 	page = pte_page(*ptep);
-	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
+	page += ((addr & ~HPAGE_MASK(mm)) >> PAGE_SHIFT);
 	return page;
 }
 int pmd_huge(pmd_t pmd)
@@ -122,13 +122,14 @@ void hugetlb_free_pgd_range(struct mmu_g
 	 * If floor and ceiling are also in the hugetlb region, they
 	 * must likewise be scaled down; but if outside, left unchanged.
 	 */
+	struct mm_struct *mm = (*tlb)->mm;
 
-	addr = htlbpage_to_page(addr);
-	end  = htlbpage_to_page(end);
+	addr = htlbpage_to_page(mm, addr);
+	end  = htlbpage_to_page(mm, end);
 	if (REGION_NUMBER(floor) == RGN_HPAGE)
-		floor = htlbpage_to_page(floor);
+		floor = htlbpage_to_page(mm, floor);
 	if (REGION_NUMBER(ceiling) == RGN_HPAGE)
-		ceiling = htlbpage_to_page(ceiling);
+		ceiling = htlbpage_to_page(mm, ceiling);
 
 	free_pgd_range(tlb, addr, end, floor, ceiling);
 }
@@ -137,23 +138,24 @@ unsigned long hugetlb_get_unmapped_area(
 		unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct mm_struct *mm = current->mm;
 
 	if (len > RGN_MAP_LIMIT)
 		return -ENOMEM;
-	if (len & ~HPAGE_MASK)
+	if (len & ~HPAGE_MASK(mm))
 		return -EINVAL;
 	/* This code assumes that RGN_HPAGE != 0. */
-	if ((REGION_NUMBER(addr) != RGN_HPAGE) || (addr & (HPAGE_SIZE - 1)))
+	if ((REGION_NUMBER(addr) != RGN_HPAGE) || (addr & (HPAGE_SIZE(mm) - 1)))
 		addr = HPAGE_REGION_BASE;
 	else
-		addr = ALIGN(addr, HPAGE_SIZE);
+		addr = ALIGN(addr, HPAGE_SIZE(mm));
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
 		if (REGION_OFFSET(addr) + len > RGN_MAP_LIMIT)
 			return -ENOMEM;
 		if (!vmm || (addr + len) <= vmm->vm_start)
 			return addr;
-		addr = ALIGN(vmm->vm_end, HPAGE_SIZE);
+		addr = ALIGN(vmm->vm_end, HPAGE_SIZE(mm));
 	}
 }
 
@@ -167,15 +169,14 @@ static int __init hugetlb_setup_sz(char 
 		return 1;
 	}
 
-	hpage_shift = __ffs(size);
-	ia64_set_rr(HPAGE_REGION_BASE, hpage_shift << 2);
+	init_hpage_shift = __ffs(size);
 	return 1;
 }
 __setup("hugepagesz=", hugetlb_setup_sz);
 
 void hugepage_size_init(struct mm_struct *mm)
 {
-  mm->hugepage_shift = hpage_shift;
+  mm->hugepage_shift = init_hpage_shift;
 }
 
 int is_valid_hpage_size(unsigned long long size)
diff -Nraup a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
--- a/arch/powerpc/mm/hash_utils_64.c	2006-04-12 10:12:43.000000000 +0800
+++ b/arch/powerpc/mm/hash_utils_64.c	2006-04-12 10:09:37.000000000 +0800
@@ -94,7 +94,7 @@ int mmu_linear_psize = MMU_PAGE_4K;
 int mmu_virtual_psize = MMU_PAGE_4K;
 #ifdef CONFIG_HUGETLB_PAGE
 int mmu_huge_psize = MMU_PAGE_16M;
-unsigned int HPAGE_SHIFT;
+unsigned int hpage_shift;
 #endif
 
 /* There are definitions of page sizes arrays to be used when none
@@ -337,9 +337,9 @@ static void __init htab_init_page_sizes(
 	/* Calculate HPAGE_SHIFT and sanity check it */
 	if (mmu_psize_defs[mmu_huge_psize].shift > MIN_HUGEPTE_SHIFT &&
 	    mmu_psize_defs[mmu_huge_psize].shift < SID_SHIFT)
-		HPAGE_SHIFT = mmu_psize_defs[mmu_huge_psize].shift;
+		hpage_shift = mmu_psize_defs[mmu_huge_psize].shift;
 	else
-		HPAGE_SHIFT = 0; /* No huge pages dude ! */
+		hpage_shift = 0; /* No huge pages dude ! */
 #endif /* CONFIG_HUGETLB_PAGE */
 }
 
diff -Nraup a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
--- a/arch/powerpc/mm/hugetlbpage.c	2006-04-12 10:12:43.000000000 +0800
+++ b/arch/powerpc/mm/hugetlbpage.c	2006-04-12 10:09:37.000000000 +0800
@@ -40,7 +40,7 @@ pte_t *huge_pte_offset(struct mm_struct 
 
 	BUG_ON(! in_hugepage_area(mm->context, addr));
 
-	addr &= HPAGE_MASK;
+	addr &= HPAGE_MASK(mm);
 
 	pg = pgd_offset(mm, addr);
 	if (!pgd_none(*pg)) {
@@ -81,7 +81,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
 
 	BUG_ON(! in_hugepage_area(mm->context, addr));
 
-	addr &= HPAGE_MASK;
+	addr &= HPAGE_MASK(mm);
 
 	pg = pgd_offset(mm, addr);
 	pu = pud_alloc(mm, pg, addr);
@@ -115,7 +115,7 @@ void set_huge_pte_at(struct mm_struct *m
 		 */
 		unsigned long old = pte_update(ptep, ~0UL);
 		if (old & _PAGE_HASHPTE)
-			hpte_update(mm, addr & HPAGE_MASK, ptep, old, 1);
+			hpte_update(mm, addr & HPAGE_MASK(mm), ptep, old, 1);
 		flush_tlb_pending();
 	}
 	*ptep = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
@@ -127,7 +127,7 @@ pte_t huge_ptep_get_and_clear(struct mm_
 	unsigned long old = pte_update(ptep, ~0UL);
 
 	if (old & _PAGE_HASHPTE)
-		hpte_update(mm, addr & HPAGE_MASK, ptep, old, 1);
+		hpte_update(mm, addr & HPAGE_MASK(mm), ptep, old, 1);
 	*ptep = __pte(0);
 
 	return __pte(old);
@@ -331,7 +331,7 @@ follow_huge_addr(struct mm_struct *mm, u
 	ptep = huge_pte_offset(mm, address);
 	page = pte_page(*ptep);
 	if (page)
-		page += (address % HPAGE_SIZE) / PAGE_SIZE;
+		page += (address % HPAGE_SIZE(mm)) / PAGE_SIZE;
 
 	return page;
 }
@@ -562,7 +562,7 @@ static unsigned long htlb_get_low_area(u
 
 		if (!vma || (addr + len) <= vma->vm_start)
 			return addr;
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
+		addr = ALIGN(vma->vm_end, HPAGE_SIZE(current->mm));
 		/* Depending on segmask this might not be a confirmed
 		 * hugepage region, so the ALIGN could have skipped
 		 * some VMAs */
@@ -589,7 +589,7 @@ static unsigned long htlb_get_high_area(
 
 		if (!vma || (addr + len) <= vma->vm_start)
 			return addr;
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
+		addr = ALIGN(vma->vm_end, HPAGE_SIZE(current->mm));
 		/* Depending on segmask this might not be a confirmed
 		 * hugepage region, so the ALIGN could have skipped
 		 * some VMAs */
@@ -606,7 +606,7 @@ unsigned long hugetlb_get_unmapped_area(
 	int lastshift;
 	u16 areamask, curareas;
 
-	if (HPAGE_SHIFT == 0)
+	if (HPAGE_SHIFT(current->mm) == 0)
 		return -EINVAL;
 	if (len & ~HPAGE_MASK)
 		return -EINVAL;
@@ -700,7 +700,7 @@ static unsigned int hash_huge_page_do_la
 	/* page is dirty */
 	if (!test_bit(PG_arch_1, &page->flags) && !PageReserved(page)) {
 		if (trap == 0x400) {
-			for (i = 0; i < (HPAGE_SIZE / PAGE_SIZE); i++)
+			for (i = 0; i < (HPAGE_SIZE(current->mm) / PAGE_SIZE); i++)
 				__flush_dcache_icache(page_address(page+i));
 			set_bit(PG_arch_1, &page->flags);
 		} else {
@@ -774,7 +774,7 @@ int hash_huge_page(struct mm_struct *mm,
 		/* There MIGHT be an HPTE for this pte */
 		unsigned long hash, slot;
 
-		hash = hpt_hash(va, HPAGE_SHIFT);
+		hash = hpt_hash(va, HPAGE_SHIFT(mm));
 		if (old_pte & _PAGE_F_SECOND)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -786,7 +786,7 @@ int hash_huge_page(struct mm_struct *mm,
 	}
 
 	if (likely(!(old_pte & _PAGE_HASHPTE))) {
-		unsigned long hash = hpt_hash(va, HPAGE_SHIFT);
+		unsigned long hash = hpt_hash(va, HPAGE_SHIFT(mm));
 		unsigned long hpte_group;
 
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
diff -Nraup a/arch/sparc64/kernel/sun4v_tlb_miss.S b/arch/sparc64/kernel/sun4v_tlb_miss.S
--- a/arch/sparc64/kernel/sun4v_tlb_miss.S	2006-04-12 10:12:43.000000000 +0800
+++ b/arch/sparc64/kernel/sun4v_tlb_miss.S	2006-04-12 10:09:37.000000000 +0800
@@ -182,7 +182,7 @@ sun4v_tsb_miss_common:
 	cmp	%g5, -1
 	be,pt	%xcc, 80f
 	 nop
-	COMPUTE_TSB_PTR(%g5, %g4, HPAGE_SHIFT, %g2, %g7)
+	COMPUTE_TSB_PTR(%g5, %g4, HPAGE_SHIFT(0), %g2, %g7)
 
 	/* That clobbered %g2, reload it.  */
 	ldxa	[%g0] ASI_SCRATCHPAD, %g2
diff -Nraup a/arch/sparc64/kernel/tsb.S b/arch/sparc64/kernel/tsb.S
--- a/arch/sparc64/kernel/tsb.S	2006-04-12 10:12:43.000000000 +0800
+++ b/arch/sparc64/kernel/tsb.S	2006-04-12 10:09:37.000000000 +0800
@@ -76,7 +76,7 @@ tsb_miss_page_table_walk:
 	mov		512, %g7
 	andn		%g5, 0x7, %g5
 	sllx		%g7, %g6, %g7
-	srlx		%g4, HPAGE_SHIFT, %g6
+	srlx		%g4, HPAGE_SHIFT(0), %g6
 	sub		%g7, 1, %g7
 	and		%g6, %g7, %g6
 	sllx		%g6, 4, %g6
diff -Nraup a/arch/sparc64/mm/fault.c b/arch/sparc64/mm/fault.c
--- a/arch/sparc64/mm/fault.c	2006-04-12 10:12:43.000000000 +0800
+++ b/arch/sparc64/mm/fault.c	2006-04-12 10:09:37.000000000 +0800
@@ -415,7 +415,7 @@ good_area:
 
 	mm_rss = get_mm_rss(mm);
 #ifdef CONFIG_HUGETLB_PAGE
-	mm_rss -= (mm->context.huge_pte_count * (HPAGE_SIZE / PAGE_SIZE));
+	mm_rss -= (mm->context.huge_pte_count * (HPAGE_SIZE(mm) / PAGE_SIZE));
 #endif
 	if (unlikely(mm_rss >
 		     mm->context.tsb_block[MM_TSB_BASE].tsb_rss_limit))
diff -Nraup a/arch/sparc64/mm/hugetlbpage.c b/arch/sparc64/mm/hugetlbpage.c
--- a/arch/sparc64/mm/hugetlbpage.c	2006-04-12 10:12:43.000000000 +0800
+++ b/arch/sparc64/mm/hugetlbpage.c	2006-04-12 10:09:37.000000000 +0800
@@ -54,7 +54,7 @@ static unsigned long hugetlb_get_unmappe
 	task_size -= len;
 
 full_search:
-	addr = ALIGN(addr, HPAGE_SIZE);
+	addr = ALIGN(addr, HPAGE_SIZE(mm));
 
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
@@ -81,7 +81,7 @@ full_search:
 		if (addr + mm->cached_hole_size < vma->vm_start)
 		        mm->cached_hole_size = vma->vm_start - addr;
 
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
+		addr = ALIGN(vma->vm_end, HPAGE_SIZE(mm));
 	}
 }
 
@@ -105,7 +105,7 @@ hugetlb_get_unmapped_area_topdown(struct
  	}
 
 	/* either no address requested or can't fit in requested address hole */
-	addr = mm->free_area_cache & HPAGE_MASK;
+	addr = mm->free_area_cache & HPAGE_MASK(mm);
 
 	/* make sure it can fit in the remaining address space */
 	if (likely(addr > len)) {
@@ -119,7 +119,7 @@ hugetlb_get_unmapped_area_topdown(struct
 	if (unlikely(mm->mmap_base < len))
 		goto bottomup;
 
-	addr = (mm->mmap_base-len) & HPAGE_MASK;
+	addr = (mm->mmap_base-len) & HPAGE_MASK(mm);
 
 	do {
 		/*
@@ -138,7 +138,7 @@ hugetlb_get_unmapped_area_topdown(struct
  		        mm->cached_hole_size = vma->vm_start - addr;
 
 		/* try just below the current vma->vm_start */
-		addr = (vma->vm_start-len) & HPAGE_MASK;
+		addr = (vma->vm_start-len) & HPAGE_MASK(mm);
 	} while (likely(len < vma->vm_start));
 
 bottomup:
@@ -171,13 +171,13 @@ hugetlb_get_unmapped_area(struct file *f
 	if (test_thread_flag(TIF_32BIT))
 		task_size = STACK_TOP32;
 
-	if (len & ~HPAGE_MASK)
+	if (len & ~HPAGE_MASK(mm))
 		return -EINVAL;
 	if (len > task_size)
 		return -ENOMEM;
 
 	if (addr) {
-		addr = ALIGN(addr, HPAGE_SIZE);
+		addr = ALIGN(addr, HPAGE_SIZE(mm));
 		vma = find_vma(mm, addr);
 		if (task_size - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
@@ -203,7 +203,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
 	 * all of the sub-ptes for the hugepage range.  So we have
 	 * to give it the first such sub-pte.
 	 */
-	addr &= HPAGE_MASK;
+	addr &= HPAGE_MASK(mm);
 
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
@@ -222,7 +222,7 @@ pte_t *huge_pte_offset(struct mm_struct 
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	addr &= HPAGE_MASK;
+	addr &= HPAGE_MASK(mm);
 
 	pgd = pgd_offset(mm, addr);
 	if (!pgd_none(*pgd)) {
diff -Nraup a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
--- a/arch/sparc64/mm/init.c	2006-04-12 10:12:43.000000000 +0800
+++ b/arch/sparc64/mm/init.c	2006-04-12 10:09:37.000000000 +0800
@@ -325,7 +325,7 @@ void update_mmu_cache(struct vm_area_str
 		    (tlb_type != hypervisor &&
 		     (pte_val(pte) & _PAGE_SZALL_4U) == _PAGE_SZHUGE_4U)) {
 			tsb_index = MM_TSB_HUGE;
-			tsb_hash_shift = HPAGE_SHIFT;
+			tsb_hash_shift = HPAGE_SHIFT(mm);
 		}
 	}
 #endif
diff -Nraup a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c	2006-04-12 10:13:56.000000000 +0800
+++ b/fs/hugetlbfs/inode.c	2006-04-12 10:14:25.000000000 +0800
@@ -71,16 +71,16 @@ static int hugetlbfs_file_mmap(struct fi
                 return -EINVAL;
 #endif
 
-	if (vma->vm_pgoff & (HPAGE_SIZE / PAGE_SIZE - 1))
+	if (vma->vm_pgoff & (HPAGE_SIZE(vma->vm_mm) / PAGE_SIZE - 1))
 		return -EINVAL;
 
-	if (vma->vm_start & ~HPAGE_MASK)
+	if (vma->vm_start & ~HPAGE_MASK(vma->vm_mm))
 		return -EINVAL;
 
-	if (vma->vm_end & ~HPAGE_MASK)
+	if (vma->vm_end & ~HPAGE_MASK(vma->vm_mm))
 		return -EINVAL;
 
-	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
+	if (vma->vm_end - vma->vm_start < HPAGE_SIZE(vma->vm_mm))
 		return -EINVAL;
 
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
@@ -96,7 +96,9 @@ static int hugetlbfs_file_mmap(struct fi
 		goto out;
 
 	if (vma->vm_flags & VM_MAYSHARE)
-		if (hugetlb_extend_reservation(info, len >> HPAGE_SHIFT) != 0)
+		if (hugetlb_extend_reservation(info,
+					len >> HPAGE_SHIFT(vma->vm_mm),
+					HUGETLB_PAGE_ORDER(vma->vm_mm)) != 0)
 			goto out;
 
 	ret = 0;
@@ -125,13 +127,13 @@ hugetlb_get_unmapped_area(struct file *f
 	struct vm_area_struct *vma;
 	unsigned long start_addr;
 
-	if (len & ~HPAGE_MASK)
+	if (len & ~HPAGE_MASK(mm))
 		return -EINVAL;
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
 	if (addr) {
-		addr = ALIGN(addr, HPAGE_SIZE);
+		addr = ALIGN(addr, HPAGE_SIZE(mm));
 		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
@@ -144,7 +146,7 @@ hugetlb_get_unmapped_area(struct file *f
 		start_addr = TASK_UNMAPPED_BASE;
 
 full_search:
-	addr = ALIGN(start_addr, HPAGE_SIZE);
+	addr = ALIGN(start_addr, HPAGE_SIZE(mm));
 
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
@@ -162,7 +164,7 @@ full_search:
 
 		if (!vma || addr + len <= vma->vm_start)
 			return addr;
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
+		addr = ALIGN(vma->vm_end, HPAGE_SIZE(mm));
 	}
 }
 #endif
@@ -197,16 +199,18 @@ static void truncate_huge_page(struct pa
 	put_page(page);
 }
 
-static void truncate_hugepages(struct inode *inode, loff_t lstart)
+static void truncate_hugepages(struct inode *inode, loff_t lstart,
+	 struct super_block *sb)
 {
 	struct address_space *mapping = &inode->i_data;
-	const pgoff_t start = lstart >> HPAGE_SHIFT;
+	const pgoff_t start = lstart >> (sb->s_blocksize_bits);
 	struct pagevec pvec;
 	pgoff_t next;
 	int i;
 
 	hugetlb_truncate_reservation(HUGETLBFS_I(inode),
-				     lstart >> HPAGE_SHIFT);
+				     lstart >> (sb->s_blocksize_bits),
+				     sb->s_blocksize_bits - PAGE_SHIFT);
 	if (!mapping->nrpages)
 		return;
 	pagevec_init(&pvec, 0);
@@ -237,7 +241,7 @@ static void truncate_hugepages(struct in
 
 static void hugetlbfs_delete_inode(struct inode *inode)
 {
-	truncate_hugepages(inode, 0);
+	truncate_hugepages(inode, 0, inode->i_sb);
 	clear_inode(inode);
 }
 
@@ -270,7 +274,7 @@ static void hugetlbfs_forget_inode(struc
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
-	truncate_hugepages(inode, 0);
+	truncate_hugepages(inode, 0, sb);
 	clear_inode(inode);
 	destroy_inode(inode);
 }
@@ -297,8 +301,9 @@ hugetlb_vmtruncate_list(struct prio_tree
 		unsigned long h_vm_pgoff;
 		unsigned long v_offset;
 
-		h_vm_pgoff = vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
-		v_offset = (h_pgoff - h_vm_pgoff) << HPAGE_SHIFT;
+		h_vm_pgoff = vma->vm_pgoff >> (HPAGE_SHIFT(vma->vm_mm)
+		 - PAGE_SHIFT);
+		v_offset = (h_pgoff - h_vm_pgoff) << HPAGE_SHIFT(vma->vm_mm);
 		/*
 		 * Is this VMA fully outside the truncation point?
 		 */
@@ -321,15 +326,15 @@ static int hugetlb_vmtruncate(struct ino
 	if (offset > inode->i_size)
 		return -EINVAL;
 
-	BUG_ON(offset & ~HPAGE_MASK);
-	pgoff = offset >> HPAGE_SHIFT;
+	BUG_ON(offset & (inode->i_sb->s_blocksize - 1));
+	pgoff = offset >> (inode->i_sb->s_blocksize_bits);
 
 	inode->i_size = offset;
 	spin_lock(&mapping->i_mmap_lock);
 	if (!prio_tree_empty(&mapping->i_mmap))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
 	spin_unlock(&mapping->i_mmap_lock);
-	truncate_hugepages(inode, offset);
+	truncate_hugepages(inode, offset, inode->i_sb);
 	return 0;
 }
 
@@ -347,7 +352,7 @@ static int hugetlbfs_setattr(struct dent
 
 	if (ia_valid & ATTR_SIZE) {
 		error = -EINVAL;
-		if (!(attr->ia_size & ~HPAGE_MASK))
+		if (!(attr->ia_size & (inode->i_sb->s_blocksize - 1)))
 			error = hugetlb_vmtruncate(inode, attr->ia_size);
 		if (error)
 			goto out;
@@ -369,7 +374,7 @@ static struct inode *hugetlbfs_get_inode
 		inode->i_mode = mode;
 		inode->i_uid = uid;
 		inode->i_gid = gid;
-		inode->i_blksize = HPAGE_SIZE;
+		inode->i_blksize = sb->s_blocksize;
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
@@ -480,7 +485,7 @@ static int hugetlbfs_statfs(struct super
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(sb);
 
 	buf->f_type = HUGETLBFS_MAGIC;
-	buf->f_bsize = HPAGE_SIZE;
+	buf->f_bsize = sb->s_blocksize_bits;
 	if (sbinfo) {
 		spin_lock(&sbinfo->stat_lock);
 		/* If no limits set, just report 0 for max/free/used
@@ -632,13 +637,13 @@ hugetlbfs_parse_options(char *options, s
 		else if (!strcmp(opt, "size")) {
 			unsigned long long size = memparse(value, &rest);
 			if (*rest == '%') {
-				size <<= HPAGE_SHIFT;
+				size <<= HUGETLB_INIT_PAGE_SHIFT;
 				size *= max_huge_pages;
 				do_div(size, 100);
 				rest++;
 			}
-			size &= HPAGE_MASK;
-			pconfig->nr_blocks = (size >> HPAGE_SHIFT);
+			size &= HUGETLB_INIT_PAGE_MASK;
+			pconfig->nr_blocks = (size >> HUGETLB_INIT_PAGE_SHIFT);
 			value = rest;
 		} 
 #ifdef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
@@ -676,7 +681,7 @@ hugetlbfs_fill_super(struct super_block 
 	config.uid = current->fsuid;
 	config.gid = current->fsgid;
 	config.mode = 0755;
-	config.page_shift = HPAGE_SHIFT;
+	config.page_shift = HUGETLB_INIT_PAGE_SHIFT;
 	ret = hugetlbfs_parse_options(data, &config);
 
 	if (ret)
@@ -763,7 +768,7 @@ static int can_do_hugetlb_shm(void)
 			can_do_mlock());
 }
 
-struct file *hugetlb_zero_setup(size_t size)
+struct file *hugetlb_zero_setup(size_t size, int order)
 {
 	int error = -ENOMEM;
 	struct file *file;
@@ -801,7 +806,7 @@ struct file *hugetlb_zero_setup(size_t s
 
 	error = -ENOMEM;
 	if (hugetlb_extend_reservation(HUGETLBFS_I(inode),
-				       size >> HPAGE_SHIFT) != 0)
+				       size >> (order + PAGE_SHIFT), order) != 0)
 		goto out_inode;
 
 	d_instantiate(dentry, inode);
diff -Nraup a/include/asm-i386/page.h b/include/asm-i386/page.h
--- a/include/asm-i386/page.h	2006-04-12 10:12:43.000000000 +0800
+++ b/include/asm-i386/page.h	2006-04-12 10:09:37.000000000 +0800
@@ -52,21 +52,26 @@ typedef struct { unsigned long long pgpr
 #define pmd_val(x)	((x).pmd)
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define __pmd(x) ((pmd_t) { (x) } )
-#define HPAGE_SHIFT	21
+#define HPAGE_SHIFT(mm)	21
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 #define boot_pte_t pte_t /* or would you rather have a typedef */
 #define pte_val(x)	((x).pte_low)
-#define HPAGE_SHIFT	22
+#define HPAGE_SHIFT(mm)	22
 #endif
 #define PTE_MASK	PAGE_MASK
 
 #ifdef CONFIG_HUGETLB_PAGE
-#define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
-#define HPAGE_MASK	(~(HPAGE_SIZE - 1))
-#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#define HPAGE_SIZE(mm)	((1UL) << HPAGE_SHIFT(mm))
+#define HPAGE_MASK(mm)	(~(HPAGE_SIZE(mm) - 1))
+#define HUGETLB_PAGE_ORDER(mm) (HPAGE_SHIFT(mm) - PAGE_SHIFT)
+#define HUGETLB_INIT_PAGE_SHIFT (HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_ORDER (HPAGE_SHIFT(0) - PAGE_SHIFT)
+#define HUGETLB_INIT_PAGE_SIZE  (1UL<<HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_MASK  (~(HUGETLB_INIT_PAGE_SIZE - 1))
+
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #endif
 
diff -Nraup a/include/asm-ia64/page.h b/include/asm-ia64/page.h
--- a/include/asm-ia64/page.h	2006-04-12 10:13:52.000000000 +0800
+++ b/include/asm-ia64/page.h	2006-04-12 10:09:37.000000000 +0800
@@ -50,10 +50,11 @@
 
 #ifdef CONFIG_HUGETLB_PAGE
 # define HPAGE_REGION_BASE	RGN_BASE(RGN_HPAGE)
-# define HPAGE_SHIFT		hpage_shift
+# define HPAGE_SHIFT(mm)	(mm->hugepage_shift)
 # define HPAGE_SHIFT_DEFAULT	28	/* check ia64 SDM for architecture supported size */
-# define HPAGE_SIZE		(__IA64_UL_CONST(1) << HPAGE_SHIFT)
-# define HPAGE_MASK		(~(HPAGE_SIZE - 1))
+# define HPAGE_SIZE(mm)		(__IA64_UL_CONST(1) << HPAGE_SHIFT(mm))
+# define HPAGE_MASK(mm)		(~(HPAGE_SIZE(mm) - 1))
+# define HUGETLB_PAGE_ORDER(mm) ((mm->hugepage_shift) - PAGE_SHIFT)
 
 # define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 # define ARCH_HAS_HUGEPAGE_ONLY_RANGE
@@ -154,13 +155,17 @@ typedef union ia64_va {
 #define REGION_OFFSET(x)	({ia64_va _v; _v.l = (long) (x); _v.f.off;})
 
 #ifdef CONFIG_HUGETLB_PAGE
-# define htlbpage_to_page(x)	(((unsigned long) REGION_NUMBER(x) << 61)			\
-				 | (REGION_OFFSET(x) >> (HPAGE_SHIFT-PAGE_SHIFT)))
-# define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+# define htlbpage_to_page(mm,x)	(((unsigned long) REGION_NUMBER(x) << 61)			\
+				 | (REGION_OFFSET(x) >> (mm->hugepage_shift-PAGE_SHIFT)))
+# define HUGETLB_INIT_PAGE_SHIFT (init_hpage_shift)
+# define HUGETLB_INIT_PAGE_ORDER (init_hpage_shift - PAGE_SHIFT)
+# define HUGETLB_INIT_PAGE_SIZE  (__IA64_UL_CONST(1)<<init_hpage_shift)
+# define HUGETLB_INIT_PAGE_MASK  (~(HUGETLB_INIT_PAGE_SIZE - 1))
+
 # define is_hugepage_only_range(mm, addr, len)		\
 	 (REGION_NUMBER(addr) == RGN_HPAGE ||	\
 	  REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE)
-extern unsigned int hpage_shift;
+extern unsigned int init_hpage_shift;
 #endif
 
 static __inline__ int
diff -Nraup a/include/asm-parisc/page.h b/include/asm-parisc/page.h
--- a/include/asm-parisc/page.h	2006-04-12 10:12:43.000000000 +0800
+++ b/include/asm-parisc/page.h	2006-04-12 10:09:37.000000000 +0800
@@ -158,10 +158,15 @@ extern int npmem_ranges;
 #endif /* CONFIG_DISCONTIGMEM */
 
 #ifdef CONFIG_HUGETLB_PAGE
-#define HPAGE_SHIFT		22	/* 4MB (is this fixed?) */
-#define HPAGE_SIZE      	((1UL) << HPAGE_SHIFT)
-#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
-#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#define HPAGE_SHIFT(mm)		22	/* 4MB (is this fixed?) */
+#define HPAGE_SIZE(mm)      	((1UL) << HPAGE_SHIFT(mm))
+#define HPAGE_MASK(mm)		(~(HPAGE_SIZE(mm) - 1))
+#define HUGETLB_PAGE_ORDER(mm) (HPAGE_SHIFT(mm) - PAGE_SHIFT)
+
+#define HUGETLB_INIT_PAGE_SHIFT (HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_ORDER (HPAGE_SHIFT(0) - PAGE_SHIFT)
+#define HUGETLB_INIT_PAGE_SIZE  (1UL<<HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_MASK  (~(HUGETLB_INIT_PAGE_SIZE - 1))
 #endif
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
diff -Nraup a/include/asm-powerpc/page_64.h b/include/asm-powerpc/page_64.h
--- a/include/asm-powerpc/page_64.h	2006-04-12 10:12:43.000000000 +0800
+++ b/include/asm-powerpc/page_64.h	2006-04-12 10:09:37.000000000 +0800
@@ -78,14 +78,18 @@ extern u64 ppc64_pft_size;
 
 /* Large pages size */
 #ifdef CONFIG_HUGETLB_PAGE
-extern unsigned int HPAGE_SHIFT;
+#define HPAGE_SHIFT(mm) hpage_shift;
 #else
-#define HPAGE_SHIFT PAGE_SHIFT
+#define HPAGE_SHIFT(mm) PAGE_SHIFT
 #endif
-#define HPAGE_SIZE		((1UL) << HPAGE_SHIFT)
-#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
-#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
-
+#define HPAGE_SIZE(mm)		((1UL) << HPAGE_SHIFT(mm))
+#define HPAGE_MASK(mm)		(~(HPAGE_SIZE(mm) - 1))
+#define HUGETLB_PAGE_ORDER(mm) (HPAGE_SHIFT(mm) - PAGE_SHIFT)
+
+#define HUGETLB_INIT_PAGE_SHIFT (HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_ORDER (HPAGE_SHIFT(0) - PAGE_SHIFT)
+#define HUGETLB_INIT_PAGE_SIZE  (1UL<<HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_MASK  (~(HUGETLB_INIT_PAGE_SIZE - 1))
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_HUGETLB_PAGE
diff -Nraup a/include/asm-sh/page.h b/include/asm-sh/page.h
--- a/include/asm-sh/page.h	2006-04-12 10:12:43.000000000 +0800
+++ b/include/asm-sh/page.h	2006-04-12 10:09:37.000000000 +0800
@@ -22,15 +22,20 @@
 #define PTE_MASK	PAGE_MASK
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
-#define HPAGE_SHIFT	16
+#define HPAGE_SHIFT(mm)	16
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_1MB)
-#define HPAGE_SHIFT	20
+#define HPAGE_SHIFT(mm)	20
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-#define HPAGE_SIZE		(1UL << HPAGE_SHIFT)
-#define HPAGE_MASK		(~(HPAGE_SIZE-1))
-#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
+#define HPAGE_SIZE(mm)		(1UL << HPAGE_SHIFT(mm))
+#define HPAGE_MASK(mm)		(~(HPAGE_SIZE(mm)-1))
+#define HUGETLB_PAGE_ORDER(mm) (HPAGE_SHIFT(mm) - PAGE_SHIFT)
+
+#define HUGETLB_INIT_PAGE_SHIFT (HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_ORDER (HPAGE_SHIFT(0) - PAGE_SHIFT)
+#define HUGETLB_INIT_PAGE_SIZE  (1UL<<HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_MASK  (~(HUGETLB_INIT_PAGE_SIZE - 1))
 #define ARCH_HAS_SETCLEAR_HUGE_PTE
 #endif
 
diff -Nraup a/include/asm-sh64/page.h b/include/asm-sh64/page.h
--- a/include/asm-sh64/page.h	2006-04-12 10:12:43.000000000 +0800
+++ b/include/asm-sh64/page.h	2006-04-12 10:09:37.000000000 +0800
@@ -30,17 +30,22 @@
 #define PTE_MASK	PAGE_MASK
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
-#define HPAGE_SHIFT	16
+#define HPAGE_SHIFT(mm)	16
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_1MB)
-#define HPAGE_SHIFT	20
+#define HPAGE_SHIFT(mm)	20
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_512MB)
-#define HPAGE_SHIFT	29
+#define HPAGE_SHIFT(mm)	29
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-#define HPAGE_SIZE		(1UL << HPAGE_SHIFT)
-#define HPAGE_MASK		(~(HPAGE_SIZE-1))
-#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
+#define HPAGE_SIZE(mm)		(1UL << HPAGE_SHIFT(mm))
+#define HPAGE_MASK(mm)		(~(HPAGE_SIZE(mm)-1))
+#define HUGETLB_PAGE_ORDER(mm) (HPAGE_SHIFT(mm) - PAGE_SHIFT)
+
+#define HUGETLB_INIT_PAGE_SHIFT (HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_ORDER (HPAGE_SHIFT(0) - PAGE_SHIFT)
+#define HUGETLB_INIT_PAGE_SIZE  (1UL<<HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_MASK  (~(HUGETLB_INIT_PAGE_SIZE - 1))
 #define ARCH_HAS_SETCLEAR_HUGE_PTE
 #endif
 
diff -Nraup a/include/asm-sparc64/page.h b/include/asm-sparc64/page.h
--- a/include/asm-sparc64/page.h	2006-04-12 10:12:43.000000000 +0800
+++ b/include/asm-sparc64/page.h	2006-04-12 10:09:37.000000000 +0800
@@ -31,17 +31,23 @@
 #ifdef __KERNEL__
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_4MB)
-#define HPAGE_SHIFT		22
+#define HPAGE_SHIFT(mm)		22
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_512K)
-#define HPAGE_SHIFT		19
+#define HPAGE_SHIFT(mm)		19
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
-#define HPAGE_SHIFT		16
+#define HPAGE_SHIFT(mm)		16
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-#define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
-#define HPAGE_MASK		(~(HPAGE_SIZE - 1UL))
-#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#define HPAGE_SIZE(mm)		(_AC(1,UL) << HPAGE_SHIFT(mm))
+#define HPAGE_MASK(mm)		(~(HPAGE_SIZE(mm) - 1UL))
+#define HUGETLB_PAGE_ORDER(mm) (HPAGE_SHIFT(mm) - PAGE_SHIFT)
+
+#define HUGETLB_INIT_PAGE_SHIFT (HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_ORDER (HPAGE_SHIFT(0) - PAGE_SHIFT)
+#define HUGETLB_INIT_PAGE_SIZE  (1UL<<HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_MASK  (~(HUGETLB_INIT_PAGE_SIZE - 1))
+
 #define ARCH_HAS_SETCLEAR_HUGE_PTE
 #define ARCH_HAS_HUGETLB_PREFAULT_HOOK
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
diff -Nraup a/include/asm-x86_64/page.h b/include/asm-x86_64/page.h
--- a/include/asm-x86_64/page.h	2006-04-12 10:12:43.000000000 +0800
+++ b/include/asm-x86_64/page.h	2006-04-12 10:09:37.000000000 +0800
@@ -36,10 +36,15 @@
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
 #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
 
-#define HPAGE_SHIFT PMD_SHIFT
-#define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
-#define HPAGE_MASK	(~(HPAGE_SIZE - 1))
-#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#define HPAGE_SHIFT(mm) PMD_SHIFT
+#define HPAGE_SIZE(mm)  ((1UL) << HPAGE_SHIFT(mm))
+#define HPAGE_MASK(mm)  (~(HPAGE_SIZE(mm) - 1))
+#define HUGETLB_PAGE_ORDER(mm) (HPAGE_SHIFT(mm) - PAGE_SHIFT)
+
+#define HUGETLB_INIT_PAGE_SHIFT (HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_ORDER (HPAGE_SHIFT(0) - PAGE_SHIFT)
+#define HUGETLB_INIT_PAGE_SIZE  (1UL<<HPAGE_SHIFT(0))
+#define HUGETLB_INIT_PAGE_MASK  (~(HUGETLB_INIT_PAGE_SIZE - 1))
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff -Nraup a/include/linux/hugetlb.h b/include/linux/hugetlb.h
--- a/include/linux/hugetlb.h	2006-04-12 10:13:56.000000000 +0800
+++ b/include/linux/hugetlb.h	2006-04-12 10:09:37.000000000 +0800
@@ -59,9 +59,9 @@ void hugetlb_free_pgd_range(struct mmu_g
  */
 static inline int prepare_hugepage_range(unsigned long addr, unsigned long len)
 {
-	if (len & ~HPAGE_MASK)
+	if (len & ~HPAGE_MASK(current->mm))
 		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
+	if (addr & ~HPAGE_MASK(current->mm))
 		return -EINVAL;
 	return 0;
 }
@@ -113,8 +113,8 @@ static inline unsigned long hugetlb_tota
 #define hugetlb_change_protection(vma, address, end, newprot)
 
 #ifndef HPAGE_MASK
-#define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
-#define HPAGE_SIZE	PAGE_SIZE
+#define HPAGE_MASK(mm)	PAGE_MASK		/* Keep the compiler happy */
+#define HPAGE_SIZE(mm)	PAGE_SIZE
 #endif
 
 #endif /* !CONFIG_HUGETLB_PAGE */
@@ -124,7 +124,7 @@ struct hugetlbfs_config {
 	uid_t   uid;
 	gid_t   gid;
 	umode_t mode;
-	int     page_shift;
+	long	page_shift;
 	long	nr_blocks;
 	long	nr_inodes;
 };
@@ -157,11 +157,11 @@ static inline struct hugetlbfs_sb_info *
 
 extern const struct file_operations hugetlbfs_file_operations;
 extern struct vm_operations_struct hugetlb_vm_ops;
-struct file *hugetlb_zero_setup(size_t);
+struct file *hugetlb_zero_setup(size_t, int);
 int hugetlb_extend_reservation(struct hugetlbfs_inode_info *info,
-			       unsigned long atleast_hpages);
+			       unsigned long atleast_hpages, int order);
 void hugetlb_truncate_reservation(struct hugetlbfs_inode_info *info,
-				  unsigned long atmost_hpages);
+				  unsigned long atmost_hpages, int order);
 int hugetlb_get_quota(struct address_space *mapping);
 void hugetlb_put_quota(struct address_space *mapping);
 
@@ -178,7 +178,7 @@ static inline void set_file_hugepages(st
 
 #define is_file_hugepages(file)		0
 #define set_file_hugepages(file)	BUG()
-#define hugetlb_zero_setup(size)	ERR_PTR(-ENOSYS)
+#define hugetlb_zero_setup(size, int)	ERR_PTR(-ENOSYS)
 
 #endif /* !CONFIG_HUGETLBFS */
 
diff -Nraup a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	2006-04-12 10:13:53.000000000 +0800
+++ b/include/linux/mm.h	2006-04-12 10:14:33.000000000 +0800
@@ -1063,7 +1063,7 @@ extern int randomize_va_space;
 #define hugepage_size_init(mm)
 static inline int is_valid_hpage_size(unsigned long long size)
 {
-	return 1;
+	return (size == HPAGE_SIZE(0));
 }
 #else
 extern void hugepage_size_init(struct mm_struct *mm);
diff -Nraup a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c	2006-04-12 10:12:43.000000000 +0800
+++ b/ipc/shm.c	2006-04-12 10:09:37.000000000 +0800
@@ -217,7 +217,8 @@ static int newseg (key_t key, int shmflg
 
 	if (shmflg & SHM_HUGETLB) {
 		/* hugetlb_zero_setup takes care of mlock user accounting */
-		file = hugetlb_zero_setup(size);
+		file = hugetlb_zero_setup(size,
+			HUGETLB_PAGE_ORDER(current->mm));
 		shp->mlock_user = current->user;
 	} else {
 		int acctflag = VM_ACCOUNT;
@@ -411,7 +412,8 @@ static void shm_get_stat(unsigned long *
 
 		if (is_file_hugepages(shp->shm_file)) {
 			struct address_space *mapping = inode->i_mapping;
-			*rss += (HPAGE_SIZE/PAGE_SIZE)*mapping->nrpages;
+			struct super_block *sb = inode->i_sb;
+			*rss += (sb->s_blocksize/PAGE_SIZE)*mapping->nrpages;
 		} else {
 			struct shmem_inode_info *info = SHMEM_I(inode);
 			spin_lock(&info->lock);
diff -Nraup a/mm/hugetlb.c b/mm/hugetlb.c
--- a/mm/hugetlb.c	2006-04-12 10:12:43.000000000 +0800
+++ b/mm/hugetlb.c	2006-04-12 10:09:37.000000000 +0800
@@ -22,49 +22,51 @@
 #include "internal.h"
 
 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
-static unsigned long nr_huge_pages, free_huge_pages, reserved_huge_pages;
+static unsigned long nr_huge_pages[MAX_ORDER], free_huge_pages[MAX_ORDER], 
+	reserved_huge_pages[MAX_ORDER];
 unsigned long max_huge_pages;
-static struct list_head hugepage_freelists[MAX_NUMNODES];
-static unsigned int nr_huge_pages_node[MAX_NUMNODES];
-static unsigned int free_huge_pages_node[MAX_NUMNODES];
+unsigned long nr_huge_pages_size;
+static struct list_head hugepage_freelists[MAX_NUMNODES][MAX_ORDER];
+static unsigned int nr_huge_pages_node[MAX_NUMNODES][MAX_ORDER];
+static unsigned int free_huge_pages_node[MAX_NUMNODES][MAX_ORDER];
 /*
  * Protects updates to hugepage_freelists, nr_huge_pages, and free_huge_pages
  */
 static DEFINE_SPINLOCK(hugetlb_lock);
 
-static void clear_huge_page(struct page *page, unsigned long addr)
+static void clear_huge_page(struct mm_struct *mm, struct page *page, unsigned long addr)
 {
 	int i;
 
 	might_sleep();
-	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); i++) {
+	for (i = 0; i < (HPAGE_SIZE(mm)/PAGE_SIZE); i++) {
 		cond_resched();
 		clear_user_highpage(page + i, addr);
 	}
 }
 
-static void copy_huge_page(struct page *dst, struct page *src,
-			   unsigned long addr)
+static void copy_huge_page(struct mm_struct *mm, struct page *dst, 
+	struct page *src, unsigned long addr)
 {
 	int i;
 
 	might_sleep();
-	for (i = 0; i < HPAGE_SIZE/PAGE_SIZE; i++) {
+	for (i = 0; i < HPAGE_SIZE(mm)/PAGE_SIZE; i++) {
 		cond_resched();
 		copy_user_highpage(dst + i, src + i, addr + i*PAGE_SIZE);
 	}
 }
 
-static void enqueue_huge_page(struct page *page)
+static void enqueue_huge_page(struct page *page, int order)
 {
 	int nid = page_to_nid(page);
-	list_add(&page->lru, &hugepage_freelists[nid]);
-	free_huge_pages++;
-	free_huge_pages_node[nid]++;
+	list_add(&page->lru, &hugepage_freelists[nid][order]);
+	free_huge_pages[order]++;
+	free_huge_pages_node[nid][order]++;
 }
 
 static struct page *dequeue_huge_page(struct vm_area_struct *vma,
-				unsigned long address)
+				unsigned long address, int order)
 {
 	int nid = numa_node_id();
 	struct page *page = NULL;
@@ -74,16 +76,16 @@ static struct page *dequeue_huge_page(st
 	for (z = zonelist->zones; *z; z++) {
 		nid = (*z)->zone_pgdat->node_id;
 		if (cpuset_zone_allowed(*z, GFP_HIGHUSER) &&
-		    !list_empty(&hugepage_freelists[nid]))
+		    !list_empty(&hugepage_freelists[nid][order]))
 			break;
 	}
 
 	if (*z) {
-		page = list_entry(hugepage_freelists[nid].next,
+		page = list_entry(hugepage_freelists[nid][order].next,
 				  struct page, lru);
 		list_del(&page->lru);
-		free_huge_pages--;
-		free_huge_pages_node[nid]--;
+		free_huge_pages[order]--;
+		free_huge_pages_node[nid][order]--;
 	}
 	return page;
 }
@@ -95,24 +97,25 @@ static void free_huge_page(struct page *
 	INIT_LIST_HEAD(&page->lru);
 
 	spin_lock(&hugetlb_lock);
-	enqueue_huge_page(page);
+	enqueue_huge_page(page, (unsigned long)page[1].lru.prev);
 	spin_unlock(&hugetlb_lock);
 }
 
-static int alloc_fresh_huge_page(void)
+static int alloc_fresh_huge_page(int order)
 {
 	static int nid = 0;
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP|__GFP_NOWARN,
-					HUGETLB_PAGE_ORDER);
+				order);
 	nid = next_node(nid, node_online_map);
 	if (nid == MAX_NUMNODES)
 		nid = first_node(node_online_map);
 	if (page) {
 		page[1].lru.next = (void *)free_huge_page;	/* dtor */
 		spin_lock(&hugetlb_lock);
-		nr_huge_pages++;
-		nr_huge_pages_node[page_to_nid(page)]++;
+		nr_huge_pages[order]++;
+		nr_huge_pages_size += 1UL<<order;
+		nr_huge_pages_node[page_to_nid(page)][order]++;
 		spin_unlock(&hugetlb_lock);
 		put_page(page); /* free it into the hugepage allocator */
 		return 1;
@@ -127,15 +130,15 @@ static struct page *alloc_huge_page(stru
 	struct page *page;
 	int use_reserve = 0;
 	unsigned long idx;
-
+	struct mm_struct *mm = vma->vm_mm;
+	int order = HUGETLB_PAGE_ORDER(mm);
 	spin_lock(&hugetlb_lock);
-
 	if (vma->vm_flags & VM_MAYSHARE) {
 
 		/* idx = radix tree index, i.e. offset into file in
 		 * HPAGE_SIZE units */
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT(mm))
+			+ (vma->vm_pgoff >> (HPAGE_SHIFT(mm) - PAGE_SHIFT));
 
 		/* The hugetlbfs specific inode info stores the number
 		 * of "guaranteed available" (huge) pages.  That is,
@@ -150,14 +153,14 @@ static struct page *alloc_huge_page(stru
 	}
 
 	if (!use_reserve) {
-		if (free_huge_pages <= reserved_huge_pages)
+		if (free_huge_pages[order] <= reserved_huge_pages[order])
 			goto fail;
 	} else {
-		BUG_ON(reserved_huge_pages == 0);
-		reserved_huge_pages--;
+		BUG_ON(reserved_huge_pages[order] == 0);
+		reserved_huge_pages[order]--;
 	}
 
-	page = dequeue_huge_page(vma, addr);
+	page = dequeue_huge_page(vma, addr, order);
 	if (!page)
 		goto fail;
 
@@ -181,7 +184,7 @@ static struct page *alloc_huge_page(stru
  * than getting the SIGBUS later).
  */
 int hugetlb_extend_reservation(struct hugetlbfs_inode_info *info,
-			       unsigned long atleast)
+			       unsigned long atleast, int order)
 {
 	struct inode *inode = &info->vfs_inode;
 	unsigned long change_in_reserve = 0;
@@ -198,12 +201,13 @@ int hugetlb_extend_reservation(struct hu
 	 * instantiated, so we need to reserve all of them now. */
 	change_in_reserve = atleast - info->prereserved_hpages;
 
-	if ((reserved_huge_pages + change_in_reserve) > free_huge_pages) {
+	if ((reserved_huge_pages[order] + change_in_reserve) 
+		> free_huge_pages[order]) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	reserved_huge_pages += change_in_reserve;
+	reserved_huge_pages[order] += change_in_reserve;
 	info->prereserved_hpages = atleast;
 
  out:
@@ -221,7 +225,7 @@ int hugetlb_extend_reservation(struct hu
  * them.
  */
 void hugetlb_truncate_reservation(struct hugetlbfs_inode_info *info,
-				  unsigned long atmost)
+				  unsigned long atmost, int order)
 {
 	struct inode *inode = &info->vfs_inode;
 	struct address_space *mapping = inode->i_mapping;
@@ -246,8 +250,8 @@ void hugetlb_truncate_reservation(struct
 			change_in_reserve++;
 	}
 
-	BUG_ON(reserved_huge_pages < change_in_reserve);
-	reserved_huge_pages -= change_in_reserve;
+	BUG_ON(reserved_huge_pages[order] < change_in_reserve);
+	reserved_huge_pages[order] -= change_in_reserve;
 	info->prereserved_hpages = atmost;
 
  out:
@@ -257,20 +261,24 @@ void hugetlb_truncate_reservation(struct
 
 static int __init hugetlb_init(void)
 {
-	unsigned long i;
+	unsigned long i, j;
 
-	if (HPAGE_SHIFT == 0)
+#ifndef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
+	if (HPAGE_SHIFT(0) == 0)
 		return 0;
+#endif
 
 	for (i = 0; i < MAX_NUMNODES; ++i)
-		INIT_LIST_HEAD(&hugepage_freelists[i]);
+		for (j = 0; j < MAX_ORDER; ++j)
+			INIT_LIST_HEAD(&hugepage_freelists[i][j]);
 
 	for (i = 0; i < max_huge_pages; ++i) {
-		if (!alloc_fresh_huge_page())
+		if (!alloc_fresh_huge_page(HUGETLB_INIT_PAGE_ORDER))
 			break;
 	}
-	max_huge_pages = free_huge_pages = nr_huge_pages = i;
-	printk("Total HugeTLB memory allocated, %ld\n", free_huge_pages);
+	max_huge_pages = free_huge_pages[HUGETLB_INIT_PAGE_ORDER] = nr_huge_pages[HUGETLB_INIT_PAGE_ORDER] = i;
+	printk("Total HugeTLB memory allocated, %ld\n", 
+		free_huge_pages[HUGETLB_INIT_PAGE_ORDER]);
 	return 0;
 }
 module_init(hugetlb_init);
@@ -284,66 +292,67 @@ static int __init hugetlb_setup(char *s)
 __setup("hugepages=", hugetlb_setup);
 
 #ifdef CONFIG_SYSCTL
-static void update_and_free_page(struct page *page)
+static void update_and_free_page(struct page *page, int order)
 {
 	int i;
-	nr_huge_pages--;
-	nr_huge_pages_node[page_zone(page)->zone_pgdat->node_id]--;
-	for (i = 0; i < (HPAGE_SIZE / PAGE_SIZE); i++) {
+	nr_huge_pages[order]--;
+	nr_huge_pages_size -= 1UL << order;
+	nr_huge_pages_node[page_zone(page)->zone_pgdat->node_id][order]--;
+	for (i = 0; i < ((1UL << (PAGE_SHIFT + order))/ PAGE_SIZE); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
 				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
 				1 << PG_private | 1<< PG_writeback);
 	}
 	page[1].lru.next = NULL;
 	set_page_refcounted(page);
-	__free_pages(page, HUGETLB_PAGE_ORDER);
+	__free_pages(page, order);
 }
 
 #ifdef CONFIG_HIGHMEM
-static void try_to_free_low(unsigned long count)
+static void try_to_free_low(unsigned long count, int order)
 {
 	int i, nid;
 	for (i = 0; i < MAX_NUMNODES; ++i) {
 		struct page *page, *next;
-		list_for_each_entry_safe(page, next, &hugepage_freelists[i], lru) {
+		list_for_each_entry_safe(page, next, &hugepage_freelists[i][order], lru) {
 			if (PageHighMem(page))
 				continue;
 			list_del(&page->lru);
-			update_and_free_page(page);
+			update_and_free_page(page, order);
 			nid = page_zone(page)->zone_pgdat->node_id;
-			free_huge_pages--;
-			free_huge_pages_node[nid]--;
-			if (count >= nr_huge_pages)
+			free_huge_pages[order]--;
+			free_huge_pages_node[nid][order]--;
+			if (count >= nr_huge_pages[order])
 				return;
 		}
 	}
 }
 #else
-static inline void try_to_free_low(unsigned long count)
+static inline void try_to_free_low(unsigned long count, int order)
 {
 }
 #endif
 
-static unsigned long set_max_huge_pages(unsigned long count)
+static unsigned long set_max_huge_pages(unsigned long count, int order)
 {
-	while (count > nr_huge_pages) {
-		if (!alloc_fresh_huge_page())
-			return nr_huge_pages;
+	while (count > nr_huge_pages[order]) {
+		if (!alloc_fresh_huge_page(order))
+			return nr_huge_pages[order];
 	}
-	if (count >= nr_huge_pages)
-		return nr_huge_pages;
+	if (count >= nr_huge_pages[order])
+		return nr_huge_pages[order];
 
 	spin_lock(&hugetlb_lock);
-	count = max(count, reserved_huge_pages);
-	try_to_free_low(count);
-	while (count < nr_huge_pages) {
-		struct page *page = dequeue_huge_page(NULL, 0);
+	count = max(count, reserved_huge_pages[order]);
+	try_to_free_low(count, order);
+	while (count < nr_huge_pages[order]) {
+		struct page *page = dequeue_huge_page(NULL, 0, order);
 		if (!page)
 			break;
-		update_and_free_page(page);
+		update_and_free_page(page, order);
 	}
 	spin_unlock(&hugetlb_lock);
-	return nr_huge_pages;
+	return nr_huge_pages[order];
 }
 
 int hugetlb_sysctl_handler(struct ctl_table *table, int write,
@@ -351,7 +360,8 @@ int hugetlb_sysctl_handler(struct ctl_ta
 			   size_t *length, loff_t *ppos)
 {
 	proc_doulongvec_minmax(table, write, file, buffer, length, ppos);
-	max_huge_pages = set_max_huge_pages(max_huge_pages);
+	max_huge_pages = set_max_huge_pages(max_huge_pages,
+		HUGETLB_INIT_PAGE_ORDER);
 	return 0;
 }
 #endif /* CONFIG_SYSCTL */
@@ -363,10 +373,10 @@ int hugetlb_report_meminfo(char *buf)
 			"HugePages_Free:  %5lu\n"
 		        "HugePages_Rsvd:  %5lu\n"
 			"Hugepagesize:    %5lu kB\n",
-			nr_huge_pages,
-			free_huge_pages,
-		        reserved_huge_pages,
-			HPAGE_SIZE/1024);
+			nr_huge_pages[HUGETLB_INIT_PAGE_ORDER],
+			free_huge_pages[HUGETLB_INIT_PAGE_ORDER],
+		        reserved_huge_pages[HUGETLB_INIT_PAGE_ORDER],
+			HUGETLB_INIT_PAGE_SIZE/1024);
 }
 
 int hugetlb_report_node_meminfo(int nid, char *buf)
@@ -374,14 +384,14 @@ int hugetlb_report_node_meminfo(int nid,
 	return sprintf(buf,
 		"Node %d HugePages_Total: %5u\n"
 		"Node %d HugePages_Free:  %5u\n",
-		nid, nr_huge_pages_node[nid],
-		nid, free_huge_pages_node[nid]);
+		nid, nr_huge_pages_node[nid][HUGETLB_INIT_PAGE_ORDER],
+		nid, free_huge_pages_node[nid][HUGETLB_INIT_PAGE_ORDER]);
 }
 
 /* Return the number pages of memory we physically have, in PAGE_SIZE units. */
 unsigned long hugetlb_total_pages(void)
 {
-	return nr_huge_pages * (HPAGE_SIZE / PAGE_SIZE);
+	return nr_huge_pages_size;
 }
 
 /*
@@ -440,7 +450,8 @@ int copy_hugetlb_page_range(struct mm_st
 
 	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
+	for (addr = vma->vm_start; addr < vma->vm_end; 
+			addr += HPAGE_SIZE(src)) {
 		src_pte = huge_pte_offset(src, addr);
 		if (!src_pte)
 			continue;
@@ -455,7 +466,8 @@ int copy_hugetlb_page_range(struct mm_st
 			entry = *src_pte;
 			ptepage = pte_page(entry);
 			get_page(ptepage);
-			add_mm_counter(dst, file_rss, HPAGE_SIZE / PAGE_SIZE);
+			add_mm_counter(dst, file_rss, 
+					HPAGE_SIZE(src) / PAGE_SIZE);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		}
 		spin_unlock(&src->page_table_lock);
@@ -477,15 +489,15 @@ void unmap_hugepage_range(struct vm_area
 	struct page *page;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
-	BUG_ON(start & ~HPAGE_MASK);
-	BUG_ON(end & ~HPAGE_MASK);
+	BUG_ON(start & ~HPAGE_MASK(mm));
+	BUG_ON(end & ~HPAGE_MASK(mm));
 
 	spin_lock(&mm->page_table_lock);
 
 	/* Update high watermark before we lower rss */
 	update_hiwater_rss(mm);
 
-	for (address = start; address < end; address += HPAGE_SIZE) {
+	for (address = start; address < end; address += HPAGE_SIZE(mm)) {
 		ptep = huge_pte_offset(mm, address);
 		if (!ptep)
 			continue;
@@ -496,7 +508,7 @@ void unmap_hugepage_range(struct vm_area
 
 		page = pte_page(pte);
 		put_page(page);
-		add_mm_counter(mm, file_rss, (int) -(HPAGE_SIZE / PAGE_SIZE));
+		add_mm_counter(mm, file_rss, (int) -(HPAGE_SIZE(mm) / PAGE_SIZE));
 	}
 
 	spin_unlock(&mm->page_table_lock);
@@ -528,10 +540,10 @@ static int hugetlb_cow(struct mm_struct 
 	}
 
 	spin_unlock(&mm->page_table_lock);
-	copy_huge_page(new_page, old_page, address);
+	copy_huge_page(mm, new_page, old_page, address);
 	spin_lock(&mm->page_table_lock);
 
-	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
+	ptep = huge_pte_offset(mm, address & HPAGE_MASK(mm));
 	if (likely(pte_same(*ptep, pte))) {
 		/* Break COW */
 		set_huge_pte_at(mm, address, ptep,
@@ -555,8 +567,8 @@ int hugetlb_no_page(struct mm_struct *mm
 	pte_t new_pte;
 
 	mapping = vma->vm_file->f_mapping;
-	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
-		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+	idx = ((address - vma->vm_start) >> HPAGE_SHIFT(mm))
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT(mm) - PAGE_SHIFT));
 
 	/*
 	 * Use page lock to guard against racing truncation
@@ -573,7 +585,7 @@ retry:
 			ret = VM_FAULT_OOM;
 			goto out;
 		}
-		clear_huge_page(page, address);
+		clear_huge_page(mm, page, address);
 
 		if (vma->vm_flags & VM_SHARED) {
 			int err;
@@ -591,7 +603,7 @@ retry:
 	}
 
 	spin_lock(&mm->page_table_lock);
-	size = i_size_read(mapping->host) >> HPAGE_SHIFT;
+	size = i_size_read(mapping->host) >> HPAGE_SHIFT(mm);
 	if (idx >= size)
 		goto backout;
 
@@ -599,7 +611,7 @@ retry:
 	if (!pte_none(*ptep))
 		goto backout;
 
-	add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
+	add_mm_counter(mm, file_rss, HPAGE_SIZE(mm) / PAGE_SIZE);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	set_huge_pte_at(mm, address, ptep, new_pte);
@@ -678,7 +690,7 @@ int follow_hugetlb_page(struct mm_struct
 		 * each hugepage.  We have to make * sure we get the
 		 * first, for the page indexing below to work.
 		 */
-		pte = huge_pte_offset(mm, vaddr & HPAGE_MASK);
+		pte = huge_pte_offset(mm, vaddr & HPAGE_MASK(mm));
 
 		if (!pte || pte_none(*pte)) {
 			int ret;
@@ -695,7 +707,7 @@ int follow_hugetlb_page(struct mm_struct
 			break;
 		}
 
-		pfn_offset = (vaddr & ~HPAGE_MASK) >> PAGE_SHIFT;
+		pfn_offset = (vaddr & ~HPAGE_MASK(mm)) >> PAGE_SHIFT;
 		page = pte_page(*pte);
 same_page:
 		if (pages) {
@@ -711,7 +723,7 @@ same_page:
 		--remainder;
 		++i;
 		if (vaddr < vma->vm_end && remainder &&
-				pfn_offset < HPAGE_SIZE/PAGE_SIZE) {
+				pfn_offset < HPAGE_SIZE(mm)/PAGE_SIZE) {
 			/*
 			 * We use pfn_offset to avoid touching the pageframes
 			 * of this compound page.
@@ -738,7 +750,7 @@ void hugetlb_change_protection(struct vm
 	flush_cache_range(vma, address, end);
 
 	spin_lock(&mm->page_table_lock);
-	for (; address < end; address += HPAGE_SIZE) {
+	for (; address < end; address += HPAGE_SIZE(mm)) {
 		ptep = huge_pte_offset(mm, address);
 		if (!ptep)
 			continue;
diff -Nraup a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2006-04-12 10:12:43.000000000 +0800
+++ b/mm/memory.c	2006-04-12 10:09:37.000000000 +0800
@@ -824,7 +824,7 @@ unsigned long unmap_vmas(struct mmu_gath
 			if (unlikely(is_vm_hugetlb_page(vma))) {
 				unmap_hugepage_range(vma, start, end);
 				zap_work -= (end - start) /
-						(HPAGE_SIZE / PAGE_SIZE);
+					(HPAGE_SIZE(vma->vm_mm) / PAGE_SIZE);
 				start = end;
 			} else
 				start = unmap_page_range(*tlbp, vma,
diff -Nraup a/mm/mempolicy.c b/mm/mempolicy.c
--- a/mm/mempolicy.c	2006-04-12 10:12:43.000000000 +0800
+++ b/mm/mempolicy.c	2006-04-12 10:09:37.000000000 +0800
@@ -1170,7 +1170,7 @@ struct zonelist *huge_zonelist(struct vm
 	if (pol->policy == MPOL_INTERLEAVE) {
 		unsigned nid;
 
-		nid = interleave_nid(pol, vma, addr, HPAGE_SHIFT);
+		nid = interleave_nid(pol, vma, addr, HPAGE_SHIFT(vma->vm_mm));
 		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_HIGHUSER);
 	}
 	return zonelist_policy(GFP_HIGHUSER, pol);
@@ -1772,8 +1772,8 @@ static void check_huge_range(struct vm_a
 	unsigned long addr;
 	struct page *page;
 
-	for (addr = start; addr < end; addr += HPAGE_SIZE) {
-		pte_t *ptep = huge_pte_offset(vma->vm_mm, addr & HPAGE_MASK);
+	for (addr = start; addr < end; addr += HPAGE_SIZE(vma->vm_mm)) {
+		pte_t *ptep = huge_pte_offset(vma->vm_mm, addr & HPAGE_MASK(vma->vm_mm));
 		pte_t pte;
 
 		if (!ptep)
diff -Nraup a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	2006-04-12 10:12:43.000000000 +0800
+++ b/mm/mmap.c	2006-04-12 10:09:37.000000000 +0800
@@ -1693,7 +1693,7 @@ int split_vma(struct mm_struct * mm, str
 	struct mempolicy *pol;
 	struct vm_area_struct *new;
 
-	if (is_vm_hugetlb_page(vma) && (addr & ~HPAGE_MASK))
+	if (is_vm_hugetlb_page(vma) && (addr & ~HPAGE_MASK(mm)))
 		return -EINVAL;
 
 	if (mm->map_count >= sysctl_max_map_count)



