Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422933AbWHZARu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422933AbWHZARu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422940AbWHZARu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:17:50 -0400
Received: from science.horizon.com ([192.35.100.1]:1852 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1422933AbWHZARt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:17:49 -0400
Date: 25 Aug 2006 20:17:48 -0400
Message-ID: <20060826001748.5089.qmail@science.horizon.com>
From: linux@horizon.com
To: johnstul@us.ibm.com, linux@horizon.com
Subject: Re: Linux time code
Cc: linux-kernel@vger.kernel.org, theotso@us.ibm.com, zippel@linux-m68k.org
In-Reply-To: <1156357786.5370.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Overall, I like your idea quite a bit. Might we look forward to a
> patch? :)

Researching this has led me into that pit of madness, the i8254
programmable interval timer specification.

This is the original IBM PC timer (well, the version after the original
8253), counting at 13125000/11 = 1193181.81... Hz, programmed to divide
by 11932 to generate a 100 Hz timer interrupt.  If you want to be picky,
the options are

Divisor	Exact frequency	Decimal Hz	Error

11932	13125000/131252	  99.998476...	-15 ppm
 4773	13125000/52503	 249.985715...	-57 ppm
 1193	13125000/13123	1000.152404...	152 ppm

But, of course, the (at best) 100 ppm quality of typical cheap quartz
oscillators means that only the first 4 digits of the frequency matter.

Anyway, if you see a high value in the counter (it counts down, so this
means that it was just reset), the question arises: has the interrupt
handler run and propagated the carry bit yet?

Now, if you assume that the interrupt controller gets the signal in
negligible time, it's not that hard.  Grab the software-managed
high-order bits, read the low-order bits from the 8254, and if it
reports "just rolled over" (generally, in the first half of its count
range), re-grab the software bits.  If interrupts are disabled,
also check the interrupt pending bit on the controller.

The logic on FreeBSD to do that is in i8254_get_timecount
(source/i386/isa/clock.c):
 
static unsigned
i8254_get_timecount(struct timecounter *tc)
{
	u_int count;
	u_int high, low;
	u_int eflags;

	eflags = read_eflags();
	mtx_lock_spin(&clock_lock);

	/* Select timer0 and latch counter value. */
	outb(TIMER_MODE, TIMER_SEL0 | TIMER_LATCH);

	low = inb(TIMER_CNTR0);
	high = inb(TIMER_CNTR0);
	count = timer0_max_count - ((high << 8) | low);
	if (count < i8254_lastcount ||
	    (!i8254_ticked && (clkintr_pending ||
	    ((count < 20 || (!(eflags & PSL_I) && count < timer0_max_count / 2u)) &&
	    i8254_pending != NULL && i8254_pending(i8254_intsrc)))))

		i8254_ticked = 1;
		i8254_offset += timer0_max_count;
	}
	i8254_lastcount = count;
	count += i8254_offset;
	mtx_unlock_spin(&clock_lock);
	return (count);
}

Parsing that four-line if () condition is a bit tricky.  First, notice
that count() has already been converted to up-counter form.

 1) If the count has gone backwards, it has obviously wrapped, else
 2) If we've already recorded that it has wrapped, it hasn't, else
 3) If we have a ending clock interrupt, it's wrapped, else
4a) If the count is less than 20, or is less then half of full-scale and
    interrupts are disabled, AND
4b) The interrupt is pending at the interrupt controller,
    then it has wrapped.

But I still don't see how to manage something like this in an SMP
environment, where the interrupt handler might be in the process of running
on a different processor.

It's sometimes possible to very Very Sneaky and use timer 1 (the refresh
counter) to detect overflows in the tick timer, as long as its period
does not evenly divide the tick timer.  Latch them simultaneously,
and use modular congruence to figure out what's happened.

But such sneakiness could have bad interactions with the wide variety
of crapola southbridge implementations out there.

Is there an alternate timer which is GUARANTEED to exist on SMP
systems, obviating the need to solve this problem?  Any other ideas?

Life would be a lot easier if I could use the RTC interrupt for tick
timing (128, 256, or 1024 Hz, as required), and leave the PIC at 18.2 Hz
to interpolate and detect lost ticks.  (You can also detect lost ticks
by reading the RTC just before and after each second to see if it reads
the expected value.)

(P.S. It's surprising how well Linux keeps working when you've disabled
the timer interrupt by buggy 8254 programming from user-space.  Not
well enough to let me undo it without rebooting, however.  For future
reference, after writing the mode, you MUST program the count, even
if the mode you programmed is the same as the previous one.)
