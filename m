Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319589AbSIHKK5>; Sun, 8 Sep 2002 06:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319590AbSIHKK5>; Sun, 8 Sep 2002 06:10:57 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:53647 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S319589AbSIHKK4>; Sun, 8 Sep 2002 06:10:56 -0400
Date: Sun, 8 Sep 2002 12:38:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209080957410.17502-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209081218150.1096-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Ingo Molnar wrote:

> if we didnt disable the IRQ line then an additional interrupt would be
> triggered when [*] is done.
> 
> it could perhaps be handled the following way:
> 
> 	disable IRQ line
> 	ack APIC
> 	-> call handler
> 	    while (work_left) {
> 		ack interrupt on the card            [*]
> 		enable IRQ line			     [**]
> 		[... full processing ...]
> 	    }
> 
> so after [**] is done we could accept new interrupts, and the amount of
> time we keep the irq line disabled should be small. Obviously this means
> driver level changes.

Ok that definitely would allow for more interrupts to get through, i was 
working on the basis that handlers with SA_INTERRUPT set would allow for 
for that reenable. About the driver level changes, would this be in regard 
to a device with ISR_INPROGRESS triggering an interrupt and thus have one 
pending? In that case couldn't we avoid touching the driver and increment 
a pending counter on that particular handler?

> an additional nit even for edge-triggered interrupts: synchronize_irq()  
> needs to be aware of the new bit on SMP, now that IRQ_PENDING is not
> showing the true 'pending' state anymore. But it's doable. Basically
> IRQ_PENDING would be gone completely, and replaced by a more complex set
> of bits in the action struct. In the normal unshared case it should be
> almost as efficient as the IRQ_PENDING bit.
> 
> in fact i'd suggest to also add a desc->pending counter in addition to the
> per-action flag, to make it cheaper to determine whether there are any
> pending handlers on the chain.

Gotcha

> also some other code needs to be updated as well to be aware of the
> changed pending-semantics: enable_irq() and probe_irq_on().

I'll have a look at those too.

Thanks,
	Zwane
-- 
function.linuxpower.ca


