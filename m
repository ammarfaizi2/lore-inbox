Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTDQRPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTDQRPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:15:08 -0400
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:53766
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id S261764AbTDQRPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:15:01 -0400
Date: Thu, 17 Apr 2003 10:28:19 -0700
From: Neil Schemenauer <nas@arctrix.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de, akpm@digeo.com, conman@kolivas.net
Subject: [PATCH][CFT] new IO scheduler for 2.4.20
Message-ID: <20030417172818.GA8848@glacier.arctrix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Recently I was bitten badly by bad IO scheduler behavior on an important
Linux server.  An easy way to trigger this problem is to start a
streaming write process:

    while :
    do
            dd if=/dev/zero of=foo bs=1M count=512 conv=notrunc
    done

and then try doing a bunch of small reads:

    time (find kernel-tree -type f | xargs cat > /dev/null)

With Linux 2.4.20, the reading takes a very long time to finish.  I
looked at backporting Jen's deadline scheduler to 2.4 but decided it
would be too much work (especially for someone like me who doesn't know
much about kernel hacking).  

I've come up with a fairly simple patch that seems to solve the
starvation problem.  Perhaps it is simple enough to get merged into the
stable branch (after a little more polish).  The basic idea is to give
reads a boost if there are lots of write requests in the queue.  I think
my solution also prevents reads and writes from being starved
indefinitely.

Throughput also seems good although I have not done a lot of testing
yet.  I would greatly appreciate it if people could give it a test.

  Neil

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neil-iosched-1.diff"

diff -u -ur linux-2.4.20/drivers/block/elevator.c linux-iosched-1d/drivers/block/elevator.c
--- linux-2.4.20/drivers/block/elevator.c	2003-04-14 14:47:22.000000000 -0400
+++ linux-iosched-1d/drivers/block/elevator.c	2003-04-17 12:15:10.000000000 -0400
@@ -74,6 +74,86 @@
 	return 0;
 }
 
+int elevator_neil_merge(request_queue_t *q, struct request **req,
+			 struct list_head * head,
+			 struct buffer_head *bh, int rw,
+			 int max_sectors)
+{
+	struct list_head *entry = &q->queue_head;
+	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	unsigned long read_sectors = 0, write_sectors = 0;
+	unsigned int expire_time = jiffies - 1*HZ;
+	struct request *__rq;
+
+	while ((entry = entry->prev) != head) {
+		__rq = blkdev_entry_to_request(entry);
+
+		/*
+		 * we can't insert beyond a zero sequence point
+		 */
+		if (__rq->elevator_sequence == 0) {
+			goto append;
+		}
+
+		if (__rq->cmd == READ)
+			read_sectors += __rq->nr_sectors;
+		else
+			write_sectors += __rq->nr_sectors;
+
+		if (__rq->rq_dev != bh->b_rdev)
+			continue;
+
+		if (__rq->waiting)
+			continue;
+
+		if (__rq->cmd != rw)
+			continue;
+
+		if (time_before(__rq->start_time, expire_time)) {
+			break;
+		}
+
+		if (__rq->sector + __rq->nr_sectors == bh->b_rsector) {
+			if (__rq->nr_sectors + count <= max_sectors)
+				ret = ELEVATOR_BACK_MERGE;
+			*req = __rq;
+			break;
+		} else if (__rq->sector - count == bh->b_rsector) {
+			if (__rq->nr_sectors + count <= max_sectors)
+				ret = ELEVATOR_FRONT_MERGE;
+			*req = __rq;
+			break;
+		}
+	}
+
+	if (!*req && rw == READ) {
+		long extra_writes = write_sectors - read_sectors;
+		/*
+		 * If there are more writes than reads in the queue then put
+		 * read requests ahead of the extra writes.  This prevents
+		 * writes from starving reads.
+		 */
+		entry = q->queue_head.prev;
+		while (extra_writes > 0 && entry != head) {
+			__rq = blkdev_entry_to_request(entry);
+			if (__rq->cmd == WRITE)
+				extra_writes -= __rq->nr_sectors;
+			entry = entry->prev;
+		}
+		*req = blkdev_entry_to_request(entry);
+	}
+
+append:
+
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
diff -u -ur linux-2.4.20/drivers/block/ll_rw_blk.c linux-iosched-1d/drivers/block/ll_rw_blk.c
--- linux-2.4.20/drivers/block/ll_rw_blk.c	2003-04-14 14:47:22.000000000 -0400
+++ linux-iosched-1d/drivers/block/ll_rw_blk.c	2003-04-17 12:21:59.000000000 -0400
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
diff -u -ur linux-2.4.20/include/linux/elevator.h linux-iosched-1d/include/linux/elevator.h
--- linux-2.4.20/include/linux/elevator.h	2003-04-14 14:47:24.000000000 -0400
+++ linux-iosched-1d/include/linux/elevator.h	2003-04-15 10:17:23.000000000 -0400
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
Only in linux-iosched-1d: inst.sh

--C7zPtVaVf+AK4Oqc--
