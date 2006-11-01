Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946523AbWKAFrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946523AbWKAFrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946554AbWKAFqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:46:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:59612 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946553AbWKAFph
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:45:37 -0500
Message-Id: <20061101054507.162773000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:34 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Martin Bligh <mbligh@mbligh.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: [PATCH 54/61] vmscan: Fix temp_priority race
Content-Disposition: inline; filename=vmscan-fix-temp_priority-race.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andrew Morton <akpm@osdl.org>

The temp_priority field in zone is racy, as we can walk through a reclaim
path, and just before we copy it into prev_priority, it can be overwritten
(say with DEF_PRIORITY) by another reclaimer.

The same bug is contained in both try_to_free_pages and balance_pgdat, but
it is fixed slightly differently.  In balance_pgdat, we keep a separate
priority record per zone in a local array.  In try_to_free_pages there is
no need to do this, as the priority level is the same for all zones that we
reclaim from.

Impact of this bug is that temp_priority is copied into prev_priority, and
setting this artificially high causes reclaimers to set distress
artificially low.  They then fail to reclaim mapped pages, when they are,
in fact, under severe memory pressure (their priority may be as low as 0).
This causes the OOM killer to fire incorrectly.

From: Andrew Morton <akpm@osdl.org>

__zone_reclaim() isn't modifying zone->prev_priority.  But zone->prev_priority
is used in the decision whether or not to bring mapped pages onto the inactive
list.  Hence there's a risk here that __zone_reclaim() will fail because
zone->prev_priority ir large (ie: low urgency) and lots of mapped pages end up
stuck on the active list.

Fix that up by decreasing (ie making more urgent) zone->prev_priority as
__zone_reclaim() scans the zone's pages.

This bug perhaps explains why ZONE_RECLAIM_PRIORITY was created.  It should be
possible to remove that now, and to just start out at DEF_PRIORITY?

Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@engr.sgi.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
[chrisw: minor wiggle to fit -stable]
---
 include/linux/mmzone.h |    6 -----
 mm/page_alloc.c        |    2 -
 mm/vmscan.c            |   55 ++++++++++++++++++++++++++++++++++++-------------
 mm/vmstat.c            |    2 -
 4 files changed, 43 insertions(+), 22 deletions(-)

--- linux-2.6.18.1.orig/include/linux/mmzone.h
+++ linux-2.6.18.1/include/linux/mmzone.h
@@ -200,13 +200,9 @@ struct zone {
 	 * under - it drives the swappiness decision: whether to unmap mapped
 	 * pages.
 	 *
-	 * temp_priority is used to remember the scanning priority at which
-	 * this zone was successfully refilled to free_pages == pages_high.
-	 *
-	 * Access to both these fields is quite racy even on uniprocessor.  But
+	 * Access to both this field is quite racy even on uniprocessor.  But
 	 * it is expected to average out OK.
 	 */
-	int temp_priority;
 	int prev_priority;
 
 
--- linux-2.6.18.1.orig/mm/page_alloc.c
+++ linux-2.6.18.1/mm/page_alloc.c
@@ -2021,7 +2021,7 @@ static void __meminit free_area_init_cor
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 
-		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
+		zone->prev_priority = DEF_PRIORITY;
 
 		zone_pcp_init(zone);
 		INIT_LIST_HEAD(&zone->active_list);
--- linux-2.6.18.1.orig/mm/vmscan.c
+++ linux-2.6.18.1/mm/vmscan.c
@@ -696,6 +696,20 @@ done:
 }
 
 /*
+ * We are about to scan this zone at a certain priority level.  If that priority
+ * level is smaller (ie: more urgent) than the previous priority, then note
+ * that priority level within the zone.  This is done so that when the next
+ * process comes in to scan this zone, it will immediately start out at this
+ * priority level rather than having to build up its own scanning priority.
+ * Here, this priority affects only the reclaim-mapped threshold.
+ */
+static inline void note_zone_scanning_priority(struct zone *zone, int priority)
+{
+	if (priority < zone->prev_priority)
+		zone->prev_priority = priority;
+}
+
+/*
  * This moves pages from the active list to the inactive list.
  *
  * We move them the other way if the page is referenced by one or more
@@ -934,9 +948,7 @@ static unsigned long shrink_zones(int pr
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 			continue;
 
-		zone->temp_priority = priority;
-		if (zone->prev_priority > priority)
-			zone->prev_priority = priority;
+		note_zone_scanning_priority(zone, priority);
 
 		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
@@ -984,7 +996,6 @@ unsigned long try_to_free_pages(struct z
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 			continue;
 
-		zone->temp_priority = DEF_PRIORITY;
 		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
 
@@ -1022,13 +1033,22 @@ unsigned long try_to_free_pages(struct z
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:
+	/*
+	 * Now that we've scanned all the zones at this priority level, note
+	 * that level within the zone so that the next thread which performs
+	 * scanning of this zone will immediately start out at this priority
+	 * level.  This affects only the decision whether or not to bring
+	 * mapped pages onto the inactive list.
+	 */
+	if (priority < 0)
+		priority = 0;
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];
 
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 			continue;
 
-		zone->prev_priority = zone->temp_priority;
+		zone->prev_priority = priority;
 	}
 	return ret;
 }
@@ -1068,6 +1088,11 @@ static unsigned long balance_pgdat(pg_da
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.swappiness = vm_swappiness,
 	};
+	/*
+	 * temp_priority is used to remember the scanning priority at which
+	 * this zone was successfully refilled to free_pages == pages_high.
+	 */
+	int temp_priority[MAX_NR_ZONES];
 
 loop_again:
 	total_scanned = 0;
@@ -1075,11 +1100,8 @@ loop_again:
 	sc.may_writepage = !laptop_mode;
 	count_vm_event(PAGEOUTRUN);
 
-	for (i = 0; i < pgdat->nr_zones; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-
-		zone->temp_priority = DEF_PRIORITY;
-	}
+	for (i = 0; i < pgdat->nr_zones; i++)
+		temp_priority[i] = DEF_PRIORITY;
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
@@ -1140,10 +1162,9 @@ scan:
 			if (!zone_watermark_ok(zone, order, zone->pages_high,
 					       end_zone, 0))
 				all_zones_ok = 0;
-			zone->temp_priority = priority;
-			if (zone->prev_priority > priority)
-				zone->prev_priority = priority;
+			temp_priority[i] = priority;
 			sc.nr_scanned = 0;
+			note_zone_scanning_priority(zone, priority);
 			nr_reclaimed += shrink_zone(priority, zone, &sc);
 			reclaim_state->reclaimed_slab = 0;
 			nr_slab = shrink_slab(sc.nr_scanned, GFP_KERNEL,
@@ -1183,10 +1204,15 @@ scan:
 			break;
 	}
 out:
+	/*
+	 * Note within each zone the priority level at which this zone was
+	 * brought into a happy state.  So that the next thread which scans this
+	 * zone will start out at that priority level.
+	 */
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 
-		zone->prev_priority = zone->temp_priority;
+		zone->prev_priority = temp_priority[i];
 	}
 	if (!all_zones_ok) {
 		cond_resched();
@@ -1570,6 +1596,7 @@ static int __zone_reclaim(struct zone *z
 		 */
 		priority = ZONE_RECLAIM_PRIORITY;
 		do {
+			note_zone_scanning_priority(zone, priority);
 			nr_reclaimed += shrink_zone(priority, zone, &sc);
 			priority--;
 		} while (priority >= 0 && nr_reclaimed < nr_pages);
--- linux-2.6.18.1.orig/mm/vmstat.c
+++ linux-2.6.18.1/mm/vmstat.c
@@ -586,11 +586,9 @@ static int zoneinfo_show(struct seq_file
 		seq_printf(m,
 			   "\n  all_unreclaimable: %u"
 			   "\n  prev_priority:     %i"
-			   "\n  temp_priority:     %i"
 			   "\n  start_pfn:         %lu",
 			   zone->all_unreclaimable,
 			   zone->prev_priority,
-			   zone->temp_priority,
 			   zone->zone_start_pfn);
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');

--
