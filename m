Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWHPWVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWHPWVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWHPWVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:21:22 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:5373 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932282AbWHPWVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:21:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YnN0BglKp/0foc3sgQoOxdNPRutmcuhZ0IWIW9/z44yOF0y1Pet8bG6iEf3A/RMz9reBhtol3GF3cfvc34vWR6w1kv2C+5CKcvfjE7eP0zFei61CiV1Eah2EKVk2Rk+BhuqPJHJ8JCRoCF1gyE2riUrd3Ju6Pj5AOtnfPFpMiys=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: possible NULL pointer deref in nfs_sillyrename()
Date: Thu, 17 Aug 2006 00:22:28 +0200
User-Agent: KMail/1.9.4
Cc: Rick Sladkey <jrs@world.std.com>, Olaf Kirch <okir@monad.swb.de>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170022.29168.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The coverity checker spotted this as bug #1013.

If we get a NULL dentry->d_inode, then regardless of 
NFS_PARANOIA or no NFS_PARANOIA, then if 
   if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
turns out to be false we'll end up dereferencing 
that NULL d_inode in two places below.

And since the check for "(!dentry->d_inode)" even exists
(although inside #ifdef NFS_PARANOIA) I take that to mean
that this is a possibility. 
And the fact that we check 
    if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
must also mean that there are cases where the check could 
fail.

So, we can get in trouble here : 

1) as an arg to sprintf() :
 		sprintf(silly, ".nfs%*.*lx",
 			i_inosize, i_inosize, dentry->d_inode->i_ino);

2) or we pass it to nfs_inode_return_delegation() which then dereferences it.
 		nfs_inode_return_delegation(dentry->d_inode);

I propose the following patch to handle this.

Compile tested only.

If this patch is somehow incorrect I'd appreciate an explanation of why :)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/nfs/dir.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.18-rc4-orig/fs/nfs/dir.c	2006-08-11 00:11:12.000000000 +0200
+++ linux-2.6.18-rc4/fs/nfs/dir.c	2006-08-17 00:06:23.000000000 +0200
@@ -1299,15 +1299,15 @@ static int nfs_sillyrename(struct inode 
 		atomic_read(&dentry->d_count));
 	nfs_inc_stats(dir, NFSIOS_SILLYRENAME);
 
-#ifdef NFS_PARANOIA
-if (!dentry->d_inode)
-printk("NFS: silly-renaming %s/%s, negative dentry??\n",
-dentry->d_parent->d_name.name, dentry->d_name.name);
-#endif
+	error = -EBUSY;
+	if (!dentry->d_inode) {
+		printk("NFS: silly-renaming %s/%s, negative dentry??\n",
+			dentry->d_parent->d_name.name, dentry->d_name.name);
+		goto out;
+	}
 	/*
 	 * We don't allow a dentry to be silly-renamed twice.
 	 */
-	error = -EBUSY;
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
 		goto out;
 


