Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbULNCho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbULNCho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 21:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbULNChn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 21:37:43 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:65153 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261379AbULNChJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 21:37:09 -0500
Date: Tue, 14 Dec 2004 03:36:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041214023651.GT16322@dualathlon.random>
References: <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213191249.GB1052@elf.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 08:12:49PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > But that does not matter, right? Yes, one-shot timer will not fire
> > > exactly at right place, but as long as you are reading TSC and basing
> > > next shot on current time, error should not accumulate.
> > 
> > As said in the rest of the message, the error (or some other error)
> > accumulates heavily today in the tick-loss compensation/adjustment
> > algorithm in arch/i386/kernel/timers/timer_tsc.c, so I'm sceptical
> > about
> 
> I do not see how it should accumulate. Lets have working TSC. You want
> to emulate fixed-period timer with single-shot timer.
> 
> int should_fire_at;
> 
> void handle_single_shot()
> {
> 	int delay;
> retry:n
> 	should_fire_at += loops_per_second/HZ
> 	delay = should_fire_at - get_tsc();
> 	if (delay < 0)
> 		goto retry;

Here you get a 10minute long NMI and you're automatically 10 minute in
the past (or your event gets a 10 sec introduced delay) without a way to
track it down.

Now in theory we might run this critical section into some special
section and we could restart it by updating regs->eip before returning
form the nmi. But that still leaves the unfixable window introduced by
the cpu not executing the tsc read and the do_single_shot_in atomically.

Given my recent experience with the lost tick compensation code that has
exactly the same window, I'm not optimistic it's going to keep the system
time uptodate accurately. Perhaps the apic is a lot faster and the error
won't propagate visibly. I'm not against trying but the thing about the
one-shot timer system time accuracy is a lot more complicated than this
pseudocode, and it's not obvious at all that your pseducode will work.

> 	do_single_shot_in(delay);

The only other way would be to use the 64bit tsc as the only source for
the system time (perhaps that's what you mean with the above
pseudocode?). But the calibration code would need changes to allow that.
Today we use the calibration divisor only in a small range so the
calibration can be quick and this way changing CPU frequency to the cpu
is also easier.

Even before thinking at using the one-shot timer, I would like to
fix the lost tick compensation of current production 2.6.9, only then we
can talk about tickless by using a one-shot timer. If we can't do the
lost-tick compensation without screwing the system time, I don't see how
we can do the one-shot timer without screwing the system time.

The lost tick compensation as well could be avoided if we use the TSC as
the source for gettimeofday and we ignore the PIT completely and we use
the PIT only to wakeup the cpu once in a while. *Then* we could convert
the PIT to a one-shot timer trivially too, but as said above the
accuracy of the divisor isn't enough and I've no idea if we can get a
real calibration that lasts more than a few hours.

My fast_gettimeoffset_quotient is set to 0x2f0271, that means the last
significant bit of the fast_gettimeoffset_quotient will showup in the
gettimeofday last singificant bit, after the tsc counted 2**32 ticks,
that means after less then 4 seconds in my computers at >1ghz. That's
why the gettimeoffset will never return anything longer than 1/HZ, so
the error cannot propagate in userspace.
