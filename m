Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271165AbRICDrF>; Sun, 2 Sep 2001 23:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271182AbRICDqz>; Sun, 2 Sep 2001 23:46:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26275 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271165AbRICDqi>;
	Sun, 2 Sep 2001 23:46:38 -0400
Date: Sun, 2 Sep 2001 23:46:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup in fs/super.c (do_kern_mount())
Message-ID: <Pine.GSO.4.21.0109022339300.22951-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New helper function: do_kern_mount() (aka. kern_mount() donw right).
do_add_mount() and kern_mount() are using it - it does all work of
do_add_mount() except actual attaching new vfsmount to the tree. Unlike
kern_mount() it allows to pass flags/options - as the matter of fact, that's
what kern_mount() should've been: mount(2) without attaching to any mountpoint.
Quite a few people (intermezzo folks, supermount, yodda, yodda) had been
asking for that for quite a while.

Please, apply.

diff -urN S10-pre4/fs/super.c S10-pre4-do_kern_mount/fs/super.c
--- S10-pre4/fs/super.c	Sun Sep  2 23:22:20 2001
+++ S10-pre4-do_kern_mount/fs/super.c	Sun Sep  2 23:28:26 2001
@@ -418,6 +418,9 @@
 
 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
 {
+	if (mnt->mnt_sb->s_flags & MS_NOUSER)
+		return -EINVAL;
+
 	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
 	      S_ISDIR(mnt->mnt_root->d_inode->i_mode))
 		return -ENOTDIR;
@@ -1177,31 +1180,6 @@
 	return 0;
 }
 
-struct vfsmount *kern_mount(struct file_system_type *type)
-{
-	struct super_block *sb;
-	struct vfsmount *mnt = alloc_vfsmnt();
-
-	if (!mnt)
-		return ERR_PTR(-ENOMEM);
-
-	if (type->fs_flags & FS_SINGLE)
-		sb = get_sb_single(type, 0, NULL);
-	else
-		sb = get_sb_nodev(type, 0, NULL);
-	if (IS_ERR(sb)) {
-		kmem_cache_free(mnt_cache, mnt);
-		return (struct vfsmount *)sb;
-	}
-	mnt->mnt_sb = sb;
-	mnt->mnt_root = dget(sb->s_root);
-	mnt->mnt_mountpoint = mnt->mnt_root;
-	mnt->mnt_parent = mnt;
-	up_write(&sb->s_umount);
-	up(&mount_sem);
-	return mnt;
-}
-
 /*
  * Doesn't take quota and stuff into account. IOW, in some cases it will
  * give false negatives. The main reason why it's here is that we need
@@ -1428,31 +1406,30 @@
 	return err;
 }
 
-static int do_add_mount(struct nameidata *nd, char *type, int flags,
-			char *name, void *data)
+struct vfsmount *do_kern_mount(char *type, int flags, char *name, void *data)
 {
 	struct file_system_type * fstype;
 	struct vfsmount *mnt = NULL;
 	struct super_block *sb;
-	int retval = 0;
 
 	if (!type || !memchr(type, 0, PAGE_SIZE))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/* we need capabilities... */
 	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+		return ERR_PTR(-EPERM);
 
 	/* ... filesystem driver... */
 	fstype = get_fs_type(type);
 	if (!fstype)		
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
 	/* ... allocated vfsmount... */
-	retval = -ENOMEM;
 	mnt = alloc_vfsmnt();
-	if (!mnt)
+	if (!mnt) {
+		mnt = ERR_PTR(-ENOMEM);
 		goto fs_out;
+	}
 	if (name) {
 		mnt->mnt_devname = kmalloc(strlen(name)+1, GFP_KERNEL);
 		if (mnt->mnt_devname)
@@ -1460,42 +1437,62 @@
 	}
 
 	/* get superblock, locks mount_sem on success */
-	if (fstype->fs_flags & FS_NOMOUNT)
-		sb = ERR_PTR(-EINVAL);
-	else if (fstype->fs_flags & FS_REQUIRES_DEV)
+	if (fstype->fs_flags & FS_REQUIRES_DEV)
 		sb = get_sb_bdev(fstype, name, flags, data);
 	else if (fstype->fs_flags & FS_SINGLE)
 		sb = get_sb_single(fstype, flags, data);
 	else
 		sb = get_sb_nodev(fstype, flags, data);
 
-	retval = PTR_ERR(sb);
 	if (IS_ERR(sb)) {
 		if (mnt->mnt_devname)
 			kfree(mnt->mnt_devname);
 		kmem_cache_free(mnt_cache, mnt);
+		mnt = (struct vfsmount *)sb;
 		goto fs_out;
 	}
+	if (fstype->fs_flags & FS_NOMOUNT)
+		sb->s_flags |= MS_NOUSER;
 
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
 	up_write(&sb->s_umount);
+fs_out:
+	put_filesystem(fstype);
+	return mnt;
+}
+
+struct vfsmount *kern_mount(struct file_system_type *type)
+{
+	char *name = (char *)type->name;
+	struct vfsmount *mnt = do_kern_mount(name, 0, name, NULL);
+	up(&mount_sem);
+	return mnt;
+}
+
+static int do_add_mount(struct nameidata *nd, char *type, int flags,
+			char *name, void *data)
+{
+	struct vfsmount *mnt = do_kern_mount(type, flags, name, data);
+	int retval = PTR_ERR(mnt);
+
+	if (IS_ERR(mnt))
+		goto out;
 
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
 
 	/* Refuse the same filesystem on the same mount point */
-	if (nd->mnt->mnt_sb == sb && nd->mnt->mnt_root == nd->dentry)
+	if (nd->mnt->mnt_sb == mnt->mnt_sb && nd->mnt->mnt_root == nd->dentry)
 		retval = -EBUSY;
 	else
 		retval = graft_tree(mnt, nd);
 	mntput(mnt);
 	up(&mount_sem);
-fs_out:
-	put_filesystem(fstype);
+out:
 	return retval;
 }
 
diff -urN S10-pre4/include/linux/fs.h S10-pre4-do_kern_mount/include/linux/fs.h
--- S10-pre4/include/linux/fs.h	Sun Sep  2 23:22:20 2001
+++ S10-pre4-do_kern_mount/include/linux/fs.h	Sun Sep  2 23:28:26 2001
@@ -108,6 +108,7 @@
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
+#define MS_NOUSER	(1<<31)
 
 /*
  * Flags that can be altered by MS_REMOUNT

