Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWATL4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWATL4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWATL4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:56:43 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:37508 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750860AbWATL4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:56:23 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060120115515.16475.84525.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie>
References: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 3/4] Split the per-cpu lists into kernel and user parts
Date: Fri, 20 Jan 2006 11:55:15 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The freelists for each allocation type can slowly become corrupted due to
the per-cpu list. Consider what happens when the following happens

1. A 2^(MAX_ORDER-1) list is reserved for __GFP_EASYRCLM pages
2. An order-0 page is allocated from the newly reserved block
3. The page is freed and placed on the per-cpu list
4. alloc_page() is called with GFP_KERNEL as the gfp_mask
5. The per-cpu list is used to satisfy the allocation

This results in a kernel page is in the middle of a RCLM_EASY region. This
means that over long periods of the time, the anti-fragmentation scheme
slowly degrades to the standard allocator.

This patch divides the per-cpu lists into RCLM_TYPES number of lists.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h linux-2.6.16-rc1-mm1-003_percpu/include/linux/mmzone.h
--- linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h	2006-01-19 21:51:05.000000000 +0000
+++ linux-2.6.16-rc1-mm1-003_percpu/include/linux/mmzone.h	2006-01-19 22:15:16.000000000 +0000
@@ -26,6 +26,8 @@
 #define RCLM_EASY   1
 #define RCLM_TYPES  2
 
+#define for_each_rclmtype(type) \
+	for (type = 0; type < RCLM_TYPES; type++)
 #define for_each_rclmtype_order(type, order) \
 	for (order = 0; order < MAX_ORDER; order++) \
 		for (type = 0; type < RCLM_TYPES; type++)
@@ -53,10 +55,10 @@ struct zone_padding {
 #endif
 
 struct per_cpu_pages {
-	int count;		/* number of pages in the list */
+	int count[RCLM_TYPES];	/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
-	struct list_head list;	/* the list of pages */
+	struct list_head list[RCLM_TYPES];	/* the list of pages */
 };
 
 struct per_cpu_pageset {
@@ -71,6 +73,11 @@ struct per_cpu_pageset {
 #endif
 } ____cacheline_aligned_in_smp;
 
+static inline int pcp_count(struct per_cpu_pages *pcp)
+{
+	return pcp->count[RCLM_NORCLM] + pcp->count[RCLM_EASY];
+}
+
 #ifdef CONFIG_NUMA
 #define zone_pcp(__z, __cpu) ((__z)->pageset[(__cpu)])
 #else
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-002_fragcore/mm/page_alloc.c linux-2.6.16-rc1-mm1-003_percpu/mm/page_alloc.c
--- linux-2.6.16-rc1-mm1-002_fragcore/mm/page_alloc.c	2006-01-19 22:12:09.000000000 +0000
+++ linux-2.6.16-rc1-mm1-003_percpu/mm/page_alloc.c	2006-01-19 22:26:45.000000000 +0000
@@ -663,7 +663,7 @@ static int rmqueue_bulk(struct zone *zon
 void drain_remote_pages(void)
 {
 	struct zone *zone;
-	int i;
+	int i, pindex;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -679,8 +679,12 @@ void drain_remote_pages(void)
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			free_pages_bulk(zone, pcp->count, &pcp->list, 0);
-			pcp->count = 0;
+			for_each_rclmtype(pindex) {
+				free_pages_bulk(zone,
+						pcp->count[pindex],
+						&pcp->list[pindex], 0);
+				pcp->count[pindex] = 0;
+			}
 		}
 	}
 	local_irq_restore(flags);
@@ -692,7 +696,7 @@ static void __drain_pages(unsigned int c
 {
 	unsigned long flags;
 	struct zone *zone;
-	int i;
+	int i, pindex;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
@@ -703,8 +707,13 @@ static void __drain_pages(unsigned int c
 
 			pcp = &pset->pcp[i];
 			local_irq_save(flags);
-			free_pages_bulk(zone, pcp->count, &pcp->list, 0);
-			pcp->count = 0;
+			for_each_rclmtype(pindex) {
+				free_pages_bulk(zone,
+						pcp->count[pindex],
+						&pcp->list[pindex], 0);
+
+				pcp->count[pindex] = 0;
+			}
 			local_irq_restore(flags);
 		}
 	}
@@ -780,6 +789,7 @@ static void zone_statistics(struct zonel
 static void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
+	int pindex = get_pageblock_type(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
@@ -795,11 +805,11 @@ static void fastcall free_hot_cold_page(
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
 	__inc_page_state(pgfree);
-	list_add(&page->lru, &pcp->list);
-	pcp->count++;
-	if (pcp->count >= pcp->high) {
-		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
-		pcp->count -= pcp->batch;
+	list_add(&page->lru, &pcp->list[pindex]);
+	pcp->count[pindex]++;
+	if (pcp->count[pindex] >= pcp->high) {
+		free_pages_bulk(zone, pcp->batch, &pcp->list[pindex], 0);
+		pcp->count[pindex] -= pcp->batch;
 	}
 	local_irq_restore(flags);
 	put_cpu();
@@ -845,16 +855,17 @@ again:
 
 		pcp = &zone_pcp(zone, cpu)->pcp[cold];
 		local_irq_save(flags);
-		if (!pcp->count) {
-			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list,
+		if (!pcp->count[alloctype]) {
+			pcp->count[alloctype] += rmqueue_bulk(zone, 0,
+						pcp->batch,
+						&pcp->list[alloctype],
 						alloctype);
 			if (unlikely(!pcp->count))
 				goto failed;
 		}
-		page = list_entry(pcp->list.next, struct page, lru);
+		page = list_entry(pcp->list[alloctype].next, struct page, lru);
 		list_del(&page->lru);
-		pcp->count--;
+		pcp->count[alloctype]--;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 		page = __rmqueue(zone, order, alloctype);
@@ -1534,7 +1545,7 @@ void show_free_areas(void)
 					temperature ? "cold" : "hot",
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].count);
+					pcp_count(&pageset->pcp[temperature]));
 		}
 	}
 
@@ -1978,16 +1989,20 @@ inline void setup_pageset(struct per_cpu
 	memset(p, 0, sizeof(*p));
 
 	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
+	pcp->count[RCLM_NORCLM] = 0;
+	pcp->count[RCLM_EASY] = 0;
 	pcp->high = 6 * batch;
 	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->list[RCLM_NORCLM]);
+	INIT_LIST_HEAD(&pcp->list[RCLM_EASY]);
 
 	pcp = &p->pcp[1];		/* cold*/
-	pcp->count = 0;
+	pcp->count[RCLM_NORCLM] = 0;
+	pcp->count[RCLM_EASY] = 0;
 	pcp->high = 2 * batch;
 	pcp->batch = max(1UL, batch/2);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->list[RCLM_NORCLM]);
+	INIT_LIST_HEAD(&pcp->list[RCLM_EASY]);
 }
 
 /*
@@ -2403,7 +2418,7 @@ static int zoneinfo_show(struct seq_file
 					   "\n              high:  %i"
 					   "\n              batch: %i",
 					   i, j,
-					   pageset->pcp[j].count,
+					   pcp_count(&pageset->pcp[j]),
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
 			}
