Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVIYQIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVIYQIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVIYQIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:08:50 -0400
Received: from silver.veritas.com ([143.127.12.111]:16311 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932244AbVIYQIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:08:49 -0400
Date: Sun, 25 Sep 2005 17:08:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 17/21] mm: batch updating mm_counters
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251707171.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 16:08:49.0618 (UTC) FILETIME=[6A618B20:01C5C1EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tlb_finish_mmu used to batch zap_pte_range's update of mm rss, which may
be worthwhile if the mm is contended, and would reduce atomic operations
if the counts were atomic.  Let zap_pte_range now batch its updates to
file_rss and anon_rss, per page-table in case we drop the lock outside;
and copy_pte_range batch them too.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   47 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 15 deletions(-)

--- mm16/mm/memory.c	2005-09-24 19:29:53.000000000 +0100
+++ mm17/mm/memory.c	2005-09-24 19:30:07.000000000 +0100
@@ -332,6 +332,16 @@ out:
 	return pte_offset_kernel(pmd, address);
 }
 
+static inline void add_mm_rss(struct mm_struct *mm, int file_rss, int anon_rss)
+{
+	if (file_rss)
+		add_mm_counter(mm, file_rss, file_rss);
+	if (anon_rss)
+		add_mm_counter(mm, anon_rss, anon_rss);
+}
+
+#define NO_RSS 2	/* Increment neither file_rss nor anon_rss */
+
 /*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
@@ -341,7 +351,7 @@ out:
  * but may be dropped within p[mg]d_alloc() and pte_alloc_map().
  */
 
-static inline void
+static inline int
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, unsigned long vm_flags,
 		unsigned long addr)
@@ -349,6 +359,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	pte_t pte = *src_pte;
 	struct page *page;
 	unsigned long pfn;
+	int anon = NO_RSS;
 
 	/* pte contains position in swap or file, so copy. */
 	if (unlikely(!pte_present(pte))) {
@@ -361,8 +372,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 				spin_unlock(&mmlist_lock);
 			}
 		}
-		set_pte_at(dst_mm, addr, dst_pte, pte);
-		return;
+		goto out_set_pte;
 	}
 
 	pfn = pte_pfn(pte);
@@ -375,10 +385,8 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	if (pfn_valid(pfn))
 		page = pfn_to_page(pfn);
 
-	if (!page || PageReserved(page)) {
-		set_pte_at(dst_mm, addr, dst_pte, pte);
-		return;
-	}
+	if (!page || PageReserved(page))
+		goto out_set_pte;
 
 	/*
 	 * If it's a COW mapping, write protect it both
@@ -397,12 +405,12 @@ copy_one_pte(struct mm_struct *dst_mm, s
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 	get_page(page);
-	if (PageAnon(page))
-		inc_mm_counter(dst_mm, anon_rss);
-	else
-		inc_mm_counter(dst_mm, file_rss);
-	set_pte_at(dst_mm, addr, dst_pte, pte);
 	page_dup_rmap(page);
+	anon = !!PageAnon(page);
+
+out_set_pte:
+	set_pte_at(dst_mm, addr, dst_pte, pte);
+	return anon;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -412,8 +420,10 @@ static int copy_pte_range(struct mm_stru
 	pte_t *src_pte, *dst_pte;
 	unsigned long vm_flags = vma->vm_flags;
 	int progress = 0;
+	int rss[NO_RSS+1], anon;
 
 again:
+	rss[1] = rss[0] = 0;
 	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
 	if (!dst_pte)
 		return -ENOMEM;
@@ -436,13 +446,16 @@ again:
 			progress++;
 			continue;
 		}
-		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
+		anon = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
+							vm_flags, addr);
+		rss[anon]++;
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 	spin_unlock(&src_mm->page_table_lock);
 
 	pte_unmap_nested(src_pte - 1);
 	pte_unmap(dst_pte - 1);
+	add_mm_rss(dst_mm, rss[0], rss[1]);
 	cond_resched_lock(&dst_mm->page_table_lock);
 	if (addr != end)
 		goto again;
@@ -533,6 +546,8 @@ static void zap_pte_range(struct mmu_gat
 				struct zap_details *details)
 {
 	pte_t *pte;
+	int file_rss = 0;
+	int anon_rss = 0;
 
 	pte = pte_offset_map(pmd, addr);
 	do {
@@ -576,13 +591,13 @@ static void zap_pte_range(struct mmu_gat
 				set_pte_at(tlb->mm, addr, pte,
 					   pgoff_to_pte(page->index));
 			if (PageAnon(page))
-				dec_mm_counter(tlb->mm, anon_rss);
+				anon_rss++;
 			else {
 				if (pte_dirty(ptent))
 					set_page_dirty(page);
 				if (pte_young(ptent))
 					mark_page_accessed(page);
-				dec_mm_counter(tlb->mm, file_rss);
+				file_rss++;
 			}
 			page_remove_rmap(page);
 			tlb_remove_page(tlb, page);
@@ -598,6 +613,8 @@ static void zap_pte_range(struct mmu_gat
 			free_swap_and_cache(pte_to_swp_entry(ptent));
 		pte_clear_full(tlb->mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+	add_mm_rss(tlb->mm, -file_rss, -anon_rss);
 	pte_unmap(pte - 1);
 }
 
