Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWAJX0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWAJX0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWAJX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:26:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:56543 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751341AbWAJX0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:26:15 -0500
Subject: [PATCH 2/5] ext3-get-blocks:  multiple block allocation
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 10 Jan 2006 15:26:12 -0800
Message-Id: <1136935573.4901.43.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Main part the multiple block allocation patch. This patch added support for multiple
block allocation in ext3-get-blocks(): looked up the disk block mapping and count
the total number of blocks to allocate, then pass it to ext3_new_block(),
where the real block allocation is performed. Once multiple blocks are
allocated, prepare the branch with those just allocated blocks info and
finally splice the whole branch into the block mapping tree.

Signed-off-by: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.15-ming/fs/ext3/inode.c |  266 +++++++++++++++++++++++++++-----------
 1 files changed, 191 insertions(+), 75 deletions(-)

diff -puN fs/ext3/inode.c~ext3-get-blocks fs/ext3/inode.c
--- linux-2.6.15/fs/ext3/inode.c~ext3-get-blocks	2006-01-10 14:18:10.146356906 -0800
+++ linux-2.6.15-ming/fs/ext3/inode.c	2006-01-10 14:25:27.518411899 -0800
@@ -235,16 +235,6 @@ no_delete:
 	clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
-static int ext3_alloc_block (handle_t *handle,
-			struct inode * inode, unsigned long goal, int *err)
-{
-	unsigned long result;
-
-	result = ext3_new_block(handle, inode, goal, err);
-	return result;
-}
-
-
 typedef struct {
 	__le32	*p;
 	__le32	key;
@@ -476,15 +466,115 @@ static unsigned long ext3_find_goal(stru
 
 	return ext3_find_near(inode, partial);
 }
+/**
+ *	ext3_blks_to_allocate: Look up the block map and count the number
+ *	of direct blocks need to be allocated for the given branch.
+ *
+ * 	@branch: chain of indirect blocks
+ *	@k: number of blocks need for indirect blocks
+ *	@blks: number of data blocks to be mapped.
+ *	@blocks_to_boundary:  the offset in the indirect block
+ *
+ *	return the total number of blocks to be allocate, including the
+ *	direct and indirect blocks.
+ */
+static int
+ext3_blks_to_allocate(Indirect * branch, int k, unsigned long blks,
+		int blocks_to_boundary)
+{
+	unsigned long count = 0;
+
+	/*
+	 * Simple case, [t,d]Indirect block(s) has not allocated yet
+	 * then it's clear blocks on that path have not allocated
+	 */
+	if (k > 0) {
+		/* right now don't hanel cross boundary allocation */
+		if (blks < blocks_to_boundary + 1)
+			count += blks;
+		else
+			count += blocks_to_boundary + 1;
+		return count;
+	}
+
+	count++;
+	while (count < blks && count <= blocks_to_boundary
+		&& le32_to_cpu(*(branch[0].p + count)) == 0) {
+		count++;
+	}
+	return count;
+}
+/**
+ *	ext3_alloc_blocks: multiple allocate blocks needed for a branch
+ *	@indirect_blks: the number of blocks need to allocate for indirect
+ *			blocks
+ *
+ *	@new_blocks: on return it will store the new block numbers for
+ *	the indirect blocks(if needed) and the first direct block,
+ *	@blks:	on return it will store the total number of allocated
+ *		direct blocks
+ */
+static int ext3_alloc_blocks(handle_t *handle, struct inode *inode,
+			unsigned long goal, int indirect_blks, int blks,
+			unsigned long long new_blocks[4], int *err)
+{
+	int target;
+	unsigned long count;
+	int index, i;
+	unsigned long current_block = 0;
+	int ret = 0;
+
+	/*
+	 * Here we try to allocate the requested multiple blocks at once,
+	 * on a best-effort basis.
+	 * To build a branch, we should allocate blocks for
+	 * the indirect blocks(if not allocated yet), and at least
+	 * the first direct block of this branch.  That's the
+	 * minimum number of blocks need to allocate(required)
+	 *
+	 */
+	target = blks + indirect_blks;
+	index = 0; count = 0;
+
+	while (1) {
+		count = target;
+		/* allocating blocks for indirect blocks and direct blocks */
+		current_block = ext3_new_blocks(handle, inode, goal, &count, err);
+		if (*err)
+			goto failed_out;
+
+		target -= count;
+		/* allocate blocks for indirect blocks */
+		while (index < indirect_blks && count) {
+			new_blocks[index++] = current_block++;
+			count--;
+		}
+
+		if (count > 0)
+			break;
+	}
+
+	/* save the new block number for the first direct block*/
+	new_blocks[index] = current_block;
+	/* total number of blocks allocated for direct blocks */
+	ret = count;
+	*err = 0;
+	return ret;
+failed_out:
+	for (i = 0; i <index; i++)
+		ext3_free_blocks(handle, inode, new_blocks[i], 1);
+	return ret;
+}
 
 /**
  *	ext3_alloc_branch - allocate and set up a chain of blocks.
  *	@inode: owner
- *	@num: depth of the chain (number of blocks to allocate)
+ *	@indirect_blks: number of allocated indirect blocks
+ *	@blks: number of allocated direct blocks
  *	@offsets: offsets (in the blocks) to store the pointers to next.
  *	@branch: place to store the chain in.
  *
- *	This function allocates @num blocks, zeroes out all but the last one,
+ *	This function allocates blocks, zeroes out all but the last one,
  *	links them into chain and (if we are synchronous) writes them to disk.
  *	In other words, it prepares a branch that can be spliced onto the
  *	inode. It stores the information about that chain in the branch[], in
@@ -503,71 +593,79 @@ static unsigned long ext3_find_goal(stru
  */
 
 static int ext3_alloc_branch(handle_t *handle, struct inode *inode,
-			     int num,
-			     unsigned long goal,
-			     int *offsets,
-			     Indirect *branch)
+			int indirect_blks, int *blks, unsigned long goal,
+			int *offsets, Indirect *branch)
 {
 	int blocksize = inode->i_sb->s_blocksize;
-	int n = 0, keys = 0;
+	int i, n = 0;
 	int err = 0;
-	int i;
-	int parent = ext3_alloc_block(handle, inode, goal, &err);
-
-	branch[0].key = cpu_to_le32(parent);
-	if (parent) {
-		for (n = 1; n < num; n++) {
-			struct buffer_head *bh;
-			/* Allocate the next block */
-			int nr = ext3_alloc_block(handle, inode, parent, &err);
-			if (!nr)
-				break;
-			branch[n].key = cpu_to_le32(nr);
+	struct buffer_head *bh;
+	int num;
+	unsigned long long new_blocks[4];
+	unsigned long long current_block;
 
-			/*
-			 * Get buffer_head for parent block, zero it out
-			 * and set the pointer to new one, then send
-			 * parent to disk.  
-			 */
-			bh = sb_getblk(inode->i_sb, parent);
-			if (!bh)
-				break;
-			keys = n+1;
-			branch[n].bh = bh;
-			lock_buffer(bh);
-			BUFFER_TRACE(bh, "call get_create_access");
-			err = ext3_journal_get_create_access(handle, bh);
-			if (err) {
-				unlock_buffer(bh);
-				brelse(bh);
-				break;
-			}
+	num = ext3_alloc_blocks(handle, inode, goal, indirect_blks,
+					*blks, new_blocks, &err);
+	if (err)
+		return err;
 
-			memset(bh->b_data, 0, blocksize);
-			branch[n].p = (__le32*) bh->b_data + offsets[n];
-			*branch[n].p = branch[n].key;
-			BUFFER_TRACE(bh, "marking uptodate");
-			set_buffer_uptodate(bh);
+	branch[0].key = cpu_to_le32(new_blocks[0]);
+	/*
+	 * metadata blocks and data blocks are allocated.
+	 */
+	for (n = 1; n <= indirect_blks;  n++) {
+		/*
+		 * Get buffer_head for parent block, zero it out
+		 * and set the pointer to new one, then send
+		 * parent to disk.
+		 */
+		bh = sb_getblk(inode->i_sb, new_blocks[n-1]);
+		branch[n].bh = bh;
+		lock_buffer(bh);
+		BUFFER_TRACE(bh, "call get_create_access");
+		err = ext3_journal_get_create_access(handle, bh);
+		if (err) {
 			unlock_buffer(bh);
+			brelse(bh);
+			goto failed;
+		}
 
-			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
-			err = ext3_journal_dirty_metadata(handle, bh);
-			if (err)
-				break;
-
-			parent = nr;
+		memset(bh->b_data, 0, blocksize);
+		branch[n].p = (__le32*) bh->b_data + offsets[n];
+		branch[n].key = cpu_to_le32(new_blocks[n]);
+		*branch[n].p = branch[n].key;
+		if ( n == indirect_blks) {
+			current_block = new_blocks[n];
+			/*
+			 * End of chain, update the last new metablock of
+			 * the chain to point to the new allocated
+			 * data blocks numbers
+			 */
+			for (i=1; i < num; i++)
+				*(branch[n].p + i) = cpu_to_le32(++current_block);
 		}
-	}
-	if (n == num)
-		return 0;
+		BUFFER_TRACE(bh, "marking uptodate");
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
 
+		BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
+		err = ext3_journal_dirty_metadata(handle, bh);
+		if (err)
+			goto failed;
+	}
+	*blks = num;
+	return err;
+failed:
 	/* Allocation failed, free what we already allocated */
-	for (i = 1; i < keys; i++) {
+	for (i = 1; i <= n ; i++) {
 		BUFFER_TRACE(branch[i].bh, "call journal_forget");
 		ext3_journal_forget(handle, branch[i].bh);
 	}
-	for (i = 0; i < keys; i++)
-		ext3_free_blocks(handle, inode, le32_to_cpu(branch[i].key), 1);
+	for (i = 0; i <indirect_blks; i++)
+		ext3_free_blocks(handle, inode, new_blocks[i], 1);
+
+	ext3_free_blocks(handle, inode, new_blocks[i], num);
+
 	return err;
 }
 
@@ -578,7 +676,8 @@ static int ext3_alloc_branch(handle_t *h
  *	@chain: chain of indirect blocks (with a missing link - see
  *		ext3_alloc_branch)
  *	@where: location of missing link
- *	@num:   number of blocks we are adding
+ *	@num:   number of indirect blocks we are adding
+ *	@blks:  number of direct blocks we are adding
  *
  *	This function fills the missing link and does all housekeeping needed in
  *	inode (->i_blocks, etc.). In case of success we end up with the full
@@ -586,12 +685,12 @@ static int ext3_alloc_branch(handle_t *h
  */
 
 static int ext3_splice_branch(handle_t *handle, struct inode *inode, long block,
-			      Indirect chain[4], Indirect *where, int num)
+			      Indirect *where, int num, int blks)
 {
 	int i;
 	int err = 0;
 	struct ext3_block_alloc_info *block_i = EXT3_I(inode)->i_block_alloc_info;
-
+	unsigned long current_block;
 	/*
 	 * If we're splicing into a [td]indirect block (as opposed to the
 	 * inode) then we need to get write access to the [td]indirect block
@@ -606,6 +705,13 @@ static int ext3_splice_branch(handle_t *
 	/* That's it */
 
 	*where->p = where->key;
+	/* update host bufferhead or inode to point to
+	 * more just allocated direct blocks blocks */
+	if (num == 0 && blks > 1) {
+		current_block = le32_to_cpu(where->key + 1);
+		for (i = 1; i < blks; i++)
+			*(where->p + i ) = cpu_to_le32(current_block++);
+	}
 
 	/*
 	 * update the most recently allocated logical & physical block
@@ -613,8 +719,8 @@ static int ext3_splice_branch(handle_t *
 	 * allocation
 	 */
 	if (block_i) {
-		block_i->last_alloc_logical_block = block;
-		block_i->last_alloc_physical_block = le32_to_cpu(where[num-1].key);
+		block_i->last_alloc_logical_block = block + blks - 1;
+		block_i->last_alloc_physical_block = le32_to_cpu(where[num].key + blks - 1);
 	}
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
@@ -647,10 +753,13 @@ static int ext3_splice_branch(handle_t *
 	return err;
 
 err_out:
-	for (i = 1; i < num; i++) {
+	for (i = 1; i <= num; i++) {
 		BUFFER_TRACE(where[i].bh, "call journal_forget");
 		ext3_journal_forget(handle, where[i].bh);
+		ext3_free_blocks(handle, inode, le32_to_cpu(where[i-1].key), 1);
 	}
+	ext3_free_blocks(handle, inode, le32_to_cpu(where[num].key), blks);
+
 	return err;
 }
 
@@ -683,7 +792,7 @@ ext3_get_blocks_handle(handle_t *handle,
 	Indirect chain[4];
 	Indirect *partial;
 	unsigned long goal;
-	int left;
+	int indirect_blks;
 	int blocks_to_boundary = 0;
 	int depth;
 	struct ext3_inode_info *ei = EXT3_I(inode);
@@ -770,12 +879,19 @@ ext3_get_blocks_handle(handle_t *handle,
 
 	goal = ext3_find_goal(inode, iblock, chain, partial);
 
-	left = (chain + depth) - partial;
+	/* the number of blocks need to allocate for [d,t]indirect blocks */
+	indirect_blks = (chain + depth) - partial - 1;
 
 	/*
+	 * Next look up the indirect map to count the totoal number of
+	 * direct blocks to allocate for this branch.
+	 */
+	count = ext3_blks_to_allocate(partial, indirect_blks,
+					maxblocks, blocks_to_boundary);
+	/*
 	 * Block out ext3_truncate while we alter the tree
 	 */
-	err = ext3_alloc_branch(handle, inode, left, goal,
+	err = ext3_alloc_branch(handle, inode, indirect_blks, &count, goal,
 				offsets + (partial - chain), partial);
 
 	/*
@@ -786,8 +902,8 @@ ext3_get_blocks_handle(handle_t *handle,
 	 * may need to return -EAGAIN upwards in the worst case.  --sct
 	 */
 	if (!err)
-		err = ext3_splice_branch(handle, inode, iblock, chain,
-					 partial, left);
+		err = ext3_splice_branch(handle, inode, iblock,
+					partial, indirect_blks, count);
 	/*
 	 * i_disksize growing is protected by truncate_sem.  Don't forget to
 	 * protect it if you're about to implement concurrent

_


