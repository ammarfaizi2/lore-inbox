Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932893AbWCVWdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893AbWCVWdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbWCVWdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:33:50 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:63154 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S932890AbWCVWdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:33:42 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223308.12658.70497.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 12/34] mm: page-replace-shrink.patch
Date: Wed, 22 Mar 2006 23:33:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Move the whole per zone shrinker to the policy files.
Share the shrink_list logic across policies since it doesn't know about
the policy internels anymore and exclusively deals with pageout.

API:
	void page_replace_shrink(struct zone *, struct scan_control *);

Shrink the specified zone.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    1 
 include/linux/mm_use_once_policy.h |    3 
 include/linux/swap.h               |    3 
 mm/useonce.c                       |  235 ++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                        |  238 -------------------------------------
 5 files changed, 241 insertions(+), 239 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -76,8 +76,5 @@ static inline int page_replace_activate(
 	return 1;
 }
 
-extern int isolate_lru_pages(int nr_to_scan, struct list_head *src,
-			     struct list_head *dst, int *scanned);
-
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_USEONCE_POLICY_H */
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -87,6 +87,7 @@ typedef enum {
 /* reclaim_t page_replace_reclaimable(struct page *); */
 /* int page_replace_activate(struct page *page); */
 extern void page_replace_reinsert(struct list_head *);
+extern void page_replace_shrink(struct zone *, struct scan_control *);
 
 #ifdef CONFIG_MIGRATION
 extern int page_replace_isolate(struct page *p);
Index: linux-2.6-git/include/linux/swap.h
===================================================================
--- linux-2.6-git.orig/include/linux/swap.h
+++ linux-2.6-git/include/linux/swap.h
@@ -7,6 +7,7 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/atomic.h>
 #include <asm/page.h>
@@ -171,6 +172,8 @@ extern void release_pages(struct page **
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, gfp_t);
 extern int shrink_all_memory(int);
+extern int shrink_list(struct list_head *, struct scan_control *);
+extern int should_reclaim_mapped(struct zone *, struct scan_control *);
 extern int vm_swappiness;
 
 #ifdef CONFIG_NUMA
Index: linux-2.6-git/mm/useonce.c
===================================================================
--- linux-2.6-git.orig/mm/useonce.c
+++ linux-2.6-git/mm/useonce.c
@@ -3,6 +3,9 @@
 #include <linux/swap.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
+#include <linux/writeback.h>
+#include <linux/buffer_head.h>	/* for try_to_release_page(),
+					buffer_heads_over_limit */
 
 /**
  * lru_cache_add: add a page to the page lists
@@ -135,8 +138,8 @@ void page_replace_reinsert(struct list_h
  *
  * returns how many pages were moved onto *@dst.
  */
-int isolate_lru_pages(int nr_to_scan, struct list_head *src,
-		      struct list_head *dst, int *scanned)
+static int isolate_lru_pages(int nr_to_scan, struct list_head *src,
+			     struct list_head *dst, int *scanned)
 {
 	int nr_taken = 0;
 	struct page *page;
@@ -167,3 +170,231 @@ int isolate_lru_pages(int nr_to_scan, st
 	return nr_taken;
 }
 
+/*
+ * shrink_cache() adds the number of pages reclaimed to sc->nr_reclaimed
+ */
+static void shrink_cache(struct zone *zone, struct scan_control *sc)
+{
+	LIST_HEAD(page_list);
+	struct pagevec pvec;
+	int max_scan = sc->nr_to_scan;
+
+	pagevec_init(&pvec, 1);
+
+	page_replace_add_drain();
+	spin_lock_irq(&zone->lru_lock);
+	while (max_scan > 0) {
+		struct page *page;
+		int nr_taken;
+		int nr_scan;
+		int nr_freed;
+
+		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
+					     &zone->inactive_list,
+					     &page_list, &nr_scan);
+		zone->nr_inactive -= nr_taken;
+		zone->pages_scanned += nr_scan;
+		spin_unlock_irq(&zone->lru_lock);
+
+		if (nr_taken == 0)
+			goto done;
+
+		max_scan -= nr_scan;
+		nr_freed = shrink_list(&page_list, sc);
+
+		local_irq_disable();
+		if (current_is_kswapd()) {
+			__mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
+			__mod_page_state(kswapd_steal, nr_freed);
+		} else
+			__mod_page_state_zone(zone, pgscan_direct, nr_scan);
+		__mod_page_state_zone(zone, pgsteal, nr_freed);
+
+		spin_lock(&zone->lru_lock);
+		/*
+		 * Put back any unfreeable pages.
+		 */
+		while (!list_empty(&page_list)) {
+			page = lru_to_page(&page_list);
+			if (TestSetPageLRU(page))
+				BUG();
+			list_del(&page->lru);
+			if (PageActive(page))
+				add_page_to_active_list(zone, page);
+			else
+				add_page_to_inactive_list(zone, page);
+			if (!pagevec_add(&pvec, page)) {
+				spin_unlock_irq(&zone->lru_lock);
+				__pagevec_release(&pvec);
+				spin_lock_irq(&zone->lru_lock);
+			}
+		}
+  	}
+	spin_unlock_irq(&zone->lru_lock);
+done:
+	pagevec_release(&pvec);
+}
+
+/*
+ * This moves pages from the active list to the inactive list.
+ *
+ * We move them the other way if the page is referenced by one or more
+ * processes, from rmap.
+ *
+ * If the pages are mostly unmapped, the processing is fast and it is
+ * appropriate to hold zone->lru_lock across the whole operation.  But if
+ * the pages are mapped, the processing is slow (page_referenced()) so we
+ * should drop zone->lru_lock around each page.  It's impossible to balance
+ * this, so instead we remove the pages from the LRU while processing them.
+ * It is safe to rely on PG_active against the non-LRU pages in here because
+ * nobody will play with that bit on a non-LRU page.
+ *
+ * The downside is that we have to touch page->_count against each page.
+ * But we had to alter page->flags anyway.
+ */
+static void
+refill_inactive_zone(struct zone *zone, struct scan_control *sc)
+{
+	int pgmoved;
+	int pgdeactivate = 0;
+	int pgscanned;
+	int nr_pages = sc->nr_to_scan;
+	LIST_HEAD(l_hold);	/* The pages which were snipped off */
+	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
+	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
+	struct page *page;
+	struct pagevec pvec;
+	int reclaim_mapped = 0;
+
+	if (unlikely(sc->may_swap))
+		reclaim_mapped = should_reclaim_mapped(zone, sc);
+
+	page_replace_add_drain();
+	spin_lock_irq(&zone->lru_lock);
+	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
+				    &l_hold, &pgscanned);
+	zone->pages_scanned += pgscanned;
+	zone->nr_active -= pgmoved;
+	spin_unlock_irq(&zone->lru_lock);
+
+	while (!list_empty(&l_hold)) {
+		cond_resched();
+		page = lru_to_page(&l_hold);
+		list_del(&page->lru);
+		if (page_mapped(page)) {
+			if (!reclaim_mapped ||
+			    (total_swap_pages == 0 && PageAnon(page)) ||
+			    page_referenced(page, 0)) {
+				list_add(&page->lru, &l_active);
+				continue;
+			}
+		}
+		list_add(&page->lru, &l_inactive);
+	}
+
+	pagevec_init(&pvec, 1);
+	pgmoved = 0;
+	spin_lock_irq(&zone->lru_lock);
+	while (!list_empty(&l_inactive)) {
+		page = lru_to_page(&l_inactive);
+		prefetchw_prev_lru_page(page, &l_inactive, flags);
+		if (TestSetPageLRU(page))
+			BUG();
+		if (!TestClearPageActive(page))
+			BUG();
+		list_move(&page->lru, &zone->inactive_list);
+		pgmoved++;
+		if (!pagevec_add(&pvec, page)) {
+			zone->nr_inactive += pgmoved;
+			spin_unlock_irq(&zone->lru_lock);
+			pgdeactivate += pgmoved;
+			pgmoved = 0;
+			if (buffer_heads_over_limit)
+				pagevec_strip(&pvec);
+			__pagevec_release(&pvec);
+			spin_lock_irq(&zone->lru_lock);
+		}
+	}
+	zone->nr_inactive += pgmoved;
+	pgdeactivate += pgmoved;
+	if (buffer_heads_over_limit) {
+		spin_unlock_irq(&zone->lru_lock);
+		pagevec_strip(&pvec);
+		spin_lock_irq(&zone->lru_lock);
+	}
+
+	pgmoved = 0;
+	while (!list_empty(&l_active)) {
+		page = lru_to_page(&l_active);
+		prefetchw_prev_lru_page(page, &l_active, flags);
+		if (TestSetPageLRU(page))
+			BUG();
+		BUG_ON(!PageActive(page));
+		list_move(&page->lru, &zone->active_list);
+		pgmoved++;
+		if (!pagevec_add(&pvec, page)) {
+			zone->nr_active += pgmoved;
+			pgmoved = 0;
+			spin_unlock_irq(&zone->lru_lock);
+			__pagevec_release(&pvec);
+			spin_lock_irq(&zone->lru_lock);
+		}
+	}
+	zone->nr_active += pgmoved;
+	spin_unlock(&zone->lru_lock);
+
+	__mod_page_state_zone(zone, pgrefill, pgscanned);
+	__mod_page_state(pgdeactivate, pgdeactivate);
+	local_irq_enable();
+
+	pagevec_release(&pvec);
+}
+
+/*
+ * This is a basic per-zone page freer.  Used by both kswapd and direct reclaim.
+ */
+void page_replace_shrink(struct zone *zone, struct scan_control *sc)
+{
+	unsigned long nr_active;
+	unsigned long nr_inactive;
+
+	atomic_inc(&zone->reclaim_in_progress);
+
+	/*
+	 * Add one to `nr_to_scan' just to make sure that the kernel will
+	 * slowly sift through the active list.
+	 */
+	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
+	nr_active = zone->nr_scan_active;
+	if (nr_active >= sc->swap_cluster_max)
+		zone->nr_scan_active = 0;
+	else
+		nr_active = 0;
+
+	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
+	nr_inactive = zone->nr_scan_inactive;
+	if (nr_inactive >= sc->swap_cluster_max)
+		zone->nr_scan_inactive = 0;
+	else
+		nr_inactive = 0;
+
+	while (nr_active || nr_inactive) {
+		if (nr_active) {
+			sc->nr_to_scan = min(nr_active,
+					(unsigned long)sc->swap_cluster_max);
+			nr_active -= sc->nr_to_scan;
+			refill_inactive_zone(zone, sc);
+		}
+
+		if (nr_inactive) {
+			sc->nr_to_scan = min(nr_inactive,
+					(unsigned long)sc->swap_cluster_max);
+			nr_inactive -= sc->nr_to_scan;
+			shrink_cache(zone, sc);
+		}
+	}
+
+	throttle_vm_writeout();
+
+	atomic_dec(&zone->reclaim_in_progress);
+}
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -336,7 +336,7 @@ cannot_free:
 /*
  * shrink_list adds the number of reclaimed pages to sc->nr_reclaimed
  */
-static int shrink_list(struct list_head *page_list, struct scan_control *sc)
+int shrink_list(struct list_head *page_list, struct scan_control *sc)
 {
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
@@ -913,71 +913,6 @@ next:
 }
 #endif
 
-/*
- * shrink_cache() adds the number of pages reclaimed to sc->nr_reclaimed
- */
-static void shrink_cache(struct zone *zone, struct scan_control *sc)
-{
-	LIST_HEAD(page_list);
-	struct pagevec pvec;
-	int max_scan = sc->nr_to_scan;
-
-	pagevec_init(&pvec, 1);
-
-	page_replace_add_drain();
-	spin_lock_irq(&zone->lru_lock);
-	while (max_scan > 0) {
-		struct page *page;
-		int nr_taken;
-		int nr_scan;
-		int nr_freed;
-
-		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
-					     &zone->inactive_list,
-					     &page_list, &nr_scan);
-		zone->nr_inactive -= nr_taken;
-		zone->pages_scanned += nr_scan;
-		spin_unlock_irq(&zone->lru_lock);
-
-		if (nr_taken == 0)
-			goto done;
-
-		max_scan -= nr_scan;
-		nr_freed = shrink_list(&page_list, sc);
-
-		local_irq_disable();
-		if (current_is_kswapd()) {
-			__mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-			__mod_page_state(kswapd_steal, nr_freed);
-		} else
-			__mod_page_state_zone(zone, pgscan_direct, nr_scan);
-		__mod_page_state_zone(zone, pgsteal, nr_freed);
-
-		spin_lock(&zone->lru_lock);
-		/*
-		 * Put back any unfreeable pages.
-		 */
-		while (!list_empty(&page_list)) {
-			page = lru_to_page(&page_list);
-			if (TestSetPageLRU(page))
-				BUG();
-			list_del(&page->lru);
-			if (PageActive(page))
-				add_page_to_active_list(zone, page);
-			else
-				add_page_to_inactive_list(zone, page);
-			if (!pagevec_add(&pvec, page)) {
-				spin_unlock_irq(&zone->lru_lock);
-				__pagevec_release(&pvec);
-				spin_lock_irq(&zone->lru_lock);
-			}
-		}
-  	}
-	spin_unlock_irq(&zone->lru_lock);
-done:
-	pagevec_release(&pvec);
-}
-
 int should_reclaim_mapped(struct zone *zone, struct scan_control *sc)
 {
 	long mapped_ratio;
@@ -1023,171 +958,6 @@ int should_reclaim_mapped(struct zone *z
 }
 
 /*
- * This moves pages from the active list to the inactive list.
- *
- * We move them the other way if the page is referenced by one or more
- * processes, from rmap.
- *
- * If the pages are mostly unmapped, the processing is fast and it is
- * appropriate to hold zone->lru_lock across the whole operation.  But if
- * the pages are mapped, the processing is slow (page_referenced()) so we
- * should drop zone->lru_lock around each page.  It's impossible to balance
- * this, so instead we remove the pages from the LRU while processing them.
- * It is safe to rely on PG_active against the non-LRU pages in here because
- * nobody will play with that bit on a non-LRU page.
- *
- * The downside is that we have to touch page->_count against each page.
- * But we had to alter page->flags anyway.
- */
-static void
-refill_inactive_zone(struct zone *zone, struct scan_control *sc)
-{
-	int pgmoved;
-	int pgdeactivate = 0;
-	int pgscanned;
-	int nr_pages = sc->nr_to_scan;
-	LIST_HEAD(l_hold);	/* The pages which were snipped off */
-	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
-	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
-	struct page *page;
-	struct pagevec pvec;
-	int reclaim_mapped = 0;
-
-	if (unlikely(sc->may_swap))
-		reclaim_mapped = should_reclaim_mapped(zone, sc);
-
-	page_replace_add_drain();
-	spin_lock_irq(&zone->lru_lock);
-	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
-				    &l_hold, &pgscanned);
-	zone->pages_scanned += pgscanned;
-	zone->nr_active -= pgmoved;
-	spin_unlock_irq(&zone->lru_lock);
-
-	while (!list_empty(&l_hold)) {
-		cond_resched();
-		page = lru_to_page(&l_hold);
-		list_del(&page->lru);
-		if (page_mapped(page)) {
-			if (!reclaim_mapped ||
-			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0)) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
-		}
-		list_add(&page->lru, &l_inactive);
-	}
-
-	pagevec_init(&pvec, 1);
-	pgmoved = 0;
-	spin_lock_irq(&zone->lru_lock);
-	while (!list_empty(&l_inactive)) {
-		page = lru_to_page(&l_inactive);
-		prefetchw_prev_lru_page(page, &l_inactive, flags);
-		if (TestSetPageLRU(page))
-			BUG();
-		if (!TestClearPageActive(page))
-			BUG();
-		list_move(&page->lru, &zone->inactive_list);
-		pgmoved++;
-		if (!pagevec_add(&pvec, page)) {
-			zone->nr_inactive += pgmoved;
-			spin_unlock_irq(&zone->lru_lock);
-			pgdeactivate += pgmoved;
-			pgmoved = 0;
-			if (buffer_heads_over_limit)
-				pagevec_strip(&pvec);
-			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
-		}
-	}
-	zone->nr_inactive += pgmoved;
-	pgdeactivate += pgmoved;
-	if (buffer_heads_over_limit) {
-		spin_unlock_irq(&zone->lru_lock);
-		pagevec_strip(&pvec);
-		spin_lock_irq(&zone->lru_lock);
-	}
-
-	pgmoved = 0;
-	while (!list_empty(&l_active)) {
-		page = lru_to_page(&l_active);
-		prefetchw_prev_lru_page(page, &l_active, flags);
-		if (TestSetPageLRU(page))
-			BUG();
-		BUG_ON(!PageActive(page));
-		list_move(&page->lru, &zone->active_list);
-		pgmoved++;
-		if (!pagevec_add(&pvec, page)) {
-			zone->nr_active += pgmoved;
-			pgmoved = 0;
-			spin_unlock_irq(&zone->lru_lock);
-			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
-		}
-	}
-	zone->nr_active += pgmoved;
-	spin_unlock(&zone->lru_lock);
-
-	__mod_page_state_zone(zone, pgrefill, pgscanned);
-	__mod_page_state(pgdeactivate, pgdeactivate);
-	local_irq_enable();
-
-	pagevec_release(&pvec);
-}
-
-/*
- * This is a basic per-zone page freer.  Used by both kswapd and direct reclaim.
- */
-static void
-shrink_zone(struct zone *zone, struct scan_control *sc)
-{
-	unsigned long nr_active;
-	unsigned long nr_inactive;
-
-	atomic_inc(&zone->reclaim_in_progress);
-
-	/*
-	 * Add one to `nr_to_scan' just to make sure that the kernel will
-	 * slowly sift through the active list.
-	 */
-	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
-	nr_active = zone->nr_scan_active;
-	if (nr_active >= sc->swap_cluster_max)
-		zone->nr_scan_active = 0;
-	else
-		nr_active = 0;
-
-	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
-	nr_inactive = zone->nr_scan_inactive;
-	if (nr_inactive >= sc->swap_cluster_max)
-		zone->nr_scan_inactive = 0;
-	else
-		nr_inactive = 0;
-
-	while (nr_active || nr_inactive) {
-		if (nr_active) {
-			sc->nr_to_scan = min(nr_active,
-					(unsigned long)sc->swap_cluster_max);
-			nr_active -= sc->nr_to_scan;
-			refill_inactive_zone(zone, sc);
-		}
-
-		if (nr_inactive) {
-			sc->nr_to_scan = min(nr_inactive,
-					(unsigned long)sc->swap_cluster_max);
-			nr_inactive -= sc->nr_to_scan;
-			shrink_cache(zone, sc);
-		}
-	}
-
-	throttle_vm_writeout();
-
-	atomic_dec(&zone->reclaim_in_progress);
-}
-
-/*
  * This is the direct reclaim path, for page-allocating processes.  We only
  * try to reclaim pages from zones which will satisfy the caller's allocation
  * request.
@@ -1224,7 +994,7 @@ shrink_caches(struct zone **zones, struc
 		if (zone->all_unreclaimable && sc->priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
-		shrink_zone(zone, sc);
+		page_replace_shrink(zone, sc);
 	}
 }
  
@@ -1440,7 +1210,7 @@ scan:
 			sc.nr_reclaimed = 0;
 			sc.priority = priority;
 			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
-			shrink_zone(zone, &sc);
+			page_replace_shrink(zone, &sc);
 			reclaim_state->reclaimed_slab = 0;
 			nr_slab = shrink_slab(sc.nr_scanned, GFP_KERNEL,
 						lru_pages);
@@ -1743,7 +1513,7 @@ int zone_reclaim(struct zone *zone, gfp_
 	 */
 	do {
 		sc.priority--;
-		shrink_zone(zone, &sc);
+		page_replace_shrink(zone, &sc);
 
 	} while (sc.nr_reclaimed < nr_pages && sc.priority > 0);
 
