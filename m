Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWIHLE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWIHLE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 07:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWIHLE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 07:04:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:7296 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750797AbWIHLE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 07:04:28 -0400
Subject: Re: [PATCH] FRV: Use the generic IRQ stuff
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org,
       tglx@linutronix.de
In-Reply-To: <10468.1157710616@warthog.cambridge.redhat.com>
References: <1157672581.22705.345.camel@localhost.localdomain>
	 <20060907133845.5031.87111.stgit@warthog.cambridge.redhat.com>
	 <10468.1157710616@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 21:03:32 +1000
Message-Id: <1157713412.31071.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 11:16 +0100, David Howells wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > > +	.end		= frv_fpga_end,
> > > +};
> > 
> > Why do you have a end() handler ? (and an empty one....) Your FPGA
> > interrupts ase using the level generic flow handler right ? That doesn't
> > call end(). Though you might want to have a mask_ack() "combined"
> > callback to avoid two indirect calls (it's an optional optimisation). 
> 
> This is called unconditionally from __do_IRQ().  It's also not listed in
> genericirq.tmpl, though ack(), mask(), etc. are.  The header file (irq.h)
> doesn't say that it is optional, though it does say that startup(), shutdown(),
> etc. are, therefore the assumption would be that it isn't optional.

Well, you shoud not use __do_IRQ if you use the genirq stuff... the
callbacks that are needed depend on which flow handler you use. 

> > Ahem... __do_IRQ()... That's probably part of your bloat... With a
> > conversion to genirq, you shouldn't use __do_IRQ() anymore (and thus it
> > shouldn't be compiled in). In fact, that defeats genirq completely as
> > you aren't calling the new handlers at all there. You should call
> > generic_handle_irq() instead.
> 
> It's not mentioned in the docs:
> 
> 	warthog>grep generic_handle_irq Documentation/DocBook/genericirq.tmpl 
> 	warthog1>
> 
> Looking at the code itself, generic_handle_irq() is a wrapper around
> __do_IRQ():
> 

No, it's a wrapper around desc->handler_irq, which is the flow handler
you install. The fallback to __do_IRQ is only if you don't implement a
flow handler (still have one of your PICs not using it). However, that
means that if you use generic_handle_irq(), then __do_IRQ will have to
be linked in, that's a good point, we might want to provide a different
wrapper for archs that have done a total conversion...

> 	static inline void generic_handle_irq(unsigned int irq,
> 					      struct pt_regs *regs)
> 	{
> 		struct irq_desc *desc = irq_desc + irq;
> 
> 		if (likely(desc->handle_irq))
> 			desc->handle_irq(irq, desc, regs);
> 		else
> 			__do_IRQ(irq, regs);
> 	}
> 
> So I don't see how it can help but make the code larger.  The if-statement in
> it can't be optimised down because its condition depends on a value held in
> memory and is not subject to compile-time evaluation.

That helper is my fault :) It's mostly because at one point, I had a
partial conversion and some of my PICs were still using __do_IRQ(). Ingo
initial design wants you to call desc->handle_irq() directly.

> It will make things quicker, probably, since it bypasses __do_IRQ() when
> possible, but if it can't, it will make things slower as you'll have this
> check, the condition will fail against expectations, and then you'll still have
> to do __do_IRQ() anyway.

Yes, we can avoid it though as I just wrote.

> > > +static struct irqaction fpga_irq[4]  = {
> > ...
> >  .../...
> 
> Can you rephrase your comment?
> 
> > > +	setup_irq(IRQ_CPU_EXTERNAL0, &fpga_irq[0]);
> > > +	setup_irq(IRQ_CPU_EXTERNAL1, &fpga_irq[1]);
> > > +	setup_irq(IRQ_CPU_EXTERNAL2, &fpga_irq[2]);
> > > +	setup_irq(IRQ_CPU_EXTERNAL3, &fpga_irq[3]);
> > >  }
> > 
> > Your approach to cascades might be wrong here. Instead of setting up an
> > irq handler, you could just attach a chained flow handler. Much less
> > overhead.
> 
> That's an undocumented feature:

I haven't checked the docs. I suggest you look how I did it on powerpc.
I'll see if I can improve the doc next week.

> 	warthog>grep -i chain Documentation/DocBook/genericirq.tmpl 
> 	warthog1>
> 
> > > +	.enable		= frv_fpga_enable,
> > > +	.disable	= frv_fpga_disable,
> > > +	.ack		= frv_fpga_ack,
> > > +	.mask		= frv_fpga_disable,
> > > +	.unmask		= frv_fpga_enable,
> > > +	.end		= frv_fpga_end,
> > > +};
> > 
> > SImilar comments. Also, you are using enable/disable here. Just leave
> > them NULL and the generic code will call your mask/unmask.
> 
> Hmmm... I see that irq_chip_set_defaults() installs intermediary functions in
> the chip ops table for anything it doesn't have.  Surely it'd be better to
> require people to fill in the appropriate default functions directly as you
> could then make the table const.  That's what you've got documentation for,
> right?

Well... enable/disable are higher level than mask/umask... it's not
completely clear to me if we should keep them under control of the
irq_chip at all ... It's mostly useful for thigns that haven't yet been
ported...

> > You do that in another one at least... And I have to go now so I can't
> > finish reviewing your patch :) But it looks like you aren't properly
> > "converting" to the genirq code and thus not getting all of the benefit,
> > like faster code path to cascade handlers, etc... and you aren't getting
> > rid of __do_IRQ() so at the end of the day, you aren't using the new
> > stuff and still link in the old one :)
> 
> Documentation/DocBook/genericirq.tmpl doesn't do a very good job of explaining
> it.  The comments in include/linux/irq.h also need a check as some of them are
> out of date.
> 
> Take the comment at the head of struct irq_desc for example, it mentions fields
> that are absent in the structure, the HTML doc generator spits out warnings in
> relation to linux/irq.h.
> 
> I would also recommend that a line be added to the banner comments at the top
> of linux/irq.h to point to the documentation, just like is done in the .c files
> implementing genirq.

We should indeed improve the documentation. 

Cheers,
Ben.


