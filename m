Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWG0BKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWG0BKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWG0BKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:10:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:51116 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750728AbWG0BKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:10:00 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: reference: smbfs: simplify compat_ioctl handling
Date: Thu, 27 Jul 2006 03:09:58 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com> <200607270303.42959.arnd.bergmann@de.ibm.com>
In-Reply-To: <200607270303.42959.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270309.58867.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 03:03, Arnd Bergmann wrote:

> I'm also posting the two patches I made a long time ago as a reference.
> 

This one is a how the ncpfs patch is supposed to work as well.
still needs the UID16/32/64 stuff, I guess....

	Arnd <><

Subject: smbfs: simplify compat_ioctl handling

smbfs already handles SMB_IOC_GETMOUNTUID with both 16
and 32 bit arguments, so the compatibility wrapper is
not needed any more. The only other ioctl used in smbfs
is SMB_IOC_NEWCONN, which is compatible as well.

This simply introduces a new compat_ioctl function that
calls the regular smb_ioctl function.

CC: urban@teststation.com
CC: samba@samba.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-05 02:41:39.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-05 02:41:40.000000000 +0100
@@ -331,24 +331,6 @@
 	return err;
 }
 
-static int do_smb_getmountuid(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	__kernel_uid_t kuid;
-	int err;
-
-	cmd = SMB_IOC_GETMOUNTUID;
-
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, cmd, (unsigned long)&kuid);
-	set_fs(old_fs);
-
-	if (err >= 0)
-		err = put_user(kuid, (compat_uid_t __user *)compat_ptr(arg));
-
-	return err;
-}
-
 static __attribute_used__ int 
 ret_einval(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -938,9 +920,6 @@
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
-/* One SMB ioctl needs translations. */
-#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
-HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
 /* vfat */
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
Index: linux-2.6.14-rc/fs/smbfs/ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/smbfs/ioctl.c	2005-11-05 02:38:13.000000000 +0100
+++ linux-2.6.14-rc/fs/smbfs/ioctl.c	2005-11-05 02:41:40.000000000 +0100
@@ -7,6 +7,8 @@
  *  Please add a note about your changes to smbfs in the ChangeLog file.
  */
 
+#include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/ioctl.h>
@@ -65,3 +67,17 @@
 
 	return result;
 }
+
+#ifdef CONFIG_COMPAT
+/* All three ioctl numbers above are compatible */
+long
+smb_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int result;
+	lock_kernel();
+	arg = (unsigned long) compat_ptr(arg);
+	result = smb_ioctl(file->f_dentry->d_inode, file, cmd, arg);
+	unlock_kernel();
+	return result;
+}
+#endif
Index: linux-2.6.14-rc/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/compat_ioctl.h	2005-11-05 02:41:39.000000000 +0100
+++ linux-2.6.14-rc/include/linux/compat_ioctl.h	2005-11-05 02:41:40.000000000 +0100
@@ -379,8 +379,6 @@
 /* Raw devices */
 COMPATIBLE_IOCTL(RAW_SETBIND)
 COMPATIBLE_IOCTL(RAW_GETBIND)
-/* SMB ioctls which do not need any translations */
-COMPATIBLE_IOCTL(SMB_IOC_NEWCONN)
 /* NCP ioctls which do not need any translations */
 COMPATIBLE_IOCTL(NCP_IOC_CONN_LOGGED_IN)
 COMPATIBLE_IOCTL(NCP_IOC_SIGN_INIT)
Index: linux-2.6.14-rc/fs/smbfs/file.c
===================================================================
--- linux-2.6.14-rc.orig/fs/smbfs/file.c	2005-11-05 02:38:13.000000000 +0100
+++ linux-2.6.14-rc/fs/smbfs/file.c	2005-11-05 02:41:40.000000000 +0100
@@ -7,6 +7,7 @@
  *  Please add a note about your changes to smbfs in the ChangeLog file.
  */
 
+#include <linux/config.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -408,6 +409,9 @@
 	.read		= smb_file_read,
 	.write		= smb_file_write,
 	.ioctl		= smb_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= smb_compat_ioctl,
+#endif
 	.mmap		= smb_file_mmap,
 	.open		= smb_file_open,
 	.release	= smb_file_release,
Index: linux-2.6.14-rc/fs/smbfs/proto.h
===================================================================
--- linux-2.6.14-rc.orig/fs/smbfs/proto.h	2005-11-05 02:38:13.000000000 +0100
+++ linux-2.6.14-rc/fs/smbfs/proto.h	2005-11-05 02:41:40.000000000 +0100
@@ -68,6 +68,7 @@
 extern struct inode_operations smb_file_inode_operations;
 /* ioctl.c */
 extern int smb_ioctl(struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg);
+extern long smb_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 /* smbiod.c */
 extern void smbiod_wake_up(void);
 extern int smbiod_register_server(struct smb_sb_info *server);
Index: linux-2.6.14-rc/fs/smbfs/dir.c
===================================================================
--- linux-2.6.14-rc.orig/fs/smbfs/dir.c	2005-11-05 02:38:13.000000000 +0100
+++ linux-2.6.14-rc/fs/smbfs/dir.c	2005-11-05 02:41:40.000000000 +0100
@@ -7,6 +7,7 @@
  *  Please add a note about your changes to smbfs in the ChangeLog file.
  */
 
+#include <linux/config.h>
 #include <linux/time.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -39,6 +40,9 @@
 	.read		= generic_read_dir,
 	.readdir	= smb_readdir,
 	.ioctl		= smb_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= smb_compat_ioctl,
+#endif
 	.open		= smb_dir_open,
 };
 
