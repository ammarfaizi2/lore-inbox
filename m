Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSBMW1w>; Wed, 13 Feb 2002 17:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289017AbSBMW1n>; Wed, 13 Feb 2002 17:27:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53767 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289015AbSBMW12>; Wed, 13 Feb 2002 17:27:28 -0500
Date: Wed, 13 Feb 2002 17:24:38 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <E16b14Z-0001oR-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Daniel Phillips wrote:

> On February 13, 2002 04:46 am, Jeff Garzik wrote:

> > Yow, your message inspired me to re-read SuSv2 and indeed confirm,
> > sync(2) schedules I/O but can return before completion,
> 
> I think that's just stupid and we have a duty to fix it, it's an anachronism.
> The _natural_ expectation for the user is that sync means 'don't come back
> until data is on disk' and any other interpretation is just apologizing for
> halfway implementations.

Feel free to join a standards committee. In the mean time, I agree we have
a duty to fix it, since the current implementation can hang forever
without improving the securty of the data one bit, therefore sync(2)
should return after all data generated before the sync has been written
and not wait for all data written by all processes in the system to
complete.

BTW: I think users would expect the system call to work as the standard
specifies, not some better way which would break on non-Linux systems. Of
course now working programs which conform to the standard DO break on
Linux.
 
> Sync should mean: come back after all filesystem transactions submitted before
> the sync are recorded, such that if the contents of RAM vanishes the data can
> still be retrieved.

We agree on that, and it doesn't violate the standard. What we do now
doesn't.
 
> For dumb filesystems, this can degenerate to 'just try to write all the dirty
> blocks', the traditional Linux interpretation, but for journalling filesystems
> we can do the job properly.

It doesn't matter, if you write the existing dirty buffers the filesystem
type is irrelevant. And if you have cache in your controller and/or drives
the data might be there and not on the disk. If you have those IBM drives
discussed a few months ago and a bad sector, the drive may drop the data.
The point I'm making is that doing it really right is harder than it
seems.

Also, there are applications which don't like journals because they create
and delete lots of little files, or update the file information
frequently, resulting in a write to the journal. Sendmail, web servers,
and usenet news do this in many cases. That's why the noatime option was
added.
 
> > while fsync(2) schedules I/O and waits for completion.
> 
> Yes, right.
> 
> > So we need to implement system call checkpoint(2) ?  schedule I/O,
> > introduce an I/O barrier, then sleep until that I/O barrier and all I/O
> > scheduled before it occurs.
> 
> How about adding: sync --old-broken-way

The problem is that the system call should work in a way which doesn't
violate the standard. I think waiting for all existing dirty buffers is
conforming, waiting until hell freezes over isn't, nor does it have any
benefit to the user, since the sync is either an end of the execution
safety net or a checkpoint. In either case the user doesn't expect to have
the program hang after *his/her* data is safe.
 
> On this topic, it would make a lot of sense from the user's point of view to
> have a way of syncing a single volume, how would we express that?

I have an idea, I'll put it in another message, since only two of us are
likely to be reading at this point.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

