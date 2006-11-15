Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030635AbWKOQJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030635AbWKOQJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030637AbWKOQJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:09:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41950 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030633AbWKOQJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:09:58 -0500
Date: Wed, 15 Nov 2006 08:06:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Ingo Molnar <mingo@redhat.com>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use delayed disable mode of ioapic edge triggered
 interrupts
In-Reply-To: <m17ixxjnpc.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0611150754120.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
 <1162985578.8335.12.camel@localhost.localdomain> <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
 <20061108085235.GT4729@stusta.de> <7813413.118221162987983254.komurojun-mbn@nifty.com>
 <11940937.327381163162570124.komurojun-mbn@nifty.com>
 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org> <m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
 <1163450677.7473.86.camel@earth> <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
 <1163492040.28401.76.camel@earth> <Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
 <m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0611141706300.3349@woody.osdl.org>
 <m17ixxjnpc.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, Eric W. Biederman wrote:
> 
> The big one I did not set it on is the interrupt if it comes in
> through ExtInt.  I assume the 8259 is sane but I may be wrong.

Yes, ExtInt is ok, i fyou actually mask it at the 8259. As mentioned 
earlier in the thread, the i8259 has its edge detect logic _after_ the 
masking logic, so if the irq is still active, and you unmask it, it will 
see an edge, and re-assert the interrupt in hardware.

So the i8259 is a good interrupt controller, and does not need delayed 
disable and software logic to re-assert the irq.

> The truth is in practice I don't think it matters because I don't
> think anyone actually disables MSI or hypertransport interrupts.

Fair enough, at least for a 2.6.19 kind of release timeframe (and that is 
what I worry about most, at least right now).

> At this point I have two questions.
> - What is the easiest path to get us to a stable 2.6.19 where
>   everything works?

If people don't expect HT and MSI interrupts to be masked (and I can well 
imagine that), then I think your two-liner patch is good to go. Komuro 
seems to have acked it already, and in many ways that's the "minimal 
change" for 2.6.19 right now.

I do like Ingo's patch because it seems "safe" (even if I think it might 
be a bit _overly_ safe), but it changes semantics enough that I don't like 
it for 2.6.19. Even his second version definitely changes semantics for 
level-triggered PCI interrupts, even though he fixed ExtInt/i8259 ones.

So I think I'll go with your patch for now, and we can re-visit Ingo's 
thing after 2.6.19.

> - What is the sanest thing for long term maintenance, of irqs?
> 
>   genirq is less code to maintain overall (a plus).

Oh, I absolutely think genirq is the right thing to do. No question at 
all. I just think that we might want to refactor the code somewhat, and in 
particular I suspect that many irq controller drivers should use separate 
"struct irq_chip" entries for edge and level, because they are 
fundamentally different.

>   My gut feel is that there is room for a lot more cleanup in this
>   area but we probably need to stabilize what we have.

Exactly. Baby steps. Make it work. Then clean up. Slowly.

>   Since you aren't complaining about what the code actually does but
>   rather how the interface looks, I have a proposal.  I assert that
>   the interface for registering an irq is much to general, and broad.
> 
>   Instead of having:
> 
>   irq_desc[irq].status |= IRQ_DELAYED_DISABLE;
>   set_irq_chip_and_handler_name(irq, &ioapic_chip,
>                                      handle_edge_irq, "edge");
> 
>   We should have a set of helper functions one for each common type
>   of interrupt.
> 
>   set_irq_edge_lossy(irq, &ioapic_chip);
>   set_irq_edge(irq, &ioapic_chip);
>   set_irq_level(irq, &ioapic_chip);

Yeah, that might be a fine way too. That's largely what we do for the IO 
schedulers, and it's been fairly successful. Start out by setting common 
defaults, and then allow chip drivers to specify particular details 
explicitly.

Ingo?

			Linus
