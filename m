Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLDS7w>; Mon, 4 Dec 2000 13:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLDS7m>; Mon, 4 Dec 2000 13:59:42 -0500
Received: from 62-6-229-244.btconnect.com ([62.6.229.244]:10244 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129421AbQLDS7a>;
	Mon, 4 Dec 2000 13:59:30 -0500
Date: Mon, 4 Dec 2000 18:31:07 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Attempt to hard link across filesystems results in
 un-unmountable filesystem (fwd)
Message-ID: <Pine.LNX.4.21.0012041829370.1134-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second attempt, the first one failed due to stupid setup of ISP and the
usage of mail-abuse.org which blocks anything that has no reverse DNS
lookup. So some of my messages (about 20%) get lost and I have to resend
them when I feel it's been too quiet :)

---------- Forwarded message ----------
Date: Mon, 4 Dec 2000 13:43:20 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Christopher Yeoh <cyeoh@linuxcare.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Attempt to hard link across filesystems results in
    un-unmountable filesystem

On Tue, 21 Nov 2000, Christopher Yeoh wrote:
> 
> In 2.4-test11 attempting to hard link a file across filesystems (the
> link does fail correctly) results in one of the filesystems (the one
> the hard link was to be created on) to be in a state such that it
> can't be unmounted.
> 
> The attached patch fixes this problem.

Hi Christopher,

It is true that your patch fixes the problem as reported but let us look
one step deeper into the problem. Linux supports multiply mounted
instances of a filesystem and the check in sys_link() comparing the
mountpoints would refuse (with cross-device link error) linking between
them. This is correct. However, one level down, inside vfs_link() we also
check for ->i_dev match and that seems unnecessary, now that (with your
patch) link(2) would work correctly anyway.

Therefore, I propose a slightly modified (tested under
2.4.0-test12-pre4) version of the patch. What do you think? My philosophy
is -- since you made this feature work properly you should make it work
efficiently too and that means removing redundant code. 

Regards,
Tigran

--- linux/fs/namei.c	Mon Dec  4 08:43:35 2000
+++ work/fs/namei.c	Mon Dec  4 12:34:24 2000
@@ -1551,10 +1551,6 @@
 	if (error)
 		goto exit_lock;
 
-	error = -EXDEV;
-	if (dir->i_dev != inode->i_dev)
-		goto exit_lock;
-
 	/*
 	 * A link to an append-only or immutable file cannot be created.
 	 */
@@ -1611,7 +1607,7 @@
 			goto out;
 		error = -EXDEV;
 		if (old_nd.mnt != nd.mnt)
-			goto out;
+			goto out2;
 		new_dentry = lookup_create(&nd, 0);
 		error = PTR_ERR(new_dentry);
 		if (!IS_ERR(new_dentry)) {
@@ -1619,6 +1615,7 @@
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
