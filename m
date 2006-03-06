Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWCFOEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWCFOEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 09:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWCFOEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 09:04:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750792AbWCFOEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 09:04:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060302213359.7282.14615.stgit@warthog.cambridge.redhat.com> 
References: <20060302213359.7282.14615.stgit@warthog.cambridge.redhat.com>  <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] NFS: Permit filesystem to override root dentry on mount [try #4] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Mon, 06 Mar 2006 14:03:45 +0000
Message-ID: <9447.1141653825@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] NFS: Permit filesystem to override root dentry on mount

From: David Howells <dhowells@redhat.com>

The attached patch extends the get_sb() filesystem operation to take an extra
argument that permits the VFS to pass in the target vfsmount that defines the
mountpoint.

The filesystem is then required to manually set the superblock and root dentry
pointers. For most filesystems, this should be done with simple_set_mnt() which
will set the superblock pointer and then set the root dentry to the
superblock's s_root (as per the old default behaviour).

This patch permits a superblock to be implicitly shared amongst several mount
points, such as can be done with NFS to avoid potential inode aliasing (see
patch 5/5). In such a case, simple_set_mnt() would not be called, and instead
the mnt_root and mnt_sb would be set directly.

This patch also changes the superblock cleanup routine to make it use
shrink_dcache_sb() instead of shrink_dcache_anon(). This required is
because the superblock may now have multiple trees that aren't
actually bound to s_root, but that still need to be cleaned up. The
currently called functions assume that the whole tree is rooted at
s_root, and that anonymous dentries are not the roots of trees which
results in dentries being left unculled.

Following discussion with Al Viro, the following changes [try #2] were
made to the previous attempt at this set of patches:

 (*) The vfsmount is now passed into the get_sb() method for a filesystem
     instead of passing a pointer to a pointer to a dentry into which get_sb()
     could stick a root dentry if it wanted. get_sb() now instantiates the
     superblock and root dentry pointers in the vfsmount itself.

 (*) The get_sb() method now returns an integer (0 or -ve error number) rather
     than the superblock pointer or cast error number.

 (*) the get_sb_*() convenience functions in the core kernel now take a
     vfsmount pointer argument and return an integer, so most filesystems have
     to change very little.

 (*) If one of the convenience function is not used, then get_sb() should
     normally call simple_set_mnt() to instantiate the vfsmount. This will
     always return 0, and so can be tail-called from get_sb().

 (*) generic_shutdown_super() now calls shrink_dcache_sb() to clean up the
     dcache upon superblock destruction rather than shrink_dcache_parent() and
     shrink_dcache_anon(). This is because, as far as I can tell, the current
     code assumes that all the dentries will be linked into a tree depending
     from sb->s_root, and that anonymous dentries won't have children.

     However, with the way these patches implement NFS superblock sharing,
     these assumptions are violated: the root of the filesystem is simply a
     dummy dentry and inode (the real inode for '/' may well be inaccessible),
     and all the vfsmounts are rooted on anonymous[*] dentries with child
     trees.

     [*] Anonymous until discovered from another tree.

Further changes [try #3] that have been made:

 (*) The patches are now against Trond's NFS git tree, so won't apply to
     Linus's tree.

 (*) Documentation changes have been moved from patch 2/5 to 1/5.

Further changes [try #4]:

 (*) shrink_dcache_parent() has been reintroduced to handle final cleanup of
     filesystem types such as nfsd and binfmt_misc that have pinned dentries.

 (*) get_sb_bdev() has been fixed to handle the superblock sharing case
     correctly (it should not go down the error path).

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/porting |    7 ++-
 fs/libfs.c                        |   12 ++---
 fs/namespace.c                    |    9 ++++
 fs/super.c                        |   92 ++++++++++++++++++++-----------------
 include/linux/fs.h                |   25 ++++++----
 5 files changed, 84 insertions(+), 61 deletions(-)

diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index 2f38846..ae8db97 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -50,10 +50,11 @@ Turn your foo_read_super() into a functi
 success and negative number in case of error (-EINVAL unless you have more
 informative error value to report).  Call it foo_fill_super().  Now declare
 
-struct super_block foo_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+int foo_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super,
+			   mnt);
 }
 
 (or similar with s/bdev/nodev/ or s/bdev/single/, depending on the kind of
diff --git a/fs/libfs.c b/fs/libfs.c
index 71fd08f..7a60a20 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -194,9 +194,9 @@ struct inode_operations simple_dir_inode
  * Common helper for pseudo-filesystems (sockfs, pipefs, bdev - stuff that
  * will never be mountable)
  */
-struct super_block *
-get_sb_pseudo(struct file_system_type *fs_type, char *name,
-	struct super_operations *ops, unsigned long magic)
+int get_sb_pseudo(struct file_system_type *fs_type, char *name,
+	struct super_operations *ops, unsigned long magic,
+	struct vfsmount *mnt)
 {
 	struct super_block *s = sget(fs_type, NULL, set_anon_super, NULL);
 	static struct super_operations default_ops = {.statfs = simple_statfs};
@@ -205,7 +205,7 @@ get_sb_pseudo(struct file_system_type *f
 	struct qstr d_name = {.name = name, .len = strlen(name)};
 
 	if (IS_ERR(s))
-		return s;
+		return PTR_ERR(s);
 
 	s->s_flags = MS_NOUSER;
 	s->s_maxbytes = ~0ULL;
@@ -230,12 +230,12 @@ get_sb_pseudo(struct file_system_type *f
 	d_instantiate(dentry, root);
 	s->s_root = dentry;
 	s->s_flags |= MS_ACTIVE;
-	return s;
+	return simple_set_mnt(mnt, s);
 
 Enomem:
 	up_write(&s->s_umount);
 	deactivate_super(s);
-	return ERR_PTR(-ENOMEM);
+	return -ENOMEM;
 }
 
 int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
diff --git a/fs/namespace.c b/fs/namespace.c
index 70bba4b..8f96212 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -86,6 +86,15 @@ struct vfsmount *alloc_vfsmnt(const char
 	return mnt;
 }
 
+int simple_set_mnt(struct vfsmount *mnt, struct super_block *sb)
+{
+	mnt->mnt_sb = sb;
+	mnt->mnt_root = dget(sb->s_root);
+	return 0;
+}
+
+EXPORT_SYMBOL(simple_set_mnt);
+
 void free_vfsmnt(struct vfsmount *mnt)
 {
 	kfree(mnt->mnt_devname);
diff --git a/fs/super.c b/fs/super.c
index e20b558..2905600 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -231,7 +231,7 @@ void generic_shutdown_super(struct super
 	if (root) {
 		sb->s_root = NULL;
 		shrink_dcache_parent(root);
-		shrink_dcache_anon(&sb->s_anon);
+		shrink_dcache_sb(sb);
 		dput(root);
 		fsync_super(sb);
 		lock_super(sb);
@@ -676,9 +676,10 @@ static void bdev_uevent(struct block_dev
 	}
 }
 
-struct super_block *get_sb_bdev(struct file_system_type *fs_type,
+int get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt)
 {
 	struct block_device *bdev;
 	struct super_block *s;
@@ -686,7 +687,7 @@ struct super_block *get_sb_bdev(struct f
 
 	bdev = open_bdev_excl(dev_name, flags, fs_type);
 	if (IS_ERR(bdev))
-		return (struct super_block *)bdev;
+		return PTR_ERR(bdev);
 
 	/*
 	 * once the super is inserted into the list by sget, s_umount
@@ -697,15 +698,17 @@ struct super_block *get_sb_bdev(struct f
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
 	up(&bdev->bd_mount_sem);
 	if (IS_ERR(s))
-		goto out;
+		goto error_s;
 
 	if (s->s_root) {
 		if ((flags ^ s->s_flags) & MS_RDONLY) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
-			s = ERR_PTR(-EBUSY);
+			error = -EBUSY;
+			goto error_bdev;
 		}
-		goto out;
+
+		close_bdev_excl(bdev);
 	} else {
 		char b[BDEVNAME_SIZE];
 
@@ -716,18 +719,21 @@ struct super_block *get_sb_bdev(struct f
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
-			s = ERR_PTR(error);
-		} else {
-			s->s_flags |= MS_ACTIVE;
-			bdev_uevent(bdev, KOBJ_MOUNT);
+			goto error;
 		}
+
+		s->s_flags |= MS_ACTIVE;
+		bdev_uevent(bdev, KOBJ_MOUNT);
 	}
 
-	return s;
+	return simple_set_mnt(mnt, s);
 
-out:
+error_s:
+	error = PTR_ERR(s);
+error_bdev:
 	close_bdev_excl(bdev);
-	return s;
+error:
+	return error;
 }
 
 EXPORT_SYMBOL(get_sb_bdev);
@@ -744,15 +750,16 @@ void kill_block_super(struct super_block
 
 EXPORT_SYMBOL(kill_block_super);
 
-struct super_block *get_sb_nodev(struct file_system_type *fs_type,
+int get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt)
 {
 	int error;
 	struct super_block *s = sget(fs_type, NULL, set_anon_super, NULL);
 
 	if (IS_ERR(s))
-		return s;
+		return PTR_ERR(s);
 
 	s->s_flags = flags;
 
@@ -760,10 +767,10 @@ struct super_block *get_sb_nodev(struct 
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
-		return ERR_PTR(error);
+		return error;
 	}
 	s->s_flags |= MS_ACTIVE;
-	return s;
+	return simple_set_mnt(mnt, s);
 }
 
 EXPORT_SYMBOL(get_sb_nodev);
@@ -773,28 +780,29 @@ static int compare_single(struct super_b
 	return 1;
 }
 
-struct super_block *get_sb_single(struct file_system_type *fs_type,
+int get_sb_single(struct file_system_type *fs_type,
 	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt)
 {
 	struct super_block *s;
 	int error;
 
 	s = sget(fs_type, compare_single, set_anon_super, NULL);
 	if (IS_ERR(s))
-		return s;
+		return PTR_ERR(s);
 	if (!s->s_root) {
 		s->s_flags = flags;
 		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
-			return ERR_PTR(error);
+			return error;
 		}
 		s->s_flags |= MS_ACTIVE;
 	}
 	do_remount_sb(s, flags, data, 0);
-	return s;
+	return simple_set_mnt(mnt, s);
 }
 
 EXPORT_SYMBOL(get_sb_single);
@@ -803,7 +811,6 @@ struct vfsmount *
 do_kern_mount(const char *fstype, int flags, const char *name, void *data)
 {
 	struct file_system_type *type = get_fs_type(fstype);
-	struct super_block *sb = ERR_PTR(-ENOMEM);
 	struct vfsmount *mnt;
 	int error;
 	char *secdata = NULL;
@@ -811,49 +818,50 @@ do_kern_mount(const char *fstype, int fl
 	if (!type)
 		return ERR_PTR(-ENODEV);
 
+	error = -ENOMEM;
 	mnt = alloc_vfsmnt(name);
 	if (!mnt)
 		goto out;
 
 	if (data) {
 		secdata = alloc_secdata();
-		if (!secdata) {
-			sb = ERR_PTR(-ENOMEM);
+		if (!secdata)
 			goto out_mnt;
-		}
 
 		error = security_sb_copy_data(type, data, secdata);
-		if (error) {
-			sb = ERR_PTR(error);
+		if (error)
 			goto out_free_secdata;
-		}
 	}
 
-	sb = type->get_sb(type, flags, name, data);
-	if (IS_ERR(sb))
+	error = type->get_sb(type, flags, name, data, mnt);
+	if (error < 0)
 		goto out_free_secdata;
- 	error = security_sb_kern_mount(sb, secdata);
+
+	BUG_ON(!mnt->mnt_sb);
+	BUG_ON(!mnt->mnt_sb->s_root);
+	BUG_ON(!mnt->mnt_root);
+
+ 	error = security_sb_kern_mount(mnt->mnt_sb, secdata);
  	if (error)
  		goto out_sb;
-	mnt->mnt_sb = sb;
-	mnt->mnt_root = dget(sb->s_root);
-	mnt->mnt_mountpoint = sb->s_root;
+
+	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	up_write(&sb->s_umount);
+	up_write(&mnt->mnt_sb->s_umount);
 	free_secdata(secdata);
 	put_filesystem(type);
 	return mnt;
 out_sb:
-	up_write(&sb->s_umount);
-	deactivate_super(sb);
-	sb = ERR_PTR(error);
+	dput(mnt->mnt_root);
+	up_write(&mnt->mnt_sb->s_umount);
+	deactivate_super(mnt->mnt_sb);
 out_free_secdata:
 	free_secdata(secdata);
 out_mnt:
 	free_vfsmnt(mnt);
 out:
 	put_filesystem(type);
-	return (struct vfsmount *)sb;
+	return ERR_PTR(error);
 }
 
 EXPORT_SYMBOL_GPL(do_kern_mount);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4652e42..074d776 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1236,23 +1236,26 @@ find_exported_dentry(struct super_block 
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-	struct super_block *(*get_sb) (struct file_system_type *, int,
-				       const char *, void *);
+	int (*get_sb) (struct file_system_type *, int,
+		       const char *, void *, struct vfsmount *);
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
 	struct file_system_type * next;
 	struct list_head fs_supers;
 };
 
-struct super_block *get_sb_bdev(struct file_system_type *fs_type,
+extern int get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
-struct super_block *get_sb_single(struct file_system_type *fs_type,
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt);
+extern int get_sb_single(struct file_system_type *fs_type,
 	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
-struct super_block *get_sb_nodev(struct file_system_type *fs_type,
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt);
+extern int get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt);
 void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
 void kill_anon_super(struct super_block *sb);
@@ -1263,8 +1266,10 @@ struct super_block *sget(struct file_sys
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
 			void *data);
-struct super_block *get_sb_pseudo(struct file_system_type *, char *,
-			struct super_operations *ops, unsigned long);
+extern int get_sb_pseudo(struct file_system_type *, char *,
+	struct super_operations *ops, unsigned long,
+	struct vfsmount *mnt);
+extern int simple_set_mnt(struct vfsmount *mnt, struct super_block *sb);
 int __put_super(struct super_block *sb);
 int __put_super_and_need_restart(struct super_block *sb);
 void unnamed_dev_init(void);
