Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131774AbRCUURM>; Wed, 21 Mar 2001 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131775AbRCUURC>; Wed, 21 Mar 2001 15:17:02 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:3589 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131774AbRCUUQu>; Wed, 21 Mar 2001 15:16:50 -0500
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.33.0103211738240.1981-100000@mikeg.weiden.de>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Mike Galbraith's message of "Wed, 21 Mar 2001 17:45:30 +0100 (CET)"
Date: 21 Mar 2001 14:16:06 -0600
Message-ID: <vba4rwm6fp5.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:
> 
> Yes.  I'm so used to UP numbers I didn't think.  I saw user larger than
> real on my UP box yesterday during some testing, and then seeing this
> post... oops.

Okay, so you see "user > real" on a UP box running an SMP kernel.

First, I'm not really familiar with this part of the kernel, but as I
understand things (and others will correct me if I'm wrong) ...

The "real time" is calculated by subtracting the "gettimeofday" before
and after running the process.  The "user" and "system" times are
sampled times updated every timer tick.

A discrepancy of a hundredth of a second is perfectly normal.
"gettimeofday" uses a neat trick to get microsecond accuracy, but the
user and system times only have one timer tick (1/HZ=.01sec on i386)
resolution.  For this reason, any CPU intensive program can give
slightly (within .01sec or so) higher user than real:

    buhr@saurus:~/src/cpuburn/cpuburn-1.2$ time ./burnP6
    real    0m6.438s
    user    0m6.440s
    sys     0m0.000s
    ^C
    buhr@saurus:~/src/cpuburn/cpuburn-1.2$

If your discrepancy is bigger than a couple hundredths of second, it
gets more complicated.

In an SMP kernel, the jiffies are updated by the "do_timer" function,
and the timer bottom half uses the jiffies to update the time of day.
On the other hand, the user and system times are updated by the
"smp_local_timer_interrupt".

On an SMP motherboard (one with an APIC), "do_timer" is invoked by
timer ticks from the dedicated timer chip, but "smp_local_timer_
interrupt" is invoked by a timer on the APIC chip.  These two timers
will run at nearly the same speed (HZ times per second), but not
exactly.  If the APIC timer is significantly faster, you can have
user+system>real on an SMP motherboard, even though it only has one
processor installed!

So, the first question is, does your "UP" box really have a UP-only
motherboard?  That is, in your bootup messages, do you see a line like
this:

   Mar  5 15:32:28 mozart kernel: SMP motherboard not detected. Using
   dummy APIC emulation.

If you don't see such a line, this might be the problem: the real time
is based on a different timer than the user and system times.  
I believe the APIC timer is based on bus frequency.  If you're over-
or under-clocking your board, you may see huge discrepancies.

If you *do* see the emulation message, then "do_timer" and
"smp_local_timer_interrupt" are both called exactly once on every
timer tick, so there is no discrepancy possible there.

However, the "gettimeofday" time isn't just based on the jiffies
count.  The time adjustment parameters (set by the adjtimex(2) system
call) can modify the "gettimeofday" time away from what would normally
be calculated from jiffies alone.  If you are running a time daemon,
like NTP, if you've run "ntpdate" at bootup and a time adjustment is
in progress, or if you've used the "adjtimex" utility directly to make
your system clock more accurate, then that could also account for the
discrepancy.

In any event, if the discrepancy is large: if user, for a
single-threaded process, exceeds the real time by more than 1% (or a
few hundredths of a second, whichever is greater) on any system, I
think this indicates a serious problem.

Kevin <buhr@stat.wisc.edu>
