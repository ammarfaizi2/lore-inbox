Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269114AbUIHLnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269114AbUIHLnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269125AbUIHLnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:43:16 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:29058 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269114AbUIHLmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:42:18 -0400
Date: Wed, 08 Sep 2004 20:47:31 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC][PATCH] no bitmap buddy allocator : initialize mem_map
 considering buddy system (1/4)
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <413EF153.7030100@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part (1/4). This part modifies memmap_init().


This implements some initialization for the buddy allocator.

In page_alloc.c, new function calculate_buddy_range() is implemented.

bad_range() is modified to use zone->memmap_start_pfn/memmap_end_pfn instead of
zone->start_pfn and zone->spanned_pages mostly because of IA64.

virtual_memmap_init() in arch/ia64/mm/init.c is also modified because
it calls memmap_init() for already initialized memmap.

calculate_buddy_range() removes some pages from system for removing invalid
mem_map access from __free_pages_bulk() main loop.(This is in 4th patch)

See below
================== main loop in __free_pages_bulk(page,order) ===========
while (order < MAX_ORDER) {
	struct page *buddy;
	......
	buddy_idx = page_idx ^ (1 << order);
	buddy = zone->zone_mem_map + buddy_idx;
	if (bad_range_pfn(zone,buddy_idx))------------(**)
		break;
	if (page_count(buddy) !=0  --------------------(*)
	.......
}
===============================================================
At (*), we have to guarantee that "buddy" is a valid page struct
in a valid zone.
At (**), bad_range_pfn() can catch out of zone access.
But it cannot manage a case that a zone's mem_map has holes.
So we remove pages in advance which can cause invalid page access at(*)
and cannot covered by bad_range_pfn().

calculate_buddy_range() discards some pages which is to be coalesced with
invalid "buddy". It is called from memmap_init() which is called per
contiguous mem_map.
It removes some pages from the mem_map to guarantee that there is no
invalid "buddy" access at (*). I call them as victim pages in my code.
The number of victim pages is at most MAX_ORDER pages per contiguous mem_map.

I think many machines' mem_map  has good alignment and has no holes
therefore there are usually no victim pages.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



---

  test-kernel-kamezawa/arch/ia64/mm/init.c |    9 +
  test-kernel-kamezawa/include/linux/gfp.h |    2
  test-kernel-kamezawa/mm/bootmem.c        |    9 -
  test-kernel-kamezawa/mm/page_alloc.c     |  210 ++++++++++++++++++++++++-------
  4 files changed, 177 insertions(+), 53 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-init mm/page_alloc.c
--- test-kernel/mm/page_alloc.c~eliminate-bitmap-init	2004-09-08 17:31:42.322389784 +0900
+++ test-kernel-kamezawa/mm/page_alloc.c	2004-09-08 19:14:33.803182096 +0900
@@ -62,19 +62,27 @@ unsigned long __initdata nr_kernel_pages
  unsigned long __initdata nr_all_pages;

  /*
- * Temporary debugging check for pages not lying within a given zone.
+ * check for pages not lying within a given zone.
   */
-static int bad_range(struct zone *zone, struct page *page)
+static int bad_range_pfn(struct zone *zone, unsigned long pfn)
  {
-	if (page_to_pfn(page) >= zone->zone_start_pfn + zone->spanned_pages)
+	if((pfn < zone->memmap_start_pfn) || (pfn > zone->memmap_end_pfn))
  		return 1;
-	if (page_to_pfn(page) < zone->zone_start_pfn)
+	return 0;
+}
+
+static int bad_range(struct zone *zone, struct page *page)
+{
+	if (bad_range_pfn(zone, page_to_pfn(page)))
  		return 1;
  	if (zone != page_zone(page))
  		return 1;
  	return 0;
  }

+/*
+ *  debug check to print bad page.
+ */
  static void bad_page(const char *function, struct page *page)
  {
  	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
@@ -917,6 +925,33 @@ fastcall void free_pages(unsigned long a
  EXPORT_SYMBOL(free_pages);

  /*
+ * This function doesn't pass PG_locked pages to buddy allocator.
+ * PG_locked pages are silently removed from buddy system, which are
+ * marked with PG_private and set page_order() to INVALID_PAGE_ORDER.
+ */
+long __init free_pages_at_init(struct page *base, int order)
+{
+	struct page *page;
+	int nr_pages = (1 << order);
+	long nr_freed_pages = 0;
+
+	if (PageReserved(base) || !put_page_testzero(base))
+		return 0;
+
+	for( page = base,nr_freed_pages = 0; page != base + nr_pages; page++) {
+		if (PageLocked(page)) {
+			/* this page is a victim for the buddy allocator. */
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
@@ -1499,6 +1534,109 @@ static void __init calculate_zone_totalp
  	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
  }

+/*
+ * For the buddy system, A page which meets all below conditions must access
+ * an invalid page in __free_pages_bulk() and cause a fault.
+ * (a) its buddy has an invalid pfn , out of mem_map.
+ * (b) access to its invalid buddy cannot be catched by bad_range_pfn().
+ * We cannot use it in the buddy system.
+ *
+ * This calculate_buddy_range() removes some pages.
+ * (1) At first, we check whether a mem_map is sparse or not. If not,
+ *     bad_range_pfn() can catch all invalid access.
+ * (2) We check whether the mem_map is aligned to MAX_ORDER or not.
+ * (3) If the mem_map is not aligned in its start address, we find pages
+ *     which are top of buddy-list in each order and check whether
+ *     their buddy are out of mem_map.If buddy is out of zone, bad_range_pfn()
+ *     can catch it.If in zone, we mark them with PG_locked.
+ * (4) If the mem_map is not aligned in its end addres and the first
+ *     out-of-memmap page is not out-of-zone, we mark the end page
+ *     of it with PG_locked.
+ *
+ * Marked pages are not added to buddy system and we call them victim pages.
+ * Please see free_pages_at_init().
+ */
+
+static void __init calculate_buddy_range(struct zone *zone,
+					 unsigned long start_pfn,
+					 int nr_pages)
+{
+	struct page *base;
+	unsigned long alignment_mask;
+	long start_idx, end_idx, edge_idx, buddy_idx;
+	int order;
+
+	if((zone->zone_start_pfn == start_pfn) &&
+	   (zone->spanned_pages == nr_pages))
+		/*
+		 * memmap is fully contiguous. bad_range_pfn() can catch
+		 * all invalid access. there is nothing to do
+		 */
+		return;
+	start_idx = start_pfn - zone->zone_start_pfn;
+	end_idx = start_idx + nr_pages - 1;
+	alignment_mask = (1 << MAX_ORDER) - 1;
+	base = zone->zone_mem_map;
+	printk("calculate_buddy_range() %lx %d\n",start_pfn, nr_pages);
+
+	if ((start_pfn != zone->memmap_start_pfn) &&
+	    (start_idx & alignment_mask)) {
+		/*
+		 * this mem_map is not aligned and invalid access in this
+		 * mem_map cannot be caught by bad_range_pfn()
+		 */
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
+				       zone->zone_start_pfn + edge_idx);
+				SetPageLocked(base + edge_idx);
+				edge_idx += (1 << order);
+			}
+		}
+	}
+	/*
+	 *  If end address is not aligned, we remove the last page.
+	 *  This will keep __free_page_bulk() from invalid mem_map access
+	 *  which exceeds the end of mem_map.
+	 *  This victim page can be revived by save_end_victim_zone().
+	 */
+	if ((end_idx & alignment_mask) != alignment_mask) {
+		printk("victim end page %lx\n",
+		       zone->zone_start_pfn + end_idx);
+		SetPageLocked(base + end_idx);
+	}
+	return;
+}
+
+static inline void save_end_victim_zone(struct zone *zone)
+{
+	struct page *page;
+	/*
+	 * zone->memmap_end_pfn is updated now.
+ 	 * bad_range_pfn() can catch invalid access exceeding end of zone.
+	 * if the zone's end page is a victim, we can use it.
+	 */
+	page = zone->zone_mem_map + zone->memmap_end_pfn- zone->zone_start_pfn;
+	if (PageLocked(page)) {
+		ClearPageLocked(page);
+		printk("saved end victim page %lx\n",zone->memmap_end_pfn);
+	}
+	return;
+}

  /*
   * Initially all pages are reserved - free ones are freed
@@ -1510,9 +1648,21 @@ void __init memmap_init_zone(unsigned lo
  {
  	struct page *start = pfn_to_page(start_pfn);
  	struct page *page;
-
+	unsigned long saved_start_pfn = start_pfn;
+	int zoneid = NODEZONE(nid, zone);
+	struct zone *zonep;
+	zonep = zone_table[zoneid];
+
+	if (zonep->memmap_start_pfn == ~0UL) {
+		zonep->memmap_start_pfn = start_pfn;
+	} else if (start_pfn < zonep->memmap_start_pfn) {
+		printk("BUG: memmap is not sorted. \n");
+	}
+	if (zonep->memmap_end_pfn < (start_pfn + size - 1)) {
+		zonep->memmap_end_pfn = start_pfn + size - 1;
+	}
  	for (page = start; page < (start + size); page++) {
-		set_page_zone(page, NODEZONE(nid, zone));
+		set_page_zone(page, zoneid);
  		set_page_count(page, 0);
  		reset_page_mapcount(page);
  		SetPageReserved(page);
@@ -1524,51 +1674,18 @@ void __init memmap_init_zone(unsigned lo
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
+	/*
+	 * calling calculate_buddy_range(zone) is to be called per
+	 * a contiguous mem_map.
+	 */
+	calculate_buddy_range(zonep, saved_start_pfn, size);
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

@@ -1682,7 +1799,10 @@ static void __init free_area_init_core(s
  		if ((zone_start_pfn) & (zone_required_alignment-1))
  			printk("BUG: wrong zone alignment, it will crash\n");

+		zone->memmap_start_pfn = ~0UL;
+		zone->memmap_end_pfn = 0;
  		memmap_init(size, nid, j, zone_start_pfn);
+		save_end_victim_zone(zone);

  		zone_start_pfn += size;

diff -puN include/linux/gfp.h~eliminate-bitmap-init include/linux/gfp.h
--- test-kernel/include/linux/gfp.h~eliminate-bitmap-init	2004-09-08 17:31:42.324389480 +0900
+++ test-kernel-kamezawa/include/linux/gfp.h	2004-09-08 17:31:42.333388112 +0900
@@ -5,6 +5,7 @@
  #include <linux/stddef.h>
  #include <linux/linkage.h>
  #include <linux/config.h>
+#include <linux/init.h>

  struct vm_area_struct;

@@ -124,6 +125,7 @@ extern void FASTCALL(__free_pages(struct
  extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
  extern void FASTCALL(free_hot_page(struct page *page));
  extern void FASTCALL(free_cold_page(struct page *page));
+extern long __init free_pages_at_init(struct page *base, int order);

  #define __free_page(page) __free_pages((page), 0)
  #define free_page(addr) free_pages((addr),0)
diff -puN mm/bootmem.c~eliminate-bitmap-init mm/bootmem.c
--- test-kernel/mm/bootmem.c~eliminate-bitmap-init	2004-09-08 17:31:42.326389176 +0900
+++ test-kernel-kamezawa/mm/bootmem.c	2004-09-08 17:31:42.334387960 +0900
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
diff -puN arch/ia64/mm/init.c~eliminate-bitmap-init arch/ia64/mm/init.c
--- test-kernel/arch/ia64/mm/init.c~eliminate-bitmap-init	2004-09-08 18:43:47.647840368 +0900
+++ test-kernel-kamezawa/arch/ia64/mm/init.c	2004-09-08 19:18:26.663781904 +0900
@@ -403,6 +403,8 @@ struct memmap_init_callback_data {
  	unsigned long zone;
  };

+/* this is used to avoid to initialize mem_map twice. */
+unsigned long max_initialized_memmap = 0;
  static int
  virtual_memmap_init (u64 start, u64 end, void *arg)
  {
@@ -427,10 +429,13 @@ virtual_memmap_init (u64 start, u64 end,
  	map_start -= ((unsigned long) map_start & (PAGE_SIZE - 1)) / sizeof(struct page);
  	map_end += ((PAGE_ALIGN((unsigned long) map_end) - (unsigned long) map_end)
  		    / sizeof(struct page));
-
-	if (map_start < map_end)
+	if (page_to_pfn(map_start) < max_initialized_memmap)
+		map_start = pfn_to_page(max_initialized_memmap);
+	if (map_start < map_end) {
  		memmap_init_zone((unsigned long)(map_end - map_start),
  				 args->nid, args->zone, page_to_pfn(map_start));
+		max_initialized_memmap = page_to_pfn(map_end) - 1;
+	}
  	return 0;
  }


_

