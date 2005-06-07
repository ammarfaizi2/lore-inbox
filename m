Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVFGF4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVFGF4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVFGF4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:56:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:5521 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261796AbVFGFzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:55:23 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1118122469.3245.62.camel@localhost.localdomain>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com> <1118115278.6850.48.camel@gaston>
	 <1118116682.3245.45.camel@localhost.localdomain>
	 <1118118413.6850.57.camel@gaston>
	 <1118122469.3245.62.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 15:50:57 +1000
Message-Id: <1118123457.6850.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I think unregistering the handler is the equivalent and easier to get
> right.  Otherwise, the driver developer needs to check a flag in the
> interrupt handler to see if the device is sleeping, and if it is then
> return IRQ_NONE.  Both options would work fine, but I don't see a race
> condition with free_irq().

You still need to disable IRQs on chip tho before you free_irq or you'll
put other devices sharing your interrupt in real pain in case your hw
accidentally emits one :)
 
> > To not be racy, the best is to synchronize though. Something like this
> > pseudo code:
> > 
> > suspend():
> > 
> >   1) chip_disable_irq(); /* disable emission of IRQs on the chip,
> >                           * maybe do that & below in a spinlock_irq
> >                           * to make sure no other driver code path
> >                           * re-enables them
> >                           */
> > 
> >   2) me->sleeping = 1;  /* tells the rest of the driver I'm not there
> >                          * anymore, can be some netif_* thingy.
> >                          */
> > 
> >   3) synchronize_irq(me->irq); /* make sure above is visible to IRQs and
> >                                 * any pending one competes on another
> >                                 * CPU
> >                                 */
> 
> free_irq doesn't return until all pending irqs have completed, so we
> don't need to do this if we're using the method I proposed.  In fact,
> I think it calls synchronize_irq.

Yes. free_irq above would be equivalent to synchronize_irq() and a good
replacement for it. With it, you don't even need the me->sleeping & test
in the IRQ handler since you simply cant call the IRQ handler after it's
free'd :)

> > 
> >   4) pci_set_power_state(), maybe free_irq(), etc...
> > 
> > 
> > my_irq_handler():
> > 
> >   if (me->sleeping)
> >     return IRQ_NONE;
> > 
> > That's it.
> > 
> > Ben.
> 
> Thanks,
> Adam
> 

