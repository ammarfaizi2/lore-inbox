Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422852AbWHYTiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422852AbWHYTiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422858AbWHYTiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:38:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47247 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422848AbWHYThe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:37:34 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 14/18] [PATCH] BLOCK: Move the Ext3 device ioctl compat stuff to the Ext3 driver [try #4]
Date: Fri, 25 Aug 2006 20:37:31 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825193730.11384.1455.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move the Ext3 device ioctl compat stuff from fs/compat_ioctl.c to the Ext3
driver so that the Ext3 header file doesn't need to be included.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/compat_ioctl.c       |   27 -----------------------
 fs/ext3/dir.c           |    3 +++
 fs/ext3/file.c          |    3 +++
 fs/ext3/ioctl.c         |   55 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/ext3_fs.h |    6 +++++
 5 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 3594668..e5eb0f1 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -45,8 +45,6 @@ #include <linux/auto_fs4.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
 #include <linux/fb.h>
-#include <linux/ext3_jbd.h>
-#include <linux/ext3_fs.h>
 #include <linux/videodev.h>
 #include <linux/netdevice.h>
 #include <linux/raw.h>
@@ -158,22 +156,6 @@ static int rw_long(unsigned int fd, unsi
 	return err;
 }
 
-static int do_ext3_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	/* These are just misnamed, they actually get/put from/to user an int */
-	switch (cmd) {
-	case EXT3_IOC32_GETVERSION: cmd = EXT3_IOC_GETVERSION; break;
-	case EXT3_IOC32_SETVERSION: cmd = EXT3_IOC_SETVERSION; break;
-	case EXT3_IOC32_GETRSVSZ: cmd = EXT3_IOC_GETRSVSZ; break;
-	case EXT3_IOC32_SETRSVSZ: cmd = EXT3_IOC_SETRSVSZ; break;
-	case EXT3_IOC32_GROUP_EXTEND: cmd = EXT3_IOC_GROUP_EXTEND; break;
-#ifdef CONFIG_JBD_DEBUG
-	case EXT3_IOC32_WAIT_FOR_READONLY: cmd = EXT3_IOC_WAIT_FOR_READONLY; break;
-#endif
-	}
-	return sys_ioctl(fd, cmd, (unsigned long)compat_ptr(arg));
-}
-
 struct compat_video_event {
 	int32_t		type;
 	compat_time_t	timestamp;
@@ -2712,15 +2694,6 @@ HANDLE_IOCTL(PIO_UNIMAP, do_unimap_ioctl
 HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl)
 #endif
-HANDLE_IOCTL(EXT3_IOC32_GETVERSION, do_ext3_ioctl)
-HANDLE_IOCTL(EXT3_IOC32_SETVERSION, do_ext3_ioctl)
-HANDLE_IOCTL(EXT3_IOC32_GETRSVSZ, do_ext3_ioctl)
-HANDLE_IOCTL(EXT3_IOC32_SETRSVSZ, do_ext3_ioctl)
-HANDLE_IOCTL(EXT3_IOC32_GROUP_EXTEND, do_ext3_ioctl)
-COMPATIBLE_IOCTL(EXT3_IOC_GROUP_ADD)
-#ifdef CONFIG_JBD_DEBUG
-HANDLE_IOCTL(EXT3_IOC32_WAIT_FOR_READONLY, do_ext3_ioctl)
-#endif
 /* One SMB ioctl needs translations. */
 #define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
diff --git a/fs/ext3/dir.c b/fs/ext3/dir.c
index fbb0d4e..7ba8917 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -44,6 +44,9 @@ const struct file_operations ext3_dir_op
 	.read		= generic_read_dir,
 	.readdir	= ext3_readdir,		/* we take BKL. needed?*/
 	.ioctl		= ext3_ioctl,		/* BKL held */
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext3_compat_ioctl,
+#endif
 	.fsync		= ext3_sync_file,	/* BKL held */
 #ifdef CONFIG_EXT3_INDEX
 	.release	= ext3_release_dir,
diff --git a/fs/ext3/file.c b/fs/ext3/file.c
index 1efefb6..40320da 100644
--- a/fs/ext3/file.c
+++ b/fs/ext3/file.c
@@ -114,6 +114,9 @@ const struct file_operations ext3_file_o
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext3_compat_ioctl,
+#endif
 	.mmap		= generic_file_mmap,
 	.open		= generic_file_open,
 	.release	= ext3_release_file,
diff --git a/fs/ext3/ioctl.c b/fs/ext3/ioctl.c
index 3a6b012..12daa68 100644
--- a/fs/ext3/ioctl.c
+++ b/fs/ext3/ioctl.c
@@ -13,9 +13,10 @@ #include <linux/capability.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
 #include <linux/time.h>
+#include <linux/compat.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
-
 int ext3_ioctl (struct inode * inode, struct file * filp, unsigned int cmd,
 		unsigned long arg)
 {
@@ -252,3 +253,55 @@ #endif
 		return -ENOTTY;
 	}
 }
+
+#ifdef CONFIG_COMPAT
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
diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
index 90cfba2..690c730 100644
--- a/include/linux/ext3_fs.h
+++ b/include/linux/ext3_fs.h
@@ -237,6 +237,8 @@ #define EXT3_IOC_SETRSVSZ		_IOW('f', 6, 
 /*
  * ioctl commands in 32 bit emulation
  */
+#define EXT3_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
+#define EXT3_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
 #define EXT3_IOC32_GETVERSION		_IOR('f', 3, int)
 #define EXT3_IOC32_SETVERSION		_IOW('f', 4, int)
 #define EXT3_IOC32_GETRSVSZ		_IOR('f', 5, int)
@@ -245,6 +247,9 @@ #define EXT3_IOC32_GROUP_EXTEND		_IOW('f
 #ifdef CONFIG_JBD_DEBUG
 #define EXT3_IOC32_WAIT_FOR_READONLY	_IOR('f', 99, int)
 #endif
+#define EXT3_IOC32_GETVERSION_OLD	FS_IOC32_GETVERSION
+#define EXT3_IOC32_SETVERSION_OLD	FS_IOC32_SETVERSION
+
 
 /*
  *  Mount options
@@ -828,6 +833,7 @@ extern void ext3_set_aops(struct inode *
 /* ioctl.c */
 extern int ext3_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);
+extern long ext3_compat_ioctl (struct file *, unsigned int, unsigned long);
 
 /* namei.c */
 extern int ext3_orphan_add(handle_t *, struct inode *);
