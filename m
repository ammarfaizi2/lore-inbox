Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSGVHF0>; Mon, 22 Jul 2002 03:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSGVHF0>; Mon, 22 Jul 2002 03:05:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5904 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316535AbSGVHF0>;
	Mon, 22 Jul 2002 03:05:26 -0400
Message-ID: <3D3BB14F.44C93587@zip.com.au>
Date: Mon, 22 Jul 2002 00:16:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/13] lseek speedup
References: <3D35A024.1635E12E@zip.com.au> <5.1.0.14.2.20020717185356.00ae4ec0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> At 17:49 17/07/02, Andrew Morton wrote:
> >Anton Altaparmakov wrote:
> > >
> > > >  Now, why are we taking i_sem for lseek/readdir
> > > >exclusion and not a per-file lock?
> > >
> > > Because it also excludes against directory modifications, etc. Just imagine
> > > what "rm somefile" or "mv somefile otherfile" or "touch newfile" would do
> > > to the directory contents and what a concurrent readdir() would do... A
> > > very loud *BANG* is the only thing that springs to mind...
> >
> >That's different.  i_size, contents of things, yes - i_sem for
> >those.
> >
> >But protection of struct file should not be via any per-inode thing.
> 
> Oh, I see. But that would mean adding yet another lock to an existing
> locking scheme? So both i_sem and the "per file lock" would nead to be held
> over readdir(). That's doable but it would have to be a semaphore based
> lock due to readdir()...

Adding a sleeping lock to struct file for this would make sense; using
i_sem to protect the innards of struct file ain't right.

However I'm not sure that the VFS needs to be serialising lseek
and readdir at all.  The fs can do that if it really needs to.

And does it really need to?  Setting aside the non-atomic 64-bit
read, it may be sufficient for the fs to do what ext2_readdir
does:  read f_pos once on entry, write it once on exit and if
there was a concurrent lseek then its results get stomped on.

Can you see any problem with that?

Anyway.  It's not exactly a top-priority thing.  I'll park
it for a while and just stop running that test ;)

-
