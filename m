Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281650AbRKUHgY>; Wed, 21 Nov 2001 02:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281651AbRKUHgQ>; Wed, 21 Nov 2001 02:36:16 -0500
Received: from h00010256f583.ne.mediaone.net ([66.31.45.140]:42882 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S281650AbRKUHgG>; Wed, 21 Nov 2001 02:36:06 -0500
Message-Id: <200111210736.fAL7afd29922@portent.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
From: Lev Makhlis <mlev@despammed.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: Bug or feature? Priority in /proc/<pid>/stat for RT processes
Date: Wed, 21 Nov 2001 02:36:41 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111200551.fAK5pp2209301@saturn.cs.uml.edu>
In-Reply-To: <200111200551.fAK5pp2209301@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 12:51 am, Albert D. Cahalan wrote:
> Lev Makhlis wwrites:
> > On Monday 19 November 2001 06:31 am, Albert D. Cahalan wrote:
> >> I can tell you what procps will do. The very first thing is
> >> to undo your transformation. Don't bother having the kernel
> >> muck with the numbers. The procps code will transform the
> >> numbers as needed to match UNIX convention and/or the tools
> >> which users run to set these values.
> >
> > Hmm, how would you explain that the kernel mucks with the numbers
> > for SCHED_OTHER, but not for SCHED_FIFO/SCHED_RR?
>
> Long ago, the kernel didn't muck with the numbers. It has to
> do that now because the numbers used inside the kernel are
> different than they used to be. If the interface were being
> designed today, it could supply the raw numbers.

Yes, and then there would be no question about supplying the raw
numbers for FIFO/RR as well.  I'm not sure, though, that it would be
such a good idea, because the raw numbers for SCHED_OTHER
do not have a rigid scale -- it changes with the definition of HZ.
It wouldn't be trivial for an app programmer to find out just how high
on the priority scale a particular process is.

>
> > IIRC, procps does not attempt to undo the f(x) = 20 - (10x + 5) / 10
> > (assuming HZ=100) transformation currently used for SCHED_OTHER.
>
> Yes it does, more-or-less. This depends on what is being
> supplied to the user. You can have the data UNIX-style,
> SunOS-style, and traditional Linux-style. Like this:
>
> ps -eo pri,opri,priority

But you can't have the raw task->counter value, can you?
I don't think it's possible, since the mapping is not 1-1.

>
> > Granted, procps can do the transformation itself, but procps does not
> > have a monopoly on using procfs data -- any other performance-monitoring
> > application would have to duplicate the transformation, if it is to be
> > consistent with the standard (procps) tools.  I thought it would be
> > nice if the kernel provided a consistent interface through procfs to
> > begin with.
>
> Maybe you should consider why, if true, the kernel internals
> are not consistent with the API.

I can only speculate that it's for the same reason that /proc/partitions
shows sizes in units of 1024 regardless of the actual block size, and
that /proc/stat shows CPU times in units of 10ms even if HZ is redefined
to something other than 100 -- so that the API remains backward-compatible
as the kernel internals continue to evolve.

 Perhaps this isn't a performance
> advantage. I also wonder why RT tasks have a separate priority
> in the task struct when they leave the regular one unused and
> regular tasks leave the RT one unused. If these could be the same
> data type, then there isn't even any need for a union.

I do not claim to understand all of the scheduler code, but it appears
to me that the regular priority field still has some limited use for
RT processes, especially for RR.

>
> For compatibility with the rest of the world, procps needs to
> display the scheduling policy ("RR", "TS", etc.) and remap RT
> priority values in several different ways. Having the kernel
> remap values just obfuscates what the data really means, making
> more work for every app developer and wasting kernel CPU time.

Frankly, as an app developer, I can't see the benefit of having
the raw values, as long as I get a 1-1 mapping.  For example, when
I am programming on Solaris, I know that FIFO/RR priorities can range
from 0 (lowest) to 59 (highest) when I look at them via /proc, or
from 100 (lowest) to 159 (highest) when using the POSIX interface
(<sched.h>).  On HP-UX, I know that they range from -32 (highest)
to -1 (lowest) when using pstat(), or from 0 (lowest) to 31 (highest)
when using sched_*().  And on Tru64 Unix, they can be between 0
(highest) and 63 (lowest)  when using the mach interface, or between
0 (lowest) and 63 (highest) when using sched_*().  In each case,
there is a 1-1 mapping between the POSIX values and the "native"
values that are used by ps/top by default.  In each case, I don't know
which values the kernel uses internally -- could be the POSIX ones,
the "native" ones, or neither.  I simply fail to see what additional
benefit I would have if I knew, for example, that Solaris really uses
values from 300 to 359 (just an off the wall example) under the hood.
Unless, perhaps, I wanted to bypass the API and read the priority
straight from process tables in /dev/kmem or something.

On Linux, I know the RT priorities range from 1 (lowest) to 99 (highest)
in the POSIX interface, and I happen to know, thanks to source
availability, that 1..99 is used internally.  Would I see anything wrong
with Linux, unlike the other platforms, providing exactly the same
numbers through its "native" (procfs) interface? Not at all.  My only
objection is that it would be inconsistent with the mapping for
SCHED_OTHER that's already in place, which is from -20 (highest)
to 20 (lowest).  I am saying the scales should either both go upwards,
or both go downwards.  I suggested a reversal of the RT scale
because I doubt a reversal of the TS scale would be readily accepted
at this stage, but maybe I'm wrong...
