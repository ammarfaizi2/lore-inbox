Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263428AbRFKFit>; Mon, 11 Jun 2001 01:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263430AbRFKFik>; Mon, 11 Jun 2001 01:38:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33972 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263428AbRFKFiW>;
	Mon, 11 Jun 2001 01:38:22 -0400
Date: Mon, 11 Jun 2001 01:38:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c stuff (8/10)
In-Reply-To: <Pine.GSO.4.21.0106110137320.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110138000.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-s_count/fs/inode.c S6-pre2-freeing/fs/inode.c
--- S6-pre2-s_count/fs/inode.c	Sun Jun 10 12:45:04 2001
+++ S6-pre2-freeing/fs/inode.c	Sun Jun 10 12:45:47 2001
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
@@ -319,23 +302,13 @@
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
 
@@ -365,37 +338,75 @@
 	spin_unlock(&inode_lock);
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
+			up_read(&s->s_umount);
+			spin_lock(&sb_lock);
+			if (!--s->s_count)
+				kfree(s);
+			spin_unlock(&sb_lock);
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
-	struct super_block * sb;
+	struct super_block * s;
 
 	/*
 	 * Search the super_blocks array for the device(s) to sync.
 	 */
-	spin_lock(&sb_lock);
-	sb = sb_entry(super_blocks.next);
-	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
-		if (!sb->s_dev)
-			continue;
-		if (dev && sb->s_dev != dev)
-			continue;
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
-		if (sb->s_dev && (sb->s_dev == dev || !dev)) {
-			spin_lock(&inode_lock);
-			do {
-				sync_list(&sb->s_dirty);
-			} while (wait_on_dirty(&sb->s_locked_inodes));
-			spin_unlock(&inode_lock);
+	if (dev) {
+		if ((s = get_super(dev)) != NULL) {
+			down_read(&s->s_umount);
+			if (s->s_root)
+				sync_inodes_sb(s);
+			up_read(&s->s_umount);
+			spin_lock(&sb_lock);
+			if (!--s->s_count)
+				kfree(s);
+			spin_unlock(&sb_lock);
+		}
+	} else {
+		while ((s = get_super_to_sync()) != NULL) {
+			sync_inodes_sb(s);
+			up_read(&s->s_umount);
+			spin_lock(&sb_lock);
+			if (!--s->s_count)
+				kfree(s);
+			spin_unlock(&sb_lock);
 		}
-		up_read(&sb->s_umount);
-		spin_lock(&sb_lock);
-		sb->s_count--;
-		if (dev)
-			break;
 	}
-	spin_unlock(&sb_lock);
 }
 
 /*
diff -urN S6-pre2-s_count/fs/super.c S6-pre2-freeing/fs/super.c
--- S6-pre2-s_count/fs/super.c	Sun Jun 10 12:45:04 2001
+++ S6-pre2-freeing/fs/super.c	Sun Jun 10 12:45:47 2001
@@ -644,7 +644,8 @@
 static inline void __put_super(struct super_block *sb)
 {
 	spin_lock(&sb_lock);
-	sb->s_count--;
+	if (!--sb->s_count)
+		kfree(sb);
 	spin_unlock(&sb_lock);
 }
 
@@ -652,6 +653,21 @@
 {
 	__put_super(sb);
 }
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
@@ -662,26 +678,30 @@
 {
 	struct super_block * sb;
 
-	spin_lock(&sb_lock);
-	for (sb = sb_entry(super_blocks.next);
-	     sb != sb_entry(&super_blocks); 
-	     sb = sb_entry(sb->s_list.next)) {
-		if (!sb->s_dev)
-			continue;
-		if (dev && sb->s_dev != dev)
-			continue;
-		if (!sb->s_dirt)
-			continue;
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-		lock_super(sb);
-		if (sb->s_dev && sb->s_dirt && (!dev || dev == sb->s_dev))
-			if (sb->s_op && sb->s_op->write_super)
-				sb->s_op->write_super(sb);
-		unlock_super(sb);
-		spin_lock(&sb_lock);
-		sb->s_count--;
+	if (dev) {
+		sb = get_super(dev);
+		if (sb) {
+			if (sb->s_dirt)
+				write_super(sb);
+			up_read(&sb->s_umount);
+			__put_super(sb);
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
+			up_read(&sb->s_umount);
+			__put_super(sb);
+			goto restart;
+		} else
+			sb = sb_entry(sb->s_list.next);
 	spin_unlock(&sb_lock);
 }
 
@@ -1022,8 +1042,10 @@
 		bdput(bdev);
 	} else
 		put_unnamed_dev(dev);
-	up_write(&sb->s_umount);
-	__put_super(sb);
+	spin_lock(&sb_lock);
+	list_del(&sb->s_list);
+	spin_unlock(&sb_lock);
+	put_super(sb);
 }
 
 /*


