Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVFGE3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVFGE3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 00:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVFGE3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 00:29:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:25232 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261722AbVFGE3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 00:29:06 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1118116682.3245.45.camel@localhost.localdomain>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com>  <1118115278.6850.48.camel@gaston>
	 <1118116682.3245.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 14:26:53 +1000
Message-Id: <1118118413.6850.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We don't support PCI bus power management, so we don't have any idea
> what the parent is doing. 

Ugh ? You don't know, thus you can't assume it's working. A rule of the
device model is, once you have been suspended, you can't assume your
parent is still there and thus that you can talk to your device. On ppc
or embedded, the arch has ways to shut down clocks and/or power to
entire bus segment and that may have happened anytime.

> Also, we don't have a pci bridge driver (one
> that uses "struct pci_driver" to handle bridge resumes properly.  I'm
> working on these issues.

I know, but there may be arch thingies going on anyway. So the basic
"model" of turning back the chip on is wrong.

> I also have some changes in mind for the PM
> model to make it more friendly to the power dependency problem.  So in
> short, I think this is fine for now, as every other driver is doing it
> incorrectly, and in general it is working ok for suspend and resume.

No. just return IRQ_NONE. That is the only sane thing to do.

> They're all broken in this respect, and we need to gradually fix them.
> But first we need the infrastructure to make this possible.

No. That specific bit can be easily fixed for PCI drivers like that.
Just return IRQ_NONE, you shouldn't be emitting any IRQ yourself anyway.

> I haven't decided yet, but we could probably hide much of this inside
> pci_set_power_state().

No need.

> > Also, isn't that racy vs. the code in suspend() anyway ? You need to
> > make sure you program your chip not to issue any interrupt and
> > synchronize proerly, then just "ignore" (don't handle) interrupts coming
> > in as they should not be for you.
> 
> Yeah, that's exactly what I had in mind.  As I understand, tulip_down
> does tells the chip not to issue interrupts.  Then we unregister the
> interrupt handler before powering down the device to avoid any issues
> with shared interrupts.  The best way of ignoring interrupts is to
> unregister the handler.  Do you still see a race condition?

Well, if we have told the chip not to issue interrupts, then it's safe
to just have the handler return IRQ_NONE... we don't even need to
unregister the handler. (That's actually equivalent to some regard).

To not be racy, the best is to synchronize though. Something like this
pseudo code:

suspend():

  1) chip_disable_irq(); /* disable emission of IRQs on the chip,
                          * maybe do that & below in a spinlock_irq
                          * to make sure no other driver code path
                          * re-enables them
                          */

  2) me->sleeping = 1;  /* tells the rest of the driver I'm not there
                         * anymore, can be some netif_* thingy.
                         */

  3) synchronize_irq(me->irq); /* make sure above is visible to IRQs and
                                * any pending one competes on another
                                * CPU
                                */

  4) pci_set_power_state(), maybe free_irq(), etc...


my_irq_handler():

  if (me->sleeping)
    return IRQ_NONE;

That's it.

Ben.


