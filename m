Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUCAWOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUCAWOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:14:54 -0500
Received: from fmr09.intel.com ([192.52.57.35]:11943 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261455AbUCAWOg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:14:36 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: per-cpu blk_plug_list
Date: Mon, 1 Mar 2004 14:14:16 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB501F2AB4E@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: per-cpu blk_plug_list
Thread-Index: AcP/2Xdj2W76Fn0YSdaDax9BrbZoiQAACU4Q
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 01 Mar 2004 22:14:17.0708 (UTC) FILETIME=[89D7CAC0:01C3FFDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> (you should inline patches, or at least make sure they have
> the proper mimetype so one can comment on them inlined).

My email client sucks and usually screw up with inline patch.
Here is the patch again. (please don't blame if it got messed up).

diff -Nurp linux-2.6.3/drivers/block/ll_rw_blk.c
linux-2.6.3.blk/drivers/block/ll_rw_blk.c
--- linux-2.6.3/drivers/block/ll_rw_blk.c	2004-02-17 19:57:16
+++ linux-2.6.3.blk/drivers/block/ll_rw_blk.c	2004-03-01 11:36:09
@@ -39,8 +39,7 @@ static kmem_cache_t *request_cachep;
 /*
  * plug management
  */
-static LIST_HEAD(blk_plug_list);
-static spinlock_t blk_plug_lock __cacheline_aligned_in_smp =
SPIN_LOCK_UNLOCKED;
+static struct blk_plug_struct blk_plug_array[NR_CPUS];
 
 static wait_queue_head_t congestion_wqh[2];
 
@@ -1096,10 +1095,14 @@ void blk_plug_device(request_queue_t *q)
 	 */
 	if (!blk_queue_plugged(q)
 	    && !test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
-		spin_lock(&blk_plug_lock);
-		list_add_tail(&q->plug_list, &blk_plug_list);
+		struct blk_plug_struct * local_blk_plug =
+
&blk_plug_array[smp_processor_id()];
+
+		spin_lock(&local_blk_plug->blk_plug_lock);
+		list_add_tail(&q->plug_list,
&local_blk_plug->blk_plug_head);
+		q->blk_plug = local_blk_plug;
 		mod_timer(&q->unplug_timer, jiffies + q->unplug_delay);
-		spin_unlock(&blk_plug_lock);
+		spin_unlock(&local_blk_plug->blk_plug_lock);
 	}
 }
 
@@ -1113,10 +1116,11 @@ int blk_remove_plug(request_queue_t *q)
 {
 	WARN_ON(!irqs_disabled());
 	if (blk_queue_plugged(q)) {
-		spin_lock(&blk_plug_lock);
+		struct blk_plug_struct * blk_plug = q->blk_plug;
+		spin_lock(&blk_plug->blk_plug_lock);
 		list_del_init(&q->plug_list);
 		del_timer(&q->unplug_timer);
-		spin_unlock(&blk_plug_lock);
+		spin_unlock(&blk_plug->blk_plug_lock);
 		return 1;
 	}
 
@@ -1237,6 +1241,26 @@ void blk_run_queue(struct request_queue 
 
 EXPORT_SYMBOL(blk_run_queue);
 
+/*
+ * blk_run_queues_cpu - fire all plugged queues on this cpu
+ */
+#define blk_plug_entry(entry) list_entry((entry), request_queue_t,
plug_list)
+void blk_run_queues_cpu(int cpu)
+{
+	struct blk_plug_struct * cur_blk_plug = &blk_plug_array[cpu];
+	struct list_head * head = &cur_blk_plug->blk_plug_head;
+	spinlock_t *lock = &cur_blk_plug->blk_plug_lock;
+
+	spin_lock_irq(lock);
+	while (!list_empty(head)) {
+		request_queue_t *q = blk_plug_entry(head->next);
+		spin_unlock_irq(lock);
+		q->unplug_fn(q);
+		spin_lock_irq(lock);
+	}
+	spin_unlock_irq(lock);
+}
+
 /**
  * blk_run_queues - fire all plugged queues
  *
@@ -1245,30 +1269,12 @@ EXPORT_SYMBOL(blk_run_queue);
  *   are currently stopped are ignored. This is equivalent to the older
  *   tq_disk task queue run.
  **/
-#define blk_plug_entry(entry) list_entry((entry), request_queue_t,
plug_list)
 void blk_run_queues(void)
 {
-	LIST_HEAD(local_plug_list);
-
-	spin_lock_irq(&blk_plug_lock);
-
-	/*
-	 * this will happen fairly often
-	 */
-	if (list_empty(&blk_plug_list))
-		goto out;
-
-	list_splice_init(&blk_plug_list, &local_plug_list);
-	
-	while (!list_empty(&local_plug_list)) {
-		request_queue_t *q =
blk_plug_entry(local_plug_list.next);
+	int i;
 
-		spin_unlock_irq(&blk_plug_lock);
-		q->unplug_fn(q);
-		spin_lock_irq(&blk_plug_lock);
-	}
-out:
-	spin_unlock_irq(&blk_plug_lock);
+	for_each_cpu(i)
+		blk_run_queues_cpu(i);
 }
 
 EXPORT_SYMBOL(blk_run_queues);
@@ -2687,6 +2693,11 @@ int __init blk_dev_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(congestion_wqh); i++)
 		init_waitqueue_head(&congestion_wqh[i]);
+
+	for (i = 0; i < NR_CPUS; i++) {
+		INIT_LIST_HEAD(&blk_plug_array[i].blk_plug_head);
+		spin_lock_init(&blk_plug_array[i].blk_plug_lock);
+	}
 	return 0;
 }
 
diff -Nurp linux-2.6.3/fs/direct-io.c linux-2.6.3.blk/fs/direct-io.c
--- linux-2.6.3/fs/direct-io.c	2004-02-17 19:58:16
+++ linux-2.6.3.blk/fs/direct-io.c	2004-03-01 11:36:09
@@ -329,7 +329,7 @@ static struct bio *dio_await_one(struct 
 		if (dio->bio_list == NULL) {
 			dio->waiter = current;
 			spin_unlock_irqrestore(&dio->bio_list_lock,
flags);
-			blk_run_queues();
+			blk_run_queues_cpu(smp_processor_id());
 			io_schedule();
 			spin_lock_irqsave(&dio->bio_list_lock, flags);
 			dio->waiter = NULL;
@@ -960,7 +960,7 @@ direct_io_worker(int rw, struct kiocb *i
 		if (ret == 0)
 			ret = dio->result;	/* Bytes written */
 		finished_one_bio(dio);		/* This can free the dio
*/
-		blk_run_queues();
+		blk_run_queues_cpu(smp_processor_id());
 	} else {
 		finished_one_bio(dio);
 		ret2 = dio_await_completion(dio);
diff -Nurp linux-2.6.3/include/linux/blkdev.h
linux-2.6.3.blk/include/linux/blkdev.h
--- linux-2.6.3/include/linux/blkdev.h	2004-02-17 19:57:20
+++ linux-2.6.3.blk/include/linux/blkdev.h	2004-03-01 11:36:09
@@ -267,6 +267,11 @@ struct blk_queue_tag {
 	atomic_t refcnt;		/* map can be shared */
 };
 
+struct blk_plug_struct {
+	struct list_head	blk_plug_head;
+	spinlock_t		blk_plug_lock;
+} ____cacheline_aligned;
+
 struct request_queue
 {
 	/*
@@ -316,6 +321,7 @@ struct request_queue
 	int			bounce_gfp;
 
 	struct list_head	plug_list;
+	struct blk_plug_struct	*blk_plug;	/* blk_plug it belongs
to */
 
 	/*
 	 * various queue flags, see QUEUE_* below
diff -Nurp linux-2.6.3/include/linux/fs.h
linux-2.6.3.blk/include/linux/fs.h
--- linux-2.6.3/include/linux/fs.h	2004-02-17 19:57:20
+++ linux-2.6.3.blk/include/linux/fs.h	2004-03-01 11:36:09
@@ -1152,6 +1152,7 @@ extern int blkdev_put(struct block_devic
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
 extern void blk_run_queues(void);
+extern void blk_run_queues_cpu(int);
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, char *);
