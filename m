Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUJDSQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUJDSQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUJDSQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:16:14 -0400
Received: from peabody.ximian.com ([130.57.169.10]:40662 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267863AbUJDSPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:15:30 -0400
Subject: [patch] inotify locking and other misc.
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096865816.3827.1.camel@vertex>
References: <1096865816.3827.1.camel@vertex>
Content-Type: multipart/mixed; boundary="=-MH5MpwI6r7c7nfOM6oGC"
Date: Mon, 04 Oct 2004 14:13:59 -0400
Message-Id: <1096913639.17426.29.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MH5MpwI6r7c7nfOM6oGC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Greetings from Down Under, John.  Just kidding, I am in Boston.

Anyhow.

Attached patch brings inotify-0.12 in line with my tree.  It looks like
some or all of the crucial locking patch was not merged.

Here is what the original locking patch did:

        - More locking documentation/comments
        - Respect lock ranking when locking two different
          inodes' i_lock
        - Don't grab dentry->d_lock and just use dget_parent(). [1]
        - Respect lock ranking with dev->lock vs. inode->i_lock.
        - inotify_release_all_watches() needed dev->lock.
        - misc. cleanup

This diff also has a few misc. changes to bring our trees in sync (which
was a lot of work after the s/watchers/watches/ change!).

Patch is on top of 0.12.

	Robert Love


--=-MH5MpwI6r7c7nfOM6oGC
Content-Disposition: attachment; filename=inotify-0.12-rml-locking-1.patch
Content-Type: text/x-patch; name=inotify-0.12-rml-locking-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

inotify locking updates and other misc. changes

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   87 +++++++++++++++++++++++++++++--------------------
 1 files changed, 52 insertions(+), 35 deletions(-)

diff -urN linux-inotify-0.12/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify-0.12/drivers/char/inotify.c	2004-10-04 11:57:40.189179408 -0400
+++ linux/drivers/char/inotify.c	2004-10-04 14:04:28.691511240 -0400
@@ -43,7 +43,7 @@
 #include <linux/inotify.h>
 
 #define MAX_INOTIFY_DEVS	  8	/* max open inotify devices */
-#define MAX_INOTIFY_DEV_WATCHES  8192	/* max total watches */
+#define MAX_INOTIFY_DEV_WATCHES   8192	/* max total watches */
 #define MAX_INOTIFY_QUEUED_EVENTS 256	/* max events queued on the dev */
 
 static atomic_t watch_count;
@@ -64,9 +64,12 @@
  * implies that the given WD is valid, unset implies it is not.
  *
  * This structure is protected by 'lock'.  Lock ordering:
+ *
+ * inode->i_lock
  *	dev->lock
  *		dev->wait->lock
- * FIXME: Define lock ordering wrt inode and dentry locking!
+ *
+ * FIXME: Look at replacing i_lock with i_sem.
  */
 struct inotify_device {
 	DECLARE_BITMAP(bitmask, MAX_INOTIFY_DEV_WATCHES);
@@ -311,7 +314,7 @@
  * Grabs dev->lock, so the caller must not hold it.
  */
 static struct inotify_watch *create_watch(struct inotify_device *dev,
-					      __u32 mask, struct inode *inode)
+					  __u32 mask, struct inode *inode)
 {
 	struct inotify_watch *watch;
 
@@ -322,7 +325,6 @@
 		return NULL;
 	}
 
-	watch->wd = -1;
 	watch->mask = mask;
 	watch->inode = inode;
 	watch->dev = dev;
@@ -467,7 +469,8 @@
 	 * This inode doesn't have an inotify_data structure attached to it
 	 */
 	if (!inode->inotify_data) {
-		inode->inotify_data = kmalloc(sizeof(struct inotify_inode_data), GFP_ATOMIC);
+		inode->inotify_data = kmalloc(sizeof(struct inotify_inode_data),
+					      GFP_ATOMIC);
 		INIT_LIST_HEAD(&inode->inotify_data->watches);
 		inode->inotify_data->watch_mask = 0;
 		inode->inotify_data->watch_count = 0;
@@ -525,12 +528,9 @@
 {
 	struct dentry *parent;
 
-	spin_lock(&dentry->d_lock);
-	dget(dentry->d_parent);
-	parent = dentry->d_parent;
+	parent = dget_parent(dentry);
 	inotify_inode_queue_event(parent->d_inode, mask, filename);
 	dput(parent);
-	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL_GPL(inotify_dentry_parent_queue_event);
 
@@ -539,8 +539,8 @@
 	struct inotify_device *dev;
 	struct inode *inode;
 
-	spin_lock(&watch->dev->lock);
 	spin_lock(&watch->inode->i_lock);
+	spin_lock(&watch->dev->lock);
 
 	inode = watch->inode;
 	dev = watch->dev;
@@ -552,24 +552,30 @@
 	inotify_dev_rm_watch(watch->dev, watch);
 	list_del(&watch->u_list);
 
-	spin_unlock(&inode->i_lock);
 	delete_watch(dev, watch);
 	spin_unlock(&dev->lock);
+	spin_unlock(&inode->i_lock);
 
 	unref_inode(inode);
 }
 
-static void process_umount_list(struct list_head *umount) {
+static void process_umount_list(struct list_head *umount)
+{
 	struct inotify_watch *watch, *next;
 
 	list_for_each_entry_safe(watch, next, umount, u_list)
 		ignore_helper(watch, IN_UNMOUNT);
 }
 
+/*
+ * build_umount_list - build a list of watches affected by an unmount.
+ *
+ * Caller must hold inode_lock.
+ */
 static void build_umount_list(struct list_head *head, struct super_block *sb,
 			      struct list_head *umount)
 {
-	struct inode *	inode;
+	struct inode *inode;
 
 	list_for_each_entry(inode, head, i_list) {
 		struct inotify_watch *watch;
@@ -603,6 +609,11 @@
 }
 EXPORT_SYMBOL_GPL(inotify_super_block_umount);
 
+/*
+ * inotify_inode_is_dead - an inode has been deleted, cleanup any watches
+ *
+ * FIXME: Callers need to always hold inode->i_lock.
+ */
 void inotify_inode_is_dead(struct inode *inode)
 {
 	struct inotify_watch *watch, *next;
@@ -610,7 +621,8 @@
 	if (!inode->inotify_data)
 		return;
 
-	list_for_each_entry_safe(watch, next, &inode->inotify_data->watches, i_list)
+	list_for_each_entry_safe(watch, next, &inode->inotify_data->watches,
+				 i_list)
 		ignore_helper(watch, 0);
 }
 EXPORT_SYMBOL_GPL(inotify_inode_is_dead);
@@ -724,6 +736,11 @@
 	return 0;
 }
 
+/*
+ * inotify_release_all_watches - destroy all watches on a given device
+ *
+ * Caller must hold dev->lock.
+ */
 static void inotify_release_all_watches(struct inotify_device *dev)
 {
 	struct inotify_watch *watch,*next;
@@ -734,13 +751,13 @@
 
 /*
  * inotify_release_all_events - destroy all of the events on a given device
+ *
+ * Caller must hold dev->lock.
  */
 static void inotify_release_all_events(struct inotify_device *dev)
 {
-	spin_lock(&dev->lock);
 	while (inotify_dev_has_events(dev))
 		inotify_dev_event_dequeue(dev);
-	spin_unlock(&dev->lock);
 }
 
 static int inotify_release(struct inode *inode, struct file *file)
@@ -748,8 +765,10 @@
 	struct inotify_device *dev;
 
 	dev = file->private_data;
+	spin_lock(&dev->lock);
 	inotify_release_all_watches(dev);
 	inotify_release_all_events(dev);
+	spin_unlock(&dev->lock);
 	kfree(dev);
 
 	printk(KERN_ALERT "inotify device released\n");
@@ -761,22 +780,18 @@
 static int inotify_watch(struct inotify_device *dev,
 			 struct inotify_watch_request *request)
 {
-	int err;
 	struct inode *inode;
 	struct inotify_watch *watch;
-	err = 0;
 
 	inode = find_inode(request->dirname);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		goto exit;
-	}
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	if (!S_ISDIR(inode->i_mode))
 		iprintk(INOTIFY_DEBUG_ERRORS, "watching file\n");
 
-	spin_lock(&dev->lock);
 	spin_lock(&inode->i_lock);
+	spin_lock(&dev->lock);
 
 	/*
 	 * This handles the case of re-adding a directory we are already
@@ -791,15 +806,15 @@
 		owatch = inode_find_dev(inode, dev);
 		owatch->mask = request->mask;
 		inode_update_watch_mask(inode);
-		spin_unlock(&inode->i_lock);
 		spin_unlock(&dev->lock);
+		spin_unlock(&inode->i_lock);		
 		unref_inode(inode);
 
 		return 0;
 	}
 
-	spin_unlock(&inode->i_lock);
 	spin_unlock(&dev->lock);
+	spin_unlock(&inode->i_lock);	
 
 	watch = create_watch(dev, request->mask, inode);
 	if (!watch) {
@@ -807,31 +822,26 @@
 		return -ENOSPC;
 	}
 
-	spin_lock(&dev->lock);
 	spin_lock(&inode->i_lock);
+	spin_lock(&dev->lock);
 
 	/* We can't add anymore watches to this device */
 	if (inotify_dev_add_watch(dev, watch) == -ENOSPC) {
 		iprintk(INOTIFY_DEBUG_ERRORS,
 			"can't add watch dev is full\n");
-		spin_unlock(&inode->i_lock);
 		delete_watch(dev, watch);
 		spin_unlock(&dev->lock);
-
+		spin_unlock(&inode->i_lock);		
 		unref_inode(inode);
 		return -ENOSPC;
 	}
 
 	inode_add_watch(inode, watch);
 
-	/* we keep a reference on the inode */
-	if (!err)
-		err = watch->wd;
-
-	spin_unlock(&inode->i_lock);
 	spin_unlock(&dev->lock);
-exit:
-	return err;
+	spin_unlock(&inode->i_lock);
+
+	return watch->wd;
 }
 
 static int inotify_ignore(struct inotify_device *dev, int wd)
@@ -875,6 +885,13 @@
 	spin_unlock(&dev->lock);
 }
 
+/*
+ * inotify_ioctl() - our device file's ioctl method
+ *
+ * The VFS serializes all of our calls via the BKL and we rely on that.  We
+ * could, alternatively, grab dev->lock.  Right now lower levels grab that
+ * where needed.
+ */
 static int inotify_ioctl(struct inode *ip, struct file *fp,
 			 unsigned int cmd, unsigned long arg)
 {

--=-MH5MpwI6r7c7nfOM6oGC--

