Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263433AbRFKFkl>; Mon, 11 Jun 2001 01:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263431AbRFKFkZ>; Mon, 11 Jun 2001 01:40:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4791 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263430AbRFKFjo>;
	Mon, 11 Jun 2001 01:39:44 -0400
Date: Mon, 11 Jun 2001 01:39:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c stuff (9/10)
In-Reply-To: <Pine.GSO.4.21.0106110138000.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110138470.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-freeing/fs/super.c S6-pre2-current/fs/super.c
--- S6-pre2-freeing/fs/super.c	Sun Jun 10 12:45:47 2001
+++ S6-pre2-current/fs/super.c	Sun Jun 10 12:53:15 2001
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
@@ -991,8 +969,8 @@
 	sb = fs_type->kern_mnt->mnt_sb;
 	if (!sb)
 		BUG();
-	do_remount_sb(sb, flags, data);
 	atomic_inc(&sb->s_active);
+	do_remount_sb(sb, flags, data);
 	return sb;
 }
 
diff -urN S6-pre2-freeing/include/linux/fs.h S6-pre2-current/include/linux/fs.h
--- S6-pre2-freeing/include/linux/fs.h	Sun Jun 10 12:45:04 2001
+++ S6-pre2-current/include/linux/fs.h	Sun Jun 10 06:10:13 2001
@@ -61,7 +61,6 @@
 };
 extern struct inodes_stat_t inodes_stat;
 
-extern int max_super_blocks, nr_super_blocks;
 extern int leases_enable, dir_notify_enable, lease_break_time;
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
diff -urN S6-pre2-freeing/kernel/sysctl.c S6-pre2-current/kernel/sysctl.c
--- S6-pre2-freeing/kernel/sysctl.c	Sat Apr 14 21:41:29 2001
+++ S6-pre2-current/kernel/sysctl.c	Sun Jun 10 06:09:56 2001
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


