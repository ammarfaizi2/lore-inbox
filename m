Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVHZREn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVHZREn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVHZRCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:15 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:30869 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965124AbVHZRCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:03 -0400
Subject: [patch 18/18] remap_file_pages linear nonuniform support: (2) fix truncation on nonuniform VMA
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:54:07 +0200
Message-Id: <20050826165407.5DA9225486A@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Since we aren't going to support nonuniform linear VMAs, this is probably not
needed. Otherwise, you may want to look at this patch, but I must first note
that it's a bit intrusive.

We must save protections and support when truncating pages in a linear
nonuniform VMA.  I could indeed verify this failure: protections were reset on
a linear nonuniform VMA by a madvise(MADV_DONTNEED) or by a truncate(), while
they weren't when the VMA was also nonlinear.

Also, we can have pte_file PTE's even when details is clear. This used to
happen for MAP_POPULATE|MAP_NONBLOCK only, where clearing the PTE is allowed;
but now this can happen on nonuniform vmas, where we mustn't clear them. We
then unconditionally add vma to the zap_pte_range parameters. So, I've turned
details->nonlinear_vma into a bitfield, and I added another bitfield:
 ->must_unmap.

In fact, in the case we're being called by do_munmap() or exit_mmap() (rather
than truncating its pagecache), we must still clear mappings (leaving them in
place would create problems if we map another file in the same area, since we
would reuse the stored offset and protections).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/mm.h |    4 +-
 linux-2.6.git-paolo/mm/madvise.c       |    2 -
 linux-2.6.git-paolo/mm/memory.c        |   55 +++++++++++++++++++--------------
 linux-2.6.git-paolo/mm/mmap.c          |   10 ++++--
 4 files changed, 45 insertions(+), 26 deletions(-)

diff -puN include/linux/mm.h~rfp-fix-linear-nonunif-truncation include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-fix-linear-nonunif-truncation	2005-08-25 14:03:59.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-25 14:03:59.000000000 +0200
@@ -680,7 +680,6 @@ extern void user_shm_unlock(size_t, stru
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct vm_area_struct *nonlinear_vma;	/* Check page->index if set */
 	struct address_space *check_mapping;	/* Check page->mapping if set */
 	pgoff_t	first_index;			/* Lowest page->index to unmap */
 	pgoff_t last_index;			/* Highest page->index to unmap */
@@ -689,6 +688,9 @@ struct zap_details {
 	unsigned prot_none_ptes : 1;		/* If 1, set all PTE's to
 						   PROT_NONE ones, and all other
 						   fields must be clear */
+	unsigned nonlinear_vma : 1;		/* Check page->index if set */
+	unsigned must_unmap : 1;		/* Totally zap page tables, it's
+						   an unmap not a truncation. */
 };
 
 unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
diff -puN mm/madvise.c~rfp-fix-linear-nonunif-truncation mm/madvise.c
--- linux-2.6.git/mm/madvise.c~rfp-fix-linear-nonunif-truncation	2005-08-25 14:03:59.000000000 +0200
+++ linux-2.6.git-paolo/mm/madvise.c	2005-08-25 14:03:59.000000000 +0200
@@ -128,7 +128,7 @@ static long madvise_dontneed(struct vm_a
 
 	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
 		struct zap_details details = {
-			.nonlinear_vma = vma,
+			.nonlinear_vma = 1,
 			.last_index = ULONG_MAX,
 		};
 		zap_page_range(vma, start, end - start, &details);
diff -puN mm/memory.c~rfp-fix-linear-nonunif-truncation mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-fix-linear-nonunif-truncation	2005-08-25 14:03:59.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-25 14:03:59.000000000 +0200
@@ -514,9 +514,9 @@ int copy_page_range(struct mm_struct *ds
 	return 0;
 }
 
-static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
-				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+static void zap_pte_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+				pmd_t *pmd, unsigned long addr,
+				unsigned long end, struct zap_details *details)
 {
 	pte_t *pte;
 
@@ -536,8 +536,8 @@ static void zap_pte_range(struct mmu_gat
 				if (PageReserved(page))
 					page = NULL;
 			}
-			if (unlikely(details && !details->prot_none_ptes) &&
-					page) {
+			if (unlikely(details && !details->prot_none_ptes &&
+						!details->must_unmap) && page) {
 				/*
 				 * unmap_shared_mapping_pages() wants to
 				 * invalidate cache without truncating:
@@ -561,12 +561,12 @@ static void zap_pte_range(struct mmu_gat
 				set_pte_at(mm, addr, pte, pfn_pte(0, __S000));
 			if (unlikely(!page))
 				continue;
-			if (unlikely(details) && details->nonlinear_vma &&
-					!details->prot_none_ptes) {
-				save_nonlinear_pte(ptent, pte,
-						details->nonlinear_vma,
-						tlb->mm, page, addr);
-			}
+			/* We may have to save prots and offset in the PTE even
+			 * if the VMA is linear, but nonuniform. */
+			if (likely(!details) || (!details->must_unmap &&
+					!details->prot_none_ptes))
+				save_nonlinear_pte(ptent, pte, vma, tlb->mm,
+						page, addr);
 			if (pte_dirty(ptent))
 				set_page_dirty(page);
 			if (PageAnon(page))
@@ -580,21 +580,30 @@ static void zap_pte_range(struct mmu_gat
 		}
 		/*
 		 * If details->check_mapping, we leave swap entries;
-		 * if details->nonlinear_vma, we leave file entries.
+		 * if details->nonlinear_vma, we leave file entries; we only
+		 * clear them if details->must_unmap (see do_munmap()).
+		 * Otherwise we could wrongly reuse index and protections on
+		 * another vma.
+		 * We must reuse them in any other occasion, even if the file is
+		 * truncated or the pagecache invalidated; nonlinear_vma may be
+		 * clear because of a VM_NONUNIFORM vma, which is rare however.
 		 */
-		if (unlikely(details) && !details->prot_none_ptes)
+		if (unlikely(details) && !details->prot_none_ptes &&
+				!details->must_unmap)
 			continue;
 		if (likely(!pte_file(ptent)))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
 		if (unlikely(details && details->prot_none_ptes))
 			set_pte_at(mm, addr, pte, pfn_pte(0, __S000));
-		else
+		/* Here details implies details->must_unmap */
+		else if (likely(!pte_file(ptent) || details))
 			pte_clear(tlb->mm, addr, pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
 }
 
-static inline void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+static inline void zap_pmd_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -606,11 +615,12 @@ static inline void zap_pmd_range(struct 
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		zap_pte_range(tlb, pmd, addr, next, details);
+		zap_pte_range(tlb, vma, pmd, addr, next, details);
 	} while (pmd++, addr = next, addr != end);
 }
 
-static inline void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+static inline void zap_pud_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -622,7 +632,7 @@ static inline void zap_pud_range(struct 
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		zap_pmd_range(tlb, pud, addr, next, details);
+		zap_pmd_range(tlb, vma, pud, addr, next, details);
 	} while (pud++, addr = next, addr != end);
 }
 
@@ -634,7 +644,7 @@ static void unmap_page_range(struct mmu_
 	unsigned long next;
 
 	if (details && !details->check_mapping && !details->nonlinear_vma &&
-			!details->prot_none_ptes)
+			!details->prot_none_ptes && !details->must_unmap)
 		details = NULL;
 
 	BUG_ON(addr >= end);
@@ -644,7 +654,7 @@ static void unmap_page_range(struct mmu_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		zap_pud_range(tlb, pgd, addr, next, details);
+		zap_pud_range(tlb, vma, pgd, addr, next, details);
 	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
 }
@@ -1486,11 +1496,11 @@ static inline void unmap_mapping_range_l
 	 * whose virtual address lies outside the file truncation point.
 	 */
 restart:
+	details->nonlinear_vma = 1;
 	list_for_each_entry(vma, head, shared.vm_set.list) {
 		/* Skip quickly over those we have already dealt with */
 		if (vma->vm_truncate_count == details->truncate_count)
 			continue;
-		details->nonlinear_vma = vma;
 		if (unmap_mapping_range_vma(vma, vma->vm_start,
 					vma->vm_end, details) < 0)
 			goto restart;
@@ -1529,13 +1539,14 @@ void unmap_mapping_range(struct address_
 	}
 
 	details.check_mapping = even_cows? NULL: mapping;
-	details.nonlinear_vma = NULL;
+	details.nonlinear_vma = 0;
 	details.first_index = hba;
 	details.last_index = hba + hlen - 1;
 	if (details.last_index < details.first_index)
 		details.last_index = ULONG_MAX;
 	details.i_mmap_lock = &mapping->i_mmap_lock;
 	details.prot_none_ptes = 0;
+	details.must_unmap = 0;
 
 	spin_lock(&mapping->i_mmap_lock);
 
diff -puN mm/mmap.c~rfp-fix-linear-nonunif-truncation mm/mmap.c
--- linux-2.6.git/mm/mmap.c~rfp-fix-linear-nonunif-truncation	2005-08-25 14:03:59.000000000 +0200
+++ linux-2.6.git-paolo/mm/mmap.c	2005-08-25 14:03:59.000000000 +0200
@@ -1660,11 +1660,14 @@ static void unmap_region(struct mm_struc
 	struct vm_area_struct *next = prev? prev->vm_next: mm->mmap;
 	struct mmu_gather *tlb;
 	unsigned long nr_accounted = 0;
+	struct zap_details details = {
+		.must_unmap = 1,
+	};
 
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
-	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
+	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, &details);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
 				 next? next->vm_start: 0);
@@ -1942,6 +1945,9 @@ void exit_mmap(struct mm_struct *mm)
 	struct vm_area_struct *vma = mm->mmap;
 	unsigned long nr_accounted = 0;
 	unsigned long end;
+	struct zap_details details = {
+		.must_unmap = 1,
+	};
 
 	lru_add_drain();
 
@@ -1950,7 +1956,7 @@ void exit_mmap(struct mm_struct *mm)
 	flush_cache_mm(mm);
 	tlb = tlb_gather_mmu(mm, 1);
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
+	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, &details);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
 	tlb_finish_mmu(tlb, 0, end);
_
