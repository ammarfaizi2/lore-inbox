Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSHFT3e>; Tue, 6 Aug 2002 15:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSHFT3e>; Tue, 6 Aug 2002 15:29:34 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:19468 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S315370AbSHFT33>;
	Tue, 6 Aug 2002 15:29:29 -0400
Date: Tue, 6 Aug 2002 20:33:00 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/5] page_alloc commentry
Message-ID: <Pine.LNX.4.44.0208062009200.14917-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a commentry patch documenting more how the buddy allocator does
it's work. No code is changed. Please apply

Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel


--- linux-2.4.19/mm/page_alloc.c	Sat Aug  3 01:39:46 2002
+++ linux-2.4.19-mel/mm/page_alloc.c	Tue Aug  6 15:41:33 2002
@@ -25,11 +25,24 @@
 int nr_swap_pages;
 int nr_active_pages;
 int nr_inactive_pages;
+
+/*
+ * The two LRU list. These of primary interest to the page replacement
+ * algorithm. Pages that are referenced often will remain in the active_list.
+ * Pages are moved to the inactive_list by refill_inactive called by kswapd.
+ * Once in the inactive list, the page is a candidate to be swapped out
+ */
 LIST_HEAD(inactive_list);
 LIST_HEAD(active_list);
 pg_data_t *pgdat_list;

-/* Used to look up the address of the struct zone encoded in page->zone */
+/*
+ * zone_table is the replacement for page->zone . It's a simple way of
+ * quickly looking up what zone a page belongs so. During init, the upper
+ * most 8 bits of page->flags will be used to store what zone we are in.
+ * See free_area_init_core . The macro page_zone returns the zone a page
+ * belongs to. See linux/include/mm.h
+ */
 zone_t *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
 EXPORT_SYMBOL(zone_table);

@@ -69,8 +82,23 @@
  * triggers coalescing into a block of larger size.
  *
  * -- wli
+ *
+ *  There is a brief explanation of how a buddy algorithm works at
+ *  http://www.memorymanagement.org/articles/alloc.html . A better idea
+ *  is to read the explanation from a book like UNIX Internals by
+ *  Uresh Vahalia
+ *
  */

+/**
+ *
+ * __free_pages_ok - Returns pages to the buddy allocator
+ * @page: The first page of the block to be freed
+ * @order: 2^order number of pages are freed
+ *
+ * This function returns the pages allocated by __alloc_pages and tries to
+ * merge buddies if possible. Do not call directly, use free_pages()
+ **/
 static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
 static void __free_pages_ok (struct page *page, unsigned int order)
 {
@@ -97,13 +125,29 @@
 		BUG();
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));

+	/*
+	 * If it is balance_classzone that is doing the freeing, the pages
+	 * are to be kept for the process doing all the work freeing up pages
+	 */
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
  back_local_freelist:

 	zone = page_zone(page);

+	/*
+	 * Multiple uses for mask which defies a common name
+	 * -mask            == number of pages that will be freed
+	 * page_idx & ~mask == Is page aligned to an order size?
+	 * Also used later to calculate the address of a buddy
+	 */
 	mask = (~0UL) << order;
+
+	/*
+	 * zone_mem_map  = first page in the current zone
+	 * page_idx      = page offset within zone_mem_map
+	 * index         = bit offset within map representing the buddies
+	 */
 	base = zone->zone_mem_map;
 	page_idx = page - base;
 	if (page_idx & ~mask)
@@ -116,9 +160,16 @@

 	zone->free_pages -= mask;

+	/* Irregardless of order, this is 0 when MAX_ORDER is reached */
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;

+		/*
+		 * FIXME: This could only be true if order was originally set
+		 *        to be a value greater than MAX_ORDER. The
+		 *        sanity check should be at the beginning of the
+		 *        function.
+		 */
 		if (area >= zone->free_area + MAX_ORDER)
 			BUG();
 		if (!__test_and_change_bit(index, area->map))
@@ -150,11 +201,23 @@
 	return;

  local_freelist:
+	/* If the process has already freed pages for itself, don't give it
+	 * more */
 	if (current->nr_local_pages)
 		goto back_local_freelist;
+
+	/*
+	 * An interrupt doesn't have a current process to store pages on.
+	 *
+	 * QUERY: is this not a dead check, an interrupt could only get here if
+	 * alloc_pages took the slow path through balance_classzones. If an
+	 * interrupt got there, aren't we already dead?
+	 */
 	if (in_interrupt())
 		goto back_local_freelist;

+	/* Add the page onto the local list, update the page information
+	 * and return */
 	list_add(&page->list, &current->local_pages);
 	page->index = order;
 	current->nr_local_pages++;
@@ -163,19 +226,49 @@
 #define MARK_USED(index, order, area) \
 	__change_bit((index) >> (1+(order)), (area)->map)

+/**
+ *
+ * expand - Break up higher order pages until the right size block is available
+ * @zone: The zone to free pages from
+ * @page: The first page of the first order to split
+ * @index: The page address index inside zone_mem_map
+ * @low: The order block of pages required
+ * @high: The order of the block of pages that are about to be split
+ * @area: The array of free areas for this zone
+ *
+ * This function will break up higher orders of pages necessary and update the
+ * bitmaps as it goes along. If it splits, the lower half will be put onto
+ * the free list and the high half will be either allocated or split
+ * further. This function is called from rmqueue() and not directly
+ *
+ * Note that index here is a page number offset within this zone. In other
+ * parts of the code, index means a bit offset within map.
+ **/
 static inline struct page * expand (zone_t *zone, struct page *page,
 	 unsigned long index, int low, int high, free_area_t * area)
 {
 	unsigned long size = 1 << high;

+	/*
+	 * If it turned out there was a free block at the right order to begin
+	 * with, no splitting will take place
+	 */
 	while (high > low) {
 		if (BAD_RANGE(zone,page))
 			BUG();
+		/* Prepare to move to next area and size */
 		area--;
 		high--;
 		size >>= 1;
+
+		/*
+		 * Add the page to the free list for the "lower" area. The
+		 * high half will be split more if necessary
+		 */
 		list_add(&(page)->list, &(area)->free_list);
 		MARK_USED(index, high, area);
+
+		/* Move to next page index and addres */
 		index += size;
 		page += size;
 	}
@@ -184,6 +277,17 @@
 	return page;
 }

+/**
+ *
+ * rmqueue - Allocate page blocks of 2^order size via the buddy algorithm
+ * @zone: The zone to allocate from
+ * @order: The 2^order sized block to allocate
+ *
+ * This function is responsible for finding out what order of pages we
+ * have to go to to satisfy the request. For example if there is no
+ * page blocks free to satisfy order=0 (1 page), then see if there is
+ * a free block of order=1 that can be spilt into two order=0 pages
+ **/
 static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
 static struct page * rmqueue(zone_t *zone, unsigned int order)
 {
@@ -198,18 +302,26 @@
 		head = &area->free_list;
 		curr = head->next;

+		/*
+		 * If there is a free block of pages at the current order,
+		 * split it up until we get the required order block of pages
+		 * and allocate them
+		 */
 		if (curr != head) {
 			unsigned int index;

+			/* Get the page and then remove from the freelist */
 			page = list_entry(curr, struct page, list);
 			if (BAD_RANGE(zone,page))
 				BUG();
 			list_del(curr);
+
+			/* Toggle the bit representing these buddies */
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
 				MARK_USED(index, curr_order, area);
-			zone->free_pages -= 1UL << order;

+			zone->free_pages -= 1UL << order;
 			page = expand(zone, page, index, order, curr_order, area);
 			spin_unlock_irqrestore(&zone->lock, flags);

@@ -220,10 +332,17 @@
 				BUG();
 			if (PageActive(page))
 				BUG();
+
 			return page;
 		}
+
+		/*
+		 * There isn't pages ready at this order so examine a block of
+		 * higher orders
+		 */
 		curr_order++;
 		area++;
+
 	} while (curr_order < MAX_ORDER);
 	spin_unlock_irqrestore(&zone->lock, flags);

@@ -231,13 +350,40 @@
 }

 #ifndef CONFIG_DISCONTIGMEM
+/**
+ *
+ * _alloc_pages - Find zone to allocate from and call __alloc_pages
+ * @gfp_mask - Flags that determine the behaviour of the allocator
+ * @order - 2^order number of pages will be allocated in a block
+ *
+ * This is called by alloc_pages. It's only task is to identify the
+ * preferred set of zones to allocate from.
+ **/
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
+	/*
+	 * Clear the high bits to see if the allocation is from ZONE_DMA,
+	 * ZONE_NORMAL or ZONE_HIGHMEM
+ 	 */
 	return __alloc_pages(gfp_mask, order,
 		contig_page_data.node_zonelists+(gfp_mask & GFP_ZONEMASK));
 }
 #endif

+/**
+ *
+ * balance_classzone - Free page frames from a zone in a synchronous fashion
+ * @classzone: Zone to free from
+ * @gfp_mask: Flags which determine the behaviour of the allocator
+ * @order: It's a block of 2^order pages the caller is looking for
+ * @freed: Returns the number of total number of pages freed
+ *
+ * In a nutshell, this function does some of the work of kswapd in a synchronous
+ * fashion when there simply is too little memory to be waiting around. The
+ * caller will use this when it needs the memory and is willing to block on
+ * waiting for it.
+ *
+ **/
 static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int, unsigned int, int *));
 static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
@@ -250,6 +396,10 @@
 		BUG();

 	current->allocation_order = order;
+
+	/* These flags are set so that __free_pages_ok knows to return the
+	 * pages directly to the process
+	 */
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;

 	__freed = try_to_free_pages(classzone, gfp_mask, order);
@@ -257,6 +407,7 @@
 	current->flags &= ~(PF_MEMALLOC | PF_FREE_PAGES);

 	if (current->nr_local_pages) {
+		/* If pages were freed */
 		struct list_head * entry, * local_pages;
 		struct page * tmp;
 		int nr_pages;
@@ -264,12 +415,21 @@
 		local_pages = &current->local_pages;

 		if (likely(__freed)) {
-			/* pick from the last inserted so we're lifo */
+			/* pick from the last inserted so we're LIFO */
 			entry = local_pages->next;
 			do {
 				tmp = list_entry(entry, struct page, list);
 				if (tmp->index == order && memclass(page_zone(tmp), classzone)) {
+					/*
+					 * This is a block of pages that is of
+					 * the correct size so remember it
+					 */
 					list_del(entry);
+
+					/*
+					 *QUERY: if order > 0, wouldn't the
+					 * nr_local_pages drop by more than 1?
+					 */
 					current->nr_local_pages--;
 					set_page_count(tmp, 1);
 					page = tmp;
@@ -295,7 +455,10 @@
 		}

 		nr_pages = current->nr_local_pages;
-		/* free in reverse order so that the global order will be lifo */
+		/* free in reverse order so that the global order will be lifo
+		 * The pages freed here are ones not of the order we are
+		 * interested in for the moment
+		 */
 		while ((entry = local_pages->prev) != local_pages) {
 			list_del(entry);
 			tmp = list_entry(entry, struct page, list);
@@ -310,8 +473,27 @@
 	return page;
 }

-/*
+/**
+ *
+ * __alloc_pages - Allocate pages in a block of size 2^order
+ * @gfp_mask: Flags for this allocation that determine behaviour of allocator
+ * @order: 2^order number of pages to allocate
+ * @zonelist: A list of zones to allocate from starting with the preferred one
+ *
  * This is the 'heart' of the zoned buddy allocator:
+ * There is a few paths the this will take to try and allocate the pages.
+ * is takes depends on what pages are available and what flags on gfp_mask
+ * are set. For instance, if the allocation is for an interrupt handler,
+ * __alloc_pages won't do anything that would block. Each block or attempt
+ * made gets progressively slower as the function executes.
+ *
+ * zonelist is the set of zones which determines the order of fallback if
+ * one zone is full. An allocation may be for ZONE_HIGHMEM, but if there
+ * is none available, ZONE_NORMAL may be used or possibly ZONE_DMA. see
+ * build_zonelist() .
+ *
+ * This function should not be called directly. Use either alloc_pages() or
+ * __get_free_pages()
  */
 struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
 {
@@ -320,11 +502,22 @@
 	struct page * page;
 	int freed;

+	/*
+	 * zone is the preferred allocation zone. zone++ is a fallback one
+	 * classzone is the first zone of the list. It's a "special"
+	 *           zone which keeps track of whether the whole needs to be
+	 *           balanced
+	 * class_idx is which zone index within this pg_data_t zone is
+	 */
 	zone = zonelist->zones;
 	classzone = *zone;
 	if (classzone == NULL)
 		return NULL;
 	min = 1UL << order;
+
+	/* Cycle through the zones and their fallbacks. Allocate from the zone
+	 * if the allocation can be made without the low watermark been hit
+	 */
 	for (;;) {
 		zone_t *z = *(zone++);
 		if (!z)
@@ -338,11 +531,21 @@
 		}
 	}

+	/* The watermarks.pages_low has been reached. Mark the zone set
+	 * as needing balancing and wake up kswapd which will start work
+	 * freeing pages in this classzone
+	 */
+
 	classzone->need_balance = 1;
 	mb();
 	if (waitqueue_active(&kswapd_wait))
 		wake_up_interruptible(&kswapd_wait);

+	/* Start again moving through the zones. This time it will allow the
+	 * zone to reach watermarks.min number of free pages. It is hoped that
+	 * kswapd will bring the number of pages above the watermarks again
+	 * later
+	 */
 	zone = zonelist->zones;
 	min = 1UL << order;
 	for (;;) {
@@ -352,9 +555,15 @@
 			break;

 		local_min = z->pages_min;
+
+		/* If the caller can't wait, allow the zone to be pushed into
+		 * a tighter memory position */
 		if (!(gfp_mask & __GFP_WAIT))
 			local_min >>= 2;
+
 		min += local_min;
+
+		/* If we are safe to allocate this, allocate the page */
 		if (z->free_pages > min) {
 			page = rmqueue(z, order);
 			if (page)
@@ -365,6 +574,13 @@
 	/* here we're in the low on memory slow path */

 rebalance:
+	/*
+	 * PF_MEMALLOC if set if the calling process wants to be treated as a
+	 * memory allocator, kswapd for example. This process is high priority
+	 * and should be served if at all possible. in_interrupt() means we
+	 * can't sleep no matter what. This next block will allocate the
+	 * memory no matter  what watermark is hit if possible
+	 */
 	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
 		zone = zonelist->zones;
 		for (;;) {
@@ -383,10 +599,15 @@
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;

+	/* Do the work of kswapd in a synchronous fashion */
 	page = balance_classzone(classzone, gfp_mask, order, &freed);
 	if (page)
 		return page;

+	/*
+	 * pages were freed by balance_classzone but not of the
+	 * proper type. Cycle through in case a higher order was freed
+	 */
 	zone = zonelist->zones;
 	min = 1UL << order;
 	for (;;) {
@@ -413,8 +634,15 @@
 	goto rebalance;
 }

-/*
- * Common helper functions.
+/**
+ *
+ * __get_free_pages - Get a 2^order block of free pages
+ * @gfp_mask: Flags which determine the allocator behaviour
+ * @order: A block sized 2^order will be allocated
+ *
+ * This is the highest level function available for allocating a block of
+ * pages to the caller. Ultimately __alloc_pages() is called to use the
+ * buddy algorithm to retrieve a block of pages
  */
 unsigned long __get_free_pages(unsigned int gfp_mask, unsigned int order)
 {
@@ -423,9 +651,15 @@
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
+
 	return (unsigned long) page_address(page);
 }

+/**
+ *
+ * get_zerod_page - Allocates one page from the buddy allocator and zeros it
+ * @gfp_mask: Flags which determine the allocator behaviour
+ */
 unsigned long get_zeroed_page(unsigned int gfp_mask)
 {
 	struct page * page;
@@ -439,20 +673,43 @@
 	return 0;
 }

+/**
+ *
+ * __free_pages - Sanity check before asking the buddy allocator to take pages
+ * @page: The first page of the block to free
+ * @order: Indicates the block size. size = 2^order
+ */
 void __free_pages(struct page *page, unsigned int order)
 {
+	/* QUERY: __free_pages_ok() does a load of sanity checks at the
+	 *        beginning of the function, would it not make more sense
+	 *        to lump them all together and have one function call?
+	 */
 	if (!PageReserved(page) && put_page_testzero(page))
 		__free_pages_ok(page, order);
 }

+/**
+ *
+ * free_pages - Free pages allocated by the buddy allocator
+ * addr: The address of the pages to free
+ * order: The block size to free
+ *
+ * This is the highest level function available for freeing pages allocated
+ * by the buddy allocator
+ */
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0)
 		__free_pages(virt_to_page(addr), order);
 }

-/*
- * Total amount of free (allocatable) RAM:
+/**
+ *
+ * nr_free_pages - Returns number of free pages in all zones
+ *
+ * This function walks through all zones and sums the free page frames in each
+ * of them.
  */
 unsigned int nr_free_pages (void)
 {
@@ -469,8 +726,12 @@
 	return sum;
 }

-/*
- * Amount of free RAM allocatable as buffer memory:
+/**
+ *
+ * nr_free_buffer_pages - Amount of free RAM allocatable as buffer memory
+ *
+ * This steps through all the zones that are suitable for normal use and
+ * returns back the totals of "size-pages_high".
  */
 unsigned int nr_free_buffer_pages (void)
 {
@@ -496,6 +757,10 @@
 }

 #if CONFIG_HIGHMEM
+/**
+ *
+ * nr_free_highpages - Returns the number of free page frames in high memory
+ */
 unsigned int nr_free_highpages (void)
 {
 	pg_data_t *pgdat = pgdat_list;
@@ -509,6 +774,10 @@
 }
 #endif

+/*
+ * This macro will yield the total amount of RAM in kB
+ * addressed by x number of pages.
+ */
 #define K(x) ((x) << (PAGE_SHIFT-10))

 /*
@@ -526,6 +795,8 @@
 		K(nr_free_pages()),
 		K(nr_free_highpages()));

+	/* Step through all zones in all pgdats and print out the pertinent
+	 * information about them */
 	while (tmpdat) {
 		zone_t *zone;
 		for (zone = tmpdat->node_zones;
@@ -546,6 +817,10 @@
 	       nr_inactive_pages,
 	       nr_free_pages());

+	/* This steps through all the zones a second time and checks how
+	 * many blocks of each 2^order block of pages. This helps determine
+	 * how fragmented memory is
+	 */
 	for (type = 0; type < MAX_NR_ZONES; type++) {
 		struct list_head *head, *curr;
 		zone_t *zone = pgdat->node_zones + type;
@@ -582,7 +857,10 @@
 }

 /*
- * Builds allocation fallback zone lists.
+ * Builds allocation fallback zone lists. This determines what order zones
+ * should be used to take pages from if an allocation fails. For example,
+ * an allocation for HIGHMEM will fall to NORMAL if pages are not available
+ * and in turn fall to DMA.
  */
 static inline void build_zonelists(pg_data_t *pgdat)
 {




