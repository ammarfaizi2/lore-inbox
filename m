Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131983AbRDGV0Y>; Sat, 7 Apr 2001 17:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDGV0P>; Sat, 7 Apr 2001 17:26:15 -0400
Received: from ns.suse.de ([213.95.15.193]:40207 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131973AbRDGV0A>;
	Sat, 7 Apr 2001 17:26:00 -0400
Date: Sat, 7 Apr 2001 23:25:55 +0200
From: Andi Kleen <ak@suse.de>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, nigel@nrg.org, rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
Message-ID: <20010407232555.A1982@gruyere.muc.suse.de>
In-Reply-To: <OF37B0793C.6B15F182-ON88256A27.0007C3EF@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF37B0793C.6B15F182-ON88256A27.0007C3EF@LocalDomain>; from Paul.McKenney@us.ibm.com on Fri, Apr 06, 2001 at 06:25:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 06:25:36PM -0700, Paul McKenney wrote:
> I see your point here, but need to think about it.  One question:
> isn't it the case that the alternative to using synchronize_kernel()
> is to protect the read side with explicit locks, which will themselves
> suppress preemption?  If so, why not just suppress preemption on the read
> side in preemptible kernels, and thus gain the simpler implementation
> of synchronize_kernel()?  You are not losing any preemption latency
> compared to a kernel that uses traditional locks, in fact, you should
> improve latency a bit since the lock operations are more expensive than
> are simple increments and decrements.  As usual, what am I missing
> here?  ;-)

You miss nothing I think. In fact it's already used (see below) 

> 
> > > 2.   Isn't it possible to get in trouble even on a UP if a task
> > >      is preempted in a critical region?  For example, suppose the
> > >      preempting task does a synchronize_kernel()?
> >
> > Ugly. I guess one way to solve it would be to readd the 2.2 scheduler
> > taskqueue, and just queue a scheduler callback in this case.
> 
> Another approach would be to define a "really low" priority that noone
> other than synchronize_kernel() was allowed to use.  Then the UP
> implementation of synchronize_kernel() could drop its priority to
> this level, yield the CPU, and know that all preempted tasks must
> have obtained and voluntarily yielded the CPU before synchronize_kernel()
> gets it back again.

That just would allow nasty starvation, e.g. when someone runs a cpu intensive
screensaver or a seti-at-home.

> 
> I still prefer suppressing preemption on the read side, though I
> suppose one could claim that this is only because I am -really-
> used to it.  ;-)

For a lot of reader cases non-preemption by threads is guaranteed anyways -- 
e.g.  anything that runs in interrupts, timers, tasklets and network softirq.  
I think that already covers a lot of interesting cases.


-Andi


