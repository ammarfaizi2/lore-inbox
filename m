Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVGYP45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVGYP45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVGYP44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:56:56 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:15557 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261243AbVGYP4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:56:12 -0400
Date: Mon, 25 Jul 2005 17:56:11 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH NFS 3/3] Replace nfs_block_bits() with roundup_pow_of_two()
Message-ID: <20050725155611.GA12856@lsrfire.ath.cx>
References: <20050724143640.GA19941@lsrfire.ath.cx> <1122246549.8322.3.camel@lade.trondhjem.org> <1122247463.8322.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122247463.8322.19.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 07:24:23PM -0400, Trond Myklebust wrote:
> su den 24.07.2005 Klokka 19:09 (-0400) skreiv Trond Myklebust:
> > What non-power-of-two target? Anything _not_ aligned to a power of two
> > boundary is a BUG!

So we could simply replace the loop in nfs_block_bits() with call to
BUG()? :->

> Furthermore, rounding UP in order to "correct" this non-alignment would
> definitely be a bug.
> 
> If users choose to override the default rsize/wsize, that is almost
> always in order to limit the UDP fragmentation per read/write request on
> lossy networks. By rounding up, you are doubling the number of fragments
> that the user requested instead of respecting the limit.

OK.  Either way, this function can be cleaned up.  Apparently the Plan 9
filesystem guys thought it rounds up.

What's your opinion of the following patch, which explicitly states the
intent of nfs_block_bits()?  It still needs patch 1 and 2.

Thanks,
Rene



[PATCH 3/4] Simplify and rename nfs_block_bits() to rounddown_pow_of_two()

nfs_block_bits() doesn't have a lot to do with bits anymore.  It can
also be implemented simpler and clearer with fls().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 fs/nfs/inode.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

1388b63224334877b1b154e38ad9ee17f1726bca
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -185,20 +185,9 @@ nfs_umount_begin(struct super_block *sb)
 		rpc_killall_tasks(rpc);
 }
 
-
-static inline unsigned long
-nfs_block_bits(unsigned long bsize)
+static inline unsigned long rounddown_pow_of_two(unsigned long x)
 {
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
+	return x ? (1UL << (fls(x) - 1)) : 0;
 }
 
 /*
@@ -222,7 +211,7 @@ nfs_block_size(unsigned long bsize)
 	else if (bsize >= NFS_MAX_FILE_IO_BUFFER_SIZE)
 		bsize = NFS_MAX_FILE_IO_BUFFER_SIZE;
 
-	return nfs_block_bits(bsize);
+	return rounddown_pow_of_two(bsize);
 }
 
 /*
@@ -319,10 +308,10 @@ nfs_sb_init(struct super_block *sb, rpc_
 	}
 
 	if (sb->s_blocksize == 0) {
-		sb->s_blocksize = nfs_block_bits(server->wsize);
+		sb->s_blocksize = rounddown_pow_of_two(server->wsize);
 		sb->s_blocksize_bits = fls(sb->s_blocksize - 1);
 	}
-	server->wtmult = nfs_block_bits(fsinfo.wtmult);
+	server->wtmult = rounddown_pow_of_two(fsinfo.wtmult);
 
 	server->dtsize = nfs_block_size(fsinfo.dtpref);
 	if (server->dtsize > PAGE_CACHE_SIZE)
