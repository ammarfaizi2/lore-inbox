Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUHZMJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUHZMJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUHZMH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:07:28 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:491 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268849AbUHZLw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:52:59 -0400
Date: Thu, 26 Aug 2004 20:58:06 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap [1/4]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-id: <412DD04E.1040003@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2nd part of patches, for zone initialization.

New member, zone->aligned_order and zone->nr_mem_map is added to zone.

aligned_order indicates memmap is aligned below this order.
nr_mem_map    indicates memmap is diveded into nr_mem_map.

How these works ? prease see patch 4th ;), there are used to
coalesce pages.

-- Kame

==================
This patch removes bitmap allocation in zone_init_free_lists() and
page_to_bitmap_size();

And new added member zone->aligned_order is initialized.

zone->alined_order guarantees "zone is aligned to (1 << zone->aligned_order)
contiguous pages"

If zone->alined_order == MAX_ORDER, zone is completely aligned, and
every page is guaranteed to have its buddy page in any order.

zone->aligned_order is used in free_pages_bulk() to skip range checking.
By using this, if order < zone->aligned_order,
we do not have to worry about "a page can have its buddy in an order or not?"

This would work well in several architectures.

But my ia64 box shows zone->aligned_order=0 .....this aligned_order would not
be helpful in some environment.

-- Kame


---

 linux-2.6.8.1-mm4-kame-kamezawa/mm/page_alloc.c |   78 +++++++++++-------------
 1 files changed, 38 insertions(+), 40 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-init mm/page_alloc.c
--- linux-2.6.8.1-mm4-kame/mm/page_alloc.c~eliminate-bitmap-init	2004-08-26 08:42:33.572192352 +0900
+++ linux-2.6.8.1-mm4-kame-kamezawa/mm/page_alloc.c	2004-08-26 08:42:33.577191592 +0900
@@ -1499,6 +1499,30 @@ static void __init calculate_zone_totalp
 	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
 }

+/*
+ * calculate_aligned_order()
+ * this function calculates an upper bound order of alignment
+ * of buddy pages. if order < zone->aligned_order, every page
+ * are guaranteed to have its buddy.
+ */
+void __init calculate_aligned_order(struct zone *zone,
+				    unsigned long start_pfn,
+				    unsigned long nr_pages)
+{
+	int order, page_idx;
+	unsigned long mask;
+	
+	page_idx = start_pfn - zone->zone_start_pfn;
+	
+	for (order = 0 ; order < MAX_ORDER; order++) {
+		mask = 1UL << order;
+		if ((page_idx & mask) || (nr_pages & mask))
+			break;
+	}
+	if (order < zone->aligned_order)
+		zone->aligned_order = order;
+	printk("Aligned order of %s is %d \n",zone->name, zone->aligned_order);
+}

 /*
  * Initially all pages are reserved - free ones are freed
@@ -1510,7 +1534,9 @@ void __init memmap_init_zone(unsigned lo
 {
 	struct page *start = pfn_to_page(start_pfn);
 	struct page *page;
-
+	unsigned long saved_start_pfn = start_pfn;
+	struct zone *zonep = zone_table[NODEZONE(nid, zone)];
+	
 	for (page = start; page < (start + size); page++) {
 		set_page_zone(page, NODEZONE(nid, zone));
 		set_page_count(page, 0);
@@ -1524,51 +1550,20 @@ void __init memmap_init_zone(unsigned lo
 #endif
 		start_pfn++;
 	}
-}
-
-/*
- * Page buddy system uses "index >> (i+1)", where "index" is
- * at most "size-1".
- *
- * The extra "+3" is to round down to byte size (8 bits per byte
- * assumption). Thus we get "(size-1) >> (i+4)" as the last byte
- * we can access.
- *
- * The "+1" is because we want to round the byte allocation up
- * rather than down. So we should have had a "+7" before we shifted
- * down by three. Also, we have to add one as we actually _use_ the
- * last bit (it's [0,n] inclusive, not [0,n[).
- *
- * So we actually had +7+1 before we shift down by 3. But
- * (n+8) >> 3 == (n >> 3) + 1 (modulo overflows, which we do not have).
- *
- * Finally, we LONG_ALIGN because all bitmap operations are on longs.
- */
-unsigned long pages_to_bitmap_size(unsigned long order, unsigned long nr_pages)
-{
-	unsigned long bitmap_size;
-
-	bitmap_size = (nr_pages-1) >> (order+4);
-	bitmap_size = LONG_ALIGN(bitmap_size+1);
-
-	return bitmap_size;
+	/* Because memmap_init_zone() is called in suitable way
+	 * even if zone has memory holes,
+	 * calling calculate_aligned_order(zone) here is reasonable
+	 */
+	calculate_aligned_order(zonep, saved_start_pfn, size);
+	
+	zonep->nr_mem_map++;
 }

 void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone, unsigned long size)
 {
 	int order;
-	for (order = 0; ; order++) {
-		unsigned long bitmap_size;
-
+	for (order = 0 ; order < MAX_ORDER ; order++) {
 		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		if (order == MAX_ORDER-1) {
-			zone->free_area[order].map = NULL;
-			break;
-		}
-
-		bitmap_size = pages_to_bitmap_size(order, size);
-		zone->free_area[order].map =
-		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
 	}
 }

@@ -1682,6 +1677,9 @@ static void __init free_area_init_core(s
 		if ((zone_start_pfn) & (zone_required_alignment-1))
 			printk("BUG: wrong zone alignment, it will crash\n");

+		zone->aligned_order = MAX_ORDER;
+		zone->nr_mem_map = 0;
+
 		memmap_init(size, nid, j, zone_start_pfn);

 		zone_start_pfn += size;

_

