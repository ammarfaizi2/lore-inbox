Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbUAREDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 23:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUAREDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 23:03:36 -0500
Received: from law10-f20.law10.hotmail.com ([64.4.15.20]:2309 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265648AbUAREC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 23:02:57 -0500
X-Originating-IP: [207.104.37.19]
X-Originating-Email: [joshudson@hotmail.com]
From: "Joshua Hudson" <joshudson@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: joshudson@hotmail.com
Subject: Patch for 2.2 loop driver & loop root filesystem
Date: Sat, 17 Jan 2004 20:02:55 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F20imD3JkUwWp00029bbe@hotmail.com>
X-OriginalArrivalTime: 18 Jan 2004 04:02:55.0980 (UTC) FILETIME=[F3EDCAC0:01C3DD77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote this patch for the linux 2.2.22 kernel, although I will be replacing 
it in about ten days
with 2.2.25 or so. There is a little problem with loopback installations
that I discovered, in that it is impossible to unmount the host partition or 
even mount it
readonly. This patch makes it possible to mount it readonly. I have also 
included a little utility
that demonstrates the new functionality. Enjoy.

Oh, I'm not on the list, so cc any followups to me.


!-! Start of utility

/* loopro.c - JH
*
*/

/* Can't include gclibc defs. Oh bother. */
#include <linux/types.h>
#include <linux/loop.h>
#define O_RDWR 2

#ifndef LO_CRYPT_KEEP
#define LO_CRYPT_KEEP 127 /* So that we don't depend on the newest k header. 
*/
#endif

char usage[] = "Sets a loop device to readonly\nUsage: loopro device\n";
char cantdev[] = "loopro: Can't open device\n";
char notloop[] = "loopro: ioctl failed. Not a loop device?\n";
char notsup[] = "loopro: your kernel doesn't support this.\n";

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
		write(2, cantdev, sizeof(cantdev) - 1);
		return 1;
	}
	if (0 > ioctl(fd, LOOP_GET_STATUS, (char *)&inf))
	{
		write(2, notloop, sizeof(notloop) - 1);
		return 1;
	}
	inf.lo_encrypt_type = LO_CRYPT_KEEP;
	inf.lo_flags |= LO_FLAGS_READ_ONLY;
	if (0 > ioctl(fd, LOOP_SET_STATUS, (char *)&inf))
	{
		write(2, notsup, sizeof(notsup) - 1);
		return 1;
	}
	return 0;
}


!-! Start of patch
diff -u -r linux-2.2.22/Documentation/Configure.help 
linux-2.2.22c/Documentation/Configure.help
--- linux-2.2.22/Documentation/Configure.help	Mon Sep 16 09:26:11 2002
+++ linux-2.2.22c/Documentation/Configure.help	Sat Jan 17 11:00:40 2004
@@ -262,6 +262,16 @@

   Most users will answer N here.

+Enable late setting of readonly
+CONFIG_LOOP_SET_RO
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
+++ linux-2.2.22c/drivers/block/Config.in	Sat Jan 17 09:08:29 2004
@@ -98,6 +98,9 @@
comment 'Additional Block Devices'

tristate 'Loopback device support' CONFIG_BLK_DEV_LOOP
+if [ "$CONFIG_BLK_DEV_LOOP" = "y" -o $CONFIG_BLK_DEV_LOOP = "m" ]; then
+  bool '   Enable late setting of readonly' CONFIG_LOOP_SET_RO
+fi
if [ "$CONFIG_NET" = "y" ]; then
   tristate 'Network block device support' CONFIG_BLK_DEV_NBD
fi
diff -u -r linux-2.2.22/drivers/block/loop.c 
linux-2.2.22c/drivers/block/loop.c
--- linux-2.2.22/drivers/block/loop.c	Mon Sep 16 09:26:11 2002
+++ linux-2.2.22c/drivers/block/loop.c	Sat Jan 17 09:21:35 2004
@@ -49,6 +49,7 @@
#include <asm/uaccess.h>

#include <linux/loop.h>
+#include <linux/smp_lock.h>

#define MAJOR_NR LOOP_MAJOR

@@ -499,7 +500,12 @@
	return 0;
}

+#ifdef CONFIG_LOOP_SET_RO
+static int loop_set_status(struct loop_device *lo, struct loop_info *arg,
+		kdev_t dev)
+#else
static int loop_set_status(struct loop_device *lo, struct loop_info *arg)
+#endif
{
	struct loop_info info;
	int err;
@@ -514,28 +520,66 @@
		return -EFAULT;
	if ((unsigned int) info.lo_encrypt_key_size > LO_KEY_SIZE)
		return -EINVAL;
-	type = info.lo_encrypt_type;
-	if (type >= MAX_LO_CRYPT || xfer_funcs[type] == NULL)
-		return -EINVAL;
-	err = loop_release_xfer(lo);
-	if (!err)
-		err = loop_init_xfer(lo, type, &info);
-	if (err)
-		return err;
+	type = info.lo_encrypt_type;
+#ifdef CONFIG_LOOP_SET_RO
+	if (info.lo_flags & LO_FLAGS_READ_ONLY &&
+			!(lo->lo_flags & LO_FLAGS_READ_ONLY))
+	{
+		/* The user is trying to turn on readonly. */
+		/* There appears to be no way to verify if activating
+		 * readonly is safe. The kernel is sloppy and does not
+		 * remove the write flag when remounting readonly. So,
+		 * be warned that setting readonly when the device is
+		 * mounted readwrite will corrupt your data. */
+
+		lock_kernel();
+		fsync_dev(0);	/* Prevent the worst of the damage. */
+		set_device_ro(dev, 1);
+		lo->lo_flags |= LO_FLAGS_READ_ONLY;
+		unlock_kernel();
+		/* Now reopen the backing file ro */
+		if (lo->lo_backing_file)
+		{
+			lo->lo_backing_file->f_mode ^= FMODE_WRITE;
+			put_write_access(lo->lo_backing_file->f_dentry->d_inode
+					);
+		}
+	}

+	if (type != LO_CRYPT_KEEP)
+	{	/* Changing encryption */
+#endif
+		if (type >= MAX_LO_CRYPT || xfer_funcs[type] == NULL)
+			return -EINVAL;
+
+		err = loop_release_xfer(lo);
+		if (!err)
+			err = loop_init_xfer(lo, type, &info);
+		if (err)
+			return err;
+#ifdef CONFIG_LOOP_SET_RO
+	}
+#endif
	lo->lo_offset = info.lo_offset;
	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);

-	lo->transfer = xfer_funcs[type]->transfer;
-	lo->ioctl = xfer_funcs[type]->ioctl;
-	lo->lo_encrypt_key_size = info.lo_encrypt_key_size;
-	lo->lo_init[0] = info.lo_init[0];
-	lo->lo_init[1] = info.lo_init[1];
-	if (info.lo_encrypt_key_size) {
-		memcpy(lo->lo_encrypt_key, info.lo_encrypt_key,
-		       info.lo_encrypt_key_size);
-		lo->lo_key_owner = current->uid;
-	}
+#ifdef CONFIG_LOOP_SET_RO
+	if (type != LO_CRYPT_KEEP)
+	{
+#endif
+		lo->transfer = xfer_funcs[type]->transfer;
+		lo->ioctl = xfer_funcs[type]->ioctl;
+		lo->lo_encrypt_key_size = info.lo_encrypt_key_size;
+		lo->lo_init[0] = info.lo_init[0];
+		lo->lo_init[1] = info.lo_init[1];
+		if (info.lo_encrypt_key_size) {
+			memcpy(lo->lo_encrypt_key, info.lo_encrypt_key,
+				info.lo_encrypt_key_size);
+			lo->lo_key_owner = current->uid;
+		}
+#ifdef CONFIG_LOOP_SET_RO
+	}
+#endif
	figure_loop_size(lo);
	return 0;
}
@@ -587,7 +631,12 @@
	case LOOP_CLR_FD:
		return loop_clr_fd(lo, inode->i_rdev);
	case LOOP_SET_STATUS:
+#ifdef CONFIG_LOOP_SET_RO
+		return loop_set_status(lo, (struct loop_info *) arg,
+				inode->i_rdev);
+#else
		return loop_set_status(lo, (struct loop_info *) arg);
+#endif
	case LOOP_GET_STATUS:
		return loop_get_status(lo, (struct loop_info *) arg);
	case BLKGETSIZE:   /* Return device size */
diff -u -r linux-2.2.22/include/linux/loop.h 
linux-2.2.22c/include/linux/loop.h
--- linux-2.2.22/include/linux/loop.h	Sat Sep 21 05:13:19 2002
+++ linux-2.2.22c/include/linux/loop.h	Sat Jan 17 07:42:33 2004
@@ -97,6 +97,7 @@
#define LO_CRYPT_DUMMY    9
#define LO_CRYPT_SKIPJACK 10
#define MAX_LO_CRYPT	20
+#define LO_CRYPT_KEEP 127 /* Changing something besides encryption (!)*/

#ifdef __KERNEL__
/* Support for loadable transfer modules */

_________________________________________________________________
Let the new MSN Premium Internet Software make the most of your high-speed 
experience. http://join.msn.com/?pgmarket=en-us&page=byoa/prem&ST=1

