Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278789AbRKHXJE>; Thu, 8 Nov 2001 18:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278755AbRKHXI6>; Thu, 8 Nov 2001 18:08:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:14318 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278701AbRKHXIi>;
	Thu, 8 Nov 2001 18:08:38 -0500
Date: Thu, 8 Nov 2001 18:08:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Andrew Morton <akpm@zip.com.au>, ext2-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
In-Reply-To: <20011108154311.E9043@lynx.no>
Message-ID: <Pine.GSO.4.21.0111081802250.8052-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Nov 2001, Andreas Dilger wrote:

> On Nov 08, 2001  17:16 -0500, Alexander Viro wrote:
> > +		get_random_bytes(&group, sizeof(group));

Grrr....

+		parent_cg = group % ngroups;

/me wonders how the heck had it disappeared...

Corrected patch follows:

diff -urN S14/fs/ext2/ialloc.c S14-ext2/fs/ext2/ialloc.c
--- S14/fs/ext2/ialloc.c	Tue Oct  9 21:47:26 2001
+++ S14-ext2/fs/ext2/ialloc.c	Thu Nov  8 18:05:00 2001
@@ -17,7 +17,7 @@
 #include <linux/ext2_fs.h>
 #include <linux/locks.h>
 #include <linux/quotaops.h>
-
+#include <linux/random.h>
 
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
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
@@ -83,79 +72,62 @@
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
 	}
 
-	for (i = 0; i < sb->u.ext2_sb.s_loaded_inode_bitmaps &&
-		    sb->u.ext2_sb.s_inode_bitmap_number[i] != block_group;
+	bh = NULL;
+	for (i = 0; i < sbi->s_loaded_inode_bitmaps &&
+		    sbi->s_inode_bitmap_number[i] != block_group;
 	     i++)
 		;
-	if (i < sb->u.ext2_sb.s_loaded_inode_bitmaps &&
-  	    sb->u.ext2_sb.s_inode_bitmap_number[i] == block_group) {
-		inode_bitmap_number = sb->u.ext2_sb.s_inode_bitmap_number[i];
-		inode_bitmap = sb->u.ext2_sb.s_inode_bitmap[i];
-		for (j = i; j > 0; j--) {
-			sb->u.ext2_sb.s_inode_bitmap_number[j] =
-				sb->u.ext2_sb.s_inode_bitmap_number[j - 1];
-			sb->u.ext2_sb.s_inode_bitmap[j] =
-				sb->u.ext2_sb.s_inode_bitmap[j - 1];
-		}
-		sb->u.ext2_sb.s_inode_bitmap_number[0] = inode_bitmap_number;
-		sb->u.ext2_sb.s_inode_bitmap[0] = inode_bitmap;
-
-		/*
-		 * There's still one special case here --- if inode_bitmap == 0
-		 * then our last attempt to read the bitmap failed and we have
-		 * just ended up caching that failure.  Try again to read it.
-		 */
-		if (!inode_bitmap)
-			retval = read_inode_bitmap (sb, block_group, 0);
-		
-	} else {
-		if (sb->u.ext2_sb.s_loaded_inode_bitmaps < EXT2_MAX_GROUP_LOADED)
-			sb->u.ext2_sb.s_loaded_inode_bitmaps++;
-		else
-			brelse (sb->u.ext2_sb.s_inode_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
-		for (j = sb->u.ext2_sb.s_loaded_inode_bitmaps - 1; j > 0; j--) {
-			sb->u.ext2_sb.s_inode_bitmap_number[j] =
-				sb->u.ext2_sb.s_inode_bitmap_number[j - 1];
-			sb->u.ext2_sb.s_inode_bitmap[j] =
-				sb->u.ext2_sb.s_inode_bitmap[j - 1];
-		}
-		retval = read_inode_bitmap (sb, block_group, 0);
-	}
-	return retval;
+	if (i < sbi->s_loaded_inode_bitmaps)
+		bh = sbi->s_inode_bitmap[i];
+	else if (sbi->s_loaded_inode_bitmaps < EXT2_MAX_GROUP_LOADED)
+		sbi->s_loaded_inode_bitmaps++;
+	else
+		brelse (sbi->s_inode_bitmap[--i]);
+
+	while (i--) {
+		sbi->s_inode_bitmap_number[i+1] = sbi->s_inode_bitmap_number[i];
+		sbi->s_inode_bitmap[i+1] = sbi->s_inode_bitmap[i];
+	}
+
+read_it:
+	if (!bh)
+		bh = read_inode_bitmap (sb, block_group);
+	sbi->s_inode_bitmap_number[slot] = block_group;
+	sbi->s_inode_bitmap[slot] = bh;
+	if (!bh)
+		return ERR_PTR(-EIO);
+found:
+	return bh;
 }
 
 /*
@@ -183,7 +155,6 @@
 	struct buffer_head * bh2;
 	unsigned long block_group;
 	unsigned long bit;
-	int bitmap_nr;
 	struct ext2_group_desc * gdp;
 	struct ext2_super_block * es;
 
@@ -215,12 +186,10 @@
 	}
 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT2_INODES_PER_GROUP(sb);
-	bitmap_nr = load_inode_bitmap (sb, block_group);
-	if (bitmap_nr < 0)
+	bh = load_inode_bitmap (sb, block_group);
+	if (IS_ERR(bh))
 		goto error_return;
 
-	bh = sb->u.ext2_sb.s_inode_bitmap[bitmap_nr];
-
 	/* Ok, now we can actually update the inode bitmaps.. */
 	if (!ext2_clear_bit (bit, bh->b_data))
 		ext2_error (sb, "ext2_free_inode",
@@ -230,9 +199,11 @@
 		if (gdp) {
 			gdp->bg_free_inodes_count =
 				cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) + 1);
-			if (is_directory)
+			if (is_directory) {
 				gdp->bg_used_dirs_count =
 					cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) - 1);
+				sb->u.ext2_sb.s_dir_count--;
+			}
 		}
 		mark_buffer_dirty(bh2);
 		es->s_free_inodes_count =
@@ -259,23 +230,230 @@
  * For other inodes, search forward from the parent directory\'s block
  * group to find a free inode.
  */
+
+static int find_cg_dir(struct super_block *sb, const struct inode *parent)
+{
+	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	int ngroups = sb->u.ext2_sb.s_groups_count;
+	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	struct ext2_group_desc *cg, *best_cg = NULL;
+	struct buffer_head *bh, *best_bh = NULL;
+	int i = -1, j;
+
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
+
+	best_cg->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(best_cg->bg_free_inodes_count) - 1);
+	best_cg->bg_used_dirs_count =
+		cpu_to_le16(le16_to_cpu(best_cg->bg_used_dirs_count) + 1);
+	sb->u.ext2_sb.s_dir_count++;
+	mark_buffer_dirty(best_bh);
+	return i;
+}
+
+/*
+ * Orlov's allocator for directories.
+ *
+ * We always try to spread first-level directories:
+ *	If there are directories with both free inodes and free blocks counts
+ *	not worse than average we return one with smallest directory count.
+ *	Otherwise we simply return a random group.
+ *
+ * For the rest rules look so:
+ *
+ * It's OK to put directory into a group unless
+ *	it has too many directories already (max_dirs) or
+ *	it has too few free inodes left (min_inodes) or
+ *	it has too few free blocks left (min_blocks) or
+ *	it's already running too large debt (max_debt).
+ * Parent's group is prefered, if it doesn't satisfy these
+ * conditions we search cyclically through the rest.  If none
+ * of the groups look good we just look for a group with more
+ * free inodes than average (starting at parent's group).
+ *
+ * Debt is incremented each time we allocate a directory and decremented
+ * when we allocate an inode, within 0--255.
+ */
+
+#define INODE_COST 64
+#define BLOCK_COST 256
+
+static int find_cg_dir_orlov(struct super_block *sb, const struct inode *parent)
+{
+	int parent_cg = parent->u.ext2_i.i_block_group;
+	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	int ngroups = sb->u.ext2_sb.s_groups_count;
+	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
+	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	int avefreeb = le32_to_cpu(es->s_free_blocks_count) / ngroups;
+	int blocks_per_dir;
+	int ndirs = sb->u.ext2_sb.s_dir_count;
+	int max_debt, max_dirs, min_blocks, min_inodes;
+	int group = -1, i;
+	struct ext2_group_desc *cg;
+	struct buffer_head *bh;
+
+	if (parent == sb->s_root->d_inode) {
+		struct ext2_group_desc *best_cg = NULL;
+		struct buffer_head *best_bh = NULL;
+		int best_ndir = inodes_per_group;
+		int best_group = -1;
+
+		for (group = 0; group < ngroups; group++) {
+			cg = ext2_get_group_desc (sb, group, &bh);
+			if (!cg || !cg->bg_free_inodes_count)
+				continue;
+			if (le16_to_cpu(cg->bg_used_dirs_count) >= best_ndir)
+				continue;
+			if (le16_to_cpu(cg->bg_free_inodes_count) < avefreei)
+				continue;
+			if (le16_to_cpu(cg->bg_free_blocks_count) < avefreeb)
+				continue;
+			best_group = group;
+			best_ndir = le16_to_cpu(cg->bg_used_dirs_count);
+			best_cg = cg;
+			best_bh = bh;
+		}
+		if (best_group >= 0) {
+			cg = best_cg;
+			bh = best_bh;
+			group = best_group;
+			goto found;
+		}
+		get_random_bytes(&group, sizeof(group));
+		parent_cg = group % ngroups;
+		goto fallback;
+	}
+
+	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) -
+			  le32_to_cpu(es->s_free_blocks_count)) / ndirs;
+
+	max_dirs = ndirs / ngroups + inodes_per_group / 16;
+	min_inodes = avefreei - inodes_per_group / 4;
+	min_blocks = avefreeb - EXT2_BLOCKS_PER_GROUP(sb) / 4;
+
+	max_debt = EXT2_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, BLOCK_COST);
+	if (max_debt * INODE_COST > inodes_per_group)
+		max_debt = inodes_per_group / INODE_COST;
+	if (max_debt > 255)
+		max_debt = 255;
+	if (max_debt == 0)
+		max_debt = 1;
+
+	for (i = 0; i < ngroups; i++) {
+		group = (parent_cg + i) % ngroups;
+		cg = ext2_get_group_desc (sb, group, &bh);
+		if (!cg || !cg->bg_free_inodes_count)
+			continue;
+		if (sb->u.ext2_sb.debts[group] >= max_debt)
+			continue;
+		if (le16_to_cpu(cg->bg_used_dirs_count) >= max_dirs)
+			continue;
+		if (le16_to_cpu(cg->bg_free_inodes_count) < min_inodes)
+			continue;
+		if (le16_to_cpu(cg->bg_free_blocks_count) < min_blocks)
+			continue;
+		goto found;
+	}
+
+fallback:
+	for (i = 0; i < ngroups; i++) {
+		group = (parent_cg + i) % ngroups;
+		cg = ext2_get_group_desc (sb, group, &bh);
+		if (!cg || !cg->bg_free_inodes_count)
+			continue;
+		if (le16_to_cpu(cg->bg_free_inodes_count) >= avefreei)
+			goto found;
+	}
+
+	return -1;
+
+found:
+	cg->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(cg->bg_free_inodes_count) - 1);
+	cg->bg_used_dirs_count =
+		cpu_to_le16(le16_to_cpu(cg->bg_used_dirs_count) + 1);
+	sb->u.ext2_sb.s_dir_count++;
+	mark_buffer_dirty(bh);
+	return group;
+}
+
+static int find_cg_other(struct super_block *sb, const struct inode *parent)
+{
+	int parent_cg = parent->u.ext2_i.i_block_group;
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
 struct inode * ext2_new_inode (const struct inode * dir, int mode)
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
 	int err;
 
-	/* Cannot create files in a deleted directory */
-	if (!dir || !dir->i_nlink)
-		return ERR_PTR(-EPERM);
-
 	sb = dir->i_sb;
 	inode = new_inode(sb);
 	if (!inode)
@@ -284,140 +462,52 @@
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
 repeat:
-	gdp = NULL; i=0;
-	
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
+		i = find_cg_dir_orlov(sb, dir);
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
+		i = find_cg_other(sb, dir);
 
 	err = -ENOSPC;
-	if (!gdp)
+	if (i == -1)
 		goto fail;
 
 	err = -EIO;
-	bitmap_nr = load_inode_bitmap (sb, i);
-	if (bitmap_nr < 0)
-		goto fail;
+	bh = load_inode_bitmap (sb, i);
+	if (IS_ERR(bh))
+		goto fail2;
+
+	j = ext2_find_first_zero_bit ((unsigned long *) bh->b_data,
+				      EXT2_INODES_PER_GROUP(sb));
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
-			/* Is it really ENOSPC? */
-			err = -ENOSPC;
-			if (sb->s_flags & MS_RDONLY)
-				goto fail;
-
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
 		err = -EIO;
-		goto fail;
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
+
+	if (S_ISDIR(mode)) {
+		if (sb->u.ext2_sb.debts[i] < 255)
+			sb->u.ext2_sb.debts[i]++;
+	} else {
+		if (sb->u.ext2_sb.debts[i])
+			sb->u.ext2_sb.debts[i]--;
+	}
+
 	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
 	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
@@ -438,14 +528,7 @@
 	inode->u.ext2_i.i_new_inode = 1;
 	inode->u.ext2_i.i_flags = dir->u.ext2_i.i_flags;
 	if (S_ISLNK(mode))
-		inode->u.ext2_i.i_flags &= ~(EXT2_IMMUTABLE_FL | EXT2_APPEND_FL);
-	inode->u.ext2_i.i_faddr = 0;
-	inode->u.ext2_i.i_frag_no = 0;
-	inode->u.ext2_i.i_frag_size = 0;
-	inode->u.ext2_i.i_file_acl = 0;
-	inode->u.ext2_i.i_dir_acl = 0;
-	inode->u.ext2_i.i_dtime = 0;
-	inode->u.ext2_i.i_prealloc_count = 0;
+		inode->u.ext2_i.i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
 	inode->u.ext2_i.i_block_group = i;
 	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
@@ -464,38 +547,59 @@
 	ext2_debug ("allocating inode %lu\n", inode->i_ino);
 	return inode;
 
+fail2:
+	gdp = ext2_get_group_desc (sb, i, &bh2);
+	gdp->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) + 1);
+	if (S_ISDIR(mode)) {
+		gdp->bg_used_dirs_count =
+			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) - 1);
+		sb->u.ext2_sb.s_dir_count--;
+	}
+	mark_buffer_dirty(bh2);
 fail:
 	unlock_super(sb);
 	make_bad_inode(inode);
 	iput(inode);
 	return ERR_PTR(err);
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
 {
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
-	unsigned long desc_count, bitmap_count, x;
-	int bitmap_nr;
-	struct ext2_group_desc * gdp;
+	unsigned long desc_count = 0, bitmap_count = 0;
 	int i;
 
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
-	desc_count = 0;
-	bitmap_count = 0;
-	gdp = NULL;
 	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
-		gdp = ext2_get_group_desc (sb, i, NULL);
+		struct ext2_group_desc *gdp = ext2_get_group_desc (sb, i, NULL);
+		struct buffer_head *bh;
+		unsigned x;
+
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
@@ -509,31 +613,42 @@
 #endif
 }
 
+/* Called at mount-time, super-block is locked */
+unsigned long ext2_count_dirs (struct super_block * sb)
+{
+	unsigned long count = 0;
+	int i;
+
+	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+		struct ext2_group_desc *gdp = ext2_get_group_desc (sb, i, NULL);
+		if (!gdp)
+			continue;
+		count += le16_to_cpu(gdp->bg_used_dirs_count);
+	}
+	return count;
+}
+
 #ifdef CONFIG_EXT2_CHECK
 /* Called at mount-time, super-block is locked */
 void ext2_check_inodes_bitmap (struct super_block * sb)
 {
-	struct ext2_super_block * es;
-	unsigned long desc_count, bitmap_count, x;
-	int bitmap_nr;
-	struct ext2_group_desc * gdp;
+	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	unsigned long desc_count = 0, bitmap_count = 0;
 	int i;
 
-	es = sb->u.ext2_sb.s_es;
-	desc_count = 0;
-	bitmap_count = 0;
-	gdp = NULL;
 	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
-		gdp = ext2_get_group_desc (sb, i, NULL);
+		struct ext2_group_desc *gdp = ext2_get_group_desc (sb, i, NULL);
+		struct buffer_head *bh;
+		unsigned x;
+
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
@@ -545,7 +660,7 @@
 		ext2_error (sb, "ext2_check_inodes_bitmap",
 			    "Wrong free inodes count in super block, "
 			    "stored = %lu, counted = %lu",
-			    (unsigned long) le32_to_cpu(es->s_free_inodes_count),
+			    (unsigned long)le32_to_cpu(es->s_free_inodes_count),
 			    bitmap_count);
 }
 #endif
diff -urN S14/fs/ext2/super.c S14-ext2/fs/ext2/super.c
--- S14/fs/ext2/super.c	Tue Oct  9 21:47:26 2001
+++ S14-ext2/fs/ext2/super.c	Thu Nov  8 15:29:07 2001
@@ -605,6 +605,12 @@
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
+	sb->u.ext2_sb.debts = kmalloc(sb->u.ext2_sb.s_groups_count, GFP_KERNEL);
+	if (!sb->u.ext2_sb.debts) {
+		printk ("EXT2-fs: not enough memory\n");
+		goto failed_mount;
+	}
+	memset(sb->u.ext2_sb.debts, 0, sb->u.ext2_sb.s_groups_count);
 	for (i = 0; i < db_count; i++) {
 		sb->u.ext2_sb.s_group_desc[i] = bread (dev, logic_sb_block + i + 1,
 						       sb->s_blocksize);
@@ -621,6 +627,7 @@
 		db_count = i;
 		goto failed_mount2;
 	}
+	sb->u.ext2_sb.s_dir_count = ext2_count_dirs(sb);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++) {
 		sb->u.ext2_sb.s_inode_bitmap_number[i] = 0;
 		sb->u.ext2_sb.s_inode_bitmap[i] = NULL;
diff -urN S14/include/linux/ext2_fs.h S14-ext2/include/linux/ext2_fs.h
--- S14/include/linux/ext2_fs.h	Thu Nov  8 16:33:29 2001
+++ S14-ext2/include/linux/ext2_fs.h	Thu Nov  8 16:20:16 2001
@@ -578,6 +578,7 @@
 extern unsigned long ext2_count_free_inodes (struct super_block *);
 extern void ext2_check_inodes_bitmap (struct super_block *);
 extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
+extern unsigned long ext2_count_dirs (struct super_block *);
 
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
diff -urN S14/include/linux/ext2_fs_sb.h S14-ext2/include/linux/ext2_fs_sb.h
--- S14/include/linux/ext2_fs_sb.h	Fri Feb 16 21:29:52 2001
+++ S14-ext2/include/linux/ext2_fs_sb.h	Thu Nov  8 15:28:34 2001
@@ -56,6 +56,8 @@
 	int s_desc_per_block_bits;
 	int s_inode_size;
 	int s_first_ino;
+	unsigned long s_dir_count;
+	u8 *debts;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */

