Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266691AbUHWUMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUHWUMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHWUG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:06:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2177 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266519AbUHWSWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:22:30 -0400
Date: Mon, 23 Aug 2004 14:22:20 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][7/7] add xattr support to ramfs
In-Reply-To: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds xattr support to tmpfs, and a security xattr handler.
Original patch from: Chris PeBenito <pebenito@gentoo.org>


 fs/Kconfig                |   22 +++++++++++
 fs/ramfs/Makefile         |    3 +
 fs/ramfs/inode.c          |   36 +++++++++++++++++--
 fs/ramfs/xattr.c          |   87 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ramfs/xattr.h          |   39 ++++++++++++++++++++
 fs/ramfs/xattr_security.c |   43 ++++++++++++++++++++++
 6 files changed, 228 insertions(+), 2 deletions(-)

 Signed-off-by: James Morris <jmorris@redhat.com>
 Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
    
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/Kconfig linux-2.6.8.1-mm2.w/fs/Kconfig
--- linux-2.6.8.1-mm2.p/fs/Kconfig	2004-08-23 13:27:54.690946600 -0400
+++ linux-2.6.8.1-mm2.w/fs/Kconfig	2004-08-23 13:27:45.330369624 -0400
@@ -961,6 +961,28 @@ config RAMFS
 	  To compile this as a module, choose M here: the module will be called
 	  ramfs.
 
+config RAMFS_XATTR
+	bool "ramfs Extended Attributes"
+	depends on RAMFS
+	help
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
+
+	  If unsure, say N.
+
+config RAMFS_SECURITY
+	bool "ramfs Security Labels"
+	depends on RAMFS_XATTR
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the ramfs filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
 config KEYFS
 	bool "Key managment database interface filesystem"
 	depends on KEYS
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ramfs/inode.c linux-2.6.8.1-mm2.w/fs/ramfs/inode.c
--- linux-2.6.8.1-mm2.p/fs/ramfs/inode.c	2004-06-16 01:19:11.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ramfs/inode.c	2004-08-23 13:27:45.331369472 -0400
@@ -34,6 +34,8 @@
 
 #include <asm/uaccess.h>
 
+#include "xattr.h"
+
 /* some random number */
 #define RAMFS_MAGIC	0x858458f6
 
@@ -42,6 +44,8 @@ static struct address_space_operations r
 static struct file_operations ramfs_file_operations;
 static struct inode_operations ramfs_file_inode_operations;
 static struct inode_operations ramfs_dir_inode_operations;
+static struct inode_operations ramfs_symlink_inode_operations;
+static struct inode_operations ramfs_special_inode_operations;
 
 static struct backing_dev_info ramfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -63,6 +67,7 @@ static struct inode *ramfs_get_inode(str
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
 		default:
+			inode->i_op = &ramfs_special_inode_operations;
 			init_special_inode(inode, mode, dev);
 			break;
 		case S_IFREG:
@@ -77,7 +82,7 @@ static struct inode *ramfs_get_inode(str
 			inode->i_nlink++;
 			break;
 		case S_IFLNK:
-			inode->i_op = &page_symlink_inode_operations;
+			inode->i_op = &ramfs_symlink_inode_operations;
 			break;
 		}
 	}
@@ -157,6 +162,10 @@ static struct file_operations ramfs_file
 
 static struct inode_operations ramfs_file_inode_operations = {
 	.getattr	= simple_getattr,
+	.setxattr	= ramfs_setxattr,
+	.getxattr	= ramfs_getxattr,
+	.listxattr	= ramfs_listxattr,
+	.removexattr	= ramfs_removexattr,
 };
 
 static struct inode_operations ramfs_dir_inode_operations = {
@@ -169,8 +178,28 @@ static struct inode_operations ramfs_dir
 	.rmdir		= simple_rmdir,
 	.mknod		= ramfs_mknod,
 	.rename		= simple_rename,
+	.setxattr	= ramfs_setxattr,
+	.getxattr	= ramfs_getxattr,
+	.listxattr	= ramfs_listxattr,
+	.removexattr	= ramfs_removexattr,
+};
+
+static struct inode_operations ramfs_symlink_inode_operations = {
+	.readlink	= page_readlink,
+	.follow_link	= page_follow_link,
+	.setxattr	= ramfs_setxattr,
+	.getxattr	= ramfs_getxattr,
+	.listxattr	= ramfs_listxattr,
+	.removexattr	= ramfs_removexattr,
+};
+
+static struct inode_operations ramfs_special_inode_operations = {
+	.setxattr	= ramfs_setxattr,
+	.getxattr	= ramfs_getxattr,
+	.listxattr	= ramfs_listxattr,
+	.removexattr	= ramfs_removexattr,
 };
-
+ 
 static struct super_operations ramfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
@@ -224,6 +253,9 @@ static struct file_system_type rootfs_fs
 
 static int __init init_ramfs_fs(void)
 {
+	int err = init_ramfs_xattr();
+	if (err)
+		return err;
 	return register_filesystem(&ramfs_fs_type);
 }
 
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ramfs/Makefile linux-2.6.8.1-mm2.w/fs/ramfs/Makefile
--- linux-2.6.8.1-mm2.p/fs/ramfs/Makefile	2004-06-16 01:20:26.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ramfs/Makefile	2004-08-23 13:27:45.332369320 -0400
@@ -5,3 +5,6 @@
 obj-$(CONFIG_RAMFS) += ramfs.o
 
 ramfs-objs := inode.o
+ramfs-$(CONFIG_RAMFS_XATTR)	+= xattr.o
+ramfs-$(CONFIG_RAMFS_SECURITY)	+= xattr_security.o
+
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ramfs/xattr.c linux-2.6.8.1-mm2.w/fs/ramfs/xattr.c
--- linux-2.6.8.1-mm2.p/fs/ramfs/xattr.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8.1-mm2.w/fs/ramfs/xattr.c	2004-08-23 13:27:45.333369168 -0400
@@ -0,0 +1,87 @@
+/*
+ * Pseudo xattr support for ramfs.
+ *
+ * Based on fs/devpts/xattr.c by Stephen Smalley <sds@epoch.ncsc.mil>
+ *
+ * Copyright (c) 2004, Joshua Brindle <method@gentoo.org>
+ * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ */
+#include <linux/init.h>
+#include <linux/fs.h>
+#include "xattr.h"
+
+static struct simple_xattr_handler *ramfs_xattr_handlers[SIMPLE_XATTR_MAX];
+static struct simple_xattr_info ramfs_xattr_info;
+
+ssize_t ramfs_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size)
+{
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = simple_xattr_resolve_name(&ramfs_xattr_info, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->get(inode, name, buffer, size);
+}
+
+ssize_t ramfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	return simple_xattr_list(&ramfs_xattr_info, dentry, buffer, size);
+}
+
+int ramfs_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags)
+{
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	if (size == 0)
+		value = "";  /* empty EA, do not remove */
+	handler = simple_xattr_resolve_name(&ramfs_xattr_info, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, value, size, flags);
+}
+
+int ramfs_removexattr(struct dentry *dentry, const char *name)
+{
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = simple_xattr_resolve_name(&ramfs_xattr_info, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
+}
+
+int __init init_ramfs_xattr(void)
+{
+#ifdef CONFIG_RAMFS_SECURITY	
+	int	err;
+	
+	ramfs_xattr_info.lock = RW_LOCK_UNLOCKED;
+	ramfs_xattr_info.handlers = ramfs_xattr_handlers;
+
+	err = simple_xattr_register(&ramfs_xattr_info,
+				    RAMFS_XATTR_INDEX_SECURITY,
+				    &ramfs_xattr_security_handler);
+	if (err)
+		return err;
+#endif
+
+	return 0;
+}
+
+void exit_ramfs_xattr(void)
+{
+#ifdef CONFIG_RAMFS_FS_SECURITY	
+	simple_xattr_unregister(&ramfs_xattr_info,
+				RAMFS_XATTR_INDEX_SECURITY,
+				&ramfs_xattr_security_handler);
+#endif
+
+}
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ramfs/xattr.h linux-2.6.8.1-mm2.w/fs/ramfs/xattr.h
--- linux-2.6.8.1-mm2.p/fs/ramfs/xattr.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8.1-mm2.w/fs/ramfs/xattr.h	2004-08-23 13:27:45.333369168 -0400
@@ -0,0 +1,39 @@
+/*
+ * Pseudo xattr support for ramfs.
+ */
+#include <linux/config.h>
+#include <linux/xattr.h>
+
+/* Name indexes */
+#define RAMFS_XATTR_INDEX_SECURITY	1
+
+#ifdef CONFIG_RAMFS_XATTR
+
+int ramfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
+ssize_t ramfs_getxattr(struct dentry *, const char *, void *, size_t);
+ssize_t ramfs_listxattr(struct dentry *, char *, size_t);
+int ramfs_removexattr(struct dentry *, const char *);
+
+int init_ramfs_xattr(void);
+void exit_ramfs_xattr(void);
+
+#else	/* !CONFIG_RAMFS_XATTR */
+
+#define ramfs_setxattr		NULL
+#define ramfs_getxattr		NULL
+#define ramfs_listxattr		NULL
+#define ramfs_removexattr	NULL
+
+static inline int init_ramfs_xattr(void)
+{
+	return 0;
+}
+
+static inline void exit_ramfs_xattr(void)
+{
+}
+
+#endif  /* CONFIG_RAMFS_XATTR */
+
+extern struct simple_xattr_handler ramfs_xattr_security_handler;
+
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ramfs/xattr_security.c linux-2.6.8.1-mm2.w/fs/ramfs/xattr_security.c
--- linux-2.6.8.1-mm2.p/fs/ramfs/xattr_security.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8.1-mm2.w/fs/ramfs/xattr_security.c	2004-08-23 13:28:49.505613504 -0400
@@ -0,0 +1,43 @@
+/*
+ * Security xattr support for ramfs.
+ *
+ * Based on fs/devpts/xattr_security.c by Stephen Smalley <sds@epoch.ncsc.mil>
+ *
+ * Copyright (c) 2004, Chris PeBenito <pebenito@gentoo.org>
+ * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ */
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/security.h>
+#include "xattr.h"
+
+static size_t ramfs_xattr_security_list(struct inode *inode, char *list, const char *name, int name_len)
+{
+	return security_inode_listsecurity(inode, list);
+}
+
+static int ramfs_xattr_security_get(struct inode *inode, const char *name, void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_getsecurity(inode, name, buffer, size);
+}
+
+static int ramfs_xattr_security_set(struct inode *inode, const char *name, const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_setsecurity(inode, name, value, size, flags);
+}
+
+struct simple_xattr_handler ramfs_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= ramfs_xattr_security_list,
+	.get	= ramfs_xattr_security_get,
+	.set	= ramfs_xattr_security_set,
+};

