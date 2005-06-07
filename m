Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVFGAbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVFGAbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVFGAbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:31:42 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64703 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261269AbVFGAbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 20:31:39 -0400
Subject: Re: [PATCH] mtime attribute is not being updated on client
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1113009804.7459.9.camel@lindad>
References: <1112921570.6182.16.camel@lindad>
	 <1112965872.15565.34.camel@lade.trondhjem.org>
	 <1112993686.7459.4.camel@lindad>  <1113009804.7459.9.camel@lindad>
Content-Type: text/plain
Organization: CCUR
Message-Id: <1118104107.13894.20.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 06 Jun 2005 20:28:27 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2005 00:28:27.0570 (UTC) FILETIME=[D2C7C120:01C56AF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

After running for awhile with the mtime related changes that I made to
nfs_refresh_inode() on 4/8/05, I noticed that I would sometimes see
stale file data on an an NFS client if the file had been updated but
it's new filesize was the same as the old filesize. The clients were
seeing the correct mtime for the file, but the data was stale.

In my previous change for mtime in nfs_refresh_inode(), the inode was
being marked invalid, but the data was not. In the following patch, if
the mtime is updated and the data_unstable flag is not true, the inode
and the data will both be marked invalid. These changes solved the
original mtime issue as well as the stale data problem that I was
seeing.

Linda

The following patch is for 2.6.12-rc2:

diff -Nrau base/fs/nfs/inode.c new/fs/nfs/inode.c
--- base/fs/nfs/inode.c	2005-04-07 16:04:40.000000000 -0400
+++ new/fs/nfs/inode.c	2005-04-18 21:48:28.000000000 -0400
@@ -1176,9 +1176,17 @@
 	}
 
 	/* Verify a few of the more important attributes */
+	if (!timespec_equal(&inode->i_mtime, &fattr->mtime)) {
+		memcpy(&inode->i_mtime, &fattr->mtime, sizeof(inode->i_mtime));
+#ifdef NFS_DEBUG_VERBOSE
+		printk(KERN_DEBUG "NFS: mtime change on %s/%ld\n", inode->i_sb->s_id, inode->i_ino);
+#endif
+		if (!data_unstable)
+			nfsi->flags |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA;
+	}
+
 	if (!data_unstable) {
-		if (!timespec_equal(&inode->i_mtime, &fattr->mtime)
-				|| cur_size != new_isize)
+		if (cur_size != new_isize)
 			nfsi->flags |= NFS_INO_INVALID_ATTR;
 	} else if (S_ISREG(inode->i_mode) && new_isize > cur_size)
 			nfsi->flags |= NFS_INO_INVALID_ATTR;


