Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263511AbSIQCsc>; Mon, 16 Sep 2002 22:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263512AbSIQCsc>; Mon, 16 Sep 2002 22:48:32 -0400
Received: from holomorphy.com ([66.224.33.161]:21218 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263511AbSIQCsb>;
	Mon, 16 Sep 2002 22:48:31 -0400
Date: Mon, 16 Sep 2002 19:50:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: false NUMA OOM
Message-ID: <20020917025035.GY2179@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, there's an obvious problem. shrink_caches() hammers out_of_memory()
when it has only looked at a single node. Something like this might help.

Totally untested. Problem discovered during 2 simultaneous dbench 512's
on separate 12GB tmpfs fs's on a 32x NUMA-Q with 32GB of RAM.

Against 2.5.35.


Bill


--- mm/vmscan.c.orig	2002-09-16 19:02:11.000000000 -0700
+++ mm/vmscan.c	2002-09-16 19:07:50.000000000 -0700
@@ -519,18 +519,24 @@
 shrink_caches(struct zone *classzone, int priority,
 		int gfp_mask, int nr_pages)
 {
+	pg_data_t *pgdat;
 	struct zone *first_classzone;
 	struct zone *zone;
+	int type;
 
 	first_classzone = classzone->zone_pgdat->node_zones;
-	zone = classzone;
-	while (zone >= first_classzone && nr_pages > 0) {
-		if (zone->free_pages <= zone->pages_high) {
-			nr_pages = shrink_zone(zone, priority,
-					gfp_mask, nr_pages);
+	for (type = classzone - first_classzone; type >= 0; --type)
+		for_each_pgdat(pgdat) {
+			zone = pgdat->node_zones + type;
+			if (!zone->size)
+				continue;
+			if (zone->free_pages <= zone->pages_high)
+				nr_pages = shrink_zone(zone, priority,
+							gfp_mask, nr_pages);
+			if (nr_pages <= 0)
+				return nr_pages;
 		}
-		zone--;
-	}
+
 	return nr_pages;
 }
 
