Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTABAoF>; Wed, 1 Jan 2003 19:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbTABAoF>; Wed, 1 Jan 2003 19:44:05 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:12676 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265246AbTABAnS>; Wed, 1 Jan 2003 19:43:18 -0500
Date: Wed, 1 Jan 2003 16:51:21 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au, hch@infradead.org
Subject: Re: RFC/Patch - Implode devfs
Message-ID: <20030101165121.A3091@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Just to keep everyone up to date, here is a third iteration of
my patch converting devfs to a ramfs-based file system.  This one uses
an almost unmodified version of devfs/util.c to restore automatic
device number allocation and devfs_{,un}register_tape().

	This code now tries to implement almost all of the devfs
functionality that anything outside of arch/ia64/sn uses.  The most
significant except that I'm aware of is the ability to create a plain
file with custom file operations, which is done the Memory Type Range
Register code, but that code also provides a proc interface for the
same thing, and I think the proc interface is what everyone uses right
now anyhow.

	If Christoph's patch for deleting a bunch of unused stuff from
devfs gets into 2.5.54, that should make my patch smaller, and I'll
post a new version then.  If nobody objects, then perhaps I'll make
that version replace fs/devfs rather than creating a separate
fs/mini-devfs.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="minidevfs.diff"

--- linux-2.5.53/include/linux/devfs_fs_kernel.h	2002-12-23 21:21:01.000000000 -0800
+++ linux/include/linux/devfs_fs_kernel.h	2003-01-01 14:58:01.000000000 -0800
@@ -24,7 +24,11 @@
 #define DEVFS_SPECIAL_CHR     0
 #define DEVFS_SPECIAL_BLK     1
 
+#ifdef CONFIG_DEVFS_SMALL
+typedef struct dentry * devfs_handle_t;
+#else
 typedef struct devfs_entry * devfs_handle_t;
+#endif
 
 #ifdef CONFIG_DEVFS_FS
 
@@ -53,10 +57,19 @@
 			     devfs_handle_t *handle, void *info);
 extern devfs_handle_t devfs_mk_dir (devfs_handle_t dir, const char *name,
 				    void *info);
+
+extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
+extern int devfs_only (void);
+
+#ifdef CONFIG_DEVFS_SMALL
+extern int devfs_alloc_major (umode_t mode);
+extern void devfs_dealloc_major (umode_t mode, int major);
+extern dev_t devfs_alloc_devnum (umode_t mode);
+extern void devfs_dealloc_devnum (umode_t mode, dev_t devnum);
+#else
 extern devfs_handle_t devfs_get_handle (devfs_handle_t dir, const char *name,
 					int traverse_symlinks);
 extern devfs_handle_t devfs_get_handle_from_inode (struct inode *inode);
-extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
 extern int devfs_set_file_size (devfs_handle_t de, unsigned long size);
 extern void *devfs_get_info (devfs_handle_t de);
 extern int devfs_set_info (devfs_handle_t de, void *info);
@@ -64,17 +77,17 @@
 extern devfs_handle_t devfs_get_first_child (devfs_handle_t de);
 extern devfs_handle_t devfs_get_next_sibling (devfs_handle_t de);
 extern const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen);
-extern int devfs_only (void);
 extern int devfs_register_tape (devfs_handle_t de);
 extern void devfs_unregister_tape(int num);
 extern int devfs_alloc_major (char type);
 extern void devfs_dealloc_major (char type, int major);
 extern dev_t devfs_alloc_devnum (char type);
 extern void devfs_dealloc_devnum (char type, dev_t devnum);
+#endif /* !CONFIG_DEVFS_SMALL */
+
 extern int devfs_alloc_unique_number (struct unique_numspace *space);
 extern void devfs_dealloc_unique_number (struct unique_numspace *space,
 					 int number);
-
 extern void mount_devfs_fs (void);
 
 #else  /*  CONFIG_DEVFS_FS  */
--- linux-2.5.53/fs/namei.c	2002-12-23 21:19:59.000000000 -0800
+++ linux/fs/namei.c	2002-12-31 19:07:06.000000000 -0800
@@ -1377,9 +1377,9 @@
 }
 
 /* SMP-safe */
-static struct dentry *lookup_create(struct nameidata *nd, int is_dir)
+struct dentry *lookup_create(struct nameidata *nd, int is_dir)
 {
 	struct dentry *dentry;
 
--- linux-2.5.53/fs/Kconfig	2002-12-23 21:20:32.000000000 -0800
+++ linux/fs/Kconfig	2002-12-31 18:45:59.000000000 -0800
@@ -847,7 +847,21 @@
 
 	  If unsure, say N.
 
+config DEVFS_SMALL
+	bool "Smaller /dev file system (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && DEVFS_FS
+	---help---
+	  New smaller devfs without automatic partition rereading
+	  (which impeded user level partition handling) and currently
+	  without some features used by arch/ia64/sn.
+
+	  If unsure, say N.
+
+config DEVFS_BIG
+	bool
+	depends on DEVFS_FS && !DEVFS_SMALL
+
 config DEVFS_MOUNT
 	bool "Automatically mount at boot"
 	depends on DEVFS_FS
--- linux-2.5.53/fs/mini-devfs/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/mini-devfs/Makefile	2003-01-01 14:16:05.000000000 -0800
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux ramfs routines.
+#
+
+export-objs := inode.o util.o
+
+obj-$(CONFIG_DEVFS_FS) += devfs.o
+
+devfs-objs := inode.o util.o
--- linux-2.5.53/fs/mini-devfs/inode.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/mini-devfs/inode.c	2003-01-01 16:24:52.000000000 -0800
@@ -0,0 +1,580 @@
+/*
+ * Stripped down Device File System (devfs2)
+ *	Adapted from ramfs by Adam J. Richter.  Ramfs was written by
+ *      Linus Torvalds.
+ *
+ * Copyright (C) 2000 Linus Torvalds.
+ *               2000 Transmeta Corp.
+ *		 2002 Yggdrasil Computing, Inc.
+ *
+ * Usage limits added to ramfs by David Gibson, Linuxcare Australia.
+ * This file is released under the GPL.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+
+#include <asm/uaccess.h>
+#include <asm/string.h>
+
+/* For now, must be the same as devfs magic to appease glibc.  See
+   __posix_openpt in glibc-2.3/sysdeps/unix/sysv/linux/getpt.c
+   TODO(?): Adopt a new magic number and adjust glibc? */
+#define DEVFS2_MAGIC	DEVFS_SUPER_MAGIC
+
+
+/* TODO: Move this to some .h file or, more likely, use a slightly
+   different interface from lookup_create. */
+extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
+
+static struct super_operations devfs2_ops;
+static struct address_space_operations devfs2_aops;
+static struct file_operations devfs2_file_operations;
+static struct inode_operations devfs2_dir_inode_operations;
+struct vfsmount *devfs2_vfsmount;
+
+static char devfs_helper[150] = "/sbin/devfs_helper";
+module_param_string(devfs_helper, devfs_helper, sizeof(devfs_helper), 0644);
+
+static struct backing_dev_info devfs2_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
+static void devfs_event(const char *event, struct dentry *dentry)
+{
+	char path[64];
+
+	if (devfs_generate_path(dentry, path, sizeof(path)) == 0) {
+		const char *argv[] = { devfs_helper, event, path, NULL };
+		static char *envp[] = {"PATH=/bin:/sbin:/usr/bin:/usr/sbin",
+				       "HOME=/", NULL };
+
+		/* FIXME: Change the call_usermodehelper prototype so
+		   that argv and envp are type const so we won't have
+		   to cast the type of argv. */
+		call_usermodehelper(devfs_helper, (char**) argv, envp);
+	} else
+		BUG();
+}
+
+static struct inode *devfs2_get_inode(struct super_block *sb, int mode, dev_t dev)
+{
+	struct inode * inode = new_inode(sb);
+
+	if (!inode)
+		return NULL;
+
+	inode->i_mode = mode;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_rdev = NODEV;
+	inode->i_mapping->a_ops = &devfs2_aops;
+	inode->i_mapping->backing_dev_info = &devfs2_backing_dev_info;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	
+	switch (mode & S_IFMT) {
+	default:
+		init_special_inode(inode, mode, dev);
+		break;
+	case S_IFREG:
+		inode->i_fop = &devfs2_file_operations;
+		break;
+	case S_IFDIR:
+		inode->i_op = &devfs2_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+
+		/* directory inodes start off with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+		break;
+	case S_IFLNK:
+		inode->i_op = &page_symlink_inode_operations;
+		break;
+	}
+
+	return inode;
+}
+
+static struct dentry * devfs2_lookup(struct inode *inode, struct dentry *dentry)
+{
+	devfs_event("LOOKUP", dentry);
+	return simple_lookup(inode, dentry);
+}
+
+
+/*
+ * File creation. Allocate an inode, and we're done..
+ */
+/* SMP-safe */
+static int
+devfs2_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	struct inode * inode = devfs2_get_inode(dir->i_sb, mode, dev);
+	int error = -ENOSPC;
+
+	if (inode) {
+		d_instantiate(dentry, inode);
+		dget(dentry);	/* Extra count - pin the dentry in core */
+		error = 0;
+		devfs_event("REGISTER", dentry);
+	}
+
+	return error;
+}
+
+static int devfs2_mkdir(struct inode * dir, struct dentry * dentry, int mode)
+{
+	int retval = devfs2_mknod(dir, dentry, mode | S_IFDIR, 0);
+	if (!retval)
+		dir->i_nlink++;
+	return retval;
+}
+
+static int devfs2_create(struct inode *dir, struct dentry *dentry, int mode)
+{
+	return devfs2_mknod(dir, dentry, mode | S_IFREG, 0);
+}
+
+
+static int devfs2_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+{
+	struct inode *inode;
+	int error = -ENOSPC;
+
+	inode = devfs2_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
+	if (inode) {
+		int l = strlen(symname)+1;
+		error = page_symlink(inode, symname, l);
+		if (!error) {
+			d_instantiate(dentry, inode);
+			dget(dentry);
+		} else
+			iput(inode);
+	}
+	return error;
+}
+
+static struct address_space_operations devfs2_aops = {
+	.readpage	= simple_readpage,
+	.prepare_write	= simple_prepare_write,
+	.commit_write	= simple_commit_write
+};
+
+static struct file_operations devfs2_file_operations = {
+	.read		= generic_file_read,
+	.write		= generic_file_write,
+	.mmap		= generic_file_mmap,
+	.fsync		= simple_sync_file,
+	.sendfile	= generic_file_sendfile,
+};
+
+static struct inode_operations devfs2_dir_inode_operations = {
+	.create		= devfs2_create,
+	.lookup		= devfs2_lookup,
+	.link		= simple_link,
+	.unlink		= simple_unlink,
+	.symlink	= devfs2_symlink,
+	.mkdir		= devfs2_mkdir,
+	.rmdir		= simple_rmdir,
+	.mknod		= devfs2_mknod,
+	.rename		= simple_rename,
+};
+
+static struct super_operations devfs2_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+};
+
+static int devfs2_fill_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = DEVFS2_MAGIC;
+	sb->s_op = &devfs2_ops;
+	inode = devfs2_get_inode(sb, S_IFDIR | 0755, 0);
+	if (!inode)
+		return -ENOMEM;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	sb->s_root = root;
+	return 0;
+}
+
+static struct super_block *devfs2_get_sb(struct file_system_type *fs_type,
+					 int flags, char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, devfs2_fill_super);
+}
+
+static struct file_system_type devfs2_fs_type = {
+	.name		= "devfs",
+	.get_sb		= devfs2_get_sb,
+	.kill_sb	= kill_litter_super,
+};
+
+static int __init init_devfs2_fs(void)
+{
+	int err;
+
+	if (devfs2_vfsmount != NULL)
+		return 0;
+
+	err = register_filesystem(&devfs2_fs_type);
+	if (err)
+		return err;
+
+	devfs2_vfsmount = kern_mount(&devfs2_fs_type);
+
+	if (IS_ERR(devfs2_vfsmount)) {
+		unregister_filesystem(&devfs2_fs_type);
+		return PTR_ERR(devfs2_vfsmount);
+	}
+	else
+		return 0;
+}
+
+static void __exit exit_devfs2_fs(void)
+{
+	unregister_filesystem(&devfs2_fs_type);
+}
+
+module_init(init_devfs2_fs)
+module_exit(exit_devfs2_fs)
+
+MODULE_LICENSE("GPL");
+
+/* Called and returns with dcache_lock held.  */
+static int walk_parents_mkdir(const char **path, struct nameidata *nd,
+			      int is_dir)
+{
+	char *slash;
+	char buf[strlen(*path)+1];
+	int err;
+
+	while ((slash = strchr(*path, '/')) != NULL) {
+		int len = slash - *path;
+		memcpy(buf, *path, len);
+		buf[len] = '\0';
+
+		spin_lock(&dcache_lock);
+		err = link_path_walk(buf, nd); /* releases dcache_lock */
+
+		BUG_ON(err);	/* AJR */
+		if (err)
+			return err;
+
+		nd->dentry = lookup_create(nd, is_dir);
+
+		if (IS_ERR(nd->dentry)) {
+			BUG();
+			return PTR_ERR(nd->dentry);
+		}
+
+		if (!nd->dentry->d_inode)
+			err = vfs_mkdir(nd->dentry->d_parent->d_inode,
+					nd->dentry, 0644);
+		
+		up(&nd->dentry->d_parent->d_inode->i_sem);
+
+		if (err) {
+			BUG_ON(err); /* AJR */
+			if (err)
+				return err;
+		}
+
+		*path += len + 1;
+	}
+	return 0;
+}
+
+/* On success, returns with (*parent_inode)->i_sem taken. */
+static int devfs_decode(devfs_handle_t dir, const char *name, int is_dir,
+			struct inode **parent_inode, struct dentry **dentry)
+{
+	struct nameidata nd;
+	int err;
+
+	if (dir == NULL) {
+		if (devfs2_vfsmount == NULL && init_devfs2_fs() != 0)
+			BUG();
+
+		dir = devfs2_vfsmount->mnt_sb->s_root;
+	}
+
+	memset(&nd, 0, sizeof(nd));
+	nd.flags = LOOKUP_PARENT;
+	/* nd.mnt = current->fs->rootmnt; FIXME? */
+	nd.mnt = devfs2_vfsmount;
+	nd.dentry = dir;
+
+	err = walk_parents_mkdir(&name, &nd, is_dir);
+	if (err)
+		return err;
+
+	spin_lock(&dcache_lock);
+	err = link_path_walk(name, &nd);
+	if (err) {
+		printk ("AJR devfs_decode: link_path_walk(name %s, &nd) got error %d.\n", name, err);
+		BUG();
+		return err;
+	}
+
+	*dentry = lookup_create(&nd, is_dir);
+
+	BUG_ON(IS_ERR(*dentry)); /* AJR */
+	if (IS_ERR(*dentry))
+		return PTR_ERR(*dentry);
+	else {
+		*parent_inode = (*dentry)->d_parent->d_inode;
+		return 0;
+	}
+}
+
+
+devfs_handle_t devfs_register (devfs_handle_t dir,
+			       const char *name,
+			       unsigned int flags,
+			       unsigned int major,
+			       unsigned int minor,
+			       umode_t mode,
+			       void *ops, void *info)
+{
+	struct inode *parent_inode;
+	struct dentry *dentry;
+	int err;
+	dev_t devnum;
+
+	if (flags & DEVFS_FL_AUTO_DEVNUM) {
+		BUG_ON(!S_ISCHR(mode) && !S_ISBLK(mode));
+		devnum = devfs_alloc_devnum(mode);
+		if (!devnum) {
+			printk ("(%s): exhausted %s device numbers\n",
+				name, S_ISCHR (mode) ? "char" : "block");
+			return NULL;
+		}
+	} else
+		devnum = MKDEV(major, minor);
+
+	err = devfs_decode(dir, name, 0, &parent_inode, &dentry);
+	if (err)
+		goto err_free_devnum;
+
+	err = vfs_mknod(parent_inode, dentry, mode, devnum);
+	up(&parent_inode->i_sem);
+	if (!err) {
+		/* FIXME? Is DEVFS_FL_CURRENT_OWNER useful?  Don't we
+		   already set uid and gid to current->fs{uid,gid}?  */
+		if (flags & DEVFS_FL_CURRENT_OWNER) {
+			dentry->d_inode->i_uid = current->uid;
+			dentry->d_inode->i_gid = current->gid;
+		}
+		return dentry;
+	}
+
+	BUG_ON(err != -EEXIST);	/* AJR */
+
+	dput(dentry);
+
+ err_free_devnum:
+	if (flags & DEVFS_FL_AUTO_DEVNUM)
+		devfs_dealloc_devnum(mode, devnum);
+ 
+	return NULL;
+
+}
+EXPORT_SYMBOL(devfs_register);
+
+void devfs_unregister (devfs_handle_t de)
+{
+	mode_t mode = de->d_inode->i_mode;
+	if (S_ISDIR(mode))
+		vfs_rmdir(de->d_parent->d_inode, de);
+	else {
+		if (S_ISCHR(mode) || S_ISBLK(mode))
+			devfs_dealloc_devnum(mode, mode);
+
+		vfs_unlink(de->d_parent->d_inode, de);
+	}
+}
+EXPORT_SYMBOL(devfs_unregister);
+
+void devfs_put (devfs_handle_t de)
+{
+	dput(de);
+}
+EXPORT_SYMBOL(devfs_put);
+
+int devfs_mk_symlink (devfs_handle_t dir, const char *name,
+		      unsigned int flags, const char *link,
+		      devfs_handle_t *handle, void *info)
+{
+	struct inode *parent_inode;
+	struct dentry *dentry;
+	int err = devfs_decode(dir, name, 0, &parent_inode, &dentry);
+
+	if (!err) {
+		err = vfs_symlink(parent_inode, dentry, link);
+		up(&parent_inode->i_sem);
+	}
+
+	dput(dentry);
+	return err;
+}
+EXPORT_SYMBOL(devfs_mk_symlink);
+
+devfs_handle_t devfs_mk_dir (devfs_handle_t dir, const char *name, void *info)
+{
+	struct inode *parent_inode;
+	struct dentry *dentry;
+	int err = devfs_decode(dir, name, 1, &parent_inode, &dentry);
+
+	if (!err) {
+		err = vfs_mkdir(parent_inode, dentry, 0644);
+		up(&parent_inode->i_sem);
+		if (err) {
+			BUG_ON (err != -EEXIST); /* AJR */
+			dput(dentry);
+		}
+	}
+	else
+		BUG();	/* AJR */
+	return err ? NULL : dentry;
+}
+EXPORT_SYMBOL(devfs_mk_dir);
+
+/* From fs/devfs/base.c: */
+void devfs_remove(const char *fmt, ...)
+{
+	char buf[64];
+	va_list args;
+	int len;
+	struct nameidata nd;
+	int err;
+
+	va_start(args, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, args);
+	if (len >= sizeof(buf)) {
+		BUG();
+		return;
+	}
+
+	buf[sizeof(buf)-1] = '\0';
+
+	memset(&nd, 0, sizeof(nd));
+	nd.mnt = devfs2_vfsmount;
+	nd.dentry = devfs2_vfsmount->mnt_sb->s_root;
+
+	spin_lock(&dcache_lock);
+	err = link_path_walk(buf, &nd);
+	if (!err) {
+		devfs_unregister(nd.dentry);
+		devfs_put(nd.dentry);
+	}
+	else
+		printk ("AJR devfs_remove: link_path_walk(buf %s, len %d) "
+			"returned err %d.\n", buf, len, err);
+}
+
+EXPORT_SYMBOL(devfs_remove);
+
+int devfs_only(void)
+{
+	return 0;
+}
+
+void __init mount_devfs_fs (void)
+{
+#ifdef CONFIG_DEVFS_MOUNT
+    int err;
+
+    err = do_mount ("none", "/dev", "devfs", 0, "");
+    if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
+    else printk ("(): unable to mount devfs2, err: %d\n", err);
+#endif
+}   /*  End Function mount_devfs_fs  */
+
+
+static int path_len (struct dentry *de, struct dentry *root)
+{
+	int len = 0;
+	while (de != root) {
+		len += de->d_name.len + 1;	/* count the '/' */
+		de = de->d_parent;
+	}
+	return len;		/* -1 because we omit the leading '/',
+				   +1 because we include trailing '\0' */
+}
+
+int devfs_generate_path (devfs_handle_t de, char *path, int buflen)
+{
+	struct dentry *devfs_root;
+	int len;
+	char *path_orig = path;
+
+	if (de == NULL) {
+		BUG();
+		return -EINVAL;
+	}
+
+	devfs_root = devfs2_vfsmount->mnt_sb->s_root;
+
+	if (de == devfs_root) {
+		BUG();
+		return -EINVAL;
+	}
+
+	spin_lock(&dcache_lock);
+	len = path_len(de, devfs_root);
+	if (len > buflen) {
+		spin_unlock(&dcache_lock);
+		BUG();
+		return -ENAMETOOLONG;
+	}
+
+	path += len - 1;
+	*path = '\0';
+
+	for (;;) {
+		path -= de->d_name.len;
+		memcpy(path, de->d_name.name, de->d_name.len);
+		de = de->d_parent;
+		if (de == devfs_root)
+			break;
+		*(--path) = '/';
+	}
+		
+	spin_unlock(&dcache_lock);
+
+	BUG_ON(path != path_orig);
+
+	return 0;
+}
+
+
+int devfs_set_file_size (devfs_handle_t de, unsigned long size)
+{
+	/* FIXME?  Locing?  Is this right? */
+	if (de != NULL && de->d_inode != NULL)
+		de->d_inode->i_size = size;
+	return -1;
+}
+EXPORT_SYMBOL(devfs_set_file_size);
--- linux-2.5.53/fs/mini-devfs/util.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/mini-devfs/util.c	2003-01-01 15:03:57.000000000 -0800
@@ -0,0 +1,396 @@
+/*  devfs (Device FileSystem) utilities.
+
+    Copyright (C) 1999-2002  Richard Gooch
+
+    This library is free software; you can redistribute it and/or
+    modify it under the terms of the GNU Library General Public
+    License as published by the Free Software Foundation; either
+    version 2 of the License, or (at your option) any later version.
+
+    This library is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+    Library General Public License for more details.
+
+    You should have received a copy of the GNU Library General Public
+    License along with this library; if not, write to the Free
+    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
+    The postal address is:
+      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
+
+    ChangeLog
+
+    19991031   Richard Gooch <rgooch@atnf.csiro.au>
+               Created.
+    19991103   Richard Gooch <rgooch@atnf.csiro.au>
+               Created <_devfs_convert_name> and supported SCSI and IDE CD-ROMs
+    20000203   Richard Gooch <rgooch@atnf.csiro.au>
+               Changed operations pointer type to void *.
+    20000621   Richard Gooch <rgooch@atnf.csiro.au>
+               Changed interface to <devfs_register_series>.
+    20000622   Richard Gooch <rgooch@atnf.csiro.au>
+               Took account of interface change to <devfs_mk_symlink>.
+               Took account of interface change to <devfs_mk_dir>.
+    20010519   Richard Gooch <rgooch@atnf.csiro.au>
+               Documentation cleanup.
+    20010709   Richard Gooch <rgooch@atnf.csiro.au>
+               Created <devfs_*alloc_major> and <devfs_*alloc_devnum>.
+    20010710   Richard Gooch <rgooch@atnf.csiro.au>
+               Created <devfs_*alloc_unique_number>.
+    20010730   Richard Gooch <rgooch@atnf.csiro.au>
+               Documentation typo fix.
+    20010806   Richard Gooch <rgooch@atnf.csiro.au>
+               Made <block_semaphore> and <char_semaphore> private.
+    20010813   Richard Gooch <rgooch@atnf.csiro.au>
+               Fixed bug in <devfs_alloc_unique_number>: limited to 128 numbers
+    20010818   Richard Gooch <rgooch@atnf.csiro.au>
+               Updated major masks up to Linus' "no new majors" proclamation.
+	       Block: were 126 now 122 free, char: were 26 now 19 free.
+    20020324   Richard Gooch <rgooch@atnf.csiro.au>
+               Fixed bug in <devfs_alloc_unique_number>: was clearing beyond
+	       bitfield.
+    20020326   Richard Gooch <rgooch@atnf.csiro.au>
+               Fixed bitfield data type for <devfs_*alloc_devnum>.
+               Made major bitfield type and initialiser 64 bit safe.
+    20020413   Richard Gooch <rgooch@atnf.csiro.au>
+               Fixed shift warning on 64 bit machines.
+    20020428   Richard Gooch <rgooch@atnf.csiro.au>
+               Copied and used macro for error messages from fs/devfs/base.c 
+    20021013   Richard Gooch <rgooch@atnf.csiro.au>
+               Documentation fix.
+*/
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include <asm/bitops.h>
+
+#define PRINTK(format, args...) \
+   {printk (KERN_ERR "%s" format, __FUNCTION__ , ## args);}
+
+
+/*  Private functions follow  */
+
+/**
+ *	devfs_register_tape - Register a tape device in the "/dev/tapes" hierarchy.
+ *	@de: Any tape device entry in the device directory.
+ */
+
+int devfs_register_tape (devfs_handle_t de)
+{
+    int pos;
+    devfs_handle_t slave;
+    char name[32], dest[64];
+    static unsigned int tape_counter;
+    int n = tape_counter++;
+
+    pos = devfs_generate_path (de, dest + 3, sizeof dest - 3);
+    if (pos < 0) return -1;
+    strncpy (dest + pos, "../", 3);
+    sprintf (name, "tapes/tape%u", n);
+    devfs_mk_symlink (NULL, name, DEVFS_FL_DEFAULT, dest + pos, &slave, NULL);
+    return n;
+}   /*  End Function devfs_register_tape  */
+EXPORT_SYMBOL(devfs_register_tape);
+
+void devfs_unregister_tape(int num)
+{
+	if (num >= 0)
+		devfs_remove("tapes/tape%u", num);
+}
+
+EXPORT_SYMBOL(devfs_unregister_tape);
+
+struct major_list
+{
+    spinlock_t lock;
+    unsigned long bits[256 / BITS_PER_LONG];
+};
+#if BITS_PER_LONG == 32
+#  define INITIALISER64(low,high) (low), (high)
+#else
+#  define INITIALISER64(low,high) ( (unsigned long) (high) << 32 | (low) )
+#endif
+
+/*  Block majors already assigned:
+    0-3, 7-9, 11-63, 65-99, 101-113, 120-127, 199, 201, 240-255
+    Total free: 122
+*/
+static struct major_list block_major_list =
+{SPIN_LOCK_UNLOCKED,
+    {INITIALISER64 (0xfffffb8f, 0xffffffff),  /*  Majors 0-31,    32-63    */
+     INITIALISER64 (0xfffffffe, 0xff03ffef),  /*  Majors 64-95,   96-127   */
+     INITIALISER64 (0x00000000, 0x00000000),  /*  Majors 128-159, 160-191  */
+     INITIALISER64 (0x00000280, 0xffff0000),  /*  Majors 192-223, 224-255  */
+    }
+};
+
+/*  Char majors already assigned:
+    0-7, 9-151, 154-158, 160-211, 216-221, 224-230, 240-255
+    Total free: 19
+*/
+static struct major_list char_major_list =
+{SPIN_LOCK_UNLOCKED,
+    {INITIALISER64 (0xfffffeff, 0xffffffff),  /*  Majors 0-31,    32-63    */
+     INITIALISER64 (0xffffffff, 0xffffffff),  /*  Majors 64-95,   96-127   */
+     INITIALISER64 (0x7cffffff, 0xffffffff),  /*  Majors 128-159, 160-191  */
+     INITIALISER64 (0x3f0fffff, 0xffff007f),  /*  Majors 192-223, 224-255  */
+    }
+};
+
+
+/**
+ *	devfs_alloc_major - Allocate a major number.
+ *	@mode: The file mode (must be block device or character device).
+ *	Returns the allocated major, else -1 if none are available.
+ *	This routine is thread safe and does not block.
+ */
+
+int devfs_alloc_major (umode_t mode)
+{
+    int major;
+    struct major_list *list;
+
+    list = S_ISCHR(mode) ? &char_major_list : &block_major_list;
+    spin_lock (&list->lock);
+    major = find_first_zero_bit (list->bits, 256);
+    if (major < 256) __set_bit (major, list->bits);
+    else major = -1;
+    spin_unlock (&list->lock);
+    return major;
+}   /*  End Function devfs_alloc_major  */
+EXPORT_SYMBOL(devfs_alloc_major);
+
+
+/**
+ *	devfs_dealloc_major - Deallocate a major number.
+ *	@mode: The file mode (must be block device or character device).
+ *	@major: The major number.
+ *	This routine is thread safe and does not block.
+ */
+
+void devfs_dealloc_major (umode_t mode, int major)
+{
+    int was_set;
+    struct major_list *list;
+
+    if (major < 0) return;
+    list = S_ISCHR(mode) ? &char_major_list : &block_major_list;
+    spin_lock (&list->lock);
+    was_set = __test_and_clear_bit (major, list->bits);
+    spin_unlock (&list->lock);
+    if (!was_set) PRINTK ("(): major %d was already free\n", major);
+}   /*  End Function devfs_dealloc_major  */
+EXPORT_SYMBOL(devfs_dealloc_major);
+
+
+struct minor_list
+{
+    int major;
+    unsigned long bits[256 / BITS_PER_LONG];
+    struct minor_list *next;
+};
+
+struct device_list
+{
+    struct minor_list *first, *last;
+    int none_free;
+};
+
+static DECLARE_MUTEX (block_semaphore);
+static struct device_list block_list;
+
+static DECLARE_MUTEX (char_semaphore);
+static struct device_list char_list;
+
+
+/**
+ *	devfs_alloc_devnum - Allocate a device number.
+ *	@mode: The file mode (must be block device or character device).
+ *
+ *	Returns the allocated device number, else NODEV if none are available.
+ *	This routine is thread safe and may block.
+ */
+
+dev_t devfs_alloc_devnum (umode_t mode)
+{
+    int minor;
+    struct semaphore *semaphore;
+    struct device_list *list;
+    struct minor_list *entry;
+
+    if (S_ISCHR(mode))
+    {
+	semaphore = &char_semaphore;
+	list = &char_list;
+    }
+    else
+    {
+	semaphore = &block_semaphore;
+	list = &block_list;
+    }
+    if (list->none_free) return 0;  /*  Fast test  */
+    down (semaphore);
+    if (list->none_free)
+    {
+	up (semaphore);
+	return 0;
+    }
+    for (entry = list->first; entry != NULL; entry = entry->next)
+    {
+	minor = find_first_zero_bit (entry->bits, 256);
+	if (minor >= 256) continue;
+	__set_bit (minor, entry->bits);
+	up (semaphore);
+	return MKDEV(entry->major, minor);
+    }
+    /*  Need to allocate a new major  */
+    if ( ( entry = kmalloc (sizeof *entry, GFP_KERNEL) ) == NULL )
+    {
+	list->none_free = 1;
+	up (semaphore);
+	return 0;
+    }
+    memset (entry, 0, sizeof *entry);
+    if ( ( entry->major = devfs_alloc_major (mode) ) < 0 )
+    {
+	list->none_free = 1;
+	up (semaphore);
+	kfree (entry);
+	return 0;
+    }
+    __set_bit (0, entry->bits);
+    if (list->first == NULL) list->first = entry;
+    else list->last->next = entry;
+    list->last = entry;
+    up (semaphore);
+    return MKDEV(entry->major, 0);
+}   /*  End Function devfs_alloc_devnum  */
+EXPORT_SYMBOL(devfs_alloc_devnum);
+
+
+/**
+ *	devfs_dealloc_devnum - Dellocate a device number.
+ *	@mode: The file mode (must be block device or character device).
+ *	@devnum: The device number.
+ *
+ *	This routine is thread safe and may block.
+ */
+
+void devfs_dealloc_devnum (umode_t mode, dev_t devnum)
+{
+    int major, minor;
+    struct semaphore *semaphore;
+    struct device_list *list;
+    struct minor_list *entry;
+
+    if (!devnum) return;
+    if (S_ISCHR(mode))
+    {
+	semaphore = &char_semaphore;
+	list = &char_list;
+    }
+    else
+    {
+	semaphore = &block_semaphore;
+	list = &block_list;
+    }
+    major = MAJOR (devnum);
+    minor = MINOR (devnum);
+    down (semaphore);
+    for (entry = list->first; entry != NULL; entry = entry->next)
+    {
+	int was_set;
+
+	if (entry->major != major) continue;
+	was_set = __test_and_clear_bit (minor, entry->bits);
+	if (was_set) list->none_free = 0;
+	up (semaphore);
+	if (!was_set)
+	    PRINTK ( "(): device %s was already free\n", kdevname (to_kdev_t(devnum)) );
+	return;
+    }
+    up (semaphore);
+    /* We get here when a major number was not previously allocated, which
+       can happen, because devfs_uregister calls devfs_dealloc_devnum
+       regardless of whether devfs_alloc_devnum allocated it. */
+}   /*  End Function devfs_dealloc_devnum  */
+EXPORT_SYMBOL(devfs_dealloc_devnum);
+
+
+/**
+ *	devfs_alloc_unique_number - Allocate a unique (positive) number.
+ *	@space: The number space to allocate from.
+ *
+ *	Returns the allocated unique number, else a negative error code.
+ *	This routine is thread safe and may block.
+ */
+
+int devfs_alloc_unique_number (struct unique_numspace *space)
+{
+    int number;
+    unsigned int length;
+
+    /*  Get around stupid lack of semaphore initialiser  */
+    spin_lock (&space->init_lock);
+    if (!space->sem_initialised)
+    {
+	sema_init (&space->semaphore, 1);
+	space->sem_initialised = 1;
+    }
+    spin_unlock (&space->init_lock);
+    down (&space->semaphore);
+    if (space->num_free < 1)
+    {
+	void *bits;
+
+	if (space->length < 16) length = 16;
+	else length = space->length << 1;
+	if ( ( bits = vmalloc (length) ) == NULL )
+	{
+	    up (&space->semaphore);
+	    return -ENOMEM;
+	}
+	if (space->bits != NULL)
+	{
+	    memcpy (bits, space->bits, space->length);
+	    vfree (space->bits);
+	}
+	space->num_free = (length - space->length) << 3;
+	space->bits = bits;
+	memset (bits + space->length, 0, length - space->length);
+	space->length = length;
+    }
+    number = find_first_zero_bit (space->bits, space->length << 3);
+    --space->num_free;
+    __set_bit (number, space->bits);
+    up (&space->semaphore);
+    return number;
+}   /*  End Function devfs_alloc_unique_number  */
+EXPORT_SYMBOL(devfs_alloc_unique_number);
+
+
+/**
+ *	devfs_dealloc_unique_number - Deallocate a unique (positive) number.
+ *	@space: The number space to deallocate from.
+ *	@number: The number to deallocate.
+ *
+ *	This routine is thread safe and may block.
+ */
+
+void devfs_dealloc_unique_number (struct unique_numspace *space, int number)
+{
+    int was_set;
+
+    if (number < 0) return;
+    down (&space->semaphore);
+    was_set = __test_and_clear_bit (number, space->bits);
+    if (was_set) ++space->num_free;
+    up (&space->semaphore);
+    if (!was_set) PRINTK ("(): number %d was already free\n", number);
+}   /*  End Function devfs_dealloc_unique_number  */
+EXPORT_SYMBOL(devfs_dealloc_unique_number);

--PNTmBPCT7hxwcZjr--
