Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSJMKRj>; Sun, 13 Oct 2002 06:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbSJMKRj>; Sun, 13 Oct 2002 06:17:39 -0400
Received: from holomorphy.com ([66.224.33.161]:14985 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261486AbSJMKRg>;
	Sun, 13 Oct 2002 06:17:36 -0400
Date: Sun, 13 Oct 2002 03:19:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.42-mm2
Message-ID: <20021013101949.GB2032@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3DA7C3A5.98FCC13E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA7C3A5.98FCC13E@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 11:39:33PM -0700, Andrew Morton wrote:
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.42/2.5.42-mm2/

This patch does 5 things:

(1) when the OOM killer fails and the system panics, calls
	show_free_areas()
(2) reorganizes show_free_areas() to use for_each_zone()
(3) adds per-cpu stats to show_free_areas()
(4) tags output from show_free_areas() with node and zone information
(5) initializes zone->per_cpu_pageset[cpu].pcp[temperature].reserved
	in free_area_init_core()

The net effect is better reporting of where memory went, which was
essential to determining the cause of this failure, and that the
reserved page stuff can actually boot. Prior to this it was getting
total garbage in ->reserved after free_area_init_core():

Node 0, Zone DMA: per-cpu:
cpu 0 hot: low 32, high 96, batch 16, reserved 1683971840
cpu 0 cold: low 0, high 32, batch 16, reserved 1953719651
cpu 1 hot: low 32, high 96, batch 16, reserved 1702256479
cpu 1 cold: low 0, high 32, batch 16, reserved 825241951

And this caused a false bootmem OOM. It would have been impossible to
determine the cause of failure without show_free_areas() modifications,
and this is a box-killing bug that wipes out a significant fraction of
the high-end developer base from 2.5.x contributions as well as
preventing all i386 NUMA boxen, which the highest volume high-end
configurations, from booting. Furthermore, it also cleans up
show_free_areas() in a very straightforward fashion.

Against 2.5.42-mm2.


diff -urpN mm-2.5.42/mm/oom_kill.c virgin-2.5.42/mm/oom_kill.c
--- mm-2.5.42/mm/oom_kill.c	2002-10-11 21:22:08.000000000 -0700
+++ virgin-2.5.42/mm/oom_kill.c	2002-10-13 01:35:51.000000000 -0700
@@ -172,8 +172,10 @@ static void oom_kill(void)
 	p = select_bad_process();
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
-	if (p == NULL)
+	if (!p) {
+		show_free_areas();
 		panic("Out of memory and no killable processes...\n");
+	}
 
 	/* kill all processes that share the ->mm (i.e. all threads) */
 	do_each_thread(g, q)
diff -urpN mm-2.5.42/mm/page_alloc.c virgin-2.5.42/mm/page_alloc.c
--- mm-2.5.42/mm/page_alloc.c	2002-10-13 02:37:25.000000000 -0700
+++ virgin-2.5.42/mm/page_alloc.c	2002-10-13 02:05:12.000000000 -0700
@@ -830,11 +830,11 @@ void si_meminfo(struct sysinfo *val)
  */
 void show_free_areas(void)
 {
-	pg_data_t *pgdat;
 	struct page_state ps;
-	int type;
+	int cpu, temperature;
 	unsigned long active;
 	unsigned long inactive;
+	struct zone *zone;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive);
@@ -843,26 +843,24 @@ void show_free_areas(void)
 		K(nr_free_pages()),
 		K(nr_free_highpages()));
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
-		for (type = 0; type < MAX_NR_ZONES; ++type) {
-			struct zone *zone = &pgdat->node_zones[type];
-			printk("Zone:%s"
-				" freepages:%6lukB"
-				" min:%6lukB"
-				" low:%6lukB"
-				" high:%6lukB"
-				" active:%6lukB"
-				" inactive:%6lukB"
-				"\n",
-				zone->name,
-				K(zone->free_pages),
-				K(zone->pages_min),
-				K(zone->pages_low),
-				K(zone->pages_high),
-				K(zone->nr_active),
-				K(zone->nr_inactive)
-				);
-		}
+	for_each_zone(zone)
+		printk("Node %d, Zone:%s"
+			" freepages:%6lukB"
+			" min:%6lukB"
+			" low:%6lukB"
+			" high:%6lukB"
+			" active:%6lukB"
+			" inactive:%6lukB"
+			"\n",
+			zone->zone_pgdat->node_id,
+			zone->name,
+			K(zone->free_pages),
+			K(zone->pages_min),
+			K(zone->pages_low),
+			K(zone->pages_high),
+			K(zone->nr_active),
+			K(zone->nr_inactive)
+			);
 
 	printk("( Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u )\n",
 		active,
@@ -871,26 +869,49 @@ void show_free_areas(void)
 		ps.nr_writeback,
 		nr_free_pages());
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
-		for (type = 0; type < MAX_NR_ZONES; type++) {
-			struct list_head *elem;
-			struct zone *zone = &pgdat->node_zones[type];
- 			unsigned long nr, flags, order, total = 0;
+	for_each_zone(zone) {
+		struct list_head *elem;
+ 		unsigned long nr, flags, order, total = 0;
+
+		printk("Node %d, Zone %s: ", zone->zone_pgdat->node_id, zone->name);
+		if (!zone->present_pages) {
+			printk("empty\n");
+			continue;
+		}
 
-			if (!zone->present_pages)
-				continue;
+		spin_lock_irqsave(&zone->lock, flags);
+		for (order = 0; order < MAX_ORDER; order++) {
+			nr = 0;
+			list_for_each(elem, &zone->free_area[order].free_list)
+				++nr;
+			total += nr << order;
+			printk("%lu*%lukB ", nr, K(1UL) << order);
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+		printk("= %lukB)\n", K(total));
+	}
 
-			spin_lock_irqsave(&zone->lock, flags);
-			for (order = 0; order < MAX_ORDER; order++) {
-				nr = 0;
-				list_for_each(elem, &zone->free_area[order].free_list)
-					++nr;
-				total += nr << order;
-				printk("%lu*%lukB ", nr, K(1UL) << order);
-			}
-			spin_unlock_irqrestore(&zone->lock, flags);
-			printk("= %lukB)\n", K(total));
+	for_each_zone(zone) {
+		printk("Node %d, Zone %s: per-cpu:", zone->zone_pgdat->node_id, zone->name);
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
 		}
+	}
 
 	show_swap_cache_info();
 }
@@ -1097,6 +1118,7 @@ static void __init free_area_init_core(s
 			pcp->low = 32;
 			pcp->high = 96;
 			pcp->batch = 16;
+			pcp->reserved = 0;
 			INIT_LIST_HEAD(&pcp->list);
 
 			pcp = &zone->pageset[cpu].pcp[1];	/* cold */
@@ -1104,6 +1126,7 @@ static void __init free_area_init_core(s
 			pcp->low = 0;
 			pcp->high = 32;
 			pcp->batch = 16;
+			pcp->reserved = 0;
 			INIT_LIST_HEAD(&pcp->list);
 		}
 		INIT_LIST_HEAD(&zone->active_list);
