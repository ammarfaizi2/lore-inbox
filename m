Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154095-17165>; Thu, 3 Dec 1998 03:38:51 -0500
Received: from noc.nyx.net ([206.124.29.3]:2803 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <156131-17165>; Wed, 2 Dec 1998 22:53:59 -0500
Date: Wed, 2 Dec 1998 23:07:22 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199812030607.XAA12107@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Wed Dec  2 23:07:22 1998, Sender=colin, Recipient=linux-kernel@vger.rutgers.edu, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: Linux timekeeping plans
Sender: owner-linux-kernel@vger.rutgers.edu

I've been formulating a plan for improving Linux's NTP performance
and general timekeeping.  There are a number of interesting problems
to deal with, and I have solutions to most of them.

I'll refer people to the NTP papers to see how that works.  Basically,
you need to find a reliable estimate of how much your current clock is off
from the desired time and then use that information to correct the clock.
The problem of correcting as quickly as possible without overcorrecting
an becoming unstable is so interesting that there is an entire branch
of mathematics called "control theory" devoted to it.)

The NTP documentation talks about a clock that ticks at a fixed rate,
and every ticks adds some delta to the "current time", then changes
that delta appropriately.

There is an equivalent formulation which just uses a ticks count and
then computes current_time = time_base + ticks * delta whenever
current_time is desired.  For the very high-resolution ticks
available nowadays (like the TSC in 586 processors and up) this is
the way to go.

If you want to change delta to delta' as of a specific change_ticks,
then you need to choose time_base' so that current_time doesn't change
at that moment, so
time_base + change_ticks * delta = time_base' + change_ticks * delta'.

This has the obvious solution
time_base' = time_base + (delta-delta') * change_ticks.

In fact, a slightly more efficient formulation is
current_time = time_base + (ticks - tick_base) * delta.
At the expense of periodically recomputing the numbers, this reduces the
cost to query the current time by making the multiplication smaller and
more manageable.

The only thing that you have to be careful of is that anyone using
the numbers reads them atomically.


Anyway, a typical PC has two clock crystals in it.  One is a 14.385 MHz
crystal which is fed to a PLL chip to produce the 60/66/100 MHz bus
cloxk and the 12 MHz serial/USB clock as well as divided by 12 to
feed the programmable timer.

The second is a 32768 Hz timekeeping crystal used by the battery-backed
clock.  While the higher-speed crystal is theoretically more stable,
it turns out that such crystals are used in applications which don't
care very much about long-term stability, so manufacturers don't pay
much attention to it.  32768 Hz crystals, on the other hand, are used
almost exclusively in timekeeping applications, and manufacturers do
take care to achieve good performance.

(See http://bul.eecs.umich.edu/uffc/quartz/vig/vigtoc.htm for a very thorough
education on the subject of quartz crystals.)

Because of this, I want to use the RTC as the primary long-term
clock in the system.  The TSC (or programmable tick timer, for
systems without a TSC) will be slaved to the RTC.  The TSC is
in turn used as the source of gettimeofday() and other
routine system timekeeping.

Slaving the clock does require some care, but because the interrupt
latency situation inside a single box is not nearly as messy as
internet delays that NTP deals with, the algorithms aren't as
complex.  Interrupts can be delayed, but they never arrive early,
so I have a "minimum filter" that seems to work very well at
removing the noise from interrupt arrival times.

There are two ways to slave the TSC to the RTC clock.  The nicest is
to have the RTC generate periodic interrupts.  (This can be used with
the existing RTC interrupt support by programming the interrupts
to the highest requested rate and dividing down in software for the
application that wants them less often.  Since RTC interrupts are
always a power of two per second, there is no error.)

Alan Cox has pointed out to me that there are some machines which Linux
runs on which have an RTC, but the RTC interrupt output is wired to
the reset line.  (The idea is that the programmable alarm is used
as a watchdog timer.)  In this case, more hair is required.
The system tick interrupt has to read the RTC and compare what
it reads with the predicted value.  Since (unlike when asking the RTC
for interrupts) there's no way to tell where in a second you are when
you read the RTC, you have to do more measurement and averaging to
get an accurate read.  This results in less accurate tracking, but the
number of systems affected is small.

(It's possible to limit the frequency of slow RTC reading by noticing that
the important times to read it are just before and just after the second
ticks over.)


One of the annoyances in using the TSC is that many systems don't keep
the clock rate constant, but slow it down for power saving.  Fortunately,
it's easy for the idle task to set a flag saying that it's done something
(like called APM idle or halted the processor on Cyrix chips) which
might have messed up the TSC.  It's also possible to set a flag telling
the idle task not to do those things for a while if we need a while to
recalibrate the clock.

Any time the TSC is misbehaving, we fall back to using the programmable
tick timer for timekeepimg.  (Or at least verifying the TSC time
against that.)  Of course, there are problems with the PIT (programmable
interval timer) too.  The microsecond timer patches or the PC audio speaker
patch needs to reprogram the timer on the fly.  This can, however, be
compensated for.

APM power down is even more fun, since we need to reinitialize the
higher-resolution clocks from the RTC on power up.  But since the code
is continuously tracking the exact relationship between the RTC and
the TSC, it isn't terribly difficult.  The only gotcha is taking less
than a second to do it.  My current proposal is to, on wakeup, read
the RTC and set the system time to the beginning of the current second
(or the sleep time, if we have been asleep less than a second).  Then,
when the second ticks over, jump the time forward by the appropriate
fraction of a second.  This fractional forward jump is pretty harmless,
especially since it just looks like an unexpected pause to the software
and the APM power down has already messed up anything that is going
to be confused by an unexpected pause.


I've been using PC-architecture-specific terms, but most other machines
have equivalents to all of these things, and fall somewhere within the
spectrum of possibilities spanned by various PC hardware.


The one thing that I'm still stuck on is SMP issues.  While it appears
that the TSC counters are kept synchronized by current SMP PC hardware,
this is not guaranteed, and other processors probably behave differently.
I have to find a way to keep everything ticking together by somehow
synchronizing all of the TSC registers to each other.  The unpredictable
way that

I could really use an understanding of Linux's SMP interrupt architecture.
That is, I need to understand what is guaranteed on *all* platforms,
so I can write portable code, rather than taking avantage of what
happens to work.

Currently, as I understand it, external interrupts are delivered to one
processor, but how that processor is chosen is undefined.  It may or
may not be the same processor that received the last instance of that
external interrupt.  And in particular, there is no guarantee that a
particular processor will ever see a particular external interrupt.

This makes generating a single systemwide clock a bit tricky.  Some
inter-processor interrupts will definitely be required, but I don't
know if I can create a special one for timekeeping purposes.
Can I create a broadcast interrupt which all processors use for
timekeeping?

The one tricky thing about interrupts is that they can be delayed.
Rather a lot, in fact.  Fortunately, they can never arrive early,
so in the case of inter-processor synchronization, there's an easy
fix.  If I suspect that processor 2's clock is fast relative to
processor 1, I have processor 2 send an interrupt to processor 1.
Each processor keeps track of the time of the interrupt.  If the
time that processor 1 thinks it arrived is before the time that
processor 2 thinks it sent it, then there is definitely an error.

But keeping track of this back-and-forth is going to be just a bit hairy.

On a UP, one possible approach to timekeeping is to have the kernel
export the TSC->time conversion factors and let the C library
implement gettimeofday() entirely in user space.  (Of course,
one of the state variables would be "TSC unreliable; trap to kernel
for more complex handling.")  I don't see how this is possible on
SMP, since there's no atomic way to read the TSC *and* know which
processor you're reading it on.

Anyway, that's a (hopefully not *too* confusing) dump of my current
thinking.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
