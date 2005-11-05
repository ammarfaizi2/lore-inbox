Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVKEQdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVKEQdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVKEQd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:33:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:39877 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751254AbVKEQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:26 -0500
Message-Id: <20051105162715.758021000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:03 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, axboe@suse.de,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 13/25] loop: move ioctl32 code to loop.c
Content-Disposition: inline; filename=loop-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The loop device driver is the only user of its ioctl
commands, so we can move the conversion handlers
for 32 bit emulation into the driver itself.

This patch just moves over the function, it would
probably be a good idea to get rid of get_fs/set_fs
calls here by integrating better with the driver.

CC: axboe@suse.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/drivers/block/loop.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/block/loop.c	2005-11-05 02:38:14.000000000 +0100
+++ linux-2.6.14-rc/drivers/block/loop.c	2005-11-05 02:41:39.000000000 +0100
@@ -51,6 +51,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
@@ -1164,6 +1165,78 @@
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+struct loop_info32 {
+	compat_int_t	lo_number;      /* ioctl r/o */
+	compat_dev_t	lo_device;      /* ioctl r/o */
+	compat_ulong_t	lo_inode;       /* ioctl r/o */
+	compat_dev_t	lo_rdevice;     /* ioctl r/o */
+	compat_int_t	lo_offset;
+	compat_int_t	lo_encrypt_type;
+	compat_int_t	lo_encrypt_key_size;    /* ioctl w/o */
+	compat_int_t	lo_flags;       /* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	compat_ulong_t	lo_init[2];
+	char		reserved[4];
+};
+
+static long lo_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	mm_segment_t old_fs = get_fs();
+	struct loop_info l;
+	struct loop_info32 __user *ul;
+	int err = -ENOIOCTLCMD;
+
+	ul = compat_ptr(arg);
+
+	lock_kernel();
+	switch(cmd) {
+	case LOOP_SET_STATUS:
+		err = get_user(l.lo_number, &ul->lo_number);
+		err |= __get_user(l.lo_device, &ul->lo_device);
+		err |= __get_user(l.lo_inode, &ul->lo_inode);
+		err |= __get_user(l.lo_rdevice, &ul->lo_rdevice);
+		err |= __copy_from_user(&l.lo_offset, &ul->lo_offset,
+		        8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+		if (err) {
+			err = -EFAULT;
+		} else {
+			set_fs (KERNEL_DS);
+			err = lo_ioctl(inode, file, cmd, (unsigned long)&l);
+			set_fs (old_fs);
+		}
+		break;
+	case LOOP_GET_STATUS:
+		set_fs (KERNEL_DS);
+		err = lo_ioctl(inode, file, cmd, (unsigned long)&l);
+		set_fs (old_fs);
+		if (!err) {
+			err = put_user(l.lo_number, &ul->lo_number);
+			err |= __put_user(l.lo_device, &ul->lo_device);
+			err |= __put_user(l.lo_inode, &ul->lo_inode);
+			err |= __put_user(l.lo_rdevice, &ul->lo_rdevice);
+			err |= __copy_to_user(&ul->lo_offset, &l.lo_offset,
+				(unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+			if (err)
+				err = -EFAULT;
+		}
+		break;
+	case LOOP_CLR_FD:
+	case LOOP_GET_STATUS64:
+	case LOOP_SET_STATUS64:
+		arg = (unsigned long) compat_ptr(arg);
+	case LOOP_SET_FD:
+	case LOOP_CHANGE_FD:
+		err = lo_ioctl(inode, file, cmd, arg);
+		break;
+	}
+	unlock_kernel();
+	return err;
+}
+#endif
+
 static int lo_open(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
@@ -1191,6 +1264,9 @@
 	.open =		lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =	lo_compat_ioctl,
+#endif
 };
 
 /*
Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-05 02:41:38.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-05 02:41:39.000000000 +0100
@@ -331,71 +331,6 @@
 	return err;
 }
 
-struct loop_info32 {
-	compat_int_t	lo_number;      /* ioctl r/o */
-	compat_dev_t	lo_device;      /* ioctl r/o */
-	compat_ulong_t	lo_inode;       /* ioctl r/o */
-	compat_dev_t	lo_rdevice;     /* ioctl r/o */
-	compat_int_t	lo_offset;
-	compat_int_t	lo_encrypt_type;
-	compat_int_t	lo_encrypt_key_size;    /* ioctl w/o */
-	compat_int_t	lo_flags;       /* ioctl r/o */
-	char		lo_name[LO_NAME_SIZE];
-	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
-	compat_ulong_t	lo_init[2];
-	char		reserved[4];
-};
-
-static int loop_status(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	struct loop_info l;
-	struct loop_info32 __user *ul;
-	int err = -EINVAL;
-
-	ul = compat_ptr(arg);
-	switch(cmd) {
-	case LOOP_SET_STATUS:
-		err = get_user(l.lo_number, &ul->lo_number);
-		err |= __get_user(l.lo_device, &ul->lo_device);
-		err |= __get_user(l.lo_inode, &ul->lo_inode);
-		err |= __get_user(l.lo_rdevice, &ul->lo_rdevice);
-		err |= __copy_from_user(&l.lo_offset, &ul->lo_offset,
-		        8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
-		if (err) {
-			err = -EFAULT;
-		} else {
-			set_fs (KERNEL_DS);
-			err = sys_ioctl (fd, cmd, (unsigned long)&l);
-			set_fs (old_fs);
-		}
-		break;
-	case LOOP_GET_STATUS:
-		set_fs (KERNEL_DS);
-		err = sys_ioctl (fd, cmd, (unsigned long)&l);
-		set_fs (old_fs);
-		if (!err) {
-			err = put_user(l.lo_number, &ul->lo_number);
-			err |= __put_user(l.lo_device, &ul->lo_device);
-			err |= __put_user(l.lo_inode, &ul->lo_inode);
-			err |= __put_user(l.lo_rdevice, &ul->lo_rdevice);
-			err |= __copy_to_user(&ul->lo_offset, &l.lo_offset,
-				(unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
-			if (err)
-				err = -EFAULT;
-		}
-		break;
-	default: {
-		static int count;
-		if (++count <= 20)
-			printk("%s: Unknown loop ioctl cmd, fd(%d) "
-			       "cmd(%08x) arg(%08lx)\n",
-			       __FUNCTION__, fd, cmd, arg);
-	}
-	}
-	return err;
-}
-
 static int do_smb_getmountuid(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -1001,8 +936,6 @@
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
-HANDLE_IOCTL(LOOP_SET_STATUS, loop_status)
-HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
 /* One SMB ioctl needs translations. */
Index: linux-2.6.14-rc/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/compat_ioctl.h	2005-11-05 02:41:37.000000000 +0100
+++ linux-2.6.14-rc/include/linux/compat_ioctl.h	2005-11-05 02:41:39.000000000 +0100
@@ -204,12 +204,6 @@
 COMPATIBLE_IOCTL(DVD_AUTH)
 /* pktcdvd */
 COMPATIBLE_IOCTL(PACKET_CTRL_CMD)
-/* Big L */
-ULONG_IOCTL(LOOP_SET_FD)
-ULONG_IOCTL(LOOP_CHANGE_FD)
-COMPATIBLE_IOCTL(LOOP_CLR_FD)
-COMPATIBLE_IOCTL(LOOP_GET_STATUS64)
-COMPATIBLE_IOCTL(LOOP_SET_STATUS64)
 /* Big A */
 /* sparc only */
 /* Big Q for sound/OSS */

--

