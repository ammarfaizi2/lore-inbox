Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVELIYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVELIYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVELIYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:24:48 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:21657 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S261322AbVELIYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:24:40 -0400
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: paulmck@us.ibm.com
Cc: dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050510223630.GJ1566@us.ibm.com>
References: <20050510012444.GA3011@us.ibm.com>
	 <1115755692.26548.15.camel@twins> <20050510202915.GH1566@us.ibm.com>
	 <1115758584.26548.33.camel@twins>  <20050510223630.GJ1566@us.ibm.com>
Content-Type: text/plain
Date: Thu, 12 May 2005 10:24:37 +0200
Message-Id: <1115886277.3326.16.camel@nspc0585.nedstat.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 15:36 -0700, Paul E. McKenney wrote:
> On Tue, May 10, 2005 at 10:56:24PM +0200, Peter Zijlstra wrote:
> > On Tue, 2005-05-10 at 13:29 -0700, Paul E. McKenney wrote:
> > > On Tue, May 10, 2005 at 10:08:11PM +0200, Peter Zijlstra wrote:
> > > > On Mon, 2005-05-09 at 18:24 -0700, Paul E. McKenney wrote:
> > > > 
> > > > > 
> > > > > Counter-Based Approach
> > > > > 
> > > > > The current implementation in Ingo's CONFIG_PREEMPT_RT patch uses a
> > > > > counter-based approach, which seems to work, but which can result in
> > > > > indefinite-duration grace periods.  The following are very hazy thoughts
> > > > > on how to get the benefits of this approach, but with short grace periods.
> > > > > 
> > > > > 1.	The basic trick is to maintain a pair of counters per CPU.
> > > > > 	There would also be a global boolean variable that would select
> > > > > 	one or the other of each pair.  The rcu_read_lock() primitive
> > > > > 	would then increment the counter indicated by the boolean
> > > > > 	corresponding to the CPU that it is currently running on.
> > > > > 	It would also keep a pointer to that particular counter in
> > > > > 	the task structure.  The rcu_read_unlock() primitive would
> > > > > 	decrement this counter.  (And, yes, you would also have a
> > > > > 	counter in the task structure so that only the outermost of
> > > > > 	a set of nested rcu_read_lock()/rcu_read_unlock() pairs would
> > > > > 	actually increment/decrement the per-CPU counter pairs.)
> > > > > 
> > > > > 	To force a grace period, one would invert the value of the
> > > > > 	global boolean variable.  Once all the counters indicated
> > > > > 	by the old value of the global boolean variable hit zero,
> > > > > 	the corresponding set of RCU callbacks can be safely invoked.
> > > > > 
> > > > > 	The big problem with this approach is that a pair of inversions
> > > > > 	of the global boolean variable could be spaced arbitrarily 
> > > > > 	closely, especially when you consider that the read side code
> > > > > 	can be preempted.  This could cause RCU callbacks to be invoked
> > > > > 	prematurely, which could greatly reduce the life expectancy
> > > > > 	of your kernel.
> > > > 
> > > > > Thoughts?
> > > > 
> > > > How about having another boolean indicating the ability to flip the
> > > > selector boolean. This boolean would be set false on an actual flip and
> > > > cleared during a grace period. That way the flips cannot ever interfere
> > > > with one another such that the callbacks would be cleared prematurely.
> > > 
> > > But the flip is an integral part of detecting a grace period.  So, if I
> > > understand your proposal correctly, I would have to flip to figure out
> > > when it was safe to flip.
> > > 
> > > What am I missing here?
> > 
> > 
> > int can_flip = 1;
> > int selector = 0;
> > 
> > int counter[2] = {0, 0};
> > 
> > void up()
> > {
> >   ++counter[current->selection = selector];
> 
> Suppose task 0 has just fetched the value of "selector".  How does
> force_grace() know that it is now inappropriate to invert the value
> of "selector"?
> 
> One might suppress preemption, but there can still be interrupts,
> ECC error correction, and just plain bad luck.  So up() needs to
> be able to deal with "selector" getting inverted out from under it.
> 
> Unless I am missing something still...

True, I see you point; there is a race between the = and ++ operators.

current->selection = selector;
--> gap
++counter[current->selection];

if you flip and the then old current->selection reached 0 before this
task gets executed again do_grace gets called and cleans the callbacks;
which should not matter since this task has not yet started using any
data. however it will be problematic because when it does get scheduled
again it works on the wrong counter and thus does not prevent a grace
period on the data will be using.

however I assumed you had these problems solved with your counter-based
approach. My code was meant to illustrate how I thought your double
inversion problem could be avoided.

Do you by any chance have a RCU impl. based on the counter-based
approach so I can try to understand and maybe try to intergrate my
ideas?


> > }
> > 
> > void down()
> > {
> >   if (!--counter[current->selection])
> >     do_grace();
> > }
> > 
> > void do_grace()
> > {
> >   // free stuff
> >   can_flip = 1;
> > }
> > 
> > void force_grace()
> > {
> >   if (can_flip)
> >   {
> >     can_flip = 0;
> >     selector ^= 1;
> >   }
> > }
> > 
> > 
> > The way I understood your proposal was that in order to force a grace
> > period you flip the selector and once the old one reaches zero again it
> > does a cleanup.
> > 
> > Now your problem was that when you force another flip before the old
> > counter reached zero the shit will hit the proverbial fan. So what I
> > proposed (as hopefully illustrated by the code) was another boolean; my
> > can_flip; that controls the flippability :-)
> > 
> > One can for example call force_grace every few seconds or when a
> > watermark on the rcu-callback queue has been reached. If can_flip blocks
> > the actual flip nothing is lost since a cleanup is allready pending.
> > 
> > I hope to have been clearer in explaining my idea; or if I'm missing the
> > issue tell me to read the thread in the morning ;)
> > 
> > -- 
> > Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > 
-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

