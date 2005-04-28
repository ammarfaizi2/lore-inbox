Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVD1TRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVD1TRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVD1TRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:17:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:35835 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262232AbVD1TO3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:14:29 -0400
Subject: [RFC] Adding multiple block allocation to current ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1114659912.16933.5.camel@mindpipe>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 28 Apr 2005 12:14:24 -0700
Message-Id: <1114715665.18996.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ext3_get_block()/ext3_new_block() only allocate one block at a
time.  To allocate multiple blocks, the caller, for example, ext3 direct
IO routine, has to invoke ext3_get_block() many times.  This is quite
inefficient for sequential IO workload. 

The benefit of a real get_blocks() include
1) increase the possibility to get contiguous blocks, reduce possibility
of  fragmentation due to interleaved allocations from other threads.
(should good for non reservation case)
2) Reduces CPU cycles spent in repeated get_block() calls
3) Batch meta data update and journaling in one short
4) Could possibly speed up future get_blocks() look up by cache the last
mapped blocks in inode.

Multiple block allocation for ext3 is very useful for support delayed
allocation, also useful for direct io.

This effort is trying to fill this requirements on top of the current
ext3 disk format. Given a file offset and maximum length of blocks to
map, ext3_get_blocks() will find out or allocate the corresponding chunk
of contiguous physical blocks on disk.  It will return the buffer head
mapped to the first physical block corresponding to the file offset, and
the number of the contiguous blocks just mapped or allocated.

First, search the [i,d,t]direct blocks indexed by the file offset to
found out the physical block. In the case that it is allocated, then
continue mapping the next logical block until the mapped physical block
is dis-adjacent, or there is no corresponding physical block being
allocated. 

In the case block allocation is needed, first, it walks through the
inode's block mapping tree to count the number of adjacent blocks to
allocate. Then it passes the number of blocks to allocate to
ext3_new_blocks(), while the real block allocation is performed. After
allocated the first block,  ext3_new_blocks() will always attempt to
allocate the next few(up to the requested size and not beyond the
reservation window) adjacent blocks at the same time. Once the blocks
are allocated and updated on bitmap, finally update those metadata
blocks with those new blocks info and splice the whole branch into the
block mapping tree.

Partial read map and partial write map is not supported since there is
no garantuee that the block allocation will allocate a contiguous
physical block back. Cross indirect block boundary allocation is not
supported due to the concern that it may cause metadata block far from
it's data blocks.

Below is just a first cut of proposed patch. Attach here just to show
the effort/direction. 
Appreciate any comments/suggestions/critics!


Thanks,
Mingming

---

 linux-2.6.11-ming/fs/ext3/balloc.c        |   89 ++++++---
 linux-2.6.11-ming/fs/ext3/inode.c         |  284 ++++++++++++++++++++++++++++--
 linux-2.6.11-ming/fs/ext3/xattr.c         |    3 
 linux-2.6.11-ming/include/linux/ext3_fs.h |    2 
 4 files changed, 333 insertions(+), 45 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_multiple_blocks_allocation fs/ext3/balloc.c
--- linux-2.6.11/fs/ext3/balloc.c~ext3_multiple_blocks_allocation	2005-04-28 12:12:06.168475152 -0700
+++ linux-2.6.11-ming/fs/ext3/balloc.c	2005-04-28 12:12:06.186473049 -0700
@@ -652,9 +652,11 @@ claim_block(spinlock_t *lock, int block,
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
@@ -712,8 +714,18 @@ repeat:
 			goto fail_access;
 		goto repeat;
 	}
-	return goal;
+	num++;
+	goal++;
+	while (num < *count && goal < end
+		&& ext3_test_allocatable(goal, bitmap_bh)
+		&& claim_block(sb_bgl_lock(EXT3_SB(sb), group), goal, bitmap_bh)) {
+		num++;
+		goal++;
+	}
+	*count = num;
+	return goal - num;
 fail_access:
+	*count = num;
 	return -1;
 }
 
@@ -1025,11 +1037,13 @@ static int
 ext3_try_to_allocate_with_rsv(struct super_block *sb, handle_t *handle,
 			unsigned int group, struct buffer_head *bitmap_bh,
 			int goal, struct ext3_reserve_window_node * my_rsv,
-			int *errp)
+			unsigned long *count, int *errp)
 {
 	unsigned long group_first_block;
 	int ret = 0;
 	int fatal;
+	int original_goal=goal;
+	unsigned long num = *count;
 
 	*errp = 0;
 
@@ -1052,7 +1066,8 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * or last attempt to allocate a block with reservation turned on failed
 	 */
 	if (my_rsv == NULL ) {
-		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
+		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
+					count, NULL);
 		goto out;
 	}
 	/*
@@ -1094,13 +1109,17 @@ ext3_try_to_allocate_with_rsv(struct sup
 		    || (my_rsv->rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
-					   &my_rsv->rsv_window);
+					   &num, &my_rsv->rsv_window);
 		if (ret >= 0) {
-			my_rsv->rsv_alloc_hit++;
+			my_rsv->rsv_alloc_hit += num;
+			*count = num;
 			break;				/* succeed */
 		}
+		num = *count;
 	}
 out:
+	if (my_rsv)
+		printk("Allocated blocks from %d ,count is %d, goal was %d, group is %d, inode is %, reservation window (%d,%d)\n", ret, *count, original_goal, group, my_rsv->rsv_start, my_rsv->rsv_end);
 	if (ret >= 0) {
 		BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for "
 					"bitmap block");
@@ -1155,8 +1174,8 @@ int ext3_should_retry_alloc(struct super
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
@@ -1179,7 +1198,8 @@ int ext3_new_block(handle_t *handle, str
 	static int goal_hits, goal_attempts;
 #endif
 	unsigned long ngroups;
-
+	unsigned long num = *count;
+	int i;
 	*errp = -ENOSPC;
 	sb = inode->i_sb;
 	if (!sb) {
@@ -1190,7 +1210,7 @@ int ext3_new_block(handle_t *handle, str
 	/*
 	 * Check quota for allocation of this block.
 	 */
-	if (DQUOT_ALLOC_BLOCK(inode, 1)) {
+	if (DQUOT_ALLOC_BLOCK(inode, num)) {
 		*errp = -EDQUOT;
 		return 0;
 	}
@@ -1245,7 +1265,7 @@ retry:
 		if (!bitmap_bh)
 			goto io_error;
 		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, ret_block, my_rsv, &fatal);
+					bitmap_bh, ret_block,  my_rsv, &num, &fatal);
 		if (fatal)
 			goto out;
 		if (ret_block >= 0)
@@ -1282,7 +1302,7 @@ retry:
 		if (!bitmap_bh)
 			goto io_error;
 		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, -1, my_rsv, &fatal);
+					bitmap_bh, -1, my_rsv, &num, &fatal);
 		if (fatal)
 			goto out;
 		if (ret_block >= 0) 
@@ -1317,14 +1337,17 @@ allocated:
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
@@ -1342,10 +1365,12 @@ allocated:
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
@@ -1354,12 +1379,12 @@ allocated:
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
@@ -1374,9 +1399,9 @@ allocated:
 
 	spin_lock(sb_bgl_lock(sbi, group_no));
 	gdp->bg_free_blocks_count =
-			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
+			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count)-num);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -1);
+	percpu_counter_mod(&sbi->s_freeblocks_counter, -num);
 
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
@@ -1388,6 +1413,8 @@ allocated:
 		goto out;
 
 	*errp = 0;
+	DQUOT_FREE_BLOCK(inode, *count-num);
+	*count = num;
 	brelse(bitmap_bh);
 	return ret_block;
 
@@ -1402,7 +1429,7 @@ out:
 	 * Undo the block allocation
 	 */
 	if (!performed_allocation)
-		DQUOT_FREE_BLOCK(inode, 1);
+		DQUOT_FREE_BLOCK(inode, *count);
 	brelse(bitmap_bh);
 	return 0;
 }
diff -puN fs/ext3/inode.c~ext3_multiple_blocks_allocation fs/ext3/inode.c
--- linux-2.6.11/fs/ext3/inode.c~ext3_multiple_blocks_allocation	2005-04-28 12:12:06.172474685 -0700
+++ linux-2.6.11-ming/fs/ext3/inode.c	2005-04-28 12:12:06.192472348 -0700
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
 
@@ -526,7 +526,7 @@ static int ext3_alloc_branch(handle_t *h
 			/*
 			 * Get buffer_head for parent block, zero it out
 			 * and set the pointer to new one, then send
-			 * parent to disk.  
+			 * parent to disk.
 			 */
 			bh = sb_getblk(inode->i_sb, parent);
 			branch[n].bh = bh;
@@ -566,6 +566,111 @@ static int ext3_alloc_branch(handle_t *h
 		ext3_free_blocks(handle, inode, le32_to_cpu(branch[i].key), 1);
 	return err;
 }
+#define GBS_DEBUG	0
+static int ext3_alloc_splice_branch(handle_t *handle, struct inode *inode,
+			     unsigned long num, unsigned long first_block,
+			     int *offsets, Indirect *branch, int depth)
+{
+	int blocksize = inode->i_sb->s_blocksize;
+	int n = 0;
+	int err = 0;
+	int i;
+	unsigned long current_block;
+	struct buffer_head *bh;
+
+	current_block = first_block;
+	branch[0].key = cpu_to_le32(current_block);
+
+	if (GBS_DEBUG)
+		printk("block %d, branch[0].p :%x\n", current_block, branch[0].p);
+	for (n = 1; n < depth;  n++) {
+		current_block++;
+		branch[n].key = cpu_to_le32(current_block);
+
+		/*
+		 * Get buffer_head for parent block, zero it out
+		 * and set the pointer to new one, then send
+		 * parent to disk.
+		 */
+		bh = sb_getblk(inode->i_sb, current_block - 1);
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
+		*branch[n].p = branch[n].key;
+		/*
+		 * allocate blocks to the rest missing data blocks
+		 */
+		if (n == depth -1 ) {
+			i = 0;
+			while (current_block - first_block + 1 < num) {
+				*(branch[n].p + i + 1) = ++current_block;
+				i++;
+			}
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
+	if (bh){
+		BUFFER_TRACE(bh, "call get_write_access");
+		err = ext3_journal_get_write_access(handle, bh);
+		if (err)
+			goto failed;
+	}
+
+	*(branch[0].p) = branch[0].key;
+
+	/* allocate blocks to the rest missing data blocks */
+	i = 0;
+	while (current_block - first_block + 1< num) {
+		*(branch[0].p + i + 1) = ++current_block;
+		i++;
+	}
+
+	if (GBS_DEBUG) {
+		for (i=0; i< n; i++)
+			printk("inode %x, branch[%d].p:%x, branch[%d].key:%d,\n", inode, i, branch[i].p, i, branch[i].key);
+		for (i=0; i< num-n; i++)
+			printk("inode %x, branch[%d].p + %d + 1:%x, *(branch[%d].p+%d+1):%d,\n, branch[%d].bh:%x\n", inode, n-1, i, branch[n-1].p + i +1, n-1, i, *(branch[n-1].p+i+1),n-1, branch[n-1].bh);
+	}
+	if (bh) {
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
+	return err;
+failed:
+	/* Allocation failed, free what we already allocated */
+	for (i = 0; i < n ; i++) {
+		BUFFER_TRACE(branch[i].bh, "call journal_forget");
+		ext3_journal_forget(handle, branch[n].bh);
+	}
+	for (i = 0; i < num; i++)
+		ext3_free_blocks(handle, inode, first_block + i, 1);
+	return err;
+}
 
 /**
  *	ext3_splice_branch - splice the allocated branch onto inode.
@@ -777,8 +882,153 @@ out:
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
+	if (GBS_DEBUG)
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
+	unsigned long first_block;
+	struct ext3_block_alloc_info *block_i;
+
+	J_ASSERT(handle != NULL || create == 0);
+
+	if (GBS_DEBUG)
+		printk("ext3_get_blocks_handle: maxblocks= %d, iblock = %d\n", *maxblocks, iblock);
+	down(&ei->truncate_sem);
+	depth = ext3_block_to_path(inode, iblock, offsets, &blocks_to_boundary);
+	if (depth == 0)
+		goto out;
+	partial = ext3_get_branch(inode, depth,
+				offsets, chain, &err);
+	/* Simplest case - block found */
+	if (!err && !partial) {
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
+	/* Okey, we need to do block allocation */
+	/* lazy initialize the block allocation info here if necessary */
+	if (S_ISREG(inode->i_mode) && (!ei->i_block_alloc_info)) {
+		ext3_init_block_alloc_info(inode);
+	}
+
+	goal = ext3_find_goal(inode, iblock, chain, partial);
+
+	/* number of missing meta data blocks need to allocate for this branch */
+	left = chain + depth - partial;
+	count = ext3_count_blocks_to_allocate(partial, left, *maxblocks, blocks_to_boundary);
+	if (GBS_DEBUG)
+		printk("blocks to allocate: %d\n", count);
+
+	first_block = ext3_new_blocks(handle, inode, goal, &count, &err);
+	if (GBS_DEBUG)
+		printk("blocks allocated(%d,%d,%d)\n", (int)iblock, (int)first_block, count);
+
+	if (!err)
+		err = ext3_alloc_splice_branch(handle, inode, count,
+			first_block, offsets+(partial-chain), partial, left);
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
@@ -787,15 +1037,21 @@ static int ext3_get_block(struct inode *
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
+	return ext3_get_blocks(inode, iblock, 1, bh_result, create);
 }
 
 #define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
 
-static int
-ext3_direct_io_get_blocks(struct inode *inode, sector_t iblock,
+static int ext3_direct_io_get_blocks(struct inode *inode, sector_t iblock,
 		unsigned long max_blocks, struct buffer_head *bh_result,
 		int create)
 {
@@ -831,10 +1087,14 @@ ext3_direct_io_get_blocks(struct inode *
 	}
 
 get_block:
+	if (GBS_DEBUG)
+		printk("Calling ext3_get_blocks_handle from dio: maxblocks= %d, iblock = %d", (int)max_blocks, (int)iblock);
 	if (ret == 0)
-		ret = ext3_get_block_handle(handle, inode, iblock,
+		ret = ext3_get_blocks_handle(handle, inode, iblock, &max_blocks,
 					bh_result, create, 0);
-	bh_result->b_size = (1 << inode->i_blkbits);
+	bh_result->b_size = (max_blocks << inode->i_blkbits);
+	if (GBS_DEBUG)
+		printk("ext3_get_blocks_handle returns to dio: maxblocks= %d, iblock = %d", (int)max_blocks, (int)iblock);
 	return ret;
 }
 
diff -puN fs/ext3/xattr.c~ext3_multiple_blocks_allocation fs/ext3/xattr.c
--- linux-2.6.11/fs/ext3/xattr.c~ext3_multiple_blocks_allocation	2005-04-28 12:12:06.177474100 -0700
+++ linux-2.6.11-ming/fs/ext3/xattr.c	2005-04-28 12:12:06.194472114 -0700
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
diff -puN include/linux/ext3_fs.h~ext3_multiple_blocks_allocation include/linux/ext3_fs.h
--- linux-2.6.11/include/linux/ext3_fs.h~ext3_multiple_blocks_allocation	2005-04-28 12:12:06.180473750 -0700
+++ linux-2.6.11-ming/include/linux/ext3_fs.h	2005-04-28 12:12:06.196471880 -0700
@@ -714,7 +714,7 @@ struct dir_private_info {
 /* balloc.c */
 extern int ext3_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext3_bg_num_gdb(struct super_block *sb, int group);
-extern int ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
+extern int ext3_new_blocks (handle_t *, struct inode *, unsigned long, unsigned long*, int *);
 extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
 			      unsigned long);
 extern void ext3_free_blocks_sb (handle_t *, struct super_block *,

_


