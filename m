Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTJMOxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbTJMOxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:53:53 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:24343 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261773AbTJMOxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:53:50 -0400
Date: Mon, 13 Oct 2003 07:53:16 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: nfs fstat st_blocks overreporting
Message-ID: <20031013075316.A16032@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While you know I disagree that s_blocksize should be wtmult (ie, it
is wtmult?wtmult:512 and I think it should be MAX(rsize,wsize)), in
any event the blocks used reporting is incorrect in that it assumes
a 512 byte blocksize.

I don't know why blockbits is an unsigned char instead of an int; I
just copied it from a similar block of code in fs/nfs/inode.c.

--- 26t7.1/fs/nfs/inode.c	2003-10-13 06:59:34.000000000 -0700
+++ 26t7.2/fs/nfs/inode.c	2003-10-13 07:50:34.000000000 -0700
@@ -207,13 +207,17 @@ nfs_block_bits(unsigned long bsize, unsi
 }
 
 /*
- * Calculate the number of 512byte blocks used.
+ * Calculate the number of 2^blockbits -byte blocks used.
  */
 static inline unsigned long
-nfs_calc_block_size(u64 tsize)
+nfs_calc_blocks_used(u64 tsize, unsigned char blockbits)
 {
-	loff_t used = (tsize + 511) >> 9;
-	return (used > ULONG_MAX) ? ULONG_MAX : used;
+	unsigned long blockres;
+	loff_t used;
+
+	blockres = (1 << blockbits) - 1;
+	used = (tsize + blockres) >> blockbits;
+	return (used > ULONG_MAX) ? ULONG_MAX : used;
 }
 
 /*
@@ -762,9 +766,9 @@ nfs_fhget(struct super_block *sb, struct
 		inode->i_gid = fattr->gid;
 		if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 			/*
-			 * report the blocks in 512byte units
+			 * report the blocks in s_blocksize units
 			 */
-			inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
+			inode->i_blocks = nfs_calc_blocks_used(fattr->du.nfs3.used, inode->i_sb->s_blocksize_bits);
 			inode->i_blksize = inode->i_sb->s_blocksize;
 		} else {
 			inode->i_blocks = fattr->du.nfs2.blocks;
@@ -1181,9 +1185,10 @@ __nfs_refresh_inode(struct inode *inode,
 
 	if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 		/*
-		 * report the blocks in 512byte units
+		 * report the blocks in s_blocksize units
 		 */
-		inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
+		inode->i_blocks = nfs_calc_blocks_used(fattr->du.nfs3.used,
+					inode->i_sb->s_blocksize_bits);
 		inode->i_blksize = inode->i_sb->s_blocksize;
  	} else {
  		inode->i_blocks = fattr->du.nfs2.blocks;
