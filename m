Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWFRHfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWFRHfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWFRHfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:35:09 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:51080 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932119AbWFRHer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:34:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][22/29] mm-prio_dependant_scan-1.patch
Date: Sun, 18 Jun 2006 17:34:41 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 6996
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181734.41260.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the initial "priority" of memory reclaim scanning according to the cpu
scheduling priority thus determining how aggressively reclaim is to initally
progress according to nice level.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 fs/buffer.c          |    2 +-
 include/linux/swap.h |    3 ++-
 mm/page_alloc.c      |    2 +-
 mm/vmscan.c          |   34 ++++++++++++++++++++--------------
 4 files changed, 24 insertions(+), 17 deletions(-)

Index: linux-ck-dev/fs/buffer.c
===================================================================
--- linux-ck-dev.orig/fs/buffer.c	2006-06-18 15:20:11.000000000 +1000
+++ linux-ck-dev/fs/buffer.c	2006-06-18 15:25:05.000000000 +1000
@@ -496,7 +496,7 @@ static void free_more_memory(void)
 	for_each_online_pgdat(pgdat) {
 		zones = pgdat->node_zonelists[gfp_zone(GFP_NOFS)].zones;
 		if (*zones)
-			try_to_free_pages(zones, GFP_NOFS);
+			try_to_free_pages(zones, GFP_NOFS, NULL);
 	}
 }
 
Index: linux-ck-dev/include/linux/swap.h
===================================================================
--- linux-ck-dev.orig/include/linux/swap.h	2006-06-18 15:24:58.000000000 +1000
+++ linux-ck-dev/include/linux/swap.h	2006-06-18 15:25:05.000000000 +1000
@@ -174,7 +174,8 @@ extern int rotate_reclaimable_page(struc
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern unsigned long try_to_free_pages(struct zone **, gfp_t);
+extern unsigned long try_to_free_pages(struct zone **, gfp_t,
+				       struct task_struct *p);
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_mapped;
 extern int vm_hardmaplimit;
Index: linux-ck-dev/mm/page_alloc.c
===================================================================
--- linux-ck-dev.orig/mm/page_alloc.c	2006-06-18 15:25:02.000000000 +1000
+++ linux-ck-dev/mm/page_alloc.c	2006-06-18 15:25:05.000000000 +1000
@@ -1017,7 +1017,7 @@ rebalance:
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask);
+	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask, p);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
Index: linux-ck-dev/mm/vmscan.c
===================================================================
--- linux-ck-dev.orig/mm/vmscan.c	2006-06-18 15:25:02.000000000 +1000
+++ linux-ck-dev/mm/vmscan.c	2006-06-18 15:25:05.000000000 +1000
@@ -984,7 +984,8 @@ static unsigned long shrink_zones(int pr
  * holds filesystem locks which prevent writeout this might not work, and the
  * allocation attempt will fail.
  */
-unsigned long try_to_free_pages(struct zone **zones, gfp_t gfp_mask)
+unsigned long try_to_free_pages(struct zone **zones, gfp_t gfp_mask,
+				struct task_struct *p)
 {
 	int priority;
 	int ret = 0;
@@ -992,7 +993,7 @@ unsigned long try_to_free_pages(struct z
 	unsigned long nr_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	unsigned long lru_pages = 0;
-	int i;
+	int i, scan_priority = DEF_PRIORITY;
 	struct scan_control sc = {
 		.gfp_mask = gfp_mask,
 		.may_writepage = !laptop_mode,
@@ -1001,6 +1002,9 @@ unsigned long try_to_free_pages(struct z
 		.mapped = vm_mapped,
 	};
 
+	if (p)
+		scan_priority = sc_priority(p);
+
 	delay_swap_prefetch();
 
 	inc_page_state(allocstall);
@@ -1011,11 +1015,11 @@ unsigned long try_to_free_pages(struct z
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 			continue;
 
-		zone->temp_priority = DEF_PRIORITY;
+		zone->temp_priority = scan_priority;
 		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
 
-	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
+	for (priority = scan_priority; priority >= 0; priority--) {
 		sc.nr_mapped = read_page_state(nr_mapped);
 		sc.nr_scanned = 0;
 		if (!priority)
@@ -1046,7 +1050,7 @@ unsigned long try_to_free_pages(struct z
 		}
 
 		/* Take a nap, wait for some writeback to complete */
-		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
+		if (sc.nr_scanned && priority < scan_priority - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:
@@ -1084,9 +1088,9 @@ out:
  */
 static unsigned long balance_pgdat(pg_data_t *pgdat, int order)
 {
-	int all_zones_ok;
+	int all_zones_ok = 0;
 	int priority;
-	int i;
+	int i, scan_priority;
 	unsigned long total_scanned;
 	unsigned long nr_reclaimed;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
@@ -1097,6 +1101,8 @@ static unsigned long balance_pgdat(pg_da
 		.mapped = vm_mapped,
 	};
 
+	scan_priority = sc_priority(pgdat->kswapd);
+
 loop_again:
 	total_scanned = 0;
 	nr_reclaimed = 0;
@@ -1108,10 +1114,10 @@ loop_again:
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 
-		zone->temp_priority = DEF_PRIORITY;
+		zone->temp_priority = scan_priority;
 	}
 
-	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
+	for (priority = scan_priority; priority >= 0; priority--) {
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
 
@@ -1132,7 +1138,7 @@ loop_again:
 			if (!populated_zone(zone))
 				continue;
 
-			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
+			if (zone->all_unreclaimable && priority != scan_priority)
 				continue;
 
 			/*
@@ -1141,7 +1147,7 @@ loop_again:
 			 * pages_high.
 			 */
 			watermark = zone->pages_high + (zone->pages_high *
-				    priority / DEF_PRIORITY);
+				    priority / scan_priority);
 			if (!zone_watermark_ok(zone, order, watermark, 0, 0)) {
 				end_zone = i;
 				goto scan;
@@ -1173,11 +1179,11 @@ scan:
 			if (!populated_zone(zone))
 				continue;
 
-			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
+			if (zone->all_unreclaimable && priority != scan_priority)
 				continue;
 
 			watermark = zone->pages_high + (zone->pages_high *
-				    priority / DEF_PRIORITY);
+				    priority / scan_priority);
 
 			if (!zone_watermark_ok(zone, order, watermark,
 					       end_zone, 0))
@@ -1212,7 +1218,7 @@ scan:
 		 * OK, kswapd is getting into trouble.  Take a nap, then take
 		 * another pass across the zones.
 		 */
-		if (total_scanned && priority < DEF_PRIORITY - 2)
+		if (total_scanned && priority < scan_priority - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 
 		/*

-- 
-ck
