Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWHXVgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWHXVgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbWHXVds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:33:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21220 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422698AbWHXVdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:33:24 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/17] BLOCK: Move the ReiserFS device ioctl compat stuff to the ReiserFS driver [try #2]
Date: Thu, 24 Aug 2006 22:33:22 +0100
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com
Message-Id: <20060824213321.21323.37550.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move the ReiserFS device ioctl compat stuff from fs/compat_ioctl.c to the
ReiserFS driver so that the ReiserFS header file doesn't need to be included.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/compat_ioctl.c           |   12 ------------
 fs/reiserfs/dir.c           |    3 +++
 fs/reiserfs/file.c          |    4 ++++
 fs/reiserfs/ioctl.c         |   35 +++++++++++++++++++++++++++++++++++
 include/linux/reiserfs_fs.h |    9 +++++++++
 5 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index c4d2849..5e84342 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -59,7 +59,6 @@ #include <linux/rtc.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/serial.h>
-#include <linux/reiserfs_fs.h>
 #include <linux/if_tun.h>
 #include <linux/ctype.h>
 #include <linux/ioctl32.h>
@@ -2016,16 +2015,6 @@ static int vfat_ioctl32(unsigned fd, uns
 	return ret;
 }
 
-#define REISERFS_IOC_UNPACK32               _IOW(0xCD,1,int)
-
-static int reiserfs_ioctl32(unsigned fd, unsigned cmd, unsigned long ptr)
-{
-        if (cmd == REISERFS_IOC_UNPACK32)
-                cmd = REISERFS_IOC_UNPACK;
-
-        return sys_ioctl(fd,cmd,ptr);
-}
-
 struct raw32_config_request
 {
         compat_int_t    raw_minor;
@@ -2786,7 +2775,6 @@ HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgets
 /* vfat */
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
-HANDLE_IOCTL(REISERFS_IOC_UNPACK32, reiserfs_ioctl32)
 /* Raw devices */
 HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
 HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
diff --git a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
index 9aabcc0..657050a 100644
--- a/fs/reiserfs/dir.c
+++ b/fs/reiserfs/dir.c
@@ -22,6 +22,9 @@ const struct file_operations reiserfs_di
 	.readdir = reiserfs_readdir,
 	.fsync = reiserfs_dir_fsync,
 	.ioctl = reiserfs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = reiserfs_compat_ioctl,
+#endif
 };
 
 static int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry,
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 1627edd..719b367 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -2,6 +2,7 @@
  * Copyright 2000 by Hans Reiser, licensing governed by reiserfs/README
  */
 
+#include <linux/config.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/reiserfs_acl.h>
@@ -1568,6 +1569,9 @@ const struct file_operations reiserfs_fi
 	.read = generic_file_read,
 	.write = reiserfs_file_write,
 	.ioctl = reiserfs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = reiserfs_compat_ioctl,
+#endif
 	.mmap = generic_file_mmap,
 	.release = reiserfs_file_release,
 	.fsync = reiserfs_sync_file,
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index a986b5e..9c57578 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -9,6 +9,7 @@ #include <linux/time.h>
 #include <asm/uaccess.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/compat.h>
 
 static int reiserfs_unpack(struct inode *inode, struct file *filp);
 
@@ -94,6 +95,40 @@ int reiserfs_ioctl(struct inode *inode, 
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
diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
index 54c3054..6ab7be9 100644
--- a/include/linux/reiserfs_fs.h
+++ b/include/linux/reiserfs_fs.h
@@ -2167,6 +2167,8 @@ #define SPARE_SPACE 500
 /* prototypes from ioctl.c */
 int reiserfs_ioctl(struct inode *inode, struct file *filp,
 		   unsigned int cmd, unsigned long arg);
+long reiserfs_compat_ioctl(struct file *filp,
+		   unsigned int cmd, unsigned long arg);
 
 /* ioctl's command */
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
@@ -2177,6 +2179,13 @@ #define REISERFS_IOC_SETFLAGS		FS_IOC_SE
 #define REISERFS_IOC_GETVERSION		FS_IOC_GETVERSION
 #define REISERFS_IOC_SETVERSION		FS_IOC_SETVERSION
 
+/* the 32 bit compat definitions with int argument */
+#define REISERFS_IOC32_UNPACK		_IOW(0xCD, 1, int)
+#define REISERFS_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
+#define REISERFS_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
+#define REISERFS_IOC32_GETVERSION	FS_IOC32_GETVERSION
+#define REISERFS_IOC32_SETVERSION	FS_IOC32_SETVERSION
+
 /* Locking primitives */
 /* Right now we are still falling back to (un)lock_kernel, but eventually that
    would evolve into real per-fs locks */
