Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291279AbSCMAQH>; Tue, 12 Mar 2002 19:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291291AbSCMAPs>; Tue, 12 Mar 2002 19:15:48 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:23702 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S291279AbSCMAPc>; Tue, 12 Mar 2002 19:15:32 -0500
Message-ID: <3C8E9A0A.2040804@didntduck.org>
Date: Tue, 12 Mar 2002 19:15:06 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - ext2
Content-Type: multipart/mixed;
 boundary="------------000300080207020702040600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000300080207020702040600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

First patch abstracts access to ext2_sb_info.  Second patch completes 
the seperation.

-- 

						Brian Gerst

--------------000300080207020702040600
Content-Type: text/plain;
 name="sb-ext2-a1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-ext2-a1"

diff -urN linux-2.5.7-pre1/fs/ext2/balloc.c linux/fs/ext2/balloc.c
--- linux-2.5.7-pre1/fs/ext2/balloc.c	Thu Mar  7 21:18:25 2002
+++ linux/fs/ext2/balloc.c	Tue Mar 12 18:00:36 2002
@@ -41,7 +41,7 @@
 	unsigned long group_desc;
 	unsigned long offset;
 	struct ext2_group_desc * desc;
-	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 
 	if (block_group >= sbi->s_groups_count) {
 		ext2_error (sb, "ext2_get_group_desc",
@@ -110,7 +110,7 @@
 static struct buffer_head *load_block_bitmap(struct super_block * sb,
 						unsigned int block_group)
 {
-	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	int i, slot = 0;
 	struct buffer_head *bh = sbi->s_block_bitmap[0];
 
@@ -249,7 +249,7 @@
 	unsigned freed = 0, group_freed;
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) || 
 	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_free_blocks",
@@ -285,9 +285,9 @@
 	if (in_range (le32_to_cpu(desc->bg_block_bitmap), block, count) ||
 	    in_range (le32_to_cpu(desc->bg_inode_bitmap), block, count) ||
 	    in_range (block, le32_to_cpu(desc->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group) ||
+		      EXT2_SB(sb)->s_itb_per_group) ||
 	    in_range (block + count - 1, le32_to_cpu(desc->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
+		      EXT2_SB(sb)->s_itb_per_group))
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks in system zones - "
 			    "Block = %lu, count = %lu",
@@ -552,11 +552,11 @@
 	int i;
 	
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	desc = NULL;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		struct buffer_head *bh;
 		desc = ext2_get_group_desc (sb, i, NULL);
 		if (!desc)
@@ -576,7 +576,7 @@
 	unlock_super (sb);
 	return bitmap_count;
 #else
-	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_blocks_count);
+	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_blocks_count);
 #endif
 }
 
@@ -584,7 +584,7 @@
 				struct super_block * sb,
 				unsigned char * map)
 {
-	return ext2_test_bit ((block - le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block)) %
+	return ext2_test_bit ((block - le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block)) %
 			 EXT2_BLOCKS_PER_GROUP(sb), map);
 }
 
@@ -651,11 +651,11 @@
 	struct ext2_group_desc * desc;
 	int i;
 
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	desc = NULL;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		desc = ext2_get_group_desc (sb, i, NULL);
 		if (!desc)
 			continue;
@@ -685,7 +685,7 @@
 				    "Inode bitmap for group %d is marked free",
 				    i);
 
-		for (j = 0; j < sb->u.ext2_sb.s_itb_per_group; j++)
+		for (j = 0; j < EXT2_SB(sb)->s_itb_per_group; j++)
 			if (!block_in_use (le32_to_cpu(desc->bg_inode_table) + j, sb, bh->b_data))
 				ext2_error (sb, "ext2_check_blocks_bitmap",
 					    "Block #%ld of the inode table in "
diff -urN linux-2.5.7-pre1/fs/ext2/dir.c linux/fs/ext2/dir.c
--- linux-2.5.7-pre1/fs/ext2/dir.c	Thu Mar  7 21:18:04 2002
+++ linux/fs/ext2/dir.c	Tue Mar 12 18:00:36 2002
@@ -68,7 +68,7 @@
 	struct super_block *sb = dir->i_sb;
 	unsigned chunk_size = ext2_chunk_size(dir);
 	char *kaddr = page_address(page);
-	u32 max_inumber = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	u32 max_inumber = le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_CACHE_SIZE;
 	ext2_dirent *p;
diff -urN linux-2.5.7-pre1/fs/ext2/ialloc.c linux/fs/ext2/ialloc.c
--- linux-2.5.7-pre1/fs/ext2/ialloc.c	Thu Mar  7 21:18:33 2002
+++ linux/fs/ext2/ialloc.c	Tue Mar 12 18:00:36 2002
@@ -77,7 +77,7 @@
 					      unsigned int block_group)
 {
 	int i, slot = 0;
-	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct buffer_head *bh = sbi->s_inode_bitmap[0];
 
 	if (block_group >= sbi->s_groups_count)
@@ -171,7 +171,7 @@
 	}
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 	is_directory = S_ISDIR(inode->i_mode);
 
 	/* Do this BEFORE marking the inode not in use or returning an error */
@@ -205,7 +205,7 @@
 		mark_buffer_dirty(bh2);
 		es->s_free_inodes_count =
 			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	}
 	mark_buffer_dirty(bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
@@ -230,8 +230,8 @@
 
 static int find_group_dir(struct super_block *sb, int parent_group)
 {
-	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
-	int ngroups = sb->u.ext2_sb.s_groups_count;
+	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
+	int ngroups = EXT2_SB(sb)->s_groups_count;
 	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
 	struct ext2_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh, *best_bh = NULL;
@@ -263,7 +263,7 @@
 
 static int find_group_other(struct super_block *sb, int parent_group)
 {
-	int ngroups = sb->u.ext2_sb.s_groups_count;
+	int ngroups = EXT2_SB(sb)->s_groups_count;
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh;
 	int group, i;
@@ -330,7 +330,7 @@
 
 	ei = EXT2_I(inode);
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 repeat:
 	if (S_ISDIR(mode))
 		group = find_group_dir(sb, EXT2_I(dir)->i_block_group);
@@ -369,7 +369,7 @@
 
 	es->s_free_inodes_count =
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
@@ -405,7 +405,7 @@
 	ei->i_dir_start_lookup = 0;
 	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
-	inode->i_generation = sb->u.ext2_sb.s_next_generation++;
+	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 
@@ -457,8 +457,8 @@
 	int i;
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	es = EXT2_SB(sb)->s_es;
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		struct ext2_group_desc *desc = ext2_get_group_desc (sb, i, NULL);
 		struct buffer_head *bh;
 		unsigned x;
@@ -480,7 +480,7 @@
 	unlock_super (sb);
 	return desc_count;
 #else
-	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_inodes_count);
+	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_inodes_count);
 #endif
 }
 
@@ -488,11 +488,11 @@
 /* Called at mount-time, super-block is locked */
 void ext2_check_inodes_bitmap (struct super_block * sb)
 {
-	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
 	unsigned long desc_count = 0, bitmap_count = 0;
 	int i;
 
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		struct ext2_group_desc *desc = ext2_get_group_desc(sb, i, NULL);
 		struct buffer_head *bh;
 		unsigned x;
diff -urN linux-2.5.7-pre1/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux-2.5.7-pre1/fs/ext2/inode.c	Thu Mar  7 21:18:10 2002
+++ linux/fs/ext2/inode.c	Tue Mar 12 18:00:36 2002
@@ -303,7 +303,7 @@
 	 * the same cylinder group then.
 	 */
 	return (ei->i_block_group * EXT2_BLOCKS_PER_GROUP(inode->i_sb)) +
-	       le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_first_data_block);
+	       le32_to_cpu(EXT2_SB(inode->i_sb)->s_es->s_first_data_block);
 }
 
 /**
@@ -886,7 +886,7 @@
 	*p = NULL;
 	if ((ino != EXT2_ROOT_INO && ino != EXT2_ACL_IDX_INO &&
 	     ino != EXT2_ACL_DATA_INO && ino < EXT2_FIRST_INO(sb)) ||
-	    ino > le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count))
+	    ino > le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count))
 		goto Einval;
 
 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
diff -urN linux-2.5.7-pre1/fs/ext2/super.c linux/fs/ext2/super.c
--- linux-2.5.7-pre1/fs/ext2/super.c	Tue Mar 12 17:35:10 2002
+++ linux/fs/ext2/super.c	Tue Mar 12 18:02:43 2002
@@ -37,10 +37,11 @@
 		 const char * fmt, ...)
 {
 	va_list args;
-	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_super_block *es = sbi->s_es;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
+		sbi->s_mount_state |= EXT2_ERROR_FS;
 		es->s_state =
 			cpu_to_le16(le16_to_cpu(es->s_state) | EXT2_ERROR_FS);
 		ext2_sync_super(sb, es);
@@ -49,14 +50,14 @@
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
 	if (test_opt (sb, ERRORS_PANIC) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_PANIC &&
+	    (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_RO)))
 		panic ("EXT2-fs panic (device %s): %s: %s\n",
 		       sb->s_id, function, error_buf);
 	printk (KERN_CRIT "EXT2-fs error (device %s): %s: %s\n",
 		sb->s_id, function, error_buf);
 	if (test_opt (sb, ERRORS_RO) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_RO &&
+	    (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_RO &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_PANIC))) {
 		printk ("Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
@@ -67,12 +68,13 @@
 			    const char * fmt, ...)
 {
 	va_list args;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
-		sb->u.ext2_sb.s_es->s_state =
-			cpu_to_le16(le16_to_cpu(sb->u.ext2_sb.s_es->s_state) | EXT2_ERROR_FS);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		sbi->s_mount_state |= EXT2_ERROR_FS;
+		sbi->s_es->s_state =
+			cpu_to_le16(le16_to_cpu(sbi->s_es->s_state) | EXT2_ERROR_FS);
+		mark_buffer_dirty(sbi->s_sbh);
 		sb->s_dirt = 1;
 	}
 	va_start (args, fmt);
@@ -124,25 +126,26 @@
 {
 	int db_count;
 	int i;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+		struct ext2_super_block *es = sbi->s_es;
 
-		es->s_state = le16_to_cpu(EXT2_SB(sb)->s_mount_state);
+		es->s_state = le16_to_cpu(sbi->s_mount_state);
 		ext2_sync_super(sb, es);
 	}
-	db_count = EXT2_SB(sb)->s_gdb_count;
+	db_count = sbi->s_gdb_count;
 	for (i = 0; i < db_count; i++)
-		if (sb->u.ext2_sb.s_group_desc[i])
-			brelse (sb->u.ext2_sb.s_group_desc[i]);
-	kfree(sb->u.ext2_sb.s_group_desc);
+		if (sbi->s_group_desc[i])
+			brelse (sbi->s_group_desc[i]);
+	kfree(sbi->s_group_desc);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_inode_bitmap[i])
-			brelse (sb->u.ext2_sb.s_inode_bitmap[i]);
+		if (sbi->s_inode_bitmap[i])
+			brelse (sbi->s_inode_bitmap[i]);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_block_bitmap[i])
-			brelse (sb->u.ext2_sb.s_block_bitmap[i]);
-	brelse (sb->u.ext2_sb.s_sbh);
+		if (sbi->s_block_bitmap[i])
+			brelse (sbi->s_block_bitmap[i]);
+	brelse (sbi->s_sbh);
 
 	return;
 }
@@ -333,6 +336,8 @@
 			      int read_only)
 {
 	int res = 0;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+
 	if (le32_to_cpu(es->s_rev_level) > EXT2_MAX_SUPP_REV) {
 		printk ("EXT2-fs warning: revision level too high, "
 			"forcing read-only mode\n");
@@ -340,10 +345,10 @@
 	}
 	if (read_only)
 		return res;
-	if (!(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
+	if (!(sbi->s_mount_state & EXT2_VALID_FS))
 		printk ("EXT2-fs warning: mounting unchecked fs, "
 			"running e2fsck is recommended\n");
-	else if ((sb->u.ext2_sb.s_mount_state & EXT2_ERROR_FS))
+	else if ((sbi->s_mount_state & EXT2_ERROR_FS))
 		printk ("EXT2-fs warning: mounting fs with errors, "
 			"running e2fsck is recommended\n");
 	else if ((__s16) le16_to_cpu(es->s_max_mnt_count) >= 0 &&
@@ -363,11 +368,11 @@
 		printk ("[EXT II FS %s, %s, bs=%lu, fs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]\n",
 			EXT2FS_VERSION, EXT2FS_DATE, sb->s_blocksize,
-			sb->u.ext2_sb.s_frag_size,
-			sb->u.ext2_sb.s_groups_count,
+			sbi->s_frag_size,
+			sbi->s_groups_count,
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
-			sb->u.ext2_sb.s_mount_opt);
+			sbi->s_mount_opt);
 #ifdef CONFIG_EXT2_CHECK
 	if (test_opt (sb, CHECK)) {
 		ext2_check_blocks_bitmap (sb);
@@ -381,15 +386,16 @@
 {
 	int i;
 	int desc_block = 0;
-	unsigned long block = le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block);
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	unsigned long block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	struct ext2_group_desc * gdp = NULL;
 
 	ext2_debug ("Checking group descriptors");
 
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++)
+	for (i = 0; i < sbi->s_groups_count; i++)
 	{
 		if ((i % EXT2_DESC_PER_BLOCK(sb)) == 0)
-			gdp = (struct ext2_group_desc *) sb->u.ext2_sb.s_group_desc[desc_block++]->b_data;
+			gdp = (struct ext2_group_desc *) sbi->s_group_desc[desc_block++]->b_data;
 		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
 		    le32_to_cpu(gdp->bg_block_bitmap) >= block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
@@ -409,7 +415,7 @@
 			return 0;
 		}
 		if (le32_to_cpu(gdp->bg_inode_table) < block ||
-		    le32_to_cpu(gdp->bg_inode_table) + sb->u.ext2_sb.s_itb_per_group >=
+		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >=
 		    block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
 			ext2_error (sb, "ext2_check_descriptors",
@@ -446,6 +452,7 @@
 static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct buffer_head * bh;
+	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
 	unsigned long sb_block = 1;
 	unsigned short resuid = EXT2_DEF_RESUID;
@@ -456,6 +463,7 @@
 	int db_count;
 	int i, j;
 
+	sbi = EXT2_SB(sb);
 	/*
 	 * See what the current blocksize for the device is, and
 	 * use that as the blocksize.  Otherwise (or if the blocksize
@@ -464,9 +472,9 @@
 	 * sectorsize that is larger than the default.
 	 */
 
-	sb->u.ext2_sb.s_mount_opt = 0;
+	sbi->s_mount_opt = 0;
 	if (!parse_options ((char *) data, &sb_block, &resuid, &resgid,
-	    &sb->u.ext2_sb.s_mount_opt))
+	    &sbi->s_mount_opt))
 		return -EINVAL;
 
 	blocksize = sb_min_blocksize(sb, BLOCK_SIZE);
@@ -494,7 +502,7 @@
 	 *       some ext2 macro-instructions depend on its value
 	 */
 	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-	sb->u.ext2_sb.s_es = es;
+	sbi->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
@@ -526,7 +534,7 @@
 		       sb->s_id, i);
 		goto failed_mount;
 	}
-	blocksize = BLOCK_SIZE << le32_to_cpu(EXT2_SB(sb)->s_es->s_log_block_size);
+	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 	/* If the blocksize doesn't match, re-read the thing.. */
 	if (sb->s_blocksize != blocksize) {
 		brelse(bh);
@@ -545,7 +553,7 @@
 			goto failed_mount;
 		}
 		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-		sb->u.ext2_sb.s_es = es;
+		sbi->s_es = es;
 		if (es->s_magic != le16_to_cpu(EXT2_SUPER_MAGIC)) {
 			printk ("EXT2-fs: Magic mismatch, very weird !\n");
 			goto failed_mount;
@@ -555,46 +563,46 @@
 	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
-		sb->u.ext2_sb.s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
-		sb->u.ext2_sb.s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
+		sbi->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
+		sbi->s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
 	} else {
-		sb->u.ext2_sb.s_inode_size = le16_to_cpu(es->s_inode_size);
-		sb->u.ext2_sb.s_first_ino = le32_to_cpu(es->s_first_ino);
-		if (sb->u.ext2_sb.s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
+		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
+		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
+		if (sbi->s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
 			printk ("EXT2-fs: unsupported inode size: %d\n",
-				sb->u.ext2_sb.s_inode_size);
+				sbi->s_inode_size);
 			goto failed_mount;
 		}
 	}
-	sb->u.ext2_sb.s_frag_size = EXT2_MIN_FRAG_SIZE <<
+	sbi->s_frag_size = EXT2_MIN_FRAG_SIZE <<
 				   le32_to_cpu(es->s_log_frag_size);
-	if (sb->u.ext2_sb.s_frag_size)
-		sb->u.ext2_sb.s_frags_per_block = sb->s_blocksize /
-						  sb->u.ext2_sb.s_frag_size;
+	if (sbi->s_frag_size)
+		sbi->s_frags_per_block = sb->s_blocksize /
+						  sbi->s_frag_size;
 	else
 		sb->s_magic = 0;
-	sb->u.ext2_sb.s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sb->u.ext2_sb.s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
-	sb->u.ext2_sb.s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
-	sb->u.ext2_sb.s_inodes_per_block = sb->s_blocksize /
+	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
+	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
+	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
+	sbi->s_inodes_per_block = sb->s_blocksize /
 					   EXT2_INODE_SIZE(sb);
-	sb->u.ext2_sb.s_itb_per_group = sb->u.ext2_sb.s_inodes_per_group /
-				        sb->u.ext2_sb.s_inodes_per_block;
-	sb->u.ext2_sb.s_desc_per_block = sb->s_blocksize /
+	sbi->s_itb_per_group = sbi->s_inodes_per_group /
+				        sbi->s_inodes_per_block;
+	sbi->s_desc_per_block = sb->s_blocksize /
 					 sizeof (struct ext2_group_desc);
-	sb->u.ext2_sb.s_sbh = bh;
+	sbi->s_sbh = bh;
 	if (resuid != EXT2_DEF_RESUID)
-		sb->u.ext2_sb.s_resuid = resuid;
+		sbi->s_resuid = resuid;
 	else
-		sb->u.ext2_sb.s_resuid = le16_to_cpu(es->s_def_resuid);
+		sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
 	if (resgid != EXT2_DEF_RESGID)
-		sb->u.ext2_sb.s_resgid = resgid;
+		sbi->s_resgid = resgid;
 	else
-		sb->u.ext2_sb.s_resgid = le16_to_cpu(es->s_def_resgid);
-	sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
-	sb->u.ext2_sb.s_addr_per_block_bits =
+		sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
+	sbi->s_mount_state = le16_to_cpu(es->s_state);
+	sbi->s_addr_per_block_bits =
 		log2 (EXT2_ADDR_PER_BLOCK(sb));
-	sb->u.ext2_sb.s_desc_per_block_bits =
+	sbi->s_desc_per_block_bits =
 		log2 (EXT2_DESC_PER_BLOCK(sb));
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
@@ -610,45 +618,45 @@
 		goto failed_mount;
 	}
 
-	if (sb->s_blocksize != sb->u.ext2_sb.s_frag_size) {
+	if (sb->s_blocksize != sbi->s_frag_size) {
 		printk ("EXT2-fs: fragsize %lu != blocksize %lu (not supported yet)\n",
-			sb->u.ext2_sb.s_frag_size, sb->s_blocksize);
+			sbi->s_frag_size, sb->s_blocksize);
 		goto failed_mount;
 	}
 
-	if (sb->u.ext2_sb.s_blocks_per_group > sb->s_blocksize * 8) {
+	if (sbi->s_blocks_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #blocks per group too big: %lu\n",
-			sb->u.ext2_sb.s_blocks_per_group);
+			sbi->s_blocks_per_group);
 		goto failed_mount;
 	}
-	if (sb->u.ext2_sb.s_frags_per_group > sb->s_blocksize * 8) {
+	if (sbi->s_frags_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #fragments per group too big: %lu\n",
-			sb->u.ext2_sb.s_frags_per_group);
+			sbi->s_frags_per_group);
 		goto failed_mount;
 	}
-	if (sb->u.ext2_sb.s_inodes_per_group > sb->s_blocksize * 8) {
+	if (sbi->s_inodes_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #inodes per group too big: %lu\n",
-			sb->u.ext2_sb.s_inodes_per_group);
+			sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
 
-	sb->u.ext2_sb.s_groups_count = (le32_to_cpu(es->s_blocks_count) -
+	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
 				        le32_to_cpu(es->s_first_data_block) +
 				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
 				       EXT2_BLOCKS_PER_GROUP(sb);
-	db_count = (sb->u.ext2_sb.s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
+	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
-	sb->u.ext2_sb.s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
-	if (sb->u.ext2_sb.s_group_desc == NULL) {
+	sbi->s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
+	if (sbi->s_group_desc == NULL) {
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
 	for (i = 0; i < db_count; i++) {
-		sb->u.ext2_sb.s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
-		if (!sb->u.ext2_sb.s_group_desc[i]) {
+		sbi->s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
+		if (!sbi->s_group_desc[i]) {
 			for (j = 0; j < i; j++)
-				brelse (sb->u.ext2_sb.s_group_desc[j]);
-			kfree(sb->u.ext2_sb.s_group_desc);
+				brelse (sbi->s_group_desc[j]);
+			kfree(sbi->s_group_desc);
 			printk ("EXT2-fs: unable to read group descriptors\n");
 			goto failed_mount;
 		}
@@ -659,15 +667,15 @@
 		goto failed_mount2;
 	}
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++) {
-		sb->u.ext2_sb.s_inode_bitmap_number[i] = 0;
-		sb->u.ext2_sb.s_inode_bitmap[i] = NULL;
-		sb->u.ext2_sb.s_block_bitmap_number[i] = 0;
-		sb->u.ext2_sb.s_block_bitmap[i] = NULL;
-	}
-	sb->u.ext2_sb.s_loaded_inode_bitmaps = 0;
-	sb->u.ext2_sb.s_loaded_block_bitmaps = 0;
-	sb->u.ext2_sb.s_gdb_count = db_count;
-	get_random_bytes(&sb->u.ext2_sb.s_next_generation, sizeof(u32));
+		sbi->s_inode_bitmap_number[i] = 0;
+		sbi->s_inode_bitmap[i] = NULL;
+		sbi->s_block_bitmap_number[i] = 0;
+		sbi->s_block_bitmap[i] = NULL;
+	}
+	sbi->s_loaded_inode_bitmaps = 0;
+	sbi->s_loaded_block_bitmaps = 0;
+	sbi->s_gdb_count = db_count;
+	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	/*
 	 * set up enough so that it can read an inode
 	 */
@@ -687,8 +695,8 @@
 	return 0;
 failed_mount2:
 	for (i = 0; i < db_count; i++)
-		brelse(sb->u.ext2_sb.s_group_desc[i]);
-	kfree(sb->u.ext2_sb.s_group_desc);
+		brelse(sbi->s_group_desc[i]);
+	kfree(sbi->s_group_desc);
 failed_mount:
 	brelse(bh);
 	return -EINVAL;
@@ -698,7 +706,7 @@
 			       struct ext2_super_block * es)
 {
 	es->s_wtime = cpu_to_le32(CURRENT_TIME);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sb->s_dirt = 0;
 }
 
@@ -727,7 +735,7 @@
 	struct ext2_super_block * es;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		es = sb->u.ext2_sb.s_es;
+		es = EXT2_SB(sb)->s_es;
 
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS) {
 			ext2_debug ("setting valid to 0\n");
@@ -743,35 +751,36 @@
 
 int ext2_remount (struct super_block * sb, int * flags, char * data)
 {
+	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_super_block * es;
-	unsigned short resuid = sb->u.ext2_sb.s_resuid;
-	unsigned short resgid = sb->u.ext2_sb.s_resgid;
+	unsigned short resuid = sbi->s_resuid;
+	unsigned short resgid = sbi->s_resgid;
 	unsigned long new_mount_opt;
 	unsigned long tmp;
 
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
-	new_mount_opt = sb->u.ext2_sb.s_mount_opt;
+	new_mount_opt = sbi->s_mount_opt;
 	if (!parse_options (data, &tmp, &resuid, &resgid,
 			    &new_mount_opt))
 		return -EINVAL;
 
-	sb->u.ext2_sb.s_mount_opt = new_mount_opt;
-	sb->u.ext2_sb.s_resuid = resuid;
-	sb->u.ext2_sb.s_resgid = resgid;
-	es = sb->u.ext2_sb.s_es;
+	sbi->s_mount_opt = new_mount_opt;
+	sbi->s_resuid = resuid;
+	sbi->s_resgid = resgid;
+	es = sbi->s_es;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
 	if (*flags & MS_RDONLY) {
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS ||
-		    !(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
+		    !(sbi->s_mount_state & EXT2_VALID_FS))
 			return 0;
 		/*
 		 * OK, we are remounting a valid rw partition rdonly, so set
 		 * the rdonly flag and then mark the partition as valid again.
 		 */
-		es->s_state = cpu_to_le16(sb->u.ext2_sb.s_mount_state);
+		es->s_state = cpu_to_le16(sbi->s_mount_state);
 		es->s_mtime = cpu_to_le32(CURRENT_TIME);
 	} else {
 		int ret;
@@ -787,7 +796,7 @@
 		 * store the current valid flag.  (It may have been changed
 		 * by e2fsck since we originally mounted the partition.)
 		 */
-		sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
+		sbi->s_mount_state = le16_to_cpu(es->s_state);
 		if (!ext2_setup_super (sb, es, 0))
 			sb->s_flags &= ~MS_RDONLY;
 	}
@@ -797,6 +806,7 @@
 
 int ext2_statfs (struct super_block * sb, struct statfs * buf)
 {
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	unsigned long overhead;
 	int i;
 
@@ -811,14 +821,14 @@
 		 * All of the blocks before first_data_block are
 		 * overhead
 		 */
-		overhead = le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block);
+		overhead = le32_to_cpu(sbi->s_es->s_first_data_block);
 
 		/*
 		 * Add the overhead attributed to the superblock and
 		 * block group descriptors.  If the sparse superblocks
 		 * feature is turned on, then not all groups have this.
 		 */
-		for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++)
+		for (i = 0; i < sbi->s_groups_count; i++)
 			overhead += ext2_bg_has_super(sb, i) +
 				ext2_bg_num_gdb(sb, i);
 
@@ -826,18 +836,18 @@
 		 * Every block group has an inode bitmap, a block
 		 * bitmap, and an inode table.
 		 */
-		overhead += (sb->u.ext2_sb.s_groups_count *
-			     (2 + sb->u.ext2_sb.s_itb_per_group));
+		overhead += (sbi->s_groups_count *
+			     (2 + sbi->s_itb_per_group));
 	}
 
 	buf->f_type = EXT2_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = le32_to_cpu(sb->u.ext2_sb.s_es->s_blocks_count) - overhead;
+	buf->f_blocks = le32_to_cpu(sbi->s_es->s_blocks_count) - overhead;
 	buf->f_bfree = ext2_count_free_blocks (sb);
-	buf->f_bavail = buf->f_bfree - le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count);
-	if (buf->f_bfree < le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count))
+	buf->f_bavail = buf->f_bfree - le32_to_cpu(sbi->s_es->s_r_blocks_count);
+	if (buf->f_bfree < le32_to_cpu(sbi->s_es->s_r_blocks_count))
 		buf->f_bavail = 0;
-	buf->f_files = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	buf->f_files = le32_to_cpu(sbi->s_es->s_inodes_count);
 	buf->f_ffree = ext2_count_free_inodes (sb);
 	buf->f_namelen = EXT2_NAME_LEN;
 	return 0;
diff -urN linux-2.5.7-pre1/fs/intermezzo/journal_ext2.c linux/fs/intermezzo/journal_ext2.c
--- linux-2.5.7-pre1/fs/intermezzo/journal_ext2.c	Thu Mar  7 21:18:19 2002
+++ linux/fs/intermezzo/journal_ext2.c	Tue Mar 12 18:00:28 2002
@@ -27,8 +27,8 @@
 static loff_t presto_e2_freespace(struct presto_cache *cache,
                                          struct super_block *sb)
 {
-        unsigned long freebl = le32_to_cpu(sb->u.ext2_sb.s_es->s_free_blocks_count);
-        unsigned long avail =   freebl - le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count);
+        unsigned long freebl = le32_to_cpu(EXT2_SB(sb)->s_es->s_free_blocks_count);
+        unsigned long avail =   freebl - le32_to_cpu(EXT2_SB(sb)->s_es->s_r_blocks_count);
 	return (avail <<  EXT2_BLOCK_SIZE_BITS(sb));
 }
 
@@ -41,7 +41,7 @@
              strcmp(fset->fset_cache->cache_type, "ext2"))
                 return NULL;
 
-        avail_kmlblocks = inode->i_sb->u.ext2_sb.s_es->s_free_blocks_count;
+        avail_kmlblocks = EXT2_SB(inode->i_sb)->s_es->s_free_blocks_count;
         
         if ( avail_kmlblocks < 3 ) {
                 return ERR_PTR(-ENOSPC);
diff -urN linux-2.5.7-pre1/include/linux/ext2_fs.h linux/include/linux/ext2_fs.h
--- linux-2.5.7-pre1/include/linux/ext2_fs.h	Tue Mar 12 17:42:07 2002
+++ linux/include/linux/ext2_fs.h	Tue Mar 12 18:27:00 2002
@@ -70,6 +70,18 @@
  */
 #define EXT2_SUPER_MAGIC	0xEF53
 
+#ifdef __KERNEL__
+static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
+{
+	return &sb->u.ext2_sb;
+}
+#else
+/* Assume that user mode programs are passing in an ext2fs superblock, not
+ * a kernel struct super_block.  This will allow us to call the feature-test
+ * macros from user land. */
+#define EXT2_SB(sb)	(sb)
+#endif
+
 /*
  * Maximal count of links to a file
  */
@@ -94,9 +106,9 @@
 # define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
 #ifdef __KERNEL__
-#define	EXT2_ADDR_PER_BLOCK_BITS(s)	((s)->u.ext2_sb.s_addr_per_block_bits)
-#define EXT2_INODE_SIZE(s)		((s)->u.ext2_sb.s_inode_size)
-#define EXT2_FIRST_INO(s)		((s)->u.ext2_sb.s_first_ino)
+#define	EXT2_ADDR_PER_BLOCK_BITS(s)	(EXT2_SB(s)->s_addr_per_block_bits)
+#define EXT2_INODE_SIZE(s)		(EXT2_SB(s)->s_inode_size)
+#define EXT2_FIRST_INO(s)		(EXT2_SB(s)->s_first_ino)
 #else
 #define EXT2_INODE_SIZE(s)	(((s)->s_rev_level == EXT2_GOOD_OLD_REV) ? \
 				 EXT2_GOOD_OLD_INODE_SIZE : \
@@ -113,8 +125,8 @@
 #define	EXT2_MAX_FRAG_SIZE		4096
 #define EXT2_MIN_FRAG_LOG_SIZE		  10
 #ifdef __KERNEL__
-# define EXT2_FRAG_SIZE(s)		((s)->u.ext2_sb.s_frag_size)
-# define EXT2_FRAGS_PER_BLOCK(s)	((s)->u.ext2_sb.s_frags_per_block)
+# define EXT2_FRAG_SIZE(s)		(EXT2_SB(s)->s_frag_size)
+# define EXT2_FRAGS_PER_BLOCK(s)	(EXT2_SB(s)->s_frags_per_block)
 #else
 # define EXT2_FRAG_SIZE(s)		(EXT2_MIN_FRAG_SIZE << (s)->s_log_frag_size)
 # define EXT2_FRAGS_PER_BLOCK(s)	(EXT2_BLOCK_SIZE(s) / EXT2_FRAG_SIZE(s))
@@ -161,10 +173,10 @@
  * Macro-instructions used to manage group descriptors
  */
 #ifdef __KERNEL__
-# define EXT2_BLOCKS_PER_GROUP(s)	((s)->u.ext2_sb.s_blocks_per_group)
-# define EXT2_DESC_PER_BLOCK(s)		((s)->u.ext2_sb.s_desc_per_block)
-# define EXT2_INODES_PER_GROUP(s)	((s)->u.ext2_sb.s_inodes_per_group)
-# define EXT2_DESC_PER_BLOCK_BITS(s)	((s)->u.ext2_sb.s_desc_per_block_bits)
+# define EXT2_BLOCKS_PER_GROUP(s)	(EXT2_SB(s)->s_blocks_per_group)
+# define EXT2_DESC_PER_BLOCK(s)		(EXT2_SB(s)->s_desc_per_block)
+# define EXT2_INODES_PER_GROUP(s)	(EXT2_SB(s)->s_inodes_per_group)
+# define EXT2_DESC_PER_BLOCK_BITS(s)	(EXT2_SB(s)->s_desc_per_block_bits)
 #else
 # define EXT2_BLOCKS_PER_GROUP(s)	((s)->s_blocks_per_group)
 # define EXT2_DESC_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_group_desc))
@@ -317,7 +329,7 @@
 
 #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT2_MOUNT_##opt
-#define test_opt(sb, opt)		((sb)->u.ext2_sb.s_mount_opt & \
+#define test_opt(sb, opt)		(EXT2_SB(sb)->s_mount_opt & \
 					 EXT2_MOUNT_##opt)
 /*
  * Maximal mount counts between two filesystem checks
@@ -395,15 +407,6 @@
 	__u32	s_reserved[204];	/* Padding to the end of the block */
 };
 
-#ifdef __KERNEL__
-#define EXT2_SB(sb)	(&((sb)->u.ext2_sb))
-#else
-/* Assume that user mode programs are passing in an ext2fs superblock, not
- * a kernel struct super_block.  This will allow us to call the feature-test
- * macros from user land. */
-#define EXT2_SB(sb)	(sb)
-#endif
-
 /*
  * Codes for operating systems
  */

--------------000300080207020702040600
Content-Type: text/plain;
 name="sb-ext2-b1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-ext2-b1"

diff -urN linux/fs/ext2/super.c linux2/fs/ext2/super.c
--- linux/fs/ext2/super.c	Tue Mar 12 18:02:43 2002
+++ linux2/fs/ext2/super.c	Tue Mar 12 18:36:06 2002
@@ -146,6 +146,8 @@
 		if (sbi->s_block_bitmap[i])
 			brelse (sbi->s_block_bitmap[i]);
 	brelse (sbi->s_sbh);
+	sb->u.generic_sbp = NULL;
+	kfree(sbi);
 
 	return;
 }
@@ -463,7 +465,11 @@
 	int db_count;
 	int i, j;
 
-	sbi = EXT2_SB(sb);
+	sbi = kmalloc(sizeof(struct ext2_super_block), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	sb->u.generic_sbp = sbi;
+
 	/*
 	 * See what the current blocksize for the device is, and
 	 * use that as the blocksize.  Otherwise (or if the blocksize
@@ -475,12 +481,12 @@
 	sbi->s_mount_opt = 0;
 	if (!parse_options ((char *) data, &sb_block, &resuid, &resgid,
 	    &sbi->s_mount_opt))
-		return -EINVAL;
+		goto failed_sbi;
 
 	blocksize = sb_min_blocksize(sb, BLOCK_SIZE);
 	if (!blocksize) {
 		printk ("EXT2-fs: unable to set blocksize\n");
-		return -EINVAL;
+		goto failed_sbi;
 	}
 
 	/*
@@ -495,7 +501,7 @@
 
 	if (!(bh = sb_bread(sb, logic_sb_block))) {
 		printk ("EXT2-fs: unable to read superblock\n");
-		return -EINVAL;
+		goto failed_sbi;
 	}
 	/*
 	 * Note: s_es must be initialized as soon as possible because
@@ -541,7 +547,7 @@
 
 		if (!sb_set_blocksize(sb, blocksize)) {
 			printk(KERN_ERR "EXT2-fs: blocksize too small for device.\n");
-			return -EINVAL;
+			goto failed_sbi;
 		}
 
 		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
@@ -699,6 +705,9 @@
 	kfree(sbi->s_group_desc);
 failed_mount:
 	brelse(bh);
+failed_sbi:
+	sb->u.generic_sbp = NULL;
+	kfree(sbi);
 	return -EINVAL;
 }
 
diff -urN linux/include/linux/ext2_fs.h linux2/include/linux/ext2_fs.h
--- linux/include/linux/ext2_fs.h	Tue Mar 12 18:27:00 2002
+++ linux2/include/linux/ext2_fs.h	Tue Mar 12 18:46:47 2002
@@ -17,6 +17,7 @@
 #define _LINUX_EXT2_FS_H
 
 #include <linux/types.h>
+#include <linux/ext2_fs_sb.h>
 
 /*
  * The second extended filesystem constants/structures
@@ -73,7 +74,7 @@
 #ifdef __KERNEL__
 static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 {
-	return &sb->u.ext2_sb;
+	return sb->u.generic_sbp;
 }
 #else
 /* Assume that user mode programs are passing in an ext2fs superblock, not
diff -urN linux/include/linux/fs.h linux2/include/linux/fs.h
--- linux/include/linux/fs.h	Tue Mar 12 18:26:56 2002
+++ linux2/include/linux/fs.h	Tue Mar 12 18:41:11 2002
@@ -648,7 +648,6 @@
 #define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 
-#include <linux/ext2_fs_sb.h>
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ntfs_fs_sb.h>
@@ -704,7 +703,6 @@
 	char s_id[32];				/* Informational name */
 
 	union {
-		struct ext2_sb_info	ext2_sb;
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
 		struct ntfs_sb_info	ntfs_sb;

--------------000300080207020702040600--

