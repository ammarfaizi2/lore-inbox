Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVGCUqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVGCUqK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 16:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVGCUqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 16:46:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:62614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261530AbVGCUou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 16:44:50 -0400
Date: Sun, 3 Jul 2005 13:44:24 -0700
From: Greg KH <greg@kroah.com>
To: James Morris <jmorris@redhat.com>
Cc: Tony Jones <tonyj@suse.de>, serge@hallyn.com, serue@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] securityfs
Message-ID: <20050703204423.GA17418@kroah.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 02:53:17PM -0400, James Morris wrote:
> On Sun, 3 Jul 2005, Tony Jones wrote:
> 
> > There just isn't enough content to justify a stacker specific filesystem IMHO.
> 
> It might be worth thinking about a more general securityfs as part of LSM,
> to be used by stacker and LSM modules.  SELinux could use this instead of
> managing its own selinuxfs.

Good idea.  Here's a patch to do just that (compile tested only...)

Comments?

thanks,

greg k-h


 include/linux/security.h |    5 
 security/Makefile        |    2 
 security/inode.c         |  336 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+), 1 deletion(-)

Index: gregkh-2.6/security/Makefile
===================================================================
--- gregkh-2.6.orig/security/Makefile	2005-06-17 12:48:29.000000000 -0700
+++ gregkh-2.6/security/Makefile	2005-07-03 13:26:39.000000000 -0700
@@ -11,7 +11,7 @@
 endif
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o dummy.o
+obj-$(CONFIG_SECURITY)			+= security.o dummy.o inode.o
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
Index: gregkh-2.6/security/inode.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/security/inode.c	2005-07-03 13:41:43.000000000 -0700
@@ -0,0 +1,336 @@
+/*
+ *  inode.c - part of securityfs
+ *
+ *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *  Copyright (C) 2004 IBM Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ *
+ */
+
+/* #define DEBUG */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+
+#define SECURITYFS_MAGIC	0x73636673
+
+static struct vfsmount *mount;
+static int mount_count;
+
+static ssize_t default_read_file(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	return 0;
+}
+
+static ssize_t default_write_file(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	return count;
+}
+
+static int default_open(struct inode *inode, struct file *file)
+{
+	if (inode->u.generic_ip)
+		file->private_data = inode->u.generic_ip;
+
+	return 0;
+}
+
+static struct file_operations default_file_ops = {
+	.read =		default_read_file,
+	.write =	default_write_file,
+	.open =		default_open,
+};
+
+static struct inode *get_inode(struct super_block *sb, int mode, dev_t dev)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = 0;
+		inode->i_gid = 0;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+		case S_IFREG:
+			inode->i_fop = &default_file_ops;
+			break;
+		case S_IFDIR:
+			inode->i_op = &simple_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			inode->i_nlink++;
+			break;
+		}
+	}
+	return inode;
+}
+
+/* SMP-safe */
+static int mknod(struct inode *dir, struct dentry *dentry,
+			 int mode, dev_t dev)
+{
+	struct inode *inode = get_inode(dir->i_sb, mode, dev);
+	int error = -EPERM;
+
+	if (dentry->d_inode)
+		return -EEXIST;
+
+	if (inode) {
+		d_instantiate(dentry, inode);
+		dget(dentry);
+		error = 0;
+	}
+	return error;
+}
+
+static int mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int res;
+
+	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
+	res = mknod(dir, dentry, mode, 0);
+	if (!res)
+		dir->i_nlink++;
+	return res;
+}
+
+static int create(struct inode *dir, struct dentry *dentry, int mode)
+{
+	mode = (mode & S_IALLUGO) | S_IFREG;
+	return mknod(dir, dentry, mode, 0);
+}
+
+static inline int positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+static int fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct tree_descr files[] = {{""}};
+
+	return simple_fill_super(sb, SECURITYFS_MAGIC, files);
+}
+
+static struct super_block *get_sb(struct file_system_type *fs_type,
+				        int flags, const char *dev_name,
+					void *data)
+{
+	return get_sb_single(fs_type, flags, data, fill_super);
+}
+
+static struct file_system_type fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"securityfs",
+	.get_sb =	get_sb,
+	.kill_sb =	kill_litter_super,
+};
+
+static int create_by_name(const char *name, mode_t mode,
+			  struct dentry *parent,
+			  struct dentry **dentry)
+{
+	int error = 0;
+
+	/* If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent ) {
+		if (mount && mount->mnt_sb) {
+			parent = mount->mnt_sb->s_root;
+		}
+	}
+	if (!parent) {
+		pr_debug("securityfs: Ah! can not find a parent!\n");
+		return -EFAULT;
+	}
+
+	*dentry = NULL;
+	down(&parent->d_inode->i_sem);
+	*dentry = lookup_one_len(name, parent, strlen(name));
+	if (!IS_ERR(dentry)) {
+		if ((mode & S_IFMT) == S_IFDIR)
+			error = mkdir(parent->d_inode, *dentry, mode);
+		else
+			error = create(parent->d_inode, *dentry, mode);
+	} else
+		error = PTR_ERR(dentry);
+	up(&parent->d_inode->i_sem);
+
+	return error;
+}
+
+/**
+ * securityfs_create_file - create a file in the securityfs filesystem
+ *
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          file will be created in the root of the securityfs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.u.generic_ip pointer will point to this value on
+ *        the open() call.
+ * @fops: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This is the basic "create a file" function for securityfs.  It allows for a
+ * wide range of flexibility in createing a file, or a directory (if you
+ * want to create a directory, the securityfs_create_dir() function is
+ * recommended to be used instead.)
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the securityfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If securityfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *securityfs_create_file(const char *name, mode_t mode,
+				   struct dentry *parent, void *data,
+				   struct file_operations *fops)
+{
+	struct dentry *dentry = NULL;
+	int error;
+
+	pr_debug("securityfs: creating file '%s'\n",name);
+
+	error = simple_pin_fs("securityfs", &mount, &mount_count);
+	if (error)
+		goto exit;
+
+	error = create_by_name(name, mode, parent, &dentry);
+	if (error) {
+		dentry = NULL;
+		goto exit;
+	}
+
+	if (dentry->d_inode) {
+		if (data)
+			dentry->d_inode->u.generic_ip = data;
+		if (fops)
+			dentry->d_inode->i_fop = fops;
+	}
+exit:
+	return dentry;
+}
+EXPORT_SYMBOL_GPL(securityfs_create_file);
+
+/**
+ * securityfs_create_dir - create a directory in the securityfs filesystem
+ *
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          directory will be created in the root of the securityfs filesystem.
+ *
+ * This function creates a directory in securityfs with the given name.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the securityfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If securityfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *securityfs_create_dir(const char *name, struct dentry *parent)
+{
+	return securityfs_create_file(name,
+				      S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+				      parent, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(securityfs_create_dir);
+
+/**
+ * securityfs_remove - removes a file or directory from the securityfs filesystem
+ *
+ * @dentry: a pointer to a the dentry of the file or directory to be
+ *          removed.
+ *
+ * This function removes a file or directory in securityfs that was previously
+ * created with a call to another securityfs function (like
+ * securityfs_create_file() or variants thereof.)
+ *
+ * This function is required to be called in order for the file to be
+ * removed, no automatic cleanup of files will happen when a module is
+ * removed, you are responsible here.
+ */
+void securityfs_remove(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	if (!dentry)
+		return;
+
+	parent = dentry->d_parent;
+	if (!parent || !parent->d_inode)
+		return;
+
+	down(&parent->d_inode->i_sem);
+	if (positive(dentry)) {
+		if (dentry->d_inode) {
+			if (S_ISDIR(dentry->d_inode->i_mode))
+				simple_rmdir(parent->d_inode, dentry);
+			else
+				simple_unlink(parent->d_inode, dentry);
+		dput(dentry);
+		}
+	}
+	up(&parent->d_inode->i_sem);
+	simple_release_fs(&mount, &mount_count);
+}
+EXPORT_SYMBOL_GPL(securityfs_remove);
+
+static decl_subsys(security, NULL, NULL);
+
+static int __init securityfs_init(void)
+{
+	int retval;
+
+	kset_set_kset_s(&security_subsys, kernel_subsys);
+	retval = subsystem_register(&security_subsys);
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&fs_type);
+	if (retval)
+		subsystem_unregister(&security_subsys);
+	return retval;
+}
+
+static void __exit securityfs_exit(void)
+{
+	simple_release_fs(&mount, &mount_count);
+	unregister_filesystem(&fs_type);
+	subsystem_unregister(&security_subsys);
+}
+
+core_initcall(securityfs_init);
+module_exit(securityfs_exit);
+MODULE_LICENSE("GPL");
+
Index: gregkh-2.6/include/linux/security.h
===================================================================
--- gregkh-2.6.orig/include/linux/security.h	2005-06-17 12:48:29.000000000 -0700
+++ gregkh-2.6/include/linux/security.h	2005-07-03 13:37:52.000000000 -0700
@@ -1983,6 +1983,11 @@
 extern int unregister_security	(struct security_operations *ops);
 extern int mod_reg_security	(const char *name, struct security_operations *ops);
 extern int mod_unreg_security	(const char *name, struct security_operations *ops);
+extern struct dentry *securityfs_create_file(const char *name, mode_t mode,
+					     struct dentry *parent, void *data,
+					     struct file_operations *fops);
+extern struct dentry *securityfs_create_dir(const char *name, struct dentry *parent);
+extern void securityfs_remove(struct dentry *dentry);
 
 
 #else /* CONFIG_SECURITY */
