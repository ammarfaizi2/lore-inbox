Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285517AbRL2VEA>; Sat, 29 Dec 2001 16:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285568AbRL2VDt>; Sat, 29 Dec 2001 16:03:49 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6927 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285548AbRL2VDg>; Sat, 29 Dec 2001 16:03:36 -0500
Message-ID: <3C2E2EED.83FDFC34@zip.com.au>
Date: Sat, 29 Dec 2001 13:00:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011229190226Z285236-18284+8993@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> I ask because my MP3/Ogg-Vorbis hiccup during dbench isn't solved anyway.
> Running 2.4.17 + preempt + lock-break + 10_vm-21 (AA).
> Some wisdom?

Please test this elevator patch.  I'll be putting it out more formally
in a day or two.  Much more testing is needed yet, but for me, the
time to read a 16 megabyte file whilst running dbench 160 falls from
three minutes thirty seconds to seven seconds.  (This is a VM thing,
not an elevator thing).



--- linux-2.4.18-pre1/drivers/block/elevator.c	Thu Jul 19 20:59:41 2001
+++ linux-akpm/drivers/block/elevator.c	Sat Dec 29 00:52:05 2001
@@ -82,6 +82,7 @@ int elevator_linus_merge(request_queue_t
 {
 	struct list_head *entry = &q->queue_head;
 	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	const int max_bomb_segments = q->elevator.max_bomb_segments;
 
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
@@ -116,6 +117,56 @@ int elevator_linus_merge(request_queue_t
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
 
@@ -188,7 +239,7 @@ int blkelvget_ioctl(elevator_t * elevato
 	output.queue_ID			= elevator->queue_ID;
 	output.read_latency		= elevator->read_latency;
 	output.write_latency		= elevator->write_latency;
-	output.max_bomb_segments	= 0;
+	output.max_bomb_segments	= elevator->max_bomb_segments;
 
 	if (copy_to_user(arg, &output, sizeof(blkelv_ioctl_arg_t)))
 		return -EFAULT;
@@ -207,9 +258,12 @@ int blkelvset_ioctl(elevator_t * elevato
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
 
--- linux-2.4.18-pre1/include/linux/elevator.h	Thu Feb 15 16:58:34 2001
+++ linux-akpm/include/linux/elevator.h	Sat Dec 29 12:57:33 2001
@@ -3,10 +3,11 @@
 
 typedef void (elevator_fn) (struct request *, elevator_t *,
 			    struct list_head *,
-			    struct list_head *, int);
+			    struct list_head *);
 
-typedef int (elevator_merge_fn) (request_queue_t *, struct request **, struct list_head *,
-				 struct buffer_head *, int, int);
+typedef int (elevator_merge_fn)(request_queue_t *, struct request **,
+				struct list_head *, struct buffer_head *bh,
+				int rw, int max_sectors);
 
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
+	6,				/* max_bomb_segments */		\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_cleanup,	/* elevator_merge_cleanup_fn */	\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
