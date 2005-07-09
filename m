Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbVGIBdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVGIBdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGIBdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 21:33:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263004AbVGIBbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 21:31:10 -0400
Date: Fri, 8 Jul 2005 18:28:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: Robert Love <rml@novell.com>, ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       David Woodhouse <dwmw2@infradead.org>,
       "Timothy R. Chavez" <tinytim@us.ibm.com>
Subject: [RFC/PATCH 2/2] inotify
Message-ID: <20050709012839.GF19052@shell0.pdx.osdl.net>
References: <20050709012436.GD19052@shell0.pdx.osdl.net> <20050709012657.GE19052@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709012657.GE19052@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


inotify

 Documentation/filesystems/inotify.txt |  155 +++++
 fs/Kconfig                            |   13 
 fs/Makefile                           |    1 
 fs/inode.c                            |    6 
 fs/inotify.c                          | 1011 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h                    |    5 
 include/linux/fsnotify.h              |   34 +
 include/linux/inotify.h               |  301 ++++++++++
 include/linux/sched.h                 |    4 
 kernel/user.c                         |    4 
 10 files changed, 1534 insertions(+)

Index: linux-2.6.13-rc2-fsnotify-2/Documentation/filesystems/inotify.txt
===================================================================
--- /dev/null
+++ linux-2.6.13-rc2-fsnotify-2/Documentation/filesystems/inotify.txt
@@ -0,0 +1,155 @@
+				    inotify
+	     a powerful yet simple file change notification system
+
+
+
+Document started 15 Mar 2005 by Robert Love <rml@novell.com>
+
+(i) User Interface
+
+Inotify is controlled by a device node, /dev/inotify.  If you do not use udev,
+this device may need to be created manually.
+
+First step in using inotify is to open the device file:
+
+	int dev_fd = open ("/dev/inotify", O_RDONLY);
+
+Change events are managed by "watches".  A watch is an (object,mask) pair where
+the object is a file or directory and the mask is a bitmask of one or more
+inotify events that the application wishes to receive.  See <linux/inotify.h>
+for valid events.  A watch is referenced by a watch descriptor, or wd.
+
+Watches are added via a file descriptor to the file.
+
+Watches on a directory will return events on any files inside of the directory.
+
+Adding a watch is simple,
+
+	/* 'wd' represents the watch on fd with mask */
+	struct inotify_request req = { fd, mask };
+	int wd = ioctl (dev_fd, INOTIFY_WATCH, &req);
+
+You can add a large number of files via something like
+
+	for each file to watch {
+		struct inotify_request req;
+		int file_fd;
+
+		file_fd = open (file, O_RDONLY);
+		if (fd < 0) {
+			perror ("open");
+			break;
+		}
+
+		req.fd = file_fd;
+		req.mask = mask;
+
+		wd = ioctl (dev_fd, INOTIFY_WATCH, &req);
+
+		close (fd);
+	}
+
+You can update an existing watch in the same manner, by passing in a new mask.
+
+An existing watch is removed via the INOTIFY_IGNORE ioctl, for example
+
+	ioctl (dev_fd, INOTIFY_IGNORE, wd);
+
+Events are provided in the form of an inotify_event structure that is read(2)
+from /dev/inotify.  The filename is of dynamic length and follows the struct.
+It is of size len.  The filename is padded with null bytes to ensure proper
+alignment.  This padding is reflected in len.
+
+You can slurp multiple events by passing a large buffer, for example
+
+	size_t len = read (fd, buf, BUF_LEN);
+
+Will return as many events as are available and fit in BUF_LEN.
+
+/dev/inotify is also select()- and poll()-able.
+
+You can find the size of the current event queue via the FIONREAD ioctl.
+
+All watches are destroyed and cleaned up on close.
+
+
+(ii) Internal Kernel Implementation
+
+Each open inotify device is associated with an inotify_device structure.
+
+Each watch is associated with an inotify_watch structure.  Watches are chained
+off of each associated device and each associated inode.
+
+See fs/inotify.c for the locking and lifetime rules.
+
+
+(iii) Rationale
+
+Q: What is the design decision behind not tying the watch to the open fd of
+   the watched object?
+
+A: Watches are associated with an open inotify device, not an open file.
+   This solves the primary problem with dnotify: keeping the file open pins
+   the file and thus, worse, pins the mount.  Dnotify is therefore infeasible
+   for use on a desktop system with removable media as the media cannot be
+   unmounted.
+
+Q: What is the design decision behind using an-fd-per-device as opposed to
+   an fd-per-watch?
+
+A: An fd-per-watch quickly consumes more file descriptors than are allowed,
+   more fd's than are feasible to manage, and more fd's than are optimally
+   select()-able.  Yes, root can bump the per-process fd limit and yes, users
+   can use epoll, but requiring both is a silly and extraneous requirement.
+   A watch consumes less memory than an open file, separating the number
+   spaces is thus sensible.  The current design is what user-space developers
+   want: Users open the device, once, and add n watches, requiring but one fd
+   and no twiddling with fd limits.  Opening /dev/inotify two thousand times
+   is silly.  If we can implement user-space's preferences cleanly--and we
+   can, the idr layer makes stuff like this trivial--then we should.
+
+   There are other good arguments.  With a single fd, there is a single
+   item to block on, which is mapped to a single queue of events.  The single
+   fd returns all watch events and also any potential out-of-band data.  If
+   every fd was a separate watch,
+
+   - There would be no way to get event ordering.  Events on file foo and
+     file bar would pop poll() on both fd's, but there would be no way to tell
+     which happened first.  A single queue trivially gives you ordering.  Such
+     ordering is crucial to existing applications such as Beagle.  Imagine
+     "mv a b ; mv b a" events without ordering.
+
+   - We'd have to maintain n fd's and n internal queues with state,
+     versus just one.  It is a lot messier in the kernel.  A single, linear
+     queue is the data structure that makes sense.
+
+   - User-space developers prefer the current API.  The Beagle guys, for
+     example, love it.  Trust me, I asked.  It is not a surprise: Who'd want
+     to manage and block on 1000 fd's via select?
+
+   - You'd have to manage the fd's, as an example: Call close() when you
+     received a delete event.
+
+   - No way to get out of band data.
+
+   - 1024 is still too low.  ;-)
+
+   When you talk about designing a file change notification system that
+   scales to 1000s of directories, juggling 1000s of fd's just does not seem
+   the right interface.  It is too heavy.
+
+Q: Why a device node?
+
+A: The poor user-space interface is the second biggest problem with dnotify.
+   Signals are a terrible, terrible interface for file notification.  Or for
+   anything, for that matter.  The idea solution, from all perspectives, is a
+   file descriptor-based one that allows basic file I/O and poll/select.
+   Obtaining the fd and managing the watches could have been done either via a
+   device file or a family of new system calls.  We decided to implement a
+   device file because adding three or four new system calls that mirrored
+   open, close, and ioctl seemed silly.  A character device makes sense from
+   user-space and was easy to implement inside of the kernel.
+
+   Additionally, it _is_ possible to open /dev/inotify more than once and
+   juggle more than one queue and thus more than one associated fd.
+
Index: linux-2.6.13-rc2-fsnotify-2/fs/inode.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/inode.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/pagemap.h>
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
+#include <linux/inotify.h>
 
 /*
  * This is needed for the following functions:
@@ -202,6 +203,10 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
+#ifdef CONFIG_INOTIFY
+	INIT_LIST_HEAD(&inode->inotify_watches);
+	sema_init(&inode->inotify_sem, 1);
+#endif
 }
 
 EXPORT_SYMBOL(inode_init_once);
@@ -346,6 +351,7 @@ int invalidate_inodes(struct super_block
 
 	down(&iprune_sem);
 	spin_lock(&inode_lock);
+	inotify_unmount_inodes(&sb->s_inodes);
 	busy = invalidate_list(&sb->s_inodes, &throw_away);
 	spin_unlock(&inode_lock);
 
Index: linux-2.6.13-rc2-fsnotify-2/fs/inotify.c
===================================================================
--- /dev/null
+++ linux-2.6.13-rc2-fsnotify-2/fs/inotify.c
@@ -0,0 +1,1011 @@
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
+#include <linux/file.h>
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
+ * dentry->d_lock (used to keep d_move() away from dentry->d_parent)
+ * iprune_sem (synchronize shrink_icache_memory())
+ * 	inode_lock (protects the super_block->s_inodes list)
+ * 	inode->inotify_sem (protects inode->inotify_watches and watches->i_list)
+ * 		inotify_dev->sem (protects inotify_device and watches->d_list)
+ */
+
+/*
+ * Lifetimes of the three main data structures--inotify_device, inode, and
+ * inotify_watch--are managed by reference count.
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
+ * This structure is protected by the semaphore 'sem'.
+ */
+struct inotify_device {
+	wait_queue_head_t 	wq;		/* wait queue for i/o */
+	struct idr		idr;		/* idr mapping wd -> watch */
+	struct semaphore	sem;		/* protects this bad boy */
+	struct list_head 	events;		/* list of queued events */
+	struct list_head	watches;	/* list of watches */
+	atomic_t		count;		/* reference count */
+	struct user_struct	*user;		/* user who opened this dev */
+	unsigned int		queue_size;	/* size of the queue (bytes) */
+	unsigned int		event_count;	/* number of pending events */
+	unsigned int		max_events;	/* maximum number of events */
+};
+
+/*
+ * struct inotify_kernel_event - An inotify event, originating from a watch and
+ * queued for user-space.  A list of these is attached to each instance of the
+ * device.  In read(), this list is walked and all events that can fit in the
+ * buffer are returned.
+ *
+ * Protected by dev->sem of the device in which we are queued.
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
+ * d_list is protected by dev->sem of the associated watch->dev.
+ * i_list and mask are protected by inode->inotify_sem of the associated inode.
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
+/*
+ * put_inotify_watch - decrements the ref count on a given watch.  cleans up
+ * the watch and its references if the count reaches zero.
+ */
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
+ *
+ * This function can sleep.
+ */
+static struct inotify_kernel_event * kernel_event(s32 wd, u32 mask, u32 cookie,
+						  const char *name)
+{
+	struct inotify_kernel_event *kevent;
+
+	kevent = kmem_cache_alloc(event_cachep, GFP_KERNEL);
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
+
+		kevent->name = kmalloc(len + rem, GFP_KERNEL);
+		if (unlikely(!kevent->name)) {
+			kmem_cache_free(event_cachep, kevent);
+			return NULL;
+		}
+		memcpy(kevent->name, name, len);
+		if (rem)
+			memset(kevent->name + len, 0, rem);
+		kevent->event.len = len + rem;
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
+ * Caller must hold dev->sem.
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
+ * Caller must hold dev->sem.  Can sleep (calls kernel_event()).
+ */
+static void inotify_dev_queue_event(struct inotify_device *dev,
+				    struct inotify_watch *watch, u32 mask,
+				    u32 cookie, const char *name)
+{
+	struct inotify_kernel_event *kevent, *last;
+
+	/* coalescing: drop this event if it is a dupe of the previous */
+	last = inotify_dev_get_event(dev);
+	if (last && last->event.mask == mask && last->event.wd == watch->wd &&
+			last->event.cookie == cookie) {
+		const char *lastname = last->name;
+
+		if (!name && !lastname)
+			return;
+		if (name && lastname && !strcmp(lastname, name))
+			return;
+	}
+
+	/* the queue overflowed and we already sent the Q_OVERFLOW event */
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
+/*
+ * remove_kevent - cleans up and ultimately frees the given kevent
+ *
+ * Caller must hold dev->sem.
+ */
+static void remove_kevent(struct inotify_device *dev,
+			  struct inotify_kernel_event *kevent)
+{
+	list_del(&kevent->list);
+
+	dev->event_count--;
+	dev->queue_size -= sizeof(struct inotify_event) + kevent->event.len;
+
+	kfree(kevent->name);
+	kmem_cache_free(event_cachep, kevent);
+}
+
+/*
+ * inotify_dev_event_dequeue - destroy an event on the given device
+ *
+ * Caller must hold dev->sem.
+ */
+static void inotify_dev_event_dequeue(struct inotify_device *dev)
+{
+	if (!list_empty(&dev->events)) {
+		struct inotify_kernel_event *kevent;
+		kevent = inotify_dev_get_event(dev);
+		remove_kevent(dev, kevent);
+	}
+}
+
+/*
+ * inotify_dev_get_wd - returns the next WD for use by the given dev
+ *
+ * Callers must hold dev->sem.  This function can sleep.
+ */
+static int inotify_dev_get_wd(struct inotify_device *dev,
+			      struct inotify_watch *watch)
+{
+	int ret;
+
+	do {
+		if (unlikely(!idr_pre_get(&dev->idr, GFP_KERNEL)))
+			return -ENOSPC;
+		ret = idr_get_new(&dev->idr, watch, &watch->wd);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
+/*
+ * create_watch - creates a watch on the given device.
+ *
+ * Callers must hold dev->sem.  Calls inotify_dev_get_wd() so may sleep.
+ * Both 'dev' and 'inode' (by way of nameidata) need to be pinned.
+ */
+static struct inotify_watch *create_watch(struct inotify_device *dev,
+					  u32 mask, struct inode *inode)
+{
+	struct inotify_watch *watch;
+	int ret;
+
+	if (atomic_read(&dev->user->inotify_watches) >= max_user_watches)
+		return ERR_PTR(-ENOSPC);
+
+	watch = kmem_cache_alloc(watch_cachep, GFP_KERNEL);
+	if (unlikely(!watch))
+		return ERR_PTR(-ENOMEM);
+
+	ret = inotify_dev_get_wd(dev, watch);
+	if (unlikely(ret)) {
+		kmem_cache_free(watch_cachep, watch);
+		return ERR_PTR(ret);
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
+	watch->inode = igrab(inode);
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
+ * Callers must hold inode->inotify_sem.
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
+ * remove_watch_no_event - remove_watch() without the IN_IGNORED event.
+ */
+static void remove_watch_no_event(struct inotify_watch *watch,
+				  struct inotify_device *dev)
+{
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
+ * Callers must hold both inode->inotify_sem and dev->sem.  We drop a
+ * reference to the inode before returning.
+ *
+ * The inode is not iput() so as to remain atomic.  If the inode needs to be
+ * iput(), the call returns one.  Otherwise, it returns zero.
+ */
+static void remove_watch(struct inotify_watch *watch,struct inotify_device *dev)
+{
+	inotify_dev_queue_event(dev, watch, IN_IGNORED, 0, NULL);
+	remove_watch_no_event(watch, dev);
+}
+
+/*
+ * inotify_inode_watched - returns nonzero if there are watches on this inode
+ * and zero otherwise.  We call this lockless, we do not care if we race.
+ */
+static inline int inotify_inode_watched(struct inode *inode)
+{
+	return !list_empty(&inode->inotify_watches);
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
+	struct inotify_watch *watch, *next;
+
+	if (!inotify_inode_watched(inode))
+		return;
+
+	down(&inode->inotify_sem);
+	list_for_each_entry_safe(watch, next, &inode->inotify_watches, i_list) {
+		u32 watch_mask = watch->mask;
+		if (watch_mask & mask) {
+			struct inotify_device *dev = watch->dev;
+			get_inotify_watch(watch);
+			down(&dev->sem);
+			inotify_dev_queue_event(dev, watch, mask, cookie, name);
+			if (watch_mask & IN_ONESHOT)
+				remove_watch_no_event(watch, dev);
+			up(&dev->sem);
+			put_inotify_watch(watch);
+		}
+	}
+	up(&inode->inotify_sem);
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
+
+	if (inotify_inode_watched(inode)) {
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
+ * inotify_get_cookie - return a unique cookie for use in synchronizing events.
+ */
+u32 inotify_get_cookie(void)
+{
+	return atomic_inc_return(&inotify_cookie);
+}
+EXPORT_SYMBOL_GPL(inotify_get_cookie);
+
+/**
+ * inotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
+ * @list: list of inodes being unmounted (sb->s_inodes)
+ *
+ * Called with inode_lock held, protecting the unmounting super block's list
+ * of inodes, and with iprune_sem held, keeping shrink_icache_memory() at bay.
+ * We temporarily drop inode_lock, however, and CAN block.
+ */
+void inotify_unmount_inodes(struct list_head *list)
+{
+	struct inode *inode, *next_i, *need_iput = NULL;
+
+	list_for_each_entry_safe(inode, next_i, list, i_sb_list) {
+		struct inotify_watch *watch, *next_w;
+		struct inode *need_iput_tmp;
+		struct list_head *watches;
+
+		/*
+		 * If i_count is zero, the inode cannot have any watches and
+		 * doing an __iget/iput with MS_ACTIVE clear would actually
+		 * evict all inodes with zero i_count from icache which is
+		 * unnecessarily violent and may in fact be illegal to do.
+		 */
+		if (!atomic_read(&inode->i_count))
+			continue;
+
+		/*
+		 * We cannot __iget() an inode in state I_CLEAR, I_FREEING, or
+		 * I_WILL_FREE which is fine because by that point the inode
+		 * cannot have any associated watches.
+		 */
+		if (inode->i_state & (I_CLEAR | I_FREEING | I_WILL_FREE))
+			continue;
+
+		need_iput_tmp = need_iput;
+		need_iput = NULL;
+		/* In case the remove_watch() drops a reference. */
+		if (inode != need_iput_tmp)
+			__iget(inode);
+		else
+			need_iput_tmp = NULL;
+		/* In case the dropping of a reference would nuke next_i. */
+		if ((&next_i->i_sb_list != list) &&
+				atomic_read(&next_i->i_count) &&
+				!(next_i->i_state & (I_CLEAR | I_FREEING |
+					I_WILL_FREE))) {
+			__iget(next_i);
+			need_iput = next_i;
+		}
+
+		/*
+		 * We can safely drop inode_lock here because we hold
+		 * references on both inode and next_i.  Also no new inodes
+		 * will be added since the umount has begun.  Finally,
+		 * iprune_sem keeps shrink_icache_memory() away.
+		 */
+		spin_unlock(&inode_lock);
+
+		if (need_iput_tmp)
+			iput(need_iput_tmp);
+
+		/* for each watch, send IN_UNMOUNT and then remove it */
+		down(&inode->inotify_sem);
+		watches = &inode->inotify_watches;
+		list_for_each_entry_safe(watch, next_w, watches, i_list) {
+			struct inotify_device *dev = watch->dev;
+			down(&dev->sem);
+			inotify_dev_queue_event(dev, watch, IN_UNMOUNT,0,NULL);
+			remove_watch(watch, dev);
+			up(&dev->sem);
+		}
+		up(&inode->inotify_sem);
+		iput(inode);
+
+		spin_lock(&inode_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(inotify_unmount_inodes);
+
+/**
+ * inotify_inode_is_dead - an inode has been deleted, cleanup any watches
+ * @inode: inode that is about to be removed
+ */
+void inotify_inode_is_dead(struct inode *inode)
+{
+	struct inotify_watch *watch, *next;
+
+	down(&inode->inotify_sem);
+	list_for_each_entry_safe(watch, next, &inode->inotify_watches, i_list) {
+		struct inotify_device *dev = watch->dev;
+		down(&dev->sem);
+		remove_watch(watch, dev);
+		up(&dev->sem);
+	}
+	up(&inode->inotify_sem);
+}
+EXPORT_SYMBOL_GPL(inotify_inode_is_dead);
+
+/* Device Interface */
+
+static unsigned int inotify_poll(struct file *file, poll_table *wait)
+{
+	struct inotify_device *dev = file->private_data;
+	int ret = 0;
+
+	poll_wait(file, &dev->wq, wait);
+	down(&dev->sem);
+	if (!list_empty(&dev->events))
+		ret = POLLIN | POLLRDNORM;
+	up(&dev->sem);
+
+	return ret;
+}
+
+static ssize_t inotify_read(struct file *file, char __user *buf,
+			    size_t count, loff_t *pos)
+{
+	size_t event_size = sizeof (struct inotify_event);
+	struct inotify_device *dev;
+	char __user *start;
+	int ret;
+	DEFINE_WAIT(wait);
+
+	start = buf;
+	dev = file->private_data;
+
+	while (1) {
+		int events;
+
+		prepare_to_wait(&dev->wq, &wait, TASK_INTERRUPTIBLE);
+
+		down(&dev->sem);
+		events = !list_empty(&dev->events);
+		up(&dev->sem);
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
+	down(&dev->sem);
+	while (1) {
+		struct inotify_kernel_event *kevent;
+
+		ret = buf - start;
+		if (list_empty(&dev->events))
+			break;
+
+		kevent = inotify_dev_get_event(dev);
+		if (event_size + kevent->event.len > count)
+			break;
+
+		if (copy_to_user(buf, &kevent->event, event_size)) {
+			ret = -EFAULT;
+			break;
+		}
+		buf += event_size;
+		count -= event_size;
+
+		if (kevent->name) {
+			if (copy_to_user(buf, kevent->name, kevent->event.len)){
+				ret = -EFAULT;
+				break;
+			}
+			buf += kevent->event.len;
+			count -= kevent->event.len;
+		}
+
+		remove_kevent(dev, kevent);
+	}
+	up(&dev->sem);
+
+	return ret;
+}
+
+static int _inotify_open(struct inode *inode, struct file *file)
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
+	sema_init(&dev->sem, 1);
+	dev->event_count = 0;
+	dev->queue_size = 0;
+	dev->max_events = max_queued_events;
+	dev->user = user;
+	atomic_set(&dev->count, 0);
+
+	get_inotify_dev(dev);
+	atomic_inc(&user->inotify_devs);
+
+	file->private_data = dev;
+
+	ret = nonseekable_open(inode, file);
+	if (ret)
+		goto out_err;
+
+	return 0;
+out_err:
+	free_uid(user);
+	return ret;
+}
+
+static int inotify_release(struct inode *ignored, struct file *file)
+{
+	struct inotify_device *dev = file->private_data;
+
+	/*
+	 * Destroy all of the watches on this device.  Unfortunately, not very
+	 * pretty.  We cannot do a simple iteration over the list, because we
+	 * do not know the inode until we iterate to the watch.  But we need to
+	 * hold inode->inotify_sem before dev->sem.  The following works.
+	 */
+	while (1) {
+		struct inotify_watch *watch;
+		struct list_head *watches;
+		struct inode *inode;
+
+		down(&dev->sem);
+		watches = &dev->watches;
+		if (list_empty(watches)) {
+			up(&dev->sem);
+			break;
+		}
+		watch = list_entry(watches->next, struct inotify_watch, d_list);
+		get_inotify_watch(watch);
+		up(&dev->sem);
+
+		inode = watch->inode;
+		down(&inode->inotify_sem);
+		down(&dev->sem);
+		remove_watch_no_event(watch, dev);
+		up(&dev->sem);
+		up(&inode->inotify_sem);
+		put_inotify_watch(watch);
+	}
+
+	/* destroy all of the events on this device */
+	down(&dev->sem);
+	while (!list_empty(&dev->events))
+		inotify_dev_event_dequeue(dev);
+	up(&dev->sem);
+
+	/* free this device: the put matching the get in inotify_open() */
+	put_inotify_dev(dev);
+
+	return 0;
+}
+
+static int inotify_add_watch(struct inotify_device *dev, int fd, u32 mask)
+{
+	struct inotify_watch *watch, *old;
+	struct inode *inode;
+	struct file *filp;
+	int ret;
+
+	filp = fget(fd);
+	if (!filp)
+		return -EBADF;
+	inode = filp->f_dentry->d_inode;
+
+	down(&inode->inotify_sem);
+	down(&dev->sem);
+
+	/* don't let user-space set invalid bits: we don't want flags set */
+	mask &= IN_ALL_EVENTS;
+	if (!mask) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Handle the case of re-adding a watch on an (inode,dev) pair that we
+	 * are already watching.  We just update the mask and return its wd.
+	 */
+	old = inode_find_dev(inode, dev);
+	if (unlikely(old)) {
+		old->mask = mask;
+		ret = old->wd;
+		goto out;
+	}
+
+	watch = create_watch(dev, mask, inode);
+	if (unlikely(IS_ERR(watch))) {
+		ret = PTR_ERR(watch);
+		goto out;
+	}
+
+	/* Add the watch to the device's and the inode's list */
+	list_add(&watch->d_list, &dev->watches);
+	list_add(&watch->i_list, &inode->inotify_watches);
+	ret = watch->wd;
+
+out:
+	up(&dev->sem);
+	up(&inode->inotify_sem);
+	fput(filp);
+
+	return ret;
+}
+
+/*
+ * inotify_ignore - handle the INOTIFY_IGNORE ioctl, asking that a given wd be
+ * removed from the device.
+ *
+ * Can sleep.
+ */
+static int inotify_ignore(struct inotify_device *dev, s32 wd)
+{
+	struct inotify_watch *watch;
+	struct inode *inode;
+
+	down(&dev->sem);
+	watch = idr_find(&dev->idr, wd);
+	if (unlikely(!watch)) {
+		up(&dev->sem);
+		return -EINVAL;
+	}
+	get_inotify_watch(watch);
+	inode = watch->inode;
+	up(&dev->sem);
+
+	down(&inode->inotify_sem);
+	down(&dev->sem);
+
+	/* make sure that we did not race */
+	watch = idr_find(&dev->idr, wd);
+	if (likely(watch))
+		remove_watch(watch, dev);
+
+	up(&dev->sem);
+	up(&inode->inotify_sem);
+	put_inotify_watch(watch);
+
+	return 0;
+}
+
+static long inotify_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
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
+	switch (cmd) {
+	case INOTIFY_WATCH:
+		if (unlikely(copy_from_user(&request, p, sizeof (request)))) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = inotify_add_watch(dev, request.fd, request.mask);
+		break;
+	case INOTIFY_IGNORE:
+		if (unlikely(get_user(wd, (int __user *) p))) {
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
+	return ret;
+}
+
+static struct file_operations inotify_fops = {
+	.owner		= THIS_MODULE,
+	.poll		= inotify_poll,
+	.read		= inotify_read,
+	.open		= _inotify_open,
+	.release	= inotify_release,
+	.unlocked_ioctl	= inotify_ioctl,
+	.compat_ioctl	= inotify_ioctl,
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
+	max_queued_events = 8192;
+	max_user_devices = 128;
+	max_user_watches = 8192;
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
Index: linux-2.6.13-rc2-fsnotify-2/fs/Kconfig
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/Kconfig
+++ linux-2.6.13-rc2-fsnotify-2/fs/Kconfig
@@ -356,6 +356,19 @@ config ROMFS_FS
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
Index: linux-2.6.13-rc2-fsnotify-2/fs/Makefile
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/Makefile
+++ linux-2.6.13-rc2-fsnotify-2/fs/Makefile
@@ -12,6 +12,7 @@ obj-y :=	open.o read_write.o file_table.
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
 		ioprio.o
 
+obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
 
Index: linux-2.6.13-rc2-fsnotify-2/include/linux/fs.h
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/include/linux/fs.h
+++ linux-2.6.13-rc2-fsnotify-2/include/linux/fs.h
@@ -474,6 +474,11 @@ struct inode {
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 #endif
 
+#ifdef CONFIG_INOTIFY
+	struct list_head	inotify_watches; /* watches on this inode */
+	struct semaphore	inotify_sem;	/* protects the watches list */
+#endif
+
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
Index: linux-2.6.13-rc2-fsnotify-2/include/linux/inotify.h
===================================================================
--- /dev/null
+++ linux-2.6.13-rc2-fsnotify-2/include/linux/inotify.h
@@ -0,0 +1,301 @@
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
+	__u32		len;		/* length (including nulls) of name */
+	char		name[0];	/* stub for possible name */
+};
+
+/*
+ * struct inotify_watch_request - represents a watch request
+ *
+ * Pass to the inotify device via the INOTIFY_WATCH ioctl
+ */
+struct inotify_watch_request {
+	int		fd;		/* fd of filename to watch */
+	__u32		mask;		/* event mask */
+};
+
+/* the following are legal, implemented events that user-space can watch for */
+#define IN_ACCESS		0x00000001	/* File was accessed */
+#define IN_MODIFY		0x00000002	/* File was modified */
+#define IN_ATTRIB		0x00000004	/* Metadata changed */
+#define IN_CLOSE_WRITE		0x00000008	/* Writtable file was closed */
+#define IN_CLOSE_NOWRITE	0x00000010	/* Unwrittable file closed */
+#define IN_OPEN			0x00000020	/* File was opened */
+#define IN_MOVED_FROM		0x00000040	/* File was moved from X */
+#define IN_MOVED_TO		0x00000080	/* File was moved to Y */
+#define IN_CREATE		0x00000100	/* Subfile was created */
+#define IN_DELETE		0x00000200	/* Subfile was deleted */
+#define IN_DELETE_SELF		0x00000400	/* Self was deleted */
+
+/* the following are legal events.  they are sent as needed to any watch */
+#define IN_UNMOUNT		0x00002000	/* Backing fs was unmounted */
+#define IN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
+#define IN_IGNORED		0x00008000	/* File was ignored */
+
+/* helper events */
+#define IN_CLOSE		(IN_CLOSE_WRITE | IN_CLOSE_NOWRITE) /* close */
+#define IN_MOVE			(IN_MOVED_FROM | IN_MOVED_TO) /* moves */
+
+/* special flags */
+#define IN_ISDIR		0x40000000	/* event occurred against dir */
+#define IN_ONESHOT		0x80000000	/* only send event once */
+
+/*
+ * All of the events - we build the list by hand so that we can add flags in
+ * the future and not break backward compatibility.  Apps will get only the
+ * events that they originally wanted.  Be sure to add new events here!
+ */
+#define IN_ALL_EVENTS	(IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
+			 IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
+			 IN_MOVED_TO | IN_DELETE | IN_CREATE | IN_DELETE_SELF)
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
+#ifdef CONFIG_INOTIFY
+
+extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
+				      const char *);
+extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
+					      const char *);
+extern void inotify_unmount_inodes(struct list_head *);
+extern void inotify_inode_is_dead(struct inode *);
+extern u32 inotify_get_cookie(void);
+
+static inline void inotify_move(struct inode *old_dir, struct inode *new_dir,
+				const char *old_name, const char *new_name,
+				int isdir)
+{
+	u32 cookie = inotify_get_cookie();
+	if (isdir)
+		isdir = IN_ISDIR;
+	inotify_inode_queue_event(old_dir, IN_MOVED_FROM|isdir,cookie,old_name);
+	inotify_inode_queue_event(new_dir, IN_MOVED_TO|isdir, cookie, new_name);
+}
+
+static inline void inotify_unlink(struct dentry *dentry, struct inode *dir)
+{
+	struct inode *inode = dentry->d_inode;
+
+	inotify_inode_queue_event(dir, IN_DELETE, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
+	inotify_inode_is_dead(inode);
+}
+
+static inline void inotify_rmdir(struct dentry *dentry, struct inode *inode,
+				 struct inode *dir)
+{
+	inotify_inode_queue_event(dir,IN_DELETE|IN_ISDIR,0,dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF | IN_ISDIR, 0, NULL);
+	inotify_inode_is_dead(inode);
+}
+
+static inline void inotify_create(struct inode *inode, const char *name)
+{
+	inotify_inode_queue_event(inode, IN_CREATE, 0, name);
+}
+
+static inline void inotify_mkdir(struct inode *inode, const char *name)
+{
+	inotify_inode_queue_event(inode, IN_CREATE | IN_ISDIR, 0, name);
+}
+
+static inline void inotify_access(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	u32 mask = IN_ACCESS;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+}
+
+static inline void inotify_modify(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	u32 mask = IN_MODIFY;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+}
+
+static inline void inotify_open(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	u32 mask = IN_OPEN;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+}
+
+static inline void inotify_close(struct file *file)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct inode *inode = dentry->d_inode;
+	const char *name = dentry->d_name.name;
+	mode_t mode = file->f_mode;
+	u32 mask = (mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
+	inotify_dentry_parent_queue_event(dentry, mask, 0, name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+}
+
+static inline void inotify_xattr(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	u32 mask = IN_ATTRIB;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+}
+
+static inline void inotify_change(struct dentry *dentry, unsigned int ia_valid)
+{
+	struct inode *inode = dentry->d_inode;
+	u32 in_mask = 0;
+
+	if (ia_valid & ATTR_UID)
+		in_mask |= IN_ATTRIB;
+	if (ia_valid & ATTR_GID)
+		in_mask |= IN_ATTRIB;
+	if (ia_valid & ATTR_SIZE)
+		in_mask |= IN_MODIFY;
+	/* both times implies a utime(s) call */
+	if ((ia_valid & (ATTR_ATIME | ATTR_MTIME)) == (ATTR_ATIME | ATTR_MTIME))
+		in_mask |= IN_ATTRIB;
+	else if (ia_valid & ATTR_ATIME)
+		in_mask |= IN_ACCESS;
+	else if (ia_valid & ATTR_MTIME)
+		in_mask |= IN_MODIFY;
+	if (ia_valid & ATTR_MODE)
+		in_mask |= IN_ATTRIB;
+	
+	if (in_mask) {
+		if (S_ISDIR(inode->i_mode))
+			in_mask |= IN_ISDIR;
+		inotify_inode_queue_event(inode, in_mask, 0, NULL);
+		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
+						  dentry->d_name.name);
+	}
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
+static inline void inotify_unmount_inodes(struct list_head *list)
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
+static inline void inotify_move(struct inode *old_dir, struct inode *new_dir,
+				const char *old_name, const char *new_name,
+				int isdir)
+{
+}
+
+static inline void inotify_unlink(struct dentry *dentry, struct inode *dir)
+{
+}
+
+static inline void inotify_rmdir(struct dentry *dentry, struct inode *inode,
+				 struct inode *dir)
+{
+}
+
+static inline void inotify_create(struct inode *inode, const char *name)
+{
+}
+
+static inline void inotify_mkdir(struct inode *inode, const char *name)
+{
+}
+
+static inline void inotify_access(struct dentry *dentry)
+{
+}
+
+static inline void inotify_modify(struct dentry *dentry)
+{
+}
+
+static inline void inotify_open(struct dentry *dentry)
+{
+}
+
+static inline void inotify_close(struct file *file)
+{
+}
+
+static inline void inotify_xattr(struct dentry *dentry)
+{
+}
+
+static inline void inotify_change(struct dentry *dentry, unsigned int ia_valid){
+{
+}
+#endif	/* CONFIG_INOTIFY */
+
+#endif	/* __KERNEL __ */
+
+#endif	/* _LINUX_INOTIFY_H */
Index: linux-2.6.13-rc2-fsnotify-2/include/linux/sched.h
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/include/linux/sched.h
+++ linux-2.6.13-rc2-fsnotify-2/include/linux/sched.h
@@ -410,6 +410,10 @@ struct user_struct {
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
+#ifdef CONFIG_INOTIFY
+	atomic_t inotify_watches; /* How many inotify watches does this user have? */
+	atomic_t inotify_devs;	/* How many inotify devs does this user have opened? */
+#endif
 	/* protected by mq_lock	*/
 	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
 	unsigned long locked_shm; /* How many pages of mlocked shm ? */
Index: linux-2.6.13-rc2-fsnotify-2/kernel/user.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/kernel/user.c
+++ linux-2.6.13-rc2-fsnotify-2/kernel/user.c
@@ -120,6 +120,10 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
 		atomic_set(&new->sigpending, 0);
+#ifdef CONFIG_INOTIFY
+		atomic_set(&new->inotify_watches, 0);
+		atomic_set(&new->inotify_devs, 0);
+#endif
 
 		new->mq_bytes = 0;
 		new->locked_shm = 0;
Index: linux-2.6.13-rc2-fsnotify-2/include/linux/fsnotify.h
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/include/linux/fsnotify.h
+++ linux-2.6.13-rc2-fsnotify-2/include/linux/fsnotify.h
@@ -14,6 +14,7 @@
 #ifdef __KERNEL__
 
 #include <linux/dnotify.h>
+#include <linux/inotify.h>
 
 /*
  * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
@@ -23,6 +24,7 @@ static inline void fsnotify_move(struct 
 				 int isdir)
 {
 	dnotify_move(old_dir, new_dir, old_name, new_name, isdir);
+	inotify_move(old_dir, new_dir, old_name, new_name, isdir);
 }
 
 /*
@@ -31,6 +33,7 @@ static inline void fsnotify_move(struct 
 static inline void fsnotify_unlink(struct dentry *dentry, struct inode *dir)
 {
 	dnotify_unlink(dentry, dir);
+	inotify_unlink(dentry, dir);
 }
 
 /*
@@ -40,6 +43,7 @@ static inline void fsnotify_rmdir(struct
 				  struct inode *dir)
 {
 	dnotify_rmdir(dentry, inode, dir);
+	inotify_rmdir(dentry, inode, dir);
 }
 
 /*
@@ -48,6 +52,7 @@ static inline void fsnotify_rmdir(struct
 static inline void fsnotify_create(struct inode *inode, const char *name)
 {
 	dnotify_create(inode, name);
+	inotify_create(inode, name);
 }
 
 /*
@@ -56,6 +61,7 @@ static inline void fsnotify_create(struc
 static inline void fsnotify_mkdir(struct inode *inode, const char *name)
 {
 	dnotify_mkdir(inode, name);
+	inotify_mkdir(inode, name);
 }
 
 /*
@@ -64,6 +70,7 @@ static inline void fsnotify_mkdir(struct
 static inline void fsnotify_access(struct dentry *dentry)
 {
 	dnotify_access(dentry);
+	inotify_access(dentry);
 }
 
 /*
@@ -72,6 +79,7 @@ static inline void fsnotify_access(struc
 static inline void fsnotify_modify(struct dentry *dentry)
 {
 	dnotify_modify(dentry);
+	inotify_modify(dentry);
 }
 
 /*
@@ -79,6 +87,7 @@ static inline void fsnotify_modify(struc
  */
 static inline void fsnotify_open(struct dentry *dentry)
 {
+	inotify_open(dentry);
 }
 
 /*
@@ -86,6 +95,7 @@ static inline void fsnotify_open(struct 
  */
 static inline void fsnotify_close(struct file *file)
 {
+	inotify_close(file);
 }
 
 /*
@@ -93,6 +103,7 @@ static inline void fsnotify_close(struct
  */
 static inline void fsnotify_xattr(struct dentry *dentry)
 {
+	inotify_xattr(dentry);
 }
 
 /*
@@ -102,8 +113,29 @@ static inline void fsnotify_xattr(struct
 static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 {
 	dnotify_change(dentry, ia_valid);
+	inotify_change(dentry, ia_valid);
 }
 
+#ifdef CONFIG_INOTIFY	/* inotify helpers */
+
+/*
+ * fsnotify_oldname_init - save off the old filename before we change it
+ */
+static inline const char *fsnotify_oldname_init(const char *name)
+{
+	return kstrdup(name, GFP_KERNEL);
+}
+
+/*
+ * snotify_oldname_free - free the name we got from fsnotify_oldname_init
+ */
+static inline void fsnotify_oldname_free(const char *old_name)
+{
+	kfree(old_name);
+}
+
+#else	/* CONFIG_INOTIFY */
+
 static inline const char *fsnotify_oldname_init(const char *name)
 {
 	return NULL;
@@ -113,6 +145,8 @@ static inline void fsnotify_oldname_free
 {
 }
 
+#endif	/* ! CONFIG_INOTIFY */
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_FS_NOTIFY_H */
