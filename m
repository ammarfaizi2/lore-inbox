Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbUJYWWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbUJYWWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUJYPMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:12:25 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:59048 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261860AbUJYOqs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:46:48 -0400
Cc: raven@themaw.net
Subject: [PATCH 16/28] VFS: Mountpoint file descriptor attach support
In-Reply-To: <10987155691365@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:46:39 -0400
Message-Id: <10987155992813@sun.com>
References: <10987155691365@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows an unattached mountfd to be attached to a directory given a
direct fd.

NOTE: Probably requires CAP_SYSADMIN..  depends on what we want the security
model to be.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/mountfd.c       |   35 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    1 +
 2 files changed, 36 insertions(+)

Index: linux-2.6.9-quilt/fs/mountfd.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/mountfd.c	2004-10-22 17:17:41.367175376 -0400
+++ linux-2.6.9-quilt/fs/mountfd.c	2004-10-22 17:17:42.011077488 -0400
@@ -5,6 +5,7 @@
 #include <linux/stat.h>
 #include <linux/init.h>
 #include <linux/security.h>
+#include <linux/namei.h>
 
 #define MFDFS_MAGIC 0x4A9F2E43
 #define MFDFS_ROOT_INO 1
@@ -251,6 +252,38 @@ out_filp:
 	return error;
 }
 
+static long mfd_attach(struct file *mountfilp, int dirfd)
+{
+	struct file *dir;
+	struct vfsmount *mnt;
+	struct nameidata nd;
+	int ret;
+
+	mnt = mntget(VFSMOUNT(mountfilp));
+
+	ret = -EBADF;
+	dir = fget(dirfd);
+	if (!dir)
+		goto out;
+
+	ret = -ENOTDIR;
+	if (!S_ISDIR(dir->f_dentry->d_inode->i_mode))
+		goto out2;
+
+	memset(&nd, 0, sizeof(nd));
+	nd.dentry = dget(dir->f_dentry);
+	nd.mnt = mntget(dir->f_vfsmnt);
+
+	ret = do_graft_mount(mnt, &nd);
+
+	path_release(&nd);
+out2:
+	put_filp(dir);
+out:
+	mntput(mnt);
+	return ret;
+}
+
 static int mfd_ioctl(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg)
 {
@@ -263,6 +296,8 @@ static int mfd_ioctl(struct inode *inode
 		return mfd_umount(filp, 0);
 	case MOUNTFD_IOC_FORCEDUNMOUNT:
 		return mfd_umount(filp, MNT_FORCE);
+	case MOUNTFD_IOC_ATTACH:
+		return mfd_attach(filp, arg);
 	}
 	return -ENOTTY;
 }
Index: linux-2.6.9-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/fs.h	2004-10-22 17:17:41.369175072 -0400
+++ linux-2.6.9-quilt/include/linux/fs.h	2004-10-22 17:17:42.012077336 -0400
@@ -218,6 +218,7 @@ extern int leases_enable, dir_notify_ena
 #define MOUNTFD_IOC_UNMOUNT       _IO('p', 0xa1)
 #define MOUNTFD_IOC_DETACH        _IO('p', 0xa2)
 #define MOUNTFD_IOC_FORCEDUNMOUNT _IO('p', 0xa3)
+#define MOUNTFD_IOC_ATTACH        _IOW('p', 0xa4, int)
 
 #ifdef __KERNEL__
 

