Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVBIOH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVBIOH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 09:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVBIOH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 09:07:57 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57503
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261823AbVBIOHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 09:07:43 -0500
Subject: Re: Preempt Real-time for ARM
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Sven Dietrich <sdietrich@mvista.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
In-Reply-To: <20050209125044.A6312@flint.arm.linux.org.uk>
References: <1107628604.5065.54.camel@dhcp153.mvista.com>
	 <1107948492.17747.31.camel@tglx.tec.linutronix.de>
	 <20050209113140.GB13274@elte.hu>
	 <20050209125044.A6312@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 09 Feb 2005 15:07:36 +0100
Message-Id: <1107958056.17747.70.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

On Wed, 2005-02-09 at 12:50 +0000, Russell King wrote:
> > > We have done the conversion to the generic irq handling and it works
> > > fine on a couple of machines. 
> > 
> > great - this would be a much preferred approach indeed.
> 
> Well, I remain unconvinced about the generic irq handling.
> 
> This caused major changes throughout all the machine support files,
> and I'm _NOT_, repeat _NOT_ going to consider going back to some
> half baked approach which doesn't really fit the needs of the ARM
> architecture, just because "oh, it's generic."  If it doesn't work
> reliably, I'm not interested.

Agreed. Doing it just for the sake of a generic solution is not the
point.

> This is especially so when it impacts so many machines in ways
> specific to each machine, and there's no way to get them tested
> in one go.

Ack.

> If this is to be done, doing it in the middle of a stable kernel series
> is NOT the time or place to do it.  I have recently had people complaining
> about the "stability" of 2.6, particularly in relation to changes made by
> other people affecting drivers.
> 
> Consider these questions in relation to the generic IRQ code:
> 
> 1. Does it know the difference between handling level, edge-based and
>    "simple" IRQs?  ("simple" IRQs are those which are cascaded, but
>    don't have their own individual interrupt mask controls.)

The changes we made to the generic layer in order to make it work on ARM
still call the level/edge/simple handlers.

> 2. Does the generic autoprobe code know which IRQs can be autoprobed
>    and which can't?  (cascade interrupts are just one example of
>    interrupts which must not be autoprobed.  There may be other
>    reasons you wish to avoid probing other interrupts on a particular
>    machine, which the machine support code knows about.)

Makes sense to add this to the generic code anyway.

> 3. Does the generic IRQ code know which IRQs can be claimed and
>    which can't?  (IRQs 0 to NR_IRQS aren't always claimable, even
>    when they appear to be available - iow, desc->handler != &no_irq_type.)

There's a check whether a particular irq has been exclusively allocated
or is available for driver use. Not sure, if it does exactly the same
what you are talking about. Needs to be checked.

> 4. Does it allow per "hw type" retriggering of interrupts, even if the
>    hardware itself is not capable of such an action?  (and running
>    these interrupts at the next hardware interrupt?)

I implemented this basically, but it's not fully tested/functional yet. 

> 5. Does it allow control of interrupt wakeup sources?

Are you talking about PM wakeup ? If yes, it is not there, but isn't
this functionality useful for other platforms than ARM too ?

> 6. Does it allow architectures to define their own irq_desc_t so that
>    all the data for a particular IRQ is localised and contained within
>    one data structure?

Having a generic irq_desc_t with an architecture specific member "struct
arch_irq_desc_t bla;" should do the job.

> In essence, I'm opposed to completely rewriting the ARM interrupt
> handling at this stage.

As expected :)
I accept your decision, but I hope that you are not completely opposed
to discuss a conversion at all, especially as other architectures will
benefit from the necessary changes to the generic code too. 

Thanks for the pointers so far.

tglx


