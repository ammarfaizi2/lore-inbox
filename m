Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSEURuU>; Tue, 21 May 2002 13:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSEURuT>; Tue, 21 May 2002 13:50:19 -0400
Received: from holomorphy.com ([66.224.33.161]:56717 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315267AbSEURuN>;
	Tue, 21 May 2002 13:50:13 -0400
Date: Tue, 21 May 2002 10:50:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: lazy buddy prototype
Message-ID: <20020521175005.GN2035@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brewed this one up Sunday. Lightly tested. i386-only. Also available from

bk://linux-wli.bkbits.net/lazy_buddy
ftp://ftp.kernel.org/pub/linux/kernel/wli/vm/lazy_buddy/lazy_buddy-2.5.17-1

TODO:
(1)  remove debug code
(2)  move the work in dequeue()/enqueue() to buddy_alloc()/buddy_free()
(3)  use dequeue() and enqueue() for address-ordered queueing
(4)  write lg() for other architectures or use something else
(5)  kill boottime_defragment()
(6)  stress testing, find bugs if present
(7)  benchmarking
(8)  audit for unnecessary cacheline dirtying
(9)  audit for proper obeisance of the reclaiming/accelerated thresholds
(10) port to 2.4.x & rmap
(11) optimize
(12) figure out if the mask twiddling for ->deferred_pages[] is worth it
(13) figure out some way to get fragmentation stats out of the buddy bitmap


Cheers,
Bill

diff -urN --exclude [psx].* linux-2.5/fs/proc/proc_misc.c lazy_buddy-2.5/fs/proc/proc_misc.c
--- linux-2.5/fs/proc/proc_misc.c	Tue May 21 08:24:43 2002
+++ lazy_buddy-2.5/fs/proc/proc_misc.c	Tue May 21 09:02:34 2002
@@ -132,6 +132,7 @@
 	int len;
 	int pg_size ;
 	struct page_state ps;
+	extern unsigned long nr_deferred_pages(void);
 
 	get_page_state(&ps);
 /*
@@ -161,7 +162,8 @@
 		"SwapTotal:    %8lu kB\n"
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
-		"Writeback:    %8lu kB\n",
+		"Writeback:    %8lu kB\n"
+		"Deferred:     %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -177,7 +179,8 @@
 		K(i.totalswap),
 		K(i.freeswap),
 		K(ps.nr_dirty),
-		K(ps.nr_writeback)
+		K(ps.nr_writeback),
+		K(nr_deferred_pages())
 		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
diff -urN --exclude [psx].* linux-2.5/include/asm-i386/bitops.h lazy_buddy-2.5/include/asm-i386/bitops.h
--- linux-2.5/include/asm-i386/bitops.h	Tue May 21 08:24:57 2002
+++ lazy_buddy-2.5/include/asm-i386/bitops.h	Tue May 21 09:02:40 2002
@@ -401,6 +401,20 @@
 }
 
 /**
+ * lg - integer logarithm, or floor(ln(n)/ln(2))
+ * @word: The word to search
+ *
+ * Undefined if 0, one should check against 0 first.
+ */
+static inline unsigned long lg(unsigned long n)
+{
+	__asm__("bsrl %1,%0"
+		:"=r" (n)
+		:"r" (n));
+	return n;
+}
+
+/**
  * __ffs - find first bit in word.
  * @word: The word to search
  *
diff -urN --exclude [psx].* linux-2.5/include/linux/mmzone.h lazy_buddy-2.5/include/linux/mmzone.h
--- linux-2.5/include/linux/mmzone.h	Tue May 21 08:25:24 2002
+++ lazy_buddy-2.5/include/linux/mmzone.h	Tue May 21 09:03:04 2002
@@ -42,11 +42,15 @@
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
 	int			need_balance;
+	unsigned long		pages_granted;
+	unsigned long		pages_deferred;
 
 	/*
 	 * free areas of different sizes
 	 */
 	free_area_t		free_area[MAX_ORDER];
+	unsigned long		deferred_mask;
+	list_t			deferred_pages[MAX_ORDER];
 
 	/*
 	 * wait_table		-- the array holding the hash table
@@ -144,6 +148,11 @@
 
 #define memclass(pgzone, classzone)	(((pgzone)->zone_pgdat == (classzone)->zone_pgdat) \
 			&& ((pgzone) <= (classzone)))
+
+static inline unsigned long zone_free_pages(zone_t *zone)
+{
+	return zone->free_pages + zone->pages_deferred;
+}
 
 /*
  * The following two are not meant for general usage. They are here as
diff -urN --exclude [psx].* linux-2.5/include/linux/page-flags.h lazy_buddy-2.5/include/linux/page-flags.h
--- linux-2.5/include/linux/page-flags.h	Tue May 21 08:25:24 2002
+++ lazy_buddy-2.5/include/linux/page-flags.h	Tue May 21 09:03:05 2002
@@ -64,6 +64,7 @@
 
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
+#define PG_deferred		14	/* page not marked in buddy bitmap */
 
 /*
  * Global page accounting.  One instance per CPU.
@@ -174,6 +175,17 @@
 #define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
 #define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
 #define PagePrivate(page)	test_bit(PG_private, &(page)->flags)
+
+#ifdef DEBUG_LAZY_BUDDY
+#if DEBUG_LAZY_BUDDY > 0
+#define PageDeferred(page)	test_bit(PG_deferred, &(page)->flags)
+#define SetPageDeferred(page)	set_bit(PG_deferred, &(page)->flags)
+#define ClearPageDeferred(page)	clear_bit(PG_deferred, &(page)->flags)
+#else
+#define SetPageDeferred(page)	do { ; } while(0)
+#define ClearPageDeferred(page)	do { ; } while(0)
+#endif /* DEBUG_LAZY_BUDDY > 0 */
+#endif /* DEBUG_LAZY_BUDDY */
 
 #define PageWriteback(page)	test_bit(PG_writeback, &(page)->flags)
 #define SetPageWriteback(page)						\
diff -urN --exclude [psx].* linux-2.5/mm/bootmem.c lazy_buddy-2.5/mm/bootmem.c
--- linux-2.5/mm/bootmem.c	Tue May 21 08:25:32 2002
+++ lazy_buddy-2.5/mm/bootmem.c	Tue May 21 09:03:11 2002
@@ -241,6 +241,7 @@
 	return ret;
 }
 
+extern void FASTCALL(boottime_defragment(zone_t *zone));
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
 	struct page *page = pgdat->node_mem_map;
@@ -287,6 +288,9 @@
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
+
+	for (i = 0; i < MAX_NR_ZONES; ++i)
+		boottime_defragment(&pgdat->node_zones[i]);
 
 	return total;
 }
diff -urN --exclude [psx].* linux-2.5/mm/page_alloc.c lazy_buddy-2.5/mm/page_alloc.c
--- linux-2.5/mm/page_alloc.c	Tue May 21 08:25:33 2002
+++ lazy_buddy-2.5/mm/page_alloc.c	Tue May 21 09:03:11 2002
@@ -12,6 +12,8 @@
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
  */
 
+#define DEBUG_LAZY_BUDDY 0
+
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
@@ -71,6 +73,47 @@
 	|| ((zone) != page_zone(page))					\
 )
 
+#if DEBUG_LAZY_BUDDY > 0
+#define LAZY_BUG_ON(p) BUG_ON(p)
+#else
+#define LAZY_BUG_ON(p) do { ; } while(0)
+#endif
+
+#if DEBUG_LAZY_BUDDY > 1
+static void FASTCALL(check_deferred(zone_t *zone));
+static void check_deferred(zone_t *zone)
+{
+	int order;
+	list_t *elem;
+	unsigned long incr = 1;
+	unsigned long counted_deferred = 0;
+	struct page *page;
+
+	for (order = 0; order < MAX_ORDER; ++order) {
+		list_for_each(elem, &zone->deferred_pages[order]) {
+			counted_deferred += incr;
+			page = list_entry(elem, struct page, list);
+			BUG_ON(!PageDeferred(page));
+		}
+
+		incr <<= 1;
+	}
+	if (counted_deferred == zone->pages_deferred)
+		return;
+
+	printk("zone %s: deferred = %lu, zone->pages_deferred = %lu\n",
+			zone->name,
+			counted_deferred,
+			zone->pages_deferred);
+	BUG();
+}
+#else
+static inline void check_deferred(zone_t *zone)
+{
+	return;
+}
+#endif /* DEBUG_LAZY_BUDDY */
+
 /*
  * Freeing function for a buddy system allocator.
  *
@@ -91,35 +134,19 @@
  * -- wli
  */
 
-static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
-static void __free_pages_ok (struct page *page, unsigned int order)
+static void FASTCALL(enqueue(struct page *, int order));
+static void enqueue(struct page *page, int order)
 {
-	unsigned long index, page_idx, mask, flags;
+	unsigned long index, page_idx, mask;
 	free_area_t *area;
 	struct page *base;
 	zone_t *zone;
 
-	if (PagePrivate(page))
-		BUG();
-	if (page->mapping)
-		BUG();
-	if (PageLocked(page))
-		BUG();
-	if (PageLRU(page))
-		BUG();
-	if (PageActive(page))
-		BUG();
-	if (PageWriteback(page))
-		BUG();
-	ClearPageDirty(page);
-	page->flags &= ~(1<<PG_referenced);
-
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
- back_local_freelist:
 
+back_local_freelist:
 	zone = page_zone(page);
-
 	mask = (~0UL) << order;
 	base = zone->zone_mem_map;
 	page_idx = page - base;
@@ -129,8 +156,6 @@
 
 	area = zone->free_area + order;
 
-	spin_lock_irqsave(&zone->lock, flags);
-
 	zone->free_pages -= mask;
 
 	while (mask + (1 << (MAX_ORDER-1))) {
@@ -163,10 +188,9 @@
 	}
 	memlist_add_head(&(base + page_idx)->list, &area->free_list);
 
-	spin_unlock_irqrestore(&zone->lock, flags);
 	return;
 
- local_freelist:
+local_freelist:
 	if (current->nr_local_pages)
 		goto back_local_freelist;
 	if (in_interrupt())
@@ -177,6 +201,166 @@
 	current->nr_local_pages++;
 }
 
+static void FASTCALL(buddy_free(struct page *page, unsigned int order));
+static void buddy_free(struct page *page, unsigned int order)
+{
+	LAZY_BUG_ON(PageDeferred(page));
+	enqueue(page, order);
+}
+
+static void FASTCALL(low_level_free(struct page *page, unsigned int order));
+static void low_level_free(struct page *page, unsigned int order)
+{
+	zone_t *zone = page_zone(page);
+	unsigned long offset;
+	unsigned long flags;
+	unsigned long nr_pages = 1UL << order;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	check_deferred(zone);
+
+	offset = page - zone->zone_mem_map;
+
+	LAZY_BUG_ON(offset & (nr_pages - 1));
+	LAZY_BUG_ON(zone->pages_granted < zone->pages_deferred);
+	LAZY_BUG_ON(PageDeferred(page));
+
+	if (zone->pages_granted >= nr_pages)
+		zone->pages_granted -= nr_pages;
+	else
+		zone->pages_granted = 0;
+
+	/*
+	 * This check appears different from the strict invariant enforcement
+	 * because it anticipates pages_granted falling below pages_deferred.
+	 * One of the ugly things here is that we've already subtracted
+	 * nr_pages from pages_granted.
+	 */
+	if (unlikely(zone->pages_granted < zone->pages_deferred + nr_pages))
+		goto use_buddy;
+
+	zone->pages_deferred += nr_pages;
+
+	if (unlikely(!test_bit(order, &zone->deferred_mask)))
+		__set_bit(order, &zone->deferred_mask);
+	else
+		LAZY_BUG_ON(list_empty(&zone->deferred_pages[order]));
+
+	LAZY_BUG_ON((page - zone->zone_mem_map) & (nr_pages - 1));
+	list_add(&page->list, &zone->deferred_pages[order]);
+	SetPageDeferred(page);
+
+out_check:
+	LAZY_BUG_ON(zone->pages_granted < zone->pages_deferred);
+	check_deferred(zone);
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return;
+
+use_buddy:
+	LAZY_BUG_ON((page - zone->zone_mem_map) & (nr_pages - 1));
+	buddy_free(page, order);
+
+	if (likely(zone->pages_granted > zone->pages_deferred + 1))
+		goto out_check;
+
+keep_freeing:
+	/* grab another deferred page to coalesce */
+	if (unlikely(!zone->deferred_mask))
+		goto out_check;
+
+	order = lg(zone->deferred_mask);
+	nr_pages = 1UL << order;
+	LAZY_BUG_ON(order >= MAX_ORDER);
+	LAZY_BUG_ON(list_empty(&zone->deferred_pages[order]));
+
+	page = list_entry(zone->deferred_pages[order].next, struct page, list);
+	list_del_init(&page->list);
+	if (list_empty(&zone->deferred_pages[order]))
+		__clear_bit(order, &zone->deferred_mask);
+	else
+		LAZY_BUG_ON(!test_bit(order, &zone->deferred_mask));
+
+	LAZY_BUG_ON((page - zone->zone_mem_map) & (nr_pages - 1));
+	LAZY_BUG_ON(zone->pages_deferred < nr_pages);
+	LAZY_BUG_ON(!PageDeferred(page));
+	ClearPageDeferred(page);
+
+	buddy_free(page, order);
+	zone->pages_deferred -= nr_pages;
+	if (unlikely(zone->pages_granted < zone->pages_deferred))
+		goto keep_freeing;
+
+	check_deferred(zone);
+	LAZY_BUG_ON(zone->pages_granted < zone->pages_deferred);
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
+void FASTCALL(boottime_defragment(zone_t *zone));
+void boottime_defragment(zone_t *zone)
+{
+	int order;
+	struct page *page;
+	unsigned int nr_pages;
+	unsigned long offset;
+
+	if (!zone->size)
+		return;
+
+	check_deferred(zone);
+
+	for (order = MAX_ORDER - 1; order >= 0; --order) {
+		nr_pages = 1UL << order;
+		while (!list_empty(&zone->deferred_pages[order])) {
+			page = list_entry(zone->deferred_pages[order].next,
+						struct page,
+						list);
+			offset = page - zone->zone_mem_map;
+			if (unlikely(offset & (nr_pages - 1))) {
+				printk("page %p, bad offset %lx\n",
+						page,
+						offset);
+				BUG();
+			}
+			if (unlikely((unsigned long)page > MAXMEM)) {
+				printk("page %p above MAXMEM=%lx\n",
+						page,
+						MAXMEM);
+				BUG();
+			}
+			LAZY_BUG_ON(!PageDeferred(page));
+			ClearPageDeferred(page);
+			list_del_init(&page->list);
+			buddy_free(page, order);
+			LAZY_BUG_ON(zone->pages_deferred < nr_pages);
+			zone->pages_deferred -= nr_pages;
+		}
+		LAZY_BUG_ON(!list_empty(&zone->deferred_pages[order]));
+		__clear_bit(order, &zone->deferred_mask);
+	}
+	check_deferred(zone);
+}
+
+static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
+static void __free_pages_ok (struct page *page, unsigned int order)
+{
+	if (PagePrivate(page))
+		BUG();
+	if (page->mapping)
+		BUG();
+	if (PageLocked(page))
+		BUG();
+	if (PageLRU(page))
+		BUG();
+	if (PageActive(page))
+		BUG();
+	if (PageWriteback(page))
+		BUG();
+	ClearPageDirty(page);
+	page->flags &= ~(1<<PG_referenced);
+	LAZY_BUG_ON((page - page_zone(page)->zone_mem_map) & ((1UL << order) - 1));
+	low_level_free(page, order);
+}
+
 #define MARK_USED(index, order, area) \
 	__change_bit((index) >> (1+(order)), (area)->map)
 
@@ -201,16 +385,14 @@
 	return page;
 }
 
-static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
-static struct page * rmqueue(zone_t *zone, unsigned int order)
+static FASTCALL(struct page * dequeue(zone_t *zone, unsigned int order));
+static struct page * dequeue(zone_t *zone, unsigned int order)
 {
 	free_area_t * area = zone->free_area + order;
 	unsigned int curr_order = order;
 	struct list_head *head, *curr;
-	unsigned long flags;
 	struct page *page;
 
-	spin_lock_irqsave(&zone->lock, flags);
 	do {
 		head = &area->free_list;
 		curr = memlist_next(head);
@@ -228,8 +410,6 @@
 			zone->free_pages -= 1UL << order;
 
 			page = expand(zone, page, index, order, curr_order, area);
-			spin_unlock_irqrestore(&zone->lock, flags);
-
 			set_page_count(page, 1);
 			if (BAD_RANGE(zone,page))
 				BUG();
@@ -242,11 +422,132 @@
 		curr_order++;
 		area++;
 	} while (curr_order < MAX_ORDER);
-	spin_unlock_irqrestore(&zone->lock, flags);
 
 	return NULL;
 }
 
+static FASTCALL(struct page *buddy_alloc(zone_t *zone, unsigned int order));
+static struct page *buddy_alloc(zone_t *zone, unsigned int order)
+{
+	struct page *page;
+
+	page = dequeue(zone, order);
+
+	/*
+	 * This check is incorrect: the lazy buddy invariants may
+	 * be satisfied at boot but this would be the case during
+	 * steady state.
+	 * BUG_ON(!order && !page
+	 *      && zone->pages_granted - zone->pages_deferred > nr_pages);
+	 */
+
+	if (page)
+		LAZY_BUG_ON(PageDeferred(page));
+
+	return page;
+}
+
+static void FASTCALL(split_pages(zone_t *, struct page *, int, int));
+static void split_pages(zone_t *zone,
+			struct page *page,
+			int page_order,
+			int deferred_order)
+{
+	int split_order;
+	unsigned long split_offset;
+	struct page *split_page;
+
+	LAZY_BUG_ON(page_order >= deferred_order || page_order < 0);
+
+	split_order = deferred_order - 1;
+	split_offset = 1UL << split_order;
+	while (split_order >= page_order) {
+
+		LAZY_BUG_ON(split_order < 0 || split_order > MAX_ORDER);
+
+		split_page = &page[split_offset];
+		LAZY_BUG_ON(split_page == page);
+		LAZY_BUG_ON(PageDeferred(split_page));
+		SetPageDeferred(split_page);
+
+		if (unlikely(!test_bit(split_order, &zone->deferred_mask)))
+			__set_bit(split_order, &zone->deferred_mask);
+		else
+			LAZY_BUG_ON(list_empty(&zone->deferred_pages[split_order]));
+		list_add(&split_page->list, &zone->deferred_pages[split_order]);
+
+		--split_order;
+		split_offset >>= 1;
+	}
+}
+
+static FASTCALL(struct page *low_level_alloc(zone_t *, unsigned int));
+static struct page *low_level_alloc(zone_t *zone, unsigned int order)
+{
+	struct page *page;
+	unsigned long nr_pages = 1UL << order;
+	unsigned int deferred_order;
+	unsigned long flags;
+	unsigned long mask;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	check_deferred(zone);
+
+	LAZY_BUG_ON(zone->pages_granted < zone->pages_deferred);
+
+	/*
+	 * pages_granted and pages_deferred are about to get further
+	 * apart. The only adherence to strict coalescing is during
+	 * periods of deferred pool exhaustion.
+	 */
+	if (unlikely(zone->pages_granted <= zone->pages_deferred + 2)) {
+		page = buddy_alloc(zone, order);
+		goto out;
+	}
+
+	mask = zone->deferred_mask & ~(nr_pages - 1);
+	if (unlikely(!mask)) {
+		page = buddy_alloc(zone, order);
+		goto out;
+	}
+
+	deferred_order = __ffs(mask);
+	LAZY_BUG_ON(deferred_order >= MAX_ORDER || deferred_order < order);
+
+	LAZY_BUG_ON(list_empty(&zone->deferred_pages[deferred_order]));
+	page = list_entry(	zone->deferred_pages[deferred_order].next,
+				struct page,
+				list);
+
+	list_del_init(&page->list);
+	LAZY_BUG_ON(!PageDeferred(page));
+	ClearPageDeferred(page);
+
+	if (unlikely(list_empty(&zone->deferred_pages[deferred_order])))
+		__clear_bit(deferred_order, &zone->deferred_mask);
+	else
+		LAZY_BUG_ON(!test_bit(deferred_order, &zone->deferred_mask));
+
+	LAZY_BUG_ON(zone->pages_deferred < nr_pages);
+	zone->pages_deferred -= nr_pages;
+
+	if (unlikely(deferred_order > order))
+		split_pages(zone, page, order, deferred_order);
+
+out:
+	if (unlikely(!page))
+		goto out_nocount;
+
+	zone->pages_granted += nr_pages;
+	set_page_count(page, 1);
+
+out_nocount:
+	LAZY_BUG_ON(zone->pages_granted < zone->pages_deferred);
+	check_deferred(zone);
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return page;
+}
+
 #ifndef CONFIG_DISCONTIGMEM
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
@@ -348,8 +649,8 @@
 			break;
 
 		min += z->pages_low;
-		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+		if (zone_free_pages(z) > min) {
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -372,8 +673,8 @@
 		if (!(gfp_mask & __GFP_WAIT))
 			local_min >>= 2;
 		min += local_min;
-		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+		if (zone_free_pages(z) > min) {
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -389,7 +690,7 @@
 			if (!z)
 				break;
 
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -418,8 +719,8 @@
 			break;
 
 		min += z->pages_min;
-		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+		if (zone_free_pages(z) > min) {
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -490,15 +791,14 @@
 unsigned int nr_free_pages (void)
 {
 	unsigned int sum;
-	zone_t *zone;
+	int i;
 	pg_data_t *pgdat = pgdat_list;
 
 	sum = 0;
-	while (pgdat) {
-		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
-			sum += zone->free_pages;
-		pgdat = pgdat->node_next;
-	}
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+		for (i = 0; i < MAX_NR_ZONES; ++i)
+			sum += zone_free_pages(&pgdat->node_zones[i]);
+
 	return sum;
 }
 
@@ -574,6 +874,19 @@
 	return atomic_read(&buffermem_pages);
 }
 
+unsigned long nr_deferred_pages(void)
+{
+	pg_data_t *pgdat;
+	int i;
+	unsigned long pages = 0;
+
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+		for (i = 0; i < MAX_NR_ZONES; ++i)
+			pages += pgdat->node_zones[i].pages_deferred;
+
+	return pages;
+}
+
 /*
  * Accumulate the page_state information across all CPUs.
  * The result is unavoidably approximate - it can change
@@ -648,7 +961,7 @@
 			printk("Zone:%s freepages:%6lukB min:%6lukB low:%6lukB " 
 				       "high:%6lukB\n", 
 					zone->name,
-					K(zone->free_pages),
+					K(zone_free_pages(zone)),
 					K(zone->pages_min),
 					K(zone->pages_low),
 					K(zone->pages_high));
@@ -858,6 +1171,7 @@
 		zone->lock = SPIN_LOCK_UNLOCKED;
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->pages_deferred = 0;
 		zone->need_balance = 0;
 		if (!size)
 			continue;
@@ -913,6 +1227,7 @@
 		offset += size;
 		for (i = 0; ; i++) {
 			unsigned long bitmap_size;
+			INIT_LIST_HEAD(&zone->deferred_pages[i]);
 
 			memlist_init(&zone->free_area[i].free_list);
 			if (i == MAX_ORDER-1) {
diff -urN --exclude [psx].* linux-2.5/mm/vmscan.c lazy_buddy-2.5/mm/vmscan.c
--- linux-2.5/mm/vmscan.c	Tue May 21 08:25:33 2002
+++ lazy_buddy-2.5/mm/vmscan.c	Tue May 21 09:03:11 2002
@@ -672,7 +672,7 @@
 
 	first_classzone = classzone->zone_pgdat->node_zones;
 	while (classzone >= first_classzone) {
-		if (classzone->free_pages > classzone->pages_high)
+		if (zone_free_pages(classzone) > classzone->pages_high)
 			return 0;
 		classzone--;
 	}
