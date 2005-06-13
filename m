Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVFMIzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVFMIzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 04:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFMIzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 04:55:10 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:25484 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261434AbVFMIy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 04:54:58 -0400
Date: Mon, 13 Jun 2005 10:54:41 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <1118649905.5729.76.camel@sdietrich-xp.vilm.net>
Message-Id: <Pine.OSF.4.05.10506131043300.10063-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005, Sven-Thorsten Dietrich wrote:

> On Mon, 2005-06-13 at 09:53 +0200, Esben Nielsen wrote:
> > On Mon, 13 Jun 2005, Sven-Thorsten Dietrich wrote:
> > > > 
> > > 
> > > Hi Esben,
> > > 
> > > I just wondered if you are talking about the scenario where an interrupt
> > > is executing on one processor, and gets preempted. Then some code runs
> > > on the same CPU, which does local_irq_disable (now preempt_disable), to
> > > keep that IRQ from running, but the IRQ thread is already started?
> > > 
> > > In the community kernel, this could never happen, because IRQs can't be
> > > preempted. But in RT, its possible an IRQ could be preempted, and under
> > > some circumstance, this sequence could occur.
> > > 
> > > Is that is what you are talking about? If not, it might be over my head,
> > > and I am sorry. If so, I think that scenario is covered under SMP.
> > > 
> > > Sven
> > > 
> > No, Sven it is not. I am not so worried about that scenario.
> > I am worried about some coder somewhere still using local_irq_disable() -
> > there is a lot of code out there doing that. We have not confirmed that
> > all of it really locks small enough regions to preserver RT preemption.
> > I for one is doubtfull about the cmos_lock thingy. (Sorry, can't connect
> > to my machine at home to check where it is, right now.) A very weird setup
> > with a kind of homebrewn spinlock.
> > All these cases needs to be reviewed to see if it is valid to use a
> > global lock type like local_irq_disable() or a local mutex must be used.
> > The former is only "allowed" if the time being within the locked is
> > deterministicly only in the order of the time for scheduling.
> > I wanted to add a extra name to the namespace stating "this usage of
> > local_irq_disable() have been reviwed wrt. RT_PREEMPT".
> 
> I am sure there are some issues like you describe out there.
> 
> I suppose we could examine each local_irq_disable, but I wonder if there
> is not a better way.
> 
> I wrote earlier, that we could just keep specific IRQ threads from
> runnning, rather than disabling preemption overall.
> 
> This is somewhat orthogonal, but would serve as a filter to break things
> down into local_irq_disable to keep a specific IRQ from running, and
> local_irq_disable to suppress all IRQ activity.
> 
> If we're going to walk trough all these local_irq_disables, we might as
> well check-off that item as well.
> 
> What do you think?
>

The problem is local_irq_disable() doesn't carry around a notion of
locality: It doesn't say which code and which IRQ handler is the problem.
That is each instance have to be considered :-( :-(

We could make "global", per-cpu replacement lock (would be a bit like the
BKL hack), but as soon as a RT thread hits one of those RT is totally
gone. Each IRQ-handler needs to be reviewed wether or not they must be
executed under this lock or not. By instead doing the hard work of 
breaking it into smaller locks (with PI) or veryfying that the regions are
so small that disabling preemption is acceptable, the RT property can be
preserved.

I'll try to make an option in the config: "Disallow
local_irq_disable()/preempt_disable()". Then one can switch this on to
prevent local_irq_disable() not reviewed for PREEMPT_RT to sneak in from
!PREEMPT_RT. 
I will also try to make a lock which introduces the "notion
of locallity" (i.e. have the same semantics as a normal
spin_lock/mutex) into the code, but in !PREEMPT_RT will turn out to be
just local_irq_disable() or preempt_disable(). A lot of the
local_irq_disable() should be replaced with that.

Esben
 
> Sven
> 

