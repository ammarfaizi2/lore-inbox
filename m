Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWBLNkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWBLNkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 08:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWBLNkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 08:40:23 -0500
Received: from 203-59-200-129.dyn.iinet.net.au ([203.59.200.129]:26330 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1750739AbWBLNkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 08:40:21 -0500
Date: Sun, 12 Feb 2006 21:40:11 +0800
Message-Id: <200602121340.k1CDeB8x019274@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [RFC:PATCH 1/4] autofs4 - nameidata needs to be up to date for follow_link
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to trigger a mount using the follow_link
inode method the nameidata struct that is passed in needs to have
the vfsmount of the autofs trigger not its parent.

During a path walk if an autofs trigger is mounted on a dentry,
when the follow_link method is called, the nameidata struct contains
the vfsmount and mountpoint dentry of the parent mount while the
dentry that is passed in is the root of the autofs trigger mount.
I believe it is impossible to get the vfsmount of the trigger 
mount, within the follow_link method, when only the parent vfsmount
and the root dentry of the trigger mount are known.

This patch updates the nameidata struct on entry to __do_follow_link
if it detects that it is out of date. It moves the path_to_nameidata
to above __do_follow_link to facilitate calling it from there.
The dput_path is moved as well as that seemed sensible. No changes
are made to these two functions.

--- linux-2.6.16-rc2-mm1/fs/namei.c.update-nameidata-on-follow_link	2006-02-09 13:41:32.000000000 +0800
+++ linux-2.6.16-rc2-mm1/fs/namei.c	2006-02-09 13:51:19.000000000 +0800
@@ -546,6 +546,22 @@ struct path {
 	struct dentry *dentry;
 };
 
+static inline void dput_path(struct path *path, struct nameidata *nd)
+{
+	dput(path->dentry);
+	if (path->mnt != nd->mnt)
+		mntput(path->mnt);
+}
+
+static inline void path_to_nameidata(struct path *path, struct nameidata *nd)
+{
+	dput(nd->dentry);
+	if (nd->mnt != path->mnt)
+		mntput(nd->mnt);
+	nd->mnt = path->mnt;
+	nd->dentry = path->dentry;
+}
+
 static __always_inline int __do_follow_link(struct path *path, struct nameidata *nd)
 {
 	int error;
@@ -555,8 +571,11 @@ static __always_inline int __do_follow_l
 	touch_atime(path->mnt, dentry);
 	nd_set_link(nd, NULL);
 
-	if (path->mnt == nd->mnt)
-		mntget(path->mnt);
+	if (path->mnt != nd->mnt) {
+		path_to_nameidata(path, nd);
+		dget(dentry);
+	}
+	mntget(path->mnt);
 	cookie = dentry->d_inode->i_op->follow_link(dentry, nd);
 	error = PTR_ERR(cookie);
 	if (!IS_ERR(cookie)) {
@@ -573,22 +592,6 @@ static __always_inline int __do_follow_l
 	return error;
 }
 
-static inline void dput_path(struct path *path, struct nameidata *nd)
-{
-	dput(path->dentry);
-	if (path->mnt != nd->mnt)
-		mntput(path->mnt);
-}
-
-static inline void path_to_nameidata(struct path *path, struct nameidata *nd)
-{
-	dput(nd->dentry);
-	if (nd->mnt != path->mnt)
-		mntput(nd->mnt);
-	nd->mnt = path->mnt;
-	nd->dentry = path->dentry;
-}
-
 /*
  * This limits recursive symlink follows to 8, while
  * limiting consecutive symlinks to 40.
