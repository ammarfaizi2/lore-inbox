Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFJHV>; Wed, 6 Dec 2000 04:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQLFJHL>; Wed, 6 Dec 2000 04:07:11 -0500
Received: from 213-123-74-204.btconnect.com ([213.123.74.204]:19460 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129183AbQLFJHE>;
	Wed, 6 Dec 2000 04:07:04 -0500
Date: Wed, 6 Dec 2000 08:38:40 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.LNX.4.21.0012060824360.906-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012060838100.906-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Tigran Aivazian wrote:
> minutes ago... maybe you could merge it into yours and re-send to Linus?

here is the merged patch:

--- linux/fs/open.c	Thu Oct 26 16:11:21 2000
+++ work/fs/open.c	Wed Dec  6 07:38:30 2000
@@ -102,7 +102,12 @@
 		goto out;
 	inode = nd.dentry->d_inode;
 
-	error = -EACCES;
+	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
+	error = -EISDIR;
+	if (S_ISDIR(inode->i_mode))
+		goto dput_and_out;
+
+	error = -EINVAL;
 	if (!S_ISREG(inode->i_mode))
 		goto dput_and_out;
 
@@ -110,10 +115,6 @@
 	if (error)
 		goto dput_and_out;
 
-	error = -EROFS;
-	if (IS_RDONLY(inode))
-		goto dput_and_out;
-
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto dput_and_out;
@@ -163,7 +164,7 @@
 		goto out;
 	dentry = file->f_dentry;
 	inode = dentry->d_inode;
-	error = -EACCES;
+	error = -EINVAL;
 	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
 		goto out_putf;
 	error = -EPERM;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
