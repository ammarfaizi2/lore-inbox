Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269587AbUI3Wor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269587AbUI3Wor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUI3Wor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:44:47 -0400
Received: from peabody.ximian.com ([130.57.169.10]:46532 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269598AbUI3WoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:44:24 -0400
Subject: [patch] inotify: rename inotify_watcher
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096410792.4365.3.camel@vertex>
References: <1096410792.4365.3.camel@vertex>
Content-Type: multipart/mixed; boundary="=-BEKUWAG9bmpzt6IavJfF"
Date: Thu, 30 Sep 2004 18:43:00 -0400
Message-Id: <1096584180.4203.91.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BEKUWAG9bmpzt6IavJfF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

s/inotify_watcher/inotify_watch/ per the TODO

I agree: The structures are objects we are watching, not the watchers
themselves.

	Robert Love


--=-BEKUWAG9bmpzt6IavJfF
Content-Disposition: attachment; filename=inotify-rename-inotify_watcher.patch
Content-Type: text/x-patch; name=inotify-rename-inotify_watcher.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

s/inotify_watcher/inode_watch/

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   76 +++++++++++++++++++++++--------------------------
 1 files changed, 37 insertions(+), 39 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-30 18:25:19.102473088 -0400
+++ linux/drivers/char/inotify.c	2004-09-30 18:39:20.164612208 -0400
@@ -17,8 +17,6 @@
 /* TODO: 
  * unmount events don't get sent if filesystem is mounted in two places.
  * dynamically allocate event filename
- * watchers and events could use their own slab cache
- * rename inotify_watcher to inotify_watch
  * need a way to connect MOVED_TO/MOVED_FROM events in user space
  * use b-tree so looking up watch by WD is faster
  */
@@ -82,7 +80,7 @@
 	int			nr_watches;
 };
 
-struct inotify_watcher {
+struct inotify_watch {
 	__s32 			wd;	/* watcher descriptor */
 	__u32			mask;
 	struct inode *		inode;
@@ -91,9 +89,9 @@
 	struct list_head	i_list; // inode list
 	struct list_head	u_list; // unmount list 
 };
-#define inotify_watcher_d_list(pos) list_entry((pos), struct inotify_watcher, d_list)
-#define inotify_watcher_i_list(pos) list_entry((pos), struct inotify_watcher, i_list)
-#define inotify_watcher_u_list(pos) list_entry((pos), struct inotify_watcher, u_list)
+#define inotify_watcher_d_list(pos) list_entry((pos), struct inotify_watch, d_list)
+#define inotify_watcher_i_list(pos) list_entry((pos), struct inotify_watch, i_list)
+#define inotify_watcher_u_list(pos) list_entry((pos), struct inotify_watch, u_list)
 
 /*
  * A list of these is attached to each instance of the driver
@@ -136,7 +134,7 @@
 	iput(inode);
 }
 
-struct inotify_kernel_event *kernel_event(int wd, int mask,
+struct inotify_kernel_event *kernel_event(int wd, __u32 mask,
 					  const char *filename)
 {
 	struct inotify_kernel_event *kevent;
@@ -199,7 +197,7 @@
  * Caller must hold dev->lock.
  */
 static void inotify_dev_queue_event(struct inotify_device *dev,
-				    struct inotify_watcher *watcher,
+				    struct inotify_watch *watcher,
 				    __u32 mask, const char *filename)
 {
 	struct inotify_kernel_event *kevent;
@@ -318,10 +316,10 @@
  *
  * Grabs dev->lock, so the caller must not hold it.
  */
-static struct inotify_watcher *create_watcher(struct inotify_device *dev,
-					      int mask, struct inode *inode)
+static struct inotify_watch *create_watcher(struct inotify_device *dev,
+					    __u32 mask, struct inode *inode)
 {
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 
 	watcher = kmem_cache_alloc(watcher_cache, GFP_KERNEL);
 	if (!watcher) {
@@ -359,7 +357,7 @@
  * Caller must hold dev->lock.
  */
 static void delete_watcher(struct inotify_device *dev,
-			   struct inotify_watcher *watcher)
+			   struct inotify_watch *watcher)
 {
 	inotify_dev_put_wd(dev, watcher->wd);
 	iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
@@ -371,10 +369,10 @@
  *
  * Caller must hold dev->lock.
  */
-static struct inotify_watcher *inode_find_dev(struct inode *inode,
+static struct inotify_watch *inode_find_dev(struct inode *inode,
 					      struct inotify_device *dev)
 {
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 
 	list_for_each_entry(watcher, &inode->watchers, i_list) {
 		if (watcher->dev == dev)
@@ -384,9 +382,9 @@
 	return NULL;
 }
 
-static struct inotify_watcher *dev_find_wd(struct inotify_device *dev, int wd)
+static struct inotify_watch *dev_find_wd(struct inotify_device *dev, int wd)
 {
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 
 	list_for_each_entry(watcher, &dev->watchers, d_list) {
 		if (watcher->wd == wd)
@@ -398,7 +396,7 @@
 static int inotify_dev_is_watching_inode(struct inotify_device *dev,
 					  struct inode *inode)
 {
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 
 	list_for_each_entry(watcher, &dev->watchers, d_list) {
 		if (watcher->inode == inode)
@@ -409,7 +407,7 @@
 }
 
 static int inotify_dev_add_watcher(struct inotify_device *dev,
-				   struct inotify_watcher *watcher)
+				   struct inotify_watch *watcher)
 {
 	int error;
 
@@ -441,7 +439,7 @@
  * Caller must hold dev->lock because we call inotify_dev_queue_event().
  */
 static int inotify_dev_rm_watcher(struct inotify_device *dev,
-				  struct inotify_watcher *watcher)
+				  struct inotify_watch *watcher)
 {
 	int error;
 
@@ -457,7 +455,7 @@
 
 void inode_update_watchers_mask(struct inode *inode)
 {
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 	__u32 new_mask;
 
 	new_mask = 0;
@@ -473,7 +471,7 @@
  * Callers must hold dev->lock, because we call inode_find_dev().
  */
 static int inode_add_watcher(struct inode *inode,
-			     struct inotify_watcher *watcher)
+			     struct inotify_watch *watcher)
 {
 	if (!inode || !watcher || inode_find_dev(inode, watcher->dev))
 		return -EINVAL;
@@ -486,7 +484,7 @@
 }
 
 static int inode_rm_watcher(struct inode *inode,
-			     struct inotify_watcher *watcher)
+			     struct inotify_watch *watcher)
 {
 	if (!inode || !watcher)
 		return -EINVAL;
@@ -504,7 +502,7 @@
 void inotify_inode_queue_event(struct inode *inode, __u32 mask,
 			       const char *filename)
 {
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 
 	spin_lock(&inode->i_lock);
 
@@ -523,7 +521,7 @@
 				    struct inode *inode2, __u32 mask2,
 				    const char *filename2)
 {
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 
 	if (inode1 < inode2) {
 		spin_lock(&inode1->i_lock);
@@ -563,7 +561,7 @@
 }
 EXPORT_SYMBOL_GPL(inotify_dentry_parent_queue_event);
 
-static void ignore_helper(struct inotify_watcher *watcher, int event)
+static void ignore_helper(struct inotify_watch *watcher, int event)
 {
 	struct inotify_device *dev;
 	struct inode *inode;
@@ -590,7 +588,7 @@
 
 static void process_umount_list(struct list_head *umount)
 {
-	struct inotify_watcher *watcher, *next;
+	struct inotify_watch *watcher, *next;
 
 	list_for_each_entry_safe(watcher, next, umount, u_list)
 		ignore_helper(watcher, IN_UNMOUNT);
@@ -607,7 +605,7 @@
 	struct inode *inode;
 
 	list_for_each_entry(inode, head, i_list) {
-		struct inotify_watcher *watcher;
+		struct inotify_watch *watcher;
 
 		if (inode->i_sb != sb)
 			continue;
@@ -642,7 +640,7 @@
  */
 void inotify_inode_is_dead(struct inode *inode)
 {
-	struct inotify_watcher *watcher, *next;
+	struct inotify_watch *watcher, *next;
 
 	list_for_each_entry_safe(watcher, next, &inode->watchers, i_list)
 		ignore_helper(watcher, 0);
@@ -765,7 +763,7 @@
  */
 static void inotify_release_all_watchers(struct inotify_device *dev)
 {
-	struct inotify_watcher *watcher,*next;
+	struct inotify_watch *watcher,*next;
 
 	list_for_each_entry_safe(watcher, next, &dev->watchers, d_list)
 		ignore_helper(watcher, 0);
@@ -804,7 +802,7 @@
 			 struct inotify_watch_request *request)
 {
 	struct inode *inode;
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 
 	inode = find_inode(request->dirname);
 	if (IS_ERR(inode))
@@ -821,13 +819,13 @@
 	 * watching, we just update the mask and return 0
 	 */
 	if (inotify_dev_is_watching_inode(dev, inode)) {
-		struct inotify_watcher *owatcher;	/* the old watcher */
+		struct inotify_watch *owatch;	/* the old watch */
 
 		iprintk(INOTIFY_DEBUG_ERRORS,
 				"adjusting event mask for inode %p\n", inode);
 
-		owatcher = inode_find_dev(inode, dev);
-		owatcher->mask = request->mask;
+		owatch = inode_find_dev(inode, dev);
+		owatch->mask = request->mask;
 		inode_update_watchers_mask(inode);
 		spin_unlock(&dev->lock);		
 		spin_unlock(&inode->i_lock);
@@ -870,7 +868,7 @@
 
 static int inotify_ignore(struct inotify_device *dev, int wd)
 {
-	struct inotify_watcher *watcher;
+	struct inotify_watch *watcher;
 
 	watcher = dev_find_wd(dev, wd);
 	if (!watcher)
@@ -882,19 +880,19 @@
 
 static void inotify_print_stats(struct inotify_device *dev)
 {
-	int sizeof_inotify_watcher;
+	int sizeof_inotify_watch;
 	int sizeof_inotify_device;
 	int sizeof_inotify_kernel_event;
 
-	sizeof_inotify_watcher = sizeof (struct inotify_watcher);
+	sizeof_inotify_watch = sizeof (struct inotify_watch);
 	sizeof_inotify_device = sizeof (struct inotify_device);
 	sizeof_inotify_kernel_event = sizeof (struct inotify_kernel_event);
 
 	printk(KERN_ALERT "GLOBAL INOTIFY STATS\n");
 	printk(KERN_ALERT "watcher_count = %d\n", atomic_read(&watcher_count));
 
-	printk(KERN_ALERT "sizeof(struct inotify_watcher) = %d\n",
-		sizeof_inotify_watcher);
+	printk(KERN_ALERT "sizeof(struct inotify_watch) = %d\n",
+		sizeof_inotify_watch);
 	printk(KERN_ALERT "sizeof(struct inotify_device) = %d\n",
 		sizeof_inotify_device);
 	printk(KERN_ALERT "sizeof(struct inotify_kernel_event) = %d\n",
@@ -978,7 +976,7 @@
 	inotify_debug_flags = INOTIFY_DEBUG_NONE;
 
 	watcher_cache = kmem_cache_create("watcher_cache",
-			sizeof(struct inotify_watcher), 0, SLAB_PANIC,
+			sizeof(struct inotify_watch), 0, SLAB_PANIC,
 			NULL, NULL);
 
 	kevent_cache = kmem_cache_create("kevent_cache",

--=-BEKUWAG9bmpzt6IavJfF--

