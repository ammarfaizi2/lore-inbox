Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbVIONFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVIONFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVIONFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:05:52 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:33727 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1030399AbVIONFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:05:51 -0400
Date: Thu, 15 Sep 2005 21:08:32 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Subject: Adaptive read-ahead based on page cache context
Message-ID: <20050915130832.GA5058@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here's a new read-ahead logic for the 2.6.13 kernel.  It features: 
        o stateless (for now)
        o adapts to available memory / read speed
        o free of thrashing (in theory)

The new logic also can handle some problem-cases of the current one:
        o large number of slow streams (FTP server)
	o open/read/close access patterns (NFS server)
        o multiple interleaved, sequential streams in one file
	  (multithread / multimedia / database)

The magic lies in the status of cached pages near the read request, and
it is done with minimal overheads.


PRINCIPLES

Assume that
        1. inactive list has constant length and page flow speed
        2. the observed stream receives a steady flow of read requests 
	3. no page activation, so that the inactive list forms a pipe
With that we get the picture showed below.

|<------------------------- constant length ------------------------->|
<<<<<<<<<<<<<<<<<<<<<<<<< steady flow of pages <<<<<<<<<<<<<<<<<<<<<<<<
+---------------------------------------------------------------------+
|tail                        inactive list                        head|
|   =======                  ==========----                           |
|   chunk A(stale pages)     chunk B(stale + fresh pages)             |
+---------------------------------------------------------------------+

Imagine a read stream with all of its LRU pages in inactive list, and
they are in the form of two chunks. Reading is now marching inside chunk
B as it is slowly shifted to the tail of inactive list. As soon as all
fresh pages are read in chunk B, the read-ahead logic will read in a new
chunk of pages. To do so it must first determine the largest chunk size
that will not cause a thrashing. E.g. the new chunk size must be under a
thrashing-threshold to be sure all fresh pages have been read (and
become stale) when it is shifted out of inactive list. 

The thrashing-safe size for the new chunk C can be
	size(C) = size(A') + size(B')
where A' is the part of chunk A that still remains in the inactive list. 


FLUCTUATIONS

Now let's return to the real world and deal with the fluctuations
(violation of assumption 1 and 2).
Two variables are introduced and the formula turns into

	size(C) = min(readahead-max,
			size(A') + size(B')) * readahead-ratio / 100

I guess the following defaults can be used:

#define VM_MAX_READAHEAD        1024    /* kbytes */
int readahead_ratio = 50; 

VM_MAX_READAHEAD sets the default hard max for general read-ahead, which
can be changed by the utility blockdev. Software/Hardware RAID drivers
and some special devices/filesystems should set their own default
values.

It should be set to a reasonable large value to allow good parallel read
performance. To be safe, the new logic calculates another max value
based on the current (free + inactive) pages available and uses the
smaller one:
	readahead-max = min(dynamic-max, VM_MAX_READAHEAD)

DISTURBS

Now consider the situations against the third assumption.
The pages can be classified as: fresh, stale, disturbed.
      - When readahead pages are first read in, they are fresh;
      - after the first user space access, they become stale;
      - those have been accessed two or more times are disturbed.

When a sequential read runs across disturbed pages, the read-ahead logic
tries to distinguish different patterns and deal with them properly.

There are two major sources of disturbed pages:

1. sequential disturbing 

1.1 two aggressive reads in one file
The back one tends to catch up with the front one, and the two become
parallel ever since. They will either be detected as sequential fresh
reads and get a readahead-min sized readahead, or be detected as
sequential following reads and get a readahead-max sized readahead.

Another danger would be the thrashing caused by aggressive reads, which
is a general caching strategy problem.

1.2 two multimedia streams close enough
The following one always hits the cache, but that disturbs the leader
one and causes it to get smaller thrashing-threshold estimation. A
chunk size of readahead-min will normally be guaranteed.

The cache hits also causes inactive list to slowly be shortened, until
new balance is reached. It is normally OK for other streams to adapt to
new thresholds in the mean while.

2. random disturbing

Perhaps we should be a bit conservative here. The code may or may
not detect them, as it only does limited check for the sake of speed. 


There is also another form of disturb in the front. But they are
not likely to cause trouble: rotating the old pages to the head of
inactive list can effectively prevent possible thrashing.


DYNAMICS

* startup
When a sequential read is detected, chunk size is set to readahead-min
and grows up with each readahead.  The grow speed is controlled by
readahead-ratio.  When readahead-ratio == 100, the new logic grows chunk
sizes exponentially -- like the current logic, but lags behind it at
early steps.

* stabilize
When chunk size reaches readahead-max, or comes close to
	(readahead-ratio * thrashing-threshold)
it stops growing and stay there.

The main difference with the current logic occurs at and after the time
chunk size stops growing:
     -  The current logic grows chunk size exponentially in normal and
        decreases it by 2 each time thrashing is seen. That can lead to
        thrashing with almost every readahead for very slow streams.
     -  The new logic can stop at a size below the thrashing-threshold,
	and stay there stable.

* on stream speed up or system load fall
thrashing-threshold follows up and chunk size is likely to be enlarged.

* on stream slow down or system load rocket up
thrashing-threshold falls down.
If thrashing happened, the next read would be treated as a random read,
and with another read the chunk-size-growing-phase is restarted.

For a slow stream that has thrashing-threshold < readahead-max:
      - When readahead-ratio = 100, there is only one chunk in cache at
        most time;
      - When readahead-ratio = 50, there are two chunks in cache at most
        time.
      - Lowing readahead-ratio helps gracefully cut down the chunk size
        without thrashing.


OVERHEADS

The main added cost over the current logic is the looking back of the
stale pages in function count_history_pages(). That is done at times to
prepare a readahead I/O. The typical overhead would be 3 radix tree
lookups for every 1M readahead chunk. The worst case would see about 40
radix tree lookups. There is also one radix tree lookup for every read
request to determine whether it is a random read.

So overheads are expected to be low.

On the other hand, the current logic will do some extra radix tree
lookups on cache hits. That behavior is limited by a safeguard max.
The new logic cleanly avoids it by readahead on demand. (But it seems to
cause trouble in benchmarking.)


FUTURE WORK

The new algorithm makes no use of any explicit state variable for now.
It can help much to make use of some global statistics of inactive list.
In fact the new logic and the current logic are complemental in nature.

By adding an ever growing counter `inpages_inactive' to struct zone and
another `inpages_inactive' to struct file_ra_state, we can estimate the
location of the previous readahead chunk within the inactive list, and
obtain another safe estimation of thrashing-threshold. That will make
another major step ahead:
	o no grow up phase (the second readahead gets optimal size)
	o life becomes easier with the choice of readahead-ratio
	o alleviates the disturbing problems
	o cuts down overheads (less scans)

(There is also possibility to store and manage all the file_ra_state
objects in a global data structure, so that there is one entry for each
and every stream. It may be the ultimate way to kill disturbing problems
and achieve good multi-stream behavior, but also requires more work.)

The attached patch is prepared for review and testing. It is written
simple to show basic idea.  If Linus and Andrew Morton feels OK with it,
I plan to work ahead as follows:
1. fix up the basic code
2. integrate with the current one
3. introduce inpages_inactive

Helps and suggestions are welcome.  I'm not able to subscribe to the
LKML, so please CC to me if necessary.

Thank you.

diff -rup linux-2.6.13/include/linux/mm.h linux-2.6.13ra/include/linux/mm.h
--- linux-2.6.13/include/linux/mm.h	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/include/linux/mm.h	2005-09-12 14:41:57.000000000 +0800
@@ -875,7 +875,7 @@ extern int filemap_populate(struct vm_ar
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
-#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MAX_READAHEAD	1024	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 #define VM_MAX_CACHE_HIT    	256	/* max pages in a row in cache before
 					 * turning readahead off */
@@ -889,6 +889,11 @@ unsigned long  page_cache_readahead(stru
 			  struct file *filp,
 			  unsigned long offset,
 			  unsigned long size);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, unsigned long first_index,
+			unsigned long index, unsigned long last_index);
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
diff -rup linux-2.6.13/include/linux/sysctl.h linux-2.6.13ra/include/linux/sysctl.h
--- linux-2.6.13/include/linux/sysctl.h	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/include/linux/sysctl.h	2005-09-07 17:01:58.000000000 +0800
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_READAHEAD_RATIO=29, /* ratio of readahead request size to backward-looking size */
 };
 
 
diff -rup linux-2.6.13/kernel/sysctl.c linux-2.6.13ra/kernel/sysctl.c
--- linux-2.6.13/kernel/sysctl.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/kernel/sysctl.c	2005-09-07 16:46:05.000000000 +0800
@@ -66,6 +66,7 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+extern int readahead_ratio;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -851,6 +852,16 @@ static ctl_table vm_table[] = {
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
 
diff -rup linux-2.6.13/mm/filemap.c linux-2.6.13ra/mm/filemap.c
--- linux-2.6.13/mm/filemap.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/mm/filemap.c	2005-09-13 16:06:02.000000000 +0800
@@ -699,6 +699,8 @@ grab_cache_page_nowait(struct address_sp
 
 EXPORT_SYMBOL(grab_cache_page_nowait);
 
+extern int readahead_ratio;
+
 /*
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level
@@ -726,10 +728,12 @@ void do_generic_mapping_read(struct addr
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
@@ -758,16 +762,28 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index)
+		
+		if (readahead_ratio <= 9 && index == next_index)
 			next_index = page_cache_readahead(mapping, &ra, filp,
 					index, last_index - index);
 
 find_page:
 		page = find_get_page(mapping, index);
+		if (unlikely(page == NULL) && readahead_ratio > 9) {
+			page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+			page = find_get_page(mapping, index);
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
@@ -802,7 +818,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -814,7 +829,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -839,7 +853,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -860,7 +873,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -869,7 +881,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -879,7 +890,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -904,6 +914,9 @@ no_cached_page:
 		}
 		page = cached_page;
 		cached_page = NULL;
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		goto readpage;
 	}
 
@@ -913,6 +926,8 @@ out:
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }
@@ -1210,19 +1225,27 @@ retry_all:
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
+	if (!page && VM_SequentialReadHint(area) && readahead_ratio > 9) {
+		page_cache_readahead_adaptive(mapping, ra,
+						file, NULL,
+						pgoff, pgoff, pgoff + 1);
+		page = find_get_page(mapping, pgoff);
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
diff -rup linux-2.6.13/mm/readahead.c linux-2.6.13ra/mm/readahead.c
--- linux-2.6.13/mm/readahead.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/mm/readahead.c	2005-09-13 16:10:01.000000000 +0800
@@ -15,6 +15,9 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+int readahead_ratio = 0;
+EXPORT_SYMBOL(readahead_ratio);
+
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
@@ -257,7 +261,7 @@ __do_page_cache_readahead(struct address
 			unsigned long offset, unsigned long nr_to_read)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
+	struct page *page = NULL;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
@@ -267,7 +271,7 @@ __do_page_cache_readahead(struct address
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -292,6 +296,10 @@ __do_page_cache_readahead(struct address
 		list_add(&page->lru, &page_pool);
 		ret++;
 	}
+	if (page && readahead_ratio > 9 && (readahead_ratio % 3) == 0)
+		get_page(page);
+	else
+		page = NULL;
 	read_unlock_irq(&mapping->tree_lock);
 
 	/*
@@ -301,6 +309,11 @@ __do_page_cache_readahead(struct address
 	 */
 	if (ret)
 		read_pages(mapping, filp, &page_pool, ret);
+	if (page) {
+		lock_page(page);
+		__put_page(page);
+		unlock_page(page);
+	}
 	BUG_ON(!list_empty(&page_pool));
 out:
 	return ret;
@@ -395,7 +408,13 @@ blockable_page_cache_readahead(struct ad
 
 	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
 
-	return check_ra_success(ra, nr_to_read, actual);
+	if (readahead_ratio <= 9 && (readahead_ratio & 1)) {
+		printk(KERN_DEBUG
+			"blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
+	}
+
+	return (readahead_ratio > 9) ? actual : check_ra_success(ra, nr_to_read, actual);
 }
 
 static int make_ahead_window(struct address_space *mapping, struct file *filp,
@@ -555,3 +574,231 @@ unsigned long max_sane_readahead(unsigne
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
+
+
+/* STATUS	VALUE		TYPE
+ *  ___ 	0		nonexist
+ *  L__ 	1		fresh
+ *  L_R 	2		stale
+ *  LA_ 	4		disturbed once
+ *  LAR 	8		disturbed twice
+ */
+static inline int get_sequential_type(struct page *page)
+{
+	if (page && PageLRU(page)) {
+		if (!PageActive(page))
+			return 1 + PageReferenced(page);
+		else
+			return 4 + 4*PageReferenced(page);
+	}
+	else
+		return 0;
+}
+
+/*
+ * Look back to estimate safe readahead size.
+ * It will normally be around min(nr_lookback, offset), unless either memory or
+ * read speed is low.  A rigid implementation would be a simple loop to scan
+ * page by page backward, though this may be unnecessary and inefficient, so
+ * the stepping forward scheme is used.
+ */
+static int count_sequential_pages(struct address_space *mapping,
+			unsigned long offset, unsigned long nr_lookback,
+			int page_mask)
+{
+	int step;
+	int count;
+	unsigned long index;
+	struct page *page;
+
+	index = offset - nr_lookback;
+	if (unlikely(index > offset))
+		index = 0;
+
+	read_lock_irq(&mapping->tree_lock);
+	for(step = (offset - index + 3) / 4, count = 0;
+			index < offset;
+			index += step) {
+		page = radix_tree_lookup(&mapping->page_tree, index);
+		if (get_sequential_type(page) & page_mask) {
+			if (++count >= 3)
+				break;
+		} else {
+			count = 0;
+			step = (offset - index + 3) / 4;
+		}
+	}
+	read_unlock_irq(&mapping->tree_lock);
+
+	return (offset > index) ? (4 * step) : 0;
+}
+
+
+/*
+ * Rotate old cached pages in inactive_list to prevent readahead thrashing.
+ * Not expected to happen too much.
+ */
+static void rotate_old_pages(struct address_space *mapping,
+			unsigned long offset, unsigned long nr_scan)
+{
+	struct page *page;
+	struct zone *zone;
+
+	for (; nr_scan--; offset++) {
+		page = find_get_page(mapping, offset);
+		if (unlikely(!page))
+			break;
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+		if (PageLRU(page) && !PageLocked(page) && !PageActive(page)) {
+			list_del(&page->lru);
+			list_add(&page->lru, &zone->inactive_list);
+			inc_page_state(pgrotated);
+		}
+		spin_unlock_irq(&zone->lru_lock);
+		page_cache_release(page);
+	}
+}
+
+
+/*
+ * ra_size is mainly determined by:
+ * 1. sequential-start: min(KB(32 + mem_mb/4), KB(128))
+ * 2. sequential-max:	min(KB(64 + mem_mb*8), KB(2048))
+ * 3. sequential:	(history pages) * (readahead_ratio / 100)
+ *
+ * Table of concrete numbers:
+ *  (inactive + free) (in MB):   8  16  32  64  128  256  1024  2048
+ *    initial ra_size (in KB):  34  36  40  48   64   96   128   128
+ *	  max ra_size (in KB): 128 192 320 576 1088 2048  2048  2048
+ */
+static inline void get_readahead_bounds(struct address_space *mapping,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long mem_mb;
+
+#define KB(size)	(((size) * (1<<10)) / PAGE_CACHE_SIZE)
+	mem_mb = max_sane_readahead(KB(1024*1024)) * 2 *
+				PAGE_CACHE_SIZE / 1024 / 1024;
+
+	*ra_max = min(min(KB(64 + mem_mb*8), KB(2048)),
+			mapping->backing_dev_info->ra_pages); 
+
+	*ra_min = min(min(KB(32 + mem_mb/4), KB(128)), *ra_max);
+#undef KB
+}
+
+/* 
+ * Adaptive readahead based on page cache context
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, unsigned long first_index,
+			unsigned long index, unsigned long last_index)
+{
+	unsigned long ra_index;
+	unsigned long ra_size;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int ret;
+	int sequential_type;
+
+	ra_index = index;
+	get_readahead_bounds(mapping, &ra_min, &ra_max);
+
+	/* do not run across EOF */
+	{
+		unsigned long eof_index;
+		eof_index = ((i_size_read(mapping->host) - 1)
+				>> PAGE_CACHE_SHIFT) + 1;
+		if (last_index > eof_index)
+			last_index = eof_index;
+	}
+
+	/*
+	 * readahead disabled?
+	 */
+	if (unlikely(!ra_max)) {
+		ra_size = max_sane_readahead(last_index - index);
+		goto readit;
+	}
+	if (unlikely(!readahead_ratio))
+		goto read_random;
+
+	/*
+	 * Start of file.
+	 */
+	if (index == 0) {
+		ra_size = ra_min;
+		goto readit;
+	}
+
+	/* 
+	 * Sequential readahead?
+	 */ 
+	if (last_index - first_index > ra_max)
+		sequential_type = 0xF;
+	else if (prev_page)
+		sequential_type = get_sequential_type(prev_page);
+	else {
+		prev_page = find_get_page(mapping, index - 1);
+		sequential_type = get_sequential_type(prev_page);
+		if (prev_page)
+			page_cache_release(prev_page);
+	}
+
+	if (sequential_type > 1) {
+		ra_size = count_sequential_pages(mapping, index,
+				ra_max * 100 / readahead_ratio,
+				sequential_type) * readahead_ratio / 100;
+		if (ra_size < ra_min && sequential_type != 2)
+			goto read_random;
+
+		if (ra_size > ra_max)
+			ra_size = ra_max;
+		else if (ra_size < ra_min)
+			ra_size = ra_min;
+		goto readit;
+	}
+
+	/*
+	 * Bare support for read backward.
+	 */
+	if (!prev_page && first_index == index &&
+			last_index - index < ra_min) {
+		struct page *page;
+
+		page = find_get_page(mapping, last_index);
+		if (get_sequential_type(page) == 2) {
+			ra_index = ((index > 8) ? (index - 8) : 0);
+			ra_size = last_index - ra_index;
+			page_cache_release(page);
+			goto readit;
+		} else if (page)
+			page_cache_release(page);
+	}
+
+read_random:
+	ra_size = min(last_index - index, ra_max);
+
+readit: 
+	ret = __do_page_cache_readahead(mapping, filp, ra_index, ra_size);
+
+	/* 
+	 * If found hole, rotate old pages to prevent readahead-thrashing.
+	 */
+	if (ret != ra_size && ra_size < ra_max)
+		rotate_old_pages(mapping, ra_index, ra_size);
+
+	if (readahead_ratio & 1)
+		printk(KERN_DEBUG "readahead(ino=%lu, index=%lu-%lu-%lu, "
+				"ra=%lu+%lu) = %d\n",
+				mapping->host->i_ino,
+				first_index, index, last_index,
+				ra_index, ra_size, ret);
+
+	return ra_index + ra_size;
+}
+
-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui
