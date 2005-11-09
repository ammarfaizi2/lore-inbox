Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVKIOOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVKIOOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKIOOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:14:21 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:9196 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750823AbVKIOOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:00 -0500
Message-Id: <20051109141438.053618000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:40 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 02/16] mm: balance page aging between zones
Content-Disposition: inline; filename=mm-balanced-aging.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The page aging rates are currently imbalanced, the gap can be as large as 3
times, which can severely damage read-ahead requests and shorten their
effective life time.

This patch adds three variables in struct zone to keep track of page aging
rate, and keeps them in sync on vmscan/pagealloc time. The nr_page_aging is
a per-zone counter-part to the per-cpu pgscan_{kswapd,direct}_{zone name}.

The direct page reclaim path is not touched, for it needs non-trival changes.
It is ok as long as (pgscan_kswapd_* > pgscan_direct_*).

__alloc_pages() is changed a lot, which needs comfirmation from NUMA gurus.
The basic idea is to do reclaim in batches, and keep the zones inside one
batch balanced.  There can be different policies in the partitioning.  One
obvious choice for the first batch would be the zones on current node and
nearby memory nodes without cpu.


Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mmzone.h |   53 ++++++++++++++++++++++++++
 mm/page_alloc.c        |   97 ++++++++++++++++++++++++++++++++++++++++---------
 mm/vmscan.c            |   31 ++++++++++++---
 3 files changed, 159 insertions(+), 22 deletions(-)

--- linux-2.6.14-mm1.orig/include/linux/mmzone.h
+++ linux-2.6.14-mm1/include/linux/mmzone.h
@@ -161,6 +161,20 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* Fields for balanced page aging:
+	 * nr_page_aging   - The accumulated number of activities that may
+	 *                   cause page aging, that is, make some pages closer
+	 *                   to the tail of inactive_list.
+	 * aging_milestone - A snapshot of nr_page_aging every time a full
+	 *                   inactive_list of pages become aged.
+	 * page_age        - A normalized value showing the percent of pages
+	 *                   have been aged.  It is compared between zones to
+	 *                   balance the rate of page aging.
+	 */
+	unsigned long		nr_page_aging;
+	unsigned long		aging_milestone;
+	unsigned long		page_age;
+
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?
@@ -344,6 +358,45 @@ static inline void memory_present(int ni
 unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
 #endif
 
+#ifdef CONFIG_HIGHMEM64G
+#define		PAGE_AGE_SHIFT  8
+#elif BITS_PER_LONG == 32
+#define		PAGE_AGE_SHIFT  12
+#elif BITS_PER_LONG == 64
+#define		PAGE_AGE_SHIFT  20
+#else
+#error unknown BITS_PER_LONG
+#endif
+#define		PAGE_AGE_MASK   ((1 << PAGE_AGE_SHIFT) - 1)
+
+/*
+ * Keep track of the percent of pages in inactive_list that have been scanned
+ * / aged.  It's not really ##%, but a high resolution normalized value.
+ */
+static inline void update_page_age(struct zone *z, int nr_scan)
+{
+	z->nr_page_aging += nr_scan;
+
+	if (z->nr_page_aging - z->aging_milestone > z->nr_inactive)
+		z->aging_milestone += z->nr_inactive;
+
+	z->page_age = ((z->nr_page_aging - z->aging_milestone)
+				<< PAGE_AGE_SHIFT) / (1 + z->nr_inactive);
+}
+
+/*
+ * The simplified code is:
+ *         return (a->page_age > b->page_age);
+ * The complexity deals with the wrap-around problem.
+ * Two page ages not close enough should also be ignored:
+ * they are out of sync and the comparison may be nonsense.
+ */
+static inline int pages_more_aged(struct zone *a, struct zone *b)
+{
+	return ((b->page_age - a->page_age) & PAGE_AGE_MASK) >
+			PAGE_AGE_MASK - (1 << (PAGE_AGE_SHIFT - 2));
+}
+
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
  */
--- linux-2.6.14-mm1.orig/mm/page_alloc.c
+++ linux-2.6.14-mm1/mm/page_alloc.c
@@ -488,7 +488,7 @@ static void prep_new_page(struct page *p
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_activate |
+			1 << PG_activate | 1 << PG_readahead |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
 	set_page_refs(page, order);
@@ -871,9 +871,15 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	struct task_struct *p = current;
 	int i;
 	int classzone_idx;
+	int do_reclaim;
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
+	unsigned long zones_mask;
+	int left_count;
+	int batch_size;
+	int batch_base;
+	int batch_idx;
 
 	might_sleep_if(wait);
 
@@ -893,13 +899,62 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	classzone_idx = zone_idx(zones[0]);
 
-restart:
 	/*
 	 * Go through the zonelist once, looking for a zone with enough free.
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
-		int do_reclaim = should_reclaim_zone(z, gfp_mask);
+restart:
+	/*
+	 * To fulfill three goals:
+	 * - balanced page aging
+	 * - locality
+	 * - predefined zonelist priority
+	 *
+	 * The logic employs the following rules:
+	 * 1. Zones are checked in predefined order in general.
+	 * 2. Skip to the next zone if it has lower page_age.
+	 * 3. Checkings are carried out in batch, all zones in a batch must be
+	 *    checked before entering the next batch.
+	 * 4. All local zones in the zonelist forms the first batch.
+	 */
+
+	/* TODO: Avoid this loop by putting the values into struct zonelist.
+	 * The (more general) desired batch counts can also go there.
+	 */
+	for (batch_size = 0, i = 0; (z = zones[i]) != NULL; i++) {
+		if (z->zone_pgdat == zones[0]->zone_pgdat)
+			batch_size++;
+	}
+	BUG_ON(!batch_size);
+
+	left_count = i - batch_size;
+	batch_base = 0;
+	batch_idx = 0;
+	zones_mask = 0;
+
+	for (;;) {
+		if (zones_mask == (1 << batch_size) - 1) {
+			if (left_count <= 0) {
+				break;
+			}
+			batch_base += batch_size;
+			batch_size = min(left_count, (int)sizeof(zones_mask) * 8);
+			left_count -= batch_size;
+			batch_idx = 0;
+			zones_mask = 0;
+		}
+
+		do {
+			i = batch_idx;
+			do {
+				if (++batch_idx >= batch_size)
+					batch_idx = 0;
+			} while (zones_mask & (1 << batch_idx));
+		} while (pages_more_aged(zones[batch_base + i],
+					 zones[batch_base + batch_idx]));
+
+		zones_mask |= (1 << i);
+		z = zones[batch_base + i];
 
 		if (!cpuset_zone_allowed(z, __GFP_HARDWALL))
 			continue;
@@ -909,11 +964,12 @@ restart:
 		 * will try to reclaim pages and check the watermark a second
 		 * time before giving up and falling back to the next zone.
 		 */
+		do_reclaim = should_reclaim_zone(z, gfp_mask);
 zone_reclaim_retry:
 		if (!zone_watermark_ok(z, order, z->pages_low,
 				       classzone_idx, 0, 0)) {
 			if (!do_reclaim)
-				continue;
+				goto try_harder;
 			else {
 				zone_reclaim(z, gfp_mask, order);
 				/* Only try reclaim once */
@@ -925,20 +981,18 @@ zone_reclaim_retry:
 		page = buffered_rmqueue(z, order, gfp_mask);
 		if (page)
 			goto got_pg;
-	}
 
-	for (i = 0; (z = zones[i]) != NULL; i++)
+try_harder:
 		wakeup_kswapd(z, order);
 
-	/*
-	 * Go through the zonelist again. Let __GFP_HIGH and allocations
-	 * coming from realtime tasks to go deeper into reserves
-	 *
-	 * This is the last chance, in general, before the goto nopage.
-	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
-	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
-	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
+		/*
+		 * Put stress on the zone. Let __GFP_HIGH and allocations
+		 * coming from realtime tasks to go deeper into reserves.
+		 *
+		 * This is the last chance, in general, before the goto nopage.
+		 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
+		 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
+		 */
 		if (!zone_watermark_ok(z, order, z->pages_min,
 				       classzone_idx, can_try_harder,
 				       gfp_mask & __GFP_HIGH))
@@ -1447,6 +1501,8 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" aging:%lukB"
+			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",
@@ -1458,6 +1514,8 @@ void show_free_areas(void)
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
+			K(zone->nr_page_aging),
+			zone->page_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
@@ -2075,6 +2133,9 @@ static void __init free_area_init_core(s
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->nr_page_aging = 0;
+		zone->aging_milestone = 0;
+		zone->page_age = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2223,6 +2284,8 @@ static int zoneinfo_show(struct seq_file
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        aging    %lu"
+			   "\n        age      %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2232,6 +2295,8 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->nr_page_aging,
+			   zone->page_age,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
--- linux-2.6.14-mm1.orig/mm/vmscan.c
+++ linux-2.6.14-mm1/mm/vmscan.c
@@ -839,6 +839,7 @@ static void shrink_cache(struct zone *zo
 			goto done;
 
 		max_scan -= nr_scan;
+		update_page_age(zone, nr_scan);
 		if (current_is_kswapd())
 			mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
 		else
@@ -1286,6 +1287,7 @@ loop_again:
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
+		int begin_zone = -1;
 		unsigned long lru_pages = 0;
 
 		all_zones_ok = 1;
@@ -1307,16 +1309,33 @@ loop_again:
 
 				if (!zone_watermark_ok(zone, order,
 						zone->pages_high, 0, 0, 0)) {
-					end_zone = i;
-					goto scan;
+					if (!end_zone)
+						begin_zone = end_zone = i;
+					else /* if (begin_zone == i + 1) */
+						begin_zone = i;
 				}
 			}
-			goto out;
+			if (begin_zone < 0)
+				goto out;
 		} else {
+			begin_zone = 0;
 			end_zone = pgdat->nr_zones - 1;
 		}
-scan:
-		for (i = 0; i <= end_zone; i++) {
+
+		/*
+		 * Prepare enough free pages for zones with small page_age,
+		 * they are going to be reclaimed in the page allocation.
+		 */
+		while (end_zone < pgdat->nr_zones - 1 &&
+			pages_more_aged(pgdat->node_zones + end_zone,
+					pgdat->node_zones + end_zone + 1))
+			end_zone++;
+		while (begin_zone &&
+			pages_more_aged(pgdat->node_zones + begin_zone,
+					pgdat->node_zones + begin_zone - 1))
+			begin_zone--;
+
+		for (i = begin_zone; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
 			lru_pages += zone->nr_active + zone->nr_inactive;
@@ -1331,7 +1350,7 @@ scan:
 		 * pages behind kswapd's direction of progress, which would
 		 * cause too much scanning of the lower zones.
 		 */
-		for (i = 0; i <= end_zone; i++) {
+		for (i = begin_zone; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_slab;
 

--
