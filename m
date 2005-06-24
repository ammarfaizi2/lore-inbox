Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbVFXIWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbVFXIWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263222AbVFXIUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:20:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:9121 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262629AbVFXISV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:18:21 -0400
Date: Fri, 24 Jun 2005 01:18:08 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050624081808.GA26174@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now I just know I'm going to regret this somehow...

Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
tiny:
$ size fs/ndevfs/inode.o 
   text    data     bss     dec     hex filename
   1571     200       8    1779     6f3 fs/ndevfs/inode.o
replacement for devfs for those embedded users who just can't live
without the damm thing.  It doesn't allow subdirectories, and only uses
LSB compliant names.  But it works, and should be enough for people to
use, if they just can't wean themselves off of the idea of an in-kernel
fs to provide device nodes.

Now, with this, is there still anyone out there who just can't live
without devfs in their kernel?

Damm, the depths I've sunk to these days, I'm such a people pleaser...

Comments?  Questions?  Criticisms?

I need sleep.

greg k-h
---------------

ndevfs - a "nano" devfs

For embedded people to use since they seem to hate userspace.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/class.c   |    3 
 fs/Kconfig             |    3 
 fs/Makefile            |    1 
 fs/ndevfs/Makefile     |    4 
 fs/ndevfs/inode.c      |  249 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/partitions/check.c  |    6 +
 include/linux/ndevfs.h |   13 ++
 7 files changed, 279 insertions(+)

--- gregkh-2.6.orig/fs/Kconfig	2005-06-24 01:05:59.000000000 -0700
+++ gregkh-2.6/fs/Kconfig	2005-06-24 01:06:02.000000000 -0700
@@ -1700,6 +1700,9 @@
 config RXRPC
 	tristate
 
+config NDEV_FS
+	bool "Nano Device File System"
+
 endmenu
 
 menu "Partition Types"
--- gregkh-2.6.orig/fs/Makefile	2005-06-24 01:05:59.000000000 -0700
+++ gregkh-2.6/fs/Makefile	2005-06-24 01:06:02.000000000 -0700
@@ -95,3 +95,4 @@
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
+obj-$(CONFIG_NDEV_FS)		+= ndevfs/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/include/linux/ndevfs.h	2005-06-24 01:06:02.000000000 -0700
@@ -0,0 +1,13 @@
+#ifndef _NDEVFS_H_
+#define _NDEVFS_H_
+
+#if defined(CONFIG_NDEV_FS)
+extern void ndevfs_create(const char *name, dev_t dev, int is_char);
+extern void ndevfs_remove(const char *name);
+#else
+static inline void ndevfs_create(const char *name, dev_t dev, int is_char) {}
+static inline void ndevfs_remove(const char *name) {}
+#endif
+
+#endif
+
--- gregkh-2.6.orig/drivers/base/class.c	2005-06-24 01:05:59.000000000 -0700
+++ gregkh-2.6/drivers/base/class.c	2005-06-24 01:06:02.000000000 -0700
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/kdev_t.h>
 #include <linux/err.h>
+#include <linux/ndevfs.h>
 #include "base.h"
 
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
@@ -492,6 +493,7 @@
 		attr->store = NULL;
 		class_device_create_file(class_dev, attr);
 		class_dev->devt_attr = attr;
+		ndevfs_create(class_dev->class_id, class_dev->devt, 1);
 	}
 
 	class_device_add_attrs(class_dev);
@@ -595,6 +597,7 @@
 		class_device_remove_file(class_dev, class_dev->devt_attr);
 		kfree(class_dev->devt_attr);
 		class_dev->devt_attr = NULL;
+		ndevfs_remove(class_dev->class_id);
 	}
 	class_device_remove_attrs(class_dev);
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/fs/ndevfs/Makefile	2005-06-24 01:06:02.000000000 -0700
@@ -0,0 +1,4 @@
+ndevfs-objs	:= inode.o
+
+obj-$(CONFIG_NDEV_FS)	+= ndevfs.o
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/fs/ndevfs/inode.c	2005-06-24 01:06:02.000000000 -0700
@@ -0,0 +1,249 @@
+/*
+ *  inode.c - part of ndevfs, a tiny little device file system
+ *
+ *  Copyright (C) 2004,2005 Greg Kroah-Hartman <greg@kroah.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ *
+ * Written for all of the people out there who just hate userspace solutions.
+ *
+ */
+
+/* uncomment to get debug messages */
+#define DEBUG
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/device.h>
+#include <linux/ndevfs.h>
+
+#define MAGIC	0x64756d62
+
+struct entry {
+	struct list_head node;
+	struct dentry *dentry;
+	char name[BUS_ID_SIZE];
+};
+static LIST_HEAD(entries);
+
+static struct vfsmount *mount;
+static int mount_count;
+
+static struct file_operations stupid_file_ops = {
+	.read	= generic_file_read,
+	.write	= generic_file_write,
+	.mmap	= generic_file_mmap,
+	.fsync	= simple_sync_file,
+	.llseek	= generic_file_llseek,
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
+			inode->i_fop = &stupid_file_ops;
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
+static inline int positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+static int fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct tree_descr files[] = {{""}};
+
+	return simple_fill_super(sb, MAGIC, files);
+}
+
+static struct super_block *get_sb(struct file_system_type *fs_type,
+				  int flags, const char *dev_name,
+				  void *data)
+{
+	return get_sb_single(fs_type, flags, data, fill_super);
+}
+
+static void remove(struct dentry *dentry)
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
+
+/**
+ * ndevfs_create - create a device node in ndevfs
+ *
+ * @name: the name to create
+ * @dev: the dev_t of the node
+ * @is_char: if the node is a char device or not
+ */
+void ndevfs_create(const char *name, dev_t dev, int is_char)
+{
+	struct dentry *parent;
+	struct dentry *dentry;
+	struct entry *entry;
+	int err;
+	int mode = S_IRUSR | S_IWUSR;
+
+	pr_debug("ndevfs: creating file '%s' with major %d and minor %d\n",
+		 name, MAJOR(dev), MINOR(dev));
+
+	if (is_char)
+		mode |= S_IFCHR;
+	else
+		mode |= S_IFBLK;
+
+	err = simple_pin_fs("ndevfs", &mount, &mount_count);
+	if (err)
+		return;
+
+	/* everything is at the root fs, no directories allowed */
+	if (mount && mount->mnt_sb) {
+		parent = mount->mnt_sb->s_root;
+	} else {
+		pr_debug("%s: no parent?\n", __FUNCTION__);
+		goto error;
+	}
+
+	down(&parent->d_inode->i_sem);
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (!IS_ERR(dentry))
+		err = mknod(parent->d_inode, dentry, mode, dev);
+	else
+		err = PTR_ERR(dentry);
+	up(&parent->d_inode->i_sem);
+
+	if (err)
+		goto error;
+
+	entry = kmalloc(sizeof(struct entry), GFP_KERNEL);
+	if (!entry) {
+		remove(dentry);
+		err = -ENOMEM;
+		goto error;
+	}
+	entry->dentry = dentry;
+	strcpy(&entry->name[0], name);
+	list_add(&entry->node, &entries);
+	return;
+
+error:
+	pr_debug("%s failed with error %d\n", __FUNCTION__, err);
+	simple_release_fs(&mount, &mount_count);
+}
+EXPORT_SYMBOL_GPL(ndevfs_create);
+
+/**
+ * ndevfs_remove - removes the node from the fs
+ *
+ * @name: the name to remove.
+ */
+void ndevfs_remove(const char *name)
+{
+	struct entry *entry;
+	struct dentry *dentry = NULL;
+
+	pr_debug("ndevfs: removing file '%s'\n", name);
+
+	list_for_each_entry(entry, &entries, node) {
+		if (strcmp(name, &entry->name[0]) == 0) {
+			dentry = entry->dentry;
+			break;
+		}
+	}
+	if (!dentry) {
+		pr_debug("%s: can't find %s\n", __FUNCTION__, name);
+		return;
+	}
+	remove (dentry);
+}
+EXPORT_SYMBOL_GPL(ndevfs_remove);
+
+static struct file_system_type fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"ndevfs",
+	.get_sb =	get_sb,
+	.kill_sb =	kill_litter_super,
+};
+
+static int __init ndevfs_init(void)
+{
+	return register_filesystem(&fs_type);
+}
+
+static void __exit ndevfs_exit(void)
+{
+	simple_release_fs(&mount, &mount_count);
+	unregister_filesystem(&fs_type);
+}
+
+core_initcall(ndevfs_init);
+module_exit(ndevfs_exit);
+MODULE_LICENSE("GPL");
+
--- gregkh-2.6.orig/fs/partitions/check.c	2005-06-24 01:05:59.000000000 -0700
+++ gregkh-2.6/fs/partitions/check.c	2005-06-24 01:06:02.000000000 -0700
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/kmod.h>
 #include <linux/ctype.h>
+#include <linux/ndevfs.h>
 
 #include "check.h"
 
@@ -273,6 +274,7 @@
 	p->start_sect = 0;
 	p->nr_sects = 0;
 	p->reads = p->writes = p->read_sectors = p->write_sectors = 0;
+	ndevfs_remove(kobject_name(&p->kobj));
 	kobject_unregister(&p->kobj);
 }
 
@@ -296,6 +298,7 @@
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
 	kobject_register(&p->kobj);
+	ndevfs_create(kobject_name(&p->kobj), MKDEV(disk->major, p->partno), 0);
 	disk->part[part-1] = p;
 }
 
@@ -323,6 +326,8 @@
 	if ((err = kobject_add(&disk->kobj)))
 		return;
 	disk_sysfs_symlinks(disk);
+	ndevfs_create(kobject_name(&disk->kobj),
+		      MKDEV(disk->major, disk->first_minor), 0);
 	kobject_hotplug(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
@@ -420,6 +425,7 @@
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}
+	ndevfs_remove(kobject_name(&disk->kobj));
 	kobject_hotplug(&disk->kobj, KOBJ_REMOVE);
 	kobject_del(&disk->kobj);
 }
