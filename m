Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSCTAnR>; Tue, 19 Mar 2002 19:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293164AbSCTAnI>; Tue, 19 Mar 2002 19:43:08 -0500
Received: from tsukuba.m17n.org ([192.47.44.130]:60888 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S293131AbSCTAm6>;
	Tue, 19 Mar 2002 19:42:58 -0500
Date: Wed, 20 Mar 2002 09:42:49 +0900 (JST)
Message-Id: <200203200042.g2K0gnL19526@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <E16nKrq-0007uP-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I agree that your argument is correct generally, what I'd like
to discuss is a specific technical concern with the _change_.  Well,
you may have a big picture of NFS than me, so I just say my thought
here...

I attach the change (of my current version against 2.4.18) again, so
that we can focus the issue.

Here, the non-patched implementation checks inode correctness and
fails in:
	nfs_refresh_inode: inode XXXXXXX mode changed, OOOO to OOOO

I think there is nothing to be useful in client side inode data, when
inode->i_count == 0.  So, it doesn't make sense to check correctness
with this.

Provided the file handle is eternal thing, it doesn't fail...

IMO, it's no use to check the correctness for the inode when ->i_count == 0.
We can reuse the memory of the client side inode, that's true,
but we don't need to check old data against new one at that time.

BTW, I got positive feedback with this change.


2002-03-20  NIIBE Yutaka  <gniibe@m17n.org>

	* fs/nfs/inode.c (nfs_read_inode): Don't set inode->i_rdev here.
	(nfs_fill_inode): But set it here, instead.
	(nfs_find_actor): Reusing cached inode, clear ->i_mode.

--- fs/nfs/inode.c	19 Mar 2002 23:57:40 -0000	1.1.2.1
+++ fs/nfs/inode.c	20 Mar 2002 00:05:30 -0000
@@ -104,7 +104,6 @@ nfs_read_inode(struct inode * inode)
 {
 	inode->i_blksize = inode->i_sb->s_blocksize;
 	inode->i_mode = 0;
-	inode->i_rdev = 0;
 	/* We can't support UPDATE_ATIME(), since the server will reset it */
 	inode->i_flags |= S_NOATIME;
 	INIT_LIST_HEAD(&inode->u.nfs_i.read);
@@ -638,6 +637,7 @@ nfs_fill_inode(struct inode *inode, stru
 		 * that's precisely what we have in nfs_file_inode_operations.
 		 */
 		inode->i_op = &nfs_file_inode_operations;
+		inode->i_rdev = 0;
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &nfs_file_operations;
 			inode->i_data.a_ops = &nfs_file_aops;
@@ -679,7 +679,7 @@ nfs_find_actor(struct inode *inode, unsi
 		return 0;
 	/* Force an attribute cache update if inode->i_count == 0 */
 	if (!atomic_read(&inode->i_count))
-		NFS_CACHEINV(inode);
+		inode->i_mode = 0;
 	return 1;
 }
 
-- 
