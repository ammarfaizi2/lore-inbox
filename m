Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262647AbTDAQRM>; Tue, 1 Apr 2003 11:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbTDAQRM>; Tue, 1 Apr 2003 11:17:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57794 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262637AbTDAQQL>;
	Tue, 1 Apr 2003 11:16:11 -0500
Date: Tue, 1 Apr 2003 22:02:42 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filesystem aio rdwr patchset
Message-ID: <20030401220242.B1857@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030401215957.A1800@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030401215957.A1800@in.ibm.com>; from suparna@in.ibm.com on Tue, Apr 01, 2003 at 09:59:57PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 09:59:57PM +0530, Suparna Bhattacharya wrote:
> 02aiordwr.patch  : this is the filesystem read+write
>   changes for aio using the retry model
> 
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


diff -ur linux-2.5.66/drivers/block/ll_rw_blk.c linux-2.5.66aio/drivers/block/ll_rw_blk.c
--- linux-2.5.66/drivers/block/ll_rw_blk.c	Tue Mar 25 03:30:00 2003
+++ linux-2.5.66aio/drivers/block/ll_rw_blk.c	Tue Apr  1 10:36:53 2003
@@ -1564,17 +1564,33 @@
  * If no queues are congested then just wait for the next request to be
  * returned.
  */
-void blk_congestion_wait(int rw, long timeout)
+int blk_congestion_wait_async(int rw, long timeout)
 {
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(sync_wait);
+	wait_queue_t *wait = &sync_wait;
+	int state = TASK_UNINTERRUPTIBLE;
 	wait_queue_head_t *wqh = &congestion_wqh[rw];
 
+	if (current->iocb) {
+		wait = &current->iocb->ki_wait;
+		state = TASK_RUNNING;
+	}
 	blk_run_queues();
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+	prepare_to_wait(wqh, wait, state);
+	if (current->iocb) 
+		return -EIOCBQUEUED;
+
 	io_schedule_timeout(timeout);
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, wait);
+	return 0;
 }
 
+void blk_congestion_wait(int rw, long timeout)
+{
+	do_sync_op(blk_congestion_wait_async(rw, timeout));
+}
+
+
 /*
  * Has to be called with the request spinlock acquired
  */
diff -ur linux-2.5.66/fs/buffer.c linux-2.5.66aio/fs/buffer.c
--- linux-2.5.66/fs/buffer.c	Tue Mar 25 03:30:48 2003
+++ linux-2.5.66aio/fs/buffer.c	Wed Mar 26 19:11:09 2003
@@ -1821,8 +1860,11 @@
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			err = get_block(inode, block, bh, 1);
-			if (err)
+			if (err) {
+				if (-EIOCBQUEUED == err)
+					pr_debug("get_block queued\n");
 				goto out;
+			}
 			if (buffer_new(bh)) {
 				clear_buffer_new(bh);
 				unmap_underlying_metadata(bh->b_bdev,
diff -ur linux-2.5.66/include/linux/blkdev.h linux-2.5.66aio/include/linux/blkdev.h
--- linux-2.5.66/include/linux/blkdev.h	Tue Mar 25 03:30:09 2003
+++ linux-2.5.66aio/include/linux/blkdev.h	Wed Mar 26 20:07:06 2003
@@ -391,6 +391,7 @@
 extern void blk_queue_free_tags(request_queue_t *);
 extern void blk_queue_invalidate_tags(request_queue_t *);
 extern void blk_congestion_wait(int rw, long timeout);
+extern int blk_congestion_wait_async(int rw, long timeout);
 
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
diff -ur linux-2.5.66/include/linux/pagemap.h linux-2.5.66aio/include/linux/pagemap.h
--- linux-2.5.66/include/linux/pagemap.h	Tue Mar 25 03:29:54 2003
+++ linux-2.5.66aio/include/linux/pagemap.h	Wed Mar 26 19:40:29 2003
@@ -135,6 +135,16 @@
 	if (TestSetPageLocked(page))
 		__lock_page(page);
 }
+
+extern int FASTCALL(__lock_page_async(struct page *page));
+static inline int lock_page_async(struct page *page)
+{
+	if (TestSetPageLocked(page))
+		return __lock_page_async(page);
+	else
+		return 0;
+}
+
 	
 /*
  * This is exported only for wait_on_page_locked/wait_on_page_writeback.
@@ -155,6 +165,15 @@
 		wait_on_page_bit(page, PG_locked);
 }
 
+extern int FASTCALL(wait_on_page_bit_async(struct page *page, int bit_nr));
+static inline int wait_on_page_locked_async(struct page *page)
+{
+	if (PageLocked(page))
+		return wait_on_page_bit_async(page, PG_locked);
+	else
+		return 0;
+}
+
 /* 
  * Wait for a page to complete writeback
  */
diff -ur linux-2.5.66/include/linux/writeback.h linux-2.5.66aio/include/linux/writeback.h
--- linux-2.5.66/include/linux/writeback.h	Tue Mar 25 03:30:01 2003
+++ linux-2.5.66aio/include/linux/writeback.h	Mon Mar 24 12:00:32 2003
@@ -80,8 +80,8 @@
 
 
 void page_writeback_init(void);
-void balance_dirty_pages(struct address_space *mapping);
-void balance_dirty_pages_ratelimited(struct address_space *mapping);
+int balance_dirty_pages(struct address_space *mapping);
+int balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 
diff -ur linux-2.5.66/mm/filemap.c linux-2.5.66aio/mm/filemap.c
--- linux-2.5.66/mm/filemap.c	Tue Mar 25 03:30:15 2003
+++ linux-2.5.66aio/mm/filemap.c	Wed Mar 26 20:38:03 2003
@@ -254,19 +254,36 @@
 	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
 
-void wait_on_page_bit(struct page *page, int bit_nr)
+int wait_on_page_bit_async(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(sync_wait);
+	wait_queue_t *wait = &sync_wait;
+	int state = TASK_UNINTERRUPTIBLE;
+		
+	if (current->iocb) {
+		wait = &current->iocb->ki_wait;
+		state = TASK_RUNNING;
+	}
 
 	do {
-		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(waitqueue, wait, state);
 		if (test_bit(bit_nr, &page->flags)) {
 			sync_page(page);
+			if (current->iocb)
+				return -EIOCBQUEUED;
 			io_schedule();
 		}
 	} while (test_bit(bit_nr, &page->flags));
-	finish_wait(waitqueue, &wait);
+	finish_wait(waitqueue, wait);
+
+	return 0;
+}
+EXPORT_SYMBOL(wait_on_page_bit_async);
+
+void wait_on_page_bit(struct page *page, int bit_nr)
+{
+	do_sync_op(wait_on_page_bit_async(page, bit_nr));
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
@@ -322,19 +339,35 @@
  * chances are that on the second loop, the block layer's plug list is empty,
  * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
-void __lock_page(struct page *page)
+int __lock_page_async(struct page *page)
 {
 	wait_queue_head_t *wqh = page_waitqueue(page);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(sync_wait);
+	wait_queue_t *wait = &sync_wait;
+	int state = TASK_UNINTERRUPTIBLE;
+		
+	if (current->iocb) {
+		wait = &current->iocb->ki_wait;
+		state = TASK_RUNNING;
+	}
 
 	while (TestSetPageLocked(page)) {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(wqh, wait, state);
 		if (PageLocked(page)) {
 			sync_page(page);
+			if (current->iocb)
+				return -EIOCBQUEUED;
 			io_schedule();
 		}
 	}
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, wait);
+	return 0;
+}
+EXPORT_SYMBOL(__lock_page_async);
+
+void __lock_page(struct page *page)
+{
+	do_sync_op(__lock_page_async(page));
 }
 EXPORT_SYMBOL(__lock_page);
 
@@ -384,7 +417,7 @@
  *
  * Returns zero if the page was not present. find_lock_page() may sleep.
  */
-struct page *find_lock_page(struct address_space *mapping,
+struct page *find_lock_page_async(struct address_space *mapping,
 				unsigned long offset)
 {
 	struct page *page;
@@ -396,7 +429,10 @@
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
 			read_unlock(&mapping->page_lock);
-			lock_page(page);
+			if (-EIOCBQUEUED == lock_page_async(page)) {
+				page_cache_release(page);
+				return ERR_PTR(-EIOCBQUEUED);
+			}
 			read_lock(&mapping->page_lock);
 
 			/* Has the page been truncated while we slept? */
@@ -411,6 +447,19 @@
 	return page;
 }
 
+struct page *find_lock_page(struct address_space *mapping,
+				unsigned long offset)
+{
+	struct page *page;
+	struct kiocb *iocb = current->iocb;
+
+	current->iocb = NULL;
+	page = find_lock_page_async(mapping, offset);
+	current->iocb = iocb;
+
+	return page;
+}
+
 /**
  * find_or_create_page - locate or add a pagecache page
  *
@@ -607,7 +656,13 @@
 			goto page_ok;
 
 		/* Get exclusive access to the page ... */
-		lock_page(page);
+		
+		if (lock_page_async(page)) {
+			pr_debug("queued lock page \n");
+			error = -EIOCBQUEUED;
+			/* TBD: should we hold on to the cached page ? */
+			goto sync_error;
+		}
 
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
@@ -629,12 +684,19 @@
 		if (!error) {
 			if (PageUptodate(page))
 				goto page_ok;
-			wait_on_page_locked(page);
+			if (wait_on_page_locked_async(page)) {
+				pr_debug("queued wait_on_page \n");
+				error = -EIOCBQUEUED;
+				/*TBD:should we hold on to the cached page ?*/
+				goto sync_error;
+			}
+			
 			if (PageUptodate(page))
 				goto page_ok;
 			error = -EIO;
 		}
 
+sync_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
 		page_cache_release(page);
@@ -806,6 +868,7 @@
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
+	BUG_ON(current->iocb != NULL);
 	ret = __generic_file_aio_read(&kiocb, &local_iov, 1, ppos);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
@@ -837,6 +900,7 @@
 {
 	read_descriptor_t desc;
 
+	BUG_ON(current->iocb != NULL);
 	if (!count)
 		return 0;
 
@@ -1364,7 +1428,9 @@
 	int err;
 	struct page *page;
 repeat:
-	page = find_lock_page(mapping, index);
+	page = find_lock_page_async(mapping, index);
+	if (IS_ERR(page))
+		return page;
 	if (!page) {
 		if (!*cached_page) {
 			*cached_page = page_cache_alloc(mapping);
@@ -1683,6 +1749,10 @@
 		fault_in_pages_readable(buf, bytes);
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
+		if (IS_ERR(page)) {
+			status = PTR_ERR(page);
+			break;
+		}
 		if (!page) {
 			status = -ENOMEM;
 			break;
@@ -1690,6 +1760,8 @@
 
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
+			if (-EIOCBQUEUED == status)
+				pr_debug("queued prepare_write\n");
 			/*
 			 * prepare_write() may have instantiated a few blocks
 			 * outside i_size.  Trim these off again.
@@ -1730,7 +1802,11 @@
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
@@ -1742,9 +1818,10 @@
 	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
 	 */
 	if (status >= 0) {
-		if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
+		if ((file->f_flags & O_SYNC) || IS_SYNC(inode)) {
 			status = generic_osync_inode(inode,
 					OSYNC_METADATA|OSYNC_DATA);
+		}
 	}
 	
 out_status:	
diff -ur linux-2.5.66/mm/page-writeback.c linux-2.5.66aio/mm/page-writeback.c
--- linux-2.5.66/mm/page-writeback.c	Tue Mar 25 03:30:55 2003
+++ linux-2.5.66aio/mm/page-writeback.c	Wed Mar 26 19:37:42 2003
@@ -135,7 +135,7 @@
  * If we're over `background_thresh' then pdflush is woken to perform some
  * writeout.
  */
-void balance_dirty_pages(struct address_space *mapping)
+int balance_dirty_pages(struct address_space *mapping)
 {
 	struct page_state ps;
 	long background_thresh;
@@ -152,6 +152,7 @@
 			.sync_mode	= WB_SYNC_NONE,
 			.older_than_this = NULL,
 			.nr_to_write	= write_chunk,
+			.nonblocking	= current->iocb ? 1 : 0,
 		};
 
 		dirty_exceeded = 1;
@@ -165,7 +166,10 @@
 		pages_written += write_chunk - wbc.nr_to_write;
 		if (pages_written >= write_chunk)
 			break;		/* We've done our duty */
-		blk_congestion_wait(WRITE, HZ/10);
+		if (-EIOCBQUEUED == blk_congestion_wait_async(WRITE, HZ/10)) {
+			pr_debug("async blk congestion wait\n");
+			return -EIOCBQUEUED;
+		}
 	}
 
 	if (ps.nr_dirty + ps.nr_writeback <= dirty_thresh)
@@ -173,6 +177,8 @@
 
 	if (!writeback_in_progress(bdi) && ps.nr_dirty > background_thresh)
 		pdflush_operation(background_writeout, 0);
+
+	return 0;
 }
 
 /**
@@ -188,7 +194,7 @@
  * decrease the ratelimiting by a lot, to prevent individual processes from
  * overshooting the limit by (ratelimit_pages) each.
  */
-void balance_dirty_pages_ratelimited(struct address_space *mapping)
+int balance_dirty_pages_ratelimited(struct address_space *mapping)
 {
 	static DEFINE_PER_CPU(int, ratelimits) = 0;
 	int cpu;
@@ -202,10 +208,10 @@
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
 
