Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284985AbSAFWN6>; Sun, 6 Jan 2002 17:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285709AbSAFWNp>; Sun, 6 Jan 2002 17:13:45 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:11018 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284264AbSAFWN3>;
	Sun, 6 Jan 2002 17:13:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC] Unbork fs.h, 3 of 4
Date: Sun, 6 Jan 2002 23:17:23 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NLbX-0001LO-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3nd of a set of 4 patches aimed at removing the ext2-specific 
inode and super block includes from include/linux/fs.h, with a view to 
establishing a pattern for updating all the filesystems in the source tree 
to remove the union entirely.  Please see the first posting in this series
for details.

This patch changes all uses of the 'ext2_sb' field of the inode union to an 
inline function call, 'ext2_s(inode)'.

To apply:

    cd /your/2.4.17/tree
    cat this/patch | patch -p1

--
Daniel

--- 2.4.17.clean/fs/ext2/balloc.c	Fri Oct  5 15:23:53 2001
+++ 2.4.17/fs/ext2/balloc.c	Sun Jan  6 17:40:02 2002
@@ -43,18 +43,18 @@
 	unsigned long desc;
 	struct ext2_group_desc * gdp;
 
-	if (block_group >= sb->u.ext2_sb.s_groups_count) {
+	if (block_group >= ext2_s(sb)->s_groups_count) {
 		ext2_error (sb, "ext2_get_group_desc",
 			    "block_group >= groups_count - "
 			    "block_group = %d, groups_count = %lu",
-			    block_group, sb->u.ext2_sb.s_groups_count);
+			    block_group, ext2_s(sb)->s_groups_count);
 
 		return NULL;
 	}
 	
 	group_desc = block_group / EXT2_DESC_PER_BLOCK(sb);
 	desc = block_group % EXT2_DESC_PER_BLOCK(sb);
-	if (!sb->u.ext2_sb.s_group_desc[group_desc]) {
+	if (!ext2_s(sb)->s_group_desc[group_desc]) {
 		ext2_error (sb, "ext2_get_group_desc",
 			    "Group descriptor not loaded - "
 			    "block_group = %d, group_desc = %lu, desc = %lu",
@@ -63,9 +63,9 @@
 	}
 	
 	gdp = (struct ext2_group_desc *) 
-	      sb->u.ext2_sb.s_group_desc[group_desc]->b_data;
+	      ext2_s(sb)->s_group_desc[group_desc]->b_data;
 	if (bh)
-		*bh = sb->u.ext2_sb.s_group_desc[group_desc];
+		*bh = ext2_s(sb)->s_group_desc[group_desc];
 	return gdp + desc;
 }
 
@@ -101,8 +101,8 @@
 	 * this group.  The IO will be retried next time.
 	 */
 error_out:
-	sb->u.ext2_sb.s_block_bitmap_number[bitmap_nr] = block_group;
-	sb->u.ext2_sb.s_block_bitmap[bitmap_nr] = bh;
+	ext2_s(sb)->s_block_bitmap_number[bitmap_nr] = block_group;
+	ext2_s(sb)->s_block_bitmap[bitmap_nr] = bh;
 	return retval;
 }
 
@@ -126,15 +126,15 @@
 	unsigned long block_bitmap_number;
 	struct buffer_head * block_bitmap;
 
-	if (block_group >= sb->u.ext2_sb.s_groups_count)
+	if (block_group >= ext2_s(sb)->s_groups_count)
 		ext2_panic (sb, "load_block_bitmap",
 			    "block_group >= groups_count - "
 			    "block_group = %d, groups_count = %lu",
-			    block_group, sb->u.ext2_sb.s_groups_count);
+			    block_group, ext2_s(sb)->s_groups_count);
 
-	if (sb->u.ext2_sb.s_groups_count <= EXT2_MAX_GROUP_LOADED) {
-		if (sb->u.ext2_sb.s_block_bitmap[block_group]) {
-			if (sb->u.ext2_sb.s_block_bitmap_number[block_group] ==
+	if (ext2_s(sb)->s_groups_count <= EXT2_MAX_GROUP_LOADED) {
+		if (ext2_s(sb)->s_block_bitmap[block_group]) {
+			if (ext2_s(sb)->s_block_bitmap_number[block_group] ==
 			    block_group)
 				return block_group;
 			ext2_error (sb, "__load_block_bitmap",
@@ -146,21 +146,21 @@
 		return block_group;
 	}
 
-	for (i = 0; i < sb->u.ext2_sb.s_loaded_block_bitmaps &&
-		    sb->u.ext2_sb.s_block_bitmap_number[i] != block_group; i++)
+	for (i = 0; i < ext2_s(sb)->s_loaded_block_bitmaps &&
+		    ext2_s(sb)->s_block_bitmap_number[i] != block_group; i++)
 		;
-	if (i < sb->u.ext2_sb.s_loaded_block_bitmaps &&
-  	    sb->u.ext2_sb.s_block_bitmap_number[i] == block_group) {
-		block_bitmap_number = sb->u.ext2_sb.s_block_bitmap_number[i];
-		block_bitmap = sb->u.ext2_sb.s_block_bitmap[i];
+	if (i < ext2_s(sb)->s_loaded_block_bitmaps &&
+  	    ext2_s(sb)->s_block_bitmap_number[i] == block_group) {
+		block_bitmap_number = ext2_s(sb)->s_block_bitmap_number[i];
+		block_bitmap = ext2_s(sb)->s_block_bitmap[i];
 		for (j = i; j > 0; j--) {
-			sb->u.ext2_sb.s_block_bitmap_number[j] =
-				sb->u.ext2_sb.s_block_bitmap_number[j - 1];
-			sb->u.ext2_sb.s_block_bitmap[j] =
-				sb->u.ext2_sb.s_block_bitmap[j - 1];
+			ext2_s(sb)->s_block_bitmap_number[j] =
+				ext2_s(sb)->s_block_bitmap_number[j - 1];
+			ext2_s(sb)->s_block_bitmap[j] =
+				ext2_s(sb)->s_block_bitmap[j - 1];
 		}
-		sb->u.ext2_sb.s_block_bitmap_number[0] = block_bitmap_number;
-		sb->u.ext2_sb.s_block_bitmap[0] = block_bitmap;
+		ext2_s(sb)->s_block_bitmap_number[0] = block_bitmap_number;
+		ext2_s(sb)->s_block_bitmap[0] = block_bitmap;
 
 		/*
 		 * There's still one special case here --- if block_bitmap == 0
@@ -170,15 +170,15 @@
 		if (!block_bitmap)
 			retval = read_block_bitmap (sb, block_group, 0);
 	} else {
-		if (sb->u.ext2_sb.s_loaded_block_bitmaps < EXT2_MAX_GROUP_LOADED)
-			sb->u.ext2_sb.s_loaded_block_bitmaps++;
+		if (ext2_s(sb)->s_loaded_block_bitmaps < EXT2_MAX_GROUP_LOADED)
+			ext2_s(sb)->s_loaded_block_bitmaps++;
 		else
-			brelse (sb->u.ext2_sb.s_block_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
-		for (j = sb->u.ext2_sb.s_loaded_block_bitmaps - 1; j > 0; j--) {
-			sb->u.ext2_sb.s_block_bitmap_number[j] =
-				sb->u.ext2_sb.s_block_bitmap_number[j - 1];
-			sb->u.ext2_sb.s_block_bitmap[j] =
-				sb->u.ext2_sb.s_block_bitmap[j - 1];
+			brelse (ext2_s(sb)->s_block_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
+		for (j = ext2_s(sb)->s_loaded_block_bitmaps - 1; j > 0; j--) {
+			ext2_s(sb)->s_block_bitmap_number[j] =
+				ext2_s(sb)->s_block_bitmap_number[j - 1];
+			ext2_s(sb)->s_block_bitmap[j] =
+				ext2_s(sb)->s_block_bitmap[j - 1];
 		}
 		retval = read_block_bitmap (sb, block_group, 0);
 	}
@@ -207,18 +207,18 @@
 	 * Do the lookup for the slot.  First of all, check if we're asking
 	 * for the same slot as last time, and did we succeed that last time?
 	 */
-	if (sb->u.ext2_sb.s_loaded_block_bitmaps > 0 &&
-	    sb->u.ext2_sb.s_block_bitmap_number[0] == block_group &&
-	    sb->u.ext2_sb.s_block_bitmap[0]) {
+	if (ext2_s(sb)->s_loaded_block_bitmaps > 0 &&
+	    ext2_s(sb)->s_block_bitmap_number[0] == block_group &&
+	    ext2_s(sb)->s_block_bitmap[0]) {
 		return 0;
 	}
 	/*
 	 * Or can we do a fast lookup based on a loaded group on a filesystem
 	 * small enough to be mapped directly into the superblock?
 	 */
-	else if (sb->u.ext2_sb.s_groups_count <= EXT2_MAX_GROUP_LOADED && 
-		 sb->u.ext2_sb.s_block_bitmap_number[block_group] == block_group &&
-		 sb->u.ext2_sb.s_block_bitmap[block_group]) {
+	else if (ext2_s(sb)->s_groups_count <= EXT2_MAX_GROUP_LOADED && 
+		 ext2_s(sb)->s_block_bitmap_number[block_group] == block_group &&
+		 ext2_s(sb)->s_block_bitmap[block_group]) {
 		slot = block_group;
 	}
 	/*
@@ -238,7 +238,7 @@
 	 * If it's a valid slot, we may still have cached a previous IO error,
 	 * in which case the bh in the superblock cache will be zero.
 	 */
-	if (!sb->u.ext2_sb.s_block_bitmap[slot])
+	if (!ext2_s(sb)->s_block_bitmap[slot])
 		return -EIO;
 	
 	/*
@@ -268,7 +268,7 @@
 		return;
 	}
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = ext2_s(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) || 
 	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_free_blocks",
@@ -297,7 +297,7 @@
 	if (bitmap_nr < 0)
 		goto error_return;
 	
-	bh = sb->u.ext2_sb.s_block_bitmap[bitmap_nr];
+	bh = ext2_s(sb)->s_block_bitmap[bitmap_nr];
 	gdp = ext2_get_group_desc (sb, block_group, &bh2);
 	if (!gdp)
 		goto error_return;
@@ -305,9 +305,9 @@
 	if (in_range (le32_to_cpu(gdp->bg_block_bitmap), block, count) ||
 	    in_range (le32_to_cpu(gdp->bg_inode_bitmap), block, count) ||
 	    in_range (block, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group) ||
+		      ext2_s(sb)->s_itb_per_group) ||
 	    in_range (block + count - 1, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
+		      ext2_s(sb)->s_itb_per_group))
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks in system zones - "
 			    "Block = %lu, count = %lu",
@@ -328,7 +328,7 @@
 	}
 	
 	mark_buffer_dirty(bh2);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(ext2_s(sb)->s_sbh);
 
 	mark_buffer_dirty(bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
@@ -376,11 +376,11 @@
 	}
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = ext2_s(sb)->s_es;
 	if (le32_to_cpu(es->s_free_blocks_count) <= le32_to_cpu(es->s_r_blocks_count) &&
-	    ((sb->u.ext2_sb.s_resuid != current->fsuid) &&
-	     (sb->u.ext2_sb.s_resgid == 0 ||
-	      !in_group_p (sb->u.ext2_sb.s_resgid)) && 
+	    ((ext2_s(sb)->s_resuid != current->fsuid) &&
+	     (ext2_s(sb)->s_resgid == 0 ||
+	      !in_group_p (ext2_s(sb)->s_resgid)) && 
 	     !capable(CAP_SYS_RESOURCE)))
 		goto out;
 
@@ -408,7 +408,7 @@
 		if (bitmap_nr < 0)
 			goto io_error;
 		
-		bh = sb->u.ext2_sb.s_block_bitmap[bitmap_nr];
+		bh = ext2_s(sb)->s_block_bitmap[bitmap_nr];
 
 		ext2_debug ("goal is at %d:%d.\n", i, j);
 
@@ -465,9 +465,9 @@
 	 * Now search the rest of the groups.  We assume that 
 	 * i and gdp correctly point to the last group visited.
 	 */
-	for (k = 0; k < sb->u.ext2_sb.s_groups_count; k++) {
+	for (k = 0; k < ext2_s(sb)->s_groups_count; k++) {
 		i++;
-		if (i >= sb->u.ext2_sb.s_groups_count)
+		if (i >= ext2_s(sb)->s_groups_count)
 			i = 0;
 		gdp = ext2_get_group_desc (sb, i, &bh2);
 		if (!gdp)
@@ -475,13 +475,13 @@
 		if (le16_to_cpu(gdp->bg_free_blocks_count) > 0)
 			break;
 	}
-	if (k >= sb->u.ext2_sb.s_groups_count)
+	if (k >= ext2_s(sb)->s_groups_count)
 		goto out;
 	bitmap_nr = load_block_bitmap (sb, i);
 	if (bitmap_nr < 0)
 		goto io_error;
 	
-	bh = sb->u.ext2_sb.s_block_bitmap[bitmap_nr];
+	bh = ext2_s(sb)->s_block_bitmap[bitmap_nr];
 	r = memscan(bh->b_data, 0, EXT2_BLOCKS_PER_GROUP(sb) >> 3);
 	j = (r - bh->b_data) << 3;
 	if (j < EXT2_BLOCKS_PER_GROUP(sb))
@@ -520,7 +520,7 @@
 	if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
 	    tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
+		      ext2_s(sb)->s_itb_per_group))
 		ext2_error (sb, "ext2_new_block",
 			    "Allocating block in system zone - "
 			    "block = %u", tmp);
@@ -600,7 +600,7 @@
 	gdp->bg_free_blocks_count = cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
 	mark_buffer_dirty(bh2);
 	es->s_free_blocks_count = cpu_to_le32(le32_to_cpu(es->s_free_blocks_count) - 1);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(ext2_s(sb)->s_sbh);
 	sb->s_dirt = 1;
 	unlock_super (sb);
 	*err = 0;
@@ -624,11 +624,11 @@
 	int i;
 	
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = ext2_s(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < ext2_s(sb)->s_groups_count; i++) {
 		gdp = ext2_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
@@ -637,7 +637,7 @@
 		if (bitmap_nr < 0)
 			continue;
 		
-		x = ext2_count_free (sb->u.ext2_sb.s_block_bitmap[bitmap_nr],
+		x = ext2_count_free (ext2_s(sb)->s_block_bitmap[bitmap_nr],
 				     sb->s_blocksize);
 		printk ("group %d: stored = %d, counted = %lu\n",
 			i, le16_to_cpu(gdp->bg_free_blocks_count), x);
@@ -648,7 +648,7 @@
 	unlock_super (sb);
 	return bitmap_count;
 #else
-	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_blocks_count);
+	return le32_to_cpu(ext2_s(sb)->s_es->s_free_blocks_count);
 #endif
 }
 
@@ -656,7 +656,7 @@
 				struct super_block * sb,
 				unsigned char * map)
 {
-	return ext2_test_bit ((block - le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block)) %
+	return ext2_test_bit ((block - le32_to_cpu(ext2_s(sb)->s_es->s_first_data_block)) %
 			 EXT2_BLOCKS_PER_GROUP(sb), map);
 }
 
@@ -709,7 +709,7 @@
 	if (EXT2_HAS_RO_COMPAT_FEATURE(sb,EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER)&&
 	    !ext2_group_sparse(group))
 		return 0;
-	return EXT2_SB(sb)->s_gdb_count;
+	return ext2_s(sb)->s_gdb_count;
 }
 
 #ifdef CONFIG_EXT2_CHECK
@@ -724,11 +724,11 @@
 	struct ext2_group_desc * gdp;
 	int i;
 
-	es = sb->u.ext2_sb.s_es;
+	es = ext2_s(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < ext2_s(sb)->s_groups_count; i++) {
 		gdp = ext2_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
@@ -737,7 +737,7 @@
 		if (bitmap_nr < 0)
 			continue;
 
-		bh = EXT2_SB(sb)->s_block_bitmap[bitmap_nr];
+		bh = ext2_s(sb)->s_block_bitmap[bitmap_nr];
 
 		if (ext2_bg_has_super(sb, i) && !ext2_test_bit(0, bh->b_data))
 			ext2_error(sb, __FUNCTION__,
@@ -760,7 +760,7 @@
 				    "Inode bitmap for group %d is marked free",
 				    i);
 
-		for (j = 0; j < sb->u.ext2_sb.s_itb_per_group; j++)
+		for (j = 0; j < ext2_s(sb)->s_itb_per_group; j++)
 			if (!block_in_use (le32_to_cpu(gdp->bg_inode_table) + j, sb, bh->b_data))
 				ext2_error (sb, "ext2_check_blocks_bitmap",
 					    "Block #%ld of the inode table in "
--- 2.4.17.clean/fs/ext2/dir.c	Sun Jan  6 17:39:50 2002
+++ 2.4.17/fs/ext2/dir.c	Sun Jan  6 17:40:02 2002
@@ -64,7 +64,7 @@
 	struct super_block *sb = dir->i_sb;
 	unsigned chunk_size = ext2_chunk_size(dir);
 	char *kaddr = page_address(page);
-	u32 max_inumber = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	u32 max_inumber = le32_to_cpu(ext2_s(sb)->s_es->s_inodes_count);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_CACHE_SIZE;
 	ext2_dirent *p;
--- 2.4.17.clean/fs/ext2/ialloc.c	Sun Jan  6 17:39:50 2002
+++ 2.4.17/fs/ext2/ialloc.c	Sun Jan  6 17:40:02 2002
@@ -79,7 +79,7 @@
 					      unsigned int block_group)
 {
 	int i, slot = 0;
-	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct ext2_sb_info *sbi = ext2_s(sb);
 	struct buffer_head *bh = sbi->s_inode_bitmap[0];
 
 	if (block_group >= sbi->s_groups_count)
@@ -173,7 +173,7 @@
 	}
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = ext2_s(sb)->s_es;
 	is_directory = S_ISDIR(inode->i_mode);
 
 	/* Do this BEFORE marking the inode not in use or returning an error */
@@ -207,7 +207,7 @@
 		mark_buffer_dirty(bh2);
 		es->s_free_inodes_count =
 			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		mark_buffer_dirty(ext2_s(sb)->s_sbh);
 	}
 	mark_buffer_dirty(bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
@@ -232,8 +232,8 @@
 
 static int find_group_dir(struct super_block *sb, int parent_group)
 {
-	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
-	int ngroups = sb->u.ext2_sb.s_groups_count;
+	struct ext2_super_block * es = ext2_s(sb)->s_es;
+	int ngroups = ext2_s(sb)->s_groups_count;
 	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
 	struct ext2_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh, *best_bh = NULL;
@@ -265,7 +265,7 @@
 
 static int find_group_other(struct super_block *sb, int parent_group)
 {
-	int ngroups = sb->u.ext2_sb.s_groups_count;
+	int ngroups = ext2_s(sb)->s_groups_count;
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh;
 	int group, i;
@@ -332,7 +332,7 @@
 		return ERR_PTR(-ENOMEM);
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = ext2_s(sb)->s_es;
 repeat:
 	if (S_ISDIR(mode))
 		group = find_group_dir(sb, di->i_block_group);
@@ -371,7 +371,7 @@
 
 	es->s_free_inodes_count =
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(ext2_s(sb)->s_sbh);
 	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
@@ -447,8 +447,8 @@
 	int i;
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	es = ext2_s(sb)->s_es;
+	for (i = 0; i < ext2_s(sb)->s_groups_count; i++) {
 		struct ext2_group_desc *desc = ext2_get_group_desc (sb, i, NULL);
 		struct buffer_head *bh;
 		unsigned x;
@@ -470,7 +470,7 @@
 	unlock_super (sb);
 	return desc_count;
 #else
-	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_inodes_count);
+	return le32_to_cpu(ext2_s(sb)->s_es->s_free_inodes_count);
 #endif
 }
 
@@ -478,11 +478,11 @@
 /* Called at mount-time, super-block is locked */
 void ext2_check_inodes_bitmap (struct super_block * sb)
 {
-	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	struct ext2_super_block * es = ext2_s(sb)->s_es;
 	unsigned long desc_count = 0, bitmap_count = 0;
 	int i;
 
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < ext2_s(sb)->s_groups_count; i++) {
 		struct ext2_group_desc *desc = ext2_get_group_desc(sb, i, NULL);
 		struct buffer_head *bh;
 		unsigned x;
--- 2.4.17.clean/fs/ext2/inode.c	Sun Jan  6 17:39:50 2002
+++ 2.4.17/fs/ext2/inode.c	Sun Jan  6 17:40:02 2002
@@ -309,7 +309,7 @@
 	 * the same cylinder group then.
 	 */
 	return (ei->i_block_group * EXT2_BLOCKS_PER_GROUP(inode->i_sb)) +
-	       le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_first_data_block);
+	       le32_to_cpu(ext2_s(inode->i_sb)->s_es->s_first_data_block);
 }
 
 /**
@@ -900,20 +900,20 @@
 	if ((inode->i_ino != EXT2_ROOT_INO && inode->i_ino != EXT2_ACL_IDX_INO &&
 	     inode->i_ino != EXT2_ACL_DATA_INO &&
 	     inode->i_ino < EXT2_FIRST_INO(inode->i_sb)) ||
-	    inode->i_ino > le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_inodes_count)) {
+	    inode->i_ino > le32_to_cpu(ext2_s(inode->i_sb)->s_es->s_inodes_count)) {
 		ext2_error (inode->i_sb, "ext2_read_inode",
 			    "bad inode number: %lu", inode->i_ino);
 		goto bad_inode;
 	}
 	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
-	if (block_group >= inode->i_sb->u.ext2_sb.s_groups_count) {
+	if (block_group >= ext2_s(inode->i_sb)->s_groups_count) {
 		ext2_error (inode->i_sb, "ext2_read_inode",
 			    "group >= groups count");
 		goto bad_inode;
 	}
 	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(inode->i_sb);
 	desc = block_group & (EXT2_DESC_PER_BLOCK(inode->i_sb) - 1);
-	bh = inode->i_sb->u.ext2_sb.s_group_desc[group_desc];
+	bh = ext2_s(inode->i_sb)->s_group_desc[group_desc];
 	if (!bh) {
 		ext2_error (inode->i_sb, "ext2_read_inode",
 			    "Descriptor not loaded");
@@ -1044,20 +1044,20 @@
 
 	if ((inode->i_ino != EXT2_ROOT_INO &&
 	     inode->i_ino < EXT2_FIRST_INO(inode->i_sb)) ||
-	    inode->i_ino > le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_inodes_count)) {
+	    inode->i_ino > le32_to_cpu(ext2_s(inode->i_sb)->s_es->s_inodes_count)) {
 		ext2_error (inode->i_sb, "ext2_write_inode",
 			    "bad inode number: %lu", inode->i_ino);
 		return -EIO;
 	}
 	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
-	if (block_group >= inode->i_sb->u.ext2_sb.s_groups_count) {
+	if (block_group >= ext2_s(inode->i_sb)->s_groups_count) {
 		ext2_error (inode->i_sb, "ext2_write_inode",
 			    "group >= groups count");
 		return -EIO;
 	}
 	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(inode->i_sb);
 	desc = block_group & (EXT2_DESC_PER_BLOCK(inode->i_sb) - 1);
-	bh = inode->i_sb->u.ext2_sb.s_group_desc[group_desc];
+	bh = ext2_s(inode->i_sb)->s_group_desc[group_desc];
 	if (!bh) {
 		ext2_error (inode->i_sb, "ext2_write_inode",
 			    "Descriptor not loaded");
@@ -1121,7 +1121,7 @@
 			struct super_block *sb = inode->i_sb;
 			if (!EXT2_HAS_RO_COMPAT_FEATURE(sb,
 					EXT2_FEATURE_RO_COMPAT_LARGE_FILE) ||
-			    EXT2_SB(sb)->s_es->s_rev_level ==
+			    ext2_s(sb)->s_es->s_rev_level ==
 					cpu_to_le32(EXT2_GOOD_OLD_REV)) {
 			       /* If this is the first large file
 				* created, add a flag to the superblock.
--- 2.4.17.clean/fs/ext2/super.c	Fri Dec 21 12:41:55 2001
+++ 2.4.17/fs/ext2/super.c	Sun Jan  6 17:40:02 2002
@@ -37,10 +37,10 @@
 		 const char * fmt, ...)
 {
 	va_list args;
-	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+	struct ext2_super_block *es = ext2_s(sb)->s_es;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
+		ext2_s(sb)->s_mount_state |= EXT2_ERROR_FS;
 		es->s_state =
 			cpu_to_le16(le16_to_cpu(es->s_state) | EXT2_ERROR_FS);
 		ext2_sync_super(sb, es);
@@ -49,14 +49,14 @@
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
 	if (test_opt (sb, ERRORS_PANIC) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_PANIC &&
+	    (le16_to_cpu(ext2_s(sb)->s_es->s_errors) == EXT2_ERRORS_PANIC &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_RO)))
 		panic ("EXT2-fs panic (device %s): %s: %s\n",
 		       bdevname(sb->s_dev), function, error_buf);
 	printk (KERN_CRIT "EXT2-fs error (device %s): %s: %s\n",
 		bdevname(sb->s_dev), function, error_buf);
 	if (test_opt (sb, ERRORS_RO) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_RO &&
+	    (le16_to_cpu(ext2_s(sb)->s_es->s_errors) == EXT2_ERRORS_RO &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_PANIC))) {
 		printk ("Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
@@ -69,10 +69,10 @@
 	va_list args;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
-		sb->u.ext2_sb.s_es->s_state =
-			cpu_to_le16(le16_to_cpu(sb->u.ext2_sb.s_es->s_state) | EXT2_ERROR_FS);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		ext2_s(sb)->s_mount_state |= EXT2_ERROR_FS;
+		ext2_s(sb)->s_es->s_state =
+			cpu_to_le16(le16_to_cpu(ext2_s(sb)->s_es->s_state) | EXT2_ERROR_FS);
+		mark_buffer_dirty(ext2_s(sb)->s_sbh);
 		sb->s_dirt = 1;
 	}
 	va_start (args, fmt);
@@ -97,7 +97,7 @@
 
 void ext2_update_dynamic_rev(struct super_block *sb)
 {
-	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+	struct ext2_super_block *es = ext2_s(sb)->s_es;
 
 	if (le32_to_cpu(es->s_rev_level) > EXT2_GOOD_OLD_REV)
 		return;
@@ -126,23 +126,23 @@
 	int i;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+		struct ext2_super_block *es = ext2_s(sb)->s_es;
 
-		es->s_state = le16_to_cpu(EXT2_SB(sb)->s_mount_state);
+		es->s_state = le16_to_cpu(ext2_s(sb)->s_mount_state);
 		ext2_sync_super(sb, es);
 	}
-	db_count = EXT2_SB(sb)->s_gdb_count;
+	db_count = ext2_s(sb)->s_gdb_count;
 	for (i = 0; i < db_count; i++)
-		if (sb->u.ext2_sb.s_group_desc[i])
-			brelse (sb->u.ext2_sb.s_group_desc[i]);
-	kfree(sb->u.ext2_sb.s_group_desc);
+		if (ext2_s(sb)->s_group_desc[i])
+			brelse (ext2_s(sb)->s_group_desc[i]);
+	kfree(ext2_s(sb)->s_group_desc);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_inode_bitmap[i])
-			brelse (sb->u.ext2_sb.s_inode_bitmap[i]);
+		if (ext2_s(sb)->s_inode_bitmap[i])
+			brelse (ext2_s(sb)->s_inode_bitmap[i]);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_block_bitmap[i])
-			brelse (sb->u.ext2_sb.s_block_bitmap[i]);
-	brelse (sb->u.ext2_sb.s_sbh);
+		if (ext2_s(sb)->s_block_bitmap[i])
+			brelse (ext2_s(sb)->s_block_bitmap[i]);
+	brelse (ext2_s(sb)->s_sbh);
 
 	return;
 }
@@ -294,10 +294,10 @@
 	}
 	if (read_only)
 		return res;
-	if (!(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
+	if (!(ext2_s(sb)->s_mount_state & EXT2_VALID_FS))
 		printk ("EXT2-fs warning: mounting unchecked fs, "
 			"running e2fsck is recommended\n");
-	else if ((sb->u.ext2_sb.s_mount_state & EXT2_ERROR_FS))
+	else if ((ext2_s(sb)->s_mount_state & EXT2_ERROR_FS))
 		printk ("EXT2-fs warning: mounting fs with errors, "
 			"running e2fsck is recommended\n");
 	else if ((__s16) le16_to_cpu(es->s_max_mnt_count) >= 0 &&
@@ -317,11 +317,11 @@
 		printk ("[EXT II FS %s, %s, bs=%lu, fs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]\n",
 			EXT2FS_VERSION, EXT2FS_DATE, sb->s_blocksize,
-			sb->u.ext2_sb.s_frag_size,
-			sb->u.ext2_sb.s_groups_count,
+			ext2_s(sb)->s_frag_size,
+			ext2_s(sb)->s_groups_count,
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
-			sb->u.ext2_sb.s_mount_opt);
+			ext2_s(sb)->s_mount_opt);
 #ifdef CONFIG_EXT2_CHECK
 	if (test_opt (sb, CHECK)) {
 		ext2_check_blocks_bitmap (sb);
@@ -335,15 +335,15 @@
 {
 	int i;
 	int desc_block = 0;
-	unsigned long block = le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block);
+	unsigned long block = le32_to_cpu(ext2_s(sb)->s_es->s_first_data_block);
 	struct ext2_group_desc * gdp = NULL;
 
 	ext2_debug ("Checking group descriptors");
 
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++)
+	for (i = 0; i < ext2_s(sb)->s_groups_count; i++)
 	{
 		if ((i % EXT2_DESC_PER_BLOCK(sb)) == 0)
-			gdp = (struct ext2_group_desc *) sb->u.ext2_sb.s_group_desc[desc_block++]->b_data;
+			gdp = (struct ext2_group_desc *) ext2_s(sb)->s_group_desc[desc_block++]->b_data;
 		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
 		    le32_to_cpu(gdp->bg_block_bitmap) >= block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
@@ -363,7 +363,7 @@
 			return 0;
 		}
 		if (le32_to_cpu(gdp->bg_inode_table) < block ||
-		    le32_to_cpu(gdp->bg_inode_table) + sb->u.ext2_sb.s_itb_per_group >=
+		    le32_to_cpu(gdp->bg_inode_table) + ext2_s(sb)->s_itb_per_group >=
 		    block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
 			ext2_error (sb, "ext2_check_descriptors",
@@ -423,9 +423,9 @@
 	if(blocksize < BLOCK_SIZE )
 	    blocksize = BLOCK_SIZE;
 
-	sb->u.ext2_sb.s_mount_opt = 0;
+	ext2_s(sb)->s_mount_opt = 0;
 	if (!parse_options ((char *) data, &sb_block, &resuid, &resgid,
-	    &sb->u.ext2_sb.s_mount_opt)) {
+	    &ext2_s(sb)->s_mount_opt)) {
 		return NULL;
 	}
 
@@ -453,7 +453,7 @@
 	 *       some ext2 macro-instructions depend on its value
 	 */
 	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-	sb->u.ext2_sb.s_es = es;
+	ext2_s(sb)->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
@@ -486,7 +486,7 @@
 		goto failed_mount;
 	}
 	sb->s_blocksize_bits =
-		le32_to_cpu(EXT2_SB(sb)->s_es->s_log_block_size) + 10;
+		le32_to_cpu(ext2_s(sb)->s_es->s_log_block_size) + 10;
 	sb->s_blocksize = 1 << sb->s_blocksize_bits;
 
 	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
@@ -510,7 +510,7 @@
 			goto failed_mount;
 		}
 		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-		sb->u.ext2_sb.s_es = es;
+		ext2_s(sb)->s_es = es;
 		if (es->s_magic != le16_to_cpu(EXT2_SUPER_MAGIC)) {
 			printk ("EXT2-fs: Magic mismatch, very weird !\n");
 			goto failed_mount;
@@ -518,46 +518,46 @@
 	}
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
-		sb->u.ext2_sb.s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
-		sb->u.ext2_sb.s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
+		ext2_s(sb)->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
+		ext2_s(sb)->s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
 	} else {
-		sb->u.ext2_sb.s_inode_size = le16_to_cpu(es->s_inode_size);
-		sb->u.ext2_sb.s_first_ino = le32_to_cpu(es->s_first_ino);
-		if (sb->u.ext2_sb.s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
+		ext2_s(sb)->s_inode_size = le16_to_cpu(es->s_inode_size);
+		ext2_s(sb)->s_first_ino = le32_to_cpu(es->s_first_ino);
+		if (ext2_s(sb)->s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
 			printk ("EXT2-fs: unsupported inode size: %d\n",
-				sb->u.ext2_sb.s_inode_size);
+				ext2_s(sb)->s_inode_size);
 			goto failed_mount;
 		}
 	}
-	sb->u.ext2_sb.s_frag_size = EXT2_MIN_FRAG_SIZE <<
+	ext2_s(sb)->s_frag_size = EXT2_MIN_FRAG_SIZE <<
 				   le32_to_cpu(es->s_log_frag_size);
-	if (sb->u.ext2_sb.s_frag_size)
-		sb->u.ext2_sb.s_frags_per_block = sb->s_blocksize /
-						  sb->u.ext2_sb.s_frag_size;
+	if (ext2_s(sb)->s_frag_size)
+		ext2_s(sb)->s_frags_per_block = sb->s_blocksize /
+						  ext2_s(sb)->s_frag_size;
 	else
 		sb->s_magic = 0;
-	sb->u.ext2_sb.s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sb->u.ext2_sb.s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
-	sb->u.ext2_sb.s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
-	sb->u.ext2_sb.s_inodes_per_block = sb->s_blocksize /
+	ext2_s(sb)->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
+	ext2_s(sb)->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
+	ext2_s(sb)->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
+	ext2_s(sb)->s_inodes_per_block = sb->s_blocksize /
 					   EXT2_INODE_SIZE(sb);
-	sb->u.ext2_sb.s_itb_per_group = sb->u.ext2_sb.s_inodes_per_group /
-				        sb->u.ext2_sb.s_inodes_per_block;
-	sb->u.ext2_sb.s_desc_per_block = sb->s_blocksize /
+	ext2_s(sb)->s_itb_per_group = ext2_s(sb)->s_inodes_per_group /
+				        ext2_s(sb)->s_inodes_per_block;
+	ext2_s(sb)->s_desc_per_block = sb->s_blocksize /
 					 sizeof (struct ext2_group_desc);
-	sb->u.ext2_sb.s_sbh = bh;
+	ext2_s(sb)->s_sbh = bh;
 	if (resuid != EXT2_DEF_RESUID)
-		sb->u.ext2_sb.s_resuid = resuid;
+		ext2_s(sb)->s_resuid = resuid;
 	else
-		sb->u.ext2_sb.s_resuid = le16_to_cpu(es->s_def_resuid);
+		ext2_s(sb)->s_resuid = le16_to_cpu(es->s_def_resuid);
 	if (resgid != EXT2_DEF_RESGID)
-		sb->u.ext2_sb.s_resgid = resgid;
+		ext2_s(sb)->s_resgid = resgid;
 	else
-		sb->u.ext2_sb.s_resgid = le16_to_cpu(es->s_def_resgid);
-	sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
-	sb->u.ext2_sb.s_addr_per_block_bits =
+		ext2_s(sb)->s_resgid = le16_to_cpu(es->s_def_resgid);
+	ext2_s(sb)->s_mount_state = le16_to_cpu(es->s_state);
+	ext2_s(sb)->s_addr_per_block_bits =
 		log2 (EXT2_ADDR_PER_BLOCK(sb));
-	sb->u.ext2_sb.s_desc_per_block_bits =
+	ext2_s(sb)->s_desc_per_block_bits =
 		log2 (EXT2_DESC_PER_BLOCK(sb));
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
@@ -573,46 +573,46 @@
 		goto failed_mount;
 	}
 
-	if (sb->s_blocksize != sb->u.ext2_sb.s_frag_size) {
+	if (sb->s_blocksize != ext2_s(sb)->s_frag_size) {
 		printk ("EXT2-fs: fragsize %lu != blocksize %lu (not supported yet)\n",
-			sb->u.ext2_sb.s_frag_size, sb->s_blocksize);
+			ext2_s(sb)->s_frag_size, sb->s_blocksize);
 		goto failed_mount;
 	}
 
-	if (sb->u.ext2_sb.s_blocks_per_group > sb->s_blocksize * 8) {
+	if (ext2_s(sb)->s_blocks_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #blocks per group too big: %lu\n",
-			sb->u.ext2_sb.s_blocks_per_group);
+			ext2_s(sb)->s_blocks_per_group);
 		goto failed_mount;
 	}
-	if (sb->u.ext2_sb.s_frags_per_group > sb->s_blocksize * 8) {
+	if (ext2_s(sb)->s_frags_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #fragments per group too big: %lu\n",
-			sb->u.ext2_sb.s_frags_per_group);
+			ext2_s(sb)->s_frags_per_group);
 		goto failed_mount;
 	}
-	if (sb->u.ext2_sb.s_inodes_per_group > sb->s_blocksize * 8) {
+	if (ext2_s(sb)->s_inodes_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #inodes per group too big: %lu\n",
-			sb->u.ext2_sb.s_inodes_per_group);
+			ext2_s(sb)->s_inodes_per_group);
 		goto failed_mount;
 	}
 
-	sb->u.ext2_sb.s_groups_count = (le32_to_cpu(es->s_blocks_count) -
+	ext2_s(sb)->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
 				        le32_to_cpu(es->s_first_data_block) +
 				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
 				       EXT2_BLOCKS_PER_GROUP(sb);
-	db_count = (sb->u.ext2_sb.s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
+	db_count = (ext2_s(sb)->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
-	sb->u.ext2_sb.s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
-	if (sb->u.ext2_sb.s_group_desc == NULL) {
+	ext2_s(sb)->s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
+	if (ext2_s(sb)->s_group_desc == NULL) {
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
 	for (i = 0; i < db_count; i++) {
-		sb->u.ext2_sb.s_group_desc[i] = bread (dev, logic_sb_block + i + 1,
+		ext2_s(sb)->s_group_desc[i] = bread (dev, logic_sb_block + i + 1,
 						       sb->s_blocksize);
-		if (!sb->u.ext2_sb.s_group_desc[i]) {
+		if (!ext2_s(sb)->s_group_desc[i]) {
 			for (j = 0; j < i; j++)
-				brelse (sb->u.ext2_sb.s_group_desc[j]);
-			kfree(sb->u.ext2_sb.s_group_desc);
+				brelse (ext2_s(sb)->s_group_desc[j]);
+			kfree(ext2_s(sb)->s_group_desc);
 			printk ("EXT2-fs: unable to read group descriptors\n");
 			goto failed_mount;
 		}
@@ -623,14 +623,14 @@
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
+		ext2_s(sb)->s_inode_bitmap_number[i] = 0;
+		ext2_s(sb)->s_inode_bitmap[i] = NULL;
+		ext2_s(sb)->s_block_bitmap_number[i] = 0;
+		ext2_s(sb)->s_block_bitmap[i] = NULL;
+	}
+	ext2_s(sb)->s_loaded_inode_bitmaps = 0;
+	ext2_s(sb)->s_loaded_block_bitmaps = 0;
+	ext2_s(sb)->s_gdb_count = db_count;
 	/*
 	 * set up enough so that it can read an inode
 	 */
@@ -650,8 +650,8 @@
 	return sb;
 failed_mount2:
 	for (i = 0; i < db_count; i++)
-		brelse(sb->u.ext2_sb.s_group_desc[i]);
-	kfree(sb->u.ext2_sb.s_group_desc);
+		brelse(ext2_s(sb)->s_group_desc[i]);
+	kfree(ext2_s(sb)->s_group_desc);
 failed_mount:
 	brelse(bh);
 	return NULL;
@@ -661,16 +661,16 @@
 			       struct ext2_super_block * es)
 {
 	es->s_wtime = cpu_to_le32(CURRENT_TIME);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(ext2_s(sb)->s_sbh);
 	sb->s_dirt = 0;
 }
 
 static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
 {
 	es->s_wtime = cpu_to_le32(CURRENT_TIME);
-	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	ll_rw_block(WRITE, 1, &EXT2_SB(sb)->s_sbh);
-	wait_on_buffer(EXT2_SB(sb)->s_sbh);
+	mark_buffer_dirty(ext2_s(sb)->s_sbh);
+	ll_rw_block(WRITE, 1, &ext2_s(sb)->s_sbh);
+	wait_on_buffer(ext2_s(sb)->s_sbh);
 	sb->s_dirt = 0;
 }
 
@@ -690,7 +690,7 @@
 	struct ext2_super_block * es;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		es = sb->u.ext2_sb.s_es;
+		es = ext2_s(sb)->s_es;
 
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS) {
 			ext2_debug ("setting valid to 0\n");
@@ -707,34 +707,34 @@
 int ext2_remount (struct super_block * sb, int * flags, char * data)
 {
 	struct ext2_super_block * es;
-	unsigned short resuid = sb->u.ext2_sb.s_resuid;
-	unsigned short resgid = sb->u.ext2_sb.s_resgid;
+	unsigned short resuid = ext2_s(sb)->s_resuid;
+	unsigned short resgid = ext2_s(sb)->s_resgid;
 	unsigned long new_mount_opt;
 	unsigned long tmp;
 
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
-	new_mount_opt = sb->u.ext2_sb.s_mount_opt;
+	new_mount_opt = ext2_s(sb)->s_mount_opt;
 	if (!parse_options (data, &tmp, &resuid, &resgid,
 			    &new_mount_opt))
 		return -EINVAL;
 
-	sb->u.ext2_sb.s_mount_opt = new_mount_opt;
-	sb->u.ext2_sb.s_resuid = resuid;
-	sb->u.ext2_sb.s_resgid = resgid;
-	es = sb->u.ext2_sb.s_es;
+	ext2_s(sb)->s_mount_opt = new_mount_opt;
+	ext2_s(sb)->s_resuid = resuid;
+	ext2_s(sb)->s_resgid = resgid;
+	es = ext2_s(sb)->s_es;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
 	if (*flags & MS_RDONLY) {
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS ||
-		    !(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
+		    !(ext2_s(sb)->s_mount_state & EXT2_VALID_FS))
 			return 0;
 		/*
 		 * OK, we are remounting a valid rw partition rdonly, so set
 		 * the rdonly flag and then mark the partition as valid again.
 		 */
-		es->s_state = cpu_to_le16(sb->u.ext2_sb.s_mount_state);
+		es->s_state = cpu_to_le16(ext2_s(sb)->s_mount_state);
 		es->s_mtime = cpu_to_le32(CURRENT_TIME);
 	} else {
 		int ret;
@@ -750,7 +750,7 @@
 		 * store the current valid flag.  (It may have been changed
 		 * by e2fsck since we originally mounted the partition.)
 		 */
-		sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
+		ext2_s(sb)->s_mount_state = le16_to_cpu(es->s_state);
 		if (!ext2_setup_super (sb, es, 0))
 			sb->s_flags &= ~MS_RDONLY;
 	}
@@ -774,14 +774,14 @@
 		 * All of the blocks before first_data_block are
 		 * overhead
 		 */
-		overhead = le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block);
+		overhead = le32_to_cpu(ext2_s(sb)->s_es->s_first_data_block);
 
 		/*
 		 * Add the overhead attributed to the superblock and
 		 * block group descriptors.  If the sparse superblocks
 		 * feature is turned on, then not all groups have this.
 		 */
-		for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++)
+		for (i = 0; i < ext2_s(sb)->s_groups_count; i++)
 			overhead += ext2_bg_has_super(sb, i) +
 				ext2_bg_num_gdb(sb, i);
 
@@ -789,18 +789,18 @@
 		 * Every block group has an inode bitmap, a block
 		 * bitmap, and an inode table.
 		 */
-		overhead += (sb->u.ext2_sb.s_groups_count *
-			     (2 + sb->u.ext2_sb.s_itb_per_group));
+		overhead += (ext2_s(sb)->s_groups_count *
+			     (2 + ext2_s(sb)->s_itb_per_group));
 	}
 
 	buf->f_type = EXT2_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = le32_to_cpu(sb->u.ext2_sb.s_es->s_blocks_count) - overhead;
+	buf->f_blocks = le32_to_cpu(ext2_s(sb)->s_es->s_blocks_count) - overhead;
 	buf->f_bfree = ext2_count_free_blocks (sb);
-	buf->f_bavail = buf->f_bfree - le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count);
-	if (buf->f_bfree < le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count))
+	buf->f_bavail = buf->f_bfree - le32_to_cpu(ext2_s(sb)->s_es->s_r_blocks_count);
+	if (buf->f_bfree < le32_to_cpu(ext2_s(sb)->s_es->s_r_blocks_count))
 		buf->f_bavail = 0;
-	buf->f_files = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	buf->f_files = le32_to_cpu(ext2_s(sb)->s_es->s_inodes_count);
 	buf->f_ffree = ext2_count_free_inodes (sb);
 	buf->f_namelen = EXT2_NAME_LEN;
 	return 0;
--- 2.4.17.clean/include/linux/ext2_fs.h	Sun Jan  6 17:39:50 2002
+++ 2.4.17/include/linux/ext2_fs.h	Sun Jan  6 17:40:02 2002
@@ -94,9 +94,9 @@
 # define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
 #ifdef __KERNEL__
-#define	EXT2_ADDR_PER_BLOCK_BITS(s)	((s)->u.ext2_sb.s_addr_per_block_bits)
-#define EXT2_INODE_SIZE(s)		((s)->u.ext2_sb.s_inode_size)
-#define EXT2_FIRST_INO(s)		((s)->u.ext2_sb.s_first_ino)
+#define	EXT2_ADDR_PER_BLOCK_BITS(s)	(ext2_s(s)->s_addr_per_block_bits)
+#define EXT2_INODE_SIZE(s)		(ext2_s(s)->s_inode_size)
+#define EXT2_FIRST_INO(s)		(ext2_s(s)->s_first_ino)
 #else
 #define EXT2_INODE_SIZE(s)	(((s)->s_rev_level == EXT2_GOOD_OLD_REV) ? \
 				 EXT2_GOOD_OLD_INODE_SIZE : \
@@ -113,8 +113,8 @@
 #define	EXT2_MAX_FRAG_SIZE		4096
 #define EXT2_MIN_FRAG_LOG_SIZE		  10
 #ifdef __KERNEL__
-# define EXT2_FRAG_SIZE(s)		((s)->u.ext2_sb.s_frag_size)
-# define EXT2_FRAGS_PER_BLOCK(s)	((s)->u.ext2_sb.s_frags_per_block)
+# define EXT2_FRAG_SIZE(s)		(ext2_s(s)->s_frag_size)
+# define EXT2_FRAGS_PER_BLOCK(s)	(ext2_s(s)->s_frags_per_block)
 #else
 # define EXT2_FRAG_SIZE(s)		(EXT2_MIN_FRAG_SIZE << (s)->s_log_frag_size)
 # define EXT2_FRAGS_PER_BLOCK(s)	(EXT2_BLOCK_SIZE(s) / EXT2_FRAG_SIZE(s))
@@ -161,10 +161,10 @@
  * Macro-instructions used to manage group descriptors
  */
 #ifdef __KERNEL__
-# define EXT2_BLOCKS_PER_GROUP(s)	((s)->u.ext2_sb.s_blocks_per_group)
-# define EXT2_DESC_PER_BLOCK(s)		((s)->u.ext2_sb.s_desc_per_block)
-# define EXT2_INODES_PER_GROUP(s)	((s)->u.ext2_sb.s_inodes_per_group)
-# define EXT2_DESC_PER_BLOCK_BITS(s)	((s)->u.ext2_sb.s_desc_per_block_bits)
+# define EXT2_BLOCKS_PER_GROUP(s)	(ext2_s(s)->s_blocks_per_group)
+# define EXT2_DESC_PER_BLOCK(s)		(ext2_s(s)->s_desc_per_block)
+# define EXT2_INODES_PER_GROUP(s)	(ext2_s(s)->s_inodes_per_group)
+# define EXT2_DESC_PER_BLOCK_BITS(s)	(ext2_s(s)->s_desc_per_block_bits)
 #else
 # define EXT2_BLOCKS_PER_GROUP(s)	((s)->s_blocks_per_group)
 # define EXT2_DESC_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_group_desc))
@@ -317,8 +317,7 @@
 
 #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT2_MOUNT_##opt
-#define test_opt(sb, opt)		((sb)->u.ext2_sb.s_mount_opt & \
-					 EXT2_MOUNT_##opt)
+#define test_opt(sb, opt)		(ext2_s(sb)->s_mount_opt & EXT2_MOUNT_##opt)
 /*
  * Maximal mount counts between two filesystem checks
  */
@@ -396,12 +395,11 @@
 };
 
 #ifdef __KERNEL__
-#define EXT2_SB(sb)	(&((sb)->u.ext2_sb))
 #else
 /* Assume that user mode programs are passing in an ext2fs superblock, not
  * a kernel struct super_block.  This will allow us to call the feature-test
  * macros from user land. */
-#define EXT2_SB(sb)	(sb)
+//#define EXT2_SB(sb) ext2_s(sb)
 #endif
 
 /*
@@ -429,23 +427,23 @@
  */
 
 #define EXT2_HAS_COMPAT_FEATURE(sb,mask)			\
-	( EXT2_SB(sb)->s_es->s_feature_compat & cpu_to_le32(mask) )
+	( ext2_s(sb)->s_es->s_feature_compat & cpu_to_le32(mask) )
 #define EXT2_HAS_RO_COMPAT_FEATURE(sb,mask)			\
-	( EXT2_SB(sb)->s_es->s_feature_ro_compat & cpu_to_le32(mask) )
+	( ext2_s(sb)->s_es->s_feature_ro_compat & cpu_to_le32(mask) )
 #define EXT2_HAS_INCOMPAT_FEATURE(sb,mask)			\
-	( EXT2_SB(sb)->s_es->s_feature_incompat & cpu_to_le32(mask) )
+	( ext2_s(sb)->s_es->s_feature_incompat & cpu_to_le32(mask) )
 #define EXT2_SET_COMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_compat |= cpu_to_le32(mask)
+	ext2_s(sb)->s_es->s_feature_compat |= cpu_to_le32(mask)
 #define EXT2_SET_RO_COMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_ro_compat |= cpu_to_le32(mask)
+	ext2_s(sb)->s_es->s_feature_ro_compat |= cpu_to_le32(mask)
 #define EXT2_SET_INCOMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_incompat |= cpu_to_le32(mask)
+	ext2_s(sb)->s_es->s_feature_incompat |= cpu_to_le32(mask)
 #define EXT2_CLEAR_COMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_compat &= ~cpu_to_le32(mask)
+	ext2_s(sb)->s_es->s_feature_compat &= ~cpu_to_le32(mask)
 #define EXT2_CLEAR_RO_COMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_ro_compat &= ~cpu_to_le32(mask)
+	ext2_s(sb)->s_es->s_feature_ro_compat &= ~cpu_to_le32(mask)
 #define EXT2_CLEAR_INCOMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_incompat &= ~cpu_to_le32(mask)
+	ext2_s(sb)->s_es->s_feature_incompat &= ~cpu_to_le32(mask)
 
 #define EXT2_FEATURE_COMPAT_DIR_PREALLOC	0x0001
 #define EXT2_FEATURE_COMPAT_IMAGIC_INODES	0x0002
@@ -599,6 +597,12 @@
 		       unsigned long);
 
 /* super.c */
+
+static inline struct ext2_sb_info *ext2_s(struct super_block *sb)
+{
+	return (struct ext2_sb_info *) &(sb->u);
+}
+
 extern void ext2_error (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
 extern NORET_TYPE void ext2_panic (struct super_block *, const char *,
