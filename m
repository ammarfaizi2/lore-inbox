Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVFMHxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVFMHxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFMHxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:53:54 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:34178 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261418AbVFMHxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:53:46 -0400
Date: Mon, 13 Jun 2005 09:53:24 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <1118646095.5729.57.camel@sdietrich-xp.vilm.net>
Message-Id: <Pine.OSF.4.05.10506130946010.10063-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Jun 2005, Sven-Thorsten Dietrich wrote:

> On Sun, 2005-06-12 at 13:15 +0200, Esben Nielsen wrote:
> > On Sun, 12 Jun 2005, Ingo Molnar wrote:
> > I am surprised that is should actually be faster, but I give in to the
> > experts. I will see if I can find time to perform a test or I should spend
> > it on something else.
> > 
> > That said, this long discussion have not been a complete waste of time: I
> > think this thread have learned us that we do have different goals and
> > clarifies stuff.
> > 
> > I am not happy about the soft-irq thing. Mostly due to naming.
> > local_irq_disable() is really just preempt_disable() with some extra stuff
> > to make it backward combatible. 
> > I still believe local_irq_disable() (also in the soft version) should be
> > completely forbidden when PREEMPT_RT is set. All places using it should be
> > replaced with a mutex or a ???_local_irq_disable() to mark that the code
> > have been reviewed for PREEMPT_RT. With your argument above 
> > ???_local_irq_disable() should really be preempt_disable() as that is
> > faster.
> > 
> 
> Hi Esben,
> 
> I just wondered if you are talking about the scenario where an interrupt
> is executing on one processor, and gets preempted. Then some code runs
> on the same CPU, which does local_irq_disable (now preempt_disable), to
> keep that IRQ from running, but the IRQ thread is already started?
> 
> In the community kernel, this could never happen, because IRQs can't be
> preempted. But in RT, its possible an IRQ could be preempted, and under
> some circumstance, this sequence could occur.
> 
> Is that is what you are talking about? If not, it might be over my head,
> and I am sorry. If so, I think that scenario is covered under SMP.
> 
> Sven
> 
No, Sven it is not. I am not so worried about that scenario.
I am worried about some coder somewhere still using local_irq_disable() -
there is a lot of code out there doing that. We have not confirmed that
all of it really locks small enough regions to preserver RT preemption.
I for one is doubtfull about the cmos_lock thingy. (Sorry, can't connect
to my machine at home to check where it is, right now.) A very weird setup
with a kind of homebrewn spinlock.
All these cases needs to be reviewed to see if it is valid to use a
global lock type like local_irq_disable() or a local mutex must be used.
The former is only "allowed" if the time being within the locked is
deterministicly only in the order of the time for scheduling.
I wanted to add a extra name to the namespace stating "this usage of
local_irq_disable() have been reviwed wrt. RT_PREEMPT".

Esben

