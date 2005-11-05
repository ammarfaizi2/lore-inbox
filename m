Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVKEQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVKEQeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVKEQeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:00 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:27590 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932106AbVKEQdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:42 -0500
Message-Id: <20051105162714.555612000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:00 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, ext2-devel@lists.sourceforge.net,
       ext3-users@redhat.com, linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       nathans@sgi.com, reiserfs-dev@namesys.com, zippel@linux-m68k.org,
       sfrench@samba.org, samba-technical@lists.samba.org,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/25] fs: move ext2 ioctl32 handlers into file systems
Content-Disposition: inline; filename=ext2-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same ioctls (originally from ext2) are used on ext2, ext3,
hfsplus, cifs, reiserfs and xfs. Since they are really compatible
between 32 and 64 bit except for the ioctl number, the conversion
handler is trivial and I copy it to each of these file systems
in order to eventually get rid of fs/compat_ioctl.c completely.

Ext3 and reiserfs actually have some more ioctl numbers that have
the same problem as the others, so I'm adding the conversion for
those in the same place.

XFS already handled these ioctl numbers in its existing ioctl32
code, but appeared to get it wrong.

CC: ext2-devel@lists.sourceforge.net
CC: ext3-users@redhat.com
CC: linux-xfs@oss.sgi.com
CC: xfs-masters@oss.sgi.com
CC: nathans@sgi.com
CC: reiserfs-dev@namesys.com
CC: zippel@linux-m68k.org
CC: sfrench@samba.org
CC: samba-technical@lists.samba.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 02:45:19.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 02:45:35.000000000 +0100
@@ -126,12 +126,6 @@
 
 #ifdef CODE
 
-/* Aiee. Someone does not find a difference between int and long */
-#define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
-#define EXT2_IOC32_SETFLAGS               _IOW('f', 2, int)
-#define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
-#define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
-
 static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -163,18 +157,6 @@
 	return err;
 }
 
-static int do_ext2_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	/* These are just misnamed, they actually get/put from/to user an int */
-	switch (cmd) {
-	case EXT2_IOC32_GETFLAGS: cmd = EXT2_IOC_GETFLAGS; break;
-	case EXT2_IOC32_SETFLAGS: cmd = EXT2_IOC_SETFLAGS; break;
-	case EXT2_IOC32_GETVERSION: cmd = EXT2_IOC_GETVERSION; break;
-	case EXT2_IOC32_SETVERSION: cmd = EXT2_IOC_SETVERSION; break;
-	}
-	return sys_ioctl(fd, cmd, (unsigned long)compat_ptr(arg));
-}
-
 struct fb_fix_screeninfo32 {
 	char			id[16];
         compat_caddr_t	smem_start;
@@ -1313,10 +1295,6 @@
 HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
-HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_SETVERSION, do_ext2_ioctl)
 /* One SMB ioctl needs translations. */
 #define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
Index: linux-cg/fs/ext2/ioctl.c
===================================================================
--- linux-cg.orig/fs/ext2/ioctl.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/ext2/ioctl.c	2005-11-05 02:45:35.000000000 +0100
@@ -10,6 +10,7 @@
 #include "ext2.h"
 #include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/compat.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 
@@ -79,3 +80,33 @@
 		return -ENOTTY;
 	}
 }
+
+#ifdef CONFIG_COMPAT
+long ext2_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret;
+
+	/* These are just misnamed, they actually get/put from/to user an int */
+	switch (cmd) {
+	case EXT2_IOC32_GETFLAGS:
+		cmd = EXT2_IOC_GETFLAGS;
+		break;
+	case EXT2_IOC32_SETFLAGS:
+		cmd = EXT2_IOC_SETFLAGS;
+		break;
+	case EXT2_IOC32_GETVERSION:
+		cmd = EXT2_IOC_GETVERSION;
+		break;
+	case EXT2_IOC32_SETVERSION:
+		cmd = EXT2_IOC_SETVERSION;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	lock_kernel();
+	ret = ext2_ioctl(inode, file, cmd, (unsigned long) compat_ptr(arg));
+	unlock_kernel();
+	return ret;
+}
+#endif
Index: linux-cg/fs/ext3/ioctl.c
===================================================================
--- linux-cg.orig/fs/ext3/ioctl.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/ext3/ioctl.c	2005-11-05 02:45:35.000000000 +0100
@@ -12,9 +12,9 @@
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
 #include <linux/time.h>
+#include <linux/compat.h>
 #include <asm/uaccess.h>
 
-
 int ext3_ioctl (struct inode * inode, struct file * filp, unsigned int cmd,
 		unsigned long arg)
 {
@@ -241,3 +241,67 @@
 		return -ENOTTY;
 	}
 }
+
+#ifdef CONFIG_COMPAT
+/* Aiee. Someone does not find a difference between int and long */
+#define EXT3_IOC32_GETFLAGS		_IOR('f', 1, int)
+#define EXT3_IOC32_SETFLAGS		_IOW('f', 2, int)
+#define EXT3_IOC32_GETVERSION		_IOR('f', 3, int)
+#define EXT3_IOC32_SETVERSION		_IOW('f', 4, int)
+#define EXT3_IOC32_GROUP_EXTEND		_IOW('f', 7, __u32)
+#define EXT3_IOC32_GETVERSION_OLD	_IOR('v', 1, int)
+#define EXT3_IOC32_SETVERSION_OLD	_IOW('v', 2, int)
+#define EXT3_IOC32_WAIT_FOR_READONLY	_IOR('f', 99, int)
+#define EXT3_IOC32_GETRSVSZ		_IOR('f', 5, int)
+#define EXT3_IOC32_SETRSVSZ		_IOW('f', 6, int)
+
+long ext3_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret;
+
+	/* These are just misnamed, they actually get/put from/to user an int */
+	switch (cmd) {
+	case EXT3_IOC32_GETFLAGS:
+		cmd = EXT3_IOC_GETFLAGS;
+		break;
+	case EXT3_IOC32_SETFLAGS:
+		cmd = EXT3_IOC_SETFLAGS;
+		break;
+	case EXT3_IOC32_GETVERSION:
+		cmd = EXT3_IOC_GETVERSION;
+		break;
+	case EXT3_IOC32_SETVERSION:
+		cmd = EXT3_IOC_SETVERSION;
+		break;
+	case EXT3_IOC32_GROUP_EXTEND:
+		cmd = EXT3_IOC_GROUP_EXTEND;
+		break;
+	case EXT3_IOC32_GETVERSION_OLD:
+		cmd = EXT3_IOC_GETVERSION_OLD;
+		break;
+	case EXT3_IOC32_SETVERSION_OLD:
+		cmd = EXT3_IOC_SETVERSION_OLD;
+		break;
+#ifdef CONFIG_JBD_DEBUG
+	case EXT3_IOC32_WAIT_FOR_READONLY:
+		cmd = EXT3_IOC_WAIT_FOR_READONLY;
+		break;
+#endif
+	case EXT3_IOC32_GETRSVSZ:
+		cmd = EXT3_IOC_GETRSVSZ;
+		break;
+	case EXT3_IOC32_SETRSVSZ:
+		cmd = EXT3_IOC_SETRSVSZ;
+		break;
+	case EXT3_IOC_GROUP_ADD:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	lock_kernel();
+	ret = ext3_ioctl(inode, file, cmd, (unsigned long) compat_ptr(arg));
+	unlock_kernel();
+	return ret;
+}
+#endif
Index: linux-cg/fs/ext2/dir.c
===================================================================
--- linux-cg.orig/fs/ext2/dir.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/ext2/dir.c	2005-11-05 02:45:35.000000000 +0100
@@ -669,5 +669,8 @@
 	.read		= generic_read_dir,
 	.readdir	= ext2_readdir,
 	.ioctl		= ext2_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext2_compat_ioctl,
+#endif
 	.fsync		= ext2_sync_file,
 };
Index: linux-cg/fs/ext2/file.c
===================================================================
--- linux-cg.orig/fs/ext2/file.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/ext2/file.c	2005-11-05 02:45:35.000000000 +0100
@@ -46,6 +46,9 @@
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.ioctl		= ext2_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext2_compat_ioctl,
+#endif
 	.mmap		= generic_file_mmap,
 	.open		= generic_file_open,
 	.release	= ext2_release_file,
@@ -61,6 +64,9 @@
 	.read		= xip_file_read,
 	.write		= xip_file_write,
 	.ioctl		= ext2_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext2_compat_ioctl,
+#endif
 	.mmap		= xip_file_mmap,
 	.open		= generic_file_open,
 	.release	= ext2_release_file,
Index: linux-cg/fs/ext3/dir.c
===================================================================
--- linux-cg.orig/fs/ext3/dir.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/ext3/dir.c	2005-11-05 02:45:35.000000000 +0100
@@ -44,6 +44,9 @@
 	.read		= generic_read_dir,
 	.readdir	= ext3_readdir,		/* we take BKL. needed?*/
 	.ioctl		= ext3_ioctl,		/* BKL held */
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext3_compat_ioctl,
+#endif
 	.fsync		= ext3_sync_file,	/* BKL held */
 #ifdef CONFIG_EXT3_INDEX
 	.release	= ext3_release_dir,
Index: linux-cg/fs/ext3/file.c
===================================================================
--- linux-cg.orig/fs/ext3/file.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/ext3/file.c	2005-11-05 02:45:35.000000000 +0100
@@ -114,6 +114,9 @@
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext3_compat_ioctl,
+#endif
 	.mmap		= generic_file_mmap,
 	.open		= generic_file_open,
 	.release	= ext3_release_file,
Index: linux-cg/fs/xfs/linux-2.6/xfs_ioctl32.c
===================================================================
--- linux-cg.orig/fs/xfs/linux-2.6/xfs_ioctl32.c	2005-11-05 02:44:55.000000000 +0100
+++ linux-cg/fs/xfs/linux-2.6/xfs_ioctl32.c	2005-11-05 02:45:35.000000000 +0100
@@ -34,6 +34,11 @@
 #define  _NATIVE_IOC(cmd, type) \
 	  _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(type))
 
+/* broken ext2 ioctl numbers */
+#define XFS_IOC_GETVERSION32 _IOR('v', 1, int)
+#define XFS_IOC_GETXFLAGS32 _IOR('f', 1, int)
+#define XFS_IOC_SETXFLAGS32 _IOW('f', 2, int)
+
 #if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
 #define BROKEN_X86_ALIGNMENT
 /* on ia32 l_start is on a 32-bit boundary */
@@ -115,12 +120,16 @@
 	vnode_t		*vp = LINVFS_GET_VP(inode);
 
 	switch (cmd) {
+	/* these take an int as their argument, not a long */
+	case XFS_IOC_GETVERSION32:
+	case XFS_IOC_GETXFLAGS32:
+	case XFS_IOC_SETXFLAGS32:
+		cmd = _NATIVE_IOC(cmd, long);
+		break;
+
 	case XFS_IOC_DIOINFO:
 	case XFS_IOC_FSGEOMETRY_V1:
 	case XFS_IOC_FSGEOMETRY:
-	case XFS_IOC_GETVERSION:
-	case XFS_IOC_GETXFLAGS:
-	case XFS_IOC_SETXFLAGS:
 	case XFS_IOC_FSGETXATTR:
 	case XFS_IOC_FSSETXATTR:
 	case XFS_IOC_FSGETXATTRA:
Index: linux-cg/fs/cifs/ioctl.c
===================================================================
--- linux-cg.orig/fs/cifs/ioctl.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/cifs/ioctl.c	2005-11-05 02:45:35.000000000 +0100
@@ -21,6 +21,8 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include "cifspdu.h"
@@ -109,4 +111,29 @@
 
 	FreeXid(xid);
 	return rc;
-} 
+}
+
+#ifdef CONFIG_COMPAT
+long cifs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret;
+
+	/* These are just misnamed, they actually get/put from/to user an int */
+	switch (cmd) {
+	case EXT2_IOC32_GETFLAGS:
+		cmd = EXT2_IOC_GETFLAGS;
+		break;
+	case EXT2_IOC32_SETFLAGS:
+		cmd = EXT2_IOC_SETFLAGS;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	lock_kernel();
+	ret = cifs_ioctl(inode, file, cmd, (unsigned long) compat_ptr(arg));
+	unlock_kernel();
+	return ret;
+}
+
+#endif
Index: linux-cg/fs/hfsplus/dir.c
===================================================================
--- linux-cg.orig/fs/hfsplus/dir.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/hfsplus/dir.c	2005-11-05 02:45:35.000000000 +0100
@@ -8,6 +8,7 @@
  * Handling of directories
  */
 
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
@@ -479,6 +480,9 @@
 	.read		= generic_read_dir,
 	.readdir	= hfsplus_readdir,
 	.ioctl          = hfsplus_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= hfsplus_compat_ioctl,
+#endif
 	.llseek		= generic_file_llseek,
 	.release	= hfsplus_dir_release,
 };
Index: linux-cg/fs/hfsplus/hfsplus_fs.h
===================================================================
--- linux-cg.orig/fs/hfsplus/hfsplus_fs.h	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/hfsplus/hfsplus_fs.h	2005-11-05 02:45:35.000000000 +0100
@@ -249,6 +249,8 @@
  * chattr/lsattr */
 #define HFSPLUS_IOC_EXT2_GETFLAGS	_IOR('f', 1, long)
 #define HFSPLUS_IOC_EXT2_SETFLAGS	_IOW('f', 2, long)
+#define HFSPLUS_IOC_EXT2_GETFLAGS32	_IOR('f', 1, int)
+#define HFSPLUS_IOC_EXT2_SETFLAGS32	_IOW('f', 2, int)
 
 #define EXT2_FLAG_IMMUTABLE		0x00000010 /* Immutable file */
 #define EXT2_FLAG_APPEND		0x00000020 /* writes to file may only append */
@@ -336,6 +338,8 @@
 /* ioctl.c */
 int hfsplus_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
 		  unsigned long arg);
+long hfsplus_compat_ioctl(struct file *filp, unsigned int cmd,
+		  unsigned long arg);
 int hfsplus_setxattr(struct dentry *dentry, const char *name,
 		     const void *value, size_t size, int flags);
 ssize_t hfsplus_getxattr(struct dentry *dentry, const char *name,
Index: linux-cg/fs/hfsplus/inode.c
===================================================================
--- linux-cg.orig/fs/hfsplus/inode.c	2005-11-05 02:44:53.000000000 +0100
+++ linux-cg/fs/hfsplus/inode.c	2005-11-05 02:45:35.000000000 +0100
@@ -8,6 +8,7 @@
  * Inode handling routines
  */
 
+#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
@@ -310,6 +311,9 @@
 	.open		= hfsplus_file_open,
 	.release	= hfsplus_file_release,
 	.ioctl          = hfsplus_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= hfsplus_compat_ioctl,
+#endif
 };
 
 struct inode *hfsplus_new_inode(struct super_block *sb, int mode)
Index: linux-cg/fs/hfsplus/ioctl.c
===================================================================
--- linux-cg.orig/fs/hfsplus/ioctl.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/hfsplus/ioctl.c	2005-11-05 02:45:35.000000000 +0100
@@ -12,6 +12,8 @@
  * hfsplus ioctls
  */
 
+#include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/xattr.h>
@@ -82,6 +84,33 @@
 	}
 }
 
+#ifdef CONFIG_COMPAT
+long hfsplus_compat_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret;
+
+	switch (cmd) {
+	case HFSPLUS_IOC_EXT2_GETFLAGS32:
+		cmd = HFSPLUS_IOC_EXT2_GETFLAGS;
+		break;
+	case HFSPLUS_IOC_EXT2_SETFLAGS32:
+		cmd = HFSPLUS_IOC_EXT2_SETFLAGS;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	arg = (unsigned long) compat_ptr(arg);
+	lock_kernel();
+	ret = hfsplus_ioctl(inode, file, cmd, arg);
+	unlock_kernel();
+
+	return ret;
+}
+#endif
+
 int hfsplus_setxattr(struct dentry *dentry, const char *name,
 		     const void *value, size_t size, int flags)
 {
Index: linux-cg/fs/reiserfs/dir.c
===================================================================
--- linux-cg.orig/fs/reiserfs/dir.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/reiserfs/dir.c	2005-11-05 02:45:35.000000000 +0100
@@ -23,6 +23,9 @@
 	.readdir = reiserfs_readdir,
 	.fsync = reiserfs_dir_fsync,
 	.ioctl = reiserfs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = reiserfs_compat_ioctl,
+#endif
 };
 
 static int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry,
Index: linux-cg/fs/reiserfs/file.c
===================================================================
--- linux-cg.orig/fs/reiserfs/file.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/reiserfs/file.c	2005-11-05 02:45:35.000000000 +0100
@@ -2,6 +2,7 @@
  * Copyright 2000 by Hans Reiser, licensing governed by reiserfs/README
  */
 
+#include <linux/config.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/reiserfs_acl.h>
@@ -1551,6 +1552,9 @@
 	.read = generic_file_read,
 	.write = reiserfs_file_write,
 	.ioctl = reiserfs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = reiserfs_compat_ioctl,
+#endif
 	.mmap = generic_file_mmap,
 	.release = reiserfs_file_release,
 	.fsync = reiserfs_sync_file,
Index: linux-cg/fs/reiserfs/ioctl.c
===================================================================
--- linux-cg.orig/fs/reiserfs/ioctl.c	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/reiserfs/ioctl.c	2005-11-05 02:45:35.000000000 +0100
@@ -2,6 +2,8 @@
  * Copyright 2000 by Hans Reiser, licensing governed by reiserfs/README
  */
 
+#include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/time.h>
@@ -93,6 +95,40 @@
 	}
 }
 
+#ifdef CONFIG_COMPAT
+long reiserfs_compat_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret;
+
+	/* These are just misnamed, they actually get/put from/to user an int */
+	switch (cmd) {
+	case REISERFS_IOC32_UNPACK:
+		cmd = REISERFS_IOC_UNPACK;
+		break;
+	case REISERFS_IOC32_GETFLAGS:
+		cmd = REISERFS_IOC_GETFLAGS;
+		break;
+	case REISERFS_IOC32_SETFLAGS:
+		cmd = REISERFS_IOC_SETFLAGS;
+		break;
+	case REISERFS_IOC32_GETVERSION:
+		cmd = REISERFS_IOC_GETVERSION;
+		break;
+	case REISERFS_IOC32_SETVERSION:
+		cmd = REISERFS_IOC_SETVERSION;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	lock_kernel();
+	ret = reiserfs_ioctl(inode, file, cmd, (unsigned long) compat_ptr(arg));
+	unlock_kernel();
+	return ret;
+}
+#endif
+
 /*
 ** reiserfs_unpack
 ** Function try to convert tail from direct item into indirect.
Index: linux-cg/include/linux/ext2_fs.h
===================================================================
--- linux-cg.orig/include/linux/ext2_fs.h	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/include/linux/ext2_fs.h	2005-11-05 02:45:35.000000000 +0100
@@ -204,6 +204,13 @@
 #define	EXT2_IOC_SETFLAGS		_IOW('f', 2, long)
 #define	EXT2_IOC_GETVERSION		_IOR('v', 1, long)
 #define	EXT2_IOC_SETVERSION		_IOW('v', 2, long)
+/*
+ * ioctl commands in 32 bit emulation
+ */
+#define EXT2_IOC32_GETFLAGS		_IOR('f', 1, int)
+#define EXT2_IOC32_SETFLAGS		_IOW('f', 2, int)
+#define EXT2_IOC32_GETVERSION		_IOR('v', 1, int)
+#define EXT2_IOC32_SETVERSION		_IOW('v', 2, int)
 
 /*
  * Structure of an inode on the disk
Index: linux-cg/include/linux/reiserfs_fs.h
===================================================================
--- linux-cg.orig/include/linux/reiserfs_fs.h	2005-11-05 02:45:00.000000000 +0100
+++ linux-cg/include/linux/reiserfs_fs.h	2005-11-05 02:45:35.000000000 +0100
@@ -2180,6 +2180,8 @@
 /* prototypes from ioctl.c */
 int reiserfs_ioctl(struct inode *inode, struct file *filp,
 		   unsigned int cmd, unsigned long arg);
+long reiserfs_compat_ioctl(struct file *filp,
+		   unsigned int cmd, unsigned long arg);
 
 /* ioctl's command */
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
@@ -2190,6 +2192,13 @@
 #define REISERFS_IOC_GETVERSION		EXT2_IOC_GETVERSION
 #define REISERFS_IOC_SETVERSION		EXT2_IOC_SETVERSION
 
+/* the 32 bit compat definitions with int argument */
+#define REISERFS_IOC32_UNPACK		_IOW(0xCD, 1, int)
+#define REISERFS_IOC32_GETFLAGS		EXT2_IOC32_GETFLAGS
+#define REISERFS_IOC32_SETFLAGS		EXT2_IOC32_SETFLAGS
+#define REISERFS_IOC32_GETVERSION	EXT2_IOC32_GETVERSION
+#define REISERFS_IOC32_SETVERSION	EXT2_IOC32_SETVERSION
+
 /* Locking primitives */
 /* Right now we are still falling back to (un)lock_kernel, but eventually that
    would evolve into real per-fs locks */
Index: linux-cg/fs/cifs/cifsfs.c
===================================================================
--- linux-cg.orig/fs/cifs/cifsfs.c	2005-11-05 02:44:51.000000000 +0100
+++ linux-cg/fs/cifs/cifsfs.c	2005-11-05 02:45:35.000000000 +0100
@@ -23,6 +23,7 @@
 
 /* Note that BB means BUGBUG (ie something to fix eventually) */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
@@ -600,6 +601,9 @@
 	.sendfile = generic_file_sendfile,
 #ifdef CONFIG_CIFS_POSIX
 	.ioctl	= cifs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = cifs_compat_ioctl,
+#endif /* CONFIG_COMPAT */
 #endif /* CONFIG_CIFS_POSIX */
 
 #ifdef CONFIG_CIFS_EXPERIMENTAL
@@ -624,6 +628,9 @@
 	.sendfile = generic_file_sendfile, /* BB removeme BB */
 #ifdef CONFIG_CIFS_POSIX
 	.ioctl  = cifs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = cifs_compat_ioctl,
+#endif /* CONFIG_COMPAT */
 #endif /* CONFIG_CIFS_POSIX */
 
 #ifdef CONFIG_CIFS_EXPERIMENTAL
@@ -639,6 +646,9 @@
 	.dir_notify = cifs_dir_notify,
 #endif /* CONFIG_CIFS_EXPERIMENTAL */
         .ioctl  = cifs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = cifs_compat_ioctl,
+#endif /* CONFIG_COMPAT */
 };
 
 static void
Index: linux-cg/fs/cifs/cifsfs.h
===================================================================
--- linux-cg.orig/fs/cifs/cifsfs.h	2005-11-05 02:44:51.000000000 +0100
+++ linux-cg/fs/cifs/cifsfs.h	2005-11-05 02:46:23.000000000 +0100
@@ -97,5 +97,7 @@
 extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
 extern int cifs_ioctl (struct inode * inode, struct file * filep,
 		       unsigned int command, unsigned long arg);
+extern long cifs_compat_ioctl(struct file * filep, unsigned int command,
+			      unsigned long arg);
 #define CIFS_VERSION   "1.39"
 #endif				/* _CIFSFS_H */
Index: linux-cg/fs/ext2/ext2.h
===================================================================
--- linux-cg.orig/fs/ext2/ext2.h	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/fs/ext2/ext2.h	2005-11-05 02:45:35.000000000 +0100
@@ -137,6 +137,7 @@
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);
+extern long ext2_compat_ioctl(struct file *, unsigned int, unsigned long);
 
 /* super.c */
 extern void ext2_error (struct super_block *, const char *, const char *, ...)
Index: linux-cg/include/linux/ext3_fs.h
===================================================================
--- linux-cg.orig/include/linux/ext3_fs.h	2005-11-05 02:43:26.000000000 +0100
+++ linux-cg/include/linux/ext3_fs.h	2005-11-05 02:45:35.000000000 +0100
@@ -792,6 +792,7 @@
 /* ioctl.c */
 extern int ext3_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);
+extern long ext3_compat_ioctl (struct file *, unsigned int, unsigned long);
 
 /* namei.c */
 extern int ext3_orphan_add(handle_t *, struct inode *);

--

