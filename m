Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314223AbSDRC0N>; Wed, 17 Apr 2002 22:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314224AbSDRC0M>; Wed, 17 Apr 2002 22:26:12 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:24840 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S314223AbSDRC0I>;
	Wed, 17 Apr 2002 22:26:08 -0400
Date: Thu, 18 Apr 2002 03:26:00 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-kernel@vger.kernel.org
Subject: page_alloc.c comments patch
Message-ID: <Pine.LNX.4.44.0204180306050.4760-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is a first cut effort at commenting how the buddy algorithm
works for allocating and freeing blocks of pages. No code is changed so
the impact is minimal to put it mildly

Just a few things;

1. Are patches of this type welcome? i.e. don't change any code but try to
   document how it works. If they are welcome, is there anything about the
   style I should bear in mind before continuing on with what will cover
   most of the VM eventually?

2. I have marked some parts with a QUERY: which are questions I had such
   as asking if a particular part was dead code. I'd appreciate if
   someone could take a look at them.

Thanks

Mel Gorman




--- linux-2.4.19pre7.orig/mm/page_alloc.c	Tue Apr 16 20:36:49 2002
+++ linux-2.4.19pre7.mel/mm/page_alloc.c	Thu Apr 18 03:01:34 2002
@@ -29,7 +29,8 @@
 struct list_head active_list;
 pg_data_t *pgdat_list;

-/* Used to look up the address of the struct zone encoded in page->zone */
+/* Used to look up the address of the struct zone previously encoded in
+ * page->zone */
 zone_t *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
 EXPORT_SYMBOL(zone_table);

@@ -86,8 +87,17 @@
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

+/* This function returns the pages allocated by __alloc_pages and tries to merge
+ * buddies if possible
+ */
 static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
 static void __free_pages_ok (struct page *page, unsigned int order)
 {
@@ -98,6 +108,10 @@

 	/* Yes, think what happens when other parts of the kernel take
 	 * a reference to a page in order to pin it for io. -ben
+	 *
+	 * QUERY: Out of curiousity, why would a page allocated by the buddy
+	 * algorithm be on a LRU list if kernel pages are not meant to be swapped
+	 * out? Pretty serious bug no? --mel
 	 */
 	if (PageLRU(page))
 		lru_cache_del(page);
@@ -118,30 +132,56 @@
 		BUG();
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));

+	/* If it is balance_classzone that is doing the freeing, the pages are to
+	 * be kept for the process doing all the work freeing up pages
+	 */
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
+
  back_local_freelist:

+	/* page_zone returns back what zone a page belongs to */
 	zone = page_zone(page);

+	/* Multiple uses of which one is
+	 * -mask == number of pages that will be freed
+	 */
 	mask = (~0UL) << order;
+
+	/* base is the first page in the current zone */
 	base = zone->zone_mem_map;
+
+	/* The number page insider the zone_mem_map relative to page size */
 	page_idx = page - base;
+
+	/* If the page is not aligned to the order size, it's a bug */
 	if (page_idx & ~mask)
 		BUG();
-	index = page_idx >> (1 + order);

+	/* index is the number bit inside the free_area_t bitmap stored in
+	 * area->map
+	 */
+	index = page_idx >> (1 + order);
 	area = zone->free_area + order;

 	spin_lock_irqsave(&zone->lock, flags);

+	/* -mask == number of pages been freed */
 	zone->free_pages -= mask;

+	/* No matter what order the function started out as, this expression
+	 * will result in 0 when the mask would reach the max order
+	 */
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;

+		/* QUERY: Bogus check, doesn't the condition loop check
+		 *        for this?
+		 */
 		if (area >= zone->free_area + MAX_ORDER)
 			BUG();
+
+		/* QUERY: Can someone explain this to me? */
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -151,6 +191,9 @@
 		 * Move the buddy up one level.
 		 * This code is taking advantage of the identity:
 		 * 	-mask = 1+~mask
+		 *
+		 * remember page_idx is the address index relative to the
+		 * beginning of the zone
 		 */
 		buddy1 = base + (page_idx ^ -mask);
 		buddy2 = base + page_idx;
@@ -159,7 +202,10 @@
 		if (BAD_RANGE(zone,buddy2))
 			BUG();

+		/* buddy2 has already been freed */
 		memlist_del(&buddy1->list);
+
+		/* Prepare to try and merge the higher order buddies */
 		mask <<= 1;
 		area++;
 		index >>= 1;
@@ -171,11 +217,22 @@
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
@@ -184,19 +241,46 @@
 #define MARK_USED(index, order, area) \
 	__change_bit((index) >> (1+(order)), (area)->map)

+/* expand - Shuffle pages around the free lists
+ *
+ * This function will break up higher orders of pages necessary and update the
+ * bitmaps as it goes along
+ */
 static inline struct page * expand (zone_t *zone, struct page *page,
 	 unsigned long index, int low, int high, free_area_t * area)
 {
 	unsigned long size = 1 << high;

+	/* low is the original order requested
+	 * high is where we had to start to get a free block
+	 *
+	 * If it turned out there was a free block at the right order to begin
+	 * with, no splitting will take place
+	 */
 	while (high > low) {
 		if (BAD_RANGE(zone,page))
 			BUG();
+
+		/* Mark that we are moving to the next area after we are finished
+		 * shuffling the free order lists
+		 */
 		area--;
 		high--;
+
+		/* Size is now half as big because the order dropped by 1 */
 		size >>= 1;
+
+		/* Add the page to the free list for the "lower" area
+		 * note that the lower buddy is put on the free list and the
+		 * higher buddy is considered for allocation, or splitting
+		 * more if necessary
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
@@ -205,9 +289,23 @@
 	return page;
 }

+/* rmqueue - Allocate pages for the Buddy Allocator
+ *
+ * This function is responsible for finding out what order of pages we
+ * have to go to to satisify the request. For example if there is no
+ * page blocks free to satisy order=0 (1 page), then see if there is
+ * a free block of order=1 that can be spilt into two order=0 pages
+ */
 static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
 static struct page * rmqueue(zone_t *zone, unsigned int order)
 {
+	/* A free_area_t exists for each order of pages that can be allocated.
+	 * The struct stores a list of page blocks that can be allocated and
+	 * the bitmap the describes if the buddy is allocated or not.
+	 *
+	 * Here area is set to the free_area_t that represents this order of pages.
+	 * If necessary, the next higher order of free blocks will be examined.
+	 */
 	free_area_t * area = zone->free_area + order;
 	unsigned int curr_order = order;
 	struct list_head *head, *curr;
@@ -216,24 +314,48 @@

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
+			 * subtracting them will give us which index this page in
+			 * the zone is. MARK_USED will give what bit number in
+			 * the map it is
+			 */
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
 				MARK_USED(index, curr_order, area);
+
+			/* Remove from the count the number of pages that is been
+			 * split or assigned.
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
@@ -241,10 +363,16 @@
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

@@ -252,6 +380,15 @@
 }

 #ifndef CONFIG_DISCONTIGMEM
+/* _alloc_pages - Allocate a contiguous block of pages
+ * @gfp_mask - Flags that determine the behaviour of the allocator
+ * @order - 2^order number of pages will be allocated in a block
+ *
+ * This is called directly by alloc_pages. It's only task is to identify the
+ * preferred set of zones to allocate from. The zones currently are
+ * ZONE_DMA, ZONE_NORMAL and ZONE_HIGHMEM
+ *
+ */
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
 	return __alloc_pages(gfp_mask, order,
@@ -259,6 +396,9 @@
 }
 #endif

+/* In a nutshell, this function does some of the work of kswapd in a synchrous
+ * fashion when there simply is too little memory to be waiting around
+ */
 static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int, unsigned int, int *));
 static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
@@ -271,6 +411,10 @@
 		BUG();

 	current->allocation_order = order;
+
+	/* These flags are set so that __free_pages_ok knows to return the
+	 * pages directly to the process
+	 */
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;

 	__freed = try_to_free_pages(classzone, gfp_mask, order);
@@ -278,6 +422,7 @@
 	current->flags &= ~(PF_MEMALLOC | PF_FREE_PAGES);

 	if (current->nr_local_pages) {
+		/* If pages were freed */
 		struct list_head * entry, * local_pages;
 		struct page * tmp;
 		int nr_pages;
@@ -290,7 +435,14 @@
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
@@ -318,7 +470,10 @@
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
@@ -333,8 +488,19 @@
 	return page;
 }

-/*
+/* __alloc_pages - Allocate pages in a block
+ * @gfp_mask - Flags for this allocation
+ * @order - 2^order number of pages to allocate
+ * @zonelist - The preferred zone to allocate from
+ *
  * This is the 'heart' of the zoned buddy allocator:
+ *
+ * There is a few paths the this will take to try and allocate the pages. Which is
+ * takes depends on what pages are available and what flags on gfp_mask are set.
+ * For instance, if the allocation is for an interrupt handler, __alloc_pages
+ * won't do anything that would block. Each block or attempt made gets progressively
+ * slower as the function executes.
+ *
  */
 struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
 {
@@ -343,15 +509,40 @@
 	struct page * page;
 	int freed;

+	/* zonelist is the set of zones for either ZONE_DMA, ZONE_NORMAL
+	 * or ZONE_HIGHMEM. zone is the subset of zones inside them three groups
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
+		 * QUERY: If there was more than one zone in ZONE_NORMAL and each
+		 *        zone had a pages_low value of 10, wouldn't the second
+		 *        zone have a min value of 20, the third of 30 and so on?
+		 *        Wouldn't this possibly wake kswapd before it was really
+		 *        needed? Is this the expected behaviour?
+		 */
 		min += z->pages_low;
+
+		/* There is enough pages, allocate it (rmqueue) and return the
+		 * page */
 		if (z->free_pages > min) {
 			page = rmqueue(z, order);
 			if (page)
@@ -359,11 +550,18 @@
 		}
 	}

+	/* pages_low has been reached. Mark the zone set as needing balancing and
+	 * wake up kswapd which will start work freeing pages in this zone
+	 */
 	classzone->need_balance = 1;
 	mb();
 	if (waitqueue_active(&kswapd_wait))
 		wake_up_interruptible(&kswapd_wait);

+	/* Start again moving through the zones. This time it will allow the zone
+	 * to reach pages_min number of free pages. It is hoped that kswapd will
+	 * bring the number of pages above the watermarks again later
+	 */
 	zone = zonelist->zones;
 	min = 1UL << order;
 	for (;;) {
@@ -373,9 +571,19 @@
 			break;

 		local_min = z->pages_min;
+
+		/* If the process requesting this cannot discard other pages or
+		 * wait, allow the zone to be pushed into a tigher memory position.
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
@@ -387,7 +595,17 @@

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
+		/* Cycle through the zones and try to allocate if at all possible */
 		for (;;) {
 			zone_t *z = *(zone++);
 			if (!z)
@@ -404,10 +622,17 @@
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;

+	/* Basically do the work of kswapd in a synchronous fashion and return
+	 * the pages if enough were freed
+	 */
 	page = balance_classzone(classzone, gfp_mask, order, &freed);
 	if (page)
 		return page;

+	/* if balance_classzone returned no pages, it might be because the
+	 * pages it freed up were of a higher or lower order than the one we
+	 * were interested in, so search though all the zones one last time
+	 */
 	zone = zonelist->zones;
 	min = 1UL << order;
 	for (;;) {

