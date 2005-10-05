Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbVJEOsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbVJEOsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVJEOqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:46:32 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:1167 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932639AbVJEOqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:46:19 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051005144617.11796.72973.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 6/7] Fragmentation Avoidance V16: 006_percpu
Date: Wed,  5 Oct 2005 15:46:17 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The freelists for each allocation type can slowly become corrupted due to
the per-cpu list. Consider what happens when the following happens

1. A 2^(MAX_ORDER-1) list is reserved for __GFP_USER pages
2. An order-0 page is allocated from the newly reserved block
3. The page is freed and placed on the per-cpu list
4. alloc_page() is called with GFP_KERNEL as the gfp_mask
5. The per-cpu list is used to satisfy the allocation

Now, a kernel page is in the middle of a __GFP_USER page. This means that over
long periods of the time, the anti-fragmentation scheme slowly degrades to the
standard allocator.

This patch divides the per-cpu lists into Kernel and User lists. RCLM_NORCLM
and RCLM_KERN use the Kernel list and RCLM_USER uses the user list. Strictly
speaking, there should be three lists but as little effort is made to reclaim
RCLM_KERN pages, it is not worth the overhead *yet*.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-005_fallback/include/linux/mmzone.h linux-2.6.14-rc3-006_percpu/include/linux/mmzone.h
--- linux-2.6.14-rc3-005_fallback/include/linux/mmzone.h	2005-10-05 12:16:05.000000000 +0100
+++ linux-2.6.14-rc3-006_percpu/include/linux/mmzone.h	2005-10-05 12:26:56.000000000 +0100
@@ -55,12 +55,17 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
+/* Indices into pcpu_list */
+#define PCPU_KERNEL 0
+#define PCPU_USER   1
+#define PCPU_TYPES  2
+
 struct per_cpu_pages {
-	int count;		/* number of pages in the list */
+	int count[PCPU_TYPES];  /* Number of pages on each list */
 	int low;		/* low watermark, refill needed */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
-	struct list_head list;	/* the list of pages */
+	struct list_head list[PCPU_TYPES]; /* the lists of pages */
 };
 
 struct per_cpu_pageset {
@@ -75,6 +80,10 @@ struct per_cpu_pageset {
 #endif
 } ____cacheline_aligned_in_smp;
 
+/* Helpers for per_cpu_pages */
+#define pset_count(pset) (pset.count[PCPU_KERNEL] + pset.count[PCPU_USER])
+#define for_each_pcputype(pindex) \
+	for (pindex=0; pindex < RCLM_TYPES; pindex++)
 #ifdef CONFIG_NUMA
 #define zone_pcp(__z, __cpu) ((__z)->pageset[(__cpu)])
 #else
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-005_fallback/mm/page_alloc.c linux-2.6.14-rc3-006_percpu/mm/page_alloc.c
--- linux-2.6.14-rc3-005_fallback/mm/page_alloc.c	2005-10-05 12:16:05.000000000 +0100
+++ linux-2.6.14-rc3-006_percpu/mm/page_alloc.c	2005-10-05 12:27:48.000000000 +0100
@@ -780,7 +780,7 @@ static int rmqueue_bulk(struct zone *zon
 void drain_remote_pages(void)
 {
 	struct zone *zone;
-	int i;
+	int i, pindex;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -796,9 +796,16 @@ void drain_remote_pages(void)
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			if (pcp->count)
-				pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
+			for_each_pcputype(pindex) {
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
@@ -809,7 +816,7 @@ void drain_remote_pages(void)
 static void __drain_pages(unsigned int cpu)
 {
 	struct zone *zone;
-	int i;
+	int i, pindex;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
@@ -819,8 +826,16 @@ static void __drain_pages(unsigned int c
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
+			for_each_pcputype(pindex) {
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
@@ -902,6 +917,7 @@ static void fastcall free_hot_cold_page(
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
+	int pindex;
 
 	arch_free_page(page, 0);
 
@@ -911,11 +927,21 @@ static void fastcall free_hot_cold_page(
 		page->mapping = NULL;
 	free_pages_check(__FUNCTION__, page);
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
+
+	/*
+	 * Strictly speaking, we should not be accessing the zone information
+	 * here. In this case, it does not matter if the read is incorrect
+	 */
+	if (get_pageblock_type(zone, page) == RCLM_USER)
+		pindex = PCPU_USER;
+	else
+		pindex = PCPU_KERNEL;
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
@@ -954,18 +980,25 @@ buffered_rmqueue(struct zone *zone, int 
 	
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
-
+		int pindex = PCPU_KERNEL;
+		if (alloctype == RCLM_USER)
+			pindex = PCPU_USER;
+		
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
-		if (pcp->count <= pcp->low)
-			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list,
-						alloctype);
-		if (pcp->count) {
-			page = list_entry(pcp->list.next, struct page, lru);
+		if (pcp->count[pindex] <= pcp->low)
+			pcp->count[pindex] += rmqueue_bulk(zone,
+					0, pcp->batch,
+					&(pcp->list[pindex]),
+					alloctype);
+
+		if (pcp->count[pindex]) {
+			page = list_entry(pcp->list[pindex].next,
+					struct page, lru);
 			list_del(&page->lru);
-			pcp->count--;
+			pcp->count[pindex]--;
 		}
+
 		local_irq_restore(flags);
 		put_cpu();
 	}
@@ -1601,7 +1634,7 @@ void show_free_areas(void)
 					pageset->pcp[temperature].low,
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].count);
+					pset_count(pageset->pcp[temperature]));
 		}
 	}
 
@@ -2039,18 +2072,22 @@ inline void setup_pageset(struct per_cpu
 	struct per_cpu_pages *pcp;
 
 	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
+	pcp->count[PCPU_KERNEL] = 0;
+	pcp->count[PCPU_USER] = 0;
 	pcp->low = 2 * batch;
-	pcp->high = 6 * batch;
+	pcp->high = 3 * batch;
 	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->list[PCPU_KERNEL]);
+	INIT_LIST_HEAD(&pcp->list[PCPU_USER]);
 
 	pcp = &p->pcp[1];		/* cold*/
-	pcp->count = 0;
+	pcp->count[PCPU_KERNEL] = 0;
+	pcp->count[PCPU_USER] = 0;
 	pcp->low = 0;
-	pcp->high = 2 * batch;
+	pcp->high = batch;
 	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->list[PCPU_KERNEL]);
+	INIT_LIST_HEAD(&pcp->list[PCPU_USER]);
 }
 
 #ifdef CONFIG_NUMA
@@ -2460,7 +2497,7 @@ static int zoneinfo_show(struct seq_file
 
 			pageset = zone_pcp(zone, i);
 			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				if (pageset->pcp[j].count)
+				if (pset_count(pageset->pcp[j]))
 					break;
 			}
 			if (j == ARRAY_SIZE(pageset->pcp))
@@ -2473,7 +2510,7 @@ static int zoneinfo_show(struct seq_file
 					   "\n              high:  %i"
 					   "\n              batch: %i",
 					   i, j,
-					   pageset->pcp[j].count,
+					   pset_count(pageset->pcp[j]),
 					   pageset->pcp[j].low,
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
