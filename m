Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265822AbTGIIcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbTGIIcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:32:07 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:51370 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265822AbTGIIby
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 9 Jul 2003 04:31:54 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.54887.932511.717315@laputa.namesys.com>
Date: Wed, 9 Jul 2003 12:46:31 +0400
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: [PATCH] 1/5 VM changes: zone-pressure.patch
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add zone->pressure field. It estimates scanning intensity for this zone and
is calculated as exponentially decaying average of the scanning priority
required to free enough pages in this zone (mm/vmscan.c:zone_adj_pressure()).

zone->pressure is supposed to be used in stead of scanning priority by
vmscan.c. This is used by later patches in a series.



diff -puN include/linux/mmzone.h~zone-pressure include/linux/mmzone.h
--- i386/include/linux/mmzone.h~zone-pressure	Wed Jul  9 12:24:50 2003
+++ i386-god/include/linux/mmzone.h	Wed Jul  9 12:24:50 2003
@@ -84,11 +84,23 @@ struct zone {
 	atomic_t		refill_counter;
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
-	int			all_unreclaimable; /* All pages pinned */
+	int			all_unreclaimable:1; /* All pages pinned */
 	unsigned long		pages_scanned;	   /* since last reclaim */
 
 	ZONE_PADDING(_pad2_)
 
+ 	/*
+	 * measure of scanning intensity for this zone. It is calculated
+	 * as exponentially decaying average of the scanning priority
+	 * required to free enough pages in this zone
+	 * (zone_adj_pressure()).
+	 *
+	 *     0                    --- low pressure
+	 *
+	 *     (DEF_PRIORITY << 10) --- high pressure
+	 */
+	int pressure;
+
 	/*
 	 * free areas of different sizes
 	 */
diff -puN mm/vmscan.c~zone-pressure mm/vmscan.c
--- i386/mm/vmscan.c~zone-pressure	Wed Jul  9 12:24:50 2003
+++ i386-god/mm/vmscan.c	Wed Jul  9 12:24:50 2003
@@ -80,6 +80,22 @@ static long total_memory;
 #endif
 
 /*
+ * exponentially decaying average
+ */
+static inline int expavg(int avg, int val, int order)
+{
+	return ((val - avg) >> order) + avg;
+}
+
+static void zone_adj_pressure(struct zone * zone, int priority)
+{
+	int pass;
+
+	pass = DEF_PRIORITY - priority;
+	zone->pressure = expavg(zone->pressure, pass << 10, 1);
+}
+
+/*
  * The list of shrinker callbacks used by to apply pressure to
  * ageable caches.
  */
@@ -794,8 +810,10 @@ shrink_caches(struct zone *classzone, in
 		ret += shrink_zone(zone, max_scan, gfp_mask,
 				to_reclaim, &nr_mapped, ps, priority);
 		*total_scanned += max_scan + nr_mapped;
-		if (ret >= nr_pages)
+		if (ret >= nr_pages) {
+			zone_adj_pressure(zone, priority);
 			break;
+		}
 	}
 	return ret;
 }
@@ -824,6 +842,7 @@ int try_to_free_pages(struct zone *cz,
 	int ret = 0;
 	const int nr_pages = SWAP_CLUSTER_MAX;
 	int nr_reclaimed = 0;
+	struct zone *zone;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 
 	inc_page_state(allocstall);
@@ -860,6 +879,8 @@ int try_to_free_pages(struct zone *cz,
 	}
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
 		out_of_memory();
+	for (zone = cz; zone >= cz->zone_pgdat->node_zones; -- zone)
+		zone_adj_pressure(zone, -1);
 out:
 	return ret;
 }
@@ -907,8 +928,10 @@ static int balance_pgdat(pg_data_t *pgda
 				to_reclaim = min(to_free, SWAP_CLUSTER_MAX*8);
 			} else {			/* Zone balancing */
 				to_reclaim = zone->pages_high-zone->free_pages;
-				if (to_reclaim <= 0)
+				if (to_reclaim <= 0) {
+					zone_adj_pressure(zone, priority);
 					continue;
+				}
 			}
 			all_zones_ok = 0;
 			max_scan = zone->nr_inactive >> priority;
@@ -932,6 +955,14 @@ static int balance_pgdat(pg_data_t *pgda
 			break;
 		blk_congestion_wait(WRITE, HZ/10);
 	}
+	if (priority < 0) {
+		for (i = 0; i < pgdat->nr_zones; i++) {
+			struct zone *zone = pgdat->node_zones + i;
+
+			if (zone->free_pages < zone->pages_high)
+				zone_adj_pressure(zone, -1);
+		}
+	}
 	return nr_pages - to_free;
 }
 

_
