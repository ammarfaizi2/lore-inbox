Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVGXOkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVGXOkK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGXOiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:38:11 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:45248 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261327AbVGXOgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:36:41 -0400
Date: Sun, 24 Jul 2005 16:36:40 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH NFS 3/3] Replace nfs_block_bits() with roundup_pow_of_two()
Message-ID: <20050724143640.GA19941@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH NFS 3/3] Replace nfs_block_bits() with roundup_pow_of_two()

Function nfs_block_bits() an open-coded version of (the non-existing)
rounddown_pow_of_two().  That means that for non-power-of-two target
sizes it returns half the size needed for a block to fully contain
the target.  I guess this is wrong. :-)  The patch uses the built-in
roundup_pow_of_two() instead.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 fs/nfs/inode.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

4130722d1eeb5eb22c38df9f09dfa6be554bc72c
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -185,22 +185,6 @@ nfs_umount_begin(struct super_block *sb)
 		rpc_killall_tasks(rpc);
 }
 
-
-static inline unsigned long
-nfs_block_bits(unsigned long bsize)
-{
-	/* make sure blocksize is a power of two */
-	if (bsize & (bsize - 1)) {
-		unsigned char	nrbits;
-
-		for (nrbits = 31; nrbits && !(bsize & (1 << nrbits)); nrbits--)
-			;
-		bsize = 1 << nrbits;
-	}
-
-	return bsize;
-}
-
 /*
  * Calculate the number of 512byte blocks used.
  */
@@ -222,7 +206,7 @@ nfs_block_size(unsigned long bsize)
 	else if (bsize >= NFS_MAX_FILE_IO_BUFFER_SIZE)
 		bsize = NFS_MAX_FILE_IO_BUFFER_SIZE;
 
-	return nfs_block_bits(bsize);
+	return roundup_pow_of_two(bsize);
 }
 
 /*
@@ -319,10 +303,10 @@ nfs_sb_init(struct super_block *sb, rpc_
 	}
 
 	if (sb->s_blocksize == 0) {
-		sb->s_blocksize = nfs_block_bits(server->wsize);
+		sb->s_blocksize = roundup_pow_of_two(server->wsize);
 		sb->s_blocksize_bits = fls(sb->s_blocksize - 1);
 	}
-	server->wtmult = nfs_block_bits(fsinfo.wtmult);
+	server->wtmult = roundup_pow_of_two(fsinfo.wtmult);
 
 	server->dtsize = nfs_block_size(fsinfo.dtpref);
 	if (server->dtsize > PAGE_CACHE_SIZE)
