Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSJ1Qvf>; Mon, 28 Oct 2002 11:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSJ1Qvf>; Mon, 28 Oct 2002 11:51:35 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:60371 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261353AbSJ1Qva>; Mon, 28 Oct 2002 11:51:30 -0500
Date: Mon, 28 Oct 2002 16:58:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm show_free_areas layout
Message-ID: <Pine.LNX.4.44.0210281628550.10378-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this will come high on nobody's must-push-to-Linus list.

But the -mm tree's AltSysRqM display has got dominated by special
interests recently, so a lot of the familiar stuff gets pushed off
a 25-line screen.

Could we rearrange it? with the hot and cold taps and batchwater
levels first: those who are interested can swim back to them?
Omit the word "Zone " (I'd love non-NUMAs to omit "Node 0 " but
didn't find the right #define).  Less of those leading spaces
(free min low high active inactive lines have long been hard
to read); at last destroy that stray unmatched ")".

Of course, the search for perfection in the AltSysRqM display
will never cease: I've no idea whether this patch will unleash
a flamefest, a trickle of adjustments, or a warm cloud of apathy.
The patch makes the display look something like:

SysRq : Show Memory
Mem-info:
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1, reserved 0
cpu 0 cold: low 0, high 2, batch 1, reserved 0
cpu 1 hot: low 2, high 6, batch 1, reserved 0
cpu 1 cold: low 0, high 2, batch 1, reserved 0
Node 0 Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16, reserved 0
cpu 0 cold: low 0, high 32, batch 16, reserved 0
cpu 1 hot: low 32, high 96, batch 16, reserved 0
cpu 1 cold: low 0, high 32, batch 16, reserved 0
Node 0 HighMem per-cpu: empty

Free pages:      421284kB (0kB HighMem)
Active:3464 inactive:2007 dirty:82 writeback:0 free:105321
Node 0 DMA free:13084kB min:128kB low:256kB high:384kB active:0kB inactive:0kB
Node 0 Normal free:408200kB min:1020kB low:2040kB high:3060kB active:13856kB inactive:8028kB
Node 0 HighMem free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 0 DMA: 5*4kB 1*8kB 2*16kB 5*32kB 3*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 3*4096kB = 13084kB
Node 0 Normal: 16*4kB 1*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 99*4096kB = 408200kB
Node 0 HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:       2097136kB
115296 pages of RAM
0 pages of HIGHMEM
1958 reserved pages
3186 pages shared
0 pages swap cached

--- 2.5.44-mm6/mm/page_alloc.c	Mon Oct 28 16:02:01 2002
+++ linux/mm/page_alloc.c	Mon Oct 28 16:14:26 2002
@@ -879,21 +879,50 @@
 	unsigned long inactive;
 	struct zone *zone;
 
+	for_each_zone(zone) {
+		printk("Node %d %s per-cpu:", zone->zone_pgdat->node_id, zone->name);
+
+		if (!zone->present_pages) {
+			printk(" empty\n");
+			continue;
+		} else
+			printk("\n");
+
+		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+			struct per_cpu_pageset *pageset = zone->pageset + cpu;
+			for (temperature = 0; temperature < 2; temperature++)
+				printk("cpu %d %s: low %d, high %d, batch %d, reserved %d\n",
+					cpu,
+					temperature ? "cold" : "hot",
+					pageset->pcp[temperature].low,
+					pageset->pcp[temperature].high,
+					pageset->pcp[temperature].batch,
+					pageset->pcp[temperature].reserved);
+		}
+	}
+
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive);
 
-	printk("Free pages:      %6dkB (%6dkB HighMem)\n",
+	printk("\nFree pages: %11ukB (%ukB HighMem)\n",
 		K(nr_free_pages()),
 		K(nr_free_highpages()));
 
+	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u\n",
+		active,
+		inactive,
+		ps.nr_dirty,
+		ps.nr_writeback,
+		nr_free_pages());
+
 	for_each_zone(zone)
-		printk("Node %d, Zone:%s"
-			" freepages:%6lukB"
-			" min:%6lukB"
-			" low:%6lukB"
-			" high:%6lukB"
-			" active:%6lukB"
-			" inactive:%6lukB"
+		printk("Node %d %s"
+			" free:%lukB"
+			" min:%lukB"
+			" low:%lukB"
+			" high:%lukB"
+			" active:%lukB"
+			" inactive:%lukB"
 			"\n",
 			zone->zone_pgdat->node_id,
 			zone->name,
@@ -905,18 +934,11 @@
 			K(zone->nr_inactive)
 			);
 
-	printk("( Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u )\n",
-		active,
-		inactive,
-		ps.nr_dirty,
-		ps.nr_writeback,
-		nr_free_pages());
-
 	for_each_zone(zone) {
 		struct list_head *elem;
  		unsigned long nr, flags, order, total = 0;
 
-		printk("Node %d, Zone %s: ", zone->zone_pgdat->node_id, zone->name);
+		printk("Node %d %s: ", zone->zone_pgdat->node_id, zone->name);
 		if (!zone->present_pages) {
 			printk("empty\n");
 			continue;
@@ -931,29 +953,7 @@
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
-		printk("= %lukB)\n", K(total));
-	}
-
-	for_each_zone(zone) {
-		printk("Node %d, Zone %s: per-cpu:", zone->zone_pgdat->node_id, zone->name);
-
-		if (!zone->present_pages) {
-			printk(" empty\n");
-			continue;
-		} else
-			printk("\n");
-
-		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
-			struct per_cpu_pageset *pageset = zone->pageset + cpu;
-			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: low %d, high %d, batch %d, reserved %d\n",
-					cpu,
-					temperature ? "cold" : "hot",
-					pageset->pcp[temperature].low,
-					pageset->pcp[temperature].high,
-					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].reserved);
-		}
+		printk("= %lukB\n", K(total));
 	}
 
 	show_swap_cache_info();

