Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131738AbRALS3N>; Fri, 12 Jan 2001 13:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRALS3E>; Fri, 12 Jan 2001 13:29:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51473 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131738AbRALS2u>; Fri, 12 Jan 2001 13:28:50 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Date: 12 Jan 2001 10:28:33 -0800
Organization: Transmeta Corporation
Message-ID: <93nich$1uq$1@penguin.transmeta.com>
In-Reply-To: <E14H8Ks-0004hA-00@the-village.bc.nu> <3A5F4827.2E443786@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A5F4827.2E443786@colorfullife.com>,
Manfred Spraul  <manfred@colorfullife.com> wrote:
>The processor's local APIC includes an in-service entry and a holding
>entry for each priority level. To avoid losing interrupts, software
>should allocate no more than 2 interrupt vectors per priority.
>>>>>>>>>
>
>Ok, we must reorder the vector numbers for our own interrupts
>(0xfb-0xff), but that doesn't explain our problems: we don't loose
>reschedule interrupts, we have problems with normal interrupts - and
>there we only use 2 irq at the same priority level.
>
>Btw, the kick patch I sent a few minutes ago revives my io apic.

Does this seem to happen mainly with drivers that use "disable_irq()"
and "enable_irq()"? I know the ne drivers do (through the 8390 module),
and some others do too (3c59x). 

"disable_irq()"/"enable_irq()" has always tended to be slightly
problematic.  It's not a set of semantics that maps well onto all
interrupt controllers (io-apic definitely included).  Drivers would
generally be better off if they disabled their own chip from sending
interrupts, rather than disabling the interrupt line the chip is on. 

(Of course, most drivers would be even _better_ off if they didn't play
games with irq disabling at all, but I think the 8390 driver does it
because otherwise it would suck too badly for words). 

If you are seeing this with a 8390 core, try to see if the problem goes
away if you remove the "disable_irq_nosync(dev->irq);" and
"enable_irq()" thing (which means that you need to change the
spinlocking at the same place to use irq-safe versions - this _will_
make for bad interrupt latency especially with ISA ne2000 cards, but it
would be interesting to hear if it makes the problem less likely to
happen). 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
