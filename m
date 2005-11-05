Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVKEQhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVKEQhI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVKEQeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:33475 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751273AbVKEQd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:27 -0500
Message-Id: <20051105162717.628382000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:07 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hirofumi@mail.parknet.co.jp,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 17/25] vfat: move ioctl32 code to fs/fat/dir.c
Content-Disposition: inline; filename=vfat-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vfat compat ioctls are clearly local to a single file
system, so the code can better be part of that file system.

This can be further improved in the future by getting rid
of get_fs/set_fs calls.

CC: hirofumi@mail.parknet.co.jp
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-05 02:41:42.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-05 02:41:43.000000000 +0100
@@ -356,51 +356,6 @@
 #define HIDPGETCONNLIST	_IOR('H', 210, int)
 #define HIDPGETCONNINFO	_IOR('H', 211, int)
 
-#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
-#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
-
-static long
-put_dirent32 (struct dirent *d, struct compat_dirent __user *d32)
-{
-        if (!access_ok(VERIFY_WRITE, d32, sizeof(struct compat_dirent)))
-                return -EFAULT;
-
-        __put_user(d->d_ino, &d32->d_ino);
-        __put_user(d->d_off, &d32->d_off);
-        __put_user(d->d_reclen, &d32->d_reclen);
-        if (__copy_to_user(d32->d_name, d->d_name, d->d_reclen))
-		return -EFAULT;
-
-        return 0;
-}
-
-static int vfat_ioctl32(unsigned fd, unsigned cmd, unsigned long arg)
-{
-	struct compat_dirent __user *p = compat_ptr(arg);
-	int ret;
-	mm_segment_t oldfs = get_fs();
-	struct dirent d[2];
-
-	switch(cmd)
-	{
-        	case VFAT_IOCTL_READDIR_BOTH32:
-                	cmd = VFAT_IOCTL_READDIR_BOTH;
-                	break;
-        	case VFAT_IOCTL_READDIR_SHORT32:
-                	cmd = VFAT_IOCTL_READDIR_SHORT;
-                	break;
-	}
-
-	set_fs(KERNEL_DS);
-	ret = sys_ioctl(fd,cmd,(unsigned long)&d);
-	set_fs(oldfs);
-	if (ret >= 0) {
-		ret |= put_dirent32(&d[0], p);
-		ret |= put_dirent32(&d[1], p + 1);
-	}
-	return ret;
-}
-
 #define REISERFS_IOC_UNPACK32               _IOW(0xCD,1,int)
 
 static int reiserfs_ioctl32(unsigned fd, unsigned cmd, unsigned long ptr)
@@ -726,9 +681,6 @@
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
-/* vfat */
-HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
-HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
 HANDLE_IOCTL(REISERFS_IOC_UNPACK32, reiserfs_ioctl32)
 /* Raw devices */
 HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
Index: linux-2.6.14-rc/fs/fat/dir.c
===================================================================
--- linux-2.6.14-rc.orig/fs/fat/dir.c	2005-11-05 02:09:06.000000000 +0100
+++ linux-2.6.14-rc/fs/fat/dir.c	2005-11-05 02:41:43.000000000 +0100
@@ -13,6 +13,8 @@
  *  Short name translation 1999, 2001 by Wolfram Pienkoss <wp@bszh.de>
  */
 
+#include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/time.h>
@@ -769,10 +771,62 @@
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+/* vfat */
+#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
+#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
+
+static long
+put_dirent32(struct dirent *d, struct compat_dirent __user * d32)
+{
+	if (!access_ok(VERIFY_WRITE, d32, sizeof(struct compat_dirent)))
+		return -EFAULT;
+
+	__put_user(d->d_ino, &d32->d_ino);
+	__put_user(d->d_off, &d32->d_off);
+	__put_user(d->d_reclen, &d32->d_reclen);
+	if (__copy_to_user(d32->d_name, d->d_name, d->d_reclen))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long fat_dir_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct compat_dirent __user *p = compat_ptr(arg);
+	int ret;
+	mm_segment_t oldfs = get_fs();
+	struct dirent d[2];
+
+	switch (cmd) {
+	case VFAT_IOCTL_READDIR_BOTH32:
+		cmd = VFAT_IOCTL_READDIR_BOTH;
+		break;
+	case VFAT_IOCTL_READDIR_SHORT32:
+		cmd = VFAT_IOCTL_READDIR_SHORT;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	set_fs(KERNEL_DS);
+	ret = fat_dir_ioctl(file->f_dentry->d_inode, file, cmd, (unsigned long) &d);
+	set_fs(oldfs);
+	if (ret >= 0) {
+		ret |= put_dirent32(&d[0], p);
+		ret |= put_dirent32(&d[1], p + 1);
+	}
+	return ret;
+}
+#endif
+
 struct file_operations fat_dir_operations = {
 	.read		= generic_read_dir,
 	.readdir	= fat_readdir,
 	.ioctl		= fat_dir_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= fat_dir_compat_ioctl,
+#endif
 	.fsync		= file_fsync,
 };
 

--

