Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbUJYVzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUJYVzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUJYPNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:13:04 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:54184 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261847AbUJYOom convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:44:42 -0400
Cc: raven@themaw.net
Subject: [PATCH 12/28] VFS: Remove (now bogus) check_mnt
In-Reply-To: <1098715442105@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:44:33 -0400
Message-Id: <10987154731896@sun.com>
References: <1098715442105@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check_mnt used to be used to see if a mountpoint was actually grafted or not
to a namespace.  This was done because we didn't support mountpoints being
attached to one another if they weren't associated with a namespace. We now
support this, so all check_mnt calls are bogus.  The only exception is that
pivot_root still requires all participants to exist within the same
namespace.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 namespace.c |   41 +++++++++++------------------------------
 1 files changed, 11 insertions(+), 30 deletions(-)

Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:38.881553248 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:39.557450496 -0400
@@ -124,14 +124,8 @@ struct vfsmount *lookup_mnt(struct vfsmo
 	spin_unlock(&vfsmount_lock);
 	return found;
 }
-
 EXPORT_SYMBOL(lookup_mnt);
 
-static inline int check_mnt(struct vfsmount *mnt)
-{
-	return mnt->mnt_namespace == current->namespace;
-}
-
 static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
 {
 	struct list_head *next = p->mnt_mounts.next;
@@ -701,8 +695,6 @@ asmlinkage long sys_umount(char __user *
 	retval = -EINVAL;
 	if (nd.dentry != nd.mnt->mnt_root)
 		goto dput_and_out;
-	if (!check_mnt(nd.mnt))
-		goto dput_and_out;
 
 	retval = -EPERM;
 	if (!capable(CAP_SYS_ADMIN))
@@ -867,14 +859,11 @@ static int do_loopback(struct nameidata 
 		return err;
 
 	down_write(&current->namespace->sem);
-	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
-		err = -ENOMEM;
-		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry, 0);
-		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry, 0);
-	}
+	err = -ENOMEM;
+	if (recurse)
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry, 0);
+	else
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry, 0);
 
 	if (mnt) {
 		/* stop bind mounts from expiring */
@@ -912,9 +901,6 @@ static int do_remount(struct nameidata *
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!check_mnt(nd->mnt))
-		return -EINVAL;
-
 	if (nd->dentry != nd->mnt->mnt_root)
 		return -EINVAL;
 
@@ -945,9 +931,6 @@ static int do_move_mount(struct nameidat
 	down_write(&current->namespace->sem);
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
-	err = -EINVAL;
-	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
-		goto out;
 
 	err = -ENOENT;
 	down(&nd->dentry->d_inode->i_sem);
@@ -984,7 +967,6 @@ out2:
 	spin_unlock(&vfsmount_lock);
 out1:
 	up(&nd->dentry->d_inode->i_sem);
-out:
 	up_write(&current->namespace->sem);
 	if (!err)
 		path_release(&parent_nd);
@@ -1028,9 +1010,6 @@ int do_graft_mount(struct vfsmount *newm
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
-	err = -EINVAL;
-	if (!check_mnt(nd->mnt))
-		goto unlock;
 
 	/* Refuse the same filesystem on the same mount point */
 	err = -EBUSY;
@@ -1569,9 +1548,6 @@ asmlinkage long sys_pivot_root(const cha
 	error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
 	if (error)
 		goto out0;
-	error = -EINVAL;
-	if (!check_mnt(new_nd.mnt))
-		goto out1;
 
 	error = __user_walk(put_old, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
 	if (error)
@@ -1589,9 +1565,14 @@ asmlinkage long sys_pivot_root(const cha
 	read_unlock(&current->fs->lock);
 	down_write(&current->namespace->sem);
 	down(&old_nd.dentry->d_inode->i_sem);
+	
+	/* All mountpoints must exist within the same namespace */
 	error = -EINVAL;
-	if (!check_mnt(user_nd.mnt))
+	if (user_nd.mnt->mnt_namespace != current->namespace
+	 || user_nd.mnt->mnt_namespace != old_nd.mnt->mnt_namespace
+	 || user_nd.mnt->mnt_namespace != new_nd.mnt->mnt_namespace)
 		goto out2;
+
 	error = -ENOENT;
 	if (IS_DEADDIR(new_nd.dentry->d_inode))
 		goto out2;

