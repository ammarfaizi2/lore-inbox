Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbUJYXyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUJYXyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUJYPLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:11:33 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:57512 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261858AbUJYOq3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:46:29 -0400
Cc: raven@themaw.net
Subject: [PATCH 15/28] VFS: Mountpoint file descriptor umount support
In-Reply-To: <10987155332448@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:46:09 -0400
Message-Id: <10987155691365@sun.com>
References: <10987155332448@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds functionality to mountfd so that a user can perform the
various types of umount (forced umount, not-busy umount, lazy-umount).

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/mountfd.c       |   20 ++++++++++++++++++++
 fs/namespace.c     |    2 +-
 include/linux/fs.h |    5 ++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

Index: linux-2.6.9-quilt/fs/mountfd.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/mountfd.c	2004-10-22 17:17:40.736271288 -0400
+++ linux-2.6.9-quilt/fs/mountfd.c	2004-10-22 17:17:41.367175376 -0400
@@ -11,6 +11,8 @@
 
 #define VFSMOUNT(filp) ((struct vfsmount *)((filp)->private_data))
 
+extern int do_umount(struct vfsmount *mnt, int flags);
+
 static struct vfsmount *mfdfs_mnt;
 
 static void mfdfs_read_inode(struct inode *inode);
@@ -72,6 +74,18 @@ static int mfd_release(struct inode *ino
 	return 0;
 }
 
+static long mfd_umount(struct file *mountfilp, int flags)
+{
+	struct vfsmount *mnt;
+	int error;
+	
+	mnt = mntget(VFSMOUNT(mountfilp));
+
+	error = do_umount(mnt, flags);
+
+	return error;
+}
+
 static int mfd_ioctl(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg);
 static struct file_operations mfd_file_ops = {
@@ -243,6 +257,12 @@ static int mfd_ioctl(struct inode *inode
 	switch (cmd) {
 	case MOUNTFD_IOC_GETDIRFD:
 		return mfd_getdirfd(filp);
+	case MOUNTFD_IOC_DETACH:
+		return mfd_umount(filp, MNT_DETACH);
+	case MOUNTFD_IOC_UNMOUNT:
+		return mfd_umount(filp, 0);
+	case MOUNTFD_IOC_FORCEDUNMOUNT:
+		return mfd_umount(filp, MNT_FORCE);
 	}
 	return -ENOTTY;
 }
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:40.738270984 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:41.368175224 -0400
@@ -601,7 +601,7 @@ static void umount_tree(struct vfsmount 
 	spin_lock(&vfsmount_lock);
 }
 
-static int do_umount(struct vfsmount *mnt, int flags)
+int do_umount(struct vfsmount *mnt, int flags)
 {
 	struct super_block * sb = mnt->mnt_sb;
 	int retval;
Index: linux-2.6.9-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/fs.h	2004-10-22 17:17:40.739270832 -0400
+++ linux-2.6.9-quilt/include/linux/fs.h	2004-10-22 17:17:41.369175072 -0400
@@ -214,7 +214,10 @@ extern int leases_enable, dir_notify_ena
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
 
-#define MOUNTFD_IOC_GETDIRFD _IO('p', 0xa0)
+#define MOUNTFD_IOC_GETDIRFD      _IO('p', 0xa0)
+#define MOUNTFD_IOC_UNMOUNT       _IO('p', 0xa1)
+#define MOUNTFD_IOC_DETACH        _IO('p', 0xa2)
+#define MOUNTFD_IOC_FORCEDUNMOUNT _IO('p', 0xa3)
 
 #ifdef __KERNEL__
 

