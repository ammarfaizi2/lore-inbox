Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLFIhV>; Wed, 6 Dec 2000 03:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbQLFIhL>; Wed, 6 Dec 2000 03:37:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63132 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129585AbQLFIhC>;
	Wed, 6 Dec 2000 03:37:02 -0500
Date: Wed, 6 Dec 2000 03:06:36 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012060303540.14974-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	truncate() and ftruncate() return values are different from the
POSIX requirements and from the values returned by other Unices (and from
our own manpages, BTW). Trivial fix follows. Rationale: see truncate(2),
ftruncate(2), POSIX or try to call the thing on other Unices.

	Please, apply.

diff -urN rc12-pre5/fs/open.c rc12-pre5-truncate/fs/open.c
--- rc12-pre5/fs/open.c	Wed Nov 29 21:37:31 2000
+++ rc12-pre5-truncate/fs/open.c	Tue Dec  5 14:53:59 2000
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
 
@@ -163,7 +168,7 @@
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
