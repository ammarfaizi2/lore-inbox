Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVFKUZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVFKUZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFKUZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:25:26 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:48590 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261818AbVFKUXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:23:48 -0400
Date: Sat, 11 Jun 2005 22:23:30 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <1118519067.5593.22.camel@sdietrich-xp.vilm.net>
Message-Id: <Pine.OSF.4.05.10506112214240.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Jun 2005, Sven-Thorsten Dietrich wrote:

> On Sat, 2005-06-11 at 21:34 +0200, Esben Nielsen wrote:
> > On Sat, 11 Jun 2005, Ingo Molnar wrote:
> > 
> > > 
> > > * Daniel Walker <dwalker@mvista.com> wrote:
> > > 
> > > > > The current soft-irq states only gives us better hard-irq latency but
> > > > > nothing else. I think the overhead runtime and the complication of the
> > > > > code is way too big for gaining only that. 
> > > > 
> > > > Interrupt response is massive, check the adeos vs. RT numbers . They 
> > > > did one test which was just interrupt latency.
> > > 
> > > the jury is still out on the accuracy of those numbers. The test had 
> > > RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
> > > mostly work with interrupts disabled. The other question is how were 
> > > interrupt response times measured.
> > > 
> > You would accept a patch where I made this stuff optional?
> > 
> 
> Daniel's original patch MADE it optional. Its just that the code is
> apparently more complex looking that way, so its cleaner to do what Ingo
> did.
> 
> > I have another problem:
> > I can't hide that my aim is to make task-latencies deterministic.
> 
> Then this will help you.
> 
No because it correctly leaves irqs on but not preemption on. 

> > The worry is local_irq_disable() (and preempt_disable()). I can undefine
> > it and therefore find where it is used. I can then look at the code, make
> > it into raw_local_irq_disable() or try to make a lock.
> > In many cases the raw-irq disable is the best and simplest when I am only
> > worried about task-latencies. But now Daniel and Sven wants to use the
> > distingtion between raw_local_irq_disable() and local_irq_disable() to
> > make irqs fast. 
> 
> We aim to make IRQ latencies deterministic. This affects preemption
> latency in a positive way. 
> 
No. If you leave preemption off but irqs on, which is what is done here,
you get good, deterministic IRQ latencies but nothing for task-latencies -
actually slightly (unmeassureable I agree) worse due to the extra step
you have to go from the physical interrupt to the task-switch is
completed.

> Anywhere in the kernel that IRQs are disabled, preemption is impossible.
> (you can't interrupt the CPU when irqs are disabled)
> 
For me it is the _same_ thing. Equally bad. If preemption is off I don't
care if irqs are off. 

> But you said you are worried about overhead. You have to incur overhead
> to make task response deterministic.
> 
> Are you sure you are not just trying to make it FAST?
> 
Certainly not. I was pressing for priority inheritance forinstance. That
thing does certainly not make it fast, but it makes use of locks 
deterministic.

> But then - even if you do, this is still in your interest.
> 
> Let's wait for some numbers.
> 
> > We do have a clash of notations. Any idea what to do? I mentioned
> >  local_
> 
> The following two are the same. The former is an earlier implementation,
> and has been superseded by the latter. The former is NLA.
> >  raw_local_
> >  hard_local_
> 
My idea was to split them:
 local_ are disallowed in PREEMPT_RT to catch code been made !PREEMPT_RT
suddenly destroying RT.
 raw_local_ is used all over in PREEMPT_RT core code.
 hard_local_ is the same as raw_local unless you configure for low IRQ
latencies (the original patch). Then it marks the soft-irq state.

Do you follow my idea:
I can persue low task latencies. You can persue low irq latencies and we
don't clash due to conflicting naming convensions.

Esben


> Sven
> 
> 

