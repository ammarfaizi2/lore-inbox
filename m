Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968156AbWLEJk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968156AbWLEJk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 04:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968182AbWLEJk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 04:40:26 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:44217 "EHLO
	liaag2af.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968156AbWLEJkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 04:40:25 -0500
Date: Tue, 5 Dec 2006 04:33:10 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
To: Andrew Morton <akpm@osdl.org>
Cc: Kasper Sandberg <lkml@metanurb.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Message-ID: <200612050436_MC3-1-D3F9-FB3D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061204192018.2a61814f.akpm@osdl.org>

On Mon, 4 Dec 2006 19:20:18 -0800, Andrew Morton wrote:

> On Tue, 05 Dec 2006 03:36:09 +0100
> Kasper Sandberg <lkml@metanurb.dk> wrote:
> 
> > i know i said i suspected this was another bug, but i have revised my
> > suspecisions, and i do believe its in relation to x86 chroot on x86_64
> > install, as it has happened with more stuff now, inside the chroot, and
> > only inside the chroot, while the same apps dont do it outside chroot.
> > 
> > 2.6.19 release is affected too

> > > > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > > > arg(00221000) on /home/redeeman
> > > > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > > > arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32

> Possibly some ioctl got removed.  I don't know why it would only occur
> within a chrooted environment.
> 
> Possibly one could work out what's going on by reverse-engineering x86_64
> ioctl command 0x82187201, but unfortunately I don't have time to do that. 

That is VFAT_IOCTL_READDIR_BOTH32

This patch:
        [PATCH] BLOCK: Move the msdos device ioctl
                compat stuff to the msdos driver [try #6]

may have caused this.

Here is a patch to reverse that.  Kasper, can you test it?
(Your filesystem is on a FAT/VFAT volume, I assume.)


[Revert] [PATCH] BLOCK: Move the msdos device ioctl compat stuff to the msdos driver [try #6]

Reverts:

Move the msdos device ioctl compat stuff from fs/compat_ioctl.c to the msdos
driver so that the msdos header file doesn't need to be included.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

committer: Jens Axboe <axboe@nelson.home.kernel.dk> 1159642350 +0200


 fs/compat_ioctl.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/dir.c      |   56 ------------------------------------------------------
 2 files changed, 49 insertions(+), 56 deletions(-)

--- 2.6.19.0.2-32.orig/fs/compat_ioctl.c
+++ 2.6.19.0.2-32/fs/compat_ioctl.c
@@ -107,6 +107,7 @@
 #include <linux/nbd.h>
 #include <linux/random.h>
 #include <linux/filter.h>
+#include <linux/msdos_fs.h>
 #include <linux/pktcdvd.h>
 
 #include <linux/hiddev.h>
@@ -1945,6 +1946,51 @@ static int mtd_rw_oob(unsigned int fd, u
 	return err;
 }	
 
+#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
+#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
+
+static long
+put_dirent32 (struct dirent *d, struct compat_dirent __user *d32)
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
+static int vfat_ioctl32(unsigned fd, unsigned cmd, unsigned long arg)
+{
+	struct compat_dirent __user *p = compat_ptr(arg);
+	int ret;
+	mm_segment_t oldfs = get_fs();
+	struct dirent d[2];
+
+	switch(cmd)
+	{
+        	case VFAT_IOCTL_READDIR_BOTH32:
+                	cmd = VFAT_IOCTL_READDIR_BOTH;
+                	break;
+        	case VFAT_IOCTL_READDIR_SHORT32:
+                	cmd = VFAT_IOCTL_READDIR_SHORT;
+                	break;
+	}
+
+	set_fs(KERNEL_DS);
+	ret = sys_ioctl(fd,cmd,(unsigned long)&d);
+	set_fs(oldfs);
+	if (ret >= 0) {
+		ret |= put_dirent32(&d[0], p);
+		ret |= put_dirent32(&d[1], p + 1);
+	}
+	return ret;
+}
+
 #ifdef CONFIG_BLOCK
 struct raw32_config_request
 {
@@ -2513,6 +2559,9 @@ HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_io
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
+/* vfat */
+HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
+HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
 /* Raw devices */
 HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
 HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
--- 2.6.19.0.2-32.orig/fs/fat/dir.c
+++ 2.6.19.0.2-32/fs/fat/dir.c
@@ -20,7 +20,6 @@
 #include <linux/dirent.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
-#include <linux/compat.h>
 #include <asm/uaccess.h>
 
 static inline loff_t fat_make_i_pos(struct super_block *sb,
@@ -742,65 +741,10 @@ static int fat_dir_ioctl(struct inode * 
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
-#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
-
-static long fat_compat_put_dirent32(struct dirent *d,
-				    struct compat_dirent __user *d32)
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
-static long fat_compat_dir_ioctl(struct file *file, unsigned cmd,
-				 unsigned long arg)
-{
-	struct compat_dirent __user *p = compat_ptr(arg);
-	int ret;
-	mm_segment_t oldfs = get_fs();
-	struct dirent d[2];
-
-	switch (cmd) {
-	case VFAT_IOCTL_READDIR_BOTH32:
-		cmd = VFAT_IOCTL_READDIR_BOTH;
-		break;
-	case VFAT_IOCTL_READDIR_SHORT32:
-		cmd = VFAT_IOCTL_READDIR_SHORT;
-		break;
-	default:
-		return -ENOIOCTLCMD;
-	}
-
-	set_fs(KERNEL_DS);
-	lock_kernel();
-	ret = fat_dir_ioctl(file->f_dentry->d_inode, file,
-			    cmd, (unsigned long) &d);
-	unlock_kernel();
-	set_fs(oldfs);
-	if (ret >= 0) {
-		ret |= fat_compat_put_dirent32(&d[0], p);
-		ret |= fat_compat_put_dirent32(&d[1], p + 1);
-	}
-	return ret;
-}
-#endif /* CONFIG_COMPAT */
-
 const struct file_operations fat_dir_operations = {
 	.read		= generic_read_dir,
 	.readdir	= fat_readdir,
 	.ioctl		= fat_dir_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= fat_compat_dir_ioctl,
-#endif
 	.fsync		= file_fsync,
 };
 
-- 
Chuck
"Even supernovas have their duller moments."
