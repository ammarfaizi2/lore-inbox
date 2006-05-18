Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWERHjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWERHjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWERHjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:39:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60943 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751302AbWERHjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:39:07 -0400
Date: Thu, 18 May 2006 08:38:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 00/50] genirq: -V3
Message-ID: <20060518073853.GA27687@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Paul Mackerras <paulus@samba.org>
References: <20060517001310.GA12877@elte.hu> <1147846317.4025.18.camel@localhost.localdomain> <20060517222734.GC30073@flint.arm.linux.org.uk> <1147912361.10703.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147912361.10703.40.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 10:32:41AM +1000, Benjamin Herrenschmidt wrote:
> > (Some people disagree with this, which is fine from an academic
> > view point, but unfortunately we have to deal with real life
> > systems and implementations, where things have to work.)
> 
> What is the exact reason where you need to do that ? You controller
> stops latching edges when they are masked completely ?

Yes.  The only way to disable interrupt detection on these inputs is
to disable the rising and falling edge detection enables.

Hence, if you disable the edge detection to mask the interrupt, and
an edge transition occurs (the one which you're interested in), when
you come to re-enable the edge detection, that transition will have
been missed.

> > We also have to deal with stupid combinations such as edge triggered
> > inputs connected to a secondary interrupt controller, which provides
> > a pulse trigger output.  In turn, this is logically orred with some
> > other random non-maskable interrupt sources and fed into an edge
> > triggered input on the primary interrupt controller.
> 
> So you have a secondary controller that takes an edge input and outputs
> an edge too, which edge is also shared with another edge interrupt from
> another device ? Damn ! Sharing of edge interrupts is fairly insane in
> the first place :) Still, I yet have to see why the above is a problem
> with the current flow handler ;)

Not quite - the other non-maskable interrupt sources are level based
outputs.  In this particular case, these sources are fed through an
FPGA and you have status bits for each, but no way to enable or disable
each individual source.  The output interrupt is just a logical OR of
the sources.

> > Secondly, there are fundamental differences in the way we handle "edge"
> > and "level" IRQs on ARM - "edge" interrupts are _always_ unmasked
> > prior to calling the handlers, whereas "level" interrupts must _never_
> > be unmasked until all handlers have completed.
> 
> Yes, I have seen that. My main concern was that "smart" controllers that
> handle the flow in HW are unhappy with that level of abstraction
> (mask/ummask's being called from the flow handler instead of just
> ack/end). That is solved by having a separate "fastack" flow handler for
> these though.

It sounds like you've solved this problem already.

> > The constraint on the "edge" case is that if we leave the interrupt
> > masked while the handlers are called, and, let's say your ethernet
> > chip receives a packet just as the drivers handler returns, that
> > edge transition will be lost, and you'll lose your network interface.
> 
> Well, it's the same issue you are talking about for
> enable_irq/disable_irq and edge interrupts, essentially that you don't
> get edge interrupts that were masked. Thus my question above: are they
> masked prior to being latched (thus totally lost) or just not re-emitted
> when unmasking ? In the later case, it's mostly a matter of reading back
> and re-emitting.

Totally lost - there is nothing to read back to tell you that the
active edge transition occurred.

> However, I do like the whole concept of soft-disabling in the _generic_
> case (it's useable for level interrupts as well, they just need to be
> masked if they happen while disabled).

That is incredibly wasteful for level interrupts - what you're suggesting
means that to service a level interrupt, you take an interrupt exception,
start processing it, take another interrupt exception, disable the source,
return from that interrupt and continue to service it.  No thanks.

I thought you were the one concerned about interrupt handling overhead
(about the overhead introduced by function pointer calls.) but that
idea _far_ outweighs function pointer overheads.

> > The constraint on the "level" case is that if you leave the interrupt
> > unmasked, as soon as the CPU unmasks it's interrupt (eg, when calling
> > a handler with SA_INTERRUPT) you immediately take an interrupt exception
> > and repeat the process, until your kernel stack has gobbled up all
> > system memory.
> 
> Yes well, thank's for interrupts 101 :)

Sigh, I'm not teaching you to suck eggs - I was trying to justify
clearly _why_ we have these different "flow" handlers on ARM and why
they are important by contrasting the differences between them.

Obviously, I should've just ignored your email since you know everything
already.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
