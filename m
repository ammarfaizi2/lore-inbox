Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422854AbWHYTh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422854AbWHYTh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422850AbWHYTh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:37:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52367 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422849AbWHYThl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:37:41 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/18] [PATCH] BLOCK: Move the msdos device ioctl compat stuff to the msdos driver [try #4]
Date: Fri, 25 Aug 2006 20:37:33 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825193733.11384.69401.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move the msdos device ioctl compat stuff from fs/compat_ioctl.c to the msdos
driver so that the msdos header file doesn't need to be included.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/compat_ioctl.c |   49 ------------------------------------------------
 fs/fat/dir.c      |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e5eb0f1..e1a5643 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -108,7 +108,6 @@ #include <linux/usbdevice_fs.h>
 #include <linux/nbd.h>
 #include <linux/random.h>
 #include <linux/filter.h>
-#include <linux/msdos_fs.h>
 #include <linux/pktcdvd.h>
 
 #include <linux/hiddev.h>
@@ -1937,51 +1936,6 @@ static int mtd_rw_oob(unsigned int fd, u
 	return err;
 }	
 
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
 struct raw32_config_request
 {
         compat_int_t    raw_minor;
@@ -2726,9 +2680,6 @@ HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_io
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
-/* vfat */
-HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
-HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
 /* Raw devices */
 HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
 HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 698b85b..8e99330 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -20,6 +20,7 @@ #include <linux/msdos_fs.h>
 #include <linux/dirent.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/compat.h>
 #include <asm/uaccess.h>
 
 static inline loff_t fat_make_i_pos(struct super_block *sb,
@@ -740,11 +741,64 @@ static int fat_dir_ioctl(struct inode * 
 		ret = buf.result;
 	return ret;
 }
+#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
+#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
+
+static long fat_compat_put_dirent32(struct dirent *d,
+				    struct compat_dirent __user *d32)
+{
+        if (!access_ok(VERIFY_WRITE, d32, sizeof(struct compat_dirent)))
+                return -EFAULT;
+
+        __put_user(d->d_ino, &d32->d_ino);
+        __put_user(d->d_off, &d32->d_off);
+        __put_user(d->d_reclen, &d32->d_reclen);
+        if (__copy_to_user(d32->d_name, d->d_name, d->d_reclen))
+		return -EFAULT;
+
+        return 0;
+}
+
+static long fat_compat_dir_ioctl(struct file *file, unsigned cmd,
+				 unsigned long arg)
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
+	lock_kernel();
+	ret = fat_dir_ioctl(file->f_dentry->d_inode, file,
+			    cmd, (unsigned long) &d);
+	unlock_kernel();
+	set_fs(oldfs);
+	if (ret >= 0) {
+		ret |= fat_compat_put_dirent32(&d[0], p);
+		ret |= fat_compat_put_dirent32(&d[1], p + 1);
+	}
+	return ret;
+}
+
 
 const struct file_operations fat_dir_operations = {
 	.read		= generic_read_dir,
 	.readdir	= fat_readdir,
 	.ioctl		= fat_dir_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= fat_compat_dir_ioctl,
+#endif
 	.fsync		= file_fsync,
 };
 
