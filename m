Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWESPbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWESPbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWESPbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:31:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13259 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932347AbWESPbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:31:53 -0400
Date: Fri, 19 May 2006 17:31:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tim Mann <mann@vmware.com>
cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: Fix time going backward with clock=pit [1/2]
In-Reply-To: <20060518190220.2a9aa33e@mann-lx.eng.vmware.com>
Message-ID: <Pine.LNX.4.64.0605191424360.32445@scrub.home>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
 <Pine.LNX.4.64.0605181249020.17704@scrub.home> <20060518115022.0561c24d@mann-lx.eng.vmware.com>
 <Pine.LNX.4.64.0605190108010.32445@scrub.home> <20060518190220.2a9aa33e@mann-lx.eng.vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 May 2006, Tim Mann wrote:

> Tangentially, let me point out another thing: letting get_offset_pit
> return more than a jiffy is dangerous if we can ever lose a tick (due to
> interrupts being disabled for too long, etc.).  If that happens,
> get_offset_pit might advance time past the lost tick, but when the next
> non-lost tick comes in, jiffies is incremented by only 1 and count
> recycles again, so time effectively snaps backward to the point where
> the lost tick occurred.  Losing ticks is bad in itself, of course, but
> having that make time actually go backward by about a jiffy (rather than
> just stop for one jiffy) seems a bit worse.

This can only happen if someone disables the interrupts for too long and 
then calls get_offset_pit(). As soon as the timer interrupt had a chance 
to run, time is advanced and everything should be fine.
IMO it's not worth it to support such misbehaviour.

> > > However, we don't really have a way to detect that this case happened --
> > > the "&& underflow" in your code is a handwave.
> > 
> > Ok, I'm not that familiar with Intel hardware (it must be crappier than I 
> > thought). Is there really no way to detect the pending interrupt (e.g. 
> > what do_timer_overflow() does)? Without that information one can really 
> > only guess the time.
> >
> > It's not that important if it's not completely correct for SMP systems, 
> > they usually have other sources, but for the few systems there this is the 
> > only time source, we should at least make an effort to avoid the read 
> > error.
> 
> Hmm.  If you don't care about SMP systems, that makes the problem
> tractable.  In that case get_offset_pit can assume that acknowledging
> the interrupt and incrementing jiffies happen atomically (since that's
> done at interrupt level), so checking whether there's an unacknowledged
> interrupt is a sound approach.  I'm definitely not expert enough to be
> sure how/if you can do that correctly, though.  The current code in
> do_timer_overflow may be correct for systems using PIC interrupt
> routing, but it doesn't seem to work in the APIC systems I've tried it
> on, and I don't have a suggestion for how to fix that case.  Maybe
> someone else does...?
> 
> It also would be preferable to fix the SMP case so that at least time
> doesn't go backward there, in case someone tries to use the pit
> clocksource there.  It's quite easy to hit the window where one CPU
> calls gettimeofday while another one has ack'd a timer interrupt but
> hasn't incremented jiffies yet.  Or I suppose we could disable the pit
> clocksource for SMP systems, but that seems a bit draconian.

We should at least add a warning that the clock is not usable for precise 
timekeeping (in the resolution limits one would expect from it).

In the UP case we can live without the underflow information, if we assume 
the function is called with interrupts enabled and it's properly restarted 
in case of an underflow via the timer interrupt. If we do this, we also 
have to document this somewhere that it relies on the current seq_lock 
bevaviour.
I guess in the SMP IO-APIC case we can't do much more than print the 
warning and make sure the time doesn't go backwards as you suggested.

If the underflow information is usable from the PIC, we could make proper 
use of it as I suggested and this had the advantange it's safe to use with 
interrupts disabled and doesn't require retrying. Although to make it safe 
for SMP it would also require synchronisation with the interrupt 
acknowledgement.

Anyway, the current underflow handling is next to useless, so I guess it's 
better to remove it and just document the current limitations. If someone 
cares enough, he can then do an alternative offset function properly using 
the information from the PIC.

bye, Roman
