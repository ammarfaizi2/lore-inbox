Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311618AbSCaGCh>; Sun, 31 Mar 2002 01:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311650AbSCaGC2>; Sun, 31 Mar 2002 01:02:28 -0500
Received: from www.wen-online.de ([212.223.88.39]:8714 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S311618AbSCaGCQ>;
	Sun, 31 Mar 2002 01:02:16 -0500
Date: Sun, 31 Mar 2002 07:04:12 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [NFS] Re: vfs_unlink() >=2.5.5-pre1 question
In-Reply-To: <Pine.GSO.4.21.0203301321090.2590-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10203310627310.9320-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2002, Alexander Viro wrote:

> 	a) d_delete() being called too early in vfs_unlink().  Not a big
> deal, it's easy to move outside of dget()/dput().

Indeed, that worked just fine.  I ran Bill Hawes' fs-test scripts in
ext2, ext3 and tmpfs after doing so, and nothing interesting happened.

When I ran them in a knfsd loopback mounted ext2 fs however, a couple
of gripes popped out.

nfs_safe_remove: dir1/.nfs00009d5000000b6e busy, d_count=2
nfs_safe_remove: dir2/.nfs00009d5d00000c40 busy, d_count=2

	-Mike

For reference:

--- linux-2.5.7/fs/namei.c.org	Sat Mar 30 12:54:29 2002
+++ linux-2.5.7/fs/namei.c	Sun Mar 31 05:59:24 2002
@@ -1466,16 +1466,15 @@
 	down(&dentry->d_inode->i_sem);
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
-	else {
+	else
 		error = dir->i_op->unlink(dir, dentry);
-		if (!error)
-			d_delete(dentry);
-	}
 	up(&dentry->d_inode->i_sem);
 	dput(dentry);
 
-	if (!error)
+	if (!error) {
+		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);
+	}
 
 	return error;
 }

