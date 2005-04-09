Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVDIBYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDIBYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVDIBYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:24:46 -0400
Received: from mail.ccur.com ([208.248.32.212]:64605 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261248AbVDIBXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:23:24 -0400
Subject: Re: [PATCH] mtime attribute is not being updated on client
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1112993686.7459.4.camel@lindad>
References: <1112921570.6182.16.camel@lindad>
	 <1112965872.15565.34.camel@lade.trondhjem.org>
	 <1112993686.7459.4.camel@lindad>
Content-Type: text/plain
Organization: CCUR
Message-Id: <1113009804.7459.9.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 08 Apr 2005 21:23:24 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2005 01:23:24.0726 (UTC) FILETIME=[B9AA9560:01C53CA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 16:54, Linda Dunaphant wrote:

>Do you think it would be better for nfs_refresh_inode() to check the mtime,
>perform the mtime update if needed, and not set the NFS_INO_INVALID_ATTR
>flag if the data_unstable flag is set? This is how nfs_update_inode()
>handles its mtime check.

Hi again Trond,

I updated my first patch to nfs_refresh_inode() to be similar to the way
nfs_update_inode() does the check and update of the mtime. nfs_refresh_inode()
now checks to see if the mtime changed, and if so, it does the update of
the mtime. It only sets NFS_INO_INVALID_ATTR if data_unstable is not set.

I temporarily added some printk's to selected functions to monitor some of
the functions called after the data write to the server occurs. With this
latest patch, the sequence that I see with the test program is now the
same as it was originally without any patch - except the mtime is has been
updated:
	nfs3_xdr_writeargs
	xdr_decode_fattr  		<--- new mtime from server
	nfs_refresh_inode		<--- updates mtime in inode
	nfs_attribute_timeout
	nfs_attribute_timeout
	xdr_decode_fattr  
	nfs_refresh_inode

With the first patch I proposed this sequence was:
	nfs3_xdr_writeargs
	xdr_decode_fattr  		<--- new mtime from server
	nfs_refresh_inode               <--- NFS_INO_INVALID_ATTR set
	xdr_decode_fattr  
	nfs_update_inode		<--- updates mtime in inode
	nfs_attribute_timeout
	xdr_decode_fattr  

Thank you for pointing out that there may be other consequences if the
NFS_INO_INVALID_ATTR is always set by nfs_refresh_inode() when the mtime
values are different. I believe this second patch fixes the original
problem without affecting any other behaviour.

Cheers,
Linda

diff -ura base/fs/nfs/inode.c new/fs/nfs/inode.c
--- base/fs/nfs/inode.c	2005-04-07 16:04:40.000000000 -0400
+++ new/fs/nfs/inode.c	2005-04-08 19:23:44.151698674 -0400
@@ -1176,9 +1176,17 @@
 	}
 
 	/* Verify a few of the more important attributes */
+	if (!timespec_equal(&inode->i_mtime, &fattr->mtime)) {
+		memcpy(&inode->i_mtime, &fattr->mtime, sizeof(inode->i_mtime));
+#ifdef NFS_DEBUG_VERBOSE
+		printk(KERN_DEBUG "NFS: mtime change on %s/%ld\n", inode->i_sb->s_id, inode->i_ino);
+#endif
+		if (!data_unstable)
+			nfsi->flags |= NFS_INO_INVALID_ATTR;
+	}
+
 	if (!data_unstable) {
-		if (!timespec_equal(&inode->i_mtime, &fattr->mtime)
-				|| cur_size != new_isize)
+		if (cur_size != new_isize)
 			nfsi->flags |= NFS_INO_INVALID_ATTR;
 	} else if (S_ISREG(inode->i_mode) && new_isize > cur_size)
 			nfsi->flags |= NFS_INO_INVALID_ATTR;


