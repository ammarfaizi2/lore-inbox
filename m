Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUINXwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUINXwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUINXwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:52:25 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:60844 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265971AbUINXv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:51:59 -0400
Message-ID: <41478419.3020606@yahoo.com.au>
Date: Wed, 15 Sep 2004 09:51:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: jmerkey@galt.devicelogics.com
CC: "Jeff V. Merkey" <jmerkey@drdos.com>, linux-kernel@vger.kernel.org,
       jmerkey@comcast.net
Subject: Re: 2.6.8.1 mempool subsystem sickness
References: <091420042058.15928.41475B8000002BA100003E382200763704970A059D0A0306@comcast.net> <4147555C.7010809@drdos.com> <414777EA.5080406@yahoo.com.au> <20040914223122.GA3325@galt.devicelogics.com>
In-Reply-To: <20040914223122.GA3325@galt.devicelogics.com>
Content-Type: multipart/mixed;
 boundary="------------010805090707030401040603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010805090707030401040603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

jmerkey@galt.devicelogics.com wrote:
> You bet.  Send them to me.  For some reason I am not able to post 
> to LKML again.
> 
> Jeff
> 

OK, this is against 2.6.9-rc2. Let me know how you go. Thanks

--------------010805090707030401040603
Content-Type: text/x-patch;
 name="vm-rollup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-rollup.patch"




---

 linux-2.6-npiggin/include/linux/mmzone.h |    8 ++
 linux-2.6-npiggin/mm/page_alloc.c        |   83 ++++++++++++++++++-------------
 linux-2.6-npiggin/mm/vmscan.c            |   34 +++++++++---
 3 files changed, 81 insertions(+), 44 deletions(-)

diff -puN mm/page_alloc.c~vm-rollup mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~vm-rollup	2004-09-15 09:48:12.000000000 +1000
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-09-15 09:48:59.000000000 +1000
@@ -206,6 +206,7 @@ static inline void __free_pages_bulk (st
 		BUG_ON(bad_range(zone, buddy1));
 		BUG_ON(bad_range(zone, buddy2));
 		list_del(&buddy1->lru);
+		area->nr_free--;
 		mask <<= 1;
 		order++;
 		area++;
@@ -213,6 +214,7 @@ static inline void __free_pages_bulk (st
 		page_idx &= mask;
 	}
 	list_add(&(base + page_idx)->lru, &area->free_list);
+	area->nr_free++;
 }
 
 static inline void free_pages_check(const char *function, struct page *page)
@@ -314,6 +316,7 @@ expand(struct zone *zone, struct page *p
 		size >>= 1;
 		BUG_ON(bad_range(zone, &page[size]));
 		list_add(&page[size].lru, &area->free_list);
+		area->nr_free++;
 		MARK_USED(index + size, high, area);
 	}
 	return page;
@@ -377,6 +380,7 @@ static struct page *__rmqueue(struct zon
 
 		page = list_entry(area->free_list.next, struct page, lru);
 		list_del(&page->lru);
+		area->nr_free--;
 		index = page - zone->zone_mem_map;
 		if (current_order != MAX_ORDER-1)
 			MARK_USED(index, current_order, area);
@@ -579,6 +583,36 @@ buffered_rmqueue(struct zone *zone, int 
 }
 
 /*
+ * Return 1 if free pages are above 'mark'. This takes into account the order
+ * of the allocation.
+ */
+int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
+		int alloc_type, int can_try_harder, int gfp_high)
+{
+	unsigned long min = mark, free_pages = z->free_pages;
+	int o;
+
+	if (gfp_high)
+		min -= min / 2;
+	if (can_try_harder)
+		min -= min / 4;
+
+	if (free_pages < min + z->protection[alloc_type])
+		return 0;
+	for (o = 0; o < order; o++) {
+		/* At the next order, this order's pages become unavailable */
+		free_pages -= z->free_area[order].nr_free << o;
+
+		/* Require fewer higher order pages to be free */
+		min >>= 1;
+
+		if (free_pages < min + (1 << order) - 1)
+			return 0;
+	}
+	return 1;
+}
+
+/*
  * This is the 'heart' of the zoned buddy allocator.
  *
  * Herein lies the mysterious "incremental min".  That's the
@@ -599,7 +633,6 @@ __alloc_pages(unsigned int gfp_mask, uns
 		struct zonelist *zonelist)
 {
 	const int wait = gfp_mask & __GFP_WAIT;
-	unsigned long min;
 	struct zone **zones, *z;
 	struct page *page;
 	struct reclaim_state reclaim_state;
@@ -629,9 +662,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 
 	/* Go through the zonelist once, looking for a zone with enough free */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_low + (1<<order) + z->protection[alloc_type];
 
-		if (z->free_pages < min)
+		if (!zone_watermark_ok(z, order, z->pages_low,
+				alloc_type, 0, 0))
 			continue;
 
 		page = buffered_rmqueue(z, order, gfp_mask);
@@ -640,21 +673,16 @@ __alloc_pages(unsigned int gfp_mask, uns
 	}
 
 	for (i = 0; (z = zones[i]) != NULL; i++)
-		wakeup_kswapd(z);
+		wakeup_kswapd(z, order);
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
 	 * coming from realtime tasks to go deeper into reserves
 	 */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_min;
-		if (gfp_mask & __GFP_HIGH)
-			min /= 2;
-		if (can_try_harder)
-			min -= min / 4;
-		min += (1<<order) + z->protection[alloc_type];
-
-		if (z->free_pages < min)
+		if (!zone_watermark_ok(z, order, z->pages_min,
+				alloc_type, can_try_harder,
+				gfp_mask & __GFP_HIGH))
 			continue;
 
 		page = buffered_rmqueue(z, order, gfp_mask);
@@ -690,14 +718,9 @@ rebalance:
 
 	/* go through the zonelist yet one more time */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_min;
-		if (gfp_mask & __GFP_HIGH)
-			min /= 2;
-		if (can_try_harder)
-			min -= min / 4;
-		min += (1<<order) + z->protection[alloc_type];
-
-		if (z->free_pages < min)
+		if (!zone_watermark_ok(z, order, z->pages_min,
+				alloc_type, can_try_harder,
+				gfp_mask & __GFP_HIGH))
 			continue;
 
 		page = buffered_rmqueue(z, order, gfp_mask);
@@ -1117,7 +1140,6 @@ void show_free_areas(void)
 	}
 
 	for_each_zone(zone) {
-		struct list_head *elem;
  		unsigned long nr, flags, order, total = 0;
 
 		show_node(zone);
@@ -1129,9 +1151,7 @@ void show_free_areas(void)
 
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = 0;
-			list_for_each(elem, &zone->free_area[order].free_list)
-				++nr;
+			nr = zone->free_area[order].nr_free;
 			total += nr << order;
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
@@ -1457,6 +1477,7 @@ void zone_init_free_lists(struct pglist_
 		bitmap_size = pages_to_bitmap_size(order, size);
 		zone->free_area[order].map =
 		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
+		zone->free_area[order].nr_free = 0;
 	}
 }
 
@@ -1481,6 +1502,7 @@ static void __init free_area_init_core(s
 
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
+	pgdat->kswapd_max_order = 0;
 	
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
@@ -1644,8 +1666,7 @@ static void frag_stop(struct seq_file *m
 }
 
 /* 
- * This walks the freelist for each zone. Whilst this is slow, I'd rather 
- * be slow here than slow down the fast path by keeping stats - mjbligh
+ * This walks the free areas for each zone.
  */
 static int frag_show(struct seq_file *m, void *arg)
 {
@@ -1661,14 +1682,8 @@ static int frag_show(struct seq_file *m,
 
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
diff -puN include/linux/mmzone.h~vm-rollup include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~vm-rollup	2004-09-15 09:48:16.000000000 +1000
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-09-15 09:48:59.000000000 +1000
@@ -23,6 +23,7 @@
 struct free_area {
 	struct list_head	free_list;
 	unsigned long		*map;
+	unsigned long		nr_free;
 };
 
 struct pglist_data;
@@ -262,8 +263,9 @@ typedef struct pglist_data {
 					     range, including holes */
 	int node_id;
 	struct pglist_data *pgdat_next;
-	wait_queue_head_t       kswapd_wait;
+	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
+	int kswapd_max_order;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
@@ -277,7 +279,9 @@ void __get_zone_counts(unsigned long *ac
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free);
 void build_all_zonelists(void);
-void wakeup_kswapd(struct zone *zone);
+void wakeup_kswapd(struct zone *zone, int order);
+int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
+		int alloc_type, int can_try_harder, int gfp_high);
 
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
diff -puN mm/vmscan.c~vm-rollup mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-rollup	2004-09-15 09:48:18.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-09-15 09:49:31.000000000 +1000
@@ -965,7 +965,7 @@ out:
  * the page allocator fallback scheme to ensure that aging of pages is balanced
  * across the zones.
  */
-static int balance_pgdat(pg_data_t *pgdat, int nr_pages)
+static int balance_pgdat(pg_data_t *pgdat, int nr_pages, int order)
 {
 	int to_free = nr_pages;
 	int priority;
@@ -1003,7 +1003,8 @@ static int balance_pgdat(pg_data_t *pgda
 						priority != DEF_PRIORITY)
 					continue;
 
-				if (zone->free_pages <= zone->pages_high) {
+				if (!zone_watermark_ok(zone, order,
+						zone->pages_high, 0, 0, 0)) {
 					end_zone = i;
 					goto scan;
 				}
@@ -1035,7 +1036,8 @@ scan:
 				continue;
 
 			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone->free_pages <= zone->pages_high)
+				if (!zone_watermark_ok(zone, order,
+						zone->pages_high, end_zone, 0, 0))
 					all_zones_ok = 0;
 			}
 			zone->temp_priority = priority;
@@ -1126,13 +1128,26 @@ static int kswapd(void *p)
 	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
 
 	for ( ; ; ) {
+		unsigned long order = 0, new_order;
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_FREEZE);
+
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
-		schedule();
+		new_order = pgdat->kswapd_max_order;
+		pgdat->kswapd_max_order = 0;
+		if (order < new_order) {
+			/*
+			 * Don't sleep if someone wants a larger 'order'
+			 * allocation
+			 */
+			order = new_order;
+		} else {
+			schedule();
+			order = pgdat->kswapd_max_order;
+		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0);
+		balance_pgdat(pgdat, 0, order);
 	}
 	return 0;
 }
@@ -1140,10 +1155,13 @@ static int kswapd(void *p)
 /*
  * A zone is low on free memory, so wake its kswapd task to service it.
  */
-void wakeup_kswapd(struct zone *zone)
+void wakeup_kswapd(struct zone *zone, int order)
 {
-	if (zone->free_pages > zone->pages_low)
+	pg_data_t *pgdat = zone->zone_pgdat;
+
+	if (pgdat->kswapd_max_order < order)
 		return;
+	pgdat->kswapd_max_order = order;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;
 	wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
@@ -1166,7 +1184,7 @@ int shrink_all_memory(int nr_pages)
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
-		freed = balance_pgdat(pgdat, nr_to_free);
+		freed = balance_pgdat(pgdat, nr_to_free, 0);
 		ret += freed;
 		nr_to_free -= freed;
 		if (nr_to_free <= 0)

_

--------------010805090707030401040603--
