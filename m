Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVECQsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVECQsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVECQsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:48:51 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:51604 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261322AbVECQov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:44:51 -0400
To: linux-mm@kvack.org
Subject: [PATCH] Avoiding external fragmentation with a placement policy Version 10
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Message-Id: <20050503164452.A3AB9E592@skynet.csn.ul.ie>
Date: Tue,  3 May 2005 17:44:52 +0100 (IST)
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since V9
o Tightened what pools are used for fallbacks, less likely to fragment
o Many micro-optimisations to have the same performance as the standard 
  allocator. Modified allocator now faster than standard allocator using
  gcc 3.3.5
o Add counter for splits/coalescing

Changelog since V8
o rmqueue_bulk() allocates pages in large blocks and breaks it up into the
  requested size. Reduces the number of calls to __rmqueue()
o Beancounters are now a configurable option under "Kernel Hacking"
o Broke out some code into inline functions to be more Hotplug-friendly
o Increased the size of reserve for fallbacks from 10% to 12.5%. 

Changelog since V7
o Updated to 2.6.11-rc4
o Lots of cleanups, mainly related to beancounters
o Fixed up a miscalculation in the bitmap size as pointed out by Mike Kravetz
  (thanks Mike)
o Introduced a 10% reserve for fallbacks. Drastically reduces the number of
  kernnorclm allocations that go to the wrong places
o Don't trigger OOM when large allocations are involved

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

This patch is designed to reduce fragmentation in the standard buddy allocator
without impairing the performance of the allocator. High fragmentation in
the standard binary buddy allocator means that high-order allocations can
rarely be serviced. This patch works by dividing allocations into three
different types of allocations;

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

Instead of having one global MAX_ORDER-sized array of free lists, there
are four, one for each type of allocation and another 12.5% reserve for
fallbacks. Finally, there is a list of pages of size 2^MAX_ORDER which is
a global pool of the largest pages the kernel deals with.

Once a 2^MAX_ORDER block of pages it split for a type of allocation, it is
added to the free-lists for that type, in effect reserving it. Hence, over
time, pages of the different types can be clustered together. This means that
if we wanted 2^MAX_ORDER number of pages, we could linearly scan a block of
pages allocated for UserReclaimable and page each of them out.

Fallback is used when there are no 2^MAX_ORDER pages available and there
are no free pages of the desired type. The fallback lists were chosen in a
way that keeps the most easily reclaimable pages together.

Three benchmark results are included all based on a 2.6.12-rc3 kernel
compiled with gcc 3.3.5 (it is known that gcc 2.95.4 results in significantly
different results). The first is the output of portions of AIM9 for the
vanilla allocator and the modified one;

(Tests run with bench-aim9.sh from VMRegress 0.14)
2.6.12-rc3-standard
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 add_double          60.03       1536   25.58721       460569.72 Thousand Double Precision Additions/second
     2 add_float           60.01       2303   38.37694       460523.25 Thousand Single Precision Additions/second
     3 add_long            60.01       1422   23.69605      1421763.04 Thousand Long Integer Additions/second
     4 add_int             60.01       1422   23.69605      1421763.04 Thousand Integer Additions/second
     5 add_short           60.01       3554   59.22346      1421363.11 Thousand Short Integer Additions/second
     6 creat-clo           60.02       1119   18.64379        18643.79 File Creations and Closes/second
     7 page_test           60.01       4273   71.20480       121048.16 System Allocations & Pages/second
     8 brk_test            60.03       1574   26.22022       445743.79 System Memory Allocations/second
     9 jmp_test            60.00     249505 4158.41667      4158416.67 Non-local gotos/second
    10 signal_test         60.01       5666   94.41760        94417.60 Signal Traps/second
    11 exec_test           60.04        781   13.00799           65.04 Program Loads/second
    12 fork_test           60.02        923   15.37821         1537.82 Task Creations/second
    13 link_test           60.01       6107  101.76637         6411.28 Link/Unlink Pairs/second

2.6.12-rc3-mbuddy-v10
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 add_double          60.01       1551   25.84569       465222.46 Thousand Double Precision Additions/second
     2 add_float           60.01       2327   38.77687       465322.45 Thousand Single Precision Additions/second
     3 add_long            60.04       1437   23.93404      1436042.64 Thousand Long Integer Additions/second
     4 add_int             60.04       1437   23.93404      1436042.64 Thousand Integer Additions/second
     5 add_short           60.01       3590   59.82336      1435760.71 Thousand Short Integer Additions/second
     6 creat-clo           60.04       1136   18.92072        18920.72 File Creations and Closes/second
     7 page_test           60.01       4344   72.38794       123059.49 System Allocations & Pages/second
     8 brk_test            60.01       1597   26.61223       452407.93 System Memory Allocations/second
     9 jmp_test            60.00     253925 4232.08333      4232083.33 Non-local gotos/second
    10 signal_test         60.01       5676   94.58424        94584.24 Signal Traps/second
    11 exec_test           60.05        801   13.33888           66.69 Program Loads/second
    12 fork_test           60.04       1039   17.30513         1730.51 Task Creations/second
    13 link_test           60.00       6169  102.81667         6477.45 Link/Unlink Pairs/second

Difference in performance operations report generated by diff-aim9.sh from VMRegress 0.14
N  Test          Standard   MBuddy V10  Diff     % diff Test description
                 Ops/sec    Ops/sec     Ops/sec
-- ----------    ---------  ----------  -------- ------ ----------------
 1 add_double    460569.72  465222.46    4652.74  1.01% Thousand Double Precision Additions/second
 2 add_float     460523.25  465322.45    4799.20  1.04% Thousand Single Precision Additions/second
 3 add_long     1421763.04 1436042.64   14279.60  1.00% Thousand Long Integer Additions/second
 4 add_int      1421763.04 1436042.64   14279.60  1.00% Thousand Integer Additions/second
 5 add_short    1421363.11 1435760.71   14397.60  1.01% Thousand Short Integer Additions/second
 7 page_test     121048.16  123059.49    2011.33  1.66% System Allocations & Pages/second
 8 brk_test      445743.79  452407.93    6664.14  1.50% System Memory Allocations/second
 9 jmp_test     4158416.67 4232083.33   73666.66  1.77% Non-local gotos/second
10 signal_test    94417.60   94584.24     166.64  0.18% Signal Traps/second
11 exec_test         65.04      66.69       1.65  2.54% Program Loads/second
12 fork_test       1537.82    1730.51     192.69 12.53% Task Creations/second
13 link_test       6411.28    6477.45      66.17  1.03% Link/Unlink Pairs/second

The aim9 results show that there are consistent improvements for common
page-related operations. The results are compiler dependant and there are
variances of 1-2% between versions.

The second benchmark tested the CPU cache usage to make sure it was not
getting clobbered. The test was to repeatedly render a large postscript file
10 times and get the average. The result is;

gsbench-2.6.12-rc3-standard
Average: 42.936 real, 42.856 user, 0.033 sys

gsbench-2.6.11-mbuddy-v10
Average: 42.903 real, 42.831 user, 0.037 sys

So there are no adverse cache effects and at times, the modified allocator
kernel is fractionally faster. The last test is to show that the allocator
can satisfy more high-order allocations, especially under load, than the
standard allocator. The test performs the following;

1. Start updatedb running in the background
2. Load kernel modules that tries to allocate high-order blocks on demand
3. Clean a kernel tree
4. Make 6 copies of the tree. As each copy finishes, a compile starts at -j4
5. Start compiling the primary tree
6. Sleep 3 minutes while the 7 trees are being compiled
7. Use the kernel module to attempt 160 times to allocate a 2^10 block of pages
    - note, it only attempts 160 times, no matter how often it succeeds
    - An allocation is attempted every 1/10th of a second
    - Performance will get badly shot as it forces consider amounts of pageout

The result of the allocations under load were;

2.6.12-rc3 Standard
Order:                 10
Attempted allocations: 160
Success allocs:        24
Failed allocs:         136
% Success:            15
Test completed successfully

2.6.12-rc3 MBuddy V10
Order:                 10
Attempted allocations: 160
Success allocs:        136
Failed allocs:         24
% Success:            85
Test completed successfully

It is important to note that the standard allocator invoked the out-of-memory
killer so often that it killed almost all available processes including X,
sshd and all instances of make and gcc. The patch with the placement policy
never invoked the OOM killer. The downside of the mbuddy allocator is that
it takes a long time for it to free up the MAX_ORDER sized pages as pages
are freed in LRU order.

At rest, it is known that the modified allocator can allocate almost all
160 MAX_ORDER-1 blocks of pages. However, it takes a few attempts and a
while at rest making it an unrealistic test. However, it shows that with
a linear scanner freeing pages, we could almost guarantee availability of
large pages At rest after all the compilations have finished, the results are

The results show that the modified allocator as fast, and often faster the
normal allocator, has no adverse cache effects but is far less fragmented
and able to satisfy high-order allocations.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/fs/buffer.c linux-2.6.12-rc3-mbuddy-v10n/fs/buffer.c
--- linux-2.6.12-rc3-clean/fs/buffer.c	2005-04-21 01:03:15.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/fs/buffer.c	2005-05-03 09:21:15.000000000 +0100
@@ -1136,7 +1136,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index, 
+					GFP_NOFS | __GFP_USERRCLM);
 	if (!page)
 		return NULL;
 
@@ -3054,7 +3055,8 @@ static void recalc_bh_state(void)
 	
 struct buffer_head *alloc_buffer_head(unsigned int __nocast gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, 
+						gfp_flags|__GFP_KERNRCLM);
 	if (ret) {
 		preempt_disable();
 		__get_cpu_var(bh_accounting).nr++;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/fs/dcache.c linux-2.6.12-rc3-mbuddy-v10n/fs/dcache.c
--- linux-2.6.12-rc3-clean/fs/dcache.c	2005-04-21 01:03:15.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/fs/dcache.c	2005-05-03 09:21:16.000000000 +0100
@@ -719,7 +719,8 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, 
+				GFP_KERNEL|__GFP_KERNRCLM); 
 	if (!dentry)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/fs/ext2/super.c linux-2.6.12-rc3-mbuddy-v10n/fs/ext2/super.c
--- linux-2.6.12-rc3-clean/fs/ext2/super.c	2005-04-21 01:03:15.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/fs/ext2/super.c	2005-05-03 09:21:17.000000000 +0100
@@ -137,7 +137,7 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/fs/ext3/super.c linux-2.6.12-rc3-mbuddy-v10n/fs/ext3/super.c
--- linux-2.6.12-rc3-clean/fs/ext3/super.c	2005-04-21 01:03:15.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/fs/ext3/super.c	2005-05-03 09:21:18.000000000 +0100
@@ -432,7 +432,7 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/fs/ntfs/inode.c linux-2.6.12-rc3-mbuddy-v10n/fs/ntfs/inode.c
--- linux-2.6.12-rc3-clean/fs/ntfs/inode.c	2005-04-21 01:03:15.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/fs/ntfs/inode.c	2005-05-03 09:21:21.000000000 +0100
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/include/linux/gfp.h linux-2.6.12-rc3-mbuddy-v10n/include/linux/gfp.h
--- linux-2.6.12-rc3-clean/include/linux/gfp.h	2005-04-21 01:03:16.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/include/linux/gfp.h	2005-05-03 09:21:34.000000000 +0100
@@ -38,21 +38,24 @@ struct vm_area_struct;
 #define __GFP_NO_GROW	0x2000u	/* Slab internal usage */
 #define __GFP_COMP	0x4000u	/* Add compound page metadata */
 #define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
+#define __GFP_KERNRCLM 0x10000u /* Kernel page that is easily reclaimable */
+#define __GFP_USERRCLM 0x20000u /* User is a userspace user */
 
-#define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
+#define __GFP_BITS_SHIFT 18	/* Room for 16 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
-			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
+			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|\
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/include/linux/mmzone.h linux-2.6.12-rc3-mbuddy-v10n/include/linux/mmzone.h
--- linux-2.6.12-rc3-clean/include/linux/mmzone.h	2005-04-21 01:03:16.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/include/linux/mmzone.h	2005-05-03 12:33:54.000000000 +0100
@@ -20,6 +20,12 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
+#define ALLOC_TYPES 4
+#define BITS_PER_ALLOC_TYPE 2
+#define ALLOC_KERNNORCLM 0
+#define ALLOC_KERNRCLM 1
+#define ALLOC_USERRCLM 2
+#define ALLOC_FALLBACK 3
 
 struct free_area {
 	struct list_head	free_list;
@@ -128,9 +134,64 @@ struct zone {
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
-	struct free_area	free_area[MAX_ORDER];
 
+ 	/*
+ 	 * The map tracks what each 2^MAX_ORDER-1 sized block is being used for.
+	 * Each 2^MAX_ORDER block have pages has BITS_PER_ALLOC_TYPE bits in 
+	 * this map to remember what the block is for. When a page is freed, 
+	 * it's index within this bitmap is calculated in get_pageblock_type()
+	 * This means that pages will always be freed into the correct list in 
+	 * free_area_lists
+	 *
+	 * The bits are set when a 2^MAX_ORDER block of pages is split
+ 	 */
+ 	unsigned long		*free_area_usemap;
 
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
+	 * This is a list of page blocks of 2^MAX_ORDER-1. Once one of
+	 * these are split, the buddy is added to the appropriate
+	 * free_area_lists. When the buddies are later merged, they
+	 * are placed back here
+	 */
+ 	struct free_area	free_area_global;
+ 
+	/*
+	 * Beancounter that keeps track of how many times a MAX_ORDER-1 block
+	 * of free pages has been added to the global free list
+	 */
+	unsigned long global_refill;
+	unsigned long global_steal;
+
+	/*
+	 * A percentage of a zone is reserved for falling back to. Without
+	 * a fallback, memory will slowly fragment over time meaning the
+	 * placement policy only delays the fragmentation problem, not
+	 * fixes it
+	 */
+	unsigned long fallback_reserve;
+#ifdef CONFIG_ALLOCSTATS
+	/*
+	 * These are beancounters that track how the placement policy
+	 * of the buddy allocator is performing
+	 */
+	unsigned long fallback_count[ALLOC_TYPES];
+	unsigned long alloc_count[ALLOC_TYPES];
+	unsigned long reserve_count[ALLOC_TYPES];
+	unsigned long kernnorclm_full_steal;
+	unsigned long kernnorclm_partial_steal;
+	unsigned long bulk_requests[MAX_ORDER];
+	unsigned long bulk_alloced[MAX_ORDER];
+#endif
 	ZONE_PADDING(_pad1_)
 
 	/* Fields commonly accessed by the page reclaim scanner */
@@ -212,6 +273,38 @@ struct zone {
 	char			*name;
 } ____cacheline_maxaligned_in_smp;
 
+#define inc_globalrefill_count(zone) zone->global_refill++
+#define inc_globalsteal_count(zone) zone->global_steal++
+#ifdef CONFIG_ALLOCSTATS
+#define inc_fallback_count(zone, type) zone->fallback_count[type]++
+#define inc_alloc_count(zone, type) zone->alloc_count[type]++
+#define inc_kernnorclm_partial_steal(zone) zone->kernnorclm_partial_steal++
+#define inc_kernnorclm_full_steal(zone) zone->kernnorclm_full_steal++
+#define inc_bulk_request(zone, order) zone->bulk_requests[order]++
+#define inc_bulk_alloced(zone,order) zone->bulk_alloced[order]++
+static inline void inc_reserve_count(struct zone *zone, int type) {
+	if (type == ALLOC_FALLBACK) zone->fallback_reserve++;
+	zone->reserve_count[type]++;
+}
+
+static inline void dec_reserve_count(struct zone *zone, int type) {
+	if (type == ALLOC_FALLBACK && zone->fallback_reserve) 
+		zone->fallback_reserve--;
+	if (zone->reserve_count[type]) zone->reserve_count[type]--;
+}
+#else
+#define inc_fallback_count(zone, type) do {} while (0)
+#define inc_alloc_count(zone, type) do {} while (0)
+#define inc_reserve_count(zone, type) \
+	type == ALLOC_FALLBACK ? zone->fallback_reserve++ : 0
+#define dec_reserve_count(zone, type) \
+	(type == ALLOC_FALLBACK && zone->fallback_reserve) ? \
+		zone->fallback_reserve-- : 0
+#define inc_kernnorclm_partial_steal(zone) do {} while (0)
+#define inc_kernnorclm_full_steal(zone) do {} while (0)
+#define inc_bulk_request(zone, order) do {} while (0)
+#define inc_bulk_alloced(zone,order) do {} while (0)
+#endif
 
 /*
  * The "priority" of VM scanning is how much of the queues we will scan in one
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/lib/Kconfig.debug linux-2.6.12-rc3-mbuddy-v10n/lib/Kconfig.debug
--- linux-2.6.12-rc3-clean/lib/Kconfig.debug	2005-04-21 01:03:16.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/lib/Kconfig.debug	2005-05-03 09:21:39.000000000 +0100
@@ -58,6 +58,17 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+config ALLOCSTATS
+	bool "Collection buddy allocator statistics"
+	depends on DEBUG_KERNEL && PROC_FS
+	help
+	  If you say Y here, additional code will be inserted into the
+	  page allocator routines to collect statistics on the allocator
+	  behavior and provide them in /proc/buddyinfo. These stats are
+	  useful for measuring fragmentation in the buddy allocator. If
+	  you are not debugging or measuring the allocator, you can say N
+	  to avoid the slight overhead this adds.
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/mm/mmap.c linux-2.6.12-rc3-mbuddy-v10n/mm/mmap.c
--- linux-2.6.12-rc3-clean/mm/mmap.c	2005-04-21 01:03:16.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/mm/mmap.c	2005-05-03 14:13:41.000000000 +0100
@@ -1868,7 +1868,7 @@ unsigned long do_brk(unsigned long addr,
 	/*
 	 * create a vma struct for an anonymous mapping
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL | __GFP_USERRCLM);
 	if (!vma) {
 		vm_unacct_memory(len >> PAGE_SHIFT);
 		return -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc3-clean/mm/page_alloc.c linux-2.6.12-rc3-mbuddy-v10n/mm/page_alloc.c
--- linux-2.6.12-rc3-clean/mm/page_alloc.c	2005-04-21 01:03:16.000000000 +0100
+++ linux-2.6.12-rc3-mbuddy-v10n/mm/page_alloc.c	2005-05-03 13:17:26.000000000 +0100
@@ -62,6 +62,25 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
 
+/**
+ * The allocator tries to put allocations of the same type in the
+ * same 2^MAX_ORDER-1 blocks of pages. When memory is low, this may
+ * not be possible so this describes what order they should fall
+ * back on
+ *
+ * The order of the fallback is chosen to keep the userrclm and kernrclm
+ * pools as low as fragmentation as possible. The FALLBACK zone is never
+ * directly used but acts as a reserve to allocate pages from when the
+ * normal pools are depleted.
+ *
+ */
+int fallback_allocs[ALLOC_TYPES][ALLOC_TYPES] = { 
+	{ALLOC_KERNNORCLM, ALLOC_FALLBACK,   ALLOC_KERNRCLM,   ALLOC_USERRCLM},
+	{ALLOC_KERNRCLM,   ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_USERRCLM},
+	{ALLOC_USERRCLM,   ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_KERNRCLM},
+	{ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_KERNRCLM,   ALLOC_USERRCLM}
+};
+
 /*
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
@@ -70,6 +89,8 @@ struct zone *zone_table[1 << (ZONES_SHIF
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
+static char *type_names[ALLOC_TYPES] = { "KernNoRclm", "KernRclm", 
+					  "UserRclm", "Fallback"};
 int min_free_kbytes = 1024;
 
 unsigned long __initdata nr_kernel_pages;
@@ -116,6 +137,73 @@ static void bad_page(const char *functio
 	tainted |= TAINT_BAD_PAGE;
 }
 
+/*
+ * Return what type of page is being allocated from this 2^MAX_ORDER-1 block 
+ * of pages. A bitmap is used as a char array performs slightly slower
+ */
+static inline unsigned int get_pageblock_type(struct zone *zone, struct page *page) {
+	int bitidx = ((page - zone->zone_mem_map) >> (MAX_ORDER-1)) * 
+			BITS_PER_ALLOC_TYPE;
+	unsigned int type = !!test_bit(bitidx, zone->free_area_usemap);
+	int i;
+
+	for (i=1; i < BITS_PER_ALLOC_TYPE; i++) {
+		type = (type << 1) | (!!test_bit(bitidx+i, zone->free_area_usemap));
+	}
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	if (type >= ALLOC_TYPES) {
+		printk("\nBogus type in get_pageblock_type: %u\n", type);
+		BUG();
+	}
+#endif
+	return type;
+}
+
+/*
+ * Reserve a block of pages for an allocation type
+ */
+static inline void set_pageblock_type(struct zone *zone, struct page *page, 
+					int type) {
+	int bitidx = ((page - zone->zone_mem_map) >> (MAX_ORDER-1)) * 
+			BITS_PER_ALLOC_TYPE;
+
+	/* Bits set match the alloc types defined in mmzone.h */
+	if (type == ALLOC_KERNRCLM) {
+		clear_bit(bitidx, zone->free_area_usemap);
+		set_bit(bitidx+1, zone->free_area_usemap);
+		return;
+	}
+
+	if (type == ALLOC_USERRCLM) {
+		set_bit(bitidx, zone->free_area_usemap);
+		clear_bit(bitidx+1, zone->free_area_usemap);
+		return;
+	}
+
+	if (type == ALLOC_FALLBACK) {
+		set_bit(bitidx, zone->free_area_usemap);
+		set_bit(bitidx+1, zone->free_area_usemap);
+		return;
+	}
+
+	clear_bit(bitidx, zone->free_area_usemap);
+	clear_bit(bitidx+1, zone->free_area_usemap);
+}
+
+/*
+ * 12.5% of a zone is reserved for allocations to fallback to. This function
+ * calculates how many 2**(MAX_ORDER-1) blocks of pages represent 12.5% of 
+ * the zone and if that many blocks are currently reserved for fallbacks
+ * or not
+ */
+#define min_fallback_reserve(zone) \
+	((zone->present_pages / (1 << (MAX_ORDER-1))) / 8)
+#define need_min_fallback_reserve(zone) \
+	(zone->global_refill - zone->global_steal <= min_fallback_reserve(zone))
+#define is_min_fallback_reserved(zone) \
+	(zone->fallback_reserve >= min_fallback_reserve(zone))
+
 #ifndef CONFIG_HUGETLB_PAGE
 #define prep_compound_page(page, order) do { } while (0)
 #define destroy_compound_page(page, order) do { } while (0)
@@ -274,6 +362,9 @@ static inline void __free_pages_bulk (st
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	struct free_area *area;
+	struct free_area *freelist;
+	int alloctype;
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
@@ -283,10 +374,13 @@ static inline void __free_pages_bulk (st
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
 
+	/* Select the areas to place free pages on */
+	alloctype = get_pageblock_type(zone, page);
+	freelist = zone->free_area_lists[alloctype];
+	
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
 
 		combined_idx = __find_combined_index(page_idx, order);
@@ -297,16 +391,30 @@ static inline void __free_pages_bulk (st
 		if (!page_is_buddy(buddy, order))
 			break;		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
+		area = freelist + order;
 		area->nr_free--;
 		rmv_page_order(buddy);
 		page = page + (combined_idx - page_idx);
 		page_idx = combined_idx;
 		order++;
 	}
+
+	/*
+	 * If a MAX_ORDER-1 block of pages is being freed, it is
+	 * no longer reserved for a particular type of allocation
+	 * so put it in the global list
+	 */
+	if (order >= MAX_ORDER-1) {
+		area = &(zone->free_area_global);
+		inc_globalrefill_count(zone);
+		dec_reserve_count(zone, alloctype);
+	} else {
+		area = freelist + order;
+	}
+
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	list_add_tail(&page->lru, &area->free_list);
+	area->nr_free++;
 }
 
 static inline void free_pages_check(const char *function, struct page *page)
@@ -458,53 +566,227 @@ static void prep_new_page(struct page *p
 	kernel_map_pages(page, 1 << order, 1);
 }
 
+/*
+ * This function removes a 2**MAX_ORDER-1 block of pages from the zones
+ * global list of large pages. It returns 1 on successful removal
+ */
+static inline int steal_globallist(struct zone *zone, int alloctype) {
+	struct page *page;
+
+	/* Fail if there are no pages on the global list */
+	if (list_empty(&(zone->free_area_global.free_list)))
+		return 0;
+
+	/*
+	 * Remove a MAX_ORDER block from the global pool and add
+	 * it to the list of desired alloc_type
+	 */
+	page = list_entry(zone->free_area_global.free_list.next,
+			struct page, lru);
+	list_del(&page->lru);
+	list_add(&page->lru, 
+		&(zone->free_area_lists[alloctype][MAX_ORDER-1].free_list));
+	inc_globalsteal_count(zone);
+
+	/* 
+	 * Reserve this whole block of pages. When the pool shrinks, a 
+	 * percentage will be reserved for fallbacks.
+	 */
+	if (!is_min_fallback_reserved(zone) &&
+	    need_min_fallback_reserve(zone)) {
+		set_pageblock_type(zone, page, ALLOC_FALLBACK);
+		inc_reserve_count(zone, ALLOC_FALLBACK);
+	} else {
+		set_pageblock_type(zone, page, alloctype);
+		inc_reserve_count(zone, alloctype);
+	}
+
+	return 1;
+
+}
 /* 
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order, int flags)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
+	int *fallback_list;
 
-	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
-		if (list_empty(&area->free_list))
+	/* Select area to use based on gfp_flags */
+	int alloctype, start_alloctype;
+	int retry_count=0;
+	int startorder = order;
+	if (flags & __GFP_USERRCLM) {
+		alloctype = ALLOC_USERRCLM;
+	}
+	else if (flags & __GFP_KERNRCLM) {
+		alloctype = ALLOC_KERNRCLM;
+	} else {
+		alloctype = ALLOC_KERNNORCLM;
+	}
+
+	/* Ok, pick the fallback order based on the type */
+	fallback_list = fallback_allocs[alloctype];
+	start_alloctype = alloctype;
+	inc_alloc_count(zone, alloctype);
+	alloctype = fallback_list[retry_count];
+
+retry:
+	area = zone->free_area_lists[alloctype] + startorder;
+	for (current_order = startorder; 
+			current_order < MAX_ORDER; ++current_order) {
+
+		if (list_empty(&area->free_list)) {
+			area++;
 			continue;
+		}
 
+remove_page:
 		page = list_entry(area->free_list.next, struct page, lru);
 		list_del(&page->lru);
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
+
+		/*
+		 * If we are falling back, and the allocation is KERNNORCLM,
+		 * then reserve any buddies for the KERNNORCLM pool. These
+		 * allocations fragment the worst so this helps keep them 
+		 * in the one place
+		 */
+		if (retry_count > 0 && start_alloctype == ALLOC_KERNNORCLM) {
+			area = zone->free_area_lists[ALLOC_KERNNORCLM] + 
+				current_order;
+
+			/* Reserve the whole block if this is a large split */
+			if (current_order >= MAX_ORDER/2) {
+				int reserve_type=ALLOC_KERNNORCLM;
+				dec_reserve_count(zone, 
+						get_pageblock_type(zone, page));
+
+				/*
+				 * Use this block for fallbacks if the 
+				 * minimum reserve is not being met
+				 */
+				if (!is_min_fallback_reserved(zone)) {
+					reserve_type=ALLOC_FALLBACK;
+				}
+
+				set_pageblock_type(zone, page, reserve_type);
+				inc_reserve_count(zone, reserve_type);
+				inc_kernnorclm_full_steal(zone);
+			} else inc_kernnorclm_partial_steal(zone);
+		}
+
 		return expand(zone, page, order, current_order, area);
+
+	}
+
+	/* Allocate from the global list if the preferred free list is empty */
+	if (retry_count == 0 && steal_globallist(zone, alloctype)) {
+		startorder = MAX_ORDER-1;
+		goto retry;
 	}
 
+	/*
+	 * Here, the alloc type lists has been depleted as well as the global
+	 * pool, so fallback. When falling back, the largest possible block
+	 * will be taken to keep the fallbacks clustered if possible
+	 */
+	while (++retry_count != ALLOC_TYPES) {
+
+		/*
+		 * If the current alloctype is ALLOC_FALLBACK, it means
+		 * that the requested pool and fallback pool are both
+		 * depleted and we are falling back to other pools.
+		 * At this point, pools are starting to get fragmented
+		 */
+		if (alloctype == ALLOC_FALLBACK) 
+			inc_fallback_count(zone, start_alloctype);
+		alloctype = fallback_list[retry_count];
+
+		/* Find a block to allocate */
+		area = zone->free_area_lists[alloctype] + (MAX_ORDER-1);
+		current_order=MAX_ORDER;
+		do {
+			current_order--;
+			if (list_empty(&area->free_list)) {
+				area--;
+				continue;
+			}
+
+			goto remove_page;
+		} while (current_order != order);
+	}
+	
 	return NULL;
 }
 
 /* 
  * Obtain a specified number of elements from the buddy allocator, all under
  * a single hold of the lock, for efficiency.  Add them to the supplied list.
- * Returns the number of new pages which were placed at *list.
+ * Returns the number of new pages which were placed at *list. An attempt 
+ * is made to keep the allocated memory in physically contiguous blocks
+ *
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int gfp_flags)
 {
 	unsigned long flags;
 	int i;
 	int allocated = 0;
 	struct page *page;
+	int current_order = order;
+	int pages_to_alloc = (1 << order) * count;
 	
+	/* Find what order we should start allocating blocks at */
+	while (1 << current_order <= pages_to_alloc && 
+			current_order < (MAX_ORDER-1)) current_order++;
+	inc_bulk_request(zone, current_order-1);
+
 	spin_lock_irqsave(&zone->lock, flags);
-	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
-		if (page == NULL)
-			break;
-		allocated++;
-		list_add_tail(&page->lru, list);
+
+	/*
+	 * Satisfy the request in as the largest possible physically 
+	 * contiguous block
+	 */
+	while (allocated != pages_to_alloc && current_order >= order) {
+		if ((1 << current_order) > (pages_to_alloc - allocated)) 
+			current_order--;
+
+		if (allocated > pages_to_alloc) BUG();
+		if (current_order >= MAX_ORDER) BUG();
+
+		/* Allocate a block at the current_order */
+		page = __rmqueue(zone, current_order, gfp_flags);
+		if (page == NULL) {
+			if (current_order == order) break;
+			else {
+				current_order--;
+				continue;
+			}
+		}
+		allocated += 1 << current_order;
+		inc_bulk_alloced(zone, current_order);
+
+		/* Move to the next block if order is already 0 */
+		if (current_order == order) {
+			list_add_tail(&page->lru, list);
+			continue;
+		}
+
+		/* Split the large block into order-sized blocks  */
+		for (i = 0; i < 1 << (current_order - order); i++) {
+			rmv_page_order(page);
+			list_add_tail(&page->lru, list);
+			page += (1 << order);
+		}
 	}
+
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return allocated;
 }
@@ -535,7 +817,7 @@ static void __drain_pages(unsigned int c
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
-	int order;
+	int order, type;
 	struct list_head *curr;
 
 	if (!zone->spanned_pages)
@@ -545,14 +827,17 @@ void mark_free_pages(struct zone *zone)
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
@@ -654,14 +939,15 @@ buffered_rmqueue(struct zone *zone, int 
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
@@ -673,7 +959,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, gfp_flags);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -700,6 +986,7 @@ int zone_watermark_ok(struct zone *z, in
 {
 	/* free_pages my go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
+	struct free_area *kernnorclm, *kernrclm, *userrclm;
 	int o;
 
 	if (gfp_high)
@@ -709,15 +996,25 @@ int zone_watermark_ok(struct zone *z, in
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
 		return 0;
+	kernnorclm = z->free_area_lists[ALLOC_KERNNORCLM];
+	kernrclm = z->free_area_lists[ALLOC_KERNRCLM];
+	userrclm = z->free_area_lists[ALLOC_USERRCLM];
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
+		free_pages -= (
+			kernnorclm->nr_free +
+			kernrclm->nr_free +
+			userrclm->nr_free) << o;
 
 		/* Require fewer higher order pages to be free */
 		min >>= 1;
 
 		if (free_pages <= min)
 			return 0;
+
+		kernnorclm++;
+		kernrclm++;
+		userrclm++;
 	}
 	return 1;
 }
@@ -870,7 +1167,7 @@ rebalance:
 				goto got_pg;
 		}
 
-		out_of_memory(gfp_mask);
+		if (order < MAX_ORDER/2) out_of_memory(gfp_mask);
 		goto restart;
 	}
 
@@ -1214,6 +1511,7 @@ void show_free_areas(void)
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	int type;
 
 	for_each_zone(zone) {
 		show_node(zone);
@@ -1306,8 +1604,10 @@ void show_free_areas(void)
 
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
@@ -1604,10 +1904,22 @@ void zone_init_free_lists(struct pglist_
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
@@ -1616,6 +1928,21 @@ void zone_init_free_lists(struct pglist_
 #endif
 
 /*
+ * Calculate the size of the zone->usemap
+ */
+static unsigned long __init usemap_size(unsigned long zonesize) {
+	unsigned long usemapsize;
+
+	/* - Number of MAX_ORDER blocks in the zone */
+	usemapsize = (zonesize + (1 << (MAX_ORDER-1))) >> (MAX_ORDER-1);
+
+	/* - BITS_PER_ALLOC_TYPE bits to record what type of block it is */
+	usemapsize = (usemapsize * BITS_PER_ALLOC_TYPE + (sizeof(unsigned long)*8)) / 8;
+
+	return L1_CACHE_ALIGN(usemapsize);
+}
+
+/*
  * Set up the zone data structures:
  *   - mark all pages reserved
  *   - mark all memory queues empty
@@ -1628,6 +1955,7 @@ static void __init free_area_init_core(s
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 	int cpu, nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+	unsigned long usemapsize;
 
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
@@ -1726,6 +2054,34 @@ static void __init free_area_init_core(s
 		zone_start_pfn += size;
 
 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+
+		usemapsize = usemap_size(size);
+		zone->global_steal=0;
+		zone->global_refill=0;
+#ifdef CONFIG_ALLOCSTATS
+		memset((unsigned long *)zone->fallback_count, 0, 
+					sizeof(zone->fallback_count));
+		memset((unsigned long *)zone->alloc_count, 0, 
+					sizeof(zone->alloc_count));
+		memset((unsigned long *)zone->alloc_count, 0, 
+					sizeof(zone->alloc_count));
+		memset((unsigned long *)zone->bulk_requests, 0,
+					sizeof(zone->bulk_requests));
+		memset((unsigned long *)zone->bulk_alloced, 0,
+					sizeof(zone->bulk_alloced));
+		zone->kernnorclm_partial_steal=0;
+		zone->kernnorclm_full_steal=0;
+#endif
+
+		zone->free_area_usemap = 
+			(unsigned long *)alloc_bootmem_node(pgdat, 
+					usemapsize);
+
+		memset((unsigned long *)zone->free_area_usemap,
+				ALLOC_KERNNORCLM, usemapsize);
+
+		printk(KERN_DEBUG "  %s zone: %lu pages, %lu real pages, usemap size:%lu\n",
+				zone_names[j], size, realsize, usemapsize);
 	}
 }
 
@@ -1813,19 +2169,152 @@ static int frag_show(struct seq_file *m,
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
 	unsigned long flags;
-	int order;
+	int order, type;
+	struct list_head *elem;
+ 	unsigned long nr_bufs = 0;
+#ifdef CONFIG_ALLOCSTATS
+	int i;
+	unsigned long global_refill=0;
+	unsigned long global_steal=0;
+	unsigned long kernnorclm_full_steal=0;
+	unsigned long kernnorclm_partial_steal=0;
+	unsigned long reserve_count[ALLOC_TYPES];
+	unsigned long fallback_count[ALLOC_TYPES];
+	unsigned long alloc_count[ALLOC_TYPES];
+	unsigned long bulk_requests[MAX_ORDER];
+	unsigned long bulk_alloced[MAX_ORDER];
+
+	memset(reserve_count, 0, sizeof(reserve_count));
+	memset(fallback_count, 0, sizeof(fallback_count));
+	memset(alloc_count, 0, sizeof(alloc_count));
+	memset(bulk_requests, 0, sizeof(bulk_requests));
+	memset(bulk_alloced, 0, sizeof(bulk_alloced));
 
+#endif
+
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
+ 			seq_printf(m, "\nNode %d, zone %8s, type %10s ", 
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
+ 		seq_printf(m, "%6lu \n", nr_bufs);
+
+#ifdef CONFIG_ALLOCSTATS
+ 		seq_printf(m, "\n%s Zone beancounters\n", zone->name);
+ 		seq_printf(m, "Global steal:     %lu\n", zone->global_steal);
+ 		seq_printf(m, "Global refills:   %lu\n", zone->global_refill);
+		seq_printf(m, "Partial steal:    %lu\n", zone->kernnorclm_partial_steal);
+		seq_printf(m, "Full steal:       %lu\n", zone->kernnorclm_full_steal);
+
+		seq_printf(m, "Bulk requests ");
+		for (i=0; i< MAX_ORDER; i++) {
+			seq_printf(m, "%7lu ", zone->bulk_requests[i]);
+			bulk_requests[i] += zone->bulk_requests[i];
+		}
+		seq_printf(m, "\nBulk alloced  ");
+		for (i=0; i< MAX_ORDER; i++) {
+			seq_printf(m, "%7lu ", zone->bulk_alloced[i]);
+			bulk_alloced[i] += zone->bulk_alloced[i];
+		}
+		seq_printf(m, "\n");
+
+		global_steal += zone->global_steal;
+		global_refill += zone->global_refill;
+		kernnorclm_partial_steal += zone->kernnorclm_partial_steal;
+		kernnorclm_full_steal += zone->kernnorclm_full_steal;
+
+		for (i=0; i< ALLOC_TYPES; i++) {
+ 			seq_printf(m, "%-10s Allocs: %-10lu Reserve: %-10lu Fallbacks: %-10lu\n", 
+					type_names[i], 
+					zone->alloc_count[i],
+					zone->reserve_count[i],
+					zone->fallback_count[i]);
+			alloc_count[i] += zone->alloc_count[i];
+			reserve_count[i] += zone->reserve_count[i];
+			fallback_count[i] += zone->fallback_count[i];
+		}
+ 
+#endif
 		spin_unlock_irqrestore(&zone->lock, flags);
-		seq_putc(m, '\n');
 	}
+ 
+ 	/* Show bean counters */
+#ifdef CONFIG_ALLOCSTATS
+ 	seq_printf(m, "\nGlobal beancounters\n");
+ 	seq_printf(m, "Global steal:     %lu\n", global_steal);
+ 	seq_printf(m, "Global refills:   %lu\n", global_refill);
+	seq_printf(m, "Partial steal:    %lu\n", kernnorclm_partial_steal);
+	seq_printf(m, "Full steal:       %lu\n",    kernnorclm_full_steal);
+	seq_printf(m, "Bulk requests ");
+	for (i=0; i< MAX_ORDER; i++) {
+		seq_printf(m, "%7lu ", bulk_requests[i]);
+	}
+	seq_printf(m, "\nBulk alloced  ");
+	for (i=0; i< MAX_ORDER; i++) {
+		seq_printf(m, "%7lu ", bulk_alloced[i]);
+	}
+	seq_printf(m, "\n");
+
+	for (i=0; i< ALLOC_TYPES; i++) {
+ 		seq_printf(m, "%-10s Allocs: %-10lu Reserve: %-10lu Fallbacks: %-10lu\n", 
+				type_names[i], 
+				alloc_count[i],
+				reserve_count[i],
+				fallback_count[i]);
+	}
+#endif
+
 	return 0;
 }
 
