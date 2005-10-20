Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVJTHeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVJTHeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 03:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbVJTHeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 03:34:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:35743 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750812AbVJTHeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 03:34:09 -0400
Date: Thu, 20 Oct 2005 09:34:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <20051020073416.GA28581@elte.hu>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain> <1129734626.19559.275.camel@tglx.tec.linutronix.de> <1129747172.27168.149.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > Last night I just caught a bug I accidentally introduced with the fixed
> > interval math (oh, if only optimizations didn't dirty code so!), where
> > time inconsistencies were possible when clocksources were changed. I'm
> > not sure if that's the issue being seen above, but I'll wrap things up
> > and send out a B8 release today if I can.
> 
> Hmm, I believe that the ktimers use the apic (when available) and let 
> the jiffies still be calculated via PIT/TSC.
> 
> Thomas, is the above correct?
> 
> Would that have triggered your bug?

if the bug is only possible when timesources are changed on the fly, 
then i think it shouldnt happen. We pick our sources at bootup time and 
stick with them.

in the -rt tree we also have clockevents and HRT support, so the clocks 
used should depend on whether you have the APIC enabled in the .config, 
and whether the BIOS has it enabled by default. If the BIOS has the APIC 
disabled then you can force the kernel to enable it by adding "lapic" to 
the boot-line.

without the APIC active, the equation is simple: we use the PIT for both 
jiffies and HRT. We use the TSC for gettimeofday. No interaction between 
the two.

if the APIC is active, then we have both the local APIC timer interrupt 
for and the PIT for HRT timing. The clockevents framework sees both 
hardware clocks and automatically decides which one to use, based on 
their ranking. A typical PIT reprogramming PIO sequence takes 20-30 
usecs, while a typical APIC timer reprogramming takes ~5 nanoseconds on 
my box, so the choice is rather easy ;-) The jiffies interrupt is still 
off the PIT. gettimeofday is off the TSC counter.

i could imagine the following hardware effects to cause time warps:

- the TSC is in fact the 'read counter' method of the local APIC timer 
  hardware. So there can be interactions in theory: programming the APIC 
  timer could impact the TSC and vice versa. There have been CPU 
  erratums in this area in the past.

- powersaving can impact the TSC - and can thus impact the APIC timer 
  too. Errata-land as well.

- the TSC itself could have short, temporary warps. I had a box that
  showed such effects.

besides hardware bugs, another, albeit very small possibility is that 
somewhere in the thousands of lines of shiny-new generic-time-of-day, 
ktimers, clockevents and high-res-timers code, there is a software bug, 
which is causing time warps ;-)

	Ingo
