Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289202AbSAGNWG>; Mon, 7 Jan 2002 08:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289195AbSAGNVv>; Mon, 7 Jan 2002 08:21:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33165 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289187AbSAGNVX>;
	Mon, 7 Jan 2002 08:21:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: torvalds@transmeta.com, viro@math.psu.edu, phillips@bonn-fries.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: PATCH 2.5.2.9: ext2 unbork fs.h (part 2/7)
Message-Id: <20020107132121.373041F6B@gtf.org>
Date: Mon,  7 Jan 2002 07:21:21 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch2 desc: use accessor function ext2_sb to access sb->u.ext2_sb



diff -Naur -X /g/g/lib/dontdiff linux-fs1/fs/ext2/balloc.c linux-fs2/fs/ext2/balloc.c
--- linux-fs1/fs/ext2/balloc.c	Sun Dec 16 20:23:00 2001
+++ linux-fs2/fs/ext2/balloc.c	Mon Jan  7 00:42:14 2002
@@ -39,22 +39,23 @@
 					     unsigned int block_group,
 					     struct buffer_head ** bh)
 {
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	unsigned long group_desc;
 	unsigned long desc;
 	struct ext2_group_desc * gdp;
 
-	if (block_group >= sb->u.ext2_sb.s_groups_count) {
+	if (block_group >= esb->s_groups_count) {
 		ext2_error (sb, "ext2_get_group_desc",
 			    "block_group >= groups_count - "
 			    "block_group = %d, groups_count = %lu",
-			    block_group, sb->u.ext2_sb.s_groups_count);
+			    block_group, esb->s_groups_count);
 
 		return NULL;
 	}
 	
 	group_desc = block_group / EXT2_DESC_PER_BLOCK(sb);
 	desc = block_group % EXT2_DESC_PER_BLOCK(sb);
-	if (!sb->u.ext2_sb.s_group_desc[group_desc]) {
+	if (!esb->s_group_desc[group_desc]) {
 		ext2_error (sb, "ext2_get_group_desc",
 			    "Group descriptor not loaded - "
 			    "block_group = %d, group_desc = %lu, desc = %lu",
@@ -63,9 +64,9 @@
 	}
 	
 	gdp = (struct ext2_group_desc *) 
-	      sb->u.ext2_sb.s_group_desc[group_desc]->b_data;
+	      esb->s_group_desc[group_desc]->b_data;
 	if (bh)
-		*bh = sb->u.ext2_sb.s_group_desc[group_desc];
+		*bh = esb->s_group_desc[group_desc];
 	return gdp + desc;
 }
 
@@ -77,6 +78,7 @@
  */
 
 static int read_block_bitmap (struct super_block * sb,
+			      struct ext2_sb_info * esb,
 			       unsigned int block_group,
 			       unsigned long bitmap_nr)
 {
@@ -101,8 +103,8 @@
 	 * this group.  The IO will be retried next time.
 	 */
 error_out:
-	sb->u.ext2_sb.s_block_bitmap_number[bitmap_nr] = block_group;
-	sb->u.ext2_sb.s_block_bitmap[bitmap_nr] = bh;
+	esb->s_block_bitmap_number[bitmap_nr] = block_group;
+	esb->s_block_bitmap[bitmap_nr] = bh;
 	return retval;
 }
 
@@ -120,47 +122,48 @@
  * Return the slot used to store the bitmap, or a -ve error code.
  */
 static int __load_block_bitmap (struct super_block * sb,
+				struct ext2_sb_info * esb,
 			        unsigned int block_group)
 {
 	int i, j, retval = 0;
 	unsigned long block_bitmap_number;
 	struct buffer_head * block_bitmap;
 
-	if (block_group >= sb->u.ext2_sb.s_groups_count)
+	if (block_group >= esb->s_groups_count)
 		ext2_panic (sb, "load_block_bitmap",
 			    "block_group >= groups_count - "
 			    "block_group = %d, groups_count = %lu",
-			    block_group, sb->u.ext2_sb.s_groups_count);
+			    block_group, esb->s_groups_count);
 
-	if (sb->u.ext2_sb.s_groups_count <= EXT2_MAX_GROUP_LOADED) {
-		if (sb->u.ext2_sb.s_block_bitmap[block_group]) {
-			if (sb->u.ext2_sb.s_block_bitmap_number[block_group] ==
+	if (esb->s_groups_count <= EXT2_MAX_GROUP_LOADED) {
+		if (esb->s_block_bitmap[block_group]) {
+			if (esb->s_block_bitmap_number[block_group] ==
 			    block_group)
 				return block_group;
 			ext2_error (sb, "__load_block_bitmap",
 				    "block_group != block_bitmap_number");
 		}
-		retval = read_block_bitmap (sb, block_group, block_group);
+		retval = read_block_bitmap (sb, esb, block_group, block_group);
 		if (retval < 0)
 			return retval;
 		return block_group;
 	}
 
-	for (i = 0; i < sb->u.ext2_sb.s_loaded_block_bitmaps &&
-		    sb->u.ext2_sb.s_block_bitmap_number[i] != block_group; i++)
+	for (i = 0; i < esb->s_loaded_block_bitmaps &&
+		    esb->s_block_bitmap_number[i] != block_group; i++)
 		;
-	if (i < sb->u.ext2_sb.s_loaded_block_bitmaps &&
-  	    sb->u.ext2_sb.s_block_bitmap_number[i] == block_group) {
-		block_bitmap_number = sb->u.ext2_sb.s_block_bitmap_number[i];
-		block_bitmap = sb->u.ext2_sb.s_block_bitmap[i];
+	if (i < esb->s_loaded_block_bitmaps &&
+  	    esb->s_block_bitmap_number[i] == block_group) {
+		block_bitmap_number = esb->s_block_bitmap_number[i];
+		block_bitmap = esb->s_block_bitmap[i];
 		for (j = i; j > 0; j--) {
-			sb->u.ext2_sb.s_block_bitmap_number[j] =
-				sb->u.ext2_sb.s_block_bitmap_number[j - 1];
-			sb->u.ext2_sb.s_block_bitmap[j] =
-				sb->u.ext2_sb.s_block_bitmap[j - 1];
+			esb->s_block_bitmap_number[j] =
+				esb->s_block_bitmap_number[j - 1];
+			esb->s_block_bitmap[j] =
+				esb->s_block_bitmap[j - 1];
 		}
-		sb->u.ext2_sb.s_block_bitmap_number[0] = block_bitmap_number;
-		sb->u.ext2_sb.s_block_bitmap[0] = block_bitmap;
+		esb->s_block_bitmap_number[0] = block_bitmap_number;
+		esb->s_block_bitmap[0] = block_bitmap;
 
 		/*
 		 * There's still one special case here --- if block_bitmap == 0
@@ -168,19 +171,19 @@
 		 * just ended up caching that failure.  Try again to read it.
 		 */
 		if (!block_bitmap)
-			retval = read_block_bitmap (sb, block_group, 0);
+			retval = read_block_bitmap (sb, esb, block_group, 0);
 	} else {
-		if (sb->u.ext2_sb.s_loaded_block_bitmaps < EXT2_MAX_GROUP_LOADED)
-			sb->u.ext2_sb.s_loaded_block_bitmaps++;
+		if (esb->s_loaded_block_bitmaps < EXT2_MAX_GROUP_LOADED)
+			esb->s_loaded_block_bitmaps++;
 		else
-			brelse (sb->u.ext2_sb.s_block_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
-		for (j = sb->u.ext2_sb.s_loaded_block_bitmaps - 1; j > 0; j--) {
-			sb->u.ext2_sb.s_block_bitmap_number[j] =
-				sb->u.ext2_sb.s_block_bitmap_number[j - 1];
-			sb->u.ext2_sb.s_block_bitmap[j] =
-				sb->u.ext2_sb.s_block_bitmap[j - 1];
+			brelse (esb->s_block_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
+		for (j = esb->s_loaded_block_bitmaps - 1; j > 0; j--) {
+			esb->s_block_bitmap_number[j] =
+				esb->s_block_bitmap_number[j - 1];
+			esb->s_block_bitmap[j] =
+				esb->s_block_bitmap[j - 1];
 		}
-		retval = read_block_bitmap (sb, block_group, 0);
+		retval = read_block_bitmap (sb, esb, block_group, 0);
 	}
 	return retval;
 }
@@ -199,6 +202,7 @@
  * IO request, and a group for which the last bitmap read request failed.
  */
 static inline int load_block_bitmap (struct super_block * sb,
+				     struct ext2_sb_info * esb,
 				     unsigned int block_group)
 {
 	int slot;
@@ -207,25 +211,25 @@
 	 * Do the lookup for the slot.  First of all, check if we're asking
 	 * for the same slot as last time, and did we succeed that last time?
 	 */
-	if (sb->u.ext2_sb.s_loaded_block_bitmaps > 0 &&
-	    sb->u.ext2_sb.s_block_bitmap_number[0] == block_group &&
-	    sb->u.ext2_sb.s_block_bitmap[0]) {
+	if (esb->s_loaded_block_bitmaps > 0 &&
+	    esb->s_block_bitmap_number[0] == block_group &&
+	    esb->s_block_bitmap[0]) {
 		return 0;
 	}
 	/*
 	 * Or can we do a fast lookup based on a loaded group on a filesystem
 	 * small enough to be mapped directly into the superblock?
 	 */
-	else if (sb->u.ext2_sb.s_groups_count <= EXT2_MAX_GROUP_LOADED && 
-		 sb->u.ext2_sb.s_block_bitmap_number[block_group] == block_group &&
-		 sb->u.ext2_sb.s_block_bitmap[block_group]) {
+	else if (esb->s_groups_count <= EXT2_MAX_GROUP_LOADED && 
+		 esb->s_block_bitmap_number[block_group] == block_group &&
+		 esb->s_block_bitmap[block_group]) {
 		slot = block_group;
 	}
 	/*
 	 * If not, then do a full lookup for this block group.
 	 */
 	else {
-		slot = __load_block_bitmap (sb, block_group);
+		slot = __load_block_bitmap (sb, esb, block_group);
 	}
 
 	/*
@@ -238,7 +242,7 @@
 	 * If it's a valid slot, we may still have cached a previous IO error,
 	 * in which case the bh in the superblock cache will be zero.
 	 */
-	if (!sb->u.ext2_sb.s_block_bitmap[slot])
+	if (!esb->s_block_bitmap[slot])
 		return -EIO;
 	
 	/*
@@ -261,14 +265,17 @@
 	struct super_block * sb;
 	struct ext2_group_desc * gdp;
 	struct ext2_super_block * es;
+	struct ext2_sb_info *esb;
 
 	sb = inode->i_sb;
 	if (!sb) {
 		printk ("ext2_free_blocks: nonexistent device");
 		return;
 	}
+	esb = ext2_sb(sb);
+
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = esb->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) || 
 	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_free_blocks",
@@ -293,11 +300,11 @@
 		overflow = bit + count - EXT2_BLOCKS_PER_GROUP(sb);
 		count -= overflow;
 	}
-	bitmap_nr = load_block_bitmap (sb, block_group);
+	bitmap_nr = load_block_bitmap (sb, esb, block_group);
 	if (bitmap_nr < 0)
 		goto error_return;
 	
-	bh = sb->u.ext2_sb.s_block_bitmap[bitmap_nr];
+	bh = esb->s_block_bitmap[bitmap_nr];
 	gdp = ext2_get_group_desc (sb, block_group, &bh2);
 	if (!gdp)
 		goto error_return;
@@ -305,9 +312,9 @@
 	if (in_range (le32_to_cpu(gdp->bg_block_bitmap), block, count) ||
 	    in_range (le32_to_cpu(gdp->bg_inode_bitmap), block, count) ||
 	    in_range (block, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group) ||
+		      esb->s_itb_per_group) ||
 	    in_range (block + count - 1, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
+		      esb->s_itb_per_group))
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks in system zones - "
 			    "Block = %lu, count = %lu",
@@ -328,7 +335,7 @@
 	}
 	
 	mark_buffer_dirty(bh2);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(esb->s_sbh);
 
 	mark_buffer_dirty(bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
@@ -365,6 +372,7 @@
 	struct super_block * sb;
 	struct ext2_group_desc * gdp;
 	struct ext2_super_block * es;
+	struct ext2_sb_info *esb;
 #ifdef EXT2FS_DEBUG
 	static int goal_hits = 0, goal_attempts = 0;
 #endif
@@ -374,13 +382,14 @@
 		printk ("ext2_new_block: nonexistent device");
 		return 0;
 	}
+	esb = ext2_sb(sb);
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = esb->s_es;
 	if (le32_to_cpu(es->s_free_blocks_count) <= le32_to_cpu(es->s_r_blocks_count) &&
-	    ((sb->u.ext2_sb.s_resuid != current->fsuid) &&
-	     (sb->u.ext2_sb.s_resgid == 0 ||
-	      !in_group_p (sb->u.ext2_sb.s_resgid)) && 
+	    ((esb->s_resuid != current->fsuid) &&
+	     (esb->s_resgid == 0 ||
+	      !in_group_p (esb->s_resgid)) && 
 	     !capable(CAP_SYS_RESOURCE)))
 		goto out;
 
@@ -404,11 +413,11 @@
 		if (j)
 			goal_attempts++;
 #endif
-		bitmap_nr = load_block_bitmap (sb, i);
+		bitmap_nr = load_block_bitmap (sb, esb, i);
 		if (bitmap_nr < 0)
 			goto io_error;
 		
-		bh = sb->u.ext2_sb.s_block_bitmap[bitmap_nr];
+		bh = esb->s_block_bitmap[bitmap_nr];
 
 		ext2_debug ("goal is at %d:%d.\n", i, j);
 
@@ -465,9 +474,9 @@
 	 * Now search the rest of the groups.  We assume that 
 	 * i and gdp correctly point to the last group visited.
 	 */
-	for (k = 0; k < sb->u.ext2_sb.s_groups_count; k++) {
+	for (k = 0; k < esb->s_groups_count; k++) {
 		i++;
-		if (i >= sb->u.ext2_sb.s_groups_count)
+		if (i >= esb->s_groups_count)
 			i = 0;
 		gdp = ext2_get_group_desc (sb, i, &bh2);
 		if (!gdp)
@@ -475,13 +484,13 @@
 		if (le16_to_cpu(gdp->bg_free_blocks_count) > 0)
 			break;
 	}
-	if (k >= sb->u.ext2_sb.s_groups_count)
+	if (k >= esb->s_groups_count)
 		goto out;
-	bitmap_nr = load_block_bitmap (sb, i);
+	bitmap_nr = load_block_bitmap (sb, esb, i);
 	if (bitmap_nr < 0)
 		goto io_error;
 	
-	bh = sb->u.ext2_sb.s_block_bitmap[bitmap_nr];
+	bh = esb->s_block_bitmap[bitmap_nr];
 	r = memscan(bh->b_data, 0, EXT2_BLOCKS_PER_GROUP(sb) >> 3);
 	j = (r - bh->b_data) << 3;
 	if (j < EXT2_BLOCKS_PER_GROUP(sb))
@@ -520,7 +529,7 @@
 	if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
 	    tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
+		      esb->s_itb_per_group))
 		ext2_error (sb, "ext2_new_block",
 			    "Allocating block in system zone - "
 			    "block = %u", tmp);
@@ -600,7 +609,7 @@
 	gdp->bg_free_blocks_count = cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
 	mark_buffer_dirty(bh2);
 	es->s_free_blocks_count = cpu_to_le32(le32_to_cpu(es->s_free_blocks_count) - 1);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(esb->s_sbh);
 	sb->s_dirt = 1;
 	unlock_super (sb);
 	*err = 0;
@@ -616,6 +625,7 @@
 
 unsigned long ext2_count_free_blocks (struct super_block * sb)
 {
+	struct ext2_sb_info *esb = ext2_sb(sb);
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
 	unsigned long desc_count, bitmap_count, x;
@@ -624,20 +634,20 @@
 	int i;
 	
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = esb->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < esb->s_groups_count; i++) {
 		gdp = ext2_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_blocks_count);
-		bitmap_nr = load_block_bitmap (sb, i);
+		bitmap_nr = load_block_bitmap (sb, esb, i);
 		if (bitmap_nr < 0)
 			continue;
 		
-		x = ext2_count_free (sb->u.ext2_sb.s_block_bitmap[bitmap_nr],
+		x = ext2_count_free (esb->s_block_bitmap[bitmap_nr],
 				     sb->s_blocksize);
 		printk ("group %d: stored = %d, counted = %lu\n",
 			i, le16_to_cpu(gdp->bg_free_blocks_count), x);
@@ -648,15 +658,16 @@
 	unlock_super (sb);
 	return bitmap_count;
 #else
-	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_blocks_count);
+	return le32_to_cpu(esb->s_es->s_free_blocks_count);
 #endif
 }
 
 static inline int block_in_use (unsigned long block,
 				struct super_block * sb,
+				struct ext2_sb_info * esb,
 				unsigned char * map)
 {
-	return ext2_test_bit ((block - le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block)) %
+	return ext2_test_bit ((block - le32_to_cpu(esb->s_es->s_first_data_block)) %
 			 EXT2_BLOCKS_PER_GROUP(sb), map);
 }
 
@@ -709,13 +720,14 @@
 	if (EXT2_HAS_RO_COMPAT_FEATURE(sb,EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER)&&
 	    !ext2_group_sparse(group))
 		return 0;
-	return EXT2_SB(sb)->s_gdb_count;
+	return ext2_sb(sb)->s_gdb_count;
 }
 
 #ifdef CONFIG_EXT2_CHECK
 /* Called at mount-time, super-block is locked */
 void ext2_check_blocks_bitmap (struct super_block * sb)
 {
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	struct buffer_head * bh;
 	struct ext2_super_block * es;
 	unsigned long desc_count, bitmap_count, x, j;
@@ -724,20 +736,20 @@
 	struct ext2_group_desc * gdp;
 	int i;
 
-	es = sb->u.ext2_sb.s_es;
+	es = esb->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < esb->s_groups_count; i++) {
 		gdp = ext2_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_blocks_count);
-		bitmap_nr = load_block_bitmap (sb, i);
+		bitmap_nr = load_block_bitmap (sb, esb, i);
 		if (bitmap_nr < 0)
 			continue;
 
-		bh = EXT2_SB(sb)->s_block_bitmap[bitmap_nr];
+		bh = esb->s_block_bitmap[bitmap_nr];
 
 		if (ext2_bg_has_super(sb, i) && !ext2_test_bit(0, bh->b_data))
 			ext2_error(sb, __FUNCTION__,
@@ -750,18 +762,18 @@
 					   "Descriptor block #%ld in group "
 					   "%d is marked free", j, i);
 
-		if (!block_in_use (le32_to_cpu(gdp->bg_block_bitmap), sb, bh->b_data))
+		if (!block_in_use (le32_to_cpu(gdp->bg_block_bitmap), sb, esb, bh->b_data))
 			ext2_error (sb, "ext2_check_blocks_bitmap",
 				    "Block bitmap for group %d is marked free",
 				    i);
 
-		if (!block_in_use (le32_to_cpu(gdp->bg_inode_bitmap), sb, bh->b_data))
+		if (!block_in_use (le32_to_cpu(gdp->bg_inode_bitmap), sb, esb, bh->b_data))
 			ext2_error (sb, "ext2_check_blocks_bitmap",
 				    "Inode bitmap for group %d is marked free",
 				    i);
 
-		for (j = 0; j < sb->u.ext2_sb.s_itb_per_group; j++)
-			if (!block_in_use (le32_to_cpu(gdp->bg_inode_table) + j, sb, bh->b_data))
+		for (j = 0; j < esb->s_itb_per_group; j++)
+			if (!block_in_use (le32_to_cpu(gdp->bg_inode_table) + j, sb, esb, bh->b_data))
 				ext2_error (sb, "ext2_check_blocks_bitmap",
 					    "Block #%ld of the inode table in "
 					    "group %d is marked free", j, i);
diff -Naur -X /g/g/lib/dontdiff linux-fs1/fs/ext2/dir.c linux-fs2/fs/ext2/dir.c
--- linux-fs1/fs/ext2/dir.c	Sun Jan  6 23:08:18 2002
+++ linux-fs2/fs/ext2/dir.c	Mon Jan  7 00:00:20 2002
@@ -62,9 +62,10 @@
 {
 	struct inode *dir = page->mapping->host;
 	struct super_block *sb = dir->i_sb;
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	unsigned chunk_size = ext2_chunk_size(dir);
 	char *kaddr = page_address(page);
-	u32 max_inumber = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	u32 max_inumber = le32_to_cpu(esb->s_es->s_inodes_count);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_CACHE_SIZE;
 	ext2_dirent *p;
diff -Naur -X /g/g/lib/dontdiff linux-fs1/fs/ext2/ialloc.c linux-fs2/fs/ext2/ialloc.c
--- linux-fs1/fs/ext2/ialloc.c	Mon Jan  7 00:57:57 2002
+++ linux-fs2/fs/ext2/ialloc.c	Mon Jan  7 00:42:49 2002
@@ -78,7 +78,7 @@
 					      unsigned int block_group)
 {
 	int i, slot = 0;
-	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct ext2_sb_info *sbi = ext2_sb(sb);
 	struct buffer_head *bh = sbi->s_inode_bitmap[0];
 
 	if (block_group >= sbi->s_groups_count)
@@ -157,6 +157,7 @@
 	unsigned long bit;
 	struct ext2_group_desc * desc;
 	struct ext2_super_block * es;
+	struct ext2_sb_info *esb = ext2_sb(sb);
 
 	ino = inode->i_ino;
 	ext2_debug ("freeing inode %lu\n", ino);
@@ -172,7 +173,7 @@
 	}
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = esb->s_es;
 	is_directory = S_ISDIR(inode->i_mode);
 
 	/* Do this BEFORE marking the inode not in use or returning an error */
@@ -206,7 +207,7 @@
 		mark_buffer_dirty(bh2);
 		es->s_free_inodes_count =
 			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		mark_buffer_dirty(esb->s_sbh);
 	}
 	mark_buffer_dirty(bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
@@ -231,8 +232,9 @@
 
 static int find_group_dir(struct super_block *sb, int parent_group)
 {
-	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
-	int ngroups = sb->u.ext2_sb.s_groups_count;
+	struct ext2_sb_info *esb = ext2_sb(sb);
+	struct ext2_super_block * es = esb->s_es;
+	int ngroups = esb->s_groups_count;
 	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
 	struct ext2_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh, *best_bh = NULL;
@@ -264,7 +266,7 @@
 
 static int find_group_other(struct super_block *sb, int parent_group)
 {
-	int ngroups = sb->u.ext2_sb.s_groups_count;
+	int ngroups = ext2_sb(sb)->s_groups_count;
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh;
 	int group, i;
@@ -323,16 +325,18 @@
 	struct inode * inode;
 	struct ext2_group_desc * desc;
 	struct ext2_super_block * es;
+	struct ext2_sb_info *esb;
 	int err;
 
 	sb = dir->i_sb;
+	esb = ext2_sb(sb);
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	ei = ext2_i(inode);
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = esb->s_es;
 repeat:
 	if (S_ISDIR(mode))
 		group = find_group_dir(sb, di->i_block_group);
@@ -371,7 +375,7 @@
 
 	es->s_free_inodes_count =
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(esb->s_sbh);
 	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
@@ -396,7 +400,7 @@
 	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	insert_inode_hash(inode);
-	inode->i_generation = sb->u.ext2_sb.s_next_generation++;
+	inode->i_generation = esb->s_next_generation++;
 	mark_inode_dirty(inode);
 
 	unlock_super (sb);
@@ -441,14 +445,15 @@
 
 unsigned long ext2_count_free_inodes (struct super_block * sb)
 {
+	struct ext2_sb_info *esb = ext2_sb(sb);
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
 	unsigned long desc_count = 0, bitmap_count = 0;
 	int i;
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	es = esb->s_es;
+	for (i = 0; i < esb->s_groups_count; i++) {
 		struct ext2_group_desc *desc = ext2_get_group_desc (sb, i, NULL);
 		struct buffer_head *bh;
 		unsigned x;
@@ -470,7 +475,7 @@
 	unlock_super (sb);
 	return desc_count;
 #else
-	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_inodes_count);
+	return le32_to_cpu(esb->s_es->s_free_inodes_count);
 #endif
 }
 
@@ -478,11 +483,12 @@
 /* Called at mount-time, super-block is locked */
 void ext2_check_inodes_bitmap (struct super_block * sb)
 {
-	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	struct ext2_sb_info *esb = ext2_sb(sb);
+	struct ext2_super_block * es = esb->s_es;
 	unsigned long desc_count = 0, bitmap_count = 0;
 	int i;
 
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < esb->s_groups_count; i++) {
 		struct ext2_group_desc *desc = ext2_get_group_desc(sb, i, NULL);
 		struct buffer_head *bh;
 		unsigned x;
diff -Naur -X /g/g/lib/dontdiff linux-fs1/fs/ext2/inode.c linux-fs2/fs/ext2/inode.c
--- linux-fs1/fs/ext2/inode.c	Mon Jan  7 09:19:01 2002
+++ linux-fs2/fs/ext2/inode.c	Mon Jan  7 09:19:19 2002
@@ -290,6 +290,8 @@
 
 static inline unsigned long ext2_find_near(struct inode *inode, Indirect *ind)
 {
+	struct super_block *sb = inode->i_sb;
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	struct ext2_inode_info *ei = ext2_i(inode);
 	u32 *start = ind->bh? (u32*) ind->bh->b_data: ei->i_data;
 	u32 *p;
@@ -307,8 +309,8 @@
 	 * It is going to be refered from inode itself? OK, just put it into
 	 * the same cylinder group then.
 	 */
-	return (ei->i_block_group * EXT2_BLOCKS_PER_GROUP(inode->i_sb)) +
-	       le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_first_data_block);
+	return (ei->i_block_group * EXT2_BLOCKS_PER_GROUP(sb)) +
+	       le32_to_cpu(esb->s_es->s_first_data_block);
 }
 
 /**
@@ -884,6 +886,8 @@
 
 void ext2_read_inode (struct inode * inode)
 {
+	struct super_block *sb = inode->i_sb;
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	struct ext2_inode_info *ei = ext2_i(inode);
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
@@ -896,23 +900,23 @@
 
 	if ((inode->i_ino != EXT2_ROOT_INO && inode->i_ino != EXT2_ACL_IDX_INO &&
 	     inode->i_ino != EXT2_ACL_DATA_INO &&
-	     inode->i_ino < EXT2_FIRST_INO(inode->i_sb)) ||
-	    inode->i_ino > le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_inodes_count)) {
-		ext2_error (inode->i_sb, "ext2_read_inode",
+	     inode->i_ino < EXT2_FIRST_INO(sb)) ||
+	    inode->i_ino > le32_to_cpu(esb->s_es->s_inodes_count)) {
+		ext2_error (sb, "ext2_read_inode",
 			    "bad inode number: %lu", inode->i_ino);
 		goto bad_inode;
 	}
-	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
-	if (block_group >= inode->i_sb->u.ext2_sb.s_groups_count) {
-		ext2_error (inode->i_sb, "ext2_read_inode",
+	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(sb);
+	if (block_group >= esb->s_groups_count) {
+		ext2_error (sb, "ext2_read_inode",
 			    "group >= groups count");
 		goto bad_inode;
 	}
-	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(inode->i_sb);
-	desc = block_group & (EXT2_DESC_PER_BLOCK(inode->i_sb) - 1);
-	bh = inode->i_sb->u.ext2_sb.s_group_desc[group_desc];
+	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(sb);
+	desc = block_group & (EXT2_DESC_PER_BLOCK(sb) - 1);
+	bh = esb->s_group_desc[group_desc];
 	if (!bh) {
-		ext2_error (inode->i_sb, "ext2_read_inode",
+		ext2_error (sb, "ext2_read_inode",
 			    "Descriptor not loaded");
 		goto bad_inode;
 	}
@@ -921,23 +925,23 @@
 	/*
 	 * Figure out the offset within the block group inode table
 	 */
-	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
-		EXT2_INODE_SIZE(inode->i_sb);
+	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(sb)) *
+		EXT2_INODE_SIZE(sb);
 	block = le32_to_cpu(gdp[desc].bg_inode_table) +
-		(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
-	if (!(bh = sb_bread(inode->i_sb, block))) {
-		ext2_error (inode->i_sb, "ext2_read_inode",
+		(offset >> EXT2_BLOCK_SIZE_BITS(sb));
+	if (!(bh = sb_bread(sb, block))) {
+		ext2_error (sb, "ext2_read_inode",
 			    "unable to read inode block - "
 			    "inode=%lu, block=%lu", inode->i_ino, block);
 		goto bad_inode;
 	}
-	offset &= (EXT2_BLOCK_SIZE(inode->i_sb) - 1);
+	offset &= (EXT2_BLOCK_SIZE(sb) - 1);
 	raw_inode = (struct ext2_inode *) (bh->b_data + offset);
 
 	inode->i_mode = le16_to_cpu(raw_inode->i_mode);
 	inode->i_uid = (uid_t)le16_to_cpu(raw_inode->i_uid_low);
 	inode->i_gid = (gid_t)le16_to_cpu(raw_inode->i_gid_low);
-	if(!(test_opt (inode->i_sb, NO_UID32))) {
+	if(!(test_opt (sb, NO_UID32))) {
 		inode->i_uid |= le16_to_cpu(raw_inode->i_uid_high) << 16;
 		inode->i_gid |= le16_to_cpu(raw_inode->i_gid_high) << 16;
 	}
@@ -1028,6 +1032,8 @@
 
 static int ext2_update_inode(struct inode * inode, int do_sync)
 {
+	struct super_block *sb = inode->i_sb;
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	struct ext2_inode_info *ei = ext2_i(inode);
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
@@ -1040,23 +1046,23 @@
 	struct ext2_group_desc * gdp;
 
 	if ((inode->i_ino != EXT2_ROOT_INO &&
-	     inode->i_ino < EXT2_FIRST_INO(inode->i_sb)) ||
-	    inode->i_ino > le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_inodes_count)) {
-		ext2_error (inode->i_sb, "ext2_write_inode",
+	     inode->i_ino < EXT2_FIRST_INO(sb)) ||
+	    inode->i_ino > le32_to_cpu(esb->s_es->s_inodes_count)) {
+		ext2_error (sb, "ext2_write_inode",
 			    "bad inode number: %lu", inode->i_ino);
 		return -EIO;
 	}
-	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
-	if (block_group >= inode->i_sb->u.ext2_sb.s_groups_count) {
-		ext2_error (inode->i_sb, "ext2_write_inode",
+	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(sb);
+	if (block_group >= esb->s_groups_count) {
+		ext2_error (sb, "ext2_write_inode",
 			    "group >= groups count");
 		return -EIO;
 	}
-	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(inode->i_sb);
-	desc = block_group & (EXT2_DESC_PER_BLOCK(inode->i_sb) - 1);
-	bh = inode->i_sb->u.ext2_sb.s_group_desc[group_desc];
+	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(sb);
+	desc = block_group & (EXT2_DESC_PER_BLOCK(sb) - 1);
+	bh = esb->s_group_desc[group_desc];
 	if (!bh) {
-		ext2_error (inode->i_sb, "ext2_write_inode",
+		ext2_error (sb, "ext2_write_inode",
 			    "Descriptor not loaded");
 		return -EIO;
 	}
@@ -1064,17 +1070,17 @@
 	/*
 	 * Figure out the offset within the block group inode table
 	 */
-	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
-		EXT2_INODE_SIZE(inode->i_sb);
+	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(sb)) *
+		EXT2_INODE_SIZE(sb);
 	block = le32_to_cpu(gdp[desc].bg_inode_table) +
-		(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
-	if (!(bh = sb_bread(inode->i_sb, block))) {
-		ext2_error (inode->i_sb, "ext2_write_inode",
+		(offset >> EXT2_BLOCK_SIZE_BITS(sb));
+	if (!(bh = sb_bread(sb, block))) {
+		ext2_error (sb, "ext2_write_inode",
 			    "unable to read inode block - "
 			    "inode=%lu, block=%lu", inode->i_ino, block);
 		return -EIO;
 	}
-	offset &= EXT2_BLOCK_SIZE(inode->i_sb) - 1;
+	offset &= EXT2_BLOCK_SIZE(sb) - 1;
 	raw_inode = (struct ext2_inode *) (bh->b_data + offset);
 
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
@@ -1115,10 +1121,9 @@
 	else {
 		raw_inode->i_size_high = cpu_to_le32(inode->i_size >> 32);
 		if (inode->i_size > 0x7fffffffULL) {
-			struct super_block *sb = inode->i_sb;
 			if (!EXT2_HAS_RO_COMPAT_FEATURE(sb,
 					EXT2_FEATURE_RO_COMPAT_LARGE_FILE) ||
-			    EXT2_SB(sb)->s_es->s_rev_level ==
+			    esb->s_es->s_rev_level ==
 					cpu_to_le32(EXT2_GOOD_OLD_REV)) {
 			       /* If this is the first large file
 				* created, add a flag to the superblock.
@@ -1144,7 +1149,7 @@
 		wait_on_buffer (bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh)) {
 			printk ("IO error syncing ext2 inode [%s:%08lx]\n",
-				inode->i_sb->s_id, inode->i_ino);
+				sb->s_id, inode->i_ino);
 			err = -EIO;
 		}
 	}
diff -Naur -X /g/g/lib/dontdiff linux-fs1/fs/ext2/super.c linux-fs2/fs/ext2/super.c
--- linux-fs1/fs/ext2/super.c	Sun Jan  6 23:29:19 2002
+++ linux-fs2/fs/ext2/super.c	Mon Jan  7 00:44:34 2002
@@ -30,6 +30,7 @@
 
 
 static void ext2_sync_super(struct super_block *sb,
+			    struct ext2_sb_info *esb,
 			    struct ext2_super_block *es);
 
 static char error_buf[1024];
@@ -38,26 +39,27 @@
 		 const char * fmt, ...)
 {
 	va_list args;
-	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+	struct ext2_sb_info *esb = ext2_sb(sb);
+	struct ext2_super_block *es = esb->s_es;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
+		esb->s_mount_state |= EXT2_ERROR_FS;
 		es->s_state =
 			cpu_to_le16(le16_to_cpu(es->s_state) | EXT2_ERROR_FS);
-		ext2_sync_super(sb, es);
+		ext2_sync_super(sb, esb, es);
 	}
 	va_start (args, fmt);
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
 	if (test_opt (sb, ERRORS_PANIC) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_PANIC &&
+	    (le16_to_cpu(esb->s_es->s_errors) == EXT2_ERRORS_PANIC &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_RO)))
 		panic ("EXT2-fs panic (device %s): %s: %s\n",
 		       sb->s_id, function, error_buf);
 	printk (KERN_CRIT "EXT2-fs error (device %s): %s: %s\n",
 		sb->s_id, function, error_buf);
 	if (test_opt (sb, ERRORS_RO) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_RO &&
+	    (le16_to_cpu(esb->s_es->s_errors) == EXT2_ERRORS_RO &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_PANIC))) {
 		printk ("Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
@@ -68,12 +70,13 @@
 			    const char * fmt, ...)
 {
 	va_list args;
+	struct ext2_sb_info *esb = ext2_sb(sb);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
-		sb->u.ext2_sb.s_es->s_state =
-			cpu_to_le16(le16_to_cpu(sb->u.ext2_sb.s_es->s_state) | EXT2_ERROR_FS);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		esb->s_mount_state |= EXT2_ERROR_FS;
+		esb->s_es->s_state =
+			cpu_to_le16(le16_to_cpu(esb->s_es->s_state) | EXT2_ERROR_FS);
+		mark_buffer_dirty(esb->s_sbh);
 		sb->s_dirt = 1;
 	}
 	va_start (args, fmt);
@@ -98,7 +101,7 @@
 
 void ext2_update_dynamic_rev(struct super_block *sb)
 {
-	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+	struct ext2_super_block *es = ext2_sb(sb)->s_es;
 
 	if (le32_to_cpu(es->s_rev_level) > EXT2_GOOD_OLD_REV)
 		return;
@@ -123,27 +126,28 @@
 
 void ext2_put_super (struct super_block * sb)
 {
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	int db_count;
 	int i;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+		struct ext2_super_block *es = esb->s_es;
 
-		es->s_state = le16_to_cpu(EXT2_SB(sb)->s_mount_state);
-		ext2_sync_super(sb, es);
+		es->s_state = le16_to_cpu(esb->s_mount_state);
+		ext2_sync_super(sb, esb, es);
 	}
-	db_count = EXT2_SB(sb)->s_gdb_count;
+	db_count = esb->s_gdb_count;
 	for (i = 0; i < db_count; i++)
-		if (sb->u.ext2_sb.s_group_desc[i])
-			brelse (sb->u.ext2_sb.s_group_desc[i]);
-	kfree(sb->u.ext2_sb.s_group_desc);
+		if (esb->s_group_desc[i])
+			brelse (esb->s_group_desc[i]);
+	kfree(esb->s_group_desc);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_inode_bitmap[i])
-			brelse (sb->u.ext2_sb.s_inode_bitmap[i]);
+		if (esb->s_inode_bitmap[i])
+			brelse (esb->s_inode_bitmap[i]);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_block_bitmap[i])
-			brelse (sb->u.ext2_sb.s_block_bitmap[i]);
-	brelse (sb->u.ext2_sb.s_sbh);
+		if (esb->s_block_bitmap[i])
+			brelse (esb->s_block_bitmap[i]);
+	brelse (esb->s_sbh);
 
 	return;
 }
@@ -284,6 +288,7 @@
 }
 
 static int ext2_setup_super (struct super_block * sb,
+			      struct ext2_sb_info *esb,
 			      struct ext2_super_block * es,
 			      int read_only)
 {
@@ -295,10 +300,10 @@
 	}
 	if (read_only)
 		return res;
-	if (!(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
+	if (!(esb->s_mount_state & EXT2_VALID_FS))
 		printk ("EXT2-fs warning: mounting unchecked fs, "
 			"running e2fsck is recommended\n");
-	else if ((sb->u.ext2_sb.s_mount_state & EXT2_ERROR_FS))
+	else if ((esb->s_mount_state & EXT2_ERROR_FS))
 		printk ("EXT2-fs warning: mounting fs with errors, "
 			"running e2fsck is recommended\n");
 	else if ((__s16) le16_to_cpu(es->s_max_mnt_count) >= 0 &&
@@ -318,11 +323,11 @@
 		printk ("[EXT II FS %s, %s, bs=%lu, fs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]\n",
 			EXT2FS_VERSION, EXT2FS_DATE, sb->s_blocksize,
-			sb->u.ext2_sb.s_frag_size,
-			sb->u.ext2_sb.s_groups_count,
+			esb->s_frag_size,
+			esb->s_groups_count,
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
-			sb->u.ext2_sb.s_mount_opt);
+			esb->s_mount_opt);
 #ifdef CONFIG_EXT2_CHECK
 	if (test_opt (sb, CHECK)) {
 		ext2_check_blocks_bitmap (sb);
@@ -334,17 +339,18 @@
 
 static int ext2_check_descriptors (struct super_block * sb)
 {
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	int i;
 	int desc_block = 0;
-	unsigned long block = le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block);
+	unsigned long block = le32_to_cpu(esb->s_es->s_first_data_block);
 	struct ext2_group_desc * gdp = NULL;
 
 	ext2_debug ("Checking group descriptors");
 
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++)
+	for (i = 0; i < esb->s_groups_count; i++)
 	{
 		if ((i % EXT2_DESC_PER_BLOCK(sb)) == 0)
-			gdp = (struct ext2_group_desc *) sb->u.ext2_sb.s_group_desc[desc_block++]->b_data;
+			gdp = (struct ext2_group_desc *) esb->s_group_desc[desc_block++]->b_data;
 		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
 		    le32_to_cpu(gdp->bg_block_bitmap) >= block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
@@ -364,7 +370,7 @@
 			return 0;
 		}
 		if (le32_to_cpu(gdp->bg_inode_table) < block ||
-		    le32_to_cpu(gdp->bg_inode_table) + sb->u.ext2_sb.s_itb_per_group >=
+		    le32_to_cpu(gdp->bg_inode_table) + esb->s_itb_per_group >=
 		    block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
 			ext2_error (sb, "ext2_check_descriptors",
@@ -411,6 +417,10 @@
 	int blocksize = BLOCK_SIZE;
 	int db_count;
 	int i, j;
+	struct ext2_sb_info *esb;
+
+	/* when dynamically allocated, this will change */
+	esb = ext2_sb(sb);
 
 	/*
 	 * See what the current blocksize for the device is, and
@@ -420,9 +430,9 @@
 	 * sectorsize that is larger than the default.
 	 */
 
-	sb->u.ext2_sb.s_mount_opt = 0;
+	esb->s_mount_opt = 0;
 	if (!parse_options ((char *) data, &sb_block, &resuid, &resgid,
-	    &sb->u.ext2_sb.s_mount_opt)) {
+	    &esb->s_mount_opt)) {
 		return NULL;
 	}
 
@@ -451,7 +461,7 @@
 	 *       some ext2 macro-instructions depend on its value
 	 */
 	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-	sb->u.ext2_sb.s_es = es;
+	esb->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
@@ -483,7 +493,7 @@
 		       sb->s_id, i);
 		goto failed_mount;
 	}
-	blocksize = BLOCK_SIZE << le32_to_cpu(EXT2_SB(sb)->s_es->s_log_block_size);
+	blocksize = BLOCK_SIZE << le32_to_cpu(esb->s_es->s_log_block_size);
 	/* If the blocksize doesn't match, re-read the thing.. */
 	if (sb->s_blocksize != blocksize) {
 		brelse(bh);
@@ -502,7 +512,7 @@
 			goto failed_mount;
 		}
 		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-		sb->u.ext2_sb.s_es = es;
+		esb->s_es = es;
 		if (es->s_magic != le16_to_cpu(EXT2_SUPER_MAGIC)) {
 			printk ("EXT2-fs: Magic mismatch, very weird !\n");
 			goto failed_mount;
@@ -512,46 +522,46 @@
 	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
-		sb->u.ext2_sb.s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
-		sb->u.ext2_sb.s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
+		esb->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
+		esb->s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
 	} else {
-		sb->u.ext2_sb.s_inode_size = le16_to_cpu(es->s_inode_size);
-		sb->u.ext2_sb.s_first_ino = le32_to_cpu(es->s_first_ino);
-		if (sb->u.ext2_sb.s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
+		esb->s_inode_size = le16_to_cpu(es->s_inode_size);
+		esb->s_first_ino = le32_to_cpu(es->s_first_ino);
+		if (esb->s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
 			printk ("EXT2-fs: unsupported inode size: %d\n",
-				sb->u.ext2_sb.s_inode_size);
+				esb->s_inode_size);
 			goto failed_mount;
 		}
 	}
-	sb->u.ext2_sb.s_frag_size = EXT2_MIN_FRAG_SIZE <<
+	esb->s_frag_size = EXT2_MIN_FRAG_SIZE <<
 				   le32_to_cpu(es->s_log_frag_size);
-	if (sb->u.ext2_sb.s_frag_size)
-		sb->u.ext2_sb.s_frags_per_block = sb->s_blocksize /
-						  sb->u.ext2_sb.s_frag_size;
+	if (esb->s_frag_size)
+		esb->s_frags_per_block = sb->s_blocksize /
+						  esb->s_frag_size;
 	else
 		sb->s_magic = 0;
-	sb->u.ext2_sb.s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sb->u.ext2_sb.s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
-	sb->u.ext2_sb.s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
-	sb->u.ext2_sb.s_inodes_per_block = sb->s_blocksize /
+	esb->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
+	esb->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
+	esb->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
+	esb->s_inodes_per_block = sb->s_blocksize /
 					   EXT2_INODE_SIZE(sb);
-	sb->u.ext2_sb.s_itb_per_group = sb->u.ext2_sb.s_inodes_per_group /
-				        sb->u.ext2_sb.s_inodes_per_block;
-	sb->u.ext2_sb.s_desc_per_block = sb->s_blocksize /
+	esb->s_itb_per_group = esb->s_inodes_per_group /
+				        esb->s_inodes_per_block;
+	esb->s_desc_per_block = sb->s_blocksize /
 					 sizeof (struct ext2_group_desc);
-	sb->u.ext2_sb.s_sbh = bh;
+	esb->s_sbh = bh;
 	if (resuid != EXT2_DEF_RESUID)
-		sb->u.ext2_sb.s_resuid = resuid;
+		esb->s_resuid = resuid;
 	else
-		sb->u.ext2_sb.s_resuid = le16_to_cpu(es->s_def_resuid);
+		esb->s_resuid = le16_to_cpu(es->s_def_resuid);
 	if (resgid != EXT2_DEF_RESGID)
-		sb->u.ext2_sb.s_resgid = resgid;
+		esb->s_resgid = resgid;
 	else
-		sb->u.ext2_sb.s_resgid = le16_to_cpu(es->s_def_resgid);
-	sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
-	sb->u.ext2_sb.s_addr_per_block_bits =
+		esb->s_resgid = le16_to_cpu(es->s_def_resgid);
+	esb->s_mount_state = le16_to_cpu(es->s_state);
+	esb->s_addr_per_block_bits =
 		log2 (EXT2_ADDR_PER_BLOCK(sb));
-	sb->u.ext2_sb.s_desc_per_block_bits =
+	esb->s_desc_per_block_bits =
 		log2 (EXT2_DESC_PER_BLOCK(sb));
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
@@ -567,45 +577,45 @@
 		goto failed_mount;
 	}
 
-	if (sb->s_blocksize != sb->u.ext2_sb.s_frag_size) {
+	if (sb->s_blocksize != esb->s_frag_size) {
 		printk ("EXT2-fs: fragsize %lu != blocksize %lu (not supported yet)\n",
-			sb->u.ext2_sb.s_frag_size, sb->s_blocksize);
+			esb->s_frag_size, sb->s_blocksize);
 		goto failed_mount;
 	}
 
-	if (sb->u.ext2_sb.s_blocks_per_group > sb->s_blocksize * 8) {
+	if (esb->s_blocks_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #blocks per group too big: %lu\n",
-			sb->u.ext2_sb.s_blocks_per_group);
+			esb->s_blocks_per_group);
 		goto failed_mount;
 	}
-	if (sb->u.ext2_sb.s_frags_per_group > sb->s_blocksize * 8) {
+	if (esb->s_frags_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #fragments per group too big: %lu\n",
-			sb->u.ext2_sb.s_frags_per_group);
+			esb->s_frags_per_group);
 		goto failed_mount;
 	}
-	if (sb->u.ext2_sb.s_inodes_per_group > sb->s_blocksize * 8) {
+	if (esb->s_inodes_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #inodes per group too big: %lu\n",
-			sb->u.ext2_sb.s_inodes_per_group);
+			esb->s_inodes_per_group);
 		goto failed_mount;
 	}
 
-	sb->u.ext2_sb.s_groups_count = (le32_to_cpu(es->s_blocks_count) -
+	esb->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
 				        le32_to_cpu(es->s_first_data_block) +
 				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
 				       EXT2_BLOCKS_PER_GROUP(sb);
-	db_count = (sb->u.ext2_sb.s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
+	db_count = (esb->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
-	sb->u.ext2_sb.s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
-	if (sb->u.ext2_sb.s_group_desc == NULL) {
+	esb->s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
+	if (esb->s_group_desc == NULL) {
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
 	for (i = 0; i < db_count; i++) {
-		sb->u.ext2_sb.s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
-		if (!sb->u.ext2_sb.s_group_desc[i]) {
+		esb->s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
+		if (!esb->s_group_desc[i]) {
 			for (j = 0; j < i; j++)
-				brelse (sb->u.ext2_sb.s_group_desc[j]);
-			kfree(sb->u.ext2_sb.s_group_desc);
+				brelse (esb->s_group_desc[j]);
+			kfree(esb->s_group_desc);
 			printk ("EXT2-fs: unable to read group descriptors\n");
 			goto failed_mount;
 		}
@@ -616,15 +626,15 @@
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
+		esb->s_inode_bitmap_number[i] = 0;
+		esb->s_inode_bitmap[i] = NULL;
+		esb->s_block_bitmap_number[i] = 0;
+		esb->s_block_bitmap[i] = NULL;
+	}
+	esb->s_loaded_inode_bitmaps = 0;
+	esb->s_loaded_block_bitmaps = 0;
+	esb->s_gdb_count = db_count;
+	get_random_bytes(&esb->s_next_generation, sizeof(u32));
 	/*
 	 * set up enough so that it can read an inode
 	 */
@@ -640,31 +650,34 @@
 			printk(KERN_ERR "EXT2-fs: get root inode failed\n");
 		goto failed_mount2;
 	}
-	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
+	ext2_setup_super (sb, esb, es, sb->s_flags & MS_RDONLY);
 	return sb;
 failed_mount2:
 	for (i = 0; i < db_count; i++)
-		brelse(sb->u.ext2_sb.s_group_desc[i]);
-	kfree(sb->u.ext2_sb.s_group_desc);
+		brelse(esb->s_group_desc[i]);
+	kfree(esb->s_group_desc);
 failed_mount:
 	brelse(bh);
 	return NULL;
 }
 
 static void ext2_commit_super (struct super_block * sb,
+			       struct ext2_sb_info *esb,
 			       struct ext2_super_block * es)
 {
 	es->s_wtime = cpu_to_le32(CURRENT_TIME);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(esb->s_sbh);
 	sb->s_dirt = 0;
 }
 
-static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
+static void ext2_sync_super(struct super_block *sb,
+			    struct ext2_sb_info *esb,
+			    struct ext2_super_block *es)
 {
 	es->s_wtime = cpu_to_le32(CURRENT_TIME);
-	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	ll_rw_block(WRITE, 1, &EXT2_SB(sb)->s_sbh);
-	wait_on_buffer(EXT2_SB(sb)->s_sbh);
+	mark_buffer_dirty(esb->s_sbh);
+	ll_rw_block(WRITE, 1, &esb->s_sbh);
+	wait_on_buffer(esb->s_sbh);
 	sb->s_dirt = 0;
 }
 
@@ -681,54 +694,54 @@
 
 void ext2_write_super (struct super_block * sb)
 {
-	struct ext2_super_block * es;
-
 	if (!(sb->s_flags & MS_RDONLY)) {
-		es = sb->u.ext2_sb.s_es;
+		struct ext2_sb_info *esb = ext2_sb(sb);
+		struct ext2_super_block *es = esb->s_es;
 
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS) {
 			ext2_debug ("setting valid to 0\n");
 			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
 						  ~EXT2_VALID_FS);
 			es->s_mtime = cpu_to_le32(CURRENT_TIME);
-			ext2_sync_super(sb, es);
+			ext2_sync_super(sb, esb, es);
 		} else
-			ext2_commit_super (sb, es);
+			ext2_commit_super (sb, esb, es);
 	}
 	sb->s_dirt = 0;
 }
 
 int ext2_remount (struct super_block * sb, int * flags, char * data)
 {
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	struct ext2_super_block * es;
-	unsigned short resuid = sb->u.ext2_sb.s_resuid;
-	unsigned short resgid = sb->u.ext2_sb.s_resgid;
+	unsigned short resuid = esb->s_resuid;
+	unsigned short resgid = esb->s_resgid;
 	unsigned long new_mount_opt;
 	unsigned long tmp;
 
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
-	new_mount_opt = sb->u.ext2_sb.s_mount_opt;
+	new_mount_opt = esb->s_mount_opt;
 	if (!parse_options (data, &tmp, &resuid, &resgid,
 			    &new_mount_opt))
 		return -EINVAL;
 
-	sb->u.ext2_sb.s_mount_opt = new_mount_opt;
-	sb->u.ext2_sb.s_resuid = resuid;
-	sb->u.ext2_sb.s_resgid = resgid;
-	es = sb->u.ext2_sb.s_es;
+	esb->s_mount_opt = new_mount_opt;
+	esb->s_resuid = resuid;
+	esb->s_resgid = resgid;
+	es = esb->s_es;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
 	if (*flags & MS_RDONLY) {
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS ||
-		    !(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
+		    !(esb->s_mount_state & EXT2_VALID_FS))
 			return 0;
 		/*
 		 * OK, we are remounting a valid rw partition rdonly, so set
 		 * the rdonly flag and then mark the partition as valid again.
 		 */
-		es->s_state = cpu_to_le16(sb->u.ext2_sb.s_mount_state);
+		es->s_state = cpu_to_le16(esb->s_mount_state);
 		es->s_mtime = cpu_to_le32(CURRENT_TIME);
 	} else {
 		int ret;
@@ -744,16 +757,17 @@
 		 * store the current valid flag.  (It may have been changed
 		 * by e2fsck since we originally mounted the partition.)
 		 */
-		sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
-		if (!ext2_setup_super (sb, es, 0))
+		esb->s_mount_state = le16_to_cpu(es->s_state);
+		if (!ext2_setup_super (sb, esb, es, 0))
 			sb->s_flags &= ~MS_RDONLY;
 	}
-	ext2_sync_super(sb, es);
+	ext2_sync_super(sb, esb, es);
 	return 0;
 }
 
 int ext2_statfs (struct super_block * sb, struct statfs * buf)
 {
+	struct ext2_sb_info *esb = ext2_sb(sb);
 	unsigned long overhead;
 	int i;
 
@@ -768,14 +782,14 @@
 		 * All of the blocks before first_data_block are
 		 * overhead
 		 */
-		overhead = le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block);
+		overhead = le32_to_cpu(esb->s_es->s_first_data_block);
 
 		/*
 		 * Add the overhead attributed to the superblock and
 		 * block group descriptors.  If the sparse superblocks
 		 * feature is turned on, then not all groups have this.
 		 */
-		for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++)
+		for (i = 0; i < esb->s_groups_count; i++)
 			overhead += ext2_bg_has_super(sb, i) +
 				ext2_bg_num_gdb(sb, i);
 
@@ -783,18 +797,18 @@
 		 * Every block group has an inode bitmap, a block
 		 * bitmap, and an inode table.
 		 */
-		overhead += (sb->u.ext2_sb.s_groups_count *
-			     (2 + sb->u.ext2_sb.s_itb_per_group));
+		overhead += (esb->s_groups_count *
+			     (2 + esb->s_itb_per_group));
 	}
 
 	buf->f_type = EXT2_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = le32_to_cpu(sb->u.ext2_sb.s_es->s_blocks_count) - overhead;
+	buf->f_blocks = le32_to_cpu(esb->s_es->s_blocks_count) - overhead;
 	buf->f_bfree = ext2_count_free_blocks (sb);
-	buf->f_bavail = buf->f_bfree - le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count);
-	if (buf->f_bfree < le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count))
+	buf->f_bavail = buf->f_bfree - le32_to_cpu(esb->s_es->s_r_blocks_count);
+	if (buf->f_bfree < le32_to_cpu(esb->s_es->s_r_blocks_count))
 		buf->f_bavail = 0;
-	buf->f_files = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	buf->f_files = le32_to_cpu(esb->s_es->s_inodes_count);
 	buf->f_ffree = ext2_count_free_inodes (sb);
 	buf->f_namelen = EXT2_NAME_LEN;
 	return 0;
diff -Naur -X /g/g/lib/dontdiff linux-fs1/include/linux/ext2_fs.h linux-fs2/include/linux/ext2_fs.h
--- linux-fs1/include/linux/ext2_fs.h	Mon Jan  7 09:24:57 2002
+++ linux-fs2/include/linux/ext2_fs.h	Mon Jan  7 09:28:01 2002
@@ -94,9 +94,9 @@
 # define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
 #ifdef __KERNEL__
-#define	EXT2_ADDR_PER_BLOCK_BITS(s)	((s)->u.ext2_sb.s_addr_per_block_bits)
-#define EXT2_INODE_SIZE(s)		((s)->u.ext2_sb.s_inode_size)
-#define EXT2_FIRST_INO(s)		((s)->u.ext2_sb.s_first_ino)
+#define	EXT2_ADDR_PER_BLOCK_BITS(s)	(ext2_sb(s)->s_addr_per_block_bits)
+#define EXT2_INODE_SIZE(s)		(ext2_sb(s)->s_inode_size)
+#define EXT2_FIRST_INO(s)		(ext2_sb(s)->s_first_ino)
 #else
 #define EXT2_INODE_SIZE(s)	(((s)->s_rev_level == EXT2_GOOD_OLD_REV) ? \
 				 EXT2_GOOD_OLD_INODE_SIZE : \
@@ -113,8 +113,8 @@
 #define	EXT2_MAX_FRAG_SIZE		4096
 #define EXT2_MIN_FRAG_LOG_SIZE		  10
 #ifdef __KERNEL__
-# define EXT2_FRAG_SIZE(s)		((s)->u.ext2_sb.s_frag_size)
-# define EXT2_FRAGS_PER_BLOCK(s)	((s)->u.ext2_sb.s_frags_per_block)
+# define EXT2_FRAG_SIZE(s)		(ext2_sb(s)->s_frag_size)
+# define EXT2_FRAGS_PER_BLOCK(s)	(ext2_sb(s)->s_frags_per_block)
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
+# define EXT2_BLOCKS_PER_GROUP(s)	(ext2_sb(s)->s_blocks_per_group)
+# define EXT2_DESC_PER_BLOCK(s)		(ext2_sb(s)->s_desc_per_block)
+# define EXT2_INODES_PER_GROUP(s)	(ext2_sb(s)->s_inodes_per_group)
+# define EXT2_DESC_PER_BLOCK_BITS(s)	(ext2_sb(s)->s_desc_per_block_bits)
 #else
 # define EXT2_BLOCKS_PER_GROUP(s)	((s)->s_blocks_per_group)
 # define EXT2_DESC_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_group_desc))
@@ -317,7 +317,7 @@
 
 #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT2_MOUNT_##opt
-#define test_opt(sb, opt)		((sb)->u.ext2_sb.s_mount_opt & \
+#define test_opt(sb, opt)		(ext2_sb(sb)->s_mount_opt & \
 					 EXT2_MOUNT_##opt)
 /*
  * Maximal mount counts between two filesystem checks
@@ -396,7 +396,7 @@
 };
 
 #ifdef __KERNEL__
-#define EXT2_SB(sb)	(&((sb)->u.ext2_sb))
+#define EXT2_SB		ext2_sb	/* unused */
 #else
 /* Assume that user mode programs are passing in an ext2fs superblock, not
  * a kernel struct super_block.  This will allow us to call the feature-test
@@ -601,6 +601,14 @@
 		       unsigned long);
 
 /* super.c */
+
+static inline struct ext2_sb_info *ext2_sb(struct super_block *sb)
+{
+	if (!sb)
+		BUG();
+	return &sb->u.ext2_sb;
+}
+
 extern void ext2_error (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
 extern NORET_TYPE void ext2_panic (struct super_block *, const char *,
