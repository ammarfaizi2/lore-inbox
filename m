Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269870AbRHIXa2>; Thu, 9 Aug 2001 19:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269872AbRHIXaT>; Thu, 9 Aug 2001 19:30:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37542 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269870AbRHIXaF>;
	Thu, 9 Aug 2001 19:30:05 -0400
Date: Thu, 9 Aug 2001 19:30:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c fixes (1/8)
Message-ID: <Pine.GSO.4.21.0108091927021.25945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, I'm resubmitting this stuff - it got a lot of local testing
plus public one in -ac.  It's split in 8 chunks, so that will be 8 sepatate
mails (each with patch description). I hope each of them is small and
obvious enough. Patches are incremental to each other and start at 2.4.8-pre7.
Please, apply.

Part 1/8:

->mnt_instances/->s_mounts list is gone. It is replaced by ->s_active - amount
of vfsmounts over given superblock. All accesses are under mount_sem right
now.

diff -urN S8-pre7/fs/super.c S8-pre7-mnt_instances/fs/super.c
--- S8-pre7/fs/super.c	Tue Jul  3 21:09:13 2001
+++ S8-pre7-mnt_instances/fs/super.c	Thu Aug  9 19:07:31 2001
@@ -386,19 +386,20 @@
 	mnt->mnt_parent = mnt;
 
 	spin_lock(&dcache_lock);
-	list_add(&mnt->mnt_instances, &sb->s_mounts);
 	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
+	atomic_inc(&sb->s_active);
 	if (sb->s_type->fs_flags & FS_SINGLE)
 		get_filesystem(sb->s_type);
 out:
 	return mnt;
 }
 
-static struct vfsmount *clone_mnt(struct vfsmount *old_mnt, struct dentry *root)
+static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
 {
-	char *name = old_mnt->mnt_devname;
+	char *name = old->mnt_devname;
 	struct vfsmount *mnt = alloc_vfsmnt();
+	struct super_block *sb = old->mnt_sb;
 
 	if (!mnt)
 		goto out;
@@ -408,14 +409,12 @@
 		if (mnt->mnt_devname)
 			strcpy(mnt->mnt_devname, name);
 	}
-	mnt->mnt_sb = old_mnt->mnt_sb;
+	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
 
-	spin_lock(&dcache_lock);
-	list_add(&mnt->mnt_instances, &old_mnt->mnt_instances);
-	spin_unlock(&dcache_lock);
+	atomic_inc(&sb->s_active);
 out:
 	return mnt;
 }
@@ -487,9 +486,6 @@
 	struct super_block *sb = mnt->mnt_sb;
 
 	dput(mnt->mnt_root);
-	spin_lock(&dcache_lock);
-	list_del(&mnt->mnt_instances);
-	spin_unlock(&dcache_lock);
 	if (mnt->mnt_devname)
 		kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
@@ -757,9 +753,9 @@
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		list_add (&s->s_list, super_blocks.prev);
 		INIT_LIST_HEAD(&s->s_files);
-		INIT_LIST_HEAD(&s->s_mounts);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
+		atomic_set(&s->s_active, 0);
 		sema_init(&s->s_vfs_rename_sem,1);
 		sema_init(&s->s_nfsd_free_path_sem,1);
 		sema_init(&s->s_dquot.dqio_sem, 1);
@@ -938,12 +934,9 @@
 	struct file_system_type *fs = sb->s_type;
 	struct super_operations *sop = sb->s_op;
 
-	spin_lock(&dcache_lock);
-	if (!list_empty(&sb->s_mounts)) {
-		spin_unlock(&dcache_lock);
+	atomic_dec(&sb->s_active);
+	if (atomic_read(&sb->s_active))
 		return;
-	}
-	spin_unlock(&dcache_lock);
 	down_write(&sb->s_umount);
 	lock_kernel();
 	sb->s_root = NULL;
@@ -1045,9 +1038,7 @@
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	spin_lock(&dcache_lock);
-	list_add(&mnt->mnt_instances, &sb->s_mounts);
-	spin_unlock(&dcache_lock);
+	atomic_inc(&sb->s_active);
 	type->kern_mnt = mnt;
 	return mnt;
 }
@@ -1092,7 +1083,7 @@
 
 	spin_lock(&dcache_lock);
 
-	if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
+	if (atomic_read(&sb->s_active) > 1) {
 		if (atomic_read(&mnt->mnt_count) > 2) {
 			spin_unlock(&dcache_lock);
 			return -EBUSY;
@@ -1324,9 +1315,7 @@
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	spin_lock(&dcache_lock);
-	list_add(&mnt->mnt_instances, &sb->s_mounts);
-	spin_unlock(&dcache_lock);
+	atomic_inc(&sb->s_active);
 
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
diff -urN S8-pre7/include/linux/fs.h S8-pre7-mnt_instances/include/linux/fs.h
--- S8-pre7/include/linux/fs.h	Wed Aug  8 17:54:56 2001
+++ S8-pre7-mnt_instances/include/linux/fs.h	Thu Aug  9 19:07:31 2001
@@ -680,13 +680,13 @@
 	struct dentry		*s_root;
 	struct rw_semaphore	s_umount;
 	struct semaphore	s_lock;
+	atomic_t		s_active;
 
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_locked_inodes;/* inodes being synced */
 	struct list_head	s_files;
 
 	struct block_device	*s_bdev;
-	struct list_head	s_mounts;	/* vfsmount(s) of this one */
 	struct quota_mount_options s_dquot;	/* Diskquota specific options */
 
 	union {
diff -urN S8-pre7/include/linux/mount.h S8-pre7-mnt_instances/include/linux/mount.h
--- S8-pre7/include/linux/mount.h	Tue Jul  3 21:09:14 2001
+++ S8-pre7-mnt_instances/include/linux/mount.h	Thu Aug  9 19:07:31 2001
@@ -18,7 +18,6 @@
 	struct vfsmount *mnt_parent;	/* fs we are mounted on */
 	struct dentry *mnt_mountpoint;	/* dentry of mountpoint */
 	struct dentry *mnt_root;	/* root of the mounted tree */
-	struct list_head mnt_instances;	/* other vfsmounts of the same fs */
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */

