Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282603AbRKZWWe>; Mon, 26 Nov 2001 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282608AbRKZWW0>; Mon, 26 Nov 2001 17:22:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:35851 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282603AbRKZWWQ>; Mon, 26 Nov 2001 17:22:16 -0500
Message-ID: <3C02C06A.E1389092@zip.com.au>
Date: Mon, 26 Nov 2001 14:21:30 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Nathan G. Grennan" <ngrennan@okcforum.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nathan G. Grennan" wrote:
> 
> 2.4.16 becomes very unresponsive for 30 seconds or so at a time during
> large unarchiving of tarballs, like tar -zxf mozilla-src.tar.gz. The
> file is about 36mb. I run top in one window, run free repeatedly in
> another window and run the tar -zxf in a third window. I had many
> suspects, but still not sure what it is. I have tried

yes.  I'm doing quite some work in this area at present.  There
are a couple of things which may help here.

1: The current code which is designed to throttle heavy writers
basically doesn't work under some workloads.  It's designed to
block the writer when there are too many dirty buffers in the
machine.  But in fact, all dirty data writeout occurs in the
context of shrink_cache(), so all tasks are penalised and if
the writing task doesn't happen to run shrink_cache(), it gets
to merrily continue stuffing the machine full of write data.
The fix is to account for locked buffers as well as dirty ones
in balance_dirty_state().

2: The current elevator design is downright cruel to humans in
the presence of heavy write traffic.

Please try this lot:



--- linux-2.4.16-pre1/fs/buffer.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/fs/buffer.c	Sun Nov 25 00:07:47 2001
@@ -1036,6 +1036,7 @@ static int balance_dirty_state(void)
 	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
 
 	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
+	dirty += size_buffers_type[BUF_LOCKED] >> PAGE_SHIFT;
 	tot = nr_free_buffer_pages();
 
 	dirty *= 100;
--- linux-2.4.16-pre1/mm/filemap.c	Sat Nov 24 13:14:52 2001
+++ linux-akpm/mm/filemap.c	Sun Nov 25 00:07:47 2001
@@ -3023,7 +3023,18 @@ generic_file_write(struct file *file,con
 unlock:
 		kunmap(page);
 		/* Mark it unlocked again and drop the page.. */
-		SetPageReferenced(page);
+//		SetPageReferenced(page);
+		ClearPageReferenced(page);
+#if 0
+		{
+			lru_cache_del(page);
+			TestSetPageLRU(page);
+			spin_lock(&pagemap_lru_lock);
+			list_add_tail(&(page)->lru, &inactive_list);
+			nr_inactive_pages++;
+			spin_unlock(&pagemap_lru_lock);
+		}
+#endif
 		UnlockPage(page);
 		page_cache_release(page);
 
--- linux-2.4.16-pre1/mm/vmscan.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/mm/vmscan.c	Sun Nov 25 00:08:03 2001
@@ -573,6 +573,9 @@ static int shrink_caches(zone_t * classz
 	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
 	if (nr_pages <= 0)
 		return 0;
+	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
+	if (nr_pages <= 0)
+		return 0;
 
 	shrink_dcache_memory(priority, gfp_mask);
 	shrink_icache_memory(priority, gfp_mask);
@@ -585,7 +588,7 @@ static int shrink_caches(zone_t * classz
 
 int try_to_free_pages(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
 {
-	int priority = DEF_PRIORITY;
+	int priority = DEF_PRIORITY - 2;
 	int nr_pages = SWAP_CLUSTER_MAX;
 
 	do {


--- linux-2.4.16-pre1/include/linux/elevator.h	Thu Feb 15 16:58:34 2001
+++ linux-akpm/include/linux/elevator.h	Sat Nov 24 19:58:43 2001
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
+	6,				/* max_bomb_segments */		\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_cleanup,	/* elevator_merge_cleanup_fn */	\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
--- linux-2.4.16-pre1/drivers/block/elevator.c	Thu Jul 19 20:59:41 2001
+++ linux-akpm/drivers/block/elevator.c	Sat Nov 24 20:51:29 2001
@@ -74,36 +74,52 @@ inline int bh_rq_in_between(struct buffe
 	return 0;
 }
 
+struct akpm_elv_stats {
+	int zapme;
+	int nr_read_sectors;
+	int nr_write_sectors;
+	int nr_read_requests;
+	int nr_write_requests;
+} akpm_elv_stats;
 
 int elevator_linus_merge(request_queue_t *q, struct request **req,
 			 struct list_head * head,
 			 struct buffer_head *bh, int rw,
-			 int max_sectors)
+			 int max_sectors, int max_bomb_segments)
 {
-	struct list_head *entry = &q->queue_head;
-	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	struct list_head *entry;
+	unsigned int count = bh->b_size >> 9;
+	unsigned int ret = ELEVATOR_NO_MERGE;
+	int no_in_between = 0;
 
+	if (akpm_elv_stats.zapme)
+		memset(&akpm_elv_stats, 0, sizeof(akpm_elv_stats));
+	
+	entry = &q->queue_head;
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
-
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
+			no_in_between = 1;
+		}
 		if (__rq->waiting)
 			continue;
 		if (__rq->rq_dev != bh->b_rdev)
 			continue;
-		if (!*req && bh_rq_in_between(bh, __rq, &q->queue_head))
+		if (!*req && !no_in_between &&
+			bh_rq_in_between(bh, __rq, &q->queue_head)) {
 			*req = __rq;
+		}
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
 			continue;
 		if (__rq->elevator_sequence < count)
-			break;
+			no_in_between = 1;
 		if (__rq->sector + __rq->nr_sectors == bh->b_rsector) {
 			ret = ELEVATOR_BACK_MERGE;
 			*req = __rq;
@@ -116,6 +132,66 @@ int elevator_linus_merge(request_queue_t
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
+	if (rw == READ && ret == ELEVATOR_NO_MERGE) {
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
+	if (ret == ELEVATOR_NO_MERGE) {
+		if (rw == READ)
+			akpm_elv_stats.nr_read_requests++;
+		else
+			akpm_elv_stats.nr_write_requests++;
+	}
+	if (rw == READ)
+		akpm_elv_stats.nr_read_sectors += count;
+	else
+		akpm_elv_stats.nr_write_sectors += count;
 	return ret;
 }
 
@@ -144,7 +220,7 @@ void elevator_linus_merge_req(struct req
 int elevator_noop_merge(request_queue_t *q, struct request **req,
 			struct list_head * head,
 			struct buffer_head *bh, int rw,
-			int max_sectors)
+			int max_sectors, int max_bomb_segments)
 {
 	struct list_head *entry;
 	unsigned int count = bh->b_size >> 9;
@@ -188,7 +264,7 @@ int blkelvget_ioctl(elevator_t * elevato
 	output.queue_ID			= elevator->queue_ID;
 	output.read_latency		= elevator->read_latency;
 	output.write_latency		= elevator->write_latency;
-	output.max_bomb_segments	= 0;
+	output.max_bomb_segments	= elevator->max_bomb_segments;
 
 	if (copy_to_user(arg, &output, sizeof(blkelv_ioctl_arg_t)))
 		return -EFAULT;
@@ -207,9 +283,12 @@ int blkelvset_ioctl(elevator_t * elevato
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
 
--- linux-2.4.16-pre1/drivers/block/ll_rw_blk.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/block/ll_rw_blk.c	Sat Nov 24 22:25:47 2001
@@ -690,7 +690,8 @@ again:
 	} else if (q->head_active && !q->plugged)
 		head = head->next;
 
-	el_ret = elevator->elevator_merge_fn(q, &req, head, bh, rw,max_sectors);
+	el_ret = elevator->elevator_merge_fn(q, &req, head, bh,
+				rw, max_sectors, elevator->max_bomb_segments);
 	switch (el_ret) {
 
 		case ELEVATOR_BACK_MERGE:
