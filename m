Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269611AbUJFXPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269611AbUJFXPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUJFXIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:08:44 -0400
Received: from peabody.ximian.com ([130.57.169.10]:43497 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269622AbUJFXFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:05:02 -0400
Subject: Re: [RFC][PATCH] inotify 0.13
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1097095286.9199.2.camel@vertex>
References: <1097095286.9199.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-RJDmzKFb2UBbXl4d3dfY"
Date: Wed, 06 Oct 2004 19:03:30 -0400
Message-Id: <1097103810.3960.16.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RJDmzKFb2UBbXl4d3dfY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey, John.

A couple misc. cleanups.

A few notables:

	- missing inotify_get_cookie() when !CONFIG_INOTIFY

	- Put setattr_mask_inotify() in inotify.c so we don't
	  built it in !CONFIG_INOTIFY and can thus save memory.

	- Do the same for setattr_mask(), now renamed to
	  setattr_mask_dnotify().

	- setattr_mask_inotify() needs to return a u32.

Thanks,

	Robert Love


--=-RJDmzKFb2UBbXl4d3dfY
Content-Disposition: attachment; filename=inotify-0.13-rml-cleanup-1.patch
Content-Type: text/x-patch; name=inotify-0.13-rml-cleanup-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

misc. inotify changes.

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c  |   35 ++++++++++++++++++++++++++++++++---
 fs/attr.c               |   45 ---------------------------------------------
 fs/dnotify.c            |   23 +++++++++++++++++++++++
 include/linux/dnotify.h |    6 ++++++
 include/linux/inotify.h |   11 +++++++++++
 5 files changed, 72 insertions(+), 48 deletions(-)

diff -urN linux-inotify-0.13/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify-0.13/drivers/char/inotify.c	2004-10-06 18:47:39.053602064 -0400
+++ linux/drivers/char/inotify.c	2004-10-06 19:02:43.515103016 -0400
@@ -472,7 +472,7 @@
 	 */
 	if (!inode->inotify_data) {
 		inode->inotify_data = kmem_cache_alloc(inode_data_cachep,
-							GFP_ATOMIC);
+						       GFP_ATOMIC);
 		INIT_LIST_HEAD(&inode->inotify_data->watches);
 		inode->inotify_data->watch_mask = 0;
 		inode->inotify_data->watch_count = 0;
@@ -517,7 +517,8 @@
 
 	list_for_each_entry(watch, &inode->inotify_data->watches, i_list) {
 		spin_lock(&watch->dev->lock);
-		inotify_dev_queue_event(watch->dev, watch, mask, cookie, filename);
+		inotify_dev_queue_event(watch->dev, watch, mask, cookie,
+					filename);
 		spin_unlock(&watch->dev->lock);
 	}
 
@@ -544,7 +545,6 @@
 }
 EXPORT_SYMBOL_GPL(inotify_get_cookie);
 
-
 static void ignore_helper(struct inotify_watch *watch, int event)
 {
 	struct inotify_device *dev;
@@ -640,6 +640,33 @@
 }
 EXPORT_SYMBOL_GPL(inotify_inode_is_dead);
 
+/*
+ * setattr_mask_inotify - return the desired event mask based on the given
+ * attribute bitmask.
+ */
+u32 setattr_mask_inotify(unsigned int ia_valid)
+{
+	u32 mask = 0;
+
+	if (ia_valid & ATTR_UID)
+		mask |= IN_ATTRIB;
+	if (ia_valid & ATTR_GID)
+		mask |= IN_ATTRIB;
+	if (ia_valid & ATTR_SIZE)
+		mask |= IN_MODIFY;
+	/* both times implies a utime(s) call */
+	if ((ia_valid & (ATTR_ATIME|ATTR_MTIME)) == (ATTR_ATIME|ATTR_MTIME))
+		mask |= IN_ATTRIB;
+	else if (ia_valid & ATTR_ATIME)
+		mask |= IN_ACCESS;
+	else if (ia_valid & ATTR_MTIME)
+		mask |= IN_MODIFY;
+	if (ia_valid & ATTR_MODE)
+		mask |= IN_ATTRIB;
+	return mask;
+}
+EXPORT_SYMBOL(setattr_mask_inotify);
+
 /* The driver interface is implemented below */
 
 static unsigned int inotify_poll(struct file *file, poll_table *wait)
@@ -751,6 +778,8 @@
 
 /*
  * inotify_release_all_watches - destroy all watches on a given device
+ *
+ * FIXME: Do we want a lock here?
  */
 static void inotify_release_all_watches(struct inotify_device *dev)
 {
diff -urN linux-inotify-0.13/fs/attr.c linux/fs/attr.c
--- linux-inotify-0.13/fs/attr.c	2004-10-06 16:47:54.000000000 -0400
+++ linux/fs/attr.c	2004-10-06 18:55:15.212255408 -0400
@@ -104,53 +104,8 @@
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
-static int setattr_mask_inotify(unsigned int ia_valid)
-{
-	unsigned long dn_mask = 0;
-
-	if (ia_valid & ATTR_UID)
-		dn_mask |= IN_ATTRIB;
-	if (ia_valid & ATTR_GID)
-		dn_mask |= IN_ATTRIB;
-	if (ia_valid & ATTR_SIZE)
-		dn_mask |= IN_MODIFY;
-	/* both times implies a utime(s) call */
-	if ((ia_valid & (ATTR_ATIME|ATTR_MTIME)) == (ATTR_ATIME|ATTR_MTIME))
-		dn_mask |= IN_ATTRIB;
-	else if (ia_valid & ATTR_ATIME)
-		dn_mask |= IN_ACCESS;
-	else if (ia_valid & ATTR_MTIME)
-		dn_mask |= IN_MODIFY;
-	if (ia_valid & ATTR_MODE)
-		dn_mask |= IN_ATTRIB;
-	return dn_mask;
-}
-
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
diff -urN linux-inotify-0.13/fs/dnotify.c linux/fs/dnotify.c
--- linux-inotify-0.13/fs/dnotify.c	2004-10-06 16:47:54.000000000 -0400
+++ linux/fs/dnotify.c	2004-10-06 18:55:12.333693016 -0400
@@ -143,6 +143,29 @@
 
 EXPORT_SYMBOL(__inode_dir_notify);
 
+int setattr_mask_dnotify(unsigned int ia_valid)
+{
+	unsigned long dn_mask = 0;
+
+	if (ia_valid & ATTR_UID)
+		dn_mask |= DN_ATTRIB;
+	if (ia_valid & ATTR_GID)
+		dn_mask |= DN_ATTRIB;
+	if (ia_valid & ATTR_SIZE)
+		dn_mask |= DN_MODIFY;
+	/* both times implies a utime(s) call */
+	if ((ia_valid & (ATTR_ATIME|ATTR_MTIME)) == (ATTR_ATIME|ATTR_MTIME))
+		dn_mask |= DN_ATTRIB;
+	else if (ia_valid & ATTR_ATIME)
+		dn_mask |= DN_ACCESS;
+	else if (ia_valid & ATTR_MTIME)
+		dn_mask |= DN_MODIFY;
+	if (ia_valid & ATTR_MODE)
+		dn_mask |= DN_ATTRIB;
+	return dn_mask;
+}
+EXPORT_SYMBOL(setattr_mask_dnotify);
+
 /*
  * This is hopelessly wrong, but unfixable without API changes.  At
  * least it doesn't oops the kernel...
diff -urN linux-inotify-0.13/include/linux/dnotify.h linux/include/linux/dnotify.h
--- linux-inotify-0.13/include/linux/dnotify.h	2004-10-06 16:47:54.000000000 -0400
+++ linux/include/linux/dnotify.h	2004-10-06 18:56:54.224203304 -0400
@@ -26,6 +26,7 @@
 extern void dnotify_flush(struct file *, fl_owner_t);
 extern int fcntl_dirnotify(int, struct file *, unsigned long);
 extern void dnotify_parent(struct dentry *, unsigned long);
+extern int setattr_mask_dnotify(unsigned int);
 
 static inline void inode_dir_notify(struct inode *inode, unsigned long event)
 {
@@ -56,6 +57,11 @@
 {
 }
 
+static inline int setattr_mask_dnotify(unsigned int ia_valid)
+{
+	return 0;
+}
+
 #endif /* CONFIG_DNOTIFY */
 
 #endif /* __KERNEL __ */
diff -urN linux-inotify-0.13/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-inotify-0.13/include/linux/inotify.h	2004-10-06 16:56:13.000000000 -0400
+++ linux/include/linux/inotify.h	2004-10-06 18:54:21.654397440 -0400
@@ -98,6 +98,7 @@
 extern void inotify_super_block_umount(struct super_block *);
 extern void inotify_inode_is_dead(struct inode *);
 extern __u32 inotify_get_cookie(void);
+extern int setattr_mask_inotify(unsigned int);
 
 /* this could be kstrdup if only we could add that to lib/string.c */
 static inline char * inotify_oldname_init(struct dentry *old_dentry)
@@ -142,10 +143,20 @@
 	return NULL;
 }
 
+static inline __u32 inotify_get_cookie(void)
+{
+	return 0;
+}
+
 static inline void inotify_oldname_free(const char *old_name)
 {
 }
 
+static inline int setattr_mask_inotify(unsigned int ia_mask)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_INOTIFY */
 
 #endif	/* __KERNEL __ */

--=-RJDmzKFb2UBbXl4d3dfY--

