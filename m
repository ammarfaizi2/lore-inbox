Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbWADVKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbWADVKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWADVKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:10:12 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:4373 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751804AbWADVKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:10:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=okv1u0s40GVpnc26eZN27gJo0ci9r84P86Q+5Z7eoJ8hdb2FIcnJ2XFur0bh1Hy6ywC2QvMWsVv4yQs5o2DhCiJJGxQ3RUiqi5wZbfwnlxWMcnQd+5TMiiztlQwe3UbADgqga4EgqNLA3tvgvMTvlMYeKJz3PMUAndMmu2y+tMM=
Date: Thu, 5 Jan 2006 00:18:27 +0300
From: Stanislav Maslovski <stanislav.maslovski@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: i8254 and TSC related code
Message-ID: <20060104211827.GA8723@shota.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

I have been reading sources in arch/i386/kernel/timers/ (in 2.6.14.5)
and arch/i386/kernel/time.c (in 2.4.32) for some time and I have got
a few questions. It would be nice if somebody could clarify
the things for me a little.

The first question is about the use of i8254's mode 2 in channel 0.
The datasheet on i82C54 says that in this mode the counter is used
as a programmable divider of the CLK frequency. The corresponding
divisor value (LATCH) is first loaded into the counter at the
initialization. After the init the channel generates OUT pulses at the
frequency CLK / LATCH. The specification also states that the counter
is decremented down to 1 (not to 0) after which the LATCH value is
reloaded. For instance, if LATCH is 3, then the count sequence is
3 2 1 3 2 1 3 2 1 and so on, which exactly corresponds to division
of the CLK frequency by 3.

It seems that linux assumes a different behaviour in mode 2.
For example, delay_at_last_interrupt is calculated as

        count = ((LATCH-1) - count) * TICK_SIZE;
        delay_at_last_interrupt = (count + LATCH/2) / LATCH;

The first line suggests that "count" is assumed to change in
the [ LATCH-1; 0 ] range, does not it? In 2.4.32 there is even
a piece of code in timer.c:timer_interrupt() that checks for
the condition "count == LATCH" and does "count--" if
this condition is true. The comment to this piece of code says:

        /* Some i8253 clones hold the LATCH value visible
           momentarily as they flip back to zero */

which explicitly contradicts the Intel docs.

The next question is about the piece of code in mark_offset_tsc()
in timer_tsc.c from 2.6.14 which treats the case of pit_latch_buggy.
The code replaces the most recent read value of the counter
with the middle of 3 most recently read values. Those last reads
are separated in time by at least one timer interrupt each and
therefore are not related at all! Depending on interrupt latencies
and the load those values can be anything from LATCH to 1 even in
a non-buggy PIT. I am pretty sure that this code cannot help in the case
of pit_latch_buggy either, however I could not find any information
on this partucular bug. In its present form the code will likely
produce irregular time jumps, the frequency of which will depend
on the system load, etc. There will be jumps back in time too
because the system time is calculated based on both TSC timestamps
(which are monotonic) and "delay_at_last_interrupt" which changes
randomly in this case. I think this code is bogus and should be
removed. By the way, there is no such code in 2.4.32. I did a simple
check: I made the "if(pit_latch_buggy)" in the code be always true
and then ran the modified kernel. My machine has a normal PIT.
The following program was started from the user space:

===================== time_mon.c ======================
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
struct timeval tv1, tv2;
struct timezone tz;
main()
{
	int cnt = 10;
	puts("Starting...");
	while (cnt--) {
		do {
			tv1 = tv2;
			gettimeofday(&tv2, &tz);
		} while (tv2.tv_sec > tv1.tv_sec || tv2.tv_usec >= tv1.tv_usec);
		printf("t1 = %lu.%6lu; t2 = %lu.%6lu\n",
			(unsigned long)tv1.tv_sec, (unsigned long)tv1.tv_usec,
			(unsigned long)tv2.tv_sec, (unsigned long)tv2.tv_usec);
	}
	puts("Done.");
}
=======================================================

Here are the values I received from the output of it:

t1 = 1136142051.862198; t2 = 1136142051.861307
t1 = 1136142256.233167; t2 = 1136142256.232274
t1 = 1136142403.500171; t2 = 1136142403.499295
t1 = 1136142607.871141; t2 = 1136142607.870262
t1 = 1136144390.113896; t2 = 1136144390.113019
t1 = 1136144594.484868; t2 = 1136144594.483985
t1 = 1136144946.123843; t2 = 1136144946.122972
t1 = 1136146229.457609; t2 = 1136146229.456722
t1 = 1136146728.363602; t2 = 1136146728.362730

The other load of the machine under the test was minimal:
I read some docs on the net, etc.

Next question is about TSC used in conjunction with PIT for
timekeeping. The idea of using TSC to detect lost timer
interrupts is nice. The idea of getting finer time resolution
with the help of TSC is nice too, but I have some questions
still. First, why in timer_tsc.c:mark_offset_tsc(),
the TSC is read before latching the PIT count?
Especially that in the recent kernels there is a spin_lock()
call in between the TSC and the PIT reads?
For the values read from TSC and PIT to be
corresponding the reads must happen almost
at the same time (even the comment in the code says so ;-))

I would place read_tsc() immediately after the latching
operation "outb_p(0x00, PIT_MODE);"
It is better to have it immediately after it and not
immediately before it also because the actual write to
a register of an i/o device happens at the end of the
bus cycle, but not at the beginning. I think that such a
change will also make redundant the "corner case correction"
done at the end of mark_offset_tsc():

       if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
               jiffies_64++;

By the way (and this is my last question for now) the test for this correction
is buggy because in the current implementation "lost" does not account
for the lost ticks but for the really_lost + 1. This is seen from the
code some lines above:

       lost = delta/(1000000/HZ);                                 
       delay = delta%(1000000/HZ);
       if (lost >= 2) {
               jiffies_64 += lost-1;

At the beginning of this code delta is normally slightly above 1000000/HZ
so that lost == 1 even if there was not a really lost tick. This was taken
into account in the increment for jiffies but was not in the "corner case"
correction...

I do realize that the presenly avaliable time keeping code looks like a big
mess (sorry, developers, but that is a fact :( ) and that there will soon
(probably) be an alternative timekeeping system avaliable, but for some time
this old timekeeping code will stay in the kernel, so it still deserves
fixing, IMHO.

Please comment.

--
Stanislav
