Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbTE3VxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 17:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbTE3VxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 17:53:04 -0400
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:64520
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id S264051AbTE3Vw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 17:52:59 -0400
Date: Fri, 30 May 2003 15:09:24 -0700
From: Neil Schemenauer <nas@python.ca>
To: linux-kernel@vger.kernel.org
Cc: conman@kolivas.net, Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Matt <matt@lpbproductions.com>
Subject: [PATCH][CFT] new IO scheduler for 2.4.20
Message-ID: <20030530220923.GA404@glacier.arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The major benefit of this patch is that read latency is much lower while
lots of writes are occuring.  On my machine, running:

 while :; do dd if=/dev/zero of=foo bs=1M count=1000 conv=notrunc; done

makes 2.4.20 unusable.  With this patch the "write bomb" causes no
particular problems.

With this version of the patch I've improved the bulk read performance
of the elevator.  The bonnie++ results are now:

                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
               Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
2.4.20           1G 13001  97 34939  18 13034   7 12175  92 34112  14
2.4.20-nas       1G 12923  98 36471  17 13340   8 10809  83 35569  13

Note that the "rewrite" and "per-char read" stats are slightly bogus for
2.4.20-nas.  Reads get a boost in priority over writes.  When the
"per-char read" test has started there is still some writing happening
from the rewrite test.  I think the net effect is that the "rewrite"
number is too high and the "per-char read" number is too low.

I would be very pleased if someone could run some tests on using bonnie,
contest, or their other favorite benchmarks and post the results.

  Neil


diff -u -ur linux-2.4.20/Makefile linux-iosched-2/Makefile
--- linux-2.4.20/Makefile	2003-04-14 14:47:20.000000000 -0400
+++ linux-iosched-2/Makefile	2003-05-30 17:27:16.000000000 -0400
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 20
-EXTRAVERSION =
+EXTRAVERSION = -nas
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -u -ur linux-2.4.20/drivers/block/elevator.c linux-iosched-2/drivers/block/elevator.c
--- linux-2.4.20/drivers/block/elevator.c	2003-04-14 14:47:22.000000000 -0400
+++ linux-iosched-2/drivers/block/elevator.c	2003-05-30 17:28:57.000000000 -0400
@@ -74,6 +74,81 @@
 	return 0;
 }
 
+int elevator_neil_merge(request_queue_t *q, struct request **req,
+			 struct list_head * head,
+			 struct buffer_head *bh, int rw,
+			 int max_sectors)
+{
+	struct list_head *entry = &q->queue_head;
+	struct request *__rq;
+	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	unsigned int reads = 0, writes = 0;
+	/* XXX make tunable? */
+	unsigned int expire_time = jiffies - 1*HZ;
+
+	if (list_empty(&q->queue_head))
+		goto out;
+
+	/* try to merge requests, fall back to ordering them by sector */
+	while ((entry = entry->prev) != head) {
+		__rq = blkdev_entry_to_request(entry);
+
+		if (__rq->elevator_sequence <= 0)
+			break;
+		if (__rq->cmd == READ)
+			++reads;
+		else
+			++writes;
+		if (__rq->rq_dev != bh->b_rdev)
+			continue;
+		if (__rq->waiting)
+			continue;
+		if (__rq->cmd != rw)
+			continue;
+		if (time_before(__rq->start_time, expire_time))
+			break;
+		if (bh->b_rsector > __rq->sector)
+			*req = __rq;
+		if (__rq->nr_sectors + count > max_sectors)
+			continue;
+		if (__rq->sector + __rq->nr_sectors == bh->b_rsector) {
+			ret = ELEVATOR_BACK_MERGE;
+			*req = __rq;
+			goto out;
+		} else if (__rq->sector - count == bh->b_rsector) {
+			ret = ELEVATOR_FRONT_MERGE;
+			*req = __rq;
+			goto out;
+		}
+	}
+	if (!*req && rw == READ) {
+		int extra_writes = writes - reads;
+		/*
+		 * If there are more writes than reads in the queue then put
+		 * read requests ahead of the extra writes.  This prevents
+		 * writes from starving reads.
+		 */
+		entry = q->queue_head.prev;
+		while (extra_writes > 0 && entry != head) {
+			__rq = blkdev_entry_to_request(entry);
+			if (__rq->cmd == WRITE)
+				--extra_writes;
+			else if (time_before(__rq->start_time, expire_time))
+				break;
+			entry = entry->prev;
+		}
+		*req = blkdev_entry_to_request(entry);
+	}
+out:
+	return ret;
+}
+
+void elevator_neil_merge_req(struct request *req, struct request *next)
+{
+	if (time_before(next->start_time, req->start_time))
+		req->start_time = next->start_time;
+}
+
 
 int elevator_linus_merge(request_queue_t *q, struct request **req,
 			 struct list_head * head,
diff -u -ur linux-2.4.20/drivers/block/ll_rw_blk.c linux-iosched-2/drivers/block/ll_rw_blk.c
--- linux-2.4.20/drivers/block/ll_rw_blk.c	2003-04-14 14:47:22.000000000 -0400
+++ linux-iosched-2/drivers/block/ll_rw_blk.c	2003-05-30 17:27:16.000000000 -0400
@@ -480,7 +480,7 @@
 void blk_init_queue(request_queue_t * q, request_fn_proc * rfn)
 {
 	INIT_LIST_HEAD(&q->queue_head);
-	elevator_init(&q->elevator, ELEVATOR_LINUS);
+	elevator_init(&q->elevator, ELEVATOR_NEIL);
 	blk_init_free_list(q);
 	q->request_fn     	= rfn;
 	q->back_merge_fn       	= ll_back_merge_fn;
@@ -922,7 +922,8 @@
 			rw = READ;	/* drop into READ */
 		case READ:
 		case WRITE:
-			latency = elevator_request_latency(elevator, rw);
+			/* latency = elevator_request_latency(elevator, rw); */
+			latency = 1;
 			break;
 		default:
 			BUG();
diff -u -ur linux-2.4.20/include/linux/elevator.h linux-iosched-2/include/linux/elevator.h
--- linux-2.4.20/include/linux/elevator.h	2003-04-14 14:47:24.000000000 -0400
+++ linux-iosched-2/include/linux/elevator.h	2003-05-30 17:27:16.000000000 -0400
@@ -31,6 +31,9 @@
 void elevator_linus_merge_cleanup(request_queue_t *, struct request *, int);
 void elevator_linus_merge_req(struct request *, struct request *);
 
+int elevator_neil_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
+void elevator_neil_merge_req(struct request *, struct request *);
+
 typedef struct blkelv_ioctl_arg_s {
 	int queue_ID;
 	int read_latency;
@@ -101,3 +104,12 @@
 	})
 
 #endif
+
+#define ELEVATOR_NEIL							\
+((elevator_t) {								\
+	0,				/* read_latency */		\
+	0,				/* write_latency */		\
+									\
+	elevator_neil_merge,		/* elevator_merge_fn */		\
+	elevator_neil_merge_req,	/* elevator_merge_req_fn */	\
+	})
