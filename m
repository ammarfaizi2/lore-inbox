Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264937AbSJVUOt>; Tue, 22 Oct 2002 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264928AbSJVUNu>; Tue, 22 Oct 2002 16:13:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8190 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264903AbSJVUMm>;
	Tue, 22 Oct 2002 16:12:42 -0400
Message-ID: <3DB5A60B.12FFDBA6@mvista.com>
Date: Tue, 22 Oct 2002 12:24:59 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mbs <mbs@mc.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Son of crunch time: the list v1.2.
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <200210211642.10435.landley@trommello.org> <3DB4F410.EC91CC5F@mvista.com> <200210221232.IAA03454@mc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbs wrote:
> 
> On Tuesday 22 October 2002 02:45, george anzinger wrote:
> > > > > 9) High resolution timers (George Anzinger, etc.)
> > > > > http://high-res-timers.sourceforge.net/
> > > >
> > > > no comment, I've heard arguments that high-res timers would be useful,
> > > > but haven't read the patch myself so won't comment...
> > >
> > > I vaguely remember Linus had some objections that it plays with the clock
> > > tick and potentially penalizes everybody...  Hmmm...
> > >
> > > A quick google comes up with this:
> > >
> > > http://www.cs.helsinki.fi/linux/linux-kernel/2002-28/0360.html
> >
> > Hm, I had not seen this.  He is right, but the patch
> > provides an out :)  The standard says a timer can overrun.
> > If a timer is repeating so fast as to bogdown the system,
> > the code lumps enough of them to unload the system into the
> > overrun count and doesn't take the interrupts.
> >  -g
> 
> (I haven't done my homework and looked in your patch)
> 
> you did notice the bit in posix about repeating timers and how you dont
> reinsert a repeating timer until the signal handler has completed, right?

What the standard says is that only one signal is to be
queued for a given timer.  Subsequent expires of the same
timer then just bump the overrun count.  This is what the
patch does, but still this could overload the timer list and
interrupt code, so in addition to the standard required
overrun stuff, the code checks the next expire time and
fudges a time at least X microseconds from now, where the
time is a multiple (Y) of the repeat time + the current
expire time.  Y is then added to the overrun count to
account for the missing expires.
> 
> that one bit me and we actually had to reimplement portions of our signals
> mechanism to accomodate it.

Yes, the signal code needs to check for that pending timer. 
And NOW (i.e. 2.5) it can be in either the shared list or
the local list or both :(.  This is in the patch.
> 
> that behavior ensures that a POSIX timer can't entirely dominate the system
> (although it certainly can put a hurt on as can any number of other ill
> advised programming blunders)

I would be open to requiring a capability to run the repeat
time below a fixed value if this would make folks happier. 
It would send the right message to the user, too, i.e. small
repeat counts can be hazardous to your system.
> 
> it however doesn't do anything for kernel things using the timer
> infrastructure....

The interesting thing is that we don't currently have an in
kernel call such as delay, etc.  You just use add_timer(). 
AND none of the possible interfaces I have seen or
considered even hint at needing repeating timers.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
