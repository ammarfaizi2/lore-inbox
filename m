Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbVKYPGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbVKYPGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVKYPGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:06:19 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:5867 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1161108AbVKYPGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:06:04 -0500
Message-Id: <20051125151417.771819000@localhost.localdomain>
References: <20051125151210.993109000@localhost.localdomain>
Date: Fri, 25 Nov 2005 23:12:14 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/19] mm: debug page reclaim
Content-Disposition: inline; filename=mm-debug-page-reclaim.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Show the detailed steps of early/direct/kswapd page reclaim.

To enable the printk traces:
# echo y > /debug/debug_page_reclaim

Sample lines:

reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-31, age 1248, hot+cold+free pages 92563+25703+860
reclaim zone2 from kswapd for watermark, prio 11, scan-reclaimed 33-32, age 1253, hot+cold+free pages 92547+25688+892
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1258, hot+cold+free pages 92547+25656+924
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-29, age 1262, hot+cold+free pages 92532+25639+924
reclaim zone2 from kswapd for watermark, prio 11, scan-reclaimed 33-28, age 1269, hot+cold+free pages 92531+25611+956
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-31, age 1274, hot+cold+free pages 92535+25579+988
reclaim zone2 from kswapd for watermark, prio 11, scan-reclaimed 33-29, age 1278, hot+cold+free pages 92518+25565+1020
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-29, age 1282, hot+cold+free pages 92507+25547+1052
reclaim zone2 from kswapd for aging, prio 11, scan-reclaimed 33-27, age 1287, hot+cold+free pages 92506+25519+1084
reclaim zone2 from direct for aging, prio 12, scan-reclaimed 33-29, age 1292, hot+cold+free pages 92505+25494+1116
reclaim zone2 from direct for aging, prio 11, scan-reclaimed 33-32, age 1297, hot+cold+free pages 92506+25464+1148
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1302, hot+cold+free pages 92506+25746+860
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1307, hot+cold+free pages 92488+25732+892
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1312, hot+cold+free pages 92488+25700+924
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1316, hot+cold+free pages 92481+25675+956
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1322, hot+cold+free pages 92481+25643+988
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1326, hot+cold+free pages 92474+25618+1020
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1331, hot+cold+free pages 92474+25586+1052
reclaim zone2 from kswapd for aging, prio 12, scan-reclaimed 33-32, age 1336, hot+cold+free pages 92474+25554+1084
reclaim zone2 from direct for aging, prio 12, scan-reclaimed 33-32, age 1341, hot+cold+free pages 92474+25522+1116
reclaim zone2 from direct for aging, prio 12, scan-reclaimed 33-32, age 1347, hot+cold+free pages 92470+25744+892
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-32, age 1352, hot+cold+free pages 92463+25712+924
reclaim zone2 from kswapd for watermark, prio 12, scan-reclaimed 33-25, age 1357, hot+cold+free pages 92462+25681+956

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 mm/vmscan.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 75 insertions(+), 15 deletions(-)

--- linux-2.6.15-rc2-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc2-mm1/mm/vmscan.c
@@ -38,6 +38,7 @@
 #include <asm/div64.h>
 
 #include <linux/swapops.h>
+#include <linux/debugfs.h>
 
 /* possible outcome of pageout() */
 typedef enum {
@@ -72,10 +73,7 @@ struct scan_control {
 	/* This context's GFP mask */
 	gfp_t gfp_mask;
 
-	int may_writepage;
-
-	/* Can pages be swapped as part of reclaim? */
-	int may_swap;
+	unsigned long flags;
 
 	/* This context's SWAP_CLUSTER_MAX. If freeing memory for
 	 * suspend, we effectively ignore SWAP_CLUSTER_MAX.
@@ -84,6 +82,59 @@ struct scan_control {
 	int swap_cluster_max;
 };
 
+#define SC_RECLAIM_FROM_KSWAPD		0x01
+#define SC_RECLAIM_FROM_DIRECT		0x02
+#define SC_RECLAIM_FROM_EARLY		0x04
+#define SC_RECLAIM_FOR_WATERMARK	0x10
+#define SC_RECLAIM_FOR_AGING		0x20
+#define SC_RECLAIM_MASK			0xFF
+
+#define SC_MAY_WRITEPAGE		0x100
+#define SC_MAY_SWAP			0x200	/* Can pages be swapped as part of reclaim? */
+
+#ifdef CONFIG_DEBUG_FS
+static u32 debug_page_reclaim;
+
+static inline void debug_reclaim(struct scan_control *sc, unsigned long flags)
+{
+	sc->flags = (sc->flags & ~SC_RECLAIM_MASK) | flags;
+}
+
+static inline void debug_reclaim_report(struct scan_control *sc, struct zone *z)
+{
+	if (!debug_page_reclaim)
+		return;
+
+	printk(KERN_DEBUG "reclaim zone%d from %s for %s, "
+			"prio %d, scan-reclaimed %lu-%lu, age %lu, "
+			"hot+cold+free pages %lu+%lu+%lu\n",
+			zone_idx(z),
+			(sc->flags & SC_RECLAIM_FROM_KSWAPD) ? "kswapd" :
+			((sc->flags & SC_RECLAIM_FROM_DIRECT) ? "direct" :
+								"early"),
+			(sc->flags & SC_RECLAIM_FOR_AGING) ?
+							"aging" : "watermark",
+			sc->priority, sc->nr_scanned, sc->nr_reclaimed,
+			z->page_age, z->nr_active, z->nr_inactive, z->free_pages);
+}
+
+static inline void debug_reclaim_init(void)
+{
+	debugfs_create_bool("debug_page_reclaim", 0644, NULL,
+							&debug_page_reclaim);
+}
+#else
+static inline void debug_reclaim(struct scan_control *sc, int flags)
+{
+}
+static inline void debug_reclaim_report(struct scan_control *sc, struct zone *z)
+{
+}
+static inline void debug_reclaim_init(void)
+{
+}
+#endif
+
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
 #ifdef ARCH_HAS_PREFETCH
@@ -499,7 +550,7 @@ static int shrink_list(struct list_head 
 		 * Try to allocate it some swap space here.
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
-			if (!sc->may_swap)
+			if (!(sc->flags & SC_MAY_SWAP))
 				goto keep_locked;
 			if (!add_to_swap(page, GFP_ATOMIC))
 				goto activate_locked;
@@ -530,7 +581,7 @@ static int shrink_list(struct list_head 
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
-			if (laptop_mode && !sc->may_writepage)
+			if (laptop_mode && !(sc->flags & SC_MAY_WRITEPAGE))
 				goto keep_locked;
 
 			/* Page is dirty, try to write it out here */
@@ -939,6 +990,7 @@ static void shrink_cache(struct zone *zo
 			mod_page_state(kswapd_steal, nr_freed);
 		mod_page_state_zone(zone, pgsteal, nr_freed);
 		sc->nr_to_reclaim -= nr_freed;
+		debug_reclaim_report(sc, zone);
 
 		spin_lock_irq(&zone->lru_lock);
 		/*
@@ -1216,11 +1268,14 @@ shrink_caches(struct zone **zones, struc
 			continue;
 		}
 
+		debug_reclaim(sc, SC_RECLAIM_FROM_DIRECT);
 		shrink_zone(zone, sc);
 	}
 
-	if (z)
+	if (z) {
+		debug_reclaim(sc, SC_RECLAIM_FROM_DIRECT|SC_RECLAIM_FOR_AGING);
 		shrink_zone(z, sc);
+	}
 }
  
 /*
@@ -1248,8 +1303,7 @@ int try_to_free_pages(struct zone **zone
 	delay_prefetch();
 
 	sc.gfp_mask = gfp_mask;
-	sc.may_writepage = 0;
-	sc.may_swap = 1;
+	sc.flags = SC_MAY_SWAP;
 
 	inc_page_state(allocstall);
 
@@ -1290,7 +1344,7 @@ int try_to_free_pages(struct zone **zone
 		 */
 		if (total_scanned > sc.swap_cluster_max + sc.swap_cluster_max/2) {
 			wakeup_pdflush(laptop_mode ? 0 : total_scanned);
-			sc.may_writepage = 1;
+			sc.flags |= SC_MAY_WRITEPAGE;
 		}
 
 		/* Take a nap, wait for some writeback to complete */
@@ -1365,8 +1419,7 @@ loop_again:
 	total_scanned = 0;
 	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
-	sc.may_writepage = 0;
-	sc.may_swap = 1;
+	sc.flags = SC_MAY_SWAP;
 	sc.nr_mapped = read_page_state(nr_mapped);
 
 	inc_page_state(pageoutrun);
@@ -1395,10 +1448,16 @@ loop_again:
 				if (!zone_watermark_ok(zone, order,
 							zone->pages_high,
 							0, 0)) {
+					debug_reclaim(&sc,
+							SC_RECLAIM_FROM_KSWAPD|
+							SC_RECLAIM_FOR_WATERMARK);
 					all_zones_ok = 0;
 				} else if (zone == youngest_zone &&
 						pages_more_aged(oldest_zone,
 								youngest_zone)) {
+					debug_reclaim(&sc,
+							SC_RECLAIM_FROM_KSWAPD|
+							SC_RECLAIM_FOR_AGING);
 					/* if (priority > DEF_PRIORITY - 2) */
 						/* all_zones_ok = 0; */
 				} else
@@ -1433,7 +1492,7 @@ loop_again:
 		 */
 		if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
 		    total_scanned > total_reclaimed+total_reclaimed/2)
-			sc.may_writepage = 1;
+			sc.flags |= SC_MAY_WRITEPAGE;
 
 		if (nr_pages && to_free > total_reclaimed)
 			continue;	/* swsusp: need to do more work */
@@ -1623,6 +1682,7 @@ static int __init kswapd_init(void)
 		= find_task_by_pid(kernel_thread(kswapd, pgdat, CLONE_KERNEL));
 	total_memory = nr_free_pagecache_pages();
 	hotcpu_notifier(cpu_callback, 0);
+	debug_reclaim_init();
 	return 0;
 }
 
@@ -1645,8 +1705,7 @@ int zone_reclaim(struct zone *zone, gfp_
 		return 0;
 
 	sc.gfp_mask = gfp_mask;
-	sc.may_writepage = 0;
-	sc.may_swap = 0;
+	sc.flags = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
@@ -1662,6 +1721,7 @@ int zone_reclaim(struct zone *zone, gfp_
 	if (atomic_read(&zone->reclaim_in_progress) > 0)
 		goto out;
 
+	debug_reclaim(&sc, SC_RECLAIM_FROM_EARLY);
 	shrink_zone(zone, &sc);
 	total_reclaimed = sc.nr_reclaimed;
 

--
