Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVFKOc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVFKOc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVFKOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:32:59 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:12213 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261710AbVFKOc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:32:26 -0400
Date: Sat, 11 Jun 2005 16:32:02 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <20050611134609.GA31025@elte.hu>
Message-Id: <Pine.OSF.4.05.10506111612070.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > > Plus take into
> > > account that the average interrupt disable section is very small .. I
> > > also think it's possible to extend my version to allow those section to
> > > be preemptible but keep the cost equally low.
> > > 
> > 
> > The more I think about it the more dangerous I think it is. What does 
> > local_irq_disable() protect against? All local threads as well as 
> > irq-handlers. If these sections keeped mutual exclusive but preemtible 
> > we will not have protected against a irq-handler.
> 
> one way to make it safe/reviewable is to runtime warn if 
> local_irq_disable() is called from a !preempt_count() section. But this 
> will uncover quite some code. 


> There's some code in the VM, in the 
> buffer-cache, in the RCU code - etc. that uses per-CPU data structures 
> and assumes non-preemptability of local_irq_disable().
> 
For me it is perfectly ok if RCU code, buffer caches etc use
raw_local_irq_disable(). I consider that code to be "core" code.

> > I will start to play around with the following:
> > 1) Make local_irq_disable() stop compiling to see how many we are really
> > talking about.
> 
> there are roughly 100 places:
> 
>  $ objdump -d vmlinux | grep -w call |
>       grep -wE 'local_irq_disable|local_irq_save' | wc -l
>  116
> 
> the advantage of having such primitives as out-of-line function calls :)

But many of those might be called from inline functions :-)

> 
> > 2) Make local_cpu_lock, which on PREEMPT_RT is a rt_mutex and on
> > !PREEMPT_RT turns into local_irq_disable()/enable() pairs. To introduce
> > this will demand some code-analyzing for each case but I am afraid there
> > is no general one-size solution to all the places.
> 
> I'm not sure we'd gain much from this. Lets assume we have a highprio RT 
> task that is waiting for an external event. Will it be able to preempt 
> the IRQ mutex?  Yes. Will it be able to make any progress: no, because 
> it needs an IRQ thread to run to get the wakeup in the first place, and 
> the IRQ thread needs to take the IRQ mutex => serialization.
>

That is exactly my point: We can't make a per-cpu mutex to replace
local_irq_disable(). We have to make real lock for each subsystem now
relying on local_irq_disable(). A global lock will not work. We could have
a temporary lock all non-RT can share but that would be a hack similar to
BKL.

The current soft-irq states only gives us better hard-irq latency but
nothing else. I think the overhead runtime and the complication of the
code is way too big for gaining only that. 

What is the aim of PREEMPT_RT? Low irq-latency, low task latency or
determnistic task latency? The soft irq-state helps on the first but
harms the two others indirectly by introducing extra overhead. To be
honest I think that approach should be abandoned.
 
> what seems a better is to rewrite per-CPU-local-irq-disable users to 
> make use of the DEFINE_PER_CPU_LOCKED/per_cpu_locked/get_cpu_lock 
> primitives to use preemptible per-CPU data structures. In this case 
> these sections would be truly preemptible. I've done this for a couple 
> of cases already, where it was unavoidable for lock-dependency reasons.
>

I'll continue that work then but in a way where !PREEMPT_RT will make it
back into local-irq-disable such it wont hurt performance there.
 
I.e. I will try to make a macro system, and try to turn references to
local_irq_disable() into these - or raw_local_irq_disable().

> 	Ingo
> 
Esben


