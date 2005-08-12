Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVHLOsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVHLOsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbVHLOr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63685 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750786AbVHLOrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:23 -0400
Subject: [RFC][PATCH 02/12] memory hotplug prep: break out zone initialization
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:16 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144716.E5BF9F99@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If a zone is empty at boot-time and then hot-added to later,
it needs to run the same init code that would have been run
on it at boot.

This patch breaks out zone table and per-cpu-pages functions
for use by the hotplug code.  You can almost see all of the
free_area_init_core() function on one page now. :)

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/page_alloc.c |   98 +++++++++++++++++++++++-----------------
 1 files changed, 58 insertions(+), 40 deletions(-)

diff -puN mm/page_alloc.c~C1-pcp_zone_init mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~C1-pcp_zone_init	2005-08-12 07:43:44.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-08-12 07:43:44.000000000 -0700
@@ -1850,6 +1850,60 @@ void __init setup_per_cpu_pageset()
 
 #endif
 
+static __devinit
+void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
+{
+	int i;
+
+	/*
+	 * The per-page waitqueue mechanism uses hashed waitqueues
+	 * per zone.
+	 */
+	zone->wait_table_size = wait_table_size(zone_size_pages);
+	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
+	zone->wait_table = (wait_queue_head_t *)
+		alloc_bootmem_node(pgdat, zone->wait_table_size
+					* sizeof(wait_queue_head_t));
+
+	for(i = 0; i < zone->wait_table_size; ++i)
+		init_waitqueue_head(zone->wait_table + i);
+}
+
+static __devinit void zone_pcp_init(struct zone *zone)
+{
+	int cpu;
+	unsigned long batch = zone_batchsize(zone);
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+#ifdef CONFIG_NUMA
+		/* Early boot. Slab allocator not functional yet */
+		zone->pageset[cpu] = &boot_pageset[cpu];
+		setup_pageset(&boot_pageset[cpu],0);
+#else
+		setup_pageset(zone_pcp(zone,cpu), batch);
+#endif
+	}
+	printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
+		zone->name, zone->present_pages, batch);
+}
+
+static void init_currently_empty_zone(struct zone *zone,
+		unsigned long zone_start_pfn, unsigned long size)
+{
+	struct pglist_data *pgdat = zone->zone_pgdat;
+
+	zone_wait_table_init(zone, size);
+	pgdat->nr_zones = zone_idx(zone) + 1;
+
+	zone->zone_mem_map = pfn_to_page(zone_start_pfn);
+	zone->zone_start_pfn = zone_start_pfn;
+
+	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
+
+	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+}
+
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1859,8 +1913,8 @@ void __init setup_per_cpu_pageset()
 static void __init free_area_init_core(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
-	unsigned long i, j;
-	int cpu, nid = pgdat->node_id;
+	unsigned long j;
+	int nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 
 	pgdat->nr_zones = 0;
@@ -1870,7 +1924,6 @@ static void __init free_area_init_core(s
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
-		unsigned long batch;
 
 		realsize = size = zones_size[j];
 		if (zholes_size)
@@ -1890,19 +1943,7 @@ static void __init free_area_init_core(s
 
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 
-		batch = zone_batchsize(zone);
-
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-#ifdef CONFIG_NUMA
-			/* Early boot. Slab allocator not functional yet */
-			zone->pageset[cpu] = &boot_pageset[cpu];
-			setup_pageset(&boot_pageset[cpu],0);
-#else
-			setup_pageset(zone_pcp(zone,cpu), batch);
-#endif
-		}
-		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
-				zone_names[j], realsize, batch);
+		zone_pcp_init(zone);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
 		zone->nr_scan_active = 0;
@@ -1913,32 +1954,9 @@ static void __init free_area_init_core(s
 		if (!size)
 			continue;
 
-		/*
-		 * The per-page waitqueue mechanism uses hashed waitqueues
-		 * per zone.
-		 */
-		zone->wait_table_size = wait_table_size(size);
-		zone->wait_table_bits =
-			wait_table_bits(zone->wait_table_size);
-		zone->wait_table = (wait_queue_head_t *)
-			alloc_bootmem_node(pgdat, zone->wait_table_size
-						* sizeof(wait_queue_head_t));
-
-		for(i = 0; i < zone->wait_table_size; ++i)
-			init_waitqueue_head(zone->wait_table + i);
-
-		pgdat->nr_zones = j+1;
-
-		zone->zone_mem_map = pfn_to_page(zone_start_pfn);
-		zone->zone_start_pfn = zone_start_pfn;
-
-		memmap_init(size, nid, j, zone_start_pfn);
-
 		zonetable_add(zone, nid, j, zone_start_pfn, size);
-
+		init_currently_empty_zone(zone, zone_start_pfn, size);
 		zone_start_pfn += size;
-
-		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
 	}
 }
 
diff -L ser -puN /dev/null /dev/null
_
