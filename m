Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317313AbSFCIkC>; Mon, 3 Jun 2002 04:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317315AbSFCIkB>; Mon, 3 Jun 2002 04:40:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49574 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317313AbSFCIj7>;
	Mon, 3 Jun 2002 04:39:59 -0400
Date: Mon, 3 Jun 2002 10:39:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/16] unplugging fix
Message-ID: <20020603083937.GA23527@suse.de>
In-Reply-To: <3CF88852.BCFBF774@zip.com.au> <3CF9CB92.A6BF921B@zip.com.au> <20020602081204.GD820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02 2002, Jens Axboe wrote:
> On Sun, Jun 02 2002, Andrew Morton wrote:
> > Andrew Morton wrote:
> > > 
> > > There's a plugging bug in 2.5.19.  Once you start pushing several disks
> > > hard, the new unplug code gets confused and queues are left in plugged
> > > state, but not on the plug list.  They never get unplugged and the
> > > machine dies mysteriously.
> > > 
> > 
> > This patch didn't fix it.  It made it tons better, but I again have a
> > wedged box.  Same symptoms - against IDE this time.
> > 
> > blk_plug_list is empty.  queue_flags=0x03.  Interestingly,
> > q->plug_list is non-empty, non-zero, both list members pointing at
> > a list which isn't either itself or blk_plug_list.
> > 
> > I note that the code isn't taking queues off the plug list when the queue
> > is destroyed.  Guess that doesn't matter - we never destroy a plugged
> > queue...
> > 
> > This one is killing me.
> 
> I've got a good handle on how to clean the whole plugging thing up, I
> suspect it will make this case easier to fix. I'll be back with that
> tomorrow, still got guests...

Does this work? I can't poke holes in it, but then again...

--- /opt/kernel/linux-2.5.20/drivers/block/ll_rw_blk.c	2002-06-03 10:35:35.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-06-03 10:37:26.000000000 +0200
@@ -821,7 +821,7 @@
 	/*
 	 * not plugged
 	 */
-	if (!__test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+	if (!test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
 		return;
 
 	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
@@ -893,6 +893,17 @@
  **/
 void blk_stop_queue(request_queue_t *q)
 {
+	/*
+	 * remove from the plugged list, queue must not be called.
+	 */
+	if (test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&blk_plug_lock, flags);
+		list_del(&q->plug_list);
+		spin_unlock_irqrestore(&blk_plug_lock, flags);
+	}
+
 	set_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
 }
 
@@ -904,45 +915,36 @@
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

