Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTE1X0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTE1X0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:26:35 -0400
Received: from 216-42-72-155.ppp.netsville.net ([216.42.72.155]:43664 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S261706AbTE1X0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:26:31 -0400
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20030528153922.GA845@suse.de>
References: <3ED2DE86.2070406@storadinc.com>
	 <200305281305.44073.m.c.p@wolk-project.de>
	 <20030528042700.47372139.akpm@digeo.com>
	 <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de>
	 <3ED4B49A.4050001@gmx.net> <20030528130839.GW845@suse.de>
	 <1054132096.32362.120.camel@tiny.suse.com> <20030528143333.GY845@suse.de>
	 <1054133920.32358.126.camel@tiny.suse.com>  <20030528153922.GA845@suse.de>
Content-Type: multipart/mixed; boundary="=-iHqcgH5VDfd65Gehx3z9"
Organization: 
Message-Id: <1054165116.32358.165.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 May 2003 19:38:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iHqcgH5VDfd65Gehx3z9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-05-28 at 11:39, Jens Axboe wrote:

> Correction then, it doesn't appear to be starvation in the usual sense.
> But you are right, pulling some stats out of the situation would be
> nice. I still can't reproduce here.

Well, it's not pretty but it gets some numbers out there.  This patch
only calculates the time spent waiting in __get_request_wait, it isn't
interested in any other metrics.  stats are per-queue and are reset when
you mount the FS, you get a print out either when you unmount the FS or
when you run elvtune /dev/xxx (no other args, just enough to trigger the
read ioctl).

The output looks like this (after a dbench 50 run 2.4.21-rc6)

device 03:04: num_req 12248, total jiffies waited 26729
        417 forced to wait
        1 min wait, 432 max wait
        64 average wait
        314 < 100, 62 < 200, 20 < 300, 20 < 400, 1 < 500
        0 waits longer than 500 jiffies

It tells us there were 12248 total requests (merges don't count), and
that we spent 26,729 jiffies waiting in __get_request_wait.  We had to
wait 417 times, the minimum was 1 and the max was 432 jiffies.  The line
with the < signs is a simple way to get the deviations.  314 requests
waited < 100 jiffies, 62 requests waited less than 200 jiffies, etc.

People who see stalls on UP machines and have seen improvements by
playing with code in drivers/block/ll_rw_blk.c are encouraged to try
getting numbers with this patch applied.  It will make it easier to
figure things out.

I haven't tried Andrea's fix-pausing on top of this yet, any rejects
should be minor.

-chris


--=-iHqcgH5VDfd65Gehx3z9
Content-Disposition: attachment; filename=lat-stat-3.diff
Content-Type: text/plain; name=lat-stat-3.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/block/blkpg.c 1.9 vs edited =====
--- 1.9/drivers/block/blkpg.c	Sat Mar 30 06:58:05 2002
+++ edited/drivers/block/blkpg.c	Wed May 28 19:33:16 2003
@@ -261,6 +261,7 @@
 			return blkpg_ioctl(dev, (struct blkpg_ioctl_arg *) arg);
 			
 		case BLKELVGET:
+			blk_print_stats(dev);
 			return blkelvget_ioctl(&blk_get_queue(dev)->elevator,
 					       (blkelv_ioctl_arg_t *) arg);
 		case BLKELVSET:
===== drivers/block/ll_rw_blk.c 1.44 vs edited =====
--- 1.44/drivers/block/ll_rw_blk.c	Mon Apr 14 06:53:03 2003
+++ edited/drivers/block/ll_rw_blk.c	Wed May 28 19:34:10 2003
@@ -442,6 +442,56 @@
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
@@ -491,6 +541,9 @@
 	q->plug_tq.routine	= &generic_unplug_device;
 	q->plug_tq.data		= q;
 	q->plugged        	= 0;
+
+	reset_stats(q);
+
 	/*
 	 * These booleans describe the queue properties.  We set the
 	 * default (and most common) values here.  Other drivers can
@@ -588,6 +641,8 @@
 static struct request *__get_request_wait(request_queue_t *q, int rw)
 {
 	register struct request *rq;
+	unsigned long wait_start = jiffies;
+	unsigned long time_waited;
 	DECLARE_WAITQUEUE(wait, current);
 
 	generic_unplug_device(q);
@@ -602,6 +657,18 @@
 	} while (rq == NULL);
 	remove_wait_queue(&q->wait_for_requests[rw], &wait);
 	current->state = TASK_RUNNING;
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
 
@@ -1064,6 +1131,7 @@
 	req->rq_dev = bh->b_rdev;
 	req->start_time = jiffies;
 	req_new_io(req, 0, count);
+	q->num_req++;
 	blk_started_io(count);
 	add_request(q, req, insert_here);
 out:
===== fs/super.c 1.49 vs edited =====
--- 1.49/fs/super.c	Wed Dec 18 21:34:24 2002
+++ edited/fs/super.c	Wed May 28 19:29:26 2003
@@ -404,6 +404,7 @@
 	up_write(&s->s_umount);
 	put_super(s);
 	put_filesystem(fs);
+	blk_print_stats(dev);
 	if (bdev)
 		blkdev_put(bdev, BDEV_FS);
 	else
@@ -726,6 +727,7 @@
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto Einval;
 	s->s_flags |= MS_ACTIVE;
+	blk_reset_stats(dev);
 	path_release(&nd);
 	return s;
 
===== include/linux/blkdev.h 1.23 vs edited =====
--- 1.23/include/linux/blkdev.h	Fri Nov 29 17:03:01 2002
+++ edited/include/linux/blkdev.h	Wed May 28 19:27:18 2003
@@ -138,8 +138,17 @@
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
@@ -217,6 +226,7 @@
 extern void generic_make_request(int rw, struct buffer_head * bh);
 extern inline request_queue_t *blk_get_queue(kdev_t dev);
 extern void blkdev_release_request(struct request *);
+extern void blk_print_stats(kdev_t dev);
 
 /*
  * Access functions for manipulating queue properties

--=-iHqcgH5VDfd65Gehx3z9--

