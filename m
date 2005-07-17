Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVGQRmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVGQRmS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 13:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVGQRmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 13:42:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22410 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261339AbVGQRlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 13:41:50 -0400
Subject: [RFC] [PATCH 1/4]Multiple block allocation for ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Cc: Badari Pulavarty <pbadari@us.ibm.com>, suparna@in.ibm.com, tytso@mit.edu
In-Reply-To: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Sun, 17 Jul 2005 10:40:23 -0700
Message-Id: <1121622023.4609.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch support multiple block allocation for ext3. Current
ext3 allocates one block at a time, not efficient for large sequential
write IO.

This patch implements a simply multiple block allocation with current
ext3.  The basic idea is allocating the 1st block in the existing way,
and attempting to allocate the next adjacent blocks on a  best effort
basis. If contiguous allocation is blocked by an already allocated
block, the current number of free blocks are allocated and no futhur
search is tried.

This implementation makes uses of block reservation. With the knowledge
of how many blocks to allocate, the reservation window size is being
enlargedaccordin before block allocation to increase the chance to get
contiguous blocks.

Previous post of this patch with more description could be found here:
http://marc.theaimsgroup.com/?l=ext2-devel&m=111471578328685&w=2 




---

 linux-2.6.12-ming/fs/ext3/balloc.c        |  121 +++++++--
 linux-2.6.12-ming/fs/ext3/inode.c         |  380 ++++++++++++++++++++++++++++--
 linux-2.6.12-ming/fs/ext3/xattr.c         |    3 
 linux-2.6.12-ming/include/linux/ext3_fs.h |    2 
 4 files changed, 458 insertions(+), 48 deletions(-)

diff -puN fs/ext3/balloc.c~ext3-get-blocks fs/ext3/balloc.c
--- linux-2.6.12/fs/ext3/balloc.c~ext3-get-blocks	2005-07-14 21:55:55.110385896 -0700
+++ linux-2.6.12-ming/fs/ext3/balloc.c	2005-07-14 22:40:32.265396472 -0700
@@ -20,6 +20,7 @@
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
 
+#define		NBS_DEBUG	0
 /*
  * balloc.c contains the blocks allocation and deallocation routines
  */
@@ -652,9 +653,11 @@ claim_block(spinlock_t *lock, int block,
  */
 static int
 ext3_try_to_allocate(struct super_block *sb, handle_t *handle, int group,
-	struct buffer_head *bitmap_bh, int goal, struct ext3_reserve_window *my_rsv)
+		struct buffer_head *bitmap_bh, int goal, unsigned long *count,
+		struct ext3_reserve_window *my_rsv)
 {
 	int group_first_block, start, end;
+	unsigned long num = 0;
 
 	/* we do allocation within the reservation window if we have a window */
 	if (my_rsv) {
@@ -712,8 +715,22 @@ repeat:
 			goto fail_access;
 		goto repeat;
 	}
-	return goal;
+	num++;
+	goal++;
+	if (NBS_DEBUG)
+		printk("ext3_new_block: first block allocated:block %d,num %d\n", goal, num);
+	while (num < *count && goal < end
+		&& ext3_test_allocatable(goal, bitmap_bh)
+		&& claim_block(sb_bgl_lock(EXT3_SB(sb), group), goal, bitmap_bh)) {
+		num++;
+		goal++;
+	}
+	*count = num;
+	if (NBS_DEBUG)
+		printk("ext3_new_block: additional block allocated:block %d,num %d,goal-num %d\n", goal, num, goal-num);
+	return goal - num;
 fail_access:
+	*count = num;
 	return -1;
 }
 
@@ -998,6 +1015,28 @@ retry:
 	goto retry;
 }
 
+static void try_to_extend_reservation(struct ext3_reserve_window_node *my_rsv,
+			struct super_block *sb, int size)
+{
+	struct ext3_reserve_window_node *next_rsv;
+	struct rb_node *next;
+	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
+
+	spin_lock(rsv_lock);
+	next = rb_next(&my_rsv->rsv_node);
+
+	if (!next)
+		my_rsv->rsv_end += size;
+	else {
+		next_rsv = list_entry(next, struct ext3_reserve_window_node, rsv_node);
+
+		if ((next_rsv->rsv_start - my_rsv->rsv_end) > size)
+			my_rsv->rsv_end += size;
+		else
+			my_rsv->rsv_end = next_rsv->rsv_start -1 ;
+	}
+	spin_unlock(rsv_lock);
+}
 /*
  * This is the main function used to allocate a new block and its reservation
  * window.
@@ -1023,11 +1062,12 @@ static int
 ext3_try_to_allocate_with_rsv(struct super_block *sb, handle_t *handle,
 			unsigned int group, struct buffer_head *bitmap_bh,
 			int goal, struct ext3_reserve_window_node * my_rsv,
-			int *errp)
+			unsigned long *count, int *errp)
 {
 	unsigned long group_first_block;
 	int ret = 0;
 	int fatal;
+	unsigned long num = *count;
 
 	*errp = 0;
 
@@ -1050,7 +1090,8 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * or last attempt to allocate a block with reservation turned on failed
 	 */
 	if (my_rsv == NULL ) {
-		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
+		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
+					count, NULL);
 		goto out;
 	}
 	/*
@@ -1080,6 +1121,10 @@ ext3_try_to_allocate_with_rsv(struct sup
 	while (1) {
 		if (rsv_is_empty(&my_rsv->rsv_window) || (ret < 0) ||
 			!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb)) {
+			if (my_rsv->rsv_goal_size < *count)
+                               my_rsv->rsv_goal_size = *count;
+
+
 			ret = alloc_new_reservation(my_rsv, goal, sb,
 							group, bitmap_bh);
 			if (ret < 0)
@@ -1088,15 +1133,21 @@ ext3_try_to_allocate_with_rsv(struct sup
 			if (!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb))
 				goal = -1;
 		}
+		else {
+			if (goal > 0 && (my_rsv->rsv_end - goal + 1) < *count)
+				try_to_extend_reservation(my_rsv, sb,
+					*count-my_rsv->rsv_end+goal-1);
+		}
 		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
 		    || (my_rsv->rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
-					   &my_rsv->rsv_window);
+					   &num, &my_rsv->rsv_window);
 		if (ret >= 0) {
-			my_rsv->rsv_alloc_hit++;
+			my_rsv->rsv_alloc_hit += num;
 			break;				/* succeed */
 		}
+		num = *count;
 	}
 out:
 	if (ret >= 0) {
@@ -1153,8 +1204,8 @@ int ext3_should_retry_alloc(struct super
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext3_new_block(handle_t *handle, struct inode *inode,
-			unsigned long goal, int *errp)
+int ext3_new_blocks(handle_t *handle, struct inode *inode,
+			unsigned long goal, unsigned long* count, int *errp)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
@@ -1177,7 +1228,8 @@ int ext3_new_block(handle_t *handle, str
 	static int goal_hits, goal_attempts;
 #endif
 	unsigned long ngroups;
-
+	unsigned long num = *count;
+	int i;
 	*errp = -ENOSPC;
 	sb = inode->i_sb;
 	if (!sb) {
@@ -1188,7 +1240,7 @@ int ext3_new_block(handle_t *handle, str
 	/*
 	 * Check quota for allocation of this block.
 	 */
-	if (DQUOT_ALLOC_BLOCK(inode, 1)) {
+	if (DQUOT_ALLOC_BLOCK(inode, num)) {
 		*errp = -EDQUOT;
 		return 0;
 	}
@@ -1243,7 +1295,7 @@ retry:
 		if (!bitmap_bh)
 			goto io_error;
 		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, ret_block, my_rsv, &fatal);
+					bitmap_bh, ret_block,  my_rsv, &num, &fatal);
 		if (fatal)
 			goto out;
 		if (ret_block >= 0)
@@ -1280,7 +1332,7 @@ retry:
 		if (!bitmap_bh)
 			goto io_error;
 		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, -1, my_rsv, &fatal);
+					bitmap_bh, -1, my_rsv, &num, &fatal);
 		if (fatal)
 			goto out;
 		if (ret_block >= 0) 
@@ -1315,14 +1367,17 @@ allocated:
 	target_block = ret_block + group_no * EXT3_BLOCKS_PER_GROUP(sb)
 				+ le32_to_cpu(es->s_first_data_block);
 
-	if (target_block == le32_to_cpu(gdp->bg_block_bitmap) ||
-	    target_block == le32_to_cpu(gdp->bg_inode_bitmap) ||
-	    in_range(target_block, le32_to_cpu(gdp->bg_inode_table),
-		      EXT3_SB(sb)->s_itb_per_group))
-		ext3_error(sb, "ext3_new_block",
-			    "Allocating block in system zone - "
-			    "block = %u", target_block);
-
+	for (i = 0; i < num; i++, target_block++) {
+		if (target_block == le32_to_cpu(gdp->bg_block_bitmap) ||
+		    target_block == le32_to_cpu(gdp->bg_inode_bitmap) ||
+		    in_range(target_block, le32_to_cpu(gdp->bg_inode_table),
+			      EXT3_SB(sb)->s_itb_per_group)) {
+			ext3_error(sb, "ext3_new_block",
+				    "Allocating block in system zone - "
+				    "block = %u", target_block);
+			goto out;
+		}
+	}
 	performed_allocation = 1;
 
 #ifdef CONFIG_JBD_DEBUG
@@ -1340,10 +1395,12 @@ allocated:
 	jbd_lock_bh_state(bitmap_bh);
 	spin_lock(sb_bgl_lock(sbi, group_no));
 	if (buffer_jbd(bitmap_bh) && bh2jh(bitmap_bh)->b_committed_data) {
-		if (ext3_test_bit(ret_block,
-				bh2jh(bitmap_bh)->b_committed_data)) {
-			printk("%s: block was unexpectedly set in "
-				"b_committed_data\n", __FUNCTION__);
+		for (i = 0; i < num ; i++) {
+			if (ext3_test_bit(ret_block++,
+					bh2jh(bitmap_bh)->b_committed_data)) {
+				printk("%s: block was unexpectedly set in "
+					"b_committed_data\n", __FUNCTION__);
+			}
 		}
 	}
 	ext3_debug("found bit %d\n", ret_block);
@@ -1352,12 +1409,12 @@ allocated:
 #endif
 
 	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */
-	ret_block = target_block;
+	ret_block = target_block - num;
 
-	if (ret_block >= le32_to_cpu(es->s_blocks_count)) {
+	if (target_block - 1>= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error(sb, "ext3_new_block",
-			    "block(%d) >= blocks count(%d) - "
-			    "block_group = %d, es == %p ", ret_block,
+			    "block(%d) >= fs blocks count(%d) - "
+			    "block_group = %d, es == %p ", target_block - 1,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
 	}
@@ -1372,9 +1429,9 @@ allocated:
 
 	spin_lock(sb_bgl_lock(sbi, group_no));
 	gdp->bg_free_blocks_count =
-			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
+			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count)-num);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -1);
+	percpu_counter_mod(&sbi->s_freeblocks_counter, -num);
 
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
@@ -1386,6 +1443,8 @@ allocated:
 		goto out;
 
 	*errp = 0;
+	DQUOT_FREE_BLOCK(inode, *count-num);
+	*count = num;
 	brelse(bitmap_bh);
 	return ret_block;
 
@@ -1400,7 +1459,7 @@ out:
 	 * Undo the block allocation
 	 */
 	if (!performed_allocation)
-		DQUOT_FREE_BLOCK(inode, 1);
+		DQUOT_FREE_BLOCK(inode, *count);
 	brelse(bitmap_bh);
 	return 0;
 }
diff -puN fs/ext3/inode.c~ext3-get-blocks fs/ext3/inode.c
--- linux-2.6.12/fs/ext3/inode.c~ext3-get-blocks	2005-07-14 21:55:55.114385288 -0700
+++ linux-2.6.12-ming/fs/ext3/inode.c	2005-07-14 22:42:26.225071968 -0700
@@ -237,12 +237,12 @@ static int ext3_alloc_block (handle_t *h
 			struct inode * inode, unsigned long goal, int *err)
 {
 	unsigned long result;
+	unsigned long count = 1;
 
-	result = ext3_new_block(handle, inode, goal, err);
+	result = ext3_new_blocks(handle, inode, goal, &count,  err);
 	return result;
 }
 
-
 typedef struct {
 	__le32	*p;
 	__le32	key;
@@ -328,7 +328,7 @@ static int ext3_block_to_path(struct ino
 		ext3_warning (inode->i_sb, "ext3_block_to_path", "block > big");
 	}
 	if (boundary)
-		*boundary = (i_block & (ptrs - 1)) == (final - 1);
+		*boundary = final - 1 - (i_block & (ptrs - 1));
 	return n;
 }
 
@@ -375,8 +375,10 @@ static Indirect *ext3_get_branch(struct 
 		goto no_block;
 	while (--depth) {
 		bh = sb_bread(sb, le32_to_cpu(p->key));
-		if (!bh)
+		if (!bh) {
+			printk("ext3_get-Branch failure: key is %d, depth is %d\n",p->key, depth);
 			goto failure;
+		}
 		/* Reader: pointers */
 		if (!verify_chain(chain, p))
 			goto changed;
@@ -429,11 +431,11 @@ static unsigned long ext3_find_near(stru
 	/* Try to find previous block */
 	for (p = ind->p - 1; p >= start; p--)
 		if (*p)
-			return le32_to_cpu(*p);
+			return le32_to_cpu(*p + 1);
 
 	/* No such thing, so let's try location of indirect block */
 	if (ind->bh)
-		return ind->bh->b_blocknr;
+		return ind->bh->b_blocknr + 1;
 
 	/*
 	 * It is going to be refered from inode itself? OK, just put it into
@@ -526,7 +528,7 @@ static int ext3_alloc_branch(handle_t *h
 			/*
 			 * Get buffer_head for parent block, zero it out
 			 * and set the pointer to new one, then send
-			 * parent to disk.  
+			 * parent to disk.
 			 */
 			bh = sb_getblk(inode->i_sb, parent);
 			branch[n].bh = bh;
@@ -566,6 +568,196 @@ static int ext3_alloc_branch(handle_t *h
 		ext3_free_blocks(handle, inode, le32_to_cpu(branch[i].key), 1);
 	return err;
 }
+#define GBS_DEBUG	0
+#define GBS_DEBUG1	0
+#define GBS_DEBUG2	0
+static int ext3_alloc_splice_branch(handle_t *handle, struct inode *inode,
+		     unsigned long goal, unsigned long* maxblocks,
+		     int *offsets, Indirect *branch, unsigned int minblocks)
+{
+	int blocksize = inode->i_sb->s_blocksize;
+	int err = 0;
+	int i, n = 0;
+	unsigned long required, target, count;
+	int meta_num, data_num;
+	unsigned long first_data_block = 0;
+	unsigned long current_block = 0;
+	struct buffer_head *bh;
+	unsigned long long new_meta_blocks[3];
+
+	/*
+	 * We must allocating required number metadata blocks
+	 * for the first data block if necessary. Thus the
+	 * minimum number of blocks needed(required) = the
+	 * number of needed metablocks(minblocks) + 1 (the first data
+	 * block).
+	 *
+	 * The multiple allocation of the rest data blocks are targeted
+	 * but not required.
+	 *
+	 */
+	target = *maxblocks;
+	required = minblocks + 1;
+	meta_num = 0; i = 0; data_num = 0; count = 0;
+
+	if (GBS_DEBUG)
+		printk("Come to mballoc: minblocks %d, maxblocks %d \n", minblocks, *maxblocks);
+
+	while (required > 0) {
+		i = 0;
+		count = target;
+		/* allocating blocks for metadat blocks and data blocks */
+		current_block = ext3_new_blocks(handle, inode, goal, &count, &err);
+		if (err)
+			goto failed;
+
+		/*
+		 * if need allocating blocks for metedata blocks
+		 * (indirect/double/tripl blocks)
+		 * save the allocated new metadata block numbers for later
+		 * branch update.
+		 */
+		if (required > 1)
+			for (i = 0; meta_num < minblocks && i < count; i++) {
+				new_meta_blocks[meta_num++] = current_block++;
+				if (GBS_DEBUG)
+					printk(" meta_num = %d, minblocks :%d\n", meta_num, minblocks);
+			}
+		/* if allocated blocks is less than the minimum # of blocks */
+		if (count < required) {
+			required -= count;
+			target -= count;
+		}
+		else {
+			if (GBS_DEBUG)
+				printk("count: %d, i:%d, required:%d\n", count, i, required);
+			/* done with allocation */
+			data_num = count - i;
+			first_data_block = current_block;
+			if (GBS_DEBUG) {
+				printk("ext3 mballoc allocation done. metablocks:%d,"
+				"datablocks %d, goal metablocks:%d, goal"
+				"datablocks:%d\n", meta_num, data_num, minblocks,
+				*maxblocks - minblocks);
+
+				printk("new metablocks are:");
+				for (i = 0; i<meta_num; i++)
+					printk("meta[%d]:%d",i, new_meta_blocks[i]);
+
+				printk(" over\n");
+			}
+			if (meta_num !=minblocks) {
+				BUG();
+				printk("ext3 mballoc error: allocate %d"
+					"number of metablocks, different than"
+					"required: %d", meta_num, minblocks);
+			}
+			break;
+		}
+	}
+
+	if (meta_num == 0)
+		branch[0].key = cpu_to_le32(first_data_block);
+	else
+		branch[0].key = cpu_to_le32(new_meta_blocks[0]);
+	/*
+	 * metadata blocks and data blocks are allocated.
+	 */
+	for (n = 1; n <= meta_num;  n++) {
+
+		/*
+		 * Get buffer_head for parent block, zero it out
+		 * and set the pointer to new one, then send
+		 * parent to disk.
+		 */
+		bh = sb_getblk(inode->i_sb, new_meta_blocks[n-1]);
+		branch[n].bh = bh;
+		lock_buffer(bh);
+		BUFFER_TRACE(bh, "call get_create_access");
+		err = ext3_journal_get_create_access(handle, bh);
+		if (err) {
+			unlock_buffer(bh);
+			brelse(bh);
+			goto failed;
+		}
+
+		memset(bh->b_data, 0, blocksize);
+		branch[n].p = (__le32*) bh->b_data + offsets[n];
+		if ( n != meta_num) {
+			branch[n].key = cpu_to_le32(new_meta_blocks[n]);
+			*branch[n].p = branch[n].key;
+		}
+		else {
+			branch[n].key = cpu_to_le32(first_data_block);
+			/* end of chain, update the last new metablock of
+			 * the chain to point to the new allocated
+			 * data blocks numbers
+			 */
+			for (i=0; i < data_num ; i++)
+				*(branch[n].p + i) = cpu_to_le32(current_block++);
+		}
+		BUFFER_TRACE(bh, "marking uptodate");
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
+
+		BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
+		err = ext3_journal_dirty_metadata(handle, bh);
+		if (err)
+			goto failed;
+	}
+
+	bh = branch[0].bh;
+
+	/* now splice the new branch into the tree */
+	if (bh){
+		BUFFER_TRACE(bh, "call get_write_access");
+		err = ext3_journal_get_write_access(handle, bh);
+		if (err)
+			goto failed;
+	}
+
+	*(branch[0].p) = branch[0].key;
+	current_block += 1;
+	/* update host bufferhead or inode to point to
+	 * new data blocks */
+	if ( meta_num == 0 )
+		for (i = 1; i < data_num; i++)
+			*(branch[0].p + i ) = cpu_to_le32(current_block++);
+
+	if (bh) {
+		BUFFER_TRACE(bh, "marking uptodate");
+		/*set_buffer_uptodate(bh);
+		unlock_buffer(bh);
+		*/
+		BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
+		err = ext3_journal_dirty_metadata(handle, bh);
+		if (err)
+			goto failed;
+	}
+
+	*maxblocks = data_num;
+
+	if (GBS_DEBUG) {
+		for (i=0; i<=meta_num; i++)
+			printk("inode %x, branch[%d].p:%x, branch[%d].key:%d,\n", inode, i, branch[i].p, i, branch[i].key);
+		for (i=0; i< data_num - 1; i++)
+			printk("inode %x, branch[%d].p + %d + 1:%x, *(branch[%d].p+%d+1):%d,\n, branch[%d].bh:%x\n", inode, n-1, i, branch[n-1].p + i +1, n-1, i, *(branch[n-1].p+i+1),n-1, branch[n-1].bh);
+	}
+
+	return err;
+failed:
+	/* Allocation failed, free what we already allocated */
+	for (i = 0; i < n ; i++) {
+		BUFFER_TRACE(branch[i].bh, "call journal_forget");
+		ext3_journal_forget(handle, branch[n].bh);
+	}
+	for (i = 0; i < meta_num; i++)
+		ext3_free_blocks(handle, inode, new_meta_blocks[i], 1);
+
+	if (data_num)
+		ext3_free_blocks(handle, inode, first_data_block++, data_num);
+	return err;
+}
 
 /**
  *	ext3_splice_branch - splice the allocated branch onto inode.
@@ -783,8 +975,154 @@ out:
 	return err;
 }
 
-static int ext3_get_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create)
+static int
+ext3_count_blocks_to_allocate(Indirect * branch, int k,
+				unsigned long maxblocks, int blocks_to_boundary)
+{
+	unsigned long count = 0;
+
+	if (k == 0) return 0;
+	/*
+	 * Simple case, [t,d]Indirect block(s) has not allocated yet
+	 * then it's clear blocks on that path have not allocated
+	 */
+	if (GBS_DEBUG1 || GBS_DEBUG)
+		printk("maxblocks: %d, k: %d, boundary : %d \n",maxblocks, k,
+			blocks_to_boundary);
+	if (k > 1) {
+		/* right now don't hanel cross boundary allocation */
+		if ((maxblocks - count) < blocks_to_boundary)
+			count += maxblocks;
+		else
+			count += blocks_to_boundary;
+		count += k - 1; /* blocks for [t,d]indirect blocks */
+		return count;
+	}
+
+	count++;
+	while (count < maxblocks && count <= blocks_to_boundary
+		&& *(branch[0].p + count) == 0) {
+		count++;
+	}
+	return count;
+}
+static int
+ext3_get_blocks_handle(handle_t *handle, struct inode *inode, sector_t iblock,
+			unsigned long *maxblocks, struct buffer_head *bh_result,
+			int create, int extend_disksize)
+{
+	int err = -EIO;
+	int offsets[4];
+	Indirect chain[4];
+	Indirect *partial = NULL;
+	unsigned long goal;
+	int left;
+	int blocks_to_boundary = 0;
+	int depth;
+	struct ext3_inode_info *ei = EXT3_I(inode);
+	unsigned long count = 0;
+	unsigned long first_block = 0;
+	struct ext3_block_alloc_info *block_i =  EXT3_I(inode)->i_block_alloc_info;
+
+
+	J_ASSERT(handle != NULL || create == 0);
+
+	if (GBS_DEBUG1 || GBS_DEBUG)
+		printk("ext3_get_blocks_handle: inode %x, maxblocks= %d, iblock = %d, create = %d\n", inode, (int)*maxblocks, (int)iblock, create);
+	down(&ei->truncate_sem);
+	depth = ext3_block_to_path(inode, iblock, offsets, &blocks_to_boundary);
+	if (depth == 0) {
+		printk ("depth == 0\n");
+		goto out;
+	}
+	partial = ext3_get_branch(inode, depth,
+				offsets, chain, &err);
+	/* Simplest case - block found */
+	if (!partial) {
+		first_block = chain[depth-1].key;
+		clear_buffer_new(bh_result);
+		count ++;
+		/* map more blocks */
+		while (count < *maxblocks && count <= blocks_to_boundary
+			&& (*(chain[depth-1].p+count) == first_block + count)) {
+			count ++;
+		}
+		up(&ei->truncate_sem);
+		goto got_it;
+	}
+	/* got mapped blocks or plain lookup  or failed read of indirect block */
+	if (!create || err == -EIO){
+		up(&ei->truncate_sem);
+		goto out;
+	}
+	/*
+  	 * Okay, we need to do block allocation.  Lazily initialize the block
+	 * allocation info here if necessary
+	 */
+        if (S_ISREG(inode->i_mode) && (!ei->i_block_alloc_info))
+                ext3_init_block_alloc_info(inode);
+
+	goal = ext3_find_goal(inode, iblock, chain, partial);
+
+	/* number of missing meta data blocks need to allocate for this branch */
+	left = chain + depth - partial;
+	count = ext3_count_blocks_to_allocate(partial, left, *maxblocks, blocks_to_boundary);
+	if (GBS_DEBUG1 || GBS_DEBUG)
+		printk("blocks to allocate: %d\n", count);
+	if (!err)
+		err = ext3_alloc_splice_branch(handle, inode, goal, &count,
+			offsets+(partial-chain), partial, left-1);
+	if (err) {
+		up(&ei->truncate_sem);
+		goto cleanup;
+	}
+	/* i_disksize growing is protected by truncate_sem
+	 * don't forget to protect it if you're about to implement
+	 * concurrent ext3_get_block() -bzzz */
+	if (extend_disksize && inode->i_size > ei->i_disksize)
+		ei->i_disksize = inode->i_size;
+	/*
+	 * update the most recently allocated logical & physical block
+	 * in i_block_alloc_info, to assist find the proper goal block for next
+	 * allocation
+	 */
+	block_i = ei->i_block_alloc_info;
+	if (block_i) {
+		block_i->last_alloc_logical_block = iblock + count - left;
+		block_i->last_alloc_physical_block = first_block + count - 1;
+	}
+
+	inode->i_ctime = CURRENT_TIME_SEC;
+	ext3_mark_inode_dirty(handle, inode);
+
+	up(&ei->truncate_sem);
+	if (err)
+		goto cleanup;
+
+	set_buffer_new(bh_result);
+got_it:
+	map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
+	if (blocks_to_boundary == 0)
+		set_buffer_boundary(bh_result);
+	/* Clean up and exit */
+	partial = chain+depth-1; /* the whole chain */
+cleanup:
+	while (partial > chain) {
+		BUFFER_TRACE(partial->bh, "call brelse");
+		brelse(partial->bh);
+		partial--;
+	}
+	BUFFER_TRACE(bh_result, "returned");
+out:
+	if (GBS_DEBUG1 ||GBS_DEBUG)
+		printk("ext3_get_blocks_handle returned, logical:%d, physical:%d, count: %d, err is %d\n", (int)iblock, (int) first_block, count, err);
+	*maxblocks = count;
+	return err;
+}
+
+static int ext3_get_blocks(struct inode *inode, sector_t iblock,
+		unsigned long maxblocks, struct buffer_head *bh_result,
+		int create)
 {
 	handle_t *handle = NULL;
 	int ret;
@@ -793,15 +1131,23 @@ static int ext3_get_block(struct inode *
 		handle = ext3_journal_current_handle();
 		J_ASSERT(handle != 0);
 	}
-	ret = ext3_get_block_handle(handle, inode, iblock,
+	ret = ext3_get_blocks_handle(handle, inode, iblock, &maxblocks,
 				bh_result, create, 1);
-	return ret;
+	bh_result->b_size = (maxblocks << inode->i_blkbits);
+        return ret;
+}
+
+static int ext3_get_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create)
+{
+	if (GBS_DEBUG)
+		printk("ext3_get_block is called\n");
+	return ext3_get_blocks(inode, iblock, 1, bh_result, create);
 }
 
 #define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
 
-static int
-ext3_direct_io_get_blocks(struct inode *inode, sector_t iblock,
+static int ext3_direct_io_get_blocks(struct inode *inode, sector_t iblock,
 		unsigned long max_blocks, struct buffer_head *bh_result,
 		int create)
 {
@@ -837,10 +1183,14 @@ ext3_direct_io_get_blocks(struct inode *
 	}
 
 get_block:
+	if (GBS_DEBUG)
+		printk("Calling ext3_get_blocks_handle from dio: maxblocks= %d, iblock = %d, creat = %d\n", (int)max_blocks, (int)iblock, create);
 	if (ret == 0)
-		ret = ext3_get_block_handle(handle, inode, iblock,
+		ret = ext3_get_blocks_handle(handle, inode, iblock, &max_blocks,
 					bh_result, create, 0);
-	bh_result->b_size = (1 << inode->i_blkbits);
+	bh_result->b_size = (max_blocks << inode->i_blkbits);
+	if (GBS_DEBUG)
+		printk("ext3_get_blocks_handle returns to dio: maxblocks= %d, iblock = %d\n", (int)max_blocks, (int)iblock);
 	return ret;
 }
 
diff -puN fs/ext3/xattr.c~ext3-get-blocks fs/ext3/xattr.c
--- linux-2.6.12/fs/ext3/xattr.c~ext3-get-blocks	2005-07-14 21:55:55.118384680 -0700
+++ linux-2.6.12-ming/fs/ext3/xattr.c	2005-07-14 21:55:55.173376320 -0700
@@ -796,7 +796,8 @@ inserted:
 					EXT3_SB(sb)->s_es->s_first_data_block) +
 				EXT3_I(inode)->i_block_group *
 				EXT3_BLOCKS_PER_GROUP(sb);
-			int block = ext3_new_block(handle, inode, goal, &error);
+			unsigned long count = 1;
+			int block = ext3_new_blocks(handle, inode, goal, &count, &error);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
diff -puN include/linux/ext3_fs.h~ext3-get-blocks include/linux/ext3_fs.h
--- linux-2.6.12/include/linux/ext3_fs.h~ext3-get-blocks	2005-07-14 21:55:55.122384072 -0700
+++ linux-2.6.12-ming/include/linux/ext3_fs.h	2005-07-14 21:55:55.177375712 -0700
@@ -729,7 +729,7 @@ struct dir_private_info {
 /* balloc.c */
 extern int ext3_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext3_bg_num_gdb(struct super_block *sb, int group);
-extern int ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
+extern int ext3_new_blocks (handle_t *, struct inode *, unsigned long, unsigned long*, int *);
 extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
 			      unsigned long);
 extern void ext3_free_blocks_sb (handle_t *, struct super_block *,

_


