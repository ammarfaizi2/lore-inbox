Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbTDAQSv>; Tue, 1 Apr 2003 11:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262652AbTDAQSJ>; Tue, 1 Apr 2003 11:18:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:9875 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262643AbTDAQRH>;
	Tue, 1 Apr 2003 11:17:07 -0500
Date: Tue, 1 Apr 2003 22:03:37 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filesystem aio rdwr patchset
Message-ID: <20030401220337.D1857@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030401215957.A1800@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030401215957.A1800@in.ibm.com>; from suparna@in.ibm.com on Tue, Apr 01, 2003 at 09:59:57PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 09:59:57PM +0530, Suparna Bhattacharya wrote:
> 04ext2-aiogetblk.patch :  an async get block 
>   implementation for ext2
> 
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

diff -ur linux-2.5.66/fs/ext2/balloc.c linux-2.5.66aio/fs/ext2/balloc.c
--- linux-2.5.66/fs/ext2/balloc.c	Tue Mar 25 03:30:18 2003
+++ linux-2.5.66aio/fs/ext2/balloc.c	Wed Mar 26 19:50:08 2003
@@ -76,7 +76,7 @@
  * Return buffer_head on success or NULL in case of failure.
  */
 static struct buffer_head *
-read_block_bitmap(struct super_block *sb, unsigned int block_group)
+read_block_bitmap_async(struct super_block *sb, unsigned int block_group)
 {
 	struct ext2_group_desc * desc;
 	struct buffer_head * bh = NULL;
@@ -84,7 +84,7 @@
 	desc = ext2_get_group_desc (sb, block_group, NULL);
 	if (!desc)
 		goto error_out;
-	bh = sb_bread(sb, le32_to_cpu(desc->bg_block_bitmap));
+	bh = sb_bread_async(sb, le32_to_cpu(desc->bg_block_bitmap));
 	if (!bh)
 		ext2_error (sb, "read_block_bitmap",
 			    "Cannot read block bitmap - "
@@ -94,6 +94,15 @@
 	return bh;
 }
 
+static struct buffer_head *
+read_block_bitmap(struct super_block *sb, unsigned int block_group)
+{
+	struct buffer_head * bh = NULL;
+
+	do_sync_op(bh = read_block_bitmap_async(sb, block_group));
+	return bh;
+}
+
 static inline int reserve_blocks(struct super_block *sb, int count)
 {
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
@@ -309,7 +318,7 @@
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext2_new_block (struct inode * inode, unsigned long goal,
+int ext2_new_block_async (struct inode * inode, unsigned long goal,
     u32 * prealloc_count, u32 * prealloc_block, int * err)
 {
 	struct buffer_head *bitmap_bh = NULL;
@@ -401,7 +410,7 @@
 	}
 	brelse(bitmap_bh);
 	bitmap_bh = read_block_bitmap(sb, group_no);
-	if (!bitmap_bh)
+	if (!bitmap_bh || IS_ERR(bitmap_bh))
 		goto io_error;
 
 	ret_block = grab_block(bitmap_bh->b_data, group_size, 0);
@@ -481,10 +490,20 @@
 	return block;
 
 io_error:
-	*err = -EIO;
+	*err = IS_ERR(bitmap_bh) ? PTR_ERR(bitmap_bh) : -EIO;
 	goto out_release;
 }
 
+int ext2_new_block (struct inode * inode, unsigned long goal,
+    u32 * prealloc_count, u32 * prealloc_block, int * err)
+{
+	int block = 0;
+
+	do_sync_op(block = ext2_new_block_async(inode, goal, prealloc_count,
+		prealloc_block, err));
+	return block;
+}
+
 unsigned long ext2_count_free_blocks (struct super_block * sb)
 {
 #ifdef EXT2FS_DEBUG
diff -ur linux-2.5.66/fs/ext2/ext2.h linux-2.5.66aio/fs/ext2/ext2.h
--- linux-2.5.66/fs/ext2/ext2.h	Tue Mar 25 03:31:48 2003
+++ linux-2.5.66aio/fs/ext2/ext2.h	Tue Mar 25 13:42:02 2003
@@ -74,6 +74,8 @@
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
 extern int ext2_new_block (struct inode *, unsigned long,
 			   __u32 *, __u32 *, int *);
+extern int ext2_new_block_async (struct inode *, unsigned long,
+			   __u32 *, __u32 *, int *);
 extern void ext2_free_blocks (struct inode *, unsigned long,
 			      unsigned long);
 extern unsigned long ext2_count_free_blocks (struct super_block *);
diff -ur linux-2.5.66/fs/ext2/inode.c linux-2.5.66aio/fs/ext2/inode.c
--- linux-2.5.66/fs/ext2/inode.c	Tue Mar 25 03:29:57 2003
+++ linux-2.5.66aio/fs/ext2/inode.c	Mon Mar 31 21:16:08 2003
@@ -98,7 +98,8 @@
 #endif
 }
 
-static int ext2_alloc_block (struct inode * inode, unsigned long goal, int *err)
+static int ext2_alloc_block_async (struct inode * inode, unsigned long goal, 
+	int *err)
 {
 #ifdef EXT2FS_DEBUG
 	static unsigned long alloc_hits = 0, alloc_attempts = 0;
@@ -123,18 +124,26 @@
 		ext2_debug ("preallocation miss (%lu/%lu).\n",
 			    alloc_hits, ++alloc_attempts);
 		if (S_ISREG(inode->i_mode))
-			result = ext2_new_block (inode, goal, 
+			result = ext2_new_block_async (inode, goal, 
 				 &ei->i_prealloc_count,
 				 &ei->i_prealloc_block, err);
 		else
 			result = ext2_new_block (inode, goal, 0, 0, err);
 	}
 #else
-	result = ext2_new_block (inode, goal, 0, 0, err);
+	result = ext2_new_block_async (inode, goal, 0, 0, err);
 #endif
 	return result;
 }
 
+static int ext2_alloc_block (struct inode * inode, unsigned long goal, int *err)
+{
+	int result;
+
+	do_sync_op(result = ext2_alloc_block_async(inode, goal, err));
+	return result;
+}
+
 typedef struct {
 	u32	*p;
 	u32	key;
@@ -252,7 +261,7 @@
  *	or when it reads all @depth-1 indirect blocks successfully and finds
  *	the whole chain, all way to the data (returns %NULL, *err == 0).
  */
-static Indirect *ext2_get_branch(struct inode *inode,
+static Indirect *ext2_get_branch_async(struct inode *inode,
 				 int depth,
 				 int *offsets,
 				 Indirect chain[4],
@@ -268,8 +277,8 @@
 	if (!p->key)
 		goto no_block;
 	while (--depth) {
-		bh = sb_bread(sb, le32_to_cpu(p->key));
-		if (!bh)
+		bh = sb_bread_async(sb, le32_to_cpu(p->key));
+		if (!bh || IS_ERR(bh))
 			goto failure;
 		read_lock(&EXT2_I(inode)->i_meta_lock);
 		if (!verify_chain(chain, p))
@@ -287,11 +296,24 @@
 	*err = -EAGAIN;
 	goto no_block;
 failure:
-	*err = -EIO;
+	*err = IS_ERR(bh) ? PTR_ERR(bh) : -EIO;
 no_block:
 	return p;
 }
 
+static Indirect *ext2_get_branch(struct inode *inode,
+				 int depth,
+				 int *offsets,
+				 Indirect chain[4],
+				 int *err)
+{
+	Indirect *p;
+
+	do_sync_op(p = ext2_get_branch_async(inode, depth, offsets, chain, 
+		err));
+	return p;
+}
+
 /**
  *	ext2_find_near - find a place for allocation with sufficient locality
  *	@inode: owner
@@ -406,7 +428,7 @@
  *	as described above and return 0.
  */
 
-static int ext2_alloc_branch(struct inode *inode,
+static int ext2_alloc_branch_async(struct inode *inode,
 			     int num,
 			     unsigned long goal,
 			     int *offsets,
@@ -422,7 +444,7 @@
 	if (parent) for (n = 1; n < num; n++) {
 		struct buffer_head *bh;
 		/* Allocate the next block */
-		int nr = ext2_alloc_block(inode, parent, &err);
+		int nr = ext2_alloc_block_async(inode, parent, &err);
 		if (!nr)
 			break;
 		branch[n].key = cpu_to_le32(nr);
@@ -458,6 +480,19 @@
 	return err;
 }
 
+static int ext2_alloc_branch(struct inode *inode,
+			     int num,
+			     unsigned long goal,
+			     int *offsets,
+			     Indirect *branch)
+{
+	int err;
+
+	do_sync_op(err = ext2_alloc_branch_async(inode, num, goal, 
+		offsets, branch));
+	return err;
+}
+
 /**
  *	ext2_splice_branch - splice the allocated branch onto inode.
  *	@inode: owner
@@ -531,7 +566,7 @@
  * reachable from inode.
  */
 
-static int ext2_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
+static int ext2_get_block_async(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
 {
 	int err = -EIO;
 	int offsets[4];
@@ -546,7 +581,7 @@
 		goto out;
 
 reread:
-	partial = ext2_get_branch(inode, depth, offsets, chain, &err);
+	partial = ext2_get_branch_async(inode, depth, offsets, chain, &err);
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
@@ -560,7 +595,7 @@
 	}
 
 	/* Next simple case - plain lookup or failed read of indirect block */
-	if (!create || err == -EIO) {
+	if (!create || err == -EIO || err == -EIOCBQUEUED) {
 cleanup:
 		while (partial > chain) {
 			brelse(partial->bh);
@@ -582,7 +617,7 @@
 		goto changed;
 
 	left = (chain + depth) - partial;
-	err = ext2_alloc_branch(inode, left, goal,
+	err = ext2_alloc_branch_async(inode, left, goal,
 					offsets+(partial-chain), partial);
 	if (err)
 		goto cleanup;
@@ -601,6 +636,15 @@
 	goto reread;
 }
 
+static int ext2_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
+{
+	int err;
+
+	do_sync_op(err = ext2_get_block_async(inode, iblock, bh_result, 
+		create));
+	return err;
+}
+
 static int ext2_writepage(struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, ext2_get_block, wbc);
@@ -622,7 +666,7 @@
 ext2_prepare_write(struct file *file, struct page *page,
 			unsigned from, unsigned to)
 {
-	return block_prepare_write(page,from,to,ext2_get_block);
+	return block_prepare_write(page,from,to,ext2_get_block_async);
 }
 
 static int
