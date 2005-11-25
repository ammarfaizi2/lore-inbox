Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbVKYPGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbVKYPGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVKYPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:06:00 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:25834 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932694AbVKYPFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:05:50 -0500
Message-Id: <20051125151402.332537000@localhost.localdomain>
References: <20051125151210.993109000@localhost.localdomain>
Date: Fri, 25 Nov 2005 23:12:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 03/19] mm: balance page aging between zones and slabs
Content-Disposition: inline; filename=mm-balanced-aging.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The zone aging rates are currently imbalanced, the gap can be as large as 3
times, which can severely damage read-ahead requests and shorten their
effective life time.

The current slab shrinking code is way too fragile. It should manage aging
pace by itself, and provide a simple and robust interface.

THE METHOD
==========
This patch adds three variables in struct zone and shrinker
- aging_total
- aging_milestone
- page_age
to keep track of page aging rate, and keep it in sync on page reclaim time.
The aging_total is just a per-zone counter-part to the per-cpu
pgscan_{kswapd,direct}_{zone name}. But it is not direct comparable between
zones, so the aging_milestone/page_age are maintained based on aging_total.

The main design aspects of page balancing:
- In the kswapd reclaim path,
	- reclaim also the least aged zone to help it catch up with the most
	  aged zone;
	- the reclaim for watermark is avoided whenever possible by calling
	  watermark_ok() with classzone_idx = 0;
	- in this way, the reclaims for aging are garuanteed to be more than
	  reclaims for watermark if there's a big imbalance, so that there
	  will not be any chance for a growing gap.
- In the direct reclaim path,
	- reclaim only the least aged local/headless zone in the first two
	  rounds;
	- two rounds are enough in normal to get enough free pages;
	- and prevents unnecessarily disturbing remote nodes.
- In shrink_cache()/shrink_zone()/shrink_list(),
	- zone->nr_scan_inactive is purged, the requested zone will be
	  scanned at least SWAP_CLUSTER_MAX pages;
	- sc->nr_scanned reflects exactly the number of cold pages scanned.
- In shrink_slab(),
	- keep the age of slabs in line with that of the largest zone, using
	  the same syncing logic as that of the zones;
	- a minimal number of unused slabs are reserved in normal;
	- the slabs are shrinked more if vm pressure is high;
	- `mmap pages found' - `shrink more slabs' - `avoid swapping',
	  I don't think they are strongly related, so the code is removed.

THE RESULT
==========
- It does not touch the time critical page alloc path, so will not hurt
  performance at all.
- The shrink of slabs become simple, consistent and robust. The callers no
  longer have to worry about the tricky aging thing.
- Experiments with 64M/512M/2G memory show that it keeps the zone ages in
  sync perfectly. One can check the effects by running:
			tar c / | cat > /dev/null &
			watch -n1 'grep "age " /proc/zoneinfo'

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h     |    4 
 include/linux/mmzone.h |   14 +++
 mm/page_alloc.c        |   16 ++-
 mm/vmscan.c            |  222 +++++++++++++++++++++++++++++++------------------
 4 files changed, 173 insertions(+), 83 deletions(-)

--- linux-2.6.15-rc2-mm1.orig/include/linux/mmzone.h
+++ linux-2.6.15-rc2-mm1/include/linux/mmzone.h
@@ -149,6 +149,20 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* Fields for balanced page aging:
+	 * aging_total     - The accumulated number of activities that may
+	 *                   cause page aging, that is, make some pages closer
+	 *                   to the tail of inactive_list.
+	 * aging_milestone - A snapshot of total_scan every time a full
+	 *                   inactive_list of pages become aged.
+	 * page_age        - A normalized value showing the percent of pages
+	 *                   have been aged.  It is compared between zones to
+	 *                   balance the rate of page aging.
+	 */
+	unsigned long		aging_total;
+	unsigned long		aging_milestone;
+	unsigned long		page_age;
+
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?
--- linux-2.6.15-rc2-mm1.orig/include/linux/mm.h
+++ linux-2.6.15-rc2-mm1/include/linux/mm.h
@@ -775,7 +775,9 @@ struct shrinker {
 	shrinker_t		shrinker;
 	struct list_head	list;
 	int			seeks;	/* seeks to recreate an obj */
-	long			nr;	/* objs pending delete */
+	unsigned long		aging_total;
+	unsigned long		aging_milestone;
+	unsigned long		page_age;
 	struct shrinker_stats	*s_stats;
 };
 
--- linux-2.6.15-rc2-mm1.orig/mm/page_alloc.c
+++ linux-2.6.15-rc2-mm1/mm/page_alloc.c
@@ -1468,6 +1468,8 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" aging:%lukB"
+			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",
@@ -1479,6 +1481,8 @@ void show_free_areas(void)
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
+			K(zone->aging_total),
+			zone->page_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
@@ -2089,9 +2093,11 @@ static void __init free_area_init_core(s
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
 		zone->nr_scan_active = 0;
-		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->aging_total = 0;
+		zone->aging_milestone = 0;
+		zone->page_age = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2240,7 +2246,9 @@ static int zoneinfo_show(struct seq_file
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
-			   "\n        scanned  %lu (a: %lu i: %lu)"
+			   "\n        aging    %lu"
+			   "\n        age      %lu"
+			   "\n        scanned  %lu (a: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
 			   zone->free_pages,
@@ -2249,8 +2257,10 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->aging_total,
+			   zone->page_age,
 			   zone->pages_scanned,
-			   zone->nr_scan_active, zone->nr_scan_inactive,
+			   zone->nr_scan_active,
 			   zone->spanned_pages,
 			   zone->present_pages);
 		seq_printf(m,
--- linux-2.6.15-rc2-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc2-mm1/mm/vmscan.c
@@ -123,6 +123,56 @@ static long total_memory;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
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
+ * The simplified code is: (a->page_age > b->page_age)
+ * The complexity deals with the wrap-around problem.
+ * Two page ages not close enough should also be ignored:
+ * they are out of sync and the comparison may be nonsense.
+ */
+#define pages_more_aged(a, b) 						\
+	((b->page_age - a->page_age) & PAGE_AGE_MASK) >			\
+			PAGE_AGE_MASK - (1 << (PAGE_AGE_SHIFT - 3))	\
+
+/*
+ * Keep track of the percent of cold pages that have been scanned / aged.
+ * It's not really ##%, but a high resolution normalized value.
+ */
+static inline void update_zone_age(struct zone *z, int nr_scan)
+{
+	unsigned long len = z->nr_inactive + z->free_pages;
+
+	z->aging_total += nr_scan;
+
+	if (z->aging_total - z->aging_milestone > len)
+		z->aging_milestone += len;
+
+	z->page_age = ((z->aging_total - z->aging_milestone)
+						<< PAGE_AGE_SHIFT) / len;
+}
+
+static inline void update_slab_age(struct shrinker *s,
+					unsigned long len, int nr_scan)
+{
+	s->aging_total += nr_scan;
+
+	if (s->aging_total - s->aging_milestone > len)
+		s->aging_milestone += len;
+
+	s->page_age = ((s->aging_total - s->aging_milestone)
+						<< PAGE_AGE_SHIFT) / len;
+}
+
 /*
  * Add a shrinker callback to be called from the vm
  */
@@ -134,7 +184,9 @@ struct shrinker *set_shrinker(int seeks,
         if (shrinker) {
 	        shrinker->shrinker = theshrinker;
 	        shrinker->seeks = seeks;
-	        shrinker->nr = 0;
+	        shrinker->aging_total = 0;
+	        shrinker->aging_milestone = 0;
+	        shrinker->page_age = 0;
 		shrinker->s_stats = alloc_percpu(struct shrinker_stats);
 		if (!shrinker->s_stats) {
 			kfree(shrinker);
@@ -170,80 +222,61 @@ EXPORT_SYMBOL(remove_shrinker);
  * percentages of the lru and ageable caches.  This should balance the seeks
  * generated by these structures.
  *
- * If the vm encounted mapped pages on the LRU it increase the pressure on
- * slab to avoid swapping.
- *
- * We do weird things to avoid (scanned*seeks*entries) overflowing 32 bits.
- *
- * `lru_pages' represents the number of on-LRU pages in all the zones which
- * are eligible for the caller's allocation attempt.  It is used for balancing
- * slab reclaim versus page reclaim.
+ * If the vm pressure is high, shrink the slabs more.
  *
  * Returns the number of slab objects which we shrunk.
  */
-static int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
-			unsigned long lru_pages)
+static int shrink_slab(gfp_t gfp_mask)
 {
 	struct shrinker *shrinker;
-	int ret = 0;
-
-	if (scanned == 0)
-		scanned = SWAP_CLUSTER_MAX;
+	struct pglist_data *pgdat;
+	struct zone *zone;
+	int n;
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 1;	/* Assume we'll be able to shrink next time */
 
-	list_for_each_entry(shrinker, &shrinker_list, list) {
-		unsigned long long delta;
-		unsigned long total_scan;
-		unsigned long max_pass = (*shrinker->shrinker)(0, gfp_mask);
-
-		delta = (4 * scanned) / shrinker->seeks;
-		delta *= max_pass;
-		do_div(delta, lru_pages + 1);
-		shrinker->nr += delta;
-		if (shrinker->nr < 0) {
-			printk(KERN_ERR "%s: nr=%ld\n",
-					__FUNCTION__, shrinker->nr);
-			shrinker->nr = max_pass;
-		}
+	/* find the major zone for the slabs to catch up age with */
+	pgdat = NODE_DATA(numa_node_id());
+	zone = pgdat->node_zones;
+	for (n = 1; n < pgdat->nr_zones; n++) {
+		struct zone *z = pgdat->node_zones + n;
 
-		/*
-		 * Avoid risking looping forever due to too large nr value:
-		 * never try to free more than twice the estimate number of
-		 * freeable entries.
-		 */
-		if (shrinker->nr > max_pass * 2)
-			shrinker->nr = max_pass * 2;
-
-		total_scan = shrinker->nr;
-		shrinker->nr = 0;
+		if (zone->present_pages < z->present_pages)
+			zone = z;
+	}
 
-		while (total_scan >= SHRINK_BATCH) {
-			long this_scan = SHRINK_BATCH;
-			int shrink_ret;
+	n = 0;
+	list_for_each_entry(shrinker, &shrinker_list, list) {
+		while (pages_more_aged(zone, shrinker)) {
 			int nr_before;
+			int nr_after;
 
 			nr_before = (*shrinker->shrinker)(0, gfp_mask);
-			shrink_ret = (*shrinker->shrinker)(this_scan, gfp_mask);
-			if (shrink_ret == -1)
+			if (nr_before <= SHRINK_BATCH * zone->prev_priority)
+				break;
+
+			nr_after = (*shrinker->shrinker)(SHRINK_BATCH, gfp_mask);
+			if (nr_after == -1)
 				break;
-			if (shrink_ret < nr_before) {
-				ret += nr_before - shrink_ret;
-				shrinker_stat_add(shrinker, nr_freed,
-					(nr_before - shrink_ret));
+
+			if (nr_after < nr_before) {
+				int nr_freed = nr_before - nr_after;
+
+				n += nr_freed;
+				shrinker_stat_add(shrinker, nr_freed, nr_freed);
 			}
-			shrinker_stat_add(shrinker, nr_req, this_scan);
-			mod_page_state(slabs_scanned, this_scan);
-			total_scan -= this_scan;
+			shrinker_stat_add(shrinker, nr_req, SHRINK_BATCH);
+			mod_page_state(slabs_scanned, SHRINK_BATCH);
+			update_slab_age(shrinker, nr_before * DEF_PRIORITY,
+						SHRINK_BATCH * shrinker->seeks *
+							zone->prev_priority);
 
 			cond_resched();
 		}
-
-		shrinker->nr += total_scan;
 	}
 	up_read(&shrinker_rwsem);
-	return ret;
+	return n;
 }
 
 /* Called without lock on whether page is mapped, so answer is unstable */
@@ -446,11 +479,6 @@ static int shrink_list(struct list_head 
 
 		BUG_ON(PageActive(page));
 
-		sc->nr_scanned++;
-		/* Double the slab pressure for mapped and swapcache pages */
-		if (page_mapped(page) || PageSwapCache(page))
-			sc->nr_scanned++;
-
 		if (PageWriteback(page))
 			goto keep_locked;
 
@@ -894,11 +922,13 @@ static void shrink_cache(struct zone *zo
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
+		update_zone_age(zone, nr_scan);
 		spin_unlock_irq(&zone->lru_lock);
 
 		if (nr_taken == 0)
 			goto done;
 
+		sc->nr_scanned += nr_scan;
 		max_scan -= nr_scan;
 		if (current_is_kswapd())
 			mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
@@ -1101,12 +1131,7 @@ shrink_zone(struct zone *zone, struct sc
 	else
 		nr_active = 0;
 
-	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
-	nr_inactive = zone->nr_scan_inactive;
-	if (nr_inactive >= sc->swap_cluster_max)
-		zone->nr_scan_inactive = 0;
-	else
-		nr_inactive = 0;
+	nr_inactive = (zone->nr_inactive >> sc->priority) + 1;
 
 	sc->nr_to_reclaim = sc->swap_cluster_max;
 
@@ -1153,6 +1178,7 @@ static void
 shrink_caches(struct zone **zones, struct scan_control *sc)
 {
 	int i;
+	struct zone *z = NULL;
 
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
@@ -1170,8 +1196,31 @@ shrink_caches(struct zone **zones, struc
 		if (zone->all_unreclaimable && sc->priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
+		/*
+		 * Balance page aging in local zones and following headless
+		 * zones in the first two rounds of direct reclaim.
+		 */
+		if (sc->priority > DEF_PRIORITY - 2) {
+			if (zone->zone_pgdat != zones[0]->zone_pgdat) {
+				cpumask_t cpu = node_to_cpumask(
+						zone->zone_pgdat->node_id);
+				if (!cpus_empty(cpu))
+					break;
+			}
+
+			if (!z)
+				z = zone;
+			else if (pages_more_aged(z, zone))
+				z = zone;
+
+			continue;
+		}
+
 		shrink_zone(zone, sc);
 	}
+
+	if (z)
+		shrink_zone(z, sc);
 }
  
 /*
@@ -1194,7 +1243,6 @@ int try_to_free_pages(struct zone **zone
 	int total_scanned = 0, total_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
-	unsigned long lru_pages = 0;
 	int i;
 
 	delay_prefetch();
@@ -1212,7 +1260,6 @@ int try_to_free_pages(struct zone **zone
 			continue;
 
 		zone->temp_priority = DEF_PRIORITY;
-		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
@@ -1222,7 +1269,7 @@ int try_to_free_pages(struct zone **zone
 		sc.priority = priority;
 		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 		shrink_caches(zones, &sc);
-		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
+		shrink_slab(gfp_mask);
 		if (reclaim_state) {
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
@@ -1296,6 +1343,23 @@ static int balance_pgdat(pg_data_t *pgda
 	int total_scanned, total_reclaimed;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
+	struct zone *youngest_zone;
+	struct zone *oldest_zone;
+
+	youngest_zone = oldest_zone = NULL;
+	for (i = 0; i < pgdat->nr_zones; i++) {
+		struct zone *zone = pgdat->node_zones + i;
+
+		if (zone->present_pages == 0)
+			continue;
+
+		if (!oldest_zone)
+			youngest_zone = oldest_zone = zone;
+		else if (pages_more_aged(zone, oldest_zone))
+			oldest_zone = zone;
+		else if (pages_more_aged(youngest_zone, zone))
+			youngest_zone = zone;
+	}
 
 loop_again:
 	total_scanned = 0;
@@ -1314,9 +1378,6 @@ loop_again:
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		unsigned long lru_pages = 0;
-		int first_low_zone = 0;
-
 		all_zones_ok = 1;
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
@@ -1331,13 +1392,17 @@ loop_again:
 				continue;
 
 			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone_watermark_ok(zone, order,
-					zone->pages_high, first_low_zone, 0))
+				if (!zone_watermark_ok(zone, order,
+							zone->pages_high,
+							0, 0)) {
+					all_zones_ok = 0;
+				} else if (zone == youngest_zone &&
+						pages_more_aged(oldest_zone,
+								youngest_zone)) {
+					/* if (priority > DEF_PRIORITY - 2) */
+						/* all_zones_ok = 0; */
+				} else
 					continue;
-
-				all_zones_ok = 0;
-				if (first_low_zone < i)
-					first_low_zone = i;
 			}
 
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
@@ -1346,7 +1411,6 @@ loop_again:
 			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
-			lru_pages += zone->nr_active + zone->nr_inactive;
 
 			atomic_inc(&zone->reclaim_in_progress);
 			shrink_zone(zone, &sc);
@@ -1357,7 +1421,7 @@ loop_again:
 				zone->all_unreclaimable = 1;
 		}
 		reclaim_state->reclaimed_slab = 0;
-		shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
+		shrink_slab(GFP_KERNEL);
 		sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 		total_reclaimed += sc.nr_reclaimed;
 		total_scanned += sc.nr_scanned;

--
