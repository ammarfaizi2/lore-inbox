Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVBLAlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVBLAlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVBLAlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:41:50 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:23264 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262366AbVBLAkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:40:55 -0500
Subject: [PATCH] stop using "base" argument in __free_pages_bulk()
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
Content-Type: multipart/mixed; boundary="=-RwHgvixG7ukPUn1chnax"
Date: Fri, 11 Feb 2005 16:40:39 -0800
Message-Id: <1108168839.6154.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RwHgvixG7ukPUn1chnax
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is somewhat of a companion to the "no buddy bitmap" patches.
It messes with core allocator functions, so it probably deserves a long
turn in -mm.

Appended is a patch which stops using the zone->zone_mem_map to
calculate the buddy and combined page pointers.  It uses the fact
that the mem_map array is guaranteed to be contigious for the
surrounding (1 << MAX_ORDER) pages.  The relative positions of
the pages in the physical address space to provide the alignment;
which conicidentally fixes the issue where zones are not aligned
at MAX_ORDER.  There is a very comprehensive comment in the new
code explaining the mathematical relationship between a page and
its buddy so I won't reproduce it here.

This kind of approach is required for CONFIG_NONLINEAR systems
where the mem_map is not contiguous within a zone, and the
zone->zone_mem_map is not used at all.

This patch has been boot-tested on a large variety of systems and
architectures: my P4 laptop, 16-way NUMAQ, 16-way Summit, 4-way
x86 SMP, ppc64 LPAR, x86_64, and several ia64 configurations.

It has been performance-tested on a 16-way NUMAQ. SDET shows a
very slight (within margin of error) performance gain.  Kernbench
shows an approximately ~1% decrease in system time with this
patch applied.  So, it has a likely small positive performance impact.

However, the patch has the potential to have a negative performance
impact on systems with an expensive page_to_pfn() implementation.
But, I think the NUMAQ has one of the more expensive ones around,
and it doesn't seem mind too much.

Applies against 2.6.11-rc3.  

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

-- Dave

--=-RwHgvixG7ukPUn1chnax
Content-Disposition: attachment; filename=free_pages_bulk-no-base-argument.patch
Content-Type: text/x-patch; name=free_pages_bulk-no-base-argument.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit


Appended is a patch which stops using the zone->zone_mem_map to
calculate the buddy and combined page pointers.  It uses the fact
that the mem_map array is guaranteed to be contigious for the
surrounding (1 << MAX_ORDER) pages.  The relative positions of
the pages in the physical address space to provide the
alignement; which conicidentally fixes the issue where zones are
not aligned at MAX_ORDER.  There is a very comprehensive comment
in the new code explaining the mathematical relationship between
a page and its buddy so I won't reproduce it here.

This kind of approach is required for CONFIG_NONLINEAR systems
where the mem_map is not contiguous within a zone, and the 
zone->zone_mem_map is not used at all.

This patch has been boot-tested on a large variety of systems and
architectures: my P4 laptop, 16-way NUMAQ, 16-way Summit, 4-way
x86 SMP, ppc64 LPAR, x86_64, and several ia64 configurations.

It has been performance-tested on a 16-way NUMAQ. SDET shows a
very slight (within margin of error) performance gain.  Kernbench
shows an approximately ~1% decrease in system time with this
patch applied.  So, it has a likely positive performance impact.

However, the patch has the potential to have a negative performance
impact on systems with an expensive page_to_pfn() implementation.
But, I think the NUMAQ has one of the more expensive ones around,
and it doesn't seem mind too much.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 clean-dave/mm/page_alloc.c |   57 +++++++++++++++++++++++++++++++++------------
 1 files changed, 42 insertions(+), 15 deletions(-)

diff -puN mm/page_alloc.c~B-sparse-120-free-pages-no-base mm/page_alloc.c
--- clean/mm/page_alloc.c~B-sparse-120-free-pages-no-base	2005-02-11 16:30:30.000000000 -0800
+++ clean-dave/mm/page_alloc.c	2005-02-11 16:30:36.000000000 -0800
@@ -191,6 +191,35 @@ static inline void rmv_page_order(struct
 }
 
 /*
+ * Locate the struct page for both the matching buddy in our
+ * pair (buddy1) and the combined O(n+1) page they form (page).
+ *
+ * 1) Any buddy B1 will have an order O twin B2 which satisfies
+ * the following equasion:
+ *     B2 = B1 ^ (1 << O)
+ * For example, if the starting buddy (buddy2) is #8 its order
+ * 1 buddy is #10:
+ *     B2 = 8 ^ (1 << 1) = 8 ^ 2 = 10
+ *
+ * 2) Any buddy B will have an order O+1 parent P which
+ * satisfies the following equasion:
+ *     P = B & ~(1 << O)
+ *
+ * Assumption: *_mem_map is contigious at least up to MAX_ORDER
+ */
+static inline struct page *__page_find_buddy(struct page *page, unsigned long page_idx, unsigned int order)
+{
+	unsigned long buddy_idx = page_idx ^ (1 << order);
+
+	return page + (buddy_idx - page_idx);;
+}
+
+static inline unsigned long __find_combined_index(unsigned long page_idx, unsigned int order)
+{
+	return (page_idx & ~(1 << order));
+}
+
+/*
  * This function checks whether a page is free && is the buddy
  * we can do coalesce a page and its buddy if
  * (a) the buddy is free &&
@@ -233,44 +262,43 @@ static inline int page_is_buddy(struct p
  * -- wli
  */
 
-static inline void __free_pages_bulk (struct page *page, struct page *base,
+static inline void __free_pages_bulk (struct page *page,
 		struct zone *zone, unsigned int order)
 {
 	unsigned long page_idx;
-	struct page *coalesced;
 	int order_size = 1 << order;
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
 
-	page_idx = page - base;
+	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
 
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
 
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
+		unsigned long combined_idx;
 		struct free_area *area;
 		struct page *buddy;
-		int buddy_idx;
 
-		buddy_idx = (page_idx ^ (1 << order));
-		buddy = base + buddy_idx;
+		combined_idx = __find_combined_index(page_idx, order);
+		buddy = __page_find_buddy(page, page_idx, order);
+
 		if (bad_range(zone, buddy))
 			break;
 		if (!page_is_buddy(buddy, order))
-			break;
-		/* Move the buddy up one level. */
+			break;		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
 		area = zone->free_area + order;
 		area->nr_free--;
 		rmv_page_order(buddy);
-		page_idx &= buddy_idx;
+		page = page + (combined_idx - page_idx);
+		page_idx = combined_idx;
 		order++;
 	}
-	coalesced = base + page_idx;
-	set_page_order(coalesced, order);
-	list_add(&coalesced->lru, &zone->free_area[order].free_list);
+	set_page_order(page, order);
+	list_add(&page->lru, &zone->free_area[order].free_list);
 	zone->free_area[order].nr_free++;
 }
 
@@ -309,10 +337,9 @@ free_pages_bulk(struct zone *zone, int c
 		struct list_head *list, unsigned int order)
 {
 	unsigned long flags;
-	struct page *base, *page = NULL;
+	struct page *page = NULL;
 	int ret = 0;
 
-	base = zone->zone_mem_map;
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->all_unreclaimable = 0;
 	zone->pages_scanned = 0;
@@ -320,7 +347,7 @@ free_pages_bulk(struct zone *zone, int c
 		page = list_entry(list->prev, struct page, lru);
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
-		__free_pages_bulk(page, base, zone, order);
+		__free_pages_bulk(page, zone, order);
 		ret++;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
_

--=-RwHgvixG7ukPUn1chnax--

