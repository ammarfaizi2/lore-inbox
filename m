Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVGXOiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVGXOiC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVGXOh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:37:28 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:43968 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261309AbVGXOgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:36:37 -0400
Date: Sun, 24 Jul 2005 16:36:36 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH NFS 1/3] Lose second parameter of nfs_block_size().
Message-ID: <20050724143636.GA19914@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH NFS 1/3] Lose second parameter of nfs_block_size().

Most calls to nfs_block_size() were done with a NULL pointer as second
parameter anyway.  We can simply calculate the number of bits ourselves
instead of using that ugly pointer thingy.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 fs/nfs/inode.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

6ba4cb36d1e905852917305146fbe0076ad1d86f
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -217,14 +217,14 @@ nfs_calc_block_size(u64 tsize)
  * Compute and set NFS server blocksize
  */
 static inline unsigned long
-nfs_block_size(unsigned long bsize, unsigned char *nrbitsp)
+nfs_block_size(unsigned long bsize)
 {
 	if (bsize < 1024)
 		bsize = NFS_DEF_FILE_IO_BUFFER_SIZE;
 	else if (bsize >= NFS_MAX_FILE_IO_BUFFER_SIZE)
 		bsize = NFS_MAX_FILE_IO_BUFFER_SIZE;
 
-	return nfs_block_bits(bsize, nrbitsp);
+	return nfs_block_bits(bsize, NULL);
 }
 
 /*
@@ -293,16 +293,16 @@ nfs_sb_init(struct super_block *sb, rpc_
 		server->namelen = pathinfo.max_namelen;
 	/* Work out a lot of parameters */
 	if (server->rsize == 0)
-		server->rsize = nfs_block_size(fsinfo.rtpref, NULL);
+		server->rsize = nfs_block_size(fsinfo.rtpref);
 	if (server->wsize == 0)
-		server->wsize = nfs_block_size(fsinfo.wtpref, NULL);
+		server->wsize = nfs_block_size(fsinfo.wtpref);
 
 	if (fsinfo.rtmax >= 512 && server->rsize > fsinfo.rtmax)
-		server->rsize = nfs_block_size(fsinfo.rtmax, NULL);
+		server->rsize = nfs_block_size(fsinfo.rtmax);
 	if (fsinfo.wtmax >= 512 && server->wsize > fsinfo.wtmax)
-		server->wsize = nfs_block_size(fsinfo.wtmax, NULL);
+		server->wsize = nfs_block_size(fsinfo.wtmax);
 
-	max_rpc_payload = nfs_block_size(rpc_max_payload(server->client), NULL);
+	max_rpc_payload = nfs_block_size(rpc_max_payload(server->client));
 	if (server->rsize > max_rpc_payload)
 		server->rsize = max_rpc_payload;
 	if (server->wsize > max_rpc_payload)
@@ -325,7 +325,7 @@ nfs_sb_init(struct super_block *sb, rpc_
 							 &sb->s_blocksize_bits);
 	server->wtmult = nfs_block_bits(fsinfo.wtmult, NULL);
 
-	server->dtsize = nfs_block_size(fsinfo.dtpref, NULL);
+	server->dtsize = nfs_block_size(fsinfo.dtpref);
 	if (server->dtsize > PAGE_CACHE_SIZE)
 		server->dtsize = PAGE_CACHE_SIZE;
 	if (server->dtsize > server->rsize)
@@ -419,12 +419,14 @@ nfs_fill_super(struct super_block *sb, s
 	server           = NFS_SB(sb);
 	sb->s_blocksize_bits = 0;
 	sb->s_blocksize = 0;
-	if (data->bsize)
-		sb->s_blocksize = nfs_block_size(data->bsize, &sb->s_blocksize_bits);
+	if (data->bsize) {
+		sb->s_blocksize = nfs_block_size(data->bsize);
+		sb->s_blocksize_bits = fls(sb->s_blocksize - 1);
+	}
 	if (data->rsize)
-		server->rsize = nfs_block_size(data->rsize, NULL);
+		server->rsize = nfs_block_size(data->rsize);
 	if (data->wsize)
-		server->wsize = nfs_block_size(data->wsize, NULL);
+		server->wsize = nfs_block_size(data->wsize);
 	server->flags    = data->flags & NFS_MOUNT_FLAGMASK;
 
 	server->acregmin = data->acregmin*HZ;
@@ -1619,9 +1621,9 @@ static int nfs4_fill_super(struct super_
 	sb->s_blocksize = 0;
 	server = NFS_SB(sb);
 	if (data->rsize != 0)
-		server->rsize = nfs_block_size(data->rsize, NULL);
+		server->rsize = nfs_block_size(data->rsize);
 	if (data->wsize != 0)
-		server->wsize = nfs_block_size(data->wsize, NULL);
+		server->wsize = nfs_block_size(data->wsize);
 	server->flags = data->flags & NFS_MOUNT_FLAGMASK;
 	server->caps = NFS_CAP_ATOMIC_OPEN;
 
