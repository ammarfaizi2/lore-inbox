Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVAHGhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVAHGhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVAHGgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:36:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:15494 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261928AbVAHFsr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:47 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632592320@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:39 -0800
Message-Id: <11051632594155@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.6, 2004/12/16 13:16:18-08:00, greg@kroah.com

debugfs: add debugfs

debugfs is a filesystem that is just for debug data.  Start moving stuff out of proc and sysfs now :)

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/DocBook/kernel-api.tmpl |    9 
 fs/Makefile                           |    1 
 fs/debugfs/Makefile                   |    4 
 fs/debugfs/file.c                     |  262 ++++++++++++++++++++++++++++
 fs/debugfs/inode.c                    |  315 ++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h               |   90 +++++++++
 lib/Kconfig.debug                     |   10 +
 7 files changed, 691 insertions(+)


diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	2005-01-07 15:47:39 -08:00
+++ b/Documentation/DocBook/kernel-api.tmpl	2005-01-07 15:47:39 -08:00
@@ -105,6 +105,15 @@
      </sect1>
   </chapter>
 
+  <chapter id="debugfs">
+     <title>The debugfs filesystem</title>
+ 
+     <sect1><title>debugfs interface</title>
+!Efs/debugfs/inode.c
+!Efs/debugfs/file.c
+     </sect1>
+  </chapter>
+
   <chapter id="vfs">
      <title>The Linux VFS</title>
      <sect1><title>The Directory Cache</title>
diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	2005-01-07 15:47:39 -08:00
+++ b/fs/Makefile	2005-01-07 15:47:39 -08:00
@@ -94,3 +94,4 @@
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
+obj-$(CONFIG_DEBUG_FS)		+= debugfs/
diff -Nru a/fs/debugfs/Makefile b/fs/debugfs/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/debugfs/Makefile	2005-01-07 15:47:39 -08:00
@@ -0,0 +1,4 @@
+debugfs-objs	:= inode.o file.o
+
+obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
+
diff -Nru a/fs/debugfs/file.c b/fs/debugfs/file.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/debugfs/file.c	2005-01-07 15:47:39 -08:00
@@ -0,0 +1,262 @@
+/*
+ *  file.c - part of debugfs, a tiny little debug file system
+ *
+ *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *  Copyright (C) 2004 IBM Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ *
+ *  debugfs is for people to use instead of /proc or /sys.
+ *  See Documentation/DocBook/kernel-api for more details.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/debugfs.h>
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
+struct file_operations debugfs_file_operations = {
+	.read =		default_read_file,
+	.write =	default_write_file,
+	.open =		default_open,
+};
+
+#define simple_type(type, format, temptype, strtolfn)				\
+static ssize_t read_file_##type(struct file *file, char __user *user_buf,	\
+				size_t count, loff_t *ppos)			\
+{										\
+	char buf[32];								\
+	type *val = file->private_data;						\
+										\
+	snprintf(buf, sizeof(buf), format, *val);				\
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));\
+}										\
+static ssize_t write_file_##type(struct file *file, const char __user *user_buf,\
+				 size_t count, loff_t *ppos)			\
+{										\
+	char *endp;								\
+	char buf[32];								\
+	int buf_size;								\
+	type *val = file->private_data;						\
+	temptype tmp;								\
+										\
+	memset(buf, 0x00, sizeof(buf));						\
+	buf_size = min(count, (sizeof(buf)-1));					\
+	if (copy_from_user(buf, user_buf, buf_size))				\
+		return -EFAULT;							\
+										\
+	tmp = strtolfn(buf, &endp, 0);						\
+	if ((endp == buf) || ((type)tmp != tmp))				\
+		return -EINVAL;							\
+	*val = tmp;								\
+	return count;								\
+}										\
+static struct file_operations fops_##type = {					\
+	.read =		read_file_##type,					\
+	.write =	write_file_##type,					\
+	.open =		default_open,						\
+};
+simple_type(u8, "%c", unsigned long, simple_strtoul);
+simple_type(u16, "%hi", unsigned long, simple_strtoul);
+simple_type(u32, "%i", unsigned long, simple_strtoul);
+
+/**
+ * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ *
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *debugfs_create_u8(const char *name, mode_t mode,
+				 struct dentry *parent, u8 *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_u8);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_u8);
+
+/**
+ * debugfs_create_u16 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ *
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *debugfs_create_u16(const char *name, mode_t mode,
+				  struct dentry *parent, u16 *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_u16);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_u16);
+
+/**
+ * debugfs_create_u32 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ *
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *debugfs_create_u32(const char *name, mode_t mode,
+				 struct dentry *parent, u32 *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_u32);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_u32);
+
+static ssize_t read_file_bool(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	char buf[3];
+	u32 *val = file->private_data;
+	
+	if (val)
+		buf[0] = 'Y';
+	else
+		buf[0] = 'N';
+	buf[1] = '\n';
+	buf[2] = 0x00;
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t write_file_bool(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	char buf[32];
+	int buf_size;
+	u32 *val = file->private_data;
+
+	buf_size = min(count, (sizeof(buf)-1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	switch (buf[0]) {
+	case 'y':
+	case 'Y':
+	case '1':
+		*val = 1;
+		break;
+	case 'n':
+	case 'N':
+	case '0':
+		*val = 0;
+		break;
+	}
+	
+	return count;
+}
+
+static struct file_operations fops_bool = {
+	.read =		read_file_bool,
+	.write =	write_file_bool,
+	.open =		default_open,
+};
+
+/**
+ * debugfs_create_bool - create a file in the debugfs filesystem that is used to read and write a boolean value.
+ *
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *debugfs_create_bool(const char *name, mode_t mode,
+				   struct dentry *parent, u32 *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_bool);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_bool);
+
diff -Nru a/fs/debugfs/inode.c b/fs/debugfs/inode.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/debugfs/inode.c	2005-01-07 15:47:39 -08:00
@@ -0,0 +1,315 @@
+/*
+ *  file.c - part of debugfs, a tiny little debug file system
+ *
+ *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *  Copyright (C) 2004 IBM Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ *
+ *  debugfs is for people to use instead of /proc or /sys.
+ *  See Documentation/DocBook/kernel-api for more details.
+ *
+ */
+
+/* uncomment to get debug messages from the debug filesystem, ah the irony. */
+/* #define DEBUG */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/debugfs.h>
+
+#define DEBUGFS_MAGIC	0x64626720
+
+/* declared over in file.c */
+extern struct file_operations debugfs_file_operations;
+
+static struct vfsmount *debugfs_mount;
+static int debugfs_mount_count;
+
+static struct inode *debugfs_get_inode(struct super_block *sb, int mode, dev_t dev)
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
+			inode->i_fop = &debugfs_file_operations;
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
+static int debugfs_mknod(struct inode *dir, struct dentry *dentry,
+			 int mode, dev_t dev)
+{
+	struct inode *inode = debugfs_get_inode(dir->i_sb, mode, dev);
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
+static int debugfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int res;
+
+	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
+	res = debugfs_mknod(dir, dentry, mode, 0);
+	if (!res)
+		dir->i_nlink++;
+	return res;
+}
+
+static int debugfs_create(struct inode *dir, struct dentry *dentry, int mode)
+{
+	mode = (mode & S_IALLUGO) | S_IFREG;
+	return debugfs_mknod(dir, dentry, mode, 0);
+}
+
+static inline int debugfs_positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+static int debug_fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct tree_descr debug_files[] = {{""}};
+
+	return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
+}
+
+static struct dentry * get_dentry(struct dentry *parent, const char *name)
+{               
+	struct qstr qstr;
+
+	qstr.name = name;
+	qstr.len = strlen(name);
+	qstr.hash = full_name_hash(name,qstr.len);
+	return lookup_hash(&qstr,parent);
+}               
+
+static struct super_block *debug_get_sb(struct file_system_type *fs_type,
+				        int flags, const char *dev_name,
+					void *data)
+{
+	return get_sb_single(fs_type, flags, data, debug_fill_super);
+}
+
+static struct file_system_type debug_fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"debugfs",
+	.get_sb =	debug_get_sb,
+	.kill_sb =	kill_litter_super,
+};
+
+static int debugfs_create_by_name(const char *name, mode_t mode,
+				  struct dentry *parent,
+				  struct dentry **dentry)
+{
+	int error = 0;
+
+	/* If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super 
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent ) {
+		if (debugfs_mount && debugfs_mount->mnt_sb) {
+			parent = debugfs_mount->mnt_sb->s_root;
+		}
+	}
+	if (!parent) {
+		pr_debug("debugfs: Ah! can not find a parent!\n");
+		return -EFAULT;
+	}
+
+	*dentry = NULL;
+	down(&parent->d_inode->i_sem);
+	*dentry = get_dentry (parent, name);
+	if (!IS_ERR(dentry)) {
+		if ((mode & S_IFMT) == S_IFDIR)
+			error = debugfs_mkdir(parent->d_inode, *dentry, mode);
+		else 
+			error = debugfs_create(parent->d_inode, *dentry, mode);
+	} else
+		error = PTR_ERR(dentry);
+	up(&parent->d_inode->i_sem);
+
+	return error;
+}
+
+/**
+ * debugfs_create_file - create a file in the debugfs filesystem
+ *
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.u.generic_ip pointer will point to this value on
+ *        the open() call.
+ * @fops: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This is the basic "create a file" function for debugfs.  It allows for a
+ * wide range of flexibility in createing a file, or a directory (if you
+ * want to create a directory, the debugfs_create_dir() function is
+ * recommended to be used instead.)
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *debugfs_create_file(const char *name, mode_t mode,
+				   struct dentry *parent, void *data,
+				   struct file_operations *fops)
+{
+	struct dentry *dentry = NULL;
+	int error;
+
+	pr_debug("debugfs: creating file '%s'\n",name);
+
+	error = simple_pin_fs("debugfs", &debugfs_mount, &debugfs_mount_count);
+	if (error)
+		goto exit;
+
+	error = debugfs_create_by_name(name, mode, parent, &dentry);
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
+EXPORT_SYMBOL_GPL(debugfs_create_file);
+
+/**
+ * debugfs_create_dir - create a directory in the debugfs filesystem
+ *
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this paramater is NULL, then the
+ *          directory will be created in the root of the debugfs filesystem.
+ *
+ * This function creates a directory in debugfs with the given name.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, NULL will be returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
+{
+	return debugfs_create_file(name, 
+				   S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+				   parent, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_dir);
+
+/**
+ * debugfs_remove - removes a file or directory from the debugfs filesystem
+ *
+ * @dentry: a pointer to a the dentry of the file or directory to be
+ *          removed.
+ *
+ * This function removes a file or directory in debugfs that was previously
+ * created with a call to another debugfs function (like
+ * debufs_create_file() or variants thereof.)
+ *
+ * This function is required to be called in order for the file to be
+ * removed, no automatic cleanup of files will happen when a module is
+ * removed, you are responsible here.
+ */
+void debugfs_remove(struct dentry *dentry)
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
+	if (debugfs_positive(dentry)) {
+		if (dentry->d_inode) {
+			if (S_ISDIR(dentry->d_inode->i_mode))
+				simple_rmdir(parent->d_inode, dentry);
+			else
+				simple_unlink(parent->d_inode, dentry);
+		dput(dentry);
+		}
+	}
+	up(&parent->d_inode->i_sem);
+	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
+}
+EXPORT_SYMBOL_GPL(debugfs_remove);
+
+static int __init debugfs_init(void)
+{
+	return register_filesystem(&debug_fs_type);
+}
+
+static void __exit debugfs_exit(void)
+{
+	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
+	unregister_filesystem(&debug_fs_type);
+}
+
+core_initcall(debugfs_init);
+module_exit(debugfs_exit);
+MODULE_LICENSE("GPL");
+
diff -Nru a/include/linux/debugfs.h b/include/linux/debugfs.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/debugfs.h	2005-01-07 15:47:39 -08:00
@@ -0,0 +1,90 @@
+/*
+ *  debugfs.h - a tiny little debug file system
+ *
+ *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *  Copyright (C) 2004 IBM Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ *
+ *  debugfs is for people to use instead of /proc or /sys.
+ *  See Documentation/DocBook/kernel-api for more details.
+ */
+
+#ifndef _DEBUGFS_H_
+#define _DEBUGFS_H_
+
+#if defined(CONFIG_DEBUG_FS)
+struct dentry *debugfs_create_file(const char *name, mode_t mode,
+				   struct dentry *parent, void *data,
+				   struct file_operations *fops);
+
+struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
+
+void debugfs_remove(struct dentry *dentry);
+
+struct dentry *debugfs_create_u8(const char *name, mode_t mode,
+				 struct dentry *parent, u8 *value);
+struct dentry *debugfs_create_u16(const char *name, mode_t mode,
+				  struct dentry *parent, u16 *value);
+struct dentry *debugfs_create_u32(const char *name, mode_t mode,
+				  struct dentry *parent, u32 *value);
+struct dentry *debugfs_create_bool(const char *name, mode_t mode,
+				  struct dentry *parent, u32 *value);
+
+#else
+/* 
+ * We do not return NULL from these functions if CONFIG_DEBUG_FS is not enabled
+ * so users have a chance to detect if there was a real error or not.  We don't
+ * want to duplicate the design decision mistakes of procfs and devfs again.
+ */
+
+static inline struct dentry *debugfs_create_file(const char *name, mode_t mode,
+						 struct dentry *parent,
+						 void *data,
+						 struct file_operations *fops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct dentry *debugfs_create_dir(const char *name,
+						struct dentry *parent)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void debugfs_remove(struct dentry *dentry)
+{ }
+
+static inline struct dentry *debugfs_create_u8(const char *name, mode_t mode,
+					       struct dentry *parent,
+					       u8 *value)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct dentry *debugfs_create_u16(const char *name, mode_t mode,
+						struct dentry *parent,
+						u8 *value)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct dentry *debugfs_create_u32(const char *name, mode_t mode,
+						struct dentry *parent,
+						u8 *value)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct dentry *debugfs_create_bool(const char *name, mode_t mode,
+						 struct dentry *parent,
+						 u8 *value)
+{
+	return EFF_PTR(-ENODEV);
+}
+
+#endif
+
+#endif
diff -Nru a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug	2005-01-07 15:47:39 -08:00
+++ b/lib/Kconfig.debug	2005-01-07 15:47:39 -08:00
@@ -107,6 +107,16 @@
         If you're truly short on disk space or don't expect to report any
         bugs back to the UML developers, say N, otherwise say Y.
 
+config DEBUG_FS
+	bool "Debug Filesystem"
+	depends on DEBUG_KERNEL
+	help
+	  debugfs is a virtual file system that kernel developers use to put
+	  debugging files into.  Enable this option to be able to read and
+	  write to these files.
+
+	  If unsure, say N.
+
 if !X86_64
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"

