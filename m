Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVAXLc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVAXLc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 06:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVAXLc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:32:58 -0500
Received: from rev.193.226.232.37.euroweb.hu ([193.226.232.37]:8596 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261497AbVAXLcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:32:54 -0500
To: akpm@osdl.org
CC: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] Can't unmount bad inode
Message-Id: <E1Ct2Rz-0004oH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Jan 2005 12:32:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I'm resending this patch.  This problem may allow DoS (creation
of un-umountable direcories) by non-privileged users with default
installations of smbfs or FUSE.

In reply to the previous posting of this patch, Al Viro proposed that
this can also be solved by not following symlinks in last component in
sys_umount().  While that would also solve the problem, it would be an
incompatible change, so I still believe, that this is the proper fix.

Here's the patch as previously posted:
------------------------------------------------------------------------

This patch fixes a problem when a inode which is the root of a mount
becomes bad (make_bad_inode()).  In this case follow_link will return
-EIO, so the name resolution fails, and umount won't work.  The
solution is just to remove the follow_link method from bad_inode_ops.
Any filesystem operation (other than unmount) will still fail, since
every other method returns -EIO.

A test case for this is:

 1) export an smbfs on host A and mount the share on host B

 2) create directory X on A under the exported directory

 3) bind mount X to Y on B (Y need not be under the share)

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

