Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSFDHZb>; Tue, 4 Jun 2002 03:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSFDHZb>; Tue, 4 Jun 2002 03:25:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43176 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316503AbSFDHZ3>;
	Tue, 4 Jun 2002 03:25:29 -0400
Date: Tue, 4 Jun 2002 09:25:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/16] unplugging fix
Message-ID: <20020604072522.GA1105@suse.de>
In-Reply-To: <3CF88852.BCFBF774@zip.com.au> <3CF9CB92.A6BF921B@zip.com.au> <20020602081204.GD820@suse.de> <20020603083937.GA23527@suse.de> <3CFB3383.44A6CC96@zip.com.au> <20020603094121.GB23527@suse.de> <3CFBC307.70F0581A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > On Mon, Jun 03 2002, Andrew Morton wrote:
> > > Jens Axboe wrote:
> > > >
> > > > ...
> > > > Does this work? I can't poke holes in it, but then again...
> > >
> > > It survives a 30-minute test.  It would not have done that
> > > before...
> > 
> > Excellent.
> 
> Hope so.  My Friday-night-notfix wouild have survived that long :(

Still good?

> > > Are you sure blk_stop_queue() and blk_run_queues() can't
> > > race against each other?  Seems there's a window where
> > > they could both do a list_del().
> > 
> > Hmm I'd prefer to just use the safe variant and not rely on the plugged
> > flag when the lock isn't held, so here's my final version with just that
> > change. Agree?
> 
> Not really ;)
> 
> There still seems to be a window where blk_run_queues() will
> assume the queue is on local_plug_list while not holding
> plug_list_lock.  The QUEUE_PLUGGED flag is set, so blk_stop_queue()
> will remove the queue from local_plug_list.  Then blk_run_queues()
> removes it as well.  The new list_head debug code will rudely
> catch that.
> 
> I'd be more comfortable if the duplicated info in QUEUE_FLAG_PLUGGED
> and "presence on a list" were made fully atomic/coherent via
> blk_plug_lock?

I agree, at least that makes it more clear. Alright, here's the next
version. I've removed the plugged flag since it really serves no purpose
anymore when we can just look at the list status. AFAICS, it's safe to
call blk_queue_plugged() with just the queue lock held, even if
blk_plug_list changes underneath us we'll get the rigth result (it'll
always return !list_empty regardless), only for insertion/deletion do we
grab the blk_plug_lock.

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
 

-- 
Jens Axboe

