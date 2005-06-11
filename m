Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVFKQm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVFKQm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVFKQm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:42:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46844 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261730AbVFKQmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:42:51 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10506111612070.2917-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506111612070.2917-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 09:41:38 -0700
Message-Id: <1118508098.9519.80.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 16:32 +0200, Esben Nielsen wrote:


> > > The more I think about it the more dangerous I think it is. What does 
> > > local_irq_disable() protect against? All local threads as well as 
> > > irq-handlers. If these sections keeped mutual exclusive but preemtible 
> > > we will not have protected against a irq-handler.
> > 

The more Dangerous you perieve it to be. Can you point to real damage?
After all this is experimental code.

> That is exactly my point: We can't make a per-cpu mutex to replace
> local_irq_disable(). We have to make real lock for each subsystem now
> relying on local_irq_disable(). A global lock will not work. We could have
> a temporary lock all non-RT can share but that would be a hack similar to
> BKL.
> 

Why do we need any of this?

> The current soft-irq states only gives us better hard-irq latency but
> nothing else. I think the overhead runtime and the complication of the
> code is way too big for gaining only that. 


Real numbers please, not speculation! Science, not religion.

> What is the aim of PREEMPT_RT? Low irq-latency, low task latency or
> determnistic task latency? The soft irq-state helps on the first but
> harms the two others indirectly by introducing extra overhead. To be
> honest I think that approach should be abandoned.

The purpose of the irq fix is deterministic interrupt response at a low
cost.

Quite honestly, if it does get abandoned in the community, Daniel and I
will continue to maintain it.

>  
> > what seems a better is to rewrite per-CPU-local-irq-disable users to 
> > make use of the DEFINE_PER_CPU_LOCKED/per_cpu_locked/get_cpu_lock 
> > primitives to use preemptible per-CPU data structures. In this case 
> > these sections would be truly preemptible. I've done this for a couple 
> > of cases already, where it was unavoidable for lock-dependency reasons.
> >
> 
> I'll continue that work then but in a way where !PREEMPT_RT will make it
> back into local-irq-disable such it wont hurt performance there.
>  
> I.e. I will try to make a macro system, and try to turn references to
> local_irq_disable() into these - or raw_local_irq_disable().

Esben, are there any bugs you are finding, or do you just dislike the
overhead?

Your argument is identical to the one that people made (and still make)
about preemption in the first place. 

A lot of issues were raised about simple preempt disable that was
necessary to make the kernel preemptable outside critical sections with
preemption, even though the concept was easy to understand from an SMP
POV. A lot of FUD is STILL floating around from that, 5 YEARS AGO.

A lot of discussion has been taking place about the constant overhead
necessary to improve preemption down to the level where we are now, in
PREEMPT_RT (with or without the IRQ relief you are concerned about)

The overhead of the mutex, which IS somewhat significant.

The people who need the preemption response-time absolutely don't care
about the overhead, because the cost of the CPUs required to make
vanilla Linux (with its high preemption latency) perform at latencies as
low as RT, is much higher, than the cost of a middle-of-the-road-
upgrade, to mask the constant mutex overhead.

In other words, the people who need RT preemption are willing to accept
the overhead absolutely, because it still saves them money, time, power,
whatever.

Daniel has now gone another step, very similar to the first step in
preemption, but taking advantage of a new environment, IRQs in threads.

The price here isn't that high, and the gain is astronomical, in terms
of the confidence in the interrupt subsystem that can be established
with this.

In a similar context as the argument I made above, people who need this
level of performance, will be real happy that they can leverage it, and
they WILL accept the overhead.

Daniel made this configurable, which is conventional in add-on patches.
Ingo removed that, and I do not disagree with either approach. I am just
glad that some folks understand the value of this concept, which Daniel
and I have been digesting since we opensourced the Mutex concept in the
first place.

I would prefer REAL performance data on the overhead you are suggesting,
rather than pages and pages of speculation, that make me question if you
have fully digested what is being done here.

I will be producing those ASAP, but I am REALLY busy with people who are
excited about the new era in Linux development that we are
(collectively) introducing. We are not expecting everyone to understand
it or agree with it.

But this is scientific, and we do need scientific approaches to
analysis.

Thanks,

Sven


