Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLFIVT>; Wed, 6 Dec 2000 03:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQLFIVJ>; Wed, 6 Dec 2000 03:21:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50564 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129585AbQLFIUz>;
	Wed, 6 Dec 2000 03:20:55 -0500
Date: Wed, 6 Dec 2000 02:50:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre6
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012060241000.14974-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Linus Torvalds wrote:

> 
> Ok, I almost called this the final test12, but I wanted to get some more
> feedback on the keyboard controller stuff and PCI irq routing.

Linus, could you apply the following bunch of fixes (split into separate
emails):
	* dentry leak upon the attempt of cross-device link().
	* recovery after get_block() failure in block_prepare_write()
	* ext2_update_inode() missing some cases when it should mark
	* bogus return values of truncate() and ftruncate().
fs as having large files
	* fix to ext2_get_block() - it should return -EFBIG if the block
number is too large, not -EIO.

All of these are real bugs and the first 3 are pretty bad.

The first one (not my catch) - sys_link() should do path_release() if
it decides to fail with -EXDEV. It doesn't. Result: exploitable dentry
leak. Please, apply.

diff -urN rc12-pre6/fs/namei.c rc12-pre6-link/fs/namei.c
--- rc12-pre6/fs/namei.c	Tue Dec  5 02:03:15 2000
+++ rc12-pre6-link/fs/namei.c	Tue Dec  5 14:55:57 2000
@@ -1611,7 +1611,7 @@
 			goto out;
 		error = -EXDEV;
 		if (old_nd.mnt != nd.mnt)
-			goto out;
+			goto out2;
 		new_dentry = lookup_create(&nd, 0);
 		error = PTR_ERR(new_dentry);
 		if (!IS_ERR(new_dentry)) {
@@ -1619,6 +1619,7 @@
 			dput(new_dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
+out2:
 		path_release(&nd);
 out:
 		path_release(&old_nd);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
