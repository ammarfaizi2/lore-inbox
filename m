Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269586AbUI3W3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269586AbUI3W3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269596AbUI3W30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:29:26 -0400
Received: from peabody.ximian.com ([130.57.169.10]:42180 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269592AbUI3W0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:26:32 -0400
Subject: [patch] inotify: make user visible types portable
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096410792.4365.3.camel@vertex>
References: <1096410792.4365.3.camel@vertex>
Content-Type: multipart/mixed; boundary="=-FrN4bc27VLIEicHQHQYi"
Date: Thu, 30 Sep 2004 18:25:08 -0400
Message-Id: <1096583108.4203.86.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FrN4bc27VLIEicHQHQYi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Because we have kernels with different types than their own
userspace--specifically 64-bit kernels with a 32-bit userspace--we
should limit all communication between the kernel and userspace to fixed
sized types.

This patch does that for the two user visible structures, inotify_event
and inotify_watcher.

As far as 32-bit or LP64 systems are concerned, the only type changes
are 'mask' and 'cookie', which are now unsigned.  No one is using
'cookie' yet, so the only ABI breaker is 'mask' (speaking of which, we
had 'mask' as an 'unsigned long' inside inotify.c, so this change was
needed anyhow).

Unfortunately the stupid fixed sized types are ugly as sin.  I mean,
"__u32" just does not have the same ring to it as "unsigned long".
C'est la vie.

Patch is on top of 0.11.0 and my previous bountiful delights.

Best,

	Robert Love


--=-FrN4bc27VLIEicHQHQYi
Content-Disposition: attachment; filename=inotify-0.11.0-rml-user-portability-1.patch
Content-Type: text/x-patch; name=inotify-0.11.0-rml-user-portability-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c  |   19 +++++++++----------
 include/linux/inotify.h |   37 ++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-30 17:54:46.000147000 -0400
+++ linux/drivers/char/inotify.c	2004-09-30 18:15:58.540691432 -0400
@@ -83,8 +83,8 @@
 };
 
 struct inotify_watcher {
-	int 			wd; // watcher descriptor
-	unsigned long		mask;
+	__s32 			wd;	/* watcher descriptor */
+	__u32			mask;
 	struct inode *		inode;
 	struct inotify_device *	dev;
 	struct list_head	d_list; // device list
@@ -199,8 +199,8 @@
  * Caller must hold dev->lock.
  */
 static void inotify_dev_queue_event(struct inotify_device *dev,
-				    struct inotify_watcher *watcher, int mask,
-				    const char *filename)
+				    struct inotify_watcher *watcher,
+				    __u32 mask, const char *filename)
 {
 	struct inotify_kernel_event *kevent;
 
@@ -458,7 +458,7 @@
 void inode_update_watchers_mask(struct inode *inode)
 {
 	struct inotify_watcher *watcher;
-	unsigned long new_mask;
+	__u32 new_mask;
 
 	new_mask = 0;
 	list_for_each_entry(watcher, &inode->watchers, i_list)
@@ -501,7 +501,7 @@
 
 /* Kernel API */
 
-void inotify_inode_queue_event(struct inode *inode, unsigned long mask,
+void inotify_inode_queue_event(struct inode *inode, __u32 mask,
 			       const char *filename)
 {
 	struct inotify_watcher *watcher;
@@ -518,9 +518,9 @@
 }
 EXPORT_SYMBOL_GPL(inotify_inode_queue_event);
 
-void inotify_inode_queue_event_pair(struct inode *inode1, unsigned long mask1,
+void inotify_inode_queue_event_pair(struct inode *inode1, __u32 mask1,
 				    const char *filename1,
-				    struct inode *inode2, unsigned long mask2,
+				    struct inode *inode2, __u32 mask2,
 				    const char *filename2)
 {
 	struct inotify_watcher *watcher;
@@ -552,8 +552,7 @@
 }
 EXPORT_SYMBOL_GPL(inotify_inode_queue_event_pair);
 
-void inotify_dentry_parent_queue_event(struct dentry *dentry,
-				       unsigned long mask,
+void inotify_dentry_parent_queue_event(struct dentry *dentry, __u32 mask,
 				       const char *filename)
 {
 	struct dentry *parent;
diff -urN linux-inotify/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-inotify/include/linux/inotify.h	2004-09-30 12:09:40.077925640 -0400
+++ linux/include/linux/inotify.h	2004-09-30 18:15:24.776824320 -0400
@@ -22,12 +22,22 @@
  * multiple of sizeof(struct inotify_event)
  */
 struct inotify_event {
-	int wd;
-	int mask;
-	int cookie;
+	__s32 wd;
+	__u32 mask;
+	__u32 cookie;
 	char filename[INOTIFY_FILENAME_MAX];
 };
 
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
 /* the following are legal, implemented events */
 #define IN_ACCESS		0x00000001	/* File was accessed */
 #define IN_MODIFY		0x00000002	/* File was modified */
@@ -48,16 +58,6 @@
 /* special flags */
 #define IN_ALL_EVENTS		0xffffffff	/* All the events */
 
-/*
- * struct inotify_watch_request - represents a watch request
- *
- * Pass to the inotify device via the INOTIFY_WATCH ioctl
- */
-struct inotify_watch_request {
-	char *dirname;		/* directory name */
-	unsigned long mask;	/* event mask */
-};
-
 #define INOTIFY_IOCTL_MAGIC	'Q'
 #define INOTIFY_IOCTL_MAXNR	4
 
@@ -82,23 +82,22 @@
 
 #ifdef CONFIG_INOTIFY
 
-extern void inotify_inode_queue_event(struct inode *, unsigned long,
-		const char *);
-extern void inotify_dentry_parent_queue_event(struct dentry *, unsigned long,
-		const char *);
+extern void inotify_inode_queue_event(struct inode *, __u32, const char *);
+extern void inotify_dentry_parent_queue_event(struct dentry *, __u32,
+					      const char *);
 extern void inotify_super_block_umount(struct super_block *);
 extern void inotify_inode_is_dead(struct inode *);
 
 #else
 
 static inline void inotify_inode_queue_event(struct inode *inode,
-					     unsigned long mask,
+					     __u32 mask,
 					     const char *filename)
 {
 }
 
 static inline void inotify_dentry_parent_queue_event(struct dentry *dentry,
-						     unsigned long mask,
+						     __u32 mask,
 						     const char *filename)
 {
 }

--=-FrN4bc27VLIEicHQHQYi--

