Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263958AbTJ1MF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 07:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTJ1MF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 07:05:28 -0500
Received: from ltgp.iram.es ([150.214.224.138]:33413 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S263958AbTJ1MFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 07:05:15 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 28 Oct 2003 12:55:58 +0100
To: Stephen Hemminger <shemminger@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Joe Korty <joe.korty@ccur.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
Message-ID: <20031028115558.GA20482@iram.es>
References: <20031027234447.GA7417@rudolph.ccur.com> <1067300966.1118.378.camel@cog.beaverton.ibm.com> <20031027171738.1f962565.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027171738.1f962565.shemminger@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 05:17:38PM -0800, Stephen Hemminger wrote:
> Arghh... the patch was being way more agressive than necessary.  
> tickadj which limits NTP is always 1 (for HZ=1000) so NTP will change
> at most 1 us per clock tick.  This meant we only had to stop time
> for the last us of the interval.

Hmm, I still don't like it. What does it do to timestamping in
interrupts in the kernel, especially when there is a burst of
interrupts?

If I read it correctly, the time will be frozen between the time
the timer interrupt should have arrived and the time it is processed.
So the last micosecond of the interval could extend well into the next
interval, or do I miss something (I also suspect that it could
make PPSKit behave strangely for this reason)?

> 
> 
> diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> --- a/arch/i386/kernel/time.c	Mon Oct 27 17:13:22 2003
> +++ b/arch/i386/kernel/time.c	Mon Oct 27 17:13:22 2003
> @@ -110,8 +110,9 @@
>  		 * so make sure not to go into next possible interval.
>  		 * Better to lose some accuracy than have time go backwards..
>  		 */
> -		if (unlikely(time_adjust < 0) && usec > tickadj)
> -			usec = tickadj;
> +		if (unlikely(time_adjust < 0) && 
> +		    unlikely(usec > tick_usec - tickadj)) 
> +			usec = tick_usec - tickadj;

So wouldn't it be better to put:
			usec = max(usec, tick_usec)-tickadj;
to freeze the time for only a few microseconds even for kernel clients
of gettimeofday() when the timer interrupt comes a bit late?

Now if you are looking at the microsecond level of precision, there is 
something else in which is worth considering as commented in the
appended patch. In short, I consider "do it first because it's faster 
to be a bogus argument", rather do it in the order which should
minimize the jitter of the measurements (outb and inb have enough
serialization that no other synchronization should be necessary).

I'm not sure that it will result in easily measurable improvements. 
But it should not hurt either.

The same could be applied to other timer in the file (HPET) and other files 
but I don't have any machines on which I can test these, and ensuring
that the instruction are executed in the right order is a bit more
difficult than with inb and outbs.

	Regards,
	Gabriel

===== arch/i386/kernel/timers/timer_tsc.c 1.29 vs edited =====
--- 1.29/arch/i386/kernel/timers/timer_tsc.c	Fri Oct 10 23:01:24 2003
+++ edited/arch/i386/kernel/timers/timer_tsc.c	Tue Oct 28 11:04:28 2003
@@ -165,8 +165,10 @@
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	/*
 	 * It is important that these two operations happen almost at
-	 * the same time. We do the RDTSC stuff first, since it's
-	 * faster. To avoid any inconsistencies, we need interrupts
+	 * the same time. The delay of acquiring the spinlock and
+	 * accessing the PIT may be large, especially if the bus is busy
+	 * with DMA transactions, so the rdtsc is done after to limit 
+	 * jitter. To avoid any inconsistencies, we need interrupts
 	 * disabled locally.
 	 */
 
@@ -175,15 +177,16 @@
 	 * has the SA_INTERRUPT flag set. -arca
 	 */
 	
-	/* read Pentium cycle counter */
-
-	rdtsc(last_tsc_low, last_tsc_high);
-
 	spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
 	count = inb_p(PIT_CH0);    /* read the latched count */
 	count |= inb(PIT_CH0) << 8;
+
+	/* read Pentium cycle counter */
+
+	rdtsc(last_tsc_low, last_tsc_high);
+
 	spin_unlock(&i8253_lock);
 
 	if (pit_latch_buggy) {

