Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269863AbTGKJpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269864AbTGKJpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:45:54 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:11023 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S269863AbTGKJpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:45:16 -0400
Date: Fri, 11 Jul 2003 10:59:57 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 1/2] dm: 'wait for event' race
Message-ID: <20030711095957.GB9111@fib011235813.fsnet.co.uk>
References: <20030711095739.GA9111@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711095739.GA9111@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a race associated with the 'wait for a significant event'
functionality.  Basically userland could read the status table, then
wait for another event, but the event it was waiting for could have
occurred in the gap between reading and waiting.  To solve this we
assign identifiers to events, in order to successfully wait for an
event both userland and the kernel driver must be in agreement about
what the last event identifier was.  If they don't agree the wait call
will return immediately, allowing userland to re-read the status and
see what it missed.  The new ioctl interface will use this properly.
--- diff/drivers/md/dm-ioctl.c	2003-07-08 09:55:18.000000000 +0100
+++ source/drivers/md/dm-ioctl.c	2003-07-11 09:52:15.000000000 +0100
@@ -706,7 +706,6 @@
 static int wait_device_event(struct dm_ioctl *param, struct dm_ioctl *user)
 {
 	struct mapped_device *md;
-	struct dm_table *table;
 	DECLARE_WAITQUEUE(wq, current);
 
 	md = find_device(param);
@@ -725,12 +724,12 @@
 	 * Wait for a notification event
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
-	table = dm_get_table(md);
-	dm_table_add_wait_queue(table, &wq);
-	dm_table_put(table);
-	dm_put(md);
-
-	schedule();
+ 	if (!dm_add_wait_queue(md, &wq, dm_get_event_nr(md))) {
+ 		schedule();
+ 		dm_remove_wait_queue(md, &wq);
+ 	}
+  	set_current_state(TASK_RUNNING);
+ 	dm_put(md);
 
       out:
 	return results_to_user(user, param, NULL, 0);
--- diff/drivers/md/dm-table.c	2003-06-30 10:07:21.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-07-11 09:50:17.000000000 +0100
@@ -48,11 +48,9 @@
 	 */
 	struct io_restrictions limits;
 
-	/*
-	 * A waitqueue for processes waiting for something
-	 * interesting to happen to this table.
-	 */
-	wait_queue_head_t eventq;
+	/* events get handed up using this callback */
+	void (*event_fn)(void *);
+	void *event_context;
 };
 
 /*
@@ -222,7 +220,6 @@
 		return -ENOMEM;
 	}
 
-	init_waitqueue_head(&t->eventq);
 	t->mode = mode;
 	*result = t;
 	return 0;
@@ -243,9 +240,6 @@
 {
 	unsigned int i;
 
-	/* destroying the table counts as an event */
-	dm_table_event(t);
-
 	/* free the indexes (see dm_table_complete) */
 	if (t->depth >= 2)
 		vfree(t->index[t->depth - 2]);
@@ -694,9 +688,22 @@
 	return r;
 }
 
+static spinlock_t _event_lock = SPIN_LOCK_UNLOCKED;
+void dm_table_event_callback(struct dm_table *t,
+			     void (*fn)(void *), void *context)
+{
+	spin_lock_irq(&_event_lock);
+	t->event_fn = fn;
+	t->event_context = context;
+	spin_unlock_irq(&_event_lock);
+}
+
 void dm_table_event(struct dm_table *t)
 {
-	wake_up_interruptible(&t->eventq);
+	spin_lock(&_event_lock);
+	if (t->event_fn)
+		t->event_fn(t->event_context);
+	spin_unlock(&_event_lock);
 }
 
 sector_t dm_table_get_size(struct dm_table *t)
@@ -761,11 +768,6 @@
 	return t->mode;
 }
 
-void dm_table_add_wait_queue(struct dm_table *t, wait_queue_t *wq)
-{
-	add_wait_queue(&t->eventq, wq);
-}
-
 void dm_table_suspend_targets(struct dm_table *t)
 {
 	int i;
--- diff/drivers/md/dm.c	2003-07-08 09:55:18.000000000 +0100
+++ source/drivers/md/dm.c	2003-07-11 09:55:05.000000000 +0100
@@ -63,6 +63,12 @@
 	 * io objects are allocated from here.
 	 */
 	mempool_t *io_pool;
+
+	/*
+	 * Event handling.
+	 */
+	uint32_t event_nr;
+	wait_queue_head_t eventq;
 };
 
 #define MIN_IOS 256
@@ -619,6 +625,8 @@
 
 	atomic_set(&md->pending, 0);
 	init_waitqueue_head(&md->wait);
+	init_waitqueue_head(&md->eventq);
+
 	return md;
 }
 
@@ -634,6 +642,16 @@
 /*
  * Bind a table to the device.
  */
+static void event_callback(void *context)
+{
+	struct mapped_device *md = (struct mapped_device *) context;
+
+	down_write(&md->lock);
+	md->event_nr++;
+	wake_up_interruptible(&md->eventq);
+	up_write(&md->lock);
+}
+
 static int __bind(struct mapped_device *md, struct dm_table *t)
 {
 	request_queue_t *q = &md->queue;
@@ -645,6 +663,8 @@
 	if (size == 0)
 		return 0;
 
+	dm_table_event_callback(md->map, event_callback, md);
+
 	dm_table_get(t);
 	dm_table_set_restrictions(t, q);
 	return 0;
@@ -652,6 +672,7 @@
 
 static void __unbind(struct mapped_device *md)
 {
+	dm_table_event_callback(md->map, NULL, NULL);
 	dm_table_put(md->map);
 	md->map = NULL;
 	set_capacity(md->disk, 0);
@@ -820,6 +841,42 @@
 	return 0;
 }
 
+/*-----------------------------------------------------------------
+ * Event notification.
+ *---------------------------------------------------------------*/
+uint32_t dm_get_event_nr(struct mapped_device *md)
+{
+	uint32_t r;
+
+	down_read(&md->lock);
+	r = md->event_nr;
+	up_read(&md->lock);
+
+	return r;
+}
+
+int dm_add_wait_queue(struct mapped_device *md, wait_queue_t *wq,
+		      uint32_t event_nr)
+{
+	down_write(&md->lock);
+	if (event_nr != md->event_nr) {
+		up_write(&md->lock);
+		return 1;
+	}
+
+	add_wait_queue(&md->eventq, wq);
+	up_write(&md->lock);
+
+	return 0;
+}
+
+void dm_remove_wait_queue(struct mapped_device *md, wait_queue_t *wq)
+{
+	down_write(&md->lock);
+	remove_wait_queue(&md->eventq, wq);
+	up_write(&md->lock);
+}
+
 /*
  * The gendisk is only valid as long as you have a reference
  * count on 'md'.
--- diff/drivers/md/dm.h	2003-06-30 10:07:29.000000000 +0100
+++ source/drivers/md/dm.h	2003-07-11 09:54:54.000000000 +0100
@@ -79,6 +79,14 @@
 struct dm_table *dm_get_table(struct mapped_device *md);
 
 /*
+ * Event functions.
+ */
+uint32_t dm_get_event_nr(struct mapped_device *md);
+int dm_add_wait_queue(struct mapped_device *md, wait_queue_t *wq,
+		      uint32_t event_nr);
+void dm_remove_wait_queue(struct mapped_device *md, wait_queue_t *wq);
+
+/*
  * Info functions.
  */
 struct gendisk *dm_disk(struct mapped_device *md);
@@ -96,6 +104,8 @@
 int dm_table_add_target(struct dm_table *t, const char *type,
 			sector_t start,	sector_t len, char *params);
 int dm_table_complete(struct dm_table *t);
+void dm_table_event_callback(struct dm_table *t,
+			     void (*fn)(void *), void *context);
 void dm_table_event(struct dm_table *t);
 sector_t dm_table_get_size(struct dm_table *t);
 struct dm_target *dm_table_get_target(struct dm_table *t, unsigned int index);
@@ -104,7 +114,6 @@
 unsigned int dm_table_get_num_targets(struct dm_table *t);
 struct list_head *dm_table_get_devices(struct dm_table *t);
 int dm_table_get_mode(struct dm_table *t);
-void dm_table_add_wait_queue(struct dm_table *t, wait_queue_t *wq);
 void dm_table_suspend_targets(struct dm_table *t);
 void dm_table_resume_targets(struct dm_table *t);
 
