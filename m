Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVFKHzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVFKHzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVFKHyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:54:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:64451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261643AbVFKHsk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:40 -0400
Subject: [PATCH] Remove devfs from the init code
In-Reply-To: <11184761102475@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:30 -0700
Message-Id: <11184761103552@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the devfs code from the init/ directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/devfs_fs_kernel.h |    4 -
 init/Makefile                   |    1 
 init/do_mounts.c                |    8 --
 init/do_mounts.h                |   15 ----
 init/do_mounts_devfs.c          |  137 ----------------------------------------
 init/do_mounts_initrd.c         |    6 -
 init/do_mounts_md.c             |    5 -
 7 files changed, 7 insertions(+), 169 deletions(-)

--- gregkh-2.6.orig/init/Makefile	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/init/Makefile	2005-06-10 23:36:41.000000000 -0700
@@ -6,7 +6,6 @@
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
 
 mounts-y			:= do_mounts.o
-mounts-$(CONFIG_DEVFS_FS)	+= do_mounts_devfs.o
 mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
 mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
 mounts-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o
--- gregkh-2.6.orig/init/do_mounts_devfs.c	2005-06-10 23:29:08.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,137 +0,0 @@
-
-#include <linux/kernel.h>
-#include <linux/dirent.h>
-#include <linux/string.h>
-
-#include "do_mounts.h"
-
-void __init mount_devfs(void)
-{
-	sys_mount("devfs", "/dev", "devfs", 0, NULL);
-}
-
-void __init umount_devfs(char *path)
-{
-	sys_umount(path, 0);
-}
-
-/*
- * If the dir will fit in *buf, return its length.  If it won't fit, return
- * zero.  Return -ve on error.
- */
-static int __init do_read_dir(int fd, void *buf, int len)
-{
-	long bytes, n;
-	char *p = buf;
-	sys_lseek(fd, 0, 0);
-
-	for (bytes = 0; bytes < len; bytes += n) {
-		n = sys_getdents64(fd, (struct linux_dirent64 *)(p + bytes),
-					len - bytes);
-		if (n < 0)
-			return n;
-		if (n == 0)
-			return bytes;
-	}
-	return 0;
-}
-
-/*
- * Try to read all of a directory.  Returns the contents at *p, which
- * is kmalloced memory.  Returns the number of bytes read at *len.  Returns
- * NULL on error.
- */
-static void * __init read_dir(char *path, int *len)
-{
-	int size;
-	int fd = sys_open(path, 0, 0);
-
-	*len = 0;
-	if (fd < 0)
-		return NULL;
-
-	for (size = 1 << 9; size <= (PAGE_SIZE << MAX_ORDER); size <<= 1) {
-		void *p = kmalloc(size, GFP_KERNEL);
-		int n;
-		if (!p)
-			break;
-		n = do_read_dir(fd, p, size);
-		if (n > 0) {
-			sys_close(fd);
-			*len = n;
-			return p;
-		}
-		kfree(p);
-		if (n == -EINVAL)
-			continue;	/* Try a larger buffer */
-		if (n < 0)
-			break;
-	}
-	sys_close(fd);
-	return NULL;
-}
-
-/*
- * recursively scan <path>, looking for a device node of type <dev>
- */
-static int __init find_in_devfs(char *path, unsigned dev)
-{
-	char *end = path + strlen(path);
-	int rest = path + 64 - end;
-	int size;
-	char *p = read_dir(path, &size);
-	char *s;
-
-	if (!p)
-		return -1;
-	for (s = p; s < p + size; s += ((struct linux_dirent64 *)s)->d_reclen) {
-		struct linux_dirent64 *d = (struct linux_dirent64 *)s;
-		if (strlen(d->d_name) + 2 > rest)
-			continue;
-		switch (d->d_type) {
-			case DT_BLK:
-				sprintf(end, "/%s", d->d_name);
-				if (bstat(path) != dev)
-					break;
-				kfree(p);
-				return 0;
-			case DT_DIR:
-				if (strcmp(d->d_name, ".") == 0)
-					break;
-				if (strcmp(d->d_name, "..") == 0)
-					break;
-				sprintf(end, "/%s", d->d_name);
-				if (find_in_devfs(path, dev) < 0)
-					break;
-				kfree(p);
-				return 0;
-		}
-	}
-	kfree(p);
-	return -1;
-}
-
-/*
- * create a device node called <name> which points to
- * <devfs_name> if possible, otherwise find a device node
- * which matches <dev> and make <name> a symlink pointing to it.
- */
-int __init create_dev(char *name, dev_t dev, char *devfs_name)
-{
-	char path[64];
-
-	sys_unlink(name);
-	if (devfs_name && devfs_name[0]) {
-		if (strncmp(devfs_name, "/dev/", 5) == 0)
-			devfs_name += 5;
-		sprintf(path, "/dev/%s", devfs_name);
-		if (sys_access(path, 0) == 0)
-			return sys_symlink(devfs_name, name);
-	}
-	if (!dev)
-		return -1;
-	strcpy(path, "/dev");
-	if (find_in_devfs(path, new_encode_dev(dev)) < 0)
-		return -1;
-	return sys_symlink(path + 5, name);
-}
--- gregkh-2.6.orig/init/do_mounts.c	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/init/do_mounts.c	2005-06-10 23:36:41.000000000 -0700
@@ -322,7 +322,7 @@
 {
 	void *data = nfs_root_data();
 
-	create_dev("/dev/root", ROOT_DEV, NULL);
+	create_dev("/dev/root", ROOT_DEV);
 	if (data &&
 	    do_mount_root("/dev/root", "nfs", root_mountflags, data) == 0)
 		return 1;
@@ -383,7 +383,7 @@
 			change_floppy("root floppy");
 	}
 #endif
-	create_dev("/dev/root", ROOT_DEV, root_device_name);
+	create_dev("/dev/root", ROOT_DEV);
 	mount_block_root("/dev/root", root_mountflags);
 }
 
@@ -394,8 +394,6 @@
 {
 	int is_floppy;
 
-	mount_devfs();
-
 	if (root_delay) {
 		printk(KERN_INFO "Waiting %dsec before mounting root device...\n",
 		       root_delay);
@@ -421,10 +419,8 @@
 
 	mount_root();
 out:
-	umount_devfs("/dev");
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
 	security_sb_post_mountroot();
-	mount_devfs_fs ();
 }
 
--- gregkh-2.6.orig/init/do_mounts.h	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/init/do_mounts.h	2005-06-10 23:38:12.000000000 -0700
@@ -16,25 +16,12 @@
 extern int root_mountflags;
 extern char *root_device_name;
 
-#ifdef CONFIG_DEVFS_FS
-
-void mount_devfs(void);
-void umount_devfs(char *path);
-int  create_dev(char *name, dev_t dev, char *devfs_name);
-
-#else
-
-static inline void mount_devfs(void) {}
-static inline void umount_devfs(const char *path) {}
-
-static inline int create_dev(char *name, dev_t dev, char *devfs_name)
+static inline int create_dev(char *name, dev_t dev)
 {
 	sys_unlink(name);
 	return sys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
-#endif
-
 #if BITS_PER_LONG == 32
 static inline u32 bstat(char *name)
 {
--- gregkh-2.6.orig/init/do_mounts_initrd.c	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/init/do_mounts_initrd.c	2005-06-10 23:36:41.000000000 -0700
@@ -44,7 +44,7 @@
 	int i, pid;
 
 	real_root_dev = new_encode_dev(ROOT_DEV);
-	create_dev("/dev/root.old", Root_RAM0, NULL);
+	create_dev("/dev/root.old", Root_RAM0);
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	sys_mkdir("/old", 0700);
@@ -54,7 +54,6 @@
 	sys_chdir("/root");
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
-	mount_devfs_fs ();
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
@@ -70,7 +69,6 @@
 	sys_chroot(".");
 	sys_close(old_fd);
 	sys_close(root_fd);
-	umount_devfs("/old/dev");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
 		sys_chdir("/old");
@@ -103,7 +101,7 @@
 int __init initrd_load(void)
 {
 	if (mount_initrd) {
-		create_dev("/dev/ram", Root_RAM0, NULL);
+		create_dev("/dev/ram", Root_RAM0);
 		/*
 		 * Load the initrd data into /dev/ram0. Execute it as initrd
 		 * unless /dev/ram0 is supposed to be our actual root device,
--- gregkh-2.6.orig/include/linux/devfs_fs_kernel.h	2005-06-10 23:36:24.000000000 -0700
+++ gregkh-2.6/include/linux/devfs_fs_kernel.h	2005-06-10 23:38:26.000000000 -0700
@@ -33,8 +33,4 @@
 static inline void devfs_unregister_tape(int num)
 {
 }
-static inline void mount_devfs_fs(void)
-{
-	return;
-}
 #endif				/*  _LINUX_DEVFS_FS_KERNEL_H  */
--- gregkh-2.6.orig/init/do_mounts_md.c	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/init/do_mounts_md.c	2005-06-10 23:36:41.000000000 -0700
@@ -129,19 +129,18 @@
 		int err = 0;
 		char *devname;
 		mdu_disk_info_t dinfo;
-		char name[16], devfs_name[16];
+		char name[16];
 
 		minor = md_setup_args[ent].minor;
 		partitioned = md_setup_args[ent].partitioned;
 		devname = md_setup_args[ent].device_names;
 
 		sprintf(name, "/dev/md%s%d", partitioned?"_d":"", minor);
-		sprintf(devfs_name, "/dev/md/%s%d", partitioned?"d":"", minor);
 		if (partitioned)
 			dev = MKDEV(mdp_major, minor << MdpMinorShift);
 		else
 			dev = MKDEV(MD_MAJOR, minor);
-		create_dev(name, dev, devfs_name);
+		create_dev(name, dev);
 		for (i = 0; i < MD_SB_DISKS && devname != 0; i++) {
 			char *p;
 			char comp_name[64];

