Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbTJIS1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTJIS1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:27:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65169 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262384AbTJIS1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:27:44 -0400
Date: Thu, 9 Oct 2003 19:27:43 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Message-ID: <20031009182743.GD7665@parcelfarce.linux.theplanet.co.uk>
References: <20031009174604.GC7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310091049150.22318-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310091049150.22318-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 11:03:14AM -0700, Linus Torvalds wrote:
> 
> On Thu, 9 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> >
> > a) on x86:
> > static void end_8259A_irq (unsigned int irq)
> > {
> >         if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
> >				 irq_desc[irq].action)
				^^^^^^^^^^^^^^^^^^^^^^^
> >                enable_8259A_irq(irq);
> > }
> 
> This matches the "if IRQ is disabled for whatever reason" test in irq.c, 
> and as such it makes some amount of sense. However, from a logical 
> standpoint it is indeed not very sensible. It's hard to see why the code 
> does what it does.

The underlined bit is absent on alpha version of the same function.

Note that this piece is bogus - if .action is NULL, we are already caught
by IRQ_INPROGRESS check.  So it's not exactly a bug, but considering
your arguments about exact same check slightly earlier in handle_irq()...

It's from cset1.437.22.19 by mingo; the same changeset had done unconditional
removal of IRQ_INPROGRESS, so there it made sense.  After the irq.c part
had been reverted (1.497.61.30 from you), i8259.c one should be killed
too, AFAICS...
