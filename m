Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbUKES2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbUKES2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 13:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUKES2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 13:28:30 -0500
Received: from [61.48.52.143] ([61.48.52.143]:3050 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S262715AbUKES1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 13:27:01 -0500
Date: Sat, 6 Nov 2004 02:21:36 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411061021.iA6ALa403415@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] major devfs shrink based on tmpfs and lookup traps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch is a replacement implementation of devfs.  This
patch combined the tmpfs "lookup traps" patch that is required for
certain devfs functionality are a net deletion of more than 1800 lines
of code[1].  The code that actually remains in fs/devfs has a
.text+.data size of under 3kB.

	The implementation creates an instance of tmpfs and executes
the devfs operations that device drivers request on that instance.
Using the "lookup traps" patch that I just posted, the "helper=" mount
option for tmpfs can be used with the devfs_helper program[2] to
handle the LOOKUP commands in your existing /etc/devfsd.conf to have
automatic loading of kernel modules or execution of other commands in
response to attempts to access nonexistent device files.  The
devfs_helper program is invoked when needed, so there is no longer a
persistent devfs daemon.  (I expect to have code to handle {,UN}REGISTER
devfsd.conf commands shortly.)

	From the point of view of device drivers, I believe the only
visible interface change is that devfs_mk_symlink has been changed to
take printf-style arguments, compatible with the other existings
devfs_mk_ calls and to take the link contents as the first argument
rather than the second.  The parameter order now is compatible with
what you pass to the "ln -s" command in the shell, and, more
importantly, allows for the printf-style arguments, which really does
make the devfs implementation slightly smaller and also allows the
compiler to eliminate more code from callers of this facility when
devfs is compiled out.  This patch includes updates to all the callers
of devfs_mk_symlink.

	I have been running variants of this devfs implementation
continously on a number of computers for almost two years, although
the code for piggybacking on another file system is only about a week
old, and use of tmpfs is only a few days.  Of course, I am writing this
message on a computer that is running the code.

	I should add a couple of notes about applying this patch.

	First, note that this patch depends on the tmpfs user lookup
patch.  Both patches modify fs/Kconfig.  So, please apply the tmpfs
user lookup patch first.

	Second, perhaps being a bit optimistic, regarding integration
into a main release, I would like to have the patch for tmpfs lookup
traps get integrated into a kernel snapshot and then regenerate the
devfs snapshot for integration into a subsequent snapshot.  I'll
probably also shorten or move the rant in fs/Kconfig about udev, and I
expect to make a pass through Documentation/filesystems/devfs/.

	Anyhow, please let me know what you think.  Any feedback
would be welcome.


[1] This does not include Documentation/filesystems/lookup-trap.txt.
    The "helper=" tmpfs facility is a net addition of 352 lines.  The
    devfs replacement is a net deletion of 2423 lines.  The two combined
    are a net deletion of 2071 lines.

[2] ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/devfs_helper/devfs_helper-0.2.tar.gz

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


--- linux-2.6.10-rc1-bk14/include/linux/devfs_fs_kernel.h	2004-10-18 14:54:40.000000000 -0700
+++ linux/include/linux/devfs_fs_kernel.h	2004-11-02 21:13:08.000000000 -0800
@@ -8,14 +8,13 @@
 
 #include <asm/semaphore.h>
 
-#define DEVFS_SUPER_MAGIC                0x1373
-
 #ifdef CONFIG_DEVFS_FS
 extern int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
     __attribute__ ((format(printf, 3, 4)));
-extern int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
-    __attribute__ ((format(printf, 3, 4)));
-extern int devfs_mk_symlink(const char *name, const char *link);
+
+#define devfs_mk_cdev(dev, mode, fmt...)	devfs_mk_bdev(dev,mode,fmt)
+
+extern int devfs_mk_symlink (const char *link_contents, const char *fmt, ...);
 extern int devfs_mk_dir(const char *fmt, ...)
     __attribute__ ((format(printf, 1, 2)));
 extern void devfs_remove(const char *fmt, ...)
@@ -32,7 +31,8 @@
 {
 	return 0;
 }
-static inline int devfs_mk_symlink(const char *name, const char *link)
+static inline int
+devfs_mk_symlink (const char *link_contents, const char *fmt, ...)
 {
 	return 0;
 }
--- linux-2.6.10-rc1-bk14/fs/compat_ioctl.c	2004-10-23 13:56:30.000000000 -0700
+++ linux/fs/compat_ioctl.c	2004-10-23 14:27:02.000000000 -0700
@@ -412,7 +412,7 @@
 	return err;
 }
 
-#ifdef CONFIG_NET
+#if defined(CONFIG_NET) || defined(CONFIG_NET_MODULE)
 static int do_siocgstamp(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct compat_timeval __user *up = compat_ptr(arg);
@@ -3166,7 +3166,7 @@
 #ifdef DECLARES
 HANDLE_IOCTL(MEMREADOOB32, mtd_rw_oob)
 HANDLE_IOCTL(MEMWRITEOOB32, mtd_rw_oob)
-#ifdef CONFIG_NET
+#if defined(CONFIG_NET) || defined(CONFIG_NET_MODULE)
 HANDLE_IOCTL(SIOCGIFNAME, dev_ifname32)
 HANDLE_IOCTL(SIOCGIFCONF, dev_ifconf)
 HANDLE_IOCTL(SIOCGIFFLAGS, dev_ifsioc)
--- linux-2.6.10-rc1-bk14/fs/devfs/Makefile	2004-10-18 14:53:10.000000000 -0700
+++ linux/fs/devfs/Makefile	2004-11-02 21:13:33.000000000 -0800
@@ -4,5 +4,4 @@
 
 obj-$(CONFIG_DEVFS_FS) += devfs.o
 
-devfs-objs := base.o util.o
-
+devfs-objs := fs.o interface.o util.o
--- linux-2.6.10-rc1-bk14/fs/devfs/fs.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs/fs.c	2004-11-02 21:13:33.000000000 -0800
@@ -0,0 +1,117 @@
+/*
+  Device File System implementation as an instance of trapfs.
+ 
+  Written by Adam J. Richter.  Copyright 2004 Yggdrasil Computing, Inc.
+
+  This file is free software; you can redistribute it and/or
+  modify it under the terms of the GNU General Public License as
+  published by the Free Software Foundation; either version 2 of the
+  License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+  02111-1307 USA
+*/
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
+
+extern int __init trapfs_init(void);
+
+char devfs_slave_fs[40] = "tmpfs";
+module_param_string(devfs_slave_fs, devfs_slave_fs, sizeof(devfs_slave_fs),
+		    0444);
+
+static struct super_block *devfs_sb;
+static struct file_system_type *slavefs;
+static DECLARE_MUTEX(devfs_sb_sem);
+
+
+static struct super_block *devfs_get_sb(struct file_system_type *fs_type,
+					int flags,
+					const char *dev_name,
+					void *data)
+{
+	down(&devfs_sb_sem);
+
+	if (!devfs_sb) {
+		if (!slavefs)
+			slavefs = get_fs_type(devfs_slave_fs);
+
+		if (!slavefs)
+			printk (KERN_ERR "devfs_get_sb: unable to find %s.\n",
+				devfs_slave_fs);
+		else {
+			devfs_sb = (slavefs->get_sb)(fs_type, flags, dev_name,
+						     data);
+			if (!devfs_sb)
+				printk (KERN_ERR "devfs_get_sb: "
+					"slavefs_get_sb failed.\n");
+		}
+
+	}
+
+	if (devfs_sb)
+		atomic_inc(&devfs_sb->s_active);
+
+	up(&devfs_sb_sem);
+
+	return devfs_sb;
+}
+
+static void devfs_kill_super(struct super_block *sb)
+{
+	BUG_ON(sb != devfs_sb);
+	atomic_dec(&sb->s_active);
+}
+
+
+static struct file_system_type devfs_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "devfs",
+	.get_sb		= devfs_get_sb,
+	.kill_sb	= devfs_kill_super,
+};
+
+/* Not static, because it can also be called from init_devfs_fs. */
+int __init devfs_init(void)
+{
+	static int initialized;	/* = 0 */
+	int err;
+
+	init_tmpfs();
+
+	if (initialized)
+		err = 0;
+	else {
+		err = register_filesystem(&devfs_fs_type);
+		if (!err)
+			initialized = 1;
+	}
+
+	return err;
+}
+
+
+static void __exit devfs_exit(void)
+{
+	unregister_filesystem(&devfs_fs_type);
+	if (slavefs) {
+		if (devfs_sb)
+			(*slavefs->kill_sb)(devfs_sb);
+
+		module_put(slavefs->owner);
+	}
+}
+
+module_init(devfs_init)
+module_exit(devfs_exit)
+
+MODULE_LICENSE("GPL");
--- linux-2.6.10-rc1-bk14/fs/devfs/interface.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs/interface.c	2004-11-02 21:13:08.000000000 -0800
@@ -0,0 +1,334 @@
+/*
+    Device File System (devfs) - device interface routines
+
+    This file is a reimplementation by Adam J. Richter of part of a
+    design and implementation originally written by Richard Gooch.
+
+
+
+    Copyright 2002-2003  Yggdrasil Computing, Inc.
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
+*/
+
+/* Change log:
+	2003.02.24 - Maneesh Soni <maneesh@in.ibm.com> made it work with
+	read-copy-update, which is also apparently needed for linux-2.5.62-bk7
+	(presumably rcu has been merged into 2.5.62-bk7).
+
+	2003.02.24 - Override discretionary access controls (CAP_DAC_OVERRIDE)
+	in case devfs_{register,mk_sym_link} is called from a non-super-user.
+
+	2003.02.25 - Restore devfs=nomount boot option for now when
+	CONFIG_DEVFS_MOUNT is specified.
+
+	2003.03.21 - Implement suggestions by Christoph Hellwig:
+	rename to interface.c, raise CAP_DAC_OVERRIDE in devfs_mk_dir
+	(to match devfs_regsiter and devfs_mk_symlink), eliminate call
+	to devfs_dealloc_devnum, put unlikely() around devfs_vfsmount
+	test.  Also raise CAP_DAC_OVERRIDE in devfs_unregsiter.
+
+	2003.03.24 - 2.5.65-bk5 simplified devfs_mk_dir and devfs_mk_symlink.
+*/
+	
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include <linux/namespace.h>
+
+#include "internal.h"
+
+static char *devfs_mountpoint = "/dev";
+static char *dev_fs_type = "devfs";
+
+static struct dentry *devfs_root;
+
+/*
+   walk_parents expects to be called with parent->d_inode->i_sem
+   NOT held (this is against the convention of VFS lookup routines, but
+   no callers in this file currently want to do anything with i_sem
+   held before calling walk_parents, so we consolidate the
+   down() call here.
+
+   On the other hand, if the routine succeeds, it returns a dentry
+   with ->d_inode->i_sem HELD.  This is to avoid any races between
+   the last lookup done in walk_parents and whatever vfs
+   operation the caller is going to do.  (On failure, this routine
+   does release parent_inode->i_sem, since the routine will not
+   return a pointer that would allow the caller to determine the
+   parent inode).
+ */
+static struct dentry *
+walk_parents(const char *fmt, va_list args, int mkdirs)
+{
+	int len;
+	char path_buf[64];
+	char *path;
+	char *slash;
+	int err;
+	struct inode *parent_inode;
+	struct dentry *child;
+	struct dentry *parent;
+
+	len = vsnprintf(path_buf, sizeof(path_buf), fmt, args);
+	if (len >= sizeof(path_buf))
+		return ERR_PTR(-ENAMETOOLONG);
+
+	parent = devfs_root;
+
+	/*
+	  FUTURE: parent can be null if the kernel has devfs support
+	  compiled in, but the user has disabled it at boot.
+
+	  FUTURE: parent->d_inode can be null if the devfs_root is
+	  not a mount point and the user does "rm -rf /dev"
+	*/
+	if(!parent || !parent->d_inode)
+		return ERR_PTR(-ENOENT);
+
+	path = path_buf;
+	dget(parent);
+	for(;;) {
+		while (*path == '/')
+			path++;
+
+		/* paths passed to devfs_mk_* must not end in "/".
+		   It's too much of a pain to deal with, so we just
+		   declare that to be a bug in the calling device driver. */
+		BUG_ON(*path == '\0');
+
+
+		slash = strchr(path, '/');
+
+		parent_inode = parent->d_inode;
+		down(&parent_inode->i_sem);
+
+		if (slash == NULL) {
+			child = lookup_one_len(path, parent, strlen(path));
+			break;
+		}
+
+		child = lookup_one_len(path, parent, slash - path);
+		if (IS_ERR(child))
+			break;
+
+		if (!child->d_inode) {
+			err = mkdirs ?
+				vfs_mkdir(parent_inode, child, 0755) : -ENOENT;
+
+			if (err) {
+				dput(child);
+				child = ERR_PTR(err);
+				break;
+			}
+		}
+
+		up(&parent_inode->i_sem);
+		dput(parent);
+		parent = child;
+		path = slash + 1;
+	}
+
+	if (IS_ERR(child))
+		up(&parent_inode->i_sem);
+
+	dput(parent);
+	return child;
+}
+
+int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
+{
+	va_list args;
+	struct dentry *dentry;
+	int err;
+	struct inode *parent_inode;
+	kernel_cap_t oldcap = current->cap_effective;
+
+	current->cap_effective |=
+		CAP_TO_MASK(CAP_MKNOD) | CAP_TO_MASK(CAP_DAC_OVERRIDE);
+
+	va_start(args, fmt);
+	dentry = walk_parents(fmt, args, 1);
+	va_end(args);
+
+	if (IS_ERR(dentry))
+		err = PTR_ERR(dentry);
+	else {
+		parent_inode = dentry->d_parent->d_inode;
+
+		err = vfs_mknod(parent_inode, dentry, mode, dev);
+		up(&parent_inode->i_sem);
+		dput(dentry);
+	}
+
+	current->cap_effective = oldcap;
+	return err;
+}
+EXPORT_SYMBOL(devfs_mk_bdev);
+
+int devfs_mk_symlink (const char *link_contents, const char *fmt, ...)
+{
+	va_list args;
+	struct dentry *dentry;
+	int err;
+	struct inode *parent_inode;
+	kernel_cap_t oldcap = current->cap_effective;
+
+	cap_raise(current->cap_effective, CAP_DAC_OVERRIDE);
+
+	va_start(args, fmt);
+	dentry = walk_parents(fmt, args, 1);
+	va_end(args);
+
+	if (IS_ERR(dentry))
+		err = PTR_ERR(dentry);
+	else {
+		parent_inode = dentry->d_parent->d_inode;
+		err = vfs_symlink(parent_inode, dentry, link_contents,
+				  S_IALLUGO);
+		up(&parent_inode->i_sem);
+		dput(dentry);
+	}
+
+	current->cap_effective = oldcap;
+	return err;
+}
+EXPORT_SYMBOL(devfs_mk_symlink);
+
+int devfs_mk_dir(const char *fmt, ...)
+{
+	struct inode *parent_inode;
+	struct dentry *dentry;
+	int err;
+	va_list args;
+	kernel_cap_t oldcap = current->cap_effective;
+
+	cap_raise(current->cap_effective, CAP_DAC_OVERRIDE);
+
+	va_start(args, fmt);
+	dentry = walk_parents(fmt, args, 1);
+	va_end(args);
+
+	if (IS_ERR(dentry))
+		err = PTR_ERR(dentry);
+	else {
+		parent_inode = dentry->d_parent->d_inode;
+		err = vfs_mkdir(parent_inode, dentry, 0755);
+		up(&parent_inode->i_sem);
+		dput(dentry);
+	}
+
+	current->cap_effective = oldcap;
+	return err;
+}
+EXPORT_SYMBOL(devfs_mk_dir);
+
+/* From fs/devfs/base.c: */
+void devfs_remove(const char *fmt, ...)
+{
+	va_list args;
+	kernel_cap_t oldcap;
+	struct inode *parent_inode;
+	struct dentry *dentry;
+
+	va_start(args, fmt);
+	dentry = walk_parents(fmt, args, 0);
+	va_end(args);
+
+	if (IS_ERR(dentry))
+		return;
+
+	parent_inode = dentry->d_parent->d_inode;
+
+	oldcap = current->cap_effective;
+	cap_raise(current->cap_effective, CAP_DAC_OVERRIDE);
+
+	if (S_ISDIR(dentry->d_inode->i_mode))
+		vfs_rmdir(parent_inode, dentry);
+	else
+		vfs_unlink(parent_inode, dentry);
+
+	current->cap_effective = oldcap;
+
+	up(&parent_inode->i_sem);
+	dput(dentry);
+}
+EXPORT_SYMBOL(devfs_remove);
+
+#ifdef CONFIG_DEVFS_MOUNT
+static int devfs_do_mount = 1;
+
+static int devfs_param_set(const char *buffer, struct kernel_param *unused)
+{
+	if (strcmp(buffer, "mount") == 0)
+		devfs_do_mount = 1;
+	else if (strcmp(buffer, "nomount") == 0)
+		devfs_do_mount = 0;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int devfs_param_get(char *buffer, struct kernel_param *unused)
+{
+	return sprintf(buffer, "%smount", devfs_do_mount ? "" : "no");
+}
+
+__module_param_call("", devfs, devfs_param_set, devfs_param_get, NULL, 0444);
+
+int __init init_devfs_fs(void)
+{
+	struct vfsmount *vfsmount;
+
+	if (devfs_root != NULL)	/* FIXME? Can this happen? */
+		return 0;
+
+	devfs_init();		/* Safe to call repeatedly if devfs
+				   is compiled into the kernel. */
+
+	vfsmount = do_kern_mount(dev_fs_type, 0, dev_fs_type, NULL);
+
+	if (IS_ERR(vfsmount))
+		return PTR_ERR(vfsmount);
+	else {
+		devfs_root = vfsmount->mnt_root;
+		return 0;
+	}
+}
+
+void __init mount_devfs_fs (void)
+{
+	if (devfs_do_mount) {
+		int err = do_mount ("none", devfs_mountpoint, dev_fs_type, 0, "");
+
+		if (err == 0)
+			printk (KERN_INFO "Mounted devfs on /dev\n");
+		else
+			printk ("(): unable to mount devfs, err: %d\n", err);
+	}
+}   /*  End Function mount_devfs_fs  */
+
+#else 
+
+void __init mount_devfs_fs (void)
+{
+}
+
+#endif /* CONFIG_DEVFS_MOUNT */
+
--- linux-2.6.10-rc1-bk14/fs/devfs/internal.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs/internal.h	2004-11-02 20:23:23.000000000 -0800
@@ -0,0 +1,6 @@
+#ifndef DEVFS_INTERNAL_H
+#define DEVFS_INTERNAL_H
+
+extern int __init devfs_init(void);
+
+#endif /* DEVFS_INTERNAL_H */
--- linux-2.6.10-rc1-bk14/fs/devfs/util.c	2004-10-23 13:56:30.000000000 -0700
+++ linux/fs/devfs/util.c	2004-11-02 21:13:08.000000000 -0800
@@ -75,13 +75,12 @@
 
 int devfs_register_tape(const char *name)
 {
-	char tname[32], dest[64];
+	char dest[64];
 	static unsigned int tape_counter;
 	unsigned int n = tape_counter++;
 
 	sprintf(dest, "../%s", name);
-	sprintf(tname, "tapes/tape%u", n);
-	devfs_mk_symlink(tname, dest);
+	devfs_mk_symlink(dest, "tapes/tape%u", n);
 
 	return n;
 }
--- linux-2.6.10-rc1-bk14/fs/partitions/devfs.c	2004-10-23 13:56:31.000000000 -0700
+++ linux/fs/partitions/devfs.c	2004-11-02 21:13:08.000000000 -0800
@@ -79,7 +79,7 @@
 
 void devfs_add_partitioned(struct gendisk *disk)
 {
-	char dirname[64], symlink[16];
+	char dirname[64];
 
 	devfs_mk_dir(disk->devfs_name);
 	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor),
@@ -88,10 +88,8 @@
 
 	disk->number = alloc_unique_number(&disc_numspace);
 
-	sprintf(symlink, "discs/disc%d", disk->number);
 	sprintf(dirname, "../%s", disk->devfs_name);
-	devfs_mk_symlink(symlink, dirname);
-
+	devfs_mk_symlink(dirname, "discs/disc%d", disk->number);
 }
 
 void devfs_add_disk(struct gendisk *disk)
@@ -103,13 +101,12 @@
 			"%s", disk->devfs_name);
 
 	if (disk->flags & GENHD_FL_CD) {
-		char dirname[64], symlink[16];
+		char dirname[64];
 
 		disk->number = alloc_unique_number(&cdrom_numspace);
 
-		sprintf(symlink, "cdroms/cdrom%d", disk->number);
 		sprintf(dirname, "../%s", disk->devfs_name);
-		devfs_mk_symlink(symlink, dirname);
+		devfs_mk_symlink(dirname, "cdroms/cdrom%d", disk->number);
 	}
 }
 
--- linux-2.6.10-rc1-bk14/arch/um/drivers/line.c	2004-11-04 23:32:34.000000000 -0800
+++ linux/arch/um/drivers/line.c	2004-11-02 21:13:08.000000000 -0800
@@ -438,7 +438,7 @@
 
 	from = line_driver->symlink_from;
 	to = line_driver->symlink_to;
-	err = devfs_mk_symlink(from, to);
+	err = devfs_mk_symlink(to, from);
 	if(err) printk("Symlink creation from /dev/%s to /dev/%s "
 		       "returned %d\n", from, to, err);
 
--- linux-2.6.10-rc1-bk14/arch/um/drivers/mmapper_kern.c	2004-10-23 13:56:12.000000000 -0700
+++ linux/arch/um/drivers/mmapper_kern.c	2004-11-02 21:13:08.000000000 -0800
@@ -128,7 +128,7 @@
 	p_buf = __pa(v_buf);
 
 	devfs_mk_cdev(MKDEV(30, 0), S_IFCHR|S_IRUGO|S_IWUGO, "mmapper");
-	devfs_mk_symlink("mmapper0", "mmapper");
+	devfs_mk_symlink("mmapper", "mmapper0");
 	return(0);
 }
 
--- linux-2.6.10-rc1-bk14/arch/um/drivers/ubd_kern.c	2004-10-18 14:54:08.000000000 -0700
+++ linux/arch/um/drivers/ubd_kern.c	2004-11-02 21:13:08.000000000 -0800
@@ -559,7 +559,7 @@
 			
 {
 	struct gendisk *disk;
-	char from[sizeof("ubd/nnnnn\0")], to[sizeof("discnnnnn/disc\0")];
+	char to[sizeof("discnnnnn/disc\0")];
 	int err;
 
 	disk = alloc_disk(1 << UBD_SHIFT);
@@ -573,9 +573,8 @@
 	if(major == MAJOR_NR){
 		sprintf(disk->disk_name, "ubd%c", 'a' + unit);
 		sprintf(disk->devfs_name, "ubd/disc%d", unit);
-		sprintf(from, "ubd/%d", unit);
 		sprintf(to, "disc%d/disc", unit);
-		err = devfs_mk_symlink(from, to);
+		err = devfs_mk_symlink(to, "ubd/%d", unit);
 		if(err)
 			printk("ubd_new_disk failed to make link from %s to "
 			       "%s, error = %d\n", from, to, err);
--- linux/fs/Kconfig.old	2004-11-05 23:58:22.000000000 -0800
+++ linux/fs/Kconfig	2004-11-06 01:33:20.000000000 -0800
@@ -846,56 +846,6 @@
 
 	Designers of embedded systems may wish to say N here to conserve space.
 
-config DEVFS_FS
-	bool "/dev file system support (OBSOLETE)"
-	depends on EXPERIMENTAL
-	help
-	  This is support for devfs, a virtual file system (like /proc) which
-	  provides the file system interface to device drivers, normally found
-	  in /dev. Devfs does not depend on major and minor number
-	  allocations. Device drivers register entries in /dev which then
-	  appear automatically, which means that the system administrator does
-	  not have to create character and block special device files in the
-	  /dev directory using the mknod command (or MAKEDEV script) anymore.
-
-	  This is work in progress. If you want to use this, you *must* read
-	  the material in <file:Documentation/filesystems/devfs/>, especially
-	  the file README there.
-
-	  Note that devfs no longer manages /dev/pts!  If you are using UNIX98
-	  ptys, you will also need to mount the /dev/pts filesystem (devpts).
-
-	  Note that devfs has been obsoleted by udev,
-	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
-	  It has been stripped down to a bare minimum and is only provided for
-	  legacy installations that use its naming scheme which is
-	  unfortunately different from the names normal Linux installations
-	  use.
-
-	  If unsure, say N.
-
-config DEVFS_MOUNT
-	bool "Automatically mount at boot"
-	depends on DEVFS_FS
-	help
-	  This option appears if you have CONFIG_DEVFS_FS enabled. Setting
-	  this to 'Y' will make the kernel automatically mount devfs onto /dev
-	  when the system is booted, before the init thread is started.
-	  You can override this with the "devfs=nomount" boot option.
-
-	  If unsure, say N.
-
-config DEVFS_DEBUG
-	bool "Debug devfs"
-	depends on DEVFS_FS
-	help
-	  If you say Y here, then the /dev file system code will generate
-	  debugging messages. See the file
-	  <file:Documentation/filesystems/devfs/boot-options> for more
-	  details.
-
-	  If unsure, say N.
-
 config DEVPTS_FS_XATTR
 	bool "/dev/pts Extended Attributes"
 	depends on UNIX98_PTYS
@@ -930,6 +880,9 @@
 
 	  See <file:Documentation/filesystems/tmpfs.txt> for details.
 
+	  devfs now requires tmpfs.  You must say "Y" here to tmpfs if
+	  you want to be able to use devfs.
+
 config TMPFS_XATTR
 	bool "tmpfs Extended Attributes"
 	depends on TMPFS
@@ -940,6 +893,17 @@
 
 	  If unsure, say N.
 
+config TMPFS_SECURITY
+	bool "tmpfs Security Labels"
+	depends on TMPFS_XATTR
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the tmpfs filesystem.
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
 config TMPFS_LOOKUP_TRAPS
 	bool "tmpfs lookup trapping"
 	depends on TMPFS
@@ -957,16 +921,89 @@
 	  module (because tmpfs isn't).  For examples and more information,
 	  please see <file:Documentations/filesystems/lookup-trap.txt>.
 
-config TMPFS_SECURITY
-	bool "tmpfs Security Labels"
-	depends on TMPFS_XATTR
+	  devfs now uses tmpfs lookup traps to implement configuration
+	  of devices on demand.  If you want this feature of devfs to
+	  be available, you must say "Y" here to TMPFS_LOOKUP_TRAPS.
+
+config DEVFS_FS
+	bool "/dev file system support"
+	depends on TMPFS
 	help
-	  Security labels support alternative access control models
-	  implemented by security modules like SELinux.  This option
-	  enables an extended attribute handler for file security
-	  labels in the tmpfs filesystem.
-	  If you are not using a security module that requires using
-	  extended attributes for file security labels, say N.
+	  This is support for devfs, a virtual file system (like /proc) which
+	  provides the file system interface to device drivers, normally found
+	  in /dev. Device drivers register entries in /dev which then
+	  appear automatically, which means that the system administrator does
+	  not have to create character and block special device files in the
+	  /dev directory using the mknod command (or MAKEDEV script) anymore.
+
+	  Note that devfs no longer manages /dev/pts!  If you are using UNIX98
+	  ptys, you will also need to mount the /dev/pts filesystem (devpts).
+
+	  You many want to read the material in
+	  <file:Documentation/filesystems/devfs/>, which currently
+	  documents the previous implementation.
+
+	  People interested in devfs may also be interested in udev
+	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>, a
+	  system which creates device files in /dev in response to
+	  hot plug events.  Previously, someone put a note in this
+	  help message claiming that udev had obseleted devfs, so
+	  here is a quick summary of why that is probably not true.
+
+	  udev by itself does not currently do anything to support demand
+	  loading of drivers (some of which do not correspond to any
+	  hardware event) or give device drivers the ability to register
+	  descriptive minor device names (/dev/sound/mixer, /dev/sound/dsp),
+	  although non-devfs systems can, of course be preconfigured to
+	  "know" these things for specific devices, either by creating
+	  fixed files in /dev or sysfs-to-dev configuration files, which
+	  leads one to want automatic generation of such information from
+	  new modules, devfs does when the module is loaded, although it
+	  would be helpful to evolve devfs to also make some of this
+	  information extractable from the module, as hardware device ID
+	  information now is.  Also, mechanisms to pass such string
+	  information to udev via sysfs look to require more kernel code
+	  and consume more kernel memory than devfs.  However, having
+	  a user level utility mediate the creation of nodes in /dev
+	  has advantages in customizability, and having /dev reflect
+	  what device drivers are available rather than what drivers
+	  are loaded is informative to the user.
+
+	  With about half of the code that implements the functionality
+	  previously handled by devfs now part of the tmpfs lookup
+	  trapping facility which many udev systems are likely use,
+	  and with the move to dynamic device numbers requiring some sort
+	  of string-based device identification mechanism, there is
+	  question to what set of functionality one means by "devfs"
+	  if one claims that devfs is obseleted.
+
+	  Perhaps in the future, the kernel will not directly create
+	  device nodes in a virtual file system, but it is quite likely
+	  the some variant of the current devfs driver registration
+	  calls, perhaps via more user level software, will indirectly
+	  cause /dev to names appear about the same way it does today.
+
+config DEVFS_MOUNT
+	bool "Automatically mount at boot"
+	depends on DEVFS_FS
+	help
+	  This option appears if you have CONFIG_DEVFS_FS enabled. Setting
+	  this to 'Y' will make the kernel automatically mount devfs onto /dev
+	  when the system is booted, before the init thread is started.
+	  You can override this with the "devfs=nomount" boot option.
+
+	  If unsure, say N.
+
+config DEVFS_DEBUG
+	bool "Debug devfs"
+	depends on DEVFS_FS
+	help
+	  If you say Y here, then the /dev file system code will generate
+	  debugging messages. See the file
+	  <file:Documentation/filesystems/devfs/boot-options> for more
+	  details.
+
+	  If unsure, say N.
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
--- /dev/null	2004-11-05 11:55:32.000000000 -0800
+++ linux/Documentation/filesystems/devfs/small-devfs	2004-11-06 02:13:14.000000000 -0800
@@ -0,0 +1,92 @@
+This document describes the differences between Richard Gooch's
+original devfs and my "small" devfs.
+
+This new devfs replaces the internal devfs file system with one
+derived from ramfs, a reduction of more than 1800 lines of source
+code, although it now relies on tmpfs.
+
+
+User level differences:
+
+1. devfsd replaced by devfs_helper
+
+	devfs_helper implements a subset of devfsd functionality.
+devfs_helper is not a deamon.  Instead, the new devfs invokes
+devfs_helper with argument for each event.  The new devfs currently
+only calls devfs_helper for "LOOKUP" and "REGISTER" events.
+devfs_helper uses the existing /etc/devfsd.conf file and supports
+devfsd's regular expression matching.  Like devfsd, devfs_helper is
+optional.  It is available from the following FTP directory.
+
+	ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/
+
+
+2. Old device names not automatically installed.
+
+   Unlike devfsd, devfs_helper does not install old "compatible"
+   device names.  This keeps devfs_helper small, which is particularly
+   important since devfs_helper is invoked repeatedly.
+
+   If you want to install a bunch of alternate device
+   names (such as /dev/hda1 for /dev/ide/host0/bus0/target0/lun0/part1),
+   you can do this at boot time after /dev has been mounted.  For
+   example, you could maintain a tree of device nodes to overlay
+   on /dev in, say /dev.overlay, and then add something like the
+   following to a boot script:
+
+	( cd /dev.overlay && tar cf - ) | ( cd /dev && tar xfp - )
+
+   Note that you should not use "cp" or even "cp -a" for this
+   operation, as that "cp" will always try to open devices and
+   read from them.
+
+   If you want to save the current /dev every time you shut your
+   system down, you could add a line like the following to a
+   halt script:
+
+	( cd /dev && tar cf - ) | ( cd /dev.overlay && tar xfp - )
+
+   Note that if you want to support booting both with and without
+   devfs, a simpler approach might be to convert your non-devfs
+   system to use devfs-style names, at least for the devices that
+   are needed for booting (/dev/vc/0, /dev/vc/1... for virtual
+   consoles, /dev/discs/disc0/disc for the first whole hard disk,
+   /dev/discs/discs0/part1 for the first partition of the first
+   disk, /dev/floppy/0).
+
+
+3. Future: DEVFS_MOUNT and "devfs=nomount" may disappear.
+
+   The option to have the kernel automatically mount /dev may
+   disappear in the future.  As with old devfs, you can already
+   eliminate this feature by not defining DEVFS_MOUNT.  If you
+   do this, the kernel will not be able to open /dev/console
+   before invoking /sbin/init.  Eliminating DEVFS_MOUNT shrinks
+   the kernel, allowing this functionality to be provided by
+   user level programs (which don't necessarily remain resident
+   in memory and which may want to do something different anyhow).
+   The init program can do something like the following untested
+   code to mount /dev and open /dev/console:
+
+	mount("", "/dev", "devfs", 0, NULL);
+	close(0); close(1); close(2);	/* Just to make sure. */
+	open("/dev/console", O_RDONLY); /* This will return fd 0. */
+	open("/dev/console", O_WRONLY); /* This will return fd 1. */
+	dup2(1, 2);			/* stderr = stdout. */
+
+
+4. Partition table support now matches non-devfs systems (i.e., no
+   automatic partition table rereading, which was causing problems).
+
+	The old devfs would automatically reread partition tables
+at various times.  This was a functional difference with non-devfs
+systems, and made it nearly impossible to use drivers that returned
+incorrect "media changed" information such as with CompactFlash cards
+on systems that used user level partition reading programs like partx
+to keep the kernel small.  Basically, the old devfs would make the
+kernel forget CompactFlash partition tables on nearly every operation.
+This misfeature is removed in smalldevfs.  smalldevfs systems now
+handle partition tables just like non-devfs systems.
+
+Adam J. Richter
+adam@yggdrasil.com
