Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbQLFImB>; Wed, 6 Dec 2000 03:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQLFIlx>; Wed, 6 Dec 2000 03:41:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13475 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129593AbQLFIlk>;
	Wed, 6 Dec 2000 03:41:40 -0500
Date: Wed, 6 Dec 2000 03:11:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012060306550.14974-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	ext2_get_block() should return -EFBIG if the block number is
too large for our block size. It returns -EIO and prints a warning
right now. Fix: don't generate bogus warnings (we can legitimately
get larger-than-maximum arguments; there is no way in hell VFS or VM
could know the ext2-specific size limits), return correct error value.
Documentation fixed to reflect the change. Additionally, ext2_get_branch()
became non-inlined - obviously correct, saves code size and makes the
things actually faster (it's too big for inlining).

	Please, apply

diff -urN rc12-pre6/fs/ext2/inode.c rc12-pre6-ext2_get_block/fs/ext2/inode.c
--- rc12-pre6/fs/ext2/inode.c	Tue Dec  5 02:03:14 2000
+++ rc12-pre6-ext2_get_block/fs/ext2/inode.c	Tue Dec  5 14:59:18 2000
@@ -153,11 +153,13 @@
  *	This function translates the block number into path in that tree -
  *	return value is the path length and @offsets[n] is the offset of
  *	pointer to (n+1)th node in the nth one. If @block is out of range
- *	(negative or too large) warning is printed and zero returned.
+ *	(negative or too large) we return zero. Warning is printed if @block
+ *	is negative - that should never happen. Too large value is OK, it
+ *	just means that ext2_get_block() should return -%EFBIG.
  *
  *	Note: function doesn't find node addresses, so no IO is needed. All
  *	we need to know is the capacity of indirect blocks (taken from the
- *	inode->i_sb).
+ *	@inode->i_sb).
  */
 
 /*
@@ -196,7 +198,7 @@
 		offsets[n++] = (i_block >> ptrs_bits) & (ptrs - 1);
 		offsets[n++] = i_block & (ptrs - 1);
 	} else {
-		ext2_warning (inode->i_sb, "ext2_block_to_path", "block > big");
+		/* Too large, nothing to do here */
 	}
 	return n;
 }
@@ -216,7 +218,7 @@
  *	i.e. little-endian 32-bit), chain[i].p contains the address of that
  *	number (it points into struct inode for i==0 and into the bh->b_data
  *	for i>0) and chain[i].bh points to the buffer_head of i-th indirect
- *	block for i>0 and NULL for i==0. In other words, it holds the block
+ *	block for i>0 and %NULL for i==0. In other words, it holds the block
  *	numbers of the chain, addresses they were taken from (and where we can
  *	verify that chain did not change) and buffer_heads hosting these
  *	numbers.
@@ -230,11 +232,11 @@
  *	or when it reads all @depth-1 indirect blocks successfully and finds
  *	the whole chain, all way to the data (returns %NULL, *err == 0).
  */
-static inline Indirect *ext2_get_branch(struct inode *inode,
-					int depth,
-					int *offsets,
-					Indirect chain[4],
-					int *err)
+static Indirect *ext2_get_branch(struct inode *inode,
+				 int depth,
+				 int *offsets,
+				 Indirect chain[4],
+				 int *err)
 {
 	kdev_t dev = inode->i_dev;
 	int size = inode->i_sb->s_blocksize;
@@ -505,7 +507,7 @@
 
 static int ext2_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
 {
-	int err = -EIO;
+	int err = -EFBIG;
 	int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
