Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLGLHp>; Thu, 7 Dec 2000 06:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLGLHf>; Thu, 7 Dec 2000 06:07:35 -0500
Received: from [62.172.234.2] ([62.172.234.2]:17079 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129183AbQLGLH2>;
	Thu, 7 Dec 2000 06:07:28 -0500
Date: Thu, 7 Dec 2000 10:18:05 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.GSO.4.21.0012061728530.17341-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012071007420.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Alexander Viro wrote:
> On Wed, 6 Dec 2000, Linus Torvalds wrote:
> > Why remove the EROFS test?
>
> there, so if it's not a regular file we die before the call of permission(),
> if it is and fs is readonly - we get -EROFS from permission() and die
> there. In either case we don't get to the IS_RDONLY() check...

just to add that I removed the immutable test for almost the same reason:

a) we don't hit that test because permission takes care of it (for
regulars/dirs/symlinks but here only regulars are important)

b) the error returned by permission EACCES makes a lot more sense than
EPERM we were trying to return. I already quotes Single UNIX v2 to explain
why.

Now, here is the same patch, except:

a) tested under test12-pre7

b) I suggest we explain why we return EPERM for append-only files despite
the fact that SuS and common sense suggest EACCES.

Facts verified under FreeBSD 4.2

The rationale for being compatible with 4.4BSD on append-only but not on
immutable is -- for immutable we can do the test by means of permission()
fast but for append-only we would need an extra if() above permission so
let's just be BSD-compatible.  Alternatively, one could ignore BSD
altogether and return EACCES in both. Or, one could ignore SuS altogether
and return EPERM for both immutable and append-only. It is a matter of
taste so... I chose something in the middle , perhaps non-intuitive but
optimized for speed and the size of code.

Regards,
Tigran

--- linux/fs/open.c	Thu Oct 26 16:11:21 2000
+++ work/fs/open.c	Thu Dec  7 09:06:50 2000
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
 
@@ -110,12 +115,9 @@
 	if (error)
 		goto dput_and_out;
 
-	error = -EROFS;
-	if (IS_RDONLY(inode))
-		goto dput_and_out;
-
+	/* EPERM for 4.4BSD compat. EACCES would make more sense */
 	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+	if (IS_APPEND(inode))
 		goto dput_and_out;
 
 	/*
@@ -163,7 +165,7 @@
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
