Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVKVTSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVKVTSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVKVTRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:17:55 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:40168 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965129AbVKVTR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:17:29 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       mingo@elte.hu
Message-Id: <20051122191725.21757.68325.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
References: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 3/5] Light fragmentation avoidance without usemap: 003_percpu
Date: Tue, 22 Nov 2005 19:17:28 +0000 (GMT)
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-002_fragcore/include/linux/mmzone.h linux-2.6.15-rc1-mm2-003_percpu/include/linux/mmzone.h
--- linux-2.6.15-rc1-mm2-002_fragcore/include/linux/mmzone.h	2005-11-22 16:50:09.000000000 +0000
+++ linux-2.6.15-rc1-mm2-003_percpu/include/linux/mmzone.h	2005-11-22 16:52:10.000000000 +0000
@@ -26,6 +26,8 @@
 #define RCLM_EASY   1
 #define RCLM_TYPES  2
 
+#define for_each_rclmtype(type) \
+	for (type = 0; type < RCLM_TYPES; type++)
 #define for_each_rclmtype_order(type, order) \
 	for (order = 0; order < MAX_ORDER; order++) \
 		for (type = 0; type < RCLM_TYPES; type++)
@@ -53,11 +55,11 @@ struct zone_padding {
 #endif
 
 struct per_cpu_pages {
-	int count;		/* number of pages in the list */
+	int count[RCLM_TYPES];	/* Number of pages on the lists */
 	int low;		/* low watermark, refill needed */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
-	struct list_head list;	/* the list of pages */
+	struct list_head list[RCLM_TYPES]; /* the lists of pages */
 };
 
 struct per_cpu_pageset {
@@ -72,6 +74,11 @@ struct per_cpu_pageset {
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-002_fragcore/mm/page_alloc.c linux-2.6.15-rc1-mm2-003_percpu/mm/page_alloc.c
--- linux-2.6.15-rc1-mm2-002_fragcore/mm/page_alloc.c	2005-11-22 16:50:09.000000000 +0000
+++ linux-2.6.15-rc1-mm2-003_percpu/mm/page_alloc.c	2005-11-22 16:52:10.000000000 +0000
@@ -637,7 +637,7 @@ static int rmqueue_bulk(struct zone *zon
 void drain_remote_pages(void)
 {
 	struct zone *zone;
-	int i;
+	int i, pindex;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -653,9 +653,16 @@ void drain_remote_pages(void)
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			if (pcp->count)
-				pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
+			for_each_rclmtype(pindex) {
+				if (!pcp->count[pindex])
+					continue;
+
+				/* Try remove all pages from the pcpu list */
+				pcp->count[pindex] -=
+					free_pages_bulk(zone,
+						pcp->count[pindex],
+						&pcp->list[pindex], 0);
+			}
 		}
 	}
 	local_irq_restore(flags);
@@ -666,7 +673,7 @@ void drain_remote_pages(void)
 static void __drain_pages(unsigned int cpu)
 {
 	struct zone *zone;
-	int i;
+	int i, pindex;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
@@ -676,8 +683,16 @@ static void __drain_pages(unsigned int c
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
+			for_each_rclmtype(pindex) {
+				if (!pcp->count[pindex])
+					continue;
+
+				/* Try remove all pages from the pcpu list */
+				pcp->count[pindex] -=
+					free_pages_bulk(zone,
+						pcp->count[pindex],
+						&pcp->list[pindex], 0);
+			}
 		}
 	}
 }
@@ -758,6 +773,7 @@ static void FASTCALL(free_hot_cold_page(
 static void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
+	int pindex = get_pageblock_type(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
@@ -773,10 +789,11 @@ static void fastcall free_hot_cold_page(
 
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
-	list_add(&page->lru, &pcp->list);
-	pcp->count++;
-	if (pcp->count >= pcp->high)
-		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
+	list_add(&page->lru, &pcp->list[pindex]);
+	pcp->count[pindex]++;
+	if (pcp->count[pindex] >= pcp->high)
+		pcp->count[pindex] -= free_pages_bulk(zone, pcp->batch,
+				&pcp->list[pindex], 0);
 	local_irq_restore(flags);
 	put_cpu();
 }
@@ -820,14 +837,16 @@ again:
 		page = NULL;
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
-		if (pcp->count <= pcp->low)
-			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list,
+		if (pcp->count[alloctype] <= pcp->low)
+			pcp->count[alloctype] += rmqueue_bulk(zone, 0,
+						pcp->batch,
+						&pcp->list[alloctype],
 						alloctype);
-		if (pcp->count) {
-			page = list_entry(pcp->list.next, struct page, lru);
+		if (pcp->count[alloctype]) {
+			page = list_entry(pcp->list[alloctype].next,
+					struct page, lru);
 			list_del(&page->lru);
-			pcp->count--;
+			pcp->count[alloctype]--;
 		}
 		local_irq_restore(flags);
 		put_cpu();
@@ -1478,7 +1497,7 @@ void show_free_areas(void)
 					pageset->pcp[temperature].low,
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].count);
+					pcp_count(&pageset->pcp[temperature]));
 		}
 	}
 
@@ -1920,18 +1939,23 @@ inline void setup_pageset(struct per_cpu
 	memset(p, 0, sizeof(*p));
 
 	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
+	pcp->count[RCLM_NORCLM] = 0;
+	pcp->count[RCLM_EASY] = 0;
 	pcp->low = 0;
 	pcp->high = 6 * batch;
 	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->list[RCLM_NORCLM]);
+	INIT_LIST_HEAD(&pcp->list[RCLM_EASY]);
 
 	pcp = &p->pcp[1];		/* cold*/
-	pcp->count = 0;
+
+	pcp->count[RCLM_NORCLM] = 0;
+	pcp->count[RCLM_EASY] = 0;
 	pcp->low = 0;
 	pcp->high = 2 * batch;
 	pcp->batch = max(1UL, batch/2);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->list[RCLM_NORCLM]);
+	INIT_LIST_HEAD(&pcp->list[RCLM_EASY]);
 }
 
 #ifdef CONFIG_NUMA
@@ -2328,7 +2352,7 @@ static int zoneinfo_show(struct seq_file
 					   "\n              high:  %i"
 					   "\n              batch: %i",
 					   i, j,
-					   pageset->pcp[j].count,
+					   pcp_count(&pageset->pcp[j]),
 					   pageset->pcp[j].low,
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
