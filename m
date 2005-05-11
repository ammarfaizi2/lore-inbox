Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVEKPxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVEKPxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVEKPxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:53:03 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:36530 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261965AbVEKPwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:52:06 -0400
Message-ID: <42822A21.8090600@sw.ru>
Date: Wed, 11 May 2005 19:52:01 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] O(1) sb list traversing on syncs
Content-Type: multipart/mixed;
 boundary="------------020901030605070105030709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901030605070105030709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

against 2.6.12-rc4

This patch removes O(n^2) super block loops
in sync_inodes(), sync_filesystems() etc. in favour
of using __put_super_and_need_restart() which
I introduced earlier. We faced a noticably long freezes on sb
syncing when there are thousands of super blocks in the system.

The patch was heavilly tested on 2.6.8 during 3 months,
this forward-ported version boots and works ok as well.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

--------------020901030605070105030709
Content-Type: text/plain;
 name="diff-inode-sbsync-20050317-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-inode-sbsync-20050317-2"

--- ./fs/fs-writeback.c.sbsync	2005-05-10 16:10:26.000000000 +0400
+++ ./fs/fs-writeback.c	2005-05-10 18:29:03.000000000 +0400
@@ -485,32 +485,6 @@ static void set_sb_syncing(int val)
 	spin_unlock(&sb_lock);
 }
 
-/*
- * Find a superblock with inodes that need to be synced
- */
-static struct super_block *get_super_to_sync(void)
-{
-	struct super_block *sb;
-restart:
-	spin_lock(&sb_lock);
-	sb = sb_entry(super_blocks.prev);
-	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
-		if (sb->s_syncing)
-			continue;
-		sb->s_syncing = 1;
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
-		if (!sb->s_root) {
-			drop_super(sb);
-			goto restart;
-		}
-		return sb;
-	}
-	spin_unlock(&sb_lock);
-	return NULL;
-}
-
 /**
  * sync_inodes - writes all inodes to disk
  * @wait: wait for completion
@@ -530,23 +504,39 @@ restart:
  * outstanding dirty inodes, the writeback goes block-at-a-time within the
  * filesystem's write_inode().  This is extremely slow.
  */
-void sync_inodes(int wait)
+static void __sync_inodes(int wait)
 {
 	struct super_block *sb;
 
-	set_sb_syncing(0);
-	while ((sb = get_super_to_sync()) != NULL) {
-		sync_inodes_sb(sb, 0);
-		sync_blockdev(sb->s_bdev);
-		drop_super(sb);
+	spin_lock(&sb_lock);
+restart:
+	list_for_each_entry(sb, &super_blocks, s_list) {	
+		if (sb->s_syncing)
+			continue;
+		sb->s_syncing = 1;
+		sb->s_count++;
+		spin_unlock(&sb_lock);				
+		down_read(&sb->s_umount); 
+		if (sb->s_root) {
+			sync_inodes_sb(sb, wait);
+			sync_blockdev(sb->s_bdev);
+		}
+		up_read(&sb->s_umount);	
+		spin_lock(&sb_lock);
+		if (__put_super_and_need_restart(sb))
+			goto restart;
 	}
+	spin_unlock(&sb_lock);
+}
+
+void sync_inodes(int wait)
+{
+	set_sb_syncing(0);
+	__sync_inodes(0);
+	
 	if (wait) {
 		set_sb_syncing(0);
-		while ((sb = get_super_to_sync()) != NULL) {
-			sync_inodes_sb(sb, 1);
-			sync_blockdev(sb->s_bdev);
-			drop_super(sb);
-		}
+		__sync_inodes(1);
 	}
 }
 
--- ./fs/quota.c.sbsync	2005-05-10 16:10:29.000000000 +0400
+++ ./fs/quota.c	2005-05-10 18:41:51.000000000 +0400
@@ -149,36 +149,6 @@ static int check_quotactl_valid(struct s
 	return error;
 }
 
-static struct super_block *get_super_to_sync(int type)
-{
-	struct list_head *head;
-	int cnt, dirty;
-
-restart:
-	spin_lock(&sb_lock);
-	list_for_each(head, &super_blocks) {
-		struct super_block *sb = list_entry(head, struct super_block, s_list);
-
-		/* This test just improves performance so it needn't be reliable... */
-		for (cnt = 0, dirty = 0; cnt < MAXQUOTAS; cnt++)
-			if ((type == cnt || type == -1) && sb_has_quota_enabled(sb, cnt)
-			    && info_any_dirty(&sb_dqopt(sb)->info[cnt]))
-				dirty = 1;
-		if (!dirty)
-			continue;
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
-		if (!sb->s_root) {
-			drop_super(sb);
-			goto restart;
-		}
-		return sb;
-	}
-	spin_unlock(&sb_lock);
-	return NULL;
-}
-
 static void quota_sync_sb(struct super_block *sb, int type)
 {
 	int cnt;
@@ -219,17 +189,35 @@ static void quota_sync_sb(struct super_b
 
 void sync_dquots(struct super_block *sb, int type)
 {
+	int cnt, dirty;
+
 	if (sb) {
 		if (sb->s_qcop->quota_sync)
 			quota_sync_sb(sb, type);
+		return;
 	}
-	else {
-		while ((sb = get_super_to_sync(type)) != NULL) {
-			if (sb->s_qcop->quota_sync)
-				quota_sync_sb(sb, type);
-			drop_super(sb);
-		}
+
+	spin_lock(&sb_lock);
+restart:
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		/* This test just improves performance so it needn't be reliable... */
+		for (cnt = 0, dirty = 0; cnt < MAXQUOTAS; cnt++)
+			if ((type == cnt || type == -1) && sb_has_quota_enabled(sb, cnt)
+			    && info_any_dirty(&sb_dqopt(sb)->info[cnt]))
+				dirty = 1;
+		if (!dirty)
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+		down_read(&sb->s_umount);
+		if (sb->s_root && sb->s_qcop->quota_sync)
+			quota_sync_sb(sb, type);
+		up_read(&sb->s_umount);
+		spin_lock(&sb_lock);
+		if (__put_super_and_need_restart(sb))
+			goto restart;
 	}
+	spin_unlock(&sb_lock);
 }
 
 /* Copy parameters and call proper function */
--- ./fs/super.c.sbsync	2005-05-10 17:53:36.000000000 +0400
+++ ./fs/super.c	2005-05-11 19:32:12.000000000 +0400
@@ -343,20 +343,22 @@ static inline void write_super(struct su
  */
 void sync_supers(void)
 {
-	struct super_block * sb;
-restart:
+	struct super_block *sb;
+	
 	spin_lock(&sb_lock);
-	sb = sb_entry(super_blocks.next);
-	while (sb != sb_entry(&super_blocks))
+restart:
+	list_for_each_entry(sb, &super_blocks, s_list) {
 		if (sb->s_dirt) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
 			write_super(sb);
-			drop_super(sb);
-			goto restart;
-		} else
-			sb = sb_entry(sb->s_list.next);
+			up_read(&sb->s_umount);
+			spin_lock(&sb_lock);
+			if (__put_super_and_need_restart(sb)) 
+				goto restart;
+		}
+	}
 	spin_unlock(&sb_lock);
 }
 
@@ -383,20 +385,16 @@ void sync_filesystems(int wait)
 
 	down(&mutex);		/* Could be down_interruptible */
 	spin_lock(&sb_lock);
-	for (sb = sb_entry(super_blocks.next); sb != sb_entry(&super_blocks);
-			sb = sb_entry(sb->s_list.next)) {
+	list_for_each_entry(sb, &super_blocks, s_list) {
 		if (!sb->s_op->sync_fs)
 			continue;
 		if (sb->s_flags & MS_RDONLY)
 			continue;
 		sb->s_need_sync_fs = 1;
 	}
-	spin_unlock(&sb_lock);
 
 restart:
-	spin_lock(&sb_lock);
-	for (sb = sb_entry(super_blocks.next); sb != sb_entry(&super_blocks);
-			sb = sb_entry(sb->s_list.next)) {
+	list_for_each_entry(sb, &super_blocks, s_list) {
 		if (!sb->s_need_sync_fs)
 			continue;
 		sb->s_need_sync_fs = 0;
@@ -407,8 +405,11 @@ restart:
 		down_read(&sb->s_umount);
 		if (sb->s_root && (wait || sb->s_dirt))
 			sb->s_op->sync_fs(sb, wait);
-		drop_super(sb);
-		goto restart;
+		up_read(&sb->s_umount);
+		/* restart only when sb is no longer on the list */
+		spin_lock(&sb_lock);
+		if (__put_super_and_need_restart(sb))
+			goto restart;
 	}
 	spin_unlock(&sb_lock);
 	up(&mutex);
@@ -424,21 +425,25 @@ restart:
 
 struct super_block * get_super(struct block_device *bdev)
 {
-	struct list_head *p;
+	struct super_block *sb;
+
 	if (!bdev)
 		return NULL;
-rescan:
+
 	spin_lock(&sb_lock);
-	list_for_each(p, &super_blocks) {
-		struct super_block *s = sb_entry(p);
-		if (s->s_bdev == bdev) {
-			s->s_count++;
+rescan:
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (sb->s_bdev == bdev) {
+			sb->s_count++;
 			spin_unlock(&sb_lock);
-			down_read(&s->s_umount);
-			if (s->s_root)
-				return s;
-			drop_super(s);
-			goto rescan;
+			down_read(&sb->s_umount);
+			if (sb->s_root)
+				return sb;
+			up_read(&sb->s_umount);
+			/* restart only when sb is no longer on the list */
+			spin_lock(&sb_lock);
+			if (__put_super_and_need_restart(sb))
+				goto rescan;
 		}
 	}
 	spin_unlock(&sb_lock);
@@ -449,20 +454,22 @@ EXPORT_SYMBOL(get_super);
  
 struct super_block * user_get_super(dev_t dev)
 {
-	struct list_head *p;
+	struct super_block *sb;
 
-rescan:
 	spin_lock(&sb_lock);
-	list_for_each(p, &super_blocks) {
-		struct super_block *s = sb_entry(p);
-		if (s->s_dev ==  dev) {
-			s->s_count++;
+rescan:
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (sb->s_dev ==  dev) {
+			sb->s_count++;
 			spin_unlock(&sb_lock);
-			down_read(&s->s_umount);
-			if (s->s_root)
-				return s;
-			drop_super(s);
-			goto rescan;
+			down_read(&sb->s_umount);
+			if (sb->s_root)
+				return sb;
+			up_read(&sb->s_umount);
+			/* restart only when sb is no longer on the list */
+			spin_lock(&sb_lock);
+			if (__put_super_and_need_restart(sb))
+				goto rescan;
 		}
 	}
 	spin_unlock(&sb_lock);

--------------020901030605070105030709--

