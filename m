Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVEaL0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVEaL0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVEaL0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:26:20 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:46016 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261867AbVEaLUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:20:55 -0400
To: linux-mm@kvack.org
Subject: Avoiding external fragmentation with a placement policy Version 12
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Message-Id: <20050531112048.D2511E57A@skynet.csn.ul.ie>
Date: Tue, 31 May 2005 12:20:48 +0100 (IST)
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since V11
o Mainly a redefiff against 2.6.12-rc5
o Use #defines for indexing into pcpu lists
o Fix rounding error in the size of usemap

Changelog since V10
o All allocation types now use per-cpu caches like the standard allocator
o Removed all the additional buddy allocator statistic code
o Elimated three zone fields that can be lived without
o Simplified some loops
o Removed many unnecessary calculations

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
2.6.12-rc5-standard
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.00       1109   18.48333        18483.33 File Creations and Closes/second
     2 page_test           60.01       4304   71.72138       121926.35 System Allocations & Pages/second
     3 brk_test            60.03       1560   25.98701       441779.11 System Memory Allocations/second
     4 jmp_test            60.00     251053 4184.21667      4184216.67 Non-local gotos/second
     5 signal_test         60.01       5524   92.05132        92051.32 Signal Traps/second
     6 exec_test           60.04        779   12.97468           64.87 Program Loads/second
     7 fork_test           60.02        927   15.44485         1544.49 Task Creations/second
     8 link_test           60.01       6044  100.71655         6345.14 Link/Unlink Pairs/second

2.6.12-rc5-mbuddy-v11
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.05       1116   18.58451        18584.51 File Creations and Closes/second
     2 page_test           60.01       4414   73.55441       125042.49 System Allocations & Pages/second
     3 brk_test            60.04       1608   26.78215       455296.47 System Memory Allocations/second
     4 jmp_test            60.00     250917 4181.95000      4181950.00 Non-local gotos/second
     5 signal_test         60.01       5448   90.78487        90784.87 Signal Traps/second
     6 exec_test           60.03        781   13.01016           65.05 Program Loads/second
     7 fork_test           60.05        928   15.45379         1545.38 Task Creations/second
     8 link_test           60.01       6102  101.68305         6406.03 Link/Unlink Pairs/second

Difference in performance operations report generated by diff-aim9.sh
 1 creat-clo      18483.33   18584.51     101.18  0.55% File Creations and Closes/second
 2 page_test     121926.35  125042.49    3116.14  2.56% System Allocations & Pages/second
 3 brk_test      441779.11  455296.47   13517.36  3.06% System Memory Allocations/second
 4 jmp_test     4184216.67 4181950.00   -2266.67 -0.05% Non-local gotos/second
 5 signal_test    92051.32   90784.87   -1266.45 -1.38% Signal Traps/second
 6 exec_test         64.87      65.05       0.18  0.28% Program Loads/second
 7 fork_test       1544.49    1545.38       0.89  0.06% Task Creations/second
 8 link_test       6345.14    6406.03      60.89  0.96% Link/Unlink Pairs/second

The aim9 results show that there are improvements for common page-related
operations so we can provide lower fragmentation without performance
loss. The results are compiler dependant and there are variances of 1-2%
between versions.

The second benchmark tested the CPU cache usage to make sure it was not
getting clobbered. The test was to repeatedly render a large postscript file
10 times and get the average. The result is;

gsbench-2.6.12-rc4-standard
Average: 42.84 real, 42.754 user, 0.037 sys

gsbench-2.6.12-rc4-mbuddy-v11
Average: 42.907 real, 42.825 user, 0.037 sys

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
    - Performance will get badly shot as it forces consider amounts of pageout

The result of the allocations under load (load averaging 25) were;

2.6.12-rc5 Standard
Order:                 10
Attempted allocations: 160
Success allocs:        3
Failed allocs:         108
% Success:            1

2.6.12-rc4 MBuddy V12
Order:                 10
Attempted allocations: 160
Success allocs:        63
Failed allocs:         97
% Success:             39

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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc5-standard/fs/buffer.c linux-2.6.12-rc5-mbuddy-v12/fs/buffer.c
--- linux-2.6.12-rc5-standard/fs/buffer.c	2005-05-25 04:31:20.000000000 +0100
+++ linux-2.6.12-rc5-mbuddy-v12/fs/buffer.c	2005-05-31 09:49:11.000000000 +0100
@@ -1135,7 +1135,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index, 
+					GFP_NOFS | __GFP_USERRCLM);
 	if (!page)
 		return NULL;
 
@@ -3056,7 +3057,8 @@ static void recalc_bh_state(void)
 	
 struct buffer_head *alloc_buffer_head(unsigned int __nocast gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, 
+						gfp_flags|__GFP_KERNRCLM);
 	if (ret) {
 		preempt_disable();
 		__get_cpu_var(bh_accounting).nr++;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc5-standard/fs/dcache.c linux-2.6.12-rc5-mbuddy-v12/fs/dcache.c
--- linux-2.6.12-rc5-standard/fs/dcache.c	2005-05-25 04:31:20.000000000 +0100
+++ linux-2.6.12-rc5-mbuddy-v12/fs/dcache.c	2005-05-31 09:49:11.000000000 +0100
@@ -719,7 +719,8 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, 
+				GFP_KERNEL|__GFP_KERNRCLM); 
 	if (!dentry)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc5-standard/fs/ext2/super.c linux-2.6.12-rc5-mbuddy-v12/fs/ext2/super.c
--- linux-2.6.12-rc5-standard/fs/ext2/super.c	2005-05-25 04:31:20.000000000 +0100
+++ linux-2.6.12-rc5-mbuddy-v12/fs/ext2/super.c	2005-05-31 09:49:11.000000000 +0100
@@ -137,7 +137,7 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc5-standard/fs/ext3/super.c linux-2.6.12-rc5-mbuddy-v12/fs/ext3/super.c
--- linux-2.6.12-rc5-standard/fs/ext3/super.c	2005-05-25 04:31:20.000000000 +0100
+++ linux-2.6.12-rc5-mbuddy-v12/fs/ext3/super.c	2005-05-31 09:49:11.000000000 +0100
@@ -440,7 +440,7 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc5-standard/fs/ntfs/inode.c linux-2.6.12-rc5-mbuddy-v12/fs/ntfs/inode.c
--- linux-2.6.12-rc5-standard/fs/ntfs/inode.c	2005-05-25 04:31:20.000000000 +0100
+++ linux-2.6.12-rc5-mbuddy-v12/fs/ntfs/inode.c	2005-05-31 09:49:11.000000000 +0100
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc5-standard/include/linux/gfp.h linux-2.6.12-rc5-mbuddy-v12/include/linux/gfp.h
--- linux-2.6.12-rc5-standard/include/linux/gfp.h	2005-05-25 04:31:20.000000000 +0100
+++ linux-2.6.12-rc5-mbuddy-v12/include/linux/gfp.h	2005-05-31 09:49:11.000000000 +0100
@@ -39,7 +39,10 @@ struct vm_area_struct;
 #define __GFP_COMP	0x4000u	/* Add compound page metadata */
 #define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC 0x10000u /* Don't use emergency reserves */
+#define __GFP_KERNRCLM  0x20000u  /* Kernel page that is easily reclaimable */
+#define __GFP_USERRCLM  0x40000u  /* User is a userspace user */
 
+#define __GFP_TYPE_SHIFT 17     /* Translate RCLM flags to array index */
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
@@ -47,14 +50,14 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC)
+			__GFP_NOMEMALLOC|__GFP_KERNRCLM|__GFP_USERRCLM)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_USERRCLM )
+#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM | __GFP_USERRCLM)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc5-standard/include/linux/mmzone.h linux-2.6.12-rc5-mbuddy-v12/include/linux/mmzone.h
--- linux-2.6.12-rc5-standard/include/linux/mmzone.h	2005-05-25 04:31:20.000000000 +0100
+++ linux-2.6.12-rc5-mbuddy-v12/include/linux/mmzone.h	2005-05-31 09:52:20.000000000 +0100
@@ -21,6 +21,16 @@
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
 
+/* Page allocations are divided into these types */
+#define ALLOC_TYPES 4
+#define ALLOC_KERNNORCLM 0
+#define ALLOC_KERNRCLM 1
+#define ALLOC_USERRCLM 2
+#define ALLOC_FALLBACK 3
+
+/* Number of bits required to encode the type */
+#define BITS_PER_ALLOC_TYPE 2
+
 struct free_area {
 	struct list_head	free_list;
 	unsigned long		nr_free;
@@ -43,12 +53,28 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
+/*
+ * Shared per-cpu lists would cause fragmentation over time
+ * The pcpu_list is to keep kernel and userrclm allocations
+ * apart while still allowing all allocation types to have
+ * per-cpu lists
+ */
+struct pcpu_list {
+	int count;
+	struct list_head list;
+} ____cacheline_aligned_in_smp;
+
+
+/* Indices into pcpu_list */
+#define PCPU_KERNEL 0
+#define PCPU_USER 1
 struct per_cpu_pages {
-	int count;		/* number of pages in the list */
+	struct pcpu_list pcpu_list[2]; /* PCPU_KERNEL: kernel
+					* PCPU_USER: user
+					*/
 	int low;		/* low watermark, refill needed */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
-	struct list_head list;	/* the list of pages */
 };
 
 struct per_cpu_pageset {
@@ -128,8 +154,34 @@ struct zone {
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
-	struct free_area	free_area[MAX_ORDER];
 
+ 	/*
+ 	 * The map tracks what each 2^MAX_ORDER-1 sized block is being used for
+	 * using BITS_PER_ALLOC_TYPE number of bites. Bits are set when a large
+	 * block is being split and rechecked during freeing of the page
+ 	 */
+ 	unsigned long		*free_area_usemap;
+	
+	/*
+	 * There are ALLOC_TYPE number of MAX_ORDER free lists. Once a 
+	 * MAX_ORDER block of pages has been split for an allocation type,
+	 * the whole block is reserved for that type of allocation.
+	 */
+ 	struct free_area	free_area_lists[ALLOC_TYPES][MAX_ORDER];
+
+	/*
+	 * A percentage of a zone is reserved for falling back to. Without
+	 * a fallback, memory will slowly fragment over time meaning the
+	 * placement policy only delays the fragmentation problem, not
+	 * fixes it
+	 */
+	unsigned long fallback_reserve;
+
+	/*
+	 * When negative, 2^MAX_ORDER-1 sized blocks of pages will be reserved
+	 * for fallbacks
+	 */
+	long fallback_balance;
 
 	ZONE_PADDING(_pad1_)
 
@@ -212,6 +264,11 @@ struct zone {
 	char			*name;
 } ____cacheline_maxaligned_in_smp;
 
+#define inc_reserve_count(zone, type) \
+	type == ALLOC_FALLBACK ? zone->fallback_reserve++ : 0
+#define dec_reserve_count(zone, type) \
+	(type == ALLOC_FALLBACK && zone->fallback_reserve) ? \
+		zone->fallback_reserve-- : 0
 
 /*
  * The "priority" of VM scanning is how much of the queues we will scan in one
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.12-rc5-standard/mm/page_alloc.c linux-2.6.12-rc5-mbuddy-v12/mm/page_alloc.c
--- linux-2.6.12-rc5-standard/mm/page_alloc.c	2005-05-25 04:31:20.000000000 +0100
+++ linux-2.6.12-rc5-mbuddy-v12/mm/page_alloc.c	2005-05-31 10:08:00.000000000 +0100
@@ -64,6 +64,25 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
 
+/**
+ * The allocator tries to put allocations of the same type in the
+ * same 2^MAX_ORDER-1 blocks of pages. When memory is low, this may
+ * not be possible so this array describes what order allocations should
+ * fall back to
+ *
+ * The order of the fallback is chosen to keep the userrclm and kernrclm
+ * pools as low as fragmentation as possible. The FALLBACK zone is never
+ * directly used but acts as a reserve to allocate pages from when the
+ * normal pools are depleted.
+ *
+ */
+int fallback_allocs[ALLOC_TYPES][ALLOC_TYPES+1] = { 
+	{ALLOC_KERNNORCLM,ALLOC_FALLBACK,  ALLOC_KERNRCLM,  ALLOC_USERRCLM,-1},
+	{ALLOC_KERNRCLM,  ALLOC_FALLBACK,  ALLOC_KERNNORCLM,ALLOC_USERRCLM,-1},
+	{ALLOC_USERRCLM,  ALLOC_FALLBACK,  ALLOC_KERNNORCLM,ALLOC_KERNRCLM,-1},
+	{ALLOC_FALLBACK,  ALLOC_KERNNORCLM,ALLOC_KERNRCLM,  ALLOC_USERRCLM,-1}
+};
+
 /*
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
@@ -118,6 +137,64 @@ static void bad_page(const char *functio
 	tainted |= TAINT_BAD_PAGE;
 }
 
+/*
+ * Return what type of page is being allocated from this 2^MAX_ORDER-1 block 
+ * of pages. A bitmap is used as a char array performs slightly slower
+ */
+static inline unsigned int get_pageblock_type(struct zone *zone, struct page *page) {
+	int bitidx = (page_to_pfn(page) >> (MAX_ORDER-1)) * BITS_PER_ALLOC_TYPE;
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
+	int bitidx = (page_to_pfn(page) >> (MAX_ORDER-1)) * BITS_PER_ALLOC_TYPE;
+
+	/* Bits set match the alloc types defined in mmzone.h */
+	switch (type) {
+		case ALLOC_KERNRCLM:
+			clear_bit(bitidx, zone->free_area_usemap);
+			set_bit(bitidx+1, zone->free_area_usemap);
+			break;
+
+		case ALLOC_USERRCLM:
+			set_bit(bitidx, zone->free_area_usemap);
+			clear_bit(bitidx+1, zone->free_area_usemap);
+			break;
+
+		default:
+			set_bit(bitidx, zone->free_area_usemap);
+			set_bit(bitidx+1, zone->free_area_usemap);
+			break;
+	}
+}
+
+/*
+ * A percentage of a zone is reserved for allocations to fallback to. These
+ * macros calculate if a fallback reserve is already reserved and if it is
+ * needed
+ */
+#define need_min_fallback_reserve(zone) \
+	(zone->free_pages >> (MAX_ORDER) < zone->fallback_reserve)
+#define is_min_fallback_reserved(zone) \
+	(zone->fallback_balance < 0)
+
 #ifndef CONFIG_HUGETLB_PAGE
 #define prep_compound_page(page, order) do { } while (0)
 #define destroy_compound_page(page, order) do { } while (0)
@@ -276,6 +353,8 @@ static inline void __free_pages_bulk (st
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	struct free_area *area;
+	struct free_area *freelist;
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
@@ -285,12 +364,14 @@ static inline void __free_pages_bulk (st
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
 
+	/* Select the areas to place free pages on */
+	freelist = zone->free_area_lists[get_pageblock_type(zone,page)];
+	
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
-
+		
 		combined_idx = __find_combined_index(page_idx, order);
 		buddy = __page_find_buddy(page, page_idx, order);
 
@@ -299,16 +380,19 @@ static inline void __free_pages_bulk (st
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
+	if (unlikely(order == MAX_ORDER-1)) zone->fallback_balance++;
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	area = freelist + order;
+	list_add_tail(&page->lru, &area->free_list);
+	area->nr_free++;
 }
 
 static inline void free_pages_check(const char *function, struct page *page)
@@ -460,57 +544,211 @@ static void prep_new_page(struct page *p
 	kernel_map_pages(page, 1 << order, 1);
 }
 
+/*
+ * Find a list that has a 2^MAX_ORDER-1 block of pages available and
+ * return it
+ */
+static inline struct page* steal_largepage(struct zone *zone, int alloctype) {
+	struct page *page;
+	struct free_area *area;
+	int i=0;
+
+	/* Search the other allocation type lists */
+	while (i < ALLOC_TYPES) {
+		area = &(zone->free_area_lists[i][MAX_ORDER-1]);
+		if (!list_empty(&(area->free_list))) break;
+		if (++i == alloctype) i++;
+	}
+	if (i == ALLOC_TYPES) return NULL;
+
+	/*
+	 * Remove a MAX_ORDER block from the global pool and add
+	 * it to the list of desired alloc_type
+	 */
+	page = list_entry(area->free_list.next, struct page, lru);
+	area->nr_free--;
+
+	/* 
+	 * Reserve this whole block of pages. When the pool shrinks, a 
+	 * percentage will be reserved for fallbacks.
+	 */
+	if (!is_min_fallback_reserved(zone) &&
+	    need_min_fallback_reserve(zone)) {
+		alloctype = ALLOC_FALLBACK;
+	}
+
+	set_pageblock_type(zone, page, alloctype);
+	dec_reserve_count(zone, i);
+	inc_reserve_count(zone, alloctype);
+
+	return page;
+
+}
 /* 
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order, int alloctype)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
+	int *fallback_list;
+	int start_alloctype;
 
-	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
-		if (list_empty(&area->free_list))
-			continue;
+	alloctype >>= __GFP_TYPE_SHIFT;
+
+	/* Search the list for the alloctype */
+	area = zone->free_area_lists[alloctype] + order;
+	for (current_order = order;
+			current_order < MAX_ORDER;
+			current_order++, area++) {
+		if (list_empty(&area->free_list)) continue;
 
 		page = list_entry(area->free_list.next, struct page, lru);
-		list_del(&page->lru);
-		rmv_page_order(page);
 		area->nr_free--;
-		zone->free_pages -= 1UL << order;
-		return expand(zone, page, order, current_order, area);
+		goto remove_page;
+	}
+
+	/* Allocate from the global list if the preferred free list is empty */
+	if ((page = steal_largepage(zone, alloctype)) != NULL) {
+		area--;
+		current_order--;
+		goto remove_page;
 	}
 
+	/* Ok, pick the fallback order based on the type */
+	fallback_list = fallback_allocs[alloctype];
+	start_alloctype = alloctype;
+
+	/*
+	 * Here, the alloc type lists has been depleted as well as the global
+	 * pool, so fallback. When falling back, the largest possible block
+	 * will be taken to keep the fallbacks clustered if possible
+	 */
+	while ((alloctype = *(++fallback_list)) != -1) {
+
+		if (alloctype < 0 || alloctype >= ALLOC_TYPES) BUG();
+
+		/* Find a block to allocate */
+		area = zone->free_area_lists[alloctype] + MAX_ORDER;
+		current_order=MAX_ORDER;
+		do {
+			current_order--;
+			area--;
+			if (!list_empty(&area->free_list)) {
+
+				page = list_entry(area->free_list.next, struct page, lru);
+				area->nr_free--;
+				goto fallback_alloc;
+			}
+
+		} while (current_order != order);
+
+	}
+	
 	return NULL;
+	
+fallback_alloc:
+	/*
+ 	 * If we are falling back, and the allocation is KERNNORCLM,
+ 	 * then reserve any buddies for the KERNNORCLM pool. These
+ 	 * allocations fragment the worst so this helps keep them 
+ 	 * in the one place
+ 	 */
+	if (start_alloctype == ALLOC_KERNNORCLM) {
+		area = zone->free_area_lists[ALLOC_KERNNORCLM] + current_order;
+
+		/* Reserve the whole block if this is a large split */
+		if (current_order >= MAX_ORDER / 2) {
+			int reserve_type=ALLOC_KERNNORCLM;
+			dec_reserve_count(zone, get_pageblock_type(zone,page));
+
+			/*
+			 * Use this block for fallbacks if the
+			 * minimum reserve is not being met
+			 */
+			if (!is_min_fallback_reserved(zone))
+				reserve_type = ALLOC_FALLBACK;
+
+			set_pageblock_type(zone, page, reserve_type);
+			inc_reserve_count(zone, reserve_type);
+		}
+
+	}
+
+remove_page:
+	/*
+	 * At this point, page is expected to be the page we are
+	 * about to remove and the area->nr_free count should have been
+	 * updated 
+	 */
+	if (unlikely(current_order == MAX_ORDER-1)) zone->fallback_balance--;
+	list_del(&page->lru);
+	rmv_page_order(page);
+	zone->free_pages -= 1UL << order;
+	return expand(zone, page, order, current_order, area);
 }
 
 /* 
- * Obtain a specified number of elements from the buddy allocator, all under
- * a single hold of the lock, for efficiency.  Add them to the supplied list.
- * Returns the number of new pages which were placed at *list.
+ * Obtain a specified number of order-0 elements from the buddy allocator, all 
+ * under a single hold of the lock, for efficiency.  Add them to the supplied 
+ * list. An attempt is made to keep the allocatoed memory in physically
+ * contiguous blocks. Returns the number of new pages which were placed at 
+ * *list.
+ *
  */
-static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+static int rmqueue_bulk(struct zone *zone,
+			unsigned long count, struct list_head *list,
+			int alloctype)
 {
 	unsigned long flags;
 	int i;
-	int allocated = 0;
+	unsigned long allocated = count;
 	struct page *page;
+	unsigned long current_order= 0;
 	
+	/* Find what order we should start allocating blocks at */
+	current_order = ffs(count) - 1;
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
+	while (allocated) {
+		if ((1 << current_order) > allocated) 
+			current_order--;
+
+		/* Allocate a block at the current_order */
+		page = __rmqueue(zone, current_order, alloctype);
+		if (page == NULL) {
+			if (current_order == 0) break;
+			current_order--;
+			continue;
+		}
+		allocated -= 1 << current_order;
+
+		/* Move to the next block if order is already 0 */
+		if (current_order == 0) {
+			list_add_tail(&page->lru, list);
+			continue;
+		}
+
+		/* Split the large block into order-sized blocks  */
+		for (i = 1 << current_order; i != 0; i--) {
+			list_add_tail(&page->lru, list);
+			page++;
+		}
 	}
+
 	spin_unlock_irqrestore(&zone->lock, flags);
-	return allocated;
+	return count - allocated;
 }
 
+
+
 #if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
 static void __drain_pages(unsigned int cpu)
 {
@@ -525,8 +763,11 @@ static void __drain_pages(unsigned int c
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
+			pcp->pcpu_list[0].count -= free_pages_bulk(zone, pcp->pcpu_list[0].count,
+						&pcp->pcpu_list[0].list, 0);
+
+			pcp->pcpu_list[1].count -= free_pages_bulk(zone, pcp->pcpu_list[1].count,
+						&pcp->pcpu_list[1].list, 0);
 		}
 	}
 }
@@ -537,7 +778,7 @@ static void __drain_pages(unsigned int c
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
-	int order;
+	int order, type;
 	struct list_head *curr;
 
 	if (!zone->spanned_pages)
@@ -547,14 +788,17 @@ void mark_free_pages(struct zone *zone)
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
@@ -607,6 +851,7 @@ static void fastcall free_hot_cold_page(
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
+	struct pcpu_list *plist;
 
 	arch_free_page(page, 0);
 
@@ -616,11 +861,20 @@ static void fastcall free_hot_cold_page(
 		page->mapping = NULL;
 	free_pages_check(__FUNCTION__, page);
 	pcp = &zone->pageset[get_cpu()].pcp[cold];
+
+	/* 
+	 * Strictly speaking, we should not be accessing the zone information
+	 * here. In this case, it does not matter if the read is incorrect
+	 */
+	if (get_pageblock_type(zone, page) == ALLOC_USERRCLM)
+		plist = &pcp->pcpu_list[1];
+	else 
+		plist = &pcp->pcpu_list[0];
 	local_irq_save(flags);
-	if (pcp->count >= pcp->high)
-		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
-	list_add(&page->lru, &pcp->list);
-	pcp->count++;
+	if (plist->count >= pcp->high)
+		plist->count -= free_pages_bulk(zone, pcp->batch, &plist->list, 0);
+	list_add(&page->lru, &plist->list);
+	plist->count++;
 	local_irq_restore(flags);
 	put_cpu();
 }
@@ -650,7 +904,7 @@ static inline void prep_zero_page(struct
  * or two.
  */
 static struct page *
-buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags)
+buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags, int alloctype)
 {
 	unsigned long flags;
 	struct page *page = NULL;
@@ -658,16 +912,22 @@ buffered_rmqueue(struct zone *zone, int 
 
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
+		struct pcpu_list *plist;
 
 		pcp = &zone->pageset[get_cpu()].pcp[cold];
 		local_irq_save(flags);
-		if (pcp->count <= pcp->low)
-			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
-		if (pcp->count) {
-			page = list_entry(pcp->list.next, struct page, lru);
+
+		if (alloctype == __GFP_USERRCLM) plist = &pcp->pcpu_list[1];
+		else plist = &pcp->pcpu_list[0];
+
+		if (plist->count <= pcp->low)
+			plist->count += rmqueue_bulk(zone,
+						pcp->batch, &plist->list,
+						alloctype);
+		if (plist->count) {
+			page = list_entry(plist->list.next, struct page, lru);
 			list_del(&page->lru);
-			pcp->count--;
+			plist->count--;
 		}
 		local_irq_restore(flags);
 		put_cpu();
@@ -675,7 +935,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -702,6 +962,7 @@ int zone_watermark_ok(struct zone *z, in
 {
 	/* free_pages my go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
+	struct free_area *kernnorclm, *kernrclm, *userrclm;
 	int o;
 
 	if (gfp_high)
@@ -711,15 +972,25 @@ int zone_watermark_ok(struct zone *z, in
 
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
@@ -741,6 +1012,8 @@ __alloc_pages(unsigned int __nocast gfp_
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
+	int alloctype;
+	int highorder_retry=3;
 
 	might_sleep_if(wait);
 
@@ -760,6 +1033,13 @@ __alloc_pages(unsigned int __nocast gfp_
 
 	classzone_idx = zone_idx(zones[0]);
 
+	/*
+	 * Find what type of allocation this is. Later, this value will
+	 * be shifted __GFP_TYPE_SHIFT bits to the right to give an
+	 * index within the zones freelist
+	 */
+	alloctype = (gfp_mask & (__GFP_USERRCLM | __GFP_KERNRCLM));
+
  restart:
 	/* Go through the zonelist once, looking for a zone with enough free */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
@@ -771,7 +1051,7 @@ __alloc_pages(unsigned int __nocast gfp_
 		if (!cpuset_zone_allowed(z))
 			continue;
 
-		page = buffered_rmqueue(z, order, gfp_mask);
+		page = buffered_rmqueue(z, order, gfp_mask, alloctype);
 		if (page)
 			goto got_pg;
 	}
@@ -795,7 +1075,7 @@ __alloc_pages(unsigned int __nocast gfp_
 		if (wait && !cpuset_zone_allowed(z))
 			continue;
 
-		page = buffered_rmqueue(z, order, gfp_mask);
+		page = buffered_rmqueue(z, order, gfp_mask, alloctype);
 		if (page)
 			goto got_pg;
 	}
@@ -809,7 +1089,8 @@ __alloc_pages(unsigned int __nocast gfp_
 			for (i = 0; (z = zones[i]) != NULL; i++) {
 				if (!cpuset_zone_allowed(z))
 					continue;
-				page = buffered_rmqueue(z, order, gfp_mask);
+				page = buffered_rmqueue(z, order, gfp_mask,
+						alloctype);
 				if (page)
 					goto got_pg;
 			}
@@ -852,7 +1133,7 @@ rebalance:
 			if (!cpuset_zone_allowed(z))
 				continue;
 
-			page = buffered_rmqueue(z, order, gfp_mask);
+			page = buffered_rmqueue(z, order, gfp_mask, alloctype);
 			if (page)
 				goto got_pg;
 		}
@@ -871,12 +1152,19 @@ rebalance:
 			if (!cpuset_zone_allowed(z))
 				continue;
 
-			page = buffered_rmqueue(z, order, gfp_mask);
+			page = buffered_rmqueue(z, order, gfp_mask, alloctype);
 			if (page)
 				goto got_pg;
 		}
 
-		out_of_memory(gfp_mask);
+		if (order < MAX_ORDER/2) out_of_memory(gfp_mask);
+
+		/*
+		 * Due to low fragmentation efforts, we should try a little
+		 * harder to satisfy high order allocations
+		 */
+		if (order >= MAX_ORDER/2 && --highorder_retry > 0)
+			goto rebalance;
 		goto restart;
 	}
 
@@ -893,6 +1181,8 @@ rebalance:
 			do_retry = 1;
 		if (gfp_mask & __GFP_NOFAIL)
 			do_retry = 1;
+		if (order >= MAX_ORDER/2 && --highorder_retry > 0)
+			do_retry=1;
 	}
 	if (do_retry) {
 		blk_congestion_wait(WRITE, HZ/50);
@@ -1220,6 +1510,7 @@ void show_free_areas(void)
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	int type;
 
 	for_each_zone(zone) {
 		show_node(zone);
@@ -1312,8 +1603,10 @@ void show_free_areas(void)
 
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
@@ -1609,10 +1902,19 @@ void zone_init_free_lists(struct pglist_
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
 }
 
 #ifndef __HAVE_ARCH_MEMMAP_INIT
@@ -1621,6 +1923,25 @@ void zone_init_free_lists(struct pglist_
 #endif
 
 /*
+ * Calculate the size of the zone->usemap in bytes rounded to an unsigned long
+ */
+static unsigned long __init usemap_size(unsigned long zonesize) {
+	unsigned long usemapsize;
+
+	/* Rounded-up number of MAX_ORDER-1 blocks */
+	usemapsize = (zonesize + (1 << (MAX_ORDER-1)) - 1) >> (MAX_ORDER-1);
+
+	/* BITS_PER_ALLOC_TYPE bits to record what type of block it is */
+	usemapsize *= BITS_PER_ALLOC_TYPE;
+	
+	/* Round the number of bits to the nearest unsigned long */
+	usemapsize = usemapsize + (sizeof(unsigned long) * 8 + BITS_PER_LONG-1);
+
+	/* Return size in bytes */
+	return usemapsize / 8;
+}
+
+/*
  * Set up the zone data structures:
  *   - mark all pages reserved
  *   - mark all memory queues empty
@@ -1633,6 +1954,7 @@ static void __init free_area_init_core(s
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 	int cpu, nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+	unsigned long usemapsize;
 
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
@@ -1659,6 +1981,11 @@ static void __init free_area_init_core(s
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->fallback_reserve = 0;
+
+		/* Set the balance so about 12.5% will be used for fallbacks */
+		zone->fallback_balance = (realsize >> (MAX_ORDER-1)) - 
+					 (realsize >> (MAX_ORDER+2));
 
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 
@@ -1692,18 +2019,22 @@ static void __init free_area_init_core(s
 			struct per_cpu_pages *pcp;
 
 			pcp = &zone->pageset[cpu].pcp[0];	/* hot */
-			pcp->count = 0;
+			pcp->pcpu_list[0].count = 0;
+			pcp->pcpu_list[1].count = 0;
 			pcp->low = 2 * batch;
 			pcp->high = 6 * batch;
 			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
+			INIT_LIST_HEAD(&pcp->pcpu_list[0].list);
+			INIT_LIST_HEAD(&pcp->pcpu_list[1].list);
 
 			pcp = &zone->pageset[cpu].pcp[1];	/* cold */
-			pcp->count = 0;
+			pcp->pcpu_list[0].count = 0;
+			pcp->pcpu_list[1].count = 0;
 			pcp->low = 0;
 			pcp->high = 2 * batch;
 			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
+			INIT_LIST_HEAD(&pcp->pcpu_list[0].list);
+			INIT_LIST_HEAD(&pcp->pcpu_list[1].list);
 		}
 		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
@@ -1743,6 +2074,18 @@ static void __init free_area_init_core(s
 		zone_start_pfn += size;
 
 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+
+		usemapsize = usemap_size(size);
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
 
@@ -1830,19 +2173,38 @@ static int frag_show(struct seq_file *m,
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
-		spin_unlock_irqrestore(&zone->lock, flags);
-		seq_putc(m, '\n');
-	}
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
+		for (type=0; type < ALLOC_TYPES; type++) {
+			nr_bufs += zone->free_area_lists[type][MAX_ORDER-1].nr_free;
+		}
+ 		seq_printf(m, "%6lu ", nr_bufs);
+ 
+ 		spin_unlock_irqrestore(&zone->lock, flags);
+ 		seq_putc(m, '\n');
+ 	}
+ 
 	return 0;
 }
 
