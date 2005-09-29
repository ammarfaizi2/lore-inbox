Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVI2SRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVI2SRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVI2SRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:17:18 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:42573 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932320AbVI2SQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:16:48 -0400
Message-Id: <20050929181642.481684197@twins>
References: <20050929180845.910895444@twins>
Date: Thu, 29 Sep 2005 20:08:51 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: [PATCH 6/7] CART - an advanced page replacement policy
Content-Disposition: inline; filename=cart-use-once.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch started live as a rework of the use-once code by
Rik van Riel. I (ab)used it to remove the use-once code.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 mm/filemap.c  |   10 +---------
 mm/shmem.c    |    7 ++-----
 mm/swap.c     |   27 +--------------------------
 mm/swapfile.c |    4 ++--
 mm/vmscan.c   |   25 ++-----------------------
 5 files changed, 8 insertions(+), 65 deletions(-)

Index: linux-2.6-git/mm/filemap.c
===================================================================
--- linux-2.6-git.orig/mm/filemap.c
+++ linux-2.6-git/mm/filemap.c
@@ -723,7 +723,6 @@ void do_generic_mapping_read(struct addr
 	unsigned long offset;
 	unsigned long last_index;
 	unsigned long next_index;
-	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
 	int error;
@@ -732,7 +731,6 @@ void do_generic_mapping_read(struct addr
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
-	prev_index = ra.prev_page;
 	last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
@@ -779,13 +777,7 @@ page_ok:
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
-		/*
-		 * When (part of) the same page is read multiple times
-		 * in succession, only mark it as accessed the first time.
-		 */
-		if (prev_index != index)
-			mark_page_accessed(page);
-		prev_index = index;
+		mark_page_accessed(page);
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
Index: linux-2.6-git/mm/shmem.c
===================================================================
--- linux-2.6-git.orig/mm/shmem.c
+++ linux-2.6-git/mm/shmem.c
@@ -1500,11 +1500,8 @@ static void do_shmem_file_read(struct fi
 			 */
 			if (mapping_writably_mapped(mapping))
 				flush_dcache_page(page);
-			/*
-			 * Mark the page accessed if we read the beginning.
-			 */
-			if (!offset)
-				mark_page_accessed(page);
+
+			mark_page_accessed(page);
 		} else
 			page = ZERO_PAGE(0);
 
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -97,37 +97,12 @@ int rotate_reclaimable_page(struct page 
 }
 
 /*
- * FIXME: speed this up?
- */
-void fastcall activate_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-
-	spin_lock_irq(&zone->lru_lock);
-	if (PageLRU(page) && !PageActive(page)) {
-		del_page_from_inactive_list(zone, page);
-		SetPageActive(page);
-		add_page_to_active_list(zone, page);
-		inc_page_state(pgactivate);
-	}
-	spin_unlock_irq(&zone->lru_lock);
-}
-
-/*
  * Mark a page as having seen activity.
- *
- * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
+	if (!PageReferenced(page))
 		SetPageReferenced(page);
-	}
 }
 
 EXPORT_SYMBOL(mark_page_accessed);
Index: linux-2.6-git/mm/swapfile.c
===================================================================
--- linux-2.6-git.orig/mm/swapfile.c
+++ linux-2.6-git/mm/swapfile.c
@@ -408,7 +408,7 @@ static void unuse_pte(struct vm_area_str
 	 * Move the page to the active list so it is not
 	 * immediately swapped out again after swapon.
 	 */
-	activate_page(page);
+	SetPageReferenced(page);
 }
 
 static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
@@ -508,7 +508,7 @@ static int unuse_mm(struct mm_struct *mm
 		 * Activate page so shrink_cache is unlikely to unmap its
 		 * ptes while lock is dropped, so swapoff can make progress.
 		 */
-		activate_page(page);
+		SetPageReferenced(page);
 		unlock_page(page);
 		down_read(&mm->mmap_sem);
 		lock_page(page);
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -235,27 +235,6 @@ static int shrink_slab(unsigned long sca
 	return ret;
 }
 
-/* Called without lock on whether page is mapped, so answer is unstable */
-static inline int page_mapping_inuse(struct page *page)
-{
-	struct address_space *mapping;
-
-	/* Page is in somebody's page tables. */
-	if (page_mapped(page))
-		return 1;
-
-	/* Be more reluctant to reclaim swapcache than pagecache */
-	if (PageSwapCache(page))
-		return 1;
-
-	mapping = page_mapping(page);
-	if (!mapping)
-		return 0;
-
-	/* File is mmap'd by somebody? */
-	return mapping_mapped(mapping);
-}
-
 static inline int is_page_cache_freeable(struct page *page)
 {
 	return page_count(page) - !!PagePrivate(page) == 2;
@@ -408,8 +387,8 @@ static int shrink_list(struct list_head 
 			goto keep_locked;
 
 		referenced = page_referenced(page, 1, sc->priority <= 0);
-		/* In active use or really unfreeable?  Activate it. */
-		if (referenced && page_mapping_inuse(page))
+
+		if (referenced)
 			goto activate_locked;
 
 #ifdef CONFIG_SWAP

--
