Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269038AbRHBTQP>; Thu, 2 Aug 2001 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268816AbRHBTQG>; Thu, 2 Aug 2001 15:16:06 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60334 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268688AbRHBTP5>;
	Thu, 2 Aug 2001 15:15:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 19:15:31 GMT
Message-Id: <200108021915.TAA114350@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: [PATCH] vxfs fix
Cc: alan@lxorguk.ukuu.org.uk, hch@caldera.de, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: Linus Torvalds <torvalds@transmeta.com>

	On Wed, 1 Aug 2001 Andries.Brouwer@cwi.nl wrote:
	>
	> When mount continues to try all types, it may try V7.
	> That always succeeds, there is no test for magic or so,
	> and after garbage has been mounted as a V7 filesystem,
	> the kernel crashes or hangs or fails in other sad ways.

	Even on filesystems that have bad (limited or non-existent)
	magic numbers, 	the read_super() function should really be able
	to do a fair amount of sanity-checking. If nothing else,
	then things like verifying that the root inode really is
	a directory with a proper size, for example.

Added.

	From: Christoph Hellwig

	I'd like to propose:
	s_nfree <= V7_NICFREE, s_ninode <= V7_NICINOD, s_time != 0

Added.

	From: Al Viro

	It shouldn't crash the box, though - I'll look into that.

Good!

	From: Alan

	Alternatively pass a flag to the mount command saying
	"this is a guesswork special" then V7 fs can just return 'not me'

Parse failure.

Below a patch.

Andries


diff -r -u ../linux-2.4.7/linux/fs/sysv/super.c linux/fs/sysv/super.c
--- ../linux-2.4.7/linux/fs/sysv/super.c	Sat Jul 28 17:08:46 2001
+++ linux/fs/sysv/super.c	Thu Aug  2 19:47:58 2001
@@ -197,6 +197,8 @@
 		sb->sv_bytesex = BYTESEX_BE;
 	else
 		return 0;
+
+	/* BUG? no endian conversion on s_time? */
 	if (sbd->s_time < JAN_1_1980) {
 		/* this is likely to happen on SystemV2 FS */
 		if (sbd->s_type > 3 || sbd->s_type < 1)
@@ -294,7 +296,8 @@
 	sb->sv_toobig_block = 10 + bsize_4 * (1 + bsize_4 * (1 + bsize_4));
 	sb->sv_ind_per_block_bits = n_bits-2;
 
-	sb->sv_ninodes = (sb->sv_firstdatazone - sb->sv_firstinodezone) << sb->sv_inodes_per_block_bits;
+	sb->sv_ninodes = (sb->sv_firstdatazone - sb->sv_firstinodezone)
+		<< sb->sv_inodes_per_block_bits;
 
 	sb->s_blocksize = bsize;
 	sb->s_blocksize_bits = n_bits;
@@ -346,13 +349,10 @@
 	sb->sv_block_base = 0;
 
 	for (i = 0; i < sizeof(flavours)/sizeof(flavours[0]) && !size; i++) {
-		struct buffer_head *next_bh;
-		next_bh = bread(dev, flavours[i].block, BLOCK_SIZE);
-		if (!next_bh)
-			continue;
 		brelse(bh);
-		bh = next_bh;
-
+		bh = bread(dev, flavours[i].block, BLOCK_SIZE);
+		if (!bh)
+			continue;
 		size = flavours[i].test(sb, bh);
 	}
 
@@ -411,8 +411,10 @@
 static struct super_block *v7_read_super(struct super_block *sb,void *data,
 				  int silent)
 {
-	struct buffer_head *bh;
+	struct buffer_head *bh, *bh2 = NULL;
 	kdev_t dev = sb->s_dev;
+	struct v7_super_block *v7sb;
+	struct sysv_inode *v7i;
 
 	if (440 != sizeof (struct v7_super_block))
 		panic("V7 FS: bad super-block size");
@@ -422,23 +424,41 @@
 	sb->sv_type = FSTYPE_V7;
 	sb->sv_bytesex = BYTESEX_PDP;
 
-	set_blocksize(dev,512);
+	set_blocksize(dev, 512);
 
 	if ((bh = bread(dev, 1, 512)) == NULL) {
 		if (!silent)
-			printk("VFS: unable to read V7 FS superblock on device "
-			       "%s.\n", bdevname(dev));
+			printk("VFS: unable to read V7 FS superblock on "
+			       "device %s.\n", bdevname(dev));
 		goto failed;
 	}
 
+	/* plausibility check on superblock */
+	v7sb = (struct v7_super_block *) bh->b_data;
+	if (fs16_to_cpu(sb,v7sb->s_nfree) > V7_NICFREE ||
+	    fs16_to_cpu(sb,v7sb->s_ninode) > V7_NICINOD ||
+	    fs32_to_cpu(sb,v7sb->s_time) == 0)
+		goto failed;
+
+	/* plausibility check on root inode: it is a directory,
+	   with a nonzero size that is a multiple of 16 */
+	if ((bh2 = bread(dev, 2, 512)) == NULL)
+		goto failed;
+	v7i = (struct sysv_inode *)(bh2->b_data + 64);
+	if ((fs16_to_cpu(sb,v7i->i_mode) & ~0777) != S_IFDIR ||
+	    (fs32_to_cpu(sb,v7i->i_size) == 0) ||
+	    (fs32_to_cpu(sb,v7i->i_size) & 017) != 0)
+		goto failed;
+	brelse(bh2);
 
 	sb->sv_bh1 = bh;
 	sb->sv_bh2 = bh;
 	if (complete_read_super(sb, silent, 1))
 		return sb;
 
-	brelse(bh);
 failed:
+	brelse(bh2);
+	brelse(bh);
 	return NULL;
 }
 
