Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264926AbSJ3VHM>; Wed, 30 Oct 2002 16:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264927AbSJ3VHM>; Wed, 30 Oct 2002 16:07:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33039 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264926AbSJ3VHK>; Wed, 30 Oct 2002 16:07:10 -0500
Date: Wed, 30 Oct 2002 16:12:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andreas Dilger <adilger@clusterfs.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
In-Reply-To: <20021030004457.GC22170@bjl1.asuk.net>
Message-ID: <Pine.LNX.3.96.1021030155404.14229A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Jamie Lokier wrote:

> Bill Davidsen wrote:
> > I admit to being one of the "thousands" people, and even if I have 100k
> > inodes (more likely to be 10% of that) it's in the order of a MB, and any
> > machine which has 100k inodes open is likely to be large enough to ignore
> > a MB. One advantage of keeping the HRT in the in-core inode is that it
> > allows parallel make to work correctly even on a filesystem which doesn't
> > have space to save that information.
> > 
> > Feel free to tell me if that last isn't true.
> 
> It isn't true if the parallel make actually uses your RAM for
> something, thus flushing some of the inodes from RAM.

Hopefully it is being smart about doing that, or rather not doing that.
But that would be a good thing to add to my responsiveness benchmark, to
access a file, do a stat, and then do another stat later. Thanks for the
idea, I expect to release a new version sometime this weekend.
 
> Admittedly it is no worse than we have at the moment.  However, at the
> moment it is possible, to construct a "make" or other program of that
> ilk which can always make a safe decision: if it's ambiguous whether a
> file needs to be remade, then remake the file.
> 
> As soon as we have inodes time stamp resolution being spontanously
> lowered (because some of the inodes are flushed from RAM and some
> aren't), then it's not possible to make a safe program like that
> anymore, unless you simply ignore the high resolution time stamps
> _all_ the time, even when they are present.
> 
> You can just do that - it's correct behaviour.  But it would be better
> to use the high precision when available, as that reduces the number
> of unnecessary remakes.

I have to think about the point you raise of doing it one way or the other
but not mixing. I had assumed that the inode of a file which was open
would remain in core, and I want to look at the code before I form an
opinion. If the file is not open or the inode is a non-file...
 
> > 4 - the time could be stored in register values, ticks, or whatever else,
> > avoiding any conversion to ns. Then the time could be converted only when
> > the inode was read, written out, etc. 
> > 
> > I'd really like your comments on these, you probably see things I've
> > missed.
> 
> I know of exactly one application which depends on atime information:
> checking whether you have new mail in your inbox.  That's done by
> comparing atime and mtime on the mailbox.  Mail readers read the file
> after writing it, MTAs will simply write it.
> 
> For this to function correctly, what's important is that the atime is
> updated to be at least the mtime.  So for nanosecond atime updates, it
> makes sense that the _first_ read following a write should update the
> atime -- if not using the current clock, then simply copying the mtime
> value.

I think you may have missed the point of (4), some of the overhead of
keeping HRT is the conversion of data to ns from some machine dependent
information. Where possible the base information, such as a register,
could be stored with a flag, avoiding the "convert to ns" CPU usage. The
conversion could be done when the data was used, before save, at the time
of a stat, etc. I have the feeling that would take some of the sting out
of keeping HRT. It doesn't matter if it's atime, mtime or ctime, the atime
was in response to "nobody uses HRT atime" in an earlier post.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

