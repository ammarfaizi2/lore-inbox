Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVK3Q07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVK3Q07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVK3Q07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:26:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:52970 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751442AbVK3Q06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:26:58 -0500
Subject: [PATCH] ext3 getblocks() support for read
From: Badari Pulavarty <pbadari@us.ibm.com>
To: ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, sct@redhat.com, hch@lst.de, cmm@us.ibm.com
Content-Type: multipart/mixed; boundary="=-80VbKM2GOSVhHTrQ4PEa"
Date: Wed, 30 Nov 2005 08:26:59 -0800
Message-Id: <1133368019.27824.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-80VbKM2GOSVhHTrQ4PEa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Here is the patch to support ext3 getblocks() for non allocation
cases. (for reads & re-writes). This is useful with DIO reads,
DIO re-writes and to go with Christoph's getblocks() for readpages()
work.

Mingming is working on adding multiblock allocation support using
reservation (which can be incrementally added later).

Comments ? 

Thanks,
Badari



--=-80VbKM2GOSVhHTrQ4PEa
Content-Disposition: attachment; filename=ext3-noalloc-get-blocks.patch
Content-Type: text/x-patch; name=ext3-noalloc-get-blocks.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux-2.6.15-rc2/fs/ext3/inode.c	2005-11-19 19:25:03.000000000 -0800
+++ linux-2.6.15-rc2.new/fs/ext3/inode.c	2005-11-30 08:16:36.000000000 -0800
@@ -329,8 +329,9 @@ static int ext3_block_to_path(struct ino
 	} else {
 		ext3_warning (inode->i_sb, "ext3_block_to_path", "block > big");
 	}
-	if (boundary)
-		*boundary = (i_block & (ptrs - 1)) == (final - 1);
+	if (boundary) {
+		*boundary = final - 1 - (i_block & (ptrs - 1));
+	}
 	return n;
 }
 
@@ -672,8 +673,9 @@ err_out:
  */
 
 static int
-ext3_get_block_handle(handle_t *handle, struct inode *inode, sector_t iblock,
-		struct buffer_head *bh_result, int create, int extend_disksize)
+ext3_get_blocks_handle(handle_t *handle, struct inode *inode, sector_t iblock, 
+		int max_blocks,struct buffer_head *bh_result, int create, 
+		int extend_disksize)
 {
 	int err = -EIO;
 	int offsets[4];
@@ -681,9 +683,10 @@ ext3_get_block_handle(handle_t *handle, 
 	Indirect *partial;
 	unsigned long goal;
 	int left;
-	int boundary = 0;
-	const int depth = ext3_block_to_path(inode, iblock, offsets, &boundary);
+	int blks_boundary = 0;
+	const int depth = ext3_block_to_path(inode, iblock, offsets, &blks_boundary);
 	struct ext3_inode_info *ei = EXT3_I(inode);
+	int count = 1;
 
 	J_ASSERT(handle != NULL || create == 0);
 
@@ -694,7 +697,18 @@ ext3_get_block_handle(handle_t *handle, 
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
+		unsigned long first_block = le32_to_cpu(chain[depth-1].key);
+
 		clear_buffer_new(bh_result);
+
+		/*
+		 * Find all the contiguous blocks and return at once.
+		 */
+		while (count < max_blocks && count <= blks_boundary &&
+			(le32_to_cpu(*(chain[depth-1].p+count)) == 
+				(first_block + count))) {
+			count++;
+		}
 		goto got_it;
 	}
 
@@ -772,8 +786,9 @@ ext3_get_block_handle(handle_t *handle, 
 	set_buffer_new(bh_result);
 got_it:
 	map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
-	if (boundary)
+	if (blks_boundary == 0)
 		set_buffer_boundary(bh_result);
+	err = count;
 	/* Clean up and exit */
 	partial = chain + depth - 1;	/* the whole chain */
 cleanup:
@@ -787,6 +802,19 @@ out:
 	return err;
 }
 
+static int
+ext3_get_block_handle(handle_t *handle, struct inode *inode, sector_t iblock,
+		struct buffer_head *bh_result, int create, int extend_disksize)
+{
+	int ret;
+	ret = ext3_get_blocks_handle(handle, inode, iblock, 1, bh_result, 
+			create, extend_disksize);
+	if (ret > 0)
+		ret = 0;
+
+	return ret;
+}
+
 static int ext3_get_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
@@ -842,9 +870,13 @@ ext3_direct_io_get_blocks(struct inode *
 
 get_block:
 	if (ret == 0)
-		ret = ext3_get_block_handle(handle, inode, iblock,
-					bh_result, create, 0);
-	bh_result->b_size = (1 << inode->i_blkbits);
+		ret = ext3_get_blocks_handle(handle, inode, iblock,
+					max_blocks, bh_result, create, 0);
+
+	if (ret > 0)
+		bh_result->b_size = (ret << inode->i_blkbits);
+	else
+		bh_result->b_size = (1 << inode->i_blkbits);
 	return ret;
 }
 

--=-80VbKM2GOSVhHTrQ4PEa--

