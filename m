Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTJICAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 22:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJICAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 22:00:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261877AbTJICAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 22:00:01 -0400
Date: Thu, 9 Oct 2003 03:00:00 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Message-ID: <20031009020000.GZ7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Current code (at least on x86 and alpha) appears to assume that
you can't call disable_irq()/enable_irq() unless you have registered
that irq.

	However, ide-probe.c::probe_hwif() contains the following:
        /*
         * We must always disable IRQ, as probe_for_drive will assert IRQ, but
         * we'll install our IRQ driver much later...
         */
        irqd = hwif->irq;
        if (irqd)
                disable_irq(hwif->irq);
and later
        /*
         * Use cached IRQ number. It might be (and is...) changed by probe
         * code above
         */
        if (irqd)
                enable_irq(irqd);

That happens *way* before we call register_irq().  Current tree barfs on
that in all sorts of interesting ways.  Most notably, we get irq enabled
and with NULL ->action for a while.  If an interrupt comes during that
time, we'll get IRQ_INPROGRESS set and not reset until later register_irq()
(see handle_irq() for details).  Note that calling disable_irq() after that
will kill us on SMP - it will spin waiting for IRQ_INPROGRESS to go away.

Moreover, if somebody calls register_irq() while we are at it, we'll get
->depth reset to 0.  enable_irq() will try to decrement depth and will get
very unhappy about the situation.

What do we really want to do here?  I see only two variants:
	a) allow enable_irq()/disable_irq() regardless of having the thing
registered.  IRQ_DISABLED would be set iff ->depth is positive or ->action
is NULL.  register_irq() wouldn't touch the ->depth and would enable IRQ
only if ->depth is 0.  enable_irq() would not enable the thing unless ->action
was non-NULL.  That would work, but I wouldn't bet a dime on correctness -
e.g. currently disable_irq() followed by free_irq() works fine and drivers
might very well leave ->depth positive when they are removed.  With new
scheme that would be deadly.
	b) have ide-probe.c register a dummy handler for that period.
Then it would be allowed to do what it does.  Said handler would simply
return IRQ_NONE and be done with that.  Add BUG() to disable_irq()/enable_irq()
for cases when they are called with NULL ->action.

	Note that scenario above is absolutely real - 2.4.21 and later
hang on DS10 since their IDE chipset (alim15x3.c) does generate an interrupt
after the probe code had called enable_irq().  With obvious results -
ide_intr() is never called afterwards.  On 2.6 it doesn't happen only
because register_irq() forcibly drops IRQ_INPROGRESS, which hides that
problem, but doesn't help with other scenarios (e.g. somebody sharing the
same IRQ and doing register_irq() before we call enable_irq()).

Comments?
