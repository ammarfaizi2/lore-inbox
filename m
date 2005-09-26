Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVIZUQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVIZUQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVIZUQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:16:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59812 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932501AbVIZUQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:16:16 -0400
Message-ID: <4338570E.6050101@austin.ibm.com>
Date: Mon, 26 Sep 2005 15:16:14 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Schopp <jschopp@austin.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 8/9] defrag fallback
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070601010804010804050400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601010804010804050400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

When we can't allocate from the preferred allocation type we need fallback to
other allocation types.  This patch determines which allocation types we try
to fallback to in which order.  It also adds a special fallback type that is
designed to minimize the fragmentation caused by fallback between the other
types.

There is an implicit tradeoff being made here between avoiding fragmentation
and satisfying allocations.  This patch aims to keep existing behavior of
satisfying allocations if there is any free memory of any type to satisfy them.
It does a reasonable job of trying to minimize the fragmentation, and certainly
does better than a stock kernel in all situations.

However, it would not be hard to imagine scenarios where a different fallback
algorithm that fails more allocations was able to keep fragmentation down much
better, and on some systems this decreased fragmentation might even be worth
the cost of failing allocations.  Systems doing memory hotplug remove for
example.  This patch is designed so that the static function
fallback_alloc() can be easily replaced with an alternate implementation (under
a config option perhaps) in the future.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

--------------070601010804010804050400
Content-Type: text/plain;
 name="8_defrag_fallback"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8_defrag_fallback"

Index: 2.6.13-joel2/mm/page_alloc.c
===================================================================
--- 2.6.13-joel2.orig/mm/page_alloc.c	2005-09-21 11:14:49.%N -0500
+++ 2.6.13-joel2/mm/page_alloc.c	2005-09-21 11:17:23.%N -0500
@@ -39,6 +39,17 @@
 #include "internal.h"
 
 /*
+ * fallback_allocs contains the fallback types for low memory conditions
+ * where the preferred alloction type if not available.
+ */
+int fallback_allocs[RCLM_TYPES][RCLM_TYPES+1] = {
+	{RCLM_NORCLM,RCLM_FALLBACK,  RCLM_KERN,  RCLM_USER,-1},
+	{RCLM_KERN,  RCLM_FALLBACK,  RCLM_NORCLM,RCLM_USER,-1},
+	{RCLM_USER,  RCLM_FALLBACK,  RCLM_NORCLM,RCLM_KERN,-1},
+	{RCLM_FALLBACK,  RCLM_NORCLM,RCLM_KERN,  RCLM_USER,-1}
+};
+
+/*
  * MCD - HACK: Find somewhere to initialize this EARLY, or make this
  * initializer cleaner
  */
@@ -576,13 +587,86 @@ static inline struct page
 }
 
 
+/*
+ * If we are falling back, and the allocation is KERNNORCLM,
+ * then reserve any buddies for the KERNNORCLM pool. These
+ * allocations fragment the worst so this helps keep them
+ * in the one place
+ */
+static inline void
+fallback_buddy_reserve(int start_alloctype, struct zone *zone,
+		       unsigned int current_order, struct page *page)
+{
+	int reserve_type = RCLM_NORCLM;
+	struct free_area *area;
+
+	if (start_alloctype == RCLM_NORCLM) {
+		area = zone->free_area_lists[RCLM_NORCLM] + current_order;
+
+		/* Reserve the whole block if this is a large split */
+		if (current_order >= MAX_ORDER / 2) {
+			dec_reserve_count(zone, get_pageblock_type(zone,page));
+
+			/*
+			 * Use this block for fallbacks if the
+			 * minimum reserve is not being met
+			 */
+			if (!is_min_fallback_reserved(zone))
+				reserve_type = RCLM_FALLBACK;
+
+			set_pageblock_type(zone, page, reserve_type);
+			inc_reserve_count(zone, reserve_type);
+		}
+
+	}
+
+}
+
 static struct page *
 fallback_alloc(int alloctype, struct zone *zone, unsigned int order)
 {
-	/* Stub out for seperate review, NULL equates to no fallback*/
+	int *fallback_list;
+	int start_alloctype;
+	unsigned int current_order;
+	struct free_area *area;
+	struct page* page;
+
+	/* Ok, pick the fallback order based on the type */
+	fallback_list = fallback_allocs[alloctype];
+	start_alloctype = alloctype;
+
+
+	/*
+	 * Here, the alloc type lists has been depleted as well as the global
+	 * pool, so fallback. When falling back, the largest possible block
+	 * will be taken to keep the fallbacks clustered if possible
+	 */
+	while ((alloctype = *(++fallback_list)) != -1) {
+
+		/* Find a block to allocate */
+		area = zone->free_area_lists[alloctype] + MAX_ORDER;
+		current_order=MAX_ORDER;
+		do {
+			current_order--;
+			area--;
+			if (!list_empty(&area->free_list)) {
+				page = list_entry(area->free_list.next,
+						  struct page, lru);
+				area->nr_free--;
+				fallback_buddy_reserve(start_alloctype, zone,
+						       current_order, page);
+				return remove_page(zone, page, order,
+						   current_order, area);
+			}
+
+		} while (current_order != order);
+
+	}
+
 	return NULL;
 
 }
+
 /* 
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -2101,6 +2185,11 @@ static void __init free_area_init_core(s
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->fallback_reserve = 0;
+
+		/* Set the balance so about 12.5% will be used for fallbacks */
+		zone->fallback_balance = (realsize >> (MAX_ORDER-1)) -
+					 (realsize >> (MAX_ORDER+2));
 
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 

--------------070601010804010804050400--
