Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSGQSES>; Wed, 17 Jul 2002 14:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSGQSES>; Wed, 17 Jul 2002 14:04:18 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:65208 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316519AbSGQSER>; Wed, 17 Jul 2002 14:04:17 -0400
Message-Id: <5.1.0.14.2.20020717185356.00ae4ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Jul 2002 19:07:24 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [patch 13/13] lseek speedup
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D35A024.1635E12E@zip.com.au>
References: <3D3598F0.FBBA9DB6@zip.com.au>
 <5.1.0.14.2.20020717171311.00b00380@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:49 17/07/02, Andrew Morton wrote:
>Anton Altaparmakov wrote:
> >
> > >  Now, why are we taking i_sem for lseek/readdir
> > >exclusion and not a per-file lock?
> >
> > Because it also excludes against directory modifications, etc. Just imagine
> > what "rm somefile" or "mv somefile otherfile" or "touch newfile" would do
> > to the directory contents and what a concurrent readdir() would do... A
> > very loud *BANG* is the only thing that springs to mind...
>
>That's different.  i_size, contents of things, yes - i_sem for
>those.
>
>But protection of struct file should not be via any per-inode thing.

Oh, I see. But that would mean adding yet another lock to an existing 
locking scheme? So both i_sem and the "per file lock" would nead to be held 
over readdir(). That's doable but it would have to be a semaphore based 
lock due to readdir()...

Perhaps the f_lock from your patch, changed to a semaphore, and acquiring 
it in generic_file_llseek&friends, vfs_readdir() (and any other place where 
f_pos needs protecting) would be able to do the trick. Would that solve the 
lock contention problems you were seing? It would at least off-load i_sem a 
bit... but it would only replace one semaphore for another...

> > btw. the directory modification locking rules are written up in
> > Documentation/filesystems/directory-locking by our very own VFS maintainer
> > Al Viro himself... (-;
>
>Doesn't cover lseek...

Hm, true. I hadn't read it for quite a while...

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

