Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273456AbRINTDO>; Fri, 14 Sep 2001 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273453AbRINTDG>; Fri, 14 Sep 2001 15:03:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46757 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273449AbRINTCv>;
	Fri, 14 Sep 2001 15:02:51 -0400
Date: Fri, 14 Sep 2001 15:03:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lazy umount (3/4)
In-Reply-To: <Pine.GSO.4.21.0109141502090.11172-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109141502430.11172-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3/4:
	New function - check_mnt(). Checks that vfsmount is an ancestor
of root_vfsmnt.  Calls added - since we are going to do lazy umount we
should take care of mounting on something that is busy, but already umounted.
Fixed leak in pivot_root(2)


diff -urN S10-pre9-root_vfsmnt/fs/super.c S10-pre9-check_mnt/fs/super.c
--- S10-pre9-root_vfsmnt/fs/super.c	Fri Sep 14 14:03:34 2001
+++ S10-pre9-check_mnt/fs/super.c	Fri Sep 14 14:04:01 2001
@@ -327,6 +327,15 @@
 	return p;
 }
 
+static int check_mnt(struct vfsmount *mnt)
+{
+	spin_lock(&dcache_lock);
+	while (mnt->mnt_parent != mnt)
+		mnt = mnt->mnt_parent;
+	spin_unlock(&dcache_lock);
+	return mnt == root_vfsmnt;
+}
+
 static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)
 {
 	old_nd->dentry = mnt->mnt_mountpoint;
@@ -1226,6 +1235,8 @@
 	retval = -EINVAL;
 	if (nd.dentry != nd.mnt->mnt_root)
 		goto dput_and_out;
+	if (!check_mnt(nd.mnt))
+		goto dput_and_out;
 
 	retval = -EPERM;
 	if (!capable(CAP_SYS_ADMIN) && current->uid!=nd.mnt->mnt_owner)
@@ -1277,7 +1288,7 @@
 static int do_loopback(struct nameidata *nd, char *old_name)
 {
 	struct nameidata old_nd;
-	struct vfsmount *mnt;
+	struct vfsmount *mnt = NULL;
 	int err;
 
 	err = mount_is_safe(nd);
@@ -1293,12 +1304,16 @@
 		return err;
 
 	down(&mount_sem);
-	err = -ENOMEM;
-	mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+	err = -EINVAL;
+	if (check_mnt(nd->mnt)) {
+		err = -ENOMEM;
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+	}
 	if (mnt) {
 		err = graft_tree(mnt, nd);
 		mntput(mnt);
 	}
+
 	up(&mount_sem);
 	path_release(&old_nd);
 	return err;
@@ -1318,6 +1333,9 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!check_mnt(nd->mnt))
+		return -EINVAL;
+
 	if (nd->dentry != nd->mnt->mnt_root)
 		return -EINVAL;
 
@@ -1396,27 +1414,31 @@
 			int mnt_flags, char *name, void *data)
 {
 	struct vfsmount *mnt = do_kern_mount(type, flags, name, data);
-	int retval = PTR_ERR(mnt);
+	int err = PTR_ERR(mnt);
 
 	if (IS_ERR(mnt))
 		goto out;
 
-	mnt->mnt_flags = mnt_flags;
-
 	down(&mount_sem);
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
+	err = -EINVAL;
+	if (!check_mnt(nd->mnt))
+		goto unlock;
 
 	/* Refuse the same filesystem on the same mount point */
+	err = -EBUSY;
 	if (nd->mnt->mnt_sb == mnt->mnt_sb && nd->mnt->mnt_root == nd->dentry)
-		retval = -EBUSY;
-	else
-		retval = graft_tree(mnt, nd);
+		goto unlock;
+
+	mnt->mnt_flags = mnt_flags;
+	err = graft_tree(mnt, nd);
+unlock:
 	up(&mount_sem);
 	mntput(mnt);
 out:
-	return retval;
+	return err;
 }
 
 static int copy_mount_options (const void *data, unsigned long *where)
@@ -1772,10 +1794,8 @@
 
 asmlinkage long sys_pivot_root(const char *new_root, const char *put_old)
 {
-	struct dentry *root;
-	struct vfsmount *root_mnt;
 	struct vfsmount *tmp;
-	struct nameidata new_nd, old_nd, parent_nd, root_parent;
+	struct nameidata new_nd, old_nd, parent_nd, root_parent, user_nd;
 	char *name;
 	int error;
 
@@ -1794,11 +1814,14 @@
 	putname(name);
 	if (error)
 		goto out0;
+	error = -EINVAL;
+	if (!check_mnt(new_nd.mnt))
+		goto out1;
 
 	name = getname(put_old);
 	error = PTR_ERR(name);
 	if (IS_ERR(name))
-		goto out0;
+		goto out1;
 	error = 0;
 	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd))
 		error = path_walk(name, &old_nd);
@@ -1807,11 +1830,14 @@
 		goto out1;
 
 	read_lock(&current->fs->lock);
-	root_mnt = mntget(current->fs->rootmnt);
-	root = dget(current->fs->root);
+	user_nd.mnt = mntget(current->fs->rootmnt);
+	user_nd.dentry = dget(current->fs->root);
 	read_unlock(&current->fs->lock);
 	down(&mount_sem);
 	down(&old_nd.dentry->d_inode->i_zombie);
+	error = -EINVAL;
+	if (!check_mnt(user_nd.mnt))
+		goto out2;
 	error = -ENOENT;
 	if (IS_DEADDIR(new_nd.dentry->d_inode))
 		goto out2;
@@ -1820,10 +1846,10 @@
 	if (d_unhashed(old_nd.dentry) && !IS_ROOT(old_nd.dentry))
 		goto out2;
 	error = -EBUSY;
-	if (new_nd.mnt == root_mnt || old_nd.mnt == root_mnt)
+	if (new_nd.mnt == user_nd.mnt || old_nd.mnt == user_nd.mnt)
 		goto out2; /* loop */
 	error = -EINVAL;
-	if (root_mnt->mnt_root != root)
+	if (user_nd.mnt->mnt_root != user_nd.dentry)
 		goto out2;
 	if (new_nd.mnt->mnt_root != new_nd.dentry)
 		goto out2; /* not a mountpoint */
@@ -1842,19 +1868,18 @@
 	} else if (!is_subdir(old_nd.dentry, new_nd.dentry))
 		goto out3;
 	detach_mnt(new_nd.mnt, &parent_nd);
-	detach_mnt(root_mnt, &root_parent);
-	attach_mnt(root_mnt, &old_nd);
+	detach_mnt(user_nd.mnt, &root_parent);
+	attach_mnt(user_nd.mnt, &old_nd);
 	attach_mnt(new_nd.mnt, &root_parent);
 	spin_unlock(&dcache_lock);
-	chroot_fs_refs(root,root_mnt,new_nd.dentry,new_nd.mnt);
+	chroot_fs_refs(user_nd.dentry,user_nd.mnt,new_nd.dentry,new_nd.mnt);
 	error = 0;
 	path_release(&root_parent);
 	path_release(&parent_nd);
 out2:
 	up(&old_nd.dentry->d_inode->i_zombie);
 	up(&mount_sem);
-	dput(root);
-	mntput(root_mnt);
+	path_release(&user_nd);
 	path_release(&old_nd);
 out1:
 	path_release(&new_nd);


