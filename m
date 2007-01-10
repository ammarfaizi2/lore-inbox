Return-Path: <linux-kernel-owner+w=401wt.eu-S965024AbXAJSeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbXAJSeU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbXAJSeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:34:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:55371 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965022AbXAJSeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:34:19 -0500
Subject: Re: [PATCH] r/o bind mounts: add vfsmount and superblock writer
	counts
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20070109105305.GA22984@infradead.org>
References: <20070108183445.9472D522@localhost.localdomain>
	 <20070109105305.GA22984@infradead.org>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 10:33:56 -0800
Message-Id: <1168454037.13412.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 10:53 +0000, Christoph Hellwig wrote: 
> On Mon, Jan 08, 2007 at 10:34:45AM -0800, Dave Hansen wrote:
> > The other side-effect is that we can't have the bit in mnt_flags
> > to be a shortcut to the superblock's writeable state since we
> > don't have a way to go find the mounts and that bit when a fs
> > changes writeable state.  This causes a potential cache miss
> > when we have to check the superblock directly during the
> > relatively common __mnt_is_readonly() function.
> 
> Why? We _only_ need to check the vfsmount flag.  vfsmount can
> become r/w if the superblock is marked r/o which means the
> underlying (block/network/etc) device is fundamentally not writeable.

It does seem a bit silly to go all the way down to the permissions
checks to finally find out that the sb is r/o when it is pretty easy to
catch here.  But, I guess it is a common-case hit for a relatively
uncommon occurrence.

Here is an updated patch?

After this, do you think it is ready for -mm?

---

 lxc-dave/fs/inode.c            |    5 ++++
 lxc-dave/fs/namespace.c        |   47 ++++++++++++++++++++++++++++++++++++++---
 lxc-dave/fs/super.c            |   31 ++++++++++++++++++++++-----
 lxc-dave/include/linux/fs.h    |    5 ++++
 lxc-dave/include/linux/mount.h |   20 ++++++++++-------
 5 files changed, 92 insertions(+), 16 deletions(-)

diff -puN fs/namespace.c~03-24-add-vfsmount-writer-count fs/namespace.c
--- lxc/fs/namespace.c~03-24-add-vfsmount-writer-count	2007-01-10 10:26:33.000000000 -0800
+++ lxc-dave/fs/namespace.c	2007-01-10 10:26:34.000000000 -0800
@@ -56,6 +56,7 @@ struct vfsmount *alloc_vfsmnt(const char
 	struct vfsmount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
 	if (mnt) {
 		atomic_set(&mnt->mnt_count, 1);
+		mnt->mnt_writers = 0;
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
@@ -877,15 +878,52 @@ out_unlock:
 	return err;
 }
 
+int mnt_make_readonly(struct vfsmount *mnt)
+{
+	int ret = 0;
+
+	WARN_ON(__mnt_is_readonly(mnt));
+
+	/*
+	 * This flag set is actually redundant with what
+	 * happens in do_remount(), but since we do this
+	 * under the lock, anyone attempting to get a write
+	 * on it after this will fail.
+	 */
+	spin_lock(&mnt->mnt_sb->s_mnt_writers_lock);
+	if (!mnt->mnt_writers)
+		mnt->mnt_flags |= MNT_READONLY;
+	else
+		ret = -EBUSY;
+	spin_unlock(&mnt->mnt_sb->s_mnt_writers_lock);
+	return ret;
+}
+
 int mnt_want_write(struct vfsmount *mnt)
 {
-	if (__mnt_is_readonly(mnt))
-		return -EROFS;
-	return 0;
+	int ret = 0;
+	spin_lock(&mnt->mnt_sb->s_mnt_writers_lock);
+	if (mnt->mnt_writers)
+		goto out;
+
+	if (__mnt_is_readonly(mnt)) {
+		ret = -EROFS;
+		goto out;
+	}
+	mnt->mnt_sb->s_writers++;
+	mnt->mnt_writers++;
+out:
+	spin_unlock(&mnt->mnt_sb->s_mnt_writers_lock);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(mnt_want_write);
 
 void mnt_drop_write(struct vfsmount *mnt)
 {
+	spin_lock(&mnt->mnt_sb->s_mnt_writers_lock);
+	mnt->mnt_sb->s_writers--;
+	mnt->mnt_writers--;
+	spin_unlock(&mnt->mnt_sb->s_mnt_writers_lock);
 }
 
 /*
@@ -986,6 +1024,7 @@ static int do_remount(struct nameidata *
 		security_sb_post_remount(nd->mnt, flags, data);
 	return err;
 }
+EXPORT_SYMBOL_GPL(mnt_drop_write);
 
 static inline int tree_contains_unbindable(struct vfsmount *mnt)
 {
@@ -1410,6 +1449,8 @@ long do_mount(char *dev_name, char *dir_
 		((char *)data_page)[PAGE_SIZE - 1] = 0;
 
 	/* Separate the per-mountpoint flags */
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_READONLY;
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
diff -puN fs/super.c~03-24-add-vfsmount-writer-count fs/super.c
--- lxc/fs/super.c~03-24-add-vfsmount-writer-count	2007-01-10 10:26:33.000000000 -0800
+++ lxc-dave/fs/super.c	2007-01-10 10:26:34.000000000 -0800
@@ -93,6 +93,8 @@ static struct super_block *alloc_super(s
 		s->s_qcop = sb_quotactl_ops;
 		s->s_op = &default_op;
 		s->s_time_gran = 1000000000;
+		s->s_writers = 0;
+		spin_lock_init(&s->s_mnt_writers_lock);
 	}
 out:
 	return s;
@@ -576,6 +578,20 @@ static void mark_files_ro(struct super_b
 	file_list_unlock();
 }
 
+static int sb_remount_ro(struct super_block *sb)
+{
+	return fs_may_remount_ro(sb);
+}
+
+static void sb_remount_rw(struct super_block *sb)
+{
+	/*
+	 * No action, yet.  This will soon
+	 * notify the mounts that the sb
+	 * has become writeable.
+	 */
+}
+
 /**
  *	do_remount_sb - asks filesystem to change mount options.
  *	@sb:	superblock in question
@@ -587,7 +603,8 @@ static void mark_files_ro(struct super_b
  */
 int do_remount_sb(struct super_block *sb, int flags, void *data, int force)
 {
-	int retval;
+	int retval = 0;
+	int sb_started_ro = (sb->s_flags & MS_RDONLY);
 	
 #ifdef CONFIG_BLOCK
 	if (!(flags & MS_RDONLY) && bdev_read_only(sb->s_bdev))
@@ -600,13 +617,14 @@ int do_remount_sb(struct super_block *sb
 
 	/* If we are remounting RDONLY and current sb is read/write,
 	   make sure there are no rw files opened */
-	if ((flags & MS_RDONLY) && !(sb->s_flags & MS_RDONLY)) {
+	if ((flags & MS_RDONLY) && !sb_started_ro) {
 		if (force)
 			mark_files_ro(sb);
-		else if (!fs_may_remount_ro(sb))
-			return -EBUSY;
+		else
+			retval = sb_remount_ro(sb);
+		if (retval)
+			return retval;
 	}
-
 	if (sb->s_op->remount_fs) {
 		lock_super(sb);
 		retval = sb->s_op->remount_fs(sb, &flags, data);
@@ -614,6 +632,9 @@ int do_remount_sb(struct super_block *sb
 		if (retval)
 			return retval;
 	}
+	if (!(flags & MS_RDONLY) && sb_started_ro)
+		sb_remount_rw(sb);
+
 	sb->s_flags = (sb->s_flags & ~MS_RMT_MASK) | (flags & MS_RMT_MASK);
 	return 0;
 }
diff -puN include/linux/fs.h~03-24-add-vfsmount-writer-count include/linux/fs.h
--- lxc/include/linux/fs.h~03-24-add-vfsmount-writer-count	2007-01-10 10:26:33.000000000 -0800
+++ lxc-dave/include/linux/fs.h	2007-01-10 10:26:34.000000000 -0800
@@ -969,6 +969,8 @@ struct super_block {
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
+	int			s_writers;	/* number of files open for write */
+	spinlock_t		s_mnt_writers_lock; /* taken when mounts change rw state */
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
@@ -1277,6 +1279,9 @@ static inline void check_nlink(struct in
 		return;
 
 	inode->i_state |= I_AWAITING_FINAL_IPUT;
+	spin_lock(&inode->i_sb->s_mnt_writers_lock);
+	inode->i_sb->s_writers--;
+	spin_unlock(&inode->i_sb->s_mnt_writers_lock);
 }
 
 /**
diff -puN include/linux/mount.h~03-24-add-vfsmount-writer-count include/linux/mount.h
--- lxc/include/linux/mount.h~03-24-add-vfsmount-writer-count	2007-01-10 10:26:34.000000000 -0800
+++ lxc-dave/include/linux/mount.h	2007-01-10 10:27:17.000000000 -0800
@@ -28,6 +28,7 @@ struct mnt_namespace;
 #define MNT_NOATIME	0x08
 #define MNT_NODIRATIME	0x10
 #define MNT_RELATIME	0x20
+#define MNT_READONLY	0x40 /* does the user want this to be r/o? */
 
 #define MNT_SHRINKABLE	0x100
 
@@ -53,7 +54,7 @@ struct vfsmount {
 	struct list_head mnt_slave;	/* slave list entry */
 	struct vfsmount *mnt_master;	/* slave is on master->mnt_slave_list */
 	struct mnt_namespace *mnt_ns;	/* containing namespace */
-	atomic_t mnt_writers;		/* nr files open for write */
+	int mnt_writers;		/* nr files open for write */
 	/*
 	 * We put mnt_count & mnt_expiry_mark at the end of struct vfsmount
 	 * to let these frequently modified fields in a separate cache line
@@ -71,17 +72,20 @@ static inline struct vfsmount *mntget(st
 	return mnt;
 }
 
-/*
- * This is temporary for now.  We also don't want to check
- * the SB in because it is already checked in other
- * code paths.  We'll have a better way to do this in
- * the end of this series
- */
 static inline int __mnt_is_readonly(struct vfsmount *mnt)
 {
-	return 0;
+	return mnt->mnt_flags & MNT_READONLY;
 }
 
+static inline void __mnt_unmake_readonly(struct vfsmount *mnt)
+{
+	WARN_ON(!__mnt_is_readonly(mnt));
+	mnt->mnt_flags &= ~MNT_READONLY;
+}
+
+extern int mnt_make_readonly(struct vfsmount *mnt);
+extern int mnt_want_write(struct vfsmount *mnt);
+extern void mnt_drop_write(struct vfsmount *mnt);
 extern void mntput_no_expire(struct vfsmount *mnt);
 extern void mnt_pin(struct vfsmount *mnt);
 extern void mnt_unpin(struct vfsmount *mnt);
diff -L lxc-dave/include/linux/fs.h -puN /dev/null /dev/null
diff -puN fs/inode.c~03-24-add-vfsmount-writer-count fs/inode.c
--- lxc/fs/inode.c~03-24-add-vfsmount-writer-count	2007-01-10 10:26:34.000000000 -0800
+++ lxc-dave/fs/inode.c	2007-01-10 10:26:34.000000000 -0800
@@ -1101,6 +1101,11 @@ static inline void iput_final(struct ino
 	if (op && op->drop_inode)
 		drop = op->drop_inode;
 	drop(inode);
+	if (must_drop_sb_write) {
+		spin_lock(&sb->s_mnt_writers_lock);
+		sb->s_writers--;
+		spin_unlock(&sb->s_mnt_writers_lock);
+	}
 }
 
 /**
_


-- Dave

