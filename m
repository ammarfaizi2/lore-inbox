Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSFDIJf>; Tue, 4 Jun 2002 04:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSFDIJe>; Tue, 4 Jun 2002 04:09:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3756 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316532AbSFDIJd>;
	Tue, 4 Jun 2002 04:09:33 -0400
Date: Tue, 4 Jun 2002 10:09:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/16] unplugging fix
Message-ID: <20020604080927.GC1105@suse.de>
In-Reply-To: <3CF88852.BCFBF774@zip.com.au> <3CF9CB92.A6BF921B@zip.com.au> <20020602081204.GD820@suse.de> <20020603083937.GA23527@suse.de> <3CFB3383.44A6CC96@zip.com.au> <20020603094121.GB23527@suse.de> <3CFBC307.70F0581A@zip.com.au> <20020604072522.GA1105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04 2002, Jens Axboe wrote:
> I agree, at least that makes it more clear. Alright, here's the next

[snip]

forgot to diff blkdev.h. here's a new complete version.

--- /opt/kernel/linux-2.5.20/drivers/block/ll_rw_blk.c	2002-06-03 10:35:35.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-06-04 09:23:12.000000000 +0200
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
 
@@ -904,45 +922,35 @@
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
-
-	/*
-	 * local_plug_list is now a private copy we can traverse lockless
-	 */
-	list_for_each_safe(n, tmp, &local_plug_list) {
-		request_queue_t *q = list_entry(n, request_queue_t, plug_list);
+	spin_unlock_irq(&blk_plug_lock);
+	
+	while (!list_empty(&local_plug_list)) {
+		request_queue_t *q = blk_plug_entry(local_plug_list.next);
 
-		if (!test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
-			list_del(&q->plug_list);
-			generic_unplug_device(q);
-		}
-	}
+		BUG_ON(test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags));
 
-	/*
-	 * add any remaining queue back to plug list
-	 */
-	if (!list_empty(&local_plug_list)) {
-		spin_lock_irqsave(&blk_plug_lock, flags);
-		list_splice(&local_plug_list, &blk_plug_list);
-		spin_unlock_irqrestore(&blk_plug_lock, flags);
+		spin_lock_irq(q->queue_lock);
+		__generic_unplug_device(q);
+		spin_unlock_irq(q->queue_lock);
 	}
 }
 
--- /opt/kernel/linux-2.5.20/include/linux/blkdev.h	2002-06-03 10:35:40.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-06-04 09:17:46.000000000 +0200
@@ -209,13 +209,11 @@
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

