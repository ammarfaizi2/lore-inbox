Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263358AbRFEVFL>; Tue, 5 Jun 2001 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263359AbRFEVFB>; Tue, 5 Jun 2001 17:05:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21687 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263358AbRFEVEx>;
	Tue, 5 Jun 2001 17:04:53 -0400
Date: Tue, 5 Jun 2001 17:04:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more fs/super.c cleanups (4)
Message-ID: <Pine.GSO.4.21.0106051648170.4799-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chunk 4: OK, this one is interesting.
	* new function - graft_tree(what, where). It does necessary locking
and checks and mounts existing vfsmount on given point. Basically, it's the
common part of mounting and binding. Checks are usual - mountpoint is not
dead, we are not trying to mount directory on non-directory or vice versa.
	* clone_mnt(vfsmount, root) - creates vfsmount of subtree.
	* do_loopback() turned into "find what we want to bind, clone that
vfsmount setting its root to that dentry and graft it on mountpoint"
	* do_add_mount() (aka. normal mounting) is "allocate vfsmount, then
find superblock, then attach it to already allocated vfsmount, check that
we are not stacking it onto the same fs and graft on mountpoint". The good
thing being: we are done with the ugliness on the "can't mount here, need
to kill superblock". We simply do mntput() on the vfsmount we have. Always.
If it was successfully grafted on the mountpoint - fine, we are left with
->mnt_count == 1. If we didn't make it - last reference goes away and we
are doing the right thing again.

Another good thing is that vfsmount allocation is gone from the area where
we keep mountpoint locked. That helps later big way, since we can clean
the mount/rmdir and mount/unlink race-prevention nicely - it's easier if
we can get the critical area in mount non-blocking.

	Please, apply.
								Al


diff -urN S6-pre1-do_add_mount/fs/super.c S6-pre1-graft_tree/fs/super.c
--- S6-pre1-do_add_mount/fs/super.c	Tue Jun  5 08:16:35 2001
+++ S6-pre1-graft_tree/fs/super.c	Tue Jun  5 08:17:28 2001
@@ -330,9 +330,7 @@
  *	dentry (if any).
  */
 
-static struct vfsmount *add_vfsmnt(struct nameidata *nd,
-				struct dentry *root,
-				const char *dev_name)
+static struct vfsmount *add_vfsmnt(struct dentry *root, const char *dev_name)
 {
 	struct vfsmount *mnt;
 	struct super_block *sb = root->d_inode->i_sb;
@@ -351,18 +349,11 @@
 		}
 	}
 	mnt->mnt_sb = sb;
-
-	spin_lock(&dcache_lock);
-	if (nd && !IS_ROOT(nd->dentry) && d_unhashed(nd->dentry))
-		goto fail;
 	mnt->mnt_root = dget(root);
+	mnt->mnt_mountpoint = mnt->mnt_root;
+	mnt->mnt_parent = mnt;
 
-	if (nd) {
-		attach_mnt(mnt, nd);
-	} else {
-		mnt->mnt_mountpoint = mnt->mnt_root;
-		mnt->mnt_parent = mnt;
-	}
+	spin_lock(&dcache_lock);
 	list_add(&mnt->mnt_instances, &sb->s_mounts);
 	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
@@ -370,12 +361,60 @@
 		get_filesystem(sb->s_type);
 out:
 	return mnt;
+}
+
+static struct vfsmount *clone_mnt(struct vfsmount *old_mnt, struct dentry *root)
+{
+	char *name = old_mnt->mnt_devname;
+	struct vfsmount *mnt = alloc_vfsmnt();
+
+	if (!mnt)
+		goto out;
+
+	if (name) {
+		mnt->mnt_devname = kmalloc(strlen(name)+1, GFP_KERNEL);
+		if (mnt->mnt_devname)
+			strcpy(mnt->mnt_devname, name);
+	}
+	mnt->mnt_sb = old_mnt->mnt_sb;
+	mnt->mnt_root = dget(root);
+	mnt->mnt_mountpoint = mnt->mnt_root;
+	mnt->mnt_parent = mnt;
+
+	spin_lock(&dcache_lock);
+	list_add(&mnt->mnt_instances, &old_mnt->mnt_instances);
+	spin_unlock(&dcache_lock);
+out:
+	return mnt;
+}
+
+static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
+{
+	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
+	      S_ISDIR(mnt->mnt_root->d_inode->i_mode))
+		return -ENOTDIR;
+
+	down(&nd->dentry->d_inode->i_zombie);
+	if (IS_DEADDIR(nd->dentry->d_inode))
+		goto fail1;
+
+	spin_lock(&dcache_lock);
+	if (!IS_ROOT(nd->dentry) && d_unhashed(nd->dentry))
+		goto fail;
+
+	attach_mnt(mnt, nd);
+	list_add(&mnt->mnt_list, vfsmntlist.prev);
+	spin_unlock(&dcache_lock);
+	up(&nd->dentry->d_inode->i_zombie);
+	if (mnt->mnt_sb->s_type->fs_flags & FS_SINGLE)
+		get_filesystem(mnt->mnt_sb->s_type);
+	mntget(mnt);
+	return 0;
 fail:
 	spin_unlock(&dcache_lock);
-	if (mnt->mnt_devname)
-		kfree(mnt->mnt_devname);
-	kfree(mnt);
-	return NULL;
+fail1:
+	up(&nd->dentry->d_inode->i_zombie);
+	return -ENOENT;
 }
 
 static void move_vfsmnt(struct vfsmount *mnt,
@@ -1154,35 +1193,30 @@
 static int do_loopback(struct nameidata *nd, char *old_name)
 {
 	struct nameidata old_nd;
-	int err = 0;
+	struct vfsmount *mnt;
+	int err;
+
+	err = mount_is_safe(nd);
+	if (err)
+		return err;
+
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE, &old_nd))
+
+	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
 		err = path_walk(old_name, &old_nd);
 	if (err)
-		goto out;
-	err = mount_is_safe(nd);
-	if (err)
-		goto out1;
-	err = -EINVAL;
-	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
-	      S_ISDIR(old_nd.dentry->d_inode->i_mode))
-		goto out1;
+		return err;
 
 	err = -ENOMEM;
-		
-	down(&mount_sem);
-	/* there we go */
-	down(&nd->dentry->d_inode->i_zombie);
-	if (IS_DEADDIR(nd->dentry->d_inode))
-		err = -ENOENT;
-	else if (add_vfsmnt(nd, old_nd.dentry, old_nd.mnt->mnt_devname))
-		err = 0;
-	up(&nd->dentry->d_inode->i_zombie);
-	up(&mount_sem);
-out1:
+	mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+	if (mnt) {
+		down(&mount_sem);
+		err = graft_tree(mnt, nd);
+		up(&mount_sem);
+		mntput(mnt);
+	}
 	path_release(&old_nd);
-out:
 	return err;
 }
 
@@ -1207,7 +1241,6 @@
 			char *name, void *data)
 {
 	struct file_system_type * fstype;
-	struct nameidata nd;
 	struct vfsmount *mnt = NULL;
 	struct super_block *sb;
 	int retval = 0;
@@ -1224,6 +1257,17 @@
 	if (!fstype)		
 		return -ENODEV;
 
+	/* ... allocated vfsmount... */
+	retval = -ENOMEM;
+	mnt = alloc_vfsmnt();
+	if (!mnt)
+		goto fs_out;
+	if (name) {
+		mnt->mnt_devname = kmalloc(strlen(name)+1, GFP_KERNEL);
+		if (mnt->mnt_devname)
+			strcpy(mnt->mnt_devname, name);
+	}
+
 	/* get superblock, locks mount_sem on success */
 	if (fstype->fs_flags & FS_NOMOUNT)
 		sb = ERR_PTR(-EINVAL);
@@ -1235,42 +1279,35 @@
 		sb = get_sb_nodev(fstype, flags, data);
 
 	retval = PTR_ERR(sb);
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		if (mnt->mnt_devname)
+			kfree(mnt->mnt_devname);
+		kfree(mnt);
 		goto fs_out;
+	}
+
+	mnt->mnt_sb = sb;
+	mnt->mnt_root = dget(sb->s_root);
+	mnt->mnt_mountpoint = mnt->mnt_root;
+	mnt->mnt_parent = mnt;
+	spin_lock(&dcache_lock);
+	list_add(&mnt->mnt_instances, &sb->s_mounts);
+	spin_unlock(&dcache_lock);
 
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
 
 	/* Refuse the same filesystem on the same mount point */
-	retval = -EBUSY;
 	if (nd->mnt->mnt_sb == sb && nd->mnt->mnt_root == nd->dentry)
-		goto fail;
-
-	retval = -ENOENT;
-	if (!nd->dentry->d_inode)
-		goto fail;
-	retval = -ENOTDIR;
-	if (!S_ISDIR(nd->dentry->d_inode->i_mode))
-		goto fail;
-	down(&nd->dentry->d_inode->i_zombie);
-	if (!IS_DEADDIR(nd->dentry->d_inode)) {
-		retval = -ENOMEM;
-		mnt = add_vfsmnt(nd, sb->s_root, name);
-	}
-	up(&nd->dentry->d_inode->i_zombie);
-	if (!mnt)
-		goto fail;
-	retval = 0;
-unlock_out:
+		retval = -EBUSY;
+	else
+		retval = graft_tree(mnt, nd);
+	mntput(mnt);
 	up(&mount_sem);
 fs_out:
 	put_filesystem(fstype);
 	return retval;
-
-fail:
-	kill_super(sb);
-	goto unlock_out;
 }
 
 static int copy_mount_options (const void *data, unsigned long *where)
@@ -1540,10 +1577,10 @@
 		devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT,
 				  path + 5 + path_start, NULL, NULL);
 		memcpy (path + path_start, "/dev/", 5);
-		vfsmnt = add_vfsmnt(NULL, sb->s_root, path + path_start);
+		vfsmnt = add_vfsmnt(sb->s_root, path + path_start);
 	}
 	else
-		vfsmnt = add_vfsmnt(NULL, sb->s_root, "/dev/root");
+		vfsmnt = add_vfsmnt(sb->s_root, "/dev/root");
 	/* FIXME: if something will try to umount us right now... */
 	if (vfsmnt) {
 		set_fs_root(current->fs, vfsmnt, sb->s_root);

