Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757422AbWKWQto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422AbWKWQto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbWKWQtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:49:43 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:36745
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1757422AbWKWQtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:49:42 -0500
Date: Thu, 23 Nov 2006 16:49:10 +0000
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] lumpy reclaim v2
Message-ID: <5dd653f9f8e104d772109ee0c5146e19@pinky>
References: <exportbomb.1164300519@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1164300519@pinky>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lumpy reclaim v2

When trying to reclaim pages for a higher order allocation, make reclaim
try to move lumps of pages (fitting the requested order) about, instead
of single pages. This should significantly reduce the number of
reclaimed pages for higher order allocations.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/fs/buffer.c b/fs/buffer.c
index 64ea099..c73acb7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -424,7 +424,7 @@ static void free_more_memory(void)
 	for_each_online_pgdat(pgdat) {
 		zones = pgdat->node_zonelists[gfp_zone(GFP_NOFS)].zones;
 		if (*zones)
-			try_to_free_pages(zones, GFP_NOFS);
+			try_to_free_pages(zones, 0, GFP_NOFS);
 	}
 }
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 439f9a8..5c26736 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -187,7 +187,7 @@ extern int rotate_reclaimable_page(struc
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern unsigned long try_to_free_pages(struct zone **, gfp_t);
+extern unsigned long try_to_free_pages(struct zone **, int, gfp_t);
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 19ab611..39f48a8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1368,7 +1368,7 @@ nofail_alloc:
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask);
+	did_some_progress = try_to_free_pages(zonelist->zones, order, gfp_mask);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7e9caff..4645a3f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -67,6 +67,8 @@ struct scan_control {
 	int swappiness;
 
 	int all_unreclaimable;
+
+	int order;
 };
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
@@ -623,35 +625,86 @@ keep:
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
 
 		VM_BUG_ON(!PageLRU(page));
 
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
@@ -682,7 +735,7 @@ static unsigned long shrink_inactive_lis
 
 		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
 					     &zone->inactive_list,
-					     &page_list, &nr_scan);
+					     &page_list, &nr_scan, sc->order);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
 		zone->aging_total += nr_scan;
@@ -828,7 +881,7 @@ force_reclaim_mapped:
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
 	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
-				    &l_hold, &pgscanned);
+				    &l_hold, &pgscanned, sc->order);
 	zone->pages_scanned += pgscanned;
 	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
@@ -1017,7 +1070,7 @@ static unsigned long shrink_zones(int pr
  * holds filesystem locks which prevent writeout this might not work, and the
  * allocation attempt will fail.
  */
-unsigned long try_to_free_pages(struct zone **zones, gfp_t gfp_mask)
+unsigned long try_to_free_pages(struct zone **zones, int order, gfp_t gfp_mask)
 {
 	int priority;
 	int ret = 0;
@@ -1032,6 +1085,7 @@ unsigned long try_to_free_pages(struct z
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.may_swap = 1,
 		.swappiness = vm_swappiness,
+		.order = order,
 	};
 
 	delay_swap_prefetch();
