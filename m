Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUHPW7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUHPW7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUHPW7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:59:36 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:7310 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S266457AbUHPW5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:57:35 -0400
Date: Mon, 16 Aug 2004 15:56:57 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Fw: [Lhms-devel] Making hotremovable attribute with memory section[1/4]
Cc: mbligh@aracnet.com
Message-Id: <20040816155201.E6F9.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forwarded by Yasunori Goto <ygoto@us.fujitsu.com>
----------------------- Original Message -----------------------
 From:    Yasunori Goto <ygoto@us.fujitsu.com>
 To:      lhms-devel@lists.sourceforge.net
 Date:    Mon, 16 Aug 2004 14:36:13 -0700
 Subject: [Lhms-devel] Making hotremovable attribute with memory section[1/4]
----


-----------------------------------------
This is a patche to add attribute hot-removable
into section. Kernel will allocate pages by this attribute.

Reason:
  There are some memories which can't be hot-removed.
    ex) kernel text/stack, kmalloc(), etc...
  So, we should identify un-removable memory section to 
  hot-remove memory easily. This patch is for it.
  
   The amount of memories that can actually be hot-removed 
  will be maximized by localizing un-removable memories.
   At first, we give up to hot-remove of 'un-removable memory'.
  However, un-removable memory may be reduced by improvement of
  implementation.

Implementation:
  - Section has a flag. one bit is to indicate removable or not.
    
  - free_area is divided into hotremovable and removable.
    o If page requester requires swap-outable memory (this will be 
      indicated by __GFP_HOTREMOVABLE), kernel will allocate from 
      hot-removable free_area as much as possible.
    o If __GFP_HOTREMOVABLE isn't indicated at page allocation request,
      kernel will give only un-removable free_area.
    o When a page will be returned to free_area, kernel will
      identify sections to which the page belongs, and will return
      each free_area by it.

Note:
  - per_cpu_pages also have to be divided, but this patch doesn't 
    include it. (Other patch include it.)
  - __GFP_HOTREMOVABLE is defined by other patch.

---

 hotremovable-goto/include/linux/mmzone.h    |   11 +
 hotremovable-goto/include/linux/nonlinear.h |    5 
 hotremovable-goto/mm/nonlinear.c            |    9 +
 hotremovable-goto/mm/page_alloc.c           |  160 ++++++++++++++++------------
 4 files changed, 121 insertions(+), 64 deletions(-)

diff -puN include/linux/mmzone.h~divide_free_area include/linux/mmzone.h
--- hotremovable/include/linux/mmzone.h~divide_free_area	Fri Aug 13 16:24:32 2004
+++ hotremovable-goto/include/linux/mmzone.h	Fri Aug 13 16:24:32 2004
@@ -32,6 +32,15 @@ struct free_area {
 	} alloc_type;
 };
 
+struct area_type {
+	struct free_area free_area[MAX_ORDER];
+};
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+#define NUM_AREA_TYPE 2
+#else
+#define NUM_AREA_TYPE 1
+#endif
 struct pglist_data;
 
 /*
@@ -171,7 +180,7 @@ struct zone {
 	/*
 	 * free areas of different sizes
 	 */
-	struct free_area	free_area[MAX_ORDER];
+	struct area_type       area_type[NUM_AREA_TYPE];  /* 0: un-removable , 1: removable memory */
 
 	/*
 	 * wait_table		-- the array holding the hash table
diff -puN include/linux/nonlinear.h~divide_free_area include/linux/nonlinear.h
--- hotremovable/include/linux/nonlinear.h~divide_free_area	Fri Aug 13 16:24:32 2004
+++ hotremovable-goto/include/linux/nonlinear.h	Fri Aug 13 16:24:32 2004
@@ -39,6 +39,10 @@ static inline void alloc_memmap(struct p
 struct mem_section {
 	unsigned int	phys_section;
 	struct page	*mem_map;
+	unsigned char   flags;
+
+#define SECTION_REMOVABLE       (1 << 3)
+
 };
 
 extern struct mem_section mem_section[];
@@ -135,6 +139,7 @@ extern struct page *pfn_to_page(unsigned
 extern struct page *lpfn_to_page(unsigned long pfn);
 extern unsigned long page_to_pfn(struct page *page);
 extern unsigned long page_to_lpfn(struct page *page);
+extern unsigned int page_is_removable(struct page *page);
 
 #endif /* CONFIG_NONLINEAR */
 #endif /* __LINUX_NONLINEAR_H_ */
diff -puN mm/nonlinear.c~divide_free_area mm/nonlinear.c
--- hotremovable/mm/nonlinear.c~divide_free_area	Fri Aug 13 16:24:32 2004
+++ hotremovable-goto/mm/nonlinear.c	Fri Aug 13 16:24:32 2004
@@ -175,6 +175,15 @@ page_to_pfn(struct page *page)
 	return section_to_pfn(mem_section[page->section].phys_section) +
 		(page - mem_section[page->section].mem_map);
 }
+
+unsigned int
+page_is_removable(struct page *page)
+{
+	int index = page->section;
+	return !!(mem_section[index].flags & SECTION_REMOVABLE);
+}
+
+
 EXPORT_SYMBOL(pfn_to_page);
 EXPORT_SYMBOL(page_to_pfn);
 
diff -puN mm/page_alloc.c~divide_free_area mm/page_alloc.c
--- hotremovable/mm/page_alloc.c~divide_free_area	Fri Aug 13 16:24:32 2004
+++ hotremovable-goto/mm/page_alloc.c	Fri Aug 13 16:24:32 2004
@@ -197,7 +197,7 @@ static inline void __free_pages_bulk (st
 	while (order < MAX_ORDER-1) {
 		struct page *buddy1, *buddy2;
 
-		BUG_ON(area >= zone->free_area + MAX_ORDER);
+		/* XXX: How to check?  BUG_ON(area >= zone->free_area + MAX_ORDER); */
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -259,14 +259,17 @@ free_pages_bulk(struct zone *zone, int c
 	int ret = 0;
 
 	base = zone->zone_start_pfn;
-	area = zone->free_area + order;
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->all_unreclaimable = 0;
 	zone->pages_scanned = 0;
 	while (!list_empty(list) && count--) {
+		unsigned int at;
 		page = list_entry(list->prev, struct page, lru);
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
+		at = page_is_removable(page);
+                /* at = 0: Un-removable, 1: removable */
+		area = &zone->area_type[at].free_area[order];
 		__free_pages_bulk(page, base, zone, area, order);
 		ret++;
 	}
@@ -326,7 +329,7 @@ static inline int test_remove_range(stru
 static int remove_page_freearea(struct page *base, int order)
 {
 	struct zone *zone = page_zone(base);
-	int p_order;
+	int p_order, at;
 	unsigned long flags;
 	struct free_area *area;
 	struct list_head *p, *n;
@@ -337,9 +340,11 @@ static int remove_page_freearea(struct p
 	 * every iteration of the loop allows other processes to access the
 	 * data when needed.
 	 */
+	at = page_is_removable(base);
+
 	for (p_order = 0; p_order < MAX_ORDER; p_order++) {
 		spin_lock_irqsave(&zone->lock, flags);
-		area = zone->free_area + p_order;
+		area = zone->area_type[at].free_area + p_order;
 		if(list_empty(&area->free_list)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			continue;
@@ -456,15 +461,15 @@ static void prep_new_page(struct page *p
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone,struct area_type *area_type, unsigned int order)
 {
-	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
 	unsigned int index;
+	struct free_area *area;
 
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
+		area = area_type->free_area + current_order;
 		if (list_empty(&area->free_list))
 			continue;
 
@@ -486,23 +491,33 @@ static struct page *__rmqueue(struct zon
  * a single hold of the lock, for efficiency.  Add them to the supplied list.
  * Returns the number of new pages which were placed at *list.
  */
-static int rmqueue_bulk(struct zone *zone, unsigned int order, 
+static int rmqueue_bulk(struct zone *zone, unsigned int order, int gfp_flags,
 			unsigned long count, struct list_head *list)
 {
 	unsigned long flags;
 	int i;
 	int allocated = 0;
 	struct page *page;
+	struct area_type *area_type;
+	int at = !!(gfp_flags & __GFP_HOTREMOVABLE);
 	
+	area_type = &zone->area_type[at];
+
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, area_type, order);
 		if ((unsigned long)page == 0xc100c6b4) {
 			printk("%s() saw c100c6b4\n", __func__);
 			dump_stack();
 		}
-		if (page == NULL)
-			break;
+		if (page == NULL){
+			if (at){
+				at--;  /* try un-removable area */
+				area_type = &zone->area_type[at];
+				continue;
+			} else
+				break;
+		}
 		allocated++;
 		list_add_tail(&page->lru, list);
 	}
@@ -536,7 +551,7 @@ int is_head_of_free_region(struct page *
 {
         struct zone *zone = page_zone(page);
         unsigned long flags;
-	int order;
+	int order, at;
 	struct list_head *curr;
 
 	/*
@@ -544,12 +559,14 @@ int is_head_of_free_region(struct page *
 	 * suspend anyway, but...
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list)
-			if (page == list_entry(curr, struct page, lru)) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return 1 << order;
-			}
+	for (at = 0; at < NUM_AREA_TYPE; at++){
+		for (order = MAX_ORDER - 1; order >= 0; --order)
+			list_for_each(curr, &zone->area_type[at].free_area[order].free_list)
+				if (page == list_entry(curr, struct page, lru)) {
+					spin_unlock_irqrestore(&zone->lock, flags);
+					return 1 << order;
+				}
+	}
 	spin_unlock_irqrestore(&zone->lock, flags);
         return 0;
 }
@@ -722,6 +739,7 @@ buffered_rmqueue(struct zone *zone, int 
 	unsigned long flags;
 	struct page *page = NULL;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	int at = !!(gfp_flags & __GFP_HOTREMOVABLE);
 
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
@@ -729,7 +747,7 @@ buffered_rmqueue(struct zone *zone, int 
 		pcp = &zone->pageset[get_cpu()].pcp[cold];
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
-			pcp->count += rmqueue_bulk(zone, 0,
+			pcp->count += rmqueue_bulk(zone, 0, gfp_flags,
 						pcp->batch, &pcp->list);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
@@ -741,13 +759,21 @@ buffered_rmqueue(struct zone *zone, int 
 	}
 
 	if (page == NULL) {
-		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
-		if ((unsigned long)page == 0xc100c6b4) {
-			printk("%s() saw c100c6b4\n", __func__);
-			dump_stack();
+		struct area_type *area_type;
+		for (; at >= 0; at--){
+			/* Hotremovable requester can use un-hotremovable area. */
+			area_type = &zone->area_type[at];
+
+			spin_lock_irqsave(&zone->lock, flags);
+			page = __rmqueue(zone, area_type, order);
+			if ((unsigned long)page == 0xc100c6b4) {
+				printk("%s() saw c100c6b4\n", __func__);
+				dump_stack();
+			}
+			spin_unlock_irqrestore(&zone->lock, flags);
+
+			if (page != NULL) break;
 		}
-		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
 	if (page != NULL) {
@@ -1282,7 +1308,7 @@ void show_free_areas(void)
 
 	for_each_zone(zone) {
 		struct list_head *elem;
- 		unsigned long nr, flags, order, total = 0;
+ 		unsigned long nr, flags, order, total = 0, at;
 
 		show_node(zone);
 		printk("%s: ", zone->name);
@@ -1292,12 +1318,14 @@ void show_free_areas(void)
 		}
 
 		spin_lock_irqsave(&zone->lock, flags);
-		for (order = 0; order < MAX_ORDER; order++) {
-			nr = 0;
-			list_for_each(elem, &zone->free_area[order].free_list)
-				++nr;
-			total += nr << order;
-			printk("%lu*%lukB ", nr, K(1UL) << order);
+		for (at = 0; at < NUM_AREA_TYPE; at++){
+			for (order = 0; order < MAX_ORDER; order++) {
+				nr = 0;
+				list_for_each(elem, &zone->area_type[at].free_area[order].free_list)
+					++nr;
+				total += nr << order;
+				printk("%lu*%lukB ", nr, K(1UL) << order);
+			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
 		printk("= %lukB\n", K(total));
@@ -1613,21 +1641,23 @@ unsigned long pages_to_bitmap_size(unsig
 
 void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone, unsigned long size)
 {
-	int order;
-	for (order = 0; ; order++) {
-		unsigned long bitmap_size;
-
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		if (order == MAX_ORDER-1) {
-			zone->free_area[order].map = NULL;
-			break;
-		}
+	int order, at;
+	for (at = 0; at < NUM_AREA_TYPE; at++){
+		for (order = 0; ; order++) {
+			unsigned long bitmap_size;
+
+			INIT_LIST_HEAD(&zone->area_type[at].free_area[order].free_list);
+			if (order == MAX_ORDER-1) {
+				zone->area_type[at].free_area[order].map = NULL;
+				break;
+			}
 
-		bitmap_size = pages_to_bitmap_size(order, size);
-		zone->free_area[order].map =
-		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
-		zone->free_area[order].alloc_type = FROM_BOOTMEM;
-		zone->free_area[order].capacity_pages = bitmap_size;
+			bitmap_size = pages_to_bitmap_size(order, size);
+			zone->area_type[at].free_area[order].map =
+				(unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
+			zone->area_type[at].free_area[order].alloc_type = FROM_BOOTMEM;
+			zone->area_type[at].free_area[order].capacity_pages = bitmap_size;
+		}
 	}
 }
 
@@ -1686,10 +1716,10 @@ static void free_zone_bitmap(unsigned lo
  * a concurrent add or remove operation
  */
 static int zone_grow_one_free_list(struct zone *zone, unsigned long order,
-				   unsigned long new_nr_pages)
+				   unsigned int at, unsigned long new_nr_pages)
 {
-	unsigned long *old_map = zone->free_area[order].map;
-	struct free_area *fa = &zone->free_area[order];
+	unsigned long *old_map = zone->area_type[at].free_area[order].map;
+	struct free_area *fa = &zone->area_type[at].free_area[order];
 	unsigned long old_map_size_bytes;
 	unsigned long new_map_size_bytes;
 	unsigned long flags;
@@ -1739,7 +1769,7 @@ static int zone_grow_one_free_list(struc
  */
 int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages)
 {
-	unsigned long order;
+	unsigned long order, at;
 	int err = 0;
 
 	if (new_nr_pages < zone->spanned_pages) {
@@ -1747,13 +1777,15 @@ int zone_grow_free_lists(struct zone *zo
 		BUG();
 	}
 
-	for (order=0; order < MAX_ORDER-1; order++) {
-		err = zone_grow_one_free_list(zone, order, new_nr_pages);
-		if (err)
-			goto out;
+	for (at = 0; at < NUM_AREA_TYPE; at++){
+		for (order=0; order < MAX_ORDER-1; order++) {
+			err = zone_grow_one_free_list(zone, order, at, new_nr_pages);
+			if (err)
+				goto out;
+		}
+		zone->area_type[at].free_area[order].map = NULL;
 	}
 
-	zone->free_area[order].map = NULL;
 	zone->spanned_pages = new_nr_pages;
 out:
 	return err;
@@ -1974,7 +2006,7 @@ static int frag_show(struct seq_file *m,
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
 	unsigned long flags;
-	int order;
+	int order, at;
 
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		if (!zone->present_pages)
@@ -1982,13 +2014,15 @@ static int frag_show(struct seq_file *m,
 
 		spin_lock_irqsave(&zone->lock, flags);
 		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-		for (order = 0; order < MAX_ORDER; ++order) {
-			unsigned long nr_bufs = 0;
-			struct list_head *elem;
-
-			list_for_each(elem, &(zone->free_area[order].free_list))
-				++nr_bufs;
-			seq_printf(m, "%6lu ", nr_bufs);
+		for (at = 0; at < NUM_AREA_TYPE ; at++){
+			for (order = 0; order < MAX_ORDER; ++order) {
+				unsigned long nr_bufs = 0;
+				struct list_head *elem;
+
+				list_for_each(elem, &(zone->area_type[at].free_area[order].free_list))
+					++nr_bufs;
+				seq_printf(m, "%6lu ", nr_bufs);
+			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
_

-- 
Yasunori Goto <ygoto at us.fujitsu.com>




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Lhms-devel mailing list
Lhms-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lhms-devel

--------------------- Original Message Ends --------------------

-- 
Yasunori Goto <ygoto at us.fujitsu.com>


