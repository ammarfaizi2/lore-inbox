Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVKEQim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVKEQim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVKEQeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:44780 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932100AbVKEQda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:30 -0500
Message-Id: <20051105162718.128174000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:08 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, axboe@suse.de,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 18/25] raw: move ioctl32 code to raw.c
Content-Disposition: inline; filename=raw-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two ioctl commands for the raw driver are not used
anywhere outside of raw.c, so move the compat handler
there as well.

Since they were previously registered both as compatible
and with a conversion handler, it is not clear if this
ever worked before.

Forwarding ioctl commands to the underlying block device
needs adaptations here as well because of the earlier
block device compat ioctl patch.

CC: axboe@suse.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/drivers/char/raw.c
===================================================================
--- linux-cg.orig/drivers/char/raw.c	2005-11-05 14:19:13.000000000 +0100
+++ linux-cg/drivers/char/raw.c	2005-11-05 14:22:34.000000000 +0100
@@ -8,6 +8,8 @@
  * device are used to bind the other minor numbers to block devices.
  */
 
+#include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/devfs_fs_kernel.h>
@@ -125,6 +127,16 @@
 	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
 }
 
+#ifdef CONFIG_COMPAT
+static long
+raw_compat_ioctl(struct file *filp, unsigned int command, unsigned long arg)
+{
+	struct block_device *bdev = filp->private_data;
+
+	return compat_blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
+}
+#endif
+
 static void bind_device(struct raw_config_request *rq)
 {
 	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
@@ -238,6 +250,79 @@
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+/* Raw devices */
+struct raw32_config_request {
+	compat_int_t raw_minor;
+	__u64 block_major;
+	__u64 block_minor;
+} __attribute__ ((packed));
+
+static int get_raw32_request(struct raw_config_request *req,
+			     struct raw32_config_request __user * user_req)
+{
+	int ret;
+
+	if (!access_ok
+	    (VERIFY_READ, user_req, sizeof(struct raw32_config_request)))
+		return -EFAULT;
+
+	ret = __get_user(req->raw_minor, &user_req->raw_minor);
+	ret |= __get_user(req->block_major, &user_req->block_major);
+	ret |= __get_user(req->block_minor, &user_req->block_minor);
+
+	return ret ? -EFAULT : 0;
+}
+
+static int set_raw32_request(struct raw_config_request *req,
+			     struct raw32_config_request __user * user_req)
+{
+	int ret;
+
+	if (!access_ok
+	    (VERIFY_WRITE, user_req, sizeof(struct raw32_config_request)))
+		return -EFAULT;
+
+	ret = __put_user(req->raw_minor, &user_req->raw_minor);
+	ret |= __put_user(req->block_major, &user_req->block_major);
+	ret |= __put_user(req->block_minor, &user_req->block_minor);
+
+	return ret ? -EFAULT : 0;
+}
+
+static long raw_ctl_compat_ioctl(struct file *file, unsigned cmd,
+						unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+
+	switch (cmd) {
+	case RAW_SETBIND:
+	case RAW_GETBIND:{
+			struct raw_config_request req;
+			struct raw32_config_request __user *user_req =
+			    compat_ptr(arg);
+			mm_segment_t oldfs = get_fs();
+
+			if ((ret = get_raw32_request(&req, user_req)))
+				return ret;
+
+			set_fs(KERNEL_DS);
+			lock_kernel();
+			ret = raw_ctl_ioctl(file->f_dentry->d_inode, file,
+						cmd, (unsigned long) &req);
+			unlock_kernel();
+			set_fs(oldfs);
+
+			if ((!ret) && (cmd == RAW_GETBIND)) {
+				ret = set_raw32_request(&req, user_req);
+			}
+			break;
+		}
+	}
+	return ret;
+}
+#endif
+
 static ssize_t raw_file_write(struct file *file, const char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -269,6 +354,9 @@
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =	raw_compat_ioctl,
+#endif
 	.readv	= 	generic_file_readv,
 	.writev	= 	generic_file_writev,
 	.owner	=	THIS_MODULE,
@@ -276,6 +364,9 @@
 
 static struct file_operations raw_ctl_fops = {
 	.ioctl	=	raw_ctl_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = raw_ctl_compat_ioctl,
+#endif
 	.open	=	raw_open,
 	.owner	=	THIS_MODULE,
 };
Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 14:22:34.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 15:46:57.000000000 +0100
@@ -366,71 +366,6 @@
         return sys_ioctl(fd,cmd,ptr);
 }
 
-struct raw32_config_request
-{
-        compat_int_t    raw_minor;
-        __u64   block_major;
-        __u64   block_minor;
-} __attribute__((packed));
-
-static int get_raw32_request(struct raw_config_request *req, struct raw32_config_request __user *user_req)
-{
-        int ret;
-
-        if (!access_ok(VERIFY_READ, user_req, sizeof(struct raw32_config_request)))
-                return -EFAULT;
-
-        ret = __get_user(req->raw_minor, &user_req->raw_minor);
-        ret |= __get_user(req->block_major, &user_req->block_major);
-        ret |= __get_user(req->block_minor, &user_req->block_minor);
-
-        return ret ? -EFAULT : 0;
-}
-
-static int set_raw32_request(struct raw_config_request *req, struct raw32_config_request __user *user_req)
-{
-	int ret;
-
-        if (!access_ok(VERIFY_WRITE, user_req, sizeof(struct raw32_config_request)))
-                return -EFAULT;
-
-        ret = __put_user(req->raw_minor, &user_req->raw_minor);
-        ret |= __put_user(req->block_major, &user_req->block_major);
-        ret |= __put_user(req->block_minor, &user_req->block_minor);
-
-        return ret ? -EFAULT : 0;
-}
-
-static int raw_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
-{
-        int ret;
-
-        switch (cmd) {
-        case RAW_SETBIND:
-        case RAW_GETBIND: {
-                struct raw_config_request req;
-                struct raw32_config_request __user *user_req = compat_ptr(arg);
-                mm_segment_t oldfs = get_fs();
-
-                if ((ret = get_raw32_request(&req, user_req)))
-                        return ret;
-
-                set_fs(KERNEL_DS);
-                ret = sys_ioctl(fd,cmd,(unsigned long)&req);
-                set_fs(oldfs);
-
-                if ((!ret) && (cmd == RAW_GETBIND)) {
-                        ret = set_raw32_request(&req, user_req);
-                }
-                break;
-        }
-        default:
-                ret = sys_ioctl(fd, cmd, arg);
-                break;
-        }
-        return ret;
-}
-
 struct serial_struct32 {
         compat_int_t    type;
         compat_int_t    line;
@@ -682,9 +617,6 @@
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
 HANDLE_IOCTL(REISERFS_IOC_UNPACK32, reiserfs_ioctl32)
-/* Raw devices */
-HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
-HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
 /* Serial */
 HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
 HANDLE_IOCTL(TIOCSSERIAL, serial_struct_ioctl)
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 14:22:34.000000000 +0100
+++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 15:46:57.000000000 +0100
@@ -365,9 +365,6 @@
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
 COMPATIBLE_IOCTL(DEVFSDIOC_RELEASE_EVENT_QUEUE)
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_DEBUG_MASK)
-/* Raw devices */
-COMPATIBLE_IOCTL(RAW_SETBIND)
-COMPATIBLE_IOCTL(RAW_GETBIND)
 /* Little a */
 COMPATIBLE_IOCTL(ATMSIGD_CTRL)
 COMPATIBLE_IOCTL(ATMARPD_CTRL)
Index: linux-cg/include/linux/fs.h
===================================================================
--- linux-cg.orig/include/linux/fs.h	2005-11-05 14:19:13.000000000 +0100
+++ linux-cg/include/linux/fs.h	2005-11-05 14:22:34.000000000 +0100
@@ -1321,7 +1321,8 @@
 extern struct file_operations def_fifo_fops;
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct inode *, struct file *, unsigned, unsigned long);
-extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
+extern long compat_blkdev_ioctl(struct inode *,struct file *,
+				unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
Index: linux-cg/drivers/block/ioctl.c
===================================================================
--- linux-cg.orig/drivers/block/ioctl.c	2005-11-05 14:22:34.000000000 +0100
+++ linux-cg/drivers/block/ioctl.c	2005-11-05 15:46:12.000000000 +0100
@@ -259,6 +259,7 @@
 
 	return blkdev_driver_ioctl(inode, file, disk, cmd, arg);
 }
+EXPORT_SYMBOL_GPL(blkdev_ioctl);
 
 #ifdef CONFIG_COMPAT
 static int w_long(struct inode *inode, struct file *file,
@@ -695,11 +696,10 @@
 /* Most of the generic ioctls are handled in the normal fallback path.
    This assumes the blkdev's low level compat_ioctl always returns
    ENOIOCTLCMD for unknown ioctls. */
-long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+long compat_blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd, unsigned long arg)
 {
-	struct block_device *bdev = file->f_dentry->d_inode->i_bdev;
+	struct block_device *bdev = inode->i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
-	struct inode *inode = file->f_mapping->host;
 	int ret = -ENOIOCTLCMD;
 
 	switch (cmd) {
@@ -808,6 +808,5 @@
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(compat_blkdev_ioctl);
 #endif
-
-EXPORT_SYMBOL_GPL(blkdev_ioctl);
Index: linux-cg/fs/block_dev.c
===================================================================
--- linux-cg.orig/fs/block_dev.c	2005-11-05 14:22:31.000000000 +0100
+++ linux-cg/fs/block_dev.c	2005-11-05 14:24:35.000000000 +0100
@@ -782,6 +782,14 @@
 	return blkdev_ioctl(file->f_mapping->host, file, cmd, arg);
 }
 
+#ifdef CONFIG_COMPAT
+static long block_compat_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	return compat_blkdev_ioctl(file->f_mapping->host, file, cmd, arg);
+}
+#endif
+
 struct address_space_operations def_blk_aops = {
 	.readpage	= blkdev_readpage,
 	.writepage	= blkdev_writepage,
@@ -804,7 +812,7 @@
 	.fsync		= block_fsync,
 	.unlocked_ioctl	= block_ioctl,
 #ifdef CONFIG_COMPAT
-	.compat_ioctl	= compat_blkdev_ioctl,
+	.compat_ioctl	= block_compat_ioctl,
 #endif
 	.readv		= generic_file_readv,
 	.writev		= generic_file_write_nolock,

--

