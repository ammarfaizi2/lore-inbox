Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbSLRW30>; Wed, 18 Dec 2002 17:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbSLRW30>; Wed, 18 Dec 2002 17:29:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:43717 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267458AbSLRW3O>;
	Wed, 18 Dec 2002 17:29:14 -0500
Message-ID: <3E00F894.BDAB4E05@digeo.com>
Date: Wed, 18 Dec 2002 14:37:08 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Torben Frey <kernel@mailsammler.de>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
References: <1040245847.3e00e457a4d66@kolivas.net> <3E00F3B4.7050209@mailsammler.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 22:37:08.0263 (UTC) FILETIME=[FF69A370:01C2A6E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torben Frey wrote:
> 
> Hi Con,
> 
> thanks for your fast reply. Unfortunately - I cannot patch a vanilla
> 2.4.20 kernel using patch -p1. The first hunk fails, the other ones are
> found with offsets or even fuzz. Although I applied the first hunk
> manually, compiling fails.
> 
> Do I need the other patches, too? Or a special version of the kernel?
> 

Here's a diff against base 2.4.20.  It may be a little out of date
wrt Andrea's latest but it should tell us if we're looking in the
right place.

I doubt it though.  This problem will be exceedingly rare on kernels
which do not have a voluntary scheduling point in submit_bh().  SMP and
preemptible kernels will hit it, but rarely.

So please try this patch.  Also it would be interesting to know if
read activity against the device fixes the problem.  Try doing a

	cat /dev/sda1 > /dev/null

and see if that unjams things.  If so then yes, it's a queue unplugging
problem.


 drivers/block/ll_rw_blk.c |   25 ++++++++++++++++++++-----
 fs/buffer.c               |   22 +++++++++++++++++++++-
 fs/reiserfs/inode.c       |    1 +
 include/linux/pagemap.h   |    2 ++
 kernel/ksyms.c            |    1 +
 mm/filemap.c              |   14 ++++++++++++++
 6 files changed, 59 insertions(+), 6 deletions(-)

--- 24/drivers/block/ll_rw_blk.c~fix-pausing	Wed Dec 18 14:32:06 2002
+++ 24-akpm/drivers/block/ll_rw_blk.c	Wed Dec 18 14:32:06 2002
@@ -590,12 +590,20 @@ static struct request *__get_request_wai
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
-	generic_unplug_device(q);
 	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (q->rq[rw].count == 0)
+		if (q->rq[rw].count == 0) {
+			/*
+			 * All we care about is not to stall if any request
+			 * is been released after we set TASK_UNINTERRUPTIBLE.
+			 * This is the most efficient place to unplug the queue
+			 * in case we hit the race and we can get the request
+			 * without waiting.
+			 */
+			generic_unplug_device(q);
 			schedule();
+		}
 		spin_lock_irq(&io_request_lock);
 		rq = get_request(q, rw);
 		spin_unlock_irq(&io_request_lock);
@@ -829,9 +837,11 @@ void blkdev_release_request(struct reque
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests &&
-				waitqueue_active(&q->wait_for_requests[rw]))
-			wake_up(&q->wait_for_requests[rw]);
+		if (++q->rq[rw].count >= q->batch_requests) {
+			smp_mb();
+			if (waitqueue_active(&q->wait_for_requests[rw]))
+				wake_up(&q->wait_for_requests[rw]);
+		}
 	}
 }
 
@@ -1200,6 +1210,11 @@ void submit_bh(int rw, struct buffer_hea
 
 	generic_make_request(rw, bh);
 
+	/* fix race condition with wait_on_buffer() */
+	smp_mb(); /* spin_unlock may have inclusive semantics */
+	if (waitqueue_active(&bh->b_wait))
+		wake_up(&bh->b_wait);
+
 	switch (rw) {
 		case WRITE:
 			kstat.pgpgout += count;
--- 24/fs/buffer.c~fix-pausing	Wed Dec 18 14:32:06 2002
+++ 24-akpm/fs/buffer.c	Wed Dec 18 14:32:06 2002
@@ -153,10 +153,23 @@ void __wait_on_buffer(struct buffer_head
 	get_bh(bh);
 	add_wait_queue(&bh->b_wait, &wait);
 	do {
-		run_task_queue(&tq_disk);
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!buffer_locked(bh))
 			break;
+		/*
+		 * We must read tq_disk in TQ_ACTIVE after the
+		 * add_wait_queue effect is visible to other cpus.
+		 * We could unplug some line above it wouldn't matter
+		 * but we can't do that right after add_wait_queue
+		 * without an smp_mb() in between because spin_unlock
+		 * has inclusive semantics.
+		 * Doing it here is the most efficient place so we
+		 * don't do a suprious unplug if we get a racy
+		 * wakeup that make buffer_locked to return 0, and
+		 * doing it here avoids an explicit smp_mb() we
+		 * rely on the implicit one in set_task_state.
+		 */
+		run_task_queue(&tq_disk);
 		schedule();
 	} while (buffer_locked(bh));
 	tsk->state = TASK_RUNNING;
@@ -1512,6 +1525,9 @@ static int __block_write_full_page(struc
 
 	/* Done - end_buffer_io_async will unlock */
 	SetPageUptodate(page);
+
+	wakeup_page_waiters(page);
+
 	return 0;
 
 out:
@@ -1543,6 +1559,7 @@ out:
 	} while (bh != head);
 	if (need_unlock)
 		UnlockPage(page);
+	wakeup_page_waiters(page);
 	return err;
 }
 
@@ -1770,6 +1787,8 @@ int block_read_full_page(struct page *pa
 		else
 			submit_bh(READ, bh);
 	}
+
+	wakeup_page_waiters(page);
 	
 	return 0;
 }
@@ -2383,6 +2402,7 @@ int brw_page(int rw, struct page *page, 
 		submit_bh(rw, bh);
 		bh = next;
 	} while (bh != head);
+	wakeup_page_waiters(page);
 	return 0;
 }
 
--- 24/fs/reiserfs/inode.c~fix-pausing	Wed Dec 18 14:32:06 2002
+++ 24-akpm/fs/reiserfs/inode.c	Wed Dec 18 14:32:06 2002
@@ -1993,6 +1993,7 @@ static int reiserfs_write_full_page(stru
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         UnlockPage(page) ;
     }
--- 24/include/linux/pagemap.h~fix-pausing	Wed Dec 18 14:32:06 2002
+++ 24-akpm/include/linux/pagemap.h	Wed Dec 18 14:32:06 2002
@@ -97,6 +97,8 @@ static inline void wait_on_page(struct p
 		___wait_on_page(page);
 }
 
+extern void wakeup_page_waiters(struct page * page);
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
--- 24/kernel/ksyms.c~fix-pausing	Wed Dec 18 14:32:06 2002
+++ 24-akpm/kernel/ksyms.c	Wed Dec 18 14:32:06 2002
@@ -293,6 +293,7 @@ EXPORT_SYMBOL(filemap_fdatasync);
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);
--- 24/mm/filemap.c~fix-pausing	Wed Dec 18 14:32:06 2002
+++ 24-akpm/mm/filemap.c	Wed Dec 18 14:32:06 2002
@@ -909,6 +909,20 @@ void lock_page(struct page *page)
 }
 
 /*
+ * This must be called after every submit_bh with end_io
+ * callbacks that would result into the blkdev layer waking
+ * up the page after a queue unplug.
+ */
+void wakeup_page_waiters(struct page * page)
+{
+	wait_queue_head_t * head;
+
+	head = page_waitqueue(page);
+	if (waitqueue_active(head))
+		wake_up(head);
+}
+
+/*
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */

_
