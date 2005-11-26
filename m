Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVKZRnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVKZRnn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 12:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVKZRnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 12:43:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9613 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932278AbVKZRnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 12:43:42 -0500
Date: Sat, 26 Nov 2005 12:43:14 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, zwane@arm.linux.org.uk
Subject: [PATCH] temporarily disable swap token on memory pressure 
Message-ID: <Pine.LNX.4.63.0511261241500.32217@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some users (hi Zwane) have seen a problem when running a workload
that eats nearly all of physical memory - th system does an OOM
kill, even when there is still a lot of swap free.

The problem appears to be a very big task that is holding the swap
token, and the VM has a very hard time finding any other page in
the system that is swappable.  

Instead of ignoring the swap token when sc->priority reaches 0,
we could simply take the swap token away from the memory hog and
make sure we don't give it back to the memory hog for a few seconds.

This patch resolves the problem Zwane ran into.

This patch is against yesterday's git head.

Signed-off-by: Rik van Riel <riel@redhat.com>

Index: linux-2.6-token/mm/thrash.c
===================================================================
--- linux-2.6-token.orig/mm/thrash.c
+++ linux-2.6-token/mm/thrash.c
@@ -57,14 +57,17 @@ void grab_swap_token(void)
 	/* We have the token. Let others know we still need it. */
 	if (has_swap_token(current->mm)) {
 		current->mm->recent_pagein = 1;
+		if (unlikely(!swap_token_default_timeout))
+			disable_swap_token();
 		return;
 	}
 
 	if (time_after(jiffies, swap_token_check)) {
 
-		/* Can't get swapout protection if we exceed our RSS limit. */
-		// if (current->mm->rss > current->mm->rlimit_rss)
-		//	return;
+		if (!swap_token_default_timeout) {
+			swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
+			return;
+		}
 
 		/* ... or if we recently held the token. */
 		if (time_before(jiffies, current->mm->swap_token_time))
@@ -95,6 +98,7 @@ void __put_swap_token(struct mm_struct *
 {
 	spin_lock(&swap_token_lock);
 	if (likely(mm == swap_token_mm)) {
+		mm->swap_token_time = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
 		swap_token_mm = &init_mm;
 		swap_token_check = jiffies;
 	}
Index: linux-2.6-token/include/linux/rmap.h
===================================================================
--- linux-2.6-token.orig/include/linux/rmap.h
+++ linux-2.6-token/include/linux/rmap.h
@@ -89,7 +89,7 @@ static inline void page_dup_rmap(struct 
 /*
  * Called from mm/vmscan.c to handle paging out
  */
-int page_referenced(struct page *, int is_locked, int ignore_token);
+int page_referenced(struct page *, int is_locked);
 int try_to_unmap(struct page *);
 
 /*
@@ -109,7 +109,7 @@ unsigned long page_address_in_vma(struct
 #define anon_vma_prepare(vma)	(0)
 #define anon_vma_link(vma)	do {} while (0)
 
-#define page_referenced(page,l,i) TestClearPageReferenced(page)
+#define page_referenced(page,l) TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
 
 #endif	/* CONFIG_MMU */
Index: linux-2.6-token/include/linux/swap.h
===================================================================
--- linux-2.6-token.orig/include/linux/swap.h
+++ linux-2.6-token/include/linux/swap.h
@@ -239,6 +239,11 @@ static inline void put_swap_token(struct
 		__put_swap_token(mm);
 }
 
+static inline void disable_swap_token(void)
+{
+	put_swap_token(swap_token_mm);
+}
+
 #else /* CONFIG_SWAP */
 
 #define total_swap_pages			0
Index: linux-2.6-token/mm/vmscan.c
===================================================================
--- linux-2.6-token.orig/mm/vmscan.c
+++ linux-2.6-token/mm/vmscan.c
@@ -407,7 +407,7 @@ static int shrink_list(struct list_head 
 		if (PageWriteback(page))
 			goto keep_locked;
 
-		referenced = page_referenced(page, 1, sc->priority <= 0);
+		referenced = page_referenced(page, 1);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
 			goto activate_locked;
@@ -756,7 +756,7 @@ refill_inactive_zone(struct zone *zone, 
 		if (page_mapped(page)) {
 			if (!reclaim_mapped ||
 			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0, sc->priority <= 0)) {
+			    page_referenced(page, 0)) {
 				list_add(&page->lru, &l_active);
 				continue;
 			}
@@ -960,6 +960,8 @@ int try_to_free_pages(struct zone **zone
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
 		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
+		if (!priority)
+			disable_swap_token();
 		shrink_caches(zones, &sc);
 		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
@@ -1056,6 +1058,10 @@ loop_again:
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
 
+		/* The swap token gets in the way of swapout... */
+		if (!priority)
+			disable_swap_token();
+
 		all_zones_ok = 1;
 
 		if (nr_pages == 0) {
@@ -1360,6 +1366,7 @@ int zone_reclaim(struct zone *zone, gfp_
 	sc.nr_reclaimed = 0;
 	/* scan at the highest priority */
 	sc.priority = 0;
+	disable_swap_token();
 
 	if (nr_pages > SWAP_CLUSTER_MAX)
 		sc.swap_cluster_max = nr_pages;
Index: linux-2.6-token/mm/rmap.c
===================================================================
--- linux-2.6-token.orig/mm/rmap.c
+++ linux-2.6-token/mm/rmap.c
@@ -292,7 +292,7 @@ pte_t *page_check_address(struct page *p
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
 static int page_referenced_one(struct page *page,
-	struct vm_area_struct *vma, unsigned int *mapcount, int ignore_token)
+	struct vm_area_struct *vma, unsigned int *mapcount)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -313,7 +313,7 @@ static int page_referenced_one(struct pa
 
 	/* Pretend the page is referenced if the task has the
 	   swap token and is in the middle of a page fault. */
-	if (mm != current->mm && !ignore_token && has_swap_token(mm) &&
+	if (mm != current->mm && has_swap_token(mm) &&
 			rwsem_is_locked(&mm->mmap_sem))
 		referenced++;
 
@@ -323,7 +323,7 @@ out:
 	return referenced;
 }
 
-static int page_referenced_anon(struct page *page, int ignore_token)
+static int page_referenced_anon(struct page *page)
 {
 	unsigned int mapcount;
 	struct anon_vma *anon_vma;
@@ -336,8 +336,7 @@ static int page_referenced_anon(struct p
 
 	mapcount = page_mapcount(page);
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		referenced += page_referenced_one(page, vma, &mapcount,
-							ignore_token);
+		referenced += page_referenced_one(page, vma, &mapcount);
 		if (!mapcount)
 			break;
 	}
@@ -356,7 +355,7 @@ static int page_referenced_anon(struct p
  *
  * This function is only called from page_referenced for object-based pages.
  */
-static int page_referenced_file(struct page *page, int ignore_token)
+static int page_referenced_file(struct page *page)
 {
 	unsigned int mapcount;
 	struct address_space *mapping = page->mapping;
@@ -394,8 +393,7 @@ static int page_referenced_file(struct p
 			referenced++;
 			break;
 		}
-		referenced += page_referenced_one(page, vma, &mapcount,
-							ignore_token);
+		referenced += page_referenced_one(page, vma, &mapcount);
 		if (!mapcount)
 			break;
 	}
@@ -412,13 +410,10 @@ static int page_referenced_file(struct p
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of ptes which referenced the page.
  */
-int page_referenced(struct page *page, int is_locked, int ignore_token)
+int page_referenced(struct page *page, int is_locked)
 {
 	int referenced = 0;
 
-	if (!swap_token_default_timeout)
-		ignore_token = 1;
-
 	if (page_test_and_clear_young(page))
 		referenced++;
 
@@ -427,15 +422,14 @@ int page_referenced(struct page *page, i
 
 	if (page_mapped(page) && page->mapping) {
 		if (PageAnon(page))
-			referenced += page_referenced_anon(page, ignore_token);
+			referenced += page_referenced_anon(page);
 		else if (is_locked)
-			referenced += page_referenced_file(page, ignore_token);
+			referenced += page_referenced_file(page);
 		else if (TestSetPageLocked(page))
 			referenced++;
 		else {
 			if (page->mapping)
-				referenced += page_referenced_file(page,
-								ignore_token);
+				referenced += page_referenced_file(page);
 			unlock_page(page);
 		}
 	}
