Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVJRRKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVJRRKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 13:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVJRRKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 13:10:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61074 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750798AbVJRRKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 13:10:23 -0400
Date: Tue, 18 Oct 2005 13:09:43 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: Re: [PATCH 8/9] Kprobes: Use RCU for (un)register synchronization - base changes
Message-ID: <20051018170943.GA7264@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051010144107.GC4389@in.ibm.com> <20051010144206.GD4389@in.ibm.com> <20051010144248.GE4389@in.ibm.com> <20051010144343.GF4389@in.ibm.com> <20051010144430.GG4389@in.ibm.com> <20051010144515.GH4389@in.ibm.com> <20051010144720.GI4389@in.ibm.com> <20051018054436.GA1364@us.ibm.com> <20051018144323.GA4479@in.ibm.com> <20051018163116.GB1304@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018163116.GB1304@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 09:31:16AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 18, 2005 at 10:43:23AM -0400, Ananth N Mavinakayanahalli wrote:
> > On Mon, Oct 17, 2005 at 10:44:36PM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 10, 2005 at 10:47:20AM -0400, Ananth N Mavinakayanahalli wrote:
> > > > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

<snip>

> > > > -/* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
> > > > +/* Get the kprobe at this addr (if any) - called under a rcu_read_lock() */
> > > 
> > > Since the update side uses synchronize_kernel() (in patch 9/9, right?),
> > 
> > Yes, synchronize_sched() to be precise.
> 
> Good, am not going blind yet.  ;-)

:)

> > > shouldn't the above "rcu_read_lock()" instead by preempt_disable()?
> > 
> > My reasoning was that since rcu_read_(un)lock is #defined to
> > preempt_(en)disable. But, I agree, since we use synchronize_sched() this
> > can just be preempt_disable()...
> > Suggestions?
> 
> In some realtime-friendly RCU implementations, the RCU read-side critical
> sections do not disable preemption.  So, if you are using synchronize_sched()
> on the update side, you need to use preempt_disable() (or some other
> primitive that disables preemption, for example, any of the primitives
> that disables hardware interrupts) on the read side.
> 
> >From Documentation/RCU/whatisRCU.txt, the correspondence between the
> update-side primitive and the read-side primitives needs to be as follows:
> 
> 	Defer			Protect
> 
> a.	synchronize_rcu()	rcu_read_lock() / rcu_read_unlock()
> 	call_rcu()
> 
> b.	call_rcu_bh()		rcu_read_lock_bh() / rcu_read_unlock_bh()
> 
> c.	synchronize_sched()	preempt_disable() / preempt_enable()
> 				local_irq_save() / local_irq_restore()
> 				hardirq enter / hardirq exit
> 				NMI enter / NMI exit

Thanks for the pointers.

> > > Also, some of the code in the earlier patches seems to do preempt_disable.
> > > For example, kprobe_handler() in arch/i386/kernel/kprobes.c.
> > 
> > Well, the convolution is due to the way kprobes work: 
> > - Breakpoint hit; execute pre_handler
> > - single-step on a copy of the original instruction; execute the
> > post_handler
> > 
> > We don't want to be preempted from the time of the breakpoint exception
> > until after the post_handler is run. I've taken care to ensure the
> > preempt_ calls from the various codepaths are balanced.
> 
> OK, didn't follow this -- thank you for the explanation!  This sequence
> of events happens on each execution of the kprobe handler, or is there
> some optimization for subsequent invocations of the same kprobe handler?
> 
> If the former, then perhaps there is some way to make the preempt_disable()
> that protects the single stepping also protect the probe lookup.

It is the former.

> > > In realtime kernels, synchronize_sched() does -not- guarantee that all
> > > rcu_read_lock() critical sections have finished, only that any
> > > preempt_disable() code sequences (explicit or implicit) have completed.
> > 
> > Are we assured that the preempt_ depth is also taken care of? If that is
> > the case, I think we are safe, since the matching preempt_enable() calls
> > are _after_ the post_handler is executed.
> 
> Seems so to me -- though if I understand you correctly, you should then
> be able to simply remove the rcu_read_lock() and rcu_read_unlock() calls,
> since that code sequence would be covered by the preempt_disable().
> 
> Or am I missing something?

Nope, you are right. The extra depth was introduced so the older kprobes
code wouldn't throw warnings on every smp_processor_id() invocation
without preemption disabled. With the current changes, we can get rid of
the extra depth with a little bit of code rearrangement. I am on it now.

Thanks,
Ananth
