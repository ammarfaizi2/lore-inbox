Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313415AbSC2J00>; Fri, 29 Mar 2002 04:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313417AbSC2J0R>; Fri, 29 Mar 2002 04:26:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36858 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313415AbSC2JZ7> convert rfc822-to-8bit;
	Fri, 29 Mar 2002 04:25:59 -0500
Message-ID: <3CA432C7.5E33EF4A@mvista.com>
Date: Fri, 29 Mar 2002 01:24:23 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] Micro-Second timers in kernel ?
In-Reply-To: <20020315164845.A15889@bougret.hpl.hp.com> <3C92B126.852DC838@mvista.com> <3C98F4C8.703E4574@daimi.au.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
> 
> george anzinger wrote:
> >
> > Jean Tourrilhes wrote:
> > >
> > >         Well... I'm stuck. 10ms is a very long time at 4Mb/s. So, I
> > > guess I'll continue to busy wait before sending each packet. Ugh !
> > >
> > The overhead to do a timer is on the order of at least 100 us on an
> > 800MHZ machine.  Given this, a timer/ interrupt based delay for less
> > than 100 us is probably a bad idea.
> 
> I have been considering all this timer thing for some time. I would
> actually like to see the interrupt at regular intervals completely
> removed from the kernel.

Check out the high-res-timers sourceforge site (see signature for URL). 
You will find a patch to make a "tick less" kernel.  It does pretty much
what you are thinking of.  I rejected the whole notion based on the
instrumentation results from that kernel.  The problem, in a nut shell,
is that a timer needs to be stopped and started each context switch. 
While these operations are really quite fast, so is the context switch
and the extra overhead seems to cross the "ticked" system timer overhead
when the context switch rate is, well, lets say busy.  The upshot is
that the "tick less" system is overload prone, timer overhead increases
with load (or context switch rate) where, in the "ticked" system it is
almost flat.
> 
> Instead I would rather be using a programable one shot timer. The
> PIT used in the i386 based machines actually can do that, although
> it is not the best designed hardware I could imagine. I don't know
> what posibilities there are in other hardware.
> 
> The idea behind all this is that the timers are used for two
> different purposes. One purpose is that we want particular pieces
> of code executed at given times, the one shot timer can be used for
> that. The other purpose is to meassure time intervals, this can be
> done better in hardware without the need for interrupts, the TSC is
> more or less a proof of that.
> 
> What we need to do is that whenever we want a function called at a
> specified time, we insert a struct containing the time and whatever
> additional information we need into a priority queue. We then take
> the difference between the current time and the time from the head
> of the queue and reprogram the oneshot timer if necesarry.

The wonderful PIT has a maximum time of some where around 500 ms (if I
remember correctly).  This would mean that you would need "keep alive"
interrupts for longer times...
> 
> Whenever the timer interrupt gets invoked it should keep executing
> the first element from the priority queue, until the element in the
> head has a time stamp in the future. Then it should either busywait
> or reprogram the timer depending on the needed delay compared to
> the overhead. All this should probably not be done by the timer
> interrupt itself, so perhaps we would use a kernel thread, a tasklet
> or something else. I haven't yet figured out exactly what would be
> the best.

This is exactly what the run_timer_list code does, both in the standard
kernel and in the high-res-timer code (not to be confused with the "tick
less" experiment mentioned above).  This code is run from a tasklet. 
You would need to use great care to use a kernel thread as you could
then lock out timer events with real time tasks.  I did do this (another
time and system) with a kernel task that reset its own priority based on
the timer event priority, so something like this is possible.  It does,
however, introduce latency in the event.
> 
> The problem with this idea is primarily that a lot of code might
> need to be rewritten. We would also need another unit for the
> jiffies variable, nanoseconds would probably be a good choice. But
> this would probably need it to be a 64bit integer even on 32bit
> architectures. And actually jiffies should no longer be a variable
> but actually a function call. (This is in some way similar to what
> happened to current at some time.)

IMHO it is used far too often to be a function (overhead again).  Also,
for most things the 1/HZ resolution is satisfactory.  We do need better
resolution sometimes, but this usually comes at some cost so it is best
to only use it when needed.
> 
> I have been considering a few implementation details on the i386
> architecture, obviously a combination of the PIT and the TSC will
> be needed. The TSC cannot produce interrupts, and the PIT cannot
> reliably be used to meassure time when used as one shot timer.
> 
> The PIT has a well specified frequency, the TSC doesn't. I don't
> know about the accuracy of the two. We would need to know the
> frequency of the TSC, but I guess the kernel already meassures
> that at bootup. I would suggest that the frequency meassured in HZ
> would be put in some proc pseudofile. Then there is an easy way
> for applications to read it, and root can change it if needed. The

It is already in /proc.

> posibility of changing of this pseudofile would have two main
> purposes. First of all it can be used on hardware were the boot
> time measurement of the frequency is for some reason wrong. Second
> a feature could be added to ntpd to change the frequency used by
> the kernel in order to slowly adjust the time towards the right
> value.

The actual value used to convert TSC to nano or micro seconds is a
scaled number which takes a small amount of math to compute.  The
result, however, is a very fast conversion when doing e.g.
gettimeofday() (~.65 micro seconds on 800 MHz PIII).  So to do this you
would have to tap on the kernels shoulder and have it recompute these
scaled numbers.  This is not unreasonable and IF we can get notice of
throttling (which changes the TSC clock rate) this is exactly what we
would want to do.
> 
> The accuracy with which we know the TSC speed will affect the
> accuracy of the time. However the accuracy of the PIT should not
> be that important. If interrupts come too early we will either
> busywait a very short time, or we will just schedule another
> interrupt. If interrupts come too late, some process will sleep
> slightly longer than it was supposed to, but that is no worse
> than what the kernel promises. And probably no worse than the
> current implementation.

The standards INSIST that we NEVER return too early, but allow late. 
The TSC and PIT are, in some (most?) hardware driven from the same
crystal so they should always have the same error rate, usually a few
PPM.
> 
> With all this in place the scheduler does no more need to use
> fixed size timeslices, it could implement growing time slices and
> decreasing priorities for processes that needs lots of CPU time.
> And OTOH use small time slices for interactive processes.
> 
> There are still a few questions for which I do not yet know the
> answers:
> - How much overhead will the timer interrupts have with this new
>   design?

See the "tick less" patch. It has instrumentation that measures this. 
The short answer is the best you can do with the PIT is a 5 to 1
improvement (assuming keep alive interrupts at ~500 ms).

This, however, is not the problem.  The real issue is the timer start/
stop time incurred each context switch.  Most of the time there is a
time event closer than the end of the slice AND most of the time several
context switches occur prior to the slice end.  All this adds accounting
time to the context switch, but does not add PIT programming time as a
close in timer usually is active.  The instrumentation shows this.

> - How much overhead will the needed 64bit calculations in the
>   kernel have?

Mostly none.  You don't really need 64bit stuff often enough to notice.

> - Will this be possible on all architectures on which Linux runs.
>   And are there any architectures where this will be easy to
>   implement?

There are certainly platforms with better time interrupt hardware, and a
couple with worse.

> - Is the TSC frequency reliable enough to be used for this?
Same rock as the PIT.  The issue is throttling and power management slow
downs.
> 
> I'm absolutely sure that this will require a lot of work to
> implement, but with the right architecture I believe it would be
> a very good idea. Is it worth a try?

IMHO NO :)

> 
> --
> Kasper Dupont -- der bruger for meget tid på usenet.
> For sending spam use mailto:razor-report@daimi.au.dk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
