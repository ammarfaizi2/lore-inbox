Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268453AbUJDTBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbUJDTBd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUJDTBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:01:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:63190 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268453AbUJDS7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:59:40 -0400
Subject: [patch] inotify: idr layerization
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, iggy@gentoo.org,
       ben@bagu.org
In-Reply-To: <1096865816.3827.1.camel@vertex>
References: <1096865816.3827.1.camel@vertex>
Content-Type: multipart/mixed; boundary="=-I25atvZWE2qa3+Hd+Y8I"
Date: Mon, 04 Oct 2004 14:58:09 -0400
Message-Id: <1096916289.17426.47.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I25atvZWE2qa3+Hd+Y8I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

John,

Here is another attempt at the removal of the bitmap and the addition of
the idr layer into inotify.

As before, I really like the idr, although its interface leaves a bit to
be desired.  But it makes the wd <-> watcher mapping wonderfully easy.

The patch is attached.  It still needs some banging on before merging,
but here it is.

Best,

	Robert Love


--=-I25atvZWE2qa3+Hd+Y8I
Content-Disposition: attachment; filename=inotify-0.12-rml-idr-1.patch
Content-Type: text/x-patch; name=inotify-0.12-rml-idr-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

inotify, meet idr. idr, meet inotify.

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   65 ++++++++++++++++++++++++++++---------------------
 1 files changed, 38 insertions(+), 27 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-10-04 14:56:17.211944304 -0400
+++ linux/drivers/char/inotify.c	2004-10-04 14:54:31.595000520 -0400
@@ -22,11 +22,11 @@
  * use slab cache for inotify_inode_data structures
  */
 
-#include <linux/bitmap.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
@@ -55,9 +55,6 @@
  * For each inotify device, we need to keep track of the events queued on it,
  * a list of the inodes that we are watching, and so on.
  *
- * 'bitmask' holds one bit for each possible watch descriptor: a set bit
- * implies that the given WD is valid, unset implies it is not.
- *
  * This structure is protected by 'lock'.  Lock ordering:
  *
  * inode->i_lock
@@ -67,8 +64,8 @@
  * FIXME: Look at replacing i_lock with i_sem.
  */
 struct inotify_device {
-	DECLARE_BITMAP(bitmask, MAX_INOTIFY_DEV_WATCHES);
 	wait_queue_head_t 	wait;
+	struct idr		idr;
 	struct list_head 	events;
 	struct list_head 	watches;
 	spinlock_t		lock;
@@ -271,20 +268,30 @@
 /*
  * inotify_dev_get_wd - returns the next WD for use by the given dev
  *
- * Caller must hold dev->lock before calling.
+ * This function can sleep.
  */
-static int inotify_dev_get_wd(struct inotify_device *dev)
+static int inotify_dev_get_wd(struct inotify_device *dev,
+			      struct inotify_watch *watch)
 {
-	int wd;
+	int ret;
 
 	if (!dev || dev->nr_watches == MAX_INOTIFY_DEV_WATCHES)
 		return -1;
 
+repeat:
+	if (!idr_pre_get(&dev->idr, GFP_KERNEL))
+		return -1;
+	spin_lock(&dev->lock);
+	ret = idr_get_new(&dev->idr, watch, &watch->wd);
+	spin_unlock(&dev->lock);
+	if (ret == -EAGAIN)	/* more memory is required, try again */
+		goto repeat;
+	else if (ret)		/* the idr is full! */
+		return -1;
+
 	dev->nr_watches++;
-	wd = find_first_zero_bit(dev->bitmask, MAX_INOTIFY_DEV_WATCHES);
-	set_bit(wd, dev->bitmask);
 
-	return wd;
+	return 0;
 }
 
 /*
@@ -298,7 +305,7 @@
 		return -1;
 
 	dev->nr_watches--;
-	clear_bit(wd, dev->bitmask);
+	idr_remove(&dev->idr, wd);
 
 	return 0;
 }
@@ -327,11 +334,7 @@
 	INIT_LIST_HEAD(&watch->i_list);
 	INIT_LIST_HEAD(&watch->u_list);
 
-	spin_lock(&dev->lock);
-	watch->wd = inotify_dev_get_wd(dev);
-	spin_unlock(&dev->lock);
-
-	if (watch->wd < 0) {
+	if (inotify_dev_get_wd(dev, watch)) {
 		iprintk(INOTIFY_DEBUG_ERRORS,
 			"Could not get wd for watch %p\n", watch);
 		iprintk(INOTIFY_DEBUG_ALLOC, "free'd watch %p\n", watch);
@@ -376,16 +379,18 @@
 	return NULL;
 }
 
-static struct inotify_watch *dev_find_wd(struct inotify_device *dev, int wd)
+/*
+ * dev_find_wd - given a (dev,wd) pair, returns the matching inotify_watcher
+ *
+ * Returns the results of looking up (dev,wd) in the idr layer.  NULL is
+ * returned on error.
+ *
+ * The caller must hold dev->lock.
+ */
+static inline struct inotify_watch *dev_find_wd(struct inotify_device *dev,
+						__u32 wd)
 {
-	struct inotify_watch *watch;
-
-	list_for_each_entry(watch, &dev->watches, d_list) {
-		if (watch->wd == wd)
-			return watch;
-	}
-
-	return NULL;
+	return idr_find(&dev->idr, wd);
 }
 
 static int inotify_dev_is_watching_inode(struct inotify_device *dev,
@@ -720,7 +725,7 @@
 	if (!dev)
 		return -ENOMEM;
 
-	bitmap_zero(dev->bitmask, MAX_INOTIFY_DEV_WATCHES);
+	idr_init(&dev->idr);
 
 	INIT_LIST_HEAD(&dev->events);
 	INIT_LIST_HEAD(&dev->watches);
@@ -849,7 +854,13 @@
 {
 	struct inotify_watch *watch;
 
+	/*
+	 * FIXME: Silly to grab dev->lock here and then drop it, when
+	 * ignore_helper() grabs it anyway a few lines down.
+	 */
+	spin_lock(&dev->lock);
 	watch = dev_find_wd(dev, wd);
+	spin_unlock(&dev->lock);
 	if (!watch)
 		return -EINVAL;
 	ignore_helper(watch, 0);

--=-I25atvZWE2qa3+Hd+Y8I--

