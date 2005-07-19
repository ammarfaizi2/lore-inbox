Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVGSOdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVGSOdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVGSOdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:33:45 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:1936 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261378AbVGSOdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:33:44 -0400
Message-Id: <200507191433.j6JEX4RZ015674@ms-smtp-03-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Tue, 19 Jul 2005 09:32:50 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc3-mm1] v9fs: Replace v9fs_block_bits() with fls()
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace v9fs_block_bits() with fls()

Originally from Rene Scharfe.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit f2a177d5cc8ba35ac8473961def629890d30a2f7
tree d81534c54698cb502bf7810488b03be36f36a528
parent 76ebbc7869a06014e638ad72148c375cf6644655
author Eric Van Hensbergen <ericvh@gmail.com> Tue, 19 Jul 2005 09:29:15 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Tue, 19 Jul 2005 09:29:15 -0500

 fs/9p/vfs_super.c |   33 +++------------------------------
 1 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -25,6 +25,7 @@
  *
  */
 
+#include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -74,34 +75,6 @@ static int v9fs_set_super(struct super_b
 }
 
 /**
- * v9fs_block_bits - Determine bits in blocksize (from NFS Code)
- * @bsize: blocksize
- * @nrbitsp: number of bits
- *
- * this bit from linux/fs/nfs/inode.c
- * Copyright (C) 1992  Rick Sladkey
- * XXX - shouldn't there be a global linux function for this?
- *
- */
-
-static inline unsigned long
-v9fs_block_bits(unsigned long bsize, unsigned char *nrbitsp)
-{
-	/* make sure blocksize is a power of two */
-	if ((bsize & (bsize - 1)) || nrbitsp) {
-		unsigned char nrbits;
-
-		for (nrbits = 31; nrbits && !(bsize & (1 << nrbits));
-		     nrbits--) ;
-		bsize = 1 << nrbits;
-		if (nrbitsp)
-			*nrbitsp = nrbits;
-	}
-
-	return bsize;
-}
-
-/**
  * v9fs_fill_super - populate superblock with info
  * @sb: superblock
  * @v9ses: session information
@@ -113,8 +86,8 @@ v9fs_fill_super(struct super_block *sb, 
 		int flags)
 {
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
-	sb->s_blocksize =
-	    v9fs_block_bits(v9ses->maxdata, &sb->s_blocksize_bits);
+	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
+	sb->s_blocksize = 1 << sb->s_blocksize_bits;
 	sb->s_magic = V9FS_MAGIC;
 	sb->s_op = &v9fs_super_ops;
 
