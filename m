Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSFGPL6>; Fri, 7 Jun 2002 11:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSFGPL5>; Fri, 7 Jun 2002 11:11:57 -0400
Received: from jalon.able.es ([212.97.163.2]:56245 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317298AbSFGPLz>;
	Fri, 7 Jun 2002 11:11:55 -0400
Date: Fri, 7 Jun 2002 17:10:36 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa1
Message-ID: <20020607151036.GA10199@werewolf.able.es>
In-Reply-To: <20020607003413.GH1004@dualathlon.random> <3D001363.BDEBD682@zip.com.au> <20020607020839.GM1004@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.07 Andrea Arcangeli wrote:
>
>to export to modules, right, I don't use it as module so I didn't
>noticed. Oh well, it's too late now to update. I will upload a new one
>tomorrow if I find the time or it will wait one week.
>

While you are at it, could you take a look at what I have as the
read-latency-2 patch ? If it is worth, is really short and easy to include.
(Credits to Andrew Morton)

--- 2.4.19-pre5/drivers/block/elevator.c~read-latency2	Sat Mar 30 11:16:34 2002
+++ 2.4.19-pre5-akpm/drivers/block/elevator.c	Sat Mar 30 11:16:34 2002
@@ -80,30 +80,38 @@ int elevator_linus_merge(request_queue_t
 			 struct buffer_head *bh, int rw,
 			 int max_sectors)
 {
-	struct list_head *entry = &q->queue_head;
-	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
-
+	struct list_head *entry;
+	unsigned int count = bh->b_size >> 9;
+	unsigned int ret = ELEVATOR_NO_MERGE;
+	int merge_only = 0;
+	const int max_bomb_segments = q->elevator.max_bomb_segments;
+ 
+	entry = &q->queue_head;
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
 
-		/*
-		 * simply "aging" of requests in queue
-		 */
-		if (__rq->elevator_sequence-- <= 0)
-			break;
-
+		if (__rq->elevator_sequence-- <= 0) {
+			/*
+			 * OK, we've exceeded someone's latency limit.
+			 * But we still continue to look for merges,
+			 * because they're so much better than seeks.
+			 */
+			merge_only = 1;
+		}
 		if (__rq->waiting)
 			continue;
 		if (__rq->rq_dev != bh->b_rdev)
 			continue;
-		if (!*req && bh_rq_in_between(bh, __rq, &q->queue_head))
+		if (!*req && !merge_only &&
+			bh_rq_in_between(bh, __rq, &q->queue_head)) {
 			*req = __rq;
+		}
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
 			continue;
 		if (__rq->elevator_sequence < count)
-			break;
+			merge_only = 1;
 		if (__rq->sector + __rq->nr_sectors == bh->b_rsector) {
 			ret = ELEVATOR_BACK_MERGE;
 			*req = __rq;
@@ -116,6 +124,56 @@ int elevator_linus_merge(request_queue_t
 		}
 	}
 
+	/*
+	 * If we failed to merge a read anywhere in the request
+	 * queue, we really don't want to place it at the end
+	 * of the list, behind lots of writes.  So place it near
+	 * the front.
+	 *
+	 * We don't want to place it in front of _all_ writes: that
+	 * would create lots of seeking, and isn't tunable.
+	 * We try to avoid promoting this read in front of existing
+	 * reads.
+	 *
+	 * max_bomb_segments becomes the maximum number of write
+	 * requests which we allow to remain in place in front of
+	 * a newly introduced read.  We weight things a little bit,
+	 * so large writes are more expensive than small ones, but it's
+	 * requests which count, not sectors.
+	 */
+	if (max_bomb_segments && rw == READ && ret == ELEVATOR_NO_MERGE) {
+		int cur_latency = 0;
+		struct request * const cur_request = *req;
+
+		entry = head->next;
+		while (entry != &q->queue_head) {
+			struct request *__rq;
+
+			if (entry == &q->queue_head)
+				BUG();
+			if (entry == q->queue_head.next &&
+					q->head_active && !q->plugged)
+				BUG();
+			__rq = blkdev_entry_to_request(entry);
+
+			if (__rq == cur_request) {
+				/*
+				 * This is where the old algorithm placed it.
+				 * There's no point pushing it further back,
+				 * so leave it here, in sorted order.
+				 */
+				break;
+			}
+			if (__rq->cmd == WRITE) {
+				cur_latency += 1 + __rq->nr_sectors / 64;
+				if (cur_latency >= max_bomb_segments) {
+					*req = __rq;
+					break;
+				}
+			}
+			entry = entry->next;
+		}
+	}
 	return ret;
 }
 
@@ -188,7 +246,7 @@ int blkelvget_ioctl(elevator_t * elevato
 	output.queue_ID			= elevator->queue_ID;
 	output.read_latency		= elevator->read_latency;
 	output.write_latency		= elevator->write_latency;
-	output.max_bomb_segments	= 0;
+	output.max_bomb_segments	= elevator->max_bomb_segments;
 
 	if (copy_to_user(arg, &output, sizeof(blkelv_ioctl_arg_t)))
 		return -EFAULT;
@@ -207,9 +265,12 @@ int blkelvset_ioctl(elevator_t * elevato
 		return -EINVAL;
 	if (input.write_latency < 0)
 		return -EINVAL;
+	if (input.max_bomb_segments < 0)
+		return -EINVAL;
 
 	elevator->read_latency		= input.read_latency;
 	elevator->write_latency		= input.write_latency;
+	elevator->max_bomb_segments	= input.max_bomb_segments;
 	return 0;
 }
 
--- 2.4.19-pre5/drivers/block/ll_rw_blk.c~read-latency2	Sat Mar 30 11:16:34 2002
+++ 2.4.19-pre5-akpm/drivers/block/ll_rw_blk.c	Sat Mar 30 11:46:53 2002
@@ -439,9 +439,11 @@ static void blk_init_free_list(request_q
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
-	nr_requests = 128;
-	if (megs < 32)
-		nr_requests /= 2;
+	nr_requests = (megs * 2) & ~15;	/* One per half-megabyte */
+	if (nr_requests < 32)
+		nr_requests = 32;
+	if (nr_requests > 1024)
+		nr_requests = 1024;
 	blk_grow_request_list(q, nr_requests);
 
 	init_waitqueue_head(&q->wait_for_requests[0]);
--- 2.4.19-pre5/include/linux/elevator.h~read-latency2	Sat Mar 30 11:16:34 2002
+++ 2.4.19-pre5-akpm/include/linux/elevator.h	Sat Mar 30 11:16:34 2002
@@ -1,12 +1,9 @@
 #ifndef _LINUX_ELEVATOR_H
 #define _LINUX_ELEVATOR_H
 
-typedef void (elevator_fn) (struct request *, elevator_t *,
-			    struct list_head *,
-			    struct list_head *, int);
-
-typedef int (elevator_merge_fn) (request_queue_t *, struct request **, struct list_head *,
-				 struct buffer_head *, int, int);
+typedef int (elevator_merge_fn)(request_queue_t *, struct request **,
+				struct list_head *, struct buffer_head *bh,
+				int rw, int max_sectors);
 
 typedef void (elevator_merge_cleanup_fn) (request_queue_t *, struct request *, int);
 
@@ -16,6 +13,7 @@ struct elevator_s
 {
 	int read_latency;
 	int write_latency;
+	int max_bomb_segments;
 
 	elevator_merge_fn *elevator_merge_fn;
 	elevator_merge_cleanup_fn *elevator_merge_cleanup_fn;
@@ -24,13 +22,13 @@ struct elevator_s
 	unsigned int queue_ID;
 };
 
-int elevator_noop_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
-void elevator_noop_merge_cleanup(request_queue_t *, struct request *, int);
-void elevator_noop_merge_req(struct request *, struct request *);
-
-int elevator_linus_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
-void elevator_linus_merge_cleanup(request_queue_t *, struct request *, int);
-void elevator_linus_merge_req(struct request *, struct request *);
+elevator_merge_fn		elevator_noop_merge;
+elevator_merge_cleanup_fn	elevator_noop_merge_cleanup;
+elevator_merge_req_fn		elevator_noop_merge_req;
+
+elevator_merge_fn		elevator_linus_merge;
+elevator_merge_cleanup_fn	elevator_linus_merge_cleanup;
+elevator_merge_req_fn		elevator_linus_merge_req;
 
 typedef struct blkelv_ioctl_arg_s {
 	int queue_ID;
@@ -54,22 +52,6 @@ extern void elevator_init(elevator_t *, 
 #define ELEVATOR_FRONT_MERGE	1
 #define ELEVATOR_BACK_MERGE	2
 
-/*
- * This is used in the elevator algorithm.  We don't prioritise reads
- * over writes any more --- although reads are more time-critical than
- * writes, by treating them equally we increase filesystem throughput.
- * This turns out to give better overall performance.  -- sct
- */
-#define IN_ORDER(s1,s2)				\
-	((((s1)->rq_dev == (s2)->rq_dev &&	\
-	   (s1)->sector < (s2)->sector)) ||	\
-	 (s1)->rq_dev < (s2)->rq_dev)
-
-#define BHRQ_IN_ORDER(bh, rq)			\
-	((((bh)->b_rdev == (rq)->rq_dev &&	\
-	   (bh)->b_rsector < (rq)->sector)) ||	\
-	 (bh)->b_rdev < (rq)->rq_dev)
-
 static inline int elevator_request_latency(elevator_t * elevator, int rw)
 {
 	int latency;
@@ -85,7 +67,7 @@ static inline int elevator_request_laten
 ((elevator_t) {								\
 	0,				/* read_latency */		\
 	0,				/* write_latency */		\
-									\
+	0,				/* max_bomb_segments */		\
 	elevator_noop_merge,		/* elevator_merge_fn */		\
 	elevator_noop_merge_cleanup,	/* elevator_merge_cleanup_fn */	\
 	elevator_noop_merge_req,	/* elevator_merge_req_fn */	\
@@ -95,7 +77,7 @@ static inline int elevator_request_laten
 ((elevator_t) {								\
 	8192,				/* read passovers */		\
 	16384,				/* write passovers */		\
-									\
+	6,				/* max_bomb_segments */		\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_cleanup,	/* elevator_merge_cleanup_fn */	\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre10-jam2 #1 SMP jue jun 6 16:05:12 CEST 2002 i686
