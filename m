Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTGFSiU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 14:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTGFSiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 14:38:20 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:48049 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S266737AbTGFSiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 14:38:00 -0400
Subject: Re: Status of the IO scheduler fixes for 2.4
From: Chris Mason <mason@suse.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>,
       Nick Piggin <piggin@cyberone.com.au>
In-Reply-To: <200307060958.36642.m.c.p@wolk-project.de>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva>
	 <1057354654.20903.1280.camel@tiny.suse.com>
	 <200307060958.36642.m.c.p@wolk-project.de>
Content-Type: multipart/mixed; boundary="=-p0X6n9mswUGSW0OCQ5Wf"
Organization: 
Message-Id: <1057517497.20904.1322.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Jul 2003 14:51:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p0X6n9mswUGSW0OCQ5Wf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-07-06 at 03:58, Marc-Christian Petersen wrote:
> On Friday 04 July 2003 23:37, Chris Mason wrote:
> 
> Hi Chris,
> 
> > > If the IO fairness still doesnt
> > > get somewhat better for general use (well get isolated user reports and
> > > benchmarks for both the two patches), then I might consider the q->full
> > > patch (it has throughtput drawbacks and I prefer avoiding a tunable
> > > there).
> now there is io-stalls-10 in .22-pre3 (lowlat elev. + fixpausing). Could you 
> please send "q->full patch" as ontop of -pre3? :-)

Attached, this defaults to q->full off and keeps the elvtune changes. 
So to turn on the q->full low latency fixes, you need to:

elvtune -b 1 /dev/xxxx

Note that for lvm and md, you need to elvtune each underlying device. 
Running it on an lvm/md device doesn't do anything.

-chris


--=-p0X6n9mswUGSW0OCQ5Wf
Content-Disposition: attachment; filename=q_full.diff
Content-Type: text/plain; name=q_full.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- 1.9/drivers/block/blkpg.c	Sat Mar 30 06:58:05 2002
+++ edited/drivers/block/blkpg.c	Sun Jul  6 14:34:31 2003
@@ -261,10 +261,10 @@
 			return blkpg_ioctl(dev, (struct blkpg_ioctl_arg *) arg);
 			
 		case BLKELVGET:
-			return blkelvget_ioctl(&blk_get_queue(dev)->elevator,
+			return blkelvget_ioctl(blk_get_queue(dev),
 					       (blkelv_ioctl_arg_t *) arg);
 		case BLKELVSET:
-			return blkelvset_ioctl(&blk_get_queue(dev)->elevator,
+			return blkelvset_ioctl(blk_get_queue(dev),
 					       (blkelv_ioctl_arg_t *) arg);
 
 		case BLKBSZGET:
--- 1.8/drivers/block/elevator.c	Tue Oct 22 00:29:25 2002
+++ edited/drivers/block/elevator.c	Sun Jul  6 14:34:31 2003
@@ -180,23 +180,28 @@
 
 void elevator_noop_merge_req(struct request *req, struct request *next) {}
 
-int blkelvget_ioctl(elevator_t * elevator, blkelv_ioctl_arg_t * arg)
+int blkelvget_ioctl(request_queue_t *q, blkelv_ioctl_arg_t * arg)
 {
+	elevator_t *elevator = &q->elevator;
 	blkelv_ioctl_arg_t output;
 
 	output.queue_ID			= elevator->queue_ID;
 	output.read_latency		= elevator->read_latency;
 	output.write_latency		= elevator->write_latency;
-	output.max_bomb_segments	= 0;
-
+	output.max_bomb_segments	= q->max_queue_sectors;
+	if (q->low_latency)
+		output.max_bomb_segments |= MAX_BOMB_LATENCY_MASK;	
+	else
+		output.max_bomb_segments &= ~MAX_BOMB_LATENCY_MASK;	
 	if (copy_to_user(arg, &output, sizeof(blkelv_ioctl_arg_t)))
 		return -EFAULT;
 
 	return 0;
 }
 
-int blkelvset_ioctl(elevator_t * elevator, const blkelv_ioctl_arg_t * arg)
+int blkelvset_ioctl(request_queue_t *q, const blkelv_ioctl_arg_t * arg)
 {
+	elevator_t *elevator = &q->elevator;
 	blkelv_ioctl_arg_t input;
 
 	if (copy_from_user(&input, arg, sizeof(blkelv_ioctl_arg_t)))
@@ -206,9 +211,19 @@
 		return -EINVAL;
 	if (input.write_latency < 0)
 		return -EINVAL;
+	if (input.max_bomb_segments < 0)
+		return -EINVAL;
 
 	elevator->read_latency		= input.read_latency;
 	elevator->write_latency		= input.write_latency;
+	q->low_latency = input.max_bomb_segments & MAX_BOMB_LATENCY_MASK ? 1:0;
+	printk("queue %d: low latency mode is now %s\n", elevator->queue_ID, 
+		q->low_latency ? "on" : "off");
+	input.max_bomb_segments &= ~MAX_BOMB_LATENCY_MASK;
+	if (input.max_bomb_segments)
+		q->max_queue_sectors = input.max_bomb_segments;
+	printk("queue %d: max queue sectors is now %d\n", elevator->queue_ID, 
+		q->max_queue_sectors);
 	return 0;
 }
 
--- 1.46/drivers/block/ll_rw_blk.c	Fri Jul  4 13:35:08 2003
+++ edited/drivers/block/ll_rw_blk.c	Sun Jul  6 14:34:30 2003
@@ -379,8 +379,22 @@
 {
 	if (q->plugged) {
 		q->plugged = 0;
-		if (!list_empty(&q->queue_head))
+		if (!list_empty(&q->queue_head)) {
+
+			/* we don't want merges later on to come in 
+			 * and significantly increase the amount of
+			 * work during an unplug, it can lead to high
+			 * latencies while some poor waiter tries to
+			 * run an ever increasing chunk of io.
+			 * This does lower throughput some though.
+			 */
+			if (q->low_latency) {
+				struct request *rq;
+				rq = blkdev_entry_prev_request(&q->queue_head),
+				rq->elevator_sequence = 0;
+			}
 			q->request_fn(q);
+		}
 	}
 }
 
@@ -527,7 +541,9 @@
 	q->plug_tq.routine	= &generic_unplug_device;
 	q->plug_tq.data		= q;
 	q->plugged        	= 0;
+	q->full			= 0;
 	q->can_throttle		= 0;
+	q->low_latency		= 0;
 
 	/*
 	 * These booleans describe the queue properties.  We set the
@@ -546,7 +562,7 @@
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.  Returns NULL if there are no free requests.
  */
-static struct request *get_request(request_queue_t *q, int rw)
+static struct request *__get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
 	struct request_list *rl;
@@ -560,11 +576,34 @@
 		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
-	}
+	} else if (q->low_latency)
+		q->full = 1;
 	return rq;
 }
 
 /*
+ * get a free request, honoring the queue_full condition
+ */
+static inline struct request *get_request(request_queue_t *q, int rw)
+{
+	if (q->full)
+		return NULL;
+	return __get_request(q, rw);
+}
+
+/* 
+ * helper func to do memory barriers and wakeups when we finally decide
+ * to clear the queue full condition
+ */
+static inline void clear_full_and_wake(request_queue_t *q)
+{
+	q->full = 0;
+	mb();
+	if (waitqueue_active(&q->wait_for_requests))
+		wake_up(&q->wait_for_requests);
+}
+
+/*
  * Here's the request allocation design, low latency version:
  *
  * 1: Blocking on request exhaustion is a key part of I/O throttling.
@@ -612,24 +651,30 @@
 {
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
+	int oversized;
 
 	add_wait_queue_exclusive(&q->wait_for_requests, &wait);
 
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_lock_irq(&io_request_lock);
-		if (blk_oversized_queue(q)) {
-			__generic_unplug_device(q);
+		oversized = blk_oversized_queue(q);
+		if (q->full || oversized) {
+			if (oversized)
+				__generic_unplug_device(q);
 			spin_unlock_irq(&io_request_lock);
 			schedule();
 			spin_lock_irq(&io_request_lock);
 		}
-		rq = get_request(q, rw);
+		rq = __get_request(q, rw);
 		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
 	remove_wait_queue(&q->wait_for_requests, &wait);
 	current->state = TASK_RUNNING;
 
+	if (!waitqueue_active(&q->wait_for_requests))
+		clear_full_and_wake(q);
+
 	return rq;
 }
 
@@ -876,6 +921,8 @@
 			smp_mb();
 			if (waitqueue_active(&q->wait_for_requests))
 				wake_up(&q->wait_for_requests);
+			else
+				clear_full_and_wake(q);
 		}
 	}
 }
--- 1.24/include/linux/blkdev.h	Fri Jul  4 13:18:12 2003
+++ edited/include/linux/blkdev.h	Sun Jul  6 14:34:38 2003
@@ -136,12 +136,25 @@
 	int			head_active:1;
 
 	/*
+	 * Booleans that indicate whether the queue's free requests have
+	 * been exhausted and is waiting to drop below the batch_requests
+	 * threshold
+	 */
+	int			full:1;
+	
+	/*
 	 * Boolean that indicates you will use blk_started_sectors
 	 * and blk_finished_sectors in addition to blk_started_io
 	 * and blk_finished_io.  It enables the throttling code to 
 	 * help keep the sectors in flight to a reasonable value
 	 */
 	int			can_throttle:1;
+
+	/*
+	 * Boolean that indicates the queue should prefer low
+	 * latency over throughput.  This enables the q->full checks
+	 */
+	int			low_latency:1;
 
 	unsigned long		bounce_pfn;
 
--- 1.6/include/linux/elevator.h	Fri Jul  4 13:12:45 2003
+++ edited/include/linux/elevator.h	Sun Jul  6 14:34:31 2003
@@ -35,14 +35,19 @@
 	int queue_ID;
 	int read_latency;
 	int write_latency;
+/*
+ * (max_bomb_segments & MAX_BOMB_LATENCY_MASK) == 1 indicates low latency
+ * mode.  We're using any odd number to indicate low latency is on.
+ */
+#define MAX_BOMB_LATENCY_MASK 1
 	int max_bomb_segments;
 } blkelv_ioctl_arg_t;
 
 #define BLKELVGET   _IOR(0x12,106,sizeof(blkelv_ioctl_arg_t))
 #define BLKELVSET   _IOW(0x12,107,sizeof(blkelv_ioctl_arg_t))
 
-extern int blkelvget_ioctl(elevator_t *, blkelv_ioctl_arg_t *);
-extern int blkelvset_ioctl(elevator_t *, const blkelv_ioctl_arg_t *);
+extern int blkelvget_ioctl(request_queue_t *, blkelv_ioctl_arg_t *);
+extern int blkelvset_ioctl(request_queue_t *, const blkelv_ioctl_arg_t *);
 
 extern void elevator_init(elevator_t *, elevator_t);
 

--=-p0X6n9mswUGSW0OCQ5Wf--

