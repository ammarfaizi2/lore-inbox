Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUJARsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUJARsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 13:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUJARsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 13:48:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6859 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265395AbUJARre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:47:34 -0400
Subject: [patch] inotify: misc changes
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096410792.4365.3.camel@vertex>
References: <1096410792.4365.3.camel@vertex>
Content-Type: multipart/mixed; boundary="=-kXc2eA8HexY7JDFCvIJ7"
Date: Fri, 01 Oct 2004 13:46:09 -0400
Message-Id: <1096652769.7676.35.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kXc2eA8HexY7JDFCvIJ7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey hey, John!

Following patch is misc. changes between my tree and the last posted
inotify patch.

Most of the changes are cosmetic, coding style and such cleanup.

One non-cosmetic change is an optimization in inotify_dev_queue_event().
I cache the results of what was inotify_dev_get_event() and
list_to_inotify_kernel_event(), which cleans up the code a lot and saves
like seven dereferences.

Patch is on top of 0.11.0 and the previous chicanery I posted.

	Robert Love


--=-kXc2eA8HexY7JDFCvIJ7
Content-Disposition: attachment; filename=inotify-rml-misc-cleanup-1.patch
Content-Type: text/x-patch; name=inotify-rml-misc-cleanup-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

misc. cleanup of inotify

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   98 +++++++++++++++++++------------------------------
 1 files changed, 38 insertions(+), 60 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-30 18:54:56.946199760 -0400
+++ linux/drivers/char/inotify.c	2004-10-01 13:41:10.286490584 -0400
@@ -43,7 +43,7 @@
 
 #define MAX_INOTIFY_DEVS	  8	/* max open inotify devices */
 #define MAX_INOTIFY_DEV_WATCHERS  8192	/* max total watches */
-#define MAX_INOTIFY_QUEUED_EVENTS 256	/* max events queued on the dev*/
+#define MAX_INOTIFY_QUEUED_EVENTS 256	/* max events queued on the dev */
 
 static atomic_t watcher_count;
 static kmem_cache_t *watch_cachep;
@@ -85,9 +85,9 @@
 	__u32			mask;
 	struct inode *		inode;
 	struct inotify_device *	dev;
-	struct list_head	d_list; // device list
-	struct list_head	i_list; // inode list
-	struct list_head	u_list; // unmount list 
+	struct list_head	d_list;	/* device list */
+	struct list_head	i_list; /* inode list */
+	struct list_head	u_list; /* unmount list */
 };
 #define inotify_watcher_d_list(pos) list_entry((pos), struct inotify_watch, d_list)
 #define inotify_watcher_i_list(pos) list_entry((pos), struct inotify_watch, i_list)
@@ -102,7 +102,6 @@
         struct list_head        list;
 	struct inotify_event	event;
 };
-#define list_to_inotify_kernel_event(pos) list_entry((pos), struct inotify_kernel_event, list)
 
 /*
  * find_inode - resolve a user-given path to a specific inode and iget() it
@@ -175,17 +174,12 @@
 {
 	if (!kevent)
 		return;
-
-	INIT_LIST_HEAD(&kevent->list);
-	kevent->event.wd = -1;
-	kevent->event.mask = 0;
-
 	iprintk(INOTIFY_DEBUG_ALLOC, "free'd kevent %p\n", kevent);
 	kmem_cache_free(event_cachep, kevent);
 }
 
-#define inotify_dev_has_events(dev) (!list_empty(&dev->events))
-#define inotify_dev_get_event(dev) (list_to_inotify_kernel_event(dev->events.next))
+#define inotify_dev_has_events(dev)	(!list_empty(&dev->events))
+
 /* Does this events mask get sent to the watcher ? */
 #define event_and(event_mask,watchers_mask) 	((event_mask == IN_UNMOUNT) || \
 						(event_mask == IN_IGNORED) || \
@@ -200,21 +194,21 @@
 				    struct inotify_watch *watcher,
 				    __u32 mask, const char *filename)
 {
-	struct inotify_kernel_event *kevent;
+	struct inotify_kernel_event *kevent, *last;
 
 	/*
 	 * Check if the new event is a duplicate of the last event queued.
 	 */
-	if (dev->event_count && 
-		inotify_dev_get_event(dev)->event.mask == mask &&
-		inotify_dev_get_event(dev)->event.wd == watcher->wd) {
-
+	last = list_entry(dev->events.next, struct inotify_kernel_event, list);	
+	if (dev->event_count && last->event.mask == mask &&
+			last->event.wd == watcher->wd) {
 		/* Check if the filenames match */
-		if (!filename && inotify_dev_get_event(dev)->event.filename[0] == '\0')
+		if (!filename && last->event.filename[0] == '\0')
 			return;
-		if (filename && !strcmp(inotify_dev_get_event(dev)->event.filename, filename))
+		if (filename && !strcmp(last->event.filename, filename))
 			return;
 	}
+
 	/*
 	 * the queue has already overflowed and we have already sent the
 	 * Q_OVERFLOW event
@@ -370,7 +364,7 @@
  * Caller must hold dev->lock.
  */
 static struct inotify_watch *inode_find_dev(struct inode *inode,
-					      struct inotify_device *dev)
+					    struct inotify_device *dev)
 {
 	struct inotify_watch *watcher;
 
@@ -390,11 +384,12 @@
 		if (watcher->wd == wd)
 			return watcher;
 	}
+
 	return NULL;
 }
 
 static int inotify_dev_is_watching_inode(struct inotify_device *dev,
-					  struct inode *inode)
+					 struct inode *inode)
 {
 	struct inotify_watch *watcher;
 
@@ -409,28 +404,17 @@
 static int inotify_dev_add_watcher(struct inotify_device *dev,
 				   struct inotify_watch *watcher)
 {
-	int error;
-
-	error = 0;
-
-	if (!dev || !watcher) {
-		error = -EINVAL;
-		goto out;
-	}
+	if (!dev || !watcher)
+		return -EINVAL;
 
-	if (dev_find_wd (dev, watcher->wd)) {
-		error = -EINVAL;
-		goto out;
-	}
+	if (dev_find_wd (dev, watcher->wd))
+		return -EINVAL;
 
-	if (dev->nr_watches == MAX_INOTIFY_DEV_WATCHERS) {
-		error = -ENOSPC;
-		goto out;
-	}
+	if (dev->nr_watches == MAX_INOTIFY_DEV_WATCHERS)
+		return -ENOSPC;
 
 	list_add(&watcher->d_list, &dev->watchers);
-out:
-	return error;
+	return 0;
 }
 
 /*
@@ -441,16 +425,13 @@
 static int inotify_dev_rm_watcher(struct inotify_device *dev,
 				  struct inotify_watch *watcher)
 {
-	int error;
+	if (!watcher)
+		return -EINVAL;
 
-	error = -EINVAL;
-	if (watcher) {
-		inotify_dev_queue_event(dev, watcher, IN_IGNORED, NULL);
-		list_del(&watcher->d_list);
-		error = 0;
-	} 
+	inotify_dev_queue_event(dev, watcher, IN_IGNORED, NULL);
+	list_del(&watcher->d_list);
 
-	return error;
+	return 0;
 }
 
 void inode_update_watchers_mask(struct inode *inode)
@@ -521,7 +502,7 @@
 				    struct inode *inode2, __u32 mask2,
 				    const char *filename2)
 {
-	struct inotify_watch *watcher;
+	struct inotify_watch *watch;
 
 	if (inode1 < inode2) {
 		spin_lock(&inode1->i_lock);
@@ -531,18 +512,16 @@
 		spin_lock(&inode1->i_lock);
 	}
 
-	list_for_each_entry(watcher, &inode1->watchers, i_list) {
-		spin_lock(&watcher->dev->lock);
-		inotify_dev_queue_event(watcher->dev, watcher,
-					mask1, filename1);
-		spin_unlock(&watcher->dev->lock);
+	list_for_each_entry(watch, &inode1->watchers, i_list) {
+		spin_lock(&watch->dev->lock);
+		inotify_dev_queue_event(watch->dev, watch, mask1, filename1);
+		spin_unlock(&watch->dev->lock);
 	}
 
-	list_for_each_entry(watcher, &inode2->watchers, i_list) {
-		spin_lock(&watcher->dev->lock);
-		inotify_dev_queue_event(watcher->dev, watcher,
-					mask2, filename2);
-		spin_unlock(&watcher->dev->lock);
+	list_for_each_entry(watch, &inode2->watchers, i_list) {
+		spin_lock(&watch->dev->lock);
+		inotify_dev_queue_event(watch->dev, watch, mask2, filename2);
+		spin_unlock(&watch->dev->lock);
 	}
 
 	spin_unlock(&inode2->i_lock);
@@ -600,7 +579,7 @@
  * Caller must hold inode_lock.
  */
 static void build_umount_list(struct list_head *head, struct super_block *sb,
-			       struct list_head *umount)
+			      struct list_head *umount)
 {
 	struct inode *inode;
 
@@ -780,7 +759,6 @@
 		inotify_dev_event_dequeue(dev);
 }
 
-
 static int inotify_release(struct inode *inode, struct file *file)
 {
 	struct inotify_device *dev;

--=-kXc2eA8HexY7JDFCvIJ7--

