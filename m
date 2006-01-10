Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030682AbWAJX0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbWAJX0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWAJX0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:26:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:51361 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751356AbWAJX0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:26:10 -0500
Subject: [PATCH 1/5] ext3-get-blocks: Maping multiple blocks at a once
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 10 Jan 2006 15:26:07 -0800
Message-Id: <1136935567.4901.42.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch added support of mapping multiple blocks in one short.
This is useful for DIO reads and re-writes (where blocks are already allocated),
 also is in line with Christoph's proposal of using getblocks() in
mpage_readpage() or mpage_readpages().

Signed-off-by: Mingming Cao <cmm@us.ibm.com>



---

 linux-2.6.15-ming/fs/ext3/inode.c |   91 ++++++++++++++++++++++++++------------
 1 files changed, 64 insertions(+), 27 deletions(-)

diff -puN fs/ext3/inode.c~ext3-map-mblocks fs/ext3/inode.c
--- linux-2.6.15/fs/ext3/inode.c~ext3-map-mblocks	2006-01-09 14:17:04.000000000 -0800
+++ linux-2.6.15-ming/fs/ext3/inode.c	2006-01-09 16:47:47.000000000 -0800
@@ -330,7 +330,7 @@ static int ext3_block_to_path(struct ino
 		ext3_warning (inode->i_sb, "ext3_block_to_path", "block > big");
 	}
 	if (boundary)
-		*boundary = (i_block & (ptrs - 1)) == (final - 1);
+		*boundary = final - 1 - (i_block & (ptrs - 1));
 	return n;
 }
 
@@ -669,11 +669,14 @@ err_out:
  * akpm: `handle' can be NULL if create == 0.
  *
  * The BKL may not be held on entry here.  Be sure to take it early.
+ * return > 0, # of blocks mapped or allocated
+ * return < 0, error case
  */
 
 static int
-ext3_get_block_handle(handle_t *handle, struct inode *inode, sector_t iblock,
-		struct buffer_head *bh_result, int create, int extend_disksize)
+ext3_get_blocks_handle(handle_t *handle, struct inode *inode, sector_t iblock,
+		unsigned long maxblocks, struct buffer_head *bh_result,
+		int create, int extend_disksize)
 {
 	int err = -EIO;
 	int offsets[4];
@@ -681,11 +684,15 @@ ext3_get_block_handle(handle_t *handle, 
 	Indirect *partial;
 	unsigned long goal;
 	int left;
-	int boundary = 0;
-	const int depth = ext3_block_to_path(inode, iblock, offsets, &boundary);
+	int blocks_to_boundary = 0;
+	int depth;
 	struct ext3_inode_info *ei = EXT3_I(inode);
+	int count = 0;
+	unsigned long first_block = 0;
+
 
 	J_ASSERT(handle != NULL || create == 0);
+	depth = ext3_block_to_path(inode, iblock, offsets, &blocks_to_boundary);
 
 	if (depth == 0)
 		goto out;
@@ -694,7 +701,29 @@ ext3_get_block_handle(handle_t *handle, 
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
+		first_block = chain[depth-1].key;
 		clear_buffer_new(bh_result);
+		count++;
+		/*map more blocks*/
+		while (count < maxblocks && count <= blocks_to_boundary) {
+			if (!verify_chain(chain, partial)) {
+				/*
+				 * Indirect block might be removed by
+				 * truncate while we were reading it.
+				 * Handling of that case: forget what we've
+				 * got now. Flag the err as EAGAIN, so it
+				 * will reread.
+				 */
+				err = -EAGAIN;
+				count = 0;
+				break;
+			}
+			if (le32_to_cpu(*(chain[depth-1].p+count) ==
+					(first_block + count)))
+				count++;
+			else
+				break;
+		}
 		goto got_it;
 	}
 
@@ -723,6 +752,7 @@ ext3_get_block_handle(handle_t *handle, 
 		}
 		partial = ext3_get_branch(inode, depth, offsets, chain, &err);
 		if (!partial) {
+			count++;
 			up(&ei->truncate_sem);
 			if (err)
 				goto cleanup;
@@ -772,8 +802,9 @@ ext3_get_block_handle(handle_t *handle, 
 	set_buffer_new(bh_result);
 got_it:
 	map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
-	if (boundary)
+	if (blocks_to_boundary == 0)
 		set_buffer_boundary(bh_result);
+	err = count;
 	/* Clean up and exit */
 	partial = chain + depth - 1;	/* the whole chain */
 cleanup:
@@ -787,21 +818,6 @@ out:
 	return err;
 }
 
-static int ext3_get_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create)
-{
-	handle_t *handle = NULL;
-	int ret;
-
-	if (create) {
-		handle = ext3_journal_current_handle();
-		J_ASSERT(handle != 0);
-	}
-	ret = ext3_get_block_handle(handle, inode, iblock,
-				bh_result, create, 1);
-	return ret;
-}
-
 #define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
 
 static int
@@ -815,6 +831,9 @@ ext3_direct_io_get_blocks(struct inode *
 	if (!handle)
 		goto get_block;		/* A read */
 
+	if (max_blocks == 1)
+		goto get_block;		/* A single block get */
+
 	if (handle->h_transaction->t_state == T_LOCKED) {
 		/*
 		 * Huge direct-io writes can hold off commits for long
@@ -841,13 +860,31 @@ ext3_direct_io_get_blocks(struct inode *
 	}
 
 get_block:
-	if (ret == 0)
-		ret = ext3_get_block_handle(handle, inode, iblock,
-					bh_result, create, 0);
-	bh_result->b_size = (1 << inode->i_blkbits);
+	if (ret == 0) {
+		ret = ext3_get_blocks_handle(handle, inode, iblock,
+					max_blocks, bh_result, create, 0);
+		if (ret > 0) {
+			bh_result->b_size = (ret << inode->i_blkbits);
+			ret = 0;
+		}
+	}
 	return ret;
 }
 
+static int ext3_get_blocks(struct inode *inode, sector_t iblock,
+		unsigned long maxblocks, struct buffer_head *bh_result,
+		int create)
+{
+	return ext3_direct_io_get_blocks(inode, iblock, maxblocks,
+					bh_result, create);
+}
+
+static int ext3_get_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create)
+{
+	return ext3_get_blocks(inode, iblock, 1, bh_result, create);
+}
+
 /*
  * `handle' can be NULL if create is zero
  */
@@ -862,8 +899,8 @@ struct buffer_head *ext3_getblk(handle_t
 	dummy.b_state = 0;
 	dummy.b_blocknr = -1000;
 	buffer_trace_init(&dummy.b_history);
-	*errp = ext3_get_block_handle(handle, inode, block, &dummy, create, 1);
-	if (!*errp && buffer_mapped(&dummy)) {
+	*errp = ext3_get_blocks_handle(handle, inode, block, 1, &dummy, create, 1);
+	if ((*errp == 1 ) && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
 		if (!bh) {

_


