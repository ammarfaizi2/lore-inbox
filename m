Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWIGTEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWIGTEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWIGTEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:04:48 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:49632 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751363AbWIGTEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:04:44 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060907190442.6166.90028.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 3/8] Split the per-cpu lists into kernel and user parts
Date: Thu,  7 Sep 2006 20:04:42 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The freelists for each allocation type can slowly become fragmented due to
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
---

 include/linux/mmzone.h |   16 +++++++++--
 mm/page_alloc.c        |   63 +++++++++++++++++++++++++++-----------------
 mm/vmstat.c            |    4 +-
 3 files changed, 56 insertions(+), 27 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-002_fragcore/include/linux/mmzone.h linux-2.6.18-rc5-mm1-003_percpu/include/linux/mmzone.h
--- linux-2.6.18-rc5-mm1-002_fragcore/include/linux/mmzone.h	2006-09-04 18:37:59.000000000 +0100
+++ linux-2.6.18-rc5-mm1-003_percpu/include/linux/mmzone.h	2006-09-04 18:39:39.000000000 +0100
@@ -28,6 +28,8 @@
 #define RCLM_EASY   1
 #define RCLM_TYPES  2
 
+#define for_each_rclmtype(type) \
+	for (type = 0; type < RCLM_TYPES; type++)
 #define for_each_rclmtype_order(type, order) \
 	for (order = 0; order < MAX_ORDER; order++) \
 		for (type = 0; type < RCLM_TYPES; type++)
@@ -77,10 +79,10 @@ enum zone_stat_item {
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
-	int count;		/* number of pages in the list */
+	int counts[RCLM_TYPES];	/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
-	struct list_head list;	/* the list of pages */
+	struct list_head list[RCLM_TYPES];	/* the list of pages */
 };
 
 struct per_cpu_pageset {
@@ -91,6 +93,16 @@ struct per_cpu_pageset {
 #endif
 } ____cacheline_aligned_in_smp;
 
+static inline int pcp_count(struct per_cpu_pages *pcp)
+{
+	int rclmtype, count = 0;
+
+	for_each_rclmtype(rclmtype)
+		count += pcp->counts[rclmtype];
+
+	return count;
+}
+
 #ifdef CONFIG_NUMA
 #define zone_pcp(__z, __cpu) ((__z)->pageset[(__cpu)])
 #else
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-002_fragcore/mm/page_alloc.c linux-2.6.18-rc5-mm1-003_percpu/mm/page_alloc.c
--- linux-2.6.18-rc5-mm1-002_fragcore/mm/page_alloc.c	2006-09-04 18:37:59.000000000 +0100
+++ linux-2.6.18-rc5-mm1-003_percpu/mm/page_alloc.c	2006-09-04 18:39:39.000000000 +0100
@@ -745,7 +745,7 @@ static int rmqueue_bulk(struct zone *zon
  */
 void drain_node_pages(int nodeid)
 {
-	int i;
+	int i, pindex;
 	enum zone_type z;
 	unsigned long flags;
 
@@ -761,10 +761,14 @@ void drain_node_pages(int nodeid)
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			if (pcp->count) {
+			if (pcp_count(pcp)) {
 				local_irq_save(flags);
-				free_pages_bulk(zone, pcp->count, &pcp->list, 0);
-				pcp->count = 0;
+				for_each_rclmtype(pindex) {
+					free_pages_bulk(zone,
+							pcp->counts[pindex],
+							&pcp->list[pindex], 0);
+					pcp->counts[pindex] = 0;
+				}
 				local_irq_restore(flags);
 			}
 		}
@@ -777,7 +781,7 @@ static void __drain_pages(unsigned int c
 {
 	unsigned long flags;
 	struct zone *zone;
-	int i;
+	int i, pindex;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
@@ -788,8 +792,13 @@ static void __drain_pages(unsigned int c
 
 			pcp = &pset->pcp[i];
 			local_irq_save(flags);
-			free_pages_bulk(zone, pcp->count, &pcp->list, 0);
-			pcp->count = 0;
+			for_each_rclmtype(pindex) {
+				free_pages_bulk(zone,
+						pcp->counts[pindex],
+						&pcp->list[pindex], 0);
+
+				pcp->counts[pindex] = 0;
+			}
 			local_irq_restore(flags);
 		}
 	}
@@ -851,6 +860,7 @@ void drain_local_pages(void)
 static void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
+	int pindex = get_pageblock_type(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
@@ -866,11 +876,11 @@ static void fastcall free_hot_cold_page(
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
 	__count_vm_event(PGFREE);
-	list_add(&page->lru, &pcp->list);
-	pcp->count++;
-	if (pcp->count >= pcp->high) {
-		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
-		pcp->count -= pcp->batch;
+	list_add(&page->lru, &pcp->list[pindex]);
+	pcp->counts[pindex]++;
+	if (pcp->counts[pindex] >= pcp->high) {
+		free_pages_bulk(zone, pcp->batch, &pcp->list[pindex], 0);
+		pcp->counts[pindex] -= pcp->batch;
 	}
 	local_irq_restore(flags);
 	put_cpu();
@@ -916,6 +926,7 @@ static struct page *buffered_rmqueue(str
 	struct page *page;
 	int cold = !!(gfp_flags & __GFP_COLD);
 	int cpu;
+	int rclmtype = gfpflags_to_rclmtype(gfp_flags);
 
 again:
 	cpu  = get_cpu();
@@ -924,15 +935,15 @@ again:
 
 		pcp = &zone_pcp(zone, cpu)->pcp[cold];
 		local_irq_save(flags);
-		if (!pcp->count) {
-			pcp->count += rmqueue_bulk(zone, 0,
-				pcp->batch, &pcp->list, gfp_flags);
-			if (unlikely(!pcp->count))
+		if (!pcp->counts[rclmtype]) {
+			pcp->counts[rclmtype] += rmqueue_bulk(zone, 0,
+				pcp->batch, &pcp->list[rclmtype], gfp_flags);
+			if (unlikely(!pcp->counts[rclmtype]))
 				goto failed;
 		}
-		page = list_entry(pcp->list.next, struct page, lru);
+		page = list_entry(pcp->list[rclmtype].next, struct page, lru);
 		list_del(&page->lru);
-		pcp->count--;
+		pcp->counts[rclmtype]--;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 		page = __rmqueue(zone, order, gfp_flags);
@@ -1480,7 +1491,7 @@ void show_free_areas(void)
 					temperature ? "cold" : "hot",
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].count);
+					pcp_count(&pageset->pcp[temperature]));
 		}
 	}
 
@@ -1921,20 +1932,26 @@ static int __cpuinit zone_batchsize(stru
 inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
 {
 	struct per_cpu_pages *pcp;
+	int rclmtype;
 
 	memset(p, 0, sizeof(*p));
 
 	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
+	for_each_rclmtype(rclmtype) {
+		pcp->counts[rclmtype] = 0;
+		INIT_LIST_HEAD(&pcp->list[rclmtype]);
+	}
 	pcp->high = 6 * batch;
 	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->list[RCLM_EASY]);
 
 	pcp = &p->pcp[1];		/* cold*/
-	pcp->count = 0;
+	for_each_rclmtype(rclmtype) {
+		pcp->counts[rclmtype] = 0;
+		INIT_LIST_HEAD(&pcp->list[rclmtype]);
+	}
 	pcp->high = 2 * batch;
 	pcp->batch = max(1UL, batch/2);
-	INIT_LIST_HEAD(&pcp->list);
 }
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-002_fragcore/mm/vmstat.c linux-2.6.18-rc5-mm1-003_percpu/mm/vmstat.c
--- linux-2.6.18-rc5-mm1-002_fragcore/mm/vmstat.c	2006-09-04 18:34:33.000000000 +0100
+++ linux-2.6.18-rc5-mm1-003_percpu/mm/vmstat.c	2006-09-04 18:39:39.000000000 +0100
@@ -562,7 +562,7 @@ static int zoneinfo_show(struct seq_file
 
 			pageset = zone_pcp(zone, i);
 			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				if (pageset->pcp[j].count)
+				if (pcp_count(&pageset->pcp[j]))
 					break;
 			}
 			if (j == ARRAY_SIZE(pageset->pcp))
@@ -574,7 +574,7 @@ static int zoneinfo_show(struct seq_file
 					   "\n              high:  %i"
 					   "\n              batch: %i",
 					   i, j,
-					   pageset->pcp[j].count,
+					   pcp_count(&pageset->pcp[j]),
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
 			}
