Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVIROXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVIROXf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVIROX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:23:29 -0400
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]:32947 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932075AbVIROXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:23:17 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 12/12] HPPFS: fix nameidata handling
Date: Sun, 18 Sep 2005 16:10:09 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <20050918141009.31461.43507.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In follow_link, we call the underlying method with the same nameidata we got -
it will then call path_release() and then dput()/mntput() on hppfs dentries /
vfsmount rather than his own, which could be problematic (I'm not really sure,
however).

This issue exists potentially also for other methods getting nameidata. Fix
this.

However, I couldn't make a lot of sense of the reference counting used in
namei.c. So I'm uncertain whether this patch makes sense. Al, please have a
critical eye toward this one. Especially, proc_pid_follow_link calls
path_release itself. Which makes me wonder a lot.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -15,6 +15,7 @@
 #include <linux/dcache.h>
 #include <linux/statfs.h>
 #include <linux/mount.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 #include <asm/fcntl.h>
 #include "os.h"
@@ -106,8 +107,12 @@ static char *dentry_name(struct dentry *
 
 static int hppfs_d_revalidate(struct dentry * dentry, struct nameidata * nd)
 {
+	struct dentry *sav_dentry;
+	struct vfsmount *sav_mnt;
+
 	int (*d_revalidate)(struct dentry *, struct nameidata *);
 	struct dentry *proc_dentry;
+	int ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
 	if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate)
@@ -115,7 +120,17 @@ static int hppfs_d_revalidate(struct den
 	else
 		return 1; /* "Still valid" code */
 
-	return (*d_revalidate)(proc_dentry, nd);
+	sav_dentry = nd->dentry;
+	sav_mnt = nd->mnt;
+
+	nd->dentry = dget(proc_dentry);
+	nd->mnt = mntget(proc_submnt);
+	ret = (*d_revalidate)(proc_dentry, nd);
+	path_release(nd);
+
+	nd->dentry = sav_dentry;
+	nd->mnt = sav_mnt;
+	return ret;
 }
 
 static struct dentry_operations hppfs_dentry_ops = {
@@ -175,6 +190,9 @@ static void hppfs_read_inode(struct inod
 static struct dentry *hppfs_lookup(struct inode *parent_ino, struct dentry *dentry,
                                   struct nameidata *nd)
 {
+	struct dentry *sav_dentry;
+	struct vfsmount *sav_mnt;
+
 	struct dentry *proc_dentry, *new, *parent;
 	struct inode *inode;
 	int err, deleted;
@@ -203,8 +221,17 @@ static struct dentry *hppfs_lookup(struc
 			up(&parent->d_inode->i_sem);
 			goto out;
 		}
+		sav_dentry = nd->dentry;
+		sav_mnt = nd->mnt;
+
+		nd->dentry = dget(proc_dentry);
+		nd->mnt = mntget(proc_submnt);
 		new = (*parent->d_inode->i_op->lookup)(parent->d_inode,
-						       proc_dentry, NULL);
+						       proc_dentry, nd);
+		path_release(nd);
+
+		nd->dentry = sav_dentry;
+		nd->mnt = sav_mnt;
 		if(new){
 			dput(proc_dentry);
 			proc_dentry = new;
@@ -213,11 +240,20 @@ static struct dentry *hppfs_lookup(struc
 	} else {
 		up(&parent->d_inode->i_sem);
 		if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate) {
-			if (!proc_dentry->d_op->d_revalidate(proc_dentry, NULL) &&
+			sav_dentry = nd->dentry;
+			sav_mnt = nd->mnt;
+
+			nd->dentry = dget(proc_dentry);
+			nd->mnt = mntget(proc_submnt);
+			if (!proc_dentry->d_op->d_revalidate(proc_dentry, nd) &&
 					!d_invalidate(proc_dentry)) {
 				dput(proc_dentry);
 				proc_dentry = ERR_PTR(-ENOENT);
 			}
+			path_release(nd);
+
+			nd->dentry = sav_dentry;
+			nd->mnt = sav_mnt;
 		}
 	}
 
@@ -248,16 +284,32 @@ static struct dentry *hppfs_lookup(struc
 
 static int hppfs_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
+	struct dentry *sav_dentry;
+	struct vfsmount *sav_mnt;
+
 	struct inode *proc_inode;
+	struct dentry *proc_dentry;
 	int (*permission) (struct inode *, int, struct nameidata *);
+	int ret;
 
-	proc_inode = HPPFS_I(inode)->proc_dentry->d_inode;
+	proc_dentry = HPPFS_I(inode)->proc_dentry;
+	proc_inode = proc_dentry->d_inode;
 	permission = proc_inode->i_op->permission;
 
 	if (permission == NULL)
 		return generic_permission(inode, mask, NULL);
 
-	return (*permission)(proc_inode, mask, nd);
+	sav_dentry = nd->dentry;
+	sav_mnt = nd->mnt;
+
+	nd->dentry = dget(proc_dentry);
+	nd->mnt = mntget(proc_submnt);
+	ret = (*permission)(proc_inode, mask, nd);
+	path_release(nd);
+
+	nd->dentry = sav_dentry;
+	nd->mnt = sav_mnt;
+	return ret;
 }
 
 static struct inode_operations hppfs_file_iops = {
@@ -794,6 +846,9 @@ static int hppfs_readlink(struct dentry 
 
 static void* hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
+	struct dentry *sav_dentry;
+	struct vfsmount *sav_mnt;
+
 	struct dentry *proc_dentry;
 	void * (*follow_link)(struct dentry *, struct nameidata *);
 	void *ret;
@@ -808,7 +863,18 @@ static void* hppfs_follow_link(struct de
 	if (follow_link == NULL)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/* We have a reference on this already - so it won't go.*/
+	sav_dentry = nd->dentry;
+	sav_mnt = nd->mnt;
+
+	nd->dentry = dget(proc_dentry);
+	nd->mnt = mntget(proc_submnt);
 	ret = follow_link(proc_dentry, nd);
+	/* XXX: would this be done normally when calling follow_link or not? */
+	path_release(nd);
+
+	nd->dentry = sav_dentry;
+	nd->mnt = sav_mnt;
 
 	return ret;
 }

