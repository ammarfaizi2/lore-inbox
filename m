Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269435AbUI3TYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269435AbUI3TYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269453AbUI3TWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:22:36 -0400
Received: from peabody.ximian.com ([130.57.169.10]:14019 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269458AbUI3TSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:18:42 -0400
Subject: Re: [patch] inotify: locking
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096570886.4203.36.camel@betsy.boston.ximian.com>
References: <1096410792.4365.3.camel@vertex>
	 <1096570886.4203.36.camel@betsy.boston.ximian.com>
Content-Type: multipart/mixed; boundary="=-QgazXXiIekbo4X2Maxs+"
Date: Thu, 30 Sep 2004 15:17:19 -0400
Message-Id: <1096571839.4203.41.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QgazXXiIekbo4X2Maxs+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-09-30 at 15:01 -0400, Robert Love wrote:

> I finally got around to reviewing the locking in inotify, again, in
> response to Andrew's points.

As I was saying.  I need to walk down the hall and have the Evolution
hackers add the "Robert intended to add a patch but did not, so let's
automatically add it for him" feature.

Here it is, this time for serious.

	Robert Love


--=-QgazXXiIekbo4X2Maxs+
Content-Disposition: attachment; filename=inotify-0.11.0-rml-locking-redux-1.patch
Content-Type: text/x-patch; name=inotify-0.11.0-rml-locking-redux-1.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

locking cleanup for inotify, the code equivalent of fine cheese.

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   86 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 54 insertions(+), 32 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-30 12:09:41.317737160 -0400
+++ linux/drivers/char/inotify.c	2004-09-30 14:18:33.369286656 -0400
@@ -65,9 +65,12 @@
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
 	DECLARE_BITMAP(bitmask, MAX_INOTIFY_DEV_WATCHERS);
@@ -522,8 +525,13 @@
 {
 	struct inotify_watcher *watcher;
 
-	spin_lock(&inode1->i_lock);
-	spin_lock(&inode2->i_lock);
+	if (inode1 < inode2) {
+		spin_lock(&inode1->i_lock);
+		spin_lock(&inode2->i_lock);
+	} else {
+		spin_lock(&inode2->i_lock);
+		spin_lock(&inode1->i_lock);
+	}
 
 	list_for_each_entry(watcher, &inode1->watchers, i_list) {
 		spin_lock(&watcher->dev->lock);
@@ -550,12 +558,9 @@
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
 
@@ -564,8 +569,8 @@
 	struct inotify_device *dev;
 	struct inode *inode;
 
-	spin_lock(&watcher->dev->lock);
 	spin_lock(&watcher->inode->i_lock);
+	spin_lock(&watcher->dev->lock);
 
 	inode = watcher->inode;
 	dev = watcher->dev;
@@ -577,24 +582,30 @@
 	inotify_dev_rm_watcher(watcher->dev, watcher);
 	list_del(&watcher->u_list);
 
-	spin_unlock(&inode->i_lock);
 	delete_watcher(dev, watcher);
 	spin_unlock(&dev->lock);
+	spin_unlock(&inode->i_lock);
 
 	unref_inode(inode);
 }
 
-static void process_umount_list(struct list_head *umount) {
+static void process_umount_list(struct list_head *umount)
+{
 	struct inotify_watcher *watcher, *next;
 
 	list_for_each_entry_safe(watcher, next, umount, u_list)
 		ignore_helper(watcher, IN_UNMOUNT);
 }
 
+/*
+ * build_umount_list - build a list of watchers affected by an unmount.
+ *
+ * Caller must hold inode_lock.
+ */
 static void build_umount_list(struct list_head *head, struct super_block *sb,
 			       struct list_head *umount)
 {
-	struct inode *	inode;
+	struct inode *inode;
 
 	list_for_each_entry(inode, head, i_list) {
 		struct inotify_watcher *watcher;
@@ -625,6 +636,11 @@
 }
 EXPORT_SYMBOL_GPL(inotify_super_block_umount);
 
+/*
+ * inotify_inode_is_dead - an inode has been deleted, cleanup any watches
+ *
+ * FIXME: Callers need to always hold inode->i_lock.
+ */
 void inotify_inode_is_dead(struct inode *inode)
 {
 	struct inotify_watcher *watcher, *next;
@@ -752,6 +768,11 @@
 	return 0;
 }
 
+/*
+ * inotify_release_all_watchers - destroy all watchers on a given device
+ *
+ * Caller must hold dev->lock.
+ */
 static void inotify_release_all_watchers(struct inotify_device *dev)
 {
 	struct inotify_watcher *watcher,*next;
@@ -762,13 +783,13 @@
 
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
 
 
@@ -777,8 +798,10 @@
 	struct inotify_device *dev;
 
 	dev = file->private_data;
+	spin_lock(&dev->lock);
 	inotify_release_all_watchers(dev);
 	inotify_release_all_events(dev);
+	spin_unlock(&dev->lock);
 	kfree(dev);
 
 	printk(KERN_ALERT "inotify device released\n");
@@ -790,22 +813,18 @@
 static int inotify_watch(struct inotify_device *dev,
 			 struct inotify_watch_request *request)
 {
-	int err;
 	struct inode *inode;
 	struct inotify_watcher *watcher;
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
@@ -820,15 +839,15 @@
 		owatcher = inode_find_dev(inode, dev);
 		owatcher->mask = request->mask;
 		inode_update_watchers_mask(inode);
+		spin_unlock(&dev->lock);		
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&dev->lock);
 		unref_inode(inode);
 
 		return 0;
 	}
 
+	spin_unlock(&dev->lock);	
 	spin_unlock(&inode->i_lock);
-	spin_unlock(&dev->lock);
 
 	watcher = create_watcher(dev, request->mask, inode);
 	if (!watcher) {
@@ -836,31 +855,27 @@
 		return -ENOSPC;
 	}
 
+	spin_lock(&inode->i_lock);	
 	spin_lock(&dev->lock);
-	spin_lock(&inode->i_lock);
 
 	/* We can't add anymore watchers to this device */
 	if (inotify_dev_add_watcher(dev, watcher) == -ENOSPC) {
 		iprintk(INOTIFY_DEBUG_ERRORS,
 			"can't add watcher dev is full\n");
-		spin_unlock(&inode->i_lock);
 		delete_watcher(dev, watcher);
 		spin_unlock(&dev->lock);
-
+		spin_unlock(&inode->i_lock);
 		unref_inode(inode);
+
 		return -ENOSPC;
 	}
 
 	inode_add_watcher(inode, watcher);
 
-	/* we keep a reference on the inode */
-	if (!err)
-		err = watcher->wd;
-
-	spin_unlock(&inode->i_lock);
 	spin_unlock(&dev->lock);
-exit:
-	return err;
+	spin_unlock(&inode->i_lock);
+
+	return watcher->wd;
 }
 
 static int inotify_ignore(struct inotify_device *dev, int wd)
@@ -904,6 +919,13 @@
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

--=-QgazXXiIekbo4X2Maxs+--

