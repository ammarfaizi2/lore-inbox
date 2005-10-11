Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVJKPO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVJKPO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVJKPNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:13:08 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:718 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751393AbVJKPMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:12:48 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051011151246.16178.40148.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 5/8] Fragmentation Avoidance V17: 005_fallback
Date: Tue, 11 Oct 2005 16:12:47 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements fallback logic. In the event there is no 2^(MAX_ORDER-1)
blocks of pages left, this will help the system decide what list to use. The
highlights of the patch are;

o Define a RCLM_FALLBACK type for fallbacks
o Use a percentage of each zone for fallbacks. When a reserved pool of pages
  is depleted, it will try and use RCLM_FALLBACK before using anything else.
  This greatly reduces the amount of fallbacks causing fragmentation without
  needing complex balancing algorithms
o Add a fallback_reserve and fallback_balance so that the system knows how
  may 2^(MAX_ORDER-1) blocks are being used for fallbacks and if more need
  to be reserved.
o Adds a fallback_allocs[] array that determines the order of freelists are
  used for each allocation type

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-004_markfree/include/linux/mmzone.h linux-2.6.14-rc3-005_fallback/include/linux/mmzone.h
--- linux-2.6.14-rc3-004_markfree/include/linux/mmzone.h	2005-10-11 12:08:07.000000000 +0100
+++ linux-2.6.14-rc3-005_fallback/include/linux/mmzone.h	2005-10-11 12:09:27.000000000 +0100
@@ -29,7 +29,8 @@
 #define RCLM_NORCLM   0
 #define RCLM_USER     1
 #define RCLM_KERN     2
-#define RCLM_TYPES    3
+#define RCLM_FALLBACK 3
+#define RCLM_TYPES    4
 #define BITS_PER_RCLM_TYPE 2
 
 #define for_each_rclmtype_order(type, order) \
@@ -163,6 +164,13 @@ struct zone {
 
 	struct free_area	free_area_lists[RCLM_TYPES][MAX_ORDER];
 
+	/*
+	 * Track what percentage of the zone should be used for fallbacks and
+	 * how much is being currently used
+	 */
+	unsigned long		fallback_reserve;
+	long			fallback_balance;
+
 	ZONE_PADDING(_pad1_)
 
 	/* Fields commonly accessed by the page reclaim scanner */
@@ -275,6 +283,17 @@ struct zonelist {
 	struct zone *zones[MAX_NUMNODES * MAX_NR_ZONES + 1]; // NULL delimited
 };
 
+static inline void inc_reserve_count(struct zone* zone, int type)
+{
+	if (type == RCLM_FALLBACK)
+		zone->fallback_reserve++;
+}
+
+static inline void dec_reserve_count(struct zone* zone, int type)
+{
+	if (type == RCLM_FALLBACK && zone->fallback_reserve)
+		zone->fallback_reserve--;
+}
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-004_markfree/mm/page_alloc.c linux-2.6.14-rc3-005_fallback/mm/page_alloc.c
--- linux-2.6.14-rc3-004_markfree/mm/page_alloc.c	2005-10-11 12:08:47.000000000 +0100
+++ linux-2.6.14-rc3-005_fallback/mm/page_alloc.c	2005-10-11 12:09:27.000000000 +0100
@@ -53,6 +53,40 @@ unsigned long totalhigh_pages __read_mos
 long nr_swap_pages;
 
 /*
+ * fallback_allocs contains the fallback types for low memory conditions
+ * where the preferred alloction type if not available.
+ */
+int fallback_allocs[RCLM_TYPES][RCLM_TYPES+1] = {
+	{RCLM_NORCLM,	RCLM_FALLBACK, RCLM_KERN,   RCLM_USER, RCLM_TYPES},
+	{RCLM_KERN,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_USER, RCLM_TYPES},
+	{RCLM_USER,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_KERN, RCLM_TYPES},
+	{RCLM_FALLBACK, RCLM_NORCLM,   RCLM_KERN,   RCLM_USER, RCLM_TYPES}
+};
+
+/*
+ * Returns 1 if the required presentage of the zone if reserved for fallbacks
+ *
+ * fallback_balance and fallback_reserve are used to detect when the required
+ * percentage is reserved. fallback_balance is decremented when a
+ * 2^(MAX_ORDER-1) block is split and incremented when coalesced.
+ * fallback_reserve is incremented when a block is reserved for fallbacks
+ * and decremented when reassigned elsewhere.
+ *
+ */
+static inline int min_fallback_reserved(struct zone *zone) {
+	/* If fallback_balance is positive, we do not need to reserve */
+	if (zone->fallback_balance > 0)
+		return 1;
+
+	/*
+	 * When fallback_balance is negative, a reserve is required. The number
+	 * of reserved blocks required is related to the negative value of
+	 * fallback_balance
+	 */
+	return -(zone->fallback_balance) < zone->fallback_reserve;
+}
+
+/*
  * results with 256, 32 in the lowmem_reserve sysctl:
  *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
  *	1G machine -> (16M dma, 784M normal, 224M high)
@@ -404,6 +438,8 @@ static inline void __free_pages_bulk (st
 		page_idx = combined_idx;
 		order++;
 	}
+	if (unlikely(order == MAX_ORDER-1))
+		zone->fallback_balance++;
 	set_page_order(page, order);
 	list_add_tail(&page->lru, &freelist[order].free_list);
 	freelist[order].nr_free++;
@@ -585,7 +621,12 @@ struct page* steal_largepage(struct zone
 	page = list_entry(area->free_list.next, struct page, lru);
 	area->nr_free--;
 
+	if (!min_fallback_reserved(zone))
+		alloctype = RCLM_FALLBACK;
+
 	set_pageblock_type(zone, page, (unsigned long)alloctype);
+	dec_reserve_count(zone, i);
+	inc_reserve_count(zone, alloctype);
 
 	return page;
 }
@@ -595,6 +636,8 @@ static inline struct page *
 remove_page(struct zone *zone, struct page *page, unsigned int order,
 		unsigned int current_order, struct free_area *area)
 {
+	if (unlikely(current_order == MAX_ORDER-1))
+		zone->fallback_balance--;
 	list_del(&page->lru);
 	rmv_page_order(page);
 	zone->free_pages -= 1UL << order;
@@ -602,6 +645,83 @@ remove_page(struct zone *zone, struct pa
 
 }
 
+/*
+ * If we are falling back, and the allocation is KERNNORCLM,
+ * then reserve any buddies for the KERNNORCLM pool. These
+ * allocations fragment the worst so this helps keep them
+ * in the one place
+ */
+static inline struct free_area *
+fallback_buddy_reserve(int start_alloctype, struct zone *zone,
+			unsigned int current_order, struct page *page,
+			struct free_area *area)
+{
+	if (start_alloctype != RCLM_NORCLM)
+		return area;
+
+	area = &(zone->free_area_lists[RCLM_NORCLM][current_order]);
+
+	/* Reserve the whole block if this is a large split */
+	if (current_order >= MAX_ORDER / 2) {
+		int reserve_type = RCLM_NORCLM;
+		dec_reserve_count(zone, get_pageblock_type(zone,page));
+
+		/*
+		 * Use this block for fallbacks if the
+		 * minimum reserve is not being met
+		 */
+		if (!min_fallback_reserved(zone))
+			reserve_type = RCLM_FALLBACK;
+
+		set_pageblock_type(zone, page, (unsigned long)reserve_type);
+		inc_reserve_count(zone, reserve_type);
+	}
+	return area;
+}
+
+static struct page *
+fallback_alloc(int alloctype, struct zone *zone, unsigned int order)
+{
+	int *fallback_list;
+	int start_alloctype = alloctype;
+	struct free_area *area;
+	unsigned int current_order;
+	struct page *page;
+	int i;
+
+	/* Ok, pick the fallback order based on the type */
+	BUG_ON(alloctype >= RCLM_TYPES);
+	fallback_list = fallback_allocs[alloctype];
+
+	/*
+	 * Here, the alloc type lists has been depleted as well as the global
+	 * pool, so fallback. When falling back, the largest possible block
+	 * will be taken to keep the fallbacks clustered if possible
+	 */
+	for (i = 0; fallback_list[i] != RCLM_TYPES; i++) {
+		alloctype = fallback_list[i];
+
+		/* Find a block to allocate */
+		area = &(zone->free_area_lists[alloctype][MAX_ORDER-1]);
+		for (current_order = MAX_ORDER - 1; current_order > order;
+				current_order--, area--) {
+			if (list_empty(&area->free_list))
+				continue;
+
+			page = list_entry(area->free_list.next, 
+						struct page, lru);
+			area->nr_free--;
+			area = fallback_buddy_reserve(start_alloctype, zone,
+					current_order, page, area);
+			return remove_page(zone, page, order,
+					current_order, area);
+
+		}
+	}
+
+	return NULL;
+}
+
 /* 
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -628,7 +748,8 @@ static struct page *__rmqueue(struct zon
 	if (page != NULL)
 		return remove_page(zone, page, order, MAX_ORDER-1, area);
 
-	return NULL;
+	/* Try falling back */
+	return fallback_alloc(alloctype, zone, order);
 }
 
 /* 
@@ -2106,6 +2227,10 @@ static void __init free_area_init_core(s
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->fallback_reserve = 0;
+
+		/* Set the balance so about 12.5% will be used for fallbacks */
+		zone->fallback_balance = -(realsize >> (MAX_ORDER+2));
 
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 
