Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTJIRqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTJIRqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:46:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5265 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262366AbTJIRqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:46:05 -0400
Date: Thu, 9 Oct 2003 18:46:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Message-ID: <20031009174604.GC7665@parcelfarce.linux.theplanet.co.uk>
References: <20031009154641.GB7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310090851390.10041-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310090851390.10041-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 09:01:36AM -0700, Linus Torvalds wrote:
> 
> On Thu, 9 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> >
> > IOW, the question is: do we want enable_irq() to undo all effects of
> > disable_irq()?  Whether the current behaviour is intentional or not,
> > it's worth documenting, IMO...
> 
> I think yes, it would be clean to make enable_irq() clean up properly. 
> That includes clearing the IRQ_INPROGRESS bit along with the IRQ_DISABLED 
> but. It won't even make the codepath longer, it just changes a constant.
> 
> And yes, I think we should just remove the clearing of depth in 
> setup_irq(), _and_ make the enabling of the irq be dependent on depth 
> being non-zero.
> 
> In 2.6.x terms, we'd like to go towards something like the appended, but 
> this actually has a _different_ problem: we have separate "->startup()" vs 
> "->enable()" functions for the irq controller, and this means that if the 
> interrupt was disabled when the first irq handler was requested, 
> "->startup()" wouldn't be called at all.
> 
> So my suggestion would be:
>  - do the IRQ_INPROGRESS clearing (safe, since disable_irq() will have 
>    waited for it if it was valid)
>  - leave the depth reset as-is for now, and think about how we'd like to 
>    solve it.
>  - make the synchronize_irq() conditional in irq_disable() (2.6.x now
>    already does that part, so it's not in the patch)
> 
> Hmm?

I've looked through the uses of IRQ_DISABLED in 2.6.  Fun things found:

a) on alpha:
void
i8259a_end_irq(unsigned int irq)
{
        if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
                i8259a_enable_irq(irq);
}
and similar in other ->end() 

on x86:
static void end_8259A_irq (unsigned int irq)
{
        if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
                                                        irq_desc[irq].action)
                enable_8259A_irq(irq);
}

b) if we get *two* interrupts while irq is enabled and not registered, we'll
be stuck with IRQ_PENDING in addition to IRQ_INPROGRESS.  Which can, AFAICS,
confuse other code.

c) mind-boggling amount of code duplication - are there any plans to take
that stuff to kernel/*?
