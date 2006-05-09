Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWEILJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWEILJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWEILJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:09:40 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:15543
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751759AbWEILJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:09:39 -0400
Date: Tue, 9 May 2006 12:05:51 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>,
       Bob Picco <bob.picco@hp.com>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 3/3] zone allow unaligned zone boundries
Message-ID: <20060509110551.GA9839@shadowen.org>
References: <exportbomb.1147172704@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1147172704@pinky>
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zone allow unaligned zone boundries

Currently the buddy allocator requires that zone boundries be
at MAX_ORDER boundries.  This may not always be desirable or
possible.  Add a config option to allow these boundies
to be arbitrary.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/linux/mm.h     |    7 +++++--
 include/linux/mmzone.h |    4 ++++
 mm/page_alloc.c        |   21 ++++++++++++++-------
 3 files changed, 23 insertions(+), 9 deletions(-)
diff -upN reference/include/linux/mm.h current/include/linux/mm.h
--- reference/include/linux/mm.h
+++ current/include/linux/mm.h
@@ -466,10 +466,13 @@ static inline unsigned long page_zonenum
 struct zone;
 extern struct zone *zone_table[];
 
+static inline int page_zone_id(struct page *page)
+{
+	return (page->flags >> ZONETABLE_PGSHIFT) & ZONETABLE_MASK;
+}
 static inline struct zone *page_zone(struct page *page)
 {
-	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
-			ZONETABLE_MASK];
+	return zone_table[page_zone_id(page)];
 }
 
 static inline unsigned long page_to_nid(struct page *page)
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -390,7 +390,11 @@ static inline int is_dma(struct zone *zo
 
 static inline unsigned long zone_boundry_align_pfn(unsigned long pfn)
 {
+#ifdef CONFIG_UNALIGNED_ZONE_BOUNDRIES
+	return pfn;
+#else
 	return pfn & ~((1 << MAX_ORDER) - 1);
+#endif
 }
 
 /* These two functions are used to setup the per zone pages min values */
diff -upN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c
+++ current/mm/page_alloc.c
@@ -285,22 +285,28 @@ __find_combined_index(unsigned long page
  * we can do coalesce a page and its buddy if
  * (a) the buddy is not in a hole &&
  * (b) the buddy is in the buddy system &&
- * (c) a page and its buddy have the same order.
+ * (c) a page and its buddy have the same order &&
+ * (d) a page and its buddy are in the same zone.
  *
  * For recording whether a page is in the buddy system, we use PG_buddy.
  * Setting, clearing, and testing PG_buddy is serialized by zone->lock.
  *
  * For recording page's order, we use page_private(page).
  */
-static inline int page_is_buddy(struct page *page, int order)
+static inline int page_is_buddy(struct page *page, struct page *buddy,
+								int order)
 {
 #ifdef CONFIG_HOLES_IN_ZONE
-	if (!pfn_valid(page_to_pfn(page)))
+	if (!pfn_valid(page_to_pfn(buddy)))
+		return 0;
+#endif
+#ifdef CONFIG_UNALIGNED_ZONE_BOUNDRIES
+	if (page_zone_id(page) != page_zone_id(buddy))
 		return 0;
 #endif
 
-	if (PageBuddy(page) && page_order(page) == order) {
-		BUG_ON(page_count(page) != 0);
+	if (PageBuddy(buddy) && page_order(buddy) == order) {
+		BUG_ON(page_count(buddy) != 0);
 		return 1;
 	}
 	return 0;
@@ -351,7 +357,7 @@ static inline void __free_one_page(struc
 		struct page *buddy;
 
 		buddy = __page_find_buddy(page, page_idx, order);
-		if (!page_is_buddy(buddy, order))
+		if (!page_is_buddy(page, buddy, order))
 			break;		/* Move the buddy up one level. */
 
 		list_del(&buddy->lru);
@@ -2080,7 +2086,8 @@ static void __init free_area_init_core(s
 
 		if (zone_boundry_align_pfn(zone_start_pfn) != zone_start_pfn)
 			printk(KERN_CRIT "node %d zone %s missaligned "
-					"start pfn\n", nid, zone_names[j]);
+				"start pfn, enable UNALIGNED_ZONE_BOUNDRIES\n",
+							nid, zone_names[j]);
 
 		realsize = size = zones_size[j];
 		if (zholes_size)
