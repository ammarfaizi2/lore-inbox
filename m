Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWFFPAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWFFPAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWFFPAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:00:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:10918 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932202AbWFFO77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:59:59 -0400
Date: Tue, 6 Jun 2006 16:59:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm3] fix irqpoll some more
Message-ID: <20060606145915.GA627@elte.hu>
References: <200606050600.k5560GdU002338@shell0.pdx.osdl.net> <1149497459.23209.39.camel@localhost.localdomain> <20060605084938.GA31915@elte.hu> <1149600355.16247.49.camel@localhost.localdomain> <20060606135353.GA25609@elte.hu> <1149604828.16247.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149604828.16247.64.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > you got a lockup/deadlock every time, due to the bug that the lock 
> > validator pointed out?
> > 
> 
> The one with the spin_lock being used outside of interrupts disabled? 
> Yep.  But remember, this only happens with irqpoll where it doesn't 
> honor disabled interrupts, so this was expected behavior.
> 
> Here's the back trace. I had to disable your lockdep to turn NMI back 
> on.
> 
>  [<c0103d37>] show_stack_log_lvl+0xa7/0xf0
>  [<c0103f40>] show_registers+0x1c0/0x260
>  [<c0104357>] die_nmi+0xd7/0x160
>  [<c0110835>] nmi_watchdog_tick+0x1c5/0x210
>  [<c0104079>] do_nmi+0x99/0x2a0
>  [<c01035ee>] nmi_stack_correct+0x1d/0x22
>  [<f8898933>] boomerang_interrupt+0x33/0x460 [3c59x]
>  [<c01435d5>] note_interrupt+0x155/0x260
>  [<c0143dfd>] handle_edge_irq+0x11d/0x150
>  [<c010529f>] do_IRQ+0x4f/0xa0
>  [<c0103462>] common_interrupt+0x1a/0x20
>  [<f8895c46>] mdio_read+0xb6/0xf0 [3c59x]
>  [<f885a2e1>] mii_link_ok+0x21/0x50 [mii]
>  [<f885a3a6>] mii_check_media+0x36/0x200 [mii]
>  [<f88956ab>] vortex_check_media+0x3b/0x90 [3c59x]
>  [<f8895b1e>] vortex_timer+0x41e/0x490 [3c59x]
>  [<c0128799>] run_timer_softirq+0xc9/0x1a0
>  [<c0123ff4>] __do_softirq+0x74/0xf0
>  [<c01240c5>] do_softirq+0x55/0x60
>  [<c012422d>] irq_exit+0x4d/0x50
>  [<c01100e4>] smp_apic_timer_interrupt+0x64/0x70
>  [<c01034f3>] apic_timer_interrupt+0x1f/0x24
>  [<c010160d>] cpu_idle+0x4d/0xb0
>  [<c010f170>] start_secondary+0x450/0x500
>  [<00000000>] 0x0

ouch. Then this problem is more urgent than i thought. We definitely 
need the disable_irq_handler(irq, handler) infrastructure and it should 
be used in the most common drivers affected (vortex/3c59x, forcedeth and 
IDE basically).

	Ingo
