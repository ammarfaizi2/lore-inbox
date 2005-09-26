Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVIZULy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVIZULy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVIZULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:11:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46007 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932496AbVIZULx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:11:53 -0400
Message-ID: <43385605.7050406@austin.ibm.com>
Date: Mon, 26 Sep 2005 15:11:49 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Joel Schopp <jschopp@austin.ibm.com>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 5/9] propagate defrag alloc types
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020107000809090901030105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020107000809090901030105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Now that we have this new information of alloctype, this patch propagates it to
functions where it will be useful.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

--------------020107000809090901030105
Content-Type: text/plain;
 name="5_propogate_defrag_types"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="5_propogate_defrag_types"

Index: 2.6.13-joel2/mm/page_alloc.c
===================================================================
--- 2.6.13-joel2.orig/mm/page_alloc.c	2005-09-20 14:16:35.%N -0500
+++ 2.6.13-joel2/mm/page_alloc.c	2005-09-20 15:08:05.%N -0500
@@ -559,7 +559,8 @@ static inline struct page* steal_largepa
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order,
+			      int alloctype)
 {
 	struct free_area * area;
 	unsigned int current_order;
@@ -587,7 +588,8 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int alloctype)
 {
 	unsigned long flags;
 	int i;
@@ -596,7 +598,7 @@ static int rmqueue_bulk(struct zone *zon
 	
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -775,7 +777,8 @@ static inline void prep_zero_page(struct
  * or two.
  */
 static struct page *
-buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags)
+buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags,
+		 int alloctype)
 {
 	unsigned long flags;
 	struct page *page = NULL;
@@ -787,8 +790,8 @@ buffered_rmqueue(struct zone *zone, int 
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
-			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+			pcp->count += rmqueue_bulk(zone, 0, pcp->batch,
+						   &pcp->list, alloctype);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -800,7 +803,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -876,7 +879,9 @@ __alloc_pages(unsigned int __nocast gfp_
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
-
+	int alloctype;
+
+	alloctype = (gfp_mask & __GFP_RCLM_BITS);
 	might_sleep_if(wait);
 
 	/*
@@ -921,7 +926,7 @@ zone_reclaim_retry:
 			}
 		}
 
-		page = buffered_rmqueue(z, order, gfp_mask);
+		page = buffered_rmqueue(z, order, gfp_mask, alloctype);
 		if (page)
 			goto got_pg;
 	}
@@ -945,7 +950,7 @@ zone_reclaim_retry:
 		if (wait && !cpuset_zone_allowed(z))
 			continue;
 
-		page = buffered_rmqueue(z, order, gfp_mask);
+		page = buffered_rmqueue(z, order, gfp_mask, alloctype);
 		if (page)
 			goto got_pg;
 	}
@@ -959,7 +964,8 @@ zone_reclaim_retry:
 			for (i = 0; (z = zones[i]) != NULL; i++) {
 				if (!cpuset_zone_allowed(z))
 					continue;
-				page = buffered_rmqueue(z, order, gfp_mask);
+				page = buffered_rmqueue(z, order, gfp_mask,
+							alloctype);
 				if (page)
 					goto got_pg;
 			}
@@ -996,7 +1002,7 @@ rebalance:
 			if (!cpuset_zone_allowed(z))
 				continue;
 
-			page = buffered_rmqueue(z, order, gfp_mask);
+			page = buffered_rmqueue(z, order, gfp_mask, alloctype);
 			if (page)
 				goto got_pg;
 		}
@@ -1015,7 +1021,7 @@ rebalance:
 			if (!cpuset_zone_allowed(z))
 				continue;
 
-			page = buffered_rmqueue(z, order, gfp_mask);
+			page = buffered_rmqueue(z, order, gfp_mask, alloctype);
 			if (page)
 				goto got_pg;
 		}

--------------020107000809090901030105--
