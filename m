Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVASVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVASVVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVASVVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:21:45 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:26531 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261901AbVASVVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:21:14 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Can't unmount bad inode
Message-Id: <E1CrNFz-0001JF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Jan 2005 22:20:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes a problem when a inode which is the root of a mount
becomes bad (make_bad_inode()).  In this case follow_link will return
-EIO, so the name resolution fails, and umount won't work.  The
solution is just to remove the follow_link method from bad_inode_ops.
Any filesystem operation (other than unmount) will still fail, since
every other method returns -EIO.

A test case for this is:

 1) export an smbfs on A and mount the share on B

 2) create directory X on A

 3) bind mount X to Y on B

 4) remove directory X, and create regular file X (same name) on A

 5) stat X on B, this will make X a bad inode (file type changed)

 6) umount Y

Without the patch applied, umount won't succeed, and a reboot is
necessary to get rid of the mount.

With the patch applied, umount will succeed.

The same is true for any filesystem which uses make_bad_inode() to
mark an existing inode bad (NFS, SMBFS, FUSE, etc...).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

--- linux-2.6.10/fs/bad_inode.c.orig	2005-01-19 21:48:24.000000000 +0100
+++ linux-2.6.10/fs/bad_inode.c	2005-01-19 22:07:56.000000000 +0100
@@ -15,17 +15,6 @@
 #include <linux/smp_lock.h>
 #include <linux/namei.h>
 
-/*
- * The follow_link operation is special: it must behave as a no-op
- * so that a bad root inode can at least be unmounted. To do this
- * we must dput() the base and return the dentry with a dget().
- */
-static int bad_follow_link(struct dentry *dent, struct nameidata *nd)
-{
-	nd_set_link(nd, ERR_PTR(-EIO));
-	return 0;
-}
-
 static int return_EIO(void)
 {
 	return -EIO;
@@ -70,7 +59,8 @@ struct inode_operations bad_inode_ops =
 	.mknod		= EIO_ERROR,
 	.rename		= EIO_ERROR,
 	.readlink	= EIO_ERROR,
-	.follow_link	= bad_follow_link,
+	/* follow_link must be no-op, otherwise unmounting this inode
+	   won't work */
 	.truncate	= EIO_ERROR,
 	.permission	= EIO_ERROR,
 	.getattr	= EIO_ERROR,
