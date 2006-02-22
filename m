Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWBVOcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWBVOcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWBVOcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:32:22 -0500
Received: from ns2.suse.de ([195.135.220.15]:12483 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750751AbWBVOcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:32:21 -0500
Date: Wed, 22 Feb 2006 15:32:17 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: [RFC][patch] mm: single pcp lists
Message-ID: <20060222143217.GI15546@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having a hot and a cold pcp list means that:

- cold pages are overlooked when when a hot page is needed but none available.
- when the hot list spills, it doesn't fill the cold list if it is low.

Use a single pcp list to solve both these problems.  Disallow cold page
allocation from taking hot pages though.

Index: linux-2.6/include/linux/mmzone.h
===================================================================
--- linux-2.6.orig/include/linux/mmzone.h
+++ linux-2.6/include/linux/mmzone.h
@@ -44,15 +44,13 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-struct per_cpu_pages {
+struct per_cpu_pageset {
+	struct list_head list;	/* the list of pages */
 	int count;		/* number of pages in the list */
+	int cold_count;		/* number of cold pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
-	struct list_head list;	/* the list of pages */
-};
 
-struct per_cpu_pageset {
-	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -598,27 +598,24 @@ static int rmqueue_bulk(struct zone *zon
 void drain_remote_pages(void)
 {
 	struct zone *zone;
-	int i;
 	unsigned long flags;
 
-	local_irq_save(flags);
 	for_each_zone(zone) {
-		struct per_cpu_pageset *pset;
-
 		/* Do not drain local pagesets */
 		if (zone->zone_pgdat->node_id == numa_node_id())
 			continue;
 
-		pset = zone_pcp(zone, smp_processor_id());
-		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
-			struct per_cpu_pages *pcp;
-
-			pcp = &pset->pcp[i];
-			free_pages_bulk(zone, pcp->count, &pcp->list, 0);
-			pcp->count = 0;
+		local_irq_save(flags);
+		if (zone->zone_pgdat->node_id != numa_node_id()) {
+			struct per_cpu_pageset *pset;
+
+			pset = zone_pcp(zone, smp_processor_id());
+			free_pages_bulk(zone, pset->count, &pset->list, 0);
+			pset->cold_count = 0;
+			pset->count = 0;
 		}
+		local_irq_restore(flags);
 	}
-	local_irq_restore(flags);
 }
 #endif
 
@@ -627,21 +624,16 @@ static void __drain_pages(unsigned int c
 {
 	unsigned long flags;
 	struct zone *zone;
-	int i;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
 
 		pset = zone_pcp(zone, cpu);
-		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
-			struct per_cpu_pages *pcp;
-
-			pcp = &pset->pcp[i];
-			local_irq_save(flags);
-			free_pages_bulk(zone, pcp->count, &pcp->list, 0);
-			pcp->count = 0;
-			local_irq_restore(flags);
-		}
+		local_irq_save(flags);
+		free_pages_bulk(zone, pset->count, &pset->list, 0);
+		pset->cold_count = 0;
+		pset->count = 0;
+		local_irq_restore(flags);
 	}
 }
 #endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
@@ -713,7 +705,7 @@ static void zone_statistics(struct zonel
 static void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
-	struct per_cpu_pages *pcp;
+	struct per_cpu_pageset *pset;
 	unsigned long flags;
 
 	arch_free_page(page, 0);
@@ -725,14 +717,22 @@ static void fastcall free_hot_cold_page(
 
 	kernel_map_pages(page, 1, 0);
 
-	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
+	pset = zone_pcp(zone, get_cpu());
 	local_irq_save(flags);
 	__inc_page_state(pgfree);
-	list_add(&page->lru, &pcp->list);
-	pcp->count++;
-	if (pcp->count >= pcp->high) {
-		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
-		pcp->count -= pcp->batch;
+	pset->count++;
+	if (cold) {
+		pset->cold_count++;
+		list_add_tail(&page->lru, &pset->list);
+	} else {
+		list_add(&page->lru, &pset->list);
+	}
+
+	if (pset->count > pset->high) {
+		int count = pset->batch;
+		free_pages_bulk(zone, count, &pset->list, 0);
+		pset->cold_count -= min(count, pset->cold_count);
+		pset->count -= count;
 	}
 	local_irq_restore(flags);
 	put_cpu();
@@ -782,19 +782,30 @@ static struct page *buffered_rmqueue(str
 again:
 	cpu  = get_cpu();
 	if (likely(order == 0)) {
-		struct per_cpu_pages *pcp;
+		struct per_cpu_pageset *pset;
 
-		pcp = &zone_pcp(zone, cpu)->pcp[cold];
+		pset = zone_pcp(zone, cpu);
 		local_irq_save(flags);
-		if (!pcp->count) {
-			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
-			if (unlikely(!pcp->count))
+		if (!pset->count || (cold && !pset->cold_count &&
+				pset->count <= pset->high - (pset->high>>2))) {
+			int count;
+			count = rmqueue_bulk(zone, 0, pset->batch, &pset->list);
+			if (unlikely(!count))
 				goto failed;
+			pset->count += count;
+			pset->cold_count += count;
+		}
+
+		pset->count--;
+		if (cold) {
+			page = list_entry(pset->list.prev, struct page, lru);
+			if (pset->cold_count)
+				pset->cold_count--;
+		} else {
+			page = list_entry(pset->list.next, struct page, lru);
+			pset->cold_count = min(pset->cold_count, pset->count);
 		}
-		page = list_entry(pcp->list.next, struct page, lru);
 		list_del(&page->lru);
-		pcp->count--;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 		page = __rmqueue(zone, order);
@@ -1385,7 +1396,7 @@ void si_meminfo_node(struct sysinfo *val
 void show_free_areas(void)
 {
 	struct page_state ps;
-	int cpu, temperature;
+	int cpu;
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
@@ -1402,17 +1413,11 @@ void show_free_areas(void)
 			printk("\n");
 
 		for_each_online_cpu(cpu) {
-			struct per_cpu_pageset *pageset;
-
-			pageset = zone_pcp(zone, cpu);
+			struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
 
-			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: high %d, batch %d used:%d\n",
-					cpu,
-					temperature ? "cold" : "hot",
-					pageset->pcp[temperature].high,
-					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].count);
+			printk("cpu %d: high %d, batch %d, pages %d, cold %d\n",
+				cpu, pset->high, pset->batch,
+				pset->count, pset->cold_count);
 		}
 	}
 
@@ -1845,23 +1850,14 @@ static int __cpuinit zone_batchsize(stru
 	return batch;
 }
 
-inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
+static inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
 {
-	struct per_cpu_pages *pcp;
-
 	memset(p, 0, sizeof(*p));
-
-	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
-	pcp->high = 6 * batch;
-	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
-
-	pcp = &p->pcp[1];		/* cold*/
-	pcp->count = 0;
-	pcp->high = 2 * batch;
-	pcp->batch = max(1UL, batch/2);
-	INIT_LIST_HEAD(&pcp->list);
+	p->count = 0;
+	p->cold_count = 0;
+	p->high = 6 * batch;
+	p->batch = max(1UL, 1 * batch);
+	INIT_LIST_HEAD(&p->list);
 }
 
 /*
@@ -1869,16 +1865,13 @@ inline void setup_pageset(struct per_cpu
  * to the value high for the pageset p.
  */
 
-static void setup_pagelist_highmark(struct per_cpu_pageset *p,
+static void setup_pagelist_highmark(struct per_cpu_pageset *pset,
 				unsigned long high)
 {
-	struct per_cpu_pages *pcp;
-
-	pcp = &p->pcp[0]; /* hot list */
-	pcp->high = high;
-	pcp->batch = max(1UL, high/4);
-	if ((high/4) > (PAGE_SHIFT * 8))
-		pcp->batch = PAGE_SHIFT * 8;
+	pset->high = high;
+	pset->batch = max(1UL, high/4);
+	if (pset->batch > PAGE_SHIFT * 8)
+		pset->batch = PAGE_SHIFT * 8;
 }
 
 
@@ -2259,27 +2252,15 @@ static int zoneinfo_show(struct seq_file
 			   ")"
 			   "\n  pagesets");
 		for_each_online_cpu(i) {
-			struct per_cpu_pageset *pageset;
-			int j;
+			struct per_cpu_pageset *pset;
 
-			pageset = zone_pcp(zone, i);
-			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				if (pageset->pcp[j].count)
-					break;
-			}
-			if (j == ARRAY_SIZE(pageset->pcp))
-				continue;
-			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				seq_printf(m,
-					   "\n    cpu: %i pcp: %i"
-					   "\n              count: %i"
-					   "\n              high:  %i"
-					   "\n              batch: %i",
-					   i, j,
-					   pageset->pcp[j].count,
-					   pageset->pcp[j].high,
-					   pageset->pcp[j].batch);
-			}
+			pset = zone_pcp(zone, i);
+			seq_printf(m,
+				   "\n    cpu: %i, pcp"
+				   "\n              count: %i"
+				   "\n              high:  %i"
+				   "\n              batch: %i",
+				   i, pset->count, pset->high, pset->batch);
 #ifdef CONFIG_NUMA
 			seq_printf(m,
 				   "\n            numa_hit:       %lu"
@@ -2288,12 +2269,12 @@ static int zoneinfo_show(struct seq_file
 				   "\n            interleave_hit: %lu"
 				   "\n            local_node:     %lu"
 				   "\n            other_node:     %lu",
-				   pageset->numa_hit,
-				   pageset->numa_miss,
-				   pageset->numa_foreign,
-				   pageset->interleave_hit,
-				   pageset->local_node,
-				   pageset->other_node);
+				   pset->numa_hit,
+				   pset->numa_miss,
+				   pset->numa_foreign,
+				   pset->interleave_hit,
+				   pset->local_node,
+				   pset->other_node);
 #endif
 		}
 		seq_printf(m,
