Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWCQNN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWCQNN6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWCQNN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:13:58 -0500
Received: from cantor2.suse.de ([195.135.220.15]:34744 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932630AbWCQNN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:13:56 -0500
Date: Fri, 17 Mar 2006 14:13:54 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: [rfc] mm: mmu gather in-place
Message-ID: <20060317131354.GA16156@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm embarrassed to release this patch in such a state, but I am
because a) I won't have much time to work on it in the short term;
b) it would take a lot of work to polish so I'd like to see what
people think before going too far; c) so I have something other than
boring lockless pagecache to talk about at Ottawa.

The basic idea is this: replace the heavyweight per-CPU mmu_gather
structure with a lightweight stack based one which is missing the
big page vector. Instead of the vector, use Linux pagetables to
store the pages-to-be-freed. Pages and pagetables are first unmapped,
then tlbs are flushed, then pages and pagetables are freed.

There is a downside: walking the page table can be anywhere from
slightly to a lot less efficient than walking the vector, depending
on density, and this adds a 2nd pagetable walk to unmapping (but
removes the vector walk, of course).

Upsides: mmu_gather is preemptible, horrible mmu_gather breaking
code can be removed, artificial disparity between PREEMPT tlb
flush batching and non-PREEMPT disappears (preempt can now have
good performance and non-preempt can have good latency). tlb flush
batching is possibly much closer to perfect though on non-PREEMPT
that may not be noticable (for PREEMPT, it appears to be spending
5x less time in tlb flushing on kbuild)

Caveats:
- nonlinear mappings don't work yet
- hugepages don't work yet
- i386 only
- code is ugly

Comments?

Nick
---

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/pagevec.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -120,19 +121,25 @@ void pmd_clear_bad(pmd_t *pmd)
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
+static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd, int free)
 {
-	struct page *page = pmd_page(*pmd);
-	pmd_clear(pmd);
-	pte_lock_deinit(page);
-	pte_free_tlb(tlb, page);
-	dec_page_state(nr_page_table_pages);
-	tlb->mm->nr_ptes--;
+	if (!free) {
+		tlb_remove_pmd_entry(tlb, pmd);
+		pmd_unmap(pmd);
+	} else {
+		struct page *page = pmd_page(*pmd);
+		pmd_clear(pmd);
+		pte_lock_deinit(page);
+		pte_free(page);
+		dec_page_state(nr_page_table_pages);
+		tlb->mm->nr_ptes--;
+	}
 }
 
 static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
+				unsigned long floor, unsigned long ceiling,
+				int free)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -142,9 +149,14 @@ static inline void free_pmd_range(struct
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
-		free_pte_range(tlb, pmd);
+		if (!free) {
+			if (pmd_none_or_clear_bad(pmd))
+				continue;
+		} else {
+			if (pmd_none(*pmd))
+				continue;
+		}
+		free_pte_range(tlb, pmd, free);
 	} while (pmd++, addr = next, addr != end);
 
 	start &= PUD_MASK;
@@ -158,14 +170,20 @@ static inline void free_pmd_range(struct
 	if (end - 1 > ceiling - 1)
 		return;
 
-	pmd = pmd_offset(pud, start);
-	pud_clear(pud);
-	pmd_free_tlb(tlb, pmd);
+	if (!free) {
+		tlb_remove_pud_entry(tlb, pud);
+		pud_unmap(pud);
+	} else {
+		pmd = pmd_offset(pud, start);
+		pud_clear(pud);
+		pmd_free(pmd);
+	}
 }
 
 static inline void free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
+				unsigned long floor, unsigned long ceiling,
+				int free)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -175,9 +193,14 @@ static inline void free_pud_range(struct
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		free_pmd_range(tlb, pud, addr, next, floor, ceiling);
+		if (!free) {
+			if (pud_none_or_clear_bad(pud))
+				continue;
+		} else {
+			if (pud_none(*pud))
+				continue;
+		}
+		free_pmd_range(tlb, pud, addr, next, floor, ceiling, free);
 	} while (pud++, addr = next, addr != end);
 
 	start &= PGDIR_MASK;
@@ -191,19 +214,23 @@ static inline void free_pud_range(struct
 	if (end - 1 > ceiling - 1)
 		return;
 
-	pud = pud_offset(pgd, start);
-	pgd_clear(pgd);
-	pud_free_tlb(tlb, pud);
+	if (!free) {
+		tlb_remove_pgd_entry(tlb, pgd);
+		pgd_unmap(pgd);
+	} else {
+		pud = pud_offset(pgd, start);
+		pgd_clear(pgd);
+		pud_free(pud);
+	}
 }
 
 /*
  * This function frees user-level page tables of a process.
- *
- * Must be called with pagetable lock held.
  */
-void free_pgd_range(struct mmu_gather **tlb,
+void free_pgd_range(struct mmu_gather *tlb,
 			unsigned long addr, unsigned long end,
-			unsigned long floor, unsigned long ceiling)
+			unsigned long floor, unsigned long ceiling,
+			int free)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -252,30 +279,40 @@ void free_pgd_range(struct mmu_gather **
 		return;
 
 	start = addr;
-	pgd = pgd_offset((*tlb)->mm, addr);
+	pgd = pgd_offset(tlb->mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		free_pud_range(*tlb, pgd, addr, next, floor, ceiling);
+		if (!free) {
+			if (pgd_none_or_clear_bad(pgd))
+				continue;
+		} else {
+			if (pgd_none(*pgd))
+				continue;
+		}
+		free_pud_range(tlb, pgd, addr, next, floor, ceiling, free);
 	} while (pgd++, addr = next, addr != end);
 
-	if (!(*tlb)->fullmm)
-		flush_tlb_pgtables((*tlb)->mm, start, end);
+	if (!free) {
+		if (!tlb->fullmm)
+			flush_tlb_pgtables(tlb->mm, start, end);
+	}
 }
 
-void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+void unmap_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long floor, unsigned long ceiling, int free)
 {
 	while (vma) {
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long addr = vma->vm_start;
 
-		/*
-		 * Hide vma from rmap and vmtruncate before freeing pgtables
-		 */
-		anon_vma_unlink(vma);
-		unlink_file_vma(vma);
+		if (!free) {
+			/*
+			 * Hide vma from rmap and vmtruncate before freeing
+			 * pgtables
+			 */
+			anon_vma_unlink(vma);
+			unlink_file_vma(vma);
+		}
 
 		if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
@@ -289,16 +326,114 @@ void free_pgtables(struct mmu_gather **t
 							HPAGE_SIZE)) {
 				vma = next;
 				next = vma->vm_next;
-				anon_vma_unlink(vma);
-				unlink_file_vma(vma);
+				if (!free) {
+					anon_vma_unlink(vma);
+					unlink_file_vma(vma);
+				}
 			}
 			free_pgd_range(tlb, addr, vma->vm_end,
-				floor, next? next->vm_start: ceiling);
+				floor, next? next->vm_start: ceiling, free);
 		}
 		vma = next;
 	}
 }
 
+static void tlb_free_pte_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pmd_t *pmd,
+				unsigned long addr, unsigned long end)
+{
+	struct mm_struct *mm = tlb->mm;
+	pte_t *pte;
+
+	pte = pte_offset_map(pmd, addr);
+	do {
+		pte_t ptent = *pte;
+		struct page *page;
+
+		if (!pte_gather(ptent))
+			continue;
+
+		page = pte_page(ptent);
+		if (!pagevec_add(&tlb->pvec, page))
+			__pagevec_release_and_swapcache(&tlb->pvec);
+		pte_clear_full(mm, addr, pte, 1);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+	pte_unmap(pte - 1);
+}
+
+static inline void tlb_free_pmd_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pud_t *pud,
+				unsigned long addr, unsigned long end)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		tlb_free_pte_range(tlb, vma, pmd, addr, next);
+	} while (pmd++, addr = next, addr != end);
+}
+
+static inline void tlb_free_pud_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, pgd_t *pgd,
+				unsigned long addr, unsigned long end)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none(*pud))
+			continue;
+		tlb_free_pmd_range(tlb, vma, pud, addr, next);
+	} while (pud++, addr = next, addr != end);
+}
+
+static void tlb_free_pgd_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end)
+{
+	pgd_t *pgd;
+	unsigned long next;
+
+	BUG_ON(addr >= end);
+	pgd = pgd_offset(vma->vm_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(*pgd))
+			continue;
+		tlb_free_pud_range(tlb, vma, pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+}
+
+void tlb_free_page_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long start_addr,
+		unsigned long end_addr)
+{
+	pagevec_init(&tlb->pvec, 0);
+	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next) {
+		unsigned long start, end;
+
+		start = max(vma->vm_start, start_addr);
+		if (start >= vma->vm_end)
+			continue;
+		end = min(vma->vm_end, end_addr);
+		if (end <= vma->vm_start)
+			continue;
+
+		if (unlikely(is_vm_hugetlb_page(vma)))
+			continue;
+
+		tlb_free_pgd_range(tlb, vma, start, end);
+	}
+	pagevec_release_and_swapcache(&tlb->pvec);
+}
+
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
 	struct page *new = pte_alloc_one(mm, address);
@@ -605,10 +740,10 @@ int copy_page_range(struct mm_struct *ds
 	return 0;
 }
 
-static unsigned long zap_pte_range(struct mmu_gather *tlb,
+static void zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
-				long *zap_work, struct zap_details *details)
+				struct zap_details *details)
 {
 	struct mm_struct *mm = tlb->mm;
 	pte_t *pte;
@@ -619,15 +754,11 @@ static unsigned long zap_pte_range(struc
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
 		pte_t ptent = *pte;
-		if (pte_none(ptent)) {
-			(*zap_work)--;
+		if (pte_none(ptent))
 			continue;
-		}
 		if (pte_present(ptent)) {
 			struct page *page;
 
-			(*zap_work) -= PAGE_SIZE;
-
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(details) && page) {
 				/*
@@ -649,14 +780,21 @@ static unsigned long zap_pte_range(struc
 			}
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
-			tlb_remove_tlb_entry(tlb, pte, addr);
+			tlb_remove_pte_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
+#if 0
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
 						addr) != page->index)
 				set_pte_at(mm, addr, pte,
-					   pgoff_to_pte(page->index));
+						pgoff_to_pte(page->index));
+			else
+#else
+			BUG_ON(details && details->nonlinear_vma);
+#endif
+			set_pte_at(mm, addr, pte, pte_mkgather(ptent));
+
 			if (PageAnon(page))
 				anon_rss--;
 			else {
@@ -667,7 +805,6 @@ static unsigned long zap_pte_range(struc
 				file_rss--;
 			}
 			page_remove_rmap(page);
-			tlb_remove_page(tlb, page);
 			continue;
 		}
 		/*
@@ -678,19 +815,21 @@ static unsigned long zap_pte_range(struc
 			continue;
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
-		pte_clear_full(mm, addr, pte, tlb->fullmm);
-	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));
+#if 1
+		else
+			BUG();
+#endif
+		pte_clear_full(mm, addr, pte, 1);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss(mm, file_rss, anon_rss);
 	pte_unmap_unlock(pte - 1, ptl);
-
-	return addr;
 }
 
-static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
+static inline void zap_pmd_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
-				long *zap_work, struct zap_details *details)
+				struct zap_details *details)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -698,21 +837,16 @@ static inline unsigned long zap_pmd_rang
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd)) {
-			(*zap_work)--;
+		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		}
-		next = zap_pte_range(tlb, vma, pmd, addr, next,
-						zap_work, details);
-	} while (pmd++, addr = next, (addr != end && *zap_work > 0));
-
-	return addr;
+		zap_pte_range(tlb, vma, pmd, addr, next, details);
+	} while (pmd++, addr = next, addr != end);
 }
 
-static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
+static inline void zap_pud_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
-				long *zap_work, struct zap_details *details)
+				struct zap_details *details)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -720,21 +854,16 @@ static inline unsigned long zap_pud_rang
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud)) {
-			(*zap_work)--;
+		if (pud_none_or_clear_bad(pud))
 			continue;
-		}
-		next = zap_pmd_range(tlb, vma, pud, addr, next,
-						zap_work, details);
-	} while (pud++, addr = next, (addr != end && *zap_work > 0));
-
-	return addr;
+		zap_pmd_range(tlb, vma, pud, addr, next, details);
+	} while (pud++, addr = next, addr != end);
 }
 
-static unsigned long unmap_page_range(struct mmu_gather *tlb,
+static void unmap_page_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end,
-				long *zap_work, struct zap_details *details)
+				struct zap_details *details)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -747,25 +876,13 @@ static unsigned long unmap_page_range(st
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd)) {
-			(*zap_work)--;
+		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		}
-		next = zap_pud_range(tlb, vma, pgd, addr, next,
-						zap_work, details);
-	} while (pgd++, addr = next, (addr != end && *zap_work > 0));
+		zap_pud_range(tlb, vma, pgd, addr, next, details);
+	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
-
-	return addr;
 }
 
-#ifdef CONFIG_PREEMPT
-# define ZAP_BLOCK_SIZE	(8 * PAGE_SIZE)
-#else
-/* No preempt: go for improved straight-line efficiency */
-# define ZAP_BLOCK_SIZE	(1024 * PAGE_SIZE)
-#endif
-
 /**
  * unmap_vmas - unmap a range of memory covered by a list of vma's
  * @tlbp: address of the caller's struct mmu_gather
@@ -779,10 +896,6 @@ static unsigned long unmap_page_range(st
  *
  * Unmap all pages in the vma list.
  *
- * We aim to not hold locks for too long (for scheduling latency reasons).
- * So zap pages in ZAP_BLOCK_SIZE bytecounts.  This means we need to
- * return the ending mmu_gather to the caller.
- *
  * Only addresses between `start' and `end' will be unmapped.
  *
  * The VMA list must be sorted in ascending virtual address order.
@@ -792,20 +905,15 @@ static unsigned long unmap_page_range(st
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-unsigned long unmap_vmas(struct mmu_gather **tlbp,
+unsigned long unmap_vmas(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *details)
 {
-	long zap_work = ZAP_BLOCK_SIZE;
-	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
-	int tlb_start_valid = 0;
-	unsigned long start = start_addr;
 	spinlock_t *i_mmap_lock = details? details->i_mmap_lock: NULL;
-	int fullmm = (*tlbp)->fullmm;
 
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next) {
-		unsigned long end;
+		unsigned long start, end;
 
 		start = max(vma->vm_start, start_addr);
 		if (start >= vma->vm_end)
@@ -817,44 +925,19 @@ unsigned long unmap_vmas(struct mmu_gath
 		if (vma->vm_flags & VM_ACCOUNT)
 			*nr_accounted += (end - start) >> PAGE_SHIFT;
 
-		while (start != end) {
-			if (!tlb_start_valid) {
-				tlb_start = start;
-				tlb_start_valid = 1;
-			}
-
-			if (unlikely(is_vm_hugetlb_page(vma))) {
-				unmap_hugepage_range(vma, start, end);
-				zap_work -= (end - start) /
-						(HPAGE_SIZE / PAGE_SIZE);
-				start = end;
-			} else
-				start = unmap_page_range(*tlbp, vma,
-						start, end, &zap_work, details);
-
-			if (zap_work > 0) {
-				BUG_ON(start != end);
-				break;
-			}
-
-			tlb_finish_mmu(*tlbp, tlb_start, start);
-
-			if (need_resched() ||
-				(i_mmap_lock && need_lockbreak(i_mmap_lock))) {
-				if (i_mmap_lock) {
-					*tlbp = NULL;
-					goto out;
-				}
-				cond_resched();
-			}
-
-			*tlbp = tlb_gather_mmu(vma->vm_mm, fullmm);
-			tlb_start_valid = 0;
-			zap_work = ZAP_BLOCK_SIZE;
+		if (unlikely(is_vm_hugetlb_page(vma)))
+			unmap_hugepage_range(vma, start, end);
+		else
+			unmap_page_range(tlb, vma, start, end, details);
+
+		if (need_resched() ||
+			(i_mmap_lock && need_lockbreak(i_mmap_lock))) {
+			if (i_mmap_lock)
+				return end;
+			cond_resched();
 		}
 	}
-out:
-	return start;	/* which is now the end (or restart) address */
+	return end_addr;
 }
 
 /**
@@ -868,16 +951,18 @@ unsigned long zap_page_range(struct vm_a
 		unsigned long size, struct zap_details *details)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct mmu_gather *tlb;
+	struct mmu_gather tlb;
 	unsigned long end = address + size;
 	unsigned long nr_accounted = 0;
 
 	lru_add_drain();
-	tlb = tlb_gather_mmu(mm, 0);
-	update_hiwater_rss(mm);
+	update_hiwater_rss(mm); /* XXX: needs preempt disabled? */
+
+	tlb_init_mmu(&tlb, mm, 0);
 	end = unmap_vmas(&tlb, vma, address, end, &nr_accounted, details);
-	if (tlb)
-		tlb_finish_mmu(tlb, address, end);
+	tlb_flush_mmu(&tlb, address, end);
+	tlb_free_page_range(&tlb, vma, address, end);
+	tlb_finish_mmu(&tlb, address, end);
 	return end;
 }
 
Index: linux-2.6/include/asm-generic/tlb.h
===================================================================
--- linux-2.6.orig/include/asm-generic/tlb.h
+++ linux-2.6/include/asm-generic/tlb.h
@@ -14,56 +14,33 @@
 #define _ASM_GENERIC__TLB_H
 
 #include <linux/config.h>
+#include <linux/list.h>
+#include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/pagevec.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
-/*
- * For UP we don't need to worry about TLB flush
- * and page free order so much..
- */
-#ifdef CONFIG_SMP
-  #ifdef ARCH_FREE_PTR_NR
-    #define FREE_PTR_NR   ARCH_FREE_PTR_NR
-  #else
-    #define FREE_PTE_NR	506
-  #endif
-  #define tlb_fast_mode(tlb) ((tlb)->nr == ~0U)
-#else
-  #define FREE_PTE_NR	1
-  #define tlb_fast_mode(tlb) 1
-#endif
-
 /* struct mmu_gather is an opaque type used by the mm code for passing around
- * any data needed by arch specific code for tlb_remove_page.
+ * any data needed by arch specific code for removing tlb translations.
  */
 struct mmu_gather {
+	struct pagevec		pvec;
 	struct mm_struct	*mm;
-	unsigned int		nr;	/* set to ~0U means fast mode */
-	unsigned int		need_flush;/* Really unmapped some ptes? */
+	unsigned int		need_flush;
 	unsigned int		fullmm; /* non-zero means full mm flush */
-	struct page *		pages[FREE_PTE_NR];
 };
 
-/* Users of the generic TLB shootdown code must declare this storage space. */
-DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 /* tlb_gather_mmu
  *	Return a pointer to an initialized struct mmu_gather.
  */
-static inline struct mmu_gather *
-tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
+static inline void
+tlb_init_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+				unsigned int full_mm_flush)
 {
-	struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
-
 	tlb->mm = mm;
-
-	/* Use fast mode if only one CPU is online */
-	tlb->nr = num_online_cpus() > 1 ? 0U : ~0U;
-
+	tlb->need_flush = 0;
 	tlb->fullmm = full_mm_flush;
-
-	return tlb;
 }
 
 static inline void
@@ -73,10 +50,6 @@ tlb_flush_mmu(struct mmu_gather *tlb, un
 		return;
 	tlb->need_flush = 0;
 	tlb_flush(tlb);
-	if (!tlb_fast_mode(tlb)) {
-		free_pages_and_swap_cache(tlb->pages, tlb->nr);
-		tlb->nr = 0;
-	}
 }
 
 /* tlb_finish_mmu
@@ -86,29 +59,10 @@ tlb_flush_mmu(struct mmu_gather *tlb, un
 static inline void
 tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
-	tlb_flush_mmu(tlb, start, end);
+	BUG_ON(tlb->need_flush);
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
-
-	put_cpu_var(mmu_gathers);
-}
-
-/* tlb_remove_page
- *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
- *	handling the additional races in SMP caused by other CPUs caching valid
- *	mappings in their TLBs.
- */
-static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
-{
-	tlb->need_flush = 1;
-	if (tlb_fast_mode(tlb)) {
-		free_page_and_swap_cache(page);
-		return;
-	}
-	tlb->pages[tlb->nr++] = page;
-	if (tlb->nr >= FREE_PTE_NR)
-		tlb_flush_mmu(tlb, 0, 0);
 }
 
 /**
@@ -118,30 +72,27 @@ static inline void tlb_remove_page(struc
  * later optimise away the tlb invalidate.   This helps when userspace is
  * unmapping already-unmapped pages, which happens quite a lot.
  */
-#define tlb_remove_tlb_entry(tlb, ptep, address)		\
+#define tlb_remove_pte_entry(tlb, ptep, address)		\
 	do {							\
 		tlb->need_flush = 1;				\
-		__tlb_remove_tlb_entry(tlb, ptep, address);	\
+		__tlb_remove_pte_entry(tlb, ptep, address);	\
 	} while (0)
 
-#define pte_free_tlb(tlb, ptep)					\
+#define tlb_remove_pmd_entry(tlb, pmdp)				\
 	do {							\
-		tlb->need_flush = 1;				\
-		__pte_free_tlb(tlb, ptep);			\
+		__tlb_remove_pmd_entry(tlb, pmdp);		\
 	} while (0)
 
 #ifndef __ARCH_HAS_4LEVEL_HACK
-#define pud_free_tlb(tlb, pudp)					\
+#define tlb_remove_pgd_entry(tlb, pgdp)				\
 	do {							\
-		tlb->need_flush = 1;				\
-		__pud_free_tlb(tlb, pudp);			\
+		__tlb_remove_pgd_entry(tlb, pgdp);		\
 	} while (0)
 #endif
 
-#define pmd_free_tlb(tlb, pmdp)					\
+#define tlb_remove_pud_entry(tlb, pudp)				\
 	do {							\
-		tlb->need_flush = 1;				\
-		__pmd_free_tlb(tlb, pmdp);			\
+		__tlb_remove_pud_entry(tlb, pudp);		\
 	} while (0)
 
 #define tlb_migrate_finish(mm) do {} while (0)
Index: linux-2.6/include/asm-i386/pgalloc.h
===================================================================
--- linux-2.6.orig/include/asm-i386/pgalloc.h
+++ linux-2.6/include/asm-i386/pgalloc.h
@@ -33,15 +33,12 @@ static inline void pte_free(struct page 
 }
 
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
-
 #ifdef CONFIG_X86_PAE
 /*
  * In the PAE case we free the pmds as part of the pgd.
  */
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)			do { } while (0)
-#define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pud_populate(mm, pmd, pte)	BUG()
 #endif
 
Index: linux-2.6/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-i386/pgtable.h
+++ linux-2.6/include/asm-i386/pgtable.h
@@ -211,6 +211,7 @@ extern unsigned long pg0[];
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define pmd_unmap(xp)	do { set_pmd(xp, __pmd(pmd_val(*xp)&(~_PAGE_PRESENT))); } while (0)
 
 
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
@@ -220,6 +221,7 @@ extern unsigned long pg0[];
  * Undefined behaviour if not..
  */
 #define __LARGE_PTE (_PAGE_PSE | _PAGE_PRESENT)
+
 static inline int pte_user(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_read(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
@@ -231,7 +233,9 @@ static inline int pte_huge(pte_t pte)		{
  * The following only works if pte_present() is not true.
  */
 static inline int pte_file(pte_t pte)		{ return (pte).pte_low & _PAGE_FILE; }
+static inline int pte_gather(pte_t pte)		{ return (((pte).pte_low & (_PAGE_FILE|_PAGE_PROTNONE|_PAGE_PRESENT)) == (_PAGE_FILE|_PAGE_PROTNONE)); }
 
+static inline pte_t pte_mknotpresent(pte_t pte)	{ (pte).pte_low &= ~_PAGE_PRESENT; return pte; }
 static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
 static inline pte_t pte_exprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ (pte).pte_low &= ~_PAGE_DIRTY; return pte; }
@@ -243,6 +247,7 @@ static inline pte_t pte_mkdirty(pte_t pt
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= __LARGE_PTE; return pte; }
+static inline pte_t pte_mkgather(pte_t pte)	{ (pte).pte_low |= (_PAGE_FILE|_PAGE_PROTNONE); (pte).pte_low &= ~_PAGE_PRESENT; return pte; }
 
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c
+++ linux-2.6/mm/mmap.c
@@ -1653,17 +1653,22 @@ static void unmap_region(struct mm_struc
 		unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *next = prev? prev->vm_next: mm->mmap;
-	struct mmu_gather *tlb;
+	struct mmu_gather tlb;
 	unsigned long nr_accounted = 0;
 
 	lru_add_drain();
-	tlb = tlb_gather_mmu(mm, 0);
+	tlb_init_mmu(&tlb, mm, 0);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, vma, start, end, &nr_accounted, NULL);
+	unmap_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
+				 next? next->vm_start: 0, 0);
+	tlb_flush_mmu(&tlb, start, end);
+	tlb_free_page_range(&tlb, vma, start, end);
+	unmap_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
+				 next? next->vm_start: 0, 1);
+	tlb_finish_mmu(&tlb, start, end);
+
 	vm_unacct_memory(nr_accounted);
-	free_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
-				 next? next->vm_start: 0);
-	tlb_finish_mmu(tlb, start, end);
 }
 
 /*
@@ -1932,20 +1937,25 @@ EXPORT_SYMBOL(do_brk);
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
-	struct mmu_gather *tlb;
+	struct mmu_gather tlb;
 	struct vm_area_struct *vma = mm->mmap;
 	unsigned long nr_accounted = 0;
 	unsigned long end;
 
 	lru_add_drain();
 	flush_cache_mm(mm);
-	tlb = tlb_gather_mmu(mm, 1);
+
+	tlb_init_mmu(&tlb, mm, 1);
 	/* Don't update_hiwater_rss(mm) here, do_exit already did */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	end = unmap_vmas(&tlb, vma, 0, -1, &nr_accounted, NULL);
+	unmap_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0, 0);
+	tlb_flush_mmu(&tlb, 0, end);
+	tlb_free_page_range(&tlb, vma, 0, -1);
+	unmap_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0, 1);
+	tlb_finish_mmu(&tlb, 0, end);
+
 	vm_unacct_memory(nr_accounted);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
-	tlb_finish_mmu(tlb, 0, end);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
Index: linux-2.6/arch/i386/mm/init.c
===================================================================
--- linux-2.6.orig/arch/i386/mm/init.c
+++ linux-2.6/arch/i386/mm/init.c
@@ -44,7 +44,6 @@
 
 unsigned int __VMALLOC_RESERVE = 128 << 20;
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
 
 static int noinline do_test_wp_bit(void);
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -697,14 +697,18 @@ struct zap_details {
 struct page *vm_normal_page(struct vm_area_struct *, unsigned long, pte_t);
 unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *);
-unsigned long unmap_vmas(struct mmu_gather **tlb,
+unsigned long unmap_vmas(struct mmu_gather *tlb,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *);
-void free_pgd_range(struct mmu_gather **tlb, unsigned long addr,
-		unsigned long end, unsigned long floor, unsigned long ceiling);
-void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *start_vma,
-		unsigned long floor, unsigned long ceiling);
+void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
+		unsigned long end, unsigned long floor, unsigned long ceiling,
+		int free);
+void unmap_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
+		unsigned long floor, unsigned long ceiling, int free);
+void tlb_free_page_range(struct mmu_gather *tlb,
+		struct vm_area_struct *start_vma, unsigned long start_addr,
+		 unsigned long end_addr);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
 int zeromap_page_range(struct vm_area_struct *vma, unsigned long from,
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -50,6 +50,7 @@ static inline void mapping_set_gfp_mask(
 #define page_cache_get(page)		get_page(page)
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
+void release_pages_list_nonlru(struct list_head *pages, int cold);
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h
+++ linux-2.6/include/linux/swap.h
@@ -230,8 +230,7 @@ extern void delete_from_swap_cache(struc
 extern int move_to_swap_cache(struct page *, swp_entry_t);
 extern int move_from_swap_cache(struct page *, unsigned long,
 		struct address_space *);
-extern void free_page_and_swap_cache(struct page *);
-extern void free_pages_and_swap_cache(struct page **, int);
+extern void free_swap_cache(struct page *);
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
@@ -286,10 +285,8 @@ static inline void disable_swap_token(vo
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
 /* only sparc can not include linux/pagemap.h in this file
  * so leave page_cache_release and release_pages undeclared... */
-#define free_page_and_swap_cache(page) \
-	page_cache_release(page)
-#define free_pages_and_swap_cache(pages, nr) \
-	release_pages((pages), (nr), 0);
+
+#define free_swap_cache(page)			/*NOTHING*/
 
 #define show_swap_cache_info()			/*NOTHING*/
 #define free_swap_and_cache(swp)		/*NOTHING*/
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -283,6 +283,26 @@ void release_pages(struct page **pages, 
 	pagevec_free(&pages_to_free);
 }
 
+void release_pages_list_nonlru(struct list_head *pages, int cold)
+{
+	struct pagevec pages_to_free;
+
+	pagevec_init(&pages_to_free, cold);
+	while (!list_empty(pages)) {
+		struct page *page = list_entry(pages->next, struct page, lru);
+		list_del(&page->lru);
+
+		if (!put_page_testzero(page))
+			continue;
+
+		if (!pagevec_add(&pages_to_free, page)) {
+			__pagevec_free(&pages_to_free);
+			pagevec_reinit(&pages_to_free);
+		}
+	}
+	pagevec_free(&pages_to_free);
+}
+
 /*
  * The pages which we're about to release may be in the deferred lru-addition
  * queues.  That would prevent them from really being freed right now.  That's
@@ -302,6 +322,14 @@ void __pagevec_release(struct pagevec *p
 
 EXPORT_SYMBOL(__pagevec_release);
 
+void __pagevec_release_and_swapcache(struct pagevec *pvec)
+{
+	int i;
+	for (i = 0; i < pagevec_count(pvec); i++)
+		free_swap_cache(pvec->pages[i]);
+	__pagevec_release(pvec);
+}
+
 /*
  * pagevec_release() for pages which are known to not be on the LRU
  *
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -14,7 +14,6 @@
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/backing-dev.h>
-#include <linux/pagevec.h>
 
 #include <asm/pgtable.h>
 
@@ -250,7 +249,7 @@ int move_from_swap_cache(struct page *pa
  * exclusive_swap_page() _with_ the lock. 
  * 					- Marcelo
  */
-static inline void free_swap_cache(struct page *page)
+void free_swap_cache(struct page *page)
 {
 	if (PageSwapCache(page) && !TestSetPageLocked(page)) {
 		remove_exclusive_swap_page(page);
@@ -258,37 +257,6 @@ static inline void free_swap_cache(struc
 	}
 }
 
-/* 
- * Perform a free_page(), also freeing any swap cache associated with
- * this page if it is the last user of the page.
- */
-void free_page_and_swap_cache(struct page *page)
-{
-	free_swap_cache(page);
-	page_cache_release(page);
-}
-
-/*
- * Passed an array of pages, drop them all from swapcache and then release
- * them.  They are removed from the LRU and freed if this is their last use.
- */
-void free_pages_and_swap_cache(struct page **pages, int nr)
-{
-	struct page **pagep = pages;
-
-	lru_add_drain();
-	while (nr) {
-		int todo = min(nr, PAGEVEC_SIZE);
-		int i;
-
-		for (i = 0; i < todo; i++)
-			free_swap_cache(pagep[i]);
-		release_pages(pagep, todo, 0);
-		pagep += todo;
-		nr -= todo;
-	}
-}
-
 /*
  * Lookup a swap entry in the swap cache. A found page will be returned
  * unlocked and with its refcount incremented - we rely on the kernel
Index: linux-2.6/include/asm-generic/pgtable-nopmd.h
===================================================================
--- linux-2.6.orig/include/asm-generic/pgtable-nopmd.h
+++ linux-2.6/include/asm-generic/pgtable-nopmd.h
@@ -37,6 +37,7 @@ static inline void pud_clear(pud_t *pud)
  * but the define is needed for a generic inline function.)
  */
 #define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
+static inline void pud_unmap(pud_t *pud) { }
 
 static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
 {
@@ -55,7 +56,7 @@ static inline pmd_t * pmd_offset(pud_t *
  */
 #define pmd_alloc_one(mm, address)		NULL
 #define pmd_free(x)				do { } while (0)
-#define __pmd_free_tlb(tlb, x)			do { } while (0)
+#define __tlb_remove_pmd_entry(tlb, x)		do { } while (0)
 
 #undef  pmd_addr_end
 #define pmd_addr_end(addr, end)			(end)
Index: linux-2.6/include/asm-generic/pgtable-nopud.h
===================================================================
--- linux-2.6.orig/include/asm-generic/pgtable-nopud.h
+++ linux-2.6/include/asm-generic/pgtable-nopud.h
@@ -34,6 +34,7 @@ static inline void pgd_clear(pgd_t *pgd)
  * but the define is needed for a generic inline function.)
  */
 #define set_pgd(pgdptr, pgdval)			set_pud((pud_t *)(pgdptr), (pud_t) { pgdval })
+static inline void pgd_unmap(pgd_t *pgd) { }
 
 static inline pud_t * pud_offset(pgd_t * pgd, unsigned long address)
 {
@@ -52,7 +53,7 @@ static inline pud_t * pud_offset(pgd_t *
  */
 #define pud_alloc_one(mm, address)		NULL
 #define pud_free(x)				do { } while (0)
-#define __pud_free_tlb(tlb, x)			do { } while (0)
+#define __tlb_remove_pud_entry(tlb, x)		do { } while (0)
 
 #undef  pud_addr_end
 #define pud_addr_end(addr, end)			(end)
Index: linux-2.6/include/asm-powerpc/pgtable-4k.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/pgtable-4k.h
+++ linux-2.6/include/asm-powerpc/pgtable-4k.h
@@ -82,6 +82,7 @@
 #define pgd_present(pgd)	(pgd_val(pgd) != 0)
 #define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0)
 #define pgd_page(pgd)		(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define pgd_unmap(pgd)		do { } while (0)
 
 #define pud_offset(pgdp, addr)	\
   (((pud_t *) pgd_page(*(pgdp))) + \
Index: linux-2.6/include/asm-powerpc/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/pgtable.h
+++ linux-2.6/include/asm-powerpc/pgtable.h
@@ -195,6 +195,7 @@ static inline pte_t pfn_pte(unsigned lon
 #define	pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0)
 #define pmd_page_kernel(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
 #define pmd_page(pmd)		virt_to_page(pmd_page_kernel(pmd))
+#define	pmd_unmap(pmdp)		do { } while (0)
 
 #define pud_set(pudp, pudval)	(pud_val(*(pudp)) = (pudval))
 #define pud_none(pud)		(!pud_val(pud))
@@ -202,6 +203,7 @@ static inline pte_t pfn_pte(unsigned lon
 #define pud_present(pud)	(pud_val(pud) != 0)
 #define pud_clear(pudp)		(pud_val(*(pudp)) = 0)
 #define pud_page(pud)		(pud_val(pud) & ~PUD_MASKED_BITS)
+#define	pud_unmap(pudp)		do { } while (0)
 
 #define pgd_set(pgdp, pudp)	({pgd_val(*(pgdp)) = (unsigned long)(pudp);})
 
Index: linux-2.6/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.orig/include/asm-i386/pgtable-3level.h
+++ linux-2.6/include/asm-i386/pgtable-3level.h
@@ -73,6 +73,7 @@ static inline void set_pte(pte_t *ptep, 
  * this erratum.
  */
 static inline void pud_clear (pud_t * pud) { }
+static inline void pud_unmap (pud_t * pud) { }
 
 #define pud_page(pud) \
 ((struct page *) __va(pud_val(pud) & PAGE_MASK))
@@ -150,6 +151,6 @@ static inline pmd_t pfn_pmd(unsigned lon
 #define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t){ 0, (x).val })
 
-#define __pmd_free_tlb(tlb, x)		do { } while (0)
+#define __tlb_remove_pmd_entry(tlb, x)	do { } while (0)
 
 #endif /* _I386_PGTABLE_3LEVEL_H */
Index: linux-2.6/include/asm-i386/tlb.h
===================================================================
--- linux-2.6.orig/include/asm-i386/tlb.h
+++ linux-2.6/include/asm-i386/tlb.h
@@ -7,7 +7,11 @@
  */
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
+#define __tlb_remove_pte_entry(tlb, ptep, address) do { } while (0)
+#define __tlb_remove_pgd_entry(tlb, pgdp)		\
+do {							\
+	tlb->need_flush = 1;				\
+} while (0)
 
 /*
  * .. because we flush the whole mm when it
Index: linux-2.6/include/linux/pagevec.h
===================================================================
--- linux-2.6.orig/include/linux/pagevec.h
+++ linux-2.6/include/linux/pagevec.h
@@ -21,6 +21,7 @@ struct pagevec {
 };
 
 void __pagevec_release(struct pagevec *pvec);
+void __pagevec_release_and_swapcache(struct pagevec *pvec);
 void __pagevec_release_nonlru(struct pagevec *pvec);
 void __pagevec_free(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
@@ -69,6 +70,12 @@ static inline void pagevec_release(struc
 		__pagevec_release(pvec);
 }
 
+static inline void pagevec_release_and_swapcache(struct pagevec *pvec)
+{
+	if (pagevec_count(pvec))
+		__pagevec_release_and_swapcache(pvec);
+}
+
 static inline void pagevec_release_nonlru(struct pagevec *pvec)
 {
 	if (pagevec_count(pvec))
