Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131533AbRAIXhR>; Tue, 9 Jan 2001 18:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131433AbRAIXhH>; Tue, 9 Jan 2001 18:37:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:65522 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131181AbRAIXgy>;
	Tue, 9 Jan 2001 18:36:54 -0500
Date: Tue, 9 Jan 2001 18:36:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: Linus Torvalds <torvalds@transmeta.com>, mchouque@e-steel.com,
        linux-kernel@vger.kernel.org
Subject: truncate() error values (was Re: Floppy disk strange behavior)
In-Reply-To: <UTC200101092303.AAA149310.aeb@texel.cwi.nl>
Message-ID: <Pine.GSO.4.21.0101091822310.9953-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001 Andries.Brouwer@cwi.nl wrote:

> >> dd: advancing past 1 blocks in output file `/dev/fd0': Permission denied
> 
> > dd bug. It tries to ftruncate() the output file and gets all upset when
> > kernel refuses to truncate a block device (surprise, surprise).
> 
> Yes. But EPERM means that something is wrong with privileges.
	EACCES, actually.
> One would expect EINVAL or so when something is wrong with the
> way the routine was called.

Oh, agreed. Patch I've sent to Linus and posted on l-k more than a month ago:

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

That's test12-pre5. And yes, the case of files opened with O_RDONLY should
be -EINVAL according to
	* our own manpages
	* POSIX
	* *BSD behaviour
	* Solaris behaviour
	* manpages of all Unices I've seen.
-EACCES is wrong here. More logical, but...

Linus, I realize that we have a moratorium on patches. It's certainly not
a critical one, but it probably ought to be applied at some point. Could
you tell what time would be OK for resubmitting it? All it changes is
	* error returned for truncate() on directories (EACCES -> EISDIR)
	* error returned for truncate() on other non-file (EACCES -> EINVAL)
	* error returned for ftruncate() on O_RDONLY fds (EACCES -> EINVAL)
	* error returned for ftruncate() on non-files (EACCES -> EINVAL)
In all cases new error values are what we are required to do by POSIX, SuS,
our own manpages, manpages of other Unices and actual behaviour of other
Unices.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
