Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUFVUHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUFVUHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbUFVT3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:29:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12955 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265359AbUFVTX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:23:59 -0400
To: torvalds@osdl.org
Subject: [PATCH] (2/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xQ-EX@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        ext2 conversion (helper functions for that one will be actually
used a lot by other filesystems, so to fs/namei.c they go)

diff -urN RC7-bk5-core/fs/ext2/symlink.c RC7-bk5-ext2/fs/ext2/symlink.c
--- RC7-bk5-core/fs/ext2/symlink.c	Sat Sep 27 22:04:56 2003
+++ RC7-bk5-ext2/fs/ext2/symlink.c	Tue Jun 22 15:13:10 2004
@@ -19,23 +19,19 @@
 
 #include "ext2.h"
 #include "xattr.h"
-
-static int
-ext2_readlink(struct dentry *dentry, char __user *buffer, int buflen)
-{
-	struct ext2_inode_info *ei = EXT2_I(dentry->d_inode);
-	return vfs_readlink(dentry, buffer, buflen, (char *)ei->i_data);
-}
+#include <linux/namei.h>
 
 static int ext2_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct ext2_inode_info *ei = EXT2_I(dentry->d_inode);
-	return vfs_follow_link(nd, (char *)ei->i_data);
+	nd_set_link(nd, (char *)ei->i_data);
+	return 0;
 }
 
 struct inode_operations ext2_symlink_inode_operations = {
-	.readlink	= page_readlink,
-	.follow_link	= page_follow_link,
+	.readlink	= generic_readlink,
+	.follow_link	= page_follow_link_light,
+	.put_link	= page_put_link,
 	.setxattr	= ext2_setxattr,
 	.getxattr	= ext2_getxattr,
 	.listxattr	= ext2_listxattr,
@@ -43,7 +39,7 @@
 };
  
 struct inode_operations ext2_fast_symlink_inode_operations = {
-	.readlink	= ext2_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= ext2_follow_link,
 	.setxattr	= ext2_setxattr,
 	.getxattr	= ext2_getxattr,
diff -urN RC7-bk5-core/fs/namei.c RC7-bk5-ext2/fs/namei.c
--- RC7-bk5-core/fs/namei.c	Tue Jun 22 15:13:10 2004
+++ RC7-bk5-ext2/fs/namei.c	Tue Jun 22 15:13:10 2004
@@ -2189,6 +2189,23 @@
 	return len;
 }
 
+/*
+ * A helper for ->readlink().  This should be used *ONLY* for symlinks that
+ * have ->follow_link() touching nd only in nd_set_link().  Using (or not
+ * using) it for any given inode is up to filesystem.
+ */
+int generic_readlink(struct dentry *dentry, char __user *buffer, int buflen)
+{
+	struct nameidata nd;
+	int res = dentry->d_inode->i_op->follow_link(dentry, &nd);
+	if (!res) {
+		res = vfs_readlink(dentry, buffer, buflen, nd_get_link(&nd));
+		if (dentry->d_inode->i_op->put_link)
+			dentry->d_inode->i_op->put_link(dentry, &nd);
+	}
+	return res;
+}
+
 static inline int
 __vfs_follow_link(struct nameidata *nd, const char *link)
 {
@@ -2265,6 +2282,30 @@
 	return res;
 }
 
+int page_follow_link_light(struct dentry *dentry, struct nameidata *nd)
+{
+	struct page *page;
+	char *s = page_getlink(dentry, &page);
+	if (!IS_ERR(s)) {
+		nd_set_link(nd, s);
+		s = NULL;
+	}
+	return PTR_ERR(s);
+}
+
+void page_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+	if (!IS_ERR(nd_get_link(nd))) {
+		struct page *page;
+		page = find_get_page(dentry->d_inode->i_mapping, 0);
+		if (!page)
+			BUG();
+		kunmap(page);
+		page_cache_release(page);
+		page_cache_release(page);
+	}
+}
+
 int page_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page = NULL;
@@ -2319,8 +2360,9 @@
 }
 
 struct inode_operations page_symlink_inode_operations = {
-	.readlink	= page_readlink,
-	.follow_link	= page_follow_link,
+	.readlink	= generic_readlink,
+	.follow_link	= page_follow_link_light,
+	.put_link	= page_put_link,
 };
 
 EXPORT_SYMBOL(__user_walk);
@@ -2333,6 +2375,8 @@
 EXPORT_SYMBOL(lookup_hash);
 EXPORT_SYMBOL(lookup_one_len);
 EXPORT_SYMBOL(page_follow_link);
+EXPORT_SYMBOL(page_follow_link_light);
+EXPORT_SYMBOL(page_put_link);
 EXPORT_SYMBOL(page_readlink);
 EXPORT_SYMBOL(page_symlink);
 EXPORT_SYMBOL(page_symlink_inode_operations);
@@ -2352,3 +2396,4 @@
 EXPORT_SYMBOL(vfs_rmdir);
 EXPORT_SYMBOL(vfs_symlink);
 EXPORT_SYMBOL(vfs_unlink);
+EXPORT_SYMBOL(generic_readlink);
diff -urN RC7-bk5-core/include/linux/fs.h RC7-bk5-ext2/include/linux/fs.h
--- RC7-bk5-core/include/linux/fs.h	Tue Jun 22 15:13:10 2004
+++ RC7-bk5-ext2/include/linux/fs.h	Tue Jun 22 15:13:10 2004
@@ -1468,8 +1468,11 @@
 extern int vfs_follow_link(struct nameidata *, const char *);
 extern int page_readlink(struct dentry *, char __user *, int);
 extern int page_follow_link(struct dentry *, struct nameidata *);
+extern int page_follow_link_light(struct dentry *, struct nameidata *);
+extern void page_put_link(struct dentry *, struct nameidata *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern struct inode_operations page_symlink_inode_operations;
+extern int generic_readlink(struct dentry *, char __user *, int);
 extern void generic_fillattr(struct inode *, struct kstat *);
 extern int vfs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 void inode_add_bytes(struct inode *inode, loff_t bytes);
