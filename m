Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSGVHka>; Mon, 22 Jul 2002 03:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSGVHka>; Mon, 22 Jul 2002 03:40:30 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:52649 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316574AbSGVHk3>; Mon, 22 Jul 2002 03:40:29 -0400
Message-Id: <5.1.0.14.2.20020722083636.00b04190@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 22 Jul 2002 08:43:49 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [patch 13/13] lseek speedup
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D3BB14F.44C93587@zip.com.au>
References: <3D35A024.1635E12E@zip.com.au>
 <5.1.0.14.2.20020717185356.00ae4ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:16 22/07/02, Andrew Morton wrote:
>Anton Altaparmakov wrote:
> > At 17:49 17/07/02, Andrew Morton wrote:
> > >Anton Altaparmakov wrote:
> > > >
> > > > >  Now, why are we taking i_sem for lseek/readdir
> > > > >exclusion and not a per-file lock?
> > > >
> > > > Because it also excludes against directory modifications, etc. Just 
> imagine
> > > > what "rm somefile" or "mv somefile otherfile" or "touch newfile" 
> would do
> > > > to the directory contents and what a concurrent readdir() would do... A
> > > > very loud *BANG* is the only thing that springs to mind...
> > >
> > >That's different.  i_size, contents of things, yes - i_sem for
> > >those.
> > >
> > >But protection of struct file should not be via any per-inode thing.
> >
> > Oh, I see. But that would mean adding yet another lock to an existing
> > locking scheme? So both i_sem and the "per file lock" would nead to be held
> > over readdir(). That's doable but it would have to be a semaphore based
> > lock due to readdir()...
>
>Adding a sleeping lock to struct file for this would make sense; using
>i_sem to protect the innards of struct file ain't right.
>
>However I'm not sure that the VFS needs to be serialising lseek
>and readdir at all.  The fs can do that if it really needs to.
>
>And does it really need to?  Setting aside the non-atomic 64-bit
>read, it may be sufficient for the fs to do what ext2_readdir
>does:  read f_pos once on entry, write it once on exit and if
>there was a concurrent lseek then its results get stomped on.
>
>Can you see any problem with that?

No problem. NTFS can very easily be turned into doing that. It would need 
to happen to all file systems and perhaps a little documentation in the 
porting document to say so for out of kernel fs...

>Anyway.  It's not exactly a top-priority thing.  I'll park
>it for a while and just stop running that test ;)

Well, I will get ntfs_readdir changed to only read/write f_pos once on 
entry/exit respectively anyway...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

