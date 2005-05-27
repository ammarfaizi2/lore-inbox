Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVE0Nbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVE0Nbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVE0Nbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:31:44 -0400
Received: from colin.muc.de ([193.149.48.1]:18193 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262470AbVE0NbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:31:24 -0400
Date: 27 May 2005 15:31:22 +0200
Date: Fri, 27 May 2005 15:31:22 +0200
From: Andi Kleen <ak@muc.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527133122.GF86087@muc.de>
References: <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527131317.GA11071@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 03:13:17PM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@muc.de> wrote:
> 
> > On Fri, May 27, 2005 at 02:48:37PM +0200, Ingo Molnar wrote:
> > > * Andi Kleen <ak@muc.de> wrote:
> > > 
> > > > [...] Even normal kernels must have reasonably good latency, as long 
> > > > as it doesnt cost unnecessary performance.
> > > 
> > > they do get reasonably good latency (within the hard constraints of the 
> > > possibilities of a given preemption model), due to the cross-effects 
> > > between the various preemption models, that i explained in detail in 
> > > earlier mails. Something that directly improves latencies on 
> > > CONFIG_PREEMPT improves the 'subsystem-use latencies' on PREEMPT_RT.  
> > 
> > I was more thinking of improvements for !PREEMPT.
> 
> how would you do that, if even a first step (PREEMPT_VOLUNTARY) was 
> opposed by some as possibly hurting throughput? I'm really curious, what 
> would you do to improve PREEMPT_NONE's latencies?

Mostly in the classical way. Add cond_resched where needed. Break
up a few locks. Perhaps convert a few spinlocks that block preemption
to long and which are not taken that often to a new kind of
sleep/spinlock (TBD).  Then add more reschedule point again.

> 
> > > Also there's the positive interaction between scalability and latencies 
> > > as well.
> >
> > That sound more like bugs that should just be fixed in the main kernel 
> > by more scheduling. Can you give details and examples?
> 
> what i meant is a pretty common-sense thing: the more independent the
> locks are, the more shortlived locking is, the less latencies there are.

At least on SMP the most finegrained locking is not always the best;
you can end up with bouncing cache lines all the time, with two CPUs
synchronizing to each other all the time, which is just slow.
it is sometimes better to batch things with less locks.
And every lock has a cost even when not taken, and they add up pretty quickly.

> The reverse is true too: most of the latency-breakers move code out from
> under locks - which obviously improves scalability too. So if you are 
> working on scalability you'll indirectly improve latencies - and if you 
> are working on reducing latencies, you often improve scalability.

But I agree that often less latency is good even for scalability.


> > > but it's certainly not for free. Just like there's no zero-cost
> > > virtualization, or there's no zero-cost nanokernel approach either,
> > > there's no zero-cost single-kernel-image deterministic system either.
> > > 
> > > and the argument about binary kernels - that's a choice up to vendors
> > 
> > It is not only binary distribution kernels. I always use my own self
> > compiled kernels, but I certainly would not want a special kernel just
> > to do something normal that requires good latency (like sound use).
> 
> for good sound you'll at least need PREEMPT_VOLUNTARY. You'll need 
> CONFIG_PREEMPT for certain workloads or pro-audio use.

AFAIK the kernel has quite regressed recently, but that was not true
(for reasonable sound) at least for some earlier 2.6 kernels and
some of the low latency patchkit 2.4 kernels.

So it is certainly possible to do it without preemption.

> the impact of PREEMPT on the codebase has a positive effect as well: it 
> forces us to document SMP data structure dependencies better. Under 
> PREEMPT_NONE it would have been way too easy to get into the kind of 
> undocumented interdependent data structure business that we so well know 
> from the big kernel lock days. get_cpu()/put_cpu() precisely marks the 
> critical section where we use a given per-CPU data structure.

Nah, there is still quite some code left that is unmarked, but 
ignores this case for various reason (e.g. in low level exception handling
which is preempt off anyways). However you are right it might have helped
a bit for generic code. But it is still quite ugly...

-Andi
