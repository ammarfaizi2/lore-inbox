Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTDXEyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTDXEyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:54:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:50375 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264437AbTDXEyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:54:00 -0400
Date: Thu, 24 Apr 2003 10:41:03 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Filesystem AIO read-write patches
Message-ID: <20030424104103.C2288@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030424102221.A2166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424102221.A2166@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 24, 2003 at 10:22:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> Here is a revised version of the filesystem AIO patches
> for 2.5.68.
> 
> 03aiowr.patch	 	: Minimal filesystem aio write 
> 			(for all archs and all filesystems 
> 			 using generic_file_aio_write)

Changes to enable generic_file_aio_write use the aio 
retry infrastructure. The blocking points addressed are
in find_lock_page and blk_congestion_wait.

(Async down and async get block are available as optional
follow on patches)

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

03aiowr.patch
..............
 drivers/block/ll_rw_blk.c |   21 +++++++++++++++++----
 include/linux/blkdev.h    |    1 +
 include/linux/writeback.h |    4 ++--
 mm/filemap.c              |   31 ++++++++++++++++++++++++++-----
 mm/page-writeback.c       |   17 ++++++++++++-----
 5 files changed, 58 insertions(+), 16 deletions(-)

diff -ur -X /home/kiran/dontdiff linux-2.5.68/drivers/block/ll_rw_blk.c linux-aio-2568/drivers/block/ll_rw_blk.c
--- linux-2.5.68/drivers/block/ll_rw_blk.c	Fri Apr 11 21:10:45 2003
+++ linux-aio-2568/drivers/block/ll_rw_blk.c	Wed Apr 16 23:47:25 2003
@@ -1564,17 +1564,30 @@
  * If no queues are congested then just wait for the next request to be
  * returned.
  */
-void blk_congestion_wait(int rw, long timeout)
+int blk_congestion_wait_wq(int rw, long timeout, wait_queue_t *wait)
 {
-	DEFINE_WAIT(wait);
 	wait_queue_head_t *wqh = &congestion_wqh[rw];
+	DEFINE_WAIT(local_wait);
+
+	if (!wait)
+		wait = &local_wait;
 
 	blk_run_queues();
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+	prepare_to_wait(wqh, wait, TASK_UNINTERRUPTIBLE);
+	if (!is_sync_wait(wait)) 
+		return -EIOCBRETRY;
+
 	io_schedule_timeout(timeout);
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, wait);
+	return 0;
+}
+
+void blk_congestion_wait(int rw, long timeout)
+{
+	blk_congestion_wait_wq(rw, timeout, NULL);
 }
 
+
 /*
  * Has to be called with the request spinlock acquired
  */
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/blkdev.h linux-aio-2568/include/linux/blkdev.h
--- linux-2.5.68/include/linux/blkdev.h	Fri Apr 11 21:10:51 2003
+++ linux-aio-2568/include/linux/blkdev.h	Wed Apr 16 16:31:12 2003
@@ -390,6 +390,7 @@
 extern void blk_queue_free_tags(request_queue_t *);
 extern void blk_queue_invalidate_tags(request_queue_t *);
 extern void blk_congestion_wait(int rw, long timeout);
+extern int blk_congestion_wait_wq(int rw, long timeout, wait_queue_t *wait);
 
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/writeback.h linux-aio-2568/include/linux/writeback.h
--- linux-2.5.68/include/linux/writeback.h	Tue Mar 25 03:30:01 2003
+++ linux-aio-2568/include/linux/writeback.h	Wed Apr 16 16:31:12 2003
@@ -80,8 +80,8 @@
 
 
 void page_writeback_init(void);
-void balance_dirty_pages(struct address_space *mapping);
-void balance_dirty_pages_ratelimited(struct address_space *mapping);
+int balance_dirty_pages(struct address_space *mapping);
+int balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 
diff -ur -X /home/kiran/dontdiff linux-2.5.68/mm/filemap.c linux-aio-2568/mm/filemap.c
--- linux-2.5.68/mm/filemap.c	Mon Apr 21 23:30:40 2003
+++ linux-aio-2568/mm/filemap.c	Tue Apr 22 00:28:55 2003
@@ -398,8 +423,8 @@
  *
  * Returns zero if the page was not present. find_lock_page() may sleep.
  */
-struct page *find_lock_page(struct address_space *mapping,
-				unsigned long offset)
+struct page *find_lock_page_wq(struct address_space *mapping,
+				unsigned long offset, wait_queue_t *wait)
 {
 	struct page *page;
 
@@ -410,7 +435,10 @@
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
 			spin_unlock(&mapping->page_lock);
-			lock_page(page);
+			if (-EIOCBRETRY == lock_page_wq(page, wait)) {
+				page_cache_release(page);
+				return ERR_PTR(-EIOCBRETRY);
+			}
 			spin_lock(&mapping->page_lock);
 
 			/* Has the page been truncated while we slept? */
@@ -425,6 +453,12 @@
 	return page;
 }
 
+struct page *find_lock_page(struct address_space *mapping,
+				unsigned long offset)
+{
+	return find_lock_page_wq(mapping, offset, NULL);
+}
+
 /**
  * find_or_create_page - locate or add a pagecache page
  *
@@ -1373,7 +1425,9 @@
 	int err;
 	struct page *page;
 repeat:
-	page = find_lock_page(mapping, index);
+	page = find_lock_page_wq(mapping, index, current->io_wait);
+	if (IS_ERR(page))
+		return page;
 	if (!page) {
 		if (!*cached_page) {
 			*cached_page = page_cache_alloc(mapping);
@@ -1690,6 +1744,10 @@
 		fault_in_pages_readable(buf, bytes);
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
+		if (IS_ERR(page)) {
+			status = PTR_ERR(page);
+			break;
+		}
 		if (!page) {
 			status = -ENOMEM;
 			break;
@@ -1697,6 +1755,8 @@
 
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
+			if (-EIOCBRETRY == status)
+				pr_debug("queued prepare_write\n");
 			/*
 			 * prepare_write() may have instantiated a few blocks
 			 * outside i_size.  Trim these off again.
@@ -1737,7 +1797,11 @@
 		page_cache_release(page);
 		if (status < 0)
 			break;
-		balance_dirty_pages_ratelimited(mapping);
+		status = balance_dirty_pages_ratelimited(mapping);
+		if (status < 0) {
+			pr_debug("async balance_dirty_pages\n");
+			break;
+		}
 		cond_resched();
 	} while (count);
 	*ppos = pos;
diff -ur -X /home/kiran/dontdiff linux-2.5.68/mm/page-writeback.c linux-aio-2568/mm/page-writeback.c
--- linux-2.5.68/mm/page-writeback.c	Mon Apr 21 23:30:40 2003
+++ linux-aio-2568/mm/page-writeback.c	Tue Apr 22 01:31:35 2003
@@ -135,7 +135,7 @@
  * If we're over `background_thresh' then pdflush is woken to perform some
  * writeout.
  */
-void balance_dirty_pages(struct address_space *mapping)
+int balance_dirty_pages(struct address_space *mapping)
 {
 	struct page_state ps;
 	long nr_reclaimable;
@@ -152,6 +152,7 @@
 			.sync_mode	= WB_SYNC_NONE,
 			.older_than_this = NULL,
 			.nr_to_write	= write_chunk,
+			.nonblocking	= !is_sync_wait(current->io_wait)
 		};
 
 		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
@@ -178,7 +179,11 @@
 			if (pages_written >= write_chunk)
 				break;		/* We've done our duty */
 		}
-		blk_congestion_wait(WRITE, HZ/10);
+		if (-EIOCBRETRY == blk_congestion_wait_wq(WRITE, HZ/10,
+			current->io_wait)) {
+			pr_debug("async blk congestion wait\n");
+			return -EIOCBRETRY;
+		}
 	}
 
 	if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
@@ -186,6 +191,8 @@
 
 	if (!writeback_in_progress(bdi) && nr_reclaimable > background_thresh)
 		pdflush_operation(background_writeout, 0);
+
+	return 0;
 }
 
 /**
@@ -201,7 +208,7 @@
  * decrease the ratelimiting by a lot, to prevent individual processes from
  * overshooting the limit by (ratelimit_pages) each.
  */
-void balance_dirty_pages_ratelimited(struct address_space *mapping)
+int balance_dirty_pages_ratelimited(struct address_space *mapping)
 {
 	static DEFINE_PER_CPU(int, ratelimits) = 0;
 	int cpu;
@@ -215,10 +222,10 @@
 	if (per_cpu(ratelimits, cpu)++ >= ratelimit) {
 		per_cpu(ratelimits, cpu) = 0;
 		put_cpu();
-		balance_dirty_pages(mapping);
-		return;
+		return balance_dirty_pages(mapping);
 	}
 	put_cpu();
+	return 0;
 }
 EXPORT_SYMBOL_GPL(balance_dirty_pages_ratelimited);
 
