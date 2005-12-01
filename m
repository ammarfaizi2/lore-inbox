Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVLAKOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVLAKOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLAKOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:14:40 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:43164 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932132AbVLAKO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:14:26 -0500
Message-Id: <20051201102152.827798000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:21 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 11/12] mm: add page reclaim debug traces
Content-Disposition: inline; filename=mm-page-reclaim-debug-traces.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Show the detailed steps of direct/kswapd page reclaim.

To enable the printk traces:
# echo y > /debug/debug_page_reclaim

Sample lines:

reclaim zone3 from kswapd for watermark, prio 12, scan-reclaimed 32-32, age 2626, active to scan 6542, hot+cold+free pages 8842+283558+352
reclaim zone2 from kswapd for aging, prio 12, scan-reclaimed 32-32, age 2626, active to scan 8018, hot+cold+free pages 1693+200036+10360
reclaim zone3 from kswapd for watermark, prio 12, scan-reclaimed 64-64, age 2627, active to scan 7564, hot+cold+free pages 8842+283526+384
reclaim zone2 from kswapd for aging, prio 12, scan-reclaimed 32-32, age 2627, active to scan 8296, hot+cold+free pages 1693+200018+10360
reclaim zone3 from kswapd for watermark, prio 12, scan-reclaimed 64-63, age 2628, active to scan 8587, hot+cold+free pages 8843+283495+416
reclaim zone2 from kswapd for aging, prio 12, scan-reclaimed 32-32, age 2628, active to scan 8574, hot+cold+free pages 1693+200014+10392
reclaim zone3 from kswapd for watermark, prio 12, scan-reclaimed 64-63, age 2628, active to scan 9610, hot+cold+free pages 8844+283465+448
reclaim zone2 from kswapd for aging, prio 12, scan-reclaimed 32-32, age 2628, active to scan 8852, hot+cold+free pages 1693+199996+10424
reclaim zone3 from kswapd for watermark, prio 12, scan-reclaimed 64-64, age 2629, active to scan 10633, hot+cold+free pages 8844+283433+480
reclaim zone2 from kswapd for aging, prio 12, scan-reclaimed 32-32, age 2629, active to scan 9130, hot+cold+free pages 1693+199992+10456
reclaim zone3 from kswapd for watermark, prio 12, scan-reclaimed 64-64, age 2630, active to scan 11656, hot+cold+free pages 8844+283401+512
reclaim zone2 from kswapd for aging, prio 12, scan-reclaimed 32-32, age 2630, active to scan 9408, hot+cold+free pages 1693+199974+10488

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 mm/vmscan.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 69 insertions(+), 1 deletion(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -38,6 +38,7 @@
 #include <asm/div64.h>
 
 #include <linux/swapops.h>
+#include <linux/debugfs.h>
 
 /* possible outcome of pageout() */
 typedef enum {
@@ -78,6 +79,62 @@ struct scan_control {
 #define SC_MAY_WRITEPAGE	0x1
 #define SC_MAY_SWAP		0x2	/* Can pages be swapped as part of reclaim? */
 
+#define SC_RECLAIM_FROM_KSWAPD		0x10
+#define SC_RECLAIM_FROM_DIRECT		0x20
+#define SC_RECLAIM_FOR_WATERMARK	0x40
+#define SC_RECLAIM_FOR_AGING		0x80
+#define SC_RECLAIM_MASK			0xF0
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
+			"active to scan %lu, "
+			"hot+cold+free pages %lu+%lu+%lu\n",
+			zone_idx(z),
+			(sc->flags & SC_RECLAIM_FROM_KSWAPD) ? "kswapd" :
+			((sc->flags & SC_RECLAIM_FROM_DIRECT) ? "direct" :
+								"early"),
+			(sc->flags & SC_RECLAIM_FOR_AGING) ?
+							"aging" : "watermark",
+			sc->priority, sc->nr_scanned, sc->nr_reclaimed,
+			z->page_age,
+			z->nr_scan_active,
+			z->nr_active, z->nr_inactive, z->free_pages);
+
+	if (atomic_read(&z->reclaim_in_progress))
+		printk(KERN_WARNING "reclaim_in_progress=%d\n",
+					atomic_read(&z->reclaim_in_progress));
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
@@ -1141,6 +1198,7 @@ shrink_zone(struct zone *zone, struct sc
 
 	atomic_dec(&zone->reclaim_in_progress);
 
+	debug_reclaim_report(sc, zone);
 	throttle_vm_writeout();
 }
 
@@ -1205,11 +1263,14 @@ shrink_caches(struct zone **zones, struc
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
@@ -1386,10 +1447,16 @@ loop_again:
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
 				} else
 					continue;
 			}
@@ -1611,6 +1678,7 @@ static int __init kswapd_init(void)
 		= find_task_by_pid(kernel_thread(kswapd, pgdat, CLONE_KERNEL));
 	total_memory = nr_free_pagecache_pages();
 	hotcpu_notifier(cpu_callback, 0);
+	debug_reclaim_init();
 	return 0;
 }
 

--
