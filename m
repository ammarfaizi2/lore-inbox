Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUI1VsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUI1VsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUI1VsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:48:21 -0400
Received: from peabody.ximian.com ([130.57.169.10]:26801 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268053AbUI1Vr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:47:28 -0400
Subject: [patch] inotify: use the idr layer
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-903Nt7lx05yBKo4yfLEw"
Date: Tue, 28 Sep 2004 17:46:04 -0400
Message-Id: <1096407964.4911.90.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-903Nt7lx05yBKo4yfLEw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

OK, I told John I would post this ASAP, as soon as I finished testing
it, but I got backed up, so here it is without much testing.  It does
compile fine.

This patch removes our current bitmap-based allocation system and
replaces it with the idr layer.  The idr layer allows us to use a radix
tree, rooted at each device instance, to trivially map between watcher
descriptors and watcher structures.  In idr terminology, the watcher
descriptor is the id and the watcher structure is the pointer.

Allocating a new watcher descriptor and associating it with a given
watcher structure is done in the same place as before,
inotify_dev_get_wd().  The code for doing this is a bit weird.  The idr
layer's interface leaves a bit to be desired.

The function dev_find_wd() is used to map from a given watcher
descriptor to a watcher structure.  This used to be our least scalable
function: O(n), but at a small fixed n, so you could call it O(1).  Now
it is O(lg n); n is still fixed, so you can still call it O(1).

I also cleaned up some locking and added some comments.

Like I said, I have not tested this, probably won't until tomorrow, but
here it is to play with earlier if anyone so chooses.  The idr layer is
rather nice for this sort of thing.

Patch is on top of all of my previous patches.

	Robert Love


--=-903Nt7lx05yBKo4yfLEw
Content-Disposition: attachment; filename=inotify-idr-layer-1.patch
Content-Type: text/x-patch; name=inotify-idr-layer-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

idr layer support for inotify

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   93 +++++++++++++++++++++++++++----------------------
 1 files changed, 53 insertions(+), 40 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-28 15:22:02.152818864 -0400
+++ linux/drivers/char/inotify.c	2004-09-28 15:27:03.994931888 -0400
@@ -17,15 +17,14 @@
 /* TODO: 
  * rename inotify_watcher to inotify_watch
  * need a way to connect MOVED_TO/MOVED_FROM events in user space
- * use b-tree so looking up watch by WD is faster
  */
 
 #include <linux/bitops.h>
-#include <linux/bitmap.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
@@ -61,22 +60,19 @@
  * For each inotify device, we need to keep track of the events queued on it,
  * a list of the inodes that we are watching, and so on.
  *
- * 'bitmask' holds one bit for each possible watcher descriptor: a set bit
- * implies that the given WD is valid, unset implies it is not.
- *
  * This structure is protected by 'lock'.  Lock ordering:
  *	dev->lock
  *		dev->wait->lock
  * FIXME: Define lock ordering wrt inode and dentry locking!
  */
 struct inotify_device {
-	DECLARE_BITMAP(bitmask, MAX_INOTIFY_DEV_WATCHERS);
 	wait_queue_head_t 	wait;
+	struct idr		idr;
 	struct list_head 	events;
 	struct list_head 	watchers;
 	spinlock_t		lock;
 	unsigned int		event_count;
-	int			nr_watches;
+	unsigned int		nr_watches;
 };
 
 struct inotify_watcher {
@@ -179,10 +175,6 @@
 		return;
 
 	event_object_count--;
-	INIT_LIST_HEAD(&kevent->list);
-	kevent->event.wd = -1;
-	kevent->event.mask = 0;
-
 	iprintk(INOTIFY_DEBUG_ALLOC, "free'd kevent %p\n", kevent);
 	kmem_cache_free(kevent_cache, kevent);
 }
@@ -282,20 +274,30 @@
 /*
  * inotify_dev_get_wd - returns the next WD for use by the given dev
  *
- * Caller must hold dev->lock before calling.
+ * This function sleeps.
  */
-static int inotify_dev_get_wd(struct inotify_device *dev)
+static int inotify_dev_get_wd(struct inotify_device *dev,
+			      struct inotify_watcher *watcher)
 {
-	int wd;
+	int ret;
 
-	if (!dev || dev->nr_watches == MAX_INOTIFY_DEV_WATCHERS)
+	if (dev->nr_watches == MAX_INOTIFY_DEV_WATCHERS)
 		return -1;
 
+repeat:
+	if (!idr_pre_get(&dev->idr, GFP_KERNEL))
+		return -1;
+
+	spin_lock(&dev->lock);
+	ret = idr_get_new(&dev->idr, watcher, &watcher->wd);
+	spin_lock(&dev->lock);
+	if (ret == -EAGAIN)	/* more memory is required, try again */
+		goto repeat;
+	if (ret == -ENOSPC)	/* the idr is full! */
+		return -1;
 	dev->nr_watches++;
-	wd = find_first_zero_bit(dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);
-	set_bit(wd, dev->bitmask);
 
-	return wd;
+	return 0;
 }
 
 /*
@@ -309,7 +311,7 @@
 		return -1;
 
 	dev->nr_watches--;
-	clear_bit(wd, dev->bitmask);
+	idr_remove(&dev->idr, wd);
 
 	return 0;
 }
@@ -331,7 +333,6 @@
 		return NULL;
 	}
 
-	watcher->wd = -1;
 	watcher->mask = mask;
 	watcher->inode = inode;
 	watcher->dev = dev;
@@ -339,11 +340,7 @@
 	INIT_LIST_HEAD(&watcher->i_list);
 	INIT_LIST_HEAD(&watcher->u_list);
 
-	spin_lock(&dev->lock);
-	watcher->wd = inotify_dev_get_wd(dev);
-	spin_unlock(&dev->lock);
-
-	if (watcher->wd < 0) {
+	if (inotify_dev_get_wd(dev, watcher)) {
 		iprintk(INOTIFY_DEBUG_ERRORS,
 			"Could not get wd for watcher %p\n", watcher);
 		iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
@@ -387,15 +384,18 @@
 	return NULL;
 }
 
-static struct inotify_watcher *dev_find_wd(struct inotify_device *dev, int wd)
+/*
+ * dev_find_wd - given a (dev,wd) pair, returns the matching inotify_watcher
+ *
+ * Returns the results of looking up (dev,wd) in the idr layer.  NULL is
+ * returned on error.
+ *
+ * The caller must hold dev->lock.
+ */
+static inline struct inotify_watcher *dev_find_wd(struct inotify_device *dev,
+						  int wd)
 {
-	struct inotify_watcher *watcher;
-
-	list_for_each_entry(watcher, &dev->watchers, d_list) {
-		if (watcher->wd == wd)
-			return watcher;
-	}
-	return NULL;
+	return idr_find(&dev->idr, wd);
 }
 
 static int inotify_dev_is_watching_inode(struct inotify_device *dev,
@@ -411,6 +411,11 @@
 	return 0;
 }
 
+/*
+ * inotify_dev_add_watcher - add the given watcher to the given device instance
+ *
+ * Caller must hold dev->lock.
+ */
 static int inotify_dev_add_watcher(struct inotify_device *dev,
 				   struct inotify_watcher *watcher)
 {
@@ -570,11 +575,11 @@
 	struct inotify_device *dev;
 	struct inode *inode;
 
-	spin_lock(&watcher->dev->lock);
-	spin_lock(&watcher->inode->i_lock);
-
-	inode = watcher->inode;
 	dev = watcher->dev;
+	inode = watcher->inode;
+
+	spin_lock(&dev->lock);
+	spin_lock(&inode->i_lock);
 
 	if (event)
 		inotify_dev_queue_event(dev, watcher, event, NULL);
@@ -590,7 +595,8 @@
 	unref_inode(inode);
 }
 
-static void process_umount_list(struct list_head *umount) {
+static void process_umount_list(struct list_head *umount)
+{
 	struct inotify_watcher *watcher, *next;
 
 	list_for_each_entry_safe(watcher, next, umount, u_list)
@@ -598,7 +604,7 @@
 }
 
 static void build_umount_list(struct list_head *head, struct super_block *sb,
-			       struct list_head *umount)
+			      struct list_head *umount)
 {
 	struct inode *	inode;
 
@@ -766,7 +772,7 @@
 	if (!dev)
 		return -ENOMEM;
 
-	bitmap_zero(dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);
+	idr_init(&dev->idr);
 
 	INIT_LIST_HEAD(&dev->events);
 	INIT_LIST_HEAD(&dev->watchers);
@@ -898,9 +904,16 @@
 {
 	struct inotify_watcher *watcher;
 
+	/*
+	 * FIXME: Silly to grab dev->lock here and then drop it, when
+	 * ignore_helper() grabs it anyway a few lines down.
+	 */
+	spin_lock(&dev->lock);
 	watcher = dev_find_wd(dev, wd);
+	spin_unlock(&dev->lock);
 	if (!watcher)
 		return -EINVAL;
+
 	ignore_helper(watcher, 0);
 
 	return 0;

--=-903Nt7lx05yBKo4yfLEw--

