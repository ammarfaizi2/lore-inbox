Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUEZRCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUEZRCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbUEZRBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:01:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:20882 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265712AbUEZQ7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:59:11 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 3/5: dm-ioctl: replace dm_[add|remove]_wait_queue() with dm_wait_event()
Date: Wed, 26 May 2004 11:58:57 -0500
User-Agent: KMail/1.6
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200405261152.33233.kevcorry@us.ibm.com>
In-Reply-To: <200405261152.33233.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405261158.57176.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dm_[add|remove]_wait_queue() with dm_wait_event().

Some testing of DM multipath has turned up a problem with the DEVICE_WAIT
command. In the tests, while performing a DEVICE_WAIT on a multipath device,
the command sometimes returns immediately, even though the event-number is
correct and no path-failure has occurred to trigger an event. The problem
was tracked down to the call to schedule() in dev_wait(), which would return
even though it was not woken up by a DM table event.

This patch moves the responsibility for waiting from the ioctl interface into
the core driver, and uses wait_event_interruptible() instead of relying on
wait-queues and schedule().

--- diff/drivers/md/dm-ioctl.c	2004-05-25 10:13:20.000000000 -0500
+++ source/drivers/md/dm-ioctl.c	2004-05-25 10:13:51.000000000 -0500
@@ -850,7 +850,6 @@
 	int r;
 	struct mapped_device *md;
 	struct dm_table *table;
-	DECLARE_WAITQUEUE(wq, current);
 
 	md = find_device(param);
 	if (!md)
@@ -859,12 +858,10 @@
 	/*
 	 * Wait for a notification event
 	 */
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (!dm_add_wait_queue(md, &wq, param->event_nr)) {
-		schedule();
-		dm_remove_wait_queue(md, &wq);
+	if (dm_wait_event(md, param->event_nr)) {
+		r = -ERESTARTSYS;
+		goto out;
 	}
- 	set_current_state(TASK_RUNNING);
 
 	/*
 	 * The userland program is going to want to know what
--- diff/drivers/md/dm.c	2004-05-25 10:13:41.000000000 -0500
+++ source/drivers/md/dm.c	2004-05-25 10:13:51.000000000 -0500
@@ -80,7 +80,7 @@
 	/*
 	 * Event handling.
 	 */
-	uint32_t event_nr;
+	atomic_t event_nr;
 	wait_queue_head_t eventq;
 
 	/*
@@ -685,6 +685,7 @@
 	init_rwsem(&md->lock);
 	rwlock_init(&md->map_lock);
 	atomic_set(&md->holders, 1);
+	atomic_set(&md->event_nr, 0);
 
 	md->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!md->queue)
@@ -754,10 +755,8 @@
 {
 	struct mapped_device *md = (struct mapped_device *) context;
 
-	down_write(&md->lock);
-	md->event_nr++;
+	atomic_inc(&md->event_nr);;
 	wake_up(&md->eventq);
-	up_write(&md->lock);
 }
 
 static void __set_size(struct gendisk *disk, sector_t size)
@@ -1055,35 +1054,13 @@
  *---------------------------------------------------------------*/
 uint32_t dm_get_event_nr(struct mapped_device *md)
 {
-	uint32_t r;
-
-	down_read(&md->lock);
-	r = md->event_nr;
-	up_read(&md->lock);
-
-	return r;
-}
-
-int dm_add_wait_queue(struct mapped_device *md, wait_queue_t *wq,
-		      uint32_t event_nr)
-{
-	down_write(&md->lock);
-	if (event_nr != md->event_nr) {
-		up_write(&md->lock);
-		return 1;
-	}
-
-	add_wait_queue(&md->eventq, wq);
-	up_write(&md->lock);
-
-	return 0;
+	return atomic_read(&md->event_nr);
 }
 
-void dm_remove_wait_queue(struct mapped_device *md, wait_queue_t *wq)
+int dm_wait_event(struct mapped_device *md, int event_nr)
 {
-	down_write(&md->lock);
-	remove_wait_queue(&md->eventq, wq);
-	up_write(&md->lock);
+	return wait_event_interruptible(md->eventq,
+			(event_nr != atomic_read(&md->event_nr)));
 }
 
 /*
--- diff/drivers/md/dm.h	2004-05-09 21:32:29.000000000 -0500
+++ source/drivers/md/dm.h	2004-05-25 10:13:51.000000000 -0500
@@ -81,9 +81,7 @@
  * Event functions.
  */
 uint32_t dm_get_event_nr(struct mapped_device *md);
-int dm_add_wait_queue(struct mapped_device *md, wait_queue_t *wq,
-		      uint32_t event_nr);
-void dm_remove_wait_queue(struct mapped_device *md, wait_queue_t *wq);
+int dm_wait_event(struct mapped_device *md, int event_nr);
 
 /*
  * Info functions.
