Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266590AbUHWS3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUHWS3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUHWS3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:29:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266509AbUHWSVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:21:05 -0400
Date: Mon, 23 Aug 2004 14:20:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][6/7] add xattr support to tmpfs
In-Reply-To: <Xine.LNX.4.44.0408231419010.13728-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds xattr support to tmpfs, and a security xattr handler.
Original patch from: Luke Kenneth Casson Leighton <lkcl@lkcl.net>


 fs/Kconfig                |   22 +++++++++++
 mm/Makefile               |    2 +
 mm/shmem.c                |   57 +++++++++++++++++++++++++++---
 mm/shmem_xattr.c          |   86 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/shmem_xattr.h          |   39 ++++++++++++++++++++
 mm/shmem_xattr_security.c |   43 +++++++++++++++++++++++
 6 files changed, 243 insertions(+), 6 deletions(-)

 Signed-off-by: James Morris <jmorris@redhat.com>
 Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
    
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/Kconfig linux-2.6.8.1-mm2.w/fs/Kconfig
--- linux-2.6.8.1-mm2.p/fs/Kconfig	2004-08-19 10:32:52.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/Kconfig	2004-08-23 01:28:04.582841048 -0400
@@ -918,6 +918,28 @@ config TMPFS
 
 	  See <file:Documentation/filesystems/tmpfs.txt> for details.
 
+config TMPFS_XATTR
+	bool "tmpfs Extended Attributes"
+	depends on TMPFS
+	help
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
+
+	  If unsure, say N.
+
+config TMPFS_SECURITY
+	bool "tmpfs Security Labels"
+	depends on TMPFS_XATTR
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the tmpfs filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || X86_64 || BROKEN
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/mm/Makefile linux-2.6.8.1-mm2.w/mm/Makefile
--- linux-2.6.8.1-mm2.p/mm/Makefile	2004-08-19 10:32:55.000000000 -0400
+++ linux-2.6.8.1-mm2.w/mm/Makefile	2004-08-23 01:28:04.583840896 -0400
@@ -15,3 +15,5 @@ obj-y			:= bootmem.o filemap.o mempool.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
+obj-$(CONFIG_TMPFS_XATTR)	+= shmem_xattr.o
+obj-$(CONFIG_TMPFS_SECURITY)	+= shmem_xattr_security.o
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/mm/shmem.c linux-2.6.8.1-mm2.w/mm/shmem.c
--- linux-2.6.8.1-mm2.p/mm/shmem.c	2004-08-19 10:32:55.000000000 -0400
+++ linux-2.6.8.1-mm2.w/mm/shmem.c	2004-08-23 01:28:04.585840592 -0400
@@ -10,6 +10,10 @@
  * Copyright (C) 2002-2003 VERITAS Software Corporation.
  * Copyright (C) 2004 Andi Kleen, SuSE Labs
  *
+ * Extended attribute support for tmpfs:
+ * Copyright (c) 2004, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
  * This file is released under the GPL.
  */
 
@@ -45,6 +49,8 @@
 #include <asm/div64.h>
 #include <asm/pgtable.h>
 
+#include "shmem_xattr.h"
+
 /* This magic number is used in glibc for posix shared memory */
 #define TMPFS_MAGIC	0x01021994
 
@@ -171,6 +177,7 @@ static struct address_space_operations s
 static struct file_operations shmem_file_operations;
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
+static struct inode_operations shmem_special_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info = {
@@ -1211,6 +1218,7 @@ shmem_get_inode(struct super_block *sb, 
  		mpol_shared_policy_init(&info->policy);
 		switch (mode & S_IFMT) {
 		default:
+			inode->i_op = &shmem_special_inode_operations;
 			init_special_inode(inode, mode, dev);
 			break;
 		case S_IFREG:
@@ -1708,6 +1716,12 @@ static void shmem_put_link(struct dentry
 static struct inode_operations shmem_symlink_inline_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link_inline,
+#ifdef CONFIG_TMPFS
+	.setxattr       = shmem_setxattr,
+	.getxattr       = shmem_getxattr,
+	.listxattr      = shmem_listxattr,
+	.removexattr    = shmem_removexattr,
+#endif
 };
 
 static struct inode_operations shmem_symlink_inode_operations = {
@@ -1715,6 +1729,12 @@ static struct inode_operations shmem_sym
 	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link,
 	.put_link	= shmem_put_link,
+#ifdef CONFIG_TMPFS
+	.setxattr       = shmem_setxattr,
+	.getxattr       = shmem_getxattr,
+	.listxattr      = shmem_listxattr,
+	.removexattr    = shmem_removexattr,
+#endif	
 };
 
 static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
@@ -1933,6 +1953,12 @@ static struct file_operations shmem_file
 static struct inode_operations shmem_inode_operations = {
 	.truncate	= shmem_truncate,
 	.setattr	= shmem_notify_change,
+#ifdef CONFIG_TMPFS
+	.setxattr	= shmem_setxattr,
+	.getxattr	= shmem_getxattr,
+	.listxattr	= shmem_listxattr,
+	.removexattr	= shmem_removexattr,
+#endif
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
@@ -1946,6 +1972,19 @@ static struct inode_operations shmem_dir
 	.rmdir		= shmem_rmdir,
 	.mknod		= shmem_mknod,
 	.rename		= shmem_rename,
+	.setxattr       = shmem_setxattr,
+	.getxattr       = shmem_getxattr,
+	.listxattr      = shmem_listxattr,
+	.removexattr    = shmem_removexattr,
+#endif
+};
+
+static struct inode_operations shmem_special_inode_operations = {
+#ifdef CONFIG_TMPFS
+	.setxattr	= shmem_setxattr,
+	.getxattr	= shmem_getxattr,
+	.listxattr	= shmem_listxattr,
+	.removexattr	= shmem_removexattr,
 #endif
 };
 
@@ -1990,12 +2029,16 @@ static int __init init_tmpfs(void)
 
 	error = init_inodecache();
 	if (error)
-		goto out3;
+		goto out_error;
+
+	error = init_shmem_xattr();
+	if (error)
+		goto out_destroy_inodecache;
 
 	error = register_filesystem(&tmpfs_fs_type);
 	if (error) {
 		printk(KERN_ERR "Could not register tmpfs\n");
-		goto out2;
+		goto out_exit_shmem_xattr;
 	}
 #ifdef CONFIG_TMPFS
 	devfs_mk_dir("shm");
@@ -2004,18 +2047,20 @@ static int __init init_tmpfs(void)
 	if (IS_ERR(shm_mnt)) {
 		error = PTR_ERR(shm_mnt);
 		printk(KERN_ERR "Could not kern_mount tmpfs\n");
-		goto out1;
+		goto out_unregister;
 	}
 
 	/* The internal instance should not do size checking */
 	shmem_set_size(SHMEM_SB(shm_mnt->mnt_sb), ULONG_MAX, ULONG_MAX);
 	return 0;
 
-out1:
+out_unregister:
 	unregister_filesystem(&tmpfs_fs_type);
-out2:
+out_exit_shmem_xattr:
+	exit_shmem_xattr();
+out_destroy_inodecache:
 	destroy_inodecache();
-out3:
+out_error:
 	shm_mnt = ERR_PTR(error);
 	return error;
 }
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/mm/shmem_xattr.c linux-2.6.8.1-mm2.w/mm/shmem_xattr.c
--- linux-2.6.8.1-mm2.p/mm/shmem_xattr.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8.1-mm2.w/mm/shmem_xattr.c	2004-08-23 01:28:54.336277376 -0400
@@ -0,0 +1,86 @@
+/*
+ * Pseudo xattr support for tmpfs.
+ *
+ * Based on fs/devpts/xattr.c by Stephen Smalley <sds@epoch.ncsc.mil>
+ *
+ * Copyright (c) 2004, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ */
+#include <linux/init.h>
+#include <linux/fs.h>
+#include "shmem_xattr.h"
+
+static struct simple_xattr_handler *shmem_xattr_handlers[SIMPLE_XATTR_MAX];
+static struct simple_xattr_info shmem_xattr_info;
+
+ssize_t shmem_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size)
+{
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = simple_xattr_resolve_name(&shmem_xattr_info, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->get(inode, name, buffer, size);
+}
+
+ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	return simple_xattr_list(&shmem_xattr_info, dentry, buffer, size);
+}
+
+int shmem_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags)
+{
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	if (size == 0)
+		value = "";  /* empty EA, do not remove */
+	handler = simple_xattr_resolve_name(&shmem_xattr_info, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, value, size, flags);
+}
+
+int shmem_removexattr(struct dentry *dentry, const char *name)
+{
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = simple_xattr_resolve_name(&shmem_xattr_info, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
+}
+
+int __init init_shmem_xattr(void)
+{
+#ifdef CONFIG_TMPFS_SECURITY
+	int	err;
+	
+	shmem_xattr_info.lock = RW_LOCK_UNLOCKED;
+	shmem_xattr_info.handlers = shmem_xattr_handlers;
+
+	err = simple_xattr_register(&shmem_xattr_info,
+				    SHMEM_XATTR_INDEX_SECURITY,
+				    &shmem_xattr_security_handler);
+	if (err)
+		return err;
+#endif
+	return 0;
+}
+
+void exit_shmem_xattr(void)
+{
+#ifdef CONFIG_TMPFS_SECURITY
+	simple_xattr_unregister(&shmem_xattr_info,
+				SHMEM_XATTR_INDEX_SECURITY,
+				&shmem_xattr_security_handler);
+#endif
+
+}
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/mm/shmem_xattr.h linux-2.6.8.1-mm2.w/mm/shmem_xattr.h
--- linux-2.6.8.1-mm2.p/mm/shmem_xattr.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8.1-mm2.w/mm/shmem_xattr.h	2004-08-23 01:28:04.587840288 -0400
@@ -0,0 +1,39 @@
+/*
+ * Pseudo xattr support for tmpfs.
+ */
+#include <linux/config.h>
+#include <linux/xattr.h>
+
+/* Name indexes */
+#define SHMEM_XATTR_INDEX_SECURITY	1
+
+#ifdef CONFIG_TMPFS_XATTR
+
+int shmem_setxattr(struct dentry *, const char *, const void *, size_t, int);
+ssize_t shmem_getxattr(struct dentry *, const char *, void *, size_t);
+ssize_t shmem_listxattr(struct dentry *, char *, size_t);
+int shmem_removexattr(struct dentry *, const char *);
+
+int init_shmem_xattr(void);
+void exit_shmem_xattr(void);
+
+#else	/* !CONFIG_TMPFS_XATTR */
+
+#define shmem_setxattr		NULL
+#define shmem_getxattr		NULL
+#define shmem_listxattr		NULL
+#define shmem_removexattr	NULL
+
+static inline int init_shmem_xattr(void)
+{
+	return 0;
+}
+
+static inline void exit_shmem_xattr(void)
+{
+}
+
+#endif  /* CONFIG_TMPFS_XATTR */
+
+extern struct simple_xattr_handler shmem_xattr_security_handler;
+
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/mm/shmem_xattr_security.c linux-2.6.8.1-mm2.w/mm/shmem_xattr_security.c
--- linux-2.6.8.1-mm2.p/mm/shmem_xattr_security.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8.1-mm2.w/mm/shmem_xattr_security.c	2004-08-23 01:28:50.042930064 -0400
@@ -0,0 +1,43 @@
+/*
+ * Security xattr support for tmpfs.
+ *
+ * Based on fs/devpts/xattr_security.c by Stephen Smalley <sds@epoch.ncsc.mil>
+ *
+ * Copyright (c) 2004, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
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
+#include "shmem_xattr.h"
+
+static size_t shmem_xattr_security_list(struct inode *inode, char *list, const char *name, int name_len)
+{
+	return security_inode_listsecurity(inode, list);
+}
+
+static int shmem_xattr_security_get(struct inode *inode, const char *name, void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_getsecurity(inode, name, buffer, size);
+}
+
+static int shmem_xattr_security_set(struct inode *inode, const char *name, const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_setsecurity(inode, name, value, size, flags);
+}
+
+struct simple_xattr_handler shmem_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= shmem_xattr_security_list,
+	.get	= shmem_xattr_security_get,
+	.set	= shmem_xattr_security_set,
+};

