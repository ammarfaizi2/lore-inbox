Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVLAKNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVLAKNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVLAKNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:13:01 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:33689 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932110AbVLAKMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:12:41 -0500
Message-Id: <20051201102004.661024000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:14 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/12] mm: balance zone aging in kswapd reclaim path
Content-Disposition: inline; filename=mm-balance-zone-aging-in-kswapd-reclaim.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kswapd reclaim has had one single goal:
	reclaim from zones to make their watermarks ok.

Now add another weak goal(it will not set all_zones_ok=0):
	reclaim from the least aged zone to help balance the aging rates.

Two major aspects of this algorithm:
- reclaim the least aged zone unless it catches up with the most aged zone
- reclaim for weaker watermark by calling watermark_ok() with classzone_idx=0

That garuantees reclaims-for-aging to be more than reclaims-for-watermark if
there is ever a big imbalance, thus eliminates the chance of growing gaps.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   39 ++++++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 9 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1356,6 +1356,8 @@ static int balance_pgdat(pg_data_t *pgda
 	int total_scanned, total_reclaimed;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
+	struct zone *youngest_zone = NULL;
+	struct zone *oldest_zone = NULL;
 
 loop_again:
 	total_scanned = 0;
@@ -1371,11 +1373,20 @@ loop_again:
 		struct zone *zone = pgdat->node_zones + i;
 
 		zone->temp_priority = DEF_PRIORITY;
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
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		unsigned long lru_pages = 0;
-		int first_low_zone = 0;
 
 		all_zones_ok = 1;
 		sc.nr_scanned = 0;
@@ -1387,21 +1398,31 @@ loop_again:
 		if (!priority)
 			disable_swap_token();
 
-		/* Scan in the highmem->dma direction */
-		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
+		/*
+		 * Now scan the zone in the dma->highmem direction, stopping
+		 * at the last zone which needs scanning.
+		 *
+		 * We do this because the page allocator works in the opposite
+		 * direction.  This prevents the page allocator from allocating
+		 * pages behind kswapd's direction of progress, which would
+		 * cause too much scanning of the lower zones.
+		 */
+		for (i = 0; i < pgdat->nr_zones; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
 			if (!populated_zone(zone))
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
+				} else
 					continue;
-
-				all_zones_ok = 0;
-				if (first_low_zone < i)
-					first_low_zone = i;
 			}
 
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)

--
