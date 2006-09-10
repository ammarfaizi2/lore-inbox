Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWIJRKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWIJRKv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWIJRKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:10:50 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:48441 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932321AbWIJRKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:10:32 -0400
Subject: [PATCH] lumpy reclaim -v2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <1157881898.1303.2.camel@lappy>
References: <exportbomb.1157718286@pinky>
	 <20060908122718.GA1662@shadowen.org>
	 <20060908114114.87612de3.akpm@osdl.org>  <1157881898.1303.2.camel@lappy>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 19:09:46 +0200
Message-Id: <1157908187.1303.9.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I found a live-lock in my previous version. Unfortunatly this one is a
bit longer.

The live lock would occur if we break out of the order loop before
moving the tail page ahead, this would lead to retrying the same order
block again and again.

This version first handles the tail page, and after that tries to
complete the block.

---

When trying to reclaim pages for a higher order allocation, make reclaim
try to move lumps of pages (fitting the requested order) about, instead
of single pages. This should significantly reduce the number of
reclaimed pages for higher order allocations.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/buffer.c          |    2 -
 include/linux/swap.h |    2 -
 mm/page_alloc.c      |    2 -
 mm/vmscan.c          |   94 ++++++++++++++++++++++++++++++++++++++++-----------
 4 files changed, 77 insertions(+), 23 deletions(-)

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c	2006-09-10 11:49:01.000000000 +0200
+++ linux-2.6/mm/vmscan.c	2006-09-10 18:47:19.000000000 +0200
@@ -62,6 +62,8 @@ struct scan_control {
 	int swap_cluster_max;
 
 	int swappiness;
+
+	int order;
 };
 
 /*
@@ -590,35 +592,86 @@ keep:
  *
  * returns how many pages were moved onto *@dst.
  */
+int __isolate_lru_page(struct page *page, int active)
+{
+	int ret = -EINVAL;
+
+	if (PageLRU(page) && (PageActive(page) == active)) {
+		ret = -EBUSY;
+		if (likely(get_page_unless_zero(page))) {
+			/*
+			 * Be careful not to clear PageLRU until after we're
+			 * sure the page is not being freed elsewhere -- the
+			 * page release code relies on it.
+			 */
+			ClearPageLRU(page);
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
 static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		struct list_head *src, struct list_head *dst,
-		unsigned long *scanned)
+		unsigned long *scanned, int order)
 {
 	unsigned long nr_taken = 0;
-	struct page *page;
-	unsigned long scan;
+	struct page *page, *tmp;
+	unsigned long scan, pfn, end_pfn, page_pfn;
+	int active;
 
 	for (scan = 0; scan < nr_to_scan && !list_empty(src); scan++) {
-		struct list_head *target;
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
 		BUG_ON(!PageLRU(page));
 
-		list_del(&page->lru);
-		target = src;
-		if (likely(get_page_unless_zero(page))) {
-			/*
-			 * Be careful not to clear PageLRU until after we're
-			 * sure the page is not being freed elsewhere -- the
-			 * page release code relies on it.
-			 */
-			ClearPageLRU(page);
-			target = dst;
-			nr_taken++;
-		} /* else it is being freed elsewhere */
+		active = PageActive(page);
+		switch (__isolate_lru_page(page, active)) {
+			case 0:
+				list_move(&page->lru, dst);
+				nr_taken++;
+				break;
+
+			case -EBUSY:
+				/* else it is being freed elsewhere */
+				list_move(&page->lru, src);
+				continue;
+
+			default:
+				BUG();
+		}
 
-		list_add(&page->lru, target);
+		if (!order)
+			continue;
+
+		page_pfn = pfn = __page_to_pfn(page);
+		end_pfn = pfn &= ~((1 << order) - 1);
+		end_pfn += 1 << order;
+		for (; pfn < end_pfn; pfn++) {
+			if (unlikely(pfn == page_pfn))
+				continue;
+			if (unlikely(!pfn_valid(pfn)))
+				break;
+
+			scan++;
+			tmp = __pfn_to_page(pfn);
+			switch (__isolate_lru_page(tmp, active)) {
+				case 0:
+					list_move(&tmp->lru, dst);
+					nr_taken++;
+					continue;
+
+				case -EBUSY:
+					/* else it is being freed elsewhere */
+					list_move(&tmp->lru, src);
+				default:
+					break;
+
+			}
+			break;
+		}
 	}
 
 	*scanned = scan;
@@ -649,7 +702,7 @@ static unsigned long shrink_inactive_lis
 
 		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
 					     &zone->inactive_list,
-					     &page_list, &nr_scan);
+					     &page_list, &nr_scan, sc->order);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
@@ -771,7 +824,7 @@ static void shrink_active_list(unsigned 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
 	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
-				    &l_hold, &pgscanned);
+				    &l_hold, &pgscanned, sc->order);
 	zone->pages_scanned += pgscanned;
 	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
@@ -959,7 +1012,7 @@ static unsigned long shrink_zones(int pr
  * holds filesystem locks which prevent writeout this might not work, and the
  * allocation attempt will fail.
  */
-unsigned long try_to_free_pages(struct zone **zones, gfp_t gfp_mask)
+unsigned long try_to_free_pages(struct zone **zones, int order, gfp_t gfp_mask)
 {
 	int priority;
 	int ret = 0;
@@ -974,6 +1027,7 @@ unsigned long try_to_free_pages(struct z
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.may_swap = 1,
 		.swappiness = vm_swappiness,
+		.order = order,
 	};
 
 	count_vm_event(ALLOCSTALL);
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2006-09-10 11:49:01.000000000 +0200
+++ linux-2.6/fs/buffer.c	2006-09-10 18:11:17.000000000 +0200
@@ -498,7 +498,7 @@ static void free_more_memory(void)
 	for_each_online_pgdat(pgdat) {
 		zones = pgdat->node_zonelists[gfp_zone(GFP_NOFS)].zones;
 		if (*zones)
-			try_to_free_pages(zones, GFP_NOFS);
+			try_to_free_pages(zones, 0, GFP_NOFS);
 	}
 }
 
Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h	2006-09-10 11:49:01.000000000 +0200
+++ linux-2.6/include/linux/swap.h	2006-09-10 18:11:17.000000000 +0200
@@ -181,7 +181,7 @@ extern int rotate_reclaimable_page(struc
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern unsigned long try_to_free_pages(struct zone **, gfp_t);
+extern unsigned long try_to_free_pages(struct zone **, int, gfp_t);
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-09-10 11:49:01.000000000 +0200
+++ linux-2.6/mm/page_alloc.c	2006-09-10 18:11:18.000000000 +0200
@@ -1000,7 +1000,7 @@ rebalance:
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask);
+	did_some_progress = try_to_free_pages(zonelist->zones, order, gfp_mask);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;


