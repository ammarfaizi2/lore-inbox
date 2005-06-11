Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVFKQcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVFKQcM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVFKQcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:32:12 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:29630 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261721AbVFKQcB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:32:01 -0400
Date: Sat, 11 Jun 2005 18:31:42 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <Pine.LNX.4.10.10506110904100.27294-100000@godzilla.mvista.com>
Message-Id: <Pine.OSF.4.05.10506111819170.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2005, Daniel Walker wrote:

> 
> 
> On Sat, 11 Jun 2005, Esben Nielsen wrote:
> 
> > On Fri, 10 Jun 2005, Daniel Walker wrote:
> > 
> > > On Sat, 2005-06-11 at 01:37 +0200, Esben Nielsen wrote:
> > > [...]
> > > > As far as I can see the only solution is to replace them with a per-cpu
> > > > mutex. Such a mutex can be the rt_mutex for now, but someone may want to
> > > > make a more optimized per-cpu version where a raw_spin_lock isn't used.
> > > > That would make it nearly as cheap as cli()/sti() when there is no
> > > > congestion. One doesn't need PI for this region either as the RT
> > > > subsystems will not hit it anyway.
> > > 
> > > I don't like this solution mainly because it's so expensive. cli/sti may
> > > take a few cycles at most, what your suggesting may take 50 times that,
> > > which would similar in speed to put linux under adeos.. 
> > 
> > We are only talking about the local_irq_disable()/enable() in drivers, not
> > the core system, right? Therefore making it into a mutex will not be that
> > expensive overall.
> 
> No, core system . We're talking about everything, including
> raw_spinlock_t.
>
I think that is a really bad idea then. It only helps on irq-latency. The
rest of the system will see lower performance. It should certainly not be
on as a default thing with PREEMPT_RT. Such low latencies are rarely
needed.

I think extremely low irq-latencies can better obtained with other 
solutions closer to the sub-kernel approach, i.e. taking it completely 
away from the scheduler such that the whole kernel - including the
scheduler, raw_spinlock etc. - runs with irqs enabled.

Actually, I think there should be 3 "levels" of irq-macroes:
 local_irq_disable()      should not compile under PREEMPT_RT (!!)
 raw_local_irq_disable()  should be used within the core kernel code.
 hard_local_irq_disable() for the very low latency interrupt systems.
Under normal circumstances raw_local and hard_local should refer to the
hardware but raw_local can be made into a soft-interrupt state close to
the sub-kernel approach such that one or two very special interupts can
come through.

Esben

