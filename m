Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTFKRac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTFKRac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:30:32 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:63922 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S263305AbTFKR35
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:29:57 -0400
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030611021030.GQ26270@dualathlon.random>
References: <200306041235.07832.m.c.p@wolk-project.de>
	 <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030611003356.GN26270@dualathlon.random>
	 <1055292839.24111.180.camel@tiny.suse.com>
	 <20030611010628.GO26270@dualathlon.random>
	 <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
Content-Type: multipart/mixed; boundary="=-6wZYFOwio3VCkXVJnXRH"
Organization: 
Message-Id: <1055353360.23697.235.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jun 2003 13:42:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6wZYFOwio3VCkXVJnXRH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok here's an updated patch, it changes the barriers around, updates
comments, and gets rid of the waited check in __get_request_wait.  It is
still a combined patch with fix_pausing, queue_full and latency stats,
mostly because I want to make really sure any testers are using all
three.

So, if someone who saw io stalls in 2.4.21-rc could give this a try, I'd
be grateful.  If you still see stalls with this applied, run elvtune
/dev/xxx and send along the resulting console output.

-chris


--=-6wZYFOwio3VCkXVJnXRH
Content-Disposition: attachment; filename=io-stalls-5.diff
Content-Type: text/plain; name=io-stalls-5.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- 1.9/drivers/block/blkpg.c	Sat Mar 30 06:58:05 2002
+++ edited/drivers/block/blkpg.c	Tue Jun 10 14:49:27 2003
@@ -261,6 +261,7 @@
 			return blkpg_ioctl(dev, (struct blkpg_ioctl_arg *) arg);
 			
 		case BLKELVGET:
+			blk_print_stats(dev);
 			return blkelvget_ioctl(&blk_get_queue(dev)->elevator,
 					       (blkelv_ioctl_arg_t *) arg);
 		case BLKELVSET:
--- 1.45/drivers/block/ll_rw_blk.c	Wed May 28 03:50:02 2003
+++ edited/drivers/block/ll_rw_blk.c	Wed Jun 11 13:36:10 2003
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
@@ -521,35 +576,48 @@
 		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
-	}
+	} else
+		set_queue_full(q, rw);
 
 	return rq;
 }
 
 /*
- * Here's the request allocation design:
+ * get a free request, honoring the queue_full condition
+ */
+static inline struct request *get_request(request_queue_t *q, int rw)
+{
+	if (queue_full(q, rw))
+		return NULL;
+	return __get_request(q, rw);
+}
+
+/* 
+ * helper func to do memory barriers and wakeups when we finally decide
+ * to clear the queue full condition
+ */
+static inline void clear_full_and_wake(request_queue_t *q, int rw)
+{
+	clear_queue_full(q, rw);
+	mb();
+	if (unlikely(waitqueue_active(&q->wait_for_requests[rw])))
+		wake_up(&q->wait_for_requests[rw]);
+}
+
+/*
+ * Here's the request allocation design, low latency version:
  *
  * 1: Blocking on request exhaustion is a key part of I/O throttling.
  * 
  * 2: We want to be `fair' to all requesters.  We must avoid starvation, and
  *    attempt to ensure that all requesters sleep for a similar duration.  Hence
  *    no stealing requests when there are other processes waiting.
- * 
- * 3: We also wish to support `batching' of requests.  So when a process is
- *    woken, we want to allow it to allocate a decent number of requests
- *    before it blocks again, so they can be nicely merged (this only really
- *    matters if the process happens to be adding requests near the head of
- *    the queue).
- * 
- * 4: We want to avoid scheduling storms.  This isn't really important, because
- *    the system will be I/O bound anyway.  But it's easy.
- * 
- *    There is tension between requirements 2 and 3.  Once a task has woken,
- *    we don't want to allow it to sleep as soon as it takes its second request.
- *    But we don't want currently-running tasks to steal all the requests
- *    from the sleepers.  We handle this with wakeup hysteresis around
- *    0 .. batch_requests and with the assumption that request taking is much,
- *    much faster than request freeing.
+ *
+ * There used to be more here, attempting to allow a process to send in a
+ * number of requests once it has woken up.  But, there's no way to 
+ * tell if a process has just been woken up, or if it is a new process
+ * coming in to steal requests from the waiters.  So, we give up and force
+ * everyone to wait fairly.
  * 
  * So here's what we do:
  * 
@@ -561,50 +629,78 @@
  * 
  *  When a process wants a new request:
  * 
- *    b) If free_requests == 0, the requester sleeps in FIFO manner.
- * 
- *    b) If 0 <  free_requests < batch_requests and there are waiters,
- *       we still take a request non-blockingly.  This provides batching.
- *
- *    c) If free_requests >= batch_requests, the caller is immediately
- *       granted a new request.
+ *    b) If free_requests == 0, the requester sleeps in FIFO manner, and
+ *       the queue full condition is set.  The full condition is not
+ *       cleared until there are no longer any waiters.  Once the full
+ *       condition is set, all new io must wait, hopefully for a very
+ *       short period of time.
  * 
  *  When a request is released:
  * 
- *    d) If free_requests < batch_requests, do nothing.
- * 
- *    f) If free_requests >= batch_requests, wake up a single waiter.
- * 
- *   The net effect is that when a process is woken at the batch_requests level,
- *   it will be able to take approximately (batch_requests) requests before
- *   blocking again (at the tail of the queue).
+ *    c) If free_requests < batch_requests, do nothing.
  * 
- *   This all assumes that the rate of taking requests is much, much higher
- *   than the rate of releasing them.  Which is very true.
+ *    d) If free_requests >= batch_requests, wake up a single waiter.
  *
- * -akpm, Feb 2002.
+ *   As each waiter gets a request, he wakes another waiter.  We do this
+ *   to prevent a race where an unplug might get run before a request makes
+ *   it's way onto the queue.  The result is a cascade of wakeups, so delaying
+ *   the initial wakeup until we've got batch_requests available helps avoid
+ *   wakeups where there aren't any requests available yet.
  */
 
 static struct request *__get_request_wait(request_queue_t *q, int rw)
 {
 	register struct request *rq;
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
+		if (queue_full(q, rw) || q->rq[rw].count == 0) {
+			if (q->rq[rw].count == 0)
+				__generic_unplug_device(q);
+			spin_unlock_irq(&io_request_lock);
+			schedule();
+			spin_lock_irq(&io_request_lock);
+		}
+		rq = __get_request(q, rw);
 		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
 	remove_wait_queue(&q->wait_for_requests[rw], &wait);
 	current->state = TASK_RUNNING;
+
+	if (!waitqueue_active(&q->wait_for_requests[rw]))
+		clear_full_and_wake(q, rw);
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
+				clear_full_and_wake(q, rw);
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
+++ edited/fs/buffer.c	Wed Jun 11 09:56:27 2003
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
+++ edited/fs/super.c	Tue Jun 10 14:49:27 2003
@@ -726,6 +726,7 @@
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto Einval;
 	s->s_flags |= MS_ACTIVE;
+	blk_reset_stats(dev);
 	path_release(&nd);
 	return s;
 
--- 1.45/fs/reiserfs/inode.c	Thu May 22 16:35:02 2003
+++ edited/fs/reiserfs/inode.c	Tue Jun 10 14:49:27 2003
@@ -2048,6 +2048,7 @@
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         UnlockPage(page) ;
     }
--- 1.23/include/linux/blkdev.h	Fri Nov 29 17:03:01 2002
+++ edited/include/linux/blkdev.h	Wed Jun 11 09:56:55 2003
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
@@ -156,6 +173,30 @@
 	}
 }
 
+static inline void set_queue_full(request_queue_t *q, int rw)
+{
+	if (rw == READ)
+		q->read_full = 1;
+	else
+		q->write_full = 1;
+}
+
+static inline void clear_queue_full(request_queue_t *q, int rw)
+{
+	if (rw == READ)
+		q->read_full = 0;
+	else
+		q->write_full = 0;
+}
+
+static inline int queue_full(request_queue_t *q, int rw)
+{
+	if (rw == READ)
+		return q->read_full;
+	else
+		return q->write_full;
+}
+
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 #define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
@@ -217,6 +258,7 @@
 extern void generic_make_request(int rw, struct buffer_head * bh);
 extern inline request_queue_t *blk_get_queue(kdev_t dev);
 extern void blkdev_release_request(struct request *);
+extern void blk_print_stats(kdev_t dev);
 
 /*
  * Access functions for manipulating queue properties
--- 1.19/include/linux/pagemap.h	Sun Aug 25 15:32:11 2002
+++ edited/include/linux/pagemap.h	Wed Jun 11 08:57:12 2003
@@ -97,6 +97,8 @@
 		___wait_on_page(page);
 }
 
+extern void FASTCALL(wakeup_page_waiters(struct page * page));
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
--- 1.68/kernel/ksyms.c	Fri May 23 17:40:47 2003
+++ edited/kernel/ksyms.c	Tue Jun 10 14:49:27 2003
@@ -295,6 +295,7 @@
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);
--- 1.77/mm/filemap.c	Thu Apr 24 11:05:10 2003
+++ edited/mm/filemap.c	Tue Jun 10 14:49:28 2003
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

--=-6wZYFOwio3VCkXVJnXRH--

