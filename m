Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289156AbSAGJeo>; Mon, 7 Jan 2002 04:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289155AbSAGJeg>; Mon, 7 Jan 2002 04:34:36 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:64270 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289159AbSAGJeW>; Mon, 7 Jan 2002 04:34:22 -0500
Message-ID: <3C396A66.D19E71DF@zip.com.au>
Date: Mon, 07 Jan 2002 01:29:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: [patch, CFT] improved disk read latency
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is designed to improves disk read latencies in the presence of
heavy write traffic.  I'm proposing it for inclusion in 2.4.x.

It changes the disk elevator's treatment of read requests.  Instead of
placing an unmergeable read at the tail of the list, it is placed a tunable
distance from the front.  That distance is tuned with `elvtune -b N'.

After much testing, the default value of N (aka max_bomb_segments) is 6.

Increasing max_bomb_segments penalises reads (a lot) and benefits
writes (a little).

Setting max_bomb_segments to zero disables the feature.

There are two other changes here:

1: Currently, if a request's latency in the queue is expired, it becomes a
   barrier to all newly introduced sectors.  With this patch, it becomes a
   barrier only to the introduction of *new* requests in the queue. 
   Contiguous merges can still bypass an expired request.

   We still avoid the `infinite latency' problem because when all the
   requests in front of the expired one are at max_sectors, that's it.  No
   more requests can be introduced in front of the expired one.

   This change gives improved merging and is worth 10-15% on dbench.

2: The request queues are big again.  A minimum of 32 requests and a
   maximum of 1024.  The maximum is reached on machines which have 512
   megabytes or more.

   Rationale: request merging/sorting is the *only* means we have of
   straightening out unordered requests from the application layer.  

   There are some workloads where this simply collapses.  The `random
   write' tests in iozone and in Juan's misc001 result in the machine being
   locked up for minutes, trickling stuff out to disk at 500 k/sec. 
   Increasing the request queue size helps here.  A bit.

   I believe the current 128-request limit was introduced in a (not very
   successful) attempt to reduce read latencies.  Well, we don't need to do
   that now.  (-ac kernels still have >1000 requests per queue).

   It's worth another 10% on dbench.


One of the objectives here was to ensure that the tunable actually does
something useful.  That it gives a good spectrum of control over the
write-throughput-versus-read-latency balance.  It does that.

I'll spare you all the columns of testing numbers.  Here's a summary of
the performance changes at the default elevator settings:

- Linear read throughput in the presence of a linear write is improved
  by 8x to 10x

- Linear read throughput in the presence of seek-intensive writes (yup,
  dbench) is improved by 5x to 30x

- Many-file read throughput (reading a kernel tree) in the presence
  of a streaming write is increased by 2x to 30x

- dbench throughput is increased a little.

- the results vary greatly depending upon available memory.  Generally
  but not always, small-memory machines suffer latency more, and are
  benefitted more.

- other benchmarks (iozone, bonnie++, tiobench) are unaltered - they
  all tend to just do single large writes.

On the downside:

- linear write throughput in the presence of a large streaming read
  is halved.

- linear write throughput in the presence of ten seek-intensive
  reading processes (read 10 separate kernel trees in parallel) is 7x
  lower.

- linear write throughput in the presence of one seek-intensive
  reading process (kernel tree diff) is about 15% lower.


One thing which probably needs altering now is the default settings of
the elevator read and write latencies.  It should be possible to
increase these significantly and get more throughput improvements. 
That's on my todo list.

Increasing the VM readahead parameters will probably be an overall win.

This is a pretty fundamental change to the kernel.  Please test this
patch.  Not only for its goodness - it has tons of that.  Try also to
find badness.


--- linux-2.4.18-pre1/drivers/block/elevator.c	Thu Jul 19 20:59:41 2001
+++ linux-akpm/drivers/block/elevator.c	Mon Dec 31 12:58:07 2001
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
+	 * max_bomb_sectors becomes the maximum number of write
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
 
--- linux-2.4.18-pre1/drivers/block/ll_rw_blk.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/block/ll_rw_blk.c	Mon Dec 31 15:27:24 2001
@@ -1091,7 +1091,7 @@ void end_that_request_last(struct reques
 int __init blk_dev_init(void)
 {
 	struct blk_dev_struct *dev;
-	int total_ram;
+	int total_ram;		/* kilobytes */
 
 	request_cachep = kmem_cache_create("blkdev_requests",
 					   sizeof(struct request),
@@ -1113,9 +1113,11 @@ int __init blk_dev_init(void)
 	 * Free request slots per queue.
 	 * (Half for reads, half for writes)
 	 */
-	queue_nr_requests = 64;
-	if (total_ram > MB(32))
-		queue_nr_requests = 128;
+	queue_nr_requests = (total_ram >> 9) & ~15;	/* One per half-megabyte */
+	if (queue_nr_requests < 32)
+		queue_nr_requests = 32;
+	if (queue_nr_requests > 1024)
+		queue_nr_requests = 1024;
 
 	/*
 	 * Batch frees according to queue length
--- linux-2.4.18-pre1/include/linux/elevator.h	Thu Feb 15 16:58:34 2001
+++ linux-akpm/include/linux/elevator.h	Mon Dec 31 12:57:11 2001
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
