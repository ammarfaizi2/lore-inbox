Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUK0HrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUK0HrP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUK0G6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:58:00 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36031 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261618AbUKZTJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:09:41 -0500
Date: Fri, 26 Nov 2004 08:43:16 +0100
From: Jens Axboe <axboe@suse.de>
To: "Christopher S. Aker" <caker@theshore.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-bk7 - Badness in cfq_put_request at drivers/block/cfq-iosched.c:1402
Message-ID: <20041126074316.GI10456@suse.de>
References: <001301c4d1f6$941d1370$0201a8c0@hawk> <20041124130139.GC13847@suse.de> <20041124132449.GD13847@suse.de> <002e01c4d22a$f426f630$0201a8c0@hawk> <20041124134038.GF13847@suse.de> <000f01c4d25b$e8d497c0$0201a8c0@hawk> <20041125184336.GA7330@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125184336.GA7330@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25 2004, Jens Axboe wrote:
> On Wed, Nov 24 2004, Christopher S. Aker wrote:
> > > Can you try this simple check to see if it triggers anything?
> > >
> > > ===== cfq-iosched.c 1.13 vs edited =====
> > > --- 1.13/drivers/block/cfq-iosched.c 2004-10-30 01:35:21 +02:00
> > > +++ edited/cfq-iosched.c 2004-11-24 14:40:13 +01:00
> > > @@ -1389,6 +1389,8 @@
> > >   struct cfq_data *cfqd = q->elevator->elevator_data;
> > >   struct cfq_rq *crq = RQ_DATA(rq);
> > >
> > > + WARN_ON(!spin_is_locked(q->queue_lock));
> > > +
> > >   if (crq) {
> > >   struct cfq_queue *cfqq = crq->cfq_queue;
> > 
> > I'd be happy to, but I won't have a free machine for a couple of days.
> > I'll can probably give it a shot during the weekend...
> 
> Nevermind, here's a patch to fix it. I was so focused on the decrement
> side of things that I forgot to check the increment, pretty silly error
> really.

And a small fix is needed on top of that, in case of hash type changes
(writing to hash_key).

Signed-off-by: Jens Axboe <axboe@suse.de>

===== drivers/block/cfq-iosched.c 1.13 vs edited =====
--- 1.13/drivers/block/cfq-iosched.c	2004-10-30 01:35:21 +02:00
+++ edited/drivers/block/cfq-iosched.c	2004-11-26 08:40:36 +01:00
@@ -1398,10 +1398,7 @@
 		if (crq->io_context)
 			put_io_context(crq->io_context->ioc);
 
-		if (!cfqq->allocated[crq->is_write]) {
-			WARN_ON(1);
-			cfqq->allocated[crq->is_write] = 1;
-		}
+		BUG_ON(!cfqq->allocated[crq->is_write]);
 		cfqq->allocated[crq->is_write]--;
 
 		mempool_free(crq, cfqd->crq_pool);
@@ -1439,20 +1436,30 @@
 #endif
 	}
 
+repeat:
 	if (cfqq->allocated[rw] >= cfqd->max_queued)
 		goto out_lock;
 
+	cfqq->allocated[rw]++;
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	/*
-	 * if hashing type has changed, the cfq_queue might change here. we
-	 * don't bother rechecking ->allocated since it should be a rare
-	 * event
+	 * if hashing type has changed, the cfq_queue might change here.
 	 */
 	cic = cfq_get_io_context(&cfqq, gfp_mask);
 	if (!cic)
 		goto err;
 
+	/*
+	 * repeat allocation checks on queue change
+	 */
+	if (unlikely(cic->cfqq != cfqq)) {
+		spin_lock_irqsave(q->queue_lock, flags);
+		cfqq->allocated[rw]--;
+		cfqq = cic->cfqq;
+		goto repeat;
+	}
+
 	crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
 	if (crq) {
 		RB_CLEAR(&crq->rb_node);
@@ -1465,7 +1472,6 @@
 		crq->in_flight = crq->accounted = crq->is_sync = 0;
 		crq->is_write = rw;
 		rq->elevator_private = crq;
-		cfqq->allocated[rw]++;
 		cfqq->alloc_limit[rw] = 0;
 		return 0;
 	}
@@ -1473,6 +1479,7 @@
 	put_io_context(cic->ioc);
 err:
 	spin_lock_irqsave(q->queue_lock, flags);
+	cfqq->allocated[rw]--;
 	cfq_put_queue(cfqq);
 out_lock:
 	spin_unlock_irqrestore(q->queue_lock, flags);

-- 
Jens Axboe

