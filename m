Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262763AbSJGUZE>; Mon, 7 Oct 2002 16:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262764AbSJGUZE>; Mon, 7 Oct 2002 16:25:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12020 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262763AbSJGUY6>;
	Mon, 7 Oct 2002 16:24:58 -0400
Message-ID: <3DA1EDB6.66CB2472@mvista.com>
Date: Mon, 07 Oct 2002 13:25:26 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Dave Hansen <haveblue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] HZ as a config option
References: <3D9E1BEA.7060804@us.ibm.com> <1033779196.1335.8.camel@irongate.swansea.linux.org.uk> <3DA1BD51.6040003@us.ibm.com> <3DA1C3F1.56B709FC@mvista.com> <20021007212753.B833@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Mon, Oct 07, 2002 at 10:27:13AM -0700, george anzinger wrote:
> > Dave Hansen wrote:
> > >
> > > Alan Cox wrote:
> > > > On Fri, 2002-10-04 at 23:53, Dave Hansen wrote:
> > > >
> > > >>On large systems (like NUMA-Q, Intel Profusion, etc...), latency and
> > > >>user responsiveness become much less important.  The extra scheduling
> > > >>overhead caused by higher HZ is bad.
> > > >>
> > > >>This is x86-only right now.  Is there any wider desire to tune this at
> > > >>config time?  Do any architecutures have strict rules as to what this
> > > >>can be set to?
> > > >
> > > > You can't set this arbitarily, the NTP PLL's will only lock for certain
> > > > value ranges.
> > >
> > > Where can I find these ranges?  include/linux/timex.h only errors if
> > > the number is out of the 12-1535 range.
> >
> > The issue is not the value itself, but if, by using the
> > value and the PIT with its clock of 14.3181818/12 MHZ you
> > can come up with a count that is ?? parts per million of
> > being right.  I am not sure what ?? should be but 20 comes
> > to mind.
> >
> > All this is (incorrectly) covered over in 2.5 by using a
> > more "correct" value for tick_nsec.  This keeps the wall
> > clock correct for most any value of HZ, BUT breaks the POSIX
> > standard that says NO TIMER SHALL EXPIRE BEFORE ITS TIME.
> > To prove this breakage, try this on a 2.5 system:
> >
> > time sleep 60
> >
> > Any answer less than 1 minute is BROKEN.
> 
> 1 minute universal time or 1 minute gettimeofday time or 1 minute
> internal kernel time?

I think you miss my point.  The current 2.5 kernel does not
sleep long enough on ANY request.  By sleeping 60 seconds,
the error becomes so big that it washes out the "time"
program latency giving a value less than 60 seconds in the
above answer.  The problem is that the system sleeps on 1/HZ
time but does NOT up date the wall clock by 1/HZ each tick. 
Instead it uses a value that more correctly represents the
actual time between the 1/HZ ticks.  Problem is this
violates the POSIX standard in that a call to gettimeofday
before and after a sleep should ALWAYS say the sleep took at
least the requested amount of time (assuming it was not
interrupted by any signals).
> 
> The current kernels do the last ...
> I guess correct would probably be the second ...

The "correct" answer IMHO is, baring over time setting, that
internal kernel time (what POSIX calls CLOCK_MONOTONIC time)
should track down to the nanosecond.  I.e. NTP should change
the 1/HZ tick size, which in turn will change the wall
clock.

> While the first is what the user would expect. ;_
> 
> Anyway, if you do an usleep(20000) on a 2.4 (with 100 Hz timer), you
> probably expect it to sleep two (and not three) ticks, while with NTP
> running you can easily get that it took 19998 usec. Or do we really want
> it to go off at 39997 us?

The above problem is NOT related to NTP at all.  But what
you are saying is true, i.e. NTP could make the timers
complete early.  Another reason to keep the clocks in sync.
> 
> > I think the correct way to do all this is to use something
> > other than the PIT as the clock reference AND adjust the
> > jiffies time, not the wall clock.
> >
> > The High-res-timers patch I posted last Friday does the
> > first part, i.e. uses a different clock reference.  The NTP
> > changes will come later.
> 
> Btw, current kernel NTP implementation (at least 2.4, didn't check 2.5
> yet, but it looks very similar) is broken enough, that with NTP running,
> the time can jump -1us or -2us backward if the 14.318... MHz clock in
> the computer goes slightly faster than it should per spec. Errors of
> +200 ppm are quite common.

This is caused by using the TSC to fill in the under 1/HZ
info AND not adjusting the conversion constant used to
convert TSC to micro seconds.  A more correct implementation
would change this conversion number as well at the wall
clock tick size.

I have in mind a solution to all of this that involves
adjusting the conversion values that convert the reference
clock to jiffies.  The reference clock could be the TSC or
the ACPI pm timer (code done) or some other timer (to be
coded).
> 
> This is quite a problem ...

Yes, out astronomy friends agree.
> 
> --
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
