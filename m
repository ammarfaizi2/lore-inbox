Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUASTNn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 14:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUASTNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 14:13:43 -0500
Received: from hera.ecs.csus.edu ([130.86.71.150]:53636 "EHLO
	hera.ecs.csus.edu") by vger.kernel.org with ESMTP id S261595AbUASTN2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 14:13:28 -0500
Date: Mon, 19 Jan 2004 11:13:26 -0800 (PST)
From: Joshua Hudson <hudsonj@sequoia.ecs.csus.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Patch for 2.2 kernel
Message-ID: <Pine.HPX.4.31.0401191104020.26731-100000@sequoia.ecs.csus.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a little problem a few days ago when experimenting with loopback
installations, in that when the root filesystem is on a loop device,
the parent filesystem can not be remounted ro even when the root
filesystem is first mounted ro. Since I use the 2.2 series, I wrote
the patch for the 2.2 series. Specifically, this is kernel 2.2.22. I will
be applying this patch to a newer 2.2 kernel in a few days though.

The patch seems rather larger than it should be because I removed all
the trailing whitespace from the files I edited (it seems that I'm not
the only person who leaves trailing whitespace when typing C code).

I also wrote a little utility to demonstrate the new functionality,
although I fancy that the final form of this will end up in losetup.

Your coments please. (Don't tell me about the ptrace security hole,
I am the only user of the machine).

*** Start of utility
/* loopro.c - JH
 *
 */

/* Can't include gclibc defs. Oh bother. */
#include <linux/types.h>
#include <linux/loop.h>
#define O_RDWR 2
#ifndef LOOP_SET_RDONLY
#define LOOP_SET_RDONLY 0x4C04
#endif

char usage[] = "Sets a loop device to readonly\n"
		"Usage: loopro device\n";

int main(int argc, char **argv)
{
	int fd;
	struct loop_info inf;
	if (argc != 2)
	{
		write(2, usage, sizeof(usage) - 1);
		return 2;
	}
	fd = open(argv[1], O_RDWR);
	if (fd < 0)
	{
		perror(argv[1]);
		return 1;
	}
	if (0 > ioctl(fd, LOOP_SET_RDONLY))
	{
		perror(argv[1]);
		return 1;
	}
	return 0;
}

*** Start of patch

diff -u -r linux-2.2.22/Documentation/Configure.help
linux-2.2.22c/Documentation/Configure.help
--- linux-2.2.22/Documentation/Configure.help	Mon Sep 16 09:26:11 2002
+++ linux-2.2.22c/Documentation/Configure.help	Sun Jan 18 07:33:51 2004
@@ -262,6 +262,16 @@

   Most users will answer N here.

+Enable late setting of readonly
+CONFIG_LOOP_SET_RDONLY
+  Saying Y here enables the loopback driver to switch the device and
+  backing file to read-only mode (but it can't switch back). This is
+  of use mainly for systems with a loopback filesystem as the root
+  filesystem.
+
+  If you will not be using a loopback root filesystem, or you don't
+  know what any of this means, say N here.
+
 Network Block Device support
 CONFIG_BLK_DEV_NBD
   Saying Y here will allow your computer to be a client for network
diff -u -r linux-2.2.22/drivers/block/Config.in
linux-2.2.22c/drivers/block/Config.in
--- linux-2.2.22/drivers/block/Config.in	Fri Nov  2 08:39:06 2001
+++ linux-2.2.22c/drivers/block/Config.in	Sun Jan 18 07:30:59 2004
@@ -98,6 +98,9 @@
 comment 'Additional Block Devices'

 tristate 'Loopback device support' CONFIG_BLK_DEV_LOOP
+if [ "$CONFIG_BLK_DEV_LOOP" = "y" -o $CONFIG_BLK_DEV_LOOP = "m" ]; then
+  bool '   Enable late setting of readonly' CONFIG_LOOP_SET_RDONLY
+fi
 if [ "$CONFIG_NET" = "y" ]; then
   tristate 'Network block device support' CONFIG_BLK_DEV_NBD
 fi
diff -u -r linux-2.2.22/drivers/block/loop.c
linux-2.2.22c/drivers/block/loop.c
--- linux-2.2.22/drivers/block/loop.c	Mon Sep 16 09:26:11 2002
+++ linux-2.2.22c/drivers/block/loop.c	Sun Jan 18 07:48:09 2004
@@ -2,7 +2,7 @@
  *  linux/drivers/block/loop.c
  *
  *  Written by Theodore Ts'o, 3/29/93
- *
+ *
  * Copyright 1993 by Theodore Ts'o.  Redistribution of this file is
  * permitted under the GNU Public License.
  *
@@ -19,21 +19,21 @@
  * Loadable modules and other fixes by AK, 1998
  *
  * Make real block number available to downstream transfer functions,
enables
- * CBC (and relatives) mode encryption requiring unique IVs per data
block.
+ * CBC (and relatives) mode encryption requiring unique IVs per data
block.
  * Reed H. Petty, rhp@draper.net
- *
+ *
  * Still To Fix:
- * - Advisory locking is ignored here.
- * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
+ * - Advisory locking is ignored here.
+ * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
  * - Should use the underlying filesystems/devices read function if
possible
  *   to support read ahead (and for write)
  *
  * WARNING/FIXME:
  * - The block number as IV passing to low level transfer functions is
broken:
  *   it passes the underlying device's block number instead of the
- *   offset. This makes it change for a given block when the file is
- *   moved/restored/copied and also doesn't work over NFS.
- */
+ *   offset. This makes it change for a given block when the file is
+ *   moved/restored/copied and also doesn't work over NFS.
+ */

 #include <linux/module.h>

@@ -48,7 +48,10 @@

 #include <asm/uaccess.h>

-#include <linux/loop.h>
+#include <linux/loop.h>
+#ifdef CONFIG_LOOP_SET_RDONLY
+#include <linux/mount.h>
+#endif

 #define MAJOR_NR LOOP_MAJOR

@@ -69,7 +72,7 @@
 #define FALSE 0
 #define TRUE (!FALSE)

-/* Forward declaration of function to create missing blocks in the
+/* Forward declaration of function to create missing blocks in the
    backing file (can happen if the backing file is sparse) */
 static int create_missing_block(struct loop_device *lo, int block, int
blksize);

@@ -108,8 +111,8 @@

 static int none_status(struct loop_device *lo, struct loop_info *info)
 {
-	return 0;
-}
+	return 0;
+}

 static int xor_status(struct loop_device *lo, struct loop_info *info)
 {
@@ -118,22 +121,22 @@
 	return 0;
 }

-struct loop_func_table none_funcs = {
+struct loop_func_table none_funcs = {
 	number: LO_CRYPT_NONE,
 	transfer: transfer_none,
 	init: none_status
-};
+};

-struct loop_func_table xor_funcs = {
+struct loop_func_table xor_funcs = {
 	number: LO_CRYPT_XOR,
 	transfer: transfer_xor,
 	init: xor_status
-};
+};

-/* xfer_funcs[0] is special - its release function is never called */
+/* xfer_funcs[0] is special - its release function is never called */
 struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
 	&none_funcs,
-	&xor_funcs
+	&xor_funcs
 };

 #define MAX_DISK_SIZE 1024*1024*1024
@@ -183,7 +186,7 @@
 	}

 	dest_addr = current_request->buffer;
-
+
 	if (blksize < 512) {
 		block = current_request->sector * (512/blksize);
 		offset = 0;
@@ -327,10 +330,10 @@
 	set_fs(get_ds());

 	inode = file->f_dentry->d_inode;
-	down(&inode->i_sem);
+	down(&inode->i_sem);
 	retval = file->f_op->write(file, zero_buf, 1, &file->f_pos);
 	up(&inode->i_sem);
-
+
 	set_fs(old_fs);

 	if (retval < 0) {
@@ -376,14 +379,14 @@
 		   a file structure */
 		lo->lo_backing_file = NULL;
 	} else if (S_ISREG(inode->i_mode)) {
-		if (!inode->i_op->bmap) {
+		if (!inode->i_op->bmap) {
 			printk(KERN_ERR "loop: device has no block
access/not implemented\n");
 			goto out_putf;
 		}

 		/* Backed by a regular file - we need to hold onto
 		   a file structure for this file.  We'll use it to
-		   write to blocks that are not already present in
+		   write to blocks that are not already present in
 		   a sparse file.  We create a new file structure
 		   based on the one passed to us via 'arg'.  This is
 		   to avoid changing the file structure that the
@@ -436,13 +439,13 @@

 static int loop_release_xfer(struct loop_device *lo)
 {
-	int err = 0;
+	int err = 0;
 	if (lo->lo_encrypt_type) {
-		struct loop_func_table *xfer=
xfer_funcs[lo->lo_encrypt_type];
+		struct loop_func_table *xfer=
xfer_funcs[lo->lo_encrypt_type];
 		if (xfer && xfer->release)
-			err = xfer->release(lo);
+			err = xfer->release(lo);
 		if (xfer && xfer->unlock)
-			xfer->unlock(lo);
+			xfer->unlock(lo);
 		lo->lo_encrypt_type = 0;
 	}
 	return err;
@@ -450,19 +453,19 @@

 static int loop_init_xfer(struct loop_device *lo, int type,struct
loop_info *i)
 {
-	int err = 0;
+	int err = 0;
 	if (type) {
-		struct loop_func_table *xfer = xfer_funcs[type];
+		struct loop_func_table *xfer = xfer_funcs[type];
 		if (xfer->init)
 			err = xfer->init(lo, i);
-		if (!err) {
+		if (!err) {
 			lo->lo_encrypt_type = type;
 			if (xfer->lock)
 				xfer->lock(lo);
 		}
 	}
 	return err;
-}
+}

 static int loop_clr_fd(struct loop_device *lo, kdev_t dev)
 {
@@ -501,27 +504,27 @@

 static int loop_set_status(struct loop_device *lo, struct loop_info *arg)
 {
-	struct loop_info info;
+	struct loop_info info;
 	int err;
 	unsigned int type;

-	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid &&
+	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid &&
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (!lo->lo_dentry)
 		return -ENXIO;
 	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
-		return -EFAULT;
+		return -EFAULT;
 	if ((unsigned int) info.lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
-	type = info.lo_encrypt_type;
+	type = info.lo_encrypt_type;
 	if (type >= MAX_LO_CRYPT || xfer_funcs[type] == NULL)
 		return -EINVAL;
 	err = loop_release_xfer(lo);
-	if (!err)
+	if (!err)
 		err = loop_init_xfer(lo, type, &info);
 	if (err)
-		return err;
+		return err;

 	lo->lo_offset = info.lo_offset;
 	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
@@ -532,10 +535,10 @@
 	lo->lo_init[0] = info.lo_init[0];
 	lo->lo_init[1] = info.lo_init[1];
 	if (info.lo_encrypt_key_size) {
-		memcpy(lo->lo_encrypt_key, info.lo_encrypt_key,
+		memcpy(lo->lo_encrypt_key, info.lo_encrypt_key,
 		       info.lo_encrypt_key_size);
-		lo->lo_key_owner = current->uid;
-	}
+		lo->lo_key_owner = current->uid;
+	}
 	figure_loop_size(lo);
 	return 0;
 }
@@ -565,6 +568,43 @@
 	return copy_to_user(arg, &info, sizeof(info)) ? -EFAULT : 0;
 }

+#ifdef CONFIG_LOOP_SET_RDONLY
+static inline int is_device_open_rw(kdev_t dev, struct file *exclude)
+{
+	struct file *file;
+	struct vfsmount *mnt = lookup_vfsmnt(dev);
+	if (mnt && !(mnt->mnt_flags & MS_RDONLY))
+		return 1;
+	for (file = inuse_filps; file; file = file->f_next)
+	{
+		if (file->f_mode & FMODE_WRITE &&
+				file->f_dentry && file->f_dentry->d_inode
&&
+				file->f_dentry->d_inode->i_rdev == dev &&
+				file != exclude)
+			return 1;
+	}
+	return 0;
+}
+
+static int loop_set_ro(struct loop_device *lo, struct file *req, kdev_t
dev)
+{
+	if (current->uid != lo->lo_key_owner && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	/* Begin VFS-wide critical section */
+	if (is_device_open_rw(dev, req))
+		return -EBUSY;
+	set_device_ro(dev, 1);
+	lo->lo_flags |= LO_FLAGS_READ_ONLY;
+	/* End VFS-wide critical section */
+	if (lo->lo_backing_file)
+	{
+		lo->lo_backing_file->f_mode &= ~FMODE_WRITE;
+		put_write_access(lo->lo_backing_file->f_dentry->d_inode);
+	}
+	return 0;
+}
+#endif
+
 static int lo_ioctl(struct inode * inode, struct file * file,
 	unsigned int cmd, unsigned long arg)
 {
@@ -590,6 +630,10 @@
 		return loop_set_status(lo, (struct loop_info *) arg);
 	case LOOP_GET_STATUS:
 		return loop_get_status(lo, (struct loop_info *) arg);
+#ifdef CONFIG_LOOP_SET_RDONLY
+	case LOOP_SET_RDONLY:
+		return loop_set_ro(lo, file, inode->i_rdev);
+#endif
 	case BLKGETSIZE:   /* Return device size */
 		if (!lo->lo_dentry)
 			return -ENXIO;
@@ -620,7 +664,7 @@
 	}
 	lo = &loop_dev[dev];

-	type = lo->lo_encrypt_type;
+	type = lo->lo_encrypt_type;
 	if (type && xfer_funcs[type] && xfer_funcs[type]->lock)
 		xfer_funcs[type]->lock(lo);
 	lo->lo_refcnt++;
@@ -681,31 +725,31 @@
 	if ((unsigned)funcs->number > MAX_LO_CRYPT ||
xfer_funcs[funcs->number])
 		return -EINVAL;
 	xfer_funcs[funcs->number] = funcs;
-	return 0;
+	return 0;
 }

 int loop_unregister_transfer(int number)
 {
-	struct loop_device *lo;
+	struct loop_device *lo;

 	if ((unsigned)number >= MAX_LO_CRYPT)
-		return -EINVAL;
-	for (lo = &loop_dev[0]; lo < &loop_dev[MAX_LOOP]; lo++) {
+		return -EINVAL;
+	for (lo = &loop_dev[0]; lo < &loop_dev[MAX_LOOP]; lo++) {
 		int type = lo->lo_encrypt_type;
-		if (type == number) {
+		if (type == number) {
 			xfer_funcs[type]->release(lo);
-			lo->transfer = NULL;
-			lo->lo_encrypt_type = 0;
+			lo->transfer = NULL;
+			lo->lo_encrypt_type = 0;
 		}
 	}
-	xfer_funcs[number] = NULL;
-	return 0;
+	xfer_funcs[number] = NULL;
+	return 0;
 }

 EXPORT_SYMBOL(loop_register_transfer);
 EXPORT_SYMBOL(loop_unregister_transfer);

-int __init loop_init(void)
+int __init loop_init(void)
 {
 	int	i;

@@ -732,7 +776,7 @@
 }

 #ifdef MODULE
-void cleanup_module(void)
+void cleanup_module(void)
 {
 	if (unregister_blkdev(MAJOR_NR, "loop") != 0)
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
diff -u -r linux-2.2.22/include/linux/loop.h
linux-2.2.22c/include/linux/loop.h
--- linux-2.2.22/include/linux/loop.h	Sat Sep 21 05:13:19 2002
+++ linux-2.2.22c/include/linux/loop.h	Sun Jan 18 08:23:00 2004
@@ -16,7 +16,7 @@
 #define LO_KEY_SIZE	32

 #ifdef __KERNEL__
-
+
 struct loop_device {
 	int		lo_number;
 	struct dentry	*lo_dentry;
@@ -33,11 +33,11 @@
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	__u32           lo_init[2];
 	uid_t		lo_key_owner;	/* Who set the key */
-	int		(*ioctl)(struct loop_device *, int cmd,
-				 unsigned long arg);
+	int		(*ioctl)(struct loop_device *, int cmd,
+				 unsigned long arg);

 	struct file *	lo_backing_file;
-	void		*key_data;
+	void		*key_data;
 	char		key_reserved[48]; /* for use by the filter modules
*/
 };

@@ -53,19 +53,19 @@
 #define LO_FLAGS_DO_BMAP	0x00000001
 #define LO_FLAGS_READ_ONLY	0x00000002

-/*
+/*
  * Note that this structure gets the wrong offsets when directly used
  * from a glibc program, because glibc has a 32bit dev_t.
- * Prevent people from shooting in their own foot.
+ * Prevent people from shooting in their own foot.
  */
 #if __GLIBC__ >= 2 && !defined(dev_t)
 #error "Wrong dev_t in loop.h"
-#endif
+#endif

 /*
  *	This uses kdev_t because glibc currently has no appropiate
- *	conversion version for the loop ioctls.
- * 	The situation is very unpleasant
+ *	conversion version for the loop ioctls.
+ * 	The situation is very unpleasant
  */

 struct loop_info {
@@ -101,21 +101,21 @@
 #ifdef __KERNEL__
 /* Support for loadable transfer modules */
 struct loop_func_table {
-	int number; 	/* filter type */
-	int (*transfer)(struct loop_device *lo, int cmd,
+	int number; 	/* filter type */
+	int (*transfer)(struct loop_device *lo, int cmd,
 			char *raw_buf, char *loop_buf, int size,
 			int real_block);
-	int (*init)(struct loop_device *, struct loop_info *);
+	int (*init)(struct loop_device *, struct loop_info *);
 	/* release is called from loop_unregister_transfer or clr_fd */
-	int (*release)(struct loop_device *);
+	int (*release)(struct loop_device *);
 	int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
-	/* lock and unlock manage the module use counts */
+	/* lock and unlock manage the module use counts */
 	void (*lock)(struct loop_device *);
 	void (*unlock)(struct loop_device *);
-};
+};

 int  loop_register_transfer(struct loop_func_table *funcs);
-int loop_unregister_transfer(int number);
+int loop_unregister_transfer(int number);

 #endif
 /*
@@ -126,5 +126,6 @@
 #define LOOP_CLR_FD	0x4C01
 #define LOOP_SET_STATUS	0x4C02
 #define LOOP_GET_STATUS	0x4C03
+#define LOOP_SET_RDONLY 0x4C04

 #endif


