Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUIBH4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUIBH4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUIBH4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:56:33 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:16286 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267792AbUIBHzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:55:16 -0400
Date: Thu, 02 Sep 2004 17:00:24 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap(3) [1/3]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>
Message-id: <4136D318.9060102@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This part is for initialization.

-- Kame

======

This patch is 2nd.
This implements some initialization for the buddy allocator.

New function: calculate_aligned_end()

calculate_aligned_end() removes some pages from system for removing invalid
mem_map access from __free_pages_bulk() main loop.(This is in 4th patch)

See below
================== main loop in __free_pages_bulk(page,order) ===========
while (order < MAX_ORDER) {
	struct page *buddy;
	......
	buddy_idx = page_idx ^ (1 << order);
	buddy = zone->zone_mem_map + buddy_idx;
	if (page_count(buddy) !=0  --------------------(*)
	.......
}
===============================================================
At (*), we have to guarantee that "buddy" is a valid page struct
in a valid zone.

Let MASK = (1 << (MAX_ORDER - 1)) - 1.
A page of index 'X' can be coalesced with pages from (X &~MASK) to (X | mask).
If both of a start index and length of a mem_map are multiples
of (1 << (MAX_ORDER - 1)), all pages have its valid buddies in all order.
Namely, if a mem_map is aligned with (1 << (MAX_ORDER -1)),
there is no invalid "buddy" access in (*).

If a mem_map is unaligned, there will be invalid access in (*).
For fixing this, it looks good to force the mem_map to be aligned.

(example) IA32's MAX_ORDER is 11. The alignment of buddy system is
(1 << (11 - 1))=1024. To make a mem_map aligned is not so difficult.

But , for example, IA64 kernel's MAX_ORDER is 18 !!!
Forcing a mem_map to be aligned is not good in general.
So, I uses another approach.

calculate_aligned_end() discards some pages which is to be coalesced with
invalid "buddy". It is called from memmap_init() which is called per
contiguous mem_map.
It removes some pages from the mem_map to guarantee that there is no
invalid "buddy" access in (*).

What is done in calculate_aligned_end() ? :
(1) It checks whether a mem_map is aligned or not.
(2) If the start of mem_map is unaligned, it find pages which have
    possibility of being coalesced with invalid pages.
    It marks them with PG_locked.
(3) If the end of mem_map is unaligned, it marks the end page with PG_locked.

Pages marked with PG_locked is removed by free_pages_at_init() and
is not added to the buddy system.

I think many machines' mem_map  has good alignment and there are usually no
removed pages :).

-- Kame


---

 include/linux/gfp.h                  |    0
 test-kernel-kamezawa/mm/bootmem.c    |    9 --
 test-kernel-kamezawa/mm/page_alloc.c |  140 +++++++++++++++++++++++++----------
 3 files changed, 103 insertions(+), 46 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-init mm/page_alloc.c
--- test-kernel/mm/page_alloc.c~eliminate-bitmap-init	2004-09-02 15:18:48.572933656 +0900
+++ test-kernel-kamezawa/mm/page_alloc.c	2004-09-02 15:45:14.692806784 +0900
@@ -917,6 +917,33 @@ fastcall void free_pages(unsigned long a
 EXPORT_SYMBOL(free_pages);

 /*
+ * This function doesn't pass PG_locked pages to buddy allocator.
+ * PG_locked pages are silently removed from buddy system, which are
+ * marked with PG_private and set page_order() to INVALID_PAGE_ORDER.
+ */
+int __init free_pages_at_init(struct page *base, unsigned int order)
+{
+	struct page *page;
+	int nr_pages = (1 << order);
+	int nr_freed_pages;
+	
+	if (PageReserved(base) || !put_page_testzero(base))
+		return 0;
+	
+	for( page = base,nr_freed_pages = 0; page != base + nr_pages; page++) {
+		if (PageLocked(page)) {
+			/* this page is out of buddy system */
+			SetPagePrivate(page);
+			set_page_order(page, PAGE_INVALID_ORDER);
+		} else {
+			free_hot_page(page);
+			nr_freed_pages++;
+		}
+	}
+	return nr_freed_pages;
+}
+
+/*
  * Total amount of free (allocatable) RAM:
  */
 unsigned int nr_free_pages(void)
@@ -1499,6 +1526,67 @@ static void __init calculate_zone_totalp
 	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
 }

+/*
+ * (1) We check whether the mem_map is aligned to MAX_ORDER or not.
+ * (2) If the mem_map is not aligned in its start address, we find pages
+ *     which are top of buddy-list in each order and check whether
+ *     their buddy are out of mem_map.If so, we mark them with PG_locked.
+ * (3) If the mem_map is not aligned in its end addres,we mark the end page
+ *     of it with PG_locked.
+ *
+ * Marked pages are not added to buddy system. Please see free_pages_at_init().
+ */
+
+static void __init calculate_aligned_end(struct zone *zone,
+					 unsigned long start_pfn,
+					 int nr_pages)
+{
+	struct page *base;
+	unsigned long alignment_mask;
+	long start_idx, end_idx;
+
+	start_idx = start_pfn - zone->zone_start_pfn;
+	end_idx = start_idx + nr_pages - 1;
+	alignment_mask = (1 << MAX_ORDER) - 1;
+	base = zone->zone_mem_map;
+	printk("calculate_aligned_end() %lx %lx\n",start_pfn, nr_pages);
+
+	if (start_idx & alignment_mask) {
+		long edge_idx, buddy_idx;
+		int order;
+		for (edge_idx = start_idx,order = 0;
+		     order < MAX_ORDER;
+		     order++) {
+			if (edge_idx > end_idx)
+				break;
+			buddy_idx = edge_idx ^ (1 << order);
+			if (buddy_idx > end_idx)
+				break;
+			if (buddy_idx < edge_idx) {
+				/*
+				 * Reserve the top page in this order
+				 * as the stopper for buddy allocator.
+				 * Because this page is an only page
+				 * which has an out of range buddy in
+				 * this order.
+				 */
+				printk("victim top page %lx\n",
+					zone->zone_start_pfn + edge_idx);
+				SetPageLocked(base + edge_idx);
+				edge_idx += (1 << order);
+			}
+		}
+	}
+	if ((end_idx & alignment_mask) != alignment_mask) {
+		/*
+		 * Reserve the last page as the stopper for buddy allocator.
+		 * Any coalescing including this page will not occur.
+		 */
+		printk("victim end page %lx\n",zone->zone_start_pfn + end_idx);
+		SetPageLocked(base + end_idx);
+	}
+	return;
+}

 /*
  * Initially all pages are reserved - free ones are freed
@@ -1510,9 +1598,13 @@ void __init memmap_init_zone(unsigned lo
 {
 	struct page *start = pfn_to_page(start_pfn);
 	struct page *page;
-
+	unsigned long saved_start_pfn = start_pfn;
+	int zoneid = NODEZONE(nid, zone);
+	struct zone *zonep;
+	zonep = zone_table[zoneid];
+	
 	for (page = start; page < (start + size); page++) {
-		set_page_zone(page, NODEZONE(nid, zone));
+		set_page_zone(page, zoneid);
 		set_page_count(page, 0);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
@@ -1524,51 +1616,19 @@ void __init memmap_init_zone(unsigned lo
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
+	/*
+	 * calling calculate_aligned_end(zone) is need to be called per
+	 * a contiguous mem_map.
+	 */
+	calculate_aligned_end(zonep, saved_start_pfn, size);

-	return bitmap_size;
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

diff -puN include/linux/gfp.h~eliminate-bitmap-init include/linux/gfp.h
diff -puN mm/bootmem.c~eliminate-bitmap-init mm/bootmem.c
--- test-kernel/mm/bootmem.c~eliminate-bitmap-init	2004-09-02 15:18:48.576933048 +0900
+++ test-kernel-kamezawa/mm/bootmem.c	2004-09-02 15:18:48.583931984 +0900
@@ -277,7 +277,6 @@ static unsigned long __init free_all_boo
 		if (gofast && v == ~0UL) {
 			int j;

-			count += BITS_PER_LONG;
 			__ClearPageReserved(page);
 			set_page_count(page, 1);
 			for (j = 1; j < BITS_PER_LONG; j++) {
@@ -285,17 +284,16 @@ static unsigned long __init free_all_boo
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
 			}
-			__free_pages(page, ffs(BITS_PER_LONG)-1);
+			count += free_pages_at_init(page,ffs(BITS_PER_LONG)-1);
 			i += BITS_PER_LONG;
 			page += BITS_PER_LONG;
 		} else if (v) {
 			unsigned long m;
 			for (m = 1; m && i < idx; m<<=1, page++, i++) {
 				if (v & m) {
-					count++;
 					__ClearPageReserved(page);
 					set_page_count(page, 1);
-					__free_page(page);
+					count += free_pages_at_init(page,0);
 				}
 			}
 		} else {
@@ -312,10 +310,9 @@ static unsigned long __init free_all_boo
 	page = virt_to_page(bdata->node_bootmem_map);
 	count = 0;
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
-		count++;
 		__ClearPageReserved(page);
 		set_page_count(page, 1);
-		__free_page(page);
+		count += free_pages_at_init(page,0);
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;

_




-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


