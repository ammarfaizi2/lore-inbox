Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVEJWge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVEJWge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVEJWge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:36:34 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:50386 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261810AbVEJWgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:36:21 -0400
Date: Tue, 10 May 2005 15:36:31 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress
Message-ID: <20050510223630.GJ1566@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050510012444.GA3011@us.ibm.com> <1115755692.26548.15.camel@twins> <20050510202915.GH1566@us.ibm.com> <1115758584.26548.33.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115758584.26548.33.camel@twins>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 10:56:24PM +0200, Peter Zijlstra wrote:
> On Tue, 2005-05-10 at 13:29 -0700, Paul E. McKenney wrote:
> > On Tue, May 10, 2005 at 10:08:11PM +0200, Peter Zijlstra wrote:
> > > On Mon, 2005-05-09 at 18:24 -0700, Paul E. McKenney wrote:
> > > 
> > > > 
> > > > Counter-Based Approach
> > > > 
> > > > The current implementation in Ingo's CONFIG_PREEMPT_RT patch uses a
> > > > counter-based approach, which seems to work, but which can result in
> > > > indefinite-duration grace periods.  The following are very hazy thoughts
> > > > on how to get the benefits of this approach, but with short grace periods.
> > > > 
> > > > 1.	The basic trick is to maintain a pair of counters per CPU.
> > > > 	There would also be a global boolean variable that would select
> > > > 	one or the other of each pair.  The rcu_read_lock() primitive
> > > > 	would then increment the counter indicated by the boolean
> > > > 	corresponding to the CPU that it is currently running on.
> > > > 	It would also keep a pointer to that particular counter in
> > > > 	the task structure.  The rcu_read_unlock() primitive would
> > > > 	decrement this counter.  (And, yes, you would also have a
> > > > 	counter in the task structure so that only the outermost of
> > > > 	a set of nested rcu_read_lock()/rcu_read_unlock() pairs would
> > > > 	actually increment/decrement the per-CPU counter pairs.)
> > > > 
> > > > 	To force a grace period, one would invert the value of the
> > > > 	global boolean variable.  Once all the counters indicated
> > > > 	by the old value of the global boolean variable hit zero,
> > > > 	the corresponding set of RCU callbacks can be safely invoked.
> > > > 
> > > > 	The big problem with this approach is that a pair of inversions
> > > > 	of the global boolean variable could be spaced arbitrarily 
> > > > 	closely, especially when you consider that the read side code
> > > > 	can be preempted.  This could cause RCU callbacks to be invoked
> > > > 	prematurely, which could greatly reduce the life expectancy
> > > > 	of your kernel.
> > > 
> > > > Thoughts?
> > > 
> > > How about having another boolean indicating the ability to flip the
> > > selector boolean. This boolean would be set false on an actual flip and
> > > cleared during a grace period. That way the flips cannot ever interfere
> > > with one another such that the callbacks would be cleared prematurely.
> > 
> > But the flip is an integral part of detecting a grace period.  So, if I
> > understand your proposal correctly, I would have to flip to figure out
> > when it was safe to flip.
> > 
> > What am I missing here?
> 
> 
> int can_flip = 1;
> int selector = 0;
> 
> int counter[2] = {0, 0};
> 
> void up()
> {
>   ++counter[current->selection = selector];

Suppose task 0 has just fetched the value of "selector".  How does
force_grace() know that it is now inappropriate to invert the value
of "selector"?

One might suppress preemption, but there can still be interrupts,
ECC error correction, and just plain bad luck.  So up() needs to
be able to deal with "selector" getting inverted out from under it.

Unless I am missing something still...

						Thanx, Paul

> }
> 
> void down()
> {
>   if (!--counter[current->selection])
>     do_grace();
> }
> 
> void do_grace()
> {
>   // free stuff
>   can_flip = 1;
> }
> 
> void force_grace()
> {
>   if (can_flip)
>   {
>     can_flip = 0;
>     selector ^= 1;
>   }
> }
> 
> 
> The way I understood your proposal was that in order to force a grace
> period you flip the selector and once the old one reaches zero again it
> does a cleanup.
> 
> Now your problem was that when you force another flip before the old
> counter reached zero the shit will hit the proverbial fan. So what I
> proposed (as hopefully illustrated by the code) was another boolean; my
> can_flip; that controls the flippability :-)
> 
> One can for example call force_grace every few seconds or when a
> watermark on the rcu-callback queue has been reached. If can_flip blocks
> the actual flip nothing is lost since a cleanup is allready pending.
> 
> I hope to have been clearer in explaining my idea; or if I'm missing the
> issue tell me to read the thread in the morning ;)
> 
> -- 
> Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> 
