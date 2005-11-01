Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVKANqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVKANqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVKANqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:46:25 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:28833 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750785AbVKANqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:46:23 -0500
Date: Tue, 1 Nov 2005 21:49:25 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       slpratt@us.ibm.com, Con Kolivas <kernel@kolivas.org>,
       Alexandre Cassen <acassen@freebox.fr>,
       Folkert van Heusden <folkert@vanheusden.com>
Subject: [PATCH 2.6.14] Adaptive read-ahead V6
Message-ID: <20051101134925.GA5576@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, slpratt@us.ibm.com,
	Con Kolivas <kernel@kolivas.org>,
	Alexandre Cassen <acassen@freebox.fr>,
	Folkert van Heusden <folkert@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!

This is the adaptive read-ahead patch for the vanilla 2.6.14 kernel.
It is ready for wild tests.

There are some minor fixes since V5, and added support for laptop mode.
The read-ahead hard limit was lifted to 255MB, which might help laptop
users to play movies from memory ;)

You can help improve it by sending me the detailed statistics:
- compile kernel with 'Kernel hacking  --->  Debug Filesystem' enabled
- mkdir /debugfs; mount -t debugfs none /debugfs
- cat /debugfs/readahead

Best Regards,
Wu Fengguang
---

diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/Documentation/sysctl/vm.txt linux-2.6.14ra/Documentation/sysctl/vm.txt
--- linux-2.6.14/Documentation/sysctl/vm.txt	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/Documentation/sysctl/vm.txt	2005-11-01 16:56:09.000000000 +0800
@@ -26,6 +26,7 @@ Currently, these files are in /proc/sys/
 - min_free_kbytes
 - laptop_mode
 - block_dump
+- readahead_ratio
 
 ==============================================================
 
@@ -102,3 +103,16 @@ This is used to force the Linux VM to ke
 of kilobytes free.  The VM uses this number to compute a pages_min
 value for each lowmem zone in the system.  Each lowmem zone gets 
 a number of reserved free pages based proportionally on its size.
+
+==============================================================
+
+readahead_ratio
+
+This limits read-ahead size to percent of the thrashing-threshold.
+The thrashing-threshold is dynamicly estimated according to the
+_history_ read speed and system load, and used to limit the
+_future_ read-ahead request size. So you should set it to a low
+value if you have not enough memory to counteract the I/O load
+fluctuation.
+
+The default value is 50.
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/drivers/block/loop.c linux-2.6.14ra/drivers/block/loop.c
--- linux-2.6.14/drivers/block/loop.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/drivers/block/loop.c	2005-11-01 16:56:09.000000000 +0800
@@ -768,6 +768,11 @@ static int loop_set_fd(struct loop_devic
 
 	mapping = file->f_mapping;
 	inode = mapping->host;
+	/*
+	 * The upper layer should already do proper read-ahead,
+	 * unlimited read-ahead here only ruins the cache hit rate.
+	 */
+	file->f_ra.ra_pages = 32 >> (PAGE_CACHE_SHIFT - 10);
 
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/include/linux/fs.h linux-2.6.14ra/include/linux/fs.h
--- linux-2.6.14/include/linux/fs.h	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/include/linux/fs.h	2005-11-01 16:56:09.000000000 +0800
@@ -562,13 +562,19 @@ struct file_ra_state {
 	unsigned long start;		/* Current window */
 	unsigned long size;
 	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
-	unsigned long cache_hit;	/* cache hit count*/
+	uint64_t      cache_hit;	/* cache hit count*/
 	unsigned long prev_page;	/* Cache last read() position */
 	unsigned long ahead_start;	/* Ahead window */
 	unsigned long ahead_size;
 	unsigned long ra_pages;		/* Maximum readahead window */
 	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
 	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
+
+	unsigned long age;
+	unsigned long la_index;
+	unsigned long ra_index;
+	unsigned long lookahead_index;
+	unsigned long readahead_index;
 };
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/include/linux/mm.h linux-2.6.14ra/include/linux/mm.h
--- linux-2.6.14/include/linux/mm.h	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/include/linux/mm.h	2005-11-01 19:38:19.000000000 +0800
@@ -875,11 +875,14 @@ extern int filemap_populate(struct vm_ar
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
-#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MAX_READAHEAD	1024	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 #define VM_MAX_CACHE_HIT    	256	/* max pages in a row in cache before
 					 * turning readahead off */
 
+/* turn on read-ahead thrashing protection if (readahead_ratio >= ##) */
+#define VM_READAHEAD_PROTECT_RATIO	80
+
 int do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			unsigned long offset, unsigned long nr_to_read);
 int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
@@ -892,6 +895,15 @@ unsigned long  page_cache_readahead(stru
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			unsigned long first_index,
+			unsigned long index, unsigned long last_index);
+void fastcall ra_access(struct file_ra_state *ra, struct page *page);
+int rescue_ra_pages(struct list_head *page_list, struct list_head *save_list);
+
 
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct * vma, unsigned long address);
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/include/linux/mmzone.h linux-2.6.14ra/include/linux/mmzone.h
--- linux-2.6.14/include/linux/mmzone.h	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/include/linux/mmzone.h	2005-11-01 16:56:09.000000000 +0800
@@ -153,6 +153,20 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* Fields for balanced page aging:
+	 * nr_page_aging   - The accumulated number of activities that may
+	 *                   cause page aging, that is, make some pages closer
+	 *                   to the tail of inactive_list.
+	 * aging_milestone - A snapshot of nr_page_aging every time a full
+	 *                   inactive_list of pages become aged.
+	 * page_age        - A normalized value showing the percent of pages
+	 *                   have been aged.  It is compared between zones to
+	 *                   balance the rate of page aging.
+	 */
+	unsigned long		nr_page_aging;
+	unsigned long		aging_milestone;
+	unsigned long		page_age;
+
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?
@@ -314,6 +328,45 @@ static inline void memory_present(int ni
 unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
 #endif
 
+#ifdef CONFIG_HIGHMEM64G
+#define		PAGE_AGE_SHIFT  8
+#elif BITS_PER_LONG == 32
+#define		PAGE_AGE_SHIFT  12
+#elif BITS_PER_LONG == 64
+#define		PAGE_AGE_SHIFT  20
+#else
+#error unknown BITS_PER_LONG
+#endif
+#define		PAGE_AGE_MASK   ((1 << PAGE_AGE_SHIFT) - 1)
+
+/*
+ * Keep track of the percent of pages in inactive_list that have been scanned
+ * / aged.  It's not really ##%, but a high resolution normalized value.
+ */
+static inline void update_page_age(struct zone *z, int nr_scan)
+{
+	z->nr_page_aging += nr_scan;
+
+	if (z->nr_page_aging - z->aging_milestone > z->nr_inactive)
+		z->aging_milestone += z->nr_inactive;
+
+	z->page_age = ((z->nr_page_aging - z->aging_milestone)
+				<< PAGE_AGE_SHIFT) / (1 + z->nr_inactive);
+}
+
+/*
+ * The simplified code is:
+ *         return (a->page_age > b->page_age);
+ * The complexity deals with the wrap-around problem.
+ * Two page ages not close enough should also be ignored:
+ * they are out of sync and the comparison may be nonsense.
+ */
+static inline int pages_more_aged(struct zone *a, struct zone *b)
+{
+	return ((b->page_age - a->page_age) & PAGE_AGE_MASK) >
+			PAGE_AGE_MASK - (1 << (PAGE_AGE_SHIFT - 2));
+}
+
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
  */
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/include/linux/page-flags.h linux-2.6.14ra/include/linux/page-flags.h
--- linux-2.6.14/include/linux/page-flags.h	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/include/linux/page-flags.h	2005-11-01 19:38:19.000000000 +0800
@@ -75,6 +75,8 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_activate		20	/* delayed activate */
+#define PG_readahead		21	/* check readahead when reading this page */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -104,6 +106,8 @@ struct page_state {
 	unsigned long pgfree;		/* page freeings */
 	unsigned long pgactivate;	/* pages moved inactive->active */
 	unsigned long pgdeactivate;	/* pages moved active->inactive */
+	unsigned long pgkeephot;	/* pages sent back to active */
+	unsigned long pgkeepcold;	/* pages sent back to inactive */
 
 	unsigned long pgfault;		/* faults (major+minor) */
 	unsigned long pgmajfault;	/* faults (major only) */
@@ -307,6 +311,16 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageActivate(page)	test_bit(PG_activate, &(page)->flags)
+#define SetPageActivate(page)	set_bit(PG_activate, &(page)->flags)
+#define ClearPageActivate(page)	clear_bit(PG_activate, &(page)->flags)
+#define TestClearPageActivate(page) test_and_clear_bit(PG_activate, &(page)->flags)
+#define TestSetPageActivate(page) test_and_set_bit(PG_activate, &(page)->flags)
+
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
@@ -323,4 +337,28 @@ static inline void set_page_writeback(st
 	test_set_page_writeback(page);
 }
 
+#if PG_activate < PG_referenced
+#error unexpected page flags order
+#endif
+
+#define PAGE_REFCNT_0		0
+#define PAGE_REFCNT_1		(1 << PG_referenced)
+#define PAGE_REFCNT_2		(1 << PG_activate)
+#define PAGE_REFCNT_3		((1 << PG_activate) | (1 << PG_referenced))
+#define PAGE_REFCNT_MASK	PAGE_REFCNT_3
+
+/*
+ * STATUS   REFERENCE COUNT
+ *  __                   0
+ *  _R       PAGE_REFCNT_1
+ *  A_       PAGE_REFCNT_2
+ *  AR       PAGE_REFCNT_3
+ *
+ *  A/R: Active / Referenced
+ */
+static inline unsigned long page_refcnt(struct page *page)
+{
+	return page->flags & PAGE_REFCNT_MASK;
+}
+
 #endif	/* PAGE_FLAGS_H */
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/include/linux/radix-tree.h linux-2.6.14ra/include/linux/radix-tree.h
--- linux-2.6.14/include/linux/radix-tree.h	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/include/linux/radix-tree.h	2005-11-01 16:56:09.000000000 +0800
@@ -22,12 +22,39 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#ifdef __KERNEL__
+#define RADIX_TREE_MAP_SHIFT	6
+#else
+#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
+#endif
+#define RADIX_TREE_TAGS		2
+
+#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
+#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
+
+#define RADIX_TREE_TAG_LONGS	\
+	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
+
+struct radix_tree_node {
+	unsigned int	count;
+	void		*slots[RADIX_TREE_MAP_SIZE];
+	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
+};
+
 struct radix_tree_root {
 	unsigned int		height;
 	unsigned int		gfp_mask;
 	struct radix_tree_node	*rnode;
 };
 
+/*
+ * Support access patterns with strong locality.
+ */
+struct radix_tree_cache {
+	unsigned long first_index;
+	struct radix_tree_node *tree_node;
+};
+
 #define RADIX_TREE_INIT(mask)	{					\
 	.height = 0,							\
 	.gfp_mask = (mask),						\
@@ -45,8 +72,13 @@ do {									\
 } while (0)
 
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
-void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
+void *radix_tree_lookup_node(struct radix_tree_root *, unsigned long,
+							unsigned int);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
+unsigned long radix_tree_lookup_head(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan);
+unsigned long radix_tree_lookup_tail(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
@@ -68,4 +100,118 @@ static inline void radix_tree_preload_en
 	preempt_enable();
 }
 
+/**
+ *	radix_tree_lookup    -    perform lookup operation on a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root.
+ */
+static inline void *radix_tree_lookup(struct radix_tree_root *root,
+							unsigned long index)
+{
+	return radix_tree_lookup_node(root, index, 0);
+}
+
+/**
+ *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the slot corresponding to the position @index in the radix tree
+ *	@root. This is useful for update-if-exists operations.
+ */
+static inline void **radix_tree_lookup_slot(struct radix_tree_root *root,
+							unsigned long index)
+{
+	struct radix_tree_node *node;
+
+	node = radix_tree_lookup_node(root, index, 1);
+	return node->slots + (index & RADIX_TREE_MAP_MASK);
+}
+
+/**
+ *	radix_tree_cache_lookup_node    -    cached lookup node
+ *	@root:		radix tree root
+ *	@cache:		look-aside cache
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root,
+ *	and return the node @level levels from the bottom in the search path.
+ *	@cache stores the last accessed upper level tree node by this
+ *	function, and is always checked first before searching in the tree.
+ *	It can improve speed for access patterns with strong locality.
+ *	NOTE:
+ *	- The cache becomes invalid on leaving the lock;
+ *	- Do not intermix calls with different @level.
+ */
+static inline void *radix_tree_cache_lookup_node(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index, unsigned int level)
+{
+	struct radix_tree_node *node;
+        unsigned long i;
+        unsigned long mask;
+
+        if (level && level >= root->height)
+                return root->rnode;
+
+        i = ((index >> (level * RADIX_TREE_MAP_SHIFT)) & RADIX_TREE_MAP_MASK);
+        mask = ~((RADIX_TREE_MAP_SIZE << (level * RADIX_TREE_MAP_SHIFT)) - 1);
+
+	if ((index & mask) == cache->first_index)
+                return cache->tree_node->slots[i];
+
+	node = radix_tree_lookup_node(root, index, level + 1);
+	if (!node)
+		return 0;
+
+	cache->tree_node = node;
+	cache->first_index = (index & mask);
+        return node->slots[i];
+}
+
+/**
+ *	radix_tree_cache_lookup    -    cached lookup page
+ *	@root:		radix tree root
+ *	@cache:		look-aside cache
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root.
+ */
+static inline void *radix_tree_cache_lookup(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index)
+{
+	return radix_tree_cache_lookup_node(root, cache, index, 0);
+}
+
+static inline void radix_tree_cache_init(struct radix_tree_cache *cache)
+{
+	cache->first_index = 0x77;
+}
+
+static inline int radix_tree_cache_size(struct radix_tree_cache *cache)
+{
+	return RADIX_TREE_MAP_SIZE;
+}
+
+static inline int radix_tree_cache_count(struct radix_tree_cache *cache)
+{
+	if (cache->first_index != 0x77)
+		return cache->tree_node->count;
+	else
+		return 0;
+}
+
+static inline int radix_tree_cache_full(struct radix_tree_cache *cache)
+{
+	return radix_tree_cache_count(cache) == radix_tree_cache_size(cache);
+}
+
+static inline int radix_tree_cache_first_index(struct radix_tree_cache *cache)
+{
+	return cache->first_index;
+}
+
 #endif /* _LINUX_RADIX_TREE_H */
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/include/linux/sysctl.h linux-2.6.14ra/include/linux/sysctl.h
--- linux-2.6.14/include/linux/sysctl.h	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/include/linux/sysctl.h	2005-11-01 16:56:09.000000000 +0800
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_READAHEAD_RATIO=29, /* percent of read-ahead size to thrashing-threshold */
 };
 
 
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/include/linux/writeback.h linux-2.6.14ra/include/linux/writeback.h
--- linux-2.6.14/include/linux/writeback.h	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/include/linux/writeback.h	2005-11-01 19:38:23.000000000 +0800
@@ -90,6 +90,12 @@ void laptop_io_completion(void);
 void laptop_sync_completion(void);
 void throttle_vm_writeout(void);
 
+extern struct timer_list laptop_mode_wb_timer;
+static inline int laptop_spinned_down(void)
+{
+	return !timer_pending(&laptop_mode_wb_timer);
+}
+
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
 extern int vm_dirty_ratio;
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/kernel/sysctl.c linux-2.6.14ra/kernel/sysctl.c
--- linux-2.6.14/kernel/sysctl.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/kernel/sysctl.c	2005-11-01 16:56:09.000000000 +0800
@@ -67,6 +67,7 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+extern int readahead_ratio;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -849,6 +850,16 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_READAHEAD_RATIO,
+		.procname	= "readahead_ratio",
+		.data		= &readahead_ratio,
+		.maxlen		= sizeof(readahead_ratio),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/lib/radix-tree.c linux-2.6.14ra/lib/radix-tree.c
--- linux-2.6.14/lib/radix-tree.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/lib/radix-tree.c	2005-11-01 16:56:09.000000000 +0800
@@ -32,25 +32,6 @@
 #include <linux/bitops.h>
 
 
-#ifdef __KERNEL__
-#define RADIX_TREE_MAP_SHIFT	6
-#else
-#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
-#endif
-#define RADIX_TREE_TAGS		2
-
-#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
-#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
-
-#define RADIX_TREE_TAG_LONGS	\
-	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
-
-struct radix_tree_node {
-	unsigned int	count;
-	void		*slots[RADIX_TREE_MAP_SIZE];
-	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
-};
-
 struct radix_tree_path {
 	struct radix_tree_node *node;
 	int offset;
@@ -134,6 +115,7 @@ int radix_tree_preload(gfp_t gfp_mask)
 out:
 	return ret;
 }
+EXPORT_SYMBOL(radix_tree_preload);
 
 static inline void tag_set(struct radix_tree_node *node, int tag, int offset)
 {
@@ -282,13 +264,20 @@ int radix_tree_insert(struct radix_tree_
 EXPORT_SYMBOL(radix_tree_insert);
 
 /**
- *	radix_tree_lookup    -    perform lookup operation on a radix tree
+ *	radix_tree_lookup_node    -    low level lookup routine
  *	@root:		radix tree root
  *	@index:		index key
+ *	@level:		stop at that many levels from bottom
  *
  *	Lookup the item at the position @index in the radix tree @root.
+ *	The return value is:
+ *	@level == 0:      page at @index;
+ *	@level == 1:      the corresponding bottom level tree node;
+ *	@level < height:  (height - @level)th level tree node;
+ *	@level >= height: root node.
  */
-void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
+void *radix_tree_lookup_node(struct radix_tree_root *root,
+				unsigned long index, unsigned int level)
 {
 	unsigned int height, shift;
 	struct radix_tree_node *slot;
@@ -300,7 +289,7 @@ void *radix_tree_lookup(struct radix_tre
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
-	while (height > 0) {
+	while (height > level) {
 		if (slot == NULL)
 			return NULL;
 
@@ -311,7 +300,114 @@ void *radix_tree_lookup(struct radix_tre
 
 	return slot;
 }
-EXPORT_SYMBOL(radix_tree_lookup);
+EXPORT_SYMBOL(radix_tree_lookup_node);
+
+/**
+ *	radix_tree_lookup_head    -    lookup the head index
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      max items to scan
+ *
+ *      Lookup head index of the segment which contains @index. A segment is
+ *      a set of continuous pages in a file.
+ *      CASE                       RETURN VALUE
+ *      no page at @index          (not head) = @index + 1
+ *      found in the range         @index - @max_scan < (head index) <= @index
+ *      not found in range         (unfinished head) <= @index - @max_scan
+ */
+unsigned long radix_tree_lookup_head(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan)
+{
+	struct radix_tree_cache cache;
+	struct radix_tree_node *node;
+	int i;
+	unsigned long origin;
+
+	origin = index;
+	if (unlikely(max_scan > index))
+		max_scan = index;
+        radix_tree_cache_init(&cache);
+
+next_node:
+	if (origin - index > max_scan)
+		goto out;
+
+	node = radix_tree_cache_lookup_node(root, &cache, index, 1);
+	if (!node)
+		goto out;
+
+	if (node->count == RADIX_TREE_MAP_SIZE) {
+		if (index < RADIX_TREE_MAP_SIZE) {
+			index = -1;
+			goto out;
+		}
+		index = (index - RADIX_TREE_MAP_SIZE) | RADIX_TREE_MAP_MASK;
+		goto next_node;
+	}
+
+	for (i = index & RADIX_TREE_MAP_MASK; i >= 0; i--, index--) {
+		if (!node->slots[i])
+			goto out;
+	}
+
+	goto next_node;
+
+out:
+	return index + 1;
+}
+EXPORT_SYMBOL(radix_tree_lookup_head);
+
+/**
+ *	radix_tree_lookup_tail    -    lookup the tail index
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      max items to scan
+ *
+ *      Lookup tail(pass the end) index of the segment which contains @index.
+ *      A segment is a set of continuous pages in a file.
+ *      CASE                       RETURN VALUE
+ *      found in the range         @index <= (tail index) < @index + @max_scan
+ *      not found in range         @index + @max_scan <= (non tail)
+ */
+unsigned long radix_tree_lookup_tail(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan)
+{
+	struct radix_tree_cache cache;
+	struct radix_tree_node *node;
+	int i;
+	unsigned long origin;
+
+	origin = index;
+	if (unlikely(index + max_scan < index))
+		max_scan = LONG_MAX - index;
+        radix_tree_cache_init(&cache);
+
+next_node:
+	if (index - origin >= max_scan)
+		goto out;
+
+	node = radix_tree_cache_lookup_node(root, &cache, index, 1);
+	if (!node)
+		goto out;
+
+	if (node->count == RADIX_TREE_MAP_SIZE) {
+		index = (index | RADIX_TREE_MAP_MASK) + 1;
+		if (unlikely(!index))
+			goto out;
+		goto next_node;
+	}
+
+	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++, index++) {
+		if (!node->slots[i])
+			goto out;
+	}
+
+	goto next_node;
+
+out:
+	return index;
+}
+EXPORT_SYMBOL(radix_tree_lookup_tail);
 
 /**
  *	radix_tree_tag_set - set a tag on a radix tree node
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/mm/filemap.c linux-2.6.14ra/mm/filemap.c
--- linux-2.6.14/mm/filemap.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/mm/filemap.c	2005-11-01 16:56:09.000000000 +0800
@@ -702,6 +702,8 @@ grab_cache_page_nowait(struct address_sp
 
 EXPORT_SYMBOL(grab_cache_page_nowait);
 
+extern int readahead_ratio;
+
 /*
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level
@@ -729,10 +731,12 @@ void do_generic_mapping_read(struct addr
 	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
+	struct page *prev_page;
 	int error;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
+	prev_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
 	prev_index = ra.prev_page;
@@ -761,16 +765,36 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index)
+
+		if (readahead_ratio <= 9 && index == next_index)
 			next_index = page_cache_readahead(mapping, &ra, filp,
 					index, last_index - index);
 
 find_page:
 		page = find_get_page(mapping, index);
+		if (readahead_ratio > 9) {
+			if (unlikely(page == NULL)) {
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, NULL,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+				page = find_get_page(mapping, index);
+			} else if (PageReadahead(page)) {
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, page,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+			}
+		}
 		if (unlikely(page == NULL)) {
-			handle_ra_miss(mapping, &ra, index);
+			if (readahead_ratio <= 9)
+				handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
+		ra_access(&ra, page);
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -786,8 +810,9 @@ page_ok:
 		 * When (part of) the same page is read multiple times
 		 * in succession, only mark it as accessed the first time.
 		 */
-		if (prev_index != index)
+		if (prev_index != index) {
 			mark_page_accessed(page);
+		}
 		prev_index = index;
 
 		/*
@@ -805,7 +830,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -817,7 +841,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -842,7 +865,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -863,7 +885,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -872,7 +893,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -882,7 +902,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -907,15 +926,22 @@ no_cached_page:
 		}
 		page = cached_page;
 		cached_page = NULL;
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		goto readpage;
 	}
 
 out:
 	*_ra = ra;
+	if (readahead_ratio > 9)
+		_ra->prev_page = prev_index;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }
@@ -1213,19 +1239,33 @@ retry_all:
 	 *
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
-	if (VM_SequentialReadHint(area))
+	if (readahead_ratio <= 9 && VM_SequentialReadHint(area))
 		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
 	page = find_get_page(mapping, pgoff);
+	if (VM_SequentialReadHint(area) && readahead_ratio > 9) {
+		if (!page) {
+			page_cache_readahead_adaptive(mapping, ra,
+						file, NULL, NULL,
+						pgoff, pgoff, pgoff + 1);
+			page = find_get_page(mapping, pgoff);
+		} else if (PageReadahead(page)) {
+			page_cache_readahead_adaptive(mapping, ra,
+						file, NULL, page,
+						pgoff, pgoff, pgoff + 1);
+		}
+	}
 	if (!page) {
 		unsigned long ra_pages;
 
 		if (VM_SequentialReadHint(area)) {
-			handle_ra_miss(mapping, ra, pgoff);
+			if (readahead_ratio <= 9)
+				handle_ra_miss(mapping, ra, pgoff);
 			goto no_cached_page;
 		}
 		ra->mmap_miss++;
@@ -1250,6 +1290,13 @@ retry_find:
 		if (ra_pages) {
 			pgoff_t start = 0;
 
+			/*
+			 * Max read-around should be much smaller than
+			 * max read-ahead.
+			 * How about adding a tunable parameter for this?
+			 */
+			if (ra_pages > 64)
+				ra_pages = 64;
 			if (pgoff > ra_pages / 2)
 				start = pgoff - ra_pages / 2;
 			do_page_cache_readahead(mapping, file, start, ra_pages);
@@ -1262,6 +1309,8 @@ retry_find:
 	if (!did_readaround)
 		ra->mmap_hit++;
 
+	ra_access(ra, page);
+
 	/*
 	 * Ok, found a page in the page cache, now we need to check
 	 * that it's up-to-date.
@@ -1276,6 +1325,8 @@ success:
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
+	if (readahead_ratio > 9)
+		ra->prev_page = page->index;
 	return page;
 
 outside_data_content:
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/mm/page_alloc.c linux-2.6.14ra/mm/page_alloc.c
--- linux-2.6.14/mm/page_alloc.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/mm/page_alloc.c	2005-11-01 19:38:19.000000000 +0800
@@ -460,6 +460,7 @@ static void prep_new_page(struct page *p
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
+			1 << PG_activate | 1 << PG_readahead |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	page->private = 0;
 	set_page_refs(page, order);
@@ -784,9 +785,15 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	struct task_struct *p = current;
 	int i;
 	int classzone_idx;
+	int do_reclaim;
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
+	unsigned long zones_mask;
+	int left_count;
+	int batch_size;
+	int batch_base;
+	int batch_idx;
 
 	might_sleep_if(wait);
 
@@ -806,13 +813,62 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	classzone_idx = zone_idx(zones[0]);
 
-restart:
 	/*
 	 * Go through the zonelist once, looking for a zone with enough free.
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
-		int do_reclaim = should_reclaim_zone(z, gfp_mask);
+restart:
+	/*
+	 * To fulfill three goals:
+	 * - balanced page aging
+	 * - locality
+	 * - predefined zonelist priority
+	 *
+	 * The logic employs the following rules:
+	 * 1. Zones are checked in predefined order in general.
+	 * 2. Skip to the next zone if it has lower page_age.
+	 * 3. Checkings are carried out in batch, all zones in a batch must be
+	 *    checked before entering the next batch.
+	 * 4. All local zones in the zonelist forms the first batch.
+	 */
+
+	/* TODO: Avoid this loop by putting the values into struct zonelist.
+	 * The (more general) desired batch counts can also go there.
+	 */
+	for (batch_size = 0, i = 0; (z = zones[i]) != NULL; i++) {
+		if (z->zone_pgdat == zones[0]->zone_pgdat)
+			batch_size++;
+	}
+	BUG_ON(!batch_size);
+
+	left_count = i - batch_size;
+	batch_base = 0;
+	batch_idx = 0;
+	zones_mask = 0;
+
+	for (;;) {
+		if (zones_mask == (1 << batch_size) - 1) {
+			if (left_count <= 0) {
+				break;
+			}
+			batch_base += batch_size;
+			batch_size = min(left_count, (int)sizeof(zones_mask) * 8);
+			left_count -= batch_size;
+			batch_idx = 0;
+			zones_mask = 0;
+		}
+
+		do {
+			i = batch_idx;
+			do {
+				if (++batch_idx >= batch_size)
+					batch_idx = 0;
+			} while (zones_mask & (1 << batch_idx));
+		} while (pages_more_aged(zones[batch_base + i],
+					 zones[batch_base + batch_idx]));
+
+		zones_mask |= (1 << i);
+		z = zones[batch_base + i];
 
 		if (!cpuset_zone_allowed(z, __GFP_HARDWALL))
 			continue;
@@ -822,11 +878,12 @@ restart:
 		 * will try to reclaim pages and check the watermark a second
 		 * time before giving up and falling back to the next zone.
 		 */
+		do_reclaim = should_reclaim_zone(z, gfp_mask);
 zone_reclaim_retry:
 		if (!zone_watermark_ok(z, order, z->pages_low,
 				       classzone_idx, 0, 0)) {
 			if (!do_reclaim)
-				continue;
+				goto try_harder;
 			else {
 				zone_reclaim(z, gfp_mask, order);
 				/* Only try reclaim once */
@@ -838,20 +895,18 @@ zone_reclaim_retry:
 		page = buffered_rmqueue(z, order, gfp_mask);
 		if (page)
 			goto got_pg;
-	}
 
-	for (i = 0; (z = zones[i]) != NULL; i++)
+try_harder:
 		wakeup_kswapd(z, order);
 
-	/*
-	 * Go through the zonelist again. Let __GFP_HIGH and allocations
-	 * coming from realtime tasks to go deeper into reserves
-	 *
-	 * This is the last chance, in general, before the goto nopage.
-	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
-	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
-	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
+		/*
+		 * Put stress on the zone. Let __GFP_HIGH and allocations
+		 * coming from realtime tasks to go deeper into reserves.
+		 *
+		 * This is the last chance, in general, before the goto nopage.
+		 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
+		 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
+		 */
 		if (!zone_watermark_ok(z, order, z->pages_min,
 				       classzone_idx, can_try_harder,
 				       gfp_mask & __GFP_HIGH))
@@ -1355,6 +1410,8 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" aging:%lukB"
+			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",
@@ -1366,6 +1423,8 @@ void show_free_areas(void)
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
+			K(zone->nr_page_aging),
+			zone->page_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
@@ -1931,6 +1990,9 @@ static void __init free_area_init_core(s
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->nr_page_aging = 0;
+		zone->aging_milestone = 0;
+		zone->page_age = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2102,6 +2164,8 @@ static int zoneinfo_show(struct seq_file
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        aging    %lu"
+			   "\n        age      %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2111,6 +2175,8 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->nr_page_aging,
+			   zone->page_age,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
@@ -2205,6 +2271,8 @@ static char *vmstat_text[] = {
 	"pgfree",
 	"pgactivate",
 	"pgdeactivate",
+	"pgkeephot",
+	"pgkeepcold",
 
 	"pgfault",
 	"pgmajfault",
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/mm/page-writeback.c linux-2.6.14ra/mm/page-writeback.c
--- linux-2.6.14/mm/page-writeback.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/mm/page-writeback.c	2005-11-01 19:38:23.000000000 +0800
@@ -369,7 +369,7 @@ static void wb_timer_fn(unsigned long un
 static void laptop_timer_fn(unsigned long unused);
 
 static DEFINE_TIMER(wb_timer, wb_timer_fn, 0, 0);
-static DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
+DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
 
 /*
  * Periodic writeback of "old" data.
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/mm/readahead.c linux-2.6.14ra/mm/readahead.c
--- linux-2.6.14/mm/readahead.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/mm/readahead.c	2005-11-01 19:38:23.000000000 +0800
@@ -14,6 +14,256 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/writeback.h>
+
+/* Set look-ahead size to 1/8 of the thrashing-threshold. */
+#define LOOKAHEAD_RATIO 8
+
+/* Set read-ahead size to ##% of the thrashing-threshold. */
+int readahead_ratio = 50;
+EXPORT_SYMBOL(readahead_ratio);
+
+/* Analog to nr_page_aging.
+ * But mainly increased on fresh page references, so is much more smoother.
+ */
+DEFINE_PER_CPU(unsigned long, smooth_aging);
+EXPORT_PER_CPU_SYMBOL(smooth_aging);
+
+/* Detailed classification of read-ahead behaviors. */
+#define RA_CLASS_SHIFT 3
+#define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
+enum ra_class {
+	RA_CLASS_ALL,
+	RA_CLASS_NEWFILE,
+	RA_CLASS_STATE,
+	RA_CLASS_CONTEXT,
+	RA_CLASS_CONTEXT_ACCELERATED,
+	RA_CLASS_BACKWARD,
+	RA_CLASS_RANDOM_THRASHING,
+	RA_CLASS_RANDOM_SEEK,
+	RA_CLASS_END,
+};
+
+/* Read-ahead events to be accounted. */
+enum ra_event {
+	RA_EVENT_CACHE_MISS,		/* read cache misses */
+	RA_EVENT_READRANDOM,		/* random reads */
+	RA_EVENT_IO_CONGESTION,		/* io congestion */
+	RA_EVENT_IO_CACHE_HIT,		/* canceled io due to cache hit */
+	RA_EVENT_IO_BLOCK,		/* read on locked page */
+
+	RA_EVENT_READAHEAD,		/* read-ahead issued */
+	RA_EVENT_READAHEAD_HIT,		/* read-ahead page hit */
+	RA_EVENT_LOOKAHEAD,		/* look-ahead issued */
+	RA_EVENT_LOOKAHEAD_HIT,		/* look-ahead mark hit */
+	RA_EVENT_READAHEAD_EOF,		/* read-ahead reaches EOF */
+	RA_EVENT_READAHEAD_SHRINK,	/* ra_size decreased, reflects var. */
+	RA_EVENT_READAHEAD_THRASHING,	/* read-ahead thrashing happened */
+	RA_EVENT_READAHEAD_RESCUE,	/* read-ahead rescued */
+
+	RA_EVENT_END
+};
+
+/*
+ * Debug facilities.
+ */
+#ifdef CONFIG_DEBUG_FS
+#define DEBUG_READAHEAD
+#endif
+
+#ifdef DEBUG_READAHEAD
+#include <linux/jiffies.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+
+static char *ra_class_name[] = {
+	"total",
+	"newfile",
+	"state",
+	"context",
+	"contexta",
+	"backward",
+	"onthrash",
+	"onraseek",
+	"none",
+};
+
+static char *ra_event_name[] = {
+	"cache_miss",
+	"read_random",
+	"io_congestion",
+	"io_cache_hit",
+	"io_block",
+	"readahead",
+	"readahead_hit",
+	"lookahead",
+	"lookahead_hit",
+	"readahead_eof",
+	"readahead_shrink",
+	"readahead_thrash",
+	"readahead_rescue",
+};
+
+static unsigned long ra_event_count[RA_CLASS_END+1][RA_EVENT_END][2];
+
+static inline void ra_account(struct file_ra_state *ra,
+				enum ra_event e, int pages)
+{
+	enum ra_class c;
+
+	c = (ra ? ra->flags & RA_CLASS_MASK : RA_CLASS_END);
+	if (e == RA_EVENT_READAHEAD_HIT && pages < 0) {
+		c = (ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK;
+		pages = -pages;
+	}
+	if (!c)
+		c = RA_CLASS_END;
+	BUG_ON(c > RA_CLASS_END);
+
+	ra_event_count[c][e][0] += 1;
+	ra_event_count[c][e][1] += pages;
+}
+
+static int ra_account_show(struct seq_file *s, void *_)
+{
+	int i;
+	int c;
+	int e;
+	static char event_fmt[] = "%-16s";
+	static char class_fmt[] = "%11s";
+	static char item_fmt[] = "%11lu";
+	static char percent_format[] = "%10lu%%";
+	static char *table_name[] = {
+		"[table requests]",
+		"[table pages]",
+		"[table summary]"};
+
+	for (i = 0; i <= 1; i++) {
+		for (e = 0; e < RA_EVENT_END; e++) {
+			ra_event_count[0][e][i] = 0;
+			for (c = 1; c <= RA_CLASS_END; c++)
+				ra_event_count[0][e][i] +=
+							ra_event_count[c][e][i];
+		}
+
+		seq_printf(s, event_fmt, table_name[i]);
+		for (c = 0; c <= RA_CLASS_END; c++)
+			seq_printf(s, class_fmt, ra_class_name[c]);
+		seq_puts(s, "\n");
+
+		for (e = 0; e < RA_EVENT_END; e++) {
+			if (e == RA_EVENT_READAHEAD_HIT && i == 0)
+				continue;
+
+			seq_printf(s, event_fmt, ra_event_name[e]);
+			for (c = 0; c <= RA_CLASS_END; c++)
+				seq_printf(s, item_fmt,
+						ra_event_count[c][e][i]);
+			seq_puts(s, "\n");
+		}
+		seq_puts(s, "\n");
+	}
+
+	seq_printf(s, event_fmt, table_name[2]);
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, class_fmt, ra_class_name[c]);
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "random_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_event_count[c][RA_EVENT_READRANDOM][0] * 100) /
+			(ra_event_count[c][RA_EVENT_READRANDOM][0] +
+			 ra_event_count[c][RA_EVENT_READAHEAD][0] + 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "ra_hit_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_event_count[c][RA_EVENT_READAHEAD_HIT][1] * 100) /
+			(ra_event_count[c][RA_EVENT_READAHEAD][1] + 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "la_hit_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD_HIT][0] * 100) /
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][0] + 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_ra_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_event_count[c][RA_EVENT_READAHEAD][1] +
+			 ra_event_count[c][RA_EVENT_READAHEAD][0] / 2) /
+			(ra_event_count[c][RA_EVENT_READAHEAD][0] + 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_la_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][1] +
+			 ra_event_count[c][RA_EVENT_LOOKAHEAD][0] / 2) /
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][0] + 1));
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static struct dentry *readahead_dentry;
+
+static int ra_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ra_account_show, NULL);
+}
+
+static ssize_t ra_debug_write(struct file *file, const char __user *buf,
+				size_t size, loff_t *offset)
+{
+	if (file->f_dentry == readahead_dentry)
+		memset(ra_event_count, 0, sizeof(ra_event_count));
+	return 1;
+}
+
+static struct file_operations ra_debug_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ra_debug_open,
+	.write		= ra_debug_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init readahead_init(void)
+{
+	readahead_dentry = debugfs_create_file("readahead",
+					0644, NULL, NULL, &ra_debug_fops);
+	return 0;
+}
+
+module_init(readahead_init)
+
+#define dprintk(args...) \
+	if (readahead_ratio & 1) printk(KERN_DEBUG args)
+#define ddprintk(args...) \
+	if ((readahead_ratio & 3) == 3) printk(KERN_DEBUG args)
+
+#else /* !DEBUG_READAHEAD */
+
+static inline void ra_account(struct file_ra_state *ra,
+				enum ra_event e, int pages)
+{
+}
+#define dprintk(args...)     do {} while(0)
+#define ddprintk(args...)    do {} while(0)
+
+#endif /* DEBUG_READAHEAD */
+
+
+/* The default max/min read-ahead pages. */
+#define MAX_RA_PAGES	(VM_MAX_READAHEAD >> (PAGE_CACHE_SHIFT - 10))
+#define MIN_RA_PAGES	(VM_MIN_READAHEAD >> (PAGE_CACHE_SHIFT - 10))
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -21,7 +271,7 @@ void default_unplug_io_fn(struct backing
 EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
-	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.ra_pages	= MAX_RA_PAGES,
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
@@ -49,7 +299,7 @@ static inline unsigned long get_max_read
 
 static inline unsigned long get_min_readahead(struct file_ra_state *ra)
 {
-	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	return MIN_RA_PAGES;
 }
 
 static inline void ra_off(struct file_ra_state *ra)
@@ -254,10 +504,11 @@ out:
  */
 static int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			unsigned long offset, unsigned long nr_to_read)
+			unsigned long offset, unsigned long nr_to_read,
+			unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
+	struct page *page = NULL;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
@@ -267,7 +518,7 @@ __do_page_cache_readahead(struct address
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -275,7 +526,7 @@ __do_page_cache_readahead(struct address
 	read_lock_irq(&mapping->tree_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		unsigned long page_offset = offset + page_idx;
-		
+
 		if (page_offset > end_index)
 			break;
 
@@ -290,6 +541,9 @@ __do_page_cache_readahead(struct address
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
+		if (readahead_ratio > 9 &&
+				page_idx == nr_to_read - lookahead_size)
+			SetPageReadahead(page);
 		ret++;
 	}
 	read_unlock_irq(&mapping->tree_lock);
@@ -326,7 +580,7 @@ int force_page_cache_readahead(struct ad
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+						offset, this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -373,7 +627,7 @@ int do_page_cache_readahead(struct addre
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 }
 
 /*
@@ -393,7 +647,10 @@ blockable_page_cache_readahead(struct ad
 	if (!block && bdi_read_congested(mapping->backing_dev_info))
 		return 0;
 
-	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
 
 	return check_ra_success(ra, nr_to_read, actual);
 }
@@ -556,3 +813,1407 @@ unsigned long max_sane_readahead(unsigne
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
+
+/*
+ * Adaptive read-ahead.
+ *
+ * Good read patterns are compact both in space and time. The read-ahead logic
+ * tries to grant larger read-ahead size to better readers under the constraint
+ * of system memory and load pressures.
+ *
+ * It employs two methods to estimate the max thrashing safe read-ahead size:
+ *   1. state based   - the default one
+ *   2. context based - the fail safe one
+ * The integration of the dual methods has the merit of being agile and robust.
+ * It makes the overall design clean: special cases are handled in general by
+ * the stateless method, leaving the stateful one simple and fast.
+ *
+ * To improve throughput and decrease read delay, the logic 'looks ahead'.
+ * In every read-ahead chunk, it selects one page and tag it with PG_readahead.
+ * Later when the page with PG_readahead is to be read, the logic knows that
+ * it's time to carry out the next read-ahead chunk in advance.
+ *
+ *                 a read-ahead chunk
+ *    +-----------------------------------------+
+ *    |       # PG_readahead                    |
+ *    +-----------------------------------------+
+ *            ^ When this page is read, we submit I/O for the next read-ahead.
+ *
+ *
+ * Here are some variable names used frequently:
+ *
+ *                                   |<------- la_size ------>|
+ *                  +-----------------------------------------+
+ *                  |                #                        |
+ *                  +-----------------------------------------+
+ *      ra_index -->|<---------------- ra_size -------------->|
+ *
+ */
+
+#define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
+#define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
+
+/*
+ * The nature of read-ahead allows most tests to fail or even be wrong.
+ * Here we just do not bother to call get_page(), it's meaningless anyway.
+ */
+static inline struct page *__find_page(struct address_space *mapping,
+						unsigned long offset)
+{
+	return radix_tree_lookup(&mapping->page_tree, offset);
+}
+
+struct page *find_page(struct address_space *mapping, unsigned long offset)
+{
+	struct page *page;
+
+	read_lock_irq(&mapping->tree_lock);
+	page = __find_page(mapping, offset);
+	read_unlock_irq(&mapping->tree_lock);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	if (page)
+		BUG_ON(page->index != offset);
+#endif
+	return page;
+}
+
+/*
+ * Move pages in danger (of thrashing) to the head of inactive_list.
+ * Not expected to happen frequently.
+ */
+static int rescue_pages(struct page *page, unsigned long nr_pages)
+{
+	unsigned long pgrescue;
+	unsigned long index;
+	struct address_space *mapping;
+	struct zone *zone;
+
+	BUG_ON(!nr_pages || !page);
+	pgrescue = 0;
+	index = page_index(page);
+	mapping = page_mapping(page);
+
+	dprintk("rescue_pages(ino=%lu, index=%lu nr=%lu)\n",
+			mapping->host->i_ino, index, nr_pages);
+
+	for(;;) {
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+
+		if (!PageLRU(page))
+			goto out_unlock;
+
+		while (page_mapping(page) == mapping &&
+				page_index(page) == index) {
+			struct page *the_page = page;
+			page = next_page(page);
+			if (!PageActive(the_page) &&
+					!PageActivate(the_page) &&
+					!PageLocked(the_page) &&
+					page_count(the_page) == 1) {
+				list_move(&the_page->lru, &zone->inactive_list);
+				pgrescue++;
+			}
+			index++;
+			if (!--nr_pages)
+				goto out_unlock;
+		}
+
+		spin_unlock_irq(&zone->lru_lock);
+
+		page = find_page(mapping, index);
+		if (!page)
+			goto out;
+	}
+out_unlock:
+	spin_unlock_irq(&zone->lru_lock);
+out:
+	ra_account(0, RA_EVENT_READAHEAD_RESCUE, pgrescue);
+
+	return nr_pages ? index : 0;
+}
+
+/*
+ * State based calculation of read-ahead request.
+ *
+ * This figure shows the meaning of file_ra_state members:
+ *
+ *             chunk A                            chunk B
+ *  +---------------------------+-------------------------------------------+
+ *  |             #             |                   #                       |
+ *  +---------------------------+-------------------------------------------+
+ *                ^             ^                   ^                       ^
+ *              la_index      ra_index     lookahead_index         readahead_index
+ */
+
+/*
+ * The global effective length of the inactive_list(s).
+ */
+static unsigned long nr_free_inactive(void)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_inactive +
+			zones[i].free_pages - zones[i].pages_low;
+
+	return sum;
+}
+
+/*
+ * The accumulated count of pages pushed into inactive_list(s).
+ */
+static unsigned long nr_page_aging(void)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_page_aging;
+
+	return sum;
+}
+
+/*
+ * A much smoother analog to nr_page_aging.
+ */
+static unsigned long nr_smooth_aging(void)
+{
+	unsigned long cpu;
+	unsigned long sum = 0;
+	cpumask_t mask = node_to_cpumask(node);
+
+	for_each_cpu_mask(cpu, mask)
+		sum += per_cpu(smooth_aging, cpu);
+
+	return sum;
+}
+
+/*
+ * Set class of read-ahead
+ */
+static inline void set_ra_class(struct file_ra_state *ra,
+				enum ra_class ra_class)
+{
+	ra->flags <<= RA_CLASS_SHIFT;
+	ra->flags += ra_class;
+}
+
+/*
+ * The 64bit cache_hit stores three accumulated value and one counter value.
+ * MSB                                                                   LSB
+ * 3333333333333333 : 2222222222222222 : 1111111111111111 : 0000000000000000
+ */
+static inline int ra_cache_hit(struct file_ra_state *ra, int nr)
+{
+	return (ra->cache_hit >> (nr * 16)) & 0xFFFF;
+}
+
+/*
+ * Something like:
+ * ra_cache_hit(ra, 1) += ra_cache_hit(ra, 0);
+ * ra_cache_hit(ra, 0) = 0;
+ */
+static inline void ra_addup_cache_hit(struct file_ra_state *ra)
+{
+	int n;
+
+	n = ra_cache_hit(ra, 0);
+	ra->cache_hit -= n;
+	n <<= 16;
+	ra->cache_hit += n;
+}
+
+/*
+ * The read-ahead is deemed success if cache-hit-rate > 50%.
+ */
+static inline int ra_cache_hit_ok(struct file_ra_state *ra)
+{
+	return ra_cache_hit(ra, 0) * 2 > (ra->lookahead_index - ra->la_index);
+}
+
+/*
+ * Check if @index falls in the ra request.
+ */
+static inline int ra_has_index(struct file_ra_state *ra, unsigned long index)
+{
+	if (index < ra->la_index || index >= ra->readahead_index)
+		return 0;
+
+	if (index >= ra->ra_index)
+		return 1;
+	else
+		return -1;
+}
+
+/*
+ * Prepare file_ra_state for a new read-ahead sequence.
+ */
+static inline void ra_state_init(struct file_ra_state *ra,
+				unsigned long la_index, unsigned long ra_index)
+{
+	ra_addup_cache_hit(ra);
+	ra->cache_hit <<= 16;
+	ra->lookahead_index = la_index;
+	ra->readahead_index = ra_index;
+}
+
+/*
+ * Take down a new read-ahead request in file_ra_state.
+ */
+static inline void ra_state_update(struct file_ra_state *ra,
+				unsigned long ra_size, unsigned long la_size)
+{
+#ifdef DEBUG_READAHEAD
+	unsigned long old_ra = ra->readahead_index - ra->ra_index;
+	if (ra_size < old_ra && ra_cache_hit(ra, 0))
+		ra_account(ra, RA_EVENT_READAHEAD_SHRINK, old_ra - ra_size);
+#endif
+	ra_addup_cache_hit(ra);
+	ra->ra_index = ra->readahead_index;
+	ra->la_index = ra->lookahead_index;
+	ra->readahead_index += ra_size;
+	ra->lookahead_index = ra->readahead_index - la_size;
+	ra->age = nr_smooth_aging();
+}
+
+/*
+ * Adjust the read-ahead request in file_ra_state.
+ */
+static inline void ra_state_adjust(struct file_ra_state *ra,
+				unsigned long ra_size, unsigned long la_size)
+{
+	ra->readahead_index = ra->ra_index + ra_size;
+	ra->lookahead_index = ra->readahead_index - la_size;
+}
+
+/*
+ * Submit IO for the read-ahead request in file_ra_state.
+ */
+static int ra_dispatch(struct file_ra_state *ra,
+			struct address_space *mapping, struct file *filp)
+{
+	unsigned long eof_index;
+	unsigned long ra_size;
+	unsigned long la_size;
+	int actual;
+	enum ra_class ra_class;
+
+	ra_class = (ra->flags & RA_CLASS_MASK);
+	BUG_ON(ra_class == 0 || ra_class > RA_CLASS_END);
+
+	eof_index = ((i_size_read(mapping->host) - 1) >> PAGE_CACHE_SHIFT) + 1;
+	ra_size = ra->readahead_index - ra->ra_index;
+	la_size = ra->readahead_index - ra->lookahead_index;
+
+	/* Snap to EOF. */
+	if (unlikely(ra->ra_index >= eof_index))
+		return 0;
+	if (ra->readahead_index + ra_size / 2 > eof_index) {
+		if (ra_class == RA_CLASS_CONTEXT_ACCELERATED &&
+				eof_index > ra->lookahead_index + 1)
+			la_size = eof_index - ra->lookahead_index;
+		else
+			la_size = 0;
+		ra_size = eof_index - ra->ra_index;
+		ra_state_adjust(ra, ra_size, la_size);
+	}
+
+	actual = __do_page_cache_readahead(mapping, filp,
+					ra->ra_index, ra_size, la_size);
+
+	if (ra->readahead_index == eof_index)
+		ra_account(ra, RA_EVENT_READAHEAD_EOF, actual);
+	if (la_size)
+		ra_account(ra, RA_EVENT_LOOKAHEAD, la_size);
+	if (ra_size > actual)
+		ra_account(ra, RA_EVENT_IO_CACHE_HIT, ra_size - actual);
+	ra_account(ra, RA_EVENT_READAHEAD, actual);
+
+	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
+			ra_class_name[ra_class],
+			mapping->host->i_ino, ra->la_index,
+			ra->ra_index, ra_size, la_size, actual);
+
+	return actual;
+}
+
+/*
+ * Determine the request parameters from primitive values.
+ *
+ * It applies the following rules:
+ *   - Substract ra_size by the old look-ahead to get real safe read-ahead;
+ *   - Set new la_size according to the (still large) ra_size;
+ *   - Apply upper limits;
+ *   - Make sure stream_shift is not too small.
+ *     (So that the next global_shift will not be too small.)
+ *
+ * Input:
+ * ra_size stores the estimated thrashing-threshold.
+ * la_size stores the look-ahead size of previous request.
+ */
+static inline int adjust_rala(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	unsigned long stream_shift = *la_size;
+
+	if (*ra_size > *la_size)
+		*ra_size -= *la_size;
+	else
+		return 0;
+
+	*la_size = *ra_size / LOOKAHEAD_RATIO;
+
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
+	stream_shift += (*ra_size - *la_size);
+	if (stream_shift < *ra_size / 4)
+		*la_size -= (*ra_size / 4 - stream_shift);
+
+	return 1;
+}
+
+/*
+ * The function estimates two values:
+ * 1. thrashing-threshold for the current stream
+ *    It is returned to make the next read-ahead request.
+ * 2. the remained space for the current chunk
+ *    It will be checked to ensure that the current chunk is safe.
+ *
+ * The computation will be pretty accurate under heavy load, and will change
+ * vastly with light load(small global_shift), so the grow speed of ra_size
+ * must be limited, and a moderate large stream_shift must be insured.
+ *
+ * This figure illustrates the formula:
+ * While the stream reads stream_shift pages inside the chunks,
+ * the chunks are shifted global_shift pages inside inactive_list.
+ *
+ *      chunk A                    chunk B
+ *                          |<=============== global_shift ================|
+ *  +-------------+         +-------------------+                          |
+ *  |       #     |         |           #       |            inactive_list |
+ *  +-------------+         +-------------------+                     head |
+ *          |---->|         |---------->|
+ *             |                  |
+ *             +-- stream_shift --+
+ */
+static inline unsigned long compute_thrashing_threshold(
+						struct file_ra_state *ra,
+						unsigned long *remain)
+{
+	unsigned long global_size;
+	unsigned long global_shift;
+	unsigned long stream_shift;
+	unsigned long ra_size;
+
+	global_size = nr_free_inactive();
+	global_shift = nr_smooth_aging() - ra->age;
+	stream_shift = ra_cache_hit(ra, 0);
+
+	ra_size = stream_shift *
+			global_size * readahead_ratio / (100 * global_shift);
+
+	if (global_size > global_shift)
+		*remain = stream_shift *
+				(global_size - global_shift) / global_shift;
+	else
+		*remain = 0;
+
+	ddprintk("compute_thrashing_threshold: "
+			"ra=%lu=%lu*%lu/%lu, remain %lu for %lu\n",
+			ra_size, stream_shift, global_size, global_shift,
+			*remain, ra->readahead_index - ra->lookahead_index);
+
+	return ra_size;
+}
+
+/*
+ * Main function for file_ra_state based read-ahead.
+ */
+static inline unsigned long
+state_based_readahead(struct address_space *mapping, struct file *filp,
+			struct file_ra_state *ra, struct page *page,
+			unsigned long ra_max)
+{
+	unsigned long ra_old;
+	unsigned long ra_size;
+	unsigned long la_size;
+	unsigned long remain_space;
+
+	la_size = ra->readahead_index - ra->lookahead_index;
+	ra_old = ra->readahead_index - ra->ra_index;
+	ra_size = compute_thrashing_threshold(ra, &remain_space);
+
+	if (readahead_ratio < VM_READAHEAD_PROTECT_RATIO &&
+			remain_space <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return 0;
+	}
+
+	if (!adjust_rala(min(ra_max, 2 * ra_old + (ra_max - ra_old) / 16),
+				&ra_size, &la_size))
+		return 0;
+
+	set_ra_class(ra, RA_CLASS_STATE);
+	ra_state_update(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * Page cache context based estimation of read-ahead/look-ahead size/index.
+ *
+ * The logic first looks backward in the inactive_list to get an estimation of
+ * the thrashing-threshold, and then, if necessary, looks forward to determine
+ * the start point of next read-ahead.
+ *
+ * The estimation theory can be illustrated with figure:
+ *
+ *   chunk A           chunk B                      chunk C                 head
+ *
+ *   l01 l11           l12   l21                    l22
+ *| |-->|-->|       |------>|-->|                |------>|
+ *| +-------+       +-----------+                +-------------+               |
+ *| |   #   |       |       #   |                |       #     |               |
+ *| +-------+       +-----------+                +-------------+               |
+ *| |<==============|<===========================|<============================|
+ *        L0                     L1                            L2
+ *
+ * Let f(l) = L be a map from
+ * 	l: the number of pages read by the stream
+ * to
+ * 	L: the number of pages pushed into inactive_list in the mean time
+ * then
+ * 	f(l01) <= L0
+ * 	f(l11 + l12) = L1
+ * 	f(l21 + l22) = L2
+ * 	...
+ * 	f(l01 + l11 + ...) <= Sum(L0 + L1 + ...)
+ *                         <= Length(inactive_list) = f(thrashing-threshold)
+ *
+ * So the count of countinuous history pages left in the inactive_list is always
+ * a lower estimation of the true thrashing-threshold.
+ */
+
+/*
+ * STATUS   REFERENCE COUNT      TYPE
+ *  A__                   0      not in inactive list
+ *  ___                   0      fresh
+ *  __R       PAGE_REFCNT_1      stale
+ *  _a_       PAGE_REFCNT_2      disturbed once
+ *  _aR       PAGE_REFCNT_3      disturbed twice
+ *
+ *  A/a/R: Active / aCTIVATE / Referenced
+ */
+static inline unsigned long cold_page_refcnt(struct page *page)
+{
+	if (!page || PageActive(page))
+		return 0;
+
+	return page_refcnt(page);
+}
+
+static inline char page_refcnt_symbol(struct page *page)
+{
+	if (!page)
+		return 'X';
+	if (PageActive(page))
+		return 'A';
+	switch (page_refcnt(page)) {
+		case 0:
+			return '_';
+		case PAGE_REFCNT_1:
+			return '-';
+		case PAGE_REFCNT_2:
+			return '=';
+		case PAGE_REFCNT_3:
+			return '#';
+	}
+	return '?';
+}
+
+/*
+ * Count/estimate cache hits in range [first_index, last_index].
+ * The estimation is simple and a bit optimistic.
+ */
+static int count_cache_hit(struct address_space *mapping,
+			unsigned long first_index, unsigned long last_index)
+{
+	static int steps[8] = {0, 4, 2, 6, 1, 3, 5, 7};
+	struct page *page;
+	int size = last_index - first_index + 1;
+	int count = 0;
+	int i;
+
+	read_lock_irq(&mapping->tree_lock);
+
+	for (i = 0; i < 8;) {
+		page = __find_page(mapping,
+					first_index + size * steps[i++] / 8);
+		if (cold_page_refcnt(page) >= PAGE_REFCNT_1 && ++count >= 2)
+			break;
+	}
+
+	read_unlock_irq(&mapping->tree_lock);
+
+	return size * count / i;
+}
+
+/*
+ * Look back and check history pages to estimate thrashing-threshold.
+ */
+static int query_page_cache(struct address_space *mapping,
+			unsigned long *remain, unsigned long offset,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	int step;
+	int count;
+	unsigned long index;
+	unsigned long nr_lookback;
+        struct radix_tree_cache cache;
+
+	/*
+	 * Scan backward and check the near @ra_max pages.
+	 * The count here determines ra_size.
+	 */
+	read_lock_irq(&mapping->tree_lock);
+	index = radix_tree_lookup_head(&mapping->page_tree, offset, ra_max);
+	read_unlock_irq(&mapping->tree_lock);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	if (index <= offset) {
+		WARN_ON(!find_page(mapping, index));
+		if (index + ra_max > offset)
+			WARN_ON(find_page(mapping, index - 1));
+	} else {
+		BUG_ON(index > offset + 1);
+		WARN_ON(find_page(mapping, offset));
+	}
+#endif
+
+	*remain = offset - index + 1;
+
+	if (unlikely(*remain <= ra_min)) {
+		count = ra_min;
+		goto out;
+	}
+
+	count = count_cache_hit(mapping, index, offset);
+	if (count < ra_min)
+		count = ra_min;
+	if (unlikely(count * 2 < offset - index))
+		goto out;
+
+	if (*remain < ra_max)
+		goto out;
+
+	/*
+	 * Check the far pages coarsely.
+	 * The big count here helps increase la_size.
+	 */
+	nr_lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
+						100 / (readahead_ratio + 1);
+	if (nr_lookback > offset)
+		nr_lookback = offset;
+
+        radix_tree_cache_init(&cache);
+	read_lock_irq(&mapping->tree_lock);
+	for (step = 2 * ra_max; step < nr_lookback; step += ra_max) {
+		struct radix_tree_node *node;
+		node = radix_tree_cache_lookup_node(&mapping->page_tree,
+                                                &cache, offset - step, 1);
+		if (!node)
+			break;
+#ifdef DEBUG_READAHEAD_RADIXTREE
+		if (node != radix_tree_lookup_node(&mapping->page_tree,
+							offset - step, 1)) {
+			read_unlock_irq(&mapping->tree_lock);
+			printk(KERN_ERR "check radix_tree_cache_lookup_node!\n");
+			return 1;
+		}
+#endif
+	}
+	read_unlock_irq(&mapping->tree_lock);
+
+	/*
+	 *  For sequential read that extends from index 0, the counted value
+	 *  may well be far under the true threshold, so return it unmodified
+	 *  for further process in adjust_rala_accelerated().
+	 */
+	if (step < offset)
+		count = step * readahead_ratio / 100;
+	else
+		count = offset;
+
+out:
+	return count;
+}
+
+/*
+ * Scan backward in the file for the first non-present page.
+ */
+static inline unsigned long first_absent_page_bw(struct address_space *mapping,
+				unsigned long index, unsigned long max_scan)
+{
+	struct radix_tree_cache cache;
+	struct page *page;
+	unsigned long origin;
+
+	origin = index;
+	if (max_scan > index)
+		max_scan = index;
+	radix_tree_cache_init(&cache);
+	read_lock_irq(&mapping->tree_lock);
+	for (;;) {
+		page = radix_tree_cache_lookup(&mapping->page_tree,
+							&cache, --index);
+		if (page) {
+			index++;
+			break;
+		}
+		if (origin - index > max_scan)
+			break;
+	}
+	read_unlock_irq(&mapping->tree_lock);
+
+	return index;
+}
+
+/*
+ * Scan forward in the file for the first non-present page.
+ */
+static inline unsigned long first_absent_page(struct address_space *mapping,
+				unsigned long index, unsigned long max_scan)
+{
+	unsigned long ra_index;
+
+	read_lock_irq(&mapping->tree_lock);
+	ra_index = radix_tree_lookup_tail(&mapping->page_tree,
+					index + 1, max_scan);
+	read_unlock_irq(&mapping->tree_lock);
+
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	BUG_ON(ra_index <= index);
+	if (index + max_scan > index) {
+		if (ra_index <= index + max_scan)
+			WARN_ON(find_page(mapping, ra_index));
+		WARN_ON(!find_page(mapping, ra_index - 1));
+	}
+#endif
+
+	if (ra_index <= index + max_scan)
+		return ra_index;
+	else
+		return 0;
+}
+
+/*
+ * Determine the request parameters for context based read-ahead that extends
+ * from start of file.
+ *
+ * The major weakness of stateless method is perhaps the slow grow up speed of
+ * ra_size. The logic tries to make up for this in the important case of
+ * sequential reads that extend from start of file. In this case, the ra_size
+ * is not choosed to make the whole next chunk safe(as in normal ones). Only
+ * half of which is safe. The added 'unsafe' half is the look-ahead part. It
+ * is expected to be safeguarded by rescue_pages() when the previous chunks are
+ * lost.
+ */
+static inline int adjust_rala_accelerated(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	if (*ra_size <= *la_size)
+		return 0;
+
+	*la_size = (*ra_size - *la_size) * readahead_ratio / 100;
+	*ra_size = *la_size * 2;
+
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
+	return 1;
+}
+
+/*
+ * Main function for page context based read-ahead.
+ */
+static inline int
+try_context_based_readahead(struct address_space *mapping,
+			struct file_ra_state *ra,
+			struct page *prev_page, struct page *page,
+			unsigned long index,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	unsigned long ra_index;
+	unsigned long ra_size;
+	unsigned long la_size;
+	unsigned long remain_pages;
+
+	/* Where to start read-ahead?
+	 * NFSv3 daemons may process adjecent requests in parallel,
+	 * leading to many locally disordered, globally sequential reads.
+	 * So do not require nearby history pages to be present or accessed.
+	 */
+	if (page) {
+		ra_index = first_absent_page(mapping, index, ra_max * 5 / 4);
+		if (unlikely(!ra_index))
+			return -1;
+	} else if (!prev_page) {
+		ra_index = first_absent_page_bw(mapping, index, ra_min);
+		if (index - ra_index > ra_min)
+			return 0;
+		ra_min += index - ra_index;
+		index = ra_index;
+	} else
+		ra_index = index;
+
+	ra_size = query_page_cache(mapping, &remain_pages,
+						index - 1, ra_min, ra_max);
+
+	la_size = ra_index - index;
+	if (readahead_ratio < VM_READAHEAD_PROTECT_RATIO &&
+			remain_pages <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return -1;
+	}
+
+	if (ra_size == index) {
+		if (!adjust_rala_accelerated(ra_max, &ra_size, &la_size))
+			return -1;
+		set_ra_class(ra, RA_CLASS_CONTEXT_ACCELERATED);
+	} else {
+		if (!adjust_rala(ra_max, &ra_size, &la_size))
+			return -1;
+		set_ra_class(ra, RA_CLASS_CONTEXT);
+	}
+
+	ra_state_init(ra, index, ra_index);
+	ra_state_update(ra, ra_size, la_size);
+
+	return 1;
+}
+
+/*
+ * Read-ahead on start of file.
+ *
+ * It is most important for small files.
+ * 1. Set a moderate large read-ahead size;
+ * 2. Issue the next read-ahead request as soon as possible.
+ *
+ * But be careful, there are some applications that dip into only the very head
+ * of a file. The most important thing is to prevent them from triggering the
+ * next (much larger) read-ahead request, which leads to lots of cache misses.
+ * Two pages should be enough for them, correct me if I'm wrong.
+ */
+static inline unsigned long
+newfile_readahead(struct address_space *mapping,
+		struct file *filp, struct file_ra_state *ra,
+		unsigned long req_size, unsigned long ra_min)
+{
+	unsigned long ra_size;
+	unsigned long la_size;
+
+	if (req_size > ra_min)
+		req_size = ra_min;
+
+	ra_size = 4 * req_size;
+	la_size = 2 * req_size;
+
+	set_ra_class(ra, RA_CLASS_NEWFILE);
+	ra_state_init(ra, 0, 0);
+	ra_state_update(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * Backward prefetching.
+ * No look ahead and thrashing threshold estimation for stepping backward
+ * pattern: should be unnecessary.
+ */
+static inline int
+try_read_backward(struct file_ra_state *ra,
+			unsigned long begin_index, unsigned long end_index,
+			unsigned long ra_size,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	if (ra_size > ra_max || end_index > ra->prev_page)
+		return 0;
+
+	if (ra_has_index(ra, ra->prev_page)) {
+		if (end_index > ra->la_index)
+			return 0;
+		ra_size += 2 * ra_cache_hit(ra, 0);
+		end_index = ra->la_index;
+	} else {
+		ra_size += ra_min;
+		end_index = ra->prev_page;
+	}
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	if (end_index > begin_index + ra_size)
+		return 0;
+
+	begin_index = end_index - ra_size;
+
+	set_ra_class(ra, RA_CLASS_BACKWARD);
+	ra_state_init(ra, begin_index, begin_index);
+	ra_state_update(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
+ * If there is a previous sequential read, it is likely to be another
+ * sequential read at the new position.
+ * Databases are known to have this seek-and-read-one-record pattern.
+ */
+static inline int
+try_random_readahead(struct file_ra_state *ra, unsigned long index,
+			unsigned long ra_size, unsigned long ra_max)
+{
+	unsigned long hit0 = ra_cache_hit(ra, 0);
+	unsigned long hit1 = ra_cache_hit(ra, 1) + hit0;
+	unsigned long hit2 = ra_cache_hit(ra, 2);
+	unsigned long hit3 = ra_cache_hit(ra, 3);
+
+	if (!ra_has_index(ra, ra->prev_page))
+		return 0;
+
+	if (index == ra->prev_page + 1) {    /* read after thrashing */
+		ra_size = hit0;
+		set_ra_class(ra, RA_CLASS_RANDOM_THRASHING);
+		ra_account(ra, RA_EVENT_READAHEAD_THRASHING,
+						ra->readahead_index - index);
+	} else if (ra_size < hit1 &&         /* read after seeking   */
+			hit1 > hit2 / 2 &&
+			hit2 > hit3 / 2 &&
+			hit3 > hit1 / 2) {
+		ra_size = max(hit1, hit2);
+		set_ra_class(ra, RA_CLASS_RANDOM_SEEK);
+	} else
+		return 0;
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	ra_state_init(ra, index, index);
+	ra_state_update(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
+ * ra_size is mainly determined by:
+ * 1. sequential-start: min(KB(16 + mem_mb/16), KB(64))
+ * 2. sequential-max:	min(ra->ra_pages, KB(262140))
+ * 3. sequential:	(thrashing-threshold) * readahead_ratio / 100
+ *
+ * Table of concrete numbers for 4KB page size:
+ *  (inactive + free) (in MB):    4   8   16   32   64  128  256  512 1024
+ *    initial ra_size (in KB):   16  16   16   16   20   24   32   48   64
+ */
+static inline void get_readahead_bounds(struct file_ra_state *ra,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long mem_mb;
+
+#define KB(size)	(((size) * 1024) / PAGE_CACHE_SIZE)
+	mem_mb = nr_free_inactive() * PAGE_CACHE_SIZE / 1024 / 1024;
+	*ra_max = min(ra->ra_pages, KB(262140));
+	*ra_min = min(min(KB(VM_MIN_READAHEAD + mem_mb/16), KB(128)), *ra_max/2);
+#undef KB
+}
+
+/*
+ * Set a new look-ahead mark at @new_index.
+ */
+void renew_lookahead(struct address_space *mapping,
+			struct file_ra_state *ra,
+			unsigned long index, unsigned long new_index)
+{
+	struct page *page;
+
+	if (index == ra->lookahead_index &&
+			new_index >= ra->readahead_index)
+		return;
+
+	page = find_page(mapping, new_index);
+	if (!page)
+		return;
+
+	SetPageReadahead(page);
+	if (ra->lookahead_index == index)
+		ra->lookahead_index = new_index;
+}
+
+/*
+ * This is the entry point of the adaptive read-ahead logic.
+ *
+ * It is only called on two conditions:
+ * 1. page == NULL
+ *    A cache miss happened, it can be either a random read or a sequential one.
+ * 2. page != NULL
+ *    There is a look-ahead mark(PG_readahead) from a previous sequential read.
+ *    It's time to do some checking and submit the next read-ahead IO.
+ *
+ * That has the merits of:
+ * - makes all stateful/stateless methods happy;
+ * - eliminates the cache hit problem naturally;
+ * - lives in harmony with application managed read-aheads via fadvise/madvise.
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			unsigned long begin_index,
+			unsigned long index, unsigned long end_index)
+{
+	unsigned long size;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int ret;
+
+	if (page) {
+		if(!TestClearPageReadahead(page))
+			return 0;
+		if (bdi_read_congested(mapping->backing_dev_info)) {
+			ra_account(ra, RA_EVENT_IO_CONGESTION,
+							end_index - index);
+			return 0;
+		}
+		if (laptop_mode && laptop_spinned_down()) {
+			renew_lookahead(mapping, ra, index, index + 32);
+			return 0;
+		}
+	}
+
+	if (page)
+		ra_account(ra, RA_EVENT_LOOKAHEAD_HIT,
+				ra->readahead_index - ra->lookahead_index);
+	else if (index)
+		ra_account(ra, RA_EVENT_CACHE_MISS, end_index - begin_index);
+
+	size = end_index - index;
+	get_readahead_bounds(ra, &ra_min, &ra_max);
+
+	/* readahead disabled? */
+	if (unlikely(!ra_min || !readahead_ratio)) {
+		size = max_sane_readahead(size);
+		goto readit;
+	}
+
+	/*
+	 * Start of file.
+	 */
+	if (index == 0)
+		return newfile_readahead(mapping, filp, ra, end_index, ra_min);
+
+	/*
+	 * State based sequential read-ahead.
+	 */
+	if ((readahead_ratio % 5) == 0 &&
+		index == ra->lookahead_index &&
+		(page || index == ra->readahead_index) &&
+		(ra_cache_hit_ok(ra) ||
+		 end_index - begin_index >= ra_max))
+		return state_based_readahead(mapping, filp, ra, page, ra_max);
+
+	/*
+	 * Backward read-ahead.
+	 */
+	if (try_read_backward(ra, begin_index, end_index, size, ra_min, ra_max))
+		return ra_dispatch(ra, mapping, filp);
+
+	/*
+	 * Context based sequential read-ahead.
+	 */
+	ret = try_context_based_readahead(mapping, ra, prev_page, page,
+						index, ra_min, ra_max);
+	if (ret > 0)
+		return ra_dispatch(ra, mapping, filp);
+	if (ret < 0)
+		return 0;
+
+	/* No action on look ahead time? */
+	if (page)
+		return 0;
+
+	/*
+	 * Random read that follows a sequential one.
+	 */
+	if (try_random_readahead(ra, index, size, ra_max))
+		return ra_dispatch(ra, mapping, filp);
+
+	/*
+	 * Random read.
+	 */
+	if (size > ra_max)
+		size = ra_max;
+
+readit:
+	size = __do_page_cache_readahead(mapping, filp, index, size, 0);
+
+	ra_account(ra, RA_EVENT_READRANDOM, size);
+	dprintk("readrandom(ino=%lu, pages=%lu, index=%lu-%lu-%lu) = %lu\n",
+			mapping->host->i_ino, mapping->nrpages,
+			begin_index, index, end_index, size);
+
+	return size;
+}
+
+/*
+ * Call me!
+ */
+void fastcall ra_access(struct file_ra_state *ra, struct page *page)
+{
+	if (page->flags & ((1 << PG_active)   |
+			   (1 << PG_activate) |
+			   (1 << PG_referenced)))
+		return;
+
+	if (ra_has_index(ra, page->index)) {
+		if (PageLocked(page))
+			ra_account(ra, RA_EVENT_IO_BLOCK,
+					ra->readahead_index - page->index);
+	} else {
+		if (PageLocked(page))
+			ra_account(0, RA_EVENT_IO_BLOCK, 1);
+		return;
+	}
+
+	ra->cache_hit++;
+
+	if (page->index >= ra->ra_index)
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, 1);
+	else
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, -1);
+}
+
+/*
+ * Detect and protect live read-ahead pages.
+ *
+ * This function provides safty guarantee for file servers with big
+ * readahead_ratio(>=VM_READAHEAD_PROTECT_RATIO) set.  The goal is to save all
+ * and only the sequential pages that are to be accessed in the near future.
+ *
+ * This function is called when pages in @page_list are to be freed,
+ * it protects live read-ahead pages by moving them into @save_list.
+ *
+ * The general idea is to classify pages of a file into random pages and groups
+ * of sequential accessed pages. Random pages and dead sequential pages are
+ * left over, live sequential pages are saved.
+ *
+ * Live read-ahead pages are defined as sequential pages that have reading in
+ * progress. They are detected by reference count pattern of:
+ *
+ *                        live head       live pages
+ *  ra pages group -->   ------------___________________
+ *                                   [  pages to save  ] (*)
+ *
+ * (*) for now, an extra page from the live head may also be saved.
+ *
+ * In pratical, the group of pages are fragmented into chunks. To tell whether
+ * pages inside a chunk are alive, we must check:
+ * 1) Are there any live heads inside the chunk?
+ * 2) Are there any live heads in the group before the chunk?
+ * 3) Sepcial case: live head just sits on the boundary of current chunk?
+ *
+ * The detailed rules employed must ensure:
+ * - no page is pinned in inactive_list.
+ * - no excessive pages are saved.
+ *
+ * A picture of common cases:
+ *             back search            chunk             case
+ *           -----___________|[____________________]    Normal
+ *           ----------------|----[________________]    Normal
+ *                           |----[________________]    Normal
+ *           ----------------|----------------------    Normal
+ *                           |----------------------    Normal
+ *           ________________|______________________    ra miss
+ *                           |______________________    ra miss
+ *           ________________|_______--------[_____]    two readers
+ *           ----____________|[______--------______]    two readers
+ *                           |_______--------[_____]    two readers
+ *                           |----[____------______]    two readers
+ *           ----------------|----[____------______]    two readers
+ *           _______---------|---------------[_____]    two readers
+ *           ----___---------|[--------------______]    two readers
+ *           ________________|---------------[_____]    two readers
+ *           ----____________|[--------------______]    two readers
+ *           ====------------|[---_________________]    two readers
+ *                           |====[----------______]    two readers
+ *                           |###======[-----------]    three readers
+ *
+ * Read backward pattern support is possible, in which case the pages should be
+ * pushed into inactive_list in reverse order.
+ *
+ * The two special cases are awkwardly delt with for now. They will be all set
+ * when the timing information of recently evicted pages are available.
+ * Dead pages can also be purged earlier with the timing info.
+ */
+static int save_chunk(struct page *head, struct page *live_head,
+			struct page *tail, struct list_head *save_list)
+{
+	struct page *page;
+	struct address_space *mapping;
+	struct radix_tree_cache cache;
+	int i;
+	unsigned long index;
+	unsigned long refcnt;
+
+#ifdef DEBUG_READAHEAD
+	static char static_buf[PAGE_SIZE];
+	static char *zone_names[1 << ZONES_SHIFT] = {
+			"DMA", "DMA32", "Normal", "HighMem", "Z5", "Z6", "Z7" };
+	char *pat = static_buf;
+	unsigned long pidx = PAGE_SIZE / 2;
+
+	if ((readahead_ratio & 3) == 3) {
+		pat = (char *)get_zeroed_page(GFP_KERNEL);
+		if (!pat)
+			pat = static_buf;
+	}
+#endif
+
+#define LIVE_PAGE_SCAN		(4 * MAX_RA_PAGES)
+	index = head->index;
+	refcnt = page_refcnt(head);
+	mapping = head->mapping;
+	radix_tree_cache_init(&cache);
+
+	BUG_ON(!mapping); /* QUESTION: in what case mapping will be NULL ? */
+	read_lock_irq(&mapping->tree_lock);
+
+	/*
+	 * Common case test:
+	 * Does the far end indicates a leading live head?
+	 */
+	index = radix_tree_lookup_head(&mapping->page_tree,
+						index, LIVE_PAGE_SCAN);
+	page = __find_page(mapping, index);
+	if (cold_page_refcnt(page) > refcnt) {
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3) {
+			pat[--pidx] = '.';
+			pat[--pidx] = '.';
+			pat[--pidx] = '.';
+			pat[--pidx] = page_refcnt_symbol(page);
+			pat[--pidx] = '|';
+		}
+#endif
+		live_head = head;
+		goto skip_scan_locked;
+	}
+
+	/*
+	 * Special case 1:
+	 * If @head is a live head, rescue_ra_pages() will not detect it.
+	 * Check it here.
+	 */
+	index = head->index;
+	page = radix_tree_cache_lookup(&mapping->page_tree, &cache, --index);
+	if (!page || PageActive(page)) {
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3)
+			pat[--pidx] = page_refcnt_symbol(page);
+#endif
+		goto skip_scan_locked;
+	}
+	if (refcnt > page_refcnt(next_page(head)) &&
+			page_refcnt(page) > page_refcnt(next_page(head))) {
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3)
+			pat[--pidx] = page_refcnt_symbol(page);
+#endif
+		live_head = head;
+		goto skip_scan_locked;
+	}
+
+	/*
+	 * Scan backward to see if the whole chunk should be saved.
+	 * It can be costly. But can be made rare in future.
+	 */
+	for (i = LIVE_PAGE_SCAN; i >= 0; i--) {
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+								--index);
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3 && pidx)
+			pat[--pidx] = page_refcnt_symbol(page);
+#endif
+
+		if (!page)
+			break;
+
+		/* Avoid being pinned by active page. */
+		if (unlikely(PageActive(page)))
+			break;
+
+		if (page_refcnt(page) > refcnt) { /* So we are alive! */
+			live_head = head;
+			break;
+		}
+
+		refcnt = page_refcnt(page);
+	}
+
+skip_scan_locked:
+	/*
+	 * Special case 2:
+	 * Save one extra page if it is a live head of the following chunk.
+	 * Just to be safe.  It protects the rare situation when the reader
+	 * is just crossing the chunk boundary, and the following chunk is not
+	 * far away from tail of inactive_list.
+	 */
+	if (live_head != head) {
+		struct page *last_page = prev_page(tail);
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+						last_page->index + 1);
+		if (page && !live_head) {
+			refcnt = page_refcnt(last_page);
+			if (page_refcnt(page) >= refcnt)
+				page = radix_tree_cache_lookup(
+						&mapping->page_tree, &cache,
+						last_page->index + 2);
+			if (page && page_refcnt(page) < refcnt)
+				live_head = last_page;
+		} else if (!page && live_head)
+			live_head = next_page(live_head);
+	}
+
+	read_unlock_irq(&mapping->tree_lock);
+
+#ifdef DEBUG_READAHEAD
+	if ((readahead_ratio & 3) == 3) {
+		for (i = 0; pidx < PAGE_SIZE / 2;)
+			pat[i++] = pat[pidx++];
+		pat[i++] = '|';
+		for (page = head; page != tail; page = next_page(page)) {
+			pidx = page->index;
+			if (page == live_head)
+				pat[i++] = '[';
+			pat[i++] = page_refcnt_symbol(page);
+			BUG_ON(PageAnon(page));
+			BUG_ON(PageSwapCache(page));
+			/* BUG_ON(page_mapped(page)); */
+			if (i >= PAGE_SIZE - 2)
+				break;
+		}
+		if (live_head)
+			pat[i++] = ']';
+		pat[i] = 0;
+		pat[PAGE_SIZE - 1] = 0;
+	}
+#endif
+
+	/*
+	 * Now save the alive pages.
+	 */
+	i = 0;
+	if (live_head) {
+		for (; live_head != tail;) { /* never dereference tail! */
+			page = next_page(live_head);
+			if (!PageActivate(live_head)) {
+				if (!page_refcnt(live_head))
+					__get_cpu_var(smooth_aging)++;
+				i++;
+				list_move(&live_head->lru, save_list);
+			}
+			live_head = page;
+		}
+
+		if (i)
+			ra_account(0, RA_EVENT_READAHEAD_RESCUE, i);
+	}
+
+#ifdef DEBUG_READAHEAD
+	if ((readahead_ratio & 3) == 3) {
+		ddprintk("save_chunk(ino=%lu, idx=%lu-%lu-%lu, %s@%s:%s)"
+				" = %d\n",
+				mapping->host->i_ino,
+				index, head->index, pidx,
+				mapping_mapped(mapping) ? "mmap" : "file",
+				zone_names[page_zonenum(head)], pat, i);
+		if (pat != static_buf)
+			free_page((unsigned long)pat);
+	}
+#endif
+
+	return i;
+}
+
+int rescue_ra_pages(struct list_head *page_list, struct list_head *save_list)
+{
+	struct address_space *mapping;
+	struct page *chunk_head;
+	struct page *live_head;
+	struct page *page;
+	unsigned long refcnt;
+	int n;
+	int ret = 0;
+
+	page = list_to_page(page_list);
+
+next_chunk:
+	chunk_head = page;
+	live_head = NULL;
+	mapping = page->mapping;
+	n = 0;
+
+next_rs_page:
+	refcnt = page_refcnt(page);
+	page = next_page(page);
+
+	if (mapping != page->mapping || &page->lru == page_list)
+		goto save_chunk;
+
+	if (refcnt == page_refcnt(page))
+		n++;
+	else if (refcnt < page_refcnt(page))
+		n = 0;
+	else if (n < 1)
+		n = INT_MIN;
+	else
+		goto got_live_head;
+
+	goto next_rs_page;
+
+got_live_head:
+	n = 0;
+	live_head = prev_page(page);
+
+next_page:
+	if (refcnt < page_refcnt(page))
+		n++;
+	refcnt = page_refcnt(page);
+	page = next_page(page);
+
+	if (mapping != page->mapping || &page->lru == page_list)
+		goto save_chunk;
+
+	goto next_page;
+
+save_chunk:
+	if (mapping && !PageAnon(chunk_head) &&
+			!PageSwapCache(chunk_head) &&
+			/* !page_mapped(chunk_head) && */
+			n <= 3 &&
+			(!refcnt ||
+			 prev_page(page)->index >= chunk_head->index + 5))
+		ret += save_chunk(chunk_head, live_head, page, save_list);
+
+	if (&page->lru != page_list)
+		goto next_chunk;
+
+	return ret;
+}
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/mm/swap.c linux-2.6.14ra/mm/swap.c
--- linux-2.6.14/mm/swap.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/mm/swap.c	2005-11-01 16:56:09.000000000 +0800
@@ -29,7 +29,6 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
-#include <linux/init.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -113,20 +112,23 @@ void fastcall activate_page(struct page 
 	spin_unlock_irq(&zone->lru_lock);
 }
 
+DECLARE_PER_CPU(unsigned long, smooth_aging);
+
 /*
  * Mark a page as having seen activity.
  *
  * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
+ * inactive,referenced		->	activate,unreferenced
+ * activate,unreferenced	->	activate,referenced
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
+	if (!PageActivate(page) && PageReferenced(page) && PageLRU(page)) {
+		SetPageActivate(page);
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
+		__get_cpu_var(smooth_aging)++;
 	}
 }
 
diff -rup -X linux-2.6.14ra/Documentation/dontdiff linux-2.6.14/mm/vmscan.c linux-2.6.14ra/mm/vmscan.c
--- linux-2.6.14/mm/vmscan.c	2005-10-28 08:02:08.000000000 +0800
+++ linux-2.6.14ra/mm/vmscan.c	2005-11-01 19:38:19.000000000 +0800
@@ -370,6 +370,9 @@ static pageout_t pageout(struct page *pa
 	return PAGE_CLEAN;
 }
 
+extern int readahead_ratio;
+DECLARE_PER_CPU(unsigned long, smooth_aging);
+
 /*
  * shrink_list adds the number of reclaimed pages to sc->nr_reclaimed
  */
@@ -378,10 +381,14 @@ static int shrink_list(struct list_head 
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
 	int pgactivate = 0;
+	int pgkeep = 0;
 	int reclaimed = 0;
 
 	cond_resched();
 
+	if (readahead_ratio >= VM_READAHEAD_PROTECT_RATIO)
+		rescue_ra_pages(page_list, &ret_pages);
+
 	pagevec_init(&freed_pvec, 1);
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
@@ -407,10 +414,18 @@ static int shrink_list(struct list_head 
 		if (PageWriteback(page))
 			goto keep_locked;
 
+		if (PageActivate(page)) {
+			ClearPageActivate(page);
+			ClearPageReferenced(page);
+			goto activate_locked;
+		}
+
 		referenced = page_referenced(page, 1, sc->priority <= 0);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
 			goto activate_locked;
+		if (!referenced)
+			__get_cpu_var(smooth_aging)++;
 
 #ifdef CONFIG_SWAP
 		/*
@@ -551,11 +566,13 @@ keep_locked:
 keep:
 		list_add(&page->lru, &ret_pages);
 		BUG_ON(PageLRU(page));
+		pgkeep++;
 	}
 	list_splice(&ret_pages, page_list);
 	if (pagevec_count(&freed_pvec))
 		__pagevec_release_nonlru(&freed_pvec);
 	mod_page_state(pgactivate, pgactivate);
+	mod_page_state(pgkeepcold, pgkeep - pgactivate);
 	sc->nr_reclaimed += reclaimed;
 	return reclaimed;
 }
@@ -639,6 +656,7 @@ static void shrink_cache(struct zone *zo
 			goto done;
 
 		max_scan -= nr_scan;
+		update_page_age(zone, nr_scan);
 		if (current_is_kswapd())
 			mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
 		else
@@ -758,6 +776,7 @@ refill_inactive_zone(struct zone *zone, 
 				list_add(&page->lru, &l_active);
 				continue;
 			}
+			__get_cpu_var(smooth_aging)++;
 		}
 		list_add(&page->lru, &l_inactive);
 	}
@@ -816,6 +835,7 @@ refill_inactive_zone(struct zone *zone, 
 
 	mod_page_state_zone(zone, pgrefill, pgscanned);
 	mod_page_state(pgdeactivate, pgdeactivate);
+	mod_page_state(pgkeephot, pgmoved);
 }
 
 /*
@@ -1052,6 +1072,7 @@ loop_again:
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
+		int begin_zone = -1;
 		unsigned long lru_pages = 0;
 
 		all_zones_ok = 1;
@@ -1073,16 +1094,33 @@ loop_again:
 
 				if (!zone_watermark_ok(zone, order,
 						zone->pages_high, 0, 0, 0)) {
-					end_zone = i;
-					goto scan;
+					if (!end_zone)
+						begin_zone = end_zone = i;
+					else /* if (begin_zone == i + 1) */
+						begin_zone = i;
 				}
 			}
-			goto out;
+			if (begin_zone < 0)
+				goto out;
 		} else {
+			begin_zone = 0;
 			end_zone = pgdat->nr_zones - 1;
 		}
-scan:
-		for (i = 0; i <= end_zone; i++) {
+
+		/*
+		 * Prepare enough free pages for zones with small page_age,
+		 * they are going to be reclaimed in the page allocation.
+		 */
+		while (end_zone < pgdat->nr_zones - 1 &&
+			pages_more_aged(pgdat->node_zones + end_zone,
+					pgdat->node_zones + end_zone + 1))
+			end_zone++;
+		while (begin_zone &&
+			pages_more_aged(pgdat->node_zones + begin_zone,
+					pgdat->node_zones + begin_zone - 1))
+			begin_zone--;
+
+		for (i = begin_zone; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
 			lru_pages += zone->nr_active + zone->nr_inactive;
@@ -1097,7 +1135,7 @@ scan:
 		 * pages behind kswapd's direction of progress, which would
 		 * cause too much scanning of the lower zones.
 		 */
-		for (i = 0; i <= end_zone; i++) {
+		for (i = begin_zone; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_slab;
 
