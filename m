Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVCWRT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVCWRT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVCWRT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:19:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:25613 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262741AbVCWRMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:12:45 -0500
Date: Wed, 23 Mar 2005 17:11:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] freepgt: free_pgtables use vma list
In-Reply-To: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent woes with some arches needing their own pgd_addr_end macro; and
4-level clear_page_range regression since 2.6.10's clear_page_tables;
and its long-standing well-known inefficiency in searching throughout
the higher-level page tables for those few entries to clear and free:
all can be blamed on ignoring the list of vmas when we free page tables.

Replace exit_mmap's clear_page_range of the total user address space by
free_pgtables operating on the mm's vma list; unmap_region use it in the
same way, giving floor and ceiling beyond which it may not free tables.
This brings lmbench fork/exec/sh numbers back to 2.6.10 (unless preempt
is enabled, in which case latency fixes spoil unmap_vmas throughput).

Beware: the do_mmap_pgoff driver failure case must now use unmap_region
instead of zap_page_range, since a page table might have been allocated,
and can only be freed while it is touched by some vma.

Move free_pgtables from mmap.c to memory.c, where its lower levels are
adapted from the clear_page_range levels.  (Most of free_pgtables' old
code was actually for a non-existent case, prev not properly set up,
dating from before hch gave us split_vma.)  Pass mmu_gather** in the
public interfaces, since we might want to add latency lockdrops later;
but no attempt to do so yet, going by vma should itself reduce latency.

But what if is_hugepage_only_range?  Those ia64 and ppc64 cases need
careful examination: put that off until a later patch of the series.

What of x86_64's 32bit vdso page __map_syscall32 maps outside any vma?

And the range to sparc64's flush_tlb_pgtables?  It's less clear to me
now that we need to do more than is done here - every PMD_SIZE ever
occupied will be flushed, do we really have to flush every PGDIR_SIZE
ever partially occupied?  A shame to complicate it unnecessarily.

Special thanks to David Miller for time spent repairing my ceilings.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/i386/mm/pgtable.c     |    2 
 arch/ia64/mm/hugetlbpage.c |   37 ----------
 include/linux/mm.h         |    3 
 mm/memory.c                |  152 ++++++++++++++++++++++++++++++++++-----------
 mm/mmap.c                  |  102 ++++++------------------------
 5 files changed, 141 insertions(+), 155 deletions(-)

--- 2.6.12-rc1-bk1/arch/i386/mm/pgtable.c	2005-03-02 07:39:18.000000000 +0000
+++ freepgt1/arch/i386/mm/pgtable.c	2005-03-21 19:06:35.000000000 +0000
@@ -255,6 +255,6 @@ void pgd_free(pgd_t *pgd)
 	if (PTRS_PER_PMD > 1)
 		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
 			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
-	/* in the non-PAE case, clear_page_range() clears user pgd entries */
+	/* in the non-PAE case, free_pgtables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
--- 2.6.12-rc1-bk1/arch/ia64/mm/hugetlbpage.c	2005-03-18 10:22:18.000000000 +0000
+++ freepgt1/arch/ia64/mm/hugetlbpage.c	2005-03-21 19:06:35.000000000 +0000
@@ -187,45 +187,12 @@ follow_huge_pmd(struct mm_struct *mm, un
 }
 
 /*
- * Same as generic free_pgtables(), except constant PGDIR_* and pgd_offset
- * are hugetlb region specific.
+ * Do nothing, until we've worked out what to do!  To allow build, we
+ * must remove reference to clear_page_range since it no longer exists.
  */
 void hugetlb_free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *prev,
 	unsigned long start, unsigned long end)
 {
-	unsigned long first = start & HUGETLB_PGDIR_MASK;
-	unsigned long last = end + HUGETLB_PGDIR_SIZE - 1;
-	struct mm_struct *mm = tlb->mm;
-
-	if (!prev) {
-		prev = mm->mmap;
-		if (!prev)
-			goto no_mmaps;
-		if (prev->vm_end > start) {
-			if (last > prev->vm_start)
-				last = prev->vm_start;
-			goto no_mmaps;
-		}
-	}
-	for (;;) {
-		struct vm_area_struct *next = prev->vm_next;
-
-		if (next) {
-			if (next->vm_start < start) {
-				prev = next;
-				continue;
-			}
-			if (last > next->vm_start)
-				last = next->vm_start;
-		}
-		if (prev->vm_end > first)
-			first = prev->vm_end;
-		break;
-	}
-no_mmaps:
-	if (last < first)	/* for arches with discontiguous pgd indices */
-		return;
-	clear_page_range(tlb, first, last);
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
--- 2.6.12-rc1-bk1/include/linux/mm.h	2005-03-18 10:22:43.000000000 +0000
+++ freepgt1/include/linux/mm.h	2005-03-21 19:06:35.000000000 +0000
@@ -591,7 +591,8 @@ int unmap_vmas(struct mmu_gather **tlbp,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *);
-void clear_page_range(struct mmu_gather *tlb, unsigned long addr, unsigned long end);
+void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *vma,
+		unsigned long floor, unsigned long ceiling);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
 int zeromap_page_range(struct vm_area_struct *vma, unsigned long from,
--- 2.6.12-rc1-bk1/mm/memory.c	2005-03-18 10:22:45.000000000 +0000
+++ freepgt1/mm/memory.c	2005-03-23 15:27:19.000000000 +0000
@@ -110,87 +110,165 @@ void pmd_clear_bad(pmd_t *pmd)
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static inline void clear_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
-				unsigned long addr, unsigned long end)
+static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	if (!((addr | end) & ~PMD_MASK)) {
-		/* Only free fully aligned ranges */
-		struct page *page = pmd_page(*pmd);
-		pmd_clear(pmd);
-		dec_page_state(nr_page_table_pages);
-		tlb->mm->nr_ptes--;
-		pte_free_tlb(tlb, page);
-	}
+	struct page *page = pmd_page(*pmd);
+	pmd_clear(pmd);
+	pte_free_tlb(tlb, page);
+	dec_page_state(nr_page_table_pages);
+	tlb->mm->nr_ptes--;
 }
 
-static inline void clear_pmd_range(struct mmu_gather *tlb, pud_t *pud,
-				unsigned long addr, unsigned long end)
+static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				unsigned long floor, unsigned long ceiling)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	pmd_t *empty_pmd = NULL;
+	unsigned long start;
 
+	start = addr;
 	pmd = pmd_offset(pud, addr);
-
-	/* Only free fully aligned ranges */
-	if (!((addr | end) & ~PUD_MASK))
-		empty_pmd = pmd;
 	do {
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		clear_pte_range(tlb, pmd, addr, next);
+		free_pte_range(tlb, pmd);
 	} while (pmd++, addr = next, addr != end);
 
-	if (empty_pmd) {
-		pud_clear(pud);
-		pmd_free_tlb(tlb, empty_pmd);
+	start &= PUD_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= PUD_MASK;
+		if (!ceiling)
+			return;
 	}
+	if (end - 1 > ceiling - 1)
+		return;
+
+	pmd = pmd_offset(pud, start);
+	pud_clear(pud);
+	pmd_free_tlb(tlb, pmd);
 }
 
-static inline void clear_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
-				unsigned long addr, unsigned long end)
+static inline void free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				unsigned long floor, unsigned long ceiling)
 {
 	pud_t *pud;
 	unsigned long next;
-	pud_t *empty_pud = NULL;
+	unsigned long start;
 
+	start = addr;
 	pud = pud_offset(pgd, addr);
-
-	/* Only free fully aligned ranges */
-	if (!((addr | end) & ~PGDIR_MASK))
-		empty_pud = pud;
 	do {
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		clear_pmd_range(tlb, pud, addr, next);
+		free_pmd_range(tlb, pud, addr, next, floor, ceiling);
 	} while (pud++, addr = next, addr != end);
 
-	if (empty_pud) {
-		pgd_clear(pgd);
-		pud_free_tlb(tlb, empty_pud);
+	start &= PGDIR_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= PGDIR_MASK;
+		if (!ceiling)
+			return;
 	}
+	if (end - 1 > ceiling - 1)
+		return;
+
+	pud = pud_offset(pgd, start);
+	pgd_clear(pgd);
+	pud_free_tlb(tlb, pud);
 }
 
 /*
- * This function clears user-level page tables of a process.
- * Unlike other pagetable walks, some memory layouts might give end 0.
+ * This function frees user-level page tables of a process.
+ *
  * Must be called with pagetable lock held.
  */
-void clear_page_range(struct mmu_gather *tlb,
-				unsigned long addr, unsigned long end)
+static inline void free_pgd_range(struct mmu_gather *tlb,
+			unsigned long addr, unsigned long end,
+			unsigned long floor, unsigned long ceiling)
 {
 	pgd_t *pgd;
 	unsigned long next;
+	unsigned long start;
 
+	/*
+	 * The next few lines have given us lots of grief...
+	 *
+	 * Why are we testing PMD* at this top level?  Because often
+	 * there will be no work to do at all, and we'd prefer not to
+	 * go all the way down to the bottom just to discover that.
+	 *
+	 * Why all these "- 1"s?  Because 0 represents both the bottom
+	 * of the address space and the top of it (using -1 for the
+	 * top wouldn't help much: the masks would do the wrong thing).
+	 * The rule is that addr 0 and floor 0 refer to the bottom of
+	 * the address space, but end 0 and ceiling 0 refer to the top
+	 * Comparisons need to use "end - 1" and "ceiling - 1" (though
+	 * that end 0 case should be mythical).
+	 *
+	 * Wherever addr is brought up or ceiling brought down, we must
+	 * be careful to reject "the opposite 0" before it confuses the
+	 * subsequent tests.  But what about where end is brought down
+	 * by PMD_SIZE below? no, end can't go down to 0 there.
+	 *
+	 * Whereas we round start (addr) and ceiling down, by different
+	 * masks at different levels, in order to test whether a table
+	 * now has no other vmas using it, so can be freed, we don't
+	 * bother to round floor or end up - the tests don't need that.
+	 */
+
+	addr &= PMD_MASK;
+	if (addr < floor) {
+		addr += PMD_SIZE;
+		if (!addr)
+			return;
+	}
+	if (ceiling) {
+		ceiling &= PMD_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		end -= PMD_SIZE;
+	if (addr > end - 1)
+		return;
+
+	start = addr;
 	pgd = pgd_offset(tlb->mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		clear_pud_range(tlb, pgd, addr, next);
+		free_pud_range(tlb, pgd, addr, next, floor, ceiling);
 	} while (pgd++, addr = next, addr != end);
+
+	if (!tlb_is_full_mm(tlb))
+		flush_tlb_pgtables(tlb->mm, start, end);
+}
+
+void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *vma,
+				unsigned long floor, unsigned long ceiling)
+{
+	while (vma) {
+		struct vm_area_struct *next = vma->vm_next;
+		unsigned long addr = vma->vm_start;
+
+		/* Optimization: gather nearby vmas into a single call down */
+		while (next && next->vm_start <= vma->vm_end + PMD_SIZE) {
+			vma = next;
+			next = vma->vm_next;
+		}
+		free_pgd_range(*tlb, addr, vma->vm_end,
+				floor, next? next->vm_start: ceiling);
+		vma = next;
+	}
 }
 
 pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
--- 2.6.12-rc1-bk1/mm/mmap.c	2005-03-18 10:22:45.000000000 +0000
+++ freepgt1/mm/mmap.c	2005-03-21 19:06:35.000000000 +0000
@@ -29,6 +29,10 @@
 #include <asm/cacheflush.h>
 #include <asm/tlb.h>
 
+static void unmap_region(struct mm_struct *mm,
+		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		unsigned long start, unsigned long end);
+
 /*
  * WARNING: the debugging will use recursive algorithms so never enable this
  * unless you know what you are doing.
@@ -1129,7 +1133,8 @@ unmap_and_free_vma:
 	fput(file);
 
 	/* Undo any partial mapping done by a device driver. */
-	zap_page_range(vma, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged = 0;
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
 unacct_error:
@@ -1572,66 +1577,6 @@ find_extend_vma(struct mm_struct * mm, u
 }
 #endif
 
-/*
- * Try to free as many page directory entries as we can,
- * without having to work very hard at actually scanning
- * the page tables themselves.
- *
- * Right now we try to free page tables if we have a nice
- * PGDIR-aligned area that got free'd up. We could be more
- * granular if we want to, but this is fast and simple,
- * and covers the bad cases.
- *
- * "prev", if it exists, points to a vma before the one
- * we just free'd - but there's no telling how much before.
- */
-static void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *prev,
-	unsigned long start, unsigned long end)
-{
-	unsigned long first = start & PGDIR_MASK;
-	unsigned long last = end + PGDIR_SIZE - 1;
-	struct mm_struct *mm = tlb->mm;
-
-	if (last > MM_VM_SIZE(mm) || last < end)
-		last = MM_VM_SIZE(mm);
-
-	if (!prev) {
-		prev = mm->mmap;
-		if (!prev)
-			goto no_mmaps;
-		if (prev->vm_end > start) {
-			if (last > prev->vm_start)
-				last = prev->vm_start;
-			goto no_mmaps;
-		}
-	}
-	for (;;) {
-		struct vm_area_struct *next = prev->vm_next;
-
-		if (next) {
-			if (next->vm_start < start) {
-				prev = next;
-				continue;
-			}
-			if (last > next->vm_start)
-				last = next->vm_start;
-		}
-		if (prev->vm_end > first)
-			first = prev->vm_end;
-		break;
-	}
-no_mmaps:
-	if (last < first)	/* for arches with discontiguous pgd indices */
-		return;
-	if (first < FIRST_USER_PGD_NR * PGDIR_SIZE)
-		first = FIRST_USER_PGD_NR * PGDIR_SIZE;
-	/* No point trying to free anything if we're in the same pte page */
-	if ((first & PMD_MASK) < (last & PMD_MASK)) {
-		clear_page_range(tlb, first, last);
-		flush_tlb_pgtables(mm, first, last);
-	}
-}
-
 /* Normal function to fix up a mapping
  * This function is the default for when an area has no specific
  * function.  This may be used as part of a more specific routine.
@@ -1674,24 +1619,22 @@ static void unmap_vma_list(struct mm_str
  * Called with the page table lock held.
  */
 static void unmap_region(struct mm_struct *mm,
-	struct vm_area_struct *vma,
-	struct vm_area_struct *prev,
-	unsigned long start,
-	unsigned long end)
+		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		unsigned long start, unsigned long end)
 {
+	struct vm_area_struct *next = prev? prev->vm_next: mm->mmap;
 	struct mmu_gather *tlb;
 	unsigned long nr_accounted = 0;
 
 	lru_add_drain();
+	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
-
-	if (is_hugepage_only_range(start, end - start))
-		hugetlb_free_pgtables(tlb, prev, start, end);
-	else
-		free_pgtables(tlb, prev, start, end);
+	free_pgtables(&tlb, vma, prev? prev->vm_end: 0,
+				 next? next->vm_start: 0);
 	tlb_finish_mmu(tlb, start, end);
+	spin_unlock(&mm->page_table_lock);
 }
 
 /*
@@ -1823,9 +1766,7 @@ int do_munmap(struct mm_struct *mm, unsi
 	 * Remove the vma's, and unmap the actual pages
 	 */
 	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
-	spin_lock(&mm->page_table_lock);
 	unmap_region(mm, mpnt, prev, start, end);
-	spin_unlock(&mm->page_table_lock);
 
 	/* Fix up all other VM information */
 	unmap_vma_list(mm, mpnt);
@@ -1957,25 +1898,21 @@ EXPORT_SYMBOL(do_brk);
 void exit_mmap(struct mm_struct *mm)
 {
 	struct mmu_gather *tlb;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = mm->mmap;
 	unsigned long nr_accounted = 0;
 
 	lru_add_drain();
 
 	spin_lock(&mm->page_table_lock);
 
-	tlb = tlb_gather_mmu(mm, 1);
 	flush_cache_mm(mm);
-	/* Use ~0UL here to ensure all VMAs in the mm are unmapped */
-	mm->map_count -= unmap_vmas(&tlb, mm, mm->mmap, 0,
-					~0UL, &nr_accounted, NULL);
+	tlb = tlb_gather_mmu(mm, 1);
+	/* Use -1 here to ensure all VMAs in the mm are unmapped */
+	mm->map_count -= unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
-	BUG_ON(mm->map_count);	/* This is just debugging */
-	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE, MM_VM_SIZE(mm));
-	
+	free_pgtables(&tlb, vma, 0, 0);
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
 
-	vma = mm->mmap;
 	mm->mmap = mm->mmap_cache = NULL;
 	mm->mm_rb = RB_ROOT;
 	mm->rss = 0;
@@ -1993,6 +1930,9 @@ void exit_mmap(struct mm_struct *mm)
 		remove_vm_struct(vma);
 		vma = next;
 	}
+
+	BUG_ON(mm->map_count);	/* This is just debugging */
+	BUG_ON(mm->nr_ptes);	/* This is just debugging */
 }
 
 /* Insert vm structure into process list sorted by address
