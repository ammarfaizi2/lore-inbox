Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275690AbRJAXED>; Mon, 1 Oct 2001 19:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275698AbRJAXDx>; Mon, 1 Oct 2001 19:03:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35858 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275690AbRJAXDr>; Mon, 1 Oct 2001 19:03:47 -0400
Date: Mon, 1 Oct 2001 16:03:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Andrea Arcangeli <andrea@suse.de>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110012305350.3280-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0110011547460.1292-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Oct 2001, Ingo Molnar wrote:
>
> - the irq handling code has been extended to support 'soft mitigation',
>   ie. to mitigate the rate of hardware interrupts, without support from
>   the actual hardware. There is a reasonable default, but the value can
>   also be decreased/increased on a per-irq basis via /proc/irq/NR/max_rate.

Adn how do you select max_rate sanely? It depends on how heavy each
interrupt is, the speed of the CPU etc etc. A rate that works for a
network card with a certain packet size may be completely ineffective on
the same machine with the same network card but a different packet size.

When you select the wrong number, you slow the system down for no good
reason (too low a number) or your mitigation has zero effect because the
system can't do that many interrupts per tick anyway (too high a number).

Saying "hey, that's the users problem", is _not_ a solution. It needs to
have some automatic cut-off that finds the right sustainable rate
automatically, instead of hardcoding random default values and asking the
user to know the unknowable.

Automatically doing the right thing may be hard, but it should be
solvable. In particular, something like the following _may_ be a workable
approach, rather than having a hardcoded limit:

 - have a notion of "made progress". Certain events count as progress, and
   will reset the interrupt count.
	Examples of "progress":
		- idle task loop
		- a context switch

 - depend on the fact that on a PC, the timer interrupt has the highest
   priority, and make the timer interrupt do something like

	if (!made_progress) {
		disable_next_irq = 1;
	} else
		made_progress = 0;

 - have all other interrupts do something like

	if (disable_next_irq)
		goto mitigate;

which just says that we mitigate an irq _only_ if we didn't make any
progress at all. Rather than mitigating on some random count that can
never be perfect.

(Tweak to suit your own definition of "made progress" - maybe you'd like
to require more than just a context switch).

		Linus

