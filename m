Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbSJPRxH>; Wed, 16 Oct 2002 13:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbSJPRxH>; Wed, 16 Oct 2002 13:53:07 -0400
Received: from 216-42-72-140.ppp.netsville.net ([216.42.72.140]:51431 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S261211AbSJPRxD>;
	Wed, 16 Oct 2002 13:53:03 -0400
Subject: [PATCH] 2.5.x write_super is not for syncing
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Oct 2002 14:00:06 -0400
Message-Id: <1034791206.18503.68.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This patch adds a commit_super super operation that allows the journaled
filesystems to do something different for the periodic write_super calls
and sync.

Based on comments from Al about my last patch, alloc_super sets a
default empty super_operations struct on each super.  This allows us to
get rid of all checks for sb->s_ops == NULL.

sync_supers is changed so that it doesn't loop on a single FS if the
write_super call leaves sb->s_dirt set.  I did this by changing
generic_shutdown_super to use list_del_init(&sb->s_list), which allows
us to check for supers that have been removed from the super_blocks list
while we slept.  The idea came from an sgi patch Hugh Dickins sent me.

Anyway, this is against 2.5.43, please review:

--- 1.161/fs/buffer.c	Tue Oct  8 14:40:47 2002
+++ edited/fs/buffer.c	Wed Oct 16 11:39:04 2002
@@ -217,8 +217,10 @@
 	sync_inodes_sb(sb, 0);
 	DQUOT_SYNC(sb);
 	lock_super(sb);
-	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
+	if (sb->s_dirt && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
+	if (sb->s_dirt && sb->s_op->commit_super)
+		sb->s_op->commit_super(sb);
 	unlock_super(sb);
 	sync_blockdev(sb->s_bdev);
 	sync_inodes_sb(sb, 1);
@@ -251,7 +253,7 @@
 	wakeup_bdflush(0);
 	sync_inodes(0);	/* All mappings and inodes, including block devices */
 	DQUOT_SYNC(NULL);
-	sync_supers();	/* Write the superblocks */
+	commit_supers();	/* Write the superblocks */
 	sync_inodes(1);	/* All the mappings and inodes, again. */
 	return 0;
 }
@@ -274,7 +276,7 @@
 	/* sync the superblock to buffers */
 	sb = inode->i_sb;
 	lock_super(sb);
-	if (sb->s_op && sb->s_op->write_super)
+	if (sb->s_op->write_super)
 		sb->s_op->write_super(sb);
 	unlock_super(sb);
 
--- 1.22/fs/fs-writeback.c	Sun Sep 22 17:26:49 2002
+++ edited/fs/fs-writeback.c	Wed Oct 16 13:29:51 2002
@@ -57,7 +57,7 @@
 	 * dirty the inode itself
 	 */
 	if (flags & (I_DIRTY_SYNC | I_DIRTY_DATASYNC)) {
-		if (sb->s_op && sb->s_op->dirty_inode)
+		if (sb->s_op->dirty_inode)
 			sb->s_op->dirty_inode(inode);
 	}
 
@@ -103,8 +103,7 @@
 
 static void write_inode(struct inode *inode, int sync)
 {
-	if (inode->i_sb->s_op && inode->i_sb->s_op->write_inode &&
-			!is_bad_inode(inode))
+	if (inode->i_sb->s_op->write_inode && !is_bad_inode(inode))
 		inode->i_sb->s_op->write_inode(inode, sync);
 }
 
--- 1.83/fs/super.c	Mon Sep  9 17:00:57 2002
+++ edited/fs/super.c	Wed Oct 16 10:36:09 2002
@@ -48,6 +48,8 @@
  */
 static struct super_block *alloc_super(void)
 {
+	static struct super_operations default_op = {};
+
 	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
 	if (s) {
 		memset(s, 0, sizeof(struct super_block));
@@ -72,6 +74,7 @@
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
+		s->s_op = &default_op;
 	}
 out:
 	return s;
@@ -203,7 +206,12 @@
 		unlock_super(sb);
 	}
 	spin_lock(&sb_lock);
-	list_del(&sb->s_list);
+
+	/* 
+	 * use list_del_init so we can tell later if a super with an
+	 * incremented count has been removed from all lists
+	 */
+	list_del_init(&sb->s_list);
 	list_del(&sb->s_instances);
 	spin_unlock(&sb_lock);
 	up_write(&sb->s_umount);
@@ -267,35 +275,65 @@
 {
 	lock_super(sb);
 	if (sb->s_root && sb->s_dirt)
-		if (sb->s_op && sb->s_op->write_super)
+		if (sb->s_op->write_super)
 			sb->s_op->write_super(sb);
 	unlock_super(sb);
 }
 
+static inline void commit_super(struct super_block *sb)
+{
+	lock_super(sb);
+	if (sb->s_root && sb->s_dirt) {
+		if (sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		if (sb->s_op->commit_super)
+			sb->s_op->commit_super(sb);
+	}
+	unlock_super(sb);
+}
+
 /*
  * Note: check the dirty flag before waiting, so we don't
  * hold up the sync while mounting a device. (The newly
  * mounted device won't need syncing.)
  */
-void sync_supers(void)
+void dirty_super_op(void (*func)(struct super_block *))
 {
 	struct super_block * sb;
-restart:
 	spin_lock(&sb_lock);
+restart:
 	sb = sb_entry(super_blocks.next);
-	while (sb != sb_entry(&super_blocks))
+	while (sb != sb_entry(&super_blocks)) {
 		if (sb->s_dirt) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
-			write_super(sb);
-			drop_super(sb);
-			goto restart;
-		} else
-			sb = sb_entry(sb->s_list.next);
+			func(sb);
+			up_read(&sb->s_umount);
+
+			spin_lock(&sb_lock);
+			if (!--sb->s_count) {
+				destroy_super(sb);
+				goto restart;
+			} else if (list_empty(&sb->s_list)) {
+				goto restart;
+			}
+		} 
+		sb = sb_entry(sb->s_list.next);
+	}
 	spin_unlock(&sb_lock);
 }
 
+void sync_supers(void)
+{
+    dirty_super_op(write_super);
+}
+
+void commit_supers(void)
+{
+    dirty_super_op(commit_super);
+}
+
 /**
  *	get_super	-	get the superblock of a device
  *	@dev: device to get the superblock for
@@ -396,7 +434,7 @@
 	if ((flags & MS_RDONLY) && !(sb->s_flags & MS_RDONLY))
 		if (!fs_may_remount_ro(sb))
 			return -EBUSY;
-	if (sb->s_op && sb->s_op->remount_fs) {
+	if (sb->s_op->remount_fs) {
 		lock_super(sb);
 		retval = sb->s_op->remount_fs(sb, &flags, data);
 		unlock_super(sb);
--- 1.170/include/linux/fs.h	Fri Oct 11 04:49:46 2002
+++ edited/include/linux/fs.h	Wed Oct 16 10:42:16 2002
@@ -818,6 +818,7 @@
 	void (*umount_begin) (struct super_block *);
 
 	int (*show_options)(struct seq_file *, struct vfsmount *);
+	void (*commit_super) (struct super_block *);
 };
 
 /* Inode state bits.  Protected by inode_lock. */
@@ -1141,6 +1142,7 @@
 extern int filemap_fdatawrite(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
+extern void commit_supers(void);
 extern sector_t bmap(struct inode *, sector_t);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);




