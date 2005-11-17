Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbVKQGh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbVKQGh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 01:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbVKQGh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 01:37:27 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:48550 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1161148AbVKQGhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 01:37:24 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20051117063903.11259.68372.sendpatchset@cherry.local>
Subject: [PATCH] Protect zone->nr_active and zone->nr_inactive
Date: Thu, 17 Nov 2005 15:37:22 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Protect read access to zone->nr_active and zone->nr_inactive.

There are places in the mm code where nr_active and nr_inactive are read from
struct zone without spinlock protection. I ran across this when working on 
improving the LRU code, but I have not been able to trigger this in real life
without my patches. The symptom for my code was that shrink_zone() read out
half-updated incorrect values from the zone struct which resulted in that the
amount of pages to scan became very very high, which in turn resulted in a
hang or almost infinite loop. In theory at least one race condition should 
exist between activate_page() and shrink_zone() on standard kernels.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

Applies to: 2.6.15-rc1, 2.6.14 (and probably earlier kernels too)

 page_alloc.c |    8 +++++++-
 vmscan.c     |   19 +++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

--- from-0002/mm/page_alloc.c
+++ to-work/mm/page_alloc.c	2005-11-17 14:55:19.000000000 +0900
@@ -1244,15 +1244,18 @@ void __get_zone_counts(unsigned long *ac
 			unsigned long *free, struct pglist_data *pgdat)
 {
 	struct zone *zones = pgdat->node_zones;
+	unsigned long flags;
 	int i;
 
 	*active = 0;
 	*inactive = 0;
 	*free = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
+		spin_lock_irqsave(&zones[i].lru_lock, flags);
 		*active += zones[i].nr_active;
 		*inactive += zones[i].nr_inactive;
 		*free += zones[i].free_pages;
+		spin_unlock_irqrestore(&zones[i].lru_lock, flags);
 	}
 }
 
@@ -1318,6 +1321,7 @@ void show_free_areas(void)
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
+	unsigned long flags;
 	struct zone *zone;
 
 	for_each_zone(zone) {
@@ -1369,6 +1373,7 @@ void show_free_areas(void)
 		int i;
 
 		show_node(zone);
+		spin_lock_irqsave(&zone->lock, flags);
 		printk("%s"
 			" free:%lukB"
 			" min:%lukB"
@@ -1394,11 +1399,12 @@ void show_free_areas(void)
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			printk(" %lu", zone->lowmem_reserve[i]);
+		spin_unlock_irqrestore(&zone->lock, flags);
 		printk("\n");
 	}
 
 	for_each_zone(zone) {
- 		unsigned long nr, flags, order, total = 0;
+ 		unsigned long nr, order, total = 0;
 
 		show_node(zone);
 		printk("%s: ", zone->name);
--- from-0002/mm/vmscan.c
+++ to-work/mm/vmscan.c	2005-11-17 14:53:05.000000000 +0900
@@ -831,18 +831,23 @@ shrink_zone(struct zone *zone, struct sc
 
 	atomic_inc(&zone->reclaim_in_progress);
 
+	spin_lock_irq(&zone->lru_lock);
+	nr_active = zone->nr_active;
+	nr_inactive = zone->nr_inactive;
+	spin_unlock_irq(&zone->lru_lock);
+
 	/*
 	 * Add one to `nr_to_scan' just to make sure that the kernel will
 	 * slowly sift through the active list.
 	 */
-	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
+	zone->nr_scan_active += (nr_active >> sc->priority) + 1;
 	nr_active = zone->nr_scan_active;
 	if (nr_active >= sc->swap_cluster_max)
 		zone->nr_scan_active = 0;
 	else
 		nr_active = 0;
 
-	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
+	zone->nr_scan_inactive += (nr_inactive >> sc->priority) + 1;
 	nr_inactive = zone->nr_scan_inactive;
 	if (nr_inactive >= sc->swap_cluster_max)
 		zone->nr_scan_inactive = 0;
@@ -935,6 +940,7 @@ int try_to_free_pages(struct zone **zone
 	int total_scanned = 0, total_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
+	unsigned long flags;
 	unsigned long lru_pages = 0;
 	int i;
 
@@ -951,7 +957,10 @@ int try_to_free_pages(struct zone **zone
 			continue;
 
 		zone->temp_priority = DEF_PRIORITY;
+
+		spin_lock_irqsave(&zone->lru_lock, flags);
 		lru_pages += zone->nr_active + zone->nr_inactive;
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
@@ -1033,6 +1042,7 @@ static int balance_pgdat(pg_data_t *pgda
 	int priority;
 	int i;
 	int total_scanned, total_reclaimed;
+	unsigned long flags;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 
@@ -1087,7 +1097,9 @@ scan:
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
+			spin_lock_irqsave(&zone->lru_lock, flags);
 			lru_pages += zone->nr_active + zone->nr_inactive;
+			spin_unlock_irqrestore(&zone->lru_lock, flags);
 		}
 
 		/*
@@ -1132,9 +1144,12 @@ scan:
 			total_scanned += sc.nr_scanned;
 			if (zone->all_unreclaimable)
 				continue;
+
+			spin_lock_irqsave(&zone->lru_lock, flags);
 			if (nr_slab == 0 && zone->pages_scanned >=
 				    (zone->nr_active + zone->nr_inactive) * 4)
 				zone->all_unreclaimable = 1;
+			spin_unlock_irqrestore(&zone->lru_lock, flags);
 			/*
 			 * If we've done a decent amount of scanning and
 			 * the reclaim ratio is low, start doing writepage
