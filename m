Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbUJ0GE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUJ0GE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUJ0GE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:04:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4507 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261664AbUJ0GE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:04:26 -0400
Date: Wed, 27 Oct 2004 08:04:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] issues with online scheduler switching
Message-ID: <20041027060359.GD15910@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are two issues with online io scheduler switching that this patch
addresses. The first is pretty simple - it concerns racing with
scheduler removal on switch. elevator_find() does not grab a reference
to the io scheduler, so before elevator_attach() is run it could go
away. Add elevator_get() to solve that.

Second issue is the flushing out of requests that is needed before
switching can be problematic with requests that aren't allocated in the
block layer (such as requests on the stack of a process). The problem is
that we don't know when they will have finished, and most io schedulers
need to access the elevator structures on io completion. This can be
fixed by adding an intermedia step that switches to noop, since it
doesn't need to touch anything but the request_queue. The queue drain
can then safely be split into two operations - one that waits for file
system requests, and one that waits for the queue to completely empty.
Requests arriving after the first drain will get stuck in a seperate
queue list.

Signed-off-by: Jens Axboe <axboe@suse.de>

===== drivers/block/elevator.c 1.60 vs edited =====
--- 1.60/drivers/block/elevator.c	2004-10-19 11:40:18 +02:00
+++ edited/drivers/block/elevator.c	2004-10-27 07:55:57 +02:00
@@ -113,14 +113,28 @@
 	return e;
 }
 
+static void elevator_put(struct elevator_type *e)
+{
+	module_put(e->elevator_owner);
+}
+
+static struct elevator_type *elevator_get(const char *name)
+{
+	struct elevator_type *e = elevator_find(name);
+
+	if (!e)
+		return NULL;
+	if (!try_module_get(e->elevator_owner))
+		return NULL;
+
+	return e;
+}
+
 static int elevator_attach(request_queue_t *q, struct elevator_type *e,
 			   struct elevator_queue *eq)
 {
 	int ret = 0;
 
-	if (!try_module_get(e->elevator_owner))
-		return -EINVAL;
-
 	memset(eq, 0, sizeof(*eq));
 	eq->ops = &e->ops;
 	eq->elevator_type = e;
@@ -156,7 +170,8 @@
 #else
 #error "You must build at least 1 IO scheduler into the kernel"
 #endif
-	printk("elevator: using %s as default io scheduler\n", chosen_elevator);
+	printk(KERN_INFO "elevator: using %s as default io scheduler\n",
+							chosen_elevator);
 }
 
 static int __init elevator_setup(char *str)
@@ -178,17 +193,21 @@
 	if (!name)
 		name = chosen_elevator;
 
-	e = elevator_find(name);
+	e = elevator_get(name);
 	if (!e)
 		return -EINVAL;
 
 	eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
-	if (!eq)
+	if (!eq) {
+		elevator_put(e->elevator_type);
 		return -ENOMEM;
+	}
 
 	ret = elevator_attach(q, e, eq);
-	if (ret)
+	if (ret) {
 		kfree(eq);
+		elevator_put(e->elevator_type);
+	}
 
 	return ret;
 }
@@ -198,7 +217,7 @@
 	if (e->ops->elevator_exit_fn)
 		e->ops->elevator_exit_fn(e);
 
-	module_put(e->elevator_type->elevator_owner);
+	elevator_put(e->elevator_type);
 	e->elevator_type = NULL;
 	kfree(e);
 }
@@ -271,15 +290,24 @@
 		blk_plug_device(q);
 
 	rq->q = q;
-	q->elevator->ops->elevator_add_req_fn(q, rq, where);
 
-	if (blk_queue_plugged(q)) {
-		int nrq = q->rq.count[READ] + q->rq.count[WRITE] - q->in_flight;
+	if (!test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {
+		q->elevator->ops->elevator_add_req_fn(q, rq, where);
 
-		if (nrq == q->unplug_thresh)
-			__generic_unplug_device(q);
-	}
+		if (blk_queue_plugged(q)) {
+			int nrq = q->rq.count[READ] + q->rq.count[WRITE]
+				  - q->in_flight;
 
+			if (nrq == q->unplug_thresh)
+				__generic_unplug_device(q);
+		}
+	} else
+		/*
+		 * if drain is set, store the request "locally". when the drain
+		 * is finished, the requests will be handed ordered to the io
+		 * scheduler
+		 */
+		list_add_tail(&rq->queuelist, &q->drain_list);
 }
 
 void elv_add_request(request_queue_t *q, struct request *rq, int where,
@@ -333,7 +361,8 @@
 			end_that_request_chunk(rq, 0, nr_bytes);
 			end_that_request_last(rq);
 		} else {
-			printk("%s: bad return=%d\n", __FUNCTION__, ret);
+			printk(KERN_ERR "%s: bad return=%d\n", __FUNCTION__,
+								ret);
 			break;
 		}
 	}
@@ -486,7 +515,7 @@
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock_irq(&elv_list_lock);
 
-	printk("io scheduler %s registered\n", e->elevator_name);
+	printk(KERN_INFO "io scheduler %s registered\n", e->elevator_name);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(elv_register);
@@ -503,19 +532,25 @@
  * switch to new_e io scheduler. be careful not to introduce deadlocks -
  * we don't free the old io scheduler, before we have allocated what we
  * need for the new one. this way we have a chance of going back to the old
- * one, if the new one fails init for some reason
+ * one, if the new one fails init for some reason. we also do an intermediate
+ * switch to noop to ensure safety with stack-allocated requests, since they
+ * don't originate from the block layer allocator. noop is safe here, because
+ * it never needs to touch the elevator itself for completion events. DRAIN
+ * flags will make sure we don't touch it for additions either.
  */
 static void elevator_switch(request_queue_t *q, struct elevator_type *new_e)
 {
 	elevator_t *e = kmalloc(sizeof(elevator_t), GFP_KERNEL);
+	struct elevator_type *noop_elevator = NULL;
 	elevator_t *old_elevator;
 
-	if (!e) {
-		printk("elevator: out of memory\n");
-		return;
-	}
+	if (!e)
+		goto error;
 
-	blk_wait_queue_drained(q);
+	/*
+	 * first step, drain requests from the block freelist
+	 */
+	blk_wait_queue_drained(q, 0);
 
 	/*
 	 * unregister old elevator data
@@ -524,6 +559,18 @@
 	old_elevator = q->elevator;
 
 	/*
+ 	 * next step, switch to noop since it uses no private rq structures
+	 * and doesn't allocate any memory for anything. then wait for any
+	 * non-fs requests in-flight
+ 	 */
+	noop_elevator = elevator_get("noop");
+	spin_lock_irq(q->queue_lock);
+	elevator_attach(q, noop_elevator, e);
+	spin_unlock_irq(q->queue_lock);
+
+	blk_wait_queue_drained(q, 1);
+
+	/*
 	 * attach and start new elevator
 	 */
 	if (elevator_attach(q, new_e, e))
@@ -537,6 +584,7 @@
 	 */
 	elevator_exit(old_elevator);
 	blk_finish_queue_drain(q);
+	elevator_put(noop_elevator);
 	return;
 
 fail_register:
@@ -549,7 +597,11 @@
 	q->elevator = old_elevator;
 	elv_register_queue(q);
 	blk_finish_queue_drain(q);
-	printk("elevator: switch to %s failed\n", new_e->elevator_name);
+error:
+	if (noop_elevator)
+		elevator_put(noop_elevator);
+	elevator_put(new_e);
+	printk(KERN_ERR "elevator: switch to %s failed\n",new_e->elevator_name);
 }
 
 ssize_t elv_iosched_store(request_queue_t *q, const char *name, size_t count)
@@ -563,11 +615,14 @@
 	if (elevator_name[strlen(elevator_name) - 1] == '\n')
 		elevator_name[strlen(elevator_name) - 1] = '\0';
 
-	e = elevator_find(elevator_name);
+	e = elevator_get(elevator_name);
 	if (!e) {
-		printk("elevator: type %s not found\n", elevator_name);
+		printk(KERN_ERR "elevator: type %s not found\n", elevator_name);
 		return -EINVAL;
 	}
+
+	if (!strcmp(elevator_name, q->elevator->elevator_type->elevator_name))
+		return count;
 
 	elevator_switch(q, e);
 	return count;
===== drivers/block/ll_rw_blk.c 1.276 vs edited =====
--- 1.276/drivers/block/ll_rw_blk.c	2004-10-25 22:06:47 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2004-10-27 07:56:32 +02:00
@@ -261,6 +261,8 @@
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 
 	blk_queue_activity_fn(q, NULL, NULL);
+
+	INIT_LIST_HEAD(&q->drain_list);
 }
 
 EXPORT_SYMBOL(blk_queue_make_request);
@@ -2481,20 +2483,42 @@
 void blk_finish_queue_drain(request_queue_t *q)
 {
 	struct request_list *rl = &q->rq;
+	struct request *rq;
 
+	spin_lock_irq(q->queue_lock);
 	clear_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
+
+	while (!list_empty(&q->drain_list)) {
+		rq = list_entry_rq(q->drain_list.next);
+
+		list_del_init(&rq->queuelist);
+		__elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
+	}
+
+	spin_unlock_irq(q->queue_lock);
+
 	wake_up(&rl->wait[0]);
 	wake_up(&rl->wait[1]);
 	wake_up(&rl->drain);
 }
 
+static int wait_drain(request_queue_t *q, struct request_list *rl, int dispatch)
+{
+	int wait = rl->count[READ] + rl->count[WRITE];
+
+	if (dispatch)
+		wait += !list_empty(&q->queue_head);
+
+	return wait;
+}
+
 /*
  * We rely on the fact that only requests allocated through blk_alloc_request()
  * have io scheduler private data structures associated with them. Any other
  * type of request (allocated on stack or through kmalloc()) should not go
  * to the io scheduler core, but be attached to the queue head instead.
  */
-void blk_wait_queue_drained(request_queue_t *q)
+void blk_wait_queue_drained(request_queue_t *q, int wait_dispatch)
 {
 	struct request_list *rl = &q->rq;
 	DEFINE_WAIT(wait);
@@ -2502,10 +2526,10 @@
 	spin_lock_irq(q->queue_lock);
 	set_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
 
-	while (rl->count[READ] || rl->count[WRITE]) {
+	while (wait_drain(q, rl, wait_dispatch)) {
 		prepare_to_wait(&rl->drain, &wait, TASK_UNINTERRUPTIBLE);
 
-		if (rl->count[READ] || rl->count[WRITE]) {
+		if (wait_drain(q, rl, wait_dispatch)) {
 			__generic_unplug_device(q);
 			spin_unlock_irq(q->queue_lock);
 			io_schedule();
===== include/linux/blkdev.h 1.155 vs edited =====
--- 1.155/include/linux/blkdev.h	2004-10-22 01:22:23 +02:00
+++ edited/include/linux/blkdev.h	2004-10-27 07:55:57 +02:00
@@ -377,6 +377,8 @@
 	 */
 	unsigned int		sg_timeout;
 	unsigned int		sg_reserved_size;
+
+	struct list_head	drain_list;
 };
 
 #define RQ_INACTIVE		(-1)
@@ -604,7 +606,7 @@
 extern void generic_unplug_device(request_queue_t *);
 extern void __generic_unplug_device(request_queue_t *);
 extern long nr_blockdev_pages(void);
-extern void blk_wait_queue_drained(request_queue_t *);
+extern void blk_wait_queue_drained(request_queue_t *, int);
 extern void blk_finish_queue_drain(request_queue_t *);
 
 int blk_get_queue(request_queue_t *);

-- 
Jens Axboe

