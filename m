Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSFDMjJ>; Tue, 4 Jun 2002 08:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSFDMjI>; Tue, 4 Jun 2002 08:39:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43974 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316599AbSFDMjF>;
	Tue, 4 Jun 2002 08:39:05 -0400
Date: Tue, 4 Jun 2002 14:38:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020604123856.GE1105@suse.de>
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04 2002, Jens Axboe wrote:
> On Tue, Jun 04 2002, Jens Axboe wrote:
> > plug? Wrt umem, it seems you could keep 'card' in the queuedata. Same
> > for raid5 and conf.
> 
> Ok by actually looking at it, both card and conf are the queues
> themselves. So I'd say your approach is indeed a bit overkill. I'll send
> a patch in half an hour for you to review.

Alright here's the block part of it, you'll need to merge your umem and
raid5 changes in with that. I'm just interested in knowing if this is
all you want/need. It's actually just a two line changes from the last
version posted -- set q->unplug_fn in blk_init_queue to our default
(you'll override that for umem and raid5, or rather you'll set it
yourself after blk_queue_make_request()), and then call that instead of
__generic_unplug_device directly from blk_run_queues().


--- /opt/kernel/linux-2.5.20/drivers/block/ll_rw_blk.c	2002-06-03 10:35:35.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-06-04 14:35:16.000000000 +0200
@@ -795,8 +795,8 @@
  * force the transfer to start only after we have put all the requests
  * on the list.
  *
- * This is called with interrupts off and no requests on the queue.
- * (and with the request spinlock acquired)
+ * This is called with interrupts off and no requests on the queue and
+ * with the queue lock held.
  */
 void blk_plug_device(request_queue_t *q)
 {
@@ -806,7 +806,7 @@
 	if (!elv_queue_empty(q))
 		return;
 
-	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags)) {
+	if (!blk_queue_plugged(q)) {
 		spin_lock(&blk_plug_lock);
 		list_add_tail(&q->plug_list, &blk_plug_list);
 		spin_unlock(&blk_plug_lock);
@@ -814,14 +814,27 @@
 }
 
 /*
+ * remove the queue from the plugged list, if present. called with
+ * queue lock held and interrupts disabled.
+ */
+static inline int blk_remove_plug(request_queue_t *q)
+{
+	if (blk_queue_plugged(q)) {
+		spin_lock(&blk_plug_lock);
+		list_del_init(&q->plug_list);
+		spin_unlock(&blk_plug_lock);
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
  * remove the plug and let it rip..
  */
 static inline void __generic_unplug_device(request_queue_t *q)
 {
-	/*
-	 * not plugged
-	 */
-	if (!__test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+	if (!blk_remove_plug(q))
 		return;
 
 	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
@@ -849,11 +862,10 @@
 void generic_unplug_device(void *data)
 {
 	request_queue_t *q = data;
-	unsigned long flags;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irq(q->queue_lock);
 	__generic_unplug_device(q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irq(q->queue_lock);
 }
 
 /**
@@ -893,6 +905,12 @@
  **/
 void blk_stop_queue(request_queue_t *q)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_remove_plug(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
 	set_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
 }
 
@@ -904,45 +922,33 @@
  *   are currently stopped are ignored. This is equivalent to the older
  *   tq_disk task queue run.
  **/
+#define blk_plug_entry(entry) list_entry((entry), request_queue_t, plug_list)
 void blk_run_queues(void)
 {
-	struct list_head *n, *tmp, local_plug_list;
-	unsigned long flags;
+	struct list_head local_plug_list;
 
 	INIT_LIST_HEAD(&local_plug_list);
 
+	spin_lock_irq(&blk_plug_lock);
+
 	/*
 	 * this will happen fairly often
 	 */
-	spin_lock_irqsave(&blk_plug_lock, flags);
 	if (list_empty(&blk_plug_list)) {
-		spin_unlock_irqrestore(&blk_plug_lock, flags);
+		spin_unlock_irq(&blk_plug_lock);
 		return;
 	}
 
 	list_splice(&blk_plug_list, &local_plug_list);
 	INIT_LIST_HEAD(&blk_plug_list);
-	spin_unlock_irqrestore(&blk_plug_lock, flags);
+	spin_unlock_irq(&blk_plug_lock);
+	
+	while (!list_empty(&local_plug_list)) {
+		request_queue_t *q = blk_plug_entry(local_plug_list.next);
 
-	/*
-	 * local_plug_list is now a private copy we can traverse lockless
-	 */
-	list_for_each_safe(n, tmp, &local_plug_list) {
-		request_queue_t *q = list_entry(n, request_queue_t, plug_list);
+		BUG_ON(test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags));
 
-		if (!test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
-			list_del(&q->plug_list);
-			generic_unplug_device(q);
-		}
-	}
-
-	/*
-	 * add any remaining queue back to plug list
-	 */
-	if (!list_empty(&local_plug_list)) {
-		spin_lock_irqsave(&blk_plug_lock, flags);
-		list_splice(&local_plug_list, &blk_plug_list);
-		spin_unlock_irqrestore(&blk_plug_lock, flags);
+		q->unplug_fn(q);
 	}
 }
 
@@ -1085,6 +1091,7 @@
 	q->front_merge_fn      	= ll_front_merge_fn;
 	q->merge_requests_fn	= ll_merge_requests_fn;
 	q->prep_rq_fn		= NULL;
+	q->unplug_fn		= generic_unplug_device;
 	q->queue_flags		= (1 << QUEUE_FLAG_CLUSTER);
 	q->queue_lock		= lock;
 
--- /opt/kernel/linux-2.5.20/include/linux/blkdev.h	2002-06-03 10:35:40.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-06-04 14:33:04.000000000 +0200
@@ -116,7 +116,7 @@
 typedef request_queue_t * (queue_proc) (kdev_t dev);
 typedef int (make_request_fn) (request_queue_t *q, struct bio *bio);
 typedef int (prep_rq_fn) (request_queue_t *, struct request *);
-typedef void (unplug_device_fn) (void *q);
+typedef void (unplug_fn) (void *q);
 
 enum blk_queue_state {
 	Queue_down,
@@ -160,6 +160,7 @@
 	merge_requests_fn	*merge_requests_fn;
 	make_request_fn		*make_request_fn;
 	prep_rq_fn		*prep_rq_fn;
+	unplug_fn		*unplug_fn;
 
 	struct backing_dev_info	backing_dev_info;
 
@@ -209,13 +210,11 @@
 #define RQ_SCSI_DONE		0xfffe
 #define RQ_SCSI_DISCONNECTING	0xffe0
 
-#define QUEUE_FLAG_PLUGGED	0	/* queue is plugged */
-#define QUEUE_FLAG_CLUSTER	1	/* cluster several segments into 1 */
-#define QUEUE_FLAG_QUEUED	2	/* uses generic tag queueing */
-#define QUEUE_FLAG_STOPPED	3	/* queue is stopped */
+#define QUEUE_FLAG_CLUSTER	0	/* cluster several segments into 1 */
+#define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
+#define QUEUE_FLAG_STOPPED	2	/* queue is stopped */
 
-#define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
-#define blk_mark_plugged(q)	set_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
+#define blk_queue_plugged(q)	!list_empty(&(q)->plug_list)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_empty(q)	elv_queue_empty(q)
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)

-- 
Jens Axboe

