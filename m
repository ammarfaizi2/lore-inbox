Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWAFWOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWAFWOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWAFWOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:14:19 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:5848 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750732AbWAFWOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:14:18 -0500
Subject: Re: i8254 and TSC related code
From: john stultz <johnstul@us.ibm.com>
To: Stanislav Maslovski <stanislav.maslovski@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060104211827.GA8723@shota.mine.nu>
References: <20060104211827.GA8723@shota.mine.nu>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 14:14:11 -0800
Message-Id: <1136585651.10357.61.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 00:18 +0300, Stanislav Maslovski wrote:
> Hello linux-kernel,
> 
> I have been reading sources in arch/i386/kernel/timers/ (in 2.6.14.5)
> and arch/i386/kernel/time.c (in 2.4.32) for some time and I have got
> a few questions. It would be nice if somebody could clarify
> the things for me a little.


I'm glad to see your interest in timekeeping! Its a area that could use
more review.


> The first question is about the use of i8254's mode 2 in channel 0.
> The datasheet on i82C54 says that in this mode the counter is used
> as a programmable divider of the CLK frequency. The corresponding
> divisor value (LATCH) is first loaded into the counter at the
> initialization. After the init the channel generates OUT pulses at the
> frequency CLK / LATCH. The specification also states that the counter
> is decremented down to 1 (not to 0) after which the LATCH value is
> reloaded. For instance, if LATCH is 3, then the count sequence is
> 3 2 1 3 2 1 3 2 1 and so on, which exactly corresponds to division
> of the CLK frequency by 3.
> 
> It seems that linux assumes a different behaviour in mode 2.
> For example, delay_at_last_interrupt is calculated as
> 
>         count = ((LATCH-1) - count) * TICK_SIZE;
>         delay_at_last_interrupt = (count + LATCH/2) / LATCH;
> 
> The first line suggests that "count" is assumed to change in
> the [ LATCH-1; 0 ] range, does not it? In 2.4.32 there is even
> a piece of code in timer.c:timer_interrupt() that checks for
> the condition "count == LATCH" and does "count--" if
> this condition is true. The comment to this piece of code says:
> 
>         /* Some i8253 clones hold the LATCH value visible
>            momentarily as they flip back to zero */
> 
> which explicitly contradicts the Intel docs.

Hmmm. That logic is as old as the hills, but from your description it
does seem that if the PIT goes from [LATCH, 1] the logic should be
(LATCH - count)*...  

Thoughts from anyone else?


> The next question is about the piece of code in mark_offset_tsc()
> in timer_tsc.c from 2.6.14 which treats the case of pit_latch_buggy.
> The code replaces the most recent read value of the counter
> with the middle of 3 most recently read values. Those last reads
> are separated in time by at least one timer interrupt each and
> therefore are not related at all! Depending on interrupt latencies
> and the load those values can be anything from LATCH to 1 even in
> a non-buggy PIT. I am pretty sure that this code cannot help in the case
> of pit_latch_buggy either, however I could not find any information
> on this partucular bug. In its present form the code will likely
> produce irregular time jumps, the frequency of which will depend
> on the system load, etc. There will be jumps back in time too
> because the system time is calculated based on both TSC timestamps
> (which are monotonic) and "delay_at_last_interrupt" which changes
> randomly in this case. I think this code is bogus and should be
> removed. By the way, there is no such code in 2.4.32. I did a simple
> check: I made the "if(pit_latch_buggy)" in the code be always true
> and then ran the modified kernel. My machine has a normal PIT.
> The following program was started from the user space:
> 
> ===================== time_mon.c ======================
> #include <stdio.h>
> #include <sys/time.h>
> #include <time.h>
> struct timeval tv1, tv2;
> struct timezone tz;
> main()
> {
> 	int cnt = 10;
> 	puts("Starting...");
> 	while (cnt--) {
> 		do {
> 			tv1 = tv2;
> 			gettimeofday(&tv2, &tz);
> 		} while (tv2.tv_sec > tv1.tv_sec || tv2.tv_usec >= tv1.tv_usec);
> 		printf("t1 = %lu.%6lu; t2 = %lu.%6lu\n",
> 			(unsigned long)tv1.tv_sec, (unsigned long)tv1.tv_usec,
> 			(unsigned long)tv2.tv_sec, (unsigned long)tv2.tv_usec);
> 	}
> 	puts("Done.");
> }
> =======================================================
> 
> Here are the values I received from the output of it:
> 
> t1 = 1136142051.862198; t2 = 1136142051.861307
> t1 = 1136142256.233167; t2 = 1136142256.232274
> t1 = 1136142403.500171; t2 = 1136142403.499295
> t1 = 1136142607.871141; t2 = 1136142607.870262
> t1 = 1136144390.113896; t2 = 1136144390.113019
> t1 = 1136144594.484868; t2 = 1136144594.483985
> t1 = 1136144946.123843; t2 = 1136144946.122972
> t1 = 1136146229.457609; t2 = 1136146229.456722
> t1 = 1136146728.363602; t2 = 1136146728.362730
> 
> The other load of the machine under the test was minimal:
> I read some docs on the net, etc.

It does seem odd. While the notion that it takes the middle of the last
three latched PIT values, to insure you have a sane value. The value
selected may not have much to do with the current interrupt handler
latency (which is why we touch the PIT at all here). 

Someone familiar w/ the Cyrix 5510/5520 should comment here since that
is what it has been added for.


> Next question is about TSC used in conjunction with PIT for
> timekeeping. The idea of using TSC to detect lost timer
> interrupts is nice. The idea of getting finer time resolution
> with the help of TSC is nice too, but I have some questions
> still. First, why in timer_tsc.c:mark_offset_tsc(),
> the TSC is read before latching the PIT count?
> Especially that in the recent kernels there is a spin_lock()
> call in between the TSC and the PIT reads?
> For the values read from TSC and PIT to be
> corresponding the reads must happen almost
> at the same time (even the comment in the code says so ;-))
> 
> I would place read_tsc() immediately after the latching
> operation "outb_p(0x00, PIT_MODE);"
> It is better to have it immediately after it and not
> immediately before it also because the actual write to
> a register of an i/o device happens at the end of the
> bus cycle, but not at the beginning. 


I'd not be opposed to this, or at least pulling the rdtsc inside the
spinlock should be fine.


> I think that such a
> change will also make redundant the "corner case correction"
> done at the end of mark_offset_tsc():
> 
>        if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
>                jiffies_64++;

I need to think it through a bit more, but it seems there is the
potential for the inverse of this corner case, where the PIT is latched
just before it triggers another interrupt, and the TSC is read after the
interrupt signal with a value greater then one interrupt. So while this
check might be made unnecessary, additional logic could be needed.


> By the way (and this is my last question for now) the test for this correction
> is buggy because in the current implementation "lost" does not account
> for the lost ticks but for the really_lost + 1. This is seen from the
> code some lines above:
> 
>        lost = delta/(1000000/HZ);                                 
>        delay = delta%(1000000/HZ);
>        if (lost >= 2) {
>                jiffies_64 += lost-1;
> 
> At the beginning of this code delta is normally slightly above 1000000/HZ
> so that lost == 1 even if there was not a really lost tick. This was taken
> into account in the increment for jiffies but was not in the "corner case"
> correction...

Actually, that should be ok since we're trying to avoid doing any math
if the interrupt is early, although I admit it is confusing.

So imagine the following:

0      1      2      3      4      5      6      7
|-+----|--+---|+-----|-----+|------|------|+----+|
  A       B    C           D               E    F

Where the numbered "|"s are the interrupt signals and lettered "+"s are
the interrupt handlers.

So, at at interrupt handler B: 

>From the last interrupt handler A, we've stored the time between 0 and A
as delay_at_last_interrupt.  

We enter mark_offset_tsc() and calculate the time from B to A using the
TSC, saving it in delta. We also store count from the PIT which we will
use later. 

We add delay_at_last_interrupt to delta to give us the full interval
from 0 to B. We divide this interval by the interrupt frequency and save
that as lost (which should store the value 1).

We use an estimate of where 1 should be to calculate the distance from 1
to B and store this in delay.

Since lost is less then 2, no lost tick compensation occurs.

We use the value count, stored earlier from the PIT, to calculate the
interval from 1 to B and store it delay_at_last_interrupt.

Then assuming a full tick has occurred (ie: lost is 1), we double check
our math for the interval 1 to B so the PIT based delay_at_last
interrupt is close enough to the mixed PIT/TSC value delay calculated
earlier.

That's the easy case (no early or late ticks) but you can go head and
work out the others in your head. 

It is quite ugly, so I might be missing your point. Please clarify if
so.

> I do realize that the presenly avaliable time keeping code looks like a big
> mess (sorry, developers, but that is a fact :( ) and that there will soon
> (probably) be an alternative timekeeping system avaliable, but for some time
> this old timekeeping code will stay in the kernel, so it still deserves
> fixing, IMHO.


Oh, I quite agree with you. I am mainly to blame, since when I initially
created the timer_opts code I was very hesitant about changing behaviour
so I preserved alot of the odd code that could probably have used a
cleanup.

Most of the bugs and uglyness here comes from the fact that we're mixing
time values generated from different hardware (ie: the PIT and the TSC).
So we have to have some sanity checking so that they aren't totally off,
and where they are just a touch off (due to calibration error or
whatever), we just pray no one notices.

After trying to find the right balance of "trusting the TSC unless we
should trust the PIT but double check and shrug if its wrong" and still
finding corner cases, I got fed up and started work on the generic
timekeeping infrastructure which allows for a simple linear mapping
(well, ignoring NTP corrections) from the hardware counter value to the
system time. This greatly cleans up the timekeeping logic and avoids
this mixing hardware when generating time values.

The patches are currently in the -rt tree as well as 2.6.15-mm1. So if
your careful eyes want to read over something else, it would be greatly
appreciated.

Additionally, your point that the upcoming rework should not keep bugs
in the current code from being fix is absolutely right!  So please feel
free to submit patches to lkml and Andrew fixing any current issues and
I'll be sure to look them over.

thanks
-john

