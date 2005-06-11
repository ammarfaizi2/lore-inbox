Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVFKQqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVFKQqp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVFKQqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:46:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47601 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261735AbVFKQqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:46:39 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42AAFC75.7090601@kolumbus.fi>
References: <1118449247.27756.47.camel@dhcp153.mvista.com>
	 <Pine.OSF.4.05.10506111455240.2917-100000@da410.phys.au.dk>
	 <20050611135111.GB31025@elte.hu>  <42AAFC75.7090601@kolumbus.fi>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jun 2005 09:45:23 -0700
Message-Id: <1118508323.9519.84.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 18:00 +0300, Mika Penttilä wrote:
> Ingo Molnar wrote:
> 
> >i've done two more things in the latest patches:
> >
> >- decoupled the 'soft IRQ flag' from the hard IRQ flag. There's
> >  basically no need for the hard IRQ state to follow the soft IRQ state. 
> >  This makes the hard IRQ disable primitives a bit faster.
> >
> >- for raw spinlocks i've reintroduced raw_local_irq primitives again.
> >  This helped get rid of some grossness in sched.c, and the raw
> >  spinlocks disable preemption anyway. It's also safer to just assume
> >  that if a raw spinlock is used together with the IRQ flag that the
> >  real IRQ flag has to be disabled.
> >
> >these changes dont really impact scheduling/preemption behavior, they 
> >are cleanup/robustization changes.
> >
> >	Ingo
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >  
> >
> With the soft IRQ flag local_irq_disable() doesn't seem to protect 
> against soft interrupts (via SA_NODELAY interrupt-> invoke_softirq()). 
> Could this be a problem?

Only if you run SOFT IRQs as SA_NODELAY, which is going to KILL all your
preemption gains with the first arriving network packet.

And that is, if you don't get buried in "scheduling while atomic" printk
messages first.

SA_NODELAY is not generally allowed in PREEMPT_RT, except for code
designed to take advantage of the IRQ void that has been created. 

This code must follow a new set of rules, which people who design RT
apps are really happy to accet, they have to accept worse compromises
with the alternatives (subkernel or ANOTHER OS (ugh))

Sven


