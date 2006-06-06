Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWFFMTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWFFMTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 08:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWFFMTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 08:19:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31012 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751226AbWFFMTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 08:19:06 -0400
Date: Tue, 6 Jun 2006 14:21:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3 - crash in cfq_queue_empty() after iosched change
Message-ID: <20060606122136.GJ6693@suse.de>
References: <200606051442.k55EghgI004703@turing-police.cc.vt.edu> <20060606071537.GP4400@suse.de> <20060606072348.GQ4400@suse.de> <20060606113934.GI6693@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606113934.GI6693@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06 2006, Jens Axboe wrote:
> On Tue, Jun 06 2006, Jens Axboe wrote:
> > On Tue, Jun 06 2006, Jens Axboe wrote:
> > > On Mon, Jun 05 2006, Valdis.Kletnieks@vt.edu wrote:
> > > > I've been hitting this about once every two weeks for a while now,
> > > > probably back to a 2.6.16-rc or so.  It always bites at the same time
> > > > while my laptop was at a point very late in bootup. I finally caught
> > > > one when I had pen, paper, *and* time to chase it a bit rather than
> > > > reboot.  Sorry for the very partial traceback, it's not a good CTS day
> > > > and I didn't have a digital camera handy.
> > > > 
> > > > BUG: Unable to handle kernel NULL pointer dereference at 0x0000005c
> > > > EIP at cfq_queue_empty+0x9/0x15
> > > > call trace:
> > > > 	elv_queue_empty+0x20/0x22
> > > > 	ide_do_request+0xa4/0x788
> > > > 	ide_intr+0x1ec/0x236
> > > > 	handle_IRQ_eent+0x27/0x52
> > > > 	handle_level_IRQ+0xb6
> > > > 	do_IRQ+0x5d/0x78
> > > > 	common_interrupt+0x1a/0x20
> > > > 
> > > > In my .config:
> > > > 
> > > > CONFIG_IOSCHED_NOOP=y
> > > > CONFIG_IOSCHED_AS=y
> > > > CONFIG_IOSCHED_DEADLINE=y
> > > > CONFIG_IOSCHED_CFQ=y
> > > > CONFIG_DEFAULT_IOSCHED="anticipatory"
> > > > 
> > > > This happened very soon (within a few milliseconds or two) after my /etc/rc.local did:
> > > > 
> > > > echo cfq >| /sys/block/hda/queue/scheduler
> > > > 
> > > > (The next executable statement in /etc/rc.local is this:
> > > > echo noop >| /sys/block/hdb/queue/scheduler  and 'last sysfs file' still
> > > > pointed at /dev/hda).
> > > > 
> > > > It *looks* like the problem is in elevator_switch() in block/elevator.c:
> > > > 
> > > >        while (q->rq.elvpriv) {
> > > >                 blk_remove_plug(q);
> > > >                 q->request_fn(q);
> > > >                 spin_unlock_irq(q->queue_lock);
> > > >                 msleep(10);
> > > >                 spin_lock_irq(q->queue_lock);
> > > >                 elv_drain_elevator(q);
> > > >         }
> > > > 
> > > > this--> spin_unlock_irq(q->queue_lock);
> > > > 
> > > >         /*
> > > >          * unregister old elevator data
> > > >          */
> > > >         elv_unregister_queue(q);
> > > >         old_elevator = q->elevator;
> > > > 
> > > >         /*
> > > >          * attach and start new elevator
> > > >          */
> > > >         if (elevator_attach(q, e))
> > > >                 goto fail;
> > > > 
> > > > should be down here someplace, after elevator_attach(), I suspect?
> > > > Looks like the disk popped an IRQ after we had installed the
> > > > iosched_cfq.ops[] but q->elevator->elevator_data hadn't been
> > > > initialized yet...
> > > > 
> > > > (I'd attach a patch, except I'm not positive I have the diagnosis
> > > > right?)
> > > 
> > > I think your analysis is pretty good, there's definitely a period there
> > > where we don't want the queueing invoked. Does this help?
> > 
> > Tested here, switched 50 times between the various io schedulers while
> > the queue was fully loaded. JFYI.
> 
> It triggers non-atomic warnings though, due to spinlock -> mutex
> dependencies. This looks a little nasty to fix in a trivial enough way
> for 2.6.17. I'll ponder it a bit.

Something like this... Care to give it a spin? Preferably sooner than
later, as I want to include this in 2.6.17 if successful. Works for
me...

diff --git a/block/as-iosched.c b/block/as-iosched.c
index e25a5d7..a7caf35 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -1648,17 +1648,17 @@ static void as_exit_queue(elevator_t *e)
  * initialize elevator private data (as_data), and alloc a arq for
  * each request on the free lists
  */
-static int as_init_queue(request_queue_t *q, elevator_t *e)
+static void *as_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct as_data *ad;
 	int i;
 
 	if (!arq_pool)
-		return -ENOMEM;
+		return NULL;
 
 	ad = kmalloc_node(sizeof(*ad), GFP_KERNEL, q->node);
 	if (!ad)
-		return -ENOMEM;
+		return NULL;
 	memset(ad, 0, sizeof(*ad));
 
 	ad->q = q; /* Identify what queue the data belongs to */
@@ -1667,7 +1667,7 @@ static int as_init_queue(request_queue_t
 				GFP_KERNEL, q->node);
 	if (!ad->hash) {
 		kfree(ad);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	ad->arq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
@@ -1675,7 +1675,7 @@ static int as_init_queue(request_queue_t
 	if (!ad->arq_pool) {
 		kfree(ad->hash);
 		kfree(ad);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	/* anticipatory scheduling helpers */
@@ -1696,14 +1696,13 @@ static int as_init_queue(request_queue_t
 	ad->antic_expire = default_antic_expire;
 	ad->batch_expire[REQ_SYNC] = default_read_batch_expire;
 	ad->batch_expire[REQ_ASYNC] = default_write_batch_expire;
-	e->elevator_data = ad;
 
 	ad->current_batch_expires = jiffies + ad->batch_expire[REQ_SYNC];
 	ad->write_batch_count = ad->batch_expire[REQ_ASYNC] / 10;
 	if (ad->write_batch_count < 2)
 		ad->write_batch_count = 2;
 
-	return 0;
+	return ad;
 }
 
 /*
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 8e9d848..a46d030 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2251,14 +2251,14 @@ static void cfq_exit_queue(elevator_t *e
 	kfree(cfqd);
 }
 
-static int cfq_init_queue(request_queue_t *q, elevator_t *e)
+static void *cfq_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct cfq_data *cfqd;
 	int i;
 
 	cfqd = kmalloc(sizeof(*cfqd), GFP_KERNEL);
 	if (!cfqd)
-		return -ENOMEM;
+		return NULL;
 
 	memset(cfqd, 0, sizeof(*cfqd));
 
@@ -2288,8 +2288,6 @@ static int cfq_init_queue(request_queue_
 	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
 		INIT_HLIST_HEAD(&cfqd->cfq_hash[i]);
 
-	e->elevator_data = cfqd;
-
 	cfqd->queue = q;
 
 	cfqd->max_queued = q->nr_requests / 4;
@@ -2316,14 +2314,14 @@ static int cfq_init_queue(request_queue_
 	cfqd->cfq_slice_async_rq = cfq_slice_async_rq;
 	cfqd->cfq_slice_idle = cfq_slice_idle;
 
-	return 0;
+	return cfqd;
 out_crqpool:
 	kfree(cfqd->cfq_hash);
 out_cfqhash:
 	kfree(cfqd->crq_hash);
 out_crqhash:
 	kfree(cfqd);
-	return -ENOMEM;
+	return NULL;
 }
 
 static void cfq_slab_kill(void)
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index 399fa1e..3bd0415 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -613,24 +613,24 @@ static void deadline_exit_queue(elevator
  * initialize elevator private data (deadline_data), and alloc a drq for
  * each request on the free lists
  */
-static int deadline_init_queue(request_queue_t *q, elevator_t *e)
+static void *deadline_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct deadline_data *dd;
 	int i;
 
 	if (!drq_pool)
-		return -ENOMEM;
+		return NULL;
 
 	dd = kmalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
 	if (!dd)
-		return -ENOMEM;
+		return NULL;
 	memset(dd, 0, sizeof(*dd));
 
 	dd->hash = kmalloc_node(sizeof(struct list_head)*DL_HASH_ENTRIES,
 				GFP_KERNEL, q->node);
 	if (!dd->hash) {
 		kfree(dd);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	dd->drq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
@@ -638,7 +638,7 @@ static int deadline_init_queue(request_q
 	if (!dd->drq_pool) {
 		kfree(dd->hash);
 		kfree(dd);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	for (i = 0; i < DL_HASH_ENTRIES; i++)
@@ -653,8 +653,7 @@ static int deadline_init_queue(request_q
 	dd->writes_starved = writes_starved;
 	dd->front_merges = 1;
 	dd->fifo_batch = fifo_batch;
-	e->elevator_data = dd;
-	return 0;
+	return dd;
 }
 
 static void deadline_put_request(request_queue_t *q, struct request *rq)
diff --git a/block/elevator.c b/block/elevator.c
index 8768a36..3288f97 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -121,16 +121,23 @@ static struct elevator_type *elevator_ge
 	return e;
 }
 
-static int elevator_attach(request_queue_t *q, struct elevator_queue *eq)
+static int elevator_init_queue(request_queue_t *q, struct elevator_queue *eq,
+			       void **data)
 {
-	int ret = 0;
-
-	q->elevator = eq;
+	if (eq->ops->elevator_init_fn) {
+		*data = eq->ops->elevator_init_fn(q, eq);
+		if (*data == NULL)
+			return 1;
+	}
 
-	if (eq->ops->elevator_init_fn)
-		ret = eq->ops->elevator_init_fn(q, eq);
+	return 0;
+}
 
-	return ret;
+static void elevator_attach(request_queue_t *q, struct elevator_queue *eq,
+			   void *data)
+{
+	q->elevator = eq;
+	eq->elevator_data = data;
 }
 
 static char chosen_elevator[16];
@@ -181,6 +188,7 @@ int elevator_init(request_queue_t *q, ch
 	struct elevator_type *e = NULL;
 	struct elevator_queue *eq;
 	int ret = 0;
+	void *data;
 
 	INIT_LIST_HEAD(&q->queue_head);
 	q->last_merge = NULL;
@@ -202,10 +210,12 @@ int elevator_init(request_queue_t *q, ch
 	if (!eq)
 		return -ENOMEM;
 
-	ret = elevator_attach(q, eq);
-	if (ret)
+	if (elevator_init_queue(q, eq, &data)) {
 		kobject_put(&eq->kobj);
+		return -ENOMEM;
+	}
 
+	elevator_attach(q, eq, data);
 	return ret;
 }
 
@@ -722,13 +732,16 @@ int elv_register_queue(struct request_qu
 	return error;
 }
 
+static void __elv_unregister_queue(elevator_t *e)
+{
+	kobject_uevent(&e->kobj, KOBJ_REMOVE);
+	kobject_del(&e->kobj);
+}
+
 void elv_unregister_queue(struct request_queue *q)
 {
-	if (q) {
-		elevator_t *e = q->elevator;
-		kobject_uevent(&e->kobj, KOBJ_REMOVE);
-		kobject_del(&e->kobj);
-	}
+	if (q)
+		__elv_unregister_queue(q->elevator);
 }
 
 int elv_register(struct elevator_type *e)
@@ -780,6 +793,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
 static int elevator_switch(request_queue_t *q, struct elevator_type *new_e)
 {
 	elevator_t *old_elevator, *e;
+	void *data;
 
 	/*
 	 * Allocate new elevator
@@ -788,6 +802,11 @@ static int elevator_switch(request_queue
 	if (!e)
 		return 0;
 
+	if (elevator_init_queue(q, e, &data)) {
+		kobject_put(&e->kobj);
+		return 0;
+	}
+
 	/*
 	 * Turn on BYPASS and drain all requests w/ elevator private data
 	 */
@@ -806,19 +825,19 @@ static int elevator_switch(request_queue
 		elv_drain_elevator(q);
 	}
 
-	spin_unlock_irq(q->queue_lock);
-
 	/*
-	 * unregister old elevator data
+	 * Remember old elevator.
 	 */
-	elv_unregister_queue(q);
 	old_elevator = q->elevator;
 
 	/*
 	 * attach and start new elevator
 	 */
-	if (elevator_attach(q, e))
-		goto fail;
+	elevator_attach(q, e, data);
+
+	spin_unlock_irq(q->queue_lock);
+
+	__elv_unregister_queue(old_elevator);
 
 	if (elv_register_queue(q))
 		goto fail_register;
@@ -837,7 +856,6 @@ fail_register:
 	 */
 	elevator_exit(e);
 	e = NULL;
-fail:
 	q->elevator = old_elevator;
 	elv_register_queue(q);
 	clear_bit(QUEUE_FLAG_ELVSWITCH, &q->queue_flags);
diff --git a/block/noop-iosched.c b/block/noop-iosched.c
index f370e4a..56a7c62 100644
--- a/block/noop-iosched.c
+++ b/block/noop-iosched.c
@@ -65,16 +65,15 @@ noop_latter_request(request_queue_t *q, 
 	return list_entry(rq->queuelist.next, struct request, queuelist);
 }
 
-static int noop_init_queue(request_queue_t *q, elevator_t *e)
+static void *noop_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct noop_data *nd;
 
 	nd = kmalloc(sizeof(*nd), GFP_KERNEL);
 	if (!nd)
-		return -ENOMEM;
+		return NULL;
 	INIT_LIST_HEAD(&nd->queue);
-	e->elevator_data = nd;
-	return 0;
+	return nd;
 }
 
 static void noop_exit_queue(elevator_t *e)
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index ad133fc..1713ace 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -21,7 +21,7 @@ typedef void (elevator_put_req_fn) (requ
 typedef void (elevator_activate_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_deactivate_req_fn) (request_queue_t *, struct request *);
 
-typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
+typedef void *(elevator_init_fn) (request_queue_t *, elevator_t *);
 typedef void (elevator_exit_fn) (elevator_t *);
 
 struct elevator_ops

-- 
Jens Axboe

