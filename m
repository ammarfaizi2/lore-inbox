Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVATV6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVATV6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVATV6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:58:11 -0500
Received: from peabody.ximian.com ([130.57.169.10]:38865 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262054AbVATVvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:51:08 -0500
Subject: [patch] inotify for 2.6.11-rc1-mm2
From: Robert Love <rml@novell.com>
To: akpm@osdl.org
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 20 Jan 2005 16:46:22 -0500
Message-Id: <1106257582.7087.7.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Andrew.

Below is an updated inotify patch (e.g. drop-in replacement for the
current patch) for 2.6.11-rc1-mm2.

Primary changes are bugfixes, cleanups, and the much-demanded
dynamic-length filename.  Also, this fixes the reported regression in
directory operation performance.  More cleanups, particularly with
locking, are still on my TODO.

Best,

	Robert Love


inotify is intended to correct the deficiencies of dnotify, particularly
its inability to scale and its terrible user interface:

        * dnotify requires the opening of one fd per each directory
          that you intend to watch. This quickly results in too many
          open files and pins removable media, preventing unmount.
        * dnotify is directory-based. You only learn about changes to
          directories. Sure, a change to a file in a directory affects
          the directory, but you are then forced to keep a cache of
          stat structures.
        * dnotify's interface to user-space is awful.  Signals?

inotify provides a more usable, simple, powerful solution to file change
notification:

        * inotify's interface is a device node, not SIGIO.  You open a 
          single fd to the device node, which is select()-able.
        * inotify has an event that says "the filesystem that the item
          you were watching is on was unmounted."
        * inotify can watch directories or files.

Inotify is currently used by Beagle (a desktop search infrastructure)
and Gamin (a FAM replacement).

Signed-off-by: Robert Love <rml@novell.com>


 drivers/char/Kconfig       |   13 
 drivers/char/Makefile      |    2 
 drivers/char/inotify.c     | 1074 +++++++++++++++++++++++++++++++++++++++++++++
 fs/attr.c                  |   73 ++-
 fs/file_table.c            |    7 
 fs/inode.c                 |    3 
 fs/namei.c                 |   36 +
 fs/open.c                  |    5 
 fs/read_write.c            |   29 +
 fs/super.c                 |    2 
 include/linux/fs.h         |    7 
 include/linux/inotify.h    |  150 ++++++
 include/linux/miscdevice.h |    1 
 include/linux/sched.h      |    2 
 kernel/user.c              |    2 
 15 files changed, 1379 insertions(+), 27 deletions(-)

diff -urN linux-2.6.11-rc1-mm2/drivers/char/inotify.c linux-inotify/drivers/char/inotify.c
--- linux-2.6.11-rc1-mm2/drivers/char/inotify.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-inotify/drivers/char/inotify.c	2005-01-20 16:29:10.058805240 -0500
@@ -0,0 +1,1074 @@
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
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/poll.h>
+#include <linux/device.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/writeback.h>
+#include <linux/inotify.h>
+
+#include <asm/ioctls.h>
+
+static atomic_t inotify_cookie;
+static kmem_cache_t *watch_cachep;
+static kmem_cache_t *event_cachep;
+static kmem_cache_t *inode_data_cachep;
+
+static int sysfs_attrib_max_user_devices;
+static int sysfs_attrib_max_user_watches;
+static unsigned int sysfs_attrib_max_queued_events;
+
+/*
+ * struct inotify_device - represents an open instance of an inotify device
+ *
+ * For each inotify device, we need to keep track of the events queued on it,
+ * a list of the inodes that we are watching, and so on.
+ *
+ * This structure is protected by 'lock'.  Lock ordering:
+ *
+ * dev->lock (protects dev)
+ *	inode_lock (used to safely walk inode_in_use list)
+ *		inode->i_lock (only needed for getting ref on inode_data)
+ */
+struct inotify_device {
+	wait_queue_head_t 	wait;
+	struct idr		idr;
+	struct list_head 	events;
+	struct list_head 	watches;
+	spinlock_t		lock;
+	unsigned int		queue_size;
+	unsigned int		event_count;
+	unsigned int		max_events;
+	struct user_struct	*user;
+};
+
+struct inotify_watch {
+	s32 			wd;	/* watch descriptor */
+	u32			mask;
+	struct inode		*inode;
+	struct inotify_device	*dev;
+	struct list_head	d_list;	/* device list */
+	struct list_head	i_list; /* inode list */
+};
+
+/*
+ * A list of these is attached to each instance of the driver.  In read(), this
+ * this list is walked and all events that can fit in the buffer are returned.
+ */
+struct inotify_kernel_event {
+	struct inotify_event	event;
+	struct list_head        list;
+	char			*filename;
+};
+
+static ssize_t show_max_queued_events(struct class_device *class, char *buf)
+{
+	return sprintf(buf, "%d\n", sysfs_attrib_max_queued_events);
+}
+
+static ssize_t store_max_queued_events(struct class_device *class,
+				       const char *buf, size_t count)
+{
+	unsigned int max;
+
+	if (sscanf(buf, "%u", &max) > 0 && max > 0) {
+		sysfs_attrib_max_queued_events = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
+}
+
+static ssize_t show_max_user_devices(struct class_device *class, char *buf)
+{
+	return sprintf(buf, "%d\n", sysfs_attrib_max_user_devices);
+}
+
+static ssize_t store_max_user_devices(struct class_device *class,
+				      const char *buf, size_t count)
+{
+	int max;
+
+	if (sscanf(buf, "%d", &max) > 0 && max > 0) {
+		sysfs_attrib_max_user_devices = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
+}
+
+static ssize_t show_max_user_watches(struct class_device *class, char *buf)
+{
+	return sprintf(buf, "%d\n", sysfs_attrib_max_user_watches);
+}
+
+static ssize_t store_max_user_watches(struct class_device *class,
+				      const char *buf, size_t count)
+{
+	int max;
+
+	if (sscanf(buf, "%d", &max) > 0 && max > 0) {
+		sysfs_attrib_max_user_watches = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
+}
+
+static CLASS_DEVICE_ATTR(max_queued_events, S_IRUGO | S_IWUSR,
+	show_max_queued_events, store_max_queued_events);
+static CLASS_DEVICE_ATTR(max_user_devices, S_IRUGO | S_IWUSR,
+	show_max_user_devices, store_max_user_devices);
+static CLASS_DEVICE_ATTR(max_user_watches, S_IRUGO | S_IWUSR,
+	show_max_user_watches, store_max_user_watches);
+
+static inline void __get_inode_data(struct inotify_inode_data *data)
+{
+	atomic_inc(&data->count);
+}
+
+/*
+ * get_inode_data - pin an inotify_inode_data structure.  Returns the structure
+ * if successful and NULL on failure, which can only occur if inotify_data is
+ * not yet allocated.  The inode must be pinned prior to invocation.
+ */
+static inline struct inotify_inode_data * get_inode_data(struct inode *inode)
+{
+	struct inotify_inode_data *data;
+
+	spin_lock(&inode->i_lock);
+	data = inode->inotify_data;
+	if (data)
+		__get_inode_data(data);
+	spin_unlock(&inode->i_lock);
+
+	return data;
+}
+
+/*
+ * put_inode_data - drop our reference on an inotify_inode_data and the
+ * inode structure in which it lives.  If the reference count on inotify_data
+ * reaches zero, free it.
+ */
+static inline void put_inode_data(struct inode *inode)
+{
+	//spin_lock(&inode->i_lock);
+	if (atomic_dec_and_test(&inode->inotify_data->count)) {
+		kmem_cache_free(inode_data_cachep, inode->inotify_data);
+		inode->inotify_data = NULL;
+	}
+	//spin_unlock(&inode->i_lock);
+}
+
+/*
+ * find_inode - resolve a user-given path to a specific inode and iget() it
+ */
+static struct inode * find_inode(const char __user *dirname)
+{
+	struct inode *inode;
+	struct nameidata nd;
+	int error;
+
+	error = __user_walk(dirname, LOOKUP_FOLLOW, &nd);
+	if (error)
+		return ERR_PTR(error);
+
+	inode = nd.dentry->d_inode;
+
+	/* you can only watch an inode if you have read permissions on it */
+	error = permission(inode, MAY_READ, NULL);
+	if (error) {
+		inode = ERR_PTR(error);
+		goto release_and_out;
+	}
+
+	spin_lock(&inode_lock);
+	__iget(inode);
+	spin_unlock(&inode_lock);
+release_and_out:
+	path_release(&nd);
+	return inode;
+}
+
+struct inotify_kernel_event * kernel_event(s32 wd, u32 mask, u32 cookie,
+					   const char *filename)
+{
+	struct inotify_kernel_event *kevent;
+
+	kevent = kmem_cache_alloc(event_cachep, GFP_ATOMIC);
+	if (!kevent)
+		return NULL;
+
+	/* we hand this out to user-space, so zero it just in case */
+	memset(&kevent->event, 0, sizeof(struct inotify_event));
+
+	kevent->event.wd = wd;
+	kevent->event.mask = mask;
+	kevent->event.cookie = cookie;
+	INIT_LIST_HEAD(&kevent->list);
+
+	if (filename) {
+		size_t len, rem, event_size = sizeof(struct inotify_event);
+
+		/*
+		 * We need to pad the filename so as to properly align an
+		 * array of inotify_event structures.  Because the structure is
+		 * small and the common case is a small filename, we just round
+		 * up to the next multiple of the structure's sizeof.  This is
+		 * simple and safe for all architectures.
+		 */
+		len = strlen(filename) + 1;
+		rem = event_size - len;
+		if (len > event_size) {
+			rem = event_size - (len % event_size);
+			if (len % event_size == 0)
+				rem = 0;
+		}
+		len += rem;
+
+		kevent->filename = kmalloc(len, GFP_ATOMIC);
+		if (!kevent->filename) {
+			kmem_cache_free(event_cachep, kevent);
+			return NULL;
+		}
+		memset(kevent->filename, 0, len);
+		strncpy(kevent->filename, filename, strlen(filename));
+		kevent->event.len = len;
+	} else {
+		kevent->event.len = 0;
+		kevent->filename = NULL;
+	}
+
+	return kevent;
+}
+
+#define list_to_inotify_kernel_event(pos)	\
+		list_entry((pos), struct inotify_kernel_event, list)
+
+#define inotify_dev_get_event(dev)		\
+		(list_to_inotify_kernel_event(dev->events.next))
+
+/* Does this events mask get sent to the watch ? */
+#define event_and(event_mask,watches_mask) 	((event_mask == IN_UNMOUNT) || \
+						(event_mask == IN_IGNORED) || \
+						(event_mask & watches_mask))
+
+/*
+ * inotify_dev_queue_event - add a new event to the given device
+ *
+ * Caller must hold dev->lock.
+ */
+static void inotify_dev_queue_event(struct inotify_device *dev,
+				    struct inotify_watch *watch, u32 mask,
+				    u32 cookie, const char *filename)
+{
+	struct inotify_kernel_event *kevent, *last;
+
+	/* drop this event if it is a dupe of the previous */
+	last = inotify_dev_get_event(dev);
+	if (dev->event_count && last->event.mask == mask &&
+			last->event.wd == watch->wd) {
+		const char *lastname = last->filename;
+
+		if (!filename && !lastname)
+			return;
+		if (filename && lastname && !strcmp(lastname, filename))
+			return;
+	}
+
+	/*
+	 * the queue has already overflowed and we have already sent the
+	 * Q_OVERFLOW event
+	 */
+	if (dev->event_count > dev->max_events)
+		return;
+
+	/* the queue has just overflowed and we need to notify user space */
+	if (dev->event_count == dev->max_events) {
+		kevent = kernel_event(-1, IN_Q_OVERFLOW, cookie, NULL);
+		goto add_event_to_queue;
+	}
+
+	if (!event_and(mask, watch->inode->inotify_data->watch_mask) ||
+			!event_and(mask, watch->mask))
+		return;
+
+	kevent = kernel_event(watch->wd, mask, cookie, filename);
+
+add_event_to_queue:
+	if (!kevent)
+		return;
+
+	/* queue the event and wake up anyone waiting */
+	dev->event_count++;
+	dev->queue_size += sizeof(struct inotify_event) + kevent->event.len;
+	list_add_tail(&kevent->list, &dev->events);
+	wake_up_interruptible(&dev->wait);
+}
+
+static inline int inotify_dev_has_events(struct inotify_device *dev)
+{
+	return !list_empty(&dev->events);
+}
+
+/*
+ * inotify_dev_event_dequeue - destroy an event on the given device
+ *
+ * Caller must hold dev->lock.
+ */
+static void inotify_dev_event_dequeue(struct inotify_device *dev)
+{
+	struct inotify_kernel_event *kevent;
+
+	if (!inotify_dev_has_events(dev))
+		return;
+
+	kevent = inotify_dev_get_event(dev);
+	list_del_init(&kevent->list);
+	if (kevent->filename)
+		kfree(kevent->filename);
+
+	dev->event_count--;
+	dev->queue_size -= sizeof(struct inotify_event) + kevent->event.len;	
+
+	kmem_cache_free(event_cachep, kevent);
+}
+
+/*
+ * inotify_dev_get_wd - returns the next WD for use by the given dev
+ *
+ * This function can sleep.
+ */
+static int inotify_dev_get_wd(struct inotify_device *dev,
+			     struct inotify_watch *watch)
+{
+	int ret;
+
+	if (atomic_read(&dev->user->inotify_watches) >=
+			sysfs_attrib_max_user_watches)
+		return -ENOSPC;
+
+repeat:
+	if (!idr_pre_get(&dev->idr, GFP_KERNEL))
+		return -ENOSPC;
+	spin_lock(&dev->lock);
+	ret = idr_get_new(&dev->idr, watch, &watch->wd);
+	spin_unlock(&dev->lock);
+	if (ret == -EAGAIN) /* more memory is required, try again */
+		goto repeat;
+	else if (ret)       /* the idr is full! */
+		return -ENOSPC;
+
+	atomic_inc(&dev->user->inotify_watches);
+
+	return 0;
+}
+
+/*
+ * inotify_dev_put_wd - release the given WD on the given device
+ *
+ * Caller must hold dev->lock.
+ */
+static int inotify_dev_put_wd(struct inotify_device *dev, s32 wd)
+{
+	if (!dev || wd < 0)
+		return -1;
+
+	atomic_dec(&dev->user->inotify_watches);
+	idr_remove(&dev->idr, wd);
+
+	return 0;
+}
+
+/*
+ * create_watch - creates a watch on the given device.
+ *
+ * Grabs dev->lock, so the caller must not hold it.
+ */
+static struct inotify_watch *create_watch(struct inotify_device *dev,
+					  u32 mask, struct inode *inode)
+{
+	struct inotify_watch *watch;
+
+	watch = kmem_cache_alloc(watch_cachep, GFP_KERNEL);
+	if (!watch)
+		return NULL;
+
+	watch->mask = mask;
+	watch->inode = inode;
+	watch->dev = dev;
+	INIT_LIST_HEAD(&watch->d_list);
+	INIT_LIST_HEAD(&watch->i_list);
+
+	if (inotify_dev_get_wd(dev, watch)) {
+		kmem_cache_free(watch_cachep, watch);
+		return NULL;
+	}
+
+	return watch;
+}
+
+/*
+ * delete_watch - removes the given 'watch' from the given 'dev'
+ *
+ * Caller must hold dev->lock.
+ */
+static void delete_watch(struct inotify_device *dev,
+			 struct inotify_watch *watch)
+{
+	inotify_dev_put_wd(dev, watch->wd);
+	kmem_cache_free(watch_cachep, watch);
+}
+
+/*
+ * inotify_find_dev - find the watch associated with the given inode and dev
+ *
+ * Caller must hold dev->lock.
+ * FIXME: Needs inotify_data->lock too.  Don't need dev->lock, just pin it.
+ */
+static struct inotify_watch *inode_find_dev(struct inode *inode,
+					    struct inotify_device *dev)
+{
+	struct inotify_watch *watch;
+
+	if (!inode->inotify_data)
+		return NULL;
+
+	list_for_each_entry(watch, &inode->inotify_data->watches, i_list) {
+		if (watch->dev == dev)
+			return watch;
+	}
+
+	return NULL;
+}
+
+/*
+ * dev_find_wd - given a (dev,wd) pair, returns the matching inotify_watcher
+ *
+ * Returns the results of looking up (dev,wd) in the idr layer.  NULL is
+ * returned on error.
+ *
+ * The caller must hold dev->lock.
+ */
+static inline struct inotify_watch *dev_find_wd(struct inotify_device *dev,
+						u32 wd)
+{
+	return idr_find(&dev->idr, wd);
+}
+
+static int inotify_dev_is_watching_inode(struct inotify_device *dev,
+					 struct inode *inode)
+{
+	struct inotify_watch *watch;
+
+	list_for_each_entry(watch, &dev->watches, d_list) {
+		if (watch->inode == inode)
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * inotify_dev_add_watcher - add the given watcher to the given device instance
+ *
+ * Caller must hold dev->lock.
+ */
+static int inotify_dev_add_watch(struct inotify_device *dev,
+				 struct inotify_watch *watch)
+{
+	if (!dev || !watch)
+		return -EINVAL;
+
+	list_add(&watch->d_list, &dev->watches);
+	return 0;
+}
+
+/*
+ * inotify_dev_rm_watch - remove the given watch from the given device
+ *
+ * Caller must hold dev->lock because we call inotify_dev_queue_event().
+ */
+static int inotify_dev_rm_watch(struct inotify_device *dev,
+				struct inotify_watch *watch)
+{
+	if (!watch)
+		return -EINVAL;
+
+	inotify_dev_queue_event(dev, watch, IN_IGNORED, 0, NULL);
+	list_del_init(&watch->d_list);
+
+	return 0;
+}
+
+/*
+ * inode_update_watch_mask - update inode->inotify_data->watch_mask
+ *
+ * Grabs inode->inotify_data->lock.
+ */
+static void inode_update_watch_mask(struct inode *inode)
+{
+	struct inotify_inode_data *data;
+	struct inotify_watch *watch;
+	u32 new_mask;
+
+	data = get_inode_data(inode);
+	if (!data)	/* XXX: this should never happen */
+		return;
+	spin_lock(&data->lock);
+
+	new_mask = 0;
+	list_for_each_entry(watch, &data->watches, i_list)
+		new_mask |= watch->mask;
+
+	data->watch_mask = new_mask;
+
+	spin_unlock(&data->lock);
+	put_inode_data(inode);
+}
+
+/*
+ * inode_add_watch - add a watch to the given inode
+ *
+ * Callers must hold dev->lock, because we call inode_find_dev().
+ */
+static int inode_add_watch(struct inode *inode, struct inotify_watch *watch)
+{
+	int ret;
+
+	if (!inode || !watch)
+		return -EINVAL;
+
+	spin_lock(&inode->i_lock);
+	if (!inode->inotify_data) {
+		/* inotify_data is not attached to the inode, so add it */
+		inode->inotify_data = kmem_cache_alloc(inode_data_cachep,
+						       GFP_ATOMIC);
+		if (!inode->inotify_data) {
+			ret = -ENOMEM;
+			goto out_lock;
+		}
+
+		atomic_set(&inode->inotify_data->count, 0);
+		INIT_LIST_HEAD(&inode->inotify_data->watches);
+		inode->inotify_data->watch_mask = 0;
+		spin_lock_init(&inode->inotify_data->lock);
+	} else if (inode_find_dev(inode, watch->dev)) {
+		/* a watch is already associated with this (inode,dev) pair */
+		ret = -EINVAL;
+		goto out_lock;
+	}
+	__get_inode_data(inode->inotify_data);
+	spin_unlock(&inode->i_lock);
+
+	list_add(&watch->i_list, &inode->inotify_data->watches);
+	inode_update_watch_mask(inode);
+
+	return 0;
+out_lock:
+	spin_unlock(&inode->i_lock);
+	return ret;
+}
+
+static int inode_rm_watch(struct inode *inode,
+			  struct inotify_watch *watch)
+{
+	if (!inode || !watch || !inode->inotify_data)
+		return -EINVAL;
+
+	list_del_init(&watch->i_list);
+	inode_update_watch_mask(inode);
+
+	/* clean up inode->inotify_data */
+	put_inode_data(inode);	
+
+	return 0;
+}
+
+/* Kernel API */
+
+/*
+ * inotify_inode_queue_event - queue an event with the given mask, cookie, and
+ * filename to any watches associated with the given inode.
+ *
+ * inode must be pinned prior to calling.
+ */
+void inotify_inode_queue_event(struct inode *inode, u32 mask, u32 cookie,
+			       const char *filename)
+{
+	struct inotify_watch *watch;
+
+	if (!inode->inotify_data)
+		return;
+
+	list_for_each_entry(watch, &inode->inotify_data->watches, i_list) {
+		spin_lock(&watch->dev->lock);
+		inotify_dev_queue_event(watch->dev, watch, mask, cookie,
+					filename);
+		spin_unlock(&watch->dev->lock);
+	}
+}
+EXPORT_SYMBOL_GPL(inotify_inode_queue_event);
+
+void inotify_dentry_parent_queue_event(struct dentry *dentry, u32 mask,
+				       u32 cookie, const char *filename)
+{
+	struct dentry *parent;
+	struct inode *inode;
+
+	spin_lock(&dentry->d_lock);
+	parent = dentry->d_parent;
+	inode = parent->d_inode;
+	if (inode->inotify_data) {
+		dget(parent);
+		spin_unlock(&dentry->d_lock);
+		inotify_inode_queue_event(inode, mask, cookie, filename);
+		dput(parent);
+	} else
+		spin_unlock(&dentry->d_lock);
+}
+EXPORT_SYMBOL_GPL(inotify_dentry_parent_queue_event);
+
+u32 inotify_get_cookie(void)
+{
+	atomic_inc(&inotify_cookie);
+	return atomic_read(&inotify_cookie);
+}
+EXPORT_SYMBOL_GPL(inotify_get_cookie);
+
+/*
+ * watch->inode must be pinned.  We drop a reference before returning.
+ */
+static void ignore_helper(struct inotify_watch *watch, int event)
+{
+	struct inotify_device *dev;
+	struct inode *inode;
+
+	inode = watch->inode;
+	dev = watch->dev;
+
+	spin_lock(&dev->lock);
+
+	if (event)
+		inotify_dev_queue_event(dev, watch, event, 0, NULL);
+
+	inode_rm_watch(inode, watch);
+	inotify_dev_rm_watch(watch->dev, watch);
+
+	delete_watch(dev, watch);
+	spin_unlock(&dev->lock);
+
+	iput(inode);
+}
+
+void inotify_super_block_umount(struct super_block *sb)
+{
+	struct inode *inode;
+
+	spin_lock(&inode_lock);
+
+	/*
+	 * We hold the inode_lock, so the inodes are not going anywhere, and
+	 * we grab a reference on inotify_data before walking its list of
+	 * watches.
+	 */
+	list_for_each_entry(inode, &inode_in_use, i_list) {
+		struct inotify_inode_data *inode_data;
+		struct inotify_watch *watch;
+
+		if (inode->i_sb != sb)
+			continue;
+
+		inode_data = get_inode_data(inode);
+		if (!inode_data)
+			continue;
+
+		list_for_each_entry(watch, &inode_data->watches, i_list)
+			ignore_helper(watch, IN_UNMOUNT);
+		put_inode_data(inode);
+	}
+
+	spin_unlock(&inode_lock);
+}
+EXPORT_SYMBOL_GPL(inotify_super_block_umount);
+
+/*
+ * inotify_inode_is_dead - an inode has been deleted, cleanup any watches
+ */
+void inotify_inode_is_dead(struct inode *inode)
+{
+	struct inotify_watch *watch, *next;
+	struct inotify_inode_data *data;
+
+	data = get_inode_data(inode);
+	if (!data)
+		return;
+	list_for_each_entry_safe(watch, next, &data->watches, i_list)
+		ignore_helper(watch, 0);
+	put_inode_data(inode);
+}
+EXPORT_SYMBOL_GPL(inotify_inode_is_dead);
+
+/* The driver interface is implemented below */
+
+static unsigned int inotify_poll(struct file *file, poll_table *wait)
+{
+        struct inotify_device *dev;
+
+        dev = file->private_data;
+
+        poll_wait(file, &dev->wait, wait);
+
+        if (inotify_dev_has_events(dev))
+                return POLLIN | POLLRDNORM;
+
+        return 0;
+}
+
+static ssize_t inotify_read(struct file *file, char __user *buf,
+			    size_t count, loff_t *pos)
+{
+	size_t event_size;
+	struct inotify_device *dev;
+	char __user *start;
+	DECLARE_WAITQUEUE(wait, current);
+
+	start = buf;
+	dev = file->private_data;
+
+	/* We only hand out full inotify events */
+	event_size = sizeof(struct inotify_event);
+	if (count < event_size)
+		return 0;
+
+	while (1) {
+		int has_events;
+
+		spin_lock(&dev->lock);
+		has_events = inotify_dev_has_events(dev);
+		spin_unlock(&dev->lock);
+		if (has_events)
+			break;
+
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		add_wait_queue(&dev->wait, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		schedule();
+
+		set_current_state(TASK_RUNNING);		
+		remove_wait_queue(&dev->wait, &wait);
+	}
+
+	while (count >= event_size) {
+		struct inotify_kernel_event *kevent;
+
+		spin_lock(&dev->lock);
+		if (!inotify_dev_has_events(dev)) {
+			spin_unlock(&dev->lock);
+			break;
+		}
+		kevent = inotify_dev_get_event(dev);
+		spin_unlock(&dev->lock);		
+
+		/* We can't send this event, not enough space in the buffer */
+		if (event_size + kevent->event.len > count)
+			break;
+
+		/* Copy the entire event except the string to user space */
+		if (copy_to_user(buf, &kevent->event, event_size)) 
+			return -EFAULT;
+
+		buf += event_size;
+		count -= event_size;
+
+		/* Copy the filename to user space */
+		if (kevent->filename) {
+			if (copy_to_user(buf, kevent->filename,
+					 kevent->event.len))
+				return -EFAULT;
+			buf += kevent->event.len;
+			count -= kevent->event.len;
+		}
+
+		spin_lock(&dev->lock);
+		inotify_dev_event_dequeue(dev);
+		spin_unlock(&dev->lock);
+	}
+
+	return buf - start;
+}
+
+static int inotify_open(struct inode *inode, struct file *file)
+{
+	struct inotify_device *dev;
+	struct user_struct *user;
+	int ret;
+
+	user = get_uid(current->user);
+
+	if (atomic_read(&user->inotify_devs) >= sysfs_attrib_max_user_devices) {
+		ret = -EMFILE;
+		goto out_err;
+	}
+
+	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	atomic_inc(&current->user->inotify_devs);	
+
+	idr_init(&dev->idr);
+
+	INIT_LIST_HEAD(&dev->events);
+	INIT_LIST_HEAD(&dev->watches);
+	init_waitqueue_head(&dev->wait);
+
+	dev->event_count = 0;
+	dev->queue_size = 0;
+	dev->max_events = sysfs_attrib_max_queued_events;
+	dev->user = user;
+	spin_lock_init(&dev->lock);
+
+	file->private_data = dev;
+
+	return 0;
+out_err:
+	free_uid(current->user);
+	return ret;
+}
+
+/*
+ * inotify_release_all_watches - destroy all watches on a given device
+ *
+ * FIXME: Do we want a lock here?
+ */
+static void inotify_release_all_watches(struct inotify_device *dev)
+{
+	struct inotify_watch *watch, *next;
+
+	list_for_each_entry_safe(watch, next, &dev->watches, d_list)
+		ignore_helper(watch, 0);
+}
+
+/*
+ * inotify_release_all_events - destroy all of the events on a given device
+ */
+static void inotify_release_all_events(struct inotify_device *dev)
+{
+	spin_lock(&dev->lock);
+	while (inotify_dev_has_events(dev))
+		inotify_dev_event_dequeue(dev);
+	spin_unlock(&dev->lock);
+}
+
+static int inotify_release(struct inode *inode, struct file *file)
+{
+	struct inotify_device *dev;
+
+	dev = file->private_data;
+
+	inotify_release_all_watches(dev);
+	inotify_release_all_events(dev);
+
+	atomic_dec(&dev->user->inotify_devs);
+	free_uid(dev->user);
+
+	kfree(dev);
+
+	return 0;
+}
+
+static int inotify_add_watch(struct inotify_device *dev,
+			     struct inotify_watch_request *request)
+{
+	struct inode *inode;
+	struct inotify_watch *watch;
+	int ret;
+
+	inode = find_inode((const char __user*) request->dirname);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	spin_lock(&dev->lock);
+
+	/*
+	 * This handles the case of re-adding a directory we are already
+	 * watching, we just update the mask and return 0
+	 */
+	if (inotify_dev_is_watching_inode(dev, inode)) {
+		struct inotify_watch *owatch;	/* the old watch */
+
+		owatch = inode_find_dev(inode, dev);
+		owatch->mask = request->mask;
+		inode_update_watch_mask(inode);
+		spin_unlock(&dev->lock);
+		iput(inode);
+
+		return owatch->wd;
+	}
+
+	spin_unlock(&dev->lock);
+
+	watch = create_watch(dev, request->mask, inode);
+	if (!watch) {
+		iput(inode);
+		return -ENOSPC;
+	}
+
+	spin_lock(&dev->lock);
+
+	/* We can't add anymore watches to this device */
+	if (inotify_dev_add_watch(dev, watch)) {
+		delete_watch(dev, watch);
+		spin_unlock(&dev->lock);
+		iput(inode);
+		return -EINVAL;
+	}
+
+	ret = inode_add_watch(inode, watch);
+	if (ret < 0) {
+		list_del_init(&watch->d_list);
+		delete_watch(dev, watch);
+		spin_unlock(&dev->lock);
+		iput(inode);
+		return ret;
+	}
+
+	spin_unlock(&dev->lock);
+
+	return watch->wd;
+}
+
+static int inotify_ignore(struct inotify_device *dev, s32 wd)
+{
+	struct inotify_watch *watch;
+
+	/*
+	 * FIXME: Silly to grab dev->lock here and then drop it, when
+	 * ignore_helper() grabs it anyway a few lines down.
+	 */
+	spin_lock(&dev->lock);
+	watch = dev_find_wd(dev, wd);
+	spin_unlock(&dev->lock);
+	if (!watch)
+		return -EINVAL;
+	ignore_helper(watch, 0);
+
+	return 0;
+}
+
+/*
+ * inotify_ioctl() - our device file's ioctl method
+ *
+ * The VFS serializes all of our calls via the BKL and we rely on that.  We
+ * could, alternatively, grab dev->lock.  Right now lower levels grab that
+ * where needed.
+ */
+static int inotify_ioctl(struct inode *ip, struct file *fp,
+			 unsigned int cmd, unsigned long arg)
+{
+	struct inotify_device *dev;
+	struct inotify_watch_request request;
+	void __user *p;
+	s32 wd;
+
+	dev = fp->private_data;
+	p = (void __user *) arg;
+
+	switch (cmd) {
+	case INOTIFY_WATCH:
+		if (copy_from_user(&request, p, sizeof (request)))
+			return -EFAULT;
+		return inotify_add_watch(dev, &request);
+	case INOTIFY_IGNORE:
+		if (copy_from_user(&wd, p, sizeof (wd)))
+			return -EFAULT;
+		return inotify_ignore(dev, wd);
+	case FIONREAD:
+		return put_user(dev->queue_size, (int __user *) p);
+	default:
+		return -ENOTTY;
+	}
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
+	.minor  = MISC_DYNAMIC_MINOR,
+	.name	= "inotify",
+	.fops	= &inotify_fops,
+};
+
+static int __init inotify_init(void)
+{
+	struct class_device *class;
+	int ret;
+
+	ret = misc_register(&inotify_device);
+	if (ret)
+		return ret;
+
+	sysfs_attrib_max_queued_events = 512;
+	sysfs_attrib_max_user_devices = 64;
+	sysfs_attrib_max_user_watches = 16384;
+
+	class = inotify_device.class;
+	class_device_create_file(class, &class_device_attr_max_queued_events);
+	class_device_create_file(class, &class_device_attr_max_user_devices);
+	class_device_create_file(class, &class_device_attr_max_user_watches);
+
+	atomic_set(&inotify_cookie, 0);
+
+	watch_cachep = kmem_cache_create("inotify_watch_cache",
+			sizeof(struct inotify_watch), 0, SLAB_PANIC,
+			NULL, NULL);
+
+	event_cachep = kmem_cache_create("inotify_event_cache",
+			sizeof(struct inotify_kernel_event), 0,
+			SLAB_PANIC, NULL, NULL);
+
+	inode_data_cachep = kmem_cache_create("inotify_inode_data_cache",
+			sizeof(struct inotify_inode_data), 0, SLAB_PANIC,
+			NULL, NULL);
+
+	printk(KERN_INFO "inotify device minor=%d\n", inotify_device.minor);
+
+	return 0;
+}
+
+module_init(inotify_init);
diff -urN linux-2.6.11-rc1-mm2/drivers/char/Kconfig linux-inotify/drivers/char/Kconfig
--- linux-2.6.11-rc1-mm2/drivers/char/Kconfig	2005-01-20 16:39:42.264695336 -0500
+++ linux-inotify/drivers/char/Kconfig	2005-01-20 16:29:10.059805088 -0500
@@ -62,6 +62,19 @@
 	depends on VT && !S390 && !USERMODE
 	default y
 
+config INOTIFY
+	bool "Inotify file change notification support"
+	default y
+	---help---
+	  Say Y here to enable inotify support and the /dev/inotify character
+	  device.  Inotify is a file change notification system and a
+	  replacement for dnotify.  Inotify fixes numerous shortcomings in
+	  dnotify and introduces several new features.  It allows monitoring
+	  of both files and directories via a single open fd.  Multiple file
+	  events are supported.
+	  
+	  If unsure, say Y.
+
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
 	---help---
diff -urN linux-2.6.11-rc1-mm2/drivers/char/Makefile linux-inotify/drivers/char/Makefile
--- linux-2.6.11-rc1-mm2/drivers/char/Makefile	2005-01-20 16:39:42.264695336 -0500
+++ linux-inotify/drivers/char/Makefile	2005-01-20 16:29:10.060804936 -0500
@@ -9,6 +9,8 @@
 
 obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o
 
+
+obj-$(CONFIG_INOTIFY)           += inotify.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-y				+= misc.o
diff -urN linux-2.6.11-rc1-mm2/fs/attr.c linux-inotify/fs/attr.c
--- linux-2.6.11-rc1-mm2/fs/attr.c	2005-01-20 16:39:42.265695184 -0500
+++ linux-inotify/fs/attr.c	2005-01-20 16:29:14.801084304 -0500
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
@@ -107,29 +108,51 @@
 out:
 	return error;
 }
-
 EXPORT_SYMBOL(inode_setattr);
 
-int setattr_mask(unsigned int ia_valid)
+void setattr_mask (unsigned int ia_valid, int *dn_mask, u32 *in_mask)
 {
-	unsigned long dn_mask = 0;
+	int dnmask;
+	u32 inmask;
 
-	if (ia_valid & ATTR_UID)
-		dn_mask |= DN_ATTRIB;
-	if (ia_valid & ATTR_GID)
-		dn_mask |= DN_ATTRIB;
-	if (ia_valid & ATTR_SIZE)
-		dn_mask |= DN_MODIFY;
-	/* both times implies a utime(s) call */
-	if ((ia_valid & (ATTR_ATIME|ATTR_MTIME)) == (ATTR_ATIME|ATTR_MTIME))
-		dn_mask |= DN_ATTRIB;
-	else if (ia_valid & ATTR_ATIME)
-		dn_mask |= DN_ACCESS;
-	else if (ia_valid & ATTR_MTIME)
-		dn_mask |= DN_MODIFY;
-	if (ia_valid & ATTR_MODE)
-		dn_mask |= DN_ATTRIB;
-	return dn_mask;
+	inmask = 0;
+	dnmask = 0;
+
+	if (!dn_mask || !in_mask) {
+		return;
+	}
+        if (ia_valid & ATTR_UID) {
+                inmask |= IN_ATTRIB;
+		dnmask |= DN_ATTRIB;
+	}
+        if (ia_valid & ATTR_GID) {
+                inmask |= IN_ATTRIB;
+		dnmask |= DN_ATTRIB;
+	}
+        if (ia_valid & ATTR_SIZE) {
+                inmask |= IN_MODIFY;
+		dnmask |= DN_MODIFY;
+	}
+        /* both times implies a utime(s) call */
+        if ((ia_valid & (ATTR_ATIME|ATTR_MTIME)) == (ATTR_ATIME|ATTR_MTIME)) {
+                inmask |= IN_ATTRIB;
+		dnmask |= DN_ATTRIB;
+	}
+        else if (ia_valid & ATTR_ATIME) {
+                inmask |= IN_ACCESS;
+		dnmask |= DN_ACCESS;
+	}
+        else if (ia_valid & ATTR_MTIME) {
+                inmask |= IN_MODIFY;
+		dnmask |= DN_MODIFY;
+	}
+        if (ia_valid & ATTR_MODE) {
+                inmask |= IN_ATTRIB;
+		dnmask |= DN_ATTRIB;
+	}
+
+	*in_mask = inmask;
+	*dn_mask = dnmask;
 }
 
 int notify_change(struct dentry * dentry, struct iattr * attr)
@@ -195,9 +218,19 @@
 		up_write(&dentry->d_inode->i_alloc_sem);
 
 	if (!error) {
-		unsigned long dn_mask = setattr_mask(ia_valid);
+		int dn_mask;
+		u32 in_mask;
+
+		setattr_mask (ia_valid, &dn_mask, &in_mask);
+
 		if (dn_mask)
 			dnotify_parent(dentry, dn_mask);
+		if (in_mask) {
+			inotify_inode_queue_event(dentry->d_inode, in_mask, 0,
+						  NULL);
+			inotify_dentry_parent_queue_event(dentry, in_mask, 0,
+							  dentry->d_name.name);
+		}
 	}
 	return error;
 }
diff -urN linux-2.6.11-rc1-mm2/fs/file_table.c linux-inotify/fs/file_table.c
--- linux-2.6.11-rc1-mm2/fs/file_table.c	2005-01-20 16:39:42.266695032 -0500
+++ linux-inotify/fs/file_table.c	2005-01-20 16:29:14.802084152 -0500
@@ -16,6 +16,7 @@
 #include <linux/eventpoll.h>
 #include <linux/mount.h>
 #include <linux/cdev.h>
+#include <linux/inotify.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
@@ -120,6 +121,12 @@
 	struct dentry *dentry = file->f_dentry;
 	struct vfsmount *mnt = file->f_vfsmnt;
 	struct inode *inode = dentry->d_inode;
+	u32 mask;
+
+
+	mask = (file->f_mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
 
 	might_sleep();
 	/*
diff -urN linux-2.6.11-rc1-mm2/fs/inode.c linux-inotify/fs/inode.c
--- linux-2.6.11-rc1-mm2/fs/inode.c	2005-01-20 16:39:42.267694880 -0500
+++ linux-inotify/fs/inode.c	2005-01-20 16:29:14.803084000 -0500
@@ -132,6 +132,9 @@
 #ifdef CONFIG_QUOTA
 		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
 #endif
+#ifdef CONFIG_INOTIFY
+		inode->inotify_data = NULL;
+#endif
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
diff -urN linux-2.6.11-rc1-mm2/fs/namei.c linux-inotify/fs/namei.c
--- linux-2.6.11-rc1-mm2/fs/namei.c	2005-01-20 16:39:42.270694424 -0500
+++ linux-inotify/fs/namei.c	2005-01-20 16:29:14.805083696 -0500
@@ -22,6 +22,7 @@
 #include <linux/quotaops.h>
 #include <linux/pagemap.h>
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
 #include <linux/security.h>
@@ -1253,6 +1254,8 @@
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE_FILE,
+				0, dentry->d_name.name);
 		security_inode_post_create(dir, dentry, mode);
 	}
 	return error;
@@ -1558,6 +1561,8 @@
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE_FILE, 0,
+				dentry->d_name.name);
 		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
 	return error;
@@ -1631,6 +1636,8 @@
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE_SUBDIR, 0,
+				dentry->d_name.name);
 		security_inode_post_mkdir(dir,dentry, mode);
 	}
 	return error;
@@ -1726,6 +1733,11 @@
 	up(&dentry->d_inode->i_sem);
 	if (!error) {
 		inode_dir_notify(dir, DN_DELETE);
+		inotify_inode_queue_event(dir, IN_DELETE_SUBDIR, 0,
+				dentry->d_name.name);
+		inotify_inode_queue_event(dentry->d_inode, IN_DELETE_SELF, 0,
+				NULL);
+		inotify_inode_is_dead (dentry->d_inode);
 		d_delete(dentry);
 	}
 	dput(dentry);
@@ -1798,8 +1810,13 @@
 
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
 	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
-		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);
+		inotify_inode_queue_event(dir, IN_DELETE_FILE, 0,
+				dentry->d_name.name);
+		inotify_inode_queue_event(dentry->d_inode, IN_DELETE_SELF, 0,
+				NULL);
+		inotify_inode_is_dead (dentry->d_inode);
+		d_delete(dentry);
 	}
 	return error;
 }
@@ -1875,6 +1892,8 @@
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE_FILE, 0,
+				dentry->d_name.name);
 		security_inode_post_symlink(dir, dentry, oldname);
 	}
 	return error;
@@ -1948,6 +1967,8 @@
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		inotify_inode_queue_event(dir, IN_CREATE_FILE, 0, 
+					new_dentry->d_name.name);
 		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
 	return error;
@@ -2111,6 +2132,8 @@
 {
 	int error;
 	int is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
+	char *old_name;
+	u32 cookie;
 
 	if (old_dentry->d_inode == new_dentry->d_inode)
  		return 0;
@@ -2132,6 +2155,8 @@
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 
+	old_name = inotify_oldname_init(old_dentry);
+
 	if (is_dir)
 		error = vfs_rename_dir(old_dir,old_dentry,new_dir,new_dentry);
 	else
@@ -2143,7 +2168,16 @@
 			inode_dir_notify(old_dir, DN_DELETE);
 			inode_dir_notify(new_dir, DN_CREATE);
 		}
+
+		cookie = inotify_get_cookie();
+
+		inotify_inode_queue_event(old_dir, IN_MOVED_FROM, cookie,
+					  old_name);
+		inotify_inode_queue_event(new_dir, IN_MOVED_TO, cookie,
+					  old_dentry->d_name.name);
 	}
+	inotify_oldname_free(old_name);
+
 	return error;
 }
 
diff -urN linux-2.6.11-rc1-mm2/fs/open.c linux-inotify/fs/open.c
--- linux-2.6.11-rc1-mm2/fs/open.c	2005-01-20 16:39:42.271694272 -0500
+++ linux-inotify/fs/open.c	2005-01-20 16:29:59.228330336 -0500
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
@@ -949,6 +950,10 @@
 			error = PTR_ERR(f);
 			if (IS_ERR(f))
 				goto out_error;
+			inotify_inode_queue_event(f->f_dentry->d_inode,
+					IN_OPEN, 0, NULL);
+			inotify_dentry_parent_queue_event(f->f_dentry, IN_OPEN,
+					0, f->f_dentry->d_name.name);
 			ltt_ev_file_system(LTT_EV_FILE_SYSTEM_OPEN, fd,
 				f->f_dentry->d_name.len,
 				f->f_dentry->d_name.name);
diff -urN linux-2.6.11-rc1-mm2/fs/read_write.c linux-inotify/fs/read_write.c
--- linux-2.6.11-rc1-mm2/fs/read_write.c	2005-01-20 16:39:42.273693968 -0500
+++ linux-inotify/fs/read_write.c	2005-01-20 16:31:56.689473528 -0500
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
@@ -223,7 +224,13 @@
 			else
 				ret = do_sync_read(file, buf, count, pos);
 			if (ret > 0) {
-				dnotify_parent(file->f_dentry, DN_ACCESS);
+				struct dentry *dentry = file->f_dentry;
+				dnotify_parent(dentry, DN_ACCESS);
+				inotify_dentry_parent_queue_event(dentry,
+						IN_ACCESS, 0,
+						dentry->d_name.name);
+				inotify_inode_queue_event(inode, IN_ACCESS, 0,
+						NULL);
 				current->rchar += ret;
 			}
 			current->syscr++;
@@ -270,7 +277,13 @@
 			else
 				ret = do_sync_write(file, buf, count, pos);
 			if (ret > 0) {
-				dnotify_parent(file->f_dentry, DN_MODIFY);
+				struct dentry *dentry = file->f_dentry;
+				dnotify_parent(dentry, DN_MODIFY);
+				inotify_dentry_parent_queue_event(dentry,
+						IN_MODIFY, 0,
+						dentry->d_name.name);
+				inotify_inode_queue_event(inode, IN_MODIFY, 0,
+						NULL);
 				current->wchar += ret;
 			}
 			current->syscw++;
@@ -514,9 +527,15 @@
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0)
-		dnotify_parent(file->f_dentry,
-				(type == READ) ? DN_ACCESS : DN_MODIFY);
+	if ((ret + (type == READ)) > 0) {
+		struct dentry *dentry = file->f_dentry;
+		dnotify_parent(dentry, (type == READ) ? DN_ACCESS : DN_MODIFY);
+		inotify_dentry_parent_queue_event(dentry,
+				(type == READ) ? IN_ACCESS : IN_MODIFY, 0,
+				dentry->d_name.name);
+		inotify_inode_queue_event (dentry->d_inode,
+				(type == READ) ? IN_ACCESS : IN_MODIFY, 0, NULL);
+	}
 	return ret;
 }
 
diff -urN linux-2.6.11-rc1-mm2/fs/super.c linux-inotify/fs/super.c
--- linux-2.6.11-rc1-mm2/fs/super.c	2005-01-20 16:39:42.273693968 -0500
+++ linux-inotify/fs/super.c	2005-01-20 16:29:14.809083088 -0500
@@ -38,6 +38,7 @@
 #include <linux/idr.h>
 #include <linux/kobject.h>
 #include <asm/uaccess.h>
+#include <linux/inotify.h>
 
 
 void get_filesystem(struct file_system_type *fs);
@@ -229,6 +230,7 @@
 
 	if (root) {
 		sb->s_root = NULL;
+		inotify_super_block_umount(sb);
 		shrink_dcache_parent(root);
 		shrink_dcache_anon(&sb->s_anon);
 		dput(root);
diff -urN linux-2.6.11-rc1-mm2/include/linux/fs.h linux-inotify/include/linux/fs.h
--- linux-2.6.11-rc1-mm2/include/linux/fs.h	2005-01-20 16:39:42.275693664 -0500
+++ linux-inotify/include/linux/fs.h	2005-01-20 16:29:14.811082784 -0500
@@ -27,6 +27,7 @@
 struct kstatfs;
 struct vm_area_struct;
 struct vfsmount;
+struct inotify_inode_data;
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -474,6 +475,10 @@
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 #endif
 
+#ifdef CONFIG_INOTIFY
+	struct inotify_inode_data *inotify_data;
+#endif
+
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
@@ -1376,7 +1381,7 @@
 extern int do_remount_sb(struct super_block *sb, int flags,
 			 void *data, int force);
 extern sector_t bmap(struct inode *, sector_t);
-extern int setattr_mask(unsigned int);
+extern void setattr_mask(unsigned int, int *, u32 *);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int, struct nameidata *);
 extern int generic_permission(struct inode *, int,
diff -urN linux-2.6.11-rc1-mm2/include/linux/inotify.h linux-inotify/include/linux/inotify.h
--- linux-2.6.11-rc1-mm2/include/linux/inotify.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-inotify/include/linux/inotify.h	2005-01-20 16:29:14.812082632 -0500
@@ -0,0 +1,150 @@
+/*
+ * Inode based directory notification for Linux
+ *
+ * Copyright (C) 2004 John McCutchan
+ */
+
+#ifndef _LINUX_INOTIFY_H
+#define _LINUX_INOTIFY_H
+
+#include <linux/types.h>
+#include <linux/limits.h>
+
+/*
+ * struct inotify_event - structure read from the inotify device for each event
+ *
+ * When you are watching a directory, you will receive the filename for events
+ * such as IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, ...
+ */
+struct inotify_event {
+	__s32 wd;
+	__u32 mask;
+	__u32 cookie;
+	size_t len;
+	char filename[0];
+};
+
+/*
+ * struct inotify_watch_request - represents a watch request
+ *
+ * Pass to the inotify device via the INOTIFY_WATCH ioctl
+ */
+struct inotify_watch_request {
+	char *dirname;		/* directory name */
+	__u32 mask;		/* event mask */
+};
+
+/* the following are legal, implemented events */
+#define IN_ACCESS		0x00000001	/* File was accessed */
+#define IN_MODIFY		0x00000002	/* File was modified */
+#define IN_ATTRIB		0x00000004	/* File changed attributes */
+#define IN_CLOSE_WRITE		0x00000008	/* Writtable file was closed */
+#define IN_CLOSE_NOWRITE	0x00000010	/* Unwrittable file closed */
+#define IN_OPEN			0x00000020	/* File was opened */
+#define IN_MOVED_FROM		0x00000040	/* File was moved from X */
+#define IN_MOVED_TO		0x00000080	/* File was moved to Y */
+#define IN_DELETE_SUBDIR	0x00000100	/* Subdir was deleted */ 
+#define IN_DELETE_FILE		0x00000200	/* Subfile was deleted */
+#define IN_CREATE_SUBDIR	0x00000400	/* Subdir was created */
+#define IN_CREATE_FILE		0x00000800	/* Subfile was created */
+#define IN_DELETE_SELF		0x00001000	/* Self was deleted */
+#define IN_UNMOUNT		0x00002000	/* Backing fs was unmounted */
+#define IN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
+#define IN_IGNORED		0x00008000	/* File was ignored */
+
+/* special flags */
+#define IN_ALL_EVENTS		0xffffffff	/* All the events */
+#define IN_CLOSE		(IN_CLOSE_WRITE | IN_CLOSE_NOWRITE)
+
+#define INOTIFY_IOCTL_MAGIC	'Q'
+#define INOTIFY_IOCTL_MAXNR	2
+
+#define INOTIFY_WATCH  		_IOR(INOTIFY_IOCTL_MAGIC, 1, struct inotify_watch_request)
+#define INOTIFY_IGNORE 		_IOR(INOTIFY_IOCTL_MAGIC, 2, int)
+
+#ifdef __KERNEL__
+
+#include <linux/dcache.h>
+#include <linux/fs.h>
+#include <linux/config.h>
+
+struct inotify_inode_data {
+	struct list_head watches;
+	__u32 watch_mask;
+	spinlock_t lock;
+	atomic_t count;
+};
+
+#ifdef CONFIG_INOTIFY
+
+extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
+				      const char *);
+extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
+					      const char *);
+extern void inotify_super_block_umount(struct super_block *);
+extern void inotify_inode_is_dead(struct inode *);
+extern __u32 inotify_get_cookie(void);
+extern __u32 setattr_mask_inotify(unsigned int);
+
+/* this could be kstrdup if only we could add that to lib/string.c */
+static inline char * inotify_oldname_init(struct dentry *old_dentry)
+{
+	char *old_name;
+
+	old_name = kmalloc(strlen(old_dentry->d_name.name) + 1, GFP_KERNEL);
+	if (old_name)
+		strcpy(old_name, old_dentry->d_name.name);
+	return old_name;
+}
+
+static inline void inotify_oldname_free(const char *old_name)
+{
+	kfree(old_name);
+}
+
+#else
+
+static inline void inotify_inode_queue_event(struct inode *inode,
+					     __u32 mask, __u32 cookie,
+					     const char *filename)
+{
+}
+
+static inline void inotify_dentry_parent_queue_event(struct dentry *dentry,
+						     __u32 mask, __u32 cookie,
+						     const char *filename)
+{
+}
+
+static inline void inotify_super_block_umount(struct super_block *sb)
+{
+}
+
+static inline void inotify_inode_is_dead(struct inode *inode)
+{
+}
+
+static inline char * inotify_oldname_init(struct dentry *old_dentry)
+{
+	return NULL;
+}
+
+static inline __u32 inotify_get_cookie(void)
+{
+	return 0;
+}
+
+static inline void inotify_oldname_free(const char *old_name)
+{
+}
+
+static inline int setattr_mask_inotify(unsigned int ia_mask)
+{
+	return 0;
+}
+
+#endif	/* CONFIG_INOTIFY */
+
+#endif	/* __KERNEL __ */
+
+#endif	/* _LINUX_INOTIFY_H */
diff -urN linux-2.6.11-rc1-mm2/include/linux/miscdevice.h linux-inotify/include/linux/miscdevice.h
--- linux-2.6.11-rc1-mm2/include/linux/miscdevice.h	2005-01-20 16:39:42.284692296 -0500
+++ linux-inotify/include/linux/miscdevice.h	2005-01-20 16:29:14.813082480 -0500
@@ -2,6 +2,7 @@
 #define _LINUX_MISCDEVICE_H
 #include <linux/module.h>
 #include <linux/major.h>
+#include <linux/device.h>
 
 #define PSMOUSE_MINOR  1
 #define MS_BUSMOUSE_MINOR 2
diff -urN linux-2.6.11-rc1-mm2/include/linux/sched.h linux-inotify/include/linux/sched.h
--- linux-2.6.11-rc1-mm2/include/linux/sched.h	2005-01-20 16:39:42.285692144 -0500
+++ linux-inotify/include/linux/sched.h	2005-01-20 16:29:14.815082176 -0500
@@ -382,6 +382,8 @@
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
+	atomic_t inotify_watches;	/* How many inotify watches does this user have? */
+	atomic_t inotify_devs;	/* How many inotify devs does this user have opened? */
 	/* protected by mq_lock	*/
 	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
 	unsigned long locked_shm; /* How many pages of mlocked shm ? */
diff -urN linux-2.6.11-rc1-mm2/kernel/user.c linux-inotify/kernel/user.c
--- linux-2.6.11-rc1-mm2/kernel/user.c	2005-01-20 16:39:42.286691992 -0500
+++ linux-inotify/kernel/user.c	2005-01-20 16:29:14.815082176 -0500
@@ -119,6 +119,8 @@
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
 		atomic_set(&new->sigpending, 0);
+		atomic_set(&new->inotify_watches, 0);
+		atomic_set(&new->inotify_devs, 0);
 
 		new->mq_bytes = 0;
 		new->locked_shm = 0;


