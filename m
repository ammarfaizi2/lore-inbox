Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263182AbSJBQ7b>; Wed, 2 Oct 2002 12:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263185AbSJBQ7b>; Wed, 2 Oct 2002 12:59:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:32137 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263182AbSJBQ73>;
	Wed, 2 Oct 2002 12:59:29 -0400
Message-ID: <3D9B2734.D983E835@digeo.com>
Date: Wed, 02 Oct 2002 10:04:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
References: <20021002023901.GA91171@compsoc.man.ac.uk> <20021002032327.GA91947@compsoc.man.ac.uk> <20021002141435.A18377@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2002 17:04:52.0643 (UTC) FILETIME=[D30CAF30:01C26A35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> 
> On Wed, Oct 02, 2002 at 04:23:27AM +0100, John Levon wrote:
> > --- linux-linus/fs/locks.c    Sat Sep 28 15:56:28 2002
> > +++ linux/fs/locks.c  Wed Oct  2 04:15:54 2002
> > @@ -727,11 +727,11 @@
> >       }
> >       unlock_kernel();
> >
> > -     if (found)
> > -             yield();
> > -
> >       if (new_fl->fl_type == F_UNLCK)
> >               return 0;
> > +
> > +     if (found)
> > +             yield();
> >
> >       lock_kernel();
> >       for_each_lock(inode, before) {
> >
> > "fixes" the problem (a simultaneous kernel compile is going on; it's a
> > 2-way SMP machine). What is the yield for ? What's the right fix (if
> > any) ? This turns our app's main loop from a second or two into a
> > 90-second behemoth.
> 
> I'm pretty sure this is correct.  There's no particular reason to yield()
> if we're unlocking.
> 
> I wonder if yield() is the correct call to make anyway.  We certainly need
> to schedule() to allow any higher-priority task the opportunity to run.
> But if we're the highest-priority task downgrading our write-lock to
> a read-lock which permits other tasks the opportunity to run, i see no
> reason we should _yield_ to them.
> 

sched_yield() sementics changed a lot.  It used to mean "take a quick
nap", but it now means "go to the back of the runqueue and stay there
for absolutely ages".  The latter is a closer interpretation of the spec,
but it has broken stuff which was tuned to the old behaviour.

It's not really clear why that yield is in there at all?  Unless that
code is really, really slow (milliseconds) then probably it should just
be deleted.

If there really is a solid need to hand the CPU over to some now-runnable
higher-priority process then a cond_resched() will suffice.
