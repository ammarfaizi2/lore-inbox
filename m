Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030646AbWHIKQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030646AbWHIKQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030647AbWHIKQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:16:52 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:27870 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030641AbWHIKQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:16:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Date: Wed, 9 Aug 2006 11:58:38 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl>
In-Reply-To: <200608091152.49094.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091158.38458.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the memory bitmap data structure and make swsusp use in the suspend
phase.

The current swsusp's internal data structure is not very efficient from the
memory usage point of view, so it seems reasonable to replace it with a data
structure that will require less memory, such as a pair of bitmaps.

The idea is to use bitmaps that may be allocated as sets of individual pages,
so that we can avoid making allocations of order greater than 0.  For this
reason the memory bitmap structure consists of several linked lists of objects
that contain pointers to memory pages with the actual bitmap data.  Still, for
a typical system all of these lists fit in a single page, so it's reasonable
to introduce an additional mechanism allowing us to allocate all of them
efficiently without sacrificing the generality of the design.  This is done
with the help of the chain_allocator structure and associated functions.

We need to use two memory bitmaps during the suspend phase of the
suspend-resume cycle.  One of them is necessary for marking the saveable
pages, and the second is used to mark the pages in which to store the copies
of them (aka image pages).

First, the bitmaps are created and we allocate as many image pages as needed
(the corresponding bits in the second bitmap are set as soon as the pages are
allocated).  Second, the bits corresponding to the saveable pages are set in
the first bitmap and the saveable pages are copied to the image pages.
Finally, the first bitmap is used to save the kernel virtual addresses of the
saveable pages and the second one is used to save the contents of the image
pages.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/power.h    |    3 
 kernel/power/snapshot.c |  605 ++++++++++++++++++++++++++++++++++++++++++------
 kernel/power/swsusp.c   |    5 
 3 files changed, 542 insertions(+), 71 deletions(-)

Index: linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/snapshot.c
+++ linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
@@ -204,6 +204,467 @@ static inline void free_image_page(void 
 	free_page((unsigned long)addr);
 }
 
+/* struct linked_page is used to build chains of pages */
+
+#define LINKED_PAGE_DATA_SIZE	(PAGE_SIZE - sizeof(void *))
+
+struct linked_page {
+	struct linked_page *next;
+	char data[LINKED_PAGE_DATA_SIZE];
+} __attribute__((packed));
+
+static inline void
+free_list_of_pages(struct linked_page *list, int clear_page_nosave)
+{
+	while (list) {
+		struct linked_page *lp = list->next;
+
+		free_image_page(list, clear_page_nosave);
+		list = lp;
+	}
+}
+
+/**
+  *	struct chain_allocator is used for allocating small objects out of
+  *	a linked list of pages called 'the chain'.
+  *
+  *	The chain grows each time when there is no room for a new object in
+  *	the current page.  The allocated objects cannot be freed individually.
+  *	It is only possible to free them all at once, by freeing the entire
+  *	chain.
+  *
+  *	NOTE: The chain allocator may be inefficient if the allocated objects
+  *	are not much smaller than PAGE_SIZE.
+  */
+
+struct chain_allocator {
+	struct linked_page *chain;	/* the chain */
+	unsigned int used_space;	/* total size of objects allocated out
+					 * of the current page
+					 */
+	gfp_t gfp_mask;		/* mask for allocating pages */
+	int safe_needed;	/* if set, only "safe" pages are allocated */
+};
+
+static void
+chain_init(struct chain_allocator *ca, gfp_t gfp_mask, int safe_needed)
+{
+	ca->chain = NULL;
+	ca->used_space = LINKED_PAGE_DATA_SIZE;
+	ca->gfp_mask = gfp_mask;
+	ca->safe_needed = safe_needed;
+}
+
+static void *chain_alloc(struct chain_allocator *ca, unsigned int size)
+{
+	void *ret;
+
+	if (LINKED_PAGE_DATA_SIZE - ca->used_space < size) {
+		struct linked_page *lp;
+
+		lp = alloc_image_page(ca->gfp_mask, ca->safe_needed);
+		if (!lp)
+			return NULL;
+
+		lp->next = ca->chain;
+		ca->chain = lp;
+		ca->used_space = 0;
+	}
+	ret = ca->chain->data + ca->used_space;
+	ca->used_space += size;
+	return ret;
+}
+
+static void chain_free(struct chain_allocator *ca, int clear_page_nosave)
+{
+	free_list_of_pages(ca->chain, clear_page_nosave);
+	memset(ca, 0, sizeof(struct chain_allocator));
+}
+
+/**
+ *	Data types related to memory bitmaps.
+ *
+ *	Memory bitmap is a structure consiting of many linked lists of
+ *	objects.  The main list's elements are of type struct zone_bitmap
+ *	and each of them corresonds to one zone.  For each zone bitmap
+ *	object there is a list of objects of type struct bm_block that
+ *	represent each blocks of bit chunks in which information is
+ *	stored.
+ *
+ *	struct memory_bitmap contains a pointer to the main list of zone
+ *	bitmap objects, a struct bm_position used for browsing the bitmap,
+ *	and a pointer to the list of pages used for allocating all of the
+ *	zone bitmap objects and bitmap block objects.
+ *
+ *	NOTE: It has to be possible to lay out the bitmap in memory
+ *	using only allocations of order 0.  Additionally, the bitmap is
+ *	designed to work with arbitrary number of zones (this is over the
+ *	top for now, but let's avoid making unnecessary assumptions ;-).
+ *
+ *	struct zone_bitmap contains a pointer to a list of bitmap block
+ *	objects and a pointer to the bitmap block object that has been
+ *	most recently used for setting bits.  Additionally, it contains the
+ *	pfns that correspond to the start and end of the represented zone.
+ *
+ *	struct bm_block contains a pointer to the memory page in which
+ *	information is stored (in the form of a block of bit chunks
+ *	of type unsigned long each).  It also contains the pfns that
+ *	correspond to the start and end of the represented memory area and
+ *	the number of bit chunks in the block.
+ *
+ *	NOTE: Memory bitmaps are used for two types of operations only:
+ *	"set a bit" and "find the next bit set".  Moreover, the searching
+ *	is always carried out after all of the "set a bit" operations
+ *	on given bitmap.
+ */
+
+#define BM_END_OF_MAP	(~0UL)
+
+#define BM_CHUNKS_PER_BLOCK	(PAGE_SIZE / sizeof(long))
+#define BM_BITS_PER_CHUNK	(sizeof(long) << 3)
+#define BM_BITS_PER_BLOCK	(PAGE_SIZE << 3)
+
+struct bm_block {
+	struct bm_block *next;		/* next element of the list */
+	unsigned long start_pfn;	/* pfn represented by the first bit */
+	unsigned long end_pfn;	/* pfn represented by the last bit plus 1 */
+	unsigned int size;	/* number of bit chunks */
+	unsigned long *data;	/* chunks of bits representing pages */
+};
+
+struct zone_bitmap {
+	struct zone_bitmap *next;	/* next element of the list */
+	unsigned long start_pfn;	/* minimal pfn in this zone */
+	unsigned long end_pfn;		/* maximal pfn in this zone plus 1 */
+	struct bm_block *bm_blocks;	/* list of bitmap blocks */
+	struct bm_block *cur_block;	/* recently used bitmap block */
+};
+
+/* strcut bm_position is used for browsing memory bitmaps */
+
+struct bm_position {
+	struct zone_bitmap *zone_bm;
+	struct bm_block *block;
+	int chunk;
+	int bit;
+};
+
+struct memory_bitmap {
+	struct zone_bitmap *zone_bm_list;	/* list of zone bitmaps */
+	struct linked_page *p_list;	/* list of pages used to store zone
+					 * bitmap objects and bitmap block
+					 * objects
+					 */
+	struct bm_position cur;	/* most recently used bit position */
+};
+
+/* Functions that operate on memory bitmaps */
+
+static inline void bm_position_reset_chunk(struct memory_bitmap *bm)
+{
+	bm->cur.chunk = 0;
+	bm->cur.bit = -1;
+}
+
+static void bm_position_reset(struct memory_bitmap *bm)
+{
+	struct zone_bitmap *zone_bm;
+
+	zone_bm = bm->zone_bm_list;
+	bm->cur.zone_bm = zone_bm;
+	bm->cur.block = zone_bm->bm_blocks;
+	bm_position_reset_chunk(bm);
+}
+
+static void free_memory_bm(struct memory_bitmap *bm, int clear_nosave_free);
+
+/**
+ *	create_bm_block_list - create a list of block bitmap objects
+ */
+
+static inline struct bm_block *
+create_bm_block_list(unsigned int nr_blocks, struct chain_allocator *ca)
+{
+	struct bm_block *bblist = NULL;
+
+	while (nr_blocks-- > 0) {
+		struct bm_block *bb;
+
+		bb = chain_alloc(ca, sizeof(struct bm_block));
+		if (!bb)
+			return NULL;
+
+		bb->next = bblist;
+		bblist = bb;
+	}
+	return bblist;
+}
+
+/**
+ *	create_zone_bm_list - create a list of zone bitmap objects
+ */
+
+static inline struct zone_bitmap *
+create_zone_bm_list(unsigned int nr_zones, struct chain_allocator *ca)
+{
+	struct zone_bitmap *zbmlist = NULL;
+
+	while (nr_zones-- > 0) {
+		struct zone_bitmap *zbm;
+
+		zbm = chain_alloc(ca, sizeof(struct zone_bitmap));
+		if (!zbm)
+			return NULL;
+
+		zbm->next = zbmlist;
+		zbmlist = zbm;
+	}
+	return zbmlist;
+}
+
+/**
+  *	create_memory_bm - allocate memory for a memory bitmap
+  */
+
+static int
+create_memory_bm(struct memory_bitmap *bm, gfp_t gfp_mask, int safe_needed)
+{
+	struct chain_allocator ca;
+	struct zone *zone;
+	struct zone_bitmap *zone_bm;
+	struct bm_block *bb;
+	unsigned int nr;
+
+	chain_init(&ca, gfp_mask, safe_needed);
+
+	/* Compute the number of zones */
+	nr = 0;
+	for_each_zone (zone)
+		if (populated_zone(zone) && !is_highmem(zone))
+			nr++;
+
+	/* Allocate the list of zones bitmap objects */
+	zone_bm = create_zone_bm_list(nr, &ca);
+	bm->zone_bm_list = zone_bm;
+	if (!zone_bm) {
+		chain_free(&ca, 1);
+		return -ENOMEM;
+	}
+
+	/* Initialize the zone bitmap objects */
+	for_each_zone (zone) {
+		unsigned long pfn;
+
+		if (!populated_zone(zone) || is_highmem(zone))
+			continue;
+
+		zone_bm->start_pfn = zone->zone_start_pfn;
+		zone_bm->end_pfn = zone->zone_start_pfn + zone->spanned_pages;
+		/* Allocate the list of bitmap block objects */
+		nr = DIV_ROUND_UP(zone->spanned_pages, BM_BITS_PER_BLOCK);
+		bb = create_bm_block_list(nr, &ca);
+		zone_bm->bm_blocks = bb;
+		zone_bm->cur_block = bb;
+		if (!bb)
+			goto Free;
+
+		nr = zone->spanned_pages;
+		pfn = zone->zone_start_pfn;
+		/* Initialize the bitmap block objects */
+		while (bb) {
+			unsigned long *ptr;
+
+			ptr = alloc_image_page(gfp_mask, safe_needed);
+			bb->data = ptr;
+			if (!ptr)
+				goto Free;
+
+			bb->start_pfn = pfn;
+			if (nr >= BM_BITS_PER_BLOCK) {
+				pfn += BM_BITS_PER_BLOCK;
+				bb->size = BM_CHUNKS_PER_BLOCK;
+				nr -= BM_BITS_PER_BLOCK;
+			} else {
+				/* This is executed only once in the loop */
+				pfn += nr;
+				bb->size = DIV_ROUND_UP(nr, BM_BITS_PER_CHUNK);
+			}
+			bb->end_pfn = pfn;
+			bb = bb->next;
+		}
+		zone_bm = zone_bm->next;
+	}
+	bm->p_list = ca.chain;
+	bm_position_reset(bm);
+	return 0;
+
+Free:
+	bm->p_list = ca.chain;
+	free_memory_bm(bm, 1);
+	return -ENOMEM;
+}
+
+/**
+  *	free_memory_bm - free memory occupied by the memory bitmap @bm
+  */
+
+static void free_memory_bm(struct memory_bitmap *bm, int clear_nosave_free)
+{
+	struct zone_bitmap *zone_bm;
+
+	/* Free the list of bit blocks for each zone_bitmap object */
+	zone_bm = bm->zone_bm_list;
+	while (zone_bm) {
+		struct bm_block *bb;
+
+		bb = zone_bm->bm_blocks;
+		while (bb) {
+			if (bb->data)
+				free_image_page(bb->data, clear_nosave_free);
+			bb = bb->next;
+		}
+		zone_bm = zone_bm->next;
+	}
+	free_list_of_pages(bm->p_list, clear_nosave_free);
+	bm->zone_bm_list = NULL;
+}
+
+/**
+ *	memory_bm_set_bit - set the bit in the bitmap @bm that corresponds
+ *	to given pfn.  The cur_zone_bm member of @bm and the cur_block member
+ *	of @bm->cur_zone_bm are updated.
+ *
+ *	If the bit cannot be set, the function returns -EINVAL .
+ */
+
+static int
+memory_bm_set_bit(struct memory_bitmap *bm, unsigned long pfn)
+{
+	struct zone_bitmap *zone_bm;
+	struct bm_block *bb;
+
+	/* Check if the pfn is from the current zone */
+	zone_bm = bm->cur.zone_bm;
+	if (pfn < zone_bm->start_pfn || pfn >= zone_bm->end_pfn) {
+		zone_bm = bm->zone_bm_list;
+		/* We don't assume that the zones are sorted by pfns */
+		while (pfn < zone_bm->start_pfn || pfn >= zone_bm->end_pfn) {
+			zone_bm = zone_bm->next;
+			if (unlikely(!zone_bm))
+				return -EINVAL;
+		}
+		bm->cur.zone_bm = zone_bm;
+	}
+	/* Check if the pfn corresponds to the current bitmap block */
+	bb = zone_bm->cur_block;
+	if (pfn < bb->start_pfn)
+		bb = zone_bm->bm_blocks;
+
+	while (pfn >= bb->end_pfn) {
+		bb = bb->next;
+		if (unlikely(!bb))
+			return -EINVAL;
+	}
+	zone_bm->cur_block = bb;
+	pfn -= bb->start_pfn;
+	set_bit(pfn % BM_BITS_PER_CHUNK, bb->data + pfn / BM_BITS_PER_CHUNK);
+	return 0;
+}
+
+/* Two auxiliary functions for memory_bm_next_pfn */
+
+/* Find the first set bit in the given chunk, if there is one */
+
+static inline int next_bit_in_chunk(int bit, unsigned long *chunk_p)
+{
+	bit++;
+	while (bit < BM_BITS_PER_CHUNK) {
+		if (test_bit(bit, chunk_p))
+			return bit;
+
+		bit++;
+	}
+	return -1;
+}
+
+/* Find a chunk containing some bits set in given block of bits */
+
+static inline int next_chunk_in_block(int n, struct bm_block *bb)
+{
+	n++;
+	while (n < bb->size) {
+		if (bb->data[n])
+			return n;
+
+		n++;
+	}
+	return -1;
+}
+
+/**
+ *	memory_bm_next_pfn - find the pfn that corresponds to the next set bit
+ *	in the bitmap @bm.  If the pfn cannot be found, BM_END_OF_MAP is
+ *	returned.
+ *
+ *	It is required to run bm_position_reset() before the first call to
+ *	this function.
+ */
+
+static unsigned long memory_bm_next_pfn(struct memory_bitmap *bm)
+{
+	struct zone_bitmap *zone_bm;
+	struct bm_block *bb;
+	int chunk;
+	int bit;
+
+	do {
+		bb = bm->cur.block;
+		do {
+			chunk = bm->cur.chunk;
+			bit = bm->cur.bit;
+			do {
+				bit = next_bit_in_chunk(bit, bb->data + chunk);
+				if (bit >= 0)
+					goto Return_pfn;
+
+				chunk = next_chunk_in_block(chunk, bb);
+				bit = -1;
+			} while (chunk >= 0);
+			bb = bb->next;
+			bm->cur.block = bb;
+			bm_position_reset_chunk(bm);
+		} while (bb);
+		zone_bm = bm->cur.zone_bm->next;
+		if (zone_bm) {
+			bm->cur.zone_bm = zone_bm;
+			bm->cur.block = zone_bm->bm_blocks;
+			bm_position_reset_chunk(bm);
+		}
+	} while (zone_bm);
+	bm_position_reset(bm);
+	return BM_END_OF_MAP;
+
+Return_pfn:
+	bm->cur.chunk = chunk;
+	bm->cur.bit = bit;
+	return bb->start_pfn + chunk * BM_BITS_PER_CHUNK + bit;
+}
+
+/**
+ *	snapshot_additional_pages - estimate the number of additional pages
+ *	be needed for setting up the suspend image data structures for given
+ *	zone (usually the returned value is greater than the exact number)
+ */
+
+unsigned int snapshot_additional_pages(struct zone *zone)
+{
+	unsigned int res;
+
+	res = DIV_ROUND_UP(zone->spanned_pages, BM_BITS_PER_BLOCK);
+	res += DIV_ROUND_UP(res * sizeof(struct bm_block), PAGE_SIZE);
+	return res;
+}
+
 /**
  *	pfn_is_nosave - check if given pfn is in the 'nosave' section
  */
@@ -269,32 +730,38 @@ static inline void copy_data_page(long *
 		*dst++ = *src++;
 }
 
-static void copy_data_pages(struct pbe *pblist)
+static void
+copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 {
 	struct zone *zone;
-	unsigned long pfn, max_zone_pfn;
-	struct pbe *pbe;
+	unsigned long pfn;
 
-	pbe = pblist;
 	for_each_zone (zone) {
+		unsigned long max_zone_pfn;
+
 		if (is_highmem(zone))
 			continue;
+
 		mark_free_pages(zone);
 		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
-		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
-			struct page *page = saveable_page(pfn);
-
-			if (page) {
-				void *ptr = page_address(page);
-
-				BUG_ON(!pbe);
-				copy_data_page((void *)pbe->address, ptr);
-				pbe->orig_address = (unsigned long)ptr;
-				pbe = pbe->next;
-			}
-		}
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			if (saveable_page(pfn))
+				memory_bm_set_bit(orig_bm, pfn);
 	}
-	BUG_ON(pbe);
+	bm_position_reset(orig_bm);
+	bm_position_reset(copy_bm);
+	do {
+		pfn = memory_bm_next_pfn(orig_bm);
+		if (likely(pfn != BM_END_OF_MAP)) {
+			struct page *page;
+			void *src;
+
+			page = pfn_to_page(pfn);
+			src = page_address(page);
+			page = pfn_to_page(memory_bm_next_pfn(copy_bm));
+			copy_data_page(page_address(page), src);
+		}
+	} while (pfn != BM_END_OF_MAP);
 }
 
 /**
@@ -440,36 +907,43 @@ static int enough_free_mem(unsigned int 
 		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
-static int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed)
+static int
+swsusp_alloc(struct memory_bitmap *orig_bm, struct memory_bitmap *copy_bm,
+		unsigned int nr_pages)
 {
-	struct pbe *p;
+	int error;
 
-	for_each_pbe (p, pblist) {
-		p->address = (unsigned long)alloc_image_page(gfp_mask, safe_needed);
-		if (!p->address)
-			return -ENOMEM;
+	error = create_memory_bm(orig_bm, GFP_ATOMIC, 0);
+	if (error)
+		goto Free;
+
+	error = create_memory_bm(copy_bm, GFP_ATOMIC, 0);
+	if (error)
+		goto Free;
+
+	while (nr_pages-- > 0) {
+		struct page *page = alloc_page(GFP_ATOMIC);
+		if (!page)
+			goto Free;
+
+		SetPageNosave(page);
+		SetPageNosaveFree(page);
+		memory_bm_set_bit(copy_bm, page_to_pfn(page));
 	}
 	return 0;
-}
-
-static struct pbe *swsusp_alloc(unsigned int nr_pages)
-{
-	struct pbe *pblist;
-
-	if (!(pblist = alloc_pagedir(nr_pages, GFP_ATOMIC | __GFP_COLD, 0))) {
-		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
-		return NULL;
-	}
-
-	if (alloc_data_pages(pblist, GFP_ATOMIC | __GFP_COLD, 0)) {
-		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
-		swsusp_free();
-		return NULL;
-	}
 
-	return pblist;
+Free:
+	swsusp_free();
+	return -ENOMEM;
 }
 
+/* Memory bitmap used for marking saveable pages */
+static struct memory_bitmap orig_bm;
+/* Memory bitmap used for marking allocated pages that will contain the copies
+ * of saveable pages
+ */
+static struct memory_bitmap copy_bm;
+
 asmlinkage int swsusp_save(void)
 {
 	unsigned int nr_pages;
@@ -490,15 +964,14 @@ asmlinkage int swsusp_save(void)
 		return -ENOMEM;
 	}
 
-	pagedir_nosave = swsusp_alloc(nr_pages);
-	if (!pagedir_nosave)
+	if (swsusp_alloc(&orig_bm, &copy_bm, nr_pages))
 		return -ENOMEM;
 
 	/* During allocating of suspend pagedir, new cold pages may appear.
 	 * Kill them.
 	 */
 	drain_local_pages();
-	copy_data_pages(pagedir_nosave);
+	copy_data_pages(&copy_bm, &orig_bm);
 
 	/*
 	 * End of critical section. From now on, we can write to memory,
@@ -527,22 +1000,23 @@ static void init_header(struct swsusp_in
 }
 
 /**
- *	pack_orig_addresses - the .orig_address fields of the PBEs from the
- *	list starting at @pbe are stored in the array @buf[] (1 page)
+ *	pack_addresses - the addresses corresponding to pfns found in the
+ *	bitmap @bm are stored in the array @buf[] (1 page)
  */
 
-static inline struct pbe *pack_orig_addresses(unsigned long *buf, struct pbe *pbe)
+static inline void
+pack_addresses(unsigned long *buf, struct memory_bitmap *bm)
 {
 	int j;
 
-	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
-		buf[j] = pbe->orig_address;
-		pbe = pbe->next;
+	for (j = 0; j < PAGE_SIZE / sizeof(long); j++) {
+		unsigned long pfn = memory_bm_next_pfn(bm);
+
+		if (unlikely(pfn == BM_END_OF_MAP))
+			break;
+
+		buf[j] = (unsigned long)page_address(pfn_to_page(pfn));
 	}
-	if (!pbe)
-		for (; j < PAGE_SIZE / sizeof(long); j++)
-			buf[j] = 0;
-	return pbe;
 }
 
 /**
@@ -571,6 +1045,7 @@ int snapshot_read_next(struct snapshot_h
 {
 	if (handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
+
 	if (!buffer) {
 		/* This makes the buffer be freed by swsusp_free() */
 		buffer = alloc_image_page(GFP_ATOMIC, 0);
@@ -580,16 +1055,17 @@ int snapshot_read_next(struct snapshot_h
 	if (!handle->offset) {
 		init_header((struct swsusp_info *)buffer);
 		handle->buffer = buffer;
-		handle->pbe = pagedir_nosave;
+		bm_position_reset(&orig_bm);
+		bm_position_reset(&copy_bm);
 	}
 	if (handle->prev < handle->cur) {
 		if (handle->cur <= nr_meta_pages) {
-			handle->pbe = pack_orig_addresses(buffer, handle->pbe);
-			if (!handle->pbe)
-				handle->pbe = pagedir_nosave;
+			memset(buffer, 0, PAGE_SIZE);
+			pack_addresses(buffer, &orig_bm);
 		} else {
-			handle->buffer = (void *)handle->pbe->address;
-			handle->pbe = handle->pbe->next;
+			unsigned long pfn = memory_bm_next_pfn(&copy_bm);
+
+			handle->buffer = page_address(pfn_to_page(pfn));
 		}
 		handle->prev = handle->cur;
 	}
@@ -728,12 +1204,7 @@ static inline struct pbe *unpack_orig_ad
  *	of "safe" which will be used later
  */
 
-struct safe_page {
-	struct safe_page *next;
-	char padding[PAGE_SIZE - sizeof(void *)];
-};
-
-static struct safe_page *safe_pages;
+static struct linked_page *safe_pages;
 
 static int prepare_image(struct snapshot_handle *handle)
 {
@@ -755,9 +1226,9 @@ static int prepare_image(struct snapshot
 	if (!error && nr_pages > unsafe_pages) {
 		nr_pages -= unsafe_pages;
 		while (nr_pages--) {
-			struct safe_page *ptr;
+			struct linked_page *ptr;
 
-			ptr = (struct safe_page *)get_zeroed_page(GFP_ATOMIC);
+			ptr = (void *)get_zeroed_page(GFP_ATOMIC);
 			if (!ptr) {
 				error = -ENOMEM;
 				break;
Index: linux-2.6.18-rc3-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/power.h
+++ linux-2.6.18-rc3-mm2/kernel/power/power.h
@@ -111,9 +111,10 @@ struct snapshot_handle {
  */
 #define data_of(handle)	((handle).buffer + (handle).buf_offset)
 
+extern unsigned int snapshot_additional_pages(struct zone *zone);
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
-int snapshot_image_loaded(struct snapshot_handle *handle);
+extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
 #define SNAPSHOT_IOC_MAGIC	'3'
 #define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
Index: linux-2.6.18-rc3-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/swsusp.c
+++ linux-2.6.18-rc3-mm2/kernel/power/swsusp.c
@@ -193,14 +193,13 @@ int swsusp_shrink_memory(void)
 	printk("Shrinking memory...  ");
 	do {
 		size = 2 * count_highmem_pages();
-		size += size / 50 + count_data_pages();
-		size += (size + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
-			PAGES_FOR_IO;
+		size += size / 50 + count_data_pages() + PAGES_FOR_IO;
 		tmp = size;
 		for_each_zone (zone)
 			if (!is_highmem(zone) && populated_zone(zone)) {
 				tmp -= zone->free_pages;
 				tmp += zone->lowmem_reserve[ZONE_NORMAL];
+				tmp += snapshot_additional_pages(zone);
 			}
 		if (tmp > 0) {
 			tmp = __shrink_memory(tmp);

