Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbULJAwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbULJAwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbULJAwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:52:33 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17350 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261682AbULJAvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:51:06 -0500
Date: Thu, 9 Dec 2004 16:50:56 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041210005055.GA17822@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago a comment from another kernel developer about why they put a
huge file in sysfs (one that was bigger than a single page and contained
more than just 1 type of information), was something like, "well, it was
just so easy, and there was no other place to put debugging stuff like
that," got me to thinking.

What if there was a in-kernel filesystem that was explicitly just for
putting debugging stuff?  Some place other than proc and sysfs, and that
was easier than both of them to use.  Yet it needed to also be able to
handle complex stuff like seq file and raw file_ops if needed.

Thus debugfs was born (yes, I know there's a userspace program called
debugfs, this is an in-kernel filesystem and has nothing to do with
that.)  debugfs is ment for putting stuff that kernel developers need to
see exported to userspace, yet don't always want hanging around.

To create a file using debugfs the call is just:
  struct dentry *debugfs_create_file(const char *name, mode_t mode,
			             struct dentry *parent, void *data,
				     struct file_operations *fops);

If that looks too complex for you, and you just want to export a single
value to userspace, how about:
  struct dentry *debugfs_create_u8(const char *name, mode_t mode, struct dentry *parent, u8 *value);

That's it, one line of code and you have a variable that can be read and
written to from userspace.  Dave Hansen, you can stop complaining about
complexity right now :)

And if you want to create a directory to put all of your stuff in (which
is a good idea, as no one is going to even try to manage the debugfs
namespace):
  struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)

That will give you a dentry to use in the other debugfs functions.

So, here's a patch against 2.6.10-rc3 (it will probably apply cleanly
against 2.6.9, but I haven't tried it.)  It still needs a bit more
cleanup (it shouldn't be a module and the init level needs to be bumped
up if core kernel code uses it) but it works and I'm asking for comments
about it.

Do we want more simple types of files?  A "string" type isn't really
needed as it's only about 3 lines of code to create your own "read"
function these days.

And I'll follow this patch up with a patch for the USB uhci driver that
converts from using /proc/driver/uhci to use debugfs, which makes that
driver smaller.

thanks,

greg k-h

p.s. I think the recently posted infiband driver can take advantage of
this fs instead of having to create it's own debug filesystem.


-------------------


diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	2004-12-09 16:32:32 -08:00
+++ b/fs/Makefile	2004-12-09 16:32:32 -08:00
@@ -94,3 +94,4 @@
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
+obj-$(CONFIG_DEBUG_FS)		+= debugfs/
diff -Nru a/fs/debugfs/Makefile b/fs/debugfs/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/debugfs/Makefile	2004-12-09 16:32:32 -08:00
@@ -0,0 +1,4 @@
+debugfs-objs	:= inode.o file.o
+
+obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
+
diff -Nru a/fs/debugfs/debugfs.h b/fs/debugfs/debugfs.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/debugfs/debugfs.h	2004-12-09 16:32:32 -08:00
@@ -0,0 +1,10 @@
+#define DEBUG
+
+#ifdef DEBUG
+#define dbg(format, arg...) printk(KERN_DEBUG "%s: " format , __FILE__ , ## arg)
+#else
+#define dbg(format, arg...) do {} while (0)
+#endif
+
+extern struct file_operations debugfs_file_operations;
+
diff -Nru a/fs/debugfs/debugfs_test.c b/fs/debugfs/debugfs_test.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/debugfs/debugfs_test.c	2004-12-09 16:32:32 -08:00
@@ -0,0 +1,61 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/usb.h>
+#include <linux/namei.h>
+#include <linux/usbdevice_fs.h>
+#include <linux/smp_lock.h>
+#include <linux/parser.h>
+#include <asm/byteorder.h>
+#include "debugfs.h"
+
+
+static struct dentry *test_dentry;
+static struct dentry *test_dir;
+static struct dentry *test_u32_dentry;
+static u32 value = 42;
+
+
+static ssize_t default_read_file(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	char buf[10];
+
+	sprintf(buf, "foo\n");
+	return simple_read_from_buffer(user_buf, count, ppos, buf, sizeof(buf));
+}
+
+
+static int default_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static struct file_operations default_file_operations = {
+	.read =		default_read_file,
+	.open =		default_open,
+};
+
+static int __init test_init(void)
+{
+	test_dir = debugfs_create_dir("foo_dir", NULL);
+	test_dentry = debugfs_create_file("foo", 0444, test_dir, NULL, &default_file_operations);
+	test_u32_dentry = debugfs_create_u32("foo_u32", 0444, test_dir, &value);
+	return 0;
+}
+
+static void __exit test_exit(void)
+{
+	debugfs_remove(test_u32_dentry);
+	debugfs_remove(test_dentry);
+	debugfs_remove(test_dir);
+}
+
+module_init(test_init);
+module_exit(test_exit);
+MODULE_LICENSE("GPL");
+
diff -Nru a/fs/debugfs/file.c b/fs/debugfs/file.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/debugfs/file.c	2004-12-09 16:32:32 -08:00
@@ -0,0 +1,165 @@
+/*
+ *  debugfs.c  - a tiny little debug file system for people to use instead of /proc or /sys
+ *
+ *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *  Copyright (C) 2004 IBM Inc.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/debugfs.h>
+#include "debugfs.h"
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
+static loff_t default_file_lseek(struct file *file, loff_t offset, int orig)
+{
+	loff_t retval = -EINVAL;
+
+	down(&file->f_dentry->d_inode->i_sem);
+	switch(orig) {
+	case 0:
+		if (offset > 0) {
+			file->f_pos = offset;
+			retval = file->f_pos;
+		} 
+		break;
+	case 1:
+		if ((offset + file->f_pos) > 0) {
+			file->f_pos += offset;
+			retval = file->f_pos;
+		} 
+		break;
+	default:
+		break;
+	}
+	up(&file->f_dentry->d_inode->i_sem);
+	return retval;
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
+	.llseek =	default_file_lseek,
+};
+
+
+#define simple_type(type, format, temptype, strtolfn)	\
+static ssize_t read_file_##type(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)	\
+{													\
+	char buf[32];											\
+	type *val = file->private_data;									\
+													\
+	snprintf(buf, sizeof(buf), format, *val);							\
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));			\
+}													\
+static ssize_t write_file_##type(struct file *file, const char __user *user_buf, size_t count, loff_t *ppos)	\
+{													\
+	char *endp;											\
+	char buf[32];											\
+	int buf_size;											\
+	type *val = file->private_data;									\
+	temptype tmp;											\
+													\
+	memset(buf, 0x00, sizeof(buf));									\
+	buf_size = min(count, (sizeof(buf)-1));								\
+	if (copy_from_user(buf, user_buf, buf_size))							\
+		return -EFAULT;										\
+													\
+	tmp = strtolfn(buf, &endp, 0);									\
+	if ((endp == buf) || ((type)tmp != tmp))							\
+		return -EINVAL;										\
+	*val = tmp;											\
+	return count;											\
+}													\
+static struct file_operations fops_##type = {								\
+	.read =		read_file_##type,								\
+	.write =	write_file_##type,								\
+	.open =		default_open,									\
+	.llseek =	default_file_lseek,								\
+};													\
+struct dentry *debugfs_create_##type(const char *name, mode_t mode, struct dentry *parent, type *value)	\
+{													\
+	return debugfs_create_file(name, mode, parent, value, &fops_##type);				\
+}
+
+simple_type(u8, "%c", unsigned long, simple_strtoul);
+simple_type(u16, "%hi", unsigned long, simple_strtoul);
+simple_type(u32, "%i", unsigned long, simple_strtoul);
+EXPORT_SYMBOL_GPL(debugfs_create_u8);
+EXPORT_SYMBOL_GPL(debugfs_create_u16);
+EXPORT_SYMBOL_GPL(debugfs_create_u32);
+
+static ssize_t read_file_bool(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
+{
+	char buf[2];
+	u32 *val = file->private_data;
+	
+	if (val)
+		buf[0] = 'Y';
+	else
+		buf[0] = 'N';
+	buf[1] = 0x00;
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t write_file_bool(struct file *file, const char __user *user_buf, size_t count, loff_t *ppos)
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
+	.llseek =	default_file_lseek,
+};
+
+struct dentry *debugfs_create_bool(const char *name, mode_t mode, struct dentry *parent, u32 *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_bool);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_bool);
+
diff -Nru a/fs/debugfs/inode.c b/fs/debugfs/inode.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/debugfs/inode.c	2004-12-09 16:32:32 -08:00
@@ -0,0 +1,229 @@
+/*
+ *  debugfs.c  - a tiny little debug file system for people to use instead of /proc or /sys
+ *
+ *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *  Copyright (C) 2004 IBM Inc.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/debugfs.h>
+#include "debugfs.h"
+
+#define DEBUG_MAGIC	0x64626720
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
+	return simple_fill_super(sb, DEBUG_MAGIC, debug_files);
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
+		dbg("Ah! can not find a parent!\n");
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
+struct dentry *debugfs_create_file(const char *name, mode_t mode,
+				   struct dentry *parent, void *data,
+				   struct file_operations *fops)
+{
+	struct dentry *dentry = NULL;
+	int error;
+
+	dbg("creating file '%s'\n",name);
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
+module_init(debugfs_init);
+module_exit(debugfs_exit);
+MODULE_LICENSE("GPL");
+
diff -Nru a/include/linux/debugfs.h b/include/linux/debugfs.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/debugfs.h	2004-12-09 16:32:32 -08:00
@@ -0,0 +1,47 @@
+/*
+ *  debugfs.h  - a tiny little debug file system for people to use instead of /proc or /sys
+ *
+ *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *  Copyright (C) 2004 IBM Inc.
+ */
+
+#ifndef _DEBUGFS_H_
+#define _DEBUGFS_H_
+
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEBUG_FS_MODULE)
+struct dentry *debugfs_create_file(const char *name, mode_t mode,
+				   struct dentry *parent, void *data,
+				   struct file_operations *fops);
+
+static inline struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
+{
+	return debugfs_create_file(name, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO, parent, NULL, NULL);
+}
+
+void debugfs_remove(struct dentry *dentry);
+
+struct dentry *debugfs_create_u8(const char *name, mode_t mode, struct dentry *parent, u8 *value);
+struct dentry *debugfs_create_u16(const char *name, mode_t mode, struct dentry *parent, u16 *value);
+struct dentry *debugfs_create_u32(const char *name, mode_t mode, struct dentry *parent, u32 *value);
+struct dentry *debugfs_create_bool(const char *name, mode_t mode, struct dentry *parent, u32 *value);
+
+#else
+static inline struct dentry *debugfs_create_file(const char *name, mode_t mode, struct dentry *parent, void *data, struct file_operations *fops)
+{ return ERR_PTR(-ENODEV); }
+static inline struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
+{ return ERR_PTR(-ENODEV); }
+
+static inline void debugfs_remove(struct dentry *dentry) { }
+
+static inline struct dentry *debugfs_create_u8(const char *name, mode_t mode, struct dentry *parent, u8 *value)
+{ return ERR_PTR(-ENODEV); }
+static inline struct dentry *debugfs_create_u16(const char *name, mode_t mode, struct dentry *parent, u16 *value)
+{ return ERR_PTR(-ENODEV); }
+static inline struct dentry *debugfs_create_u32(const char *name, mode_t mode, struct dentry *parent, u32 *value)
+{ return ERR_PTR(-ENODEV); }
+static inline struct dentry *debugfs_create_bool(const char *name, mode_t mode, struct dentry *parent, u32 *value)
+{ return EFF_PTR(-ENODEV); }
+
+#endif
+
+#endif
diff -Nru a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug	2004-12-09 16:32:17 -08:00
+++ b/lib/Kconfig.debug	2004-12-09 16:32:17 -08:00
@@ -107,6 +107,18 @@
         If you're truly short on disk space or don't expect to report any
         bugs back to the UML developers, say N, otherwise say Y.
 
+config DEBUG_FS
+	tristate "Debug Filesystem"
+	help
+	  debugfs is a virtual file system that kernel developers use to put
+	  debugging files into.  Enable this option to be able to read and
+	  write to these files.
+
+	  If unsure, say N.
+
+	  To compile this as a module, choose M here: the module will be called
+	  debugfs.
+
 if !X86_64
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
