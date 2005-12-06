Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbVLFNfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVLFNfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLFNfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:35:38 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:64216 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932569AbVLFNfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:35:37 -0500
Message-Id: <20051206135749.180427000@localhost.localdomain>
References: <20051206135608.860737000@localhost.localdomain>
Date: Tue, 06 Dec 2005 21:56:12 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/13] mm: balance zone aging in direct reclaim path
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

--- linux-2.6.15-rc5-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc5-mm1/mm/vmscan.c
@@ -1189,6 +1189,7 @@ static void
 shrink_caches(struct zone **zones, struct scan_control *sc)
 {
 	int i;
+	struct zone *z = NULL;
 
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
@@ -1203,11 +1204,34 @@ shrink_caches(struct zone **zones, struc
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
+			else if (age_gt(z, zone))
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
@@ -1251,7 +1275,8 @@ int try_to_free_pages(struct zone **zone
 		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
 
-	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
+	/* The added 10 priorities are for scan rate balancing */
+	for (priority = DEF_PRIORITY + 10; priority >= 0; priority--) {
 		sc.nr_mapped = read_page_state(nr_mapped);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
@@ -1285,7 +1310,7 @@ int try_to_free_pages(struct zone **zone
 		}
 
 		/* Take a nap, wait for some writeback to complete */
-		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
+		if (sc.nr_scanned && priority < DEF_PRIORITY)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:

--
