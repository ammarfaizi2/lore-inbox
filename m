Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312221AbSCRHHe>; Mon, 18 Mar 2002 02:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312224AbSCRHHY>; Mon, 18 Mar 2002 02:07:24 -0500
Received: from tsukuba.m17n.org ([192.47.44.130]:14773 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S312222AbSCRHHO>;
	Mon, 18 Mar 2002 02:07:14 -0500
Date: Mon, 18 Mar 2002 16:07:01 +0900 (JST)
Message-Id: <200203180707.g2I771Z00657@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: trond.myklebust@fys.uio.no
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <15499.64058.442959.241470@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Trond, 

Trond Myklebust wrote:
 > The only thing I can think might be missing is the fix to cope with
 > broken servers that reuse filehandles (this violates the
 > RFCs). Reiserfs 3.5 + knfsd is one such broken combination. Another
 > broken server is unfsd...

Yes, unfsd...

A problem is easily reproducible with user-space nfsd (on ext3, in my case).
We see the message (say, when installing a package with dpkg -i):
	nfs_refresh_inode: inode XXXXXXX mode changed, OOOO to OOOO
Which means, same file handle but different type.

FWIW, I'm using the patch attached.  It works for me.

--- linux-2.4.18/fs/nfs/inode.c~	Wed Mar 13 17:56:48 2002
+++ linux-2.4.18.superh/fs/nfs/inode.c	Mon Mar 18 13:27:39 2002
@@ -680,8 +680,10 @@ nfs_find_actor(struct inode *inode, unsi
 	if (is_bad_inode(inode))
 		return 0;
 	/* Force an attribute cache update if inode->i_count == 0 */
-	if (!atomic_read(&inode->i_count))
+	if (!atomic_read(&inode->i_count)) {
 		NFS_CACHEINV(inode);
+		inode->i_mode = 0;
+	}
 	return 1;
 }
 
-- 
