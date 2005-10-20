Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbVJTHrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbVJTHrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 03:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbVJTHrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 03:47:13 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:42995 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751791AbVJTHrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 03:47:12 -0400
Date: Thu, 20 Oct 2005 03:46:53 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <20051020073416.GA28581@elte.hu>
Message-ID: <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
 <1129747172.27168.149.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Oct 2005, Ingo Molnar wrote:

>
> if the bug is only possible when timesources are changed on the fly,
> then i think it shouldnt happen. We pick our sources at bootup time and
> stick with them.
>
> in the -rt tree we also have clockevents and HRT support, so the clocks
> used should depend on whether you have the APIC enabled in the .config,
> and whether the BIOS has it enabled by default. If the BIOS has the APIC
> disabled then you can force the kernel to enable it by adding "lapic" to
> the boot-line.

On this test machine, I had to add the lapic command line, but that was
there when I first had to get NMI working on this machine back in the V0.7
days :-)


>
> without the APIC active, the equation is simple: we use the PIT for both
> jiffies and HRT. We use the TSC for gettimeofday. No interaction between
> the two.
>
> if the APIC is active, then we have both the local APIC timer interrupt
> for and the PIT for HRT timing. The clockevents framework sees both
> hardware clocks and automatically decides which one to use, based on
> their ranking. A typical PIT reprogramming PIO sequence takes 20-30
> usecs, while a typical APIC timer reprogramming takes ~5 nanoseconds on
> my box, so the choice is rather easy ;-) The jiffies interrupt is still
> off the PIT. gettimeofday is off the TSC counter.
>
> i could imagine the following hardware effects to cause time warps:
>
> - the TSC is in fact the 'read counter' method of the local APIC timer
>   hardware. So there can be interactions in theory: programming the APIC
>   timer could impact the TSC and vice versa. There have been CPU
>   erratums in this area in the past.

Could this cause a 2 second drop backwards?

>
> - powersaving can impact the TSC - and can thus impact the APIC timer
>   too. Errata-land as well.

Well, this machine is a normal PC not a laptop, and anyway, this backwards
clock happened during a stress test with pretty much 100% CPU usage, so I
think we can rule out power saving.

>
> - the TSC itself could have short, temporary warps. I had a box that
>   showed such effects.

Can this be a 2 second warp?

>
> besides hardware bugs, another, albeit very small possibility is that
> somewhere in the thousands of lines of shiny-new generic-time-of-day,
> ktimers, clockevents and high-res-timers code, there is a software bug,
> which is causing time warps ;-)
>

My older code first used jiffies as a timer, then I switched to TSC and
then to APIC timer, and then finally ktimer.  ktimer was the first to show
a backwards get_time.

-- Steve

