Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSBNA0r>; Wed, 13 Feb 2002 19:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289228AbSBNA0i>; Wed, 13 Feb 2002 19:26:38 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:398 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289226AbSBNA0Y>;
	Wed, 13 Feb 2002 19:26:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [patch] sys_sync livelock fix
Date: Thu, 14 Feb 2002 01:26:42 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>, viro@math.psu.edu
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b9jW-0002QL-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 11:24 pm, Bill Davidsen wrote:
> On Wed, 13 Feb 2002, Daniel Phillips wrote:
> 
> > On February 13, 2002 04:46 am, Jeff Garzik wrote:
> 
> > > Yow, your message inspired me to re-read SuSv2 and indeed confirm,
> > > sync(2) schedules I/O but can return before completion,
> > 
> > I think that's just stupid and we have a duty to fix it, it's an anachronism.
> > The _natural_ expectation for the user is that sync means 'don't come back
> > until data is on disk' and any other interpretation is just apologizing for
> > halfway implementations.
> 
> Feel free to join a standards committee.

I did, it's the LCSG (Linux Cabal Standards Group) :-)

> In the mean time, I agree we have
> a duty to fix it, since the current implementation can hang forever
> without improving the securty of the data one bit, therefore sync(2)
> should return after all data generated before the sync has been written
> and not wait for all data written by all processes in the system to
> complete.

Yes, absolutely, that's a bug.

> BTW: I think users would expect the system call to work as the standard
> specifies, not some better way which would break on non-Linux systems. Of
> course now working programs which conform to the standard DO break on
> Linux.

No, it should work in the _best_ way, and if the standard got it wrong then
the standard has to change.

> > For dumb filesystems, this can degenerate to 'just try to write all the dirty
> > blocks', the traditional Linux interpretation, but for journalling filesystems
> > we can do the job properly.
> 
> It doesn't matter, if you write the existing dirty buffers the filesystem
> type is irrelevant.

Incorrect.  The modern crop of filesystems has the concept of consistency
points, and data written after a consistency point is irrelevant except to the
next consistency point.  IOW, it's often ok to leave some buffers dirty on a
sync.  But for a dumb filesystem you just have to guess at what's needed for
a consistency point, and the best guess is 'whatever's dirty at the time of
sync'.

For metadata-only journalling the issues get more subtle and we need a ruling
from the ext3 guys.

> And if you have cache in your controller and/or drives
> the data might be there and not on the disk.

We're working on that, see Jen's recent series of patches re barriers.

> If you have those IBM drives
> discussed a few months ago and a bad sector, the drive may drop the data.
> The point I'm making is that doing it really right is harder than it
> seems.

That's being worked on too, see Andre Hedrik's linuxdiskcert.org.

> Also, there are applications which don't like journals because they create
> and delete lots of little files, or update the file information
> frequently, resulting in a write to the journal. Sendmail, web servers,
> and usenet news do this in many cases. That's why the noatime option was
> added.

Sorry, I don't see the connection to sync.

> > > while fsync(2) schedules I/O and waits for completion.
> > 
> > Yes, right.
> > 
> > > So we need to implement system call checkpoint(2) ?  schedule I/O,
> > > introduce an I/O barrier, then sleep until that I/O barrier and all I/O
> > > scheduled before it occurs.
> > 
> > How about adding: sync --old-broken-way
> 
> The problem is that the system call should work in a way which doesn't
> violate the standard.

Waiting until the data is on the platter doesn't violate SuS.

> I think waiting for all existing dirty buffers is
> conforming, waiting until hell freezes over isn't,

Where does it say that in SuS?  I not arguing in favor of waiting longer
than necessary, mind you.

> nor does it have any
> benefit to the user, since the sync is either an end of the execution
> safety net or a checkpoint. In either case the user doesn't expect to have
> the program hang after *his/her* data is safe.

Have you asked any users about that?

-- 
Daniel
