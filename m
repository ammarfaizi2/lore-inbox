Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTJISDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTJISDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:03:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:51385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262315AbTJISDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:03:21 -0400
Date: Thu, 9 Oct 2003 11:03:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
In-Reply-To: <20031009174604.GC7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310091049150.22318-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> a) on x86:
> static void end_8259A_irq (unsigned int irq)
> {
>         if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
>				 irq_desc[irq].action)
>                enable_8259A_irq(irq);
> }

This matches the "if IRQ is disabled for whatever reason" test in irq.c, 
and as such it makes some amount of sense. However, from a logical 
standpoint it is indeed not very sensible. It's hard to see why the code 
does what it does.

> b) if we get *two* interrupts while irq is enabled and not registered, we'll
> be stuck with IRQ_PENDING in addition to IRQ_INPROGRESS.  Which can, AFAICS,
> confuse other code.

This should not happen: the first one will shut up the interrupt. That's 
in fact what (a) does - it refuses to enable the interrupt again (and it 
will have been shut up by the "ack".

(Other interrupt controllers _can_ get multiple interrupts while disabled, 
like the APIC edge-triggered case. But they have different logic to take 
care of this - see io_apic.c and the logic there in the 
[ack|end]_edge_ioapic_irq).

In short, this is all behaviour that depends on the low-level irq 
controller. It may not be very obvious what is going on, but I think it is 
correct (and again, it might be worth cleaning up some day. Not now)

> c) mind-boggling amount of code duplication - are there any plans to take
> that stuff to kernel/*?

Yes. It was actually tried a few months ago, but some of the other 
architectures have very different interrupt setups, so it got dropped. But 
it will almost certainly happen eventually: we've had bugs fixed on x86 
that ended up living a lot longer on other architectures.

			Linus


