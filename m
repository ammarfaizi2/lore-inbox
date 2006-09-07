Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWIGJ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWIGJ6V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWIGJ6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:58:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5573 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751471AbWIGJ6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:58:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157583693.22705.254.camel@localhost.localdomain> 
References: <1157583693.22705.254.camel@localhost.localdomain>  <20060906125626.GA3718@elte.hu> <20060906094301.GA8694@elte.hu> <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> <13982.1157545856@warthog.cambridge.redhat.com> <17274.1157553962@warthog.cambridge.redhat.com> 
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Sep 2006 10:55:28 +0100
Message-ID: <8934.1157622928@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Well, genirq gives you more flexibility than the current mecanism so ...

No, it doesn't because the FRV arch contains its own mechanism and I can do
what ever I like in it.

genirq's flexibility comes at a price.  Count the number of hooks in struct
irq_chip and struct irq_desc together.

> If I understand correctly, you need to do scray stuff to figure out your
> toplevel irq, which shound't be a problem with either mecanisms... 

Yeah.  I can't actually find out what source caused top-level IRQs.  I have to
guess from looking at the IRQ priority and poking around in the hardware.  I
got bitten that way too: at one point, I was peeking at the interrupt flag in
the serial regs, only to realise this was causing the driver to go wrong
because it cleared the interrupt requested flag in UART.

Obviously I'd rather not use IRQ priorisation to help multiplex irqs, but
unless I want a large polling set...

> Now, if you have funky cascades, then you can always group them into a
> virtual irq cascade line and have a special chained flow handler that
> does all the "figuring out" off those... it's up to you. 

You make it sound so easy, but it's not obvious how to do this, apart from
installing interrupt handlers for the auxiliary PIC interrupts on the CPU and
having those call back into __do_IRQ().  Chaining isn't mentioned in
genericirq.tmpl.

> In general, I found genirq allowed me to do more fancy stuff, and end up
> with actually less hooks and indirect function calls on the path to a
> given irq than before as you can use tailored flow handlers that do just
> the right thing.

My code in the FRV arch has fewer indirection calls than the genirq code
simply because it doesn't require tables of operations.  I can trace through
it with gdb and see them.

I built all the stuff that genirq does in indirections directly into the
handlers.  It certainly has fewer hooks.

I attempted to convert it over to use genirq, and I came up with some numbers:

The difference in kernel sizes:

	   text    data     bss     dec     hex filename
	1993023   77912  166964 2237899  2225cb vmlinux  [with genirq]
	1986511   76016  167908 2230435  2208a3 vmlinux  [without genirq]

The genirq subdir all wraps up into this:

	  10908    3272      12   14192    3770 kernel/irq/built-in.o
	   1548      64       4    1616     650 arch/frv/kernel/irq.o
	---------------------------------------------------------------------
	  12456    3336      16   15808    3dc0 total

My FRV-specific IRQ handling wraps up into these:

	    480     488       0     968     3c8 arch/frv/kernel/irq-mb93091.o
	   4688      16     520    5224    1468 arch/frv/kernel/irq.o
	   1576    1152      16    2744     ab8 arch/frv/kernel/irq-routing.o
	---------------------------------------------------------------------
	   6744    1656     536    8936    22e8 total

There's a difference in BSS size in the main kernel that I can't account for,
but basically genirq uses 6.3KB more code and 1.8KB more initialised data, but
0.9KB less BSS.  Overall, about 7.2KB more memory.  I can shrink the BSS usage
in the FRV specific version by reducing the amount of space in the IRQ sources
table.

So, again, why _should_ I use the generic IRQ stuff?  It's bigger and very
probably slower than what I already have.

David
