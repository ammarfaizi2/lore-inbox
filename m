Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267494AbUG2Wg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUG2Wg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267503AbUG2Wgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:36:45 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:23498
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S267497AbUG2WbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:31:13 -0400
Date: Thu, 29 Jul 2004 18:31:31 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] inotify 0.8
Message-ID: <20040729223131.GA7602@tentacle.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am resubmitting inotify for comments and review. Inotify has
changed drastically from the earlier proposal that Al Viro did not approve of.
There is no longer any use of (device number, inode number) pairs. Please
give this version of inotify a fresh view.

Inotify is designed as a replacement for dnotify. The key difference's
are that inotify does not require the file to be opened to watch it,
when you are watching something with inotify it can go away (if path
is unmounted) and you will be sent an event telling you it is gone and
events are delivered over a fd not by using signals.

Inotify is a character device that when opened offers 2 IOCTL's.
(It actually has 4 but the other 2 are used for debugging)

INOTIFY_WATCH:
	Which takes a path and event mask and returns a unique 
	(to the instance of the driver) integer (wd [watcher descriptor]
	from here on) that is a 1:1 mapping to the path passed. 
	What happens is inotify gets the inode (and ref's the inode)
	for the path and adds a inotify_watcher structure to the inodes
	list of watchers. If this instance of the driver is already
	watching the path, the event mask will be updated and
	the original wd will be returned.

INOTIFY_IGNORE:
	Which takes an integer (that you got from INOTIFY_WATCH) 
	representing a wd that you are not interested in watching
	anymore. This will:

	send an IGNORE event to the device
	remove the inotify_watcher structure from the device and 
	from the inode and unref the inode.
	

After you are watching 1 or more paths, you can read from the fd
and get events. The events are struct inotify_event. If you are
watching a directory and something happens to a file in the directory
the event will contain the filename (just the filename not the full path).


***KERNEL VFS CHANGES START HERE***

Aside from the inotify character device driver. 
The changes to the kernel are very minor. 

The first change is adding calls to inotify_inode_queue_event and
inotify_dentry_parent_queue_event from the various vfs functions. This
is identical to dnotify.

The second change is more serious, it adds a call to inotify_super_block_umount
inside generic_shutdown_superblock. What inotify_super_block_umount does
is:

find all of the inodes that are on the super block being shut down,
sends each watcher on each inode the UNMOUNT and IGNORED event
removes the watcher structures from each instance of the device driver 
and each inode.
unref's the inode.

I have tested this code on my system for over a week now and have not
had problems. I would appreciate design review, code review and testing.


Attached is the patch to Linux 2.6.7

John

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inotify.patch"

diff -urN clean/linux-2.6.7/drivers/char/inotify.c linux-2.6.7/drivers/char/inotify.c
--- clean/linux-2.6.7/drivers/char/inotify.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.7/drivers/char/inotify.c	2004-07-28 21:53:51.000000000 -0400
@@ -0,0 +1,949 @@
+/*
+ * Inode based directory notifications for Linux.
+ *
+ * Copyright (C) 2004 John McCutchan
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * Signed-off-by: John McCutchan ttb@tentacle.dhs.org
+ */
+
+/* TODO:
+ * enhance read() so that we return as many events that will fit in buf
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/writeback.h>
+#include <linux/inotify.h>
+
+#define MAX_INOTIFY_DEVS 8 /* We only support 8 watchers */
+#define MAX_INOTIFY_DEV_WATCHERS 64 /* A dev can only have 64 watchers */
+#define MAX_INOTIFY_QUEUED_EVENTS 64 /* Only the first 256 events will be queued */
+#define __BITMASK_SIZE (MAX_INOTIFY_DEV_WATCHERS / 8)
+
+#define INOTIFY_DEV_TIMER_TIME jiffies + (HZ/4)
+
+static atomic_t watcher_count; // < MAX_INOTIFY_DEVS
+
+static kmem_cache_t *watcher_cache;
+static kmem_cache_t *kevent_cache;
+
+/* For debugging */
+static int event_object_count;
+static int watcher_object_count;
+static int inode_ref_count;
+static int inotify_debug_flags;
+#define iprintk(f, str...) if (inotify_debug_flags & f) printk (KERN_ALERT str)
+
+/* For each inotify device we need to keep a list of events queued on it,
+ * a list of inodes that we are watching and other stuff.
+ */
+struct inotify_device {
+	struct list_head 	events;
+	atomic_t		event_count;
+	struct list_head 	watchers;
+	int			watcher_count;
+	wait_queue_head_t 	wait;
+	struct timer_list	timer;
+	char			read_state;
+	spinlock_t		lock;
+	void *			bitmask;
+};
+#define inotify_device_event_list(pos) list_entry((pos), struct inotify_event, list)
+
+struct inotify_watcher {
+	int 			wd; // watcher descriptor
+	unsigned long		mask;
+	struct inode *		inode;
+	struct inotify_device *	dev;
+	struct list_head	d_list; // device list
+	struct list_head	i_list; // inode list
+	struct list_head	u_list; // unmount list 
+};
+#define inotify_watcher_d_list(pos) list_entry((pos), struct inotify_watcher, d_list)
+#define inotify_watcher_i_list(pos) list_entry((pos), struct inotify_watcher, i_list)
+#define inotify_watcher_u_list(pos) list_entry((pos), struct inotify_watcher, u_list)
+
+/* A list of these is attached to each instance of the driver
+ * when the drivers read() gets called, this list is walked and
+ * all events that can fit in the buffer get delivered
+ */
+struct inotify_kernel_event {
+        struct list_head        list;
+	struct inotify_event	event;
+};
+#define list_to_inotify_kernel_event(pos) list_entry((pos), struct inotify_kernel_event, list)
+
+static int find_inode (const char __user *dirname, struct inode **inode)
+{
+	struct nameidata nd;
+	int error;
+
+	error = __user_walk (dirname, LOOKUP_FOLLOW, &nd);
+	if (error) {
+		iprintk(INOTIFY_DEBUG_INODE, "could not find inode\n");
+		goto out;
+	}
+
+	*inode = nd.dentry->d_inode;
+	__iget (*inode);
+	iprintk(INOTIFY_DEBUG_INODE, "ref'd inode\n");
+	inode_ref_count++;
+	path_release(&nd);
+out:
+	return error;
+}
+
+static void unref_inode (struct inode *inode) {
+	inode_ref_count--;
+	iprintk(INOTIFY_DEBUG_INODE, "unref'd inode\n");
+	iput (inode);
+}
+
+struct inotify_kernel_event *kernel_event (int wd, int mask, const char *filename) {
+	struct inotify_kernel_event *kevent;
+
+	kevent = kmem_cache_alloc (kevent_cache, GFP_ATOMIC);
+
+
+	if (!kevent) {
+		iprintk(INOTIFY_DEBUG_ALLOC, "failed to alloc kevent (%d,%d)\n", wd, mask);
+		goto out;
+	}
+
+	iprintk(INOTIFY_DEBUG_ALLOC, "alloced kevent %p (%d,%d)\n", kevent, wd, mask);
+
+	kevent->event.wd = wd;
+	kevent->event.mask = mask;
+	INIT_LIST_HEAD(&kevent->list);
+
+	if (filename) {
+		iprintk(INOTIFY_DEBUG_FILEN, "filename for event was %p %s\n", filename, filename);
+		strncpy (kevent->event.filename, filename, 256);
+		kevent->event.filename[255] = '\0';
+		iprintk(INOTIFY_DEBUG_FILEN, "filename after copying %s\n", kevent->event.filename);
+	} else {
+		iprintk(INOTIFY_DEBUG_FILEN, "no filename for event\n");
+		kevent->event.filename[0] = '\0';
+	}
+	
+	event_object_count++;
+
+out:
+	return kevent;
+}
+
+void delete_kernel_event (struct inotify_kernel_event *kevent) {
+	if (!kevent) return;
+
+	event_object_count--;
+
+	INIT_LIST_HEAD(&kevent->list);
+	kevent->event.wd = -1;
+	kevent->event.mask = 0;
+
+	iprintk(INOTIFY_DEBUG_ALLOC, "free'd kevent %p\n", kevent);
+	kmem_cache_free (kevent_cache, kevent);
+}
+
+#define inotify_dev_has_events(dev) (!list_empty(&dev->events))
+#define inotify_dev_get_event(dev) (list_to_inotify_kernel_event(dev->events.next))
+/* Does this events mask get sent to the watcher ? */
+#define event_and(event_mask,watchers_mask) 	((event_mask == IN_UNMOUNT) || \
+						(event_mask == IN_IGNORED) || \
+						(event_mask & watchers_mask))
+
+
+/* dev->lock == locked before calling */
+static void inotify_dev_queue_event (struct inotify_device *dev, struct inotify_watcher *watcher, int mask, const char *filename) {
+	struct inotify_kernel_event *kevent;
+
+	if (atomic_read(&dev->event_count) == MAX_INOTIFY_QUEUED_EVENTS) {
+		iprintk(INOTIFY_DEBUG_EVENTS, "event queue for %p overflowed\n", dev);
+		return;
+	}
+
+	if (!event_and(mask, watcher->inode->watchers_mask)||!event_and(mask, watcher->mask)) {
+		return;
+	}
+
+	atomic_inc(&dev->event_count);
+
+	kevent = kernel_event (watcher->wd, mask, filename);
+
+	if (!kevent) {
+		iprintk(INOTIFY_DEBUG_EVENTS, "failed to queue event %x for %p\n", mask, dev);
+	}
+
+	list_add_tail(&kevent->list, &dev->events);
+
+	iprintk(INOTIFY_DEBUG_EVENTS, "queued event %x for %p\n", mask, dev);
+}
+
+
+
+
+static void inotify_dev_event_dequeue (struct inotify_device *dev) {
+	struct inotify_kernel_event *kevent;
+
+	if (!inotify_dev_has_events (dev)) {
+		return;
+	}
+
+	kevent = inotify_dev_get_event(dev);
+
+	list_del(&kevent->list);
+	atomic_dec(&dev->event_count);
+
+	delete_kernel_event (kevent);
+
+	iprintk(INOTIFY_DEBUG_EVENTS, "dequeued event on %p\n", dev);
+}
+
+static int inotify_dev_get_wd (struct inotify_device *dev)
+{
+	int wd;
+
+	wd = -1;
+
+	if (!dev)
+		return -1;
+
+	if (dev->watcher_count == MAX_INOTIFY_DEV_WATCHERS) {
+		return -1;
+	}
+
+	dev->watcher_count++;
+
+	wd = find_first_zero_bit (dev->bitmask, __BITMASK_SIZE);
+
+	set_bit (wd, dev->bitmask);
+
+	return wd;
+}
+
+static int inotify_dev_put_wd (struct inotify_device *dev, int wd)
+{
+	if (!dev||wd < 0)
+		return -1;
+
+	dev->watcher_count--;
+
+	clear_bit (wd, dev->bitmask);
+
+	return 0;
+}
+
+
+static struct inotify_watcher *create_watcher (struct inotify_device *dev, int mask, struct inode *inode) {
+	struct inotify_watcher *watcher;
+
+	watcher = kmem_cache_alloc (watcher_cache, GFP_KERNEL);
+
+	if (!watcher) {
+		iprintk(INOTIFY_DEBUG_ALLOC, "failed to allocate watcher (%p,%d)\n", inode, mask);
+		return NULL;
+	}
+
+	watcher->wd = -1;
+	watcher->mask = mask;
+	watcher->inode = inode;
+	watcher->dev = dev;
+	INIT_LIST_HEAD(&watcher->d_list);
+	INIT_LIST_HEAD(&watcher->i_list);
+	INIT_LIST_HEAD(&watcher->u_list);
+
+	spin_lock(&dev->lock);
+		watcher->wd = inotify_dev_get_wd (dev);
+	spin_unlock(&dev->lock);
+
+	if (watcher->wd < 0) {
+		iprintk(INOTIFY_DEBUG_ERRORS, "Could not get wd for watcher %p\n", watcher);
+		iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
+		kmem_cache_free (watcher_cache, watcher);
+		watcher = NULL;
+		return watcher;
+	}
+
+	watcher_object_count++;
+	return watcher;
+}
+
+/* Must be called with dev->lock held */
+static void delete_watcher (struct inotify_device *dev, struct inotify_watcher *watcher) {
+	inotify_dev_put_wd (dev, watcher->wd);
+
+	iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
+
+	kmem_cache_free (watcher_cache, watcher);
+
+	watcher_object_count--;
+}
+
+
+static struct inotify_watcher *inode_find_dev (struct inode *inode, struct inotify_device *dev) {
+	struct inotify_watcher *watcher;
+
+	watcher = NULL;
+
+	list_for_each_entry (watcher, &inode->watchers, i_list) {
+		if (watcher->dev == dev) {
+			return watcher;
+		}
+
+	}
+	return NULL;
+}
+
+static struct inotify_watcher *dev_find_wd (struct inotify_device *dev, int wd)
+{
+	struct inotify_watcher *watcher;
+
+	list_for_each_entry (watcher, &dev->watchers, d_list) {
+		if (watcher->wd == wd) {
+			return watcher;
+		}
+	}
+	return NULL;
+}
+
+static int inotify_dev_is_watching_inode (struct inotify_device *dev, struct inode *inode) {
+	struct inotify_watcher *watcher;
+
+	list_for_each_entry (watcher, &dev->watchers, d_list) {
+		if (watcher->inode == inode) {
+			return 1;
+		}
+	}
+	
+	return 0;
+}
+
+static int inotify_dev_add_watcher (struct inotify_device *dev, struct inotify_watcher *watcher) {
+	int error;
+
+	error = 0;
+
+	if (!dev||!watcher) {
+		error = -EINVAL;
+		goto out;
+	}
+
+	if (dev_find_wd (dev, watcher->wd)) {
+		error = -EINVAL;
+		goto out;
+	}
+
+
+	if (dev->watcher_count == MAX_INOTIFY_DEV_WATCHERS) {
+		error = -ENOSPC;
+		goto out;
+	}
+
+	dev->watcher_count++;
+	list_add(&watcher->d_list, &dev->watchers);
+out:
+	return error;
+}
+
+static int inotify_dev_rm_watcher (struct inotify_device *dev, struct inotify_watcher *watcher) {
+	int error;
+
+	error = -EINVAL;
+
+	if (watcher) {
+		inotify_dev_queue_event (dev, watcher, IN_IGNORED, NULL);
+
+		list_del(&watcher->d_list);
+
+		dev->watcher_count--;
+
+		error = 0;
+	} 
+
+	return error;
+}
+
+void inode_update_watchers_mask (struct inode *inode)
+{
+	struct inotify_watcher *watcher;
+	unsigned long new_mask;
+
+	new_mask = 0;
+	list_for_each_entry(watcher, &inode->watchers, i_list) {
+		new_mask |= watcher->mask;
+	}
+	inode->watchers_mask = new_mask;
+}
+
+static int inode_add_watcher (struct inode *inode, struct inotify_watcher *watcher) {
+	if (!inode||!watcher||inode_find_dev (inode, watcher->dev))
+		return -EINVAL;
+
+	list_add(&watcher->i_list, &inode->watchers);
+	inode->watcher_count++;
+
+	inode_update_watchers_mask (inode);
+
+
+	return 0;
+}
+
+static int inode_rm_watcher (struct inode *inode, struct inotify_watcher *watcher) {
+	if (!inode||!watcher)
+		return -EINVAL;
+
+	list_del(&watcher->i_list);
+	inode->watcher_count--;
+
+	inode_update_watchers_mask (inode);
+
+	return 0;
+}
+
+/* Kernel API */
+
+void inotify_inode_queue_event (struct inode *inode, unsigned long mask, const char *filename) {
+	struct inotify_watcher *watcher;
+
+	spin_lock(&inode->i_lock);
+
+		list_for_each_entry (watcher, &inode->watchers, i_list) {
+			spin_lock(&watcher->dev->lock);
+				inotify_dev_queue_event (watcher->dev, watcher, mask, filename);
+			spin_unlock(&watcher->dev->lock);
+		}
+
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL_GPL(inotify_inode_queue_event);
+
+void inotify_dentry_parent_queue_event(struct dentry *dentry, unsigned long mask, const char *filename)
+{
+	struct dentry *parent;
+
+	spin_lock(&dentry->d_lock);
+	dget (dentry->d_parent);
+	parent = dentry->d_parent;
+	inotify_inode_queue_event(parent->d_inode, mask, filename);
+	dput (parent);
+	spin_unlock(&dentry->d_lock);
+}
+EXPORT_SYMBOL_GPL(inotify_dentry_parent_queue_event);
+
+static void ignore_helper (struct inotify_watcher *watcher, int event) {
+	struct inotify_device *dev;
+	struct inode *inode;
+
+	spin_lock(&watcher->dev->lock);
+	spin_lock(&watcher->inode->i_lock);
+
+	inode = watcher->inode;
+	dev = watcher->dev;
+
+	if (event)
+		inotify_dev_queue_event (dev, watcher, event, NULL);
+
+	inode_rm_watcher (inode, watcher);
+	inotify_dev_rm_watcher (watcher->dev, watcher);
+	list_del(&watcher->u_list);
+
+
+	spin_unlock(&inode->i_lock);
+
+	delete_watcher(dev, watcher);
+
+	spin_unlock(&dev->lock);
+
+	unref_inode (inode);
+}
+
+static void process_umount_list (struct list_head *umount) {
+	struct inotify_watcher *watcher, *next;
+
+	list_for_each_entry_safe (watcher, next, umount, u_list) {
+		ignore_helper (watcher, IN_UNMOUNT);
+	}
+}
+
+static void build_umount_list (struct list_head *head, struct super_block *sb, struct list_head *umount) {
+	struct inode *	inode;
+
+	list_for_each_entry (inode, head, i_list) {
+		struct inotify_watcher *watcher;
+
+		if (inode->i_sb != sb)
+			continue;
+
+		spin_lock(&inode->i_lock);
+
+		list_for_each_entry (watcher, &inode->watchers, i_list) {
+			list_add (&watcher->u_list, umount);
+		}
+
+		spin_unlock(&inode->i_lock);
+	}
+}
+
+void inotify_super_block_umount (struct super_block *sb)
+{
+	struct list_head umount;
+
+	INIT_LIST_HEAD(&umount);
+
+	spin_lock(&inode_lock);
+		build_umount_list (&inode_in_use, sb, &umount);
+	spin_unlock(&inode_lock);
+
+	process_umount_list (&umount);
+}
+EXPORT_SYMBOL_GPL(inotify_super_block_umount);
+
+/* The driver interface is implemented below */
+
+static unsigned int inotify_poll(struct file *file, poll_table *wait) {
+        struct inotify_device *dev;
+
+        dev = file->private_data;
+
+
+        poll_wait(file, &dev->wait, wait);
+
+        if (inotify_dev_has_events(dev)) {
+                return POLLIN | POLLRDNORM;
+	}
+
+        return 0;
+}
+
+static ssize_t inotify_read(struct file *file, __user char *buf,
+			   size_t count, loff_t *pos) {
+	size_t out;
+	struct inotify_kernel_event *kevent;
+	struct inotify_event event;
+	struct inotify_device *dev;
+	int put_user_result;
+	char *obuf;
+	int err;
+	DECLARE_WAITQUEUE(wait, current);
+
+	out = 0;
+	err = 0;
+
+	obuf = buf;
+
+	dev = file->private_data;
+
+	/* We only hand out full inotify events */
+	if (count < sizeof(struct inotify_event)) {
+		out = -EINVAL;
+		goto out;
+	}
+
+	if (!inotify_dev_has_events(dev)) {
+		if (file->f_flags & O_NONBLOCK) {
+			out = -EAGAIN;
+			goto out;
+		}
+	}
+
+	spin_lock_irq(&dev->lock);
+
+	add_wait_queue(&dev->wait, &wait);
+repeat:
+	if (signal_pending(current)) {
+		spin_unlock_irq (&dev->lock);
+		out = -ERESTARTSYS;
+		set_current_state (TASK_RUNNING);
+		remove_wait_queue(&dev->wait, &wait);
+		goto out;
+	}
+	set_current_state(TASK_INTERRUPTIBLE);
+	if (!inotify_dev_has_events (dev)) {
+		spin_unlock_irq (&dev->lock);
+		schedule ();
+		spin_lock_irq (&dev->lock);
+		goto repeat;
+	}
+
+	set_current_state (TASK_RUNNING);
+	remove_wait_queue (&dev->wait, &wait);
+
+	err = !access_ok(VERIFY_WRITE, (void *)buf, sizeof(event));
+
+	if (err) {
+		out = -EFAULT;
+		goto out;
+	}
+
+	/* Grab the event */
+	kevent = inotify_dev_get_event (dev);
+	event = kevent->event;
+	inotify_dev_event_dequeue (dev);
+
+	spin_unlock_irq(&dev->lock);
+
+	err = copy_to_user(buf, &event, sizeof(event));
+
+	buf += sizeof(event);
+	out = buf - obuf;
+
+out:
+	return out;
+}
+
+static void inotify_dev_timer (unsigned long data) {
+	struct inotify_device *dev = (struct inotify_device *)data;
+
+	if (!data) return;
+
+	// reset the timer
+	mod_timer(&dev->timer, INOTIFY_DEV_TIMER_TIME);
+
+	// wake up anything waiting on poll
+	if (inotify_dev_has_events (dev)) {
+		wake_up_interruptible(&dev->wait);
+	}
+}
+
+static int inotify_open(struct inode *inode, struct file *file) {
+	struct inotify_device *dev;
+
+	if (atomic_read(&watcher_count) == MAX_INOTIFY_DEVS)
+		return -ENODEV;
+
+	atomic_inc(&watcher_count);
+
+	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
+	dev->bitmask = kmalloc(__BITMASK_SIZE, GFP_KERNEL);
+	memset(dev->bitmask, 0, __BITMASK_SIZE);
+
+	INIT_LIST_HEAD(&dev->events);
+	INIT_LIST_HEAD(&dev->watchers);
+	init_timer(&dev->timer);
+	init_waitqueue_head(&dev->wait);
+
+	atomic_set(&dev->event_count, 0);
+	dev->watcher_count = 0;
+	dev->lock = SPIN_LOCK_UNLOCKED;
+	dev->read_state = 0;
+
+	file->private_data = dev;
+
+	dev->timer.data = dev;
+	dev->timer.function = inotify_dev_timer;
+	dev->timer.expires = INOTIFY_DEV_TIMER_TIME;
+
+	add_timer(&dev->timer);
+
+	printk(KERN_ALERT "inotify device opened\n");
+
+	return 0;
+}
+
+static void inotify_release_all_watchers (struct inotify_device *dev)
+{
+	struct inotify_watcher *watcher,*next;
+
+	list_for_each_entry_safe(watcher, next, &dev->watchers, d_list) {
+		ignore_helper (watcher, 0);
+	}
+}
+
+static void inotify_release_all_events (struct inotify_device *dev)
+{
+	spin_lock(&dev->lock);
+	while (inotify_dev_has_events(dev)) {
+		inotify_dev_event_dequeue(dev);
+	}
+	spin_unlock(&dev->lock);
+}
+
+
+static int inotify_release(struct inode *inode, struct file *file)
+{
+	if (file->private_data) {
+		struct inotify_device *dev;
+
+		dev = (struct inotify_device *)file->private_data;
+
+		del_timer(&dev->timer);
+
+		inotify_release_all_watchers(dev);
+
+		inotify_release_all_events(dev);
+
+		kfree (dev->bitmask);
+		kfree (dev);
+
+	}
+
+	printk(KERN_ALERT "inotify device released\n");
+
+	atomic_dec(&watcher_count);
+	return 0;
+}
+
+static int inotify_watch (struct inotify_device *dev, struct inotify_watch_request *request)
+{
+	int err;
+	struct inode *inode;
+	struct inotify_watcher *watcher;
+	err = 0;
+
+	err = find_inode (request->dirname, &inode);
+
+	if (err)
+		goto exit;
+
+	if (!S_ISDIR(inode->i_mode)) {
+		iprintk(INOTIFY_DEBUG_ERRORS, "watching file\n");
+	}
+
+	spin_lock(&dev->lock);
+	spin_lock(&inode->i_lock);
+
+	/* This handles the case of re-adding a directory we are already
+	 * watching, we just update the mask and return 0
+	 */
+	if (inotify_dev_is_watching_inode (dev, inode)) {
+		iprintk(INOTIFY_DEBUG_ERRORS, "adjusting event mask for inode %p\n", inode);
+		struct inotify_watcher *owatcher; // the old watcher
+
+		owatcher = inode_find_dev (inode, dev);
+
+		owatcher->mask = request->mask;
+
+		inode_update_watchers_mask (inode);
+
+		spin_unlock (&inode->i_lock);
+		spin_unlock (&dev->lock);
+
+		unref_inode (inode);
+
+		return 0;
+	}
+
+	spin_unlock (&inode->i_lock);
+	spin_unlock (&dev->lock);
+
+
+	watcher = create_watcher (dev, request->mask, inode);
+
+	if (!watcher) {
+		unref_inode (inode);
+		return -ENOSPC;
+	}
+
+	spin_lock(&dev->lock);
+	spin_lock(&inode->i_lock);
+
+	/* We can't add anymore watchers to this device */
+	if (inotify_dev_add_watcher (dev, watcher) == -ENOSPC) {
+		iprintk(INOTIFY_DEBUG_ERRORS, "can't add watcher dev is full\n");
+		spin_unlock (&inode->i_lock);
+		delete_watcher (dev, watcher);
+		spin_unlock (&dev->lock);
+
+		unref_inode (inode);
+		return -ENOSPC;
+	}
+
+	inode_add_watcher (inode, watcher);
+
+	/* We keep a reference on the inode */
+	if (!err) {
+		err = watcher->wd;
+	}
+
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&dev->lock);
+exit:
+	return err;
+}
+
+static int inotify_ignore(struct inotify_device *dev, int wd)
+{
+	struct inotify_watcher *watcher;
+
+	watcher = dev_find_wd (dev, wd);
+
+	if (!watcher) {
+		return -EINVAL;
+	}
+
+	ignore_helper (watcher, 0);
+
+	return 0;
+}
+
+static void inotify_print_stats (struct inotify_device *dev)
+{
+	printk (KERN_ALERT "watcher_count = %d\n", atomic_read(&watcher_count));
+	printk (KERN_ALERT "event_object_count = %d\n", event_object_count);
+	printk (KERN_ALERT "watcher_object_count = %d\n", watcher_object_count);
+	printk (KERN_ALERT "inode_ref_count = %d\n", inode_ref_count);
+
+	spin_lock(&dev->lock);
+
+	printk (KERN_ALERT "inotify device: %p\n", dev);
+	printk (KERN_ALERT "inotify event_count: %d\n", atomic_read(&dev->event_count));
+	printk (KERN_ALERT "inotify watch_count: %d\n", dev->watcher_count);
+
+	spin_unlock(&dev->lock);
+}
+
+static int inotify_ioctl(struct inode *ip, struct file *fp,
+			 unsigned int cmd, unsigned long arg) {
+	int err;
+	struct inotify_device *dev;
+	struct inotify_watch_request request;
+	int wid;
+
+	dev = fp->private_data;
+
+	err = 0;
+
+	if (_IOC_TYPE(cmd) != INOTIFY_IOCTL_MAGIC) return -EINVAL;
+	if (_IOC_NR(cmd) > INOTIFY_IOCTL_MAXNR) return -EINVAL;
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		err = !access_ok(VERIFY_READ, (void *)arg, _IOC_SIZE(cmd));
+
+	if (err) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	if (_IOC_DIR(cmd) & _IOC_WRITE)
+		err = !access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd));
+
+	if (err) {
+		err = -EFAULT;
+		goto out;
+	}
+
+
+	err = -EINVAL;
+
+	switch (cmd) {
+		case INOTIFY_WATCH:
+			iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_WATCH ioctl\n");
+			if (copy_from_user(&request, (void *)arg, sizeof(struct inotify_watch_request))) {
+				err = -EFAULT;
+				goto out;
+			}
+
+			err = inotify_watch(dev, &request);
+		break;
+		case INOTIFY_IGNORE:
+			iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_IGNORE ioctl\n");
+			if (copy_from_user(&wid, (void *)arg, sizeof(int))) {
+				err = -EFAULT;
+				goto out;
+			}
+
+			err = inotify_ignore(dev, wid);
+		break;
+		case INOTIFY_STATS:
+			iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_STATS ioctl\n");
+			inotify_print_stats (dev);
+			err = 0;
+		break;
+		case INOTIFY_SETDEBUG:
+			iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_SETDEBUG ioctl\n");
+			if (copy_from_user(&inotify_debug_flags, (void *)arg, sizeof(int))) {
+				err = -EFAULT;
+				goto out;
+			}
+		break;
+	}
+
+out:
+	return err;
+}
+
+static struct file_operations inotify_fops = {
+	.owner		= THIS_MODULE,
+	.poll		= inotify_poll,
+	.read		= inotify_read,
+	.open		= inotify_open,
+	.release	= inotify_release,
+	.ioctl		= inotify_ioctl,
+};
+
+struct miscdevice inotify_device = {
+	.minor  = MISC_DYNAMIC_MINOR, // automatic
+	.name	= "inotify",
+	.fops	= &inotify_fops,
+};
+
+
+static int __init inotify_init (void)
+{
+	int ret;
+
+	ret = misc_register(&inotify_device);
+
+	if (ret) {
+		goto out;
+	}
+
+	inotify_debug_flags = INOTIFY_DEBUG_NONE;
+
+	watcher_cache = kmem_cache_create ("watcher_cache", 
+			sizeof(struct inotify_watcher), 0, SLAB_PANIC, NULL, NULL);
+
+	if (!watcher_cache) {
+		misc_deregister (&inotify_device);
+	}
+	kevent_cache = kmem_cache_create ("kevent_cache", 
+			sizeof(struct inotify_kernel_event), 0, SLAB_PANIC, NULL, NULL);
+
+	if (!kevent_cache) {
+		misc_deregister (&inotify_device);
+		kmem_cache_destroy (watcher_cache);
+	}
+
+	printk(KERN_ALERT "inotify 0.8 minor=%d\n", inotify_device.minor);
+out:
+	return ret;
+}
+
+static void inotify_exit (void)
+{
+	kmem_cache_destroy (kevent_cache);
+	kmem_cache_destroy (watcher_cache);
+	misc_deregister (&inotify_device);
+	printk(KERN_ALERT "inotify shutdown ec=%d wc=%d ic=%d\n", event_object_count, watcher_object_count, inode_ref_count);
+}
+
+MODULE_AUTHOR("John McCutchan <ttb@tentacle.dhs.org>");
+MODULE_DESCRIPTION("Inode event driver");
+MODULE_LICENSE("GPL");
+
+module_init (inotify_init);
+module_exit (inotify_exit);
diff -urN clean/linux-2.6.7/drivers/char/Makefile linux-2.6.7/drivers/char/Makefile
--- clean/linux-2.6.7/drivers/char/Makefile	2004-06-16 01:20:04.000000000 -0400
+++ linux-2.6.7/drivers/char/Makefile	2004-07-07 18:44:31.000000000 -0400
@@ -7,7 +7,7 @@
 #
 FONTMAPFILE = cp437.uni
 
-obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o
+obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o inotify.o
 
 obj-$(CONFIG_VT)		+= vt_ioctl.o vc_screen.o consolemap.o \
 				   consolemap_deftbl.o selection.o keyboard.o
diff -urN clean/linux-2.6.7/fs/attr.c linux-2.6.7/fs/attr.c
--- clean/linux-2.6.7/fs/attr.c	2004-06-16 01:18:58.000000000 -0400
+++ linux-2.6.7/fs/attr.c	2004-07-27 18:04:40.000000000 -0400
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
@@ -184,8 +185,11 @@
 	}
 	if (!error) {
 		unsigned long dn_mask = setattr_mask(ia_valid);
-		if (dn_mask)
+		if (dn_mask) {
 			dnotify_parent(dentry, dn_mask);
+			inotify_inode_queue_event (dentry->d_inode, dn_mask, NULL);
+			inotify_dentry_parent_queue_event (dentry, dn_mask, dentry->d_name.name);
+		}
 	}
 	return error;
 }
diff -urN clean/linux-2.6.7/fs/inode.c linux-2.6.7/fs/inode.c
--- clean/linux-2.6.7/fs/inode.c	2004-06-16 01:20:26.000000000 -0400
+++ linux-2.6.7/fs/inode.c	2004-07-10 17:17:59.000000000 -0400
@@ -113,6 +113,7 @@
 	if (inode) {
 		struct address_space * const mapping = &inode->i_data;
 
+		INIT_LIST_HEAD (&inode->watchers);
 		inode->i_sb = sb;
 		inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_flags = 0;
diff -urN clean/linux-2.6.7/fs/namei.c linux-2.6.7/fs/namei.c
--- clean/linux-2.6.7/fs/namei.c	2004-06-16 01:19:12.000000000 -0400
+++ linux-2.6.7/fs/namei.c	2004-07-27 17:48:02.000000000 -0400
@@ -22,6 +22,7 @@
 #include <linux/quotaops.h>
 #include <linux/pagemap.h>
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
 #include <linux/security.h>
@@ -1158,6 +1159,7 @@
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE, dentry->d_name.name);
 		security_inode_post_create(dir, dentry, mode);
 	}
 	return error;
@@ -1459,6 +1461,7 @@
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE, dentry->d_name.name);
 		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
 	return error;
@@ -1532,6 +1535,7 @@
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE, dentry->d_name.name);
 		security_inode_post_mkdir(dir,dentry, mode);
 	}
 	return error;
@@ -1627,6 +1631,7 @@
 	up(&dentry->d_inode->i_sem);
 	if (!error) {
 		inode_dir_notify(dir, DN_DELETE);
+		inotify_inode_queue_event(dir, IN_DELETE, dentry->d_name.name);
 		d_delete(dentry);
 	}
 	dput(dentry);
@@ -1699,8 +1704,9 @@
 
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
 	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
-		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);
+		inotify_inode_queue_event(dir, IN_DELETE, dentry->d_name.name);
+		d_delete(dentry);
 	}
 	return error;
 }
@@ -1777,6 +1783,7 @@
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE, dentry->d_name.name);
 		security_inode_post_symlink(dir, dentry, oldname);
 	}
 	return error;
@@ -1850,6 +1857,7 @@
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE, new_dentry->d_name.name);
 		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
 	return error;
@@ -2039,12 +2047,15 @@
 	else
 		error = vfs_rename_other(old_dir,old_dentry,new_dir,new_dentry);
 	if (!error) {
-		if (old_dir == new_dir)
+		if (old_dir == new_dir) {
 			inode_dir_notify(old_dir, DN_RENAME);
-		else {
+		} else {
 			inode_dir_notify(old_dir, DN_DELETE);
 			inode_dir_notify(new_dir, DN_CREATE);
 		}
+
+		inotify_inode_queue_event(old_dir, IN_DELETE, old_dentry->d_name.name);
+		inotify_inode_queue_event(new_dir, IN_CREATE, new_dentry->d_name.name);
 	}
 	return error;
 }
diff -urN clean/linux-2.6.7/fs/open.c linux-2.6.7/fs/open.c
--- clean/linux-2.6.7/fs/open.c	2004-06-16 01:18:56.000000000 -0400
+++ linux-2.6.7/fs/open.c	2004-07-27 18:05:55.000000000 -0400
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
@@ -955,6 +956,8 @@
 			error = PTR_ERR(f);
 			if (IS_ERR(f))
 				goto out_error;
+			inotify_inode_queue_event (f->f_dentry->d_inode, IN_OPEN, NULL);
+			inotify_dentry_parent_queue_event (f->f_dentry, IN_OPEN, f->f_dentry->d_name.name);
 			fd_install(fd, f);
 		}
 out:
@@ -1034,6 +1037,8 @@
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
+	inotify_dentry_parent_queue_event (filp->f_dentry, IN_CLOSE, filp->f_dentry->d_name.name);
+	inotify_inode_queue_event (filp->f_dentry->d_inode, IN_CLOSE, NULL);
 	return filp_close(filp, files);
 
 out_unlock:
diff -urN clean/linux-2.6.7/fs/read_write.c linux-2.6.7/fs/read_write.c
--- clean/linux-2.6.7/fs/read_write.c	2004-06-16 01:19:37.000000000 -0400
+++ linux-2.6.7/fs/read_write.c	2004-07-27 18:04:05.000000000 -0400
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 #include <linux/security.h>
 #include <linux/module.h>
 
@@ -215,8 +216,11 @@
 				ret = file->f_op->read(file, buf, count, pos);
 			else
 				ret = do_sync_read(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_ACCESS);
+				inotify_dentry_parent_queue_event(file->f_dentry, IN_ACCESS, file->f_dentry->d_name.name);
+				inotify_inode_queue_event (file->f_dentry->d_inode, IN_ACCESS, NULL);
+			}
 		}
 	}
 
@@ -259,8 +263,11 @@
 				ret = file->f_op->write(file, buf, count, pos);
 			else
 				ret = do_sync_write(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_MODIFY);
+				inotify_dentry_parent_queue_event(file->f_dentry, IN_MODIFY, file->f_dentry->d_name.name);
+				inotify_inode_queue_event (file->f_dentry->d_inode, IN_MODIFY, NULL);
+			}
 		}
 	}
 
@@ -474,9 +481,13 @@
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0)
+	if ((ret + (type == READ)) > 0) {
 		dnotify_parent(file->f_dentry,
 				(type == READ) ? DN_ACCESS : DN_MODIFY);
+		inotify_dentry_parent_queue_event(file->f_dentry, 
+				(type == READ) ? IN_ACCESS : IN_MODIFY, file->f_dentry->d_name.name);
+		inotify_inode_queue_event (file->f_dentry->d_inode, (type == READ) ? IN_ACCESS : IN_MODIFY, NULL);
+	}
 	return ret;
 }
 
diff -urN clean/linux-2.6.7/fs/super.c linux-2.6.7/fs/super.c
--- clean/linux-2.6.7/fs/super.c	2004-06-16 01:19:22.000000000 -0400
+++ linux-2.6.7/fs/super.c	2004-07-06 23:02:43.000000000 -0400
@@ -36,6 +36,7 @@
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
 #include <asm/uaccess.h>
+#include <linux/inotify.h>
 
 
 void get_filesystem(struct file_system_type *fs);
@@ -204,6 +205,7 @@
 
 	if (root) {
 		sb->s_root = NULL;
+		inotify_super_block_umount (sb);
 		shrink_dcache_parent(root);
 		shrink_dcache_anon(&sb->s_anon);
 		dput(root);
diff -urN clean/linux-2.6.7/include/linux/fs.h linux-2.6.7/include/linux/fs.h
--- clean/linux-2.6.7/include/linux/fs.h	2004-06-16 01:19:02.000000000 -0400
+++ linux-2.6.7/include/linux/fs.h	2004-07-10 00:32:53.000000000 -0400
@@ -450,6 +450,10 @@
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 
+	struct list_head	watchers;
+	unsigned long		watchers_mask;
+	int			watcher_count;
+
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
diff -urN clean/linux-2.6.7/include/linux/inotify.h linux-2.6.7/include/linux/inotify.h
--- clean/linux-2.6.7/include/linux/inotify.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.7/include/linux/inotify.h	2004-07-27 18:57:52.000000000 -0400
@@ -0,0 +1,74 @@
+/*
+ * Inode based directory notification for Linux
+ *
+ * Copyright (C) 2004 John McCutchan
+ *
+ * Signed-off-by: John McCutchan ttb@tentacle.dhs.org
+ */
+
+#ifndef _LINUX_INOTIFY_H
+#define _LINUX_INOTIFY_H
+
+struct inode;
+struct dentry;
+struct super_block;
+
+struct inotify_event {
+	int wd;
+	int mask;
+	char filename[256];
+	/* When you are watching a directory you will get the filenames
+	 * for events like IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, etc.. 
+	 */
+};
+/* When reading from the device you must provide a buffer 
+ * that is a multiple of the sizeof(inotify_event)
+ */
+
+#define IN_ACCESS	0x00000001	/* File was accessed */
+#define IN_MODIFY	0x00000002	/* File was modified */
+#define IN_CREATE	0x00000004	/* File was created */
+#define IN_DELETE	0x00000008	/* File was deleted */
+#define IN_RENAME	0x00000010	/* File was renamed */
+#define IN_ATTRIB	0x00000020	/* File changed attributes */
+#define IN_MOVE		0x00000040	/* File was moved */
+#define IN_UNMOUNT	0x00000080	/* Device file was on, was unmounted */
+#define IN_CLOSE	0x00000100	/* File was closed */
+#define IN_OPEN		0x00000200	/* File was opened */
+#define IN_IGNORED	0x00000400	/* File was ignored */
+#define IN_ALL_EVENTS	0xffffffff	/* All the events */
+
+/* ioctl */
+
+/* Fill this and pass it to INOTIFY_WATCH ioctl */
+struct inotify_watch_request {
+	char *dirname; // directory name
+	unsigned long mask; // event mask
+};
+
+#define INOTIFY_IOCTL_MAGIC 'Q'
+#define INOTIFY_IOCTL_MAXNR 4
+
+#define INOTIFY_WATCH  		_IOR(INOTIFY_IOCTL_MAGIC, 1, struct inotify_watch_request)
+#define INOTIFY_IGNORE 		_IOR(INOTIFY_IOCTL_MAGIC, 2, int)
+#define INOTIFY_STATS		_IOR(INOTIFY_IOCTL_MAGIC, 3, int)
+#define INOTIFY_SETDEBUG	_IOR(INOTIFY_IOCTL_MAGIC, 4, int)
+
+#define INOTIFY_DEBUG_NONE   0x00000000
+#define INOTIFY_DEBUG_ALLOC  0x00000001
+#define INOTIFY_DEBUG_EVENTS 0x00000002
+#define INOTIFY_DEBUG_INODE  0x00000004
+#define INOTIFY_DEBUG_ERRORS 0x00000008
+#define INOTIFY_DEBUG_FILEN  0x00000010
+#define INOTIFY_DEBUG_ALL    0xffffffff
+
+/* Kernel API */
+/* Adds events to all watchers on inode that are interested in mask */
+void inotify_inode_queue_event (struct inode *inode, unsigned long mask, const char *filename);
+/* Same as above but uses dentry's inode */
+void inotify_dentry_parent_queue_event (struct dentry *dentry, unsigned long mask, const char *filename);
+/* This will remove all watchers from all inodes on the superblock */
+void inotify_super_block_umount (struct super_block *sb);
+
+#endif
+

--FCuugMFkClbJLl1L--
