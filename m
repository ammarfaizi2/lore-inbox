Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVBIMvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVBIMvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 07:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVBIMvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 07:51:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41488 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261814AbVBIMuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 07:50:51 -0500
Date: Wed, 9 Feb 2005 12:50:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Walker <dwalker@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Sven Dietrich <sdietrich@mvista.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Preempt Real-time for ARM
Message-ID: <20050209125044.A6312@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Walker <dwalker@mvista.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sven Dietrich <sdietrich@mvista.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
References: <1107628604.5065.54.camel@dhcp153.mvista.com> <1107948492.17747.31.camel@tglx.tec.linutronix.de> <20050209113140.GB13274@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050209113140.GB13274@elte.hu>; from mingo@elte.hu on Wed, Feb 09, 2005 at 12:31:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 12:31:40PM +0100, Ingo Molnar wrote:
> 
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Sat, 2005-02-05 at 10:36 -0800, Daniel Walker wrote:
> > 
> > > The biggest point of discussion relates to the interrupts in threads
> > > implementation. It is largely identical to what is implemented in the
> > > generic irq handling. However, ARM doesn't not implement generic irq
> > > handling, and will not support it in the near future. I am not in
> > > support of two different threaded interrupt implementations. 
> > 
> > We have done the conversion to the generic irq handling and it works
> > fine on a couple of machines. 
> 
> great - this would be a much preferred approach indeed.

Well, I remain unconvinced about the generic irq handling.

Back in 2.4 times, ARM used to use the x86 way to handle IRQs, and
it caused lots of dropped IRQs for CF cards and the like, particularly
in mixed level/edge triggered interrupt environments (where a mixture
of level and edge based outputs are connected to edge triggered inputs.)

The ARM IRQ code got completely rewritten during 2.5 with a clean
design, generated from the requirements of the machines.

This caused major changes throughout all the machine support files,
and I'm _NOT_, repeat _NOT_ going to consider going back to some
half baked approach which doesn't really fit the needs of the ARM
architecture, just because "oh, it's generic."  If it doesn't work
reliably, I'm not interested.

This is especially so when it impacts so many machines in ways
specific to each machine, and there's no way to get them tested
in one go.

If this is to be done, doing it in the middle of a stable kernel series
is NOT the time or place to do it.  I have recently had people complaining
about the "stability" of 2.6, particularly in relation to changes made by
other people affecting drivers.

Consider these questions in relation to the generic IRQ code:

1. Does it know the difference between handling level, edge-based and
   "simple" IRQs?  ("simple" IRQs are those which are cascaded, but
   don't have their own individual interrupt mask controls.)

2. Does the generic autoprobe code know which IRQs can be autoprobed
   and which can't?  (cascade interrupts are just one example of
   interrupts which must not be autoprobed.  There may be other
   reasons you wish to avoid probing other interrupts on a particular
   machine, which the machine support code knows about.)

3. Does the generic IRQ code know which IRQs can be claimed and
   which can't?  (IRQs 0 to NR_IRQS aren't always claimable, even
   when they appear to be available - iow, desc->handler != &no_irq_type.)

4. Does it allow per "hw type" retriggering of interrupts, even if the
   hardware itself is not capable of such an action?  (and running
   these interrupts at the next hardware interrupt?)

5. Does it allow control of interrupt wakeup sources?

6. Does it allow architectures to define their own irq_desc_t so that
   all the data for a particular IRQ is localised and contained within
   one data structure?

What you'll find is that the ARM interrupt structure is designed to
efficiently meet the requirements of our wide range of hardware interrupt
controllers, with chained interrupt controllers, with as low latency as
possible.

In essence, I'm opposed to completely rewriting the ARM interrupt
handling at this stage.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
