Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133062AbRDZPrr>; Thu, 26 Apr 2001 11:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135520AbRDZPrg>; Thu, 26 Apr 2001 11:47:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60858 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133062AbRDZPrL>;
	Thu, 26 Apr 2001 11:47:11 -0400
Date: Thu, 26 Apr 2001 11:45:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <Pine.GSO.4.21.0104261137410.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Ext2 does getblk+wait_on_buffer for new metadata blocks before
filling them with zeroes. While that is enough for single-processor,
on SMP we have the following race:

getblk gives us unlocked, non-uptodate bh
wait_on_buffer() does nothing
					read from device locks it and starts IO
we zero it out.
					on-disk data overwrites our zeroes.
we mark it dirty
bdflush writes the old data (_not_ zeroes) back to disk.

Result: crap in metadata block. Proposed fix: lock_buffer()/unlock_buffer()
around memset()/mark_buffer_uptodate() instead of wait_on_buffer() before
them.

Patch against 2.4.4-pre7 follows. Please, apply.
								Al


--- S4-pre7/fs/ext2/inode.c	Wed Apr 25 20:43:08 2001
+++ S4-pre7-ext2/fs/ext2/inode.c	Thu Apr 26 11:36:11 2001
@@ -397,13 +397,13 @@
 		 * the pointer to new one, then send parent to disk.
 		 */
 		bh = getblk(inode->i_dev, parent, blocksize);
-		if (!buffer_uptodate(bh))
-			wait_on_buffer(bh);
+		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
 		branch[n].p = (u32*) bh->b_data + offsets[n];
 		*branch[n].p = branch[n].key;
 		mark_buffer_uptodate(bh, 1);
+		unlock_buffer(bh);
 		mark_buffer_dirty_inode(bh, inode);
 		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
 			ll_rw_block (WRITE, 1, &bh);
@@ -587,10 +587,10 @@
 		struct buffer_head *bh;
 		bh = getblk(dummy.b_dev, dummy.b_blocknr, inode->i_sb->s_blocksize);
 		if (buffer_new(&dummy)) {
-			if (!buffer_uptodate(bh))
-				wait_on_buffer(bh);
+			lock_buffer(bh);
 			memset(bh->b_data, 0, inode->i_sb->s_blocksize);
 			mark_buffer_uptodate(bh, 1);
+			unlock_buffer(bh);
 			mark_buffer_dirty_inode(bh, inode);
 		}
 		return bh;

