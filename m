Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318714AbSH1E3X>; Wed, 28 Aug 2002 00:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSH1E2p>; Wed, 28 Aug 2002 00:28:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318714AbSH1E2B>;
	Wed, 28 Aug 2002 00:28:01 -0400
Message-ID: <3D6C54FF.E3A49037@zip.com.au>
Date: Tue, 27 Aug 2002 21:43:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] limit buffer_head consumption to 10% of ZONE_NORMAL
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch addresses the excessive consumption of ZONE_NORMAL by
buffer_heads on highmem machines.

The buffer.c change implements the buffer_head accounting - it sets the
upper limit on buffer_head memory occupancy to 10% of ZONE_NORMAL.

A possible side-effect of this change is that the kernel will perform
more calls to get_block() to map pages to disk.  This will only be
observed when a file is being repeatadly overwritten - this is the only
case in which the "cached get_block result" in the buffers is useful.

I did quite some testing of this back in the delalloc ext2 days, and
was not able to come up with a test in which the cached get_block
result was measurably useful.  That's for ext2, which has a fast
get_block().

A desirable side effect of this patch is that the kernel will be able
to cache much more blockdev pagecache in ZONE_NORMAL, so there are more
ext2/3 indirect blocks in cache, so with some workloads, less I/O will
be performed.

In mpage_writepage(): if the number of buffer_heads is excessive then
buffers are stripped from pages as they are submitted for writeback.
This change is only useful for filesystems which are using the mpage
code.  That's ext2 and ext3-writeback and JFS.  An mpage patch for
reiserfs was floating about but seems to have got lost.

There is no need to strip buffers for reads because the mpage code does
not attach buffers for reads.

These are perhaps not the most appropriate buffer_heads to toss away.
Perhaps something smarter should be done to detect file overwriting, or
to toss the 'oldest' buffer_heads first.

In refill_inactive(): if the number of buffer_heads is excessive then
strip buffers from pages as they move onto the inactive list.  This
change is useful for all filesystems.  This approach is good because
pages which are being repeatedly overwritten will remain on the active
list and will retain their buffers, whereas pages which are not being
overwritten will be stripped.



 fs/buffer.c                 |   48 +++++++++++++++++++++++++++++++++++++++++++-
 fs/mpage.c                  |    3 ++
 include/linux/buffer_head.h |    1 
 include/linux/pagevec.h     |    1 
 mm/swap.c                   |   18 ++++++++++++++++
 mm/vmscan.c                 |    8 +++++++
 6 files changed, 78 insertions(+), 1 deletion(-)

--- 2.5.32/fs/buffer.c~buffer-strip	Tue Aug 27 21:39:52 2002
+++ 2.5.32-akpm/fs/buffer.c	Tue Aug 27 21:41:33 2002
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
@@ -2560,9 +2561,45 @@ asmlinkage long sys_bdflush(int func, lo
 static kmem_cache_t *bh_cachep;
 static mempool_t *bh_mempool;
 
+/*
+ * Once the number of bh's in the machine exceeds this level, we start
+ * stripping them in writeback.
+ */
+static int max_buffer_heads;
+
+int buffer_heads_over_limit;
+
+struct bh_accounting {
+	int nr;			/* Number of live bh's */
+	int ratelimit;		/* Limit cacheline bouncing */
+};
+
+static DEFINE_PER_CPU(struct bh_accounting, bh_accounting) = {0, 0};
+
+static void recalc_bh_state(void)
+{
+	int i;
+	int tot = 0;
+
+	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
+		return;
+	__get_cpu_var(bh_accounting).ratelimit = 0;
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		tot += per_cpu(bh_accounting, i).nr;
+	}
+	buffer_heads_over_limit = (tot > max_buffer_heads);
+}
+	
 struct buffer_head *alloc_buffer_head(void)
 {
-	return mempool_alloc(bh_mempool, GFP_NOFS);
+	struct buffer_head *ret = mempool_alloc(bh_mempool, GFP_NOFS);
+	if (ret) {
+		__get_cpu_var(bh_accounting).nr++;
+		recalc_bh_state();
+	}
+	return ret;
 }
 EXPORT_SYMBOL(alloc_buffer_head);
 
@@ -2570,6 +2607,8 @@ void free_buffer_head(struct buffer_head
 {
 	BUG_ON(!list_empty(&bh->b_assoc_buffers));
 	mempool_free(bh, bh_mempool);
+	__get_cpu_var(bh_accounting).nr--;
+	recalc_bh_state();
 }
 EXPORT_SYMBOL(free_buffer_head);
 
@@ -2601,6 +2640,7 @@ static void bh_mempool_free(void *elemen
 void __init buffer_init(void)
 {
 	int i;
+	int nrpages;
 
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,
@@ -2609,4 +2649,10 @@ void __init buffer_init(void)
 				bh_mempool_free, NULL);
 	for (i = 0; i < ARRAY_SIZE(bh_wait_queue_heads); i++)
 		init_waitqueue_head(&bh_wait_queue_heads[i].wqh);
+
+	/*
+	 * Limit the bh occupancy to 10% of ZONE_NORMAL
+	 */
+	nrpages = (nr_free_buffer_pages() * 10) / 100;
+	max_buffer_heads = nrpages * (PAGE_SIZE / sizeof(struct buffer_head));
 }
--- 2.5.32/include/linux/buffer_head.h~buffer-strip	Tue Aug 27 21:39:52 2002
+++ 2.5.32-akpm/include/linux/buffer_head.h	Tue Aug 27 21:39:52 2002
@@ -167,6 +167,7 @@ void wakeup_bdflush(void);
 struct buffer_head *alloc_buffer_head(void);
 void free_buffer_head(struct buffer_head * bh);
 void FASTCALL(unlock_buffer(struct buffer_head *bh));
+extern int buffer_heads_over_limit;
 
 /*
  * Generic address_space_operations implementations for buffer_head-backed
--- 2.5.32/fs/mpage.c~buffer-strip	Tue Aug 27 21:39:52 2002
+++ 2.5.32-akpm/fs/mpage.c	Tue Aug 27 21:39:52 2002
@@ -460,6 +460,9 @@ page_is_mapped:
 			clear_buffer_dirty(bh);
 			bh = bh->b_this_page;
 		} while (bh != head);
+
+		if (buffer_heads_over_limit)
+			try_to_free_buffers(page);
 	}
 
 	bvec = &bio->bi_io_vec[bio->bi_idx++];
--- 2.5.32/mm/vmscan.c~buffer-strip	Tue Aug 27 21:39:52 2002
+++ 2.5.32-akpm/mm/vmscan.c	Tue Aug 27 21:39:52 2002
@@ -432,10 +432,18 @@ refill_inactive_zone(struct zone *zone, 
 		list_move(&page->lru, &zone->inactive_list);
 		if (!pagevec_add(&pvec, page)) {
 			spin_unlock_irq(&zone->lru_lock);
+			if (buffer_heads_over_limit)
+				pagevec_strip(&pvec);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
+	if (buffer_heads_over_limit) {
+		spin_unlock_irq(&zone->lru_lock);
+		pagevec_strip(&pvec);
+		pagevec_release(&pvec);
+		spin_lock_irq(&zone->lru_lock);
+	}
 	while (!list_empty(&l_active)) {
 		page = list_entry(l_active.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &l_active, flags);
--- 2.5.32/include/linux/pagevec.h~buffer-strip	Tue Aug 27 21:39:52 2002
+++ 2.5.32-akpm/include/linux/pagevec.h	Tue Aug 27 21:39:52 2002
@@ -21,6 +21,7 @@ void __pagevec_lru_add(struct pagevec *p
 void __pagevec_lru_del(struct pagevec *pvec);
 void lru_add_drain(void);
 void pagevec_deactivate_inactive(struct pagevec *pvec);
+void pagevec_strip(struct pagevec *pvec);
 
 static inline void pagevec_init(struct pagevec *pvec)
 {
--- 2.5.32/mm/swap.c~buffer-strip	Tue Aug 27 21:39:52 2002
+++ 2.5.32-akpm/mm/swap.c	Tue Aug 27 21:39:52 2002
@@ -20,6 +20,7 @@
 #include <linux/pagevec.h>
 #include <linux/init.h>
 #include <linux/mm_inline.h>
+#include <linux/buffer_head.h>
 #include <linux/prefetch.h>
 
 /* How many pages do we try to swap or page in/out together? */
@@ -251,6 +252,23 @@ void __pagevec_lru_del(struct pagevec *p
 }
 
 /*
+ * Try to drop buffers from the pages in a pagevec
+ */
+void pagevec_strip(struct pagevec *pvec)
+{
+	int i;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		if (PagePrivate(page) && !TestSetPageLocked(page)) {
+			try_to_release_page(page, 0);
+			unlock_page(page);
+		}
+	}
+}
+
+/*
  * Perform any setup for the swap system
  */
 void __init swap_setup(void)

.
