Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTAACQZ>; Tue, 31 Dec 2002 21:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTAACQZ>; Tue, 31 Dec 2002 21:16:25 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:54487 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266175AbTAACQI>; Tue, 31 Dec 2002 21:16:08 -0500
Date: Tue, 31 Dec 2002 18:24:22 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: RFC/Patch - Implode devfs
Message-ID: <20021231182422.A4160@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch replaces devfs with a ramfs-derived
implementation which is under one quarter the size although it
eliminates certain functionality.

		wc -l *.c Makefile	size (text + data + bss)

devfs		3614 lines		25,863 bytes
mini-devfs       629 lines		 5,367 bytes
Reduction	 5.7x			4.8x


	Further minor reductions may be possible from some additional
clean-ups and perhaps a simplification to the programming interface.

	This code is probably very buggy.  I've just gotten it working
on the machine on which I'm composing this message.  It is not ready
for integration yet.  I would particularly appreciate help with the
dentry manipulation and locking, which I think I've probably botched.

	The notable differences between devfs and mini-devfs are:

	1. devfsd has been replaced with the user mode helper
/sbin/devfs_helper which is exec'ed for registration and initial
lookup events (I could catch all the events that devfs does, but I
don't think that's really necessary).  I have yet to port devfsd to
this interface.  When sysfs support is added to the new kernel
parameter system, I will make this a kernel parameter, so it can be
off initially, and only turned on by systems that use it when the boot
process is ready for it.  This will also eliminate the problem where
the boot process currently tries to do 200+ execs as each pseudo-terminal
is registered.

	2. The removable device code that cleared and reread partition
tables from removable media all the time preventing use of userland
partitioning with devfs is eliminated.  (Non-devfs systems never had
this problem.)

	3. devfs_handle_t is now a synonym for struct dentry*.

	4. A lot of the devfs routines are unimplemented.  I haven't
noticed much code that uses them, and I'm not sure that any code
really should.  I think arch/ia64/sn uses devfs_get_first_child,
devfs_get_next_sibling.  I need to understand what if any of the
other routines are really necessary and why (for example, why can't
we use struct dentry).  My computer seems to run fine without them.

TODO:

	First of all, I'd like to debug this code and I'd welcome any
help.  The only malfunction (aside from routines that aren't written)
that I've noticed is that previously xdm would give up after trying to
start the X server about five times (it is not configured).  With this
smaller devfs, xdm keeps trying to start the X server.  Also, I'm
pretty sure that my code is at least releasing and reacquiring
dcache_lock when it shouldn't, and I think there may be some similar
inode->i_sem issues.

	In the future, I'd like to shrink the devfs interface to
devfs_{create,delete}.  If we prohibit file renaming in devfs, then
drivers can be sure they've removed the devfs nodes that they've
created when they delete the paths that they've created.  A
side-effect of this would be that devfs_handle_t would be eliminated.
I still want the ability to pass a struct file_operations* to
devfs_create as it may enable the elimination of fixed device numbers.

	I think I'd like to change fs/super.c slightly to make it
easier to statically allocate the struct super_block for filesystems
that can have only one instance even if they are mounted in multiple
locations (devfs, procfs, sysfs, usbdevfs, etc.).

	I started hacking on this code by making an approximately ten
line change to ramfs just to have it call a user level program on
lookups and file creation.  I had hoped to change the devfs routines
to just generically operate on whatever was mounted on /dev.  If
the devfs API were shrunk substantially, it might be worth trying
that approach again.

	Comments?

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="minidevfs.diff"

--- linux-2.5.53/include/linux/devfs_fs_kernel.h	2002-12-23 21:21:01.000000000 -0800
+++ linux/include/linux/devfs_fs_kernel.h	2002-12-25 17:02:21.000000000 -0800
@@ -24,7 +24,11 @@
 #define DEVFS_SPECIAL_CHR     0
 #define DEVFS_SPECIAL_BLK     1
 
+#ifdef CONFIG_DEVFS_SMALL
+typedef struct dentry * devfs_handle_t;
+#else
 typedef struct devfs_entry * devfs_handle_t;
+#endif
 
 #ifdef CONFIG_DEVFS_FS
 
--- linux-2.5.53/fs/namei.c	2002-12-23 21:19:59.000000000 -0800
+++ linux/fs/namei.c	2002-12-26 19:56:29.000000000 -0800
@@ -1377,7 +1377,7 @@
 }
 
 /* SMP-safe */
-static struct dentry *lookup_create(struct nameidata *nd, int is_dir)
+struct dentry *lookup_create(struct nameidata *nd, int is_dir)
 {
 	struct dentry *dentry;
 
--- linux-2.5.53/fs/Kconfig	2002-12-23 21:20:32.000000000 -0800
+++ linux/fs/Kconfig	2002-12-31 17:26:33.000000000 -0800
@@ -318,7 +318,7 @@
 # other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
 # dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
 config JBD
-	bool
+	tristate
 	default EXT3_FS
 	---help---
 	  This is a generic journaling layer for block devices.  It is
@@ -847,6 +847,20 @@
 
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
--- linux-2.5.53/fs/devfs2/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs2/Makefile	2002-12-25 17:43:20.000000000 -0800
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux ramfs routines.
+#
+
+export-objs := inode.o numspace.o
+
+obj-$(CONFIG_RAMFS) += ramfs.o
+
+ramfs-objs := inode.o numspace.o
--- linux-2.5.53/fs/devfs2/inode.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs2/inode.c	2002-12-31 17:50:29.000000000 -0800
@@ -0,0 +1,543 @@
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
+static struct backing_dev_info devfs2_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
+static void try_hotplug(const char *event, struct dentry *dentry)
+{
+	char buf[64];
+
+	if (devfs_generate_path(dentry, buf, sizeof(buf)) == 0) {
+		char *argv[] = { "/sbin/devfs_handler", buf, NULL };
+		static char *envp[] = {"PATH=/bin:/sbin:/usr/bin:/usr/sbin",
+				       "HOME=/", NULL };
+
+		call_usermodehelper(argv[0], argv, envp);
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
+	// AJR commented out temporarily to address bug. -- try not AJR
+	try_hotplug("lookup", dentry);
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
+		try_hotplug("register", dentry);
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
+	int err = devfs_decode(dir, name, 0, &parent_inode, &dentry);
+
+	if (!err) {
+		err = vfs_mknod(parent_inode, dentry, mode,
+				MKDEV(major, minor));
+		up(&parent_inode->i_sem);
+		if (err) {
+			printk ("AJR devfs_register(dir %p, name %s, flags 0x%x,\n\tmajor %d, minor %d, mode 0%o, ops %p, info %p)\n\tfailed, err %d.\n",
+				dir, name, flags, major, minor, mode, ops, info, err);
+			BUG_ON(err != -EEXIST);	/* AJR */
+			dput(dentry);
+		}
+	}
+
+	return err ? NULL : dentry;
+
+}
+EXPORT_SYMBOL(devfs_register);
+
+void devfs_unregister (devfs_handle_t de)
+{
+	if (S_ISDIR(de->d_inode->i_mode))
+		vfs_rmdir(de->d_parent->d_inode, de);
+	else
+		vfs_unlink(de->d_parent->d_inode, de);
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
+
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
+int devfs_set_file_size (devfs_handle_t de, unsigned long size)
+{
+	/* STUB */
+	BUG();
+	return -1;
+}
--- linux-2.5.53/fs/devfs2/numspace.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs2/numspace.c	2002-12-25 17:44:14.000000000 -0800
@@ -0,0 +1,76 @@
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/devfs_fs_kernel.h>
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
+    if (!was_set) printk ("(): number %d was already free\n", number);
+}   /*  End Function devfs_dealloc_unique_number  */
+EXPORT_SYMBOL(devfs_dealloc_unique_number);

--ZPt4rx8FFjLCG7dd--
