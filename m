Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSG1PUs>; Sun, 28 Jul 2002 11:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSG1PUs>; Sun, 28 Jul 2002 11:20:48 -0400
Received: from pat.uio.no ([129.240.130.16]:50579 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316856AbSG1PUs>;
	Sun, 28 Jul 2002 11:20:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.3216.952204.394819@charged.uio.no>
Date: Sun, 28 Jul 2002 17:24:00 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Set PG_uptodate in nfs_writepage_sync()
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A patch by Charles Lever (Charles.Lever@netapp.com) that ensures the
PG_uptodate bit gets set if an entire page gets written by
nfs_writepage_sync().

diff -u --recursive --new-file linux-2.5.29/fs/nfs/write.c linux-2.5.29-noac/fs/nfs/write.c
--- linux-2.5.29/fs/nfs/write.c	Thu Jul  4 18:17:16 2002
+++ linux-2.5.29-noac/fs/nfs/write.c	Sat Jul 27 17:28:29 2002
@@ -808,8 +808,15 @@
 	 * If wsize is smaller than page size, update and write
 	 * page synchronously.
 	 */
-	if (NFS_SERVER(inode)->wsize < PAGE_CACHE_SIZE || IS_SYNC(inode))
-		return nfs_writepage_sync(file, inode, page, offset, count);
+	if (NFS_SERVER(inode)->wsize < PAGE_CACHE_SIZE || IS_SYNC(inode)) {
+		status = nfs_writepage_sync(file, inode, page, offset, count);
+		if (status > 0) {
+			if (offset == 0 && status == PAGE_CACHE_SIZE)
+				SetPageUptodate(page);
+			return 0;
+		}
+		return status;
+	}
 
 	/*
 	 * Try to find an NFS request corresponding to this page
