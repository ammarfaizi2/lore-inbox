Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422848AbWHYTiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWHYTiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422852AbWHYTiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:38:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45967 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422846AbWHYThb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:37:31 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/18] [PATCH] BLOCK: Move the Ext2 device ioctl compat stuff to the Ext2 driver [try #4]
Date: Fri, 25 Aug 2006 20:37:28 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825193728.11384.45281.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move the Ext2 device ioctl compat stuff from fs/compat_ioctl.c to the Ext2
driver so that the Ext2 header file doesn't need to be included.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/compat_ioctl.c |   17 -----------------
 fs/ext2/dir.c     |    3 +++
 fs/ext2/ext2.h    |    1 +
 fs/ext2/file.c    |    6 ++++++
 fs/ext2/ioctl.c   |   32 ++++++++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 0346f2a..3594668 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -45,7 +45,6 @@ #include <linux/auto_fs4.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
 #include <linux/fb.h>
-#include <linux/ext2_fs.h>
 #include <linux/ext3_jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/videodev.h>
@@ -159,18 +158,6 @@ static int rw_long(unsigned int fd, unsi
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
 static int do_ext3_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
@@ -2725,10 +2712,6 @@ HANDLE_IOCTL(PIO_UNIMAP, do_unimap_ioctl
 HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl)
 #endif
-HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_SETVERSION, do_ext2_ioctl)
 HANDLE_IOCTL(EXT3_IOC32_GETVERSION, do_ext3_ioctl)
 HANDLE_IOCTL(EXT3_IOC32_SETVERSION, do_ext3_ioctl)
 HANDLE_IOCTL(EXT3_IOC32_GETRSVSZ, do_ext3_ioctl)
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 92ea826..3e7a84a 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -661,5 +661,8 @@ const struct file_operations ext2_dir_op
 	.read		= generic_read_dir,
 	.readdir	= ext2_readdir,
 	.ioctl		= ext2_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext2_compat_ioctl,
+#endif
 	.fsync		= ext2_sync_file,
 };
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index e65a019..c19ac15 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -137,6 +137,7 @@ extern void ext2_set_inode_flags(struct 
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);
+extern long ext2_compat_ioctl(struct file *, unsigned int, unsigned long);
 
 /* namei.c */
 struct dentry *ext2_get_parent(struct dentry *child);
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 23e2c7c..e8bbed9 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -46,6 +46,9 @@ const struct file_operations ext2_file_o
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.ioctl		= ext2_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext2_compat_ioctl,
+#endif
 	.mmap		= generic_file_mmap,
 	.open		= generic_file_open,
 	.release	= ext2_release_file,
@@ -63,6 +66,9 @@ const struct file_operations ext2_xip_fi
 	.read		= xip_file_read,
 	.write		= xip_file_write,
 	.ioctl		= ext2_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ext2_compat_ioctl,
+#endif
 	.mmap		= xip_file_mmap,
 	.open		= generic_file_open,
 	.release	= ext2_release_file,
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index 3ca9afd..1dfba77 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -11,6 +11,8 @@ #include "ext2.h"
 #include <linux/capability.h>
 #include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/compat.h>
+#include <linux/smp_lock.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 
@@ -80,3 +82,33 @@ int ext2_ioctl (struct inode * inode, st
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
