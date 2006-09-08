Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWIHM1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWIHM1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWIHM1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:27:51 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:28052
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750968AbWIHM1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:27:48 -0400
Date: Fri, 8 Sep 2006 13:27:18 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 5/5] linear reclaim core
Message-ID: <20060908122718.GA1662@shadowen.org>
References: <exportbomb.1157718286@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1157718286@pinky>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linear reclaim core

When we are out of memory of a suitable size we enter reclaim.
The current reclaim algorithm targets pages in LRU order, which
is great for fairness but highly unsuitable if you desire pages at
higher orders.  To get pages of higher order we must shoot down a
very high proportion of memory; >95% in a lot of cases.

This patch introduces an alternative algorithm used when requesting
higher order allocations.  Here we look at memory in ranges at the
order requested.  We make a quick pass to see if all pages in that
area are likely to be reclaimed, only then do we apply reclaim to
the pages in the area.

Testing in combination with fragmentation avoidance shows
significantly improved chances of a successful allocation at
higher order.

Added in: V1

Issues:
 o no longer need to be MAX_ORDER aligned with new iterators

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8c09638..83cafb9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -199,6 +199,7 @@ #endif
 	unsigned long		nr_inactive;
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
+	unsigned long		linear_scan_hand;
 
 	/* The accumulated number of activities that may cause page aging,
 	 * that is, make some pages closer to the tail of inactive_list.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 825a433..9c71a2d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2049,6 +2049,7 @@ __meminit int init_currently_empty_zone(
 	pgdat->nr_zones = zone_idx(zone) + 1;
 
 	zone->zone_start_pfn = zone_start_pfn;
+	zone->linear_scan_hand = zone_start_pfn;
 
 	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4a72976..a88061d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -974,6 +974,9 @@ static unsigned long shrink_zones(int pr
 	return nr_reclaimed;
 }
  
+static unsigned long pressure_zones(int, struct zone **, int,
+							struct scan_control *);
+
 /*
  * This is the main entry point to direct page reclaim.
  *
@@ -1021,7 +1024,11 @@ unsigned long try_to_free_pages(struct z
 		sc.nr_scanned = 0;
 		if (!priority)
 			disable_swap_token();
-		nr_reclaimed += shrink_zones(priority, zones, &sc);
+		if (order <= 3)
+			nr_reclaimed += shrink_zones(priority, zones, &sc);
+		else
+			nr_reclaimed += pressure_zones(priority, zones,
+								order, &sc);
 		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
 			nr_reclaimed += reclaim_state->reclaimed_slab;
@@ -1685,3 +1692,294 @@ int zone_reclaim(struct zone *zone, gfp_
 	return __zone_reclaim(zone, gfp_mask, order);
 }
 #endif
+
+static int page_likely_reclaimable(struct page *page)
+{
+	if (PageLocked(page))
+		return 0;
+	if (PageReserved(page))
+		return 0;
+	if (PageSlab(page))
+		return 0;
+	if (PageCompound(page))
+		return 0;
+	return 1;
+}
+
+static unsigned long shrink_linear_pages(struct list_head *inactive,
+			struct list_head *active, struct scan_control *sc)
+{
+	unsigned long nr_free;
+
+	/*
+	 * If the inactive pages free ok then its worth
+	 * attempting to free the active ones in this chunk.
+	 */
+	nr_free = shrink_page_list(inactive, sc);
+	if (list_empty(inactive)) {
+		struct list_head *entry;
+		struct page *page;
+
+		list_for_each(entry, active) {
+			page = list_entry(entry, struct page, lru);
+			ClearPageActive(page);
+		}
+		nr_free += shrink_page_list(active, sc);
+	}
+
+	return nr_free;
+}
+
+/*
+ * Find the real first page in an area.  This is either the real first
+ * page at pfn, or the free page which coveres this area.
+ */
+static struct page *page_find_area_start(unsigned long pfn)
+{
+	int order;
+	int mask = 1;
+	struct page *orig_page = pfn_to_page(pfn);
+	struct page *page = orig_page;
+
+	for (order = 0; order < MAX_ORDER; order++, mask <<= 1) {
+		if (pfn_valid_within(pfn) && PageBuddy(page) &&
+						page_order(page) >= order)
+			return page;
+		if (pfn & mask) {
+			pfn &= ~mask;
+			page -= mask;
+		}
+	}
+
+	return orig_page;
+}
+
+/*
+ * Scan the pages indicates, pulling out any pages on the LRU
+ * onto a list of active and a list of inactive pages.
+ *
+ * zone->lru_lock must be held, with interrupts disabled.
+ */
+static unsigned long isolate_linear_pages(struct zone *zone,
+		unsigned long size, unsigned long pfn,
+		struct list_head *page_list, struct list_head *page_list_a)
+{
+	int nr_active = 0;
+	int nr_inactive = 0;
+	struct page *page;
+	struct page *start;
+	struct page *end;
+
+	start = page_find_area_start(pfn);
+	end = pfn_to_page(pfn) + size;
+	for (page = start; page < end; page++) {
+		if (!pfn_valid_within(pfn + (page - start)))
+			continue;
+		if (PageBuddy(page)) {
+			page += (1 << page_order(page)) - 1;
+			continue;
+		}
+		if (unlikely(PageCompound(page)))
+			continue;
+
+		if (PageLRU(page)) {
+			list_del(&page->lru);
+			if (!get_page_unless_zero(page)) {
+				/*
+				 * It is being freed elsewhere, this
+				 * is also good.
+				 */
+				if (PageActive(page))
+					list_add(&page->lru,
+						&zone->active_list);
+				else
+					list_add(&page->lru,
+						&zone->inactive_list);
+				continue;
+			}
+			ClearPageLRU(page);
+			if (PageActive(page)) {
+				nr_active++;
+				list_add(&page->lru, page_list_a);
+			} else {
+				nr_inactive++;
+				list_add(&page->lru, page_list);
+			}
+		}
+	}
+	zone->nr_active -= nr_active;
+	zone->nr_inactive -= nr_inactive;
+	zone->pages_scanned += nr_inactive + nr_active;
+
+	return nr_inactive + nr_active;
+}
+
+/*
+ * Apply pressure to the zone to try and free pages at the specified order.
+ */
+static unsigned long pressure_zone(int priority, struct zone *zone, int order,
+						struct scan_control *sc)
+{
+	LIST_HEAD(page_list);
+	LIST_HEAD(page_list_a);
+	struct pagevec pvec;
+
+	unsigned long pfn;
+	unsigned long pfn_zone_end;
+	unsigned long pfn_scan_end;
+	unsigned long size = (1 << order);
+	unsigned long mask = (~0 << order);
+	unsigned long start;
+
+	unsigned long nr_to_scan = (zone->spanned_pages >> priority) + size;
+	unsigned long nr_reclaimed = 0;
+	long nr_seen;
+	long nr_free;
+	long nr_likely;
+	long nr_scan;
+
+	long blocks_scanned = 0;
+
+	pagevec_init(&pvec, 1);
+
+	lru_add_drain();
+	spin_lock_irq(&zone->lru_lock);
+
+	pfn_zone_end = zone->zone_start_pfn + zone->spanned_pages;
+	pfn_scan_end = pfn_zone_end;
+
+	/*
+	 * Calculate our current start point.  Note the buddy allocator
+	 * merge algorithm means that a free block is marked at its low
+	 * edge.  This means we _must_ scan from low to high and start
+	 * either at a MAX_ORDER boundry or the low end of the zone otherwise
+	 * we cannot determine if _this_ page is free.  Also we want to
+	 * start aligned with the requested block size.
+	 */
+	start = zone->linear_scan_hand & mask;
+scan_wrap:
+	if (start < zone->zone_start_pfn)
+		start += size;
+
+	for (pfn = start; pfn < pfn_scan_end; pfn += size) {
+		struct page *page;
+		struct page *chunk_start;
+		struct page *chunk_end;
+
+		/*
+		 * Handle memory models where we can have invalid areas
+		 * within the zone.  Note we are making use of the
+		 * assumption that mem_map is contigious out to
+		 * MAX_ORDER to allow us to check just the start of the
+		 * block.
+		 */
+		if (!pfn_valid(pfn))
+			continue;
+
+		/*
+		 * If we have scanned a reasonable amount of blocks,
+		 * and are on a MAX_ORDER boundry, we are in a reasonble
+		 * position to stop.
+		 */
+		if (blocks_scanned >= (nr_to_scan / size) &&
+					(pfn  & ~(1 << (MAX_ORDER-1))) == pfn)
+			break;
+
+		/* Do a quick evaluation pass over the area. */
+		nr_seen = nr_likely = 0;
+
+		chunk_start = page_find_area_start(pfn);
+		chunk_end = pfn_to_page(pfn) + size;
+		for (page = chunk_start; page < chunk_end; page++) {
+			if (!pfn_valid_within(pfn + (page - chunk_start))) {
+				nr_seen++;
+				continue;
+			}
+
+			if (PageBuddy(page)) {
+				page += (1 << page_order(page)) - 1;
+				continue;
+			}
+
+			if (page_likely_reclaimable(page))
+				nr_likely++;
+			nr_seen++;
+		}
+		if (nr_likely < nr_seen || nr_seen == 0)
+			continue;
+
+		/* Pull out any in use pages ready for freeing. */
+		nr_scan = isolate_linear_pages(zone, size, pfn, &page_list,
+								&page_list_a);
+		spin_unlock_irq(&zone->lru_lock);
+
+		if (nr_scan > 0) {
+			nr_free = shrink_linear_pages(&page_list,
+							&page_list_a, sc);
+			blocks_scanned++;
+		} else
+			nr_free = 0;
+
+		nr_reclaimed += nr_free;
+
+		/*
+		 * shrink_linear_pages may have converted any of our pages
+		 * to active.  We therefore need to handle both lists the
+		 * same.  Merge them.
+		 */
+		list_splice_init(&page_list_a, &page_list);
+
+		/* Update the accounting information. */
+		local_irq_disable();
+		if (current_is_kswapd()) {
+			__count_zone_vm_events(PGSCAN_KSWAPD, zone, nr_scan);
+			__count_vm_events(KSWAPD_STEAL, nr_free);
+		} else
+			__count_zone_vm_events(PGSCAN_DIRECT, zone, nr_scan);
+		__count_vm_events(PGACTIVATE, nr_free);
+
+		spin_lock(&zone->lru_lock);
+
+		return_unfreeable_pages(&page_list, zone, &pvec);
+	}
+	if (pfn >= pfn_zone_end) {
+		pfn_scan_end = start;
+		start = zone->zone_start_pfn & mask;
+		goto scan_wrap;
+	}
+	zone->linear_scan_hand = pfn;
+
+	spin_unlock_irq(&zone->lru_lock);
+	pagevec_release(&pvec);
+
+	sc->nr_scanned += blocks_scanned * size;
+
+	return nr_reclaimed;
+}
+
+static unsigned long pressure_zones(int priority, struct zone **zones,
+					int order, struct scan_control *sc)
+{
+	unsigned long nr_reclaimed = 0;
+	int i;
+
+	for (i = 0; zones[i] != NULL; i++) {
+		struct zone *zone = zones[i];
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
+			continue;
+
+		zone->temp_priority = priority;
+		if (zone->prev_priority > priority)
+			zone->prev_priority = priority;
+
+		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
+			continue;	/* Let kswapd poll it */
+
+		nr_reclaimed += pressure_zone(priority, zone, order, sc);
+	}
+	return nr_reclaimed;
+}
