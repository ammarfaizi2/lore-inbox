Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbREOWOi>; Tue, 15 May 2001 18:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261629AbREOWO2>; Tue, 15 May 2001 18:14:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41917 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261628AbREOWON>;
	Tue, 15 May 2001 18:14:13 -0400
Date: Tue, 15 May 2001 18:14:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] SMP-safe lock_super()
Message-ID: <Pine.GSO.4.21.0105151813270.22958-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch turns s_lock+s_wait combination into semaphore.
wait_on_super() is dead. lock_super() is down(&sb->s_lock),
unlock_super() is up(...).

	One place is still ugly - get_super(), but that'll have to
wait until we add reference counters on superblocks. For the time being
get_super() behaviour stays unchanged (i.e. all races with umount()
are still there).

	Please, apply it - it doesn't break anything in tree,
unlikely to break anything 3rd-party and any potential breakage there
will be caught by compiler.
								Al

diff -urN S5-pre2/fs/ext2/super.c S5-pre2-s_lock/fs/ext2/super.c
--- S5-pre2/fs/ext2/super.c	Sat Apr 28 02:12:56 2001
+++ S5-pre2-s_lock/fs/ext2/super.c	Tue May 15 18:12:35 2001
@@ -76,9 +76,6 @@
 	va_start (args, fmt);
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
-	/* this is to prevent panic from syncing this filesystem */
-	if (sb->s_lock)
-		sb->s_lock=0;
 	sb->s_flags |= MS_RDONLY;
 	panic ("EXT2-fs panic (device %s): %s: %s\n",
 	       bdevname(sb->s_dev), function, error_buf);
diff -urN S5-pre2/fs/reiserfs/prints.c S5-pre2-s_lock/fs/reiserfs/prints.c
--- S5-pre2/fs/reiserfs/prints.c	Sat Apr 28 02:12:56 2001
+++ S5-pre2-s_lock/fs/reiserfs/prints.c	Tue May 15 18:12:35 2001
@@ -349,8 +349,6 @@
 #endif
 
   /* this is to prevent panic from syncing this filesystem */
-  if (sb && sb->s_lock)
-    sb->s_lock=0;
   if (sb)
     sb->s_flags |= MS_RDONLY;
 
diff -urN S5-pre2/fs/super.c S5-pre2-s_lock/fs/super.c
--- S5-pre2/fs/super.c	Tue May 15 03:51:04 2001
+++ S5-pre2-s_lock/fs/super.c	Tue May 15 18:12:35 2001
@@ -580,30 +580,7 @@
 #undef MANGLE
 #undef FREEROOM
 }
-
-/**
- *	__wait_on_super	- wait on a superblock
- *	@sb: superblock to wait on
- *
- *	Waits for a superblock to become unlocked and then returns. It does
- *	not take the lock. This is an internal function. See wait_on_super().
- */
  
-void __wait_on_super(struct super_block * sb)
-{
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(&sb->s_wait, &wait);
-repeat:
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (sb->s_lock) {
-		schedule();
-		goto repeat;
-	}
-	remove_wait_queue(&sb->s_wait, &wait);
-	current->state = TASK_RUNNING;
-}
-
 /*
  * Note: check the dirty flag before waiting, so we don't
  * hold up the sync while mounting a device. (The newly
@@ -648,7 +625,9 @@
 	s = sb_entry(super_blocks.next);
 	while (s != sb_entry(&super_blocks))
 		if (s->s_dev == dev) {
-			wait_on_super(s);
+			/* Yes, it sucks. As soon as we get refcounting... */
+			lock_super(s);
+			unlock_super(s);
 			if (s->s_dev == dev)
 				return s;
 			goto restart;
@@ -700,9 +679,7 @@
 	     s  = sb_entry(s->s_list.next)) {
 		if (s->s_dev)
 			continue;
-		if (!s->s_lock)
-			return s;
-		printk("VFS: empty superblock %p locked!\n", s);
+		return s;
 	}
 	/* Need a new one... */
 	if (nr_super_blocks >= max_super_blocks)
@@ -714,10 +691,14 @@
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		list_add (&s->s_list, super_blocks.prev);
-		init_waitqueue_head(&s->s_wait);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_mounts);
 		init_rwsem(&s->s_umount);
+		sema_init(&s->s_lock, 1);
+		sema_init(&s->s_vfs_rename_sem,1);
+		sema_init(&s->s_nfsd_free_path_sem,1);
+		sema_init(&s->s_dquot.dqio_sem, 1);
+		sema_init(&s->s_dquot.dqoff_sem, 1);
 	}
 	return s;
 }
@@ -734,11 +715,7 @@
 	s->s_bdev = bdev;
 	s->s_flags = flags;
 	s->s_dirt = 0;
-	sema_init(&s->s_vfs_rename_sem,1);
-	sema_init(&s->s_nfsd_free_path_sem,1);
 	s->s_type = type;
-	sema_init(&s->s_dquot.dqio_sem, 1);
-	sema_init(&s->s_dquot.dqoff_sem, 1);
 	s->s_dquot.flags = 0;
 	s->s_maxbytes = MAX_NON_LFS;
 	lock_super(s);
diff -urN S5-pre2/fs/ufs/super.c S5-pre2-s_lock/fs/ufs/super.c
--- S5-pre2/fs/ufs/super.c	Sat Apr 28 02:12:56 2001
+++ S5-pre2-s_lock/fs/ufs/super.c	Tue May 15 18:12:35 2001
@@ -230,9 +230,6 @@
 	va_start (args, fmt);
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
-	/* this is to prevent panic from syncing this filesystem */
-	if (sb->s_lock)
-		sb->s_lock = 0;
 	sb->s_flags |= MS_RDONLY;
 	printk (KERN_CRIT "UFS-fs panic (device %s): %s: %s\n",
 		kdevname(sb->s_dev), function, error_buf);
diff -urN S5-pre2/include/linux/fs.h S5-pre2-s_lock/include/linux/fs.h
--- S5-pre2/include/linux/fs.h	Tue May 15 03:51:04 2001
+++ S5-pre2-s_lock/include/linux/fs.h	Tue May 15 18:12:35 2001
@@ -652,7 +652,6 @@
 	kdev_t			s_dev;
 	unsigned long		s_blocksize;
 	unsigned char		s_blocksize_bits;
-	unsigned char		s_lock;
 	unsigned char		s_dirt;
 	unsigned long long	s_maxbytes;	/* Max file size */
 	struct file_system_type	*s_type;
@@ -662,7 +661,7 @@
 	unsigned long		s_magic;
 	struct dentry		*s_root;
 	struct rw_semaphore	s_umount;
-	wait_queue_head_t	s_wait;
+	struct semaphore	s_lock;
 
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_locked_inodes;/* inodes being synced */
diff -urN S5-pre2/include/linux/locks.h S5-pre2-s_lock/include/linux/locks.h
--- S5-pre2/include/linux/locks.h	Thu May  3 15:24:14 2001
+++ S5-pre2-s_lock/include/linux/locks.h	Tue May 15 18:12:35 2001
@@ -39,30 +39,15 @@
  * a super-block (although even this isn't done right now.
  * nfs may need it).
  */
-extern void __wait_on_super(struct super_block *);
-
-extern inline void wait_on_super(struct super_block * sb)
-{
-	if (sb->s_lock)
-		__wait_on_super(sb);
-}
 
 extern inline void lock_super(struct super_block * sb)
 {
-	if (sb->s_lock)
-		__wait_on_super(sb);
-	sb->s_lock = 1;
+	down(&sb->s_lock);
 }
 
 extern inline void unlock_super(struct super_block * sb)
 {
-	sb->s_lock = 0;
-	/*
-	 * No need of any barrier, we're protected by
-	 * the big kernel lock here... unfortunately :)
-	 */
-	if (waitqueue_active(&sb->s_wait))
-		wake_up(&sb->s_wait);
+	up(&sb->s_lock);
 }
 
 #endif /* _LINUX_LOCKS_H */
diff -urN S5-pre2/kernel/ksyms.c S5-pre2-s_lock/kernel/ksyms.c
--- S5-pre2/kernel/ksyms.c	Tue May 15 03:51:04 2001
+++ S5-pre2-s_lock/kernel/ksyms.c	Tue May 15 18:12:35 2001
@@ -478,7 +478,6 @@
 
 /* Added to make file system as module */
 EXPORT_SYMBOL(sys_tz);
-EXPORT_SYMBOL(__wait_on_super);
 EXPORT_SYMBOL(file_fsync);
 EXPORT_SYMBOL(fsync_inode_buffers);
 EXPORT_SYMBOL(clear_inode);

