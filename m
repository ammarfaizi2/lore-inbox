Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWFFOkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWFFOkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWFFOkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:40:45 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:41957 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932193AbWFFOkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:40:45 -0400
Subject: Re: [patch, -rc5-mm3] fix irqpoll some more
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060606135353.GA25609@elte.hu>
References: <200606050600.k5560GdU002338@shell0.pdx.osdl.net>
	 <1149497459.23209.39.camel@localhost.localdomain>
	 <20060605084938.GA31915@elte.hu>
	 <1149600355.16247.49.camel@localhost.localdomain>
	 <20060606135353.GA25609@elte.hu>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 10:40:28 -0400
Message-Id: <1149604828.16247.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 15:53 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 2006-06-05 at 10:49 +0200, Ingo Molnar wrote:
> > 
> > > +	/*
> > > +	 * HACK:
> > > +	 *
> > > +	 * In the first pass we dont touch handlers that are behind
> > > +	 * a disabled IRQ line. In the second pass (having no other
> > > +	 * choice) we ignore the disabled state of IRQ lines. We've
> > > +	 * got a screaming interrupt, so we have the choice between
> > > +	 * a real lockup happening due to that screaming interrupt,
> > > +	 * against a theoretical locking that becomes possible if we
> > > +	 * ignore a disabled IRQ line.
> > 
> > FYI, with irqpoll on in my i386 SMP machine, I hit this theoretical 
> > locking every time in the vortex driver.
> 
> you got a lockup/deadlock every time, due to the bug that the lock 
> validator pointed out?
> 

The one with the spin_lock being used outside of interrupts disabled?
Yep.  But remember, this only happens with irqpoll where it doesn't
honor disabled interrupts, so this was expected behavior.

Here's the back trace. I had to disable your lockdep to turn NMI back
on.

 [<c0103d37>] show_stack_log_lvl+0xa7/0xf0
 [<c0103f40>] show_registers+0x1c0/0x260
 [<c0104357>] die_nmi+0xd7/0x160
 [<c0110835>] nmi_watchdog_tick+0x1c5/0x210
 [<c0104079>] do_nmi+0x99/0x2a0
 [<c01035ee>] nmi_stack_correct+0x1d/0x22
 [<f8898933>] boomerang_interrupt+0x33/0x460 [3c59x]
 [<c01435d5>] note_interrupt+0x155/0x260
 [<c0143dfd>] handle_edge_irq+0x11d/0x150
 [<c010529f>] do_IRQ+0x4f/0xa0
 [<c0103462>] common_interrupt+0x1a/0x20
 [<f8895c46>] mdio_read+0xb6/0xf0 [3c59x]
 [<f885a2e1>] mii_link_ok+0x21/0x50 [mii]
 [<f885a3a6>] mii_check_media+0x36/0x200 [mii]
 [<f88956ab>] vortex_check_media+0x3b/0x90 [3c59x]
 [<f8895b1e>] vortex_timer+0x41e/0x490 [3c59x]
 [<c0128799>] run_timer_softirq+0xc9/0x1a0
 [<c0123ff4>] __do_softirq+0x74/0xf0
 [<c01240c5>] do_softirq+0x55/0x60
 [<c012422d>] irq_exit+0x4d/0x50
 [<c01100e4>] smp_apic_timer_interrupt+0x64/0x70
 [<c01034f3>] apic_timer_interrupt+0x1f/0x24
 [<c010160d>] cpu_idle+0x4d/0xb0
 [<c010f170>] start_secondary+0x450/0x500
 [<00000000>] 0x0


-- Steve


