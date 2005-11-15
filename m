Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVKOQun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVKOQun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVKOQug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:50:36 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:40108 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964930AbVKOQuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:50:10 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Message-Id: <20051115165007.21980.37336.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 4/5] Light Fragmentation Avoidance V20: 004_percpu
Date: Tue, 15 Nov 2005 16:50:09 +0000 (GMT)
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-003_fragcore/include/linux/mmzone.h linux-2.6.14-mm2-004_percpu/include/linux/mmzone.h
--- linux-2.6.14-mm2-003_fragcore/include/linux/mmzone.h	2005-11-15 12:43:41.000000000 +0000
+++ linux-2.6.14-mm2-004_percpu/include/linux/mmzone.h	2005-11-15 12:44:23.000000000 +0000
@@ -56,11 +56,11 @@ struct zone_padding {
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
@@ -75,6 +75,9 @@ struct per_cpu_pageset {
 #endif
 } ____cacheline_aligned_in_smp;
 
+/* Helpers for per_cpu_pages */
+#define pcp_count(pcp) (pcp.count[RCLM_NORCLM] + pcp.count[RCLM_EASY])
+
 #ifdef CONFIG_NUMA
 #define zone_pcp(__z, __cpu) ((__z)->pageset[(__cpu)])
 #else
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-003_fragcore/mm/page_alloc.c linux-2.6.14-mm2-004_percpu/mm/page_alloc.c
--- linux-2.6.14-mm2-003_fragcore/mm/page_alloc.c	2005-11-15 12:44:27.000000000 +0000
+++ linux-2.6.14-mm2-004_percpu/mm/page_alloc.c	2005-11-15 12:44:23.000000000 +0000
@@ -623,7 +623,7 @@ static int rmqueue_bulk(struct zone *zon
 void drain_remote_pages(void)
 {
 	struct zone *zone;
-	int i;
+	int i, pindex;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -639,9 +639,16 @@ void drain_remote_pages(void)
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
@@ -652,7 +659,7 @@ void drain_remote_pages(void)
 static void __drain_pages(unsigned int cpu)
 {
 	struct zone *zone;
-	int i;
+	int i, pindex;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
@@ -662,8 +669,16 @@ static void __drain_pages(unsigned int c
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
@@ -743,6 +758,7 @@ static void fastcall free_hot_cold_page(
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
+	int pindex;
 
 	arch_free_page(page, 0);
 
@@ -752,11 +768,14 @@ static void fastcall free_hot_cold_page(
 		page->mapping = NULL;
 	free_pages_check(__FUNCTION__, page);
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
+
 	local_irq_save(flags);
-	list_add(&page->lru, &pcp->list);
-	pcp->count++;
-	if (pcp->count >= pcp->high)
-		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
+	pindex = get_pageblock_type(zone, page);
+	list_add(&page->lru, &pcp->list[pindex]);
+	pcp->count[pindex]++;
+	if (pcp->count[pindex] >= pcp->high)
+		pcp->count[pindex] -= free_pages_bulk(zone, pcp->batch,
+				&pcp->list[pindex], 0);
 	local_irq_restore(flags);
 	put_cpu();
 }
@@ -798,14 +817,16 @@ buffered_rmqueue(struct zone *zone, int 
 
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
@@ -847,9 +868,9 @@ int zone_watermark_ok(struct zone *z, in
 	int o,t;
 
 	if (alloc_flags & ALLOC_HIGH)
-		mark -= mark / 2;
+		mark /= 2;
 	if (alloc_flags & ALLOC_HARDER)
-		mark -= mark / 4;
+		mark /= 4;
 
 	if (free_pages <= mark + z->lowmem_reserve[classzone_idx])
 		goto out_failed;
@@ -861,13 +882,13 @@ int zone_watermark_ok(struct zone *z, in
 			 * unavailable
 			 */
 			free_pages -= z->free_area_lists[t][o].nr_free << o;
+		}
 
-			/* Require fewer higher order pages to be free */
-			min >>= 1;
+		/* Require fewer higher order pages to be free */
+		min >>= 1;
 
-			if (free_pages <= min)
-				goto out_failed;
-			}
+		if (free_pages <= min)
+			goto out_failed;
 	}
 
 	return 1;
@@ -1472,7 +1493,7 @@ void show_free_areas(void)
 					pageset->pcp[temperature].low,
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].count);
+					pcp_count(pageset->pcp[temperature]));
 		}
 	}
 
@@ -1930,18 +1951,23 @@ inline void setup_pageset(struct per_cpu
 	memset(p, 0, sizeof(*p));
 
 	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
+	pcp->count[RCLM_NORCLM] = 0;
+	pcp->count[RCLM_EASY] = 0;
 	pcp->low = 0;
-	pcp->high = 6 * batch;
+	pcp->high = 3 * batch;
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
-	pcp->high = 2 * batch;
+	pcp->high = batch;
 	pcp->batch = max(1UL, batch/2);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->list[RCLM_NORCLM]);
+	INIT_LIST_HEAD(&pcp->list[RCLM_EASY]);
 }
 
 #ifndef CONFIG_SPARSEMEM
@@ -2381,7 +2407,7 @@ static int zoneinfo_show(struct seq_file
 					   "\n              high:  %i"
 					   "\n              batch: %i",
 					   i, j,
-					   pageset->pcp[j].count,
+					   pcp_count(pageset->pcp[j]),
 					   pageset->pcp[j].low,
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
