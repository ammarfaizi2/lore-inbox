Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUIEFqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUIEFqC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 01:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUIEFqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 01:46:02 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:17538 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265847AbUIEFpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 01:45:45 -0400
Message-ID: <413AA7F8.3050706@yahoo.com.au>
Date: Sun, 05 Sep 2004 15:45:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 1/3] account free buddy areas
References: <413AA7B2.4000907@yahoo.com.au>
In-Reply-To: <413AA7B2.4000907@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030503070104070200020305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503070104070200020305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/3

--------------030503070104070200020305
Content-Type: text/x-patch;
 name="vm-free-order-pages.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-free-order-pages.patch"



Keep track of the number of free pages of each order in the buddy allocator.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/include/linux/mmzone.h |    1 +
 linux-2.6-npiggin/mm/page_alloc.c        |   22 ++++++++--------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff -puN mm/page_alloc.c~vm-free-order-pages mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~vm-free-order-pages	2004-09-05 14:53:53.000000000 +1000
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-09-05 14:53:53.000000000 +1000
@@ -216,6 +216,7 @@ static inline void __free_pages_bulk (st
 		page_idx &= mask;
 	}
 	list_add(&(base + page_idx)->lru, &area->free_list);
+	area->nr_free++;
 }
 
 static inline void free_pages_check(const char *function, struct page *page)
@@ -317,6 +318,7 @@ expand(struct zone *zone, struct page *p
 		size >>= 1;
 		BUG_ON(bad_range(zone, &page[size]));
 		list_add(&page[size].lru, &area->free_list);
+		area->nr_free++;
 		MARK_USED(index + size, high, area);
 	}
 	return page;
@@ -380,6 +382,7 @@ static struct page *__rmqueue(struct zon
 
 		page = list_entry(area->free_list.next, struct page, lru);
 		list_del(&page->lru);
+		area->nr_free--;
 		index = page - zone->zone_mem_map;
 		if (current_order != MAX_ORDER-1)
 			MARK_USED(index, current_order, area);
@@ -1228,7 +1231,6 @@ void show_free_areas(void)
 	}
 
 	for_each_zone(zone) {
-		struct list_head *elem;
  		unsigned long nr, flags, order, total = 0;
 
 		show_node(zone);
@@ -1240,9 +1242,7 @@ void show_free_areas(void)
 
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = 0;
-			list_for_each(elem, &zone->free_area[order].free_list)
-				++nr;
+			nr = zone->free_area[order].nr_free;
 			total += nr << order;
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
@@ -1569,6 +1569,7 @@ void zone_init_free_lists(struct pglist_
 		bitmap_size = pages_to_bitmap_size(order, size);
 		zone->free_area[order].map =
 		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
+		zone->free_area[order].nr_free = 0;
 	}
 }
 
@@ -1756,8 +1757,7 @@ static void frag_stop(struct seq_file *m
 }
 
 /* 
- * This walks the freelist for each zone. Whilst this is slow, I'd rather 
- * be slow here than slow down the fast path by keeping stats - mjbligh
+ * This walks the free areas for each zone.
  */
 static int frag_show(struct seq_file *m, void *arg)
 {
@@ -1773,14 +1773,8 @@ static int frag_show(struct seq_file *m,
 
 		spin_lock_irqsave(&zone->lock, flags);
 		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-		for (order = 0; order < MAX_ORDER; ++order) {
-			unsigned long nr_bufs = 0;
-			struct list_head *elem;
-
-			list_for_each(elem, &(zone->free_area[order].free_list))
-				++nr_bufs;
-			seq_printf(m, "%6lu ", nr_bufs);
-		}
+		for (order = 0; order < MAX_ORDER; ++order)
+			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
 	}
diff -puN include/linux/mmzone.h~vm-free-order-pages include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~vm-free-order-pages	2004-09-05 14:53:53.000000000 +1000
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-09-05 14:53:53.000000000 +1000
@@ -23,6 +23,7 @@
 struct free_area {
 	struct list_head	free_list;
 	unsigned long		*map;
+	unsigned long		nr_free;
 };
 
 struct pglist_data;

_

--------------030503070104070200020305--
