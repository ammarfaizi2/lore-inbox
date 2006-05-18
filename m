Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWERAdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWERAdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 20:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWERAdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 20:33:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:20717 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751006AbWERAdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 20:33:49 -0400
Subject: Re: [patch 00/50] genirq: -V3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060517222734.GC30073@flint.arm.linux.org.uk>
References: <20060517001310.GA12877@elte.hu>
	 <1147846317.4025.18.camel@localhost.localdomain>
	 <20060517222734.GC30073@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 18 May 2006 10:32:41 +1000
Message-Id: <1147912361.10703.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First question I have for you is whether you've read through the
> existing ARM IRQ handling code.  If not, please do so because it
> represents real requirements we have.  Almost everything you see
> there is not "by accident" but "by design because it was necessary"
> to solve real world problems.
> 
> For instance, we do not actively mask interrupts when disable_irq()
> is called because we have to record events on edge triggered
> interrupts to replay them when a subsequent enable_irq() occurs.

Hrm... that is lost with Ingo/Thomas patch at the moment... mostly
because the irq_type structure is now gone and the only remaining of it
is a per-desc "handler" function which allows custom flow handlers, but
not custom disable_irq/enable_irq.

That might be one argument to keep the split between disable/enable and
mask/unmask in the irq_chip structure but I'm not too keen on that,
since that means adding back flow information to irq_chip which the
patch is trying to get rid of.

An option would be to re-introduce irq_type but I really don't like it

> (Some people disagree with this, which is fine from an academic
> view point, but unfortunately we have to deal with real life
> systems and implementations, where things have to work.)

What is the exact reason where you need to do that ? You controller
stops latching edges when they are masked completely ? Or is just not
emitting upstream irqs (but still have the bits set). The old Apple one
doesn't re-emit when re-enabled but we can still read what happened from
the chip and thus we re-emit them ourselves when re-enabling.

> We also have to deal with stupid combinations such as edge triggered
> inputs connected to a secondary interrupt controller, which provides
> a pulse trigger output.  In turn, this is logically orred with some
> other random non-maskable interrupt sources and fed into an edge
> triggered input on the primary interrupt controller.

So you have a secondary controller that takes an edge input and outputs
an edge too, which edge is also shared with another edge interrupt from
another device ? Damn ! Sharing of edge interrupts is fairly insane in
the first place :) Still, I yet have to see why the above is a problem
with the current flow handler ;)

> Unfortunately, saying "we don't support that" is not an option.  We
> do support that and we support it cleanly on ARM with the code we
> have.

Oh I'm sure of that, but I haven't been proven yet that the code we have
in __do_IRQ() can't support that too :)

At this point it was pretty much agreed to have custom flow handlers
(even if I'm still convinced that a generic one works just fine :)
though we don't have custom enable_irq and disable_irq in the flow
handler. Thus you'll still need an irq_chip per type with the current
approach if you want to do that kind of soft-disabe of egde interrupts

> You are probably correct, but how do we get to that point without
> rewriting from scratch something and probably end up breaking a lot
> of machines in the process which used to work?

Well, at least _document_ the old disable/enable callbacks as being
redundant with the new mask/unmask and on the way to obsolescence to
make the situation clear :) I didn't understand why we kept 4 calls
until I finally figured out that they have indeed the same semantic,
it's just a renaming/compatibility issue

> Well, I've not been too forthcoming about this whole "generic IRQ"
> thing because (a) I remember all the pain that we had in 2.4 kernels
> when we modelled our interrupt system on the x86 way, and (b) I re-
> designed our model to something which works for all our requirements
> and it does work well with the absolute minimum of overhead... on ARM.
>
> So, I'm rather scared of letting go of something that I know fits our
> requirements in favour of going back to something which might be able
> to be bent to fit our requirements but might involve compromising on
> some corner case.
>
> That said, if someone can show that they can implement a generic IRQ
> subsystem which works for x86, PPC, Alpha, ARM, etc, and get it tested
> on enough ARM platforms that we're reasonably sure that it's going to
> work, I'm not going to stand in the way of that.

Ok good :) I was afraid you would stay there saying "if the new generic
code isn't exactly like the ARM stuff I'll stay in my fork" :)

> Firstly, if you require the more "robust" handling, then you can use
> the edge method - nothing stops that.  But why impose the considerable
> overhead of the edge method on everyone?

"considerable overhead" ? heh ! One if and a while loop... I wouldn't
call that considerable :)

> Secondly, there are fundamental differences in the way we handle "edge"
> and "level" IRQs on ARM - "edge" interrupts are _always_ unmasked
> prior to calling the handlers, whereas "level" interrupts must _never_
> be unmasked until all handlers have completed.

Yes, I have seen that. My main concern was that "smart" controllers that
handle the flow in HW are unhappy with that level of abstraction
(mask/ummask's being called from the flow handler instead of just
ack/end). That is solved by having a separate "fastack" flow handler for
these though.

> The constraint on the "edge" case is that if we leave the interrupt
> masked while the handlers are called, and, let's say your ethernet
> chip receives a packet just as the drivers handler returns, that
> edge transition will be lost, and you'll lose your network interface.

Well, it's the same issue you are talking about for
enable_irq/disable_irq and edge interrupts, essentially that you don't
get edge interrupts that were masked. Thus my question above: are they
masked prior to being latched (thus totally lost) or just not re-emitted
when unmasking ? In the later case, it's mostly a matter of reading back
and re-emitting.

However, I do like the whole concept of soft-disabling in the _generic_
case (it's useable for level interrupts as well, they just need to be
masked if they happen while disabled). The current patch from Thomas and
Ingo doesn't do soft-disable afaik. Thus you'll still get your
chip->mask called when disable_irq() is called (which you don't want).

I wonder if we can generalise soft-masking in a way that will allow to
nicely handle your case as well without having to have per-chip
high-level disable/enable...

> The constraint on the "level" case is that if you leave the interrupt
> unmasked, as soon as the CPU unmasks it's interrupt (eg, when calling
> a handler with SA_INTERRUPT) you immediately take an interrupt exception
> and repeat the process, until your kernel stack has gobbled up all
> system memory.

Yes well, thank's for interrupts 101 :)

Ben.


