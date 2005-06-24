Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263330AbVFXRTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbVFXRTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbVFXRQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:16:52 -0400
Received: from saturn.billgatliff.com ([209.251.101.200]:45516 "EHLO
	saturn.billgatliff.com") by vger.kernel.org with ESMTP
	id S263330AbVFXRLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 13:11:07 -0400
Message-ID: <42BC3E9D.6030306@billgatliff.com>
Date: Fri, 24 Jun 2005 12:10:53 -0500
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_saturn-9241-1119633202-0001-2"
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
References: <20050624081808.GA26174@kroah.com>
In-Reply-To: <20050624081808.GA26174@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_saturn-9241-1119633202-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>Now I just know I'm going to regret this somehow...
>
>Anyway, here's yet-another-ramfs-based filesystem, ndevfs.
>

Here's your code against vanilla 2.6.12.

I ran it on an ARM machine, was able to successfully mount it and do an 
'ls'.  Not an exhaustive test, obviously.

Only errors I saw in the output were:

...
Freeing init memory: 100K
ndevfs: creating file 'vcs1' with major 7 and minor 1
ndevfs: creating file 'vcsa1' with major 7 and minor 129
ndevfs: creating file 'vcs1' with major 7 and minor 1
ndevfs_create failed with error -17
ndevfs: creating file 'vcsa1' with major 7 and minor 129
ndevfs_create failed with error -17
...

I don't know what vcs1 and vcsa1 are, not sure I really care...  :^)

I moved your Kconfig diff; it was showing up in miscellaneous 
filesystems, I put it in pseudo filesystems instead.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
Professional embedded Linux training.


--=_saturn-9241-1119633202-0001-2
Content-Type: text/plain; name=ndevfs-patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ndevfs-patch"

--- orig/drivers/base/class.c
+++ mod/drivers/base/class.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/ndevfs.h>
 #include "base.h"
 
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
@@ -422,8 +423,10 @@
 		up(&parent->sem);
 	}
 
-	if (MAJOR(class_dev->devt))
+	if (MAJOR(class_dev->devt)) {
 		class_device_create_file(class_dev, &class_device_attr_dev);
+                ndevfs_create(class_dev->class_id, class_dev->devt, 1);
+        }
 
 	class_device_add_attrs(class_dev);
 	if (class_dev->dev)
@@ -458,8 +461,10 @@
 		up(&parent->sem);
 	}
 
-	if (class_dev->dev)
+	if (class_dev->dev) {
 		sysfs_remove_link(&class_dev->kobj, "device");
+                ndevfs_remove(class_dev->class_id);
+        }
 	class_device_remove_attrs(class_dev);
 
 	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);


--- orig/fs/Kconfig
+++ mod/fs/Kconfig
@@ -813,6 +813,12 @@
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
 
+config NDEV_FS
+	bool "Nano Device File System"
+        help
+          A proposed replacement for devfs.  If you aren't sure,
+          say N.
+
 config TMPFS
 	bool "Virtual memory file system support (former shm fs)"
 	help


--- orig/fs/Makefile
+++ mod/fs/Makefile
@@ -95,3 +95,4 @@
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
+obj-$(CONFIG_NDEV_FS)		+= ndevfs/


--- orig/fs/partitions/check.c
+++ mod/fs/partitions/check.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/kmod.h>
 #include <linux/ctype.h>
+#include <linux/ndevfs.h>
 #include <linux/devfs_fs_kernel.h>
 
 #include "check.h"
@@ -283,6 +284,7 @@
 	p->nr_sects = 0;
 	p->reads = p->writes = p->read_sectors = p->write_sectors = 0;
 	devfs_remove("%s/part%d", disk->devfs_name, part);
+        ndevfs_remove(kobject_name(&p->kobj));
 	kobject_unregister(&p->kobj);
 }
 
@@ -310,6 +312,7 @@
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
 	kobject_register(&p->kobj);
+	ndevfs_create(kobject_name(&p->kobj), MKDEV(disk->major, p->partno), 0);
 	disk->part[part-1] = p;
 }
 
@@ -337,6 +340,8 @@
 	if ((err = kobject_add(&disk->kobj)))
 		return;
 	disk_sysfs_symlinks(disk);
+	ndevfs_create(kobject_name(&disk->kobj),
+		      MKDEV(disk->major, disk->first_minor), 0);
 	kobject_hotplug(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
@@ -442,6 +447,7 @@
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}
+	ndevfs_remove(kobject_name(&disk->kobj));
 	kobject_hotplug(&disk->kobj, KOBJ_REMOVE);
 	kobject_del(&disk->kobj);
 }
--- /dev/null
+++ mod/fs/ndevfs/Makefile
@@ -0,0 +1,4 @@
+ndevfs-objs	:= inode.o
+
+obj-$(CONFIG_NDEV_FS)	+= ndevfs.o
+
--- /dev/null
+++ mod/fs/ndevfs/inode.c
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
--- /dev/null
+++ mod/include/linux/ndevfs.h
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



--=_saturn-9241-1119633202-0001-2--
