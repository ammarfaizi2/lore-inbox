Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVCVB3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVCVB3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVCVB2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:28:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63964 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262251AbVCVB0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:26:11 -0500
Subject: [PATCH 2.4] SGI 932676 link_path_walk refcount problem allows
	umount of active filesystem
From: Greg Banks <gnb@melbourne.sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux AutoFS Mailing List <autofs@linux.kernel.org>
Content-Type: multipart/mixed; boundary="=-fPp/ESy58Gj/36RjsLWj"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1111454677.1991.766.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 22 Mar 2005 12:24:37 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fPp/ESy58Gj/36RjsLWj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

G'day,

The attached patch fixes a bug in the VFS code which causes
"Busy inodes after unmount" and a subsequent oops.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-fPp/ESy58Gj/36RjsLWj
Content-Disposition: attachment; filename=sgi932676-fix-link-following-vfsmount-refcount-bug.patch
Content-Type: text/x-patch; name=sgi932676-fix-link-following-vfsmount-refcount-bug.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Following an absolute symlink opens a window during which the
filesystem containing the symlink has an outstanding dentry count
and no outstanding vfsmount count.  A umount() of the filesystem can
(incorrectly) proceed, resulting in the "Busy inodes after unmount"
message and an oops shortly thereafter.

Systems using autofs-controlled NFS mounts are especially vulnerable,
as autofs both increases the number of unmounts happening and does NFS
mounting in response to lookups which can result in multiple-second
vulnerability windows.  However the bug could happen on any filesystem.

This patch adds a mntget()/mntput() pair around the link following code
(as the 2.6 code does).  Attempts to umount() during link following
now return EBUSY.


Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---
 linux/linux/fs/namei.c |    7 +++++++
 1 files changed, 7 insertions(+)

--- a/linux/linux/fs/namei.c	2005-03-21 12:53:48 +11:00
+++ b/linux/linux/fs/namei.c	2005-03-21 12:16:46 +11:00
@@ -541,8 +541,10 @@
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
+			struct vfsmount *mnt = mntget(nd->mnt);
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
+			mntput(mnt);
 			if (err)
 				goto return_err;
 			err = -ENOENT;
@@ -596,8 +598,10 @@
 		inode = dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
+			struct vfsmount *mnt = mntget(nd->mnt);
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
+			mntput(mnt);
 			if (err)
 				goto return_err;
 			inode = nd->dentry->d_inode;
@@ -1002,6 +1006,7 @@
 	int acc_mode, error = 0;
 	struct inode *inode;
 	struct dentry *dentry;
+	struct vfsmount *mnt;
 	struct dentry *dir;
 	int count = 0;
 
@@ -1185,8 +1190,10 @@
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
 	UPDATE_ATIME(dentry->d_inode);
+	mnt = mntget(nd->mnt);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
 	dput(dentry);
+	mntput(mnt);
 	if (error)
 		return error;
 	if (nd->last_type == LAST_BIND) {

--=-fPp/ESy58Gj/36RjsLWj--

