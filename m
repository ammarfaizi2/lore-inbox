Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVAMBjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVAMBjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVALVVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:21:14 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:33759 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261214AbVALVJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:09:35 -0500
Date: Wed, 12 Jan 2005 21:09:24 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Memory Management List <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] Avoiding fragmentation through different allocator
Message-ID: <Pine.LNX.4.58.0501122101420.13738@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I was reading through the archives on threads involving page fragmentation
where high-order allocations are difficult to meet. The solutions I saw
proposed and implemented were focusing on moving the pages around using the
same mechanisms as used for memory hotplug and NUMA node migration. From what I
can gather, this is both expensive and difficult. This patch is a proposal to
change the page allocator to avoid some of the nastier fragmentation problems
in the first place. The objective is that higher order pages will be more
likely to be available and if not, there will be an easy way of finding large
blocks to free up. It does not negate the defragmentation-through-migration
(Marcelo's work I believe) approach to the problem but it should make that
approach's job a lot easier.

The patch is against 2.6.9 but as this is not ready for inclusion yet anyway
so I figured I would get opinions first before forward-porting or thinking
about any optimisations.

So... What the patch does. Allocations are divided up into three different
types of allocations;

UserReclaimable - These are userspace pages that are easily reclaimable. Right
	now, I'm putting all allocations of GFP_USER and GFP_HIGHUSER as
	well as disk-buffer pages into this category. These pages are trivially
	reclaimed by writing the page out to swap or syncing with backing
	storage

KernelReclaimable - These are pages allocated by the kernel that are easily
	reclaimed. This is stuff like inode caches, dcache, buffer_heads etc.
	These type of pages potentially could be reclaimed by dumping the
	caches and reaping the slabs (drastic, but you get the idea). We could
	also add pages into this category that are known to be only required
	for a short time like buffers used with DMA

KernelNonReclaimable - These are pages that are allocated by the kernel that
	are not trivially reclaimed. For example, the memory allocated for a
	loaded module would be in this category. By default, allocations are
	considered to be of this type

Instead of having one global MAX_ORDER-sized array of free lists, there are
three, one for each type of allocation. Finally, there is a list of pages of
size 2^MAX_ORDER which is a global pool of the largest pages the kernel deals
with.

Once a 2^MAX_ORDER block of pages it split for a type of allocation, it is
added to the free-lists for that type, in effect reserving it. Hence, over
time, pages of the related types can be clustered together. This means
that if we wanted 2^MAX_ORDER number of pages, we could linearly scan a
block of pages allocated for UserReclaimable and page each of them out.

The patch also implements fallback logic for when there are no 2^MAX_ORDER
pages available and there are no free pages of the desired type. The fallback
lists were chosen in a way that keeps the most easily reclaimable pages
together.

I stress-tested this patch very heavily and it never oopsed so I am
confident of it's stability, so what is left is to look at the results of
this patch were and I think they look promising in a number of respects. I
have graphs that do not translate to text very well, so I'll just point you
to http://www.csn.ul.ie/~mel/projects/mbuddy-results-1 instead.

The two figures at the top show the normal zone with the normal allocator
and with the modified allocator. A value of 0 shows the page is free. 1 is
a user reclaimable page. 2 is a kernel reclaimable page and 3 is a
non-reclaimable page. The standard allocator has these all mixed in
together. The modified allocator has each of them grouped together.

The Normal zone is the main zone of interest, but I included the graph of
what HighMem looks like. As it is almost all userspace allocations anyway,
it does not present a defragmentation problem (just linearlly scan pages,
and either page our or sync with backing storage and dump)

So.... the actual fragmentation results.

The results were not spectacular but still very interesting. Under heavy
stresing (updatedb + 4 simultaneous -j4 kernel compiles with avg load 15)
fragmentation is consistently lower than the standard allocator. It could
also be a lot better if there was some means of purging caches, userpages
and buffers but thats in the future. For the moment, the only real control
I had was the buffer pages.

The figures below are the output of /proc/buddyinfo before and after deleting
the kernel trees that were compiled (flushing their buffer pages).

Standard allocator - Before deleting trees
Node 0, zone      DMA      3      1      4      4      4      1      2      0      1      1      2
Node 0, zone   Normal    298      8    892    460    268     81     28      8      1      0     14
Node 0, zone  HighMem     30     15      1      0      0      0      0      0      1      0      0

Standard allocator - After deleting trees
Node 0, zone      DMA      3      1      4      4      4      1      2      0      1      1      2
Node 0, zone   Normal  18644  13067   7911   4224   1583    351     52     10      1      0     14
Node 0, zone  HighMem    370    343    218    157   3078    355     80     48     26     13      5


Modified allocator - Before deleting trees
Node 0, zone      DMA     1      0      4      4      4      1      2      0      1      1      2
Node 0, zone   Normal   658    230    113    578    176     73     23      9     10      4     13
Node 0, zone  HighMem    40     10      4      0      1      1      1      1      0      0      0

Modified allocator - After deleting trees
Node 0, zone      DMA     1      0      4      4      4      1      2      0      1      1      2
Node 0, zone   Normal 15407  11695   7280   3858   1563    523     87     13     11      4     13
Node 0, zone  HighMem  6816   3616   3407   3328    566    144     89     53     17      9      4


In both cases, deleting the trees really freed up HighMem which is not a
suprise. The fragmentation there will really depend on when buffer pages were
allocated (I could make this close to perfect if I put only buffer pages into
UserRclm) so there is not a lot that can be done so lets look at Normal.

Before the trees were deleted, the modified alloactor was in better shape
than the standard allocator at the higher orders although arguably they
are in similar shape. However, after the trees were deleted, the modified
allocator was in way better shape. Deleting buffers barely made a difference
in high-order page availability in the standard allocator but really improved
with the modified one

S: Node 0, zone   Normal  18644  13067   7911   4224   1583    351     52     10      1      0     14
M: Node 0, zone   Normal  15407  11695   7280   3858   1563    523     87     13     11      4     13
Delta:			  -3237  -1372   -631   -366    -20   +172    +35     +3    +10     +4     -1

Ok, order 10 lost out but I consider that just unlucky :) . From order-5
on 5, there were definite improvements. I could show what the figures look
like in each of the UserRclm, KernRclm and KernNoRclm pools but what they
show is that the UserRclm pool really benefits and it is obvious that the
other two pools were used frequently for fallbacks under the heavy memory
pressure.

So.... bottom line, there is consistent improvements in fragmentation using
the allocator before anything drastic like linear page scanning or migration
of pages takes place. I have not measured it yet, but I do not believe the
overhead of the scheme is severe either.

Opinions/Feedback?

>>>Patch follows<<<
diff -rup linux-2.6.9-clean/fs/buffer.c linux-2.6.9-mbuddy/fs/buffer.c
--- linux-2.6.9-clean/fs/buffer.c	2004-10-18 22:54:32.000000000 +0100
+++ linux-2.6.9-mbuddy/fs/buffer.c	2005-01-03 19:33:23.000000000 +0000
@@ -1203,7 +1203,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;

-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index,
+					GFP_NOFS | __GFP_USERRCLM);
 	if (!page)
 		return NULL;

@@ -3065,7 +3066,8 @@ static void recalc_bh_state(void)

 struct buffer_head *alloc_buffer_head(int gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep,
+						   gfp_flags|__GFP_KERNRCLM);
 	if (ret) {
 		preempt_disable();
 		__get_cpu_var(bh_accounting).nr++;
diff -rup linux-2.6.9-clean/fs/dcache.c linux-2.6.9-mbuddy/fs/dcache.c
--- linux-2.6.9-clean/fs/dcache.c	2004-10-18 22:53:21.000000000 +0100
+++ linux-2.6.9-mbuddy/fs/dcache.c	2005-01-03 19:34:12.000000000 +0000
@@ -691,7 +691,8 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;

-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
+	dentry = kmem_cache_alloc(dentry_cache,
+			  	  GFP_KERNEL|__GFP_KERNRCLM);
 	if (!dentry)
 		return NULL;

diff -rup linux-2.6.9-clean/fs/ext2/super.c linux-2.6.9-mbuddy/fs/ext2/super.c
--- linux-2.6.9-clean/fs/ext2/super.c	2004-10-18 22:54:38.000000000 +0100
+++ linux-2.6.9-mbuddy/fs/ext2/super.c	2005-01-03 19:34:35.000000000 +0000
@@ -134,7 +134,7 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
diff -rup linux-2.6.9-clean/fs/ext3/super.c linux-2.6.9-mbuddy/fs/ext3/super.c
--- linux-2.6.9-clean/fs/ext3/super.c	2004-10-18 22:55:07.000000000 +0100
+++ linux-2.6.9-mbuddy/fs/ext3/super.c	2005-01-03 19:34:47.000000000 +0000
@@ -442,7 +442,7 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;

-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
diff -rup linux-2.6.9-clean/fs/ntfs/inode.c linux-2.6.9-mbuddy/fs/ntfs/inode.c
--- linux-2.6.9-clean/fs/ntfs/inode.c	2004-10-18 22:55:07.000000000 +0100
+++ linux-2.6.9-mbuddy/fs/ntfs/inode.c	2005-01-03 19:35:27.000000000 +0000
@@ -314,7 +314,7 @@ struct inode *ntfs_alloc_big_inode(struc

 	ntfs_debug("Entering.");
 	ni = (ntfs_inode *)kmem_cache_alloc(ntfs_big_inode_cache,
-			SLAB_NOFS);
+			SLAB_NOFS|__GFP_KERNRCLM);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
@@ -339,7 +339,8 @@ static inline ntfs_inode *ntfs_alloc_ext
 	ntfs_inode *ni;

 	ntfs_debug("Entering.");
-	ni = (ntfs_inode *)kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS);
+	ni = (ntfs_inode *)kmem_cache_alloc(ntfs_inode_cache,
+					    SLAB_NOFS|__GFP_KERNRCLM);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return ni;
diff -rup linux-2.6.9-clean/include/linux/gfp.h linux-2.6.9-mbuddy/include/linux/gfp.h
--- linux-2.6.9-clean/include/linux/gfp.h	2004-10-18 22:53:44.000000000 +0100
+++ linux-2.6.9-mbuddy/include/linux/gfp.h	2005-01-09 18:34:07.000000000 +0000
@@ -37,21 +37,24 @@ struct vm_area_struct;
 #define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */
 #define __GFP_NO_GROW	0x2000	/* Slab internal usage */
 #define __GFP_COMP	0x4000	/* Add compound page metadata */
+#define __GFP_KERNRCLM  0x8000  /* Kernel page that is easily reclaimable */
+#define __GFP_USERRCLM  0x10000 /* User is a userspace user */

-#define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
+#define __GFP_BITS_SHIFT 18	/* Room for 16 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)

 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
-			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
+			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
+			__GFP_KERNRCLM|__GFP_USERRCLM)

 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_USERRCLM)
+#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM | __GFP_USERRCLM)

 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
@@ -130,4 +133,7 @@ extern void FASTCALL(free_cold_page(stru

 void page_alloc_init(void);

+/* VM Regress: define to indicate tracing callbacks is enabled */
+#define TRACE_PAGE_ALLOCS
+
 #endif /* __LINUX_GFP_H */
diff -rup linux-2.6.9-clean/include/linux/mmzone.h linux-2.6.9-mbuddy/include/linux/mmzone.h
--- linux-2.6.9-clean/include/linux/mmzone.h	2004-10-18 22:54:31.000000000 +0100
+++ linux-2.6.9-mbuddy/include/linux/mmzone.h	2005-01-09 15:19:44.000000000 +0000
@@ -19,6 +19,10 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
+#define ALLOC_TYPES 3
+#define ALLOC_KERNNORCLM 0
+#define ALLOC_KERNRCLM 1
+#define ALLOC_USERRCLM 2

 struct free_area {
 	struct list_head	free_list;
@@ -162,9 +166,23 @@ struct zone {
 	int prev_priority;

 	/*
-	 * free areas of different sizes
+	 * free areas of different sizes. There is one global free area that
+	 * contains lists of pages of 2^MAX_ORDER in size. Once split, the
+	 * buddy will be added to one of the free_area lists in free_area_lists.
+	 * Each type is one of User Reclaimable, Kernel Reclaimable and
+	 * Kernel Non-reclaimable. The idea is that pages of related use will
+	 * be clustered together to reduce fragmentation.
 	 */
-	struct free_area	free_area[MAX_ORDER];
+	struct free_area	free_area_lists[ALLOC_TYPES][MAX_ORDER];
+	struct free_area	free_area_global;
+
+	/*
+	 * This map tracks what each 2^MAX_ORDER sized block has been used for.
+	 * When a page is freed, it's index within this bitmap is calculated
+	 * using (address >> MAX_ORDER) * 2 . This means that pages will
+	 * always be freed into the correct list in free_area_lists
+	 */
+	unsigned long		*free_area_usemap;

 	/*
 	 * wait_table		-- the array holding the hash table
diff -rup linux-2.6.9-clean/mm/page_alloc.c linux-2.6.9-mbuddy/mm/page_alloc.c
--- linux-2.6.9-clean/mm/page_alloc.c	2004-10-18 22:53:11.000000000 +0100
+++ linux-2.6.9-mbuddy/mm/page_alloc.c	2005-01-12 14:45:20.000000000 +0000
@@ -40,8 +40,21 @@ unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 long nr_swap_pages;
 int numnodes = 1;
+int fallback_count=0;
+int drastic_fallback_count=0;
+int global_steal=0;
+int global_refill=0;
+int kernnorclm_count=0;
+int kernrclm_count=0;
+int userrclm_count=0;
 int sysctl_lower_zone_protection = 0;

+int fallback_allocs[ALLOC_TYPES][ALLOC_TYPES] = {
+ 	{ ALLOC_KERNNORCLM, ALLOC_KERNRCLM,   ALLOC_USERRCLM },
+ 	{ ALLOC_KERNRCLM,   ALLOC_KERNNORCLM, ALLOC_USERRCLM },
+ 	{ ALLOC_USERRCLM,   ALLOC_KERNNORCLM, ALLOC_KERNRCLM }
+};
+
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);

@@ -53,6 +66,7 @@ struct zone *zone_table[1 << (ZONES_SHIF
 EXPORT_SYMBOL(zone_table);

 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
+static char *type_names[ALLOC_TYPES] = { "KernNoRclm", "KernRclm", "UserRclm"};
 int min_free_kbytes = 1024;

 unsigned long __initdata nr_kernel_pages;
@@ -94,6 +108,48 @@ static void bad_page(const char *functio
 	page->mapping = NULL;
 }

+/*
+ * Return what type of use the 2^MAX_ORDER block of pages is in use for
+ * that the given page is part of
+ */
+static int get_pageblock_type(struct page *page) {
+	struct zone *zone = page_zone(page);
+	int pageidx = (page - zone->zone_mem_map) >> MAX_ORDER;
+	int bitidx = pageidx * 2;
+
+	/* Bit 1 will be set if the block is kernel reclaimable */
+	if (test_bit(bitidx,zone->free_area_usemap)) return ALLOC_KERNRCLM;
+
+	/* Bit 2 will be set if the block is user reclaimable */
+	if (test_bit(bitidx+1, zone->free_area_usemap)) return ALLOC_USERRCLM;
+
+	return ALLOC_KERNNORCLM;
+}
+
+static void set_pageblock_type(struct page *page, int type) {
+	int bit1, bit2;
+	struct zone *zone = page_zone(page);
+	int pageidx = (page - zone->zone_mem_map) >> MAX_ORDER;
+	int bitidx = pageidx * 2;
+	bit1 = bit2 = 0;
+
+	if (type == ALLOC_KERNRCLM) {
+		set_bit(bitidx, zone->free_area_usemap);
+		clear_bit(bitidx+1, zone->free_area_usemap);
+		return;
+	}
+
+	if (type == ALLOC_USERRCLM) {
+		clear_bit(bitidx, zone->free_area_usemap);
+		set_bit(bitidx+1, zone->free_area_usemap);
+		return;
+	}
+
+	clear_bit(bitidx, zone->free_area_usemap);
+	clear_bit(bitidx+1, zone->free_area_usemap);
+
+}
+
 #ifndef CONFIG_HUGETLB_PAGE
 #define prep_compound_page(page, order) do { } while (0)
 #define destroy_compound_page(page, order) do { } while (0)
@@ -193,7 +249,9 @@ static inline void __free_pages_bulk (st
 	while (order < MAX_ORDER-1) {
 		struct page *buddy1, *buddy2;

+		/* MBUDDY TODO: Fix this bug check
 		BUG_ON(area >= zone->free_area + MAX_ORDER);
+		*/
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -211,7 +269,16 @@ static inline void __free_pages_bulk (st
 		area++;
 		index >>= 1;
 		page_idx &= mask;
+
+
 	}
+
+	/* Switch to the global list if this is the MAX_ORDER */
+	if (order >= MAX_ORDER-1) {
+		area = &(zone->free_area_global);
+		global_refill++;
+	}
+
 	list_add(&(base + page_idx)->lru, &area->free_list);
 }

@@ -253,14 +320,23 @@ free_pages_bulk(struct zone *zone, int c
 	struct free_area *area;
 	struct page *base, *page = NULL;
 	int ret = 0;
+	int alloctype;

 	base = zone->zone_mem_map;
-	area = zone->free_area + order;
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->all_unreclaimable = 0;
 	zone->pages_scanned = 0;
 	while (!list_empty(list) && count--) {
 		page = list_entry(list->prev, struct page, lru);
+
+		/*
+		 * Find what area this page belonged to. It is possible that
+		 * the pages are always of the same type and this expensive
+		 * check could be only performed once. Needs investigation
+		 */
+		alloctype = get_pageblock_type(page);
+		area = zone->free_area_lists[alloctype] + order;
+
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
 		__free_pages_bulk(page, base, zone, area, order);
@@ -363,15 +439,37 @@ static void prep_new_page(struct page *p
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order, int flags)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
 	unsigned int index;
+	int global_split=0;
+
+	/* Select area to use based on gfp_flags */
+	int alloctype;
+	int retry_count=0;
+	if (flags & __GFP_USERRCLM) {
+		alloctype = ALLOC_USERRCLM;
+		userrclm_count++;
+	}
+	else if (flags & __GFP_KERNRCLM) {
+		alloctype = ALLOC_KERNRCLM;
+		kernrclm_count++;
+	} else {
+		alloctype = ALLOC_KERNNORCLM;
+		kernnorclm_count++;
+	}
+
+	/* Ok, pick the fallback order based on the type */
+	int *fallback_list = fallback_allocs[alloctype];

+retry:
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
+		alloctype = fallback_list[retry_count];
+		area = zone->free_area_lists[alloctype] + current_order;
+
 		if (list_empty(&area->free_list))
 			continue;

@@ -384,6 +482,34 @@ static struct page *__rmqueue(struct zon
 		return expand(zone, page, index, order, current_order, area);
 	}

+	/* Take from the global pool if this is the first attempt */
+	if (!global_split && !list_empty(&(zone->free_area_global.free_list))){
+		/*
+		 * Remove a MAX_ORDER block from the global pool and add
+		 * it to the list of desired alloc_type
+		 */
+		page = list_entry(zone->free_area_global.free_list.next,
+				  struct page, lru);
+		list_del(&page->lru);
+		list_add(&page->lru,
+			&(zone->free_area_lists[alloctype][MAX_ORDER-1].free_list));
+		global_steal++;
+		global_split=1;
+
+		/* Mark this block of pages as for use with this alloc type */
+		set_pageblock_type(page, alloctype);
+
+		goto retry;
+	}
+
+	/*
+	 * Here, the alloc type lists has been depleted as well as the global
+	 * pool, so fallback
+	 */
+	retry_count++;
+	fallback_count++;
+	if (retry_count != ALLOC_TYPES) goto retry;
+
 	return NULL;
 }

@@ -393,7 +519,8 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order,
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int gfp_flags)
 {
 	unsigned long flags;
 	int i;
@@ -402,7 +529,7 @@ static int rmqueue_bulk(struct zone *zon

 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, gfp_flags);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -438,7 +565,7 @@ int is_head_of_free_region(struct page *
 {
         struct zone *zone = page_zone(page);
         unsigned long flags;
-	int order;
+	int order,type;
 	struct list_head *curr;

 	/*
@@ -446,12 +573,16 @@ int is_head_of_free_region(struct page *
 	 * suspend anyway, but...
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list)
+	for (type = 0 ; type < ALLOC_TYPES ; type++) {
+		for (order = MAX_ORDER - 1; order >= 0; --order) {
+			list_for_each(curr,
+				&zone->free_area_lists[type][order].free_list)
 			if (page == list_entry(curr, struct page, lru)) {
 				spin_unlock_irqrestore(&zone->lock, flags);
 				return 1 << order;
 			}
+		}
+	}
 	spin_unlock_irqrestore(&zone->lock, flags);
         return 0;
 }
@@ -545,14 +676,15 @@ buffered_rmqueue(struct zone *zone, int
 	struct page *page = NULL;
 	int cold = !!(gfp_flags & __GFP_COLD);

-	if (order == 0) {
+	if (order == 0 && (gfp_flags & __GFP_USERRCLM)) {
 		struct per_cpu_pages *pcp;

 		pcp = &zone->pageset[get_cpu()].pcp[cold];
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list,
+						gfp_flags);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -564,7 +696,7 @@ buffered_rmqueue(struct zone *zone, int

 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, gfp_flags);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}

@@ -1040,6 +1172,7 @@ void show_free_areas(void)
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	int type;

 	for_each_zone(zone) {
 		show_node(zone);
@@ -1130,8 +1263,11 @@ void show_free_areas(void)
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
 			nr = 0;
-			list_for_each(elem, &zone->free_area[order].free_list)
-				++nr;
+			for (type=0; type < ALLOC_TYPES; type++) {
+				list_for_each(elem,
+					&zone->free_area_lists[type][order].free_list)
+					++nr;
+			}
 			total += nr << order;
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
@@ -1445,19 +1581,35 @@ unsigned long pages_to_bitmap_size(unsig
 void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone, unsigned long size)
 {
 	int order;
-	for (order = 0; ; order++) {
-		unsigned long bitmap_size;
+	int type;
+	struct free_area *area;
+	unsigned long bitmap_size;

-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		if (order == MAX_ORDER-1) {
-			zone->free_area[order].map = NULL;
-			break;
-		}
+	/* Initialse the three size ordered lists of free_areas */
+	for (type=0; type < ALLOC_TYPES; type++) {
+
+		for (order = 0; ; order++) {
+			area = zone->free_area_lists[type];
+
+			INIT_LIST_HEAD(&area[order].free_list);
+			if (order == MAX_ORDER-1) {
+				area[order].map = NULL;
+				break;
+			}

-		bitmap_size = pages_to_bitmap_size(order, size);
-		zone->free_area[order].map =
-		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
+			bitmap_size = pages_to_bitmap_size(order, size);
+			area[order].map =
+		  		(unsigned long*)alloc_bootmem_node(pgdat,
+							   	 bitmap_size);
+		}
 	}
+
+	/* Initialise the global pool of 2^size pages */
+	INIT_LIST_HEAD(&zone->free_area_global.free_list);
+	bitmap_size = pages_to_bitmap_size(MAX_ORDER-1, size);
+	zone->free_area_global.map =
+		(unsigned long*)alloc_bootmem_node(pgdat,
+					   	   bitmap_size);
 }

 #ifndef __HAVE_ARCH_MEMMAP_INIT
@@ -1575,6 +1727,11 @@ static void __init free_area_init_core(s
 		zone_start_pfn += size;

 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+		zone->free_area_usemap =
+			(unsigned long *)alloc_bootmem_node(pgdat,
+						   (size >> MAX_ORDER) * 2);
+		memset((unsigned long *)zone->free_area_usemap, ALLOC_KERNNORCLM,
+			(size >> MAX_ORDER) * 2);
 	}
 }

@@ -1653,25 +1810,83 @@ static int frag_show(struct seq_file *m,
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
 	unsigned long flags;
-	int order;
+	int order, type;
+	struct list_head *elem;

+	/* Show global fragmentation statistics */
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		if (!zone->present_pages)
 			continue;

 		spin_lock_irqsave(&zone->lock, flags);
-		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-		for (order = 0; order < MAX_ORDER; ++order) {
-			unsigned long nr_bufs = 0;
+		seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
+		unsigned long nr_bufs = 0;
+		for (order = 0; order < MAX_ORDER-1; ++order) {
+			nr_bufs = 0;
+
+			for (type=0; type < ALLOC_TYPES; type++) {
+				list_for_each(elem, &(zone->free_area_lists[type][order].free_list))
+					++nr_bufs;
+			}
+			seq_printf(m, "%6lu ", nr_bufs);
+		}
+
+		/* Scan global list */
+		nr_bufs = 0;
+		list_for_each(elem, &(zone->free_area_global.free_list))
+			++nr_bufs;
+		seq_printf(m, "%6lu ", nr_bufs);
+
+		spin_unlock_irqrestore(&zone->lock, flags);
+		seq_putc(m, '\n');
+	}
+
+	/* Show statistics for each allocation type */
+	seq_printf(m, "\nPer-allocation-type statistics");
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+		if (!zone->present_pages)
+			continue;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		unsigned long nr_bufs = 0;
+		for (type=0; type < ALLOC_TYPES; type++) {
+			seq_printf(m, "\nNode %d, zone %8s, type %10s",
+					pgdat->node_id, zone->name,
+					type_names[type]);
 			struct list_head *elem;
+			for (order = 0; order < MAX_ORDER; ++order) {
+				nr_bufs = 0;

-			list_for_each(elem, &(zone->free_area[order].free_list))
-				++nr_bufs;
-			seq_printf(m, "%6lu ", nr_bufs);
+				list_for_each(elem, &(zone->free_area_lists[type][order].free_list))
+					++nr_bufs;
+				seq_printf(m, "%6lu ", nr_bufs);
+			}
 		}
+
+		/* Scan global list */
+		seq_printf(m, "\n");
+		seq_printf(m, "Node %d, zone %8s, type %10s",
+					pgdat->node_id, zone->name,
+					"MAX_ORDER");
+		nr_bufs = 0;
+		list_for_each(elem, &(zone->free_area_global.free_list))
+			++nr_bufs;
+		seq_printf(m, "%6lu ", nr_bufs);
+
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
 	}
+
+	/* Show bean counters */
+	seq_printf(m, "\nGlobal beancounters\n");
+	seq_printf(m, "Global steals:     %d\n", global_steal);
+	seq_printf(m, "Global refills:    %d\n", global_refill);
+	seq_printf(m, "Fallback count:    %d\n", fallback_count);
+	seq_printf(m, "KernNoRclm allocs: %d\n", kernnorclm_count);
+	seq_printf(m, "KernRclm allocs:   %d\n", kernrclm_count);
+	seq_printf(m, "UserRclm allocs:   %d\n", userrclm_count);
+
+
 	return 0;
 }

