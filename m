Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264177AbRFLE3x>; Tue, 12 Jun 2001 00:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264181AbRFLE3p>; Tue, 12 Jun 2001 00:29:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58317 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264174AbRFLE3a>;
	Tue, 12 Jun 2001 00:29:30 -0400
Date: Tue, 12 Jun 2001 00:29:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [CFT][PATCH] superblock handling changes
Message-ID: <Pine.GSO.4.21.0106112359050.27704-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, the patch below the fixed and combined variant of
the last series of patches sent to Linus.

	It does pretty heavy changes of fs/super.c mechanics and
since one of the chunks I've sent originally contained a trivial
bug I've missed during testing - it obviously need heavier beating
than I've done.

	I'm reasonably sure that it is OK. Moreover, we need something
of that kind to fix a bunch of oopsable races. However, not introducing
new bugs would be a Good Thing(tm).

	Please, help with testing and code review. I don't want to
send 11 patches (10 chunks + 1 combined), so I'm sending the combined
version in this posting and putting the split-up for review on
ftp.math.psu.edu/pub/viro/[0-9]*S6-pre2

	Please, be careful with that one. _If_ it blows up it's more than
likely to leave box in a state when any activity on sync/mount/umount
stops dead. It is pretty straightforward (in split state) and I believe
that if there are bugs they will be easy to find, but until then...
Reviewing the code should be completely safe, though ;-) Seriously, I
think that it's OK, but I've missed one in it, so no warranties.

	If it gets no complaints in a reasonable time I'm going to
resubmit it to Linus, so... Please, help testing it. And yes, I'll
keep torturing it myself (obviously). 

	Combined patch follows:

diff -urN S6-pre2/arch/parisc/hpux/sys_hpux.c S6-pre2-super/arch/parisc/hpux/sys_hpux.c
--- S6-pre2/arch/parisc/hpux/sys_hpux.c	Fri Feb 16 20:46:44 2001
+++ S6-pre2-super/arch/parisc/hpux/sys_hpux.c	Mon Jun 11 23:55:03 2001
@@ -109,9 +109,11 @@
 
 	lock_kernel();
 	s = get_super(to_kdev_t(dev));
+	unlock_kernel();
 	if (s == NULL)
 		goto out;
 	err = vfs_statfs(s, &sbuf);
+	drop_super(s);
 	if (err)
 		goto out;
 
@@ -124,7 +126,6 @@
 	/* Changed to hpux_ustat:  */
 	err = copy_to_user(ubuf,&tmp,sizeof(struct hpux_ustat)) ? -EFAULT : 0;
 out:
-	unlock_kernel();
 	return err;
 }
 
diff -urN S6-pre2/fs/block_dev.c S6-pre2-super/fs/block_dev.c
--- S6-pre2/fs/block_dev.c	Fri Jun  8 18:29:02 2001
+++ S6-pre2-super/fs/block_dev.c	Mon Jun 11 23:55:02 2001
@@ -678,8 +678,10 @@
 	down(&bdev->bd_sem);
 	/* syncing will go here */
 	lock_kernel();
-	if (kind == BDEV_FILE || kind == BDEV_FS)
+	if (kind == BDEV_FILE)
 		fsync_dev(rdev);
+	else if (kind == BDEV_FS)
+		fsync_no_super(rdev);
 	if (atomic_dec_and_test(&bdev->bd_openers)) {
 		/* invalidating buffers will go here */
 		invalidate_buffers(rdev);
diff -urN S6-pre2/fs/buffer.c S6-pre2-super/fs/buffer.c
--- S6-pre2/fs/buffer.c	Fri Jun  8 18:29:03 2001
+++ S6-pre2-super/fs/buffer.c	Mon Jun 11 23:55:02 2001
@@ -318,6 +318,12 @@
 	return sync_buffers(dev, 1);
 }
 
+int fsync_no_super(kdev_t dev)
+{
+	sync_buffers(dev, 0);
+	return sync_buffers(dev, 1);
+}
+
 int fsync_dev(kdev_t dev)
 {
 	sync_buffers(dev, 0);
diff -urN S6-pre2/fs/dquot.c S6-pre2-super/fs/dquot.c
--- S6-pre2/fs/dquot.c	Thu May 24 18:26:44 2001
+++ S6-pre2-super/fs/dquot.c	Mon Jun 11 23:55:03 2001
@@ -325,7 +325,7 @@
         memset(&dquot->dq_dqb, 0, sizeof(struct dqblk));
 }
 
-void invalidate_dquots(kdev_t dev, short type)
+static void invalidate_dquots(kdev_t dev, short type)
 {
 	struct dquot *dquot, *next;
 	int need_restart;
@@ -1388,7 +1388,7 @@
 }
 
 /* Function in inode.c - remove pointers to dquots in icache */
-extern void remove_dquot_ref(kdev_t, short);
+extern void remove_dquot_ref(struct super_block *, short);
 
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
@@ -1413,7 +1413,7 @@
 		reset_enable_flags(dqopt, cnt);
 
 		/* Note: these are blocking operations */
-		remove_dquot_ref(sb->s_dev, cnt);
+		remove_dquot_ref(sb, cnt);
 		invalidate_dquots(sb->s_dev, cnt);
 
 		/* Wait for any pending IO - remove me as soon as invalidate is more polite */
@@ -1602,6 +1602,8 @@
 	if (sb && sb_has_quota_enabled(sb, type))
 		ret = set_dqblk(sb, id, type, flags, (struct dqblk *) addr);
 out:
+	if (sb)
+		drop_super(sb);
 	unlock_kernel();
 	return ret;
 }
diff -urN S6-pre2/fs/inode.c S6-pre2-super/fs/inode.c
--- S6-pre2/fs/inode.c	Fri Jun  8 18:29:03 2001
+++ S6-pre2-super/fs/inode.c	Mon Jun 11 23:55:03 2001
@@ -258,23 +258,6 @@
 		__sync_one(list_entry(tmp, struct inode, i_list), 0);
 }
 
-static inline int wait_on_dirty(struct list_head *head)
-{
-	struct list_head * tmp;
-	list_for_each(tmp, head) {
-		struct inode *inode = list_entry(tmp, struct inode, i_list);
-		if (!inode->i_state & I_DIRTY)
-			continue;
-		__iget(inode);
-		spin_unlock(&inode_lock);
-		__wait_on_inode(inode);
-		iput(inode);
-		spin_lock(&inode_lock);
-		return 1;
-	}
-	return 0;
-}
-
 static inline void wait_on_locked(struct list_head *head)
 {
 	struct list_head * tmp;
@@ -319,61 +302,96 @@
 	return 1;
 }
 
-/**
- *	sync_inodes
- *	@dev: device to sync the inodes from.
- *
- *	sync_inodes goes through the super block's dirty list, 
- *	writes them out, and puts them back on the normal list.
- */
-
-/*
- * caller holds exclusive lock on sb->s_umount
- */
- 
 void sync_inodes_sb(struct super_block *sb)
 {
 	spin_lock(&inode_lock);
-	sync_list(&sb->s_dirty);
-	wait_on_locked(&sb->s_locked_inodes);
+	while (!list_empty(&sb->s_dirty)||!list_empty(&sb->s_locked_inodes)) {
+		sync_list(&sb->s_dirty);
+		wait_on_locked(&sb->s_locked_inodes);
+	}
 	spin_unlock(&inode_lock);
 }
 
+/*
+ * Note:
+ * We don't need to grab a reference to superblock here. If it has non-empty
+ * ->s_dirty it's hadn't been killed yet and kill_super() won't proceed
+ * past sync_inodes_sb() until both ->s_dirty and ->s_locked_inodes are
+ * empty. Since __sync_one() regains inode_lock before it finally moves
+ * inode from superblock lists we are OK.
+ */
+
 void sync_unlocked_inodes(void)
 {
-	struct super_block * sb = sb_entry(super_blocks.next);
+	struct super_block * sb;
+	spin_lock(&inode_lock);
+	spin_lock(&sb_lock);
+	sb = sb_entry(super_blocks.next);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
 		if (!list_empty(&sb->s_dirty)) {
-			spin_lock(&inode_lock);
+			spin_unlock(&sb_lock);
 			sync_list(&sb->s_dirty);
-			spin_unlock(&inode_lock);
+			spin_lock(&sb_lock);
 		}
 	}
+	spin_unlock(&sb_lock);
+	spin_unlock(&inode_lock);
 }
 
+/*
+ * Find a superblock with inodes that need to be synced
+ */
+
+static struct super_block *get_super_to_sync(void)
+{
+	struct list_head *p;
+restart:
+	spin_lock(&inode_lock);
+	spin_lock(&sb_lock);
+	list_for_each(p, &super_blocks) {
+		struct super_block *s = list_entry(p,struct super_block,s_list);
+		if (list_empty(&s->s_dirty) && list_empty(&s->s_locked_inodes))
+			continue;
+		s->s_count++;
+		spin_unlock(&sb_lock);
+		spin_unlock(&inode_lock);
+		down_read(&s->s_umount);
+		if (!s->s_root) {
+			drop_super(s);
+			goto restart;
+		}
+		return s;
+	}
+	spin_unlock(&sb_lock);
+	spin_unlock(&inode_lock);
+	return NULL;
+}
+
+/**
+ *	sync_inodes
+ *	@dev: device to sync the inodes from.
+ *
+ *	sync_inodes goes through the super block's dirty list, 
+ *	writes them out, and puts them back on the normal list.
+ */
+
 void sync_inodes(kdev_t dev)
 {
-	struct super_block * sb = sb_entry(super_blocks.next);
+	struct super_block * s;
 
 	/*
 	 * Search the super_blocks array for the device(s) to sync.
 	 */
-	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
-		if (!sb->s_dev)
-			continue;
-		if (dev && sb->s_dev != dev)
-			continue;
-		down_read(&sb->s_umount);
-		if (sb->s_dev && (sb->s_dev == dev || !dev)) {
-			spin_lock(&inode_lock);
-			do {
-				sync_list(&sb->s_dirty);
-			} while (wait_on_dirty(&sb->s_locked_inodes));
-			spin_unlock(&inode_lock);
+	if (dev) {
+		if ((s = get_super(dev)) != NULL) {
+			sync_inodes_sb(s);
+			drop_super(s);
+		}
+	} else {
+		while ((s = get_super_to_sync()) != NULL) {
+			sync_inodes_sb(s);
+			drop_super(s);
 		}
-		up_read(&sb->s_umount);
-		if (dev)
-			break;
 	}
 }
 
@@ -382,13 +400,19 @@
  */
 static void try_to_sync_unused_inodes(void)
 {
-	struct super_block * sb = sb_entry(super_blocks.next);
+	struct super_block * sb;
+
+	spin_lock(&sb_lock);
+	sb = sb_entry(super_blocks.next);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
 		if (!sb->s_dev)
 			continue;
+		spin_unlock(&sb_lock);
 		if (!try_to_sync_unused_list(&sb->s_dirty))
 			break;
+		spin_lock(&sb_lock);
 	}
+	spin_unlock(&sb_lock);
 }
 
 /**
@@ -598,15 +622,18 @@
  
 int invalidate_device(kdev_t dev, int do_sync)
 {
-	struct super_block *sb = get_super(dev);
+	struct super_block *sb;
 	int res;
 
 	if (do_sync)
 		fsync_dev(dev);
 
 	res = 0;
-	if (sb)
+	sb = get_super(dev);
+	if (sb) {
 		res = invalidate_inodes(sb);
+		drop_super(sb);
+	}
 	invalidate_buffers(dev);
 	return res;
 }
@@ -1164,14 +1191,13 @@
 void put_dquot_list(struct list_head *);
 int remove_inode_dquot_ref(struct inode *, short, struct list_head *);
 
-void remove_dquot_ref(kdev_t dev, short type)
+void remove_dquot_ref(struct super_block *sb, short type)
 {
-	struct super_block *sb = get_super(dev);
 	struct inode *inode;
 	struct list_head *act_head;
 	LIST_HEAD(tofree_head);
 
-	if (!sb || !sb->dq_op)
+	if (!sb->dq_op)
 		return;	/* nothing to do */
 
 	/* We have to be protected against other CPUs */
diff -urN S6-pre2/fs/super.c S6-pre2-super/fs/super.c
--- S6-pre2/fs/super.c	Fri Jun  8 18:29:03 2001
+++ S6-pre2-super/fs/super.c	Mon Jun 11 23:56:28 2001
@@ -59,9 +59,8 @@
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
 
-int nr_super_blocks;
-int max_super_blocks = NR_SUPER;
 LIST_HEAD(super_blocks);
+spinlock_t sb_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * Handling of filesystem drivers list.
@@ -386,7 +385,6 @@
 	mnt->mnt_parent = mnt;
 
 	spin_lock(&dcache_lock);
-	list_add(&mnt->mnt_instances, &sb->s_mounts);
 	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
 	if (sb->s_type->fs_flags & FS_SINGLE)
@@ -395,10 +393,11 @@
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
@@ -408,14 +407,12 @@
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
@@ -487,16 +484,12 @@
 	struct super_block *sb = mnt->mnt_sb;
 
 	dput(mnt->mnt_root);
-	spin_lock(&dcache_lock);
-	list_del(&mnt->mnt_instances);
-	spin_unlock(&dcache_lock);
 	if (mnt->mnt_devname)
 		kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
 	kill_super(sb);
 }
 
-
 /* Use octal escapes, like mount does, for embedded spaces etc. */
 static unsigned char need_escaping[] = { ' ', '\t', '\n', '\\' };
 
@@ -645,6 +638,49 @@
 #undef MANGLE
 #undef FREEROOM
 }
+
+static inline void __put_super(struct super_block *sb)
+{
+	spin_lock(&sb_lock);
+	if (!--sb->s_count)
+		kfree(sb);
+	spin_unlock(&sb_lock);
+}
+
+static inline struct super_block * find_super(kdev_t dev)
+{
+	struct list_head *p;
+
+	list_for_each(p, &super_blocks) {
+		struct super_block * s = sb_entry(p);
+		if (s->s_dev == dev) {
+			s->s_count++;
+			return s;
+		}
+	}
+	return NULL;
+}
+
+void drop_super(struct super_block *sb)
+{
+	up_read(&sb->s_umount);
+	__put_super(sb);
+}
+
+static void put_super(struct super_block *sb)
+{
+	up_write(&sb->s_umount);
+	__put_super(sb);
+}
+
+static inline void write_super(struct super_block *sb)
+{
+	lock_super(sb);
+	if (sb->s_root && sb->s_dirt)
+		if (sb->s_op && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+	unlock_super(sb);
+}
  
 /*
  * Note: check the dirty flag before waiting, so we don't
@@ -655,21 +691,29 @@
 {
 	struct super_block * sb;
 
-	for (sb = sb_entry(super_blocks.next);
-	     sb != sb_entry(&super_blocks); 
-	     sb = sb_entry(sb->s_list.next)) {
-		if (!sb->s_dev)
-			continue;
-		if (dev && sb->s_dev != dev)
-			continue;
-		if (!sb->s_dirt)
-			continue;
-		lock_super(sb);
-		if (sb->s_dev && sb->s_dirt && (!dev || dev == sb->s_dev))
-			if (sb->s_op && sb->s_op->write_super)
-				sb->s_op->write_super(sb);
-		unlock_super(sb);
+	if (dev) {
+		sb = get_super(dev);
+		if (sb) {
+			if (sb->s_dirt)
+				write_super(sb);
+			drop_super(sb);
+		}
+		return;
 	}
+restart:
+	spin_lock(&sb_lock);
+	sb = sb_entry(super_blocks.next);
+	while (sb != sb_entry(&super_blocks))
+		if (sb->s_dirt) {
+			sb->s_count++;
+			spin_unlock(&sb_lock);
+			down_read(&sb->s_umount);
+			write_super(sb);
+			drop_super(sb);
+			goto restart;
+		} else
+			sb = sb_entry(sb->s_list.next);
+	spin_unlock(&sb_lock);
 }
 
 /**
@@ -687,17 +731,21 @@
 	if (!dev)
 		return NULL;
 restart:
-	s = sb_entry(super_blocks.next);
-	while (s != sb_entry(&super_blocks))
-		if (s->s_dev == dev) {
-			/* Yes, it sucks. As soon as we get refcounting... */
-			lock_super(s);
-			unlock_super(s);
-			if (s->s_dev == dev)
-				return s;
-			goto restart;
-		} else
-			s = sb_entry(s->s_list.next);
+	spin_lock(&sb_lock);
+	s = find_super(dev);
+	if (s) {
+		spin_unlock(&sb_lock);
+		/* Yes, it sucks. As soon as we get refcounting... */
+		/* Almost there - next two lines will go away RSN */
+		lock_super(s);
+		unlock_super(s);
+		down_read(&s->s_umount);
+		if (s->s_root)
+			return s;
+		drop_super(s);
+		goto restart;
+	}
+	spin_unlock(&sb_lock);
 	return NULL;
 }
 
@@ -714,6 +762,7 @@
         if (s == NULL)
                 goto out;
 	err = vfs_statfs(s, &sbuf);
+	drop_super(s);
 	if (err)
 		goto out;
 
@@ -735,35 +784,23 @@
  *	the request.
  */
  
-static struct super_block *get_empty_super(void)
+static struct super_block *alloc_super(void)
 {
-	struct super_block *s;
-
-	for (s  = sb_entry(super_blocks.next);
-	     s != sb_entry(&super_blocks); 
-	     s  = sb_entry(s->s_list.next)) {
-		if (s->s_dev)
-			continue;
-		return s;
-	}
-	/* Need a new one... */
-	if (nr_super_blocks >= max_super_blocks)
-		return NULL;
-	s = kmalloc(sizeof(struct super_block),  GFP_USER);
+	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
 	if (s) {
-		nr_super_blocks++;
 		memset(s, 0, sizeof(struct super_block));
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
-		list_add (&s->s_list, super_blocks.prev);
 		INIT_LIST_HEAD(&s->s_files);
-		INIT_LIST_HEAD(&s->s_mounts);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
+		s->s_count = 1;
+		atomic_set(&s->s_active, 1);
 		sema_init(&s->s_vfs_rename_sem,1);
 		sema_init(&s->s_nfsd_free_path_sem,1);
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
+		s->s_maxbytes = MAX_NON_LFS;
 	}
 	return s;
 }
@@ -773,16 +810,16 @@
 				       void *data, int silent)
 {
 	struct super_block * s;
-	s = get_empty_super();
+	s = alloc_super();
 	if (!s)
 		goto out;
 	s->s_dev = dev;
 	s->s_bdev = bdev;
 	s->s_flags = flags;
-	s->s_dirt = 0;
 	s->s_type = type;
-	s->s_dquot.flags = 0;
-	s->s_maxbytes = MAX_NON_LFS;
+	spin_lock(&sb_lock);
+	list_add (&s->s_list, super_blocks.prev);
+	spin_unlock(&sb_lock);
 	lock_super(s);
 	if (!type->read_super(s, data, silent))
 		goto out_fail;
@@ -798,6 +835,11 @@
 	s->s_bdev = 0;
 	s->s_type = NULL;
 	unlock_super(s);
+	atomic_dec(&s->s_active);
+	spin_lock(&sb_lock);
+	list_del(&s->s_list);
+	spin_unlock(&sb_lock);
+	__put_super(s);
 	return NULL;
 }
 
@@ -863,9 +905,25 @@
 	if (sb) {
 		if (fs_type == sb->s_type &&
 		    ((flags ^ sb->s_flags) & MS_RDONLY) == 0) {
+/*
+ * We are heavily relying on mount_sem here. We _will_ get rid of that
+ * ugliness RSN (and then atomicity of ->s_active will play), but first
+ * we need to get rid of "reuse" branch of get_empty_super() and that
+ * requires reference counters. Chicken and egg problem, but fortunately
+ * we can use the fact that right now all accesses to ->s_active are
+ * under mount_sem.
+ */
+			if (atomic_read(&sb->s_active)) {
+				spin_lock(&sb_lock);
+				sb->s_count--;
+				spin_unlock(&sb_lock);
+			}
+			atomic_inc(&sb->s_active);
+			up_read(&sb->s_umount);
 			path_release(&nd);
 			return sb;
 		}
+		drop_super(sb);
 	} else {
 		mode_t mode = FMODE_READ; /* we always need it ;-) */
 		if (!(flags & MS_RDONLY))
@@ -926,6 +984,7 @@
 	sb = fs_type->kern_mnt->mnt_sb;
 	if (!sb)
 		BUG();
+	atomic_inc(&sb->s_active);
 	do_remount_sb(sb, flags, data);
 	return sb;
 }
@@ -938,12 +997,8 @@
 	struct file_system_type *fs = sb->s_type;
 	struct super_operations *sop = sb->s_op;
 
-	spin_lock(&dcache_lock);
-	if (!list_empty(&sb->s_mounts)) {
-		spin_unlock(&dcache_lock);
+	if (!atomic_dec_and_test(&sb->s_active))
 		return;
-	}
-	spin_unlock(&dcache_lock);
 	down_write(&sb->s_umount);
 	lock_kernel();
 	sb->s_root = NULL;
@@ -975,12 +1030,15 @@
 	sb->s_type = NULL;
 	unlock_super(sb);
 	unlock_kernel();
-	up_write(&sb->s_umount);
 	if (bdev) {
 		blkdev_put(bdev, BDEV_FS);
 		bdput(bdev);
 	} else
 		put_unnamed_dev(dev);
+	spin_lock(&sb_lock);
+	list_del(&sb->s_list);
+	spin_unlock(&sb_lock);
+	put_super(sb);
 }
 
 /*
@@ -1045,9 +1103,6 @@
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	spin_lock(&dcache_lock);
-	list_add(&mnt->mnt_instances, &sb->s_mounts);
-	spin_unlock(&dcache_lock);
 	type->kern_mnt = mnt;
 	return mnt;
 }
@@ -1092,7 +1147,7 @@
 
 	spin_lock(&dcache_lock);
 
-	if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
+	if (atomic_read(&sb->s_active) > 1) {
 		if (atomic_read(&mnt->mnt_count) > 2) {
 			spin_unlock(&dcache_lock);
 			return -EBUSY;
@@ -1243,13 +1298,13 @@
 		return err;
 
 	err = -ENOMEM;
+	down(&mount_sem);
 	mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
 	if (mnt) {
-		down(&mount_sem);
 		err = graft_tree(mnt, nd);
-		up(&mount_sem);
 		mntput(mnt);
 	}
+	up(&mount_sem);
 	path_release(&old_nd);
 	return err;
 }
@@ -1324,9 +1379,6 @@
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	spin_lock(&dcache_lock);
-	list_add(&mnt->mnt_instances, &sb->s_mounts);
-	spin_unlock(&dcache_lock);
 
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
@@ -1583,7 +1635,10 @@
 	check_disk_change(ROOT_DEV);
 	sb = get_super(ROOT_DEV);
 	if (sb) {
+		/* FIXME */
 		fs_type = sb->s_type;
+		atomic_inc(&sb->s_active);
+		up_read(&sb->s_umount);
 		goto mount_it;
 	}
 
diff -urN S6-pre2/include/linux/fs.h S6-pre2-super/include/linux/fs.h
--- S6-pre2/include/linux/fs.h	Fri Jun  8 18:29:03 2001
+++ S6-pre2-super/include/linux/fs.h	Mon Jun 11 23:55:03 2001
@@ -61,7 +61,6 @@
 };
 extern struct inodes_stat_t inodes_stat;
 
-extern int max_super_blocks, nr_super_blocks;
 extern int leases_enable, dir_notify_enable, lease_break_time;
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
@@ -662,6 +661,7 @@
 #include <linux/usbdev_fs_sb.h>
 
 extern struct list_head super_blocks;
+extern spinlock_t sb_lock;
 
 #define sb_entry(list)	list_entry((list), struct super_block, s_list)
 struct super_block {
@@ -679,13 +679,14 @@
 	struct dentry		*s_root;
 	struct rw_semaphore	s_umount;
 	struct semaphore	s_lock;
+	int			s_count;
+	atomic_t		s_active;
 
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_locked_inodes;/* inodes being synced */
 	struct list_head	s_files;
 
 	struct block_device	*s_bdev;
-	struct list_head	s_mounts;	/* vfsmount(s) of this one */
 	struct quota_mount_options s_dquot;	/* Diskquota specific options */
 
 	union {
@@ -1122,6 +1123,7 @@
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
 extern int fsync_super(struct super_block *);
+extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
 extern int fsync_inode_buffers(struct inode *);
 extern int osync_inode_buffers(struct inode *);
@@ -1319,12 +1321,12 @@
 
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(kdev_t);
-extern void put_super(kdev_t);
+extern void drop_super(struct super_block *sb);
 static inline int is_mounted(kdev_t dev)
 {
 	struct super_block *sb = get_super(dev);
 	if (sb) {
-		/* drop_super(sb); will go here */
+		drop_super(sb);
 		return 1;
 	}
 	return 0;
diff -urN S6-pre2/include/linux/mount.h S6-pre2-super/include/linux/mount.h
--- S6-pre2/include/linux/mount.h	Fri Jun  8 18:29:03 2001
+++ S6-pre2-super/include/linux/mount.h	Mon Jun 11 23:55:02 2001
@@ -18,7 +18,6 @@
 	struct vfsmount *mnt_parent;	/* fs we are mounted on */
 	struct dentry *mnt_mountpoint;	/* dentry of mountpoint */
 	struct dentry *mnt_root;	/* root of the mounted tree */
-	struct list_head mnt_instances;	/* other vfsmounts of the same fs */
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
diff -urN S6-pre2/include/linux/quotaops.h S6-pre2-super/include/linux/quotaops.h
--- S6-pre2/include/linux/quotaops.h	Sun Jun 10 13:15:27 2001
+++ S6-pre2-super/include/linux/quotaops.h	Mon Jun 11 23:55:03 2001
@@ -21,7 +21,6 @@
  */
 extern void dquot_initialize(struct inode *inode, short type);
 extern void dquot_drop(struct inode *inode);
-extern void invalidate_dquots(kdev_t dev, short type);
 extern int  quota_off(struct super_block *sb, short type);
 extern int  sync_dquots(kdev_t dev, short type);
 
diff -urN S6-pre2/kernel/ksyms.c S6-pre2-super/kernel/ksyms.c
--- S6-pre2/kernel/ksyms.c	Fri Jun  8 18:29:03 2001
+++ S6-pre2-super/kernel/ksyms.c	Mon Jun 11 23:55:03 2001
@@ -129,6 +129,7 @@
 EXPORT_SYMBOL(update_atime);
 EXPORT_SYMBOL(get_fs_type);
 EXPORT_SYMBOL(get_super);
+EXPORT_SYMBOL(drop_super);
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(names_cachep);
 EXPORT_SYMBOL(fput);
diff -urN S6-pre2/kernel/sysctl.c S6-pre2-super/kernel/sysctl.c
--- S6-pre2/kernel/sysctl.c	Sat Apr 14 21:41:29 2001
+++ S6-pre2-super/kernel/sysctl.c	Mon Jun 11 23:55:03 2001
@@ -286,10 +286,6 @@
 	 0444, NULL, &proc_dointvec},
 	{FS_MAXFILE, "file-max", &files_stat.max_files, sizeof(int),
 	 0644, NULL, &proc_dointvec},
-	{FS_NRSUPER, "super-nr", &nr_super_blocks, sizeof(int),
-	 0444, NULL, &proc_dointvec},
-	{FS_MAXSUPER, "super-max", &max_super_blocks, sizeof(int),
-	 0644, NULL, &proc_dointvec},
 	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
 	 0444, NULL, &proc_dointvec},
 	{FS_MAXDQUOT, "dquot-max", &max_dquots, sizeof(int),

