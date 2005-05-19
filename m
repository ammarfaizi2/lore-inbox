Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVESXac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVESXac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVESXYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:24:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53922 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261303AbVESW4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:25 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (10/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwh-0007ry-At@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(10/19)

In open_namei(), __follow_down() loop turned into __follow_mount().
Instead of
	if we are on a mountpoint dentry
		if O_NOFOLLOW checks fail
			drop path.dentry
			drop nd
			return
		do equivalent of follow_mount(&path.mnt, &path.dentry)
		nd->mnt = path.mnt
we do
	if __follow_mount(path) had, indeed, traversed mountpoint
		/* now both nd->mnt and path.mnt are pinned down */
		if O_NOFOLLOW checks fail
			drop path.dentry
			drop path.mnt
			drop nd
			return
		mntput(nd->mnt)
		nd->mnt = path.mnt

Now __follow_down() can be folded into follow_down() - no other callers
left.  We need to reorder dput()/mntput() there - same problem as in
follow_mount().

Equivalent transformation + fix for a bug in O_NOFOLLOW handling - we
used to get -ELOOP if we had the same fs mounted on /foo and /bar, had
something bound on /bar/baz and tried to open /foo/baz with O_NOFOLLOW.
And fix of too-early-mntput() race in follow_down()

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-9/fs/namei.c RC12-rc4-10/fs/namei.c
--- RC12-rc4-9/fs/namei.c	2005-05-19 16:39:38.069917746 -0400
+++ RC12-rc4-10/fs/namei.c	2005-05-19 16:39:39.207691029 -0400
@@ -612,26 +612,21 @@
 /* no need for dcache_lock, as serialization is taken care in
  * namespace.c
  */
-static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
+int follow_down(struct vfsmount **mnt, struct dentry **dentry)
 {
 	struct vfsmount *mounted;
 
 	mounted = lookup_mnt(*mnt, *dentry);
 	if (mounted) {
+		dput(*dentry);
 		mntput(*mnt);
 		*mnt = mounted;
-		dput(*dentry);
 		*dentry = dget(mounted->mnt_root);
 		return 1;
 	}
 	return 0;
 }
 
-int follow_down(struct vfsmount **mnt, struct dentry **dentry)
-{
-	return __follow_down(mnt,dentry);
-}
- 
 static inline void follow_dotdot(struct vfsmount **mnt, struct dentry **dentry)
 {
 	while(1) {
@@ -1498,11 +1493,14 @@
 	if (flag & O_EXCL)
 		goto exit_dput;
 
-	if (d_mountpoint(path.dentry)) {
+	if (__follow_mount(&path)) {
 		error = -ELOOP;
-		if (flag & O_NOFOLLOW)
-			goto exit_dput;
-		while (__follow_down(&path.mnt,&path.dentry) && d_mountpoint(path.dentry));
+		if (flag & O_NOFOLLOW) {
+			dput(path.dentry);
+			mntput(path.mnt);
+			goto exit;
+		}
+		mntput(nd->mnt);
 		nd->mnt = path.mnt;
 	}
 	error = -ENOENT;
