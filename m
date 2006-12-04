Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936271AbWLDMec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936271AbWLDMec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936263AbWLDMec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:34:32 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:42462 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936271AbWLDMeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:34:31 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 35/35] Unionfs: Extended Attributes support
Date: Mon,  4 Dec 2006 07:31:08 -0500
Message-Id: <1165235473964-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Extended attribute support.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 fs/Kconfig          |    9 ++++
 fs/unionfs/Makefile |    2 +
 fs/unionfs/copyup.c |   75 +++++++++++++++++++++++++++++++
 fs/unionfs/inode.c  |   12 +++++
 fs/unionfs/union.h  |   15 ++++++
 fs/unionfs/xattr.c  |  123 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 236 insertions(+), 0 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 4b31ea4..b8b8e45 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1567,6 +1567,15 @@ config UNION_FS
 
 	  See <http://www.unionfs.org> for details
 
+config UNION_FS_XATTR
+	bool "Unionfs extended attributes"
+	depends on UNION_FS
+	help
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page).
+
+	  If unsure, say N.
+
 endmenu
 
 menu "Network File Systems"
diff --git a/fs/unionfs/Makefile b/fs/unionfs/Makefile
index 25dd78f..7c98325 100644
--- a/fs/unionfs/Makefile
+++ b/fs/unionfs/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_UNION_FS) += unionfs.o
 unionfs-y := subr.o dentry.o file.o inode.o main.o super.o \
 	stale_inode.o branchman.o rdstate.o copyup.o dirhelper.o \
 	rename.o unlink.o lookup.o commonfops.o dirfops.o sioq.o
+
+unionfs-$(CONFIG_UNION_FS_XATTR) += xattr.o
diff --git a/fs/unionfs/copyup.c b/fs/unionfs/copyup.c
index 0557c02..ec1c649 100644
--- a/fs/unionfs/copyup.c
+++ b/fs/unionfs/copyup.c
@@ -18,6 +18,75 @@
 
 #include "union.h"
 
+#ifdef CONFIG_UNION_FS_XATTR
+/* copyup all extended attrs for a given dentry */
+static int copyup_xattrs(struct dentry *old_hidden_dentry,
+			 struct dentry *new_hidden_dentry)
+{
+	int err = 0;
+	ssize_t list_size = -1;
+	char *name_list = NULL;
+	char *attr_value = NULL;
+	char *name_list_orig = NULL;
+
+	list_size = vfs_listxattr(old_hidden_dentry, NULL, 0);
+
+	if (list_size <= 0) {
+		err = list_size;
+		goto out;
+	}
+
+	name_list = xattr_alloc(list_size + 1, XATTR_LIST_MAX);
+	if (!name_list || IS_ERR(name_list)) {
+		err = PTR_ERR(name_list);
+		goto out;
+	}
+	list_size = vfs_listxattr(old_hidden_dentry, name_list, list_size);
+	attr_value = xattr_alloc(XATTR_SIZE_MAX, XATTR_SIZE_MAX);
+	if (!attr_value || IS_ERR(attr_value)) {
+		err = PTR_ERR(name_list);
+		goto out;
+	}
+	name_list_orig = name_list;
+	while (*name_list) {
+		ssize_t size;
+
+		//We need to lock here since vfs_getxattr doesn't lock for us.
+		mutex_lock(&old_hidden_dentry->d_inode->i_mutex);
+		size = vfs_getxattr(old_hidden_dentry, name_list,
+				    attr_value, XATTR_SIZE_MAX);
+		mutex_unlock(&old_hidden_dentry->d_inode->i_mutex);
+		if (size < 0) {
+			err = size;
+			goto out;
+		}
+
+		if (size > XATTR_SIZE_MAX) {
+			err = -E2BIG;
+			goto out;
+		}
+		//We don't need to lock here since vfs_setxattr does it for us.
+		err = vfs_setxattr(new_hidden_dentry, name_list, attr_value,
+				   size, 0);
+
+		if (err < 0)
+			goto out;
+		name_list += strlen(name_list) + 1;
+	}
+      out:
+	name_list = name_list_orig;
+
+	if (name_list)
+		xattr_free(name_list, list_size + 1);
+	if (attr_value)
+		xattr_free(attr_value, XATTR_SIZE_MAX);
+	/* It is no big deal if this fails, we just roll with the punches. */
+	if (err == -ENOTSUPP || err == -EOPNOTSUPP)
+		err = 0;
+	return err;
+}
+#endif /* CONFIG_UNION_FS_XATTR */
+
 /* Determine the mode based on the copyup flags, and the existing dentry. */
 static int copyup_permissions(struct super_block *sb,
 			      struct dentry *old_hidden_dentry,
@@ -343,6 +412,12 @@ int copyup_named_dentry(struct inode *di
 	if ((err = copyup_permissions(sb, old_hidden_dentry, new_hidden_dentry)))
 		goto out_unlink;
 
+#ifdef CONFIG_UNION_FS_XATTR
+ 	/* Selinux uses extended attributes for permissions. */
+ 	if ((err = copyup_xattrs(old_hidden_dentry, new_hidden_dentry)))
+		goto out_unlink;
+#endif
+
 	/* do not allow files getting deleted to be reinterposed */
 	if (!d_deleted(dentry))
 		unionfs_reinterpose(dentry);
diff --git a/fs/unionfs/inode.c b/fs/unionfs/inode.c
index c7806e9..2e45fb0 100644
--- a/fs/unionfs/inode.c
+++ b/fs/unionfs/inode.c
@@ -917,10 +917,22 @@ struct inode_operations unionfs_dir_iops
 	.rename = unionfs_rename,
 	.permission = unionfs_permission,
 	.setattr = unionfs_setattr,
+#ifdef CONFIG_UNION_FS_XATTR
+	.setxattr = unionfs_setxattr,
+	.getxattr = unionfs_getxattr,
+	.removexattr = unionfs_removexattr,
+	.listxattr = unionfs_listxattr,
+#endif
 };
 
 struct inode_operations unionfs_main_iops = {
 	.permission = unionfs_permission,
 	.setattr = unionfs_setattr,
+#ifdef CONFIG_UNION_FS_XATTR
+	.setxattr = unionfs_setxattr,
+	.getxattr = unionfs_getxattr,
+	.removexattr = unionfs_removexattr,
+	.listxattr = unionfs_listxattr,
+#endif
 };
 
diff --git a/fs/unionfs/union.h b/fs/unionfs/union.h
index ff0b814..58e0cfb 100644
--- a/fs/unionfs/union.h
+++ b/fs/unionfs/union.h
@@ -40,6 +40,7 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/writeback.h>
+#include <linux/xattr.h>
 #include <linux/fs_stack.h>
 
 #include <linux/union_fs.h>
@@ -315,6 +316,20 @@ int unionfs_ioctl_queryfile(struct file
 /* Verify that a branch is valid. */
 int check_branch(struct nameidata *nd);
 
+#ifdef CONFIG_UNION_FS_XATTR
+/* Extended attribute functions. */
+extern void *xattr_alloc(size_t size, size_t limit);
+extern void xattr_free(void *ptr, size_t size);
+
+extern ssize_t unionfs_getxattr(struct dentry *dentry, const char *name,
+		void *value, size_t size);
+extern int unionfs_removexattr(struct dentry *dentry, const char *name);
+extern ssize_t unionfs_listxattr(struct dentry *dentry, char *list,
+		size_t size);
+extern int unionfs_setxattr(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags);
+#endif /* CONFIG_UNION_FS_XATTR */
+
 /* The root directory is unhashed, but isn't deleted. */
 static inline int d_deleted(struct dentry *d)
 {
diff --git a/fs/unionfs/xattr.c b/fs/unionfs/xattr.c
new file mode 100644
index 0000000..9f804bf
--- /dev/null
+++ b/fs/unionfs/xattr.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (c) 2003-2006 Erez Zadok
+ * Copyright (c) 2003-2006 Charles P. Wright
+ * Copyright (c) 2005-2006 Josef 'Jeff' Sipek
+ * Copyright (c) 2005-2006 Junjiro Okajima
+ * Copyright (c) 2005      Arun M. Krishnakumar
+ * Copyright (c) 2004-2006 David P. Quigley
+ * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
+ * Copyright (c) 2003      Puja Gupta
+ * Copyright (c) 2003      Harikesavan Krishnan
+ * Copyright (c) 2003-2006 Stony Brook University
+ * Copyright (c) 2003-2006 The Research Foundation of State University of New York*
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "union.h"
+
+/* This is lifted from fs/xattr.c */
+void *xattr_alloc(size_t size, size_t limit)
+{
+	void *ptr;
+
+	if (size > limit)
+		return ERR_PTR(-E2BIG);
+
+	if (!size)		/* size request, no buffer is needed */
+		return NULL;
+	else if (size <= PAGE_SIZE)
+		ptr = kmalloc(size, GFP_KERNEL);
+	else
+		ptr = vmalloc(size);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+	return ptr;
+}
+
+void xattr_free(void *ptr, size_t size)
+{
+	if (!size)		/* size request, no buffer was needed */
+		return;
+	else if (size <= PAGE_SIZE)
+		kfree(ptr);
+	else
+		vfree(ptr);
+}
+
+/* BKL held by caller.
+ * dentry->d_inode->i_mutex locked
+ */
+ssize_t unionfs_getxattr(struct dentry * dentry, const char *name, void *value,
+		size_t size)
+{
+	struct dentry *hidden_dentry = NULL;
+	int err = -EOPNOTSUPP;
+
+	lock_dentry(dentry);
+
+	hidden_dentry = unionfs_lower_dentry(dentry);
+
+	err = vfs_getxattr(hidden_dentry, (char*) name, value, size);
+
+	unlock_dentry(dentry);
+	return err;
+}
+
+/* BKL held by caller.
+ * dentry->d_inode->i_mutex locked
+ */
+int unionfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+		 size_t size, int flags)
+{
+	struct dentry *hidden_dentry = NULL;
+	int err = -EOPNOTSUPP;
+
+	lock_dentry(dentry);
+	hidden_dentry = unionfs_lower_dentry(dentry);
+
+	err = vfs_setxattr(hidden_dentry, (char*) name, (void*) value, size, flags);
+
+	unlock_dentry(dentry);
+	return err;
+}
+
+/* BKL held by caller.
+ * dentry->d_inode->i_mutex locked
+ */
+int unionfs_removexattr(struct dentry *dentry, const char *name)
+{
+	struct dentry *hidden_dentry = NULL;
+	int err = -EOPNOTSUPP;
+
+	lock_dentry(dentry);
+	hidden_dentry = unionfs_lower_dentry(dentry);
+
+	err = vfs_removexattr(hidden_dentry, (char*) name);
+
+	unlock_dentry(dentry);
+	return err;
+}
+
+/* BKL held by caller.
+ * dentry->d_inode->i_mutex locked
+ */
+ssize_t unionfs_listxattr(struct dentry * dentry, char *list, size_t size)
+{
+	struct dentry *hidden_dentry = NULL;
+	int err = -EOPNOTSUPP;
+	char *encoded_list = NULL;
+
+	lock_dentry(dentry);
+
+	hidden_dentry = unionfs_lower_dentry(dentry);
+
+	encoded_list = list;
+	err = vfs_listxattr(hidden_dentry, encoded_list, size);
+
+	unlock_dentry(dentry);
+	return err;
+}
+
-- 
1.4.3.3

