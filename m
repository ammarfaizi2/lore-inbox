Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271214AbTG3LOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272005AbTG3LOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:14:14 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59629
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271214AbTG3LOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:14:10 -0400
Date: Wed, 30 Jul 2003 13:16:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linas@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730111639.GI23835@dualathlon.random>
References: <20030730082848.GC23835@dualathlon.random> <Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 12:31:23PM +0200, Ingo Molnar wrote:
> 
> On Wed, 30 Jul 2003, Andrea Arcangeli wrote:
> 
> > 
> > 	cpu0			cpu1
> > 	------------		--------------------
> > 
> > 	do_setitimer
> > 				it_real_fn
> > 	del_timer_sync		add_timer	-> crash
> 
> would you mind to elaborate the precise race? I cannot see how the above
> sequence could crash on current 2.6:
> 
> del_timer_sync() takes the base pointer in timer->base and locks it, then
> checks whether the timer has this base or not and repeats the sequence if
> not. add_timer() locks the current CPU's base, then installs the timer and
> sets timer->base. Where's the race?

not sure why you mention timer->base, you know the base lock means
nothing if it's in two different cpus (if it meant anything, it would
mean we'd still suffer the cacheline bouncing with timer ops running in
different cpus). To make it more clear I edit timer.c deleting all
spin_lock(&base->lock) so the base->lock won't make it look like it can
serialize anything. I delete the local_irqsave too since it doesn't
matter too for this example (also assume premption turned off so I don't
need to add the preempt disable in place of the local irq save).

so for this example we have this:

int del_timer(struct timer_list *timer)
{
	tvec_base_t *base;

repeat:
 	base = timer->base;
	if (!base)
		return 0;
	if (base != timer->base) {
		goto repeat;
	}
	list_del(&timer->entry);
	timer->base = NULL;

	return 1;
}

against this:

void add_timer(struct timer_list *timer)
{
	tvec_base_t *base = &get_cpu_var(tvec_bases);
  
  	BUG_ON(timer_pending(timer) || !timer->function);

	internal_add_timer(base, timer);
	timer->base = base;
	put_cpu_var(tvec_bases);
}


in del_timer, list_del can be reordered after the timer->base = NULL,
the C compiler can do that. so list_del will run at the same time of
internal_add_timer(base, timer) that does the list_add_tail.

list_del and list_add_tail running at the same time will crash.

Andrea
