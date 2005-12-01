Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVLAKM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVLAKM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVLAKM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:12:27 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:62616 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932101AbVLAKMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:12:23 -0500
Message-Id: <20051201101949.411548000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 03/12] mm: balance zone aging in direct reclaim path
Content-Disposition: inline; filename=mm-balance-zone-aging-in-direct-reclaim.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add 10 extra priorities to the direct page reclaim path, which makes 10 round of
balancing effort(reclaim only from the least aged local/headless zone) before
falling back to the reclaim-all scheme.

Ten rounds should be enough to get enough free pages in normal cases, which
prevents unnecessarily disturbing remote nodes. If further restrict the first
round of page allocation to local zones, we might get what the early zone
reclaim patch want: memory affinity/locality.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1186,6 +1186,7 @@ static void
 shrink_caches(struct zone **zones, struct scan_control *sc)
 {
 	int i;
+	struct zone *z = NULL;
 
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
@@ -1200,11 +1201,34 @@ shrink_caches(struct zone **zones, struc
 		if (zone->prev_priority > sc->priority)
 			zone->prev_priority = sc->priority;
 
-		if (zone->all_unreclaimable && sc->priority != DEF_PRIORITY)
+		if (zone->all_unreclaimable && sc->priority < DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
+		/*
+		 * Balance page aging in local zones and following headless
+		 * zones.
+		 */
+		if (sc->priority > DEF_PRIORITY) {
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
@@ -1248,7 +1272,8 @@ int try_to_free_pages(struct zone **zone
 		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
 
-	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
+	/* The added 10 priorities are for scan rate balancing */
+	for (priority = DEF_PRIORITY + 10; priority >= 0; priority--) {
 		sc.nr_mapped = read_page_state(nr_mapped);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
@@ -1282,7 +1307,7 @@ int try_to_free_pages(struct zone **zone
 		}
 
 		/* Take a nap, wait for some writeback to complete */
-		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
+		if (sc.nr_scanned && priority < DEF_PRIORITY)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:

--
