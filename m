Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319765AbSIMUAe>; Fri, 13 Sep 2002 16:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319768AbSIMUAe>; Fri, 13 Sep 2002 16:00:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:46565 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319765AbSIMUA3>;
	Fri, 13 Sep 2002 16:00:29 -0400
Message-ID: <3D824498.CDDC70B1@digeo.com>
Date: Fri, 13 Sep 2002 13:03:36 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Jens Axboe <axboe@suse.de>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Shailabh Nagar <nagar@watson.ibm.com>, Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
References: <3D80DB14.2040809@watson.ibm.com> <20020912143540.J18217@redhat.com> <20020913184652.C2758@in.ibm.com> <20020913134404.GG935@suse.de> <3D823DCC.3E303941@digeo.com> <20020913155744.C2969@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 20:03:41.0586 (UTC) FILETIME=[A8263720:01C25B60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Fri, Sep 13, 2002 at 12:34:36PM -0700, Andrew Morton wrote:
> > It has the disadvantage that we may have some data which is mergeable,
> > and would in fact nonblockingly fit into a "congested" queue.  Don't
> > know if that makes a lot of difference in practice.
> 
> That's what I was thinking.  Not having a congested queue really breaks
> aio as your submit point is not supposed to incur significant latency: an
> io should -EAGAIN if it would cost a large delay to setup.
> 

So is this congestion-query interface adequate for AIO?  (It only works
for disk-backed address_spaces, but other technologies can be taught to
implement the required signalling).





The patch provides a means for the VM to be able to determine whether a
request queue is in a "congested" state.  If it is congested, then a
write to (or read from) the queue may cause blockage in
get_request_wait().

So the VM can do:

if (!bdi_write_congested(page->mapping->backing_dev_info))
	writepage(page);


This is not exact.  The code assumes that if the request queue still
has 1/4 of its capacity (queue_nr_requests) available then a request
will be non-blocking.  There is a small chance that another CPU could
zoom in and consume those requests.  But on the rare occasions where
that may happen the result will mereley be some unexpected latency -
it's not worth doing anything elaborate to prevent this.


The patch decreases the size of `batch_requests'.  batch_requests is
positively harmful - when a "heavy" writer and a "light" writer are
both writing to the same queue, batch_requests provides a means for the
heavy writer to massively stall the light writer.  Instead of waiting
for one or two requests to come free, the light writer has to wait for
32 requests to complete.

Plus batch_requests generally makes things harder to tune, understand
and predict.  I wanted to kill it altogether, but Jens says that it is
important for some hardware - it allows decent size requests to be
submitted.

The VM changes which go along with this code cause batch_requests to be
not so painful anyway - the only processes which sleep in
get_request_wait() are the ones which we elect, by design, to wait in
there - typically heavy writers.


The patch changes the meaning of `queue_nr_requests'.  It used to mean
"total number of requests per queue".  Half of these are for reads, and
half are for writes.  This always confused the heck out of me, and the
code needs to divide queue_nr_requests by two all over the place.

So queue_nr_requests now means "the number of write requests per queue"
and "the number of read requests per queue".  ie: I halved it.

Also, queue_nr_requests was converted to static scope.  Nothing else
uses it.


The accuracy of bdi_read_congested() and bdi_write_congested() depends
upon the accuracy of mapping->backing_dev_info.  With complex block
stacking arrangements it is possible that ->backing_dev_info is
pointing at the wrong queue.  I don't know.

But the cost of getting this wrong is merely latency, and if it is a
problem we can fix it up in the block layer, by getting stacking
devices to communicate their congestion state upwards in some manner.



 drivers/block/ll_rw_blk.c   |  160 +++++++++++++++++++++++++++++++++++++-------
 include/linux/backing-dev.h |   14 +++
 include/linux/blkdev.h      |    1 
 3 files changed, 151 insertions(+), 24 deletions(-)

--- 2.5.34/drivers/block/ll_rw_blk.c~queue-congestion	Wed Sep 11 18:31:52 2002
+++ 2.5.34-akpm/drivers/block/ll_rw_blk.c	Wed Sep 11 23:07:47 2002
@@ -56,13 +56,76 @@ struct blk_dev_struct blk_dev[MAX_BLKDEV
 int * blk_size[MAX_BLKDEV];
 
 /*
- * How many reqeusts do we allocate per queue,
- * and how many do we "batch" on freeing them?
+ * Number of requests per queue.  This many for reads and for writes (twice
+ * this number, total).
  */
-int queue_nr_requests, batch_requests;
+static int queue_nr_requests;
+
+/*
+ * How many free requests must be available before we wake a process which
+ * is waiting for a request?
+ */
+static int batch_requests;
+
 unsigned long blk_max_low_pfn, blk_max_pfn;
 int blk_nohighio = 0;
 
+static struct congestion_state {
+	wait_queue_head_t wqh;
+	atomic_t nr_congested_queues;
+} congestion_states[2];
+
+/*
+ * Return the threshold (number of free requests) at which the queue is
+ * considered to be congested.  It include a little hysteresis to keep the
+ * context switch rate down.
+ */
+static inline int queue_congestion_on_threshold(void)
+{
+	int ret;
+
+	ret = queue_nr_requests / 4 - 1;
+	if (ret < 0)
+		ret = 1;
+	return ret;
+}
+
+/*
+ * The threshold at which a queue is considered to be uncongested
+ */
+static inline int queue_congestion_off_threshold(void)
+{
+	int ret;
+
+	ret = queue_nr_requests / 4 + 1;
+	if (ret > queue_nr_requests)
+		ret = queue_nr_requests;
+	return ret;
+}
+
+static void clear_queue_congested(request_queue_t *q, int rw)
+{
+	enum bdi_state bit;
+	struct congestion_state *cs = &congestion_states[rw];
+
+	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
+
+	if (test_and_clear_bit(bit, &q->backing_dev_info.state))
+		atomic_dec(&cs->nr_congested_queues);
+	if (waitqueue_active(&cs->wqh))
+		wake_up(&cs->wqh);
+}
+
+static void set_queue_congested(request_queue_t *q, int rw)
+{
+	enum bdi_state bit;
+
+	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
+
+	if (!test_and_set_bit(bit, &q->backing_dev_info.state))
+		atomic_inc(&congestion_states[rw].nr_congested_queues);
+}
+
 /**
  * bdev_get_queue: - return the queue that matches the given device
  * @bdev:    device
@@ -345,8 +408,8 @@ int blk_queue_init_tags(request_queue_t 
 	struct blk_queue_tag *tags;
 	int bits, i;
 
-	if (depth > queue_nr_requests) {
-		depth = queue_nr_requests;
+	if (depth > (queue_nr_requests*2)) {
+		depth = (queue_nr_requests*2);
 		printk("blk_queue_init_tags: adjusted depth to %d\n", depth);
 	}
 
@@ -1004,7 +1067,7 @@ static int __blk_cleanup_queue(struct re
  **/
 void blk_cleanup_queue(request_queue_t * q)
 {
-	int count = queue_nr_requests;
+	int count = (queue_nr_requests*2);
 
 	count -= __blk_cleanup_queue(&q->rq[READ]);
 	count -= __blk_cleanup_queue(&q->rq[WRITE]);
@@ -1035,7 +1098,7 @@ static int blk_init_free_list(request_qu
 	 * Divide requests in half between read and write
 	 */
 	rl = &q->rq[READ];
-	for (i = 0; i < queue_nr_requests; i++) {
+	for (i = 0; i < (queue_nr_requests*2); i++) {
 		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
 		if (!rq)
 			goto nomem;
@@ -1043,7 +1106,7 @@ static int blk_init_free_list(request_qu
 		/*
 		 * half way through, switch to WRITE list
 		 */
-		if (i == queue_nr_requests / 2)
+		if (i == queue_nr_requests)
 			rl = &q->rq[WRITE];
 
 		memset(rq, 0, sizeof(struct request));
@@ -1129,7 +1192,7 @@ int blk_init_queue(request_queue_t *q, r
  * Get a free request. queue lock must be held and interrupts
  * disabled on the way in.
  */
-static inline struct request *get_request(request_queue_t *q, int rw)
+static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = q->rq + rw;
@@ -1138,6 +1201,8 @@ static inline struct request *get_reques
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queuelist);
 		rl->count--;
+		if (rl->count < queue_congestion_on_threshold())
+			set_queue_congested(q, rw);
 		rq->flags = 0;
 		rq->rq_status = RQ_ACTIVE;
 		rq->special = NULL;
@@ -1350,13 +1415,50 @@ void blk_put_request(struct request *req
 	 * it didn't come out of our reserved rq pools
 	 */
 	if (rl) {
+		int rw = 0;
+
 		list_add(&req->queuelist, &rl->free);
 
-		if (++rl->count >= batch_requests &&waitqueue_active(&rl->wait))
+		if (rl == &q->rq[WRITE])
+			rw = WRITE;
+		else if (rl == &q->rq[READ])
+			rw = READ;
+		else
+			BUG();
+
+		rl->count++;
+		if (rl->count >= queue_congestion_off_threshold())
+			clear_queue_congested(q, rw);
+		if (rl->count >= batch_requests && waitqueue_active(&rl->wait))
 			wake_up(&rl->wait);
 	}
 }
 
+/**
+ * blk_congestion_wait - wait for a queue to become uncongested
+ * @rw: READ or WRITE
+ * @timeout: timeout in jiffies
+ *
+ * Waits for up to @timeout jiffies for a queue (any queue) to exit congestion.
+ * If no queues are congested then just return, in the hope that the caller
+ * will submit some more IO.
+ */
+void blk_congestion_wait(int rw, long timeout)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	struct congestion_state *cs = &congestion_states[rw];
+
+	if (atomic_read(&cs->nr_congested_queues) == 0)
+		return;
+	blk_run_queues();
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	add_wait_queue(&cs->wqh, &wait);
+	if (atomic_read(&cs->nr_congested_queues) != 0)
+		schedule_timeout(timeout);
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&cs->wqh, &wait);
+}
+
 /*
  * Has to be called with the request spinlock acquired
  */
@@ -1866,6 +1968,7 @@ int __init blk_dev_init(void)
 {
 	struct blk_dev_struct *dev;
 	int total_ram;
+	int i;
 
 	request_cachep = kmem_cache_create("blkdev_requests",
 					   sizeof(struct request),
@@ -1882,27 +1985,36 @@ int __init blk_dev_init(void)
 	total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
 
 	/*
-	 * Free request slots per queue.
-	 * (Half for reads, half for writes)
-	 */
-	queue_nr_requests = (total_ram >> 8) & ~15;	/* One per quarter-megabyte */
-	if (queue_nr_requests < 32)
-		queue_nr_requests = 32;
-	if (queue_nr_requests > 256)
-		queue_nr_requests = 256;
-
-	/*
-	 * Batch frees according to queue length
+	 * Free request slots per queue.  One per quarter-megabyte.
+	 * We use this many requests for reads, and this many for writes.
 	 */
-	if ((batch_requests = queue_nr_requests / 4) > 32)
-		batch_requests = 32;
-	printk("block: %d slots per queue, batch=%d\n", queue_nr_requests, batch_requests);
+	queue_nr_requests = (total_ram >> 9) & ~7;
+	if (queue_nr_requests < 16)
+		queue_nr_requests = 16;
+	if (queue_nr_requests > 128)
+		queue_nr_requests = 128;
+
+	batch_requests = queue_nr_requests / 8;
+	if (batch_requests > 8)
+		batch_requests = 8;
+
+	printk("block request queues:\n");
+	printk(" %d requests per read queue\n", queue_nr_requests);
+	printk(" %d requests per write queue\n", queue_nr_requests);
+	printk(" %d requests per batch\n", batch_requests);
+	printk(" enter congestion at %d\n", queue_congestion_on_threshold());
+	printk(" exit congestion at %d\n", queue_congestion_off_threshold());
 
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
 
 	INIT_LIST_HEAD(&blk_plug_list);
 
+	for (i = 0; i < ARRAY_SIZE(congestion_states); i++) {
+		init_waitqueue_head(&congestion_states[i].wqh);
+		atomic_set(&congestion_states[i].nr_congested_queues, 0);
+	}
+
 #if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_HD)
 	hd_init();
 #endif
--- 2.5.34/include/linux/backing-dev.h~queue-congestion	Wed Sep 11 18:31:52 2002
+++ 2.5.34-akpm/include/linux/backing-dev.h	Wed Sep 11 18:31:52 2002
@@ -8,11 +8,15 @@
 #ifndef _LINUX_BACKING_DEV_H
 #define _LINUX_BACKING_DEV_H
 
+#include <asm/atomic.h>
+
 /*
  * Bits in backing_dev_info.state
  */
 enum bdi_state {
 	BDI_pdflush,		/* A pdflush thread is working this device */
+	BDI_write_congested,	/* The write queue is getting full */
+	BDI_read_congested,	/* The read queue is getting full */
 	BDI_unused,		/* Available bits start here */
 };
 
@@ -28,4 +32,14 @@ int writeback_acquire(struct backing_dev
 int writeback_in_progress(struct backing_dev_info *bdi);
 void writeback_release(struct backing_dev_info *bdi);
 
+static inline int bdi_read_congested(struct backing_dev_info *bdi)
+{
+	return test_bit(BDI_read_congested, &bdi->state);
+}
+
+static inline int bdi_write_congested(struct backing_dev_info *bdi)
+{
+	return test_bit(BDI_write_congested, &bdi->state);
+}
+
 #endif		/* _LINUX_BACKING_DEV_H */
--- 2.5.34/include/linux/blkdev.h~queue-congestion	Wed Sep 11 18:31:52 2002
+++ 2.5.34-akpm/include/linux/blkdev.h	Wed Sep 11 18:31:52 2002
@@ -341,6 +341,7 @@ extern void blk_queue_end_tag(request_qu
 extern int blk_queue_init_tags(request_queue_t *, int);
 extern void blk_queue_free_tags(request_queue_t *);
 extern void blk_queue_invalidate_tags(request_queue_t *);
+extern void blk_congestion_wait(int rw, long timeout);
 
 extern int * blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
 

.
