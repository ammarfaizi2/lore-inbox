Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWCTLwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWCTLwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWCTLwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:52:05 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:18668 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750753AbWCTLwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:52:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][1/3] mm: swsusp shrink_all_memory tweaks
Date: Mon, 20 Mar 2006 22:50:14 +1100
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Rafael Wysocki <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, linux-mm@kvack.org
References: <200603200231.50666.kernel@kolivas.org> <441E94FA.8070408@yahoo.com.au>
In-Reply-To: <441E94FA.8070408@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603202250.14843.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 March 2006 22:41, Nick Piggin wrote:
> I still don't like this change.

Fine.

Respin.

Cheers,
Con
---
This patch is a rewrite of the shrink_all_memory function used by swsusp
prior to suspending to disk.

The special hooks into balance_pgdat for shrink_all_memory have been removed
thus simplifying that function significantly.

Some code will now be compiled out in the !CONFIG_PM case.

shrink_all_memory now uses shrink_zone and shrink_slab directly with an extra
entry in the struct scan_control suspend_pass. This is used to alter what
lists will be shrunk by shrink_zone on successive passes. The aim of this is
to alter the reclaim logic to choose the best pages to keep on resume, to
free the minimum amount of memory required to suspend and free the memory
faster.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 kernel/power/swsusp.c |   10 ---
 mm/vmscan.c           |  154 ++++++++++++++++++++++++++++++--------------------
 2 files changed, 97 insertions(+), 67 deletions(-)

Index: linux-2.6.16-rc6-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/mm/vmscan.c	2006-03-20 22:44:10.000000000 +1100
+++ linux-2.6.16-rc6-mm2/mm/vmscan.c	2006-03-20 22:46:54.000000000 +1100
@@ -62,8 +62,33 @@ struct scan_control {
 	 * In this context, it doesn't matter that we scan the
 	 * whole list at once. */
 	int swap_cluster_max;
+
+#ifdef CONFIG_PM
+	/*
+	 * If we're doing suspend to disk, what pass is this.
+	 * We decrement to allow code to transparently do normal reclaim
+	 * without explicitly setting it to 0.
+	 *
+	 * 4 = Reclaim from inactive_list only
+	 * 3 = Reclaim from active list but don't reclaim mapped
+	 * 2 = 2nd pass of type 2
+	 * 1 = Reclaim mapped (normal reclaim)
+	 * 0 = 2nd pass of type 1
+	 */
+	int suspend_pass;
+#endif
 };
 
+/*
+ * When scanning for the swsusp function shrink_all_memory we only shrink
+ * active lists on the 2nd pass.
+ */
+#ifdef CONFIG_PM
+#define suspend_scan_active(sc)	((sc)->suspend_pass < 4)
+#else
+#define suspend_scan_active(sc)	1
+#endif
+
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
 #ifdef ARCH_HAS_PREFETCH
@@ -840,7 +865,8 @@ static void shrink_active_list(unsigned 
 }
 
 /*
- * This is a basic per-zone page freer.  Used by both kswapd and direct reclaim.
+ * This is a basic per-zone page freer.  Used by kswapd, direct reclaim and
+ * the swsusp specific shrink_all_memory functions.
  */
 static unsigned long shrink_zone(int priority, struct zone *zone,
 				struct scan_control *sc)
@@ -858,7 +884,7 @@ static unsigned long shrink_zone(int pri
 	 */
 	zone->nr_scan_active += (zone->nr_active >> priority) + 1;
 	nr_active = zone->nr_scan_active;
-	if (nr_active >= sc->swap_cluster_max)
+	if (nr_active >= sc->swap_cluster_max && suspend_scan_active(sc))
 		zone->nr_scan_active = 0;
 	else
 		nr_active = 0;
@@ -1029,10 +1055,6 @@ out:
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
@@ -1050,10 +1072,8 @@ out:
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
@@ -1063,7 +1083,7 @@ static unsigned long balance_pgdat(pg_da
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_swap = 1,
-		.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX,
+		.swap_cluster_max = SWAP_CLUSTER_MAX,
 	};
 
 loop_again:
@@ -1090,31 +1110,27 @@ loop_again:
 
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
+			if (zone->all_unreclaimable &&
+					priority != DEF_PRIORITY)
+				continue;
 
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, 0, 0)) {
-					end_zone = i;
-					goto scan;
-				}
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
@@ -1141,11 +1157,9 @@ scan:
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
@@ -1170,8 +1184,6 @@ scan:
 			    total_scanned > nr_reclaimed + nr_reclaimed / 2)
 				sc.may_writepage = 1;
 		}
-		if (nr_pages && to_free > nr_reclaimed)
-			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
 			break;		/* kswapd: all done */
 		/*
@@ -1187,7 +1199,7 @@ scan:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
-		if ((nr_reclaimed >= SWAP_CLUSTER_MAX) && !nr_pages)
+		if (nr_reclaimed >= SWAP_CLUSTER_MAX)
 			break;
 	}
 out:
@@ -1269,7 +1281,7 @@ static int kswapd(void *p)
 		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0, order);
+		balance_pgdat(pgdat, order);
 	}
 	return 0;
 }
@@ -1299,36 +1311,58 @@ void wakeup_kswapd(struct zone *zone, in
 #ifdef CONFIG_PM
 /*
  * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
- * pages.
+ * pages. It does this via shrink_zone in passes. Rather than trying to age
+ * LRUs the aim is to preserve the overall LRU order by reclaiming
+ * preferentially inactive > active > active referenced > active mapped
  */
 unsigned long shrink_all_memory(unsigned long nr_pages)
 {
-	pg_data_t *pgdat;
-	unsigned long nr_to_free = nr_pages;
 	unsigned long ret = 0;
-	unsigned retry = 2;
-	struct reclaim_state reclaim_state = {
-		.reclaimed_slab = 0,
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.may_swap = 1,
+		.swap_cluster_max = nr_pages,
+		.suspend_pass = 4,
+		.may_writepage = 1,
 	};
 
 	delay_swap_prefetch();
 
-	current->reclaim_state = &reclaim_state;
-repeat:
-	for_each_online_pgdat(pgdat) {
-		unsigned long freed;
+	do {
+		int priority;
 
-		freed = balance_pgdat(pgdat, nr_to_free, 0);
-		ret += freed;
-		nr_to_free -= freed;
-		if ((long)nr_to_free <= 0)
-			break;
-	}
-	if (retry-- && ret < nr_pages) {
-		blk_congestion_wait(WRITE, HZ/5);
-		goto repeat;
-	}
-	current->reclaim_state = NULL;
+		for (priority = DEF_PRIORITY; priority >= 0; priority--) {
+			struct zone *zone;
+			unsigned long lru_pages = 0;
+
+			for_each_zone(zone) {
+				unsigned long freed;
+
+				if (!populated_zone(zone))
+					continue;
+
+				if (zone->all_unreclaimable &&
+				    priority != DEF_PRIORITY)
+					continue;
+
+				lru_pages += zone->nr_active +
+					zone->nr_inactive;
+				/*
+				 * shrink_active_list needs this to reclaim
+				 * mapped pages
+				 */
+				if (sc.suspend_pass < 2)
+					zone->prev_priority = 0;
+				freed = shrink_zone(priority, zone, &sc);
+				ret += freed;
+				if (ret > nr_pages)
+					goto out;
+			}
+			shrink_slab(0, sc.gfp_mask, lru_pages);
+		}
+		blk_congestion_wait(WRITE, HZ / 5);
+	} while (--sc.suspend_pass >= 0);
+out:
 	return ret;
 }
 #endif
Index: linux-2.6.16-rc6-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/power/swsusp.c	2006-03-20 22:44:10.000000000 +1100
+++ linux-2.6.16-rc6-mm2/kernel/power/swsusp.c	2006-03-20 22:46:12.000000000 +1100
@@ -173,9 +173,6 @@ void free_all_swap_pages(int swap, struc
  *	Notice: all userland should be stopped before it is called, or
  *	livelock is possible.
  */
-
-#define SHRINK_BITE	10000
-
 int swsusp_shrink_memory(void)
 {
 	long size, tmp;
@@ -194,14 +191,13 @@ int swsusp_shrink_memory(void)
 		for_each_zone (zone)
 			if (!is_highmem(zone))
 				tmp -= zone->free_pages;
+		if (tmp <= 0)
+			tmp = size - image_size / PAGE_SIZE;
 		if (tmp > 0) {
-			tmp = shrink_all_memory(SHRINK_BITE);
+			tmp = shrink_all_memory(tmp);
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
-		} else if (size > image_size / PAGE_SIZE) {
-			tmp = shrink_all_memory(SHRINK_BITE);
-			pages += tmp;
 		}
 		printk("\b%c", p[i++%4]);
 	} while (tmp > 0);
