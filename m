Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQK3Woa>; Thu, 30 Nov 2000 17:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQK3WoK>; Thu, 30 Nov 2000 17:44:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53214 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129183AbQK3WoA>;
	Thu, 30 Nov 2000 17:44:00 -0500
Date: Thu, 30 Nov 2000 17:13:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: [CFT][RFC] ext2_new_inode() fixes and cleanup
Message-ID: <Pine.GSO.4.21.0011301652130.21891-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* search for appropriate cylinder group had been taken out of the
ext2_new_inode() into helper functions - find_cg_dir(sb, parent_group) and
find_cg_other(sb, parent_group). Bug caught by Daniel (wrong bh being
dirtied when we update the free inodes counter) - fixed.
	* ext2_new_inode() returns error values via ERR_PTR(). Callers
updated, the third argument gone.
	* load_inode_bitmap() returns bh of the bitmap instead of the slot
number. Callers updated.
	* code in ext2_new_inode() straightened up. Nothing spectacular,
but it became more readable now...
	* all callers of ext2_new_inode() in namei.c are passing correct
mode (including ext2_mkdir(), etc.) instead of setting ->i_mode by hands
afterwards. 

	It seems to work here. However, I would really, really like people to
test it - saying that it's not for immediate inclusion is putting it
_very_ mildly.

	It's _not_ likely that the whole thing will go into 2.4.0. Moreover,
if it ever will go, it will go in pieces. I will post the splitup for review,
indeed. Right now I'm just asking to help with testing the thing and with
reading the resulting code. Hopefully, it's easier to read than it used to
be.

	Please, help with testing. It's not too likely to eat filesystems,
but as usual, don't try it without good backups. 

	Ted, if you could look through the code and comment on it... I would
be extremely grateful. I can send you a splitup of the patch if that will be
more convenient for you - just tell.
							Cheers,
								Al

diff -urN rc12-3/fs/ext2/ialloc.c linux-ext2/fs/ext2/ialloc.c
--- rc12-3/fs/ext2/ialloc.c	Thu Nov 30 13:17:44 2000
+++ linux-ext2/fs/ext2/ialloc.c	Thu Nov 30 15:26:43 2000
@@ -39,37 +39,26 @@
  * Read the inode allocation bitmap for a given block_group, reading
  * into the specified slot in the superblock's bitmap cache.
  *
- * Return >=0 on success or a -ve error code.
+ * Return buffer_head of bitmap on success or NULL.
  */
-static int read_inode_bitmap (struct super_block * sb,
-			       unsigned long block_group,
-			       unsigned int bitmap_nr)
+static struct buffer_head *read_inode_bitmap (struct super_block * sb,
+					       unsigned long block_group)
 {
 	struct ext2_group_desc * gdp;
 	struct buffer_head * bh = NULL;
-	int retval = 0;
 
 	gdp = ext2_get_group_desc (sb, block_group, NULL);
-	if (!gdp) {
-		retval = -EIO;
+	if (!gdp)
 		goto error_out;
-	}
+
 	bh = bread (sb->s_dev, le32_to_cpu(gdp->bg_inode_bitmap), sb->s_blocksize);
-	if (!bh) {
+	if (!bh)
 		ext2_error (sb, "read_inode_bitmap",
 			    "Cannot read inode bitmap - "
 			    "block_group = %lu, inode_bitmap = %lu",
 			    block_group, (unsigned long) gdp->bg_inode_bitmap);
-		retval = -EIO;
-	}
-	/*
-	 * On IO error, just leave a zero in the superblock's block pointer for
-	 * this group.  The IO will be retried next time.
-	 */
 error_out:
-	sb->u.ext2_sb.s_inode_bitmap_number[bitmap_nr] = block_group;
-	sb->u.ext2_sb.s_inode_bitmap[bitmap_nr] = bh;
-	return retval;
+	return bh;
 }
 
 /*
@@ -83,79 +72,86 @@
  * 2/ If the file system contains less than EXT2_MAX_GROUP_LOADED groups,
  *    this function reads the bitmap without maintaining a LRU cache.
  * 
- * Return the slot used to store the bitmap, or a -ve error code.
+ * Return the buffer_head of the bitmap or the ERR_PTR(error)
  */
-static int load_inode_bitmap (struct super_block * sb,
-			      unsigned int block_group)
+static struct buffer_head *load_inode_bitmap (struct super_block * sb,
+					      unsigned int block_group)
 {
-	int i, j, retval = 0;
-	unsigned long inode_bitmap_number;
-	struct buffer_head * inode_bitmap;
+	int i, slot = 0;
+	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct buffer_head *bh = sbi->s_inode_bitmap[0];
 
-	if (block_group >= sb->u.ext2_sb.s_groups_count)
+	if (block_group >= sbi->s_groups_count)
 		ext2_panic (sb, "load_inode_bitmap",
 			    "block_group >= groups_count - "
 			    "block_group = %d, groups_count = %lu",
-			     block_group, sb->u.ext2_sb.s_groups_count);
-	if (sb->u.ext2_sb.s_loaded_inode_bitmaps > 0 &&
-	    sb->u.ext2_sb.s_inode_bitmap_number[0] == block_group &&
-	    sb->u.ext2_sb.s_inode_bitmap[0] != NULL)
-		return 0;
-	if (sb->u.ext2_sb.s_groups_count <= EXT2_MAX_GROUP_LOADED) {
-		if (sb->u.ext2_sb.s_inode_bitmap[block_group]) {
-			if (sb->u.ext2_sb.s_inode_bitmap_number[block_group] != block_group)
-				ext2_panic (sb, "load_inode_bitmap",
-					    "block_group != inode_bitmap_number");
-			else
-				return block_group;
-		} else {
-			retval = read_inode_bitmap (sb, block_group,
-						    block_group);
-			if (retval < 0)
-				return retval;
-			return block_group;
-		}
+			     block_group, sbi->s_groups_count);
+
+	if (sbi->s_loaded_inode_bitmaps > 0 &&
+	    sbi->s_inode_bitmap_number[0] == block_group && bh)
+		goto found;
+
+	if (sbi->s_groups_count <= EXT2_MAX_GROUP_LOADED) {
+		slot = block_group;
+		bh = sbi->s_inode_bitmap[slot];
+		if (!bh)
+			goto read_it;
+		if (sbi->s_inode_bitmap_number[slot] == slot)
+			goto found;
+		ext2_panic (sb, "load_inode_bitmap",
+			    "block_group != inode_bitmap_number");
+		return ERR_PTR(-EIO);
 	}
 
-	for (i = 0; i < sb->u.ext2_sb.s_loaded_inode_bitmaps &&
-		    sb->u.ext2_sb.s_inode_bitmap_number[i] != block_group;
+	for (i = 0; i < sbi->s_loaded_inode_bitmaps &&
+		    sbi->s_inode_bitmap_number[i] != block_group;
 	     i++)
 		;
-	if (i < sb->u.ext2_sb.s_loaded_inode_bitmaps &&
-  	    sb->u.ext2_sb.s_inode_bitmap_number[i] == block_group) {
-		inode_bitmap_number = sb->u.ext2_sb.s_inode_bitmap_number[i];
-		inode_bitmap = sb->u.ext2_sb.s_inode_bitmap[i];
+	if (i < sbi->s_loaded_inode_bitmaps) {
+		int j;
+		unsigned long nr = sbi->s_inode_bitmap_number[i];
+		bh = sbi->s_inode_bitmap[i];
 		for (j = i; j > 0; j--) {
-			sb->u.ext2_sb.s_inode_bitmap_number[j] =
-				sb->u.ext2_sb.s_inode_bitmap_number[j - 1];
-			sb->u.ext2_sb.s_inode_bitmap[j] =
-				sb->u.ext2_sb.s_inode_bitmap[j - 1];
-		}
-		sb->u.ext2_sb.s_inode_bitmap_number[0] = inode_bitmap_number;
-		sb->u.ext2_sb.s_inode_bitmap[0] = inode_bitmap;
-
+			sbi->s_inode_bitmap_number[j] =
+				sbi->s_inode_bitmap_number[j - 1];
+			sbi->s_inode_bitmap[j] =
+				sbi->s_inode_bitmap[j - 1];
+		}
+		sbi->s_inode_bitmap_number[0] = nr;
+		sbi->s_inode_bitmap[0] = bh;
+		if (bh)
+			goto found;
 		/*
 		 * There's still one special case here --- if inode_bitmap == 0
 		 * then our last attempt to read the bitmap failed and we have
 		 * just ended up caching that failure.  Try again to read it.
 		 */
-		if (!inode_bitmap)
-			retval = read_inode_bitmap (sb, block_group, 0);
-		
 	} else {
-		if (sb->u.ext2_sb.s_loaded_inode_bitmaps < EXT2_MAX_GROUP_LOADED)
-			sb->u.ext2_sb.s_loaded_inode_bitmaps++;
+		int j;
+		if (sbi->s_loaded_inode_bitmaps < EXT2_MAX_GROUP_LOADED)
+			sbi->s_loaded_inode_bitmaps++;
 		else
-			brelse (sb->u.ext2_sb.s_inode_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
-		for (j = sb->u.ext2_sb.s_loaded_inode_bitmaps - 1; j > 0; j--) {
-			sb->u.ext2_sb.s_inode_bitmap_number[j] =
-				sb->u.ext2_sb.s_inode_bitmap_number[j - 1];
-			sb->u.ext2_sb.s_inode_bitmap[j] =
-				sb->u.ext2_sb.s_inode_bitmap[j - 1];
+			brelse (sbi->s_inode_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
+		for (j = sbi->s_loaded_inode_bitmaps - 1; j > 0; j--) {
+			sbi->s_inode_bitmap_number[j] =
+				sbi->s_inode_bitmap_number[j - 1];
+			sbi->s_inode_bitmap[j] =
+				sbi->s_inode_bitmap[j - 1];
 		}
-		retval = read_inode_bitmap (sb, block_group, 0);
 	}
-	return retval;
+
+read_it:
+	bh = read_inode_bitmap (sb, block_group);
+	/*
+	 * On IO error, just leave a zero in the superblock's block pointer for
+	 * this group.  The IO will be retried next time.
+	 */
+	sbi->s_inode_bitmap_number[slot] = block_group;
+	sbi->s_inode_bitmap[slot] = bh;
+	if (!bh)
+		return ERR_PTR(-EIO);
+found:
+	return bh;
 }
 
 /*
@@ -183,7 +179,6 @@
 	struct buffer_head * bh2;
 	unsigned long block_group;
 	unsigned long bit;
-	int bitmap_nr;
 	struct ext2_group_desc * gdp;
 	struct ext2_super_block * es;
 
@@ -207,11 +202,9 @@
 	}
 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT2_INODES_PER_GROUP(sb);
-	bitmap_nr = load_inode_bitmap (sb, block_group);
-	if (bitmap_nr < 0)
+	bh = load_inode_bitmap (sb, block_group);
+	if (IS_ERR(bh))
 		goto error_return;
-	
-	bh = sb->u.ext2_sb.s_inode_bitmap[bitmap_nr];
 
 	is_directory = S_ISDIR(inode->i_mode);
 
@@ -256,173 +249,161 @@
  * For other inodes, search forward from the parent directory\'s block
  * group to find a free inode.
  */
-struct inode * ext2_new_inode (const struct inode * dir, int mode, int * err)
+
+static int find_cg_dir(struct super_block *sb, int parent_cg)
+{
+	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	int ngroups = sb->u.ext2_sb.s_groups_count;
+	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	struct ext2_group_desc *cg, *best_cg = NULL;
+	struct buffer_head *bh, *best_bh = NULL;
+	int i = -1, j;
+
+/* I am not yet convinced that this next bit is necessary.
+	for (i = parent_cg, j = 0; j < ngroups; j++, i = ++i % ngroups) {
+		cg = ext2_get_group_desc (sb, i, &bh);
+		if (!cg)
+			continue;
+		if ((le16_to_cpu(cg->bg_used_dirs_count) << 8) < 
+		     le16_to_cpu(cg->bg_free_inodes_count)) {
+			best_cg = cg;
+			best_bh = bh;
+			goto found;
+		}
+	}
+*/
+	for (j = 0; j < ngroups; j++) {
+		cg = ext2_get_group_desc (sb, j, &bh);
+		if (!cg || !cg->bg_free_inodes_count)
+			continue;
+		if (le16_to_cpu(cg->bg_free_inodes_count) < avefreei)
+			continue;
+		if (!best_cg || 
+		    (le16_to_cpu(cg->bg_free_blocks_count) >
+		     le16_to_cpu(best_cg->bg_free_blocks_count))) {
+			i = j;
+			best_cg = cg;
+			best_bh = bh;
+		}
+	}
+	if (!best_cg)
+		return -1;
+found:
+	best_cg->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(best_cg->bg_free_inodes_count) - 1);
+	best_cg->bg_used_dirs_count =
+		cpu_to_le16(le16_to_cpu(best_cg->bg_used_dirs_count) + 1);
+	mark_buffer_dirty(best_bh);
+	return i;
+}
+
+static int find_cg_other(struct super_block *sb, int parent_cg)
+{
+	int ngroups = sb->u.ext2_sb.s_groups_count;
+	struct ext2_group_desc *cg;
+	struct buffer_head *bh;
+	int i, j;
+
+	/*
+	 * Try to place the inode in its parent directory
+	 */
+	i = parent_cg;
+	cg = ext2_get_group_desc (sb, i, &bh);
+	if (cg && le16_to_cpu(cg->bg_free_inodes_count))
+		goto found;
+
+	/*
+	 * Use a quadratic hash to find a group with a
+	 * free inode
+	 */
+	for (j = 1; j < ngroups; j <<= 1) {
+		i += j;
+		if (i >= ngroups)
+			i -= ngroups;
+		cg = ext2_get_group_desc (sb, i, &bh);
+		if (cg && le16_to_cpu(cg->bg_free_inodes_count))
+			goto found;
+	}
+
+	/*
+	 * That failed: try linear search for a free inode
+	 */
+	i = parent_cg + 1;
+	for (j = 2; j < ngroups; j++) {
+		if (++i >= ngroups)
+			i = 0;
+		cg = ext2_get_group_desc (sb, i, &bh);
+		if (cg && le16_to_cpu(cg->bg_free_inodes_count))
+			goto found;
+	}
+
+	return -1;
+
+found:
+	cg->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(cg->bg_free_inodes_count) - 1);
+	mark_buffer_dirty(bh);
+	return i;
+}
+
+struct inode * ext2_new_inode (const struct inode * dir, int mode)
 {
 	struct super_block * sb;
 	struct buffer_head * bh;
 	struct buffer_head * bh2;
-	int i, j, avefreei;
+	int i, j;
 	struct inode * inode;
-	int bitmap_nr;
 	struct ext2_group_desc * gdp;
-	struct ext2_group_desc * tmp;
 	struct ext2_super_block * es;
+	int err;
 
 	/* Cannot create files in a deleted directory */
-	if (!dir || !dir->i_nlink) {
-		*err = -EPERM;
-		return NULL;
-	}
+	if (!dir || !dir->i_nlink)
+		return ERR_PTR(-EPERM);
 
 	sb = dir->i_sb;
 	inode = new_inode(sb);
-	if (!inode) {
-		*err = -ENOMEM;
-		return NULL;
-	}
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
 
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
 repeat:
-	gdp = NULL; i=0;
-	
-	*err = -ENOSPC;
-	if (S_ISDIR(mode)) {
-		avefreei = le32_to_cpu(es->s_free_inodes_count) /
-			sb->u.ext2_sb.s_groups_count;
-/* I am not yet convinced that this next bit is necessary.
-		i = dir->u.ext2_i.i_block_group;
-		for (j = 0; j < sb->u.ext2_sb.s_groups_count; j++) {
-			tmp = ext2_get_group_desc (sb, i, &bh2);
-			if (tmp &&
-			    (le16_to_cpu(tmp->bg_used_dirs_count) << 8) < 
-			     le16_to_cpu(tmp->bg_free_inodes_count)) {
-				gdp = tmp;
-				break;
-			}
-			else
-			i = ++i % sb->u.ext2_sb.s_groups_count;
-		}
-*/
-		if (!gdp) {
-			for (j = 0; j < sb->u.ext2_sb.s_groups_count; j++) {
-				tmp = ext2_get_group_desc (sb, j, &bh2);
-				if (tmp &&
-				    le16_to_cpu(tmp->bg_free_inodes_count) &&
-				    le16_to_cpu(tmp->bg_free_inodes_count) >= avefreei) {
-					if (!gdp || 
-					    (le16_to_cpu(tmp->bg_free_blocks_count) >
-					     le16_to_cpu(gdp->bg_free_blocks_count))) {
-						i = j;
-						gdp = tmp;
-					}
-				}
-			}
-		}
-	}
+	if (S_ISDIR(mode)) 
+		i = find_cg_dir(sb, dir->u.ext2_i.i_block_group);
 	else 
-	{
-		/*
-		 * Try to place the inode in its parent directory
-		 */
-		i = dir->u.ext2_i.i_block_group;
-		tmp = ext2_get_group_desc (sb, i, &bh2);
-		if (tmp && le16_to_cpu(tmp->bg_free_inodes_count))
-			gdp = tmp;
-		else
-		{
-			/*
-			 * Use a quadratic hash to find a group with a
-			 * free inode
-			 */
-			for (j = 1; j < sb->u.ext2_sb.s_groups_count; j <<= 1) {
-				i += j;
-				if (i >= sb->u.ext2_sb.s_groups_count)
-					i -= sb->u.ext2_sb.s_groups_count;
-				tmp = ext2_get_group_desc (sb, i, &bh2);
-				if (tmp &&
-				    le16_to_cpu(tmp->bg_free_inodes_count)) {
-					gdp = tmp;
-					break;
-				}
-			}
-		}
-		if (!gdp) {
-			/*
-			 * That failed: try linear search for a free inode
-			 */
-			i = dir->u.ext2_i.i_block_group + 1;
-			for (j = 2; j < sb->u.ext2_sb.s_groups_count; j++) {
-				if (++i >= sb->u.ext2_sb.s_groups_count)
-					i = 0;
-				tmp = ext2_get_group_desc (sb, i, &bh2);
-				if (tmp &&
-				    le16_to_cpu(tmp->bg_free_inodes_count)) {
-					gdp = tmp;
-					break;
-				}
-			}
-		}
-	}
+		i = find_cg_other(sb, dir->u.ext2_i.i_block_group);
 
-	if (!gdp) {
-		unlock_super (sb);
-		iput(inode);
-		return NULL;
-	}
-	bitmap_nr = load_inode_bitmap (sb, i);
-	if (bitmap_nr < 0) {
-		unlock_super (sb);
-		iput(inode);
-		*err = -EIO;
-		return NULL;
-	}
+	err = -ENOSPC;
+	if (i == -1)
+		goto fail;
+
+	err = -EIO;
+	bh = load_inode_bitmap (sb, i);
+	if (IS_ERR(bh))
+		goto fail2;
+
+	j = ext2_find_first_zero_bit ((unsigned long *) bh->b_data,
+					      EXT2_INODES_PER_GROUP(sb));
+	if (j >= EXT2_INODES_PER_GROUP(sb))
+		goto bad_count;
+	ext2_set_bit (j, bh->b_data);
 
-	bh = sb->u.ext2_sb.s_inode_bitmap[bitmap_nr];
-	if ((j = ext2_find_first_zero_bit ((unsigned long *) bh->b_data,
-				      EXT2_INODES_PER_GROUP(sb))) <
-	    EXT2_INODES_PER_GROUP(sb)) {
-		if (ext2_set_bit (j, bh->b_data)) {
-			ext2_error (sb, "ext2_new_inode",
-				      "bit already set for inode %d", j);
-			goto repeat;
-		}
-		mark_buffer_dirty(bh);
-		if (sb->s_flags & MS_SYNCHRONOUS) {
-			ll_rw_block (WRITE, 1, &bh);
-			wait_on_buffer (bh);
-		}
-	} else {
-		if (le16_to_cpu(gdp->bg_free_inodes_count) != 0) {
-			ext2_error (sb, "ext2_new_inode",
-				    "Free inodes count corrupted in group %d",
-				    i);
-			if (sb->s_flags & MS_RDONLY) {
-				unlock_super (sb);
-				iput (inode);
-				return NULL;
-			}
-			gdp->bg_free_inodes_count = 0;
-			mark_buffer_dirty(bh2);
-		}
-		goto repeat;
+	mark_buffer_dirty(bh);
+	if (sb->s_flags & MS_SYNCHRONOUS) {
+		ll_rw_block (WRITE, 1, &bh);
+		wait_on_buffer (bh);
 	}
+
 	j += i * EXT2_INODES_PER_GROUP(sb) + 1;
 	if (j < EXT2_FIRST_INO(sb) || j > le32_to_cpu(es->s_inodes_count)) {
 		ext2_error (sb, "ext2_new_inode",
 			    "reserved inode or inode > inodes count - "
 			    "block_group = %d,inode=%d", i, j);
-		unlock_super (sb);
-		iput (inode);
-		*err = -EIO;
-		return NULL;
+		err = -EIO;
+		goto fail2;
 	}
-	gdp->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) - 1);
-	if (S_ISDIR(mode))
-		gdp->bg_used_dirs_count =
-			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) + 1);
-	mark_buffer_dirty(bh2);
+
 	es->s_free_inodes_count =
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
 	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
@@ -464,13 +445,37 @@
 		sb->dq_op->drop(inode);
 		inode->i_nlink = 0;
 		iput(inode);
-		*err = -EDQUOT;
-		return NULL;
+		return ERR_PTR(-EDQUOT);
 	}
 	ext2_debug ("allocating inode %lu\n", inode->i_ino);
-
-	*err = 0;
 	return inode;
+
+fail2:
+	gdp = ext2_get_group_desc (sb, i, &bh2);
+	gdp->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) + 1);
+	if (S_ISDIR(mode))
+		gdp->bg_used_dirs_count =
+			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) - 1);
+	mark_buffer_dirty(bh2);
+fail:
+	unlock_super(sb);
+	iput(inode);
+	return ERR_PTR(err);
+
+bad_count:
+	ext2_error (sb, "ext2_new_inode",
+		    "Free inodes count corrupted in group %d",
+		    i);
+	/* Is it really ENOSPC? */
+	err = -ENOSPC;
+	if (sb->s_flags & MS_RDONLY)
+		goto fail;
+
+	gdp = ext2_get_group_desc (sb, i, &bh2);
+	gdp->bg_free_inodes_count = 0;
+	mark_buffer_dirty(bh2);
+	goto repeat;
 }
 
 unsigned long ext2_count_free_inodes (struct super_block * sb)
@@ -478,7 +483,6 @@
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
 	unsigned long desc_count, bitmap_count, x;
-	int bitmap_nr;
 	struct ext2_group_desc * gdp;
 	int i;
 
@@ -488,16 +492,16 @@
 	bitmap_count = 0;
 	gdp = NULL;
 	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+		struct buffer_head *bh;
 		gdp = ext2_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_inodes_count);
-		bitmap_nr = load_inode_bitmap (sb, i);
-		if (bitmap_nr < 0)
+		bh = load_inode_bitmap (sb, i);
+		if (IS_ERR(bh))
 			continue;
 
-		x = ext2_count_free (sb->u.ext2_sb.s_inode_bitmap[bitmap_nr],
-				     EXT2_INODES_PER_GROUP(sb) / 8);
+		x = ext2_count_free (bh, EXT2_INODES_PER_GROUP(sb) / 8);
 		printk ("group %d: stored = %d, counted = %lu\n",
 			i, le16_to_cpu(gdp->bg_free_inodes_count), x);
 		bitmap_count += x;
@@ -517,7 +521,6 @@
 {
 	struct ext2_super_block * es;
 	unsigned long desc_count, bitmap_count, x;
-	int bitmap_nr;
 	struct ext2_group_desc * gdp;
 	int i;
 
@@ -526,16 +529,16 @@
 	bitmap_count = 0;
 	gdp = NULL;
 	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+		struct buffer_head *bh;
 		gdp = ext2_get_group_desc (sb, i, NULL);
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_inodes_count);
-		bitmap_nr = load_inode_bitmap (sb, i);
-		if (bitmap_nr < 0)
+		bh = load_inode_bitmap (sb, i);
+		if (IS_ERR(bh))
 			continue;
 		
-		x = ext2_count_free (sb->u.ext2_sb.s_inode_bitmap[bitmap_nr],
-				     EXT2_INODES_PER_GROUP(sb) / 8);
+		x = ext2_count_free (bh, EXT2_INODES_PER_GROUP(sb) / 8);
 		if (le16_to_cpu(gdp->bg_free_inodes_count) != x)
 			ext2_error (sb, "ext2_check_inodes_bitmap",
 				    "Wrong free inodes count in group %d, "
diff -urN rc12-3/fs/ext2/namei.c linux-ext2/fs/ext2/namei.c
--- rc12-3/fs/ext2/namei.c	Thu Nov 30 13:25:58 2000
+++ linux-ext2/fs/ext2/namei.c	Thu Nov 30 13:32:42 2000
@@ -361,17 +361,14 @@
  */
 static int ext2_create (struct inode * dir, struct dentry * dentry, int mode)
 {
-	struct inode * inode;
-	int err;
-
-	inode = ext2_new_inode (dir, mode, &err);
-	if (!inode)
+	struct inode * inode = ext2_new_inode (dir, mode);
+	int err = PTR_ERR(inode);
+	if (IS_ERR(inode))
 		return err;
 
 	inode->i_op = &ext2_file_inode_operations;
 	inode->i_fop = &ext2_file_operations;
 	inode->i_mapping->a_ops = &ext2_aops;
-	inode->i_mode = mode;
 	mark_inode_dirty(inode);
 	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
 			     inode);
@@ -387,11 +384,10 @@
 
 static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
 {
-	struct inode * inode;
-	int err;
+	struct inode * inode = ext2_new_inode (dir, mode);
+	int err = PTR_ERR(inode);
 
-	inode = ext2_new_inode (dir, mode, &err);
-	if (!inode)
+	if (IS_ERR(inode))
 		return err;
 
 	inode->i_uid = current->fsuid;
@@ -421,14 +417,17 @@
 	if (dir->i_nlink >= EXT2_LINK_MAX)
 		return -EMLINK;
 
-	inode = ext2_new_inode (dir, S_IFDIR, &err);
-	if (!inode)
+	if (dir->i_mode & S_ISGID)
+		mode |= S_ISGID;
+
+	inode = ext2_new_inode (dir, S_IFDIR | mode);
+	err = PTR_ERR(inode);
+	if (IS_ERR(inode))
 		return err;
 
 	inode->i_op = &ext2_dir_inode_operations;
 	inode->i_fop = &ext2_dir_operations;
 	inode->i_size = inode->i_sb->s_blocksize;
-	inode->i_blocks = 0;	
 	dir_block = ext2_bread (inode, 0, 1, &err);
 	if (!dir_block) {
 		inode->i_nlink--; /* is this nlink == 0? */
@@ -451,9 +450,6 @@
 	inode->i_nlink = 2;
 	mark_buffer_dirty_inode(dir_block, dir);
 	brelse (dir_block);
-	inode->i_mode = S_IFDIR | mode;
-	if (dir->i_mode & S_ISGID)
-		inode->i_mode |= S_ISGID;
 	mark_inode_dirty(inode);
 	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
 			     inode);
@@ -628,10 +624,10 @@
 	if (l > dir->i_sb->s_blocksize)
 		return -ENAMETOOLONG;
 
-	if (!(inode = ext2_new_inode (dir, S_IFLNK, &err)))
+	inode = ext2_new_inode (dir, S_IFLNK|S_IRWXUGO);
+	err = PTR_ERR(inode);
+	if (IS_ERR(inode))
 		return err;
-
-	inode->i_mode = S_IFLNK | S_IRWXUGO;
 
 	if (l > sizeof (inode->u.ext2_i.i_data)) {
 		inode->i_op = &page_symlink_inode_operations;
diff -urN rc12-3/include/linux/ext2_fs.h linux-ext2/include/linux/ext2_fs.h
--- rc12-3/include/linux/ext2_fs.h	Thu Nov 30 13:25:59 2000
+++ linux-ext2/include/linux/ext2_fs.h	Thu Nov 30 15:43:46 2000
@@ -552,7 +552,7 @@
 extern int ext2_fsync_inode (struct inode *, int);
 
 /* ialloc.c */
-extern struct inode * ext2_new_inode (const struct inode *, int, int *);
+extern struct inode * ext2_new_inode (const struct inode *, int);
 extern void ext2_free_inode (struct inode *);
 extern unsigned long ext2_count_free_inodes (struct super_block *);
 extern void ext2_check_inodes_bitmap (struct super_block *);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
