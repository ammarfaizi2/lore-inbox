Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTFZPmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 11:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTFZPmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 11:42:07 -0400
Received: from 216-42-72-146.ppp.netsville.net ([216.42.72.146]:1675 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S261960AbTFZPlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 11:41:53 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <3EFAEF71.1080109@cyberone.com.au>
References: <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
	 <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
	 <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
	 <20030612012951.GG1500@dualathlon.random>
	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>
	 <20030612024608.GE1415@dualathlon.random>
	 <1056567822.10097.133.camel@tiny.suse.com>
	 <3EFA8920.8050509@cyberone.com.au>
	 <1056628116.20899.28.camel@tiny.suse.com>
	 <3EFAEF71.1080109@cyberone.com.au>
Content-Type: multipart/mixed; boundary="=-pV1B75c5FUigm0GXo5+0"
Organization: 
Message-Id: <1056642911.20899.88.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Jun 2003 11:55:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pV1B75c5FUigm0GXo5+0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-06-26 at 09:04, Nick Piggin wrote:

> >One of the things I tried in this area was basically queue ownership. 
> >When each process woke up, he was given strict ownership of the queue
> >and could submit up to N number of requests.  One process waited for
> >ownership in a yield loop for a max limit of a certain number of
> >jiffies, all the others waited on the request queue.
> >
> 
> Not sure exactly what you mean by one process waiting for ownership
> in a yield loop, but why don't you simply allow the queue "owner" to
> submit up to a maximum of N requests within a time limit. Once either
> limit expires (or, rarely, another might become owner -) the process
> would just be put to sleep by the normal queue_full mechanism.
> 

You need some way to wakeup the queue after that time limit has expired,
in case the owner never submits another request.  This can either be a
timer or a process in a yield loop.  Given that very short expire time I
set (10 jiffies), I went for the yield loop.

> >
> >It generally increased the latency in __get_request wait by a multiple
> >of N.  I didn't keep it because the current patch is already full of
> >subtle interactions, I didn't want to make things more confusing than
> >they already were ;-)
> >
> 
> Yeah, something like that. I think that in a queue full situation,
> the processes are wanting to submit more than 1 request though. So
> the better thoughput you can achieve by batching translates to
> better effective throughput. Read my recent debate with Andrea
> about this though - I couldn't convince him!
> 

Well, it depends ;-) I think we've got 3 basic kinds of procs during a
q->full condition:

1) wants to submit lots of somewhat contiguous io
2) wants to submit a single io
3) wants to submit lots of random io

>From a throughput point of view, we only care about giving batch
ownership to #1.  giving batch ownership to #3 will help reduce context
switches, but if it helps throughput than the io wasn't really random
(you've got a good point about locality below, drive write caches make a
huge difference there).

The problem I see in 2.4 is the elevator can't tell any of these cases
apart, so any attempt at batch ownership is certain to be wrong at least
part of the time.

> I have seen much better maximum latencies, 2-3 times the
> throughput, and an order of magnitude less context switching on
> many threaded tiobench write loads when using batching.
> 
> In short, measuring get_request latency won't give you the full
> story.
> 

Very true.  But get_request latency is the minimum amount of time a
single read is going to wait (in 2.4.x anyway), and that is what we need
to focus on when we're trying to fix interactive performance.

> >
> >The real problem with this approach is that we're guessing about the
> >number of requests a given process wants to submit, and we're assuming
> >those requests are going to be highly mergable.  If the higher levels
> >pass these hints down to the elevator, we should be able to do a better
> >job of giving both low latency and high throughput.
> >
> 
> No, the numbers (batch # requests, batch time) are not highly scientific.
> Simply when a process wakes up, we'll let them submit a small burst of
> requests before they go back to sleep. Now in 2.5 (mm) we can cheat and
> make this more effective, fair, and without possible missed wakes because
> io contexts means that multiple processes can be batching at the same
> time, and dynamically allocated requests means it doesn't matter if we
> go a bit over the queue limit.
> 

I agree 2.5 has a lot more room for the contexts to be effective, and I
think they are a really good idea.

> I think a decent solution for 2.4 would be to simply have the one queue
> owner, but he allowed the queue to fall below the batch limit, wake
> someone else and make them the owner. It can be a bit less fair, and
> it doesn't work across queues, but they're less important cases.
> 
> >
> >Between bios and the pdflush daemons, I think 2.5 is in pretty good
> >shape to do what we need.  I'm not 100% sure we need batching when the
> >requests being submitted are not highly mergable, but I haven't put lots
> >of thought into that part yet.
> >
> 
> No, there are a couple of problems here.
> First, good locality != sequential. I saw tiobench 256 random write
> throughput _doubled_ because each process is writing within its own
> file.
> 
> Second, mergeable doesn't mean anything if your request size only
> grows to say 128KB (IDE). I saw tiobench 256 sequential writes on IDE
> go from ~ 25% peak throughput to ~70% (4.85->14.11 from 20MB/s disk)

Well, play around with raw io, my box writes at roughly disk speed with
128k synchronous requests (contiguous writes).

> Third, context switch rate. In the latest IBM regression tests,
> tiobench 64 on ext2, 8xSMP (so don't look at throughput!), average
> cs/s was about 2500 with mainline (FIFO request allocation), and
> 140 in mm (batching allocation). So nearly 20x better. This might
> not be due to batching alone, but I didn't see any other obvious
> change in mm.
> 

Makes sense.

> >
> >Anyway for 2.4 I'm not sure there's much more we can do.  I'd like to
> >add tunables to the current patch, so userland can control the max io in
> >flight and a simple toggle between throughput mode and latency mode on a
> >per device basis.  It's not perfect but should tide us over until 2.6.
> >
> >
> 
> The changes do seem to be a critical fix due to the starvation issue,
> but I'm worried that they take a big step back in performance under
> high disk load. I found my FIFO mechanism to be unacceptably slow for
> 2.5.

Me too, but I'm not sure how to fix it other than a userspace knob to
turn off the q->full checks for server workloads.  Andrea's
elevator-lowlatency alone has pretty good throughput numbers, since it
still allows request stealing.  Its get_request_wait latency numbers
aren't horrible either, it only suffers in a few corner cases.

But, if someone wants to play with this more, I've attached a quick
remerge of my batch ownership code.  I made a read and write owner, so
that a reader doing a single request doesn't grab ownership and make all
the writes wait.

It does make throughput better overall, and it also makes latencies
worse overall.  We'll probably get similar results just by disabling
q->full in io-stalls-7, but the batch ownership does a better job of
limiting get_request latencies at a fixed (although potentially large)
number.

lat-stat-5.diff goes on top of io-stalls-7.diff from yesterday
batch_owner.diff goes on top of lat-stat-5.diff.

-chris


--=-pV1B75c5FUigm0GXo5+0
Content-Disposition: attachment; filename=batch_owner.diff
Content-Type: text/plain; name=batch_owner.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/block/ll_rw_blk.c 1.47 vs edited =====
--- 1.47/drivers/block/ll_rw_blk.c	Thu Jun 26 09:20:08 2003
+++ edited/drivers/block/ll_rw_blk.c	Thu Jun 26 10:52:17 2003
@@ -592,6 +592,8 @@
 	q->full			= 0;
 	q->can_throttle		= 0;
 
+	memset(q->batch, 0, sizeof(struct queue_batch) * 2);
+
 	reset_stats(q);
 
 	/*
@@ -606,6 +608,48 @@
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 }
 
+#define MSEC(x) ((x) * 1000 / HZ)
+#define BATCH_MAX_AGE 100
+int grab_batch_ownership(request_queue_t *q, int rw)
+{
+	struct task_struct *tsk = current;
+	unsigned long age;
+	struct queue_batch *batch = q->batch + rw;
+
+	if (batch->batch_waiter)
+		return 0;
+	if (!batch->batch_owner)
+		goto grab;
+	batch->batch_waiter = tsk;
+	while(1) {
+		age = jiffies - batch->batch_jiffies;
+		if (!batch->batch_owner || MSEC(age) > BATCH_MAX_AGE)
+			break;
+		set_current_state(TASK_RUNNING);
+		spin_unlock_irq(&io_request_lock);
+		schedule();
+		spin_lock_irq(&io_request_lock);
+	}
+	batch->batch_waiter = NULL;
+grab:
+	batch->batch_owner = tsk;
+	batch->batch_jiffies = jiffies;
+	batch->batch_remaining = q->batch_requests;
+	return 1;
+}
+
+void decrement_batch_request(request_queue_t *q, int rw)
+{
+	struct queue_batch *batch = q->batch + rw;
+	if (batch->batch_owner == current) {
+		batch->batch_remaining--;
+		if (!batch->batch_remaining || 
+		    MSEC(jiffies - batch->batch_jiffies) > BATCH_MAX_AGE) {
+			batch->batch_owner = NULL;
+		}
+	}
+}
+
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queue);
 /*
  * Get a free request. io_request_lock must be held and interrupts
@@ -625,6 +669,7 @@
 		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
+		decrement_batch_request(q, rw);
 	} else
 		q->full = 1;
 	return rq;
@@ -635,7 +680,7 @@
  */
 static inline struct request *get_request(request_queue_t *q, int rw)
 {
-	if (q->full)
+	if (q->full && q->batch[rw].batch_owner != current)
 		return NULL;
 	return __get_request(q, rw);
 }
@@ -698,25 +743,28 @@
 
 static struct request *__get_request_wait(request_queue_t *q, int rw)
 {
-	register struct request *rq;
+	register struct request *rq = NULL;
 	unsigned long wait_start = jiffies;
 	unsigned long time_waited;
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue_exclusive(&q->wait_for_requests, &wait);
 
+	spin_lock_irq(&io_request_lock);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		spin_lock_irq(&io_request_lock);
 		if (q->full || blk_oversized_queue(q)) {
-			__generic_unplug_device(q);
+			if (blk_oversized_queue(q))
+				__generic_unplug_device(q);
 			spin_unlock_irq(&io_request_lock);
 			schedule();
 			spin_lock_irq(&io_request_lock);
+			if (!grab_batch_ownership(q, rw))
+				continue;
 		}
 		rq = __get_request(q, rw);
-		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
+	spin_unlock_irq(&io_request_lock);
 	remove_wait_queue(&q->wait_for_requests, &wait);
 	current->state = TASK_RUNNING;
 
@@ -978,9 +1026,9 @@
 		list_add(&req->queue, &q->rq.free);
 		if (q->rq.count >= q->batch_requests && !oversized_batch) {
 			smp_mb();
-			if (waitqueue_active(&q->wait_for_requests))
+			if (waitqueue_active(&q->wait_for_requests)) {
 				wake_up(&q->wait_for_requests);
-			else
+			} else
 				clear_full_and_wake(q);
 		}
 	}
===== include/linux/blkdev.h 1.25 vs edited =====
--- 1.25/include/linux/blkdev.h	Thu Jun 26 09:20:08 2003
+++ edited/include/linux/blkdev.h	Thu Jun 26 10:50:17 2003
@@ -69,6 +69,15 @@
 	struct list_head free;
 };
 
+struct queue_batch
+{
+	struct task_struct 	*batch_owner;
+	struct task_struct 	*batch_waiter;
+	unsigned long		batch_jiffies;
+	int			batch_remaining;
+	
+};
+
 struct request_queue
 {
 	/*
@@ -141,7 +150,7 @@
 	 * threshold
 	 */
 	int			full:1;
-	
+
 	/*
 	 * Boolean that indicates you will use blk_started_sectors
 	 * and blk_finished_sectors in addition to blk_started_io
@@ -162,6 +171,9 @@
 	 * Tasks wait here for free read and write requests
 	 */
 	wait_queue_head_t	wait_for_requests;
+
+	struct queue_batch	batch[2];
+
 	unsigned long           max_wait;
 	unsigned long           min_wait;
 	unsigned long           total_wait;
@@ -278,7 +290,7 @@
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
-#define MAX_QUEUE_SECTORS (2 << (20 - 9)) /* 4 mbytes when full sized */
+#define MAX_QUEUE_SECTORS (4 << (20 - 9)) /* 4 mbytes when full sized */
 #define MAX_NR_REQUESTS 1024 /* 1024k when in 512 units, normally min is 1M in 1k units */
 
 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)

--=-pV1B75c5FUigm0GXo5+0
Content-Disposition: attachment; filename=lat-stat-5.diff
Content-Type: text/plain; name=lat-stat-5.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

reverted:
--- b/drivers/block/blkpg.c	Thu Jun 26 09:12:14 2003
+++ a/drivers/block/blkpg.c	Thu Jun 26 09:12:14 2003
@@ -261,6 +261,7 @@
 			return blkpg_ioctl(dev, (struct blkpg_ioctl_arg *) arg);
 			
 		case BLKELVGET:
+			blk_print_stats(dev);
 			return blkelvget_ioctl(&blk_get_queue(dev)->elevator,
 					       (blkelv_ioctl_arg_t *) arg);
 		case BLKELVSET:
reverted:
--- b/drivers/block/ll_rw_blk.c	Thu Jun 26 09:12:14 2003
+++ a/drivers/block/ll_rw_blk.c	Thu Jun 26 09:12:14 2003
@@ -490,6 +490,56 @@
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
@@ -542,6 +592,8 @@
 	q->full			= 0;
 	q->can_throttle		= 0;
 
+	reset_stats(q);
+
 	/*
 	 * These booleans describe the queue properties.  We set the
 	 * default (and most common) values here.  Other drivers can
@@ -647,6 +699,8 @@
 static struct request *__get_request_wait(request_queue_t *q, int rw)
 {
 	register struct request *rq;
+	unsigned long wait_start = jiffies;
+	unsigned long time_waited;
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue_exclusive(&q->wait_for_requests, &wait);
@@ -669,6 +723,17 @@
 	if (!waitqueue_active(&q->wait_for_requests))
 		clear_full_and_wake(q);
 
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
 
@@ -1157,6 +1222,7 @@
 	req->rq_dev = bh->b_rdev;
 	req->start_time = jiffies;
 	req_new_io(req, 0, count);
+	q->num_req++;
 	blk_started_io(count);
 	blk_started_sectors(req, count);
 	add_request(q, req, insert_here);
reverted:
--- b/fs/super.c	Thu Jun 26 09:12:14 2003
+++ a/fs/super.c	Thu Jun 26 09:12:14 2003
@@ -726,6 +726,7 @@
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto Einval;
 	s->s_flags |= MS_ACTIVE;
+	blk_reset_stats(dev);
 	path_release(&nd);
 	return s;
 
reverted:
--- b/include/linux/blkdev.h	Thu Jun 26 09:12:14 2003
+++ a/include/linux/blkdev.h	Thu Jun 26 09:12:14 2003
@@ -162,8 +162,17 @@
 	 * Tasks wait here for free read and write requests
 	 */
 	wait_queue_head_t	wait_for_requests;
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
@@ -269,7 +278,7 @@
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
+#define MAX_QUEUE_SECTORS (2 << (20 - 9)) /* 4 mbytes when full sized */
-#define MAX_QUEUE_SECTORS (2 << (20 - 9)) /* 2 mbytes when full sized */
 #define MAX_NR_REQUESTS 1024 /* 1024k when in 512 units, normally min is 1M in 1k units */
 
 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)

--=-pV1B75c5FUigm0GXo5+0--

