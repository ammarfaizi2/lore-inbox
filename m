Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVGXOkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVGXOkL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVGXOiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:38:06 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:44480 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261313AbVGXOgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:36:38 -0400
Date: Sun, 24 Jul 2005 16:36:38 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH NFS 2/3] Lose second parameter of nfs_block_bits
Message-ID: <20050724143638.GA19928@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH NFS 2/3] Lose second parameter of nfs_block_bits

Two of the three calls were passing a NULL pointer and we can simply
calculate the number of bits ourselves.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 fs/nfs/inode.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

d81155b5789ac9d7e05261f5f4bf639e7982fa4b
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -187,17 +187,15 @@ nfs_umount_begin(struct super_block *sb)
 
 
 static inline unsigned long
-nfs_block_bits(unsigned long bsize, unsigned char *nrbitsp)
+nfs_block_bits(unsigned long bsize)
 {
 	/* make sure blocksize is a power of two */
-	if ((bsize & (bsize - 1)) || nrbitsp) {
+	if (bsize & (bsize - 1)) {
 		unsigned char	nrbits;
 
 		for (nrbits = 31; nrbits && !(bsize & (1 << nrbits)); nrbits--)
 			;
 		bsize = 1 << nrbits;
-		if (nrbitsp)
-			*nrbitsp = nrbits;
 	}
 
 	return bsize;
@@ -224,7 +222,7 @@ nfs_block_size(unsigned long bsize)
 	else if (bsize >= NFS_MAX_FILE_IO_BUFFER_SIZE)
 		bsize = NFS_MAX_FILE_IO_BUFFER_SIZE;
 
-	return nfs_block_bits(bsize, NULL);
+	return nfs_block_bits(bsize);
 }
 
 /*
@@ -320,10 +318,11 @@ nfs_sb_init(struct super_block *sb, rpc_
                 server->wsize = server->wpages << PAGE_CACHE_SHIFT;
 	}
 
-	if (sb->s_blocksize == 0)
-		sb->s_blocksize = nfs_block_bits(server->wsize,
-							 &sb->s_blocksize_bits);
-	server->wtmult = nfs_block_bits(fsinfo.wtmult, NULL);
+	if (sb->s_blocksize == 0) {
+		sb->s_blocksize = nfs_block_bits(server->wsize);
+		sb->s_blocksize_bits = fls(sb->s_blocksize - 1);
+	}
+	server->wtmult = nfs_block_bits(fsinfo.wtmult);
 
 	server->dtsize = nfs_block_size(fsinfo.dtpref);
 	if (server->dtsize > PAGE_CACHE_SIZE)
