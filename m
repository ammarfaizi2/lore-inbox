Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSEWKMK>; Thu, 23 May 2002 06:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316375AbSEWKMJ>; Thu, 23 May 2002 06:12:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26099 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315458AbSEWKMH>;
	Thu, 23 May 2002 06:12:07 -0400
Message-ID: <3CECB24E.D41B1527@mvista.com>
Date: Thu, 23 May 2002 02:11:42 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Seppanen <eds@reric.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: via timer/clock problem workaround
In-Reply-To: <20020522221859.A24041@reric.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Seppanen wrote:
> 
> I've noticed a handful of messages in recent months regarding the problems
> with the via chipset timer.  It would appear that the timer fails every
> so often and this causes gettimeofday to start returning weird values.
> 
> This has the following symptoms that I've noticed:
> - clock often jumps forward 71 minutes, then back
> - screensaver kicks on unexpectedly
> - video playback programs freeze or start stuttering
> - PS/2 mouse flies up to upper right corner under X
> ... I'm sure there's more; odd timeofday values cause lots of strange
> things.
> 
> There are a few patches floating around that fix this in some cases, but
> not all.  I've looked into this further and created a patch that I think
> does a much better job, though it may not be perfect yet.
> 
> In 2.4.18, whenever the code sees the microsecond offset start to grow too
> large, it guesses that there's a timer problem and smacks the timer.  This
> seems to work, but I think the code is in the wrong place.
> 
> This workaround only happens if CONFIG_X86_TSC is not set.
> Athlon-optimized kenels seem likely to have CONFIG_X86_TSC set (the
> redhat athlon kernel does), so it seems wrong to put the workaround there.
> 
> Additionally, there's a while loop in do_gettimeofday() that will loop
> millions of times if an unreasonable offset is returned from
> do_gettimeoffset().  This can be avoided by doing division instead.
> 
> I've worked over the code a bit, and I have a new patch that moves the
> timer-smack into the part of the code that executes whether the TSC is
> being used or not.  If you don't like the amount of code I've moved
> around, fear not: most of the code shuffling is just to make the debugging
> printk print the data I want.  It should be straightforward to make a
> smaller patch that does the same thing.
> 
> In my testing (using CONFIG_X86_TSC) this improves the situation quite a
> bit: before, the timer would stay messed up and the machine would act
> crazy until the next reboot.  Now, there may be a single bad value
> returned but the system goes back to normal after that.  Maybe not
> perfect, but certainly better.
> 
> I'd appreciate it if anyone experiencing odd behavior on Via chipsets
> could give it a try.  The problem usually only occurs under heavy loads; I
> have reproduced it often by creating massive images (5000x5000 pixels) in
> The Gimp or playing MPEG files while copying huge files around.
> 
> The patch works well today, but there are still a few outstanding
> questions I have:
> 
> 1. Why does this (bogus offset) happen?  Has the timer died?  Is there
> another way to prevent this from happening in the first place?

Good question.  The code you call smack_timer reprograms the
timer chip to generate repeating interrupts every "LATCH"
units of time (this is 1/HZ in timer chip ticks).  This is a
complete reprogram of the chips timer.  

Since you got here on a request for time of day, it is
possible that timer interrupts are just not happening.  In
fact, given that you are detecting over 1 second of lost
time (from reading the TSC) surly indicates that the timer
is no longer interrupting.  It might be instructive to read
the timer latch at this time to see what, or where it is
stuck.  Normally the LATCH count is counted down to zero by
the chip and then the LATCH value is reloaded by the chip
and the count starts over again.  The chip has other modes
that just count through zero (i.e. going from 0 to 0xffff
(it is 16 bits)).  These modes are supposed to generate only
one interrupt.  Another factoid is that the maximum time the
chip can be programmed for is on the order of 50 msec.

And, by the way, I don't think the offset is bogus.  It just
indicates that a great deal of time has passed since the
last interrupt.  Note that the TSC also rolls over (since
only the low 32-bits are used) and this will cause the
offset to be negative.  Also, the base TSC that is used is
only reset on a timer tick, so once you see the error it
will persist until the next timer interrupt (i.e. 1/Hz or 10
msec since you smack_timer).  Also, on the next timer
interrupt, the wall clock will only be advanced by 10 msec
and the 2 seconds will be lost, i.e. time will appear to
jump backward (since the TSC base will also get reset at
this time).

> 2. Is it possible to resurrect what the correct offset should be at this
> point?

I think it is correct.  The "correct" thing to do is to
incorporate it into xtime AND to get the timer restarted in
such a way that it is in tune with the actual time.  The way
to do this is to adjust jiffies by the number of even
jiffies that the offset computes out to.  Then the remainder
should be used to advance xtime.tv_usec.  The TSC base
should be reset at this time also.  This allows the next
interrupt to push the advanced jiffies through the update of
the wall clock, taking care of any ntp issues, and all the
other accounting things that need doing.  By doing the above
and smacking the timer everything should get on track on the
next tick interrupt.  Meanwhile, get time requests will find
small offsets (and a jiffies-wall_jiffies correction) and
will give correct time.  Most importantly, time will not
jump backward.

> 3. If not, what's the best value to use as an offset here?  I'm still
> using the bogus value to calculate the timeofday returned.  Is there a
> better way?

See above.

> 4. What does the code (which I've named smack_timer) do?  It is correct or
> just lucky?  I kept the workaround code that was already in 2.4.18, but I
> don't understand what it's doing.

See above.  It programs the PIT to interrupt every LATCH
timer units.  LATCH is defined to give 1/HZ ticks.
> 
> Patch attached applies against 2.4.18 and the redhat 7.3 kernels.  I'll
> keep my latest version here:
> http://www.reric.net/linux/viatimer/
> 
> Eric
> 
>   ------------------------------------------------------------
> 
>    eds_timer1.patchName: eds_timer1.patch
>                    Type: Plain Text (text/plain)

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
