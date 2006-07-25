Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWGYJjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWGYJjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWGYJjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:39:35 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:53698 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932255AbWGYJjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:39:33 -0400
Subject: [PATCH 1/2] blk request timeout handler: add blk layer helpers
From: Mike Christie <michaelc@cs.wisc.edu>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@suse.de
Content-Type: text/plain
Date: Tue, 25 Jul 2006 05:39:39 -0400
Message-Id: <1153820379.4166.23.camel@max>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just moves the scsi helpers from the scsi layer to
the block layer. They also hook into the block layer code
at blkdev_dequeue_request, blk_requeue_request and blk_complete_request.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

diff -aurp linux-2.6.18-rc2/block/ll_rw_blk.c linux-2.6.18-rc2.blkeh/block/ll_rw_blk.c
--- linux-2.6.18-rc2/block/ll_rw_blk.c	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/block/ll_rw_blk.c	2006-07-25 04:24:23.000000000 -0400
@@ -217,6 +217,19 @@ void blk_queue_softirq_done(request_queu
 
 EXPORT_SYMBOL(blk_queue_softirq_done);
 
+void blk_queue_rq_timeout(request_queue_t *q, unsigned int timeout)
+{
+	q->rq_timeout = timeout;
+}
+EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
+
+void blk_queue_rq_timed_out(request_queue_t *q, rq_timed_out_fn *fn)
+{
+	q->rq_timed_out_fn = fn;
+}
+
+EXPORT_SYMBOL_GPL(blk_queue_rq_timed_out);
+
 /**
  * blk_queue_make_request - define an alternate make_request function for a device
  * @q:  the request queue for the device to be affected
@@ -281,7 +294,9 @@ static inline void rq_init(request_queue
 {
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_LIST_HEAD(&rq->donelist);
+	init_timer(&rq->timer);
 
+	rq->timeout = 0;
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->bio = rq->biotail = NULL;
@@ -2245,6 +2260,7 @@ EXPORT_SYMBOL(blk_get_request);
  */
 void blk_requeue_request(request_queue_t *q, struct request *rq)
 {
+	blk_delete_timer(rq);
 	blk_add_trace_rq(q, rq, BLK_TA_REQUEUE);
 
 	if (blk_rq_tagged(rq))
@@ -3409,24 +3425,107 @@ static struct notifier_block __devinitda
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /**
- * blk_complete_request - end I/O on a request
- * @req:      the request being processed
+ * blk_delete_timer - Delete/cancel timer for a given function.
+ * @req:	request that we are canceling timer for
  *
- * Description:
- *     Ends all I/O on a request. It does not handle partial completions,
- *     unless the driver actually implements this in its completion callback
- *     through requeueing. Theh actual completion happens out-of-order,
- *     through a softirq handler. The user must have registered a completion
- *     callback through blk_queue_softirq_done().
+ * Return value:
+ *     1 if we were able to detach the timer.  0 if we blew it, and the
+ *     timer function has already started to run.
  **/
+int blk_delete_timer(struct request *req)
+{
+	int rtn;
 
-void blk_complete_request(struct request *req)
+	if (!req->q->rq_timed_out_fn)
+		return 1;
+
+	rtn = del_timer(&req->timer);
+	req->timer.data = (unsigned long)NULL;
+	req->timer.function = NULL;
+
+	return rtn;
+}
+
+EXPORT_SYMBOL_GPL(blk_delete_timer);
+
+static void blk_rq_timed_out(struct request *req)
+{
+	struct request_queue *q = req->q;
+
+	switch (q->rq_timed_out_fn(req)) {
+	case BLK_EH_HANDLED:
+		__blk_complete_request(req);
+		return;
+	case BLK_EH_RESET_TIMER:
+		blk_add_timer(req);
+		return;
+	case BLK_EH_NOT_HANDLED:
+		/*
+		 * LLD handles this for now but in the future
+		 * we can send a request msg to abort the command
+		 * and we can move more of the generic scsi eh code to
+		 * the blk layer.
+		 */
+		return;
+	}
+}
+
+/**
+ * blk_abort_req -- Request request recovery for the specified command
+ * req:		pointer to the request of interest
+ *
+ * This function requests that the block layer start recovery for the
+ * request by deleting the timer and calling the q's timeout function.
+ * LLDDs who implement their own error recovery MAY ignore the timeout
+ * event if they generated blk_abort_req.
+ */
+void blk_abort_req(struct request *req)
+{
+        if (!blk_delete_timer(req))
+                return;
+        blk_rq_timed_out(req);
+}
+
+EXPORT_SYMBOL_GPL(blk_abort_req);
+
+/**
+ * blk_add_timer - Start timeout timer for a single request
+ * @req:	request that is about to start running.
+ *
+ * Notes:
+ *    Each request has its own timer, and as it is added to the queue, we
+ *    set up the timer.  When the request completes, we cancel the timer.
+ **/
+void blk_add_timer(struct request *req)
+{
+	struct request_queue *q = req->q;
+
+	/*
+	 * If the clock was already running for this command, then
+	 * first delete the timer.  The timer handling code gets rather
+	 * confused if we don't do this.
+	 */
+	if (req->timer.function)
+		del_timer(&req->timer);
+
+	req->timer.data = (unsigned long)req;
+	if (req->timeout)
+		req->timer.expires = jiffies + req->timeout;
+	else
+		req->timer.expires = jiffies + q->rq_timeout;
+	req->timer.function = (void (*)(unsigned long))blk_rq_timed_out;
+        add_timer(&req->timer);
+}
+
+EXPORT_SYMBOL_GPL(blk_add_timer);
+
+void __blk_complete_request(struct request *req)
 {
 	struct list_head *cpu_list;
 	unsigned long flags;
 
 	BUG_ON(!req->q->softirq_done_fn);
-		
+
 	local_irq_save(flags);
 
 	cpu_list = &__get_cpu_var(blk_cpu_done);
@@ -3436,8 +3535,37 @@ void blk_complete_request(struct request
 	local_irq_restore(flags);
 }
 
+EXPORT_SYMBOL_GPL(__blk_complete_request);
+
+/**
+ * blk_complete_request - end I/O on a request
+ * @req:	the request being processed
+ *
+ * Description:
+ *     Ends all I/O on a request. It does not handle partial completions,
+ *     unless the driver actually implements this in its completion callback
+ *     through requeueing. Theh actual completion happens out-of-order,
+ *     through a softirq handler. The user must have registered a completion
+ *     callback through blk_queue_softirq_done().
+ **/
+void blk_complete_request(struct request *req)
+{
+	/*
+	 * We don't have to worry about this one timing out any more.
+	 * If we are unable to remove the timer, then the command
+	 * has already timed out.  In which case, we have no choice but to
+	 * let the timeout function run, as we have no idea where in fact
+	 * that function could really be.  It might be on another processor,
+	 * etc, etc.
+	 */
+	if (!blk_delete_timer(req))
+		return;
+
+	__blk_complete_request(req);
+}
+
 EXPORT_SYMBOL(blk_complete_request);
-	
+
 /*
  * queue lock must be held
  */
diff -aurp linux-2.6.18-rc2/include/linux/blkdev.h linux-2.6.18-rc2.blkeh/include/linux/blkdev.h
--- linux-2.6.18-rc2/include/linux/blkdev.h	2006-07-15 17:53:08.000000000 -0400
+++ linux-2.6.18-rc2.blkeh/include/linux/blkdev.h	2006-07-25 03:30:46.000000000 -0400
@@ -191,6 +191,7 @@ struct request {
 	void *data;
 	void *sense;
 
+	struct timer_list timer;
 	unsigned int timeout;
 	int retries;
 
@@ -298,6 +299,14 @@ typedef int (issue_flush_fn) (request_qu
 typedef void (prepare_flush_fn) (request_queue_t *, struct request *);
 typedef void (softirq_done_fn)(struct request *);
 
+enum blk_eh_timer_return {
+	BLK_EH_NOT_HANDLED,
+	BLK_EH_HANDLED,
+	BLK_EH_RESET_TIMER,
+};
+
+typedef enum blk_eh_timer_return (rq_timed_out_fn)(struct request *);
+
 enum blk_queue_state {
 	Queue_down,
 	Queue_up,
@@ -339,6 +348,7 @@ struct request_queue
 	issue_flush_fn		*issue_flush_fn;
 	prepare_flush_fn	*prepare_flush_fn;
 	softirq_done_fn		*softirq_done_fn;
+	rq_timed_out_fn		*rq_timed_out_fn;
 
 	/*
 	 * Dispatch queue sorting
@@ -411,6 +421,8 @@ struct request_queue
 	unsigned int		nr_sorted;
 	unsigned int		in_flight;
 
+	unsigned int		rq_timeout;
+
 	/*
 	 * sg stuff
 	 */
@@ -654,6 +666,10 @@ extern int end_that_request_chunk(struct
 extern void end_that_request_last(struct request *, int);
 extern void end_request(struct request *req, int uptodate);
 extern void blk_complete_request(struct request *);
+extern void __blk_complete_request(struct request *);
+extern void blk_abort_req(struct request *);
+extern int blk_delete_timer(struct request *);
+extern void blk_add_timer(struct request *);
 
 static inline int rq_all_done(struct request *rq, unsigned int nr_bytes)
 {
@@ -675,6 +691,8 @@ static inline int rq_all_done(struct req
 
 static inline void blkdev_dequeue_request(struct request *req)
 {
+	if (req->q->rq_timed_out_fn)
+		blk_add_timer(req);
 	elv_dequeue_request(req->q, req);
 }
 
@@ -713,6 +731,8 @@ extern void blk_queue_prep_rq(request_qu
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
 extern void blk_queue_dma_alignment(request_queue_t *, int);
 extern void blk_queue_softirq_done(request_queue_t *, softirq_done_fn *);
+extern void blk_queue_rq_timed_out(request_queue_t *, rq_timed_out_fn *);
+extern void blk_queue_rq_timeout(request_queue_t *, unsigned int);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 extern int blk_queue_ordered(request_queue_t *, unsigned, prepare_flush_fn *);
 extern void blk_queue_issue_flush_fn(request_queue_t *, issue_flush_fn *);


