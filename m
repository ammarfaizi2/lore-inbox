Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbTFIVaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTFIV3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:29:49 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:46248 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262135AbTFIV04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:26:56 -0400
Subject: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <3EDDDEBB.4080209@cyberone.com.au>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
	 <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>
	 <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1055194762.23130.370.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Jun 2003 17:39:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, there are lots of different problems here, and I've spent a little
while trying to get some numbers with the __get_request_wait stats patch
I posted before.  This is all on ext2, since I wanted to rule out
interactions with the journal flavors.

Basically a dbench 90 run on ext2 rc6 vanilla kernels can generate
latencies of over 2700 jiffies in __get_request_wait, with an average
latency over 250 jiffies.

No, most desktop workloads aren't dbench 90, but between balance_dirty()
and the way we send stuff to disk during memory allocations, just about
any process can get stuck submitting dirty buffers even if you've just
got one process doing a dd if=/dev/zero of=foo.

So, for the moment I'm going to pretend people seeing stalls in X are
stuck in atime updates or memory allocations, or reading proc or some
other silly spot.  

For the SMP corner cases, I've merged Andrea's fix-pausing patch into
rc7, along with an altered form of Nick Piggin's queue_full patch to try
and fix the latency problems.

The major difference from Nick's patch is that once the queue is marked
full, I don't clear the full flag until the wait queue is empty.  This
means new io can't steal available requests until every existing waiter
has been granted a request.

The latency results are better, with average time spent in
__get_request_wait being around 28 jiffies, and a max of 170 jiffies. 
The cost is throughput, further benchmarking needs to be done but, but I
wanted to get this out for review and testing.  It should at least help
us decide if the request allocation code really is causing our problems.

The patch below also includes the __get_request_wait latency stats.  If
people try this and still see stalls, please run elvtune /dev/xxxx and
send along the resulting console output.

I haven't yet compared this to Andrea's elevator latency code, but the
stat patch was originally developed on top of his 2.4.21pre3aa1, where
the average wait was 97 jiffies and the max was 318.

Anyway, less talk, more code.  Treat this with care, it has only been
lightly tested.  Thanks to Andrea and Nick whose patches this is largely
based on:

--- 1.9/drivers/block/blkpg.c	Sat Mar 30 06:58:05 2002
+++ edited/drivers/block/blkpg.c	Mon Jun  9 12:17:24 2003
@@ -261,6 +261,7 @@
 			return blkpg_ioctl(dev, (struct blkpg_ioctl_arg *) arg);
 			
 		case BLKELVGET:
+			blk_print_stats(dev);
 			return blkelvget_ioctl(&blk_get_queue(dev)->elevator,
 					       (blkelv_ioctl_arg_t *) arg);
 		case BLKELVSET:
--- 1.45/drivers/block/ll_rw_blk.c	Wed May 28 03:50:02 2003
+++ edited/drivers/block/ll_rw_blk.c	Mon Jun  9 17:13:16 2003
@@ -429,6 +429,8 @@
 	q->rq[READ].count = 0;
 	q->rq[WRITE].count = 0;
 	q->nr_requests = 0;
+	q->read_full = 0;
+	q->write_full = 0;
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
@@ -442,6 +444,56 @@
 	spin_lock_init(&q->queue_lock);
 }
 
+void blk_print_stats(kdev_t dev) 
+{
+	request_queue_t *q;
+	unsigned long avg_wait;
+	unsigned long min_wait;
+	unsigned long high_wait;
+	unsigned long *d;
+
+	q = blk_get_queue(dev);
+	if (!q)
+		return;
+
+	min_wait = q->min_wait;
+	if (min_wait == ~0UL)
+		min_wait = 0;
+	if (q->num_wait) 
+		avg_wait = q->total_wait / q->num_wait;
+	else
+		avg_wait = 0;
+	printk("device %s: num_req %lu, total jiffies waited %lu\n", 
+	       kdevname(dev), q->num_req, q->total_wait);
+	printk("\t%lu forced to wait\n", q->num_wait);
+	printk("\t%lu min wait, %lu max wait\n", min_wait, q->max_wait);
+	printk("\t%lu average wait\n", avg_wait);
+	d = q->deviation;
+	printk("\t%lu < 100, %lu < 200, %lu < 300, %lu < 400, %lu < 500\n",
+               d[0], d[1], d[2], d[3], d[4]);
+	high_wait = d[0] + d[1] + d[2] + d[3] + d[4];
+	high_wait = q->num_wait - high_wait;
+	printk("\t%lu waits longer than 500 jiffies\n", high_wait);
+}
+
+static void reset_stats(request_queue_t *q)
+{
+	q->max_wait		= 0;
+	q->min_wait		= ~0UL;
+	q->total_wait		= 0;
+	q->num_req		= 0;
+	q->num_wait		= 0;
+	memset(q->deviation, 0, sizeof(q->deviation));
+}
+void blk_reset_stats(kdev_t dev) 
+{
+	request_queue_t *q;
+	q = blk_get_queue(dev);
+	if (!q)
+	    return;
+	printk("reset latency stats on device %s\n", kdevname(dev));
+	reset_stats(q);
+}
 static int __make_request(request_queue_t * q, int rw, struct buffer_head * bh);
 
 /**
@@ -491,6 +543,9 @@
 	q->plug_tq.routine	= &generic_unplug_device;
 	q->plug_tq.data		= q;
 	q->plugged        	= 0;
+
+	reset_stats(q);
+
 	/*
 	 * These booleans describe the queue properties.  We set the
 	 * default (and most common) values here.  Other drivers can
@@ -508,7 +563,7 @@
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.  Returns NULL if there are no free requests.
  */
-static struct request *get_request(request_queue_t *q, int rw)
+static struct request *__get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = q->rq + rw;
@@ -521,10 +576,17 @@
 		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
-	}
+	} else
+		set_queue_full(q, rw);
 
 	return rq;
 }
+static struct request *get_request(request_queue_t *q, int rw)
+{
+	if (queue_full(q, rw))
+		return NULL;
+	return __get_request(q, rw);
+}
 
 /*
  * Here's the request allocation design:
@@ -588,23 +650,57 @@
 static struct request *__get_request_wait(request_queue_t *q, int rw)
 {
 	register struct request *rq;
+	int waited = 0;
+	unsigned long wait_start = jiffies;
+	unsigned long time_waited;
 	DECLARE_WAITQUEUE(wait, current);
 
-	add_wait_queue(&q->wait_for_requests[rw], &wait);
+	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
+
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		generic_unplug_device(q);
-		if (q->rq[rw].count == 0)
-			schedule();
 		spin_lock_irq(&io_request_lock);
-		rq = get_request(q, rw);
+		if ((!waited && queue_full(q, rw)) || q->rq[rw].count == 0) {
+			__generic_unplug_device(q);
+			spin_unlock_irq(&io_request_lock);
+			schedule();
+			spin_lock_irq(&io_request_lock);
+			waited = 1;
+		}
+		rq = __get_request(q, rw);
 		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
 	remove_wait_queue(&q->wait_for_requests[rw], &wait);
 	current->state = TASK_RUNNING;
+
+	if (!waitqueue_active(&q->wait_for_requests[rw]))
+		clear_queue_full(q, rw);
+
+	time_waited = jiffies - wait_start;
+	if (time_waited > q->max_wait)
+		q->max_wait = time_waited;
+	if (time_waited && time_waited < q->min_wait)
+		q->min_wait = time_waited;
+	q->total_wait += time_waited;
+	q->num_wait++;
+	if (time_waited < 500) {
+		q->deviation[time_waited/100]++;
+	}
+
 	return rq;
 }
 
+static void get_request_wait_wakeup(request_queue_t *q, int rw)
+{
+	/*
+	 * avoid losing an unplug if a second __get_request_wait did the
+	 * generic_unplug_device while our __get_request_wait was running
+	 * w/o the queue_lock held and w/ our request out of the queue.
+	 */
+	if (waitqueue_active(&q->wait_for_requests[rw]))
+		wake_up(&q->wait_for_requests[rw]);
+}
+
 /* RO fail safe mechanism */
 
 static long ro_bits[MAX_BLKDEV][8];
@@ -829,8 +925,14 @@
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests)
-			wake_up(&q->wait_for_requests[rw]);
+		q->rq[rw].count++;
+		if (q->rq[rw].count >= q->batch_requests) {
+			smp_mb();
+			if (waitqueue_active(&q->wait_for_requests[rw]))
+				wake_up(&q->wait_for_requests[rw]);
+			else
+				clear_queue_full(q, rw);
+		}
 	}
 }
 
@@ -948,7 +1050,6 @@
 	 */
 	max_sectors = get_max_sectors(bh->b_rdev);
 
-again:
 	req = NULL;
 	head = &q->queue_head;
 	/*
@@ -957,6 +1058,7 @@
 	 */
 	spin_lock_irq(&io_request_lock);
 
+again:
 	insert_here = head->prev;
 	if (list_empty(head)) {
 		q->plug_device_fn(q, bh->b_rdev); /* is atomic */
@@ -1042,6 +1144,9 @@
 			if (req == NULL) {
 				spin_unlock_irq(&io_request_lock);
 				freereq = __get_request_wait(q, rw);
+				head = &q->queue_head;
+				spin_lock_irq(&io_request_lock);
+				get_request_wait_wakeup(q, rw);
 				goto again;
 			}
 		}
@@ -1063,6 +1168,7 @@
 	req->rq_dev = bh->b_rdev;
 	req->start_time = jiffies;
 	req_new_io(req, 0, count);
+	q->num_req++;
 	blk_started_io(count);
 	add_request(q, req, insert_here);
 out:
@@ -1196,8 +1302,15 @@
 	bh->b_rdev = bh->b_dev;
 	bh->b_rsector = bh->b_blocknr * count;
 
+	get_bh(bh);
 	generic_make_request(rw, bh);
 
+	/* fix race condition with wait_on_buffer() */
+	smp_mb(); /* spin_unlock may have inclusive semantics */
+	if (waitqueue_active(&bh->b_wait))
+		wake_up(&bh->b_wait);
+
+	put_bh(bh);
 	switch (rw) {
 		case WRITE:
 			kstat.pgpgout += count;
--- 1.83/fs/buffer.c	Wed May 14 12:51:00 2003
+++ edited/fs/buffer.c	Mon Jun  9 13:55:22 2003
@@ -153,10 +153,23 @@
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
@@ -1507,6 +1520,9 @@
 
 	/* Done - end_buffer_io_async will unlock */
 	SetPageUptodate(page);
+
+	wakeup_page_waiters(page);
+
 	return 0;
 
 out:
@@ -1538,6 +1554,7 @@
 	} while (bh != head);
 	if (need_unlock)
 		UnlockPage(page);
+	wakeup_page_waiters(page);
 	return err;
 }
 
@@ -1765,6 +1782,8 @@
 		else
 			submit_bh(READ, bh);
 	}
+
+	wakeup_page_waiters(page);
 	
 	return 0;
 }
@@ -2378,6 +2397,7 @@
 		submit_bh(rw, bh);
 		bh = next;
 	} while (bh != head);
+	wakeup_page_waiters(page);
 	return 0;
 }
 
--- 1.49/fs/super.c	Wed Dec 18 21:34:24 2002
+++ edited/fs/super.c	Mon Jun  9 12:17:24 2003
@@ -726,6 +726,7 @@
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto Einval;
 	s->s_flags |= MS_ACTIVE;
+	blk_reset_stats(dev);
 	path_release(&nd);
 	return s;
 
--- 1.45/fs/reiserfs/inode.c	Thu May 22 16:35:02 2003
+++ edited/fs/reiserfs/inode.c	Mon Jun  9 12:17:24 2003
@@ -2048,6 +2048,7 @@
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         UnlockPage(page) ;
     }
--- 1.23/include/linux/blkdev.h	Fri Nov 29 17:03:01 2002
+++ edited/include/linux/blkdev.h	Mon Jun  9 17:31:18 2003
@@ -126,6 +126,14 @@
 	 */
 	char			head_active;
 
+	/*
+	 * Booleans that indicate whether the queue's free requests have
+	 * been exhausted and is waiting to drop below the batch_requests
+	 * threshold
+	 */
+	char			read_full;
+	char			write_full;
+
 	unsigned long		bounce_pfn;
 
 	/*
@@ -138,8 +146,17 @@
 	 * Tasks wait here for free read and write requests
 	 */
 	wait_queue_head_t	wait_for_requests[2];
+	unsigned long           max_wait;
+	unsigned long           min_wait;
+	unsigned long           total_wait;
+	unsigned long           num_req;
+	unsigned long           num_wait;
+	unsigned long           deviation[5];
 };
 
+void blk_reset_stats(kdev_t dev);
+void blk_print_stats(kdev_t dev);
+
 #define blk_queue_plugged(q)	(q)->plugged
 #define blk_fs_request(rq)	((rq)->cmd == READ || (rq)->cmd == WRITE)
 #define blk_queue_empty(q)	list_empty(&(q)->queue_head)
@@ -156,6 +173,33 @@
 	}
 }
 
+static inline void set_queue_full(request_queue_t *q, int rw)
+{
+	wmb();
+	if (rw == READ)
+		q->read_full = 1;
+	else
+		q->write_full = 1;
+}
+
+static inline void clear_queue_full(request_queue_t *q, int rw)
+{
+	wmb();
+	if (rw == READ)
+		q->read_full = 0;
+	else
+		q->write_full = 0;
+}
+
+static inline int queue_full(request_queue_t *q, int rw)
+{
+	rmb();
+	if (rw == READ)
+		return q->read_full;
+	else
+		return q->write_full;
+}
+
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 #define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
@@ -217,6 +261,7 @@
 extern void generic_make_request(int rw, struct buffer_head * bh);
 extern inline request_queue_t *blk_get_queue(kdev_t dev);
 extern void blkdev_release_request(struct request *);
+extern void blk_print_stats(kdev_t dev);
 
 /*
  * Access functions for manipulating queue properties
--- 1.19/include/linux/pagemap.h	Sun Aug 25 15:32:11 2002
+++ edited/include/linux/pagemap.h	Mon Jun  9 14:47:11 2003
@@ -97,6 +97,8 @@
 		___wait_on_page(page);
 }
 
+extern void FASTCALL(wakeup_page_waiters(struct page * page));
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
--- 1.68/kernel/ksyms.c	Fri May 23 17:40:47 2003
+++ edited/kernel/ksyms.c	Mon Jun  9 12:17:24 2003
@@ -295,6 +295,7 @@
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);
--- 1.77/mm/filemap.c	Thu Apr 24 11:05:10 2003
+++ edited/mm/filemap.c	Mon Jun  9 12:17:24 2003
@@ -812,6 +812,20 @@
 	return &wait[hash];
 }
 
+/*
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
 /* 
  * Wait for a page to get unlocked.
  *





