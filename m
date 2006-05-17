Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWEQW1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWEQW1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWEQW1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:27:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751290AbWEQW1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:27:51 -0400
Date: Wed, 17 May 2006 23:27:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 00/50] genirq: -V3
Message-ID: <20060517222734.GC30073@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Paul Mackerras <paulus@samba.org>
References: <20060517001310.GA12877@elte.hu> <1147846317.4025.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147846317.4025.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, I'll say I haven't read Ingo's patches yet, sorry.  I'm only
responding to _this_ message, not commenting on Ingo's work.  So
this is an initial response only.  I'm not going to be able to properly
review this until June.

On Wed, May 17, 2006 at 04:11:56PM +1000, Benjamin Herrenschmidt wrote:
> >From your previous implementation, you removed the distinction between
> irq_type and irq_chip, they are no longer separate structures.
> But you still basically merged all the "new" fields together. Thus we
> end up with things like both enable/disable/ack/end "high level" and
> mask+ack/unmask "low level" callbacks in the irq chip. That makes
> things confusing. 

First question I have for you is whether you've read through the
existing ARM IRQ handling code.  If not, please do so because it
represents real requirements we have.  Almost everything you see
there is not "by accident" but "by design because it was necessary"
to solve real world problems.

For instance, we do not actively mask interrupts when disable_irq()
is called because we have to record events on edge triggered
interrupts to replay them when a subsequent enable_irq() occurs.
(Some people disagree with this, which is fine from an academic
view point, but unfortunately we have to deal with real life
systems and implementations, where things have to work.)

We also have to deal with stupid combinations such as edge triggered
inputs connected to a secondary interrupt controller, which provides
a pulse trigger output.  In turn, this is logically orred with some
other random non-maskable interrupt sources and fed into an edge
triggered input on the primary interrupt controller.

Unfortunately, saying "we don't support that" is not an option.  We
do support that and we support it cleanly on ARM with the code we
have.

> If we go back to the initial hw_interrupt_type (which was a misnamed
> hw_interrupt_controller, or irq_chip, I'm not opposing the name
> change), we have the enable/disable/ack/end "API" to the main old flow
> handler (__do_IRQ) and other API functions. I am not convinced that it
> makes sense to add "lower level" functions to it at this level.
> Essentially, I think those new callbacks are either redundant or not
> necessary.

You are probably correct, but how do we get to that point without
rewriting from scratch something and probably end up breaking a lot
of machines in the process which used to work?

> First, as we discussed on IRC, I yet have to find a convincing example
> of an irq controller that cannot fit the current __do_IRQ() flow
> handler.

Well, I've not been too forthcoming about this whole "generic IRQ"
thing because (a) I remember all the pain that we had in 2.4 kernels
when we modelled our interrupt system on the x86 way, and (b) I re-
designed our model to something which works for all our requirements
and it does work well with the absolute minimum of overhead... on ARM.

So, I'm rather scared of letting go of something that I know fits our
requirements in favour of going back to something which might be able
to be bent to fit our requirements but might involve compromising on
some corner case.

That said, if someone can show that they can implement a generic IRQ
subsystem which works for x86, PPC, Alpha, ARM, etc, and get it tested
on enough ARM platforms that we're reasonably sure that it's going to
work, I'm not going to stand in the way of that.

> For an example (among others) of why I find the split handlers
> approach less robust is the logic of handling an IRQ that is already
> in progress. This logic is useful for edge interrupts in the normal
> case and thus you implemented it in your edge handler. But why remove
> it from the level handler ? For "normal" level interrupts, it's not
> supposed to happens, but IRQ controllers have bugs, especially smarter
> ones, and that logic can't harm.

Firstly, if you require the more "robust" handling, then you can use
the edge method - nothing stops that.  But why impose the considerable
overhead of the edge method on everyone?

Secondly, there are fundamental differences in the way we handle "edge"
and "level" IRQs on ARM - "edge" interrupts are _always_ unmasked
prior to calling the handlers, whereas "level" interrupts must _never_
be unmasked until all handlers have completed.

The constraint on the "edge" case is that if we leave the interrupt
masked while the handlers are called, and, let's say your ethernet
chip receives a packet just as the drivers handler returns, that
edge transition will be lost, and you'll lose your network interface.

The constraint on the "level" case is that if you leave the interrupt
unmasked, as soon as the CPU unmasks it's interrupt (eg, when calling
a handler with SA_INTERRUPT) you immediately take an interrupt exception
and repeat the process, until your kernel stack has gobbled up all
system memory.

> Also, the "split" handlers enforce the semantic that, for example, a
> level interrupt needs to be mask'ed and ack'ed, to be unmasked later
> while an edge interrupt should be left free to flow after ack. That
> sounds good on paper and matches probably the requirements of dumb
> controllers but doesn't quite agrees with smarter things like
> OpenPIC/MPIC, XICS, or even hypervisors.

As you see above, there's good reasons for that difference in behaviour,
and enforcing one common behaviour breaks real-life hardware on ARM.

I don't have much more of a response now - maybe once I've reviewed
the changes in full (see note at the top of this message) I might have
some more comments.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
