Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131212AbQLFJkE>; Wed, 6 Dec 2000 04:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131333AbQLFJj6>; Wed, 6 Dec 2000 04:39:58 -0500
Received: from 213-123-74-204.btconnect.com ([213.123.74.204]:38660 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131212AbQLFJjp>;
	Wed, 6 Dec 2000 04:39:45 -0500
Date: Wed, 6 Dec 2000 09:11:21 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [patch-2.4.0-test12-pre6] truncate(2) permissions
Message-ID: <Pine.LNX.4.21.0012060904550.1044-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ALexander,

This patch combines your previous patch with 2 changes I have just
suggested. Both changes are obvious (and correct).

(correction to my previous message -- the immutable thing to return EPERM
is not just a good idea, it is imperative and Linux already does that --
so we can drop that check from if() unconditionally, which is what the
patch below does).

Tested under 2.4.0-test12-pre6.

Regards,
Tigran

--- linux/fs/open.c	Thu Oct 26 16:11:21 2000
+++ work/fs/open.c	Wed Dec  6 08:05:43 2000
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
 
@@ -110,12 +115,8 @@
 	if (error)
 		goto dput_and_out;
 
-	error = -EROFS;
-	if (IS_RDONLY(inode))
-		goto dput_and_out;
-
 	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+	if (IS_APPEND(inode))
 		goto dput_and_out;
 
 	/*
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
