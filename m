Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270616AbRHIXea>; Thu, 9 Aug 2001 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270612AbRHIXdR>; Thu, 9 Aug 2001 19:33:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35242 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270606AbRHIXcy>;
	Thu, 9 Aug 2001 19:32:54 -0400
Date: Thu, 9 Aug 2001 19:33:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c fixes (7/8)
In-Reply-To: <Pine.GSO.4.21.0108091932300.25945-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108091932500.25945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 7/8:

_Now_ we can drop the "reuse" branch in get_empty_super(). Done, remaining
thing renamed into alloc_super(). Insertion of the allocated superblock into
the super_blocks is moved into the caller (read_super()).

diff -urN S8-pre7-freeing/fs/super.c S8-pre7-alloc_super/fs/super.c
--- S8-pre7-freeing/fs/super.c	Thu Aug  9 19:07:32 2001
+++ S8-pre7-alloc_super/fs/super.c	Thu Aug  9 19:07:32 2001
@@ -59,8 +59,6 @@
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
 
-int nr_super_blocks;
-int max_super_blocks = NR_SUPER;
 LIST_HEAD(super_blocks);
 spinlock_t sb_lock = SPIN_LOCK_UNLOCKED;
 
@@ -775,43 +773,23 @@
  *	the request.
  */
  
-static struct super_block *get_empty_super(void)
+static struct super_block *alloc_super(void)
 {
-	struct super_block *s;
-
-	spin_lock(&sb_lock);
-	for (s  = sb_entry(super_blocks.next);
-	     s != sb_entry(&super_blocks); 
-	     s  = sb_entry(s->s_list.next)) {
-		if (s->s_dev)
-			continue;
-		s->s_count++;
-		atomic_inc(&s->s_active);
-		spin_unlock(&sb_lock);
-		return s;
-	}
-	spin_unlock(&sb_lock);
-	/* Need a new one... */
-	if (nr_super_blocks >= max_super_blocks)
-		return NULL;
-	s = kmalloc(sizeof(struct super_block),  GFP_USER);
+	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
 	if (s) {
-		nr_super_blocks++;
 		memset(s, 0, sizeof(struct super_block));
-		spin_lock(&sb_lock);
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
-		list_add (&s->s_list, super_blocks.prev);
 		INIT_LIST_HEAD(&s->s_files);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
-		atomic_set(&s->s_active, 1);
 		s->s_count = 1;
+		atomic_set(&s->s_active, 1);
 		sema_init(&s->s_vfs_rename_sem,1);
 		sema_init(&s->s_nfsd_free_path_sem,1);
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
-		spin_unlock(&sb_lock);
+		s->s_maxbytes = MAX_NON_LFS;
 	}
 	return s;
 }
@@ -821,16 +799,16 @@
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
@@ -994,8 +972,8 @@
 	sb = fs_type->kern_mnt->mnt_sb;
 	if (!sb)
 		BUG();
-	do_remount_sb(sb, flags, data);
 	atomic_inc(&sb->s_active);
+	do_remount_sb(sb, flags, data);
 	return sb;
 }
 
diff -urN S8-pre7-freeing/include/linux/fs.h S8-pre7-alloc_super/include/linux/fs.h
--- S8-pre7-freeing/include/linux/fs.h	Thu Aug  9 19:07:32 2001
+++ S8-pre7-alloc_super/include/linux/fs.h	Thu Aug  9 19:07:32 2001
@@ -61,7 +61,6 @@
 };
 extern struct inodes_stat_t inodes_stat;
 
-extern int max_super_blocks, nr_super_blocks;
 extern int leases_enable, dir_notify_enable, lease_break_time;
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
diff -urN S8-pre7-freeing/kernel/sysctl.c S8-pre7-alloc_super/kernel/sysctl.c
--- S8-pre7-freeing/kernel/sysctl.c	Sat Apr 14 21:41:29 2001
+++ S8-pre7-alloc_super/kernel/sysctl.c	Thu Aug  9 19:07:32 2001
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


