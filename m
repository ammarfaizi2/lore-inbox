Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319576AbSIHIFy>; Sun, 8 Sep 2002 04:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319578AbSIHIFy>; Sun, 8 Sep 2002 04:05:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54217 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319576AbSIHIFx>;
	Sun, 8 Sep 2002 04:05:53 -0400
Date: Sun, 8 Sep 2002 10:15:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209080952410.16565-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209080957410.17502-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [...] But your patch is very tempting nevertheless, it removes much of
> the disadvantage of sharing interrupt lines. Most of the handlers on the
> chain are supposed to be completely independent.

one big issue are level triggered interrupts - your approach makes no
sense in the way we disable/ack the IRQ line currently:

	disable IRQ line
	ack APIC
	-> call handler
	    while (work_left) {
		ack interrupt on the card            [*]
		[... full processing ...]
	    }

if we didnt disable the IRQ line then an additional interrupt would be
triggered when [*] is done.

it could perhaps be handled the following way:

	disable IRQ line
	ack APIC
	-> call handler
	    while (work_left) {
		ack interrupt on the card            [*]
		enable IRQ line			     [**]
		[... full processing ...]
	    }

so after [**] is done we could accept new interrupts, and the amount of
time we keep the irq line disabled should be small. Obviously this means
driver level changes.


an additional nit even for edge-triggered interrupts: synchronize_irq()  
needs to be aware of the new bit on SMP, now that IRQ_PENDING is not
showing the true 'pending' state anymore. But it's doable. Basically
IRQ_PENDING would be gone completely, and replaced by a more complex set
of bits in the action struct. In the normal unshared case it should be
almost as efficient as the IRQ_PENDING bit.

in fact i'd suggest to also add a desc->pending counter in addition to the
per-action flag, to make it cheaper to determine whether there are any
pending handlers on the chain.

also some other code needs to be updated as well to be aware of the
changed pending-semantics: enable_irq() and probe_irq_on().

	Ingo

