Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031264AbWKUWvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031264AbWKUWvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031266AbWKUWvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:51:25 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:1703 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1031264AbWKUWvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:51:24 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225122.11710.32059.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 3/11] Choose pages from the per-cpu list based on migration type
Date: Tue, 21 Nov 2006 22:51:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The freelists for each migrate type can slowly become polluted due to the
per-cpu list. Consider what happens when the following happens

1. A 2^(MAX_ORDER-1) list is reserved for __GFP_MOVABLE pages
2. An order-0 page is allocated from the newly reserved block
3. The page is freed and placed on the per-cpu list
4. alloc_page() is called with GFP_KERNEL as the gfp_mask
5. The per-cpu list is used to satisfy the allocation

This results in a kernel page is in the middle of a migratable region. This
patch prevents this leak occuring by storing the MIGRATE_ type of the page in
page->private. On allocate, a page will only be returned of the desired type,
else more pages will be allocated. This may temporarily allow a per-cpu list
to go over the pcp->high limit but it'll be corrected on the next free. Care
is taken to preserve the hotness of pages recently freed.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 page_alloc.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-003_clustering_core/mm/page_alloc.c linux-2.6.19-rc5-mm2-004_percpu/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-003_clustering_core/mm/page_alloc.c	2006-11-21 10:48:55.000000000 +0000
+++ linux-2.6.19-rc5-mm2-004_percpu/mm/page_alloc.c	2006-11-21 10:50:40.000000000 +0000
@@ -415,6 +415,7 @@ static inline void __free_one_page(struc
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	int migratetype = get_page_migratetype(page);
 
 	if (unlikely(PageCompound(page)))
 		destroy_compound_page(page, order);
@@ -449,8 +450,7 @@ static inline void __free_one_page(struc
 		order++;
 	}
 	set_page_order(page, order);
-	list_add(&page->lru,
-		&zone->free_area[order].free_list[get_page_migratetype(page)]);
+	list_add(&page->lru, &zone->free_area[order].free_list[migratetype]);
 	zone->free_area[order].nr_free++;
 }
 
@@ -738,7 +738,8 @@ static int rmqueue_bulk(struct zone *zon
 		struct page *page = __rmqueue(zone, order, migratetype);
 		if (unlikely(page == NULL))
 			break;
-		list_add_tail(&page->lru, list);
+		list_add(&page->lru, list);
+		set_page_private(page, migratetype);
 	}
 	spin_unlock(&zone->lock);
 	return i;
@@ -876,6 +877,7 @@ static void fastcall free_hot_cold_page(
 	local_irq_save(flags);
 	__count_vm_event(PGFREE);
 	list_add(&page->lru, &pcp->list);
+	set_page_private(page, get_page_migratetype(page));
 	pcp->count++;
 	if (pcp->count >= pcp->high) {
 		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
@@ -940,9 +942,29 @@ again:
 			if (unlikely(!pcp->count))
 				goto failed;
 		}
-		page = list_entry(pcp->list.next, struct page, lru);
-		list_del(&page->lru);
-		pcp->count--;
+
+		/* Find a page of the appropriate migrate type */
+		list_for_each_entry(page, &pcp->list, lru) {
+			if (page_private(page) == migratetype) {
+				list_del(&page->lru);
+				pcp->count--;
+				break;
+			}
+		}
+
+		/*
+		 * Check if a page of the appropriate migrate type
+		 * was found. If not, allocate more to the pcp list
+		 */
+		if (&page->lru == &pcp->list) {
+			pcp->count += rmqueue_bulk(zone, 0,
+					pcp->batch, &pcp->list, migratetype);
+			page = list_entry(pcp->list.next, struct page, lru);
+			VM_BUG_ON(page_private(page) != migratetype);
+			list_del(&page->lru);
+			pcp->count--;
+		}
+
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 		page = __rmqueue(zone, order, migratetype);
