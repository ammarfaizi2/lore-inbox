Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946783AbWKALRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946783AbWKALRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946785AbWKALRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:17:24 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:12939 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1946783AbWKALRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:17:22 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101111720.18798.75303.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 3/11] Split the per-cpu lists into RCLM_TYPES lists
Date: Wed,  1 Nov 2006 11:17:20 +0000 (GMT)
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

 include/linux/mmzone.h |   16 +++++++++-
 mm/page_alloc.c        |   66 ++++++++++++++++++++++++++++----------------
 mm/vmstat.c            |    4 +-
 3 files changed, 58 insertions(+), 28 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-002_fragcore/include/linux/mmzone.h linux-2.6.19-rc4-mm1-003_percpu/include/linux/mmzone.h
--- linux-2.6.19-rc4-mm1-002_fragcore/include/linux/mmzone.h	2006-10-31 13:31:10.000000000 +0000
+++ linux-2.6.19-rc4-mm1-003_percpu/include/linux/mmzone.h	2006-10-31 13:35:47.000000000 +0000
@@ -28,6 +28,8 @@
 #define RCLM_EASY   1
 #define RCLM_TYPES  2
 
+#define for_each_rclmtype(type) \
+	for (type = 0; type < RCLM_TYPES; type++)
 #define for_each_rclmtype_order(order, type) \
 	for (order = 0; order < MAX_ORDER; order++) \
 		for (type = 0; type < RCLM_TYPES; type++)
@@ -78,10 +80,10 @@ enum zone_stat_item {
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
@@ -92,6 +94,16 @@ struct per_cpu_pageset {
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
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-002_fragcore/mm/page_alloc.c linux-2.6.19-rc4-mm1-003_percpu/mm/page_alloc.c
--- linux-2.6.19-rc4-mm1-002_fragcore/mm/page_alloc.c	2006-10-31 13:33:27.000000000 +0000
+++ linux-2.6.19-rc4-mm1-003_percpu/mm/page_alloc.c	2006-10-31 13:40:01.000000000 +0000
@@ -748,7 +748,7 @@ static int rmqueue_bulk(struct zone *zon
  */
 void drain_node_pages(int nodeid)
 {
-	int i;
+	int i, pindex;
 	enum zone_type z;
 	unsigned long flags;
 
@@ -764,10 +764,14 @@ void drain_node_pages(int nodeid)
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
@@ -780,7 +784,7 @@ static void __drain_pages(unsigned int c
 {
 	unsigned long flags;
 	struct zone *zone;
-	int i;
+	int i, pindex;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
@@ -791,8 +795,13 @@ static void __drain_pages(unsigned int c
 
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
@@ -854,6 +863,7 @@ void drain_local_pages(void)
 static void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
+	int pindex = get_page_rclmtype(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
@@ -870,11 +880,11 @@ static void fastcall free_hot_cold_page(
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
@@ -920,6 +930,7 @@ static struct page *buffered_rmqueue(str
 	struct page *page;
 	int cold = !!(gfp_flags & __GFP_COLD);
 	int cpu;
+	int rclmtype = gfpflags_to_rclmtype(gfp_flags);
 
 again:
 	cpu  = get_cpu();
@@ -928,15 +939,15 @@ again:
 
 		pcp = &zone_pcp(zone, cpu)->pcp[cold];
 		local_irq_save(flags);
-		if (!pcp->count) {
-			pcp->count = rmqueue_bulk(zone, 0,
-					pcp->batch, &pcp->list, gfp_flags);
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
@@ -1621,9 +1632,10 @@ void show_free_areas(void)
 			printk("CPU %4d: Hot: hi:%5d, btch:%4d usd:%4d   "
 			       "Cold: hi:%5d, btch:%4d usd:%4d\n",
 			       cpu, pageset->pcp[0].high,
-			       pageset->pcp[0].batch, pageset->pcp[0].count,
+			       pageset->pcp[0].batch,
+			       pcp_count(&pageset->pcp[0]),
 			       pageset->pcp[1].high, pageset->pcp[1].batch,
-			       pageset->pcp[1].count);
+			       pcp_count(&pageset->pcp[1]));
 		}
 	}
 
@@ -2084,20 +2096,26 @@ static int __cpuinit zone_batchsize(stru
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
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-002_fragcore/mm/vmstat.c linux-2.6.19-rc4-mm1-003_percpu/mm/vmstat.c
--- linux-2.6.19-rc4-mm1-002_fragcore/mm/vmstat.c	2006-10-31 13:27:13.000000000 +0000
+++ linux-2.6.19-rc4-mm1-003_percpu/mm/vmstat.c	2006-10-31 13:35:47.000000000 +0000
@@ -569,7 +569,7 @@ static int zoneinfo_show(struct seq_file
 
 			pageset = zone_pcp(zone, i);
 			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				if (pageset->pcp[j].count)
+				if (pcp_count(&pageset->pcp[j]))
 					break;
 			}
 			if (j == ARRAY_SIZE(pageset->pcp))
@@ -581,7 +581,7 @@ static int zoneinfo_show(struct seq_file
 					   "\n              high:  %i"
 					   "\n              batch: %i",
 					   i, j,
-					   pageset->pcp[j].count,
+					   pcp_count(&pageset->pcp[j]),
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
 			}
