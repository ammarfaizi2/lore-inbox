Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVCDTlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVCDTlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVCDTlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:41:18 -0500
Received: from peabody.ximian.com ([130.57.169.10]:58242 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263022AbVCDTRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:17:43 -0500
Subject: [patch] inotify for 2.6.11-mm1
From: Robert Love <rml@novell.com>
To: akpm@osdl.org
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1109961444.10313.13.camel@betsy.boston.ximian.com>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 14:11:34 -0500
Message-Id: <1109963494.10313.32.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 13:37 -0500, Robert Love wrote:

Hey, Andrew.

> I greatly reworked much of the data structures and their interactions,
> to lay the groundwork for sanitizing the locking.  I then, I hope,
> sanitized the locking.  It looks right, I am happy.  Comments welcome.
> I surely could of missed something.  Maybe even something big.
> 
> But, regardless, this release is a huge jump from the previous, fixing
> all known issues and greatly improving the locking.

Attached is inotify, replacing the current version of inotify in 2.6-mm.
The patch is diffed against 2.6.11-mm1, modulo the two inotify patches
already in-tree.

I'd like to start moving forward on this, the locking is greatly
improved, resolve any new issues, etc.

Please, apply.

Your humble servant,

	Robert Love


inotify!

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
	* inotify supports much finer grained events.

Inotify is currently used by Beagle (a desktop search infrastructure)
and Gamin (a FAM replacement).

Signed-off-by: Robert Love <rml@novell.com>

 fs/Kconfig                 |   13 
 fs/Makefile                |    1 
 fs/attr.c                  |   33 -
 fs/compat.c                |   14 
 fs/file_table.c            |    4 
 fs/inode.c                 |    4 
 fs/inotify.c               | 1013 +++++++++++++++++++++++++++++++++++++++++++++
 fs/namei.c                 |   38 -
 fs/open.c                  |    9 
 fs/read_write.c            |   24 -
 fs/super.c                 |    2 
 include/linux/fs.h         |    8 
 include/linux/fsnotify.h   |  235 ++++++++++
 include/linux/inotify.h    |  113 +++++
 include/linux/sched.h      |    2 
 kernel/user.c              |    2 
 18 files changed, 1453 insertions(+), 62 deletions(-)

diff -urN linux-2.6.11-mm1/fs/attr.c linux/fs/attr.c
--- linux-2.6.11-mm1/fs/attr.c	2005-03-04 14:06:21.732297568 -0500
+++ linux/fs/attr.c	2005-03-04 13:27:05.560490128 -0500
@@ -10,7 +10,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
@@ -107,31 +107,8 @@
 out:
 	return error;
 }
-
 EXPORT_SYMBOL(inode_setattr);
 
-int setattr_mask(unsigned int ia_valid)
-{
-	unsigned long dn_mask = 0;
-
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
-}
-
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
@@ -194,11 +171,9 @@
 	if (ia_valid & ATTR_SIZE)
 		up_write(&dentry->d_inode->i_alloc_sem);
 
-	if (!error) {
-		unsigned long dn_mask = setattr_mask(ia_valid);
-		if (dn_mask)
-			dnotify_parent(dentry, dn_mask);
-	}
+	if (!error)
+		fsnotify_change(dentry, ia_valid);
+
 	return error;
 }
 
diff -urN linux-2.6.11-mm1/fs/compat.c linux/fs/compat.c
--- linux-2.6.11-mm1/fs/compat.c	2005-03-04 14:06:21.734297264 -0500
+++ linux/fs/compat.c	2005-03-04 13:27:05.562489824 -0500
@@ -36,7 +36,7 @@
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/dirent.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/highuid.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
@@ -1233,9 +1233,15 @@
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0)
-		dnotify_parent(file->f_dentry,
-				(type == READ) ? DN_ACCESS : DN_MODIFY);
+	if ((ret + (type == READ)) > 0) {
+		struct dentry *dentry = file->f_dentry;
+		if (type == READ)
+			fsnotify_access(dentry, dentry->d_inode,
+					dentry->d_name.name);
+		else
+			fsnotify_modify(dentry, dentry->d_inode,
+					dentry->d_name.name);
+	}
 	return ret;
 }
 
diff -urN linux-2.6.11-mm1/fs/file_table.c linux/fs/file_table.c
--- linux-2.6.11-mm1/fs/file_table.c	2005-03-04 14:06:21.734297264 -0500
+++ linux/fs/file_table.c	2005-03-04 13:27:05.563489672 -0500
@@ -16,6 +16,7 @@
 #include <linux/eventpoll.h>
 #include <linux/mount.h>
 #include <linux/cdev.h>
+#include <linux/fsnotify.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
@@ -122,6 +123,9 @@
 	struct vfsmount *mnt = file->f_vfsmnt;
 	struct inode *inode = dentry->d_inode;
 
+
+	fsnotify_close(dentry, inode, file->f_mode, dentry->d_name.name);
+
 	might_sleep();
 	/*
 	 * The function eventpoll_release() should be the first called
diff -urN linux-2.6.11-mm1/fs/inode.c linux/fs/inode.c
--- linux-2.6.11-mm1/fs/inode.c	2005-03-04 14:06:21.737296808 -0500
+++ linux/fs/inode.c	2005-03-04 13:27:05.565489368 -0500
@@ -132,6 +132,10 @@
 #ifdef CONFIG_QUOTA
 		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
 #endif
+#ifdef CONFIG_INOTIFY
+		INIT_LIST_HEAD(&inode->inotify_watches);
+		spin_lock_init(&inode->inotify_lock);
+#endif
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
diff -urN linux-2.6.11-mm1/fs/inotify.c linux/fs/inotify.c
--- linux-2.6.11-mm1/fs/inotify.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/fs/inotify.c	2005-03-04 13:27:05.568488912 -0500
@@ -0,0 +1,1013 @@
+/*
+ * fs/inotify.c - inode-based file event notifications
+ *
+ * Authors:
+ *	John McCutchan	<ttb@tentacle.dhs.org>
+ *	Robert Love	<rml@novell.com>
+ *
+ * Copyright (C) 2005 John McCutchan
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
+
+static kmem_cache_t *watch_cachep;
+static kmem_cache_t *event_cachep;
+
+static int max_user_devices;
+static int max_user_watches;
+static unsigned int max_queued_events;
+
+/*
+ * Lock ordering:
+ *
+ * inode_lock (used to safely walk inode_in_use list)
+ *   inode->inotify_lock (protects inotify->inotify_watches and watches->i_list)
+ *     inotify_dev->lock (protects inotify_device and watches->d_list)
+ */
+
+/*
+ * Lifetimes of the three main data structures -- inotify_device, inode, and
+ * inotify_watch -- are managed by reference count.
+ *
+ * inotify_device: Lifetime is from open until release.  Additional references
+ * can bump the count via get_inotify_dev() and drop the count via
+ * put_inotify_dev().
+ *
+ * inotify_watch: Lifetime is from create_watch() to destory_watch().
+ * Additional references can bump the count via get_inotify_watch() and drop
+ * the count via put_inotify_watch().
+ *
+ * inode: Pinned so long as the inode is associated with a watch, from
+ * create_watch() to put_inotify_watch().
+ */
+
+/*
+ * struct inotify_device - represents an open instance of an inotify device
+ *
+ * This structure is protected by 'lock'.
+ */
+struct inotify_device {
+	wait_queue_head_t 	wq;		/* wait queue for i/o */
+	struct idr		idr;		/* idr mapping wd -> watch */
+	struct list_head 	events;		/* list of queued events */
+	struct list_head	watches;	/* list of watches */
+	spinlock_t		lock;		/* protects this bad boy */
+	atomic_t		count;		/* reference count */
+	struct user_struct	*user;		/* user who opened this dev */
+	unsigned int		queue_size;	/* size of the queue (bytes) */
+	unsigned int		event_count;	/* number of pending events */
+	unsigned int		max_events;	/* maximum number of events */
+};
+
+/*
+ * struct inotify_kernel_event - An intofiy event, originating from a watch and
+ * queued for user-space.  A list of these is attached to each instance of the
+ * device.  In read(), this list is walked and all events that can fit in the
+ * buffer are returned.
+ *
+ * Protected by dev->lock of the device in which we are queued.
+ */
+struct inotify_kernel_event {
+	struct inotify_event	event;	/* the user-space event */
+	struct list_head        list;	/* entry in inotify_device's list */
+	char			*name;	/* filename, if any */
+};
+
+/*
+ * struct inotify_watch - represents a watch request on a specific inode
+ *
+ * d_list is protected by dev->lock of the associated dev->watches.
+ * i_list and mask are protected by inode->inotify_lock of the associated inode.
+ * dev, inode, and wd are never written to once the watch is created.
+ */
+struct inotify_watch {
+	struct list_head	d_list;	/* entry in inotify_device's list */
+	struct list_head	i_list;	/* entry in inode's list */
+	atomic_t		count;	/* reference count */
+	struct inotify_device	*dev;	/* associated device */
+	struct inode		*inode;	/* associated inode */	
+	s32 			wd;	/* watch descriptor */
+	u32			mask;	/* event mask for this watch */
+};
+
+static ssize_t show_max_queued_events(struct class_device *class, char *buf)
+{
+	return sprintf(buf, "%d\n", max_queued_events);
+}
+
+static ssize_t store_max_queued_events(struct class_device *class,
+				       const char *buf, size_t count)
+{
+	unsigned int max;
+
+	if (sscanf(buf, "%u", &max) > 0 && max > 0) {
+		max_queued_events = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
+}
+
+static ssize_t show_max_user_devices(struct class_device *class, char *buf)
+{
+	return sprintf(buf, "%d\n", max_user_devices);
+}
+
+static ssize_t store_max_user_devices(struct class_device *class,
+				      const char *buf, size_t count)
+{
+	int max;
+
+	if (sscanf(buf, "%d", &max) > 0 && max > 0) {
+		max_user_devices = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
+}
+
+static ssize_t show_max_user_watches(struct class_device *class, char *buf)
+{
+	return sprintf(buf, "%d\n", max_user_watches);
+}
+
+static ssize_t store_max_user_watches(struct class_device *class,
+				      const char *buf, size_t count)
+{
+	int max;
+
+	if (sscanf(buf, "%d", &max) > 0 && max > 0) {
+		max_user_watches = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
+}
+
+static CLASS_DEVICE_ATTR(max_queued_events, S_IRUGO | S_IWUSR,
+			 show_max_queued_events, store_max_queued_events);
+static CLASS_DEVICE_ATTR(max_user_devices, S_IRUGO | S_IWUSR,
+			 show_max_user_devices, store_max_user_devices);
+static CLASS_DEVICE_ATTR(max_user_watches, S_IRUGO | S_IWUSR,
+			 show_max_user_watches, store_max_user_watches);
+
+static inline void get_inotify_dev(struct inotify_device *dev)
+{
+	atomic_inc(&dev->count);
+}
+
+static inline void put_inotify_dev(struct inotify_device *dev)
+{
+	if (atomic_dec_and_test(&dev->count)) {
+		atomic_dec(&dev->user->inotify_devs);
+		free_uid(dev->user);		
+		kfree(dev);
+	}
+}
+
+static inline void get_inotify_watch(struct inotify_watch *watch)
+{
+	atomic_inc(&watch->count);
+}
+
+static inline void put_inotify_watch(struct inotify_watch *watch)
+{
+	if (atomic_dec_and_test(&watch->count)) {
+		put_inotify_dev(watch->dev);
+		iput(watch->inode);		
+		kmem_cache_free(watch_cachep, watch);
+	}
+}
+
+/*
+ * kernel_event - create a new kernel event with the given parameters
+ */
+static struct inotify_kernel_event * kernel_event(s32 wd, u32 mask, u32 cookie,
+						  const char *name)
+{
+	struct inotify_kernel_event *kevent;
+
+	/* XXX: optimally, we should use GFP_KERNEL */
+	kevent = kmem_cache_alloc(event_cachep, GFP_ATOMIC);
+	if (unlikely(!kevent))
+		return NULL;
+
+	/* we hand this out to user-space, so zero it just in case */
+	memset(&kevent->event, 0, sizeof(struct inotify_event));
+
+	kevent->event.wd = wd;
+	kevent->event.mask = mask;
+	kevent->event.cookie = cookie;
+
+	INIT_LIST_HEAD(&kevent->list);
+
+	if (name) {
+		size_t len, rem, event_size = sizeof(struct inotify_event);
+
+		/*
+		 * We need to pad the filename so as to properly align an
+		 * array of inotify_event structures.  Because the structure is
+		 * small and the common case is a small filename, we just round
+		 * up to the next multiple of the structure's sizeof.  This is
+		 * simple and safe for all architectures.
+		 */
+		len = strlen(name) + 1;
+		rem = event_size - len;
+		if (len > event_size) {
+			rem = event_size - (len % event_size);
+			if (len % event_size == 0)
+				rem = 0;
+		}
+		len += rem;
+
+		/* XXX: optimally, we should use GFP_KERNEL */
+		kevent->name = kmalloc(len, GFP_ATOMIC);
+		if (unlikely(!kevent->name)) {
+			kmem_cache_free(event_cachep, kevent);
+			return NULL;
+		}
+		memset(kevent->name, 0, len);
+		strncpy(kevent->name, name, strlen(name));
+		kevent->event.len = len;
+	} else {
+		kevent->event.len = 0;
+		kevent->name = NULL;
+	}
+
+	return kevent;
+}
+
+/*
+ * inotify_dev_get_event - return the next event in the given dev's queue
+ *
+ * Caller must hold dev->lock.
+ */
+static inline struct inotify_kernel_event *
+inotify_dev_get_event(struct inotify_device *dev)
+{
+	return list_entry(dev->events.next, struct inotify_kernel_event, list);
+}
+
+/*
+ * inotify_dev_queue_event - add a new event to the given device
+ *
+ * Caller must hold dev->lock.
+ */
+static void inotify_dev_queue_event(struct inotify_device *dev,
+				    struct inotify_watch *watch, u32 mask,
+				    u32 cookie, const char *name)
+{
+	struct inotify_kernel_event *kevent, *last;
+
+	/* coalescing: drop this event if it is a dupe of the previous */
+	last = inotify_dev_get_event(dev);
+	if (dev->event_count && last->event.mask == mask &&
+			last->event.wd == watch->wd) {
+		const char *lastname = last->name;
+
+		if (!name && !lastname)
+			return;
+		if (name && lastname && !strcmp(lastname, name))
+			return;
+	}
+
+	/*
+	 * The queue has already overflowed and we have already sent the
+	 * Q_OVERFLOW event.
+	 */
+	if (unlikely(dev->event_count > dev->max_events))
+		return;
+
+	/* if the queue overflows, we need to notify user space */
+	if (unlikely(dev->event_count == dev->max_events))
+		kevent = kernel_event(-1, IN_Q_OVERFLOW, cookie, NULL);
+	else
+		kevent = kernel_event(watch->wd, mask, cookie, name);
+
+	if (unlikely(!kevent))
+		return;
+
+	/* queue the event and wake up anyone waiting */
+	dev->event_count++;
+	dev->queue_size += sizeof(struct inotify_event) + kevent->event.len;
+	list_add_tail(&kevent->list, &dev->events);
+	wake_up_interruptible(&dev->wq);
+}
+
+static inline int inotify_dev_has_events(struct inotify_device *dev)
+{
+	return !list_empty(&dev->events);
+}
+
+/*
+ * remove_kevent - cleans up and ultimately frees the given kevent
+ */
+static void remove_kevent(struct inotify_device *dev,
+			  struct inotify_kernel_event *kevent)
+{
+	BUG_ON(!dev);
+	BUG_ON(!kevent);
+
+	list_del(&kevent->list);
+
+	dev->event_count--;
+	dev->queue_size -= sizeof(struct inotify_event) + kevent->event.len;	
+
+	if (kevent->name)
+		kfree(kevent->name);
+	kmem_cache_free(event_cachep, kevent);
+}
+
+/*
+ * inotify_dev_event_dequeue - destroy an event on the given device
+ *
+ * Caller must hold dev->lock.
+ */
+static void inotify_dev_event_dequeue(struct inotify_device *dev)
+{
+	if (inotify_dev_has_events(dev)) {
+		struct inotify_kernel_event *kevent;
+		kevent = inotify_dev_get_event(dev);
+		remove_kevent(dev, kevent);
+	}
+}
+
+/*
+ * inotify_dev_get_wd - returns the next WD for use by the given dev
+ *
+ * Grabs dev->lock.  This function can sleep.
+ */
+static int inotify_dev_get_wd(struct inotify_device *dev,
+			     struct inotify_watch *watch)
+{
+	int ret;
+
+repeat:
+	if (unlikely(!idr_pre_get(&dev->idr, GFP_KERNEL)))
+		return -ENOSPC;
+	spin_lock(&dev->lock);
+	ret = idr_get_new(&dev->idr, watch, &watch->wd);
+	spin_unlock(&dev->lock);
+	if (ret == -EAGAIN) /* more memory is required, try again */
+		goto repeat;
+	else if (ret)       /* the idr is full! */
+		return -ENOSPC;
+
+	return 0;
+}
+
+/*
+ * create_watch - creates a watch on the given device.
+ *
+ * Calls inotify_dev_get_wd(), so it both grabs dev->lock and may sleep.
+ * Both 'dev' and 'inode' (by way of nameidata) need to be pinned.
+ */
+static struct inotify_watch *create_watch(struct inotify_device *dev,
+					  u32 mask, struct inode *inode)
+{
+	struct inotify_watch *watch;
+
+	if (atomic_read(&dev->user->inotify_watches) >= max_user_watches)
+		return NULL;
+
+	watch = kmem_cache_alloc(watch_cachep, GFP_KERNEL);
+	if (unlikely(!watch))
+		return NULL;
+
+	if (unlikely(inotify_dev_get_wd(dev, watch))) {
+		kmem_cache_free(watch_cachep, watch);
+		return NULL;
+	}
+
+	watch->mask = mask;
+	atomic_set(&watch->count, 0);
+	INIT_LIST_HEAD(&watch->d_list);
+	INIT_LIST_HEAD(&watch->i_list);
+
+	/* save a reference to device and bump the count to make it official */
+	get_inotify_dev(dev);
+	watch->dev = dev;
+
+	/*
+	 * Save a reference to the inode and bump the ref count to make it
+	 * official.  We hold a reference to nameidata, which makes this safe.
+	 */
+	watch->inode = inode;	
+	spin_lock(&inode_lock);
+	__iget(inode);
+	spin_unlock(&inode_lock);
+
+	/* bump our own count, corresponding to our entry in dev->watches */
+	get_inotify_watch(watch);
+
+	atomic_inc(&dev->user->inotify_watches);	
+
+	return watch;
+}
+
+/*
+ * inotify_find_dev - find the watch associated with the given inode and dev
+ *
+ * Callers must hold inode->inotify_lock.
+ */
+static struct inotify_watch *inode_find_dev(struct inode *inode,
+					    struct inotify_device *dev)
+{
+	struct inotify_watch *watch;
+
+	list_for_each_entry(watch, &inode->inotify_watches, i_list) {
+		if (watch->dev == dev)
+			return watch;
+	}
+
+	return NULL;
+}
+
+/*
+ * inotify_dev_is_watching_inode - is this device watching this inode?
+ *
+ * Requires 'dev' and 'inode' to both be pinned and dev->lock be held.
+ */
+static inline int inotify_dev_is_watching_inode(struct inotify_device *dev,
+						struct inode *inode)
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
+ * remove_watch_no_event - remove_watch() without the IN_IGNORED event.
+ */
+static void remove_watch_no_event(struct inotify_watch *watch,
+				  struct inotify_device *dev)
+{
+	BUG_ON(!dev);
+	BUG_ON(!watch);
+
+	list_del(&watch->i_list);
+	list_del(&watch->d_list);
+
+	atomic_dec(&dev->user->inotify_watches);
+	idr_remove(&dev->idr, watch->wd);
+	put_inotify_watch(watch);
+}
+
+/*
+ * remove_watch - Remove a watch from both the device and the inode.  Sends
+ * the IN_IGNORED event to the given device signifying that the inode is no
+ * longer watched.
+ *
+ * Callers must hold both inode->inotify_lock and dev->lock.  We drop a
+ * reference to the inode before returning.
+ */
+static void remove_watch(struct inotify_watch *watch,
+			 struct inotify_device *dev)
+{
+	inotify_dev_queue_event(dev, watch, IN_IGNORED, 0, NULL);
+	remove_watch_no_event(watch, dev);
+}
+
+/* Kernel API */
+
+/**
+ * inotify_inode_queue_event - queue an event to all watches on this inode
+ * @inode: inode event is originating from
+ * @mask: event mask describing this event
+ * @cookie: cookie for synchronization, or zero
+ * @name: filename, if any
+ */
+void inotify_inode_queue_event(struct inode *inode, u32 mask, u32 cookie,
+			       const char *name)
+{
+	struct inotify_watch *watch;
+
+	spin_lock(&inode->inotify_lock);
+	list_for_each_entry(watch, &inode->inotify_watches, i_list) {
+		if (watch->mask & mask) {
+			struct inotify_device *dev = watch->dev;
+			spin_lock(&dev->lock);
+			inotify_dev_queue_event(dev, watch, mask, cookie, name);
+			spin_unlock(&dev->lock);
+		}
+	}
+	spin_unlock(&inode->inotify_lock);
+}
+EXPORT_SYMBOL_GPL(inotify_inode_queue_event);
+
+/**
+ * inotify_dentry_parent_queue_event - queue an event to a dentry's parent
+ * @dentry: the dentry in question, we queue against this dentry's parent
+ * @mask: event mask describing this event
+ * @cookie: cookie for synchronization, or zero
+ * @name: filename, if any
+ */
+void inotify_dentry_parent_queue_event(struct dentry *dentry, u32 mask,
+				       u32 cookie, const char *name)
+{
+	struct dentry *parent;
+	struct inode *inode;
+
+	spin_lock(&dentry->d_lock);
+	parent = dentry->d_parent;
+	inode = parent->d_inode;
+	if (!list_empty(&inode->inotify_watches)) {
+		dget(parent);
+		spin_unlock(&dentry->d_lock);
+		inotify_inode_queue_event(inode, mask, cookie, name);
+		dput(parent);
+	} else
+		spin_unlock(&dentry->d_lock);
+}
+EXPORT_SYMBOL_GPL(inotify_dentry_parent_queue_event);
+
+/**
+ * inotify_get_cookie - return a unique cookie for use in synchronizing events
+ *
+ * Returns the unique cookie.
+ */
+u32 inotify_get_cookie(void)
+{
+	return atomic_inc_return(&inotify_cookie);
+}
+EXPORT_SYMBOL_GPL(inotify_get_cookie);
+
+/**
+ * inotify_super_block_umount - process watches on an unmounted fs
+ * @sb: the super_block of the filesystem in question
+ */
+void inotify_super_block_umount(struct super_block *sb)
+{
+	struct inode *inode;
+
+	/* Walk the list of inodes and find those on this superblock */
+	spin_lock(&inode_lock);
+	list_for_each_entry(inode, &inode_in_use, i_list) {
+		struct inotify_watch *watch, *next;
+		struct list_head *watches;
+
+		if (inode->i_sb != sb)
+			continue;
+
+		/* for each watch, send IN_UNMOUNT and then remove it */
+		spin_lock(&inode->inotify_lock);
+		watches = &inode->inotify_watches;
+		list_for_each_entry_safe(watch, next, watches, i_list) {
+			struct inotify_device *dev = watch->dev;
+			spin_lock(&dev->lock);
+			inotify_dev_queue_event(dev, watch, IN_UNMOUNT,0,NULL);
+			remove_watch(watch, dev);
+			spin_unlock(&dev->lock);
+		}
+		spin_unlock(&inode->inotify_lock);
+	}
+	spin_unlock(&inode_lock);
+}
+EXPORT_SYMBOL_GPL(inotify_super_block_umount);
+
+/**
+ * inotify_inode_is_dead - an inode has been deleted, cleanup any watches
+ * @inode: inode that is about to be removed
+ */
+void inotify_inode_is_dead(struct inode *inode)
+{
+	struct inotify_watch *watch, *next;
+
+	spin_lock(&inode->inotify_lock);
+	list_for_each_entry_safe(watch, next, &inode->inotify_watches, i_list) {
+		struct inotify_device *dev = watch->dev;
+		spin_lock(&dev->lock);
+		remove_watch(watch, dev);
+		spin_unlock(&dev->lock);
+	}
+	spin_unlock(&inode->inotify_lock);
+}
+EXPORT_SYMBOL_GPL(inotify_inode_is_dead);
+
+/* Device Interface */
+
+static unsigned int inotify_poll(struct file *file, poll_table *wait)
+{
+        struct inotify_device *dev;
+	int ret = 0;
+
+        dev = file->private_data;
+	get_inotify_dev(dev);
+
+	poll_wait(file, &dev->wq, wait);
+	spin_lock(&dev->lock);
+        if (inotify_dev_has_events(dev))
+                ret = POLLIN | POLLRDNORM;
+	spin_unlock(&dev->lock);
+
+	put_inotify_dev(dev);
+        return ret;
+}
+
+static ssize_t inotify_read(struct file *file, char __user *buf,
+			    size_t count, loff_t *pos)
+{
+	size_t event_size;
+	struct inotify_device *dev;
+	char __user *start;
+	int ret;
+	DEFINE_WAIT(wait);
+
+	start = buf;
+	dev = file->private_data;
+
+	/* we only hand out full inotify events */
+	event_size = sizeof(struct inotify_event);
+	if (count < event_size)
+		return 0;
+
+	while (1) {
+		int events;
+
+		prepare_to_wait(&dev->wq, &wait, TASK_INTERRUPTIBLE);
+
+		spin_lock(&dev->lock);
+		events = inotify_dev_has_events(dev);
+		spin_unlock(&dev->lock);
+		if (events) {
+			ret = 0;
+			break;
+		}
+
+		if (file->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
+		schedule();
+	}
+
+	finish_wait(&dev->wq, &wait);
+	if (ret)
+		return ret;
+
+	while (1) {
+		struct inotify_kernel_event *kevent;
+
+		spin_lock(&dev->lock);
+		if (!inotify_dev_has_events(dev)) {
+			spin_unlock(&dev->lock);
+			break;
+		}
+		kevent = inotify_dev_get_event(dev);
+		if (event_size + kevent->event.len > count) {
+			spin_unlock(&dev->lock);
+			break;
+		}
+		list_del_init(&kevent->list);
+		spin_unlock(&dev->lock);
+
+		if (copy_to_user(buf, &kevent->event, event_size)) {
+			/* put the event back on the queue */
+			spin_lock(&dev->lock);
+			list_add(&kevent->list, &dev->events);
+			spin_unlock(&dev->lock);
+			return -EFAULT;
+		}
+		buf += event_size;
+		count -= event_size;
+
+		if (kevent->name) {
+			if (copy_to_user(buf, kevent->name, kevent->event.len)){
+				/* put the event back on the queue */
+				spin_lock(&dev->lock);
+				list_add(&kevent->list, &dev->events);
+				spin_unlock(&dev->lock);
+				return -EFAULT;
+			}
+			buf += kevent->event.len;
+			count -= kevent->event.len;
+		}
+
+		/*
+		 * We made it here, so the event was copied to the user.  It is
+		 * already removed from the event list, just free it.
+		 */
+		spin_lock(&dev->lock);
+		remove_kevent(dev, kevent);
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
+	if (unlikely(atomic_read(&user->inotify_devs) >= max_user_devices)) {
+		ret = -EMFILE;
+		goto out_err;
+	}
+
+	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
+	if (unlikely(!dev)) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	idr_init(&dev->idr);
+	INIT_LIST_HEAD(&dev->events);
+	INIT_LIST_HEAD(&dev->watches);
+	init_waitqueue_head(&dev->wq);
+	spin_lock_init(&dev->lock);
+
+	dev->event_count = 0;
+	dev->queue_size = 0;
+	dev->max_events = max_queued_events;
+	dev->user = user;
+	atomic_set(&dev->count, 0);
+
+	get_inotify_dev(dev);
+	atomic_inc(&current->user->inotify_devs);
+
+	file->private_data = dev;
+
+	return 0;
+out_err:
+	free_uid(current->user);
+	return ret;
+}
+
+static int inotify_release(struct inode *inode, struct file *file)
+{
+	struct inotify_device *dev;	
+
+	dev = file->private_data;
+	BUG_ON(!dev);
+
+	/*
+	 * Destroy all of the watches on this device.  Unfortunately, not very
+	 * pretty.  We cannot do a simple iteration over the list, because we
+	 * do not know the inode until we iterate to the watch.  But we need to
+	 * hold inode->inotify_lock before dev->lock.  The following works.
+	 */
+	while (1) {
+		struct inotify_watch *watch;		
+		struct list_head *watches;
+		struct inode *inode;
+
+		spin_lock(&dev->lock);
+		watches = &dev->watches;
+		if (list_empty(watches)) {
+			spin_unlock(&dev->lock);
+			break;
+		}
+		watch = list_entry(watches->next, struct inotify_watch, d_list);
+		get_inotify_watch(watch);
+		spin_unlock(&dev->lock);
+
+		inode = watch->inode;
+		spin_lock(&inode->inotify_lock);
+		spin_lock(&dev->lock);
+		remove_watch_no_event(watch, dev);
+		spin_unlock(&dev->lock);
+		spin_unlock(&inode->inotify_lock);
+		put_inotify_watch(watch);
+	}
+
+	/* destroy all of the events on this device */
+	spin_lock(&dev->lock);
+	while (inotify_dev_has_events(dev))
+		inotify_dev_event_dequeue(dev);
+	spin_unlock(&dev->lock);
+
+	/* free this device: the put matching the get in inotify_open() */
+	put_inotify_dev(dev);
+
+	return 0;
+}
+
+static int inotify_add_watch(struct inotify_device *dev,
+			     struct inotify_watch_request *request)
+{
+	struct inode *inode;
+	struct inotify_watch *watch, *old;
+	struct nameidata nd;
+	int ret;
+
+	ret = __user_walk(request->name, LOOKUP_FOLLOW, &nd);
+	if (unlikely(ret))
+		return ret;
+
+	/* you can only watch an inode if you have read permissions on it */
+	ret = permission(nd.dentry->d_inode, MAY_READ, NULL);
+	if (unlikely(ret))
+		goto nd_out;
+
+	/* inode is held in place by a reference on nd */
+	inode = nd.dentry->d_inode;
+
+	/*
+	 * Handle the case of re-adding a watch on an (inode,dev) pair that we
+	 * are already watching.  We just update the mask and return its wd.
+	 */
+	spin_lock(&inode->inotify_lock);
+	spin_lock(&dev->lock);	
+	old = inode_find_dev(inode, dev);
+	if (unlikely(old)) {
+		old->mask = request->mask;
+		ret = old->wd;
+		spin_unlock(&dev->lock);		
+		spin_unlock(&inode->inotify_lock);
+		goto nd_out;
+	}
+	spin_unlock(&dev->lock);	
+	spin_unlock(&inode->inotify_lock);
+
+	/*
+	 * We do this lockless, for both scalability and so we can allocate
+	 * with GFP_KERNEL.  But that means we can race here and add this watch
+	 * twice.  We fix up that case below, by again checking for the watch
+	 * after we reacquire the locks.
+	 */
+	watch = create_watch(dev, request->mask, inode);
+	if (unlikely(!watch)) {
+		ret = -ENOSPC;
+		goto nd_out;
+	}
+
+	spin_lock(&inode->inotify_lock);
+	spin_lock(&dev->lock);	
+	old = inode_find_dev(inode, dev);
+	if (unlikely(old)) {
+		/* We raced!  Destroy this watch and return. */
+		put_inotify_watch(watch);
+		ret = -EBUSY;
+	} else {
+		/* Add the watch to the device's and the inode's list */
+		list_add(&watch->d_list, &dev->watches);
+		list_add(&watch->i_list, &inode->inotify_watches);
+		ret = watch->wd;
+	}
+	spin_unlock(&dev->lock);	
+	spin_unlock(&inode->inotify_lock);
+
+nd_out:
+	path_release(&nd);
+
+	return ret;
+}
+
+/*
+ * inotify_ignore - handle the INOTIFY_IGNORE ioctl, asking that a given wd be
+ * removed from the device.
+ */
+static int inotify_ignore(struct inotify_device *dev, s32 wd)
+{
+	struct inotify_watch *watch;
+	struct inode *inode;
+
+	spin_lock(&dev->lock);
+	watch = idr_find(&dev->idr, wd);
+	spin_unlock(&dev->lock);
+
+	if (unlikely(!watch))
+		return -EINVAL;
+
+	inode = watch->inode;
+	spin_lock(&inode->inotify_lock);
+	spin_lock(&dev->lock);
+	remove_watch(watch, dev);
+	spin_unlock(&dev->lock);
+	spin_unlock(&inode->inotify_lock);
+
+	return 0;
+}
+
+static int inotify_ioctl(struct inode *ip, struct file *file, unsigned int cmd,
+			 unsigned long arg)
+{
+	struct inotify_device *dev;
+	struct inotify_watch_request request;
+	void __user *p;
+	int ret = -ENOTTY;
+	s32 wd;
+
+	dev = file->private_data;
+	p = (void __user *) arg;
+
+	get_inotify_dev(dev);
+
+	switch (cmd) {
+	case INOTIFY_WATCH:
+		if (unlikely(copy_from_user(&request, p, sizeof (request)))) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = inotify_add_watch(dev, &request);
+		break;
+	case INOTIFY_IGNORE:
+		if (unlikely(copy_from_user(&wd, p, sizeof (wd)))) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = inotify_ignore(dev, wd);
+		break;
+	case FIONREAD:
+		ret = put_user(dev->queue_size, (int __user *) p);
+		break;
+	}
+
+	put_inotify_dev(dev);
+
+	return ret;
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
+static struct miscdevice inotify_device = {
+	.minor  = MISC_DYNAMIC_MINOR,
+	.name	= "inotify",
+	.fops	= &inotify_fops,
+};
+
+/*
+ * inotify_init - Our initialization function.  Note that we cannnot return
+ * error because we have compiled-in VFS hooks.  So an (unlikely) failure here
+ * must result in panic().
+ */
+static int __init inotify_init(void)
+{
+	struct class_device *class;
+	int ret;
+
+	ret = misc_register(&inotify_device);
+	if (unlikely(ret))
+		panic("inotify: misc_register returned %d\n", ret);
+
+	max_queued_events = 512;
+	max_user_devices = 64;
+	max_user_watches = 16384;
+
+	class = inotify_device.class;
+	class_device_create_file(class, &class_device_attr_max_queued_events);
+	class_device_create_file(class, &class_device_attr_max_user_devices);
+	class_device_create_file(class, &class_device_attr_max_user_watches);
+
+	atomic_set(&inotify_cookie, 0);
+
+	watch_cachep = kmem_cache_create("inotify_watch_cache",
+					 sizeof(struct inotify_watch),
+					 0, SLAB_PANIC, NULL, NULL);
+	event_cachep = kmem_cache_create("inotify_event_cache",
+					 sizeof(struct inotify_kernel_event),
+					 0, SLAB_PANIC, NULL, NULL);
+
+	printk(KERN_INFO "inotify device minor=%d\n", inotify_device.minor);
+
+	return 0;
+}
+
+module_init(inotify_init);
diff -urN linux-2.6.11-mm1/fs/Kconfig linux/fs/Kconfig
--- linux-2.6.11-mm1/fs/Kconfig	2005-03-04 13:23:55.609367088 -0500
+++ linux/fs/Kconfig	2005-03-04 13:27:05.570488608 -0500
@@ -344,6 +344,19 @@
 	  If you don't know whether you need it, then you don't need it:
 	  answer N.
 
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
 config QUOTA
 	bool "Quota support"
 	help
diff -urN linux-2.6.11-mm1/fs/Makefile linux/fs/Makefile
--- linux-2.6.11-mm1/fs/Makefile	2005-03-04 13:23:55.616366024 -0500
+++ linux/fs/Makefile	2005-03-04 13:27:05.571488456 -0500
@@ -11,6 +11,7 @@
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
 
+obj-$(CONFIG_INOTIFY)           += inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
 
diff -urN linux-2.6.11-mm1/fs/namei.c linux/fs/namei.c
--- linux-2.6.11-mm1/fs/namei.c	2005-03-04 14:06:21.750294832 -0500
+++ linux/fs/namei.c	2005-03-04 13:27:05.574488000 -0500
@@ -21,7 +21,7 @@
 #include <linux/namei.h>
 #include <linux/quotaops.h>
 #include <linux/pagemap.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
 #include <linux/security.h>
@@ -1261,7 +1261,7 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_create(dir, dentry, mode);
 	}
 	return error;
@@ -1566,7 +1566,7 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
 	return error;
@@ -1639,7 +1639,7 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_mkdir(dir, dentry->d_name.name);
 		security_inode_post_mkdir(dir,dentry, mode);
 	}
 	return error;
@@ -1729,10 +1729,8 @@
 		}
 	}
 	up(&dentry->d_inode->i_sem);
-	if (!error) {
-		inode_dir_notify(dir, DN_DELETE);
-		d_delete(dentry);
-	}
+	if (!error)
+		fsnotify_rmdir(dentry, dentry->d_inode, dir);
 	dput(dentry);
 
 	return error;
@@ -1802,10 +1800,9 @@
 	up(&dentry->d_inode->i_sem);
 
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
-	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
-		d_delete(dentry);
-		inode_dir_notify(dir, DN_DELETE);
-	}
+	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
+		fsnotify_unlink(dentry->d_inode, dir, dentry);
+
 	return error;
 }
 
@@ -1879,7 +1876,7 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_symlink(dir, dentry, oldname);
 	}
 	return error;
@@ -1952,7 +1949,7 @@
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_create(dir, new_dentry->d_name.name);
 		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
 	return error;
@@ -2116,6 +2113,7 @@
 {
 	int error;
 	int is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
+	char *old_name;
 
 	if (old_dentry->d_inode == new_dentry->d_inode)
  		return 0;
@@ -2137,18 +2135,18 @@
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 
+	old_name = fsnotify_oldname_init(old_dentry);
+
 	if (is_dir)
 		error = vfs_rename_dir(old_dir,old_dentry,new_dir,new_dentry);
 	else
 		error = vfs_rename_other(old_dir,old_dentry,new_dir,new_dentry);
 	if (!error) {
-		if (old_dir == new_dir)
-			inode_dir_notify(old_dir, DN_RENAME);
-		else {
-			inode_dir_notify(old_dir, DN_DELETE);
-			inode_dir_notify(new_dir, DN_CREATE);
-		}
+		const char *new_name = old_dentry->d_name.name;
+		fsnotify_move(old_dir, new_dir, old_name, new_name);
 	}
+	fsnotify_oldname_free(old_name);
+
 	return error;
 }
 
diff -urN linux-2.6.11-mm1/fs/open.c linux/fs/open.c
--- linux-2.6.11-mm1/fs/open.c	2005-03-04 14:06:21.751294680 -0500
+++ linux/fs/open.c	2005-03-04 13:27:05.576487696 -0500
@@ -10,7 +10,7 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
@@ -944,9 +944,14 @@
 		fd = get_unused_fd();
 		if (fd >= 0) {
 			struct file *f = filp_open(tmp, flags, mode);
+			struct dentry *dentry;
+
 			error = PTR_ERR(f);
 			if (IS_ERR(f))
 				goto out_error;
+			dentry = f->f_dentry;
+			fsnotify_open(dentry, dentry->d_inode,
+				      dentry->d_name.name);
 			fd_install(fd, f);
 		}
 out:
@@ -998,7 +1003,7 @@
 			retval = err;
 	}
 
-	dnotify_flush(filp, id);
+	fsnotify_flush(filp, id);
 	locks_remove_posix(filp, id);
 	fput(filp);
 	return retval;
diff -urN linux-2.6.11-mm1/fs/read_write.c linux/fs/read_write.c
--- linux-2.6.11-mm1/fs/read_write.c	2005-03-04 14:06:21.753294376 -0500
+++ linux/fs/read_write.c	2005-03-04 13:27:05.577487544 -0500
@@ -10,7 +10,7 @@
 #include <linux/file.h>
 #include <linux/uio.h>
 #include <linux/smp_lock.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
@@ -239,7 +239,10 @@
 			else
 				ret = do_sync_read(file, buf, count, pos);
 			if (ret > 0) {
-				dnotify_parent(file->f_dentry, DN_ACCESS);
+				struct dentry *dentry = file->f_dentry;
+				struct inode *inode = dentry->d_inode;
+				fsnotify_access(dentry, inode,
+						dentry->d_name.name);
 				current->rchar += ret;
 			}
 			current->syscr++;
@@ -287,7 +290,10 @@
 			else
 				ret = do_sync_write(file, buf, count, pos);
 			if (ret > 0) {
-				dnotify_parent(file->f_dentry, DN_MODIFY);
+				struct dentry *dentry = file->f_dentry;
+				struct inode *inode = dentry->d_inode;
+				fsnotify_modify(dentry, inode,
+						dentry->d_name.name);
 				current->wchar += ret;
 			}
 			current->syscw++;
@@ -523,9 +529,15 @@
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0)
-		dnotify_parent(file->f_dentry,
-				(type == READ) ? DN_ACCESS : DN_MODIFY);
+	if ((ret + (type == READ)) > 0) {
+		struct dentry *dentry = file->f_dentry;
+		struct inode *inode = dentry->d_inode;
+
+		if (type == READ)
+			fsnotify_access(dentry, inode, dentry->d_name.name);
+		else
+			fsnotify_modify(dentry, inode, dentry->d_name.name);
+	}
 	return ret;
 Efault:
 	ret = -EFAULT;
diff -urN linux-2.6.11-mm1/fs/super.c linux/fs/super.c
--- linux-2.6.11-mm1/fs/super.c	2005-03-04 14:06:21.754294224 -0500
+++ linux/fs/super.c	2005-03-04 13:27:05.578487392 -0500
@@ -36,6 +36,7 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
+#include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <asm/uaccess.h>
 
@@ -229,6 +230,7 @@
 
 	if (root) {
 		sb->s_root = NULL;
+		fsnotify_sb_umount(sb);
 		shrink_dcache_parent(root);
 		shrink_dcache_anon(&sb->s_anon);
 		dput(root);
diff -urN linux-2.6.11-mm1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.6.11-mm1/include/linux/fs.h	2005-03-04 14:06:21.755294072 -0500
+++ linux/include/linux/fs.h	2005-03-04 13:27:05.581486936 -0500
@@ -223,6 +223,7 @@
 struct kstatfs;
 struct vm_area_struct;
 struct vfsmount;
+struct inotify_inode_data;
 
 /* Used to be a macro which just called the function, now just a function */
 extern void update_atime (struct inode *);
@@ -473,6 +474,11 @@
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 #endif
 
+#ifdef CONFIG_INOTIFY
+	struct list_head	inotify_watches;  /* watches on this inode */
+	spinlock_t		inotify_lock;  /* protects the watches list */
+#endif
+
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
@@ -1368,7 +1374,7 @@
 extern int do_remount_sb(struct super_block *sb, int flags,
 			 void *data, int force);
 extern sector_t bmap(struct inode *, sector_t);
-extern int setattr_mask(unsigned int);
+extern void setattr_mask(unsigned int, int *, u32 *);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int, struct nameidata *);
 extern int generic_permission(struct inode *, int,
diff -urN linux-2.6.11-mm1/include/linux/fsnotify.h linux/include/linux/fsnotify.h
--- linux-2.6.11-mm1/include/linux/fsnotify.h	1969-12-31 19:00:00.000000000 -0500
+++ linux/include/linux/fsnotify.h	2005-03-04 13:27:05.583486632 -0500
@@ -0,0 +1,235 @@
+#ifndef _LINUX_FS_NOTIFY_H
+#define _LINUX_FS_NOTIFY_H
+
+/*
+ * include/linux/fs_notify.h - generic hooks for filesystem notification, to
+ * reduce in-source duplication from both dnotify and inotify.
+ *
+ * We don't compile any of this away in some complicated menagerie of ifdefs.
+ * Instead, we rely on the code inside to optimize away as needed.
+ *
+ * (C) Copyright 2005 Robert Love
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/dnotify.h>
+#include <linux/inotify.h>
+
+/*
+ * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
+ */
+static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
+				 const char *old_name, const char *new_name)
+{
+	u32 cookie;
+
+	if (old_dir == new_dir)
+		inode_dir_notify(old_dir, DN_RENAME);
+	else {
+		inode_dir_notify(old_dir, DN_DELETE);
+		inode_dir_notify(new_dir, DN_CREATE);
+	}
+
+	cookie = inotify_get_cookie();
+
+	inotify_inode_queue_event(old_dir, IN_MOVED_FROM, cookie, old_name);
+	inotify_inode_queue_event(new_dir, IN_MOVED_TO, cookie, new_name);
+}
+
+/*
+ * fsnotify_unlink - file was unlinked
+ */
+static inline void fsnotify_unlink(struct inode *inode, struct inode *dir,
+				   struct dentry *dentry)
+{
+	inode_dir_notify(dir, DN_DELETE);
+	inotify_inode_queue_event(dir, IN_DELETE_FILE, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
+
+	inotify_inode_is_dead(inode);
+	d_delete(dentry);
+}
+
+/*
+ * fsnotify_rmdir - directory was removed
+ */
+static inline void fsnotify_rmdir(struct dentry *dentry, struct inode *inode,
+				  struct inode *dir)
+{
+	inode_dir_notify(dir, DN_DELETE);
+	inotify_inode_queue_event(dir, IN_DELETE_SUBDIR,0,dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
+
+	inotify_inode_is_dead(inode);
+	d_delete(dentry);
+}
+
+/*
+ * fsnotify_create - filename was linked in
+ */
+static inline void fsnotify_create(struct inode *inode, const char *filename)
+{
+	inode_dir_notify(inode, DN_CREATE);
+	inotify_inode_queue_event(inode, IN_CREATE_FILE, 0, filename);
+}
+
+/*
+ * fsnotify_mkdir - directory 'name' was created
+ */
+static inline void fsnotify_mkdir(struct inode *inode, const char *name)
+{
+	inode_dir_notify(inode, DN_CREATE);
+	inotify_inode_queue_event(inode, IN_CREATE_SUBDIR, 0, name);
+}
+
+/*
+ * fsnotify_access - file was read
+ */
+static inline void fsnotify_access(struct dentry *dentry, struct inode *inode,
+				   const char *filename)
+{
+	dnotify_parent(dentry, DN_ACCESS);
+	inotify_dentry_parent_queue_event(dentry, IN_ACCESS, 0,
+					  dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_ACCESS, 0, NULL);
+}
+
+/*
+ * fsnotify_modify - file was modified
+ */
+static inline void fsnotify_modify(struct dentry *dentry, struct inode *inode,
+				   const char *filename)
+{
+	dnotify_parent(dentry, DN_MODIFY);
+	inotify_dentry_parent_queue_event(dentry, IN_MODIFY, 0, filename);
+	inotify_inode_queue_event(inode, IN_MODIFY, 0, NULL);
+}
+
+/*
+ * fsnotify_open - file was opened
+ */
+static inline void fsnotify_open(struct dentry *dentry, struct inode *inode,
+				 const char *filename)
+{
+	inotify_inode_queue_event(inode, IN_OPEN, 0, NULL);
+	inotify_dentry_parent_queue_event(dentry, IN_OPEN, 0, filename);
+}
+
+/*
+ * fsnotify_close - file was closed
+ */
+static inline void fsnotify_close(struct dentry *dentry, struct inode *inode,
+				  mode_t mode, const char *filename)
+{
+	u32 mask;
+
+	mask = (mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
+	inotify_dentry_parent_queue_event(dentry, mask, 0, filename);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+}
+
+/*
+ * fsnotify_change - notify_change event.  file was modified and/or metadata
+ * was changed.
+ */
+static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
+{
+	int dn_mask = 0;
+	u32 in_mask = 0;
+
+	if (ia_valid & ATTR_UID) {
+		in_mask |= IN_ATTRIB;
+		dn_mask |= DN_ATTRIB;
+	}
+	if (ia_valid & ATTR_GID) {
+		in_mask |= IN_ATTRIB;
+		dn_mask |= DN_ATTRIB;
+	}
+	if (ia_valid & ATTR_SIZE) {
+		in_mask |= IN_MODIFY;
+		dn_mask |= DN_MODIFY;
+	}
+	/* both times implies a utime(s) call */
+	if ((ia_valid & (ATTR_ATIME | ATTR_MTIME)) == (ATTR_ATIME | ATTR_MTIME))
+	{
+		in_mask |= IN_ATTRIB;
+		dn_mask |= DN_ATTRIB;
+	} else if (ia_valid & ATTR_ATIME) {
+		in_mask |= IN_ACCESS;
+		dn_mask |= DN_ACCESS;
+	} else if (ia_valid & ATTR_MTIME) {
+		in_mask |= IN_MODIFY;
+		dn_mask |= DN_MODIFY;
+	}
+	if (ia_valid & ATTR_MODE) {
+		in_mask |= IN_ATTRIB;
+		dn_mask |= DN_ATTRIB;
+	}
+
+	if (dn_mask)
+		dnotify_parent(dentry, dn_mask);
+	if (in_mask) {
+		inotify_inode_queue_event(dentry->d_inode, in_mask, 0, NULL);
+		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
+						  dentry->d_name.name);
+	}
+}
+
+/*
+ * fsnotify_sb_umount - filesystem unmount
+ */
+static inline void fsnotify_sb_umount(struct super_block *sb)
+{
+	inotify_super_block_umount(sb);
+}
+
+/*
+ * fsnotify_flush - flush time!
+ */
+static inline void fsnotify_flush(struct file *filp, fl_owner_t id)
+{
+	dnotify_flush(filp, id);
+}
+
+#ifdef CONFIG_INOTIFY	/* inotify helpers */
+
+/*
+ * fsnotify_oldname_init - save off the old filename before we change it
+ *
+ * this could be kstrdup if only we could add that to lib/string.c
+ */
+static inline char *fsnotify_oldname_init(struct dentry *old_dentry)
+{
+	char *old_name;
+
+	old_name = kmalloc(strlen(old_dentry->d_name.name) + 1, GFP_KERNEL);
+	if (old_name)
+		strcpy(old_name, old_dentry->d_name.name);
+	return old_name;
+}
+
+/*
+ * fsnotify_oldname_free - free the name we got from fsnotify_oldname_init
+ */
+static inline void fsnotify_oldname_free(const char *old_name)
+{
+	kfree(old_name);
+}
+
+#else	/* CONFIG_INOTIFY */
+
+static inline char *fsnotify_oldname_init(struct dentry *old_dentry)
+{
+	return NULL;
+}
+
+static inline void fsnotify_oldname_free(const char *old_name)
+{
+}
+
+#endif	/* ! CONFIG_INOTIFY */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_FS_NOTIFY_H */
diff -urN linux-2.6.11-mm1/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-2.6.11-mm1/include/linux/inotify.h	1969-12-31 19:00:00.000000000 -0500
+++ linux/include/linux/inotify.h	2005-03-04 13:27:05.584486480 -0500
@@ -0,0 +1,113 @@
+/*
+ * Inode based directory notification for Linux
+ *
+ * Copyright (C) 2005 John McCutchan
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
+ * such as IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, ..., relative to the wd.
+ */
+struct inotify_event {
+	__s32		wd;		/* watch descriptor */
+	__u32		mask;		/* watch mask */
+	__u32		cookie;		/* cookie to synchronize two events */
+	size_t		len;		/* length (including nulls) of name */
+	char		name[0];	/* stub for possible name */
+};
+
+/*
+ * struct inotify_watch_request - represents a watch request
+ *
+ * Pass to the inotify device via the INOTIFY_WATCH ioctl
+ */
+struct inotify_watch_request {
+	char		*name;		/* filename name */
+	__u32		mask;		/* event mask */
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
+#include <asm/atomic.h>
+
+#ifdef CONFIG_INOTIFY
+
+extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
+				      const char *);
+extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
+					      const char *);
+extern void inotify_super_block_umount(struct super_block *);
+extern void inotify_inode_is_dead(struct inode *);
+extern u32 inotify_get_cookie(void);
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
+static inline u32 inotify_get_cookie(void)
+{
+	return 0;
+}
+
+#endif	/* CONFIG_INOTIFY */
+
+#endif	/* __KERNEL __ */
+
+#endif	/* _LINUX_INOTIFY_H */
diff -urN linux-2.6.11-mm1/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.6.11-mm1/include/linux/sched.h	2005-03-04 14:06:21.766292400 -0500
+++ linux/include/linux/sched.h	2005-03-04 13:27:05.586486176 -0500
@@ -411,6 +411,8 @@
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
+	atomic_t inotify_watches;	/* How many inotify watches does this user have? */
+	atomic_t inotify_devs;	/* How many inotify devs does this user have opened? */
 	/* protected by mq_lock	*/
 	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
 	unsigned long locked_shm; /* How many pages of mlocked shm ? */
diff -urN linux-2.6.11-mm1/kernel/user.c linux/kernel/user.c
--- linux-2.6.11-mm1/kernel/user.c	2005-03-04 14:06:21.766292400 -0500
+++ linux/kernel/user.c	2005-03-04 13:27:05.588485872 -0500
@@ -120,6 +120,8 @@
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
 		atomic_set(&new->sigpending, 0);
+		atomic_set(&new->inotify_watches, 0);
+		atomic_set(&new->inotify_devs, 0);
 
 		new->mq_bytes = 0;
 		new->locked_shm = 0;


