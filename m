Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSAAW5t>; Tue, 1 Jan 2002 17:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286325AbSAAW5j>; Tue, 1 Jan 2002 17:57:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23499 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286331AbSAAW51>;
	Tue, 1 Jan 2002 17:57:27 -0500
Date: Tue, 1 Jan 2002 17:57:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: NFS "dev_t" issues..
In-Reply-To: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201011752200.16467-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Jan 2002, Linus Torvalds wrote:

> Apart from some knfsd issues, most of the kdev_t users were proper. The
> strict type-checking found one bug in the SCSI layer (which I knew about,
> and was one of the impetuses for doing it in the first place), and found a
> lot of small "works-but-will-break-with-a-bigger-kdev_t" issues).

Sigh...  Most of the ->i_dev instances are crap and ought to be replaced
with ->i_sb.  At the very least, let's

--- C2-pre6/fs/namei.c	Tue Jan  1 17:49:13 2002
+++ /tmp/namei.c	Tue Jan  1 17:54:08 2002
@@ -1589,7 +1589,7 @@
 		goto exit_lock;
 
 	error = -EXDEV;
-	if (!kdev_same(dir->i_dev, inode->i_dev))
+	if (dir->i_sb != inode->i_sb)
 		goto exit_lock;
 
 	/*
@@ -1707,7 +1707,7 @@
 	if (error)
 		return error;
 
-	if (!kdev_same(new_dir->i_dev, old_dir->i_dev))
+	if (new_dir->i_sb != old_dir->i_sb)
 		return -EXDEV;
 
 	if (!new_dentry->d_inode)
@@ -1787,7 +1787,7 @@
 	if (error)
 		return error;
 
-	if (!kdev_same(new_dir->i_dev, old_dir->i_dev))
+	if (new_dir->i_sb != old_dir->i_sb)
 		return -EXDEV;
 
 	if (!new_dentry->d_inode)

