Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263427AbRFKFij>; Mon, 11 Jun 2001 01:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263430AbRFKFi1>; Mon, 11 Jun 2001 01:38:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:948 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263427AbRFKFhu>;
	Mon, 11 Jun 2001 01:37:50 -0400
Date: Mon, 11 Jun 2001 01:37:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c stuff (7/10)
In-Reply-To: <Pine.GSO.4.21.0106110136250.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110137320.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-put_super/fs/inode.c S6-pre2-s_count/fs/inode.c
--- S6-pre2-put_super/fs/inode.c	Sun Jun 10 12:25:34 2001
+++ S6-pre2-s_count/fs/inode.c	Sun Jun 10 12:29:35 2001
@@ -339,30 +339,48 @@
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
 
 void sync_inodes(kdev_t dev)
 {
-	struct super_block * sb = sb_entry(super_blocks.next);
+	struct super_block * sb;
 
 	/*
 	 * Search the super_blocks array for the device(s) to sync.
 	 */
+	spin_lock(&sb_lock);
+	sb = sb_entry(super_blocks.next);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
 		if (!sb->s_dev)
 			continue;
 		if (dev && sb->s_dev != dev)
 			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
 		down_read(&sb->s_umount);
 		if (sb->s_dev && (sb->s_dev == dev || !dev)) {
 			spin_lock(&inode_lock);
@@ -372,9 +390,12 @@
 			spin_unlock(&inode_lock);
 		}
 		up_read(&sb->s_umount);
+		spin_lock(&sb_lock);
+		sb->s_count--;
 		if (dev)
 			break;
 	}
+	spin_unlock(&sb_lock);
 }
 
 /*
@@ -382,13 +403,19 @@
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
diff -urN S6-pre2-put_super/fs/super.c S6-pre2-s_count/fs/super.c
--- S6-pre2-put_super/fs/super.c	Sun Jun 10 12:25:34 2001
+++ S6-pre2-s_count/fs/super.c	Sun Jun 10 12:35:54 2001
@@ -62,6 +62,7 @@
 int nr_super_blocks;
 int max_super_blocks = NR_SUPER;
 LIST_HEAD(super_blocks);
+spinlock_t sb_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * Handling of filesystem drivers list.
@@ -640,8 +641,16 @@
 #undef FREEROOM
 }
 
+static inline void __put_super(struct super_block *sb)
+{
+	spin_lock(&sb_lock);
+	sb->s_count--;
+	spin_unlock(&sb_lock);
+}
+
 void drop_super(struct super_block *sb)
 {
+	__put_super(sb);
 }
  
 /*
@@ -653,6 +662,7 @@
 {
 	struct super_block * sb;
 
+	spin_lock(&sb_lock);
 	for (sb = sb_entry(super_blocks.next);
 	     sb != sb_entry(&super_blocks); 
 	     sb = sb_entry(sb->s_list.next)) {
@@ -662,12 +672,17 @@
 			continue;
 		if (!sb->s_dirt)
 			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
 		lock_super(sb);
 		if (sb->s_dev && sb->s_dirt && (!dev || dev == sb->s_dev))
 			if (sb->s_op && sb->s_op->write_super)
 				sb->s_op->write_super(sb);
 		unlock_super(sb);
+		spin_lock(&sb_lock);
+		sb->s_count--;
 	}
+	spin_unlock(&sb_lock);
 }
 
 /**
@@ -685,17 +700,23 @@
 	if (!dev)
 		return NULL;
 restart:
+	spin_lock(&sb_lock);
 	s = sb_entry(super_blocks.next);
 	while (s != sb_entry(&super_blocks))
 		if (s->s_dev == dev) {
 			/* Yes, it sucks. As soon as we get refcounting... */
+			/* Almost there */
+			s->s_count++;
+			spin_unlock(&sb_lock);
 			lock_super(s);
 			unlock_super(s);
 			if (s->s_dev == dev)
 				return s;
+			drop_super(s);
 			goto restart;
 		} else
 			s = sb_entry(s->s_list.next);
+	spin_unlock(&sb_lock);
 	return NULL;
 }
 
@@ -738,14 +759,18 @@
 {
 	struct super_block *s;
 
+	spin_lock(&sb_lock);
 	for (s  = sb_entry(super_blocks.next);
 	     s != sb_entry(&super_blocks); 
 	     s  = sb_entry(s->s_list.next)) {
 		if (s->s_dev)
 			continue;
+		s->s_count++;
 		atomic_inc(&s->s_active);
+		spin_unlock(&sb_lock);
 		return s;
 	}
+	spin_unlock(&sb_lock);
 	/* Need a new one... */
 	if (nr_super_blocks >= max_super_blocks)
 		return NULL;
@@ -753,6 +778,7 @@
 	if (s) {
 		nr_super_blocks++;
 		memset(s, 0, sizeof(struct super_block));
+		spin_lock(&sb_lock);
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		list_add (&s->s_list, super_blocks.prev);
@@ -760,10 +786,12 @@
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
 		atomic_set(&s->s_active, 1);
+		s->s_count = 1;
 		sema_init(&s->s_vfs_rename_sem,1);
 		sema_init(&s->s_nfsd_free_path_sem,1);
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
+		spin_unlock(&sb_lock);
 	}
 	return s;
 }
@@ -799,6 +827,7 @@
 	s->s_type = NULL;
 	unlock_super(s);
 	atomic_dec(&s->s_active);
+	__put_super(s);
 	return NULL;
 }
 
@@ -864,10 +893,24 @@
 	if (sb) {
 		if (fs_type == sb->s_type &&
 		    ((flags ^ sb->s_flags) & MS_RDONLY) == 0) {
-			path_release(&nd);
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
 			atomic_inc(&sb->s_active);
+			path_release(&nd);
 			return sb;
 		}
+		__put_super(sb);
 	} else {
 		mode_t mode = FMODE_READ; /* we always need it ;-) */
 		if (!(flags & MS_RDONLY))
@@ -941,8 +984,7 @@
 	struct file_system_type *fs = sb->s_type;
 	struct super_operations *sop = sb->s_op;
 
-	atomic_dec(&sb->s_active);
-	if (atomic_read(&sb->s_active))
+	if (!atomic_dec_and_test(&sb->s_active))
 		return;
 	down_write(&sb->s_umount);
 	lock_kernel();
@@ -981,6 +1023,7 @@
 	} else
 		put_unnamed_dev(dev);
 	up_write(&sb->s_umount);
+	__put_super(sb);
 }
 
 /*
@@ -1240,13 +1283,13 @@
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
@@ -1577,6 +1620,7 @@
 	check_disk_change(ROOT_DEV);
 	sb = get_super(ROOT_DEV);
 	if (sb) {
+		/* FIXME */
 		fs_type = sb->s_type;
 		atomic_inc(&sb->s_active);
 		goto mount_it;
diff -urN S6-pre2-put_super/include/linux/fs.h S6-pre2-s_count/include/linux/fs.h
--- S6-pre2-put_super/include/linux/fs.h	Sun Jun 10 12:27:37 2001
+++ S6-pre2-s_count/include/linux/fs.h	Sun Jun 10 01:29:52 2001
@@ -662,6 +662,7 @@
 #include <linux/usbdev_fs_sb.h>
 
 extern struct list_head super_blocks;
+extern spinlock_t sb_lock;
 
 #define sb_entry(list)	list_entry((list), struct super_block, s_list)
 struct super_block {
@@ -679,6 +680,7 @@
 	struct dentry		*s_root;
 	struct rw_semaphore	s_umount;
 	struct semaphore	s_lock;
+	int			s_count;
 	atomic_t		s_active;
 
 	struct list_head	s_dirty;	/* dirty inodes */


