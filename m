Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUIVTpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUIVTpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUIVTpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:45:40 -0400
Received: from peabody.ximian.com ([130.57.169.10]:45706 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266805AbUIVTjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:39:36 -0400
Subject: Re: [patch] inotify: locking
From: Robert Love <rml@novell.com>
To: ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1095881861.5090.59.camel@betsy.boston.ximian.com>
References: <1095881861.5090.59.camel@betsy.boston.ximian.com>
Content-Type: multipart/mixed; boundary="=-XfKyqCwCfyA9xgZ9BAt6"
Date: Wed, 22 Sep 2004 15:38:27 -0400
Message-Id: <1095881907.5090.60.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XfKyqCwCfyA9xgZ9BAt6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-09-22 at 15:37 -0400, Robert Love wrote:

> Attached patch is against your latest, plus the previous postings.

Evolution needs a heuristic to detect when I say that I attached
something, but when in reality I did not.  I do this all the time -
sorry.

Patch attached for real this time.

	Robert Love


--=-XfKyqCwCfyA9xgZ9BAt6
Content-Disposition: attachment; filename=inotify-locking-1.patch
Content-Type: text/x-patch; name=inotify-locking-1.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

 drivers/char/inotify.c |  189 +++++++++++++++++++++++++++++--------------------
 1 files changed, 114 insertions(+), 75 deletions(-)

--- linux-inotify/drivers/char/inotify.c	2004-09-22 15:30:58.774848096 -0400
+++ linux/drivers/char/inotify.c	2004-09-22 15:30:46.207758584 -0400
@@ -73,7 +73,7 @@
 	struct list_head 	events;
 	struct list_head 	watchers;
 	spinlock_t		lock;
-	atomic_t		event_count;
+	unsigned int		event_count;
 	int			nr_watches;
 };
 
@@ -182,22 +182,33 @@
 						(event_mask == IN_IGNORED) || \
 						(event_mask & watchers_mask))
 
-
-/* dev->lock == locked before calling */
-static void inotify_dev_queue_event (struct inotify_device *dev, struct inotify_watcher *watcher, int mask, const char *filename) {
+/*
+ * inotify_dev_queue_event - add a new event to the given device
+ *
+ * Caller must hold dev->lock.
+ */
+static void inotify_dev_queue_event (struct inotify_device *dev,
+				     struct inotify_watcher *watcher, int mask,
+				     const char *filename)
+{
 	struct inotify_kernel_event *kevent;
 
-	/* The queue has already overflowed and we have already sent the Q_OVERFLOW event */
-	if (atomic_read(&dev->event_count) > MAX_INOTIFY_QUEUED_EVENTS) {
-		iprintk(INOTIFY_DEBUG_EVENTS, "event queue for %p overflowed\n", dev);
+	/*
+	 * the queue has already overflowed and we have already sent the
+	 * Q_OVERFLOW event
+	 */
+	if (dev->event_count > MAX_INOTIFY_QUEUED_EVENTS) {
+		iprintk(INOTIFY_DEBUG_EVENTS,
+			"event queue for %p overflowed\n", dev);
 		return;
 	}
 
-	/* The queue has just overflowed and we need to notify user space that it has */
-	if (atomic_read(&dev->event_count) == MAX_INOTIFY_QUEUED_EVENTS) {
-		atomic_inc(&dev->event_count);
+	/* the queue has just overflowed and we need to notify user space */
+	if (dev->event_count == MAX_INOTIFY_QUEUED_EVENTS) {
+		dev->event_count++;
 		kevent = kernel_event(-1, IN_Q_OVERFLOW, NULL);
-		iprintk(INOTIFY_DEBUG_EVENTS, "sending IN_Q_OVERFLOW to %p\n", dev);
+		iprintk(INOTIFY_DEBUG_EVENTS, "sending IN_Q_OVERFLOW to %p\n",
+			dev);
 		goto add_event_to_queue;
 	}
 
@@ -205,13 +216,13 @@
 		return;
 	}
 
-	atomic_inc(&dev->event_count);
+	dev->event_count++;
 	kevent = kernel_event (watcher->wd, mask, filename);
 
 add_event_to_queue:
 	if (!kevent) {
 		iprintk(INOTIFY_DEBUG_EVENTS, "failed to queue event for %p -- could not allocate kevent\n", dev);
-		atomic_dec(&dev->event_count);
+		dev->event_count--;
 		return;
 	}
 
@@ -222,66 +233,77 @@
 
 
 
-
-static void inotify_dev_event_dequeue (struct inotify_device *dev) {
+/*
+ * inotify_dev_event_dequeue - destroy an event on the given device
+ *
+ * Caller must hold dev->lock.
+ */
+static void inotify_dev_event_dequeue(struct inotify_device *dev)
+{
 	struct inotify_kernel_event *kevent;
 
-	if (!inotify_dev_has_events (dev)) {
+	if (!inotify_dev_has_events(dev))
 		return;
-	}
 
 	kevent = inotify_dev_get_event(dev);
 
 	list_del(&kevent->list);
-	atomic_dec(&dev->event_count);
+	dev->event_count--;
 
 	delete_kernel_event (kevent);
 
 	iprintk(INOTIFY_DEBUG_EVENTS, "dequeued event on %p\n", dev);
 }
 
+/*
+ * inotify_dev_get_wd - returns the next WD for use by the given dev
+ *
+ * Caller must hold dev->lock before calling.
+ */
 static int inotify_dev_get_wd (struct inotify_device *dev)
 {
 	int wd;
 
-	wd = -1;
-
-	if (!dev)
-		return -1;
-
-	if (dev->nr_watches == MAX_INOTIFY_DEV_WATCHERS) {
+	if (!dev || dev->nr_watches == MAX_INOTIFY_DEV_WATCHERS)
 		return -1;
-	}
 
 	dev->nr_watches++;
-
 	wd = find_first_zero_bit (dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);
-
 	set_bit (wd, dev->bitmask);
 
 	return wd;
 }
 
-static int inotify_dev_put_wd (struct inotify_device *dev, int wd)
+/*
+ * inotify_dev_put_wd - release the given WD on the given device
+ *
+ * Caller must hold dev->lock.
+ */
+static int inotify_dev_put_wd(struct inotify_device *dev, int wd)
 {
-	if (!dev||wd < 0)
+	if (!dev || wd < 0)
 		return -1;
 
 	dev->nr_watches--;
-
-	clear_bit (wd, dev->bitmask);
+	clear_bit(wd, dev->bitmask);
 
 	return 0;
 }
 
-
-static struct inotify_watcher *create_watcher (struct inotify_device *dev, int mask, struct inode *inode) {
+/*
+ * create_watcher - creates a watcher on the given device.
+ *
+ * Grabs dev->lock, so the caller must not hold it.
+ */
+static struct inotify_watcher *create_watcher (struct inotify_device *dev,
+					       int mask, struct inode *inode)
+{
 	struct inotify_watcher *watcher;
 
 	watcher = kmem_cache_alloc (watcher_cache, GFP_KERNEL);
-
 	if (!watcher) {
-		iprintk(INOTIFY_DEBUG_ALLOC, "failed to allocate watcher (%p,%d)\n", inode, mask);
+		iprintk(INOTIFY_DEBUG_ALLOC,
+			"failed to allocate watcher (%p,%d)\n", inode, mask);
 		return NULL;
 	}
 
@@ -294,7 +316,7 @@
 	INIT_LIST_HEAD(&watcher->u_list);
 
 	spin_lock(&dev->lock);
-		watcher->wd = inotify_dev_get_wd (dev);
+	watcher->wd = inotify_dev_get_wd (dev);
 	spin_unlock(&dev->lock);
 
 	if (watcher->wd < 0) {
@@ -309,29 +331,35 @@
 	return watcher;
 }
 
-/* Must be called with dev->lock held */
-static void delete_watcher (struct inotify_device *dev, struct inotify_watcher *watcher) {
+/*
+ * delete_watcher - removes the given 'watcher' from the given 'dev'
+ *
+ * Caller must hold dev->lock.
+ */
+static void delete_watcher (struct inotify_device *dev,
+			    struct inotify_watcher *watcher)
+{
 	inotify_dev_put_wd (dev, watcher->wd);
-
 	iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
-
 	kmem_cache_free (watcher_cache, watcher);
-
 	watcher_object_count--;
 }
 
-
-static struct inotify_watcher *inode_find_dev (struct inode *inode, struct inotify_device *dev) {
+/*
+ * inotify_find_dev - find the watcher associated with the given inode and dev
+ *
+ * Caller must hold dev->lock.
+ */
+static struct inotify_watcher *inode_find_dev (struct inode *inode,
+					       struct inotify_device *dev)
+{
 	struct inotify_watcher *watcher;
 
-	watcher = NULL;
-
 	list_for_each_entry (watcher, &inode->watchers, i_list) {
-		if (watcher->dev == dev) {
+		if (watcher->dev == dev)
 			return watcher;
-		}
-
 	}
+
 	return NULL;
 }
 
@@ -385,16 +413,20 @@
 	return error;
 }
 
-static int inotify_dev_rm_watcher (struct inotify_device *dev, struct inotify_watcher *watcher) {
+/*
+ * inotify_dev_rm_watcher - remove the given watch from the given device
+ *
+ * Caller must hold dev->lock because we call inotify_dev_queue_event().
+ */
+static int inotify_dev_rm_watcher (struct inotify_device *dev,
+				   struct inotify_watcher *watcher)
+{
 	int error;
 
 	error = -EINVAL;
-
 	if (watcher) {
 		inotify_dev_queue_event (dev, watcher, IN_IGNORED, NULL);
-
 		list_del(&watcher->d_list);
-
 		error = 0;
 	} 
 
@@ -413,16 +445,21 @@
 	inode->watchers_mask = new_mask;
 }
 
-static int inode_add_watcher (struct inode *inode, struct inotify_watcher *watcher) {
-	if (!inode||!watcher||inode_find_dev (inode, watcher->dev))
+/*
+ * inode_add_watcher - add a watcher to the given inode
+ *
+ * Callers must hold dev->lock, because we call inode_find_dev().
+ */
+static int inode_add_watcher (struct inode *inode,
+			      struct inotify_watcher *watcher)
+{
+	if (!inode || !watcher || inode_find_dev (inode, watcher->dev))
 		return -EINVAL;
 
 	list_add(&watcher->i_list, &inode->watchers);
 	inode->watcher_count++;
-
 	inode_update_watchers_mask (inode);
 
-
 	return 0;
 }
 
@@ -440,16 +477,18 @@
 
 /* Kernel API */
 
-void inotify_inode_queue_event (struct inode *inode, unsigned long mask, const char *filename) {
+void inotify_inode_queue_event (struct inode *inode, unsigned long mask,
+				const char *filename)
+{
 	struct inotify_watcher *watcher;
 
 	spin_lock(&inode->i_lock);
 
-		list_for_each_entry (watcher, &inode->watchers, i_list) {
-			spin_lock(&watcher->dev->lock);
-				inotify_dev_queue_event (watcher->dev, watcher, mask, filename);
-			spin_unlock(&watcher->dev->lock);
-		}
+	list_for_each_entry(watcher, &inode->watchers, i_list) {
+		spin_lock(&watcher->dev->lock);
+		inotify_dev_queue_event(watcher->dev, watcher, mask, filename);
+		spin_unlock(&watcher->dev->lock);
+	}
 
 	spin_unlock(&inode->i_lock);
 }
@@ -479,7 +518,7 @@
 	dev = watcher->dev;
 
 	if (event)
-		inotify_dev_queue_event (dev, watcher, event, NULL);
+		inotify_dev_queue_event(dev, watcher, event, NULL);
 
 	inode_rm_watcher (inode, watcher);
 	inotify_dev_rm_watcher (watcher->dev, watcher);
@@ -529,7 +568,7 @@
 	INIT_LIST_HEAD(&umount);
 
 	spin_lock(&inode_lock);
-		build_umount_list (&inode_in_use, sb, &umount);
+	build_umount_list (&inode_in_use, sb, &umount);
 	spin_unlock(&inode_lock);
 
 	process_umount_list (&umount);
@@ -584,7 +623,6 @@
 		goto out;
 
 	events = 0;
-	event_count = 0;
 	out = 0;
 	err = 0;
 
@@ -609,12 +647,12 @@
 		}
 	}
 
-	spin_lock_irq(&dev->lock);
+	spin_lock(&dev->lock);
 
 	add_wait_queue(&dev->wait, &wait);
 repeat:
 	if (signal_pending(current)) {
-		spin_unlock_irq (&dev->lock);
+		spin_unlock(&dev->lock);
 		out = -ERESTARTSYS;
 		set_current_state (TASK_RUNNING);
 		remove_wait_queue(&dev->wait, &wait);
@@ -622,9 +660,9 @@
 	}
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (!inotify_dev_has_events (dev)) {
-		spin_unlock_irq (&dev->lock);
+		spin_unlock(&dev->lock);
 		schedule ();
-		spin_lock_irq (&dev->lock);
+		spin_lock(&dev->lock);
 		goto repeat;
 	}
 
@@ -646,7 +684,7 @@
 		inotify_dev_event_dequeue (dev);
 	}
 
-	spin_unlock_irq (&dev->lock);
+	spin_unlock(&dev->lock);
 
 	/* Send the event buffer to user space */
 	err = copy_to_user (buf, eventbuf, events * sizeof(struct inotify_event));
@@ -693,7 +731,7 @@
 	init_timer(&dev->timer);
 	init_waitqueue_head(&dev->wait);
 
-	atomic_set(&dev->event_count, 0);
+	dev->event_count = 0;
 	dev->nr_watches = 0;
 	dev->lock = SPIN_LOCK_UNLOCKED;
 
@@ -719,12 +757,14 @@
 	}
 }
 
+/*
+ * inotify_release_all_events - destroy all of the events on a given device
+ */
 static void inotify_release_all_events (struct inotify_device *dev)
 {
 	spin_lock(&dev->lock);
-	while (inotify_dev_has_events(dev)) {
+	while (inotify_dev_has_events(dev))
 		inotify_dev_event_dequeue(dev);
-	}
 	spin_unlock(&dev->lock);
 }
 
@@ -797,7 +837,6 @@
 	spin_unlock (&inode->i_lock);
 	spin_unlock (&dev->lock);
 
-
 	watcher = create_watcher (dev, request->mask, inode);
 
 	if (!watcher) {
@@ -870,7 +909,7 @@
 	spin_lock(&dev->lock);
 
 	printk (KERN_ALERT "inotify device: %p\n", dev);
-	printk (KERN_ALERT "inotify event_count: %d\n", atomic_read(&dev->event_count));
+	printk (KERN_ALERT "inotify event_count: %u\n", dev->event_count);
 	printk (KERN_ALERT "inotify watch_count: %d\n", dev->nr_watches);
 
 	spin_unlock(&dev->lock);

--=-XfKyqCwCfyA9xgZ9BAt6--

