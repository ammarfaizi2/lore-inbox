Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbRG0RLJ>; Fri, 27 Jul 2001 13:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267943AbRG0RLA>; Fri, 27 Jul 2001 13:11:00 -0400
Received: from rj.SGI.COM ([204.94.215.100]:21142 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S267984AbRG0RKz>;
	Fri, 27 Jul 2001 13:10:55 -0400
Message-Id: <200107271710.f6RHAVU19467@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@zip.com.au>
cc: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        Hans Reiser <reiser@namesys.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption 
In-Reply-To: Message from Andrew Morton <akpm@zip.com.au> 
   of "Sat, 28 Jul 2001 02:39:50 +1000." <3B619956.6AA072F9@zip.com.au> 
Date: Fri, 27 Jul 2001 12:10:31 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> 
> You can narrow the window of exposure by fiddling with the
> parameters in /proc/sys/vm/bdflush - force a full flush every
> five seconds, say.
> 
> >   It seems to be that any open file is
> > in danger.  I don't know if this is normal, or not, but I switched to XFS o
> n
> > several machines.  I have nothing against reiser.  I assumed that these
> > problems were due to immaturity....
> 
> I'm under the impression that XFS also leaves data in the hands
> of the kernel's normal writeback mechanisms and will thus be
> exposed to the same problem.  I may be wrong about this.
> 

Yes, XFS does leave writing the data to the normal writeback mechanisms, 
however, what happens with XFS is usually:

 o a file with no extents - the size made it out to disk but the data did not.
   since on writes to new space we do not allocate the space until we flush
   you tend not to see old data. The only way out of something like this is
   to prevent the inode size update from hitting disk until the file data
   is on disk. The performance consequences of doing that are probably 
   large.

   This situation is somewhat helped by the fact that if one page gets
   flushed by bdflush and it calls back into xfs to allocate space, we 
   will allocate space for, and flush all surrounding data in the file,
   so this may be causing earler flushing than might otherwise happen.

Since xfs usually operates with a much smaller in memory log than other
filesystems (64K default) and we have some synchronous transactions which
cause a flush of the in memory log, the amount that time can go backwards
by in a crash is a lot smaller.

Steve


