Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVCCL1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVCCL1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVCCLZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:25:44 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:31634 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261629AbVCCLPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:15:44 -0500
Subject: [PATCH]: Speed freeing memory for suspend.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Message-Id: <1109848654.3733.34.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 03 Mar 2005 22:17:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a patch I've prepared which improves the speed at which memory is
freed prior to suspend. It should be a big gain for swsusp. For
suspend2, it isn't used much, but has shown big improvements when I set
a very low image size limit and had memory quite full.

Signed-Off-By: Nigel Cunningham <ncunningham@cyclades.com>
Acked-By: Pavel Machek <pavel@ucw.cz>

Also submitted to Linux-MM. No response received.

Regards,

Nigel

diff -ruNp 898-swap_cluster_max_adjustments-old/mm/vmscan.c 898-swap_cluster_max_adjustments-new/mm/vmscan.c
--- 898-swap_cluster_max_adjustments-old/mm/vmscan.c	2005-03-03 12:04:12.000000000 +1100
+++ 898-swap_cluster_max_adjustments-new/mm/vmscan.c	2005-03-03 11:51:00.000000000 +1100
@@ -73,6 +73,12 @@ struct scan_control {
 	unsigned int gfp_mask;
 
 	int may_writepage;
+
+	/* This context's SWAP_CLUSTER_MAX. If freeing memory for
+	 * suspend, we effectively ignore SWAP_CLUSTER_MAX.
+	 * In this context, it doesn't matter that we scan the
+	 * whole list at once. */
+	int swap_cluster_max;
 };
 
 #ifdef CONFIG_MKI
@@ -566,7 +572,7 @@ static void shrink_cache(struct zone *zo
 		int nr_scan = 0;
 		int nr_freed;
 
-		while (nr_scan++ < SWAP_CLUSTER_MAX &&
+		while (nr_scan++ < sc->swap_cluster_max &&
 				!list_empty(&zone->inactive_list)) {
 			page = lru_to_page(&zone->inactive_list);
 
@@ -811,31 +817,31 @@ shrink_zone(struct zone *zone, struct sc
 	 */
 	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
 	nr_active = zone->nr_scan_active;
-	if (nr_active >= SWAP_CLUSTER_MAX)
+	if (nr_active >= sc->swap_cluster_max)
 		zone->nr_scan_active = 0;
 	else
 		nr_active = 0;
 
 	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
 	nr_inactive = zone->nr_scan_inactive;
-	if (nr_inactive >= SWAP_CLUSTER_MAX)
+	if (nr_inactive >= sc->swap_cluster_max)
 		zone->nr_scan_inactive = 0;
 	else
 		nr_inactive = 0;
 
-	sc->nr_to_reclaim = SWAP_CLUSTER_MAX;
+	sc->nr_to_reclaim = sc->swap_cluster_max;
 
 	while (nr_active || nr_inactive) {
 		if (nr_active) {
 			sc->nr_to_scan = min(nr_active,
-					(unsigned long)SWAP_CLUSTER_MAX);
+					(unsigned long)sc->swap_cluster_max);
 			nr_active -= sc->nr_to_scan;
 			refill_inactive_zone(zone, sc);
 		}
 
 		if (nr_inactive) {
 			sc->nr_to_scan = min(nr_inactive,
-					(unsigned long)SWAP_CLUSTER_MAX);
+					(unsigned long)sc->swap_cluster_max);
 			nr_inactive -= sc->nr_to_scan;
 			shrink_cache(zone, sc);
 			if (sc->nr_to_reclaim <= 0)
@@ -936,13 +942,14 @@ int try_to_free_pages(struct zone **zone
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
+		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 		shrink_caches(zones, &sc);
 		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
 		}
-		if (sc.nr_reclaimed >= SWAP_CLUSTER_MAX) {
+		if (sc.nr_reclaimed >= sc.swap_cluster_max) {
 			ret = 1;
 			goto out;
 		}
@@ -956,7 +963,7 @@ int try_to_free_pages(struct zone **zone
 		 * that's undesirable in laptop mode, where we *want* lumpy
 		 * writeout.  So in laptop mode, write out the whole world.
 		 */
-		if (total_scanned > SWAP_CLUSTER_MAX + SWAP_CLUSTER_MAX/2) {
+		if (total_scanned > sc.swap_cluster_max + sc.swap_cluster_max/2) {
 			wakeup_bdflush(laptop_mode ? 0 : total_scanned);
 			sc.may_writepage = 1;
 		}
@@ -1091,6 +1098,7 @@ scan:
 			sc.nr_scanned = 0;
 			sc.nr_reclaimed = 0;
 			sc.priority = priority;
+			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
 			shrink_zone(zone, &sc);
 			reclaim_state->reclaimed_slab = 0;
 			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
@@ -1128,7 +1136,7 @@ scan:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
-		if (total_reclaimed >= SWAP_CLUSTER_MAX)
+		if ((total_reclaimed >= SWAP_CLUSTER_MAX) && (!nr_pages))
 			break;
 	}
 out:

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


