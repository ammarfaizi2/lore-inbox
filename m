Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVBARQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVBARQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVBARQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:16:09 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:57055 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262063AbVBAROo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:14:44 -0500
To: linux-mm@kvack.org
Subject: [PATCH 1/2] Reducing fragmentation through better allocation
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20050201171442.27F1CE5E8@skynet.csn.ul.ie>
Date: Tue,  1 Feb 2005 17:14:42 +0000 (GMT)
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since V6
o Updated to 2.6.11-rc2
o Minor change to allow prezeroing to be a cleaner looking patch

Changelog since V5
o Fixed up gcc-2.95 errors
o Fixed up whitespace damage

Changelog since V4
o No changes. Applies cleanly against 2.6.11-rc1 and 2.6.11-rc1-bk6. Applies
  with offsets to 2.6.11-rc1-mm1

Changelog since V3
o inlined get_pageblock_type() and set_pageblock_type()
o set_pageblock_type() now takes a zone parameter to avoid a call to page_zone()
o When taking from the global pool, do not scan all the low-order lists

Changelog since V2
o Do not to interfere with the "min" decay
o Update the __GFP_BITS_SHIFT properly. Old value broke fsync and probably
  anything to do with asynchronous IO
  
Changelog since V1
o Update patch to 2.6.11-rc1
o Cleaned up bug where memory was wasted on a large bitmap
o Remove code that needed the binary buddy bitmaps
o Update flags to avoid colliding with __GFP_ZERO changes
o Extended fallback_count bean counters to show the fallback count for each
  allocation type
o In-code documentation

Version 1
o Initial release against 2.6.9

This patch divides allocations into three different types of allocations;

UserReclaimable - These are userspace pages that are easily reclaimable. Right
	now, all allocations of GFP_USER, GFP_HIGHUSER and disk buffers are
	in this category. These pages are trivially reclaimed by writing
	the page out to swap or syncing with backing storage

KernelReclaimable - These are pages allocated by the kernel that are easily
	reclaimed. This is stuff like inode caches, dcache, buffer_heads etc.
	These type of pages potentially could be reclaimed by dumping the
	caches and reaping the slabs

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
time, pages of the different types can be clustered together. This means that
if we wanted 2^MAX_ORDER number of pages, we could linearly scan a block of
pages allocated for UserReclaimable and page each of them out.

Fallback is used when there are no 2^MAX_ORDER pages available and there
are no free pages of the desired type. The fallback lists were chosen in a
way that keeps the most easily reclaimable pages together.

Three benchmark results are included. The first is the output of portions
of AIM9 for the vanilla allocator and the modified one;

root@monocle:~# grep _test aim9-vanilla-120.txt
     7 page_test          120.00       9508   79.23333       134696.67 System Allocations & Pages/second
     8 brk_test           120.01       3401   28.33931       481768.19 System Memory Allocations/second
     9 jmp_test           120.00     498718 4155.98333      4155983.33 Non-local gotos/second
    10 signal_test        120.01      11768   98.05850        98058.50 Signal Traps/second
    11 exec_test          120.04       1585   13.20393           66.02 Program Loads/second
    12 fork_test          120.04       1979   16.48617         1648.62 Task Creations/second
    13 link_test          120.01      11174   93.10891         5865.86 Link/Unlink Pairs/second
root@monocle:~# grep _test aim9-mbuddyV3-120.txt
     7 page_test          120.01       9660   80.49329       136838.60 System Allocations & Pages/second
     8 brk_test           120.01       3409   28.40597       482901.42 System Memory Allocations/second
     9 jmp_test           120.00     501533 4179.44167      4179441.67 Non-local gotos/second
    10 signal_test        120.00      11677   97.30833        97308.33 Signal Traps/second
    11 exec_test          120.05       1585   13.20283           66.01 Program Loads/second
    12 fork_test          120.05       1889   15.73511         1573.51 Task Creations/second
    13 link_test          120.01      11089   92.40063         5821.24 Link/Unlink Pairs/second

They show that the allocator performs roughly similar to the standard
allocator so there is negligible slowdown with the extra complexity. The
second benchmark tested the CPU cache usage to make sure it was not getting
clobbered. The test was to repeatadly render a large postcript file 10 times
and get the average. The result is;

==> gsbench-2.6.11-rc1Standard.txt <==
Average: 115.468 real, 115.092 user, 0.337 sys

==> gsbench-2.6.11-rc1MBuddy.txt <==
Average: 115.47 real, 115.136 user, 0.338 sys


So there are no adverse cache effects. The last test is to show that the
allocator can satisfy more high-order allocations, especially under load,
than the standard allocator. The test performs the following;

1. Start updatedb running in the background
2. Load kernel modules that tries to allocate high-order blocks on demand
3. Clean a kernel tree
4. Make 6 copies of the tree. As each copy finishes, a compile starts at -j4
5. Start compiling the primary tree
6. Sleep 3 minutes while the 7 trees are being compiled
7. Use the kernel module to attempt 160 times to allocate a 2^10 block of pages
    - note, it only attempts 160 times, no matter how often it succeeds
    - An allocation is attempted every 1/10th of a second

The result of the allocations under load were;

Vanilla 2.6.11-rc1
Attempted allocations: 160
Success allocs:        3
Failed allocs:         157
% Success:             1

2.6.11-rc1 with modified allocator
Attempted allocations: 160
Success allocs:        81
Failed allocs:         79
% Success:             50

The results show that the modified allocator runs at least as fast as the
normal allocator, has no adverse cache effects but is far less fragmented
and able to satisfy high-order allocations.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-clean/fs/buffer.c linux-2.6.11-rc2-mbuddy/fs/buffer.c
--- linux-2.6.11-rc2-clean/fs/buffer.c	2005-01-22 01:48:21.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy/fs/buffer.c	2005-01-31 12:31:37.000000000 +0000
@@ -1134,7 +1134,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index, 
+					GFP_NOFS | __GFP_USERRCLM);
 	if (!page)
 		return NULL;
 
@@ -2997,7 +2998,8 @@ static void recalc_bh_state(void)
 	
 struct buffer_head *alloc_buffer_head(int gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, 
+						gfp_flags|__GFP_KERNRCLM);
 	if (ret) {
 		preempt_disable();
 		__get_cpu_var(bh_accounting).nr++;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-clean/fs/dcache.c linux-2.6.11-rc2-mbuddy/fs/dcache.c
--- linux-2.6.11-rc2-clean/fs/dcache.c	2005-01-22 01:47:15.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy/fs/dcache.c	2005-01-31 12:31:37.000000000 +0000
@@ -715,7 +715,8 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, 
+				GFP_KERNEL|__GFP_KERNRCLM); 
 	if (!dentry)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-clean/fs/ext2/super.c linux-2.6.11-rc2-mbuddy/fs/ext2/super.c
--- linux-2.6.11-rc2-clean/fs/ext2/super.c	2005-01-22 01:48:28.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy/fs/ext2/super.c	2005-01-31 12:31:37.000000000 +0000
@@ -137,7 +137,7 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-clean/fs/ext3/super.c linux-2.6.11-rc2-mbuddy/fs/ext3/super.c
--- linux-2.6.11-rc2-clean/fs/ext3/super.c	2005-01-22 01:49:22.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy/fs/ext3/super.c	2005-01-31 12:31:37.000000000 +0000
@@ -434,7 +434,7 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-clean/fs/ntfs/inode.c linux-2.6.11-rc2-mbuddy/fs/ntfs/inode.c
--- linux-2.6.11-rc2-clean/fs/ntfs/inode.c	2005-01-22 01:48:57.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy/fs/ntfs/inode.c	2005-01-31 12:31:37.000000000 +0000
@@ -318,7 +318,7 @@ struct inode *ntfs_alloc_big_inode(struc
 
 	ntfs_debug("Entering.");
 	ni = (ntfs_inode *)kmem_cache_alloc(ntfs_big_inode_cache,
-			SLAB_NOFS);
+			SLAB_NOFS|__GFP_KERNRCLM);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
@@ -343,7 +343,8 @@ static inline ntfs_inode *ntfs_alloc_ext
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = (ntfs_inode *)kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS);
+	ni = (ntfs_inode *)kmem_cache_alloc(ntfs_inode_cache, 
+					SLAB_NOFS|__GFP_KERNRCLM);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return ni;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-clean/include/linux/gfp.h linux-2.6.11-rc2-mbuddy/include/linux/gfp.h
--- linux-2.6.11-rc2-clean/include/linux/gfp.h	2005-01-22 01:47:31.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy/include/linux/gfp.h	2005-01-31 12:31:37.000000000 +0000
@@ -38,21 +38,24 @@ struct vm_area_struct;
 #define __GFP_NO_GROW	0x2000	/* Slab internal usage */
 #define __GFP_COMP	0x4000	/* Add compound page metadata */
 #define __GFP_ZERO	0x8000	/* Return zeroed page on success */
+#define __GFP_KERNRCLM 0x10000 /* Kernel page that is easily reclaimable */
+#define __GFP_USERRCLM 0x20000 /* User is a userspace user */
 
-#define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
+#define __GFP_BITS_SHIFT 18	/* Room for 18 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
-			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
+			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
+			__GFP_USERRCLM|__GFP_KERNRCLM)
 
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-clean/include/linux/mmzone.h linux-2.6.11-rc2-mbuddy/include/linux/mmzone.h
--- linux-2.6.11-rc2-clean/include/linux/mmzone.h	2005-01-22 01:48:19.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy/include/linux/mmzone.h	2005-01-31 12:31:37.000000000 +0000
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
@@ -131,8 +135,37 @@ struct zone {
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
-	struct free_area	free_area[MAX_ORDER];
 
+	/*
+	 * There are ALLOC_TYPE number of MAX_ORDER free lists. Once a 
+	 * MAX_ORDER block of pages has been split for an allocation type,
+	 * the whole block is reserved for that type of allocation. The
+	 * types are User Reclaimable, Kernel Reclaimable and Kernel
+	 * Non-reclaimable. The objective is to reduce fragmentation 
+	 * overall
+	 */
+ 	struct free_area	free_area_lists[ALLOC_TYPES][MAX_ORDER];
+
+	/* 
+	 * This is a list of page blocks of 2^MAX_ORDER. Once one of
+	 * these are split, the buddy is added to the appropriate
+	 * free_area_lists. When the buddies are later merged, they
+	 * are placed back here
+	 */
+ 	struct free_area	free_area_global;
+ 
+ 	/*
+ 	 * This map tracks what each 2^MAX_ORDER sized block has been used for.
+	 * Each 2^MAX_ORDER block have pages has 2 bits in this map to remember
+	 * what the block is for. When a page is freed, it's index within this 
+	 * bitmap is calculated using (address >> MAX_ORDER) * 2 . This means 
+	 * that pages will always be freed into the correct list in 
+	 * free_area_lists
+	 *
+	 * The bits are set when a 2^MAX_ORDER block of pages is split
+ 	 */
+
+ 	unsigned long		*free_area_usemap;
 
 	ZONE_PADDING(_pad1_)
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-clean/mm/page_alloc.c linux-2.6.11-rc2-mbuddy/mm/page_alloc.c
--- linux-2.6.11-rc2-clean/mm/page_alloc.c	2005-01-22 01:46:59.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy/mm/page_alloc.c	2005-02-01 15:10:29.000000000 +0000
@@ -46,9 +46,30 @@ unsigned long totalhigh_pages;
 long nr_swap_pages;
 int sysctl_lower_zone_protection = 0;
 
+/* Bean counters for the per-type buddy allocator */
+int fallback_count[ALLOC_TYPES] = { 0, 0, 0};
+int global_steal=0;
+int global_refill=0;
+int kernnorclm_count=0;
+int kernrclm_count=0;
+int userrclm_count=0;
+
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
 
+/**
+ * The allocator tries to put allocations of the same type in the
+ * same 2^MAX_ORDER blocks of pages. When memory is low, this may
+ * not be possible so this describes what order they should fall
+ * back on
+ */
+int fallback_allocs[ALLOC_TYPES][ALLOC_TYPES] = { 
+	{ ALLOC_KERNNORCLM, ALLOC_KERNRCLM,   ALLOC_USERRCLM },
+	{ ALLOC_KERNRCLM,   ALLOC_KERNNORCLM, ALLOC_USERRCLM },
+	{ ALLOC_USERRCLM,   ALLOC_KERNNORCLM, ALLOC_KERNRCLM }
+};
+ 
+
 /*
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
@@ -57,6 +78,7 @@ struct zone *zone_table[1 << (ZONES_SHIF
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
+static char *type_names[ALLOC_TYPES] = { "KernNoRclm", "KernRclm", "UserRclm"};
 int min_free_kbytes = 1024;
 
 unsigned long __initdata nr_kernel_pages;
@@ -103,6 +125,46 @@ static void bad_page(const char *functio
 	tainted |= TAINT_BAD_PAGE;
 }
 
+/*
+ * Return what type of use the 2^MAX_ORDER block of pages is in use for
+ * that the given page is part of
+ */
+static inline int get_pageblock_type(struct page *page) {
+	struct zone *zone = page_zone(page);
+	int bitidx = ((page - zone->zone_mem_map) >> MAX_ORDER) * 2;
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
+static inline void set_pageblock_type(struct page *page, 
+					struct zone *zone, int type) {
+	int bit1, bit2;
+	int bitidx = ((page - zone->zone_mem_map) >> MAX_ORDER) * 2;
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
@@ -231,6 +293,9 @@ static inline void __free_pages_bulk (st
 	unsigned long page_idx;
 	struct page *coalesced;
 	int order_size = 1 << order;
+	struct free_area *area;
+	struct free_area *freelist;
+	int alloctype;
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
@@ -240,9 +305,12 @@ static inline void __free_pages_bulk (st
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
 
+	/* Select the areas to place free pages on */
+	alloctype = get_pageblock_type(page);
+	freelist = zone->free_area_lists[alloctype];
+
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
-		struct free_area *area;
 		struct page *buddy;
 		int buddy_idx;
 
@@ -254,16 +322,29 @@ static inline void __free_pages_bulk (st
 			break;
 		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
+		area = freelist + order;
 		area->nr_free--;
 		rmv_page_order(buddy);
 		page_idx &= buddy_idx;
 		order++;
 	}
+
+	/*
+	 * If a MAX_ORDER block of pages is being freed, it is
+	 * no longer reserved for a particular type of allocation
+	 * so put it in the global list
+	 */
+	if (order >= MAX_ORDER-1) {
+		area = &(zone->free_area_global);
+		global_refill++;
+	} else {
+		area = freelist + order;
+	}
+
 	coalesced = base + page_idx;
 	set_page_order(coalesced, order);
-	list_add(&coalesced->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	list_add(&coalesced->lru, &area->free_list);
+	area->nr_free++;
 }
 
 static inline void free_pages_check(const char *function, struct page *page)
@@ -310,6 +391,7 @@ free_pages_bulk(struct zone *zone, int c
 	zone->pages_scanned = 0;
 	while (!list_empty(list) && count--) {
 		page = list_entry(list->prev, struct page, lru);
+
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
 		__free_pages_bulk(page, base, zone, order);
@@ -420,16 +502,43 @@ static void prep_new_page(struct page *p
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order, int flags)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
+	int global_split=0;
+	int *fallback_list;
 
-	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
-		if (list_empty(&area->free_list))
+	/* Select area to use based on gfp_flags */
+	int alloctype;
+	int retry_count=0;
+	int startorder = order;
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
+	fallback_list = fallback_allocs[alloctype];
+
+retry:
+	alloctype = fallback_list[retry_count];
+	area = zone->free_area_lists[alloctype] + startorder;
+	for (current_order = startorder; 
+			current_order < MAX_ORDER; ++current_order) {
+
+		if (list_empty(&area->free_list)) {
+			area++;
 			continue;
+		}
 
 		page = list_entry(area->free_list.next, struct page, lru);
 		list_del(&page->lru);
@@ -439,6 +548,36 @@ static struct page *__rmqueue(struct zon
 		return expand(zone, page, order, current_order, area);
 	}
 
+	/* Take from the global pool if this is the first attempt */
+	if (!global_split && !list_empty(&(zone->free_area_global.free_list))){
+		/*
+		 * Remove a MAX_ORDER block from the global pool and add
+		 * it to the list of desired alloc_type
+		 */
+		page = list_entry(zone->free_area_global.free_list.next,
+				struct page, lru);
+		list_del(&page->lru);
+		list_add(&page->lru, 
+			&(zone->free_area_lists[alloctype][MAX_ORDER-1].free_list));
+		global_steal++;
+		global_split=1;
+
+		/* Mark this block of pages as for use with this alloc type */
+		set_pageblock_type(page, zone, alloctype);
+		startorder = MAX_ORDER-1;
+
+		goto retry;
+	}
+	
+	/*
+	 * Here, the alloc type lists has been depleted as well as the global
+	 * pool, so fallback
+	 */
+	retry_count++;
+	startorder=order;
+	fallback_count[alloctype]++;
+	if (retry_count != ALLOC_TYPES) goto retry;
+
 	return NULL;
 }
 
@@ -448,7 +587,8 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int gfp_flags)
 {
 	unsigned long flags;
 	int i;
@@ -457,7 +597,7 @@ static int rmqueue_bulk(struct zone *zon
 	
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, gfp_flags);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -493,7 +633,7 @@ static void __drain_pages(unsigned int c
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
-	int order;
+	int order, type;
 	struct list_head *curr;
 
 	if (!zone->spanned_pages)
@@ -503,14 +643,17 @@ void mark_free_pages(struct zone *zone)
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
 
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
-			unsigned long start_pfn, i;
+	for (type=0; type < ALLOC_TYPES; type++) {
 
-			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
+		for (order = MAX_ORDER - 1; order >= 0; --order)
+			list_for_each(curr, &zone->free_area_lists[type][order].free_list) {
+				unsigned long start_pfn, i;
+	
+				start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
 
-			for (i=0; i < (1<<order); i++)
-				SetPageNosaveFree(pfn_to_page(start_pfn+i));
+				for (i=0; i < (1<<order); i++)
+					SetPageNosaveFree(pfn_to_page(start_pfn+i));
+		}
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -612,14 +755,15 @@ buffered_rmqueue(struct zone *zone, int 
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
@@ -631,7 +775,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, gfp_flags);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -658,6 +802,7 @@ int zone_watermark_ok(struct zone *z, in
 {
 	/* free_pages my go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
+	struct free_area *kernnorclm, *kernrclm, *userrclm;
 	int o;
 
 	if (gfp_high)
@@ -667,9 +812,15 @@ int zone_watermark_ok(struct zone *z, in
 
 	if (free_pages <= min + z->protection[alloc_type])
 		return 0;
+	kernnorclm = z->free_area_lists[ALLOC_KERNNORCLM];
+	kernrclm = z->free_area_lists[ALLOC_KERNRCLM];
+	userrclm = z->free_area_lists[ALLOC_USERRCLM];
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
+		free_pages -= (
+			kernnorclm[o].nr_free +
+			kernrclm[o].nr_free +
+			userrclm[o].nr_free) << o;
 
 		/* Require fewer higher order pages to be free */
 		min >>= 1;
@@ -1136,6 +1287,7 @@ void show_free_areas(void)
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	int type;
 
 	for_each_zone(zone) {
 		show_node(zone);
@@ -1228,8 +1380,10 @@ void show_free_areas(void)
 
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = zone->free_area[order].nr_free;
-			total += nr << order;
+			for (type=0; type < ALLOC_TYPES; type++) {
+				nr = zone->free_area_lists[type][order].nr_free;
+				total += nr << order;
+			}
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
@@ -1527,10 +1681,22 @@ void zone_init_free_lists(struct pglist_
 				unsigned long size)
 {
 	int order;
-	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		zone->free_area[order].nr_free = 0;
+ 	int type;
+ 	struct free_area *area;
+
+ 	/* Initialse the three size ordered lists of free_areas */
+	for (type=0; type < ALLOC_TYPES; type++) {
+		for (order = 0; order < MAX_ORDER; order++) {
+			area = zone->free_area_lists[type];
+ 
+			INIT_LIST_HEAD(&area[order].free_list);
+			area[order].nr_free = 0;
+		}
 	}
+ 
+ 	/* Initialise the global pool of 2^size pages */
+ 	INIT_LIST_HEAD(&zone->free_area_global.free_list);
+	zone->free_area_global.nr_free=0;
 }
 
 #ifndef __HAVE_ARCH_MEMMAP_INIT
@@ -1551,6 +1717,7 @@ static void __init free_area_init_core(s
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 	int cpu, nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+	unsigned long usemapsize;
 
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
@@ -1649,6 +1816,22 @@ static void __init free_area_init_core(s
 		zone_start_pfn += size;
 
 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+
+		/* Calculate size of required bitmap */
+		/* - Number of MAX_ORDER blocks in the zone */
+		usemapsize = (size + (1 << MAX_ORDER)) >> MAX_ORDER;
+
+		/* - Two bits to record what type of block it is */
+		usemapsize = (usemapsize * 2 + 8) / 8;
+
+		zone->free_area_usemap = 
+			(unsigned long *)alloc_bootmem_node(pgdat, usemapsize);
+
+		memset((unsigned long *)zone->free_area_usemap,
+				ALLOC_KERNNORCLM, usemapsize);
+
+		printk(KERN_DEBUG "  %s zone: %lu pages, %lu real pages, usemap size:%lu\n",
+				zone_names[j], size, realsize, usemapsize);
 	}
 }
 
@@ -1726,19 +1909,88 @@ static int frag_show(struct seq_file *m,
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
 	unsigned long flags;
-	int order;
+	int order, type;
+	struct list_head *elem;
+ 	unsigned long nr_bufs = 0;
 
+ 	/* Show global fragmentation statistics */
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		if (!zone->present_pages)
 			continue;
 
 		spin_lock_irqsave(&zone->lock, flags);
-		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-		for (order = 0; order < MAX_ORDER; ++order)
-			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+ 		seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
+ 		for (order = 0; order < MAX_ORDER-1; ++order) {
+ 			nr_bufs = 0;
+ 
+ 			for (type=0; type < ALLOC_TYPES; type++) {
+ 				list_for_each(elem, &(zone->free_area_lists[type][order].free_list))
+ 					++nr_bufs;
+ 			}
+ 			seq_printf(m, "%6lu ", nr_bufs);
+ 		}
+ 
+ 		/* Scan global list */
+ 		nr_bufs = 0;
+ 		list_for_each(elem, &(zone->free_area_global.free_list))
+ 			++nr_bufs;
+ 		seq_printf(m, "%6lu ", nr_bufs);
+ 
+ 		spin_unlock_irqrestore(&zone->lock, flags);
+ 		seq_putc(m, '\n');
+ 	}
+ 
+ 	/* Show statistics for each allocation type */
+ 	seq_printf(m, "\nPer-allocation-type statistics");
+ 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+ 		if (!zone->present_pages)
+ 			continue;
+ 
+ 		spin_lock_irqsave(&zone->lock, flags);
+ 		for (type=0; type < ALLOC_TYPES; type++) {
+			struct list_head *elem;
+ 			seq_printf(m, "\nNode %d, zone %8s, type %10s", 
+ 					pgdat->node_id, zone->name,
+ 					type_names[type]);
+ 			for (order = 0; order < MAX_ORDER; ++order) {
+ 				nr_bufs = 0;
+
+ 				list_for_each(elem, &(zone->free_area_lists[type][order].free_list))
+ 					++nr_bufs;
+ 				seq_printf(m, "%6lu ", nr_bufs);
+ 			}
+		}
+ 
+ 		/* Scan global list */
+ 		seq_printf(m, "\n");
+ 		seq_printf(m, "Node %d, zone %8s, type %10s", 
+ 					pgdat->node_id, zone->name,
+ 					"MAX_ORDER");
+ 		nr_bufs = 0;
+ 		list_for_each(elem, &(zone->free_area_global.free_list))
+ 			++nr_bufs;
+ 		seq_printf(m, "%6lu ", nr_bufs);
+ 
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
 	}
+ 
+ 	/* Show bean counters */
+ 	seq_printf(m, "\nGlobal beancounters\n");
+ 	seq_printf(m, "Global steals:     %d\n", global_steal);
+ 	seq_printf(m, "Global refills:    %d\n", global_refill);
+ 	seq_printf(m, "KernNoRclm allocs: %d\n", kernnorclm_count);
+ 	seq_printf(m, "KernRclm allocs:   %d\n", kernrclm_count);
+ 	seq_printf(m, "UserRclm allocs:   %d\n", userrclm_count);
+ 	seq_printf(m, "%-10s Fallback count: %d\n", type_names[0], 
+							fallback_count[0]);
+ 	seq_printf(m, "%-10s Fallback count: %d\n", type_names[1],
+							fallback_count[1]);
+ 	seq_printf(m, "%-10s Fallback count: %d\n", type_names[2],
+							fallback_count[2]);
+ 
+ 
+
 	return 0;
 }
 
