Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSHOG3Z>; Thu, 15 Aug 2002 02:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSHOG3Z>; Thu, 15 Aug 2002 02:29:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45755 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316595AbSHOG3V>;
	Thu, 15 Aug 2002 02:29:21 -0400
Date: Thu, 15 Aug 2002 08:32:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] elevator seek accounting fixes
Message-ID: <20020815063254.GB1345@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Folks, we have a somewhat embarassing problem in the 2.4 i/o scheduler.
Basically the accounting currently done in 2.4.20-pre2 is bogus.

Requests are aged as the i/o scheduler passes over them, looking for a
merge or insertion point. If no merges are found, a complete queue scan
will have been completed and thus aged all requests down by one. So
requests in from of the insertion point are penalized as much as those
behind it. If a merge is found, ll_rw_blk.c will call the elevator
merge_cleanup function, which will account the merge by decrementing the
sequence of requests behind the merge point by the sector count of the
buffer. In addition, these requests have been aged as well. So the end
result is that a seek penalizes all requests with a cost of 1, a merge
penalizes requests behind it with a cost of sectors + 1, typically 9.

Completely crap! I dunno where this logic got reversed, but here's a
patch to fix it. It does two things:

o Account merges by a cost of 1, and account seeks by a cost of 16. The
  actual numbers are not very important, here they just imply that a
  seek costs 16 times as much as a merge. Actual merge cost is not
  important because request size is finite. This means that we are
  invalidating old elvtune values for the elevator. I've chosen 2048 for
  READs and 8192 for WRITEs currently, which translates into ~128 seeks
  can pass a READ at most (and ~512 for WRITEs).

o Still allow a merge even if we cross a zero sequence point in the sort
  list. This is done on the premise that merges are basically "free", as
  seen from the disk.

The actual values will probably need a bit of tweaking. I would very
much appreciate people testing what gives good throughput on benchmarks,
and what provides good latency for desktops.

Marcelo, please apply for 2.4.20-pre2

--- /opt/kernel/linux-2.4.20-pre2/drivers/block/elevator.c	2001-07-20 05:59:41.000000000 +0200
+++ linux-2.4.20-pre2/drivers/block/elevator.c	2002-08-15 07:52:21.000000000 +0200
@@ -82,54 +82,55 @@
 {
 	struct list_head *entry = &q->queue_head;
 	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	struct request *__rq;
+	int merge_only = 0;
 
 	while ((entry = entry->prev) != head) {
-		struct request *__rq = blkdev_entry_to_request(entry);
+		__rq = blkdev_entry_to_request(entry);
 
 		/*
-		 * simply "aging" of requests in queue
+		 * we can't insert beyond a zero sequence point
 		 */
-		if (__rq->elevator_sequence-- <= 0)
-			break;
+		if (__rq->elevator_sequence <= 0)
+			merge_only = 1;
 
 		if (__rq->waiting)
 			continue;
 		if (__rq->rq_dev != bh->b_rdev)
 			continue;
-		if (!*req && bh_rq_in_between(bh, __rq, &q->queue_head))
+		if (!*req && !merge_only && bh_rq_in_between(bh, __rq, &q->queue_head))
 			*req = __rq;
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
 			continue;
-		if (__rq->elevator_sequence < count)
-			break;
 		if (__rq->sector + __rq->nr_sectors == bh->b_rsector) {
 			ret = ELEVATOR_BACK_MERGE;
 			*req = __rq;
 			break;
 		} else if (__rq->sector - count == bh->b_rsector) {
 			ret = ELEVATOR_FRONT_MERGE;
-			__rq->elevator_sequence -= count;
+			__rq->elevator_sequence--;
 			*req = __rq;
 			break;
 		}
 	}
 
-	return ret;
-}
-
-void elevator_linus_merge_cleanup(request_queue_t *q, struct request *req, int count)
-{
-	struct list_head *entry = &req->queue, *head = &q->queue_head;
-
 	/*
-	 * second pass scan of requests that got passed over, if any
+	 * account merge (ret != 0, cost is 1) or seeky insert (*req is set,
+	 * cost is ELV_LINUS_SEEK_COST
 	 */
-	while ((entry = entry->next) != head) {
-		struct request *tmp = blkdev_entry_to_request(entry);
-		tmp->elevator_sequence -= count;
+	if (*req) {
+		int scan_cost = ret ? 1 : ELV_LINUS_SEEK_COST;
+		struct list_head *entry = &(*req)->queue;
+
+		while ((entry = entry->next) != &q->queue_head) {
+			__rq = blkdev_entry_to_request(entry);
+			__rq->elevator_sequence -= scan_cost;
+		}
 	}
+
+	return ret;
 }
 
 void elevator_linus_merge_req(struct request *req, struct request *next)
@@ -177,8 +178,6 @@
 	return ELEVATOR_NO_MERGE;
 }
 
-void elevator_noop_merge_cleanup(request_queue_t *q, struct request *req, int count) {}
-
 void elevator_noop_merge_req(struct request *req, struct request *next) {}
 
 int blkelvget_ioctl(elevator_t * elevator, blkelv_ioctl_arg_t * arg)
--- /opt/kernel/linux-2.4.20-pre2/drivers/block/ll_rw_blk.c	2002-08-15 08:14:37.000000000 +0200
+++ linux-2.4.20-pre2/drivers/block/ll_rw_blk.c	2002-08-15 07:52:21.000000000 +0200
@@ -972,7 +972,6 @@
 				insert_here = &req->queue;
 				break;
 			}
-			elevator->elevator_merge_cleanup_fn(q, req, count);
 			req->bhtail->b_reqnext = bh;
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
@@ -987,7 +986,6 @@
 				insert_here = req->queue.prev;
 				break;
 			}
-			elevator->elevator_merge_cleanup_fn(q, req, count);
 			bh->b_reqnext = req->bh;
 			req->bh = bh;
 			/*
--- /opt/kernel/linux-2.4.20-pre2/include/linux/elevator.h	2001-02-16 01:58:34.000000000 +0100
+++ linux-2.4.20-pre2/include/linux/elevator.h	2002-08-15 07:57:19.000000000 +0200
@@ -18,7 +18,6 @@
 	int write_latency;
 
 	elevator_merge_fn *elevator_merge_fn;
-	elevator_merge_cleanup_fn *elevator_merge_cleanup_fn;
 	elevator_merge_req_fn *elevator_merge_req_fn;
 
 	unsigned int queue_ID;
@@ -81,23 +80,23 @@
 	return latency;
 }
 
+#define ELV_LINUS_SEEK_COST	16
+
 #define ELEVATOR_NOOP							\
 ((elevator_t) {								\
 	0,				/* read_latency */		\
 	0,				/* write_latency */		\
 									\
 	elevator_noop_merge,		/* elevator_merge_fn */		\
-	elevator_noop_merge_cleanup,	/* elevator_merge_cleanup_fn */	\
 	elevator_noop_merge_req,	/* elevator_merge_req_fn */	\
 	})
 
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
-	8192,				/* read passovers */		\
-	16384,				/* write passovers */		\
+	2048,				/* read passovers */		\
+	8192,				/* write passovers */		\
 									\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
-	elevator_linus_merge_cleanup,	/* elevator_merge_cleanup_fn */	\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
 	})
 

-- 
Jens Axboe

