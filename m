Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRCCSB1>; Sat, 3 Mar 2001 13:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129635AbRCCSBR>; Sat, 3 Mar 2001 13:01:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4880 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129632AbRCCSBF>; Sat, 3 Mar 2001 13:01:05 -0500
Date: Sat, 3 Mar 2001 10:00:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
In-Reply-To: <19350126005232.15154@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10103030954060.17574-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Mar 2001, Benjamin Herrenschmidt wrote:
> 
> Especially, my question is about the code in enable_irq() which checks
> for IRQ_PENDING, and then 
> "replays" the interrupt by asking the APIC to issue it again.
> 
> I don't have a simple way on PPC to cause the interrupt to happen again,
> as you can imagine this is rather controller-specific. However, looking
> at the code closely, I couldn't figure out a case where having
> IRQ_PENDING in enable_irq() makes sense.

It only makes sense for broken irq controllers. And most aren't. You can
likely ignore it - and note how even on an x86, most of the irq controller
code _does_ ignore it. 

> How can IRQ_PENDING happen to be set on an IRQ_DISABLED interrupt, and
> why would that matter (why should we take this interrupt) ?

We have to take the interrupt - we can't just drop it on the floor. And
some stupid interrupts controllers _will_ ignore it.

In particular, if an edge-triggered interrupt comes in on an x86 IO-APIC
while that interrupt is disabled, enabling the interrupt will have caused
that irq to get dropped. And if it gets dropped, it will never ever happen
again: the interrupt line is now active, and there will never be another
edge again.

> I'd be glad if you could take the time to enlighten me about this as I'm
> trying to make the PPC code as close as the i386, according to your
> comment stating that it would be generic in 2.5, and I don't like having
> code I don't fully understand ;)

You likely don't have this problem at all. Most sane interrupt controllers
are level-triggered, and won't show the problem. And others (like the
i8259) will see a disabled->enabled transition as an edge if the interrupt
is active (ie they have the edge-detection logic _after_ the disable
logic), and again won't have this problem.

		Linus

