Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSDRXQy>; Thu, 18 Apr 2002 19:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314492AbSDRXQx>; Thu, 18 Apr 2002 19:16:53 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:5649 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S314491AbSDRXQp>;
	Thu, 18 Apr 2002 19:16:45 -0400
Date: Fri, 19 Apr 2002 00:16:37 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-kernel@vger.kernel.org
Subject: page_alloc.c comments patch v2
Message-ID: <Pine.LNX.4.44.0204182332500.5700-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a second cut at commenting on how the buddy algorithm works for
allocating and freeing blocks of pages. No code is changed but queries
about the code are marked "QUERY".

Thanks to the people who sent comments on the first cut effort. I've added
a number of new comments, removed some more obvious ones and all the
comments are less than 80 columns wide.

Andrew, if the commententry is ok, are you still interested in pushing
them to the Higher Powers That Be? I'd greatly appreciate it.

		Mel

--- linux-2.4.19pre7.orig/mm/page_alloc.c	Tue Apr 16 20:36:49 2002
+++ linux-2.4.19pre7.mel/mm/page_alloc.c	Thu Apr 18 23:30:42 2002
@@ -25,11 +25,23 @@
 int nr_swap_pages;
 int nr_active_pages;
 int nr_inactive_pages;
+
+/* The two LRU list. These of primary interest to the page replacement
+ * algorithm. Pages that are referenced often will remain in the active_list.
+ * Pages are moved to the inactive_list by refill_inactive called by kswapd.
+ * Once in the inactive list, the page is a canditate to be swapped out
+ */
 struct list_head inactive_list;
 struct list_head active_list;
+
 pg_data_t *pgdat_list;

-/* Used to look up the address of the struct zone encoded in page->zone */
+/* zone_table is the replacement for page->zone . It's a simple way of
+ * quickly looking up what zone a page belongs so. During init, the upper
+ * most 8 bits of page->flags will be used to store what zone we are in.
+ * See free_area_init_core . The macro page_zone returns the zone a page
+ * belongs to. See linux/include/mm.h
+ */
 zone_t *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
 EXPORT_SYMBOL(zone_table);

@@ -86,8 +98,22 @@
  * storing an extra bit, utilizing entry point information.
  *
  * -- wli
+ *
+ * There is a brief explanation of how a buddy algorithm works at
+ * http://www.memorymanagement.org/articles/alloc.html . A better idea
+ * is to read the explanation from a book like UNIX Internals by
+ * Uresh Vahalia
+ *
  */

+/**
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
@@ -112,36 +138,70 @@
 		BUG();
 	if (PageLocked(page))
 		BUG();
+
+	/* QUERY: The page was released from the cache a few pages above.
+	 *        Presumably, it is a bug if a page is on the LRU while
+	 *        is if been freed because it was up until 2.4.19preX .
+	 *        If it's still a bug, should we call BUG() before calling
+	 *        lru_cache_del?
+	 */
 	if (PageLRU(page))
 		BUG();
 	if (PageActive(page))
 		BUG();
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));

+	/* If it is balance_classzone that is doing the freeing, the pages
+	 * are to be kept for the process doing all the work freeing up pages
+	 */
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
+
  back_local_freelist:

 	zone = page_zone(page);

+	/* Multiple uses for mask which defies a common name
+	 * -mask            == number of pages that will be freed
+	 * page_idx & ~mask == Is page aligned to an order size?
+	 * Also used later to calculate the address of a buddy
+	 */
 	mask = (~0UL) << order;
+
+	/* zone_mem_map first page in the current zone */
 	base = zone->zone_mem_map;
+
+	/* The number page insider the zone_mem_map relative to page size */
 	page_idx = page - base;
+
 	if (page_idx & ~mask)
 		BUG();
-	index = page_idx >> (1 + order);

+	/* index is the number bit inside the free_area_t bitmap stored in
+	 * area->map
+	 */
+	index = page_idx >> (1 + order);
 	area = zone->free_area + order;

 	spin_lock_irqsave(&zone->lock, flags);

 	zone->free_pages -= mask;

+	/* No matter what order the function started out as, this expression
+	 * will result in 0 when the mask would reach the max order
+	 */
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;

+		/* QUERY: This could only be true if order was originally set
+		 *        to be a value greater than MAX_ORDER, should the
+		 *        sanity check not be made at the beginning of the
+		 *        function and then removed from here?
+		 */
 		if (area >= zone->free_area + MAX_ORDER)
 			BUG();
+
+		/* QUERY: Can someone explain this to me? */
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -151,6 +211,9 @@
 		 * Move the buddy up one level.
 		 * This code is taking advantage of the identity:
 		 * 	-mask = 1+~mask
+		 *
+		 * remember page_idx is the address index relative to the
+		 * beginning of the zone
 		 */
 		buddy1 = base + (page_idx ^ -mask);
 		buddy2 = base + page_idx;
@@ -159,7 +222,10 @@
 		if (BAD_RANGE(zone,buddy2))
 			BUG();

+		/* buddy2 has already been freed */
 		memlist_del(&buddy1->list);
+
+		/* Prepare to try and merge the higher order buddies */
 		mask <<= 1;
 		area++;
 		index >>= 1;
@@ -171,11 +237,22 @@
 	return;

  local_freelist:
+	/* If the process has already freed pages for itself, don't give it
+	 * more */
 	if (current->nr_local_pages)
 		goto back_local_freelist;
+
+	/* An interrupt doesn't have a current process to store pages on.
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
@@ -184,19 +261,50 @@
 #define MARK_USED(index, order, area) \
 	__change_bit((index) >> (1+(order)), (area)->map)

+/* expand - Break up higher order pages until the right size block is available
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
+
+		/* Mark that we are moving to the next area after we are
+		 * finished shuffling the free order lists
+		 */
 		area--;
 		high--;
+
+		/* Size is now half as big because the order dropped by 1 */
 		size >>= 1;
+
+		/* Add the page to the free list for the "lower" area. The
+		 * high half will be split more if necessary
+		 */
 		memlist_add_head(&(page)->list, &(area)->free_list);
 		MARK_USED(index, high, area);
+
+		/* index is the page number inside this zone
+		 * page is the actual address
+		 */
 		index += size;
 		page += size;
 	}
@@ -205,9 +313,26 @@
 	return page;
 }

+/* rmqueue - Allocate page blocks of 2^order size via the buddy algorithm
+ * @zone: The zone to allocate from
+ * @order: The 2^order sized block to allocate
+ *
+ * This function is responsible for finding out what order of pages we
+ * have to go to to satisify the request. For example if there is no
+ * page blocks free to satisy order=0 (1 page), then see if there is
+ * a free block of order=1 that can be spilt into two order=0 pages
+ **/
 static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
 static struct page * rmqueue(zone_t *zone, unsigned int order)
 {
+	/* A free_area_t exists for each order of pages that can be allocated.
+	 * The struct stores a list of page blocks that can be allocated and
+	 * the bitmap the describes if the buddy is allocated or not.
+	 *
+	 * Here area is set to the free_area_t that represents this order of
+	 * pages.  If necessary, the next higher order of free blocks will be
+	 * examined.
+	 */
 	free_area_t * area = zone->free_area + order;
 	unsigned int curr_order = order;
 	struct list_head *head, *curr;
@@ -216,24 +341,48 @@

 	spin_lock_irqsave(&zone->lock, flags);
 	do {
+		/* Get the first block of pages free in this area */
 		head = &area->free_list;
 		curr = memlist_next(head);

+		/* If there is a free block available, split it up until
+		 * we get the order we want and allocate it
+		 */
 		if (curr != head) {
 			unsigned int index;

+			/* Get the page for this block */
 			page = memlist_entry(curr, struct page, list);
 			if (BAD_RANGE(zone,page))
 				BUG();
+
+			/* It is no longer free for this block so remove it from
+			 * the list
+			 */
 			memlist_del(curr);
+
+			/* zone_mem_map is the first page in this zone block so
+			 * subtracting them will give us which index this page
+			 * in the zone is. MARK_USED will give what bit number
+			 * in the map it is
+			 */
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
 				MARK_USED(index, curr_order, area);
+
+			/* Remove from the count the number of pages that is
+			 * been split or assigned.
+			 */
 			zone->free_pages -= 1UL << order;

+			/* expand is responsible for splitting blocks of higher
+			 * orders (if necessary) until we get a block of the
+			 * order we are interested in.
+			 */
 			page = expand(zone, page, index, order, curr_order, area);
 			spin_unlock_irqrestore(&zone->lock, flags);

+			/* Mark the page as used and do some checks */
 			set_page_count(page, 1);
 			if (BAD_RANGE(zone,page))
 				BUG();
@@ -241,10 +390,16 @@
 				BUG();
 			if (PageActive(page))
 				BUG();
+
 			return page;
 		}
+
+		/* There isn't pages ready at this order so examine a block of
+		 * higher orders
+		 */
 		curr_order++;
 		area++;
+
 	} while (curr_order < MAX_ORDER);
 	spin_unlock_irqrestore(&zone->lock, flags);

@@ -252,13 +407,37 @@
 }

 #ifndef CONFIG_DISCONTIGMEM
+/* _alloc_pages - Find zone to allocate from and call __alloc_pages
+ * @gfp_mask - Flags that determine the behaviour of the allocator
+ * @order - 2^order number of pages will be allocated in a block
+ *
+ * This is called by alloc_pages. It's only task is to identify the
+ * preferred set of zones to allocate from.
+ **/
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
+	/* The zones currently are
+ 	* ZONE_DMA, ZONE_NORMAL and ZONE_HIGHMEM. The index to allocate
+ 	* from is stored in the lower bits of flag. GFP_ZONEMASK clears
+ 	* the higher bits
+ 	*
+ 	*/
 	return __alloc_pages(gfp_mask, order,
 		contig_page_data.node_zonelists+(gfp_mask & GFP_ZONEMASK));
 }
 #endif

+/* balance_classzone - Free page frames from a zone in a synchronous fashion
+ * @classzone: Zone to free from
+ * @gfp_mask: Flags which determine the behaviour of the allocator
+ * @order: It's a block of 2^order pages the caller is looking for
+ * @freed: Returns the number of total number of pages freed
+ *
+ * In a nutshell, this function does some of the work of kswapd in a synchrous
+ * fashion when there simply is too little memory to be waiting around. The
+ * caller will use this when it needs the memory and is willing to block on
+ * waiting for it.
+ **/
 static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int, unsigned int, int *));
 static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
@@ -271,6 +450,10 @@
 		BUG();

 	current->allocation_order = order;
+
+	/* These flags are set so that __free_pages_ok knows to return the
+	 * pages directly to the process
+	 */
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;

 	__freed = try_to_free_pages(classzone, gfp_mask, order);
@@ -278,6 +461,7 @@
 	current->flags &= ~(PF_MEMALLOC | PF_FREE_PAGES);

 	if (current->nr_local_pages) {
+		/* If pages were freed */
 		struct list_head * entry, * local_pages;
 		struct page * tmp;
 		int nr_pages;
@@ -290,7 +474,14 @@
 			do {
 				tmp = list_entry(entry, struct page, list);
 				if (tmp->index == order && memclass(page_zone(tmp), classzone)) {
+					/* This is a block of pages that is of
+					 * the correct size so remember it
+					 */
 					list_del(entry);
+
+					/* QUERY: if order > 0, wouldn't the
+					 * nr_local_pages drop by more than 1?
+					 */
 					current->nr_local_pages--;
 					set_page_count(tmp, 1);
 					page = tmp;
@@ -318,7 +509,10 @@
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
@@ -333,8 +527,21 @@
 	return page;
 }

-/*
+/**
+ * __alloc_pages - Allocate pages in a block of size 2^order
+ * @gfp_mask: Flags for this allocation that determine behaviour of allocator
+ * @order: 2^order number of pages to allocate
+ * @zonelist: The preferred zone to allocate from
+ *
  * This is the 'heart' of the zoned buddy allocator:
+ * There is a few paths the this will take to try and allocate the pages.
+ * is takes depends on what pages are available and what flags on gfp_mask
+ * are set. For instance, if the allocation is for an interrupt handler,
+ * __alloc_pages won't do anything that would block. Each block or attempt
+ * made gets progressively slower as the function executes.
+ *
+ * This function should not be called directly. Use either alloc_pages() or
+ * __get_free_pages()
  */
 struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
 {
@@ -343,15 +550,41 @@
 	struct page * page;
 	int freed;

+	/* zonelist is the set of zones for either ZONE_DMA, ZONE_NORMAL
+	 * or ZONE_HIGHMEM. zone is the subset of zones inside them three
+	 * groups
+	 */
 	zone = zonelist->zones;
+
+	/* classzone is the first zone of the list. It's a "special"
+	 * zone which keeps track of whether the whole needs to be balanced or
+	 * something
+	 */
 	classzone = *zone;
+
+	/* min is the number of pages that have to be allocated */
 	min = 1UL << order;
+
+	/* Cycle through all the zones available */
 	for (;;) {
 		zone_t *z = *(zone++);
 		if (!z)
 			break;

+		/* Increase min by pages_low so that too many pages from a zone
+		 * are not allocated. If pages_low is reached, kswapd needs to
+		 * begin work
+		 *
+		 * QUERY: If there was more than one zone in ZONE_NORMAL and
+		 *        each zone had a pages_low value of 10, wouldn't the
+		 *        second zone have a min value of 20, the third of 30
+		 *        and so on? Wouldn't this possibly wake kswapd before
+		 *        it was really needed? Is this the expected behaviour?
+		 */
 		min += z->pages_low;
+
+		/* There is enough pages, allocate it (rmqueue) and return the
+		 * page */
 		if (z->free_pages > min) {
 			page = rmqueue(z, order);
 			if (page)
@@ -359,11 +592,19 @@
 		}
 	}

+	/* pages_low has been reached. Mark the zone set as needing balancing
+	 * and wake up kswapd which will start work freeing pages in this zone
+	 */
 	classzone->need_balance = 1;
 	mb();
 	if (waitqueue_active(&kswapd_wait))
 		wake_up_interruptible(&kswapd_wait);

+	/* Start again moving through the zones. This time it will allow the
+	 * zone to reach pages_min number of free pages. It is hoped that
+	 * kswapd will bring the number of pages above the watermarks again
+	 * later
+	 */
 	zone = zonelist->zones;
 	min = 1UL << order;
 	for (;;) {
@@ -373,9 +614,20 @@
 			break;

 		local_min = z->pages_min;
+
+		/* If the process requesting this cannot discard other pages or
+		 * wait, allow the zone to be pushed into a tigher memory
+		 * position.
+		 */
 		if (!(gfp_mask & __GFP_WAIT))
 			local_min >>= 2;
+
+		/* QUERY: same as above, does it not artifically inflate min
+		 *        depending on the number of zones there is?
+		 */
 		min += local_min;
+
+		/* If we are safe to allocate this, allocate the page */
 		if (z->free_pages > min) {
 			page = rmqueue(z, order);
 			if (page)
@@ -387,7 +639,18 @@

 rebalance:
 	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
+		/* PF_MEMALLOC if set if the calling process wants to be
+		 * treated as a memory allocator, kswapd for example. This
+		 * process is high priority and should be served if at
+		 * all possible.  PF_MEMDIE is set by the OOM killer. The
+		 * calling process is going to die no matter what but
+		 * needs a bit of memory to die cleanly, hence give what
+		 * it needs because we'll get it back soon.  */
+
 		zone = zonelist->zones;
+
+		/* Cycle through the zones and try to allocate if at all
+		 * possible */
 		for (;;) {
 			zone_t *z = *(zone++);
 			if (!z)
@@ -404,10 +667,17 @@
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;

+	/* Basically do the work of kswapd in a synchronous fashion and return
+	 * a block of pages of the right order if one was found
+	 */
 	page = balance_classzone(classzone, gfp_mask, order, &freed);
 	if (page)
 		return page;

+	/* if balance_classzone returned no pages, it might be because the
+	 * pages it freed up were of a higher or lower order than the one we
+	 * were interested in, so search though all the zones again
+	 */
 	zone = zonelist->zones;
 	min = 1UL << order;
 	for (;;) {
@@ -434,8 +704,14 @@
 	goto rebalance;
 }

-/*
- * Common helper functions.
+/**
+ * __get_free_pages - Get a 2^order block of free pages
+ * @gfp_mask: Flags which determine the allocator behaviour
+ * @order: A block sized 2^order will be allocated
+ *
+ * This is the highest level function available for allocating a block of
+ * pages to the caller. Ultimatly __alloc_pages() is called to use the
+ * buddy algorithm to retrieve a block of pages
  */
 unsigned long __get_free_pages(unsigned int gfp_mask, unsigned int order)
 {
@@ -444,9 +720,17 @@
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
+
+	/* Return the linear address of the page. Presumably the caller
+	 * is not interested in the struct page
+	 */
 	return (unsigned long) page_address(page);
 }

+/**
+ * get_zerod_page - Allocates one page from the buddy allocator and zeros it
+ * @gfp_mask: Flags which determine the allocator behaviour
+ */
 unsigned long get_zeroed_page(unsigned int gfp_mask)
 {
 	struct page * page;
@@ -460,20 +744,39 @@
 	return 0;
 }

+/* __free_pages - Sanity check before asking the buddy allocator to take pages
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
+ * nr_free_pages - Returns number of free pages in all zones
+ *
+ * This function walks through all zones and sums the free page frames in each
+ * of them.
  */
 unsigned int nr_free_pages (void)
 {
@@ -490,8 +793,11 @@
 	return sum;
 }

-/*
- * Amount of free RAM allocatable as buffer memory:
+/**
+ * nr_free_buffer_pages - Amount of free RAM allocatable as buffer memory
+ *
+ * This steps through all the zones that are suitable for normal use and
+ * returns back the totals of "size-pages_high".
  */
 unsigned int nr_free_buffer_pages (void)
 {
@@ -517,6 +823,9 @@
 }

 #if CONFIG_HIGHMEM
+/**
+ * nr_free_highpages - Returns the number of free page frames in high memory
+ */
 unsigned int nr_free_highpages (void)
 {
 	pg_data_t *pgdat = pgdat_list;
@@ -530,6 +839,9 @@
 }
 #endif

+/* This macro will yield the total amount of RAM in kB
+ * addrssed by x number of pages.
+ */
 #define K(x) ((x) << (PAGE_SHIFT-10))

 /*
@@ -547,6 +859,8 @@
 		K(nr_free_pages()),
 		K(nr_free_highpages()));

+	/* Step through all zones in all pgdats and print out the pertinent
+	 * information about them */
 	while (tmpdat) {
 		zone_t *zone;
 		for (zone = tmpdat->node_zones;
@@ -567,6 +881,10 @@
 	       nr_inactive_pages,
 	       nr_free_pages());

+	/* This steps through all the zones a second time and checks how
+	 * many blocks of each 2^order block of pages. This helps determine
+	 * how fragmented memory is
+	 */
 	for (type = 0; type < MAX_NR_ZONES; type++) {
 		struct list_head *head, *curr;
 		zone_t *zone = pgdat->node_zones + type;
@@ -604,7 +922,10 @@
 }

 /*
- * Builds allocation fallback zone lists.
+ * Builds allocation fallback zone lists. This determines what order zones
+ * should be used to take pags from if an allocation fails. For example,
+ * an allocation for HIGHMEM will fall to NORMAL if pages are not available
+ * and in turn fall to DMA.
  */
 static inline void build_zonelists(pg_data_t *pgdat)
 {

