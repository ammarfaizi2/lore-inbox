Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVJORnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVJORnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 13:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVJORnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 13:43:17 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:10383 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751184AbVJORnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 13:43:15 -0400
Date: Sun, 16 Oct 2005 01:47:31 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Adaptive read-ahead v4
Message-ID: <20051015174731.GA5851@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th version of the adaptive read-ahead patch.

New features:
	- detect and prevent most read-ahead thrashing
	- support database workload
	- support reading backward
	- radix tree lookup look-aside cache

It has evolved into a near complete solution over time. I'll split it up and
describe each component at the next time.

Andrew Morton wrote:
> Try one process serving 1000 files slowly on a 64MB machine. Something
> like that.
Dreams come true :)
The patch can now support 1000 slow reads on 64MB hands down. The newly added
thrashing protection method allows one to force a large read-ahead request size
without causing serious thrashing.

The test data below were collected with readahead_ratio=200.

Regards,
Wu Fengguang

/proc/meminfo
=============
MemTotal:        60664 kB
MemFree:          1556 kB
Buffers:         22020 kB
Cached:          17760 kB
SwapCached:          0 kB
Active:          14720 kB
Inactive:        27792 kB

iostat -x 100
=============
rrqm/s    r/s   rsec/s     rkB/s    avgrq-sz avgqu-sz   await  svctm  %util
  0.17  65.64  2107.94   1053.97       29.67     1.13    9.18   2.26  27.95
  0.14  56.52  1911.22    955.61       30.11     1.23   10.46   2.15  25.31
  0.23  61.12  2104.96   1052.48       30.62     1.40   11.74   2.05  24.48
  0.21  55.34  1884.40    942.20       30.09     1.39   11.93   2.01  23.50
  0.09  55.66  1928.88    964.44       30.58     1.12    9.61   1.74  20.20
  0.18  60.02  2044.43   1022.21       30.16     1.42   11.92   1.95  23.20
  0.25  55.22  1913.39    956.70       30.28     1.18   10.05   2.14  25.06
  0.10  59.66  2019.96   1009.98       30.25     1.34   11.33   2.35  27.77
  0.22  58.43  1964.48    982.24       30.21     1.10    9.22   2.07  24.76

/proc/vmstat
============
cache_miss 116127
readrandom 3
pgreadrandom 3
readahead_rescue 76974
pgreadahead_rescue 155047
readahead_end 2
readahead 118988
readahead_return 1716
readahead_eof 1120
pgreadahead 517119
pgreadahead_hit 512447
pgreadahead_eof 4421
ra_newfile 1151
ra_newfile_return 1018
ra_newfile_eof 91
pgra_newfile 4428
pgra_newfile_hit 4353
pgra_newfile_eof 188
ra_state 115483
ra_state_return 697
ra_state_eof 1012
pgra_state 505918
pgra_state_hit 501349
pgra_state_eof 4180
ra_context 12
ra_context_return 0
ra_context_eof 0
pgra_context 41
pgra_context_hit 41
pgra_context_eof 0
ra_contexta 0
ra_contexta_return 0
ra_contexta_eof 0
pgra_contexta 0
pgra_contexta_hit 0
pgra_contexta_eof 0
ra_backward 0
ra_backward_return 0
ra_backward_eof 0
pgra_backward 0
pgra_backward_hit 0
pgra_backward_eof 0
ra_random 2342
ra_random_return 1
ra_random_eof 17
pgra_random 6732
pgra_random_hit 6704
pgra_random_eof 53

oprofile
========
The two thrashing detection/prevention functions are marked with leading
'+++++++'. The overheads are high. But there's good room for speed up.

diffprofile oprofile.50.4k oprofile.100.4k
------------------------------------------
       109    19.5% dnotify_parent
       103     6.3% ll_rw_block
        89    13.7% add_to_page_cache
++++++++83     0.0% save_chunk
        80    15.7% unlock_buffer
        64     8.5% shrink_list
        54     1.5% __copy_to_user_ll
        54    10.5% __brelse
        50    50.5% radix_tree_lookup_node
        41  1366.7% kunmap_atomic
        35   102.9% do_wp_page
        33    29.2% vfs_write
        25    25.0% megaraid_mbox_build_cmd
++++++++24     0.0% rescue_ra_pages
        24    53.3% __do_softirq
        21     4.0% inotify_dentry_parent_queue_event

       -21   -15.0% load_balance
       -22   -47.8% lock_timer_base
       -23    -7.1% find_busiest_group
       -23    -7.5% unlock_page
       -24    -5.4% __mod_page_state
       -24   -15.7% current_fs_time
       -25   -16.1% __pagevec_release_nonlru
       -25    -5.6% radix_tree_delete
       -26    -8.0% __do_page_cache_readahead
       -26   -20.5% kmem_cache_alloc
       -27    -3.7% default_idle
       -31   -13.1% release_pages
       -32    -7.5% mpage_end_io_read
       -36   -12.1% mark_offset_pmtmr
       -45    -5.0% delay_pmtmr
       -54    -8.9% find_get_page


 drivers/block/loop.c       |    5 
 include/linux/fs.h         |   21 
 include/linux/mm.h         |   12 
 include/linux/mm_inline.h  |    1 
 include/linux/mmzone.h     |   51 +
 include/linux/page-flags.h |   71 ++
 include/linux/radix-tree.h |   19 
 include/linux/sysctl.h     |    1 
 kernel/sysctl.c            |   11 
 lib/radix-tree.c           |   71 ++
 mm/filemap.c               |   70 +-
 mm/page_alloc.c            |  154 ++++-
 mm/readahead.c             | 1384 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/swap.c                  |   12 
 mm/vmscan.c                |   45 +
 15 files changed, 1876 insertions(+), 52 deletions(-)


diff -rup linux-2.6.14-rc4-git4-orig/drivers/block/loop.c linux-2.6.14-rc4-git4/drivers/block/loop.c
--- linux-2.6.14-rc4-git4-orig/drivers/block/loop.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.14-rc4-git4/drivers/block/loop.c	2005-10-16 00:43:49.000000000 +0800
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
diff -rup linux-2.6.14-rc4-git4-orig/include/linux/fs.h linux-2.6.14-rc4-git4/include/linux/fs.h
--- linux-2.6.14-rc4-git4-orig/include/linux/fs.h	2005-10-16 00:42:46.000000000 +0800
+++ linux-2.6.14-rc4-git4/include/linux/fs.h	2005-10-16 00:43:49.000000000 +0800
@@ -562,17 +562,36 @@ struct file_ra_state {
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
+	unsigned long la_index;
+	unsigned long ra_index;
+	unsigned long lookahead_index;
+	unsigned long readahead_index;
+	unsigned long nr_page_aging;
 };
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
 
+#define RA_CLASS_SHIFT 3
+#define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
+enum file_ra_class { /* the same order must be kept in page_state */
+	RA_CLASS_NEWFILE = 1,
+	RA_CLASS_STATE,
+	RA_CLASS_CONTEXT,
+	RA_CLASS_CONTEXT_ACCELERATED,
+	RA_CLASS_BACKWARD,
+	/* RA_CLASS_AROUND, */
+	RA_CLASS_RANDOM,
+	RA_CLASS_END,
+};
+
 struct file {
 	struct list_head	f_list;
 	struct dentry		*f_dentry;
diff -rup linux-2.6.14-rc4-git4-orig/include/linux/mm.h linux-2.6.14-rc4-git4/include/linux/mm.h
--- linux-2.6.14-rc4-git4-orig/include/linux/mm.h	2005-10-16 00:42:46.000000000 +0800
+++ linux-2.6.14-rc4-git4/include/linux/mm.h	2005-10-16 00:43:49.000000000 +0800
@@ -875,7 +875,7 @@ extern int filemap_populate(struct vm_ar
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
-#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MAX_READAHEAD	1024	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 #define VM_MAX_CACHE_HIT    	256	/* max pages in a row in cache before
 					 * turning readahead off */
@@ -892,6 +892,16 @@ unsigned long  page_cache_readahead(stru
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
+int save_chunk(struct page *head, struct page *tail,
+		struct list_head *save_list);
 
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct * vma, unsigned long address);
diff -rup linux-2.6.14-rc4-git4-orig/include/linux/mm_inline.h linux-2.6.14-rc4-git4/include/linux/mm_inline.h
--- linux-2.6.14-rc4-git4-orig/include/linux/mm_inline.h	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.14-rc4-git4/include/linux/mm_inline.h	2005-10-16 00:43:49.000000000 +0800
@@ -11,6 +11,7 @@ add_page_to_inactive_list(struct zone *z
 {
 	list_add(&page->lru, &zone->inactive_list);
 	zone->nr_inactive++;
+	zone->nr_page_aging++;
 }
 
 static inline void
diff -rup linux-2.6.14-rc4-git4-orig/include/linux/mmzone.h linux-2.6.14-rc4-git4/include/linux/mmzone.h
--- linux-2.6.14-rc4-git4-orig/include/linux/mmzone.h	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/include/linux/mmzone.h	2005-10-16 00:43:49.000000000 +0800
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
@@ -314,6 +328,43 @@ static inline void memory_present(int ni
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
+ * The percent of pages in inactive_list that have been scanned / aged.
+ * It's not really ##%, but a high resolution normalized value.
+ */
+static inline void update_page_age(struct zone *z)
+{
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
diff -rup linux-2.6.14-rc4-git4-orig/include/linux/page-flags.h linux-2.6.14-rc4-git4/include/linux/page-flags.h
--- linux-2.6.14-rc4-git4-orig/include/linux/page-flags.h	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/include/linux/page-flags.h	2005-10-16 00:43:49.000000000 +0800
@@ -75,6 +75,8 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_activate		20	/* delayed activate */
+#define PG_readahead		21	/* check readahead when reading this page */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -131,6 +133,63 @@ struct page_state {
 
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
 	unsigned long nr_bounce;	/* pages for bounce buffers */
+
+	unsigned long cache_miss;	/* read cache misses */
+	unsigned long readrandom;	/* random reads */
+	unsigned long pgreadrandom;	/* random read pages */
+	unsigned long readahead_rescue; /* read-aheads rescued*/
+	unsigned long pgreadahead_rescue;
+	unsigned long readahead_end;	/* read-aheads passed EOF */
+
+	unsigned long readahead;	/* read-aheads issued */
+	unsigned long readahead_return;	/* look-ahead marks returned */
+	unsigned long readahead_eof;	/* read-aheads stop at EOF */
+	unsigned long pgreadahead;	/* read-ahead pages issued */
+	unsigned long pgreadahead_hit;	/* read-ahead pages accessed */
+	unsigned long pgreadahead_eof;
+
+	unsigned long ra_newfile;	/* read-ahead on start of file */
+	unsigned long ra_newfile_return;
+	unsigned long ra_newfile_eof;
+	unsigned long pgra_newfile;
+	unsigned long pgra_newfile_hit;
+	unsigned long pgra_newfile_eof;
+
+	unsigned long ra_state;		/* state based read-ahead */
+	unsigned long ra_state_return;
+	unsigned long ra_state_eof;
+	unsigned long pgra_state;
+	unsigned long pgra_state_hit;
+	unsigned long pgra_state_eof;
+
+	unsigned long ra_context;	/* context based read-ahead */
+	unsigned long ra_context_return;
+	unsigned long ra_context_eof;
+	unsigned long pgra_context;
+	unsigned long pgra_context_hit;
+	unsigned long pgra_context_eof;
+
+	unsigned long ra_contexta;	/* accelerated context based read-ahead */
+	unsigned long ra_contexta_return;
+	unsigned long ra_contexta_eof;
+	unsigned long pgra_contexta;
+	unsigned long pgra_contexta_hit;
+	unsigned long pgra_contexta_eof;
+
+	unsigned long ra_backward;	/* prefetch pages for backward reading */
+	unsigned long ra_backward_return;
+	unsigned long ra_backward_eof;
+	unsigned long pgra_backward;
+	unsigned long pgra_backward_hit;
+	unsigned long pgra_backward_eof;
+
+	unsigned long ra_random;	/* read-ahead on seek-and-read-pages */
+	unsigned long ra_random_return;
+	unsigned long ra_random_eof;
+	unsigned long pgra_random;
+	unsigned long pgra_random_hit;
+	unsigned long pgra_random_eof;
+
 };
 
 extern void get_page_state(struct page_state *ret);
@@ -307,6 +366,18 @@ extern void __mod_page_state(unsigned lo
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
+#define ClearPageReadahead(page) clear_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+#define TestSetPageReadahead(page) test_and_set_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -rup linux-2.6.14-rc4-git4-orig/include/linux/radix-tree.h linux-2.6.14-rc4-git4/include/linux/radix-tree.h
--- linux-2.6.14-rc4-git4-orig/include/linux/radix-tree.h	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/include/linux/radix-tree.h	2005-10-16 00:43:49.000000000 +0800
@@ -45,8 +45,10 @@ do {									\
 } while (0)
 
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
-void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
+void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
+void *radix_tree_lookup_node(struct radix_tree_root *, unsigned long,
+							unsigned int);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
@@ -68,4 +70,19 @@ static inline void radix_tree_preload_en
 	preempt_enable();
 }
 
+/*
+ * Support access patterns with locality.
+ */
+struct radix_tree_cache {
+	unsigned long first_index;
+	struct radix_tree_node *tree_node;
+};
+
+void radix_tree_cache_init(struct radix_tree_cache *cache);
+void *radix_tree_cache_lookup(struct radix_tree_root *,
+				struct radix_tree_cache *, unsigned long);
+int radix_tree_cache_size(struct radix_tree_cache *cache);
+int radix_tree_cache_count(struct radix_tree_cache *cache);
+int radix_tree_cache_first_index(struct radix_tree_cache *cache);
+
 #endif /* _LINUX_RADIX_TREE_H */
diff -rup linux-2.6.14-rc4-git4-orig/include/linux/sysctl.h linux-2.6.14-rc4-git4/include/linux/sysctl.h
--- linux-2.6.14-rc4-git4-orig/include/linux/sysctl.h	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/include/linux/sysctl.h	2005-10-16 00:43:49.000000000 +0800
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_READAHEAD_RATIO=29, /* percent of read-ahead size to thrashing-threshold */
 };
 
 
diff -rup linux-2.6.14-rc4-git4-orig/kernel/sysctl.c linux-2.6.14-rc4-git4/kernel/sysctl.c
--- linux-2.6.14-rc4-git4-orig/kernel/sysctl.c	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/kernel/sysctl.c	2005-10-16 00:43:49.000000000 +0800
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
 
diff -rup linux-2.6.14-rc4-git4-orig/lib/radix-tree.c linux-2.6.14-rc4-git4/lib/radix-tree.c
--- linux-2.6.14-rc4-git4-orig/lib/radix-tree.c	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/lib/radix-tree.c	2005-10-16 00:45:29.000000000 +0800
@@ -281,14 +281,8 @@ int radix_tree_insert(struct radix_tree_
 }
 EXPORT_SYMBOL(radix_tree_insert);
 
-/**
- *	radix_tree_lookup    -    perform lookup operation on a radix tree
- *	@root:		radix tree root
- *	@index:		index key
- *
- *	Lookup the item at the position @index in the radix tree @root.
- */
-void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
+void *radix_tree_lookup_node(struct radix_tree_root *root,
+				unsigned long index, unsigned int level)
 {
 	unsigned int height, shift;
 	struct radix_tree_node *slot;
@@ -300,7 +294,7 @@ void *radix_tree_lookup(struct radix_tre
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
-	while (height > 0) {
+	while (height > level) {
 		if (slot == NULL)
 			return NULL;
 
@@ -311,8 +305,67 @@ void *radix_tree_lookup(struct radix_tre
 
 	return slot;
 }
+EXPORT_SYMBOL(radix_tree_lookup_node);
+
+/**
+ *	radix_tree_lookup    -    perform lookup operation on a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root.
+ */
+void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
+{
+	return radix_tree_lookup_node(root, index, 0);
+}
 EXPORT_SYMBOL(radix_tree_lookup);
 
+void *radix_tree_cache_lookup(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index)
+{
+	struct radix_tree_node *node;
+
+	if ((index & ~RADIX_TREE_MAP_MASK) == cache->first_index)
+		return cache->tree_node->slots[index & RADIX_TREE_MAP_MASK];
+
+	node = radix_tree_lookup_node(root, index, 1);
+	if (!node)
+		return 0;
+
+	cache->tree_node = node;
+	cache->first_index = (index & ~RADIX_TREE_MAP_MASK);
+	return node->slots[index & RADIX_TREE_MAP_MASK];
+}
+EXPORT_SYMBOL(radix_tree_cache_lookup);
+
+void radix_tree_cache_init(struct radix_tree_cache *cache)
+{
+	cache->first_index = 1;
+}
+EXPORT_SYMBOL(radix_tree_cache_init);
+
+int radix_tree_cache_size(struct radix_tree_cache *cache)
+{
+	return RADIX_TREE_MAP_SIZE;
+}
+EXPORT_SYMBOL(radix_tree_cache_size);
+
+int radix_tree_cache_count(struct radix_tree_cache *cache)
+{
+	if (cache->first_index != 1)
+		return cache->tree_node->count;
+	else
+		return 0;
+}
+EXPORT_SYMBOL(radix_tree_cache_count);
+
+int radix_tree_cache_first_index(struct radix_tree_cache *cache)
+{
+	return cache->first_index;
+}
+EXPORT_SYMBOL(radix_tree_cache_first_index);
+
 /**
  *	radix_tree_tag_set - set a tag on a radix tree node
  *	@root:		radix tree root
diff -rup linux-2.6.14-rc4-git4-orig/mm/filemap.c linux-2.6.14-rc4-git4/mm/filemap.c
--- linux-2.6.14-rc4-git4-orig/mm/filemap.c	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/mm/filemap.c	2005-10-16 00:43:49.000000000 +0800
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
@@ -761,16 +765,35 @@ void do_generic_mapping_read(struct addr
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
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -786,8 +809,10 @@ page_ok:
 		 * When (part of) the same page is read multiple times
 		 * in succession, only mark it as accessed the first time.
 		 */
-		if (prev_index != index)
+		if (prev_index != index) {
+			ra_access(&ra, page);
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
@@ -1273,6 +1320,7 @@ success:
 	/*
 	 * Found the page and have a reference on it.
 	 */
+	ra_access(ra, page);
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
diff -rup linux-2.6.14-rc4-git4-orig/mm/page_alloc.c linux-2.6.14-rc4-git4/mm/page_alloc.c
--- linux-2.6.14-rc4-git4-orig/mm/page_alloc.c	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/mm/page_alloc.c	2005-10-16 01:03:24.000000000 +0800
@@ -110,9 +110,10 @@ static void bad_page(const char *functio
 			1 << PG_private |
 			1 << PG_locked	|
 			1 << PG_active	|
+			1 << PG_activate|
 			1 << PG_dirty	|
 			1 << PG_reclaim |
-			1 << PG_slab    |
+			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback);
 	set_page_count(page, 0);
@@ -460,6 +461,7 @@ static void prep_new_page(struct page *p
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
+			1 << PG_activate | 1 << PG_readahead |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	page->private = 0;
 	set_page_refs(page, order);
@@ -784,9 +786,15 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
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
 
@@ -811,8 +819,57 @@ restart:
 	 * Go through the zonelist once, looking for a zone with enough free.
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
-		int do_reclaim = should_reclaim_zone(z, gfp_mask);
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
@@ -822,11 +879,12 @@ restart:
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
@@ -838,20 +896,18 @@ zone_reclaim_retry:
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
@@ -1355,6 +1411,8 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" aging:%lukB"
+			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",
@@ -1366,6 +1424,8 @@ void show_free_areas(void)
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
+			K(zone->nr_page_aging),
+			zone->page_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
@@ -1929,6 +1989,9 @@ static void __init free_area_init_core(s
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->nr_page_aging = 0;
+		zone->aging_milestone = 0;
+		zone->page_age = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2100,6 +2163,8 @@ static int zoneinfo_show(struct seq_file
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        aging    %lu"
+			   "\n        age      %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2109,6 +2174,8 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->nr_page_aging,
+			   zone->page_age,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
@@ -2230,6 +2297,63 @@ static char *vmstat_text[] = {
 
 	"pgrotated",
 	"nr_bounce",
+
+	"cache_miss",
+	"readrandom",
+	"pgreadrandom",
+	"readahead_rescue",
+	"pgreadahead_rescue",
+	"readahead_end",
+
+	"readahead",
+	"readahead_return",
+	"readahead_eof",
+	"pgreadahead",
+	"pgreadahead_hit",
+	"pgreadahead_eof",
+
+	"ra_newfile",
+	"ra_newfile_return",
+	"ra_newfile_eof",
+	"pgra_newfile",
+	"pgra_newfile_hit",
+	"pgra_newfile_eof",
+
+	"ra_state",
+	"ra_state_return",
+	"ra_state_eof",
+	"pgra_state",
+	"pgra_state_hit",
+	"pgra_state_eof",
+
+	"ra_context",
+	"ra_context_return",
+	"ra_context_eof",
+	"pgra_context",
+	"pgra_context_hit",
+	"pgra_context_eof",
+
+	"ra_contexta",
+	"ra_contexta_return",
+	"ra_contexta_eof",
+	"pgra_contexta",
+	"pgra_contexta_hit",
+	"pgra_contexta_eof",
+
+	"ra_backward",
+	"ra_backward_return",
+	"ra_backward_eof",
+	"pgra_backward",
+	"pgra_backward_hit",
+	"pgra_backward_eof",
+
+	"ra_random",
+	"ra_random_return",
+	"ra_random_eof",
+	"pgra_random",
+	"pgra_random_hit",
+	"pgra_random_eof",
+
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
diff -rup linux-2.6.14-rc4-git4-orig/mm/readahead.c linux-2.6.14-rc4-git4/mm/readahead.c
--- linux-2.6.14-rc4-git4-orig/mm/readahead.c	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/mm/readahead.c	2005-10-16 00:43:49.000000000 +0800
@@ -15,6 +15,56 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+#define DEBUG_READAHEAD
+
+#ifdef DEBUG_READAHEAD
+#define dprintk(args...) \
+	if (readahead_ratio & 1) printk(KERN_DEBUG args)
+#define ddprintk(args...) \
+	if ((readahead_ratio & 3) == 3) printk(KERN_DEBUG args)
+
+#define ra_account_page(ra, member, delta)	do {			\
+	unsigned long opg = offsetof(struct page_state, pgreadahead) - 	\
+				offsetof(struct page_state, readahead);	\
+	unsigned long o1 = offsetof(struct page_state, member);		\
+	unsigned long o2 = o1 + 2 * opg * ((ra)->flags & RA_CLASS_MASK);\
+	BUG_ON(opg + o2 >= sizeof(struct page_state));			\
+	__mod_page_state(o1, 1UL);					\
+	__mod_page_state(o2, 1UL);					\
+	__mod_page_state(opg + o1, (delta));				\
+	__mod_page_state(opg + o2, (delta));				\
+} while (0)
+
+#define ra_account(member, class, delta)	do {			\
+	unsigned long opg = offsetof(struct page_state, pgreadahead) - 	\
+				offsetof(struct page_state, readahead);	\
+	unsigned long o1 = offsetof(struct page_state, member);		\
+	unsigned long o2 = o1 + 2 * opg * (class);			\
+	if ((class) >= RA_CLASS_END)					\
+		break;							\
+	BUG_ON(o2 >= sizeof(struct page_state));			\
+	__mod_page_state(o1, (delta));					\
+	__mod_page_state(o2, (delta));					\
+} while (0)
+
+#else
+#undef inc_page_state
+#undef mod_page_state
+#define inc_page_state(a)    do {} while(0)
+#define mod_page_state(a, b) do {} while(0)
+#define dprintk(args...)     do {} while(0)
+#define ddprintk(args...)    do {} while(0)
+#define ra_account(member, class, delta)	do {} while(0)
+#define ra_account_page(member, class, delta)	do {} while(0)
+#endif
+
+/* Set look-ahead size to 1/8 of the read-ahead size. */
+#define LOOKAHEAD_RATIO 8
+
+/* Set read-ahead size to ##% of the thrashing-threshold. */
+int readahead_ratio = 0;   
+EXPORT_SYMBOL(readahead_ratio);
+
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
@@ -254,10 +304,11 @@ out:
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
@@ -267,7 +318,7 @@ __do_page_cache_readahead(struct address
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -290,6 +341,9 @@ __do_page_cache_readahead(struct address
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
+		if (readahead_ratio > 9 &&
+				page_idx == nr_to_read - lookahead_size)
+			SetPageReadahead(page);
 		ret++;
 	}
 	read_unlock_irq(&mapping->tree_lock);
@@ -326,7 +380,7 @@ int force_page_cache_readahead(struct ad
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+						offset, this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -373,7 +427,7 @@ int do_page_cache_readahead(struct addre
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 }
 
 /*
@@ -393,7 +447,10 @@ blockable_page_cache_readahead(struct ad
 	if (!block && bdi_read_congested(mapping->backing_dev_info))
 		return 0;
 
-	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
 
 	return check_ra_success(ra, nr_to_read, actual);
 }
@@ -556,3 +613,1318 @@ unsigned long max_sane_readahead(unsigne
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
+#define next_page(page) (list_entry((page)->lru.prev, struct page, lru))
+#define prev_page(page) (list_entry((page)->lru.next, struct page, lru))
+
+/*
+ * The nature of read-ahead allows most tests to fail or even be wrong.
+ * Here we just do not bother to call get_page(), it's meaningless anyway.
+ */
+struct page *find_page(struct address_space *mapping, unsigned long offset)
+{
+	struct page *page;
+
+	read_lock_irq(&mapping->tree_lock);
+	page = radix_tree_lookup(&mapping->page_tree, offset);
+	read_unlock_irq(&mapping->tree_lock);
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
+	index = page->index;
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
+		while (page_mapping(page) == mapping && page->index == index) {
+			struct page *the_page = page;
+			page = next_page(page);
+			if (!PageActive(the_page) &&
+					!PageActivate(the_page) &&
+					!PageLocked(the_page) &&
+					page_count(the_page) == 1) {
+				list_move(&the_page->lru, &zone->inactive_list);
+				zone->nr_page_aging++;
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
+	inc_page_state(readahead_rescue);
+	mod_page_state(pgreadahead_rescue, pgrescue);
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
+ * Set class of read-ahead
+ */
+static inline void set_ra_class(struct file_ra_state *ra,
+				enum file_ra_class ra_class)
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
+	ra_addup_cache_hit(ra);
+	ra->ra_index = ra->readahead_index;
+	ra->la_index = ra->lookahead_index;
+	ra->readahead_index += ra_size;
+	ra->lookahead_index = ra->readahead_index - la_size;
+	ra->nr_page_aging = nr_page_aging();
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
+	enum file_ra_class ra_class;
+	static char *ra_class_name[] = {
+		"newfile",
+		"state",
+		"context",
+		"contexta",
+		"backward",
+		/* "around", */
+		"random",
+	};
+
+	ra_class = (ra->flags & RA_CLASS_MASK);
+	BUG_ON(ra_class == 0 || ra_class > RA_CLASS_END);
+
+	eof_index = ((i_size_read(mapping->host) - 1) >> PAGE_CACHE_SHIFT) + 1;
+	ra_size = ra->readahead_index - ra->ra_index;
+	la_size = ra->readahead_index - ra->lookahead_index;
+
+	/* Snap to EOF. */
+	if (unlikely(ra->ra_index >= eof_index)) {
+		inc_page_state(readahead_end);
+		return 0;
+	}
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
+	if (!la_size && ra->readahead_index == eof_index)
+		ra_account_page(ra, readahead_eof, actual);
+	ra_account_page(ra, readahead, actual);
+
+	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
+			ra_class_name[ra_class - 1],
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
+	global_shift = nr_page_aging() - ra->nr_page_aging;
+	stream_shift = ra_cache_hit(ra, 0);
+
+	ra_size = stream_shift *
+			global_size * readahead_ratio / 100 / global_shift;
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
+	if (readahead_ratio < 80 && 
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
+#if PG_activate < PG_referenced
+#error unexpected page flags order
+#endif
+
+#define PAGE_REFCNT_1		(1 << PG_referenced)
+#define PAGE_REFCNT_2		(1 << PG_activate)
+#define PAGE_REFCNT_3		((1 << PG_activate) | (1 << PG_referenced))
+#define PAGE_REFCNT_MASK	PAGE_REFCNT_3
+/*
+ * STATUS   REFERENCE COUNT      TYPE
+ *   __                   -      not in inactive list
+ *   __                   0      fresh
+ *   _R       PAGE_REFCNT_1      stale
+ *   A_       PAGE_REFCNT_2      disturbed once
+ *   AR       PAGE_REFCNT_3      disturbed twice
+ */
+static inline unsigned long __page_refcnt(struct page *page)
+{
+	return page->flags & PAGE_REFCNT_MASK;
+}
+
+static inline unsigned long page_refcnt(struct page *page)
+{
+	if (!page || PageActive(page))
+		return 0;
+
+	return __page_refcnt(page);
+}
+
+static inline char page_refcnt_symbol(struct page *page)
+{
+	if (!page)
+		return 'X';
+	if (PageActive(page))
+		return 'A';
+	switch (__page_refcnt(page)) {
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
+ * Look back and count history pages to estimate thrashing-threshold.
+ *
+ * Strategies
+ * - Sequential read that extends from index 0
+ * 	The counted value may well be far under the true threshold, so return
+ * 	it unmodified for further process in adjust_rala_accelerated().
+ * - Sequential read with a large history count
+ * 	Check 3 evenly spread pages to be sure there is no hole or many
+ * 	not-yet-accessed pages. This prevents unnecessary IO, and allows some
+ * 	almost sequential patterns to survive.
+ * - Return equal or smaller count; but ensure a reasonable minimal value.
+ *
+ * Optimization
+ * - The count will normally be min(nr_lookback, offset), unless either memory
+ *   or read speed is low, or it is still in grow up phase.
+ * - A rigid implementation would be a simple loop to scan page by page
+ *   backward, though this may be unnecessary and inefficient, so the
+ *   stepping backward/forward scheme is used.
+ *
+ * FIXME: it seems ugly :(
+ */
+static int count_sequential_pages(struct address_space *mapping,
+			int refcnt, unsigned long *remain,
+			unsigned long offset,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	int step;
+	int count;
+	unsigned long index;
+	unsigned long nr_lookback;
+	struct page *page;
+	struct radix_tree_cache cache;
+
+	*remain = 0;
+	nr_lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
+						100 / (readahead_ratio + 1);
+	if (nr_lookback > offset)
+		nr_lookback = offset;
+	if (nr_lookback > mapping->nrpages)
+		nr_lookback = mapping->nrpages;
+
+	if (nr_lookback <= ra_min * 100 / (readahead_ratio + 1)) {
+		*remain = nr_lookback;
+		return ra_min;
+	}
+
+	radix_tree_cache_init(&cache);
+	read_lock_irq(&mapping->tree_lock);
+
+	/* check the far end first */
+	index = offset - nr_lookback;
+	page = radix_tree_cache_lookup(&mapping->page_tree, &cache, index);
+	if (page_refcnt(page) >= refcnt) {
+		step = 1 + nr_lookback / 3;
+		if(nr_lookback > ra_min * 8) {
+			count = 1;
+			goto check_more;
+		} else {
+			*remain = nr_lookback;
+			goto out_unlock;
+		}
+	}
+
+	/* scan backward for non-present page */
+	count = 0; /* just to make gcc happy */
+	for(step = ra_min; step < nr_lookback; step *= 4) {
+		index = offset - step;
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+									index);
+		if (!page)
+			goto check_more;
+	}
+	index = offset - nr_lookback;
+	page = NULL;
+
+	/* scan forward and check some more pages */
+check_more:
+	for(;;) {
+		if (page && !*remain)
+			*remain = offset - index;
+		if (page_refcnt(page) < refcnt) {
+			count = 0;
+			step = (offset - index + 3) / 4;
+		} else if (++count >= 3 || step < ra_min)
+			break;
+		index += step;
+		if (index >= offset)
+			break;
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+									index);
+	}
+out_unlock:
+	read_unlock_irq(&mapping->tree_lock);
+
+	count = 3 * step;
+	if (count > nr_lookback)
+		return nr_lookback;
+	
+	if (!*remain)
+		*remain = count;
+
+	count = count * readahead_ratio / 100;
+	if (count < get_min_readahead(NULL))
+		count = get_min_readahead(NULL);
+
+	return count;
+}
+
+/*
+ * Scan forward in inactive_list for the first non-present page.
+ * It takes advantage of the adjacency of pages in inactive_list.
+ */
+static unsigned long lru_scan_forward(struct page *page, int nr_pages)
+{
+	unsigned long index = page->index;
+	struct address_space *mapping = page_mapping(page);
+	struct zone *zone;
+
+	for(;;) {
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+
+		if (!PageLRU(page))
+			goto out;
+
+		do {    
+			index++;
+			if (!--nr_pages)
+				goto out;
+			page = next_page(page);
+		} while (page_mapping(page) == mapping && page->index == index);
+
+		spin_unlock_irq(&zone->lru_lock);
+
+		page = find_page(mapping, index);
+		if (!page)
+			return index;
+	}
+out:    
+	spin_unlock_irq(&zone->lru_lock);
+	return nr_pages ? index : 0;
+}
+
+/* Directly calling lru_scan_forward() would be slow.
+ * This function tries to avoid unnecessary scans for the most common cases:
+ * - Slow reads should scan forward directly;
+ * - Fast reads should step backward first;
+ * - Aggressive reads may well have max allowed look-ahead size.
+ */
+static unsigned long first_absent_page(struct address_space *mapping,
+				struct page *page, unsigned long index,
+				unsigned long ra_size, unsigned long ra_max)
+{
+	struct radix_tree_cache cache;
+
+	if (ra_size < ra_max)
+		goto scan_forward;
+
+	radix_tree_cache_init(&cache);
+	read_lock_irq(&mapping->tree_lock);
+
+	if (ra_size < LOOKAHEAD_RATIO * ra_max)
+		goto scan_backward;
+
+	page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+							index + ra_max);
+	if (page) {
+		read_unlock_irq(&mapping->tree_lock);
+		return 0;
+	}
+	page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+							index + ra_max - 1);
+	if (page) {
+		read_unlock_irq(&mapping->tree_lock);
+		return index + ra_max;
+	}
+
+scan_backward:
+	if (ra_size == index)
+		ra_size /= 4;
+	else
+		ra_size /= (LOOKAHEAD_RATIO * 2);
+	for(;; ra_size /= 2) {
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+							index + ra_size);
+		if (page)
+			break;
+		if (!ra_size)
+			return index + 1;
+	}
+	read_unlock_irq(&mapping->tree_lock);
+	ra_size = ra_max;
+
+scan_forward:
+	return lru_scan_forward(page, ra_size + 1);
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
+	unsigned long ret;
+	int refcnt;
+
+	/* NFSv3 daemons may process adjecent requests in parallel,
+	 * leading to many locally disordered, globally sequential reads.
+	 * So do not require nearby history pages to be accessed, present is
+	 * enough.
+	 */
+	if (!prev_page)
+		return 0;
+
+	refcnt = page_refcnt(prev_page);
+	if (refcnt < PAGE_REFCNT_1)
+		refcnt = PAGE_REFCNT_1;
+	
+	ra_size = count_sequential_pages(mapping, refcnt,
+			&remain_pages, index, ra_min, ra_max);
+
+	/* Where to start read-ahead? */
+	if (!page)
+		ra_index = index;
+	else {
+		ra_index = first_absent_page(
+				mapping, page, index, ra_size, ra_max);
+		if (unlikely(!ra_index))
+			return -1;
+	}
+
+	la_size = ra_index - index;
+	if (readahead_ratio < 80 && 
+			remain_pages <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return -1;
+	}
+
+	if (ra_size == index) {
+		ret = adjust_rala_accelerated(ra_max, &ra_size, &la_size);
+		set_ra_class(ra, RA_CLASS_CONTEXT_ACCELERATED);
+	} else {
+		ret = adjust_rala(ra_max, &ra_size, &la_size);
+		set_ra_class(ra, RA_CLASS_CONTEXT);
+	}
+	if (unlikely(!ret))
+		return -1;
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
+			unsigned long first_index, unsigned long last_index,
+			unsigned long ra_size, unsigned long ra_max)
+{
+	if (ra_size > ra_max)
+		return 0;
+
+	if (ra_has_index(ra, ra->prev_page)) {
+		ra_size += 2 * ra_cache_hit(ra, 0);
+		last_index = ra->la_index;
+	} else {
+		ra_size = 4 * ra_size;
+		last_index = ra->prev_page;
+	}
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	if (last_index < first_index ||
+	    last_index > first_index + ra_size)
+		return 0;
+
+	first_index = last_index - ra_size;
+
+	set_ra_class(ra, RA_CLASS_BACKWARD);
+	ra_state_init(ra, first_index, first_index);
+	ra_state_update(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
+ * If there is a previous sequential read, it is likely to be another
+ * sequential read at the new position.
+ * Databases are known to have the seek-and-read-one-record pattern.
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
+	if (index == ra->prev_page + 1)      /* read after thrashing */
+		ra_size = hit0;
+	else if (ra_size < hit1 &&           /* read after seeking   */
+			hit1 > hit2 / 2 &&
+			hit2 > hit3 / 2 &&
+			hit3 > hit1 / 2)
+		ra_size = min(ra_max, hit1);
+	else
+		return 0;
+
+	set_ra_class(ra, RA_CLASS_RANDOM);
+	ra_state_init(ra, index, index);
+	ra_state_update(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
+ * ra_size is mainly determined by:
+ * 1. sequential-start: min(KB(16 + mem_mb/16), KB(64))
+ * 2. sequential-max:	min(KB(64 + mem_mb*64), KB(2048))
+ * 3. sequential:	(thrashing-threshold) * readahead_ratio / 100
+ *
+ * Table of concrete numbers for 4KB page size:
+ *  (inactive + free) (in MB):    4   8   16   32   64  128  256  512 1024
+ *    initial ra_size (in KB):   16  16   16   16   20   24   32   48   64
+ *	  max ra_size (in KB):  320 576 1088 2048 2048 2048 2048 2048 2048
+ */
+static inline void get_readahead_bounds(struct file_ra_state *ra,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long mem_mb;
+
+#define KB(size)	(((size) * 1024) / PAGE_CACHE_SIZE)
+	mem_mb = nr_free_inactive() * PAGE_CACHE_SIZE / 1024 / 1024;
+	*ra_max = min(min(KB(64 + mem_mb*64), KB(2048)), ra->ra_pages); 
+	*ra_min = min(min(KB(VM_MIN_READAHEAD + mem_mb/16), KB(128)), *ra_max/2);
+#undef KB
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
+ * That makes both methods happy, and lives in harmony with application managed
+ * read-aheads via fadvise() / madvise(). The cache hit problem is also
+ * eliminated naturally.
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			unsigned long first_index,
+			unsigned long index, unsigned long last_index)
+{
+	unsigned long size;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int ret;
+
+	if (page) {
+		if(!TestClearPageReadahead(page))
+			return 0;
+		if (bdi_read_congested(mapping->backing_dev_info))
+			return 0;
+	}
+
+	if (page)
+		ra_account(readahead_return, ra->flags & RA_CLASS_MASK, 1);
+	else if (index)
+		inc_page_state(cache_miss);
+
+	size = last_index - index;
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
+		return newfile_readahead(mapping, filp, ra, last_index, ra_min);
+
+	/*
+	 * State based sequential read-ahead.
+	 */
+	if ((readahead_ratio % 5) == 0 &&
+		index == ra->lookahead_index &&
+		(page || index == ra->readahead_index) &&
+		(ra_cache_hit_ok(ra) ||
+		 last_index - first_index >= ra_max))
+		return state_based_readahead(mapping, filp, ra, page, ra_max);
+
+	/*
+	 * Backward read-ahead.
+	 */
+	if (try_read_backward(ra, first_index, last_index, size, ra_max))
+		return ra_dispatch(ra, mapping, filp);
+
+	/* 
+	 * Context based sequential read-ahead.
+	 */ 
+	if (!prev_page)
+		prev_page = find_page(mapping, index - 1);
+	ret = try_context_based_readahead(mapping, ra, prev_page, page,
+						index, ra_min, ra_max);
+	if (ret > 0)
+		return ra_dispatch(ra, mapping, filp);
+	if (ret < 0)
+		return 0;
+
+	/* No action on look ahead time ? */
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
+	inc_page_state(readrandom);
+	mod_page_state(pgreadrandom, size);
+
+	dprintk("readrandom(ino=%lu, pages=%lu, index=%lu-%lu-%lu) = %lu\n",
+			mapping->host->i_ino, mapping->nrpages,
+			first_index, index, last_index, size);
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
+	if (!ra_has_index(ra, page->index))
+		return;
+
+	ra->cache_hit++;
+
+	if (page->index >= ra->ra_index)
+		ra_account(pgreadahead_hit, ra->flags & RA_CLASS_MASK, 1);
+	else
+		ra_account(pgreadahead_hit,
+			(ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK, 1);
+}
+
+/*
+ * Detect and protect sequential read-ahead pages.
+ * 
+ * The safty guarantee provided by this function is only needed in file servers
+ * with big readahead_ratio set.
+ *
+ * This function is called when pages in @page_list are to be freed,
+ * it protects ra pages by moving them into @save_list.
+ *
+ * The general idea is to classify pages of a file into random pages and groups
+ * of sequential accessed pages. Random pages and leading segments of
+ * sequential pages are left over, following sequential pages are saved.
+ *
+ * The algorithm must ensure:
+ * - no page is pinned in inactive_list.
+ * - no excessive pages are saved.
+ *
+ * chunk         - a list of pages belong to the same file
+ * rs/ra pages   - a chunk of pages that was read/to be read sequentially
+ *                 Detected by ascending index and (almost) non-descending
+ *                 reference count. rs pages have greater reference count than
+ *                 following ra pages.  A page can be both rs/ra page, which
+ *                 indicates there are two adjacent readers.
+ * live ra pages - ra pages that have reading in progress
+ *                 Detected by having leading rs pages(either in page_list or in
+ *                 inactive_list), or limited ra pages(may be in another zone,
+ *                 just had their rs pages dropped).
+ * dead ra pages - ra pages that seems to have no imminent reader
+ *                 Note that they are not necessarily dead: either the cost of
+ *                 search the leading rs pages or the cost of keeping them in
+ *                 memory is large, so they are abandoned.
+ *                 Leading rs pages are detected and handled the same way.
+ *
+ * Live ra pages are saved, pure/leading rs pages and dead ra pages are left
+ * over and eligible for free. 
+ *
+ * The rules apply to the following common cases:
+ * keep head   back search            chunk             case
+ *    Y      ----____________|______________________    Normal
+ *           ----------------|----__________________    Normal
+ *                           |----__________________    Normal
+ *           ----------------|----------------------    Normal
+ *                           |----------------------    Normal
+ *     y     ________________|______________________    cache miss
+ *                           |______________________    cache miss
+ *     y     ________________|_______--------_______    two readers
+ *    Y      ----____________|_______--------_______    two readers
+ *                           |_______--------_______    two readers
+ *                           |----_____------_______    two readers
+ *           ----------------|----_____------_______    two readers
+ *           _______---------|---------------_______    two readers
+ *    Y      ----___---------|---------------_______    two readers
+ *           ________________|---------------_______    two readers
+ *    Y      ----____________|---------------_______    two readers
+ *    Y      ====------------|----__________________    two readers
+ *    N                      |====-----------_______    two readers
+ *    N                      |###======-------------    three readers
+ * Y: saved by leading rs pages
+ * y: saved by limited leading ra pages
+ * N: to be activated anyway
+ *
+ * To make it run smooth and fast, ra request boundary must be reserved:
+ * - alloc pages of a chunk from one single zone
+ * - insert pages into lru at one time
+ * - make vmscan code aware of chunk boundaries
+ *
+ * Read backward pattern support is possible, in which case the pages are
+ * better pushed into lru in reverse order.
+ */
+int rescue_ra_pages(struct list_head *page_list, struct list_head *save_list)
+{
+	struct address_space *mapping;
+	struct page *chunk_head;
+	struct page *page;
+	unsigned long refcnt;
+	unsigned long index;
+	int ascend_count;
+	int ret = 0;
+
+	page = list_to_page(page_list);
+
+next_chunk:
+	chunk_head = page;
+	mapping = page_mapping(page);
+	ascend_count = 0;
+
+next_page:
+	index = page->index;
+	refcnt = __page_refcnt(page);
+	page = next_page(page);
+
+	if (&page->lru == page_list)
+		goto save_chunk;
+
+	if (mapping == page_mapping(page) && page->index > index) {
+		if (refcnt < __page_refcnt(page))
+			ascend_count++;
+		goto next_page;
+	}
+
+save_chunk:
+	if (mapping && !PageSwapCache(page) &&
+			!page_mapped(page) &&
+			ascend_count <= 3 &&
+			(!refcnt || index >= chunk_head->index + 8))
+		ret += save_chunk(chunk_head, page, save_list);
+
+	if (&page->lru != page_list)
+		goto next_chunk;
+
+	if (ret)
+		mod_page_state(pgreadahead_rescue, ret);
+
+	return ret;
+}
+
+int save_chunk(struct page *head, struct page *tail,
+		struct list_head *save_list)
+{
+	struct page *page;
+	struct page *next_page;
+	struct address_space *mapping = page_mapping(head);
+	struct radix_tree_cache cache;
+	int i;
+	int keep_head;
+	unsigned long index = head->index;
+	unsigned long refcnt = __page_refcnt(head);
+#ifdef DEBUG_READAHEAD
+	static char static_buf[PAGE_SIZE];
+	static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
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
+	/* The leading pages are going to be activated anyway? */
+	keep_head = 0;
+	if (refcnt > PAGE_REFCNT_1)
+		goto drop_head;
+	if (refcnt >= PAGE_REFCNT_1 && mapping_mapped(mapping))
+		goto drop_head;
+
+	/* Scan backward to see if leading pages should be saved. */
+	radix_tree_cache_init(&cache);
+	read_lock_irq(&mapping->tree_lock);
+	for (i = 2 * mapping->backing_dev_info->ra_pages; i >= 0; i--) {
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+								--index);
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3 && pidx)
+			pat[--pidx] = page_refcnt_symbol(page);
+#endif
+		/* Having limited leading ra pages is required now. It will
+		 * be less important if ra request boundaries are reserved.
+		 */
+		if (!page) {
+			if (i > mapping->backing_dev_info->ra_pages &&
+					index != head->index - 1 &&
+					!__page_refcnt(head))
+				keep_head = 1;
+			break;
+		}
+
+		/* Avoid being pinned by active page. */
+		if (PageActive(page))
+			break;
+
+		/* A trick to speed things up, must be placed after the
+		 * active page test.  This check may be removed when chunk
+		 * boundaries are reserved.
+		 */
+		if ((index & 63) == 63 && !__page_refcnt(head) &&
+				i > mapping->backing_dev_info->ra_pages &&
+				radix_tree_cache_count(&cache) <
+				index - radix_tree_cache_first_index(&cache)) {
+#ifdef DEBUG_READAHEAD
+			if ((readahead_ratio & 3) == 3 && pidx)
+				pat[--pidx] = '|';
+#endif
+			keep_head = 1;
+			break;
+		}
+
+		if (__page_refcnt(page) > refcnt) { /* so they are live pages */
+			keep_head = 1;
+			break;
+		}
+		refcnt = __page_refcnt(page);
+	}
+	read_unlock_irq(&mapping->tree_lock);
+
+drop_head:
+#ifdef DEBUG_READAHEAD
+	if ((readahead_ratio & 3) == 3) {
+		for (i = 0; pidx < PAGE_SIZE / 2;)
+			pat[i++] = pat[pidx++];
+		pat[i++] = '|';
+		for (page = head; page != tail; page = next_page(page)) {
+			pidx = page->index;
+			pat[i++] = page_refcnt_symbol(page);
+			if (i >= PAGE_SIZE - 1)
+				break;
+		}
+		pat[i] = 0;
+		pat[PAGE_SIZE - 1] = 0;
+	}
+#endif
+
+	/* Drop non-descending leading pages. */
+	page = head;
+	if (!keep_head) {
+		refcnt = __page_refcnt(page);
+		while (page != tail && /* never dereference tail! */
+			refcnt <= __page_refcnt(page)) {
+			refcnt = __page_refcnt(page);
+			page = next_page(page);
+		}
+	}
+
+	/* Save the remaining pages. */
+	for (i = 0; page != tail;) {
+		next_page = next_page(page);
+		if (!PageActivate(page)) {
+			i++;
+			list_move(&page->lru, save_list);
+		}
+		page = next_page;
+	}
+
+	if (i)
+		inc_page_state(readahead_rescue);
+
+#ifdef DEBUG_READAHEAD
+	if ((readahead_ratio & 3) == 3) {
+		ddprintk("save_chunk(ino=%lu, idx=%lu-%lu-%lu, %s@%s:%s)"
+				" %s, save %d\n",
+				mapping->host->i_ino,
+				index, head->index, pidx,
+				mapping_mapped(mapping) ? "mmap" : "file",
+				zone_names[page_zonenum(head)], pat,
+				keep_head ? "keephead" : "drophead", i);
+		if (pat != static_buf)
+			free_page((unsigned long)pat);
+	}
+#endif
+
+	return i;
+}
diff -rup linux-2.6.14-rc4-git4-orig/mm/swap.c linux-2.6.14-rc4-git4/mm/swap.c
--- linux-2.6.14-rc4-git4-orig/mm/swap.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.14-rc4-git4/mm/swap.c	2005-10-16 00:43:49.000000000 +0800
@@ -96,6 +96,8 @@ int rotate_reclaimable_page(struct page 
 	return 0;
 }
 
+extern int readahead_ratio;
+
 /*
  * FIXME: speed this up?
  */
@@ -122,8 +124,13 @@ void fastcall activate_page(struct page 
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
+	if (!PageActive(page) && !PageActivate(page) &&
+			PageReferenced(page) && PageLRU(page)) {
+		if (readahead_ratio > 9 || (readahead_ratio & 1)) {
+			page_zone(page)->nr_page_aging++;
+			SetPageActivate(page);
+		} else
+			activate_page(page);
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
@@ -299,6 +306,7 @@ void __pagevec_lru_add(struct pagevec *p
 			if (zone)
 				spin_unlock_irq(&zone->lru_lock);
 			zone = pagezone;
+			update_page_age(zone);
 			spin_lock_irq(&zone->lru_lock);
 		}
 		if (TestSetPageLRU(page))
diff -rup linux-2.6.14-rc4-git4-orig/mm/vmscan.c linux-2.6.14-rc4-git4/mm/vmscan.c
--- linux-2.6.14-rc4-git4-orig/mm/vmscan.c	2005-10-16 00:42:49.000000000 +0800
+++ linux-2.6.14-rc4-git4/mm/vmscan.c	2005-10-16 00:43:49.000000000 +0800
@@ -370,6 +370,8 @@ static pageout_t pageout(struct page *pa
 	return PAGE_CLEAN;
 }
 
+extern int readahead_ratio;
+
 /*
  * shrink_list adds the number of reclaimed pages to sc->nr_reclaimed
  */
@@ -382,6 +384,9 @@ static int shrink_list(struct list_head 
 
 	cond_resched();
 
+	if (readahead_ratio >= 80) 
+		rescue_ra_pages(page_list, &ret_pages);
+
 	pagevec_init(&freed_pvec, 1);
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
@@ -407,6 +412,11 @@ static int shrink_list(struct list_head 
 		if (PageWriteback(page))
 			goto keep_locked;
 
+		if (PageActivate(page)) {
+			ClearPageActivate(page);
+			goto activate_locked;
+		}
+
 		referenced = page_referenced(page, 1, sc->priority <= 0);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
@@ -771,6 +781,7 @@ refill_inactive_zone(struct zone *zone, 
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_inactive += pgmoved;
+			zone->nr_page_aging += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
 			pgdeactivate += pgmoved;
 			pgmoved = 0;
@@ -780,6 +791,7 @@ refill_inactive_zone(struct zone *zone, 
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
+	zone->nr_page_aging += pgmoved;
 	zone->nr_inactive += pgmoved;
 	pgdeactivate += pgmoved;
 	if (buffer_heads_over_limit) {
@@ -862,6 +874,7 @@ shrink_zone(struct zone *zone, struct sc
 		}
 	}
 
+	update_page_age(zone);
 	throttle_vm_writeout();
 
 	atomic_dec(&zone->reclaim_in_progress);
@@ -1047,6 +1060,7 @@ loop_again:
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
+		int begin_zone = -1;
 		unsigned long lru_pages = 0;
 
 		all_zones_ok = 1;
@@ -1059,6 +1073,8 @@ loop_again:
 			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 				struct zone *zone = pgdat->node_zones + i;
 
+				update_page_age(zone);
+
 				if (zone->present_pages == 0)
 					continue;
 
@@ -1068,16 +1084,33 @@ loop_again:
 
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
@@ -1092,7 +1125,7 @@ scan:
 		 * pages behind kswapd's direction of progress, which would
 		 * cause too much scanning of the lower zones.
 		 */
-		for (i = 0; i <= end_zone; i++) {
+		for (i = begin_zone; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_slab;
 
