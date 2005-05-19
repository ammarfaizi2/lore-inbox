Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVESX00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVESX00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVESXYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:24:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53154 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261302AbVESW4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:20 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (9/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwc-0007rp-9B@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(9/19)

New helper: __follow_mount(struct path *path).  Same as follow_mount(),
except that we do *not* do mntput() after the first lookup_mnt().

IOW, original path->mnt stays pinned down.  We also take care to do dput()
before mntput() in the loop body (follow_mount() also needs that reordering,
but that will be done later in the series).

The following are equivalent, assuming that path.mnt == x:
(1)
	follow_mount(&path.mnt, &path.dentry)
(2)
	__follow_mount(&path);
	if (path->mnt != x)
		mntput(x);
(3)
	if (__follow_mount(&path))
		mntput(x);

Callers of follow_mount() in __link_path_walk() converted to (2).

Equivalent transformation + fix for too-late-mntput() race in __follow_mount()
loop.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-8/fs/namei.c RC12-rc4-9/fs/namei.c
--- RC12-rc4-8/fs/namei.c	2005-05-19 16:39:36.950140877 -0400
+++ RC12-rc4-9/fs/namei.c	2005-05-19 16:39:38.069917746 -0400
@@ -576,6 +576,23 @@
 /* no need for dcache_lock, as serialization is taken care in
  * namespace.c
  */
+static int __follow_mount(struct path *path)
+{
+	int res = 0;
+	while (d_mountpoint(path->dentry)) {
+		struct vfsmount *mounted = lookup_mnt(path->mnt, path->dentry);
+		if (!mounted)
+			break;
+		dput(path->dentry);
+		if (res)
+			mntput(path->mnt);
+		path->mnt = mounted;
+		path->dentry = dget(mounted->mnt_root);
+		res = 1;
+	}
+	return res;
+}
+
 static int follow_mount(struct vfsmount **mnt, struct dentry **dentry)
 {
 	int res = 0;
@@ -778,7 +795,9 @@
 		if (err)
 			break;
 		/* Check mountpoints.. */
-		follow_mount(&next.mnt, &next.dentry);
+		__follow_mount(&next);
+		if (nd->mnt != next.mnt)
+			mntput(nd->mnt);
 
 		err = -ENOENT;
 		inode = next.dentry->d_inode;
@@ -836,7 +855,9 @@
 		err = do_lookup(nd, &this, &next);
 		if (err)
 			break;
-		follow_mount(&next.mnt, &next.dentry);
+		__follow_mount(&next);
+		if (nd->mnt != next.mnt)
+			mntput(nd->mnt);
 		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
