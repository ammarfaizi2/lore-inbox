Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSFAIj7>; Sat, 1 Jun 2002 04:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315424AbSFAIjK>; Sat, 1 Jun 2002 04:39:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46090 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314433AbSFAIik>;
	Sat, 1 Jun 2002 04:38:40 -0400
Message-ID: <3CF888DA.57206310@zip.com.au>
Date: Sat, 01 Jun 2002 01:42:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/16] buffer_boundary() for ext3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Implement buffer_boundary() for ext3.

buffer_boundary() is an I/O scheduling hint which the filesystem's
get_block() function passes up to the BIO assembly code.  It is
described in fs/mpage.c

The time to read 1,000 52 kbyte files goes from 8.6 seconds down to 2.9
seconds.  52 kbytes is the worst-case size.


=====================================

--- 2.5.19/fs/ext3/inode.c~ext3-buffer_boundary	Sat Jun  1 01:18:08 2002
+++ 2.5.19-akpm/fs/ext3/inode.c	Sat Jun  1 01:18:08 2002
@@ -306,6 +306,8 @@ static inline int verify_chain(Indirect 
  *	@inode: inode in question (we are only interested in its superblock)
  *	@i_block: block number to be parsed
  *	@offsets: array to store the offsets in
+ *      @boundary: set this non-zero if the referred-to block is likely to be
+ *             followed (on disk) by an indirect block.
  *
  *	To store the locations of file's data ext3 uses a data structure common
  *	for UNIX filesystems - tree of pointers anchored in the inode, with
@@ -330,7 +332,8 @@ static inline int verify_chain(Indirect 
  * get there at all.
  */
 
-static int ext3_block_to_path(struct inode *inode, long i_block, int offsets[4])
+static int ext3_block_to_path(struct inode *inode,
+			long i_block, int offsets[4], int *boundary)
 {
 	int ptrs = EXT3_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT3_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -338,26 +341,33 @@ static int ext3_block_to_path(struct ino
 		indirect_blocks = ptrs,
 		double_blocks = (1 << (ptrs_bits * 2));
 	int n = 0;
+	int final = 0;
 
 	if (i_block < 0) {
 		ext3_warning (inode->i_sb, "ext3_block_to_path", "block < 0");
 	} else if (i_block < direct_blocks) {
 		offsets[n++] = i_block;
+		final = direct_blocks;
 	} else if ( (i_block -= direct_blocks) < indirect_blocks) {
 		offsets[n++] = EXT3_IND_BLOCK;
 		offsets[n++] = i_block;
+		final = ptrs;
 	} else if ((i_block -= indirect_blocks) < double_blocks) {
 		offsets[n++] = EXT3_DIND_BLOCK;
 		offsets[n++] = i_block >> ptrs_bits;
 		offsets[n++] = i_block & (ptrs - 1);
+		final = ptrs;
 	} else if (((i_block -= double_blocks) >> (ptrs_bits * 2)) < ptrs) {
 		offsets[n++] = EXT3_TIND_BLOCK;
 		offsets[n++] = i_block >> (ptrs_bits * 2);
 		offsets[n++] = (i_block >> ptrs_bits) & (ptrs - 1);
 		offsets[n++] = i_block & (ptrs - 1);
+		final = ptrs;
 	} else {
 		ext3_warning (inode->i_sb, "ext3_block_to_path", "block > big");
 	}
+	if (boundary)
+		*boundary = (i_block & (ptrs - 1)) == (final - 1);
 	return n;
 }
 
@@ -734,7 +744,8 @@ static int ext3_get_block_handle(handle_
 	Indirect *partial;
 	unsigned long goal;
 	int left;
-	int depth = ext3_block_to_path(inode, iblock, offsets);
+	int boundary = 0;
+	int depth = ext3_block_to_path(inode, iblock, offsets, &boundary);
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	loff_t new_size;
 
@@ -752,6 +763,8 @@ reread:
 		clear_buffer_new(bh_result);
 got_it:
 		map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
+		if (boundary)
+			set_buffer_boundary(bh_result);
 		/* Clean up and exit */
 		partial = chain+depth-1; /* the whole chain */
 		goto cleanup;
@@ -1875,7 +1888,7 @@ void ext3_truncate(struct inode * inode)
 	ext3_block_truncate_page(handle, inode->i_mapping, inode->i_size);
 		
 
-	n = ext3_block_to_path(inode, last_block, offsets);
+	n = ext3_block_to_path(inode, last_block, offsets, NULL);
 	if (n == 0)
 		goto out_stop;	/* error */
 

-
