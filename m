Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286312AbRLTSU7>; Thu, 20 Dec 2001 13:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286314AbRLTSUv>; Thu, 20 Dec 2001 13:20:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:14853 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286312AbRLTSUi>; Thu, 20 Dec 2001 13:20:38 -0500
Message-ID: <3C222BB5.B2CCC11B@zip.com.au>
Date: Thu, 20 Dec 2001 10:19:33 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance during disk writes
In-Reply-To: <20011220132729Z286241-18285+3296@vger.kernel.org>,
		<20011220132729Z286241-18285+3296@vger.kernel.org>; from Dieter.Nuetzel@hamburg.de on Thu, Dec 20, 2001 at 02:27:17PM +0100 <20011220094025.B2632@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Andrew, I don't have the URL for that still floating around. Can you
> point Dieter to it?

It's here.

You need to run

	elvtune -b N /dev/hdXX

where N=0 is "disable", N=1 is minimum read latency, N=6 is
a reasonable setting.


--- linux-2.4.17-pre6/drivers/block/elevator.c	Thu Jul 19 20:59:41 2001
+++ linux-akpm/drivers/block/elevator.c	Sat Dec  8 11:10:36 2001
@@ -74,11 +74,10 @@ inline int bh_rq_in_between(struct buffe
 	return 0;
 }
 
-
 int elevator_linus_merge(request_queue_t *q, struct request **req,
 			 struct list_head * head,
 			 struct buffer_head *bh, int rw,
-			 int max_sectors)
+			 int max_sectors, int max_bomb_segments)
 {
 	struct list_head *entry = &q->queue_head;
 	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
@@ -116,6 +115,56 @@ int elevator_linus_merge(request_queue_t
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
 
@@ -144,7 +193,7 @@ void elevator_linus_merge_req(struct req
 int elevator_noop_merge(request_queue_t *q, struct request **req,
 			struct list_head * head,
 			struct buffer_head *bh, int rw,
-			int max_sectors)
+			int max_sectors, int max_bomb_segments)
 {
 	struct list_head *entry;
 	unsigned int count = bh->b_size >> 9;
@@ -188,7 +237,7 @@ int blkelvget_ioctl(elevator_t * elevato
 	output.queue_ID			= elevator->queue_ID;
 	output.read_latency		= elevator->read_latency;
 	output.write_latency		= elevator->write_latency;
-	output.max_bomb_segments	= 0;
+	output.max_bomb_segments	= elevator->max_bomb_segments;
 
 	if (copy_to_user(arg, &output, sizeof(blkelv_ioctl_arg_t)))
 		return -EFAULT;
@@ -207,9 +256,12 @@ int blkelvset_ioctl(elevator_t * elevato
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
 
--- linux-2.4.17-pre6/drivers/block/ll_rw_blk.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/block/ll_rw_blk.c	Sat Dec  8 11:10:36 2001
@@ -690,7 +690,8 @@ again:
 	} else if (q->head_active && !q->plugged)
 		head = head->next;
 
-	el_ret = elevator->elevator_merge_fn(q, &req, head, bh, rw,max_sectors);
+	el_ret = elevator->elevator_merge_fn(q, &req, head, bh,
+				rw, max_sectors, elevator->max_bomb_segments);
 	switch (el_ret) {
 
 		case ELEVATOR_BACK_MERGE:
--- linux-2.4.17-pre6/include/linux/elevator.h	Thu Feb 15 16:58:34 2001
+++ linux-akpm/include/linux/elevator.h	Sat Dec  8 11:10:36 2001
@@ -5,8 +5,9 @@ typedef void (elevator_fn) (struct reque
 			    struct list_head *,
 			    struct list_head *, int);
 
-typedef int (elevator_merge_fn) (request_queue_t *, struct request **, struct list_head *,
-				 struct buffer_head *, int, int);
+typedef int (elevator_merge_fn)(request_queue_t *, struct request **,
+				struct list_head *, struct buffer_head *bh,
+				int rw, int max_sectors, int max_bomb_segments);
 
 typedef void (elevator_merge_cleanup_fn) (request_queue_t *, struct request *, int);
 
@@ -16,6 +17,7 @@ struct elevator_s
 {
 	int read_latency;
 	int write_latency;
+	int max_bomb_segments;
 
 	elevator_merge_fn *elevator_merge_fn;
 	elevator_merge_cleanup_fn *elevator_merge_cleanup_fn;
@@ -24,13 +26,13 @@ struct elevator_s
 	unsigned int queue_ID;
 };
 
-int elevator_noop_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
-void elevator_noop_merge_cleanup(request_queue_t *, struct request *, int);
-void elevator_noop_merge_req(struct request *, struct request *);
-
-int elevator_linus_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
-void elevator_linus_merge_cleanup(request_queue_t *, struct request *, int);
-void elevator_linus_merge_req(struct request *, struct request *);
+elevator_merge_fn elevator_noop_merge;
+elevator_merge_cleanup_fn elevator_noop_merge_cleanup;
+elevator_merge_req_fn elevator_noop_merge_req;
+
+elevator_merge_fn elevator_linus_merge;
+elevator_merge_cleanup_fn elevator_linus_merge_cleanup;
+elevator_merge_req_fn elevator_linus_merge_req;
 
 typedef struct blkelv_ioctl_arg_s {
 	int queue_ID;
@@ -54,22 +56,6 @@ extern void elevator_init(elevator_t *, 
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
@@ -85,7 +71,7 @@ static inline int elevator_request_laten
 ((elevator_t) {								\
 	0,				/* read_latency */		\
 	0,				/* write_latency */		\
-									\
+	0,				/* max_bomb_segments */		\
 	elevator_noop_merge,		/* elevator_merge_fn */		\
 	elevator_noop_merge_cleanup,	/* elevator_merge_cleanup_fn */	\
 	elevator_noop_merge_req,	/* elevator_merge_req_fn */	\
@@ -95,7 +81,7 @@ static inline int elevator_request_laten
 ((elevator_t) {								\
 	8192,				/* read passovers */		\
 	16384,				/* write passovers */		\
-									\
+	0,				/* max_bomb_segments */		\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_cleanup,	/* elevator_merge_cleanup_fn */	\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
