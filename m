Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWEZCKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWEZCKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 22:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWEZCKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 22:10:45 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:35001 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030217AbWEZCKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 22:10:42 -0400
Date: Thu, 25 May 2006 22:10:30 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>
Subject: [PATCH] inotify kernel API
Message-ID: <20060526021030.GA4936@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a kernel API for inotify, making it possible for
kernel modules to benefit from inotify's mechanism for watching
inodes.  With this patch, inotify will maintain for each caller a list
of watches (via an embedded struct inotify_watch), where each
inotify_watch is associated with a corresponding struct inode.  The
caller registers an event handler and specifies for which filesystem
events their event handler should be called per inotify_watch.

I am particularly interested in a kernel API for inotify because it
allows the audit subsystem to provide a limited form of path-based
rules, where a rule's inode data is updated based on changes to its
immediate parent's directory entries.  Using an inotify API allows
audit to take advantage of inotify's hooks, list management, and inode
removal handling, instead of duplicating that functionality.

I posted an earlier version of this patch here:

    http://lkml.org/lkml/2006/4/6/96

After stress testing and completing audit patches to use this API,
I've made the following changes:

    (*) Allow callers to share the refcounting for an inotify_watch.
        If the caller has embedded the inotify_watch in one of its own
        structs, both inotify and the caller may need to use refcounts
        for that data.  Since the caller is ultimately responsible for
        freeing the inotify_watch data, they must register a destroy
        function to be called on the last put_inotify_watch.  Also
        provide inotify_init_watch() to enable a caller to use
        refcounts before calling inotify_add_watch().

    (*) Have inotify_find_watch() grab a reference before returning to
        caller; caller puts the reference when ready.  Since inotify
        watches are always subject to auto-removal based on filesystem
        events, this solves the problem of inotify finding an existing
        watch, only to have it disappear when inotify drops its locks
        before returning to caller.

        In my last post, I was concerned that the locking hierarchy
        requirement -- locks taken during a caller's event handler
        cannot be held during other inotify calls -- could cause
        synchronization problems for kernel consumers.  However, the
        above changes to refcounting seem to alleviate those issues.
	
    (*) Allow callers to remove watches from their event handler.
        Audit uses this feature to remove a watch after an
        IN_MOVE_SELF event.  Another similar use could be to have
        functionality similar to IN_ONESHOT, but have it apply to a
        subset of events in the mask.
	
    (*) Fixed a deadlock in inotify_dev_queue_event().

    (*) Fixed memleaks in inotify_destroy() and with IN_ONESHOT masks.

    (*) Re-ordered calls to event handler with IN_IGNORED events.
        Since caller may do final put here, this must be the last
        thing inotify does with an inotify_watch.

I did some stress tests and performance comparisons on inotify with
and without this patch.  The tests I used and some results are posted
here:

    http://free.linux.hp.com/~amg/inotify/

There is more detailed documentation on the inotify kernel API in
Documentation/filesystems/inotify.txt as part of this patch and in
comments at the top of inotify.c.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

--

 Documentation/filesystems/inotify.txt |  130 ++++
 fs/Kconfig                            |   24 
 fs/Makefile                           |    1 
 fs/inotify.c                          |  991 +++++++++-------------------------
 fs/inotify_user.c                     |  719 ++++++++++++++++++++++++
 include/linux/fsnotify.h              |   29 
 include/linux/inotify.h               |  111 +++
 include/linux/sched.h                 |    2 
 kernel/sysctl.c                       |    4 
 kernel/user.c                         |    2 
 10 files changed, 1275 insertions(+), 738 deletions(-)

diff --git a/Documentation/filesystems/inotify.txt b/Documentation/filesystems/inotify.txt
index 6d50190..59a919f 100644
--- a/Documentation/filesystems/inotify.txt
+++ b/Documentation/filesystems/inotify.txt
@@ -69,17 +69,135 @@ Prototypes:
 	int inotify_rm_watch (int fd, __u32 mask);
 
 
-(iii) Internal Kernel Implementation
+(iii) Kernel Interface
 
-Each inotify instance is associated with an inotify_device structure.
+Inotify's kernel API consists a set of functions for managing watches and an
+event callback.
+
+To use the kernel API, you must first initialize an inotify instance with a set
+of inotify_operations.  You are given an opaque inotify_handle, which you use
+for any further calls to inotify.
+
+    struct inotify_handle *ih = inotify_init(my_event_handler);
+
+You must provide a function for processing events and a function for destroying
+the inotify watch.
+
+    void handle_event(struct inotify_watch *watch, u32 wd, u32 mask,
+    	              u32 cookie, const char *name, struct inode *inode)
+
+	watch - the pointer to the inotify_watch that triggered this call
+	wd - the watch descriptor
+	mask - describes the event that occurred
+	cookie - an identifier for synchronizing events
+	name - the dentry name for affected files in a directory-based event
+	inode - the affected inode in a directory-based event
+
+    void destroy_watch(struct inotify_watch *watch)
+
+You may add watches by providing a pre-allocated and initialized inotify_watch
+structure and specifying the inode to watch along with an inotify event mask.
+You must pin the inode during the call.  You will likely wish to embed the
+inotify_watch structure in a structure of your own which contains other
+information about the watch.  Once you add an inotify watch, it is immediately
+subject to removal depending on filesystem events.  You must grab a reference if
+you depend on the watch hanging around after the call.
+
+    inotify_init_watch(&my_watch->iwatch);
+    inotify_get_watch(&my_watch->iwatch);	// optional
+    s32 wd = inotify_add_watch(ih, &my_watch->iwatch, inode, mask);
+    inotify_put_watch(&my_watch->iwatch);	// optional
+
+You may use the watch descriptor (wd) or the address of the inotify_watch for
+other inotify operations.  You must not directly read or manipulate data in the
+inotify_watch.  Additionally, you must not call inotify_add_watch() more than
+once for a given inotify_watch structure, unless you have first called either
+inotify_rm_watch() or inotify_rm_wd().
+
+To determine if you have already registered a watch for a given inode, you may
+call inotify_find_watch(), which gives you both the wd and the watch pointer for
+the inotify_watch, or an error if the watch does not exist.
+
+    wd = inotify_find_watch(ih, inode, &watchp);
+
+You may use container_of() on the watch pointer to access your own data
+associated with a given watch.  When an existing watch is found,
+inotify_find_watch() bumps the refcount before releasing its locks.  You must
+put that reference with:
+
+    put_inotify_watch(watchp);
+
+Call inotify_find_update_watch() to update the event mask for an existing watch.
+inotify_find_update_watch() returns the wd of the updated watch, or an error if
+the watch does not exist.
+
+    wd = inotify_find_update_watch(ih, inode, mask);
+
+An existing watch may be removed by calling either inotify_rm_watch() or
+inotify_rm_wd().
+
+    int ret = inotify_rm_watch(ih, &my_watch->iwatch);
+    int ret = inotify_rm_wd(ih, wd);
+
+A watch may be removed while executing your event handler with the following:
+
+    inotify_remove_watch_locked(ih, iwatch);
+
+Call inotify_destroy() to remove all watches from your inotify instance and
+release it.  If there are no outstanding references, inotify_destroy() will call
+your destroy_watch op for each watch.
+
+    inotify_destroy(ih);
+
+When inotify removes a watch, it sends an IN_IGNORED event to your callback.
+You may use this event as an indication to free the watch memory.  Note that
+inotify may remove a watch due to filesystem events, as well as by your request.
+If you use IN_ONESHOT, inotify will remove the watch after the first event, at
+which point you may call the final inotify_put_watch.
+
+(iv) Kernel Interface Prototypes
+
+	struct inotify_handle *inotify_init(struct inotify_operations *ops);
+
+	inotify_init_watch(struct inotify_watch *watch);
+
+	s32 inotify_add_watch(struct inotify_handle *ih,
+		              struct inotify_watch *watch,
+			      struct inode *inode, u32 mask);
+
+	s32 inotify_find_watch(struct inotify_handle *ih, struct inode *inode,
+			       struct inotify_watch **watchp);
+
+	s32 inotify_find_update_watch(struct inotify_handle *ih,
+				      struct inode *inode, u32 mask);
+
+	int inotify_rm_wd(struct inotify_handle *ih, u32 wd);
+
+	int inotify_rm_watch(struct inotify_handle *ih,
+			     struct inotify_watch *watch);
+
+	void inotify_remove_watch_locked(struct inotify_handle *ih,
+					 struct inotify_watch *watch);
+
+	void inotify_destroy(struct inotify_handle *ih);
+
+	void get_inotify_watch(struct inotify_watch *watch);
+	void put_inotify_watch(struct inotify_watch *watch);
+
+
+(v) Internal Kernel Implementation
+
+Each inotify instance is represented by an inotify_handle structure.
+Inotify's userspace consumers also have an inotify_device which is
+associated with the inotify_handle, and on which events are queued.
 
 Each watch is associated with an inotify_watch structure.  Watches are chained
-off of each associated device and each associated inode.
+off of each associated inotify_handle and each associated inode.
 
-See fs/inotify.c for the locking and lifetime rules.
+See fs/inotify.c and fs/inotify_user.c for the locking and lifetime rules.
 
 
-(iv) Rationale
+(vi) Rationale
 
 Q: What is the design decision behind not tying the watch to the open fd of
    the watched object?
@@ -145,7 +263,7 @@ A: The poor user-space interface is the 
    file descriptor-based one that allows basic file I/O and poll/select.
    Obtaining the fd and managing the watches could have been done either via a
    device file or a family of new system calls.  We decided to implement a
-   family of system calls because that is the preffered approach for new kernel
+   family of system calls because that is the preferred approach for new kernel
    interfaces.  The only real difference was whether we wanted to use open(2)
    and ioctl(2) or a couple of new system calls.  System calls beat ioctls.
 
diff --git a/fs/Kconfig b/fs/Kconfig
index 67d5568..5a8329d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -406,18 +406,30 @@ config INOTIFY
 	bool "Inotify file change notification support"
 	default y
 	---help---
-	  Say Y here to enable inotify support and the associated system
-	  calls.  Inotify is a file change notification system and a
-	  replacement for dnotify.  Inotify fixes numerous shortcomings in
-	  dnotify and introduces several new features.  It allows monitoring
-	  of both files and directories via a single open fd.  Other features
-	  include multiple file events, one-shot support, and unmount
+	  Say Y here to enable inotify support.  Inotify is a file change
+	  notification system and a replacement for dnotify.  Inotify fixes
+	  numerous shortcomings in dnotify and introduces several new features
+	  including multiple file events, one-shot support, and unmount
 	  notification.
 
 	  For more information, see Documentation/filesystems/inotify.txt
 
 	  If unsure, say Y.
 
+config INOTIFY_USER
+	bool "Inotify support for userspace"
+	depends on INOTIFY
+	default y
+	---help---
+	  Say Y here to enable inotify support for userspace, including the
+	  associated system calls.  Inotify allows monitoring of both files and
+	  directories via a single open fd.  Events are read from the file
+	  descriptor, which is also select()- and poll()-able.
+
+	  For more information, see Documentation/filesystems/inotify.txt
+
+	  If unsure, say Y.
+
 config QUOTA
 	bool "Quota support"
 	help
diff --git a/fs/Makefile b/fs/Makefile
index 7652ccb..69d4658 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -13,6 +13,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioprio.o pnode.o drop_caches.o splice.o sync.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
+obj-$(CONFIG_INOTIFY_USER)	+= inotify_user.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
 
diff --git a/fs/inotify.c b/fs/inotify.c
index 732ec4b..16d65ba 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -5,7 +5,10 @@
  *	John McCutchan	<ttb@tentacle.dhs.org>
  *	Robert Love	<rml@novell.com>
  *
+ * Kernel API added by: Amy Griffis <amy.griffis@hp.com>
+ *
  * Copyright (C) 2005 John McCutchan
+ * Copyright 2006 Hewlett-Packard Development Company, L.P.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -20,35 +23,17 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/mount.h>
-#include <linux/namei.h>
-#include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/writeback.h>
 #include <linux/inotify.h>
-#include <linux/syscalls.h>
-
-#include <asm/ioctls.h>
 
 static atomic_t inotify_cookie;
 
-static kmem_cache_t *watch_cachep __read_mostly;
-static kmem_cache_t *event_cachep __read_mostly;
-
-static struct vfsmount *inotify_mnt __read_mostly;
-
-/* these are configurable via /proc/sys/fs/inotify/ */
-int inotify_max_user_instances __read_mostly;
-int inotify_max_user_watches __read_mostly;
-int inotify_max_queued_events __read_mostly;
-
 /*
  * Lock ordering:
  *
@@ -56,327 +41,108 @@ int inotify_max_queued_events __read_mos
  * iprune_mutex (synchronize shrink_icache_memory())
  * 	inode_lock (protects the super_block->s_inodes list)
  * 	inode->inotify_mutex (protects inode->inotify_watches and watches->i_list)
- * 		inotify_dev->mutex (protects inotify_device and watches->d_list)
+ * 		inotify_handle->mutex (protects inotify_handle and watches->h_list)
+ *
+ * The inode->inotify_mutex and inotify_handle->mutex and held during execution
+ * of a caller's event handler.  Thus, the caller must not hold any locks
+ * taken in their event handler while calling any of the published inotify
+ * interfaces.
  */
 
 /*
- * Lifetimes of the three main data structures--inotify_device, inode, and
+ * Lifetimes of the three main data structures--inotify_handle, inode, and
  * inotify_watch--are managed by reference count.
  *
- * inotify_device: Lifetime is from inotify_init() until release.  Additional
- * references can bump the count via get_inotify_dev() and drop the count via
- * put_inotify_dev().
+ * inotify_handle: Lifetime is from inotify_init() to inotify_destroy().
+ * Additional references can bump the count via get_inotify_handle() and drop
+ * the count via put_inotify_handle().
  *
- * inotify_watch: Lifetime is from create_watch() to destory_watch().
- * Additional references can bump the count via get_inotify_watch() and drop
- * the count via put_inotify_watch().
+ * inotify_watch: for inotify's purposes, lifetime is from inotify_add_watch()
+ * to remove_watch_no_event().  Additional references can bump the count via
+ * get_inotify_watch() and drop the count via put_inotify_watch().  The caller
+ * is reponsible for the final put after receiving IN_IGNORED, or when using
+ * IN_ONESHOT after receiving the first event.  Inotify does the final put when
+ * the caller calls inotify_destroy().
  *
  * inode: Pinned so long as the inode is associated with a watch, from
- * create_watch() to put_inotify_watch().
+ * inotify_add_watch() to the final put_inotify_watch().
  */
 
 /*
- * struct inotify_device - represents an inotify instance
+ * struct inotify_handle - represents an inotify instance
  *
  * This structure is protected by the mutex 'mutex'.
  */
-struct inotify_device {
-	wait_queue_head_t 	wq;		/* wait queue for i/o */
+struct inotify_handle {
 	struct idr		idr;		/* idr mapping wd -> watch */
 	struct mutex		mutex;		/* protects this bad boy */
-	struct list_head 	events;		/* list of queued events */
 	struct list_head	watches;	/* list of watches */
 	atomic_t		count;		/* reference count */
-	struct user_struct	*user;		/* user who opened this dev */
-	unsigned int		queue_size;	/* size of the queue (bytes) */
-	unsigned int		event_count;	/* number of pending events */
-	unsigned int		max_events;	/* maximum number of events */
 	u32			last_wd;	/* the last wd allocated */
+	const struct inotify_operations *in_ops; /* inotify caller operations */
 };
 
-/*
- * struct inotify_kernel_event - An inotify event, originating from a watch and
- * queued for user-space.  A list of these is attached to each instance of the
- * device.  In read(), this list is walked and all events that can fit in the
- * buffer are returned.
- *
- * Protected by dev->mutex of the device in which we are queued.
- */
-struct inotify_kernel_event {
-	struct inotify_event	event;	/* the user-space event */
-	struct list_head        list;	/* entry in inotify_device's list */
-	char			*name;	/* filename, if any */
-};
-
-/*
- * struct inotify_watch - represents a watch request on a specific inode
- *
- * d_list is protected by dev->mutex of the associated watch->dev.
- * i_list and mask are protected by inode->inotify_mutex of the associated inode.
- * dev, inode, and wd are never written to once the watch is created.
- */
-struct inotify_watch {
-	struct list_head	d_list;	/* entry in inotify_device's list */
-	struct list_head	i_list;	/* entry in inode's list */
-	atomic_t		count;	/* reference count */
-	struct inotify_device	*dev;	/* associated device */
-	struct inode		*inode;	/* associated inode */
-	s32 			wd;	/* watch descriptor */
-	u32			mask;	/* event mask for this watch */
-};
-
-#ifdef CONFIG_SYSCTL
-
-#include <linux/sysctl.h>
-
-static int zero;
-
-ctl_table inotify_table[] = {
-	{
-		.ctl_name	= INOTIFY_MAX_USER_INSTANCES,
-		.procname	= "max_user_instances",
-		.data		= &inotify_max_user_instances,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
-	},
-	{
-		.ctl_name	= INOTIFY_MAX_USER_WATCHES,
-		.procname	= "max_user_watches",
-		.data		= &inotify_max_user_watches,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero, 
-	},
-	{
-		.ctl_name	= INOTIFY_MAX_QUEUED_EVENTS,
-		.procname	= "max_queued_events",
-		.data		= &inotify_max_queued_events,
-		.maxlen		= sizeof(int),
-		.mode		= 0644, 
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec, 
-		.extra1		= &zero
-	},
-	{ .ctl_name = 0 }
-};
-#endif /* CONFIG_SYSCTL */
-
-static inline void get_inotify_dev(struct inotify_device *dev)
+static inline void get_inotify_handle(struct inotify_handle *ih)
 {
-	atomic_inc(&dev->count);
+	atomic_inc(&ih->count);
 }
 
-static inline void put_inotify_dev(struct inotify_device *dev)
+static inline void put_inotify_handle(struct inotify_handle *ih)
 {
-	if (atomic_dec_and_test(&dev->count)) {
-		atomic_dec(&dev->user->inotify_devs);
-		free_uid(dev->user);
-		idr_destroy(&dev->idr);
-		kfree(dev);
+	if (atomic_dec_and_test(&ih->count)) {
+		idr_destroy(&ih->idr);
+		kfree(ih);
 	}
 }
 
-static inline void get_inotify_watch(struct inotify_watch *watch)
+/**
+ * get_inotify_watch - grab a reference to an inotify_watch
+ * @watch: watch to grab
+ */
+void get_inotify_watch(struct inotify_watch *watch)
 {
 	atomic_inc(&watch->count);
 }
+EXPORT_SYMBOL_GPL(get_inotify_watch);
 
-/*
+/**
  * put_inotify_watch - decrements the ref count on a given watch.  cleans up
- * the watch and its references if the count reaches zero.
+ * watch references if the count reaches zero.  inotify_watch is freed by
+ * inotify callers via the destroy_watch() op.
+ * @watch: watch to release
  */
-static inline void put_inotify_watch(struct inotify_watch *watch)
+void put_inotify_watch(struct inotify_watch *watch)
 {
 	if (atomic_dec_and_test(&watch->count)) {
-		put_inotify_dev(watch->dev);
-		iput(watch->inode);
-		kmem_cache_free(watch_cachep, watch);
-	}
-}
-
-/*
- * kernel_event - create a new kernel event with the given parameters
- *
- * This function can sleep.
- */
-static struct inotify_kernel_event * kernel_event(s32 wd, u32 mask, u32 cookie,
-						  const char *name)
-{
-	struct inotify_kernel_event *kevent;
-
-	kevent = kmem_cache_alloc(event_cachep, GFP_KERNEL);
-	if (unlikely(!kevent))
-		return NULL;
-
-	/* we hand this out to user-space, so zero it just in case */
-	memset(&kevent->event, 0, sizeof(struct inotify_event));
-
-	kevent->event.wd = wd;
-	kevent->event.mask = mask;
-	kevent->event.cookie = cookie;
-
-	INIT_LIST_HEAD(&kevent->list);
-
-	if (name) {
-		size_t len, rem, event_size = sizeof(struct inotify_event);
-
-		/*
-		 * We need to pad the filename so as to properly align an
-		 * array of inotify_event structures.  Because the structure is
-		 * small and the common case is a small filename, we just round
-		 * up to the next multiple of the structure's sizeof.  This is
-		 * simple and safe for all architectures.
-		 */
-		len = strlen(name) + 1;
-		rem = event_size - len;
-		if (len > event_size) {
-			rem = event_size - (len % event_size);
-			if (len % event_size == 0)
-				rem = 0;
-		}
-
-		kevent->name = kmalloc(len + rem, GFP_KERNEL);
-		if (unlikely(!kevent->name)) {
-			kmem_cache_free(event_cachep, kevent);
-			return NULL;
-		}
-		memcpy(kevent->name, name, len);
-		if (rem)
-			memset(kevent->name + len, 0, rem);		
-		kevent->event.len = len + rem;
-	} else {
-		kevent->event.len = 0;
-		kevent->name = NULL;
-	}
-
-	return kevent;
-}
-
-/*
- * inotify_dev_get_event - return the next event in the given dev's queue
- *
- * Caller must hold dev->mutex.
- */
-static inline struct inotify_kernel_event *
-inotify_dev_get_event(struct inotify_device *dev)
-{
-	return list_entry(dev->events.next, struct inotify_kernel_event, list);
-}
-
-/*
- * inotify_dev_queue_event - add a new event to the given device
- *
- * Caller must hold dev->mutex.  Can sleep (calls kernel_event()).
- */
-static void inotify_dev_queue_event(struct inotify_device *dev,
-				    struct inotify_watch *watch, u32 mask,
-				    u32 cookie, const char *name)
-{
-	struct inotify_kernel_event *kevent, *last;
-
-	/* coalescing: drop this event if it is a dupe of the previous */
-	last = inotify_dev_get_event(dev);
-	if (last && last->event.mask == mask && last->event.wd == watch->wd &&
-			last->event.cookie == cookie) {
-		const char *lastname = last->name;
-
-		if (!name && !lastname)
-			return;
-		if (name && lastname && !strcmp(lastname, name))
-			return;
-	}
-
-	/* the queue overflowed and we already sent the Q_OVERFLOW event */
-	if (unlikely(dev->event_count > dev->max_events))
-		return;
-
-	/* if the queue overflows, we need to notify user space */
-	if (unlikely(dev->event_count == dev->max_events))
-		kevent = kernel_event(-1, IN_Q_OVERFLOW, cookie, NULL);
-	else
-		kevent = kernel_event(watch->wd, mask, cookie, name);
-
-	if (unlikely(!kevent))
-		return;
-
-	/* queue the event and wake up anyone waiting */
-	dev->event_count++;
-	dev->queue_size += sizeof(struct inotify_event) + kevent->event.len;
-	list_add_tail(&kevent->list, &dev->events);
-	wake_up_interruptible(&dev->wq);
-}
-
-/*
- * remove_kevent - cleans up and ultimately frees the given kevent
- *
- * Caller must hold dev->mutex.
- */
-static void remove_kevent(struct inotify_device *dev,
-			  struct inotify_kernel_event *kevent)
-{
-	list_del(&kevent->list);
-
-	dev->event_count--;
-	dev->queue_size -= sizeof(struct inotify_event) + kevent->event.len;
-
-	kfree(kevent->name);
-	kmem_cache_free(event_cachep, kevent);
-}
+		struct inotify_handle *ih = watch->ih;
 
-/*
- * inotify_dev_event_dequeue - destroy an event on the given device
- *
- * Caller must hold dev->mutex.
- */
-static void inotify_dev_event_dequeue(struct inotify_device *dev)
-{
-	if (!list_empty(&dev->events)) {
-		struct inotify_kernel_event *kevent;
-		kevent = inotify_dev_get_event(dev);
-		remove_kevent(dev, kevent);
+		iput(watch->inode);
+		ih->in_ops->destroy_watch(watch);
+		put_inotify_handle(ih);
 	}
 }
+EXPORT_SYMBOL_GPL(put_inotify_watch);
 
 /*
- * inotify_dev_get_wd - returns the next WD for use by the given dev
+ * inotify_handle_get_wd - returns the next WD for use by the given handle
  *
- * Callers must hold dev->mutex.  This function can sleep.
+ * Callers must hold ih->mutex.  This function can sleep.
  */
-static int inotify_dev_get_wd(struct inotify_device *dev,
-			      struct inotify_watch *watch)
+static int inotify_handle_get_wd(struct inotify_handle *ih,
+				 struct inotify_watch *watch)
 {
 	int ret;
 
 	do {
-		if (unlikely(!idr_pre_get(&dev->idr, GFP_KERNEL)))
+		if (unlikely(!idr_pre_get(&ih->idr, GFP_KERNEL)))
 			return -ENOSPC;
-		ret = idr_get_new_above(&dev->idr, watch, dev->last_wd+1, &watch->wd);
+		ret = idr_get_new_above(&ih->idr, watch, ih->last_wd+1, &watch->wd);
 	} while (ret == -EAGAIN);
 
-	return ret;
-}
+	if (likely(!ret))
+		ih->last_wd = watch->wd;
 
-/*
- * find_inode - resolve a user-given path to a specific inode and return a nd
- */
-static int find_inode(const char __user *dirname, struct nameidata *nd,
-		      unsigned flags)
-{
-	int error;
-
-	error = __user_walk(dirname, flags, nd);
-	if (error)
-		return error;
-	/* you can only watch an inode if you have read permissions on it */
-	error = vfs_permission(nd, MAY_READ);
-	if (error) 
-		path_release(nd);
-	return error;
+	return ret;
 }
 
 /*
@@ -422,67 +188,18 @@ static void set_dentry_child_flags(struc
 }
 
 /*
- * create_watch - creates a watch on the given device.
- *
- * Callers must hold dev->mutex.  Calls inotify_dev_get_wd() so may sleep.
- * Both 'dev' and 'inode' (by way of nameidata) need to be pinned.
- */
-static struct inotify_watch *create_watch(struct inotify_device *dev,
-					  u32 mask, struct inode *inode)
-{
-	struct inotify_watch *watch;
-	int ret;
-
-	if (atomic_read(&dev->user->inotify_watches) >=
-			inotify_max_user_watches)
-		return ERR_PTR(-ENOSPC);
-
-	watch = kmem_cache_alloc(watch_cachep, GFP_KERNEL);
-	if (unlikely(!watch))
-		return ERR_PTR(-ENOMEM);
-
-	ret = inotify_dev_get_wd(dev, watch);
-	if (unlikely(ret)) {
-		kmem_cache_free(watch_cachep, watch);
-		return ERR_PTR(ret);
-	}
-
-	dev->last_wd = watch->wd;
-	watch->mask = mask;
-	atomic_set(&watch->count, 0);
-	INIT_LIST_HEAD(&watch->d_list);
-	INIT_LIST_HEAD(&watch->i_list);
-
-	/* save a reference to device and bump the count to make it official */
-	get_inotify_dev(dev);
-	watch->dev = dev;
-
-	/*
-	 * Save a reference to the inode and bump the ref count to make it
-	 * official.  We hold a reference to nameidata, which makes this safe.
-	 */
-	watch->inode = igrab(inode);
-
-	/* bump our own count, corresponding to our entry in dev->watches */
-	get_inotify_watch(watch);
-
-	atomic_inc(&dev->user->inotify_watches);
-
-	return watch;
-}
-
-/*
- * inotify_find_dev - find the watch associated with the given inode and dev
+ * inotify_find_handle - find the watch associated with the given inode and
+ * handle
  *
  * Callers must hold inode->inotify_mutex.
  */
-static struct inotify_watch *inode_find_dev(struct inode *inode,
-					    struct inotify_device *dev)
+static struct inotify_watch *inode_find_handle(struct inode *inode,
+					       struct inotify_handle *ih)
 {
 	struct inotify_watch *watch;
 
 	list_for_each_entry(watch, &inode->inotify_watches, i_list) {
-		if (watch->dev == dev)
+		if (watch->ih == ih)
 			return watch;
 	}
 
@@ -490,40 +207,40 @@ static struct inotify_watch *inode_find_
 }
 
 /*
- * remove_watch_no_event - remove_watch() without the IN_IGNORED event.
+ * remove_watch_no_event - remove watch without the IN_IGNORED event.
+ *
+ * Callers must hold both inode->inotify_mutex and ih->mutex.
  */
 static void remove_watch_no_event(struct inotify_watch *watch,
-				  struct inotify_device *dev)
+				  struct inotify_handle *ih)
 {
 	list_del(&watch->i_list);
-	list_del(&watch->d_list);
+	list_del(&watch->h_list);
 
 	if (!inotify_inode_watched(watch->inode))
 		set_dentry_child_flags(watch->inode, 0);
 
-	atomic_dec(&dev->user->inotify_watches);
-	idr_remove(&dev->idr, watch->wd);
-	put_inotify_watch(watch);
+	idr_remove(&ih->idr, watch->wd);
 }
 
-/*
- * remove_watch - Remove a watch from both the device and the inode.  Sends
- * the IN_IGNORED event to the given device signifying that the inode is no
- * longer watched.
- *
- * Callers must hold both inode->inotify_mutex and dev->mutex.  We drop a
- * reference to the inode before returning.
+/**
+ * inotify_remove_watch_locked - Remove a watch from both the handle and the
+ * inode.  Sends the IN_IGNORED event signifying that the inode is no longer
+ * watched.  May be called from a caller's event handler.
+ * @ih: inotify handle associated with watch
+ * @watch: watch to remove
  *
- * The inode is not iput() so as to remain atomic.  If the inode needs to be
- * iput(), the call returns one.  Otherwise, it returns zero.
+ * Callers must hold both inode->inotify_mutex and ih->mutex.
  */
-static void remove_watch(struct inotify_watch *watch,struct inotify_device *dev)
+void inotify_remove_watch_locked(struct inotify_handle *ih,
+				 struct inotify_watch *watch)
 {
-	inotify_dev_queue_event(dev, watch, IN_IGNORED, 0, NULL);
-	remove_watch_no_event(watch, dev);
+	remove_watch_no_event(watch, ih);
+	ih->in_ops->handle_event(watch, watch->wd, IN_IGNORED, 0, NULL, NULL);
 }
+EXPORT_SYMBOL_GPL(inotify_remove_watch_locked);
 
-/* Kernel API */
+/* Kernel API for producing events */
 
 /*
  * inotify_d_instantiate - instantiate dcache entry for inode
@@ -563,9 +280,10 @@ void inotify_d_move(struct dentry *entry
  * @mask: event mask describing this event
  * @cookie: cookie for synchronization, or zero
  * @name: filename, if any
+ * @a_inode: affected inode in a directory
  */
 void inotify_inode_queue_event(struct inode *inode, u32 mask, u32 cookie,
-			       const char *name)
+			       const char *name, struct inode *a_inode)
 {
 	struct inotify_watch *watch, *next;
 
@@ -576,14 +294,13 @@ void inotify_inode_queue_event(struct in
 	list_for_each_entry_safe(watch, next, &inode->inotify_watches, i_list) {
 		u32 watch_mask = watch->mask;
 		if (watch_mask & mask) {
-			struct inotify_device *dev = watch->dev;
-			get_inotify_watch(watch);
-			mutex_lock(&dev->mutex);
-			inotify_dev_queue_event(dev, watch, mask, cookie, name);
+			struct inotify_handle *ih= watch->ih;
+			mutex_lock(&ih->mutex);
 			if (watch_mask & IN_ONESHOT)
-				remove_watch_no_event(watch, dev);
-			mutex_unlock(&dev->mutex);
-			put_inotify_watch(watch);
+				remove_watch_no_event(watch, ih);
+			ih->in_ops->handle_event(watch, watch->wd, mask, cookie,
+						 name, a_inode);
+			mutex_unlock(&ih->mutex);
 		}
 	}
 	mutex_unlock(&inode->inotify_mutex);
@@ -613,7 +330,8 @@ void inotify_dentry_parent_queue_event(s
 	if (inotify_inode_watched(inode)) {
 		dget(parent);
 		spin_unlock(&dentry->d_lock);
-		inotify_inode_queue_event(inode, mask, cookie, name);
+		inotify_inode_queue_event(inode, mask, cookie, name,
+					  dentry->d_inode);
 		dput(parent);
 	} else
 		spin_unlock(&dentry->d_lock);
@@ -665,7 +383,7 @@ void inotify_unmount_inodes(struct list_
 
 		need_iput_tmp = need_iput;
 		need_iput = NULL;
-		/* In case the remove_watch() drops a reference. */
+		/* In case inotify_remove_watch_locked() drops a reference. */
 		if (inode != need_iput_tmp)
 			__iget(inode);
 		else
@@ -694,11 +412,12 @@ void inotify_unmount_inodes(struct list_
 		mutex_lock(&inode->inotify_mutex);
 		watches = &inode->inotify_watches;
 		list_for_each_entry_safe(watch, next_w, watches, i_list) {
-			struct inotify_device *dev = watch->dev;
-			mutex_lock(&dev->mutex);
-			inotify_dev_queue_event(dev, watch, IN_UNMOUNT,0,NULL);
-			remove_watch(watch, dev);
-			mutex_unlock(&dev->mutex);
+			struct inotify_handle *ih= watch->ih;
+			mutex_lock(&ih->mutex);
+			ih->in_ops->handle_event(watch, watch->wd, IN_UNMOUNT, 0,
+						 NULL, inode);
+			inotify_remove_watch_locked(ih, watch);
+			mutex_unlock(&ih->mutex);
 		}
 		mutex_unlock(&inode->inotify_mutex);
 		iput(inode);		
@@ -718,432 +437,292 @@ void inotify_inode_is_dead(struct inode 
 
 	mutex_lock(&inode->inotify_mutex);
 	list_for_each_entry_safe(watch, next, &inode->inotify_watches, i_list) {
-		struct inotify_device *dev = watch->dev;
-		mutex_lock(&dev->mutex);
-		remove_watch(watch, dev);
-		mutex_unlock(&dev->mutex);
+		struct inotify_handle *ih = watch->ih;
+		mutex_lock(&ih->mutex);
+		inotify_remove_watch_locked(ih, watch);
+		mutex_unlock(&ih->mutex);
 	}
 	mutex_unlock(&inode->inotify_mutex);
 }
 EXPORT_SYMBOL_GPL(inotify_inode_is_dead);
 
-/* Device Interface */
+/* Kernel Consumer API */
 
-static unsigned int inotify_poll(struct file *file, poll_table *wait)
+/**
+ * inotify_init - allocate and initialize an inotify instance
+ * @ops: caller's inotify operations
+ */
+struct inotify_handle *inotify_init(const struct inotify_operations *ops)
 {
-	struct inotify_device *dev = file->private_data;
-	int ret = 0;
+	struct inotify_handle *ih;
 
-	poll_wait(file, &dev->wq, wait);
-	mutex_lock(&dev->mutex);
-	if (!list_empty(&dev->events))
-		ret = POLLIN | POLLRDNORM;
-	mutex_unlock(&dev->mutex);
+	ih = kmalloc(sizeof(struct inotify_handle), GFP_KERNEL);
+	if (unlikely(!ih))
+		return ERR_PTR(-ENOMEM);
 
-	return ret;
+	idr_init(&ih->idr);
+	INIT_LIST_HEAD(&ih->watches);
+	mutex_init(&ih->mutex);
+	ih->last_wd = 0;
+	ih->in_ops = ops;
+	atomic_set(&ih->count, 0);
+	get_inotify_handle(ih);
+
+	return ih;
 }
+EXPORT_SYMBOL_GPL(inotify_init);
 
-static ssize_t inotify_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *pos)
+/**
+ * inotify_init_watch - initialize an inotify watch
+ * @watch: watch to initialize
+ */
+void inotify_init_watch(struct inotify_watch *watch)
 {
-	size_t event_size = sizeof (struct inotify_event);
-	struct inotify_device *dev;
-	char __user *start;
-	int ret;
-	DEFINE_WAIT(wait);
-
-	start = buf;
-	dev = file->private_data;
-
-	while (1) {
-		int events;
-
-		prepare_to_wait(&dev->wq, &wait, TASK_INTERRUPTIBLE);
-
-		mutex_lock(&dev->mutex);
-		events = !list_empty(&dev->events);
-		mutex_unlock(&dev->mutex);
-		if (events) {
-			ret = 0;
-			break;
-		}
-
-		if (file->f_flags & O_NONBLOCK) {
-			ret = -EAGAIN;
-			break;
-		}
-
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-
-		schedule();
-	}
-
-	finish_wait(&dev->wq, &wait);
-	if (ret)
-		return ret;
-
-	mutex_lock(&dev->mutex);
-	while (1) {
-		struct inotify_kernel_event *kevent;
-
-		ret = buf - start;
-		if (list_empty(&dev->events))
-			break;
-
-		kevent = inotify_dev_get_event(dev);
-		if (event_size + kevent->event.len > count)
-			break;
-
-		if (copy_to_user(buf, &kevent->event, event_size)) {
-			ret = -EFAULT;
-			break;
-		}
-		buf += event_size;
-		count -= event_size;
-
-		if (kevent->name) {
-			if (copy_to_user(buf, kevent->name, kevent->event.len)){
-				ret = -EFAULT;
-				break;
-			}
-			buf += kevent->event.len;
-			count -= kevent->event.len;
-		}
-
-		remove_kevent(dev, kevent);
-	}
-	mutex_unlock(&dev->mutex);
-
-	return ret;
+	INIT_LIST_HEAD(&watch->h_list);
+	INIT_LIST_HEAD(&watch->i_list);
+	atomic_set(&watch->count, 0);
+	get_inotify_watch(watch); /* initial get */
 }
+EXPORT_SYMBOL_GPL(inotify_init_watch);
 
-static int inotify_release(struct inode *ignored, struct file *file)
+/**
+ * inotify_destroy - clean up and destroy an inotify instance
+ * @ih: inotify handle
+ */
+void inotify_destroy(struct inotify_handle *ih)
 {
-	struct inotify_device *dev = file->private_data;
-
 	/*
-	 * Destroy all of the watches on this device.  Unfortunately, not very
+	 * Destroy all of the watches for this handle. Unfortunately, not very
 	 * pretty.  We cannot do a simple iteration over the list, because we
 	 * do not know the inode until we iterate to the watch.  But we need to
-	 * hold inode->inotify_mutex before dev->mutex.  The following works.
+	 * hold inode->inotify_mutex before ih->mutex.  The following works.
 	 */
 	while (1) {
 		struct inotify_watch *watch;
 		struct list_head *watches;
 		struct inode *inode;
 
-		mutex_lock(&dev->mutex);
-		watches = &dev->watches;
+		mutex_lock(&ih->mutex);
+		watches = &ih->watches;
 		if (list_empty(watches)) {
-			mutex_unlock(&dev->mutex);
+			mutex_unlock(&ih->mutex);
 			break;
 		}
-		watch = list_entry(watches->next, struct inotify_watch, d_list);
+		watch = list_entry(watches->next, struct inotify_watch, h_list);
 		get_inotify_watch(watch);
-		mutex_unlock(&dev->mutex);
+		mutex_unlock(&ih->mutex);
 
 		inode = watch->inode;
 		mutex_lock(&inode->inotify_mutex);
-		mutex_lock(&dev->mutex);
+		mutex_lock(&ih->mutex);
 
 		/* make sure we didn't race with another list removal */
-		if (likely(idr_find(&dev->idr, watch->wd)))
-			remove_watch_no_event(watch, dev);
+		if (likely(idr_find(&ih->idr, watch->wd))) {
+			remove_watch_no_event(watch, ih);
+			put_inotify_watch(watch);
+		}
 
-		mutex_unlock(&dev->mutex);
+		mutex_unlock(&ih->mutex);
 		mutex_unlock(&inode->inotify_mutex);
 		put_inotify_watch(watch);
 	}
 
-	/* destroy all of the events on this device */
-	mutex_lock(&dev->mutex);
-	while (!list_empty(&dev->events))
-		inotify_dev_event_dequeue(dev);
-	mutex_unlock(&dev->mutex);
-
-	/* free this device: the put matching the get in inotify_init() */
-	put_inotify_dev(dev);
-
-	return 0;
+	/* free this handle: the put matching the get in inotify_init() */
+	put_inotify_handle(ih);
 }
+EXPORT_SYMBOL_GPL(inotify_destroy);
 
-/*
- * inotify_ignore - remove a given wd from this inotify instance.
+/**
+ * inotify_find_watch - find an existing watch for an (ih,inode) pair
+ * @ih: inotify handle
+ * @inode: inode to watch
+ * @watchp: pointer to existing inotify_watch
  *
- * Can sleep.
+ * Caller must pin given inode (via nameidata).
  */
-static int inotify_ignore(struct inotify_device *dev, s32 wd)
+s32 inotify_find_watch(struct inotify_handle *ih, struct inode *inode,
+		       struct inotify_watch **watchp)
 {
-	struct inotify_watch *watch;
-	struct inode *inode;
-
-	mutex_lock(&dev->mutex);
-	watch = idr_find(&dev->idr, wd);
-	if (unlikely(!watch)) {
-		mutex_unlock(&dev->mutex);
-		return -EINVAL;
-	}
-	get_inotify_watch(watch);
-	inode = watch->inode;
-	mutex_unlock(&dev->mutex);
+	struct inotify_watch *old;
+	int ret = -ENOENT;
 
 	mutex_lock(&inode->inotify_mutex);
-	mutex_lock(&dev->mutex);
+	mutex_lock(&ih->mutex);
 
-	/* make sure that we did not race */
-	if (likely(idr_find(&dev->idr, wd) == watch))
-		remove_watch(watch, dev);
+	old = inode_find_handle(inode, ih);
+	if (unlikely(old)) {
+		get_inotify_watch(old); /* caller must put watch */
+		*watchp = old;
+		ret = old->wd;
+	}
 
-	mutex_unlock(&dev->mutex);
+	mutex_unlock(&ih->mutex);
 	mutex_unlock(&inode->inotify_mutex);
-	put_inotify_watch(watch);
 
-	return 0;
+	return ret;
 }
+EXPORT_SYMBOL_GPL(inotify_find_watch);
 
-static long inotify_ioctl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
+/**
+ * inotify_find_update_watch - find and update the mask of an existing watch
+ * @ih: inotify handle
+ * @inode: inode's watch to update
+ * @mask: mask of events to watch
+ *
+ * Caller must pin given inode (via nameidata).
+ */
+s32 inotify_find_update_watch(struct inotify_handle *ih, struct inode *inode,
+			      u32 mask)
 {
-	struct inotify_device *dev;
-	void __user *p;
-	int ret = -ENOTTY;
-
-	dev = file->private_data;
-	p = (void __user *) arg;
-
-	switch (cmd) {
-	case FIONREAD:
-		ret = put_user(dev->queue_size, (int __user *) p);
-		break;
-	}
-
-	return ret;
-}
+	struct inotify_watch *old;
+	int mask_add = 0;
+	int ret;
 
-static const struct file_operations inotify_fops = {
-	.poll           = inotify_poll,
-	.read           = inotify_read,
-	.release        = inotify_release,
-	.unlocked_ioctl = inotify_ioctl,
-	.compat_ioctl	= inotify_ioctl,
-};
+	if (mask & IN_MASK_ADD)
+		mask_add = 1;
 
-asmlinkage long sys_inotify_init(void)
-{
-	struct inotify_device *dev;
-	struct user_struct *user;
-	struct file *filp;	
-	int fd, ret;
-
-	fd = get_unused_fd();
-	if (fd < 0)
-		return fd;
-
-	filp = get_empty_filp();
-	if (!filp) {
-		ret = -ENFILE;
-		goto out_put_fd;
-	}
+	/* don't allow invalid bits: we don't want flags set */
+	mask &= IN_ALL_EVENTS | IN_ONESHOT;
+	if (unlikely(!mask))
+		return -EINVAL;
 
-	user = get_uid(current->user);
-	if (unlikely(atomic_read(&user->inotify_devs) >=
-			inotify_max_user_instances)) {
-		ret = -EMFILE;
-		goto out_free_uid;
-	}
+	mutex_lock(&inode->inotify_mutex);
+	mutex_lock(&ih->mutex);
 
-	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
-	if (unlikely(!dev)) {
-		ret = -ENOMEM;
-		goto out_free_uid;
+	/*
+	 * Handle the case of re-adding a watch on an (inode,ih) pair that we
+	 * are already watching.  We just update the mask and return its wd.
+	 */
+	old = inode_find_handle(inode, ih);
+	if (unlikely(!old)) {
+		ret = -ENOENT;
+		goto out;
 	}
 
-	filp->f_op = &inotify_fops;
-	filp->f_vfsmnt = mntget(inotify_mnt);
-	filp->f_dentry = dget(inotify_mnt->mnt_root);
-	filp->f_mapping = filp->f_dentry->d_inode->i_mapping;
-	filp->f_mode = FMODE_READ;
-	filp->f_flags = O_RDONLY;
-	filp->private_data = dev;
-
-	idr_init(&dev->idr);
-	INIT_LIST_HEAD(&dev->events);
-	INIT_LIST_HEAD(&dev->watches);
-	init_waitqueue_head(&dev->wq);
-	mutex_init(&dev->mutex);
-	dev->event_count = 0;
-	dev->queue_size = 0;
-	dev->max_events = inotify_max_queued_events;
-	dev->user = user;
-	dev->last_wd = 0;
-	atomic_set(&dev->count, 0);
-
-	get_inotify_dev(dev);
-	atomic_inc(&user->inotify_devs);
-	fd_install(fd, filp);
-
-	return fd;
-out_free_uid:
-	free_uid(user);
-	put_filp(filp);
-out_put_fd:
-	put_unused_fd(fd);
+	if (mask_add)
+		old->mask |= mask;
+	else
+		old->mask = mask;
+	ret = old->wd;
+out:
+	mutex_unlock(&ih->mutex);
+	mutex_unlock(&inode->inotify_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(inotify_find_update_watch);
 
-asmlinkage long sys_inotify_add_watch(int fd, const char __user *path, u32 mask)
+/**
+ * inotify_add_watch - add a watch to an inotify instance
+ * @ih: inotify handle
+ * @watch: caller allocated watch structure
+ * @inode: inode to watch
+ * @mask: mask of events to watch
+ *
+ * Caller must pin given inode (via nameidata).
+ * Caller must ensure it only calls inotify_add_watch() once per watch.
+ * Calls inotify_handle_get_wd() so may sleep.
+ */
+s32 inotify_add_watch(struct inotify_handle *ih, struct inotify_watch *watch,
+		      struct inode *inode, u32 mask)
 {
-	struct inotify_watch *watch, *old;
-	struct inode *inode;
-	struct inotify_device *dev;
-	struct nameidata nd;
-	struct file *filp;
-	int ret, fput_needed;
-	int mask_add = 0;
-	unsigned flags = 0;
-
-	filp = fget_light(fd, &fput_needed);
-	if (unlikely(!filp))
-		return -EBADF;
-
-	/* verify that this is indeed an inotify instance */
-	if (unlikely(filp->f_op != &inotify_fops)) {
-		ret = -EINVAL;
-		goto fput_and_out;
-	}
-
-	if (!(mask & IN_DONT_FOLLOW))
-		flags |= LOOKUP_FOLLOW;
-	if (mask & IN_ONLYDIR)
-		flags |= LOOKUP_DIRECTORY;
-
-	ret = find_inode(path, &nd, flags);
-	if (unlikely(ret))
-		goto fput_and_out;
+	int ret = 0;
 
-	/* inode held in place by reference to nd; dev by fget on fd */
-	inode = nd.dentry->d_inode;
-	dev = filp->private_data;
+	/* don't allow invalid bits: we don't want flags set */
+	mask &= IN_ALL_EVENTS | IN_ONESHOT;
+	if (unlikely(!mask))
+		return -EINVAL;
+	watch->mask = mask;
 
 	mutex_lock(&inode->inotify_mutex);
-	mutex_lock(&dev->mutex);
-
-	if (mask & IN_MASK_ADD)
-		mask_add = 1;
+	mutex_lock(&ih->mutex);
 
-	/* don't let user-space set invalid bits: we don't want flags set */
-	mask &= IN_ALL_EVENTS | IN_ONESHOT;
-	if (unlikely(!mask)) {
-		ret = -EINVAL;
+	/* Initialize a new watch */
+	ret = inotify_handle_get_wd(ih, watch);
+	if (unlikely(ret))
 		goto out;
-	}
+	ret = watch->wd;
+
+	/* save a reference to handle and bump the count to make it official */
+	get_inotify_handle(ih);
+	watch->ih = ih;
 
 	/*
-	 * Handle the case of re-adding a watch on an (inode,dev) pair that we
-	 * are already watching.  We just update the mask and return its wd.
+	 * Save a reference to the inode and bump the ref count to make it
+	 * official.  We hold a reference to nameidata, which makes this safe.
 	 */
-	old = inode_find_dev(inode, dev);
-	if (unlikely(old)) {
-		if (mask_add)
-			old->mask |= mask;
-		else
-			old->mask = mask;
-		ret = old->wd;
-		goto out;
-	}
-
-	watch = create_watch(dev, mask, inode);
-	if (unlikely(IS_ERR(watch))) {
-		ret = PTR_ERR(watch);
-		goto out;
-	}
+	watch->inode = igrab(inode);
 
 	if (!inotify_inode_watched(inode))
 		set_dentry_child_flags(inode, 1);
 
-	/* Add the watch to the device's and the inode's list */
-	list_add(&watch->d_list, &dev->watches);
+	/* Add the watch to the handle's and the inode's list */
+	list_add(&watch->h_list, &ih->watches);
 	list_add(&watch->i_list, &inode->inotify_watches);
-	ret = watch->wd;
 out:
-	mutex_unlock(&dev->mutex);
+	mutex_unlock(&ih->mutex);
 	mutex_unlock(&inode->inotify_mutex);
-	path_release(&nd);
-fput_and_out:
-	fput_light(filp, fput_needed);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(inotify_add_watch);
 
-asmlinkage long sys_inotify_rm_watch(int fd, u32 wd)
+/**
+ * inotify_rm_wd - remove a watch from an inotify instance
+ * @ih: inotify handle
+ * @wd: watch descriptor to remove
+ *
+ * Can sleep.
+ */
+int inotify_rm_wd(struct inotify_handle *ih, u32 wd)
 {
-	struct file *filp;
-	struct inotify_device *dev;
-	int ret, fput_needed;
-
-	filp = fget_light(fd, &fput_needed);
-	if (unlikely(!filp))
-		return -EBADF;
+	struct inotify_watch *watch;
+	struct inode *inode;
 
-	/* verify that this is indeed an inotify instance */
-	if (unlikely(filp->f_op != &inotify_fops)) {
-		ret = -EINVAL;
-		goto out;
+	mutex_lock(&ih->mutex);
+	watch = idr_find(&ih->idr, wd);
+	if (unlikely(!watch)) {
+		mutex_unlock(&ih->mutex);
+		return -EINVAL;
 	}
+	get_inotify_watch(watch);
+	inode = watch->inode;
+	mutex_unlock(&ih->mutex);
 
-	dev = filp->private_data;
-	ret = inotify_ignore(dev, wd);
+	mutex_lock(&inode->inotify_mutex);
+	mutex_lock(&ih->mutex);
 
-out:
-	fput_light(filp, fput_needed);
-	return ret;
+	/* make sure that we did not race */
+	if (likely(idr_find(&ih->idr, wd) == watch))
+		inotify_remove_watch_locked(ih, watch);
+
+	mutex_unlock(&ih->mutex);
+	mutex_unlock(&inode->inotify_mutex);
+	put_inotify_watch(watch);
+
+	return 0;
 }
+EXPORT_SYMBOL_GPL(inotify_rm_wd);
 
-static struct super_block *
-inotify_get_sb(struct file_system_type *fs_type, int flags,
-	       const char *dev_name, void *data)
+/**
+ * inotify_rm_watch - remove a watch from an inotify instance
+ * @ih: inotify handle
+ * @watch: watch to remove
+ *
+ * Can sleep.
+ */
+int inotify_rm_watch(struct inotify_handle *ih,
+		     struct inotify_watch *watch)
 {
-    return get_sb_pseudo(fs_type, "inotify", NULL, 0xBAD1DEA);
+	return inotify_rm_wd(ih, watch->wd);
 }
-
-static struct file_system_type inotify_fs_type = {
-    .name           = "inotifyfs",
-    .get_sb         = inotify_get_sb,
-    .kill_sb        = kill_anon_super,
-};
+EXPORT_SYMBOL_GPL(inotify_rm_watch);
 
 /*
- * inotify_setup - Our initialization function.  Note that we cannnot return
- * error because we have compiled-in VFS hooks.  So an (unlikely) failure here
- * must result in panic().
+ * inotify_setup - core initialization function
  */
 static int __init inotify_setup(void)
 {
-	int ret;
-
-	ret = register_filesystem(&inotify_fs_type);
-	if (unlikely(ret))
-		panic("inotify: register_filesystem returned %d!\n", ret);
-
-	inotify_mnt = kern_mount(&inotify_fs_type);
-	if (IS_ERR(inotify_mnt))
-		panic("inotify: kern_mount ret %ld!\n", PTR_ERR(inotify_mnt));
-
-	inotify_max_queued_events = 16384;
-	inotify_max_user_instances = 128;
-	inotify_max_user_watches = 8192;
-
 	atomic_set(&inotify_cookie, 0);
 
-	watch_cachep = kmem_cache_create("inotify_watch_cache",
-					 sizeof(struct inotify_watch),
-					 0, SLAB_PANIC, NULL, NULL);
-	event_cachep = kmem_cache_create("inotify_event_cache",
-					 sizeof(struct inotify_kernel_event),
-					 0, SLAB_PANIC, NULL, NULL);
-
 	return 0;
 }
 
diff --git a/fs/inotify_user.c b/fs/inotify_user.c
new file mode 100644
index 0000000..9e9931e
--- /dev/null
+++ b/fs/inotify_user.c
@@ -0,0 +1,719 @@
+/*
+ * fs/inotify_user.c - inotify support for userspace
+ *
+ * Authors:
+ *	John McCutchan	<ttb@tentacle.dhs.org>
+ *	Robert Love	<rml@novell.com>
+ *
+ * Copyright (C) 2005 John McCutchan
+ * Copyright 2006 Hewlett-Packard Development Company, L.P.
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
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/poll.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/inotify.h>
+#include <linux/syscalls.h>
+
+#include <asm/ioctls.h>
+
+static kmem_cache_t *watch_cachep __read_mostly;
+static kmem_cache_t *event_cachep __read_mostly;
+
+static struct vfsmount *inotify_mnt __read_mostly;
+
+/* these are configurable via /proc/sys/fs/inotify/ */
+int inotify_max_user_instances __read_mostly;
+int inotify_max_user_watches __read_mostly;
+int inotify_max_queued_events __read_mostly;
+
+/*
+ * Lock ordering:
+ *
+ * inotify_dev->up_mutex (ensures we don't re-add the same watch)
+ * 	inode->inotify_mutex (protects inode's watch list)
+ * 		inotify_handle->mutex (protects inotify_handle's watch list)
+ * 			inotify_dev->ev_mutex (protects device's event queue)
+ */
+
+/*
+ * Lifetimes of the main data structures:
+ *
+ * inotify_device: Lifetime is managed by reference count, from
+ * sys_inotify_init() until release.  Additional references can bump the count
+ * via get_inotify_dev() and drop the count via put_inotify_dev().
+ *
+ * inotify_user_watch: Lifetime is from create_watch() to the receipt of an
+ * IN_IGNORED event from inotify, or when using IN_ONESHOT, to receipt of the
+ * first event, or to inotify_destroy().
+ */
+
+/*
+ * struct inotify_device - represents an inotify instance
+ *
+ * This structure is protected by the mutex 'mutex'.
+ */
+struct inotify_device {
+	wait_queue_head_t 	wq;		/* wait queue for i/o */
+	struct mutex		ev_mutex;	/* protects event queue */
+	struct mutex		up_mutex;	/* synchronizes watch updates */
+	struct list_head 	events;		/* list of queued events */
+	atomic_t		count;		/* reference count */
+	struct user_struct	*user;		/* user who opened this dev */
+	struct inotify_handle	*ih;		/* inotify handle */
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
+ * Protected by dev->ev_mutex of the device in which we are queued.
+ */
+struct inotify_kernel_event {
+	struct inotify_event	event;	/* the user-space event */
+	struct list_head        list;	/* entry in inotify_device's list */
+	char			*name;	/* filename, if any */
+};
+
+/*
+ * struct inotify_user_watch - our version of an inotify_watch, we add
+ * a reference to the associated inotify_device.
+ */
+struct inotify_user_watch {
+	struct inotify_device	*dev;	/* associated device */
+	struct inotify_watch	wdata;	/* inotify watch data */
+};
+
+#ifdef CONFIG_SYSCTL
+
+#include <linux/sysctl.h>
+
+static int zero;
+
+ctl_table inotify_table[] = {
+	{
+		.ctl_name	= INOTIFY_MAX_USER_INSTANCES,
+		.procname	= "max_user_instances",
+		.data		= &inotify_max_user_instances,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{
+		.ctl_name	= INOTIFY_MAX_USER_WATCHES,
+		.procname	= "max_user_watches",
+		.data		= &inotify_max_user_watches,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{
+		.ctl_name	= INOTIFY_MAX_QUEUED_EVENTS,
+		.procname	= "max_queued_events",
+		.data		= &inotify_max_queued_events,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero
+	},
+	{ .ctl_name = 0 }
+};
+#endif /* CONFIG_SYSCTL */
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
+/*
+ * free_inotify_user_watch - cleans up the watch and its references
+ */
+static void free_inotify_user_watch(struct inotify_watch *w)
+{
+	struct inotify_user_watch *watch;
+	struct inotify_device *dev;
+
+	watch = container_of(w, struct inotify_user_watch, wdata);
+	dev = watch->dev;
+
+	atomic_dec(&dev->user->inotify_watches);
+	put_inotify_dev(dev);
+	kmem_cache_free(watch_cachep, watch);
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
+ * Caller must hold dev->ev_mutex.
+ */
+static inline struct inotify_kernel_event *
+inotify_dev_get_event(struct inotify_device *dev)
+{
+	return list_entry(dev->events.next, struct inotify_kernel_event, list);
+}
+
+/*
+ * inotify_dev_queue_event - event handler registered with core inotify, adds
+ * a new event to the given device
+ *
+ * Can sleep (calls kernel_event()).
+ */
+static void inotify_dev_queue_event(struct inotify_watch *w, u32 wd, u32 mask,
+				    u32 cookie, const char *name,
+				    struct inode *ignored)
+{
+	struct inotify_user_watch *watch;
+	struct inotify_device *dev;
+	struct inotify_kernel_event *kevent, *last;
+
+	watch = container_of(w, struct inotify_user_watch, wdata);
+	dev = watch->dev;
+
+	mutex_lock(&dev->ev_mutex);
+
+	/* we can safely put the watch as we don't reference it while
+	 * generating the event
+	 */
+	if (mask & IN_IGNORED || mask & IN_ONESHOT)
+		put_inotify_watch(w); /* final put */
+
+	/* coalescing: drop this event if it is a dupe of the previous */
+	last = inotify_dev_get_event(dev);
+	if (last && last->event.mask == mask && last->event.wd == wd &&
+			last->event.cookie == cookie) {
+		const char *lastname = last->name;
+
+		if (!name && !lastname)
+			goto out;
+		if (name && lastname && !strcmp(lastname, name))
+			goto out;
+	}
+
+	/* the queue overflowed and we already sent the Q_OVERFLOW event */
+	if (unlikely(dev->event_count > dev->max_events))
+		goto out;
+
+	/* if the queue overflows, we need to notify user space */
+	if (unlikely(dev->event_count == dev->max_events))
+		kevent = kernel_event(-1, IN_Q_OVERFLOW, cookie, NULL);
+	else
+		kevent = kernel_event(wd, mask, cookie, name);
+
+	if (unlikely(!kevent))
+		goto out;
+
+	/* queue the event and wake up anyone waiting */
+	dev->event_count++;
+	dev->queue_size += sizeof(struct inotify_event) + kevent->event.len;
+	list_add_tail(&kevent->list, &dev->events);
+	wake_up_interruptible(&dev->wq);
+
+out:
+	mutex_unlock(&dev->ev_mutex);
+}
+
+/*
+ * remove_kevent - cleans up and ultimately frees the given kevent
+ *
+ * Caller must hold dev->ev_mutex.
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
+ * Caller must hold dev->ev_mutex.
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
+ * find_inode - resolve a user-given path to a specific inode and return a nd
+ */
+static int find_inode(const char __user *dirname, struct nameidata *nd,
+		      unsigned flags)
+{
+	int error;
+
+	error = __user_walk(dirname, flags, nd);
+	if (error)
+		return error;
+	/* you can only watch an inode if you have read permissions on it */
+	error = vfs_permission(nd, MAY_READ);
+	if (error)
+		path_release(nd);
+	return error;
+}
+
+/*
+ * create_watch - creates a watch on the given device.
+ *
+ * Callers must hold dev->up_mutex.
+ */
+static int create_watch(struct inotify_device *dev, struct inode *inode,
+			u32 mask)
+{
+	struct inotify_user_watch *watch;
+	int ret;
+
+	if (atomic_read(&dev->user->inotify_watches) >=
+			inotify_max_user_watches)
+		return -ENOSPC;
+
+	watch = kmem_cache_alloc(watch_cachep, GFP_KERNEL);
+	if (unlikely(!watch))
+		return -ENOMEM;
+
+	/* save a reference to device and bump the count to make it official */
+	get_inotify_dev(dev);
+	watch->dev = dev;
+
+	atomic_inc(&dev->user->inotify_watches);
+
+	inotify_init_watch(&watch->wdata);
+	ret = inotify_add_watch(dev->ih, &watch->wdata, inode, mask);
+	if (ret < 0)
+		free_inotify_user_watch(&watch->wdata);
+
+	return ret;
+}
+
+/* Device Interface */
+
+static unsigned int inotify_poll(struct file *file, poll_table *wait)
+{
+	struct inotify_device *dev = file->private_data;
+	int ret = 0;
+
+	poll_wait(file, &dev->wq, wait);
+	mutex_lock(&dev->ev_mutex);
+	if (!list_empty(&dev->events))
+		ret = POLLIN | POLLRDNORM;
+	mutex_unlock(&dev->ev_mutex);
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
+		mutex_lock(&dev->ev_mutex);
+		events = !list_empty(&dev->events);
+		mutex_unlock(&dev->ev_mutex);
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
+	mutex_lock(&dev->ev_mutex);
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
+	mutex_unlock(&dev->ev_mutex);
+
+	return ret;
+}
+
+static int inotify_release(struct inode *ignored, struct file *file)
+{
+	struct inotify_device *dev = file->private_data;
+
+	inotify_destroy(dev->ih);
+
+	/* destroy all of the events on this device */
+	mutex_lock(&dev->ev_mutex);
+	while (!list_empty(&dev->events))
+		inotify_dev_event_dequeue(dev);
+	mutex_unlock(&dev->ev_mutex);
+
+	/* free this device: the put matching the get in inotify_init() */
+	put_inotify_dev(dev);
+
+	return 0;
+}
+
+static long inotify_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
+{
+	struct inotify_device *dev;
+	void __user *p;
+	int ret = -ENOTTY;
+
+	dev = file->private_data;
+	p = (void __user *) arg;
+
+	switch (cmd) {
+	case FIONREAD:
+		ret = put_user(dev->queue_size, (int __user *) p);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations inotify_fops = {
+	.poll           = inotify_poll,
+	.read           = inotify_read,
+	.release        = inotify_release,
+	.unlocked_ioctl = inotify_ioctl,
+	.compat_ioctl	= inotify_ioctl,
+};
+
+static const struct inotify_operations inotify_user_ops = {
+	.handle_event	= inotify_dev_queue_event,
+	.destroy_watch	= free_inotify_user_watch,
+};
+
+asmlinkage long sys_inotify_init(void)
+{
+	struct inotify_device *dev;
+	struct inotify_handle *ih;
+	struct user_struct *user;
+	struct file *filp;
+	int fd, ret;
+
+	fd = get_unused_fd();
+	if (fd < 0)
+		return fd;
+
+	filp = get_empty_filp();
+	if (!filp) {
+		ret = -ENFILE;
+		goto out_put_fd;
+	}
+
+	user = get_uid(current->user);
+	if (unlikely(atomic_read(&user->inotify_devs) >=
+			inotify_max_user_instances)) {
+		ret = -EMFILE;
+		goto out_free_uid;
+	}
+
+	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
+	if (unlikely(!dev)) {
+		ret = -ENOMEM;
+		goto out_free_uid;
+	}
+
+	ih = inotify_init(&inotify_user_ops);
+	if (unlikely(IS_ERR(ih))) {
+		ret = PTR_ERR(ih);
+		goto out_free_dev;
+	}
+	dev->ih = ih;
+
+	filp->f_op = &inotify_fops;
+	filp->f_vfsmnt = mntget(inotify_mnt);
+	filp->f_dentry = dget(inotify_mnt->mnt_root);
+	filp->f_mapping = filp->f_dentry->d_inode->i_mapping;
+	filp->f_mode = FMODE_READ;
+	filp->f_flags = O_RDONLY;
+	filp->private_data = dev;
+
+	INIT_LIST_HEAD(&dev->events);
+	init_waitqueue_head(&dev->wq);
+	mutex_init(&dev->ev_mutex);
+	mutex_init(&dev->up_mutex);
+	dev->event_count = 0;
+	dev->queue_size = 0;
+	dev->max_events = inotify_max_queued_events;
+	dev->user = user;
+	atomic_set(&dev->count, 0);
+
+	get_inotify_dev(dev);
+	atomic_inc(&user->inotify_devs);
+	fd_install(fd, filp);
+
+	return fd;
+out_free_dev:
+	kfree(dev);
+out_free_uid:
+	free_uid(user);
+	put_filp(filp);
+out_put_fd:
+	put_unused_fd(fd);
+	return ret;
+}
+
+asmlinkage long sys_inotify_add_watch(int fd, const char __user *path, u32 mask)
+{
+	struct inode *inode;
+	struct inotify_device *dev;
+	struct nameidata nd;
+	struct file *filp;
+	int ret, fput_needed;
+	unsigned flags = 0;
+
+	filp = fget_light(fd, &fput_needed);
+	if (unlikely(!filp))
+		return -EBADF;
+
+	/* verify that this is indeed an inotify instance */
+	if (unlikely(filp->f_op != &inotify_fops)) {
+		ret = -EINVAL;
+		goto fput_and_out;
+	}
+
+	if (!(mask & IN_DONT_FOLLOW))
+		flags |= LOOKUP_FOLLOW;
+	if (mask & IN_ONLYDIR)
+		flags |= LOOKUP_DIRECTORY;
+
+	ret = find_inode(path, &nd, flags);
+	if (unlikely(ret))
+		goto fput_and_out;
+
+	/* inode held in place by reference to nd; dev by fget on fd */
+	inode = nd.dentry->d_inode;
+	dev = filp->private_data;
+
+	mutex_lock(&dev->up_mutex);
+	ret = inotify_find_update_watch(dev->ih, inode, mask);
+	if (ret == -ENOENT)
+		ret = create_watch(dev, inode, mask);
+	mutex_unlock(&dev->up_mutex);
+
+	path_release(&nd);
+fput_and_out:
+	fput_light(filp, fput_needed);
+	return ret;
+}
+
+asmlinkage long sys_inotify_rm_watch(int fd, u32 wd)
+{
+	struct file *filp;
+	struct inotify_device *dev;
+	int ret, fput_needed;
+
+	filp = fget_light(fd, &fput_needed);
+	if (unlikely(!filp))
+		return -EBADF;
+
+	/* verify that this is indeed an inotify instance */
+	if (unlikely(filp->f_op != &inotify_fops)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev = filp->private_data;
+
+	/* we free our watch data when we get IN_IGNORED */
+	ret = inotify_rm_wd(dev->ih, wd);
+
+out:
+	fput_light(filp, fput_needed);
+	return ret;
+}
+
+static struct super_block *
+inotify_get_sb(struct file_system_type *fs_type, int flags,
+	       const char *dev_name, void *data)
+{
+    return get_sb_pseudo(fs_type, "inotify", NULL, 0xBAD1DEA);
+}
+
+static struct file_system_type inotify_fs_type = {
+    .name           = "inotifyfs",
+    .get_sb         = inotify_get_sb,
+    .kill_sb        = kill_anon_super,
+};
+
+/*
+ * inotify_user_setup - Our initialization function.  Note that we cannnot return
+ * error because we have compiled-in VFS hooks.  So an (unlikely) failure here
+ * must result in panic().
+ */
+static int __init inotify_user_setup(void)
+{
+	int ret;
+
+	ret = register_filesystem(&inotify_fs_type);
+	if (unlikely(ret))
+		panic("inotify: register_filesystem returned %d!\n", ret);
+
+	inotify_mnt = kern_mount(&inotify_fs_type);
+	if (IS_ERR(inotify_mnt))
+		panic("inotify: kern_mount ret %ld!\n", PTR_ERR(inotify_mnt));
+
+	inotify_max_queued_events = 16384;
+	inotify_max_user_instances = 128;
+	inotify_max_user_watches = 8192;
+
+	watch_cachep = kmem_cache_create("inotify_watch_cache",
+					 sizeof(struct inotify_user_watch),
+					 0, SLAB_PANIC, NULL, NULL);
+	event_cachep = kmem_cache_create("inotify_event_cache",
+					 sizeof(struct inotify_kernel_event),
+					 0, SLAB_PANIC, NULL, NULL);
+
+	return 0;
+}
+
+module_init(inotify_user_setup);
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 11438ef..a9d3044 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -54,16 +54,18 @@ static inline void fsnotify_move(struct 
 
 	if (isdir)
 		isdir = IN_ISDIR;
-	inotify_inode_queue_event(old_dir, IN_MOVED_FROM|isdir,cookie,old_name);
-	inotify_inode_queue_event(new_dir, IN_MOVED_TO|isdir, cookie, new_name);
+	inotify_inode_queue_event(old_dir, IN_MOVED_FROM|isdir,cookie,old_name,
+				  source);
+	inotify_inode_queue_event(new_dir, IN_MOVED_TO|isdir, cookie, new_name,
+				  source);
 
 	if (target) {
-		inotify_inode_queue_event(target, IN_DELETE_SELF, 0, NULL);
+		inotify_inode_queue_event(target, IN_DELETE_SELF, 0, NULL, NULL);
 		inotify_inode_is_dead(target);
 	}
 
 	if (source) {
-		inotify_inode_queue_event(source, IN_MOVE_SELF, 0, NULL);
+		inotify_inode_queue_event(source, IN_MOVE_SELF, 0, NULL, NULL);
 	}
 	audit_inode_child(old_name, source, old_dir->i_ino);
 	audit_inode_child(new_name, target, new_dir->i_ino);
@@ -85,7 +87,7 @@ static inline void fsnotify_nameremove(s
  */
 static inline void fsnotify_inoderemove(struct inode *inode)
 {
-	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL, NULL);
 	inotify_inode_is_dead(inode);
 }
 
@@ -95,7 +97,8 @@ static inline void fsnotify_inoderemove(
 static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
 {
 	inode_dir_notify(inode, DN_CREATE);
-	inotify_inode_queue_event(inode, IN_CREATE, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_CREATE, 0, dentry->d_name.name,
+				  dentry->d_inode);
 	audit_inode_child(dentry->d_name.name, dentry->d_inode, inode->i_ino);
 }
 
@@ -106,7 +109,7 @@ static inline void fsnotify_mkdir(struct
 {
 	inode_dir_notify(inode, DN_CREATE);
 	inotify_inode_queue_event(inode, IN_CREATE | IN_ISDIR, 0, 
-				  dentry->d_name.name);
+				  dentry->d_name.name, dentry->d_inode);
 	audit_inode_child(dentry->d_name.name, dentry->d_inode, inode->i_ino);
 }
 
@@ -123,7 +126,7 @@ static inline void fsnotify_access(struc
 
 	dnotify_parent(dentry, DN_ACCESS);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -139,7 +142,7 @@ static inline void fsnotify_modify(struc
 
 	dnotify_parent(dentry, DN_MODIFY);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -154,7 +157,7 @@ static inline void fsnotify_open(struct 
 		mask |= IN_ISDIR;
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);	
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -172,7 +175,7 @@ static inline void fsnotify_close(struct
 		mask |= IN_ISDIR;
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -187,7 +190,7 @@ static inline void fsnotify_xattr(struct
 		mask |= IN_ISDIR;
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -234,7 +237,7 @@ static inline void fsnotify_change(struc
 	if (in_mask) {
 		if (S_ISDIR(inode->i_mode))
 			in_mask |= IN_ISDIR;
-		inotify_inode_queue_event(inode, in_mask, 0, NULL);
+		inotify_inode_queue_event(inode, in_mask, 0, NULL, NULL);
 		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
 						  dentry->d_name.name);
 	}
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index 71aa155..96c4f73 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -49,7 +49,7 @@ #define IN_MOVE			(IN_MOVED_FROM | IN_MO
 /* special flags */
 #define IN_ONLYDIR		0x01000000	/* only watch the path if it is a directory */
 #define IN_DONT_FOLLOW		0x02000000	/* don't follow a sym link */
-#define IN_MASK_ADD		0x20000000	/* add to the mask of an already existing watch */
+#define IN_MASK_ADD		0x20000000	/* add to the mask of an alreadyexisting watch */
 #define IN_ISDIR		0x40000000	/* event occurred against dir */
 #define IN_ONESHOT		0x80000000	/* only send event once */
 
@@ -68,18 +68,65 @@ #ifdef __KERNEL__
 #include <linux/dcache.h>
 #include <linux/fs.h>
 
+/*
+ * struct inotify_watch - represents a watch request on a specific inode
+ *
+ * h_list is protected by ih->mutex of the associated inotify_handle.
+ * i_list, mask are protected by inode->inotify_mutex of the associated inode.
+ * ih, inode, and wd are never written to once the watch is created.
+ *
+ * Callers must use the established inotify interfaces to access inotify_watch
+ * contents.  The content of this structure is private to the inotify
+ * implementation.
+ */
+struct inotify_watch {
+	struct list_head	h_list;	/* entry in inotify_handle's list */
+	struct list_head	i_list;	/* entry in inode's list */
+	atomic_t		count;	/* reference count */
+	struct inotify_handle	*ih;	/* associated inotify handle */
+	struct inode		*inode;	/* associated inode */
+	__s32			wd;	/* watch descriptor */
+	__u32			mask;	/* event mask for this watch */
+};
+
+struct inotify_operations {
+	void (*handle_event)(struct inotify_watch *, u32, u32, u32,
+			     const char *, struct inode *);
+	void (*destroy_watch)(struct inotify_watch *);
+};
+
 #ifdef CONFIG_INOTIFY
 
+/* Kernel API for producing events */
+
 extern void inotify_d_instantiate(struct dentry *, struct inode *);
 extern void inotify_d_move(struct dentry *);
 extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
-				      const char *);
+				      const char *, struct inode *);
 extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
 					      const char *);
 extern void inotify_unmount_inodes(struct list_head *);
 extern void inotify_inode_is_dead(struct inode *);
 extern u32 inotify_get_cookie(void);
 
+/* Kernel Consumer API */
+
+extern struct inotify_handle *inotify_init(const struct inotify_operations *);
+extern void inotify_init_watch(struct inotify_watch *);
+extern void inotify_destroy(struct inotify_handle *);
+extern __s32 inotify_find_watch(struct inotify_handle *, struct inode *,
+				struct inotify_watch **);
+extern __s32 inotify_find_update_watch(struct inotify_handle *, struct inode *,
+				       u32);
+extern __s32 inotify_add_watch(struct inotify_handle *, struct inotify_watch *,
+			       struct inode *, __u32);
+extern int inotify_rm_watch(struct inotify_handle *, struct inotify_watch *);
+extern int inotify_rm_wd(struct inotify_handle *, __u32);
+extern void inotify_remove_watch_locked(struct inotify_handle *,
+					struct inotify_watch *);
+extern void get_inotify_watch(struct inotify_watch *);
+extern void put_inotify_watch(struct inotify_watch *);
+
 #else
 
 static inline void inotify_d_instantiate(struct dentry *dentry,
@@ -93,7 +140,8 @@ static inline void inotify_d_move(struct
 
 static inline void inotify_inode_queue_event(struct inode *inode,
 					     __u32 mask, __u32 cookie,
-					     const char *filename)
+					     const char *filename,
+					     struct inode *a_inode)
 {
 }
 
@@ -116,6 +164,63 @@ static inline u32 inotify_get_cookie(voi
 	return 0;
 }
 
+static inline struct inotify_handle *inotify_init(const struct inotify_operations *)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void inotify_init_watch(struct inotify_watch *watch)
+{
+}
+
+static inline void inotify_destroy(struct inotify_handle *ih)
+{
+}
+
+static inline __s32 inotify_find_watch(struct inotify_handle *ih, struct inode *inode,
+				       struct inotify_watch **watchp)
+{
+	return -EOPNOTSUPP;
+}
+
+
+static inline __s32 inotify_find_update_watch(struct inotify_handle *ih,
+					      struct inode *inode, u32 mask)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline __s32 inotify_add_watch(struct inotify_handle *ih,
+				      struct inotify_watch *watch,
+				      struct inode *inode, __u32 mask)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int inotify_rm_watch(struct inotify_handle *ih,
+				   struct inotify_watch *watch)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int inotify_rm_wd(struct inotify_handle *ih, __u32 wd)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void inotify_remove_watch_locked(struct inotify_handle *ih,
+					       struct inotify_watch *watch)
+{
+}
+
+static inline void get_inotify_watch(struct inotify_watch *watch)
+{
+}
+
+static inline void put_inotify_watch(struct inotify_watch *watch)
+{
+}
+
 #endif	/* CONFIG_INOTIFY */
 
 #endif	/* __KERNEL __ */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 14a56ad..8e0122f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -500,7 +500,7 @@ struct user_struct {
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
-#ifdef CONFIG_INOTIFY
+#ifdef CONFIG_INOTIFY_USER
 	atomic_t inotify_watches; /* How many inotify watches does this user have? */
 	atomic_t inotify_devs;	/* How many inotify devs does this user have opened? */
 #endif
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 71463e7..ec1a1a3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -159,7 +159,7 @@ extern ctl_table random_table[];
 #ifdef CONFIG_UNIX98_PTYS
 extern ctl_table pty_table[];
 #endif
-#ifdef CONFIG_INOTIFY
+#ifdef CONFIG_INOTIFY_USER
 extern ctl_table inotify_table[];
 #endif
 
@@ -1100,7 +1100,7 @@ #ifdef CONFIG_MMU
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
 	},
-#ifdef CONFIG_INOTIFY
+#ifdef CONFIG_INOTIFY_USER
 	{
 		.ctl_name	= FS_INOTIFY,
 		.procname	= "inotify",
diff --git a/kernel/user.c b/kernel/user.c
index 2116642..4b1eb74 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -140,7 +140,7 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
 		atomic_set(&new->sigpending, 0);
-#ifdef CONFIG_INOTIFY
+#ifdef CONFIG_INOTIFY_USER
 		atomic_set(&new->inotify_watches, 0);
 		atomic_set(&new->inotify_devs, 0);
 #endif
