Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVFKQqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVFKQqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVFKQqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:46:30 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:19135 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261380AbVFKQq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:46:27 -0400
Date: Sat, 11 Jun 2005 18:46:07 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <Pine.LNX.4.10.10506110920250.27294-100000@godzilla.mvista.com>
Message-Id: <Pine.OSF.4.05.10506111832130.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Jun 2005, Daniel Walker wrote:

> 
> 
> On Sat, 11 Jun 2005, Ingo Molnar wrote:
> 
> > - for raw spinlocks i've reintroduced raw_local_irq primitives again.
> >   This helped get rid of some grossness in sched.c, and the raw
> >   spinlocks disable preemption anyway. It's also safer to just assume
> >   that if a raw spinlock is used together with the IRQ flag that the
> >   real IRQ flag has to be disabled.
> 
> I don't know about this one .. That grossness was there so people aren't
> able to easily add new disable sections. 
> 
> Could we add a new raw_raw_spinlock_t that really disable interrupt , then
> investigate each one . There are really only two that need it, runqueue
> lock , and the irq descriptor lock . If you add it back for all raw types
> you just add back more un-needed disable sections. The only way a raw lock
> needs to disable interrupts is if it's possible to enter that region from
> interrupt context .
> 
> 
> Daniel
> 
>

We must assume the !PREEMPT_RT writer never uses raw. If he starts to do
that RT will be broken no matter what.

What is it you want to obtain anyway?
As far as I understand it comes from the discussion about 
local_irq_disable() in random driver X made for !PREEMPT_RT can destroy
RT because the author used local_irq_disable() around a large,
non-deterministic section of the code.

That only has one solution:
Disallow local_irq_disable() when PREEMPT_RT is on and make some easy
alternatives. Many of them could be turned into raw_local_irq_disable(),
others into regular locks.

If you want extremely low interrupt latencies I say it is better to use a
sub-kernel - which might be a very, very simple interrupt-dispatcher. 

I think the PREEMPT_RT should go for deterministic task-latencies. Very
low interrupt, special perpose latencies is a whole other issue which I
think should be posponed - and at least should be made obtional.

Esben

