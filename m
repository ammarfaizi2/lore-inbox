Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSBPQGH>; Sat, 16 Feb 2002 11:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292398AbSBPQF5>; Sat, 16 Feb 2002 11:05:57 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32239 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S292395AbSBPQFo>; Sat, 16 Feb 2002 11:05:44 -0500
Message-ID: <3C6E833F.1A888B3C@mvista.com>
Date: Sat, 16 Feb 2002 08:05:19 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tyson D Sawyer <tyson@rwii.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Missed jiffies
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tyson D Sawyer wrote:
> 
> My system looses about 8 seconds every 20 minutes.  This is reported
> by ntp and verified by comparing 'date' to 'hwclock --show' and a wall
> clock.
> 
> My system is a x86 Dell laptop with HZ=1024.
> 
> I am quite certain that the issue is the System Management Interrupt
> (SMI).
> 
> While doing latency tests I have observed 18ms delays every 2 seconds.
>  Like, as they say, clock work.  Given that in 18ms with HZ==1024
> roughly 18 timer interrupts should occur then 17 of them (I believe)
> would be lost.  Looking in the kernel sources I could find nothing
> that adjusts for this.
> 
> Since I have defined HZ to be 1024, I miss lots of timer interrupts.
> However, since the the processor spends 18ms at a time in SMM (System
> Mangement Mode), then even the stock 10ms timer tick will sometimes
> miss a tick.  Thus the problem applies to non-hacked kernels also.
> 
> I don't know that there is a solution for all systems, however, at
> least on pentium systems it seems possible to use the TSC to catch
> this.  However, even if I worked up a patch to do so, do_timer()
> always increments jiffies by just 1 count and it isn't clear that its
> safe to call it repeatedly to catch up with lost ticks.  It also isn't
> clear that it would be safe to modify jiffies directly in one of the
> arch/i386/kernel/time.c functions.
> 
> In general, I'd like to try a solution that looks something like:
> 
> tsc_per_jiffie = cpu_khz * 1000 / HZ;
> 
> tsc_remainder += last_tsc_low-tsc_low;
> jiffies_increment=0;
> do {
>         tsc_remainder -= tsc_per_jiffie;
>         jiffies_increment++;
> } while (tsc_remainder > tsc_per_jiffie);
> 
> do_timer(regs, jiffies_increment);
> 
> The above was created on the fly and completely untested.  It needs
> bits like making sure that the arithmetic works properly on overflow
> of tsc_low.  It also requires a patch to do_timer() and proper
> structuring for portability.

You might take a look at the high-res-timers patch (see URL in
signature) where the timer interrupt is separated from the wall clock
computation.  In that patch, do_timer() updates jiffies as needed and
then calls the wall clock update which can handle more than one jiffie
at a time.

One of the nasty problems, especially with machines such as yours (i.e.
lap tops), is the fact that TSC is NOT clocked at a fixed rate.  It is
affected by throttling (reduced in 12.5% increments) and by power
management.  The patch attempts to find a way thru these problems by
making the ACPI pm timer one of the options for keeping wall clock. 
This timer is clocked at a constant rate regardless of power management,
indeed, it was created to address just these concerns.  The down side is
that it accessed via an I/O instruction and thus adds overhead to the
tick processing and also to all attempts to read system time to a finer
level than the jiffie (most of which are internal, i.e. not from user
land).
> 
> One problem I see is that tsc_per_jiffie must be perfect or time will
> drift.  I think it might work to not carry over the remainder from
> cycle to cycle under some conditions (no missed ticks) but I'd have
> to think about that the effects of timing jitter on this.
> 
> Have attempts to address this problem been made before?
> 
> What are the problems with incrementing jiffies by more than 1?
> 
> What problems have I missed?
> 
> What strategies might be employed to prevent degraded system
> performance since this code is in a criticle path?
> 
> Have I competely missed something, the kernel already takes care of
> this and I have the problem all wrong?
> 
> This problem also comes up with IDE access with dma off and I've
> seen reports of it when using frame buffers.

The IDE issue is correctly address by using DMA.

I think the real problem needs to be addressed, i.e. why does the SMI
(and/ or other code) keep the interrupt system off so long.  Most
interrupts are completed in micro seconds, not milliseconds, lets fix
the real problem.
> 
> Thanks!
> Ty
> 
> --
> Tyson D Sawyer                             iRobot Corporation
> Senior Systems Engineer                    Military Systems Division
> tsawyer@irobot.com                         Robots for the Real World
> 603-532-6900 ext 206                       http://www.irobot.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
