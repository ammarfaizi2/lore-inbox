Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932068AbWFFCZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWFFCZt (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 22:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWFFCZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 22:25:49 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:22754 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932068AbWFFCZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 22:25:47 -0400
Message-ID: <349560742.21407@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 6 Jun 2006 10:26:06 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Voluspa <lista1@comhem.se>
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
        diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix fastcall
Message-ID: <20060606022606.GA6071@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Voluspa <lista1@comhem.se>, akpm@osdl.org, arjan@infradead.org,
	Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
	linux-kernel@vger.kernel.org
References: <349406446.10828@ustc.edu.cn> <20060604020738.31f43cb0.akpm@osdl.org> <1149413103.3109.90.camel@laptopd505.fenrus.org> <20060605031720.0017ae5e.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20060605031720.0017ae5e.lista1@comhem.se>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 05, 2006 at 03:17:20AM +0200, Voluspa wrote:
> Patch:
> http://web.comhem.se/~u46139355/storetmp/adaptive-readahead-v14-linux-2.6.17-rc5-git-updated-june-04-2006.patch

It seems that the patch has some problem:

+       /* ra_size in its _steady_ state reflects thrashing threshold */                                                 
+       if (page && ra_old + ra_old / 8 >= ra_size)                                                                      
+               update_ra_thrash_bytes(mapping->backing_dev_info, ra_size);                                              
+                                                                                                                        
+       limit_rala(growth_limit, la_old, &ra_size, &la_size);                                                            

The above statements was displaced, rendering the if() clause to fail all the time.
That defeats the small file optimization, for ra_thrash_bytes will remain small.

Voluspa, I attached an updated patch, including two more performance tunings.
Please take it when you find time to do more benchmarks, thanks.

I'd suggest that you(and other kind people interested in testing it out) to run
        blockdev --setra 2048 /dev/[sda/sda1/...]
before each benchmark to ensure fairness and simplicity of analysis, thanks.

Wu

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="adaptive-readahead-2.6.17-rc5.patch"

--- linux-2.6.17-rc5.orig/Documentation/sysctl/vm.txt
+++ linux-2.6.17-rc5/Documentation/sysctl/vm.txt
@@ -29,6 +29,8 @@ Currently, these files are in /proc/sys/
 - drop-caches
 - zone_reclaim_mode
 - zone_reclaim_interval
+- readahead_ratio
+- readahead_hit_rate
 
 ==============================================================
 
@@ -178,3 +180,38 @@ Time is set in seconds and set by defaul
 Reduce the interval if undesired off node allocations occur. However, too
 frequent scans will have a negative impact onoff node allocation performance.
 
+
+==============================================================
+
+readahead_ratio
+
+This limits readahead size to percent of the thrashing threshold.
+The thrashing threshold is dynamicly estimated from the _history_ read
+speed and system load, to deduce the _future_ readahead request size.
+
+Set it to a smaller value if you have not enough memory for all the
+concurrent readers, or the I/O loads fluctuate a lot. But if there's
+plenty of memory(>2MB per reader), a bigger value may help performance.
+
+readahead_ratio also selects the readahead logic:
+	VALUE	CODE PATH
+	-------------------------------------------
+	    0	disable readahead totally
+	  1-9	select the stock readahead logic
+	10-inf	select the adaptive readahead logic
+
+The default value is 50.  Reasonable values would be [50, 100].
+
+==============================================================
+
+readahead_hit_rate
+
+This is the max allowed value of (readahead-pages : accessed-pages).
+Useful only when (readahead_ratio >= 10). If the previous readahead
+request has bad hit rate, the kernel will be reluctant to do the next
+readahead.
+
+Larger values help catch more sparse access patterns. Be aware that
+readahead of the sparse patterns sacrifices memory for speed.
+
+The default value is 1.  It is recommended to keep the value below 16.
--- linux-2.6.17-rc5.orig/block/ll_rw_blk.c
+++ linux-2.6.17-rc5/block/ll_rw_blk.c
@@ -249,9 +249,6 @@ void blk_queue_make_request(request_queu
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
 	q->make_request_fn = mfn;
-	q->backing_dev_info.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
-	q->backing_dev_info.state = 0;
-	q->backing_dev_info.capabilities = BDI_CAP_MAP_COPY;
 	blk_queue_max_sectors(q, SAFE_MAX_SECTORS);
 	blk_queue_hardsect_size(q, 512);
 	blk_queue_dma_alignment(q, 511);
@@ -1847,6 +1844,7 @@ request_queue_t *blk_alloc_queue_node(gf
 	q->kobj.ktype = &queue_ktype;
 	kobject_init(&q->kobj);
 
+	q->backing_dev_info = default_backing_dev_info;
 	q->backing_dev_info.unplug_io_fn = blk_backing_dev_unplug;
 	q->backing_dev_info.unplug_io_data = q;
 
@@ -3764,6 +3762,29 @@ queue_ra_store(struct request_queue *q, 
 	return ret;
 }
 
+static ssize_t queue_initial_ra_show(struct request_queue *q, char *page)
+{
+	int kb = q->backing_dev_info.ra_pages0 << (PAGE_CACHE_SHIFT - 10);
+
+	return queue_var_show(kb, (page));
+}
+
+static ssize_t
+queue_initial_ra_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long kb, ra;
+	ssize_t ret = queue_var_store(&kb, page, count);
+
+	ra = kb >> (PAGE_CACHE_SHIFT - 10);
+	q->backing_dev_info.ra_pages0 = ra;
+
+	ra = kb * 1024;
+	if (q->backing_dev_info.ra_expect_bytes > ra)
+		q->backing_dev_info.ra_expect_bytes = ra;
+
+	return ret;
+}
+
 static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 {
 	int max_sectors_kb = q->max_sectors >> 1;
@@ -3821,6 +3842,12 @@ static struct queue_sysfs_entry queue_ra
 	.store = queue_ra_store,
 };
 
+static struct queue_sysfs_entry queue_initial_ra_entry = {
+	.attr = {.name = "initial_ra_kb", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_initial_ra_show,
+	.store = queue_initial_ra_store,
+};
+
 static struct queue_sysfs_entry queue_max_sectors_entry = {
 	.attr = {.name = "max_sectors_kb", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_max_sectors_show,
@@ -3841,6 +3868,7 @@ static struct queue_sysfs_entry queue_io
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
+	&queue_initial_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_iosched_entry.attr,
--- linux-2.6.17-rc5.orig/drivers/block/loop.c
+++ linux-2.6.17-rc5/drivers/block/loop.c
@@ -779,6 +779,12 @@ static int loop_set_fd(struct loop_devic
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
+	/*
+	 * The upper layer should already do proper look-ahead,
+	 * one more look-ahead here only ruins the cache hit rate.
+	 */
+	file->f_ra.flags |= RA_FLAG_NO_LOOKAHEAD;
+
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
--- linux-2.6.17-rc5.orig/fs/file_table.c
+++ linux-2.6.17-rc5/fs/file_table.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/eventpoll.h>
@@ -160,6 +161,12 @@ void fastcall __fput(struct file *file)
 	might_sleep();
 
 	fsnotify_close(file);
+
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+	if (file->f_ra.flags & RA_FLAG_EOF)
+		readahead_close(file);
+#endif
+
 	/*
 	 * The function eventpoll_release() should be the first called
 	 * in the file cleanup chain.
--- linux-2.6.17-rc5.orig/fs/mpage.c
+++ linux-2.6.17-rc5/fs/mpage.c
@@ -407,8 +407,10 @@ mpage_readpages(struct address_space *ma
 					&last_block_in_bio, &map_bh,
 					&first_logical_block,
 					get_block);
-			if (!pagevec_add(&lru_pvec, page))
+			if (!pagevec_add(&lru_pvec, page)) {
+				cond_resched();
 				__pagevec_lru_add(&lru_pvec);
+			}
 		} else {
 			page_cache_release(page);
 		}
--- linux-2.6.17-rc5.orig/fs/nfsd/vfs.c
+++ linux-2.6.17-rc5/fs/nfsd/vfs.c
@@ -829,7 +829,10 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 #endif
 
 	/* Get readahead parameters */
-	ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
+	if (prefer_adaptive_readahead())
+		ra = NULL;
+	else
+		ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
 
 	if (ra && ra->p_set)
 		file->f_ra = ra->p_ra;
--- linux-2.6.17-rc5.orig/include/linux/backing-dev.h
+++ linux-2.6.17-rc5/include/linux/backing-dev.h
@@ -24,6 +24,9 @@ typedef int (congested_fn)(void *, int);
 
 struct backing_dev_info {
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
+	unsigned long ra_pages0; /* recommended readahead on start of file */
+	unsigned long ra_expect_bytes;	/* expected read size on start of file */
+	unsigned long ra_thrash_bytes;	/* thrashing threshold */
 	unsigned long state;	/* Always use atomic bitops on this */
 	unsigned int capabilities; /* Device capabilities */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
--- linux-2.6.17-rc5.orig/include/linux/fs.h
+++ linux-2.6.17-rc5/include/linux/fs.h
@@ -613,21 +613,75 @@ struct fown_struct {
 
 /*
  * Track a single file's readahead state
+ *
+ * Diagram for the adaptive readahead logic:
+ *
+ *  |--------- old chunk ------->|-------------- new chunk -------------->|
+ *  +----------------------------+----------------------------------------+
+ *  |               #            |                  #                     |
+ *  +----------------------------+----------------------------------------+
+ *                  ^            ^                  ^                     ^
+ *  file_ra_state.la_index    .ra_index   .lookahead_index      .readahead_index
+ *
+ * Common used deduced sizes:
+ *                               |----------- readahead size ------------>|
+ *  +----------------------------+----------------------------------------+
+ *  |               #            |                  #                     |
+ *  +----------------------------+----------------------------------------+
+ *                  |------- invoke interval ------>|-- lookahead size -->|
  */
 struct file_ra_state {
-	unsigned long start;		/* Current window */
-	unsigned long size;
-	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
-	unsigned long cache_hit;	/* cache hit count*/
-	unsigned long prev_page;	/* Cache last read() position */
-	unsigned long ahead_start;	/* Ahead window */
-	unsigned long ahead_size;
-	unsigned long ra_pages;		/* Maximum readahead window */
+	union {
+		struct { /* stock read-ahead */
+			unsigned long start;		/* Current window */
+			unsigned long size;
+			unsigned long ahead_start;	/* Ahead window */
+			unsigned long ahead_size;
+			unsigned long cache_hit;	/* cache hit count */
+		};
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+		struct { /* adaptive read-ahead */
+			pgoff_t la_index;		/* old chunk */
+			pgoff_t ra_index;
+			pgoff_t lookahead_index;	/* new chunk */
+			pgoff_t readahead_index;
+
+			/*
+			 * Read-ahead hits.
+			 * 	i.e. # of distinct read-ahead pages accessed.
+			 *
+			 * What is a read-ahead sequence?
+			 * 	A collection of sequential read-ahead requests.
+			 * To put it simple:
+			 * 	Normally a seek starts a new sequence.
+			 */
+			u16	hit0;	/* for the current request */
+			u16	hit1;	/* for the current sequence */
+			u16	hit2;	/* for the previous sequence */
+			u16	hit3;	/* for the prev-prev sequence */
+
+			/*
+			 * Snapshot of the (node's) read-ahead aging value
+			 * on time of I/O submission.
+			 */
+			unsigned long age;
+		};
+#endif
+	};
+
+	/* mmap read-around */
 	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
 	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
+
+	unsigned long flags;	/* RA_FLAG_xxx | ra_class_old | ra_class_new */
+	unsigned long prev_page;	/* Cache last read() position */
+	unsigned long ra_pages;		/* Maximum readahead window */
 };
-#define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
-#define RA_FLAG_INCACHE 0x02	/* file is already in cache */
+#define RA_FLAG_MISS	(1UL<<31) /* a cache miss occured against this file */
+#define RA_FLAG_INCACHE	(1UL<<30) /* file is already in cache */
+#define RA_FLAG_MMAP		(1UL<<29) /* mmaped page access */
+#define RA_FLAG_NO_LOOKAHEAD	(1UL<<28) /* disable look-ahead */
+#define RA_FLAG_EOF		(1UL<<27) /* readahead hits EOF */
 
 struct file {
 	/*
--- linux-2.6.17-rc5.orig/include/linux/mm.h
+++ linux-2.6.17-rc5/include/linux/mm.h
@@ -955,7 +955,11 @@ extern int filemap_populate(struct vm_ar
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+#define VM_MAX_READAHEAD	1024	/* kbytes */
+#else
 #define VM_MAX_READAHEAD	128	/* kbytes */
+#endif
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 #define VM_MAX_CACHE_HIT    	256	/* max pages in a row in cache before
 					 * turning readahead off */
@@ -972,6 +976,33 @@ unsigned long page_cache_readahead(struc
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
+void readahead_close(struct file *file);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			pgoff_t first_index, pgoff_t index, pgoff_t last_index);
+void readahead_cache_hit(struct file_ra_state *ra, struct page *page);
+
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+extern int readahead_ratio;
+#else
+#define readahead_ratio 1
+#endif /* CONFIG_ADAPTIVE_READAHEAD */
+
+static inline int prefer_adaptive_readahead(void)
+{
+	return readahead_ratio >= 10;
+}
+
+DECLARE_PER_CPU(unsigned long, readahead_aging);
+static inline void inc_readahead_aging(void)
+{
+#ifdef CONFIG_READAHEAD_SMOOTH_AGING
+	if (prefer_adaptive_readahead())
+		per_cpu(readahead_aging, raw_smp_processor_id())++;
+#endif
+}
 
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
--- linux-2.6.17-rc5.orig/include/linux/mmzone.h
+++ linux-2.6.17-rc5/include/linux/mmzone.h
@@ -162,6 +162,11 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* The accumulated number of activities that may cause page aging,
+	 * that is, make some pages closer to the tail of inactive_list.
+	 */
+	unsigned long 		aging_total;
+
 	/* A count of how many reclaimers are scanning this zone */
 	atomic_t		reclaim_in_progress;
 
@@ -328,6 +333,7 @@ void __get_zone_counts(unsigned long *ac
 			unsigned long *free, struct pglist_data *pgdat);
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free);
+unsigned long nr_free_inactive_pages_node(int nid);
 void build_all_zonelists(void);
 void wakeup_kswapd(struct zone *zone, int order);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
--- linux-2.6.17-rc5.orig/include/linux/page-flags.h
+++ linux-2.6.17-rc5/include/linux/page-flags.h
@@ -89,6 +89,7 @@
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
 #define PG_uncached		20	/* Page has been mapped as uncached */
+#define PG_readahead		21	/* Reminder to do readahead */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -360,6 +361,10 @@ extern void __mod_page_state_offset(unsi
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
--- linux-2.6.17-rc5.orig/include/linux/pagemap.h
+++ linux-2.6.17-rc5/include/linux/pagemap.h
@@ -68,6 +68,8 @@ static inline struct page *page_cache_al
 
 typedef int filler_t(void *, struct page *);
 
+extern int __probe_page(struct address_space *mapping, pgoff_t offset);
+extern int probe_page(struct address_space *mapping, pgoff_t offset);
 extern struct page * find_get_page(struct address_space *mapping,
 				unsigned long index);
 extern struct page * find_lock_page(struct address_space *mapping,
--- linux-2.6.17-rc5.orig/include/linux/radix-tree.h
+++ linux-2.6.17-rc5/include/linux/radix-tree.h
@@ -54,6 +54,10 @@ void *radix_tree_delete(struct radix_tre
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
+unsigned long radix_tree_scan_hole_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
+unsigned long radix_tree_scan_hole(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
 int radix_tree_preload(gfp_t gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
--- linux-2.6.17-rc5.orig/include/linux/sysctl.h
+++ linux-2.6.17-rc5/include/linux/sysctl.h
@@ -186,6 +186,8 @@ enum
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
+	VM_READAHEAD_RATIO=33,	/* percent of read-ahead size to thrashing-threshold */
+	VM_READAHEAD_HIT_RATE=34, /* one accessed page legitimizes so many read-ahead pages */
 };
 
 
--- linux-2.6.17-rc5.orig/include/linux/writeback.h
+++ linux-2.6.17-rc5/include/linux/writeback.h
@@ -85,6 +85,12 @@ void laptop_io_completion(void);
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
--- linux-2.6.17-rc5.orig/kernel/sysctl.c
+++ linux-2.6.17-rc5/kernel/sysctl.c
@@ -73,6 +73,12 @@ extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
 
+#if defined(CONFIG_ADAPTIVE_READAHEAD)
+extern int readahead_ratio;
+extern int readahead_hit_rate;
+static int one = 1;
+#endif
+
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
@@ -915,6 +921,28 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+#ifdef CONFIG_ADAPTIVE_READAHEAD
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
+	{
+		.ctl_name	= VM_READAHEAD_HIT_RATE,
+		.procname	= "readahead_hit_rate",
+		.data		= &readahead_hit_rate,
+		.maxlen		= sizeof(readahead_hit_rate),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &one,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
--- linux-2.6.17-rc5.orig/lib/radix-tree.c
+++ linux-2.6.17-rc5/lib/radix-tree.c
@@ -504,6 +504,77 @@ int radix_tree_tag_get(struct radix_tree
 EXPORT_SYMBOL(radix_tree_tag_get);
 #endif
 
+static unsigned long radix_tree_scan_hole_dumb(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	unsigned long i;
+
+	for (i = 0; i < max_scan; i++) {
+		if (!radix_tree_lookup(root, index + i))
+			break;
+		if (index + i == ULONG_MAX)
+			break;
+	}
+
+	return index + i;
+}
+
+static unsigned long radix_tree_scan_hole_backward_dumb(
+				struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	unsigned long i;
+
+	for (i = 0; i < max_scan; i++) {
+		if (!radix_tree_lookup(root, index - i))
+			break;
+		if (index - i == 0)
+			break;
+	}
+
+	return index - i;
+}
+
+/**
+ *	radix_tree_scan_hole    -    scan for hole
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      advice on max items to scan (it may scan a little more)
+ *
+ *      Scan forward from @index for a hole/empty item, stop when
+ *      - hit hole
+ *      - hit index ULONG_MAX
+ *      - @max_scan or more items scanned
+ *
+ *      One can be sure that (@returned_index >= @index).
+ */
+unsigned long radix_tree_scan_hole(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	return radix_tree_scan_hole_dumb(root, index, max_scan);
+}
+EXPORT_SYMBOL(radix_tree_scan_hole);
+
+/**
+ *	radix_tree_scan_hole_backward    -    scan backward for hole
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      advice on max items to scan (it may scan a little more)
+ *
+ *      Scan backward from @index for a hole/empty item, stop when
+ *      - hit hole
+ *      - hit index 0
+ *      - @max_scan or more items scanned
+ *
+ *      One can be sure that (@returned_index <= @index).
+ */
+unsigned long radix_tree_scan_hole_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	return radix_tree_scan_hole_backward_dumb(root, index, max_scan);
+}
+EXPORT_SYMBOL(radix_tree_scan_hole_backward);
+
 static unsigned int
 __lookup(struct radix_tree_root *root, void **results, unsigned long index,
 	unsigned int max_items, unsigned long *next_index)
--- linux-2.6.17-rc5.orig/mm/Kconfig
+++ linux-2.6.17-rc5/mm/Kconfig
@@ -145,3 +145,65 @@ config MIGRATION
 	  while the virtual addresses are not changed. This is useful for
 	  example on NUMA systems to put pages nearer to the processors accessing
 	  the page.
+
+#
+# Adaptive file readahead
+#
+config ADAPTIVE_READAHEAD
+	bool "Adaptive file readahead (EXPERIMENTAL)"
+	default y
+	depends on EXPERIMENTAL
+	help
+	  Readahead is a technique employed by the kernel in an attempt
+	  to improve file reading performance. If the kernel has reason
+	  to believe that a particular file is being read sequentially,
+	  it will attempt to read blocks from the file into memory before
+	  the application requests them. When readahead works, it speeds
+	  up the system's throughput, since the reading application does
+	  not have to wait for its requests. When readahead fails, instead,
+	  it generates useless I/O and occupies memory pages which are
+	  needed for some other purpose.
+
+	  The kernel already has a stock readahead logic that is well
+	  understood and well tuned. This option enables a more complex and
+	  feature rich one. It tries to be smart and memory efficient.
+	  However, due to the great diversity of real world applications, it
+	  might not fit everyone.
+
+	  Please refer to Documentation/sysctl/vm.txt for tunable parameters.
+
+	  It is known to work well for many desktops, file servers and
+	  postgresql databases. Say Y to try it out for yourself.
+
+config DEBUG_READAHEAD
+	bool "Readahead debug and accounting"
+	default y
+	depends on ADAPTIVE_READAHEAD
+	select DEBUG_FS
+	help
+	  This option injects extra code to dump detailed debug traces and do
+	  readahead events accounting.
+
+	  To actually get the data:
+
+	  mkdir /debug
+	  mount -t debug none /debug
+
+	  After that you can do the following:
+
+	  echo > /debug/readahead/events # reset the counters
+	  cat /debug/readahead/events    # check the counters
+
+	  echo 1 > /debug/readahead/debug_level # start events accounting
+	  echo 0 > /debug/readahead/debug_level # pause events accounting
+
+	  echo 2 > /debug/readahead/debug_level # show printk traces
+	  echo 3 > /debug/readahead/debug_level # show printk traces(verbose)
+	  echo 1 > /debug/readahead/debug_level # stop filling my kern.log
+
+	  Say N for production servers.
+
+config READAHEAD_SMOOTH_AGING
+	def_bool n if NUMA
+	default y if !NUMA
+	depends on ADAPTIVE_READAHEAD
--- linux-2.6.17-rc5.orig/mm/filemap.c
+++ linux-2.6.17-rc5/mm/filemap.c
@@ -45,6 +45,12 @@ static ssize_t
 generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 	loff_t offset, unsigned long nr_segs);
 
+#ifdef CONFIG_DEBUG_READAHEAD
+extern u32 debug_level;
+#else
+#define debug_level 0
+#endif /* CONFIG_DEBUG_READAHEAD */
+
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
  * though.
@@ -545,6 +551,28 @@ void fastcall __lock_page(struct page *p
 EXPORT_SYMBOL(__lock_page);
 
 /*
+ * Probing page existence.
+ */
+int __probe_page(struct address_space *mapping, pgoff_t offset)
+{
+	return !! radix_tree_lookup(&mapping->page_tree, offset);
+}
+
+/*
+ * Here we just do not bother to grab the page, it's meaningless anyway.
+ */
+int probe_page(struct address_space *mapping, pgoff_t offset)
+{
+	int exists;
+
+	read_lock_irq(&mapping->tree_lock);
+	exists = __probe_page(mapping, offset);
+	read_unlock_irq(&mapping->tree_lock);
+
+	return exists;
+}
+
+/*
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */
@@ -809,10 +837,12 @@ void do_generic_mapping_read(struct addr
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
@@ -823,6 +853,10 @@ void do_generic_mapping_read(struct addr
 	if (!isize)
 		goto out;
 
+	if (debug_level >= 5)
+		printk(KERN_DEBUG "read-file(ino=%lu, req=%lu+%lu)\n",
+			inode->i_ino, index, last_index - index);
+
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 	for (;;) {
 		struct page *page;
@@ -841,16 +875,47 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index)
+
+		if (!prefer_adaptive_readahead() && index == next_index)
 			next_index = page_cache_readahead(mapping, &ra, filp,
 					index, last_index - index);
 
 find_page:
 		page = find_get_page(mapping, index);
+		if (prefer_adaptive_readahead()) {
+			if (unlikely(page == NULL)) {
+				ra.prev_page = prev_index;
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, NULL,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+				page = find_get_page(mapping, index);
+			} else if (PageReadahead(page)) {
+				ra.prev_page = prev_index;
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, page,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+			}
+		}
 		if (unlikely(page == NULL)) {
-			handle_ra_miss(mapping, &ra, index);
+			if (!prefer_adaptive_readahead())
+				handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
+
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
+
+		if (prefer_adaptive_readahead())
+			readahead_cache_hit(&ra, page);
+
+		if (debug_level >= 7)
+			printk(KERN_DEBUG "read-page(ino=%lu, idx=%lu, io=%s)\n",
+				inode->i_ino, index,
+				PageUptodate(page) ? "hit" : "miss");
+
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -885,7 +950,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -897,7 +961,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -927,7 +990,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -948,7 +1010,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -957,7 +1018,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -967,7 +1027,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -992,15 +1051,22 @@ no_cached_page:
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
+	if (prefer_adaptive_readahead())
+		_ra->prev_page = prev_index;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }
@@ -1279,6 +1345,7 @@ struct page *filemap_nopage(struct vm_ar
 	unsigned long size, pgoff;
 	int did_readaround = 0, majmin = VM_FAULT_MINOR;
 
+	ra->flags |= RA_FLAG_MMAP;
 	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
 retry_all:
@@ -1296,7 +1363,7 @@ retry_all:
 	 *
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
-	if (VM_SequentialReadHint(area))
+	if (!prefer_adaptive_readahead() && VM_SequentialReadHint(area))
 		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
 	/*
@@ -1304,11 +1371,24 @@ retry_all:
 	 */
 retry_find:
 	page = find_get_page(mapping, pgoff);
+	if (prefer_adaptive_readahead() && VM_SequentialReadHint(area)) {
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
+			if (!prefer_adaptive_readahead())
+				handle_ra_miss(mapping, ra, pgoff);
 			goto no_cached_page;
 		}
 		ra->mmap_miss++;
@@ -1345,6 +1425,16 @@ retry_find:
 	if (!did_readaround)
 		ra->mmap_hit++;
 
+	if (prefer_adaptive_readahead())
+		readahead_cache_hit(ra, page);
+
+	if (debug_level >= 6)
+		printk(KERN_DEBUG "read-mmap(ino=%lu, idx=%lu, hint=%s, io=%s)\n",
+			inode->i_ino, pgoff,
+			VM_RandomReadHint(area) ? "random" :
+			(VM_SequentialReadHint(area) ? "sequential" : "none"),
+			PageUptodate(page) ? "hit" : "miss");
+
 	/*
 	 * Ok, found a page in the page cache, now we need to check
 	 * that it's up-to-date.
@@ -1359,6 +1449,8 @@ success:
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
+	if (prefer_adaptive_readahead())
+		ra->prev_page = page->index;
 	return page;
 
 outside_data_content:
--- linux-2.6.17-rc5.orig/mm/page-writeback.c
+++ linux-2.6.17-rc5/mm/page-writeback.c
@@ -376,7 +376,7 @@ static void wb_timer_fn(unsigned long un
 static void laptop_timer_fn(unsigned long unused);
 
 static DEFINE_TIMER(wb_timer, wb_timer_fn, 0, 0);
-static DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
+DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
 
 /*
  * Periodic writeback of "old" data.
--- linux-2.6.17-rc5.orig/mm/page_alloc.c
+++ linux-2.6.17-rc5/mm/page_alloc.c
@@ -543,7 +543,7 @@ static int prep_new_page(struct page *pa
 	if (PageReserved(page))
 		return 1;
 
-	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_readahead |
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
@@ -1361,6 +1361,22 @@ void get_zone_counts(unsigned long *acti
 	}
 }
 
+/*
+ * The node's effective length of inactive_list(s).
+ */
+unsigned long nr_free_inactive_pages_node(int nid)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(nid)->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_inactive +
+			zones[i].free_pages - zones[i].pages_low;
+
+	return sum;
+}
+
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
--- linux-2.6.17-rc5.orig/mm/readahead.c
+++ linux-2.6.17-rc5/mm/readahead.c
@@ -5,6 +5,8 @@
  *
  * 09Apr2002	akpm@zip.com.au
  *		Initial version.
+ * 26May2006	Wu Fengguang <wfg@mail.ustc.edu.cn>
+ *		Adaptive read-ahead framework.
  */
 
 #include <linux/kernel.h>
@@ -14,6 +16,110 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/writeback.h>
+#include <asm/div64.h>
+
+/*
+ * Convienent macros for min/max read-ahead pages.
+ * Note that MAX_RA_PAGES is rounded down, while MIN_RA_PAGES is rounded up.
+ * The latter is necessary for systems with large page size(i.e. 64k).
+ */
+#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
+#define MAX_RA_PAGES	(VM_MAX_READAHEAD*1024 / PAGE_CACHE_SIZE)
+#define MIN_RA_PAGES	DIV_ROUND_UP(VM_MIN_READAHEAD*1024, PAGE_CACHE_SIZE)
+
+/*
+ * Adaptive read-ahead parameters.
+ */
+
+/* Default max read-ahead size for the initial method.  */
+#define INITIAL_RA_PAGES  DIV_ROUND_UP(128*1024, PAGE_CACHE_SIZE)
+
+/* In laptop mode, poll delayed look-ahead on every ## pages read. */
+#define LAPTOP_POLL_INTERVAL 16
+
+/* Set look-ahead size to 1/# of the thrashing-threshold. */
+#define LOOKAHEAD_RATIO 8
+
+/* Set read-ahead size to ##% of the thrashing-threshold. */
+int readahead_ratio = 50;
+EXPORT_SYMBOL_GPL(readahead_ratio);
+
+/* Readahead as long as cache hit ratio keeps above 1/##. */
+int readahead_hit_rate = 1;
+
+/*
+ * Measures the aging process of inactive_list.
+ * Mainly increased on fresh page references to make it smooth.
+ */
+#ifdef CONFIG_READAHEAD_SMOOTH_AGING
+DEFINE_PER_CPU(unsigned long, readahead_aging);
+#endif
+
+/*
+ * Detailed classification of read-ahead behaviors.
+ */
+#define RA_CLASS_SHIFT 4
+#define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
+enum ra_class {
+	RA_CLASS_ALL,
+	RA_CLASS_INITIAL,
+	RA_CLASS_STATE,
+	RA_CLASS_CONTEXT,
+	RA_CLASS_CONTEXT_AGGRESSIVE,
+	RA_CLASS_BACKWARD,
+	RA_CLASS_THRASHING,
+	RA_CLASS_SEEK,
+	RA_CLASS_NONE,
+	RA_CLASS_COUNT
+};
+
+#define DEBUG_READAHEAD_RADIXTREE
+
+/* Read-ahead events to be accounted. */
+enum ra_event {
+	RA_EVENT_CACHE_MISS,		/* read cache misses */
+	RA_EVENT_RANDOM_READ,		/* random reads */
+	RA_EVENT_IO_CONGESTION,		/* i/o congestion */
+	RA_EVENT_IO_CACHE_HIT,		/* canceled i/o due to cache hit */
+	RA_EVENT_IO_BLOCK,		/* wait for i/o completion */
+
+	RA_EVENT_READAHEAD,		/* read-ahead issued */
+	RA_EVENT_READAHEAD_HIT,		/* read-ahead page hit */
+	RA_EVENT_LOOKAHEAD,		/* look-ahead issued */
+	RA_EVENT_LOOKAHEAD_HIT,		/* look-ahead mark hit */
+	RA_EVENT_LOOKAHEAD_NOACTION,	/* look-ahead mark ignored */
+	RA_EVENT_READAHEAD_MMAP,	/* read-ahead for mmap access */
+	RA_EVENT_READAHEAD_EOF,		/* read-ahead reaches EOF */
+	RA_EVENT_READAHEAD_SHRINK,	/* ra_size falls under previous la_size */
+	RA_EVENT_READAHEAD_THRASHING,	/* read-ahead thrashing happened */
+	RA_EVENT_READAHEAD_MUTILATE,	/* read-ahead mutilated by imbalanced aging */
+	RA_EVENT_READAHEAD_RESCUE,	/* read-ahead rescued */
+
+	RA_EVENT_READAHEAD_CUBE,
+	RA_EVENT_COUNT
+};
+
+#ifdef CONFIG_DEBUG_READAHEAD
+u32 initial_ra_hit;
+u32 initial_ra_miss;
+u32 debug_level = 1;
+u32 disable_stateful_method = 0;
+static const char * const ra_class_name[];
+static void ra_account(struct file_ra_state *ra, enum ra_event e, int pages);
+#  define debug_inc(var)		do { var++; } while (0)
+#  define debug_option(o)		(o)
+#else
+#  define ra_account(ra, e, pages)	do { } while (0)
+#  define debug_inc(var)		do { } while (0)
+#  define debug_option(o)		(0)
+#  define debug_level 			(0)
+#endif /* CONFIG_DEBUG_READAHEAD */
+
+#define dprintk(args...) \
+	do { if (debug_level >= 2) printk(KERN_DEBUG args); } while(0)
+#define ddprintk(args...) \
+	do { if (debug_level >= 3) printk(KERN_DEBUG args); } while(0)
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -21,7 +127,10 @@ void default_unplug_io_fn(struct backing
 EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
-	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.ra_pages	= MAX_RA_PAGES,
+	.ra_pages0	= INITIAL_RA_PAGES,
+	.ra_expect_bytes = INITIAL_RA_PAGES*PAGE_CACHE_SIZE,
+	.ra_thrash_bytes = INITIAL_RA_PAGES*PAGE_CACHE_SIZE,
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
@@ -49,7 +158,7 @@ static inline unsigned long get_max_read
 
 static inline unsigned long get_min_readahead(struct file_ra_state *ra)
 {
-	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	return MIN_RA_PAGES;
 }
 
 static inline void reset_ahead_window(struct file_ra_state *ra)
@@ -145,8 +254,10 @@ int read_cache_pages(struct address_spac
 			continue;
 		}
 		ret = filler(data, page);
-		if (!pagevec_add(&lru_pvec, page))
+		if (!pagevec_add(&lru_pvec, page)) {
+			cond_resched();
 			__pagevec_lru_add(&lru_pvec);
+		}
 		if (ret) {
 			while (!list_empty(pages)) {
 				struct page *victim;
@@ -184,8 +295,10 @@ static int read_pages(struct address_spa
 					page->index, GFP_KERNEL)) {
 			ret = mapping->a_ops->readpage(filp, page);
 			if (ret != AOP_TRUNCATED_PAGE) {
-				if (!pagevec_add(&lru_pvec, page))
+				if (!pagevec_add(&lru_pvec, page)) {
+					cond_resched();
 					__pagevec_lru_add(&lru_pvec);
+				}
 				continue;
 			} /* else fall through to release */
 		}
@@ -268,7 +381,8 @@ out:
  */
 static int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			pgoff_t offset, unsigned long nr_to_read)
+			pgoff_t offset, unsigned long nr_to_read,
+			unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
 	struct page *page;
@@ -281,7 +395,7 @@ __do_page_cache_readahead(struct address
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -298,12 +412,15 @@ __do_page_cache_readahead(struct address
 			continue;
 
 		read_unlock_irq(&mapping->tree_lock);
+		cond_resched();
 		page = page_cache_alloc_cold(mapping);
 		read_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
+		if (page_idx == nr_to_read - lookahead_size)
+			SetPageReadahead(page);
 		ret++;
 	}
 	read_unlock_irq(&mapping->tree_lock);
@@ -340,7 +457,7 @@ int force_page_cache_readahead(struct ad
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+						offset, this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -349,6 +466,9 @@ int force_page_cache_readahead(struct ad
 		offset += this_chunk;
 		nr_to_read -= this_chunk;
 	}
+
+	ra_account(NULL, RA_EVENT_READAHEAD, ret);
+
 	return ret;
 }
 
@@ -384,10 +504,16 @@ static inline int check_ra_success(struc
 int do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			pgoff_t offset, unsigned long nr_to_read)
 {
+	unsigned long ret;
+
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	ret = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	ra_account(NULL, RA_EVENT_READAHEAD, ret);
+
+	return ret;
 }
 
 /*
@@ -407,7 +533,11 @@ blockable_page_cache_readahead(struct ad
 	if (!block && bdi_read_congested(mapping->backing_dev_info))
 		return 0;
 
-	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	ra_account(NULL, RA_EVENT_READAHEAD, actual);
+	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
 
 	return check_ra_success(ra, nr_to_read, actual);
 }
@@ -452,7 +582,7 @@ static int make_ahead_window(struct addr
  * @req_size: hint: total size of the read which the caller is performing in
  *            PAGE_CACHE_SIZE units
  *
- * page_cache_readahead() is the main function.  If performs the adaptive
+ * page_cache_readahead() is the main function.  It performs the adaptive
  * readahead window size management and submits the readahead I/O.
  *
  * Note that @filp is purely used for passing on to the ->readpage[s]()
@@ -587,3 +717,1464 @@ unsigned long max_sane_readahead(unsigne
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
+
+/*
+ * Adaptive read-ahead.
+ *
+ * Good read patterns are compact both in space and time. The read-ahead logic
+ * tries to grant larger read-ahead size to better readers under the constraint
+ * of system memory and load pressure.
+ *
+ * It employs two methods to estimate the max thrashing safe read-ahead size:
+ *   1. state based   - the default one
+ *   2. context based - the failsafe one
+ * The integration of the dual methods has the merit of being agile and robust.
+ * It makes the overall design clean: special cases are handled in general by
+ * the stateless method, leaving the stateful one simple and fast.
+ *
+ * To improve throughput and decrease read delay, the logic 'looks ahead'.
+ * In most read-ahead chunks, one page will be selected and tagged with
+ * PG_readahead. Later when the page with PG_readahead is read, the logic
+ * will be notified to submit the next read-ahead chunk in advance.
+ *
+ *                 a read-ahead chunk
+ *    +-----------------------------------------+
+ *    |       # PG_readahead                    |
+ *    +-----------------------------------------+
+ *            ^ When this page is read, notify me for the next read-ahead.
+ *
+ */
+
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+
+/*
+ * Move pages in danger (of thrashing) to the head of inactive_list.
+ * Not expected to happen frequently.
+ */
+static unsigned long rescue_pages(struct page *page, unsigned long nr_pages)
+{
+	int pgrescue = 0;
+	pgoff_t index = page_index(page);
+	struct address_space *mapping = page_mapping(page);
+	struct page *grabbed_page = NULL;
+	struct zone *zone;
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
+			page = list_entry((page)->lru.prev, struct page, lru);
+			if (!PageActive(the_page) &&
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
+		cond_resched();
+
+		if (grabbed_page)
+			page_cache_release(grabbed_page);
+		grabbed_page = page = find_get_page(mapping, index);
+		if (!page)
+			goto out;
+	}
+
+out_unlock:
+	spin_unlock_irq(&zone->lru_lock);
+out:
+	if (grabbed_page)
+		page_cache_release(grabbed_page);
+	ra_account(NULL, RA_EVENT_READAHEAD_RESCUE, pgrescue);
+	return nr_pages;
+}
+
+/*
+ * Set a new look-ahead mark at @new_index.
+ * Return 0 if the new mark is successfully set.
+ */
+static int renew_lookahead(struct address_space *mapping,
+				struct file_ra_state *ra,
+				pgoff_t index, pgoff_t new_index)
+{
+	struct page *page;
+
+	if (index == ra->lookahead_index &&
+			new_index >= ra->readahead_index)
+		return 1;
+
+	page = radix_tree_lookup(&mapping->page_tree, new_index);
+	if (!page)
+		return 1;
+
+	SetPageReadahead(page);
+	if (ra->lookahead_index == index)
+		ra->lookahead_index = new_index;
+
+	return 0;
+}
+
+/*
+ * Update `backing_dev_info.ra_thrash_bytes' to be a _biased_ average of
+ * read-ahead sizes. Which makes it an a-bit-risky(*) estimation of the
+ * _minimal_ read-ahead thrashing threshold on the device.
+ *
+ * (*) Note that being a bit risky can _help_ overall performance.
+ */
+static inline void update_ra_thrash_bytes(struct backing_dev_info *bdi,
+						unsigned long ra_size)
+{
+	ra_size <<= PAGE_CACHE_SHIFT;
+	bdi->ra_thrash_bytes = (bdi->ra_thrash_bytes < ra_size) ?
+				(ra_size + bdi->ra_thrash_bytes * 1023) / 1024:
+				(ra_size + bdi->ra_thrash_bytes *    7) /    8;
+}
+
+/*
+ * The node's accumulated aging activities.
+ */
+static unsigned long node_readahead_aging(void)
+{
+       unsigned long sum = 0;
+
+#ifdef CONFIG_READAHEAD_SMOOTH_AGING
+       unsigned long cpu;
+       cpumask_t mask = node_to_cpumask(numa_node_id());
+
+       for_each_cpu_mask(cpu, mask)
+	       sum += per_cpu(readahead_aging, cpu);
+#else
+       unsigned int i;
+       struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+       for (i = 0; i < MAX_NR_ZONES; i++)
+	       sum += zones[i].aging_total;
+#endif
+
+       return sum;
+}
+
+/*
+ * Some helpers for querying/building a read-ahead request.
+ *
+ * Diagram for some variable names used frequently:
+ *
+ *                                   |<------- la_size ------>|
+ *                  +-----------------------------------------+
+ *                  |                #                        |
+ *                  +-----------------------------------------+
+ *      ra_index -->|<---------------- ra_size -------------->|
+ *
+ */
+
+static enum ra_class ra_class_new(struct file_ra_state *ra)
+{
+	return ra->flags & RA_CLASS_MASK;
+}
+
+static inline enum ra_class ra_class_old(struct file_ra_state *ra)
+{
+	return (ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK;
+}
+
+static unsigned long ra_readahead_size(struct file_ra_state *ra)
+{
+	return ra->readahead_index - ra->ra_index;
+}
+
+static unsigned long ra_lookahead_size(struct file_ra_state *ra)
+{
+	return ra->readahead_index - ra->lookahead_index;
+}
+
+static unsigned long ra_invoke_interval(struct file_ra_state *ra)
+{
+	return ra->lookahead_index - ra->la_index;
+}
+
+/*
+ * The read-ahead is deemed success if cache-hit-rate >= 1/readahead_hit_rate.
+ */
+static int ra_cache_hit_ok(struct file_ra_state *ra)
+{
+	return ra->hit0 * readahead_hit_rate >=
+					(ra->lookahead_index - ra->la_index);
+}
+
+/*
+ * Check if @index falls in the @ra request.
+ */
+static int ra_has_index(struct file_ra_state *ra, pgoff_t index)
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
+ * Which method is issuing this read-ahead?
+ */
+static void ra_set_class(struct file_ra_state *ra,
+				enum ra_class ra_class)
+{
+	unsigned long flags_mask;
+	unsigned long flags;
+	unsigned long old_ra_class;
+
+	flags_mask = ~(RA_CLASS_MASK | (RA_CLASS_MASK << RA_CLASS_SHIFT));
+	flags = ra->flags & flags_mask;
+
+	old_ra_class = ra_class_new(ra) << RA_CLASS_SHIFT;
+
+	ra->flags = flags | old_ra_class | ra_class;
+
+	/*
+	 * Add request-hit up to sequence-hit and reset the former.
+	 */
+	ra->hit1 += ra->hit0;
+	ra->hit0 = 0;
+
+	/*
+	 * Manage the read-ahead sequences' hit counts.
+	 * 	- the stateful method continues any existing sequence;
+	 * 	- all other methods starts a new one.
+	 */
+	if (ra_class != RA_CLASS_STATE) {
+		ra->hit3 = ra->hit2;
+		ra->hit2 = ra->hit1;
+		ra->hit1 = 0;
+	}
+}
+
+/*
+ * Where is the old read-ahead and look-ahead?
+ */
+static void ra_set_index(struct file_ra_state *ra,
+				pgoff_t la_index, pgoff_t ra_index)
+{
+	ra->la_index = la_index;
+	ra->ra_index = ra_index;
+}
+
+/*
+ * Where is the new read-ahead and look-ahead?
+ */
+static void ra_set_size(struct file_ra_state *ra,
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
+	unsigned long ra_size;
+	unsigned long la_size;
+	pgoff_t eof_index;
+	int actual;
+
+	eof_index = /* it's a past-the-end index! */
+		DIV_ROUND_UP(i_size_read(mapping->host), PAGE_CACHE_SIZE);
+
+	if (unlikely(ra->ra_index >= eof_index))
+		return 0;
+
+	/*
+	 * Snap to EOF, if the request
+	 * 	- crossed the EOF boundary;
+	 * 	- is close to EOF(explained below).
+	 *
+	 * Imagine a file sized 18 pages, and we dicided to read-ahead the
+	 * first 16 pages. It is highly possible that in the near future we
+	 * will have to do another read-ahead for the remaining 2 pages,
+	 * which is an unfavorable small I/O.
+	 *
+	 * So we prefer to take a bit risk to enlarge the current read-ahead,
+	 * to eliminate possible future small I/O.
+	 */
+	if (ra->readahead_index + ra_readahead_size(ra)/4 > eof_index) {
+		ra->readahead_index = eof_index;
+		if (ra->lookahead_index > eof_index)
+			ra->lookahead_index = eof_index;
+		if (eof_index > 1)
+			ra->flags |= RA_FLAG_EOF;
+	}
+
+	/* Disable look-ahead for loopback file. */
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		ra->lookahead_index = ra->readahead_index;
+
+	/* Take down the current read-ahead aging value. */
+	ra->age = node_readahead_aging();
+
+	ra_size = ra_readahead_size(ra);
+	la_size = ra_lookahead_size(ra);
+	actual = __do_page_cache_readahead(mapping, filp,
+					ra->ra_index, ra_size, la_size);
+
+#ifdef CONFIG_DEBUG_READAHEAD
+	if (ra->flags & RA_FLAG_MMAP)
+		ra_account(ra, RA_EVENT_READAHEAD_MMAP, actual);
+	if (ra->readahead_index == eof_index)
+		ra_account(ra, RA_EVENT_READAHEAD_EOF, actual);
+	if (la_size)
+		ra_account(ra, RA_EVENT_LOOKAHEAD, la_size);
+	if (ra_size > actual)
+		ra_account(ra, RA_EVENT_IO_CACHE_HIT, ra_size - actual);
+	ra_account(ra, RA_EVENT_READAHEAD, actual);
+
+	if (!ra->ra_index && filp->f_dentry->d_inode) {
+		char *fn;
+		static char path[1024];
+		unsigned long size;
+
+		size = (i_size_read(filp->f_dentry->d_inode)+1023)/1024;
+		fn = d_path(filp->f_dentry, filp->f_vfsmnt, path, 1000);
+		if (!IS_ERR(fn))
+			ddprintk("ino %lu is %s size %luK by %s(%d)\n",
+					filp->f_dentry->d_inode->i_ino,
+					fn, size,
+					current->comm, current->pid);
+	}
+
+	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
+			ra_class_name[ra_class_new(ra)],
+			mapping->host->i_ino, ra->la_index,
+			ra->ra_index, ra_size, la_size, actual);
+#endif /* CONFIG_DEBUG_READAHEAD */
+
+	return actual;
+}
+
+/*
+ * Deduce the read-ahead/look-ahead size from primitive values.
+ *
+ * Input:
+ *	- @ra_size stores the estimated thrashing-threshold.
+ *	- @la_size stores the look-ahead size of previous request.
+ */
+static int adjust_rala(unsigned long ra_max,
+			unsigned long *ra_size, unsigned long *la_size)
+{
+	/*
+	 * Substract the old look-ahead to get real safe size for the next
+	 * read-ahead request.
+	 */
+	if (*ra_size > *la_size)
+		*ra_size -= *la_size;
+	else {
+		ra_account(NULL, RA_EVENT_READAHEAD_SHRINK, *ra_size);
+		return 0;
+	}
+
+	/*
+	 * Set new la_size according to the (still large) ra_size.
+	 */
+	*la_size = *ra_size / LOOKAHEAD_RATIO;
+
+	return 1;
+}
+
+static void limit_rala(unsigned long ra_max, unsigned long la_old,
+			unsigned long *ra_size, unsigned long *la_size)
+{
+	unsigned long stream_shift;
+
+	/*
+	 * Apply basic upper limits.
+	 */
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
+	/*
+	 * Make sure stream_shift is not too small.
+	 * (So that the next global_shift will not be too small.)
+	 */
+	stream_shift = la_old + (*ra_size - *la_size);
+	if (stream_shift < *ra_size / 4)
+		*la_size -= (*ra_size / 4 - stream_shift);
+}
+
+/*
+ * The function estimates two values:
+ * 1. thrashing-threshold for the current stream
+ *    It is returned to make the next read-ahead request.
+ * 2. the remained safe space for the current chunk
+ *    It will be checked to ensure that the current chunk is safe.
+ *
+ * The computation will be pretty accurate under heavy load, and will vibrate
+ * more on light load(with small global_shift), so the grow speed of ra_size
+ * must be limited, and a moderate large stream_shift must be insured.
+ *
+ * This figure illustrates the formula used in the function:
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
+static unsigned long compute_thrashing_threshold(struct file_ra_state *ra,
+							unsigned long *remain)
+{
+	unsigned long global_size;
+	unsigned long global_shift;
+	unsigned long stream_shift;
+	unsigned long ra_size;
+	uint64_t ll;
+
+	global_size = nr_free_inactive_pages_node(numa_node_id());
+	global_shift = node_readahead_aging() - ra->age;
+	global_shift |= 1UL;
+	stream_shift = ra_invoke_interval(ra);
+
+	/* future safe space */
+	ll = (uint64_t) stream_shift * (global_size >> 9) * readahead_ratio * 5;
+	do_div(ll, global_shift);
+	ra_size = ll;
+
+	/* remained safe space */
+	if (global_size > global_shift) {
+		ll = (uint64_t) stream_shift * (global_size - global_shift);
+		do_div(ll, global_shift);
+		*remain = ll;
+	} else
+		*remain = 0;
+
+	ddprintk("compute_thrashing_threshold: "
+			"at %lu ra %lu=%lu*%lu/%lu, remain %lu for %lu\n",
+			ra->readahead_index, ra_size,
+			stream_shift, global_size, global_shift,
+			*remain, ra_lookahead_size(ra));
+
+	return ra_size;
+}
+
+/*
+ * Main function for file_ra_state based read-ahead.
+ */
+static unsigned long
+state_based_readahead(struct address_space *mapping, struct file *filp,
+			struct file_ra_state *ra,
+			struct page *page, pgoff_t index,
+			unsigned long req_size, unsigned long ra_max)
+{
+	unsigned long ra_old, ra_size;
+	unsigned long la_old, la_size;
+	unsigned long remain_space;
+	unsigned long growth_limit;
+
+	la_old = la_size = ra->readahead_index - index;
+	ra_old = ra_readahead_size(ra);
+	ra_size = compute_thrashing_threshold(ra, &remain_space);
+
+	if (page && remain_space <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return 0;
+	}
+
+	growth_limit = req_size;
+	growth_limit += ra_max / 16;
+	growth_limit += (2 + readahead_ratio / 64) * ra_old;
+	if (growth_limit > ra_max)
+		growth_limit = ra_max;
+
+	if (!adjust_rala(growth_limit, &ra_size, &la_size))
+		return 0;
+
+	limit_rala(growth_limit, la_old, &ra_size, &la_size);
+
+	/* ra_size in its _steady_ state reflects thrashing threshold */
+	if (page && ra_old + ra_old / 8 >= ra_size)
+		update_ra_thrash_bytes(mapping->backing_dev_info, ra_size);
+
+	ra_set_class(ra, RA_CLASS_STATE);
+	ra_set_index(ra, index, ra->readahead_index);
+	ra_set_size(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * Page cache context based estimation of read-ahead/look-ahead size/index.
+ *
+ * The logic first looks around to find the start point of next read-ahead,
+ * and then, if necessary, looks backward in the inactive_list to get an
+ * estimation of the thrashing-threshold.
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
+ *			   <= Length(inactive_list) = f(thrashing-threshold)
+ *
+ * So the count of countinuous history pages left in the inactive_list is always
+ * a lower estimation of the true thrashing-threshold.
+ */
+
+#if PG_active < PG_referenced
+#  error unexpected page flags order
+#endif
+
+#define PAGE_REFCNT_0           0
+#define PAGE_REFCNT_1           (1 << PG_referenced)
+#define PAGE_REFCNT_2           (1 << PG_active)
+#define PAGE_REFCNT_3           ((1 << PG_active) | (1 << PG_referenced))
+#define PAGE_REFCNT_MASK        PAGE_REFCNT_3
+
+/*
+ * STATUS   REFERENCE COUNT      TYPE
+ *  __                   0      fresh
+ *  _R       PAGE_REFCNT_1      stale
+ *  A_       PAGE_REFCNT_2      disturbed once
+ *  AR       PAGE_REFCNT_3      disturbed twice
+ *
+ *  A/R: Active / Referenced
+ */
+static inline unsigned long page_refcnt(struct page *page)
+{
+        return page->flags & PAGE_REFCNT_MASK;
+}
+
+/*
+ * Now that revisited pages are put into active_list immediately,
+ * we cannot get an accurate estimation of
+ *
+ * 		len(inactive_list) / speed(leader)
+ *
+ * on the situation of two sequential readers that come close enough:
+ *
+ *        chunk 1         chunk 2               chunk 3
+ *      ==========  =============-------  --------------------
+ *                     follower ^                     leader ^
+ *
+ * In this case, using inactive_page_refcnt() in the context based method yields
+ * conservative read-ahead size, while page_refcnt() yields aggressive size.
+ */
+static inline unsigned long inactive_page_refcnt(struct page *page)
+{
+	if (!page || PageActive(page))
+		return 0;
+
+	return page_refcnt(page);
+}
+
+/*
+ * Find past-the-end index of the segment at @index.
+ *
+ * Segment is defined as a full range of cached pages in a file.
+ * (Whereas a chunk refers to a range of cached pages that are brought in
+ *  by read-ahead in one shot.)
+ */
+static pgoff_t find_segtail(struct address_space *mapping,
+					pgoff_t index, unsigned long max_scan)
+{
+	pgoff_t ra_index;
+
+	cond_resched();
+	read_lock_irq(&mapping->tree_lock);
+	ra_index = radix_tree_scan_hole(&mapping->page_tree, index, max_scan);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	BUG_ON(!__probe_page(mapping, index));
+	WARN_ON(ra_index < index);
+	if (ra_index != index && !__probe_page(mapping, ra_index - 1))
+		printk(KERN_ERR "radix_tree_scan_hole(index=%lu ra_index=%lu "
+				"max_scan=%lu nrpages=%lu) fooled!\n",
+				index, ra_index, max_scan, mapping->nrpages);
+	if (ra_index != ~0UL && ra_index - index < max_scan)
+		WARN_ON(__probe_page(mapping, ra_index));
+#endif
+	read_unlock_irq(&mapping->tree_lock);
+
+	if (ra_index <= index + max_scan)
+		return ra_index;
+	else
+		return 0;
+}
+
+/*
+ * Find past-the-end index of the segment before @index.
+ */
+static pgoff_t find_segtail_backward(struct address_space *mapping,
+					pgoff_t index, unsigned long max_scan)
+{
+	pgoff_t origin = index;
+
+	if (max_scan > index)
+		max_scan = index;
+
+	/*
+	 * Poor man's radix_tree_scan_data_backward() implementation.
+	 * Acceptable because max_scan won't be large.
+	 */
+	read_lock_irq(&mapping->tree_lock);
+	for (; origin - index < max_scan;)
+		if (__probe_page(mapping, --index)) {
+			read_unlock_irq(&mapping->tree_lock);
+			return index + 1;
+		}
+	read_unlock_irq(&mapping->tree_lock);
+
+	return 0;
+}
+
+/*
+ * Count/estimate cache hits in range [first_index, last_index].
+ * The estimation is simple and optimistic.
+ */
+#define CACHE_HIT_HASH_KEY	29	/* some prime number */
+static int count_cache_hit(struct address_space *mapping,
+				pgoff_t first_index, pgoff_t last_index)
+{
+	struct page *page;
+	int size = last_index - first_index + 1;
+	int count = 0;
+	int i;
+
+	/*
+	 * The first page may well is chunk head and has been accessed,
+	 * so it is index 0 that makes the estimation optimistic. This
+	 * behavior guarantees a readahead when (size < ra_max) and
+	 * (readahead_hit_rate >= 16).
+	 */
+	for (i = 0; i < 16;) {
+		page = radix_tree_lookup(&mapping->page_tree, first_index +
+				size * ((i++ * CACHE_HIT_HASH_KEY) & 15) / 16);
+		if (inactive_page_refcnt(page) >= PAGE_REFCNT_1 && ++count >= 2)
+			break;
+	}
+
+	return size * count / i;
+}
+
+/*
+ * Look back and check history pages to estimate thrashing-threshold.
+ */
+static unsigned long query_page_cache_segment(struct address_space *mapping,
+				struct file_ra_state *ra,
+				unsigned long *remain, pgoff_t offset,
+				unsigned long ra_min, unsigned long ra_max)
+{
+	pgoff_t index;
+	unsigned long count;
+	unsigned long nr_lookback;
+
+	/*
+	 * Scan backward and check the near @ra_max pages.
+	 * The count here determines ra_size.
+	 */
+	cond_resched();
+	read_lock_irq(&mapping->tree_lock);
+	index = radix_tree_scan_hole_backward(&mapping->page_tree,
+							offset - 1, ra_max);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	WARN_ON(index > offset - 1);
+	if (index != offset - 1)
+		WARN_ON(!__probe_page(mapping, index + 1));
+	if (index && offset - 1 - index < ra_max)
+		WARN_ON(__probe_page(mapping, index));
+#endif
+
+	*remain = (offset - 1) - index;
+
+	if (offset == ra->readahead_index && ra_cache_hit_ok(ra))
+		count = *remain;
+	else if (count_cache_hit(mapping, index + 1, offset) *
+						readahead_hit_rate >= *remain)
+		count = *remain;
+	else
+		count = ra_min;
+
+	/*
+	 * Unnecessary to count more?
+	 */
+	if (count < ra_max)
+		goto out_unlock;
+
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		goto out_unlock;
+
+	/*
+	 * Check the far pages coarsely.
+	 * The enlarged count here helps increase la_size.
+	 */
+	nr_lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
+						100 / (readahead_ratio | 1);
+
+	for (count += ra_max; count < nr_lookback; count += ra_max)
+		if (!__probe_page(mapping, offset - count))
+			break;
+
+out_unlock:
+	read_unlock_irq(&mapping->tree_lock);
+
+	/*
+	 *  For sequential read that extends from index 0, the counted value
+	 *  may well be far under the true threshold, so return it unmodified
+	 *  for further processing in adjust_rala_aggressive().
+	 */
+	if (count >= offset)
+		count = offset;
+	else
+		count = max(ra_min, count * readahead_ratio / 100);
+
+	ddprintk("query_page_cache_segment: "
+			"ino=%lu, idx=%lu, count=%lu, remain=%lu\n",
+			mapping->host->i_ino, offset, count, *remain);
+
+	return count;
+}
+
+/*
+ * Determine the request parameters for context based read-ahead that extends
+ * from start of file.
+ *
+ * One major weakness of stateless method is the slow scaling up of ra_size.
+ * The logic tries to make up for this in the important case of sequential
+ * reads that extend from start of file. In this case, the ra_size is not
+ * chosen to make the whole next chunk safe (as in normal ones). Only part of
+ * which is safe: the tailing look-ahead part is 'unsafe'. However it will be
+ * safeguarded by rescue_pages() when the previous chunks are lost.
+ */
+static int adjust_rala_aggressive(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	pgoff_t index = *ra_size;
+
+	*ra_size -= min(*ra_size, *la_size);
+	*ra_size = *ra_size * readahead_ratio / 100;
+	*la_size = index * readahead_ratio / 100;
+	*ra_size += *la_size;
+
+	return 1;
+}
+
+/*
+ * Main function for page context based read-ahead.
+ *
+ * RETURN VALUE		HINT
+ *      1		@ra contains a valid ra-request, please submit it
+ *      0		no seq-pattern discovered, please try the next method
+ *     -1		please don't do _any_ readahead
+ */
+static int
+try_context_based_readahead(struct address_space *mapping,
+			struct file_ra_state *ra, struct page *prev_page,
+			struct page *page, pgoff_t index,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	pgoff_t ra_index;
+	unsigned long ra_size;
+	unsigned long la_size;
+	unsigned long remain_pages;
+
+	/* Where to start read-ahead?
+	 * NFSv3 daemons may process adjacent requests in parallel,
+	 * leading to many locally disordered, globally sequential reads.
+	 * So do not require nearby history pages to be present or accessed.
+	 */
+	if (page) {
+		ra_index = find_segtail(mapping, index, ra_max * 5 / 4);
+		if (!ra_index)
+			return -1;
+	} else if (prev_page || probe_page(mapping, index - 1)) {
+		ra_index = index;
+	} else if (readahead_hit_rate > 1) {
+		ra_index = find_segtail_backward(mapping, index,
+						readahead_hit_rate + ra_min);
+		if (!ra_index)
+			return 0;
+		ra_min += 2 * (index - ra_index);
+		index = ra_index;	/* pretend the request starts here */
+	} else
+		return 0;
+
+	ra_size = query_page_cache_segment(mapping, ra, &remain_pages,
+							index, ra_min, ra_max);
+
+	la_size = ra_index - index;
+	if (page && remain_pages <= la_size &&
+			remain_pages < index && la_size > 1) {
+		rescue_pages(page, la_size);
+		return -1;
+	}
+
+	if (ra_size == index) {
+		if (!adjust_rala_aggressive(ra_max, &ra_size, &la_size))
+			return -1;
+		ra_set_class(ra, RA_CLASS_CONTEXT_AGGRESSIVE);
+	} else {
+		if (!adjust_rala(ra_max, &ra_size, &la_size))
+			return -1;
+		ra_set_class(ra, RA_CLASS_CONTEXT);
+	}
+
+	limit_rala(ra_max, ra_index - index, &ra_size, &la_size);
+
+	ra_set_index(ra, index, ra_index);
+	ra_set_size(ra, ra_size, la_size);
+
+	return 1;
+}
+
+/*
+ * Read-ahead on start of file.
+ *
+ * We want to be as aggressive as possible, _and_
+ * 	- do not ruin the hit rate for file-head-peekers
+ * 	- do not lead to thrashing for memory tight systems
+ */
+static unsigned long
+initial_readahead(struct address_space *mapping, struct file *filp,
+		struct file_ra_state *ra, unsigned long req_size)
+{
+	struct backing_dev_info *bdi = mapping->backing_dev_info;
+	unsigned long thrash_pages = bdi->ra_thrash_bytes >> PAGE_CACHE_SHIFT;
+	unsigned long expect_pages = bdi->ra_expect_bytes >> PAGE_CACHE_SHIFT;
+	unsigned long ra_size;
+	unsigned long la_size;
+
+	ra_size = req_size;
+
+	/* be aggressive if the system tends to read more */
+	if (ra_size < expect_pages)
+		ra_size = expect_pages;
+
+	/* no read-ahead thrashing */
+	if (ra_size > thrash_pages)
+		ra_size = thrash_pages;
+
+	/* do look-ahead on large(>= 32KB) read-ahead */
+	la_size = ra_size / LOOKAHEAD_RATIO;
+
+	ra_set_class(ra, RA_CLASS_INITIAL);
+	ra_set_index(ra, 0, 0);
+	ra_set_size(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * Backward prefetching.
+ *
+ * No look-ahead and thrashing safety guard: should be unnecessary.
+ *
+ * Important for certain scientific arenas(i.e. structural analysis).
+ */
+static int
+try_read_backward(struct file_ra_state *ra, pgoff_t begin_index,
+			unsigned long ra_size, unsigned long ra_max)
+{
+	pgoff_t end_index;
+
+	/* Are we reading backward? */
+	if (begin_index > ra->prev_page)
+		return 0;
+
+	if ((ra->flags & RA_CLASS_MASK) == RA_CLASS_BACKWARD &&
+					ra_has_index(ra, ra->prev_page)) {
+		ra_size += 2 * ra->hit0;
+		end_index = ra->la_index;
+	} else {
+		ra_size += ra_size + ra_size * (readahead_hit_rate - 1) / 2;
+		end_index = ra->prev_page;
+	}
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	/* Read traces close enough to be covered by the prefetching? */
+	if (end_index > begin_index + ra_size)
+		return 0;
+
+	begin_index = end_index - ra_size;
+
+	ra_set_class(ra, RA_CLASS_BACKWARD);
+	ra_set_index(ra, begin_index, begin_index);
+	ra_set_size(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
+ * If there is a previous sequential read, it is likely to be another
+ * sequential read at the new position.
+ *
+ * i.e. detect the following sequences:
+ * 	seek(), 5*read(); seek(), 6*read(); seek(), 4*read(); ...
+ *
+ * Databases are known to have this seek-and-read-N-pages pattern.
+ */
+static int
+try_readahead_on_seek(struct file_ra_state *ra, pgoff_t index,
+			unsigned long ra_size, unsigned long ra_max)
+{
+	unsigned long hit0 = ra->hit0;
+	unsigned long hit1 = ra->hit1 + hit0;
+	unsigned long hit2 = ra->hit2;
+	unsigned long hit3 = ra->hit3;
+
+	/* There's a previous read-ahead request? */
+	if (!ra_has_index(ra, ra->prev_page))
+		return 0;
+
+	/* The previous read-ahead sequences have similiar sizes? */
+	if (!(ra_size < hit1 && hit1 > hit2 / 2 &&
+				hit2 > hit3 / 2 &&
+				hit3 > hit1 / 2))
+		return 0;
+
+	hit1 = max(hit1, hit2);
+
+	/* Follow the same prefetching direction. */
+	if ((ra->flags & RA_CLASS_MASK) == RA_CLASS_BACKWARD)
+		index = ((index > hit1 - ra_size) ? index - hit1 + ra_size : 0);
+
+	ra_size = min(hit1, ra_max);
+
+	ra_set_class(ra, RA_CLASS_SEEK);
+	ra_set_index(ra, index, index);
+	ra_set_size(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
+ * Readahead thrashing recovery.
+ */
+static unsigned long
+thrashing_recovery_readahead(struct address_space *mapping,
+				struct file *filp, struct file_ra_state *ra,
+				pgoff_t index, unsigned long ra_max)
+{
+	unsigned long ra_size;
+
+	if (probe_page(mapping, index - 1))
+		ra_account(ra, RA_EVENT_READAHEAD_MUTILATE,
+						ra->readahead_index - index);
+	ra_account(ra, RA_EVENT_READAHEAD_THRASHING,
+						ra->readahead_index - index);
+
+	/*
+	 * Some thrashing occur in (ra_index, la_index], in which case the
+	 * old read-ahead chunk is lost soon after the new one is allocated.
+	 * Ensure that we recover all needed pages in the old chunk.
+	 */
+	if (index < ra->ra_index)
+		ra_size = ra->ra_index - index;
+	else {
+		/* After thrashing, we know the exact thrashing-threshold. */
+		ra_size = ra->hit0;
+		update_ra_thrash_bytes(mapping->backing_dev_info, ra_size);
+
+		/* And we'd better be a bit conservative. */
+		ra_size = ra_size * 3 / 4;
+	}
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	ra_set_class(ra, RA_CLASS_THRASHING);
+	ra_set_index(ra, index, index);
+	ra_set_size(ra, ra_size, ra_size / LOOKAHEAD_RATIO);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * ra_min is mainly determined by the size of cache memory. Reasonable?
+ *
+ * Table of concrete numbers for 4KB page size:
+ *   inactive + free (MB):    4   8   16   32   64  128  256  512 1024
+ *            ra_min (KB):   16  16   16   16   20   24   32   48   64
+ */
+static inline void get_readahead_bounds(struct file_ra_state *ra,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long pages;
+
+	pages = max_sane_readahead((1<<30) / PAGE_CACHE_SIZE);
+	*ra_max = min(min(pages, 0xFFFFUL), ra->ra_pages);
+	*ra_min = min(min(MIN_RA_PAGES + (pages >> 13),
+				(128*1024) / PAGE_CACHE_SIZE), *ra_max / 2);
+}
+
+/**
+ * page_cache_readahead_adaptive - thrashing safe adaptive read-ahead
+ * @mapping, @ra, @filp: the same as page_cache_readahead()
+ * @prev_page: the page at @index-1, may be NULL to let the function find it
+ * @page: the page at @index, or NULL if non-present
+ * @begin_index, @index, @end_index: offsets into @mapping
+ * 		[@begin_index, @end_index) is the read the caller is performing
+ *	 	@index indicates the page to be read now
+ *
+ * page_cache_readahead_adaptive() is the entry point of the adaptive
+ * read-ahead logic. It tries a set of methods in turn to determine the
+ * appropriate readahead action and submits the readahead I/O.
+ *
+ * The caller is expected to point ra->prev_page to the previously accessed
+ * page, and to call it on two conditions:
+ * 1. @page == NULL
+ *    A cache miss happened, some pages have to be read in
+ * 2. @page != NULL && PageReadahead(@page)
+ *    A look-ahead mark encountered, this is set by a previous read-ahead
+ *    invocation to instruct the caller to give the function a chance to
+ *    check up and do next read-ahead in advance.
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			pgoff_t begin_index, pgoff_t index, pgoff_t end_index)
+{
+	unsigned long size;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int ret;
+
+	might_sleep();
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
+			if (!renew_lookahead(mapping, ra, index,
+						index + LAPTOP_POLL_INTERVAL))
+				return 0;
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
+	if (unlikely(!ra_max || !readahead_ratio)) {
+		size = max_sane_readahead(size);
+		goto readit;
+	}
+
+	/*
+	 * Start of file.
+	 */
+	if (index == 0)
+		return initial_readahead(mapping, filp, ra, size);
+
+	/*
+	 * State based sequential read-ahead.
+	 */
+	if (!debug_option(disable_stateful_method) &&
+			index == ra->lookahead_index && ra_cache_hit_ok(ra))
+		return state_based_readahead(mapping, filp, ra, page,
+							index, size, ra_max);
+
+	/*
+	 * Recover from possible thrashing.
+	 */
+	if (!page && index == ra->prev_page + 1 && ra_has_index(ra, index))
+		return thrashing_recovery_readahead(mapping, filp, ra,
+								index, ra_max);
+
+	/*
+	 * Backward read-ahead.
+	 */
+	if (!page && begin_index == index &&
+				try_read_backward(ra, index, size, ra_max))
+		return ra_dispatch(ra, mapping, filp);
+
+	/*
+	 * Context based sequential read-ahead.
+	 */
+	ret = try_context_based_readahead(mapping, ra, prev_page, page,
+							index, ra_min, ra_max);
+	if (ret > 0)
+		return ra_dispatch(ra, mapping, filp);
+	if (ret < 0)
+		return 0;
+
+	/* No action on look ahead time? */
+	if (page) {
+		ra_account(ra, RA_EVENT_LOOKAHEAD_NOACTION,
+						ra->readahead_index - index);
+		return 0;
+	}
+
+	/*
+	 * Random read that follows a sequential one.
+	 */
+	if (try_readahead_on_seek(ra, index, size, ra_max))
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
+	ra_account(ra, RA_EVENT_RANDOM_READ, size);
+	dprintk("random_read(ino=%lu, pages=%lu, index=%lu-%lu-%lu) = %lu\n",
+			mapping->host->i_ino, mapping->nrpages,
+			begin_index, index, end_index, size);
+
+	return size;
+}
+
+/**
+ * readahead_cache_hit - adaptive read-ahead feedback function
+ * @ra: file_ra_state which holds the readahead state
+ * @page: the page just accessed
+ *
+ * readahead_cache_hit() is the feedback route of the adaptive read-ahead
+ * logic. It must be called on every access on the read-ahead pages.
+ */
+void readahead_cache_hit(struct file_ra_state *ra, struct page *page)
+{
+	if (PageActive(page) || PageReferenced(page))
+		return;
+
+	if (!PageUptodate(page))
+		ra_account(ra, RA_EVENT_IO_BLOCK, 1);
+
+	if (!ra_has_index(ra, page->index))
+		return;
+
+	ra->hit0++;
+
+	if (page->index >= ra->ra_index)
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, 1);
+	else
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, -1);
+}
+
+/*
+ * When closing a normal readonly file,
+ * 	- on cache hit:  increase `backing_dev_info.ra_expect_bytes' slowly;
+ * 	- on cache miss: decrease it rapidly.
+ *
+ * The resulted `ra_expect_bytes' answers the question of:
+ * 	How many pages are expected to be read on start-of-file?
+ */
+void readahead_close(struct file *file)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
+	struct backing_dev_info *bdi = mapping->backing_dev_info;
+	unsigned long pos = file->f_pos;	/* supposed to be small */
+	unsigned long pgrahit = file->f_ra.hit0;
+	unsigned long pgcached = mapping->nrpages;
+	unsigned long pgaccess;
+
+	if (!pos)				/* pread */
+		return;
+
+	if (pgcached > bdi->ra_pages0)		/* excessive reads */
+		return;
+
+	pgaccess = max(pgrahit, 1 + pos / PAGE_CACHE_SIZE);
+	if (pgaccess >= pgcached) {
+		if (bdi->ra_expect_bytes < bdi->ra_pages0 * PAGE_CACHE_SIZE)
+			bdi->ra_expect_bytes += pgcached * PAGE_CACHE_SIZE / 8;
+
+		debug_inc(initial_ra_hit);
+		dprintk("initial_ra_hit on file %s size %lluK "
+				"pos %lu by %s(%d)\n",
+				file->f_dentry->d_name.name,
+				i_size_read(inode) / 1024,
+				pos,
+				current->comm, current->pid);
+	} else {
+		unsigned long missed;
+
+		missed = (pgcached - pgaccess) * PAGE_CACHE_SIZE;
+		if (bdi->ra_expect_bytes >= missed / 2)
+			bdi->ra_expect_bytes -= missed / 2;
+
+		debug_inc(initial_ra_miss);
+		dprintk("initial_ra_miss on file %s "
+				"size %lluK cached %luK hit %luK "
+				"pos %lu by %s(%d)\n",
+				file->f_dentry->d_name.name,
+				i_size_read(inode) / 1024,
+				pgcached << (PAGE_CACHE_SHIFT - 10),
+				pgrahit << (PAGE_CACHE_SHIFT - 10),
+				pos,
+				current->comm, current->pid);
+	}
+}
+
+#endif /* CONFIG_ADAPTIVE_READAHEAD */
+
+/*
+ * Read-ahead events accounting.
+ */
+#ifdef CONFIG_DEBUG_READAHEAD
+
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static const char * const ra_class_name[] = {
+	"total",
+	"initial",
+	"state",
+	"context",
+	"contexta",
+	"backward",
+	"onthrash",
+	"onseek",
+	"none"
+};
+
+static const char * const ra_event_name[] = {
+	"cache_miss",
+	"random_read",
+	"io_congestion",
+	"io_cache_hit",
+	"io_block",
+	"readahead",
+	"readahead_hit",
+	"lookahead",
+	"lookahead_hit",
+	"lookahead_ignore",
+	"readahead_mmap",
+	"readahead_eof",
+	"readahead_shrink",
+	"readahead_thrash",
+	"readahead_mutilt",
+	"readahead_rescue"
+};
+
+static unsigned long ra_events[RA_CLASS_COUNT][RA_EVENT_COUNT][2];
+
+static void ra_account(struct file_ra_state *ra, enum ra_event e, int pages)
+{
+	enum ra_class c;
+
+	if (!debug_level)
+		return;
+
+	if (e == RA_EVENT_READAHEAD_HIT && pages < 0) {
+		c = ra_class_old(ra);
+		pages = -pages;
+	} else if (ra)
+		c = ra_class_new(ra);
+	else
+		c = RA_CLASS_NONE;
+
+	if (!c)
+		c = RA_CLASS_NONE;
+
+	ra_events[c][e][0] += 1;
+	ra_events[c][e][1] += pages;
+
+	if (e == RA_EVENT_READAHEAD)
+		ra_events[c][RA_EVENT_READAHEAD_CUBE][1] += pages * pages;
+}
+
+static int ra_events_show(struct seq_file *s, void *_)
+{
+	int i;
+	int c;
+	int e;
+	static const char event_fmt[] = "%-16s";
+	static const char class_fmt[] = "%10s";
+	static const char item_fmt[] = "%10lu";
+	static const char percent_format[] = "%9lu%%";
+	static const char * const table_name[] = {
+		"[table requests]",
+		"[table pages]",
+		"[table summary]"};
+
+	for (i = 0; i <= 1; i++) {
+		for (e = 0; e < RA_EVENT_COUNT; e++) {
+			ra_events[RA_CLASS_ALL][e][i] = 0;
+			for (c = RA_CLASS_INITIAL; c < RA_CLASS_NONE; c++)
+				ra_events[RA_CLASS_ALL][e][i] += ra_events[c][e][i];
+		}
+
+		seq_printf(s, event_fmt, table_name[i]);
+		for (c = 0; c < RA_CLASS_COUNT; c++)
+			seq_printf(s, class_fmt, ra_class_name[c]);
+		seq_puts(s, "\n");
+
+		for (e = 0; e < RA_EVENT_COUNT; e++) {
+			if (e == RA_EVENT_READAHEAD_CUBE)
+				continue;
+			if (e == RA_EVENT_READAHEAD_HIT && i == 0)
+				continue;
+			if (e == RA_EVENT_IO_BLOCK && i == 1)
+				continue;
+
+			seq_printf(s, event_fmt, ra_event_name[e]);
+			for (c = 0; c < RA_CLASS_COUNT; c++)
+				seq_printf(s, item_fmt, ra_events[c][e][i]);
+			seq_puts(s, "\n");
+		}
+		seq_puts(s, "\n");
+	}
+
+	seq_printf(s, event_fmt, table_name[2]);
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, class_fmt, ra_class_name[c]);
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "random_rate");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_RANDOM_READ][0] * 100) /
+			((ra_events[c][RA_EVENT_RANDOM_READ][0] +
+			  ra_events[c][RA_EVENT_READAHEAD][0]) | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "ra_hit_rate");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_READAHEAD_HIT][1] * 100) /
+			(ra_events[c][RA_EVENT_READAHEAD][1] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "la_hit_rate");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_LOOKAHEAD_HIT][0] * 100) /
+			(ra_events[c][RA_EVENT_LOOKAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "var_ra_size");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, item_fmt,
+			(ra_events[c][RA_EVENT_READAHEAD_CUBE][1] -
+			 ra_events[c][RA_EVENT_READAHEAD][1] *
+			(ra_events[c][RA_EVENT_READAHEAD][1] /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1))) /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_ra_size");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, item_fmt,
+			(ra_events[c][RA_EVENT_READAHEAD][1] +
+			 ra_events[c][RA_EVENT_READAHEAD][0] / 2) /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_la_size");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, item_fmt,
+			(ra_events[c][RA_EVENT_LOOKAHEAD][1] +
+			 ra_events[c][RA_EVENT_LOOKAHEAD][0] / 2) /
+			(ra_events[c][RA_EVENT_LOOKAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int ra_events_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ra_events_show, NULL);
+}
+
+static ssize_t ra_events_write(struct file *file, const char __user *buf,
+						size_t size, loff_t *offset)
+{
+	memset(ra_events, 0, sizeof(ra_events));
+	return 1;
+}
+
+struct file_operations ra_events_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ra_events_open,
+	.write		= ra_events_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#define READAHEAD_DEBUGFS_ENTRY_U32(var) \
+	debugfs_create_u32(__stringify(var), 0644, root, &var)
+
+#define READAHEAD_DEBUGFS_ENTRY_BOOL(var) \
+	debugfs_create_bool(__stringify(var), 0644, root, &var)
+
+static int __init readahead_init(void)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("readahead", NULL);
+
+	debugfs_create_file("events", 0644, root, NULL, &ra_events_fops);
+
+	READAHEAD_DEBUGFS_ENTRY_U32(initial_ra_hit);
+	READAHEAD_DEBUGFS_ENTRY_U32(initial_ra_miss);
+
+	READAHEAD_DEBUGFS_ENTRY_U32(debug_level);
+	READAHEAD_DEBUGFS_ENTRY_BOOL(disable_stateful_method);
+
+	return 0;
+}
+
+module_init(readahead_init)
+
+#endif /* CONFIG_DEBUG_READAHEAD */
--- linux-2.6.17-rc5.orig/mm/swap.c
+++ linux-2.6.17-rc5/mm/swap.c
@@ -127,6 +127,8 @@ void fastcall mark_page_accessed(struct 
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
+		if (PageLRU(page))
+			inc_readahead_aging();
 	}
 }
 
--- linux-2.6.17-rc5.orig/mm/vmscan.c
+++ linux-2.6.17-rc5/mm/vmscan.c
@@ -439,6 +439,9 @@ static unsigned long shrink_page_list(st
 		if (PageWriteback(page))
 			goto keep_locked;
 
+		if (!PageReferenced(page))
+			inc_readahead_aging();
+
 		referenced = page_referenced(page, 1);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
@@ -637,6 +640,7 @@ static unsigned long shrink_inactive_lis
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
+		zone->aging_total += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
 		nr_scanned += nr_scan;

--nFreZHaLTZJo0R7j--
