Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbTCOU7K>; Sat, 15 Mar 2003 15:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbTCOU7J>; Sat, 15 Mar 2003 15:59:09 -0500
Received: from comtv.ru ([217.10.32.4]:24492 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261550AbTCOU66>;
	Sat, 15 Mar 2003 15:58:58 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: [PATCH] concurrent inode allocation for ext2 against 2.5.64
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 16 Mar 2003 00:01:38 +0300
Message-ID: <m365qk1gzx.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

here is the patch for ext2 concurrent inode allocation. should be applied
on top of previous concurrent-balloc patch. tested on dual p3 for several
hours of stress-test + fsck. hope someone test it on big iron ;)



diff -uNr linux/fs/ext2/ialloc.c edited/fs/ext2/ialloc.c
--- linux/fs/ext2/ialloc.c	Sat Mar 15 23:34:17 2003
+++ edited/fs/ext2/ialloc.c	Sat Mar 15 23:05:19 2003
@@ -63,6 +63,52 @@
 	return bh;
 }
 
+void ext2_reserve_inode (struct super_block * sb, int group, int dir)
+{
+	struct ext2_group_desc * desc;
+	struct buffer_head *bh;
+
+	desc = ext2_get_group_desc(sb, group, &bh);
+	if (!desc) {
+		ext2_error(sb, "ext2_reserve_inode",
+			"can't get descriptor for group %d", group);
+	return;
+	}
+
+	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	desc->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
+	if (dir)
+		desc->bg_used_dirs_count =
+			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
+	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+
+	mark_buffer_dirty(bh);
+}
+
+void ext2_release_inode (struct super_block * sb, int group, int dir)
+{
+	struct ext2_group_desc * desc;
+	struct buffer_head *bh;
+
+	desc = ext2_get_group_desc(sb, group, &bh);
+	if (!desc) {
+		ext2_error(sb, "ext2_release_inode",
+			"can't get descriptor for group %d", group);
+		return;
+	}
+
+	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	desc->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) + 1);
+	if (dir)
+		desc->bg_used_dirs_count =
+			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
+	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+
+	mark_buffer_dirty(bh);
+}
+
 /*
  * NOTE! When we get the inode, we're the only people
  * that have access to it, and as such there are no
@@ -85,10 +131,8 @@
 	int is_directory;
 	unsigned long ino;
 	struct buffer_head *bitmap_bh = NULL;
-	struct buffer_head *bh2;
 	unsigned long block_group;
 	unsigned long bit;
-	struct ext2_group_desc * desc;
 	struct ext2_super_block * es;
 
 	ino = inode->i_ino;
@@ -105,7 +149,6 @@
 		DQUOT_DROP(inode);
 	}
 
-	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 	is_directory = S_ISDIR(inode->i_mode);
 
@@ -126,32 +169,17 @@
 		goto error_return;
 
 	/* Ok, now we can actually update the inode bitmaps.. */
-	if (!ext2_clear_bit(bit, bitmap_bh->b_data))
+	if (!ext2_clear_bit_atomic(&EXT2_SB(sb)->s_bgi[block_group].ialloc_lock,
+				bit, (void *) bitmap_bh->b_data))
 		ext2_error (sb, "ext2_free_inode",
 			      "bit already cleared for inode %lu", ino);
-	else {
-		desc = ext2_get_group_desc (sb, block_group, &bh2);
-		if (desc) {
-			desc->bg_free_inodes_count =
-				cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) + 1);
-			if (is_directory) {
-				desc->bg_used_dirs_count =
-					cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
-				EXT2_SB(sb)->s_dir_count--;
-			}
-		}
-		mark_buffer_dirty(bh2);
-		es->s_free_inodes_count =
-			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
-		mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	}
+	else
+		ext2_release_inode(sb, block_group, is_directory);
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
-	sb->s_dirt = 1;
 error_return:
 	brelse(bitmap_bh);
-	unlock_super (sb);
 }
 
 /*
@@ -211,9 +239,8 @@
  */
 static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
-	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
 	int ngroups = EXT2_SB(sb)->s_groups_count;
-	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	int avefreei = ext2_count_free_inodes(sb) / ngroups;
 	struct ext2_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh, *best_bh = NULL;
 	int group, best_group = -1;
@@ -234,11 +261,9 @@
 	}
 	if (!best_desc)
 		return -1;
-	best_desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(best_desc->bg_free_inodes_count) - 1);
-	best_desc->bg_used_dirs_count =
-		cpu_to_le16(le16_to_cpu(best_desc->bg_used_dirs_count) + 1);
-	mark_buffer_dirty(best_bh);
+
+	ext2_reserve_inode(sb, best_group, 1);
+
 	return best_group;
 }
 
@@ -277,11 +302,12 @@
 	struct ext2_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
-	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	int freei = ext2_count_free_inodes(sb);
+	int avefreei = freei / ngroups;
 	int free_blocks = ext2_count_free_blocks(sb);
 	int avefreeb = free_blocks / ngroups;
 	int blocks_per_dir;
-	int ndirs = sbi->s_dir_count;
+	int ndirs = ext2_count_dirs(sb);
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
 	struct ext2_group_desc *desc;
@@ -364,12 +390,8 @@
 	return -1;
 
 found:
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	desc->bg_used_dirs_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
-	sbi->s_dir_count++;
-	mark_buffer_dirty(bh);
+	ext2_reserve_inode(sb, group, 1);
+
 	return group;
 }
 
@@ -431,9 +453,8 @@
 	return -1;
 
 found:
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	mark_buffer_dirty(bh);
+	ext2_reserve_inode(sb, group, 0);
+
 	return group;
 }
 
@@ -456,7 +477,6 @@
 		return ERR_PTR(-ENOMEM);
 
 	ei = EXT2_I(inode);
-	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 repeat:
 	if (S_ISDIR(mode)) {
@@ -480,7 +500,12 @@
 				      EXT2_INODES_PER_GROUP(sb));
 	if (i >= EXT2_INODES_PER_GROUP(sb))
 		goto bad_count;
-	ext2_set_bit(i, bitmap_bh->b_data);
+	if (ext2_set_bit_atomic(&EXT2_SB(sb)->s_bgi[group].ialloc_lock,
+			i, (void *) bitmap_bh->b_data)) {
+		brelse(bitmap_bh);
+		ext2_release_inode(sb, group, S_ISDIR(mode));
+		goto repeat;
+	}
 
	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
@@ -497,9 +524,7 @@
 		goto fail2;
 	}
 
-	es->s_free_inodes_count =
-		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
-
+	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
 	if (S_ISDIR(mode)) {
 		if (EXT2_SB(sb)->s_bgi[group].debts < 255)
 			EXT2_SB(sb)->s_bgi[group].debts++;
@@ -507,9 +532,8 @@
 		if (EXT2_SB(sb)->s_bgi[group].debts)
 			EXT2_SB(sb)->s_bgi[group].debts--;
 	}
-
-	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	sb->s_dirt = 1;
+	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
@@ -552,7 +576,6 @@
 	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
 	insert_inode_hash(inode);
 
-	unlock_super(sb);
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
 		goto fail3;
@@ -574,15 +597,8 @@
 	return ERR_PTR(err);
 
 fail2:
-	desc = ext2_get_group_desc (sb, group, &bh2);
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) + 1);
-	if (S_ISDIR(mode))
-		desc->bg_used_dirs_count =
-			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
-	mark_buffer_dirty(bh2);
+	ext2_release_inode(sb, group, S_ISDIR(mode));
 fail:
-	unlock_super(sb);
 	make_bad_inode(inode);
 	iput(inode);
 	return ERR_PTR(err);
@@ -605,16 +621,19 @@
 
 unsigned long ext2_count_free_inodes (struct super_block * sb)
 {
+	struct ext2_group_desc *desc;
+	unsigned long desc_count = 0;
+	int i;	
+
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
-	unsigned long desc_count = 0, bitmap_count = 0;
+	unsigned long bitmap_count = 0;
 	struct buffer_head *bitmap_bh = NULL;
 	int i;
 
 	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
-		struct ext2_group_desc *desc;
 		unsigned x;
 
 		desc = ext2_get_group_desc (sb, i, NULL);
@@ -637,7 +656,13 @@
 	unlock_super(sb);
 	return desc_count;
 #else
-	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_inodes_count);
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
+		desc = ext2_get_group_desc (sb, i, NULL);
+		if (!desc)
+			continue;
+		desc_count += le16_to_cpu(desc->bg_free_inodes_count);
+	}
+	return desc_count;
 #endif
 }
 
diff -uNr linux/fs/ext2/super.c edited/fs/ext2/super.c
--- linux/fs/ext2/super.c	Sat Mar 15 23:34:17 2003
+++ edited/fs/ext2/super.c	Sat Mar 15 22:15:51 2003
@@ -510,6 +510,7 @@
 	
 	/* restore free blocks counter in SB -bzzz */
 	es->s_free_blocks_count = total_free = ext2_count_free_blocks(sb);
+	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
 
 	/* distribute reserved blocks over groups -bzzz */
 	for(i = sbi->s_groups_count-1; reserved && total_free && i >= 0; i--) {
@@ -802,6 +803,7 @@
 		sbi->s_bgi[i].debts = 0;
 		sbi->s_bgi[i].reserved = 0;
 		spin_lock_init(&sbi->s_bgi[i].balloc_lock);
+		spin_lock_init(&sbi->s_bgi[i].ialloc_lock);
 	}
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logic_sb_block, i);
@@ -869,6 +871,7 @@
 static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
 {
 	es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
+	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
 	es->s_wtime = cpu_to_le32(get_seconds());
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
@@ -898,6 +901,7 @@
 			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
 						  ~EXT2_VALID_FS);
 			es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
+			es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
 			es->s_mtime = cpu_to_le32(get_seconds());
 			ext2_sync_super(sb, es);
 		} else
diff -uNr linux/include/linux/ext2_fs_sb.h edited/include/linux/ext2_fs_sb.h
--- linux/include/linux/ext2_fs_sb.h	Sat Mar 15 23:34:18 2003
+++ edited/include/linux/ext2_fs_sb.h	Sat Mar 15 21:38:35 2003
@@ -19,6 +19,7 @@
 struct ext2_bg_info {
 	u8 debts;
 	spinlock_t balloc_lock;
+	spinlock_t ialloc_lock;
 	unsigned int reserved;
 } ____cacheline_aligned_in_smp;

 

