Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263878AbSIQH5v>; Tue, 17 Sep 2002 03:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263881AbSIQH5v>; Tue, 17 Sep 2002 03:57:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:60606 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263878AbSIQH5p>;
	Tue, 17 Sep 2002 03:57:45 -0400
Message-ID: <3D86E19B.6476A9EA@digeo.com>
Date: Tue, 17 Sep 2002 01:02:35 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
References: <3D86BE4F.75C9B6CC@digeo.com> <Pine.LNX.4.44.0209170726050.19523-100000@localhost.localdomain> <20020917072716.GN3530@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 08:02:36.0281 (UTC) FILETIME=[95AB9690:01C25E20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> The extreme configurations of my machines put a great deal of stress on
> many codepaths.

Nevertheless, the issue you raised is valid.

Should direct reclaim reach across and reclaim from other nodes, or not?

If so, when?

I suspect that it shouldn't.  Direct reclaim is increasingly
last-resort and only seems to happen (now) with stresstest-type
workloads, and when there is latency in getting kswapd up and
running.

I'd suggest that the balancing of other nodes be left in the
hands of kswapd and that the fallback logic be isolated to the
page allocation path.

The current kswapd logic is all tangled up with direct reclaim.
I've split this up, so that we can balance these two different
functions.  Code passes initial stresstesting; there may be corner
cases.






There is some lack of clarity in what kswapd does and what
direct-reclaim tasks do; try_to_free_pages() tries to service both
functions, and they are different.

- kswapd's role is to keep all zones on its node at

         zone->free_pages >= zone->pages_high.

and to never stop as long as any zones do not meet that condition.

- A direct reclaimer's role is to try to free some pages from the
  zones which are suitable for this particular allocation request, and
  to return when that has been achieved, or when all the relevant zones
  are at

	zone->free_pages >= zone->pages_high.


The patch explicitly separates these two code paths; kswapd does not
run try_to_free_pages() any more.  kswapd should not be aware of zone
fallbacks.



 include/linux/mmzone.h |    1 
 mm/page_alloc.c        |    3 
 mm/vmscan.c            |  238 +++++++++++++++++++++++--------------------------
 3 files changed, 116 insertions(+), 126 deletions(-)

--- 2.5.35/mm/vmscan.c~per-zone-vm	Tue Sep 17 00:23:57 2002
+++ 2.5.35-akpm/mm/vmscan.c	Tue Sep 17 00:59:47 2002
@@ -109,7 +109,8 @@ struct vmstats {
 	int refiled_nonfreeable;
 	int refiled_no_mapping;
 	int refiled_nofs;
-	int refiled_congested;
+	int refiled_congested_kswapd;
+	int refiled_congested_non_kswapd;
 	int written_back;
 	int refiled_writeback;
 	int refiled_writeback_nofs;
@@ -122,15 +123,19 @@ struct vmstats {
 	int refill_refiled;
 } vmstats;
 
+
+/*
+ * shrink_list returns the number of reclaimed pages
+ */
 static /* inline */ int
-shrink_list(struct list_head *page_list, int nr_pages,
-		unsigned int gfp_mask, int *max_scan, int *nr_mapped)
+shrink_list(struct list_head *page_list, unsigned int gfp_mask,
+		int *max_scan, int *nr_mapped)
 {
 	struct address_space *mapping;
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
-	const int nr_pages_in = nr_pages;
 	int pgactivate = 0;
+	int ret = 0;
 
 	pagevec_init(&freed_pvec);
 	while (!list_empty(page_list)) {
@@ -268,7 +273,10 @@ shrink_list(struct list_head *page_list,
 			bdi = mapping->backing_dev_info;
 			if (bdi != current->backing_dev_info &&
 					bdi_write_congested(bdi)){
-				vmstats.refiled_congested++;
+				if (current->flags & PF_KSWAPD)
+					vmstats.refiled_congested_kswapd++;
+				else
+					vmstats.refiled_congested_non_kswapd++;
 				goto keep_locked;
 			}
 
@@ -336,7 +344,7 @@ shrink_list(struct list_head *page_list,
 		__put_page(page);	/* The pagecache ref */
 free_it:
 		unlock_page(page);
-		nr_pages--;
+		ret++;
 		vmstats.reclaimed++;
 		if (!pagevec_add(&freed_pvec, page))
 			__pagevec_release_nonlru(&freed_pvec);
@@ -354,11 +362,11 @@ keep:
 	list_splice(&ret_pages, page_list);
 	if (pagevec_count(&freed_pvec))
 		__pagevec_release_nonlru(&freed_pvec);
-	mod_page_state(pgsteal, nr_pages_in - nr_pages);
+	mod_page_state(pgsteal, ret);
 	if (current->flags & PF_KSWAPD)
-		mod_page_state(kswapd_steal, nr_pages_in - nr_pages);
+		mod_page_state(kswapd_steal, ret);
 	mod_page_state(pgactivate, pgactivate);
-	return nr_pages;
+	return ret;
 }
 
 /*
@@ -367,18 +375,19 @@ keep:
  * not freed will be added back to the LRU.
  *
  * shrink_cache() is passed the number of pages to try to free, and returns
- * the number which are yet-to-free.
+ * the number of pages which were reclaimed.
  *
  * For pagecache intensive workloads, the first loop here is the hottest spot
  * in the kernel (apart from the copy_*_user functions).
  */
 static /* inline */ int
-shrink_cache(int nr_pages, struct zone *zone,
+shrink_cache(const int nr_pages, struct zone *zone,
 		unsigned int gfp_mask, int max_scan, int *nr_mapped)
 {
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
 	int nr_to_process;
+	int ret = 0;
 
 	/*
 	 * Try to ensure that we free `nr_pages' pages in one pass of the loop.
@@ -391,10 +400,11 @@ shrink_cache(int nr_pages, struct zone *
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
-	while (max_scan > 0 && nr_pages > 0) {
+	while (max_scan > 0 && ret < nr_pages) {
 		struct page *page;
 		int nr_taken = 0;
 		int nr_scan = 0;
+		int nr_freed;
 
 		while (nr_scan++ < nr_to_process &&
 				!list_empty(&zone->inactive_list)) {
@@ -425,10 +435,10 @@ shrink_cache(int nr_pages, struct zone *
 
 		max_scan -= nr_scan;
 		mod_page_state(pgscan, nr_scan);
-		nr_pages = shrink_list(&page_list, nr_pages,
-				gfp_mask, &max_scan, nr_mapped);
-
-		if (nr_pages <= 0 && list_empty(&page_list))
+		nr_freed = shrink_list(&page_list, gfp_mask,
+					&max_scan, nr_mapped);
+		ret += nr_freed;
+		if (nr_freed <= 0 && list_empty(&page_list))
 			goto done;
 
 		spin_lock_irq(&zone->lru_lock);
@@ -454,7 +464,7 @@ shrink_cache(int nr_pages, struct zone *
 	spin_unlock_irq(&zone->lru_lock);
 done:
 	pagevec_release(&pvec);
-	return nr_pages;	
+	return ret;
 }
 
 /*
@@ -578,9 +588,14 @@ refill_inactive_zone(struct zone *zone, 
 	mod_page_state(pgdeactivate, pgdeactivate);
 }
 
+/*
+ * Try to reclaim `nr_pages' from this zone.  Returns the number of reclaimed
+ * pages.  This is a basic per-zone page freer.  Used by both kswapd and
+ * direct reclaim.
+ */
 static /* inline */ int
-shrink_zone(struct zone *zone, int max_scan,
-		unsigned int gfp_mask, int nr_pages, int *nr_mapped)
+shrink_zone(struct zone *zone, int max_scan, unsigned int gfp_mask,
+		const int nr_pages, int *nr_mapped)
 {
 	unsigned long ratio;
 
@@ -601,36 +616,60 @@ shrink_zone(struct zone *zone, int max_s
 		atomic_sub(SWAP_CLUSTER_MAX, &zone->refill_counter);
 		refill_inactive_zone(zone, SWAP_CLUSTER_MAX);
 	}
-	nr_pages = shrink_cache(nr_pages, zone, gfp_mask,
-				max_scan, nr_mapped);
-	return nr_pages;
+	return shrink_cache(nr_pages, zone, gfp_mask, max_scan, nr_mapped);
+}
+
+/*
+ * FIXME: don't do this for ZONE_HIGHMEM
+ */
+/*
+ * Here we assume it costs one seek to replace a lru page and that it also
+ * takes a seek to recreate a cache object.  With this in mind we age equal
+ * percentages of the lru and ageable caches.  This should balance the seeks
+ * generated by these structures.
+ *
+ * NOTE: for now I do this for all zones.  If we find this is too aggressive
+ * on large boxes we may want to exclude ZONE_HIGHMEM.
+ *
+ * If we're encountering mapped pages on the LRU then increase the pressure on
+ * slab to avoid swapping.
+ */
+static void shrink_slab(int total_scanned, int gfp_mask)
+{
+	int shrink_ratio;
+	int pages = nr_used_zone_pages();
+
+	shrink_ratio = (pages / (total_scanned + 1)) + 1;
+	shrink_dcache_memory(shrink_ratio, gfp_mask);
+	shrink_icache_memory(shrink_ratio, gfp_mask);
+	shrink_dqcache_memory(shrink_ratio, gfp_mask);
 }
 
+/*
+ * This is the direct reclaim path, for page-allocating processes.  We only
+ * try to reclaim pages from zones which will satisfy the caller's allocation
+ * request.
+ */
 static int
 shrink_caches(struct zone *classzone, int priority,
-		int *total_scanned, int gfp_mask, int nr_pages)
+		int *total_scanned, int gfp_mask, const int nr_pages)
 {
 	struct zone *first_classzone;
 	struct zone *zone;
-	int ratio;
 	int nr_mapped = 0;
-	int pages = nr_used_zone_pages();
+	int ret = 0;
 
 	first_classzone = classzone->zone_pgdat->node_zones;
 	for (zone = classzone; zone >= first_classzone; zone--) {
 		int max_scan;
 		int to_reclaim;
-		int unreclaimed;
 
 		to_reclaim = zone->pages_high - zone->free_pages;
 		if (to_reclaim < 0)
 			continue;	/* zone has enough memory */
 
-		if (to_reclaim > SWAP_CLUSTER_MAX)
-			to_reclaim = SWAP_CLUSTER_MAX;
-
-		if (to_reclaim < nr_pages)
-			to_reclaim = nr_pages;
+		to_reclaim = min(to_reclaim, SWAP_CLUSTER_MAX);
+		to_reclaim = max(to_reclaim, nr_pages);
 
 		/*
 		 * If we cannot reclaim `nr_pages' pages by scanning twice
@@ -639,33 +678,18 @@ shrink_caches(struct zone *classzone, in
 		max_scan = zone->nr_inactive >> priority;
 		if (max_scan < to_reclaim * 2)
 			max_scan = to_reclaim * 2;
-		unreclaimed = shrink_zone(zone, max_scan,
-				gfp_mask, to_reclaim, &nr_mapped);
-		nr_pages -= to_reclaim - unreclaimed;
+		ret += shrink_zone(zone, max_scan, gfp_mask,
+				to_reclaim, &nr_mapped);
 		*total_scanned += max_scan;
+		*total_scanned += nr_mapped;
+		if (ret >= nr_pages)
+			break;
 	}
-
-	/*
-	 * Here we assume it costs one seek to replace a lru page and that
-	 * it also takes a seek to recreate a cache object.  With this in
-	 * mind we age equal percentages of the lru and ageable caches.
-	 * This should balance the seeks generated by these structures.
-	 *
-	 * NOTE: for now I do this for all zones.  If we find this is too
-	 * aggressive on large boxes we may want to exclude ZONE_HIGHMEM
-	 *
-	 * If we're encountering mapped pages on the LRU then increase the
-	 * pressure on slab to avoid swapping.
-	 */
-	ratio = (pages / (*total_scanned + nr_mapped + 1)) + 1;
-	shrink_dcache_memory(ratio, gfp_mask);
-	shrink_icache_memory(ratio, gfp_mask);
-	shrink_dqcache_memory(ratio, gfp_mask);
-	return nr_pages;
+	return ret;
 }
 
 /*
- * This is the main entry point to page reclaim.
+ * This is the main entry point to direct page reclaim.
  *
  * If a full scan of the inactive list fails to free enough memory then we
  * are "out of memory" and something needs to be killed.
@@ -685,17 +709,18 @@ int
 try_to_free_pages(struct zone *classzone,
 		unsigned int gfp_mask, unsigned int order)
 {
-	int priority = DEF_PRIORITY;
-	int nr_pages = SWAP_CLUSTER_MAX;
+	int priority;
+	const int nr_pages = SWAP_CLUSTER_MAX;
+	int nr_reclaimed = 0;
 
 	inc_page_state(pageoutrun);
 
 	for (priority = DEF_PRIORITY; priority; priority--) {
 		int total_scanned = 0;
 
-		nr_pages = shrink_caches(classzone, priority, &total_scanned,
-					gfp_mask, nr_pages);
-		if (nr_pages <= 0)
+		nr_reclaimed += shrink_caches(classzone, priority,
+					&total_scanned, gfp_mask, nr_pages);
+		if (nr_reclaimed >= nr_pages)
 			return 1;
 		if (total_scanned == 0)
 			return 1;	/* All zones had enough free memory */
@@ -710,62 +735,46 @@ try_to_free_pages(struct zone *classzone
 
 		/* Take a nap, wait for some writeback to complete */
 		blk_congestion_wait(WRITE, HZ/4);
+		shrink_slab(total_scanned, gfp_mask);
 	}
 	if (gfp_mask & __GFP_FS)
 		out_of_memory();
 	return 0;
 }
 
-static int check_classzone_need_balance(struct zone *classzone)
+/*
+ * kswapd will work across all this node's zones until they are all at
+ * pages_high.
+ */
+static void kswapd_balance_pgdat(pg_data_t *pgdat)
 {
-	struct zone *first_classzone;
+	int priority = DEF_PRIORITY;
+	int i;
 
-	first_classzone = classzone->zone_pgdat->node_zones;
-	while (classzone >= first_classzone) {
-		if (classzone->free_pages > classzone->pages_high)
-			return 0;
-		classzone--;
-	}
-	return 1;
-}
+	for (priority = DEF_PRIORITY; priority; priority--) {
+		int success = 1;
 
-static int kswapd_balance_pgdat(pg_data_t * pgdat)
-{
-	int need_more_balance = 0, i;
-	struct zone *zone;
+		for (i = 0; i < pgdat->nr_zones; i++) {
+			struct zone *zone = pgdat->node_zones + i;
+			int nr_mapped = 0;
+			int max_scan;
+			int to_reclaim;
 
-	for (i = pgdat->nr_zones-1; i >= 0; i--) {
-		zone = pgdat->node_zones + i;
-		cond_resched();
-		if (!zone->need_balance)
-			continue;
-		if (!try_to_free_pages(zone, GFP_KSWAPD, 0)) {
-			zone->need_balance = 0;
-			__set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ);
-			continue;
+			to_reclaim = zone->pages_high - zone->free_pages;
+			if (to_reclaim <= 0)
+				continue;
+			success = 0;
+			max_scan = zone->nr_inactive >> priority;
+			if (max_scan < to_reclaim * 2)
+				max_scan = to_reclaim * 2;
+			shrink_zone(zone, max_scan, GFP_KSWAPD,
+					to_reclaim, &nr_mapped);
+			shrink_slab(max_scan + nr_mapped, GFP_KSWAPD);
 		}
-		if (check_classzone_need_balance(zone))
-			need_more_balance = 1;
-		else
-			zone->need_balance = 0;
-	}
-
-	return need_more_balance;
-}
-
-static int kswapd_can_sleep_pgdat(pg_data_t * pgdat)
-{
-	struct zone *zone;
-	int i;
-
-	for (i = pgdat->nr_zones-1; i >= 0; i--) {
-		zone = pgdat->node_zones + i;
-		if (zone->need_balance)
-			return 0;
+		if (success)
+			break;	/* All zones are at pages_high */
+		blk_congestion_wait(WRITE, HZ/4);
 	}
-
-	return 1;
 }
 
 /*
@@ -785,7 +794,7 @@ int kswapd(void *p)
 {
 	pg_data_t *pgdat = (pg_data_t*)p;
 	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	DEFINE_WAIT(wait);
 
 	daemonize();
 	set_cpus_allowed(tsk, __node_to_cpu_mask(p->node_id));
@@ -806,27 +815,12 @@ int kswapd(void *p)
 	 */
 	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
 
-	/*
-	 * Kswapd main loop.
-	 */
-	for (;;) {
+	for ( ; ; ) {
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
-		__set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&pgdat->kswapd_wait, &wait);
-
-		mb();
-		if (kswapd_can_sleep_pgdat(pgdat))
-			schedule();
-
-		__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&pgdat->kswapd_wait, &wait);
-
-		/*
-		 * If we actually get into a low-memory situation,
-		 * the processes needing more memory will wake us
-		 * up on a more timely basis.
-		 */
+		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&pgdat->kswapd_wait, &wait);
 		kswapd_balance_pgdat(pgdat);
 		blk_run_queues();
 	}
--- 2.5.35/mm/page_alloc.c~per-zone-vm	Tue Sep 17 00:23:57 2002
+++ 2.5.35-akpm/mm/page_alloc.c	Tue Sep 17 00:23:57 2002
@@ -343,8 +343,6 @@ __alloc_pages(unsigned int gfp_mask, uns
 		}
 	}
 
-	classzone->need_balance = 1;
-	mb();
 	/* we're somewhat low on memory, failed to find what we needed */
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *z = zones[i];
@@ -869,7 +867,6 @@ void __init free_area_init_core(pg_data_
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
-		zone->need_balance = 0;
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
 		atomic_set(&zone->refill_counter, 0);
--- 2.5.35/include/linux/mmzone.h~per-zone-vm	Tue Sep 17 00:23:57 2002
+++ 2.5.35-akpm/include/linux/mmzone.h	Tue Sep 17 00:23:57 2002
@@ -62,7 +62,6 @@ struct zone {
 	spinlock_t		lock;
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
-	int			need_balance;
 
 	ZONE_PADDING(_pad1_)
 

.
