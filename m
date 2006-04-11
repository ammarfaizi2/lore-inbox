Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWDKRHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWDKRHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWDKRHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:07:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:35289 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751021AbWDKRHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:07:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: shrink_all_memory tweaks (was: Re: Userland swsusp failure (mm-related))
Date: Tue, 11 Apr 2006 19:06:31 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Fabio Comolli <fabio.comolli@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604092236.45768.rjw@sisk.pl> <200604100923.24768.kernel@kolivas.org>
In-Reply-To: <200604100923.24768.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604111906.32535.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 10 April 2006 01:23, Con Kolivas wrote:
> On Monday 10 April 2006 06:36, Rafael J. Wysocki wrote:
> > Still I've been doing a crash course in mm internals recently and I can say
> > a bit more about your patch now. ;-)
> 
> Great.
> >
> > First, I agree that using balance_pgdat() for freeing memory by swsusp is
> > overkill, so the removal of its second argument seems to be a good idea to
> > me.  However, I'd rather avoid modifying struct scan_control and
> > shrink_zone() and reimplement the shrink_zone()'s logic directly in
> > shrink_all_memory(), with some modifications (eg. we can explicitly avoid
> > shrinking of the active list until we decide it's worth it) -- or we can
> > define a separate function for this purpose.
> 
> I was trying to reuse as much code as possible.
> 
> > Second, there are a couple of details I'd do in a different way.  For
> > example I think we should call shrink_slab() with the non-zero first
> > argument (otherwise it'll use SWAP_CLUSTER_MAX)
> 
> Sounds good.
> 
> > and instead of setting 
> > zone->prev_priority to 0 I'd set vm_swappiness to 100 temporarily
> > (or maybe l'd left it to the user to set swappiness before suspend?).
> 
> Probably can't rely on just the user setting. Setting priority to 0 is 
> explicit and overrides any swappiness setting which is a tunable. Priority 
> will recover by itself unlike swappiness which needs to be set and reset.
> 
> > Also I think we can try to avoid slab shrinking until we start to shrink
> > the active zone or IOW until we can't get any more pages from the inactive
> > list alone.
> 
> I tried that and it didn't shrink enough, but then that's because of the 
> SWAP_CLUSTER_MAX limit you mentioned above. But slab can be massive if you do 
> for example a lot of 'find's and shrinking slab doesn't affect the user 
> experence as much as shrinking the active/inactive lists.
> 
> > If you don't mind, I'll try to rework your patch a bit in accordance with
> > the above remarks in the next couple of days.
> 
> By all means :)

The patch is appended.

In shrink_all_memory() I try to free exactly as many pages as the caller asks
for, preferably in one shot, starting from easier targets.  If slabs are huge,
they are most likely to have enough pages to reclaim.  The inactive lists
are next (the zones with more inactive pages go first) etc.  However, since
each pass potentially requires more work, the number of pages to scan is
decreased as the pages are reclaimed which seems to make the shrinking
of memory go more smoothly.

I've been testing it on an x86_64 box for some time and it seems to behave
quite reasonably, eg. it usually makes the actual image size very close to
the value of image_size and if you set image_size to 0, it shrinks everything
almost totally.

Greetings,
Rafael

---
 kernel/power/swsusp.c |   10 +-
 mm/vmscan.c           |  211 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 164 insertions(+), 57 deletions(-)

Index: linux-2.6.17-rc1-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/vmscan.c
+++ linux-2.6.17-rc1-mm2/mm/vmscan.c
@@ -1031,10 +1031,6 @@ out:
  * For kswapd, balance_pgdat() will work across all this node's zones until
  * they are all at pages_high.
  *
- * If `nr_pages' is non-zero then it is the number of pages which are to be
- * reclaimed, regardless of the zone occupancies.  This is a software suspend
- * special.
- *
  * Returns the number of pages which were actually freed.
  *
  * There is special handling here for zones which are full of pinned pages.
@@ -1052,10 +1048,8 @@ out:
  * the page allocator fallback scheme to ensure that aging of pages is balanced
  * across the zones.
  */
-static unsigned long balance_pgdat(pg_data_t *pgdat, unsigned long nr_pages,
-				int order)
+static unsigned long balance_pgdat(pg_data_t *pgdat, int order)
 {
-	unsigned long to_free = nr_pages;
 	int all_zones_ok;
 	int priority;
 	int i;
@@ -1065,7 +1059,7 @@ static unsigned long balance_pgdat(pg_da
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_swap = 1,
-		.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX,
+		.swap_cluster_max = SWAP_CLUSTER_MAX,
 	};
 
 loop_again:
@@ -1092,31 +1086,27 @@ loop_again:
 
 		all_zones_ok = 1;
 
-		if (nr_pages == 0) {
-			/*
-			 * Scan in the highmem->dma direction for the highest
-			 * zone which needs scanning
-			 */
-			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
-				struct zone *zone = pgdat->node_zones + i;
+		/*
+		 * Scan in the highmem->dma direction for the highest
+		 * zone which needs scanning
+		 */
+		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
+			struct zone *zone = pgdat->node_zones + i;
 
-				if (!populated_zone(zone))
-					continue;
+			if (!populated_zone(zone))
+				continue;
 
-				if (zone->all_unreclaimable &&
-						priority != DEF_PRIORITY)
-					continue;
-
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, 0, 0)) {
-					end_zone = i;
-					goto scan;
-				}
+			if (zone->all_unreclaimable &&
+					priority != DEF_PRIORITY)
+				continue;
+
+			if (!zone_watermark_ok(zone, order, zone->pages_high,
+					       0, 0)) {
+				end_zone = i;
+				goto scan;
 			}
-			goto out;
-		} else {
-			end_zone = pgdat->nr_zones - 1;
 		}
+		goto out;
 scan:
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
@@ -1143,11 +1133,9 @@ scan:
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (nr_pages == 0) {	/* Not software suspend */
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, end_zone, 0))
-					all_zones_ok = 0;
-			}
+			if (!zone_watermark_ok(zone, order, zone->pages_high,
+					       end_zone, 0))
+				all_zones_ok = 0;
 			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
@@ -1172,8 +1160,6 @@ scan:
 			    total_scanned > nr_reclaimed + nr_reclaimed / 2)
 				sc.may_writepage = 1;
 		}
-		if (nr_pages && to_free > nr_reclaimed)
-			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
 			break;		/* kswapd: all done */
 		/*
@@ -1189,7 +1175,7 @@ scan:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
-		if ((nr_reclaimed >= SWAP_CLUSTER_MAX) && !nr_pages)
+		if (nr_reclaimed >= SWAP_CLUSTER_MAX)
 			break;
 	}
 out:
@@ -1271,7 +1257,7 @@ static int kswapd(void *p)
 		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0, order);
+		balance_pgdat(pgdat, order);
 	}
 	return 0;
 }
@@ -1300,37 +1286,152 @@ void wakeup_kswapd(struct zone *zone, in
 
 #ifdef CONFIG_PM
 /*
- * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
- * pages.
+ * Helper function for shrink_all_memory().  Tries to reclaim 'nr_pages' pages
+ * from LRU lists system-wide, for given pass and priority, and returns the
+ * number of reclaimed pages
+ *
+ * For pass > 3 we also try to shrink the LRU lists that contain a few pages
+ */
+unsigned long shrink_all_zones(unsigned long nr_pages, int pass, int prio,
+				struct scan_control *sc)
+{
+	struct zone *zone;
+	unsigned long nr_to_scan, ret = 0;
+
+	for_each_zone(zone) {
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone->all_unreclaimable && prio != DEF_PRIORITY)
+			continue;
+
+		/* For pass = 0 we don't shrink the active list */
+		if (pass > 0) {
+			zone->nr_scan_active += (zone->nr_active >> prio) + 1;
+			if (zone->nr_scan_active >= nr_pages || pass > 3) {
+				zone->nr_scan_active = 0;
+				nr_to_scan = min(nr_pages, zone->nr_active);
+				shrink_active_list(nr_to_scan, zone, sc);
+			}
+		}
+
+		zone->nr_scan_inactive += (zone->nr_inactive >> prio) + 1;
+		if (zone->nr_scan_inactive >= nr_pages || pass > 3) {
+			zone->nr_scan_inactive = 0;
+			nr_to_scan = min(nr_pages, zone->nr_inactive);
+			ret += shrink_inactive_list(nr_to_scan, zone, sc);
+			if (ret >= nr_pages)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Try to free `nr_pages' of memory, system-wide, and return the number of
+ * freed pages.
+ *
+ * Rather than trying to age LRUs the aim is to preserve the overall
+ * LRU order by reclaiming preferentially
+ * inactive > active > active referenced > active mapped
  */
 unsigned long shrink_all_memory(unsigned long nr_pages)
 {
-	pg_data_t *pgdat;
-	unsigned long nr_to_free = nr_pages;
+	unsigned long lru_pages, nr_slab;
 	unsigned long ret = 0;
-	unsigned retry = 2;
-	struct reclaim_state reclaim_state = {
-		.reclaimed_slab = 0,
+	int swappiness = vm_swappiness, pass;
+	struct reclaim_state reclaim_state;
+	struct zone *zone;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.may_swap = 1,
+		.swap_cluster_max = nr_pages,
+		.may_writepage = 1,
 	};
 
 	delay_swap_prefetch();
 
 	current->reclaim_state = &reclaim_state;
-repeat:
-	for_each_online_pgdat(pgdat) {
-		unsigned long freed;
 
-		freed = balance_pgdat(pgdat, nr_to_free, 0);
-		ret += freed;
-		nr_to_free -= freed;
-		if ((long)nr_to_free <= 0)
+	lru_pages = 0;
+	for_each_zone(zone)
+		lru_pages += zone->nr_active + zone->nr_inactive;
+	nr_slab = read_page_state(nr_slab);
+	/* If slab caches are huge, it's better to hit them first */
+	while (nr_slab >= lru_pages) {
+		reclaim_state.reclaimed_slab = 0;
+		shrink_slab(nr_pages, sc.gfp_mask, lru_pages);
+		if (!reclaim_state.reclaimed_slab)
 			break;
+
+		ret += reclaim_state.reclaimed_slab;
+		if (ret >= nr_pages)
+			goto out;
+
+		nr_slab -= reclaim_state.reclaimed_slab;
 	}
-	if (retry-- && ret < nr_pages) {
-		blk_congestion_wait(WRITE, HZ/5);
-		goto repeat;
+
+	/*
+	 * We try to shrink LRUs in 5 passes:
+	 * 0 = Reclaim from inactive_list only
+	 * 1 = Reclaim from active list but don't reclaim mapped
+	 * 2 = 2nd pass of type 1
+	 * 3 = Reclaim mapped (normal reclaim)
+	 * 4 = 2nd pass of type 3
+	 */
+	for (pass = 0; pass < 5; pass++) {
+		int prio;
+
+		/* Needed for shrinking slab caches later on */
+		if (!lru_pages)
+			for_each_zone(zone) {
+				lru_pages += zone->nr_active;
+				lru_pages += zone->nr_inactive;
+			}
+
+		/* Force reclaiming mapped pages in the passes #3 and #4 */
+		if (pass > 2)
+			vm_swappiness = 100;
+
+		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
+			unsigned long nr_to_scan = nr_pages - ret;
+
+			sc.nr_mapped = read_page_state(nr_mapped);
+			sc.nr_scanned = 0;
+
+			ret += shrink_all_zones(nr_to_scan, prio, pass, &sc);
+			if (ret >= nr_pages)
+				goto out;
+
+			reclaim_state.reclaimed_slab = 0;
+			shrink_slab(sc.nr_scanned, sc.gfp_mask, lru_pages);
+			ret += reclaim_state.reclaimed_slab;
+			if (ret >= nr_pages)
+				goto out;
+
+			if (sc.nr_scanned && prio < DEF_PRIORITY - 2)
+				blk_congestion_wait(WRITE, HZ / 10);
+		}
+
+		lru_pages = 0;
 	}
+
+	/*
+	 * If ret = 0, we could not shrink LRUs, but there may be something
+	 * in slab caches
+	 */
+	if (!ret)
+		do {
+			reclaim_state.reclaimed_slab = 0;
+			shrink_slab(nr_pages, sc.gfp_mask, lru_pages);
+			ret += reclaim_state.reclaimed_slab;
+		} while (ret < nr_pages && reclaim_state.reclaimed_slab > 0);
+
+out:
 	current->reclaim_state = NULL;
+	vm_swappiness = swappiness;
 	return ret;
 }
 #endif
Index: linux-2.6.17-rc1-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/kernel/power/swsusp.c
+++ linux-2.6.17-rc1-mm2/kernel/power/swsusp.c
@@ -175,6 +175,12 @@ void free_all_swap_pages(int swap, struc
  */
 
 #define SHRINK_BITE	10000
+static inline unsigned long __shrink_memory(long tmp)
+{
+	if (tmp > SHRINK_BITE)
+		tmp = SHRINK_BITE;
+	return shrink_all_memory(tmp);
+}
 
 int swsusp_shrink_memory(void)
 {
@@ -195,12 +201,12 @@ int swsusp_shrink_memory(void)
 			if (!is_highmem(zone))
 				tmp -= zone->free_pages;
 		if (tmp > 0) {
-			tmp = shrink_all_memory(SHRINK_BITE);
+			tmp = __shrink_memory(tmp);
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
 		} else if (size > image_size / PAGE_SIZE) {
-			tmp = shrink_all_memory(SHRINK_BITE);
+			tmp = __shrink_memory(size - (image_size / PAGE_SIZE));
 			pages += tmp;
 		}
 		printk("\b%c", p[i++%4]);
