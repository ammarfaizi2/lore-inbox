Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUHaKgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUHaKgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUHaKgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:36:05 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:59618 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267749AbUHaKfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:35:53 -0400
Date: Tue, 31 Aug 2004 19:41:02 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap(2) [1/3]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>
Message-id: <413455BE.6010302@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2nd file.
Implements initialization code for buddy allocator.


- Kame

------------

This patch removes bitmap allocation in zone_init_free_lists() and
page_to_bitmap_size();

calculate_aligned_end() works
(a) detects mem_map is aligned or not.
(b) if start of mem_map is not aligned, add PG_buddyend flags to pages
     which has no lower address buddy.
(c) if end of mem_map is not aligned, reserve it by reserve_bootmem()



-- Kame


---

  linux-2.6.9-rc1-mm1-k-kamezawa/mm/page_alloc.c |  112 ++++++++++++++++---------
  1 files changed, 73 insertions(+), 39 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-init mm/page_alloc.c
--- linux-2.6.9-rc1-mm1-k/mm/page_alloc.c~eliminate-bitmap-init	2004-08-31 18:37:14.596519040 +0900
+++ linux-2.6.9-rc1-mm1-k-kamezawa/mm/page_alloc.c	2004-08-31 18:43:30.723339072 +0900
@@ -1499,6 +1499,70 @@ static void __init calculate_zone_totalp
  	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
  }

+/*
+ * (1) checks a mem_map is aligned to max_order or not.
+ * (2) if mem_map is not aligned in its start address, find pages which are
+ * lower-end of buddy.
+ * (3) if mem_map is not aligned in end addres,, find a page which is higher
+ * end of buddy and remove it from buddy allocator.
+ * All found pages are marked as PG_buddyend. These marked page has speccial
+ * meaning in free_pages().
+ */
+
+
+static void __init calculate_aligned_end(struct zone *zone,
+					 unsigned long start_pfn,
+					 int nr_pages)
+{
+	struct page *base;
+	unsigned long mask;
+	long start_idx, end_idx;
+	
+	start_idx = start_pfn - zone->zone_start_pfn;
+	end_idx = start_idx + nr_pages - 1;
+	mask = (1 << MAX_ORDER) - 1;
+	base = zone->zone_mem_map;
+	
+	if (start_idx & mask) {
+		long edge_idx, buddy_idx;
+		int order;
+		edge_idx = start_idx;
+		/*
+		 * Mark all pages which can be  higher half of buddy in
+		 * its index, but its lower half is never available.
+		 */
+		for (edge_idx = start_idx,order = 0;
+		     order < MAX_ORDER;
+		     order++) {
+			if (edge_idx > end_idx)
+				break;
+			buddy_idx = edge_idx ^ (1 << order);
+			if (buddy_idx < edge_idx) {
+				SetPageBuddyend(base + edge_idx);
+				edge_idx += (1 << order);
+			}
+		}
+	}
+	if ((end_idx & mask) != mask) {
+		unsigned long end_address;
+		/*
+		 * Reserve the last page as the stopper for buddy allocator.
+		 * This page is a victim to make buddy allocator work fine.
+		 *
+		 * Note:
+                 * We are using reserve_bootmem() here, is this correct ?
+		 */
+		SetPageBuddyend(base + end_idx);
+		SetPagePrivate(base + end_idx);
+		end_address = (zone->zone_start_pfn + end_idx) << PAGE_SHIFT;
+#ifndef CONFIG_DISCONTIGMEM
+		reserve_bootmem(end_address,PAGE_SIZE);
+#else
+		reserve_bootmem_node(zone->zone_pgdat,end_address,PAGE_SIZE);
+#endif
+	}
+	return;
+}

  /*
   * Initially all pages are reserved - free ones are freed
@@ -1510,7 +1574,9 @@ void __init memmap_init_zone(unsigned lo
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
@@ -1524,51 +1590,19 @@ void __init memmap_init_zone(unsigned lo
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
+	/* Because memmap_init_zone() is called in suitable way
+	 * even if zone has memory holes,
+	 * calling calculate_aligned_end(zone) here is reasonable
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


_

