Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSFYTRN>; Tue, 25 Jun 2002 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSFYTQN>; Tue, 25 Jun 2002 15:16:13 -0400
Received: from mons.uio.no ([129.240.130.14]:22467 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S315856AbSFYTQH>;
	Tue, 25 Jun 2002 15:16:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15640.49514.475470.751124@charged.uio.no>
Date: Tue, 25 Jun 2002 21:15:54 +0200
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.19-rc1 Fix NFS attribute caching bug
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Fixes an obvious bug in __nfs_refresh_inode(): after updating the
attribute cache, if we discover that the data cache is invalid don't
call nfs_zap_caches() as that will also reinvalidate the attribute
cache.
  This bug plays havoc with the new lookup/revalidation code in 2.4.19
since it forces a lot of unnecessary extra GETATTR RPC calls.

Cheers,
   Trond

diff -u --recursive --new-file linux-2.4.19-pre10/fs/nfs/inode.c linux-2.4.19-fix_refresh1/fs/nfs/inode.c
--- linux-2.4.19-pre10/fs/nfs/inode.c	Tue Mar 12 16:35:02 2002
+++ linux-2.4.19-fix_refresh1/fs/nfs/inode.c	Tue Jun 25 17:40:36 2002
@@ -1087,14 +1087,17 @@
  		inode->i_rdev = to_kdev_t(fattr->rdev);
  
 	/* Update attrtimeo value */
-	if (!invalid && time_after(jiffies, NFS_ATTRTIMEO_UPDATE(inode)+NFS_ATTRTIMEO(inode))) {
+	if (invalid) {
+		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
+		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
+		invalidate_inode_pages(inode);
+		memset(NFS_COOKIEVERF(inode), 0, sizeof(NFS_COOKIEVERF(inode)));
+	} else if (time_after(jiffies, NFS_ATTRTIMEO_UPDATE(inode)+NFS_ATTRTIMEO(inode))) {
 		if ((NFS_ATTRTIMEO(inode) <<= 1) > NFS_MAXATTRTIMEO(inode))
 			NFS_ATTRTIMEO(inode) = NFS_MAXATTRTIMEO(inode);
 		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
 	}
 
-	if (invalid)
-		nfs_zap_caches(inode);
 	return 0;
  out_nochange:
 	if (new_atime - inode->i_atime > 0)
