Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265374AbSKABwQ>; Thu, 31 Oct 2002 20:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265383AbSKABwJ>; Thu, 31 Oct 2002 20:52:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25617 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265374AbSKABwE>; Thu, 31 Oct 2002 20:52:04 -0500
Date: Thu, 31 Oct 2002 20:57:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andreas Dilger <adilger@clusterfs.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
In-Reply-To: <20021030221724.GA25231@bjl1.asuk.net>
Message-ID: <Pine.LNX.3.96.1021031203329.22444D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Jamie Lokier wrote:

> Bill Davidsen wrote:
> > I have to think about the point you raise of doing it one way or the other
> > but not mixing. I had assumed that the inode of a file which was open
> > would remain in core, and I want to look at the code before I form an
> > opinion. If the file is not open or the inode is a non-file...
> 
> Oh, the inode of a file which is open does remain in core.  It's just
> that between runs of a program like "make", the file's aren't open are
> they?

I thought we were talking about parallel make, rather than "between runs."
Your point is valid, but given the certainty that the inode has been
recently used, hopefully the kernel is smart on releasing them.

My first thought is that the commonly used filesystems, other than ext2,
do or will support high resolution time. NFS is its own nasty little
problem.
 
> > I think you may have missed the point of (4), some of the overhead of
> > keeping HRT is the conversion of data to ns from some machine dependent
> > information. Where possible the base information, such as a register,
> > could be stored with a flag, avoiding the "convert to ns" CPU usage. The
> > conversion could be done when the data was used, before save, at the time
> > of a stat, etc. I have the feeling that would take some of the sting out
> > of keeping HRT. It doesn't matter if it's atime, mtime or ctime, the atime
> > was in response to "nobody uses HRT atime" in an earlier post.
> 
> That's some of the overhead.  The other overhead is reading the clock,
> which is quite high on x86 when TSC is not available.  On a Pentium
> with no reliable TSC, I think that the time for a read() system call
> is comparable to the time to read the clock.

Who uses a CPU without TSC? I guess the embedded folks and the people
using really old systems. There was a suggestion on handling that posted,
but I don't have it handy. Using the field as just a counter was the idea
if I remember correctly. The NUMA folks have their own set of problems, I
won't presume to even have an opinion on how they solve it, but if it
needs doing I'm sure they can do it.

Thinking out loud:
  To avoid overhead, the kernel needs to be smart about when the updated
inode info is written to storage Perhaps on writes when the data written
actually falls off the elevator or transferred to a network peer.  Until
then the time can stay in memory, if the system goes down write data is
lost, so having the inode reflect the time of the last completed write to
storage isn't wildly wrong mtime. 

  For reads, having some bounded delay between the time of a system call
to read() and the time saved in the inode is of limited impact, as long as
the time to update the inode to storage doesn't get wildly behind the time
of the read. The one second you mentioned is probably aggressive if
anything. That might have to be a tunable.

  I haven't forgotten access via execute, I don't know if it differs from
read in practice.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

