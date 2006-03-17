Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWCQE2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWCQE2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWCQE2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:28:13 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:51344 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751265AbWCQE2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:28:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] swsusp reclaim tweaks was: Re: does swsusp suck after resume for you?
Date: Fri, 17 Mar 2006 15:28:05 +1100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>, ck@vds.kolivas.org,
       Stefan Seyfried <seife@suse.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603170833.27114.kernel@kolivas.org> <200603162315.09939.rjw@sisk.pl>
In-Reply-To: <200603162315.09939.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171528.05961.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2006 09:15 am, Rafael J. Wysocki wrote:
> On Thursday 16 March 2006 22:33, Con Kolivas wrote:
> > If so, I'd like to have a go at improving the free up ram vm
> > code to make it behave nicer after resume. I have some ideas about how
> > best to free up ram differently from normal reclaim which would improve
> > behaviour post resume.
>
> That sounds really good to me. :-)

Ok here is a kind of directed memory reclaim for swsusp which is different to
 ordinary memory reclaim. It reclaims memory in up to 4 passes with just
 shrink_zone, without hooking into balance_pgdat thereby simplifying that
 function as well. 

The passes are as follows:
 Reclaim from inactive_list only
 Reclaim from active list but don't reclaim mapped
 2nd pass of type 2
 Reclaim mapped

and it replaces the current shrink_all_memory() function in situ, being passed
 exactly the number of pages desired to be freed rather than doing it in
 little chunks. This allows the memory reclaiming code to decide how
 aggressively to delete pages on a per zone basis. This should leave slightly
 more ram intact and should bias the pages stored in ram better based on
 current active referenced->active not referenced->inactive lru. This should
 improve the state of the vm immediately after resume.

Works for me. Please feel free to test and comment. Patch for 2.6.16-rc6-mm1.

Cheers,
Con
---
 kernel/power/swsusp.c |   10 +--
 mm/vmscan.c           |  140 ++++++++++++++++++++++++++++----------------------
 2 files changed, 83 insertions(+), 67 deletions(-)

Index: linux-2.6.16-rc6-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/mm/vmscan.c	2006-03-14 13:53:19.000000000 +1100
+++ linux-2.6.16-rc6-mm1/mm/vmscan.c	2006-03-17 15:08:37.000000000 +1100
@@ -74,6 +74,15 @@ struct scan_control {
 	 * In this context, it doesn't matter that we scan the
 	 * whole list at once. */
 	int swap_cluster_max;
+
+	/*
+	 * If we're doing suspend to disk, what pass is this.
+	 * 3 = Reclaim from inactive_list only
+	 * 2 = Reclaim from active list but don't reclaim mapped
+	 * 1 = 2nd pass of type 2
+	 * 0 = Reclaim mapped
+	 */
+	int suspend;
 };
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
@@ -1345,7 +1354,7 @@ static unsigned long shrink_zone(int pri
 	 */
 	zone->nr_scan_active += (zone->nr_active >> priority) + 1;
 	nr_active = zone->nr_scan_active;
-	if (nr_active >= sc->swap_cluster_max)
+	if (nr_active >= sc->swap_cluster_max && sc->suspend < 3)
 		zone->nr_scan_active = 0;
 	else
 		nr_active = 0;
@@ -1402,6 +1411,7 @@ static unsigned long shrink_zones(int pr
 	unsigned long nr_reclaimed = 0;
 	int i;
 
+	sc->suspend = 0;
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
@@ -1422,7 +1432,12 @@ static unsigned long shrink_zones(int pr
 	}
 	return nr_reclaimed;
 }
- 
+
+#define for_each_priority(priority)	\
+	for (priority = DEF_PRIORITY;	\
+		priority >= 0;		\
+		priority--)
+
 /*
  * This is the main entry point to direct page reclaim.
  *
@@ -1466,7 +1481,7 @@ unsigned long try_to_free_pages(struct z
 		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
 
-	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
+	for_each_priority(priority) {
 		sc.nr_mapped = read_page_state(nr_mapped);
 		sc.nr_scanned = 0;
 		if (!priority)
@@ -1516,10 +1531,6 @@ out:
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
@@ -1537,10 +1548,8 @@ out:
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
@@ -1550,7 +1559,8 @@ static unsigned long balance_pgdat(pg_da
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_swap = 1,
-		.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX,
+		.swap_cluster_max = SWAP_CLUSTER_MAX,
+		.suspend = 0,
 	};
 
 loop_again:
@@ -1567,7 +1577,7 @@ loop_again:
 		zone->temp_priority = DEF_PRIORITY;
 	}
 
-	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
+	for_each_priority(priority) {
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
 
@@ -1577,31 +1587,27 @@ loop_again:
 
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
+			if (!zone_watermark_ok(zone, order,
+					zone->pages_high, 0, 0)) {
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
@@ -1628,11 +1634,9 @@ scan:
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (nr_pages == 0) {	/* Not software suspend */
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, end_zone, 0))
-					all_zones_ok = 0;
-			}
+			if (!zone_watermark_ok(zone, order,
+					zone->pages_high, end_zone, 0))
+				all_zones_ok = 0;
 			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
@@ -1657,8 +1661,6 @@ scan:
 			    total_scanned > nr_reclaimed + nr_reclaimed / 2)
 				sc.may_writepage = 1;
 		}
-		if (nr_pages && to_free > nr_reclaimed)
-			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
 			break;		/* kswapd: all done */
 		/*
@@ -1674,7 +1676,7 @@ scan:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
-		if ((nr_reclaimed >= SWAP_CLUSTER_MAX) && !nr_pages)
+		if ((nr_reclaimed >= SWAP_CLUSTER_MAX))
 			break;
 	}
 out:
@@ -1756,7 +1758,7 @@ static int kswapd(void *p)
 		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0, order);
+		balance_pgdat(pgdat, order);
 	}
 	return 0;
 }
@@ -1790,32 +1792,49 @@ void wakeup_kswapd(struct zone *zone, in
  */
 unsigned long shrink_all_memory(unsigned long nr_pages)
 {
-	pg_data_t *pgdat;
 	unsigned long nr_to_free = nr_pages;
 	unsigned long ret = 0;
-	unsigned retry = 2;
-	struct reclaim_state reclaim_state = {
-		.reclaimed_slab = 0,
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.may_swap = 1,
+		.swap_cluster_max = nr_pages,
+		.suspend = 3,
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
+		for_each_priority(priority) {
+			struct zone *zone;
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
+				/*
+				 * shrink_active_list needs this to reclaim
+				 * mapped pages
+				 */
+				if (!sc.suspend)
+					zone->prev_priority = priority;
+				freed = shrink_zone(priority, zone, &sc);
+				ret += freed;
+				nr_to_free -= freed;
+				if ((long)nr_to_free <= 0)
+					break;
+				}
+		}
+		if (ret < nr_pages)
+			blk_congestion_wait(WRITE, HZ/5);
+	} while (--sc.suspend >= 0);
 	return ret;
 }
 #endif
@@ -1913,6 +1932,7 @@ static int __zone_reclaim(struct zone *z
 		.swap_cluster_max = max_t(unsigned long, nr_pages,
 					SWAP_CLUSTER_MAX),
 		.gfp_mask = gfp_mask,
+		.suspend = 0,
 	};
 
 	disable_swap_token();
Index: linux-2.6.16-rc6-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/power/swsusp.c	2006-03-17 12:38:13.000000000 +1100
+++ linux-2.6.16-rc6-mm1/kernel/power/swsusp.c	2006-03-17 15:11:06.000000000 +1100
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
@@ -195,13 +192,12 @@ int swsusp_shrink_memory(void)
 			if (!is_highmem(zone))
 				tmp -= zone->free_pages;
 		if (tmp > 0) {
-			tmp = shrink_all_memory(SHRINK_BITE);
+			tmp = shrink_all_memory(tmp);
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
-		} else if (size > image_size / PAGE_SIZE) {
-			tmp = shrink_all_memory(SHRINK_BITE);
-			pages += tmp;
+			if (pages > size)
+				break;
 		}
 		printk("\b%c", p[i++%4]);
 	} while (tmp > 0);
