Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSFCJll>; Mon, 3 Jun 2002 05:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSFCJlk>; Mon, 3 Jun 2002 05:41:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30892 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317340AbSFCJli>;
	Mon, 3 Jun 2002 05:41:38 -0400
Date: Mon, 3 Jun 2002 11:41:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/16] unplugging fix
Message-ID: <20020603094121.GB23527@suse.de>
In-Reply-To: <3CF88852.BCFBF774@zip.com.au> <3CF9CB92.A6BF921B@zip.com.au> <20020602081204.GD820@suse.de> <20020603083937.GA23527@suse.de> <3CFB3383.44A6CC96@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > ...
> > Does this work? I can't poke holes in it, but then again...
> 
> It survives a 30-minute test.  It would not have done that
> before...

Excellent.

> Are you sure blk_stop_queue() and blk_run_queues() can't
> race against each other?  Seems there's a window where
> they could both do a list_del().

Hmm I'd prefer to just use the safe variant and not rely on the plugged
flag when the lock isn't held, so here's my final version with just that
change. Agree?

--- /opt/kernel/linux-2.5.20/drivers/block/ll_rw_blk.c	2002-06-03 10:35:35.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-06-03 11:40:35.000000000 +0200
@@ -821,7 +821,7 @@
 	/*
 	 * not plugged
 	 */
-	if (!__test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+	if (!test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
 		return;
 
 	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
@@ -893,6 +893,20 @@
  **/
 void blk_stop_queue(request_queue_t *q)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	/*
+	 * remove from the plugged list, queue must not be called.
+	 */
+	if (test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags)) {
+		spin_lock(&blk_plug_lock);
+		list_del(&q->plug_list);
+		spin_unlock(&blk_plug_lock);
+	}
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
 	set_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
 }
 
@@ -904,45 +918,36 @@
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
-
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
+		list_del(&q->plug_list);
+		__generic_unplug_device(q);
+		spin_unlock_irq(q->queue_lock);
 	}
 }
 


-- 
Jens Axboe

