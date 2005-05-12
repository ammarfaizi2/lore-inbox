Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVELB5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVELB5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVELB5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 21:57:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:20411 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261270AbVELB45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 21:56:57 -0400
Date: Wed, 11 May 2005 18:57:12 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Joe Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU + SMR for preemptive kernel/user threads.
Message-ID: <20050512015712.GB1343@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <opsqivh7agehbc72@grunion> <opsqkajto6ehbc72@grunion> <20050510165512.GA1569@us.ibm.com> <opsqkzxij0ehbc72@grunion> <20050511150454.GA1343@us.ibm.com> <opsqmr52snehbc72@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opsqmr52snehbc72@grunion>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 05:47:52PM -0400, Joe Seigh wrote:
> On Wed, 11 May 2005 08:04:54 -0700, Paul E. McKenney <paulmck@us.ibm.com>  
> wrote:
> 
> > On Tue, May 10, 2005 at 06:40:20PM -0400, Joe Seigh wrote:
> 
> 
> > In classic RCU, the release is supplied by the context switch.  In your
> > scheme, couldn't you do the following on the update side?
> >
> > 	1.  Gather up all the hazard pointers.
> > 	2.  Send IPIs to all other CPUs.
> > 	3.  Check the hazard pointers gathered in #1 against the
> > 	    blocks to be freed.
> 
> You need to do the IPIs before you look at the hazard pointers.

I do both -- once after removing the data item and before gathering up
all the hazard pointers (see previous email) and once after gathering
up the hazard pointers but before checking them.  The combined update
procedure is thus:

	1.  Remove data item.
	2.  Send IPIs to all other CPUs.
	3.  Gather up all the hazard pointers.
	4.  Send IPIs to all other CPUs.
	5.  Check the hazard pointers gathered in #3 against
	    the data items to be freed.

> > The read side would do the following when letting go of a hazard pointer:
> >
> > 	1.  Prevent the compiler from reordering memory references
> > 	    (the CPU would still be free to do so).
> > 	2.  Set the hazard pointer to NULL.
> > 	3.  begin non-critical-section code.
> >
> > Checking where the IPI is received by the read side:
> >
> > 1.  Before this point, the updater would have seen the non-NULL hazard
> >     pointer (if the hazard pointer referenced the data item that was
> >     previously removed).
> > 2.  Ditto.
> > 3.  Before this point, the hazard pointer could be seen as NULL, but
> >     the read-side CPU will also have stopped using the pointer (since
> >     we are assuming precise interrupts).
> 
> The problem is you don't know when the hazard pointer was set to NULL.
> It could have been set soon after the IPI interrupt was received and
> any outstanding accesses made since the IPI interrupt aren't syncronized
> with respect to setting the hazard pointer to null.

If the hazard pointer was set to NULL after the IPI was received, then
the prior gather would have seen the hazard pointer as non-NULL, right?
This would prevent the data item from being freed, as desired in this
case.

> But if you looked at the hazard pointer in the IPI interrupt handler,
> you could use that information to decide whether you had to wait an
> additional RCU interval.  So updater logic would be
> 
>           1.  Set global pointer to NULL.  // make object unreachable
>           2.  Send IPIs  to all other CPUs
>               (IPI interrupt handler will copy CPU's hazard pointers)
>           3.  Check objects to be freed against copied hazard pointers.
>           4.  There is no step 4.  Even if the actual hazard pointers
>               that pointed to the object is NULL by this point (but not
>               its copy), you'd still have to wait and addtional RCU
>               interval so you might as well leave it out as redundant.
> 
> This is better.  I may try that trick I used to make NPTL condvars
> faster to see if I can keep Linux user space version of this from
> tanking.  It uses unix signals instead of IPIs.

Need to think about this one -- it does seem like copying the hazard
pointers in the IPI should reduce the amount of synchronization required.

> > Again, not sure if all CPUs support precise interrupts.  The ones that I
> > am familiar with do, at least for IPIs.
> >
> >> Additionally if you replace any non NULL hazard pointer value you will
> >> need to use
> >> release semantics.
> >
> > The trick is that the IPI provides the release semantics, but only
> > when needed.  Right?
> >
> >> There might be something you can do to avoid the extra RCU wait but
> >> I'd have to study it a little more to get a better handle on the
> >> trade offs.
> >
> > True, there will need to be either two RCU waits or two rounds of IPIs.
> 
> Yes, it might better be called RCU+SMR+RCU in that case.
> 
> 
> >>
> >> I suppose I should do some kind of formal analysis of this.  I'm  
> >> figuring
> >> out
> >> if this technique is interesting enough first before I go through all  
> >> that
> >> work.
> >
> > Hard to say without some experimentation.
> 
> 
> I've done plenty of that.  I have some atomically thread-safe reference
> counting impletations and a proxy GC based on those which I compare to
> an RCU for user threads implementation.  Using lock-free in user space
> gives you much more dramatic performance improvements than in the kernel.
> It cuts down on unnecessary context switching which can slow things down
> considerably.  Also mutexes and rwlocks are prone to starvation.  Making
> them FIFO for guaranteed service order slows them down even further.

True, user-level synchronization is often quite a bit more expensive
than in-kernel synchronization, so more beneficial to avoid.

> I usually use a semaphore to keep the updaters from running out of  
> resources.
> It slows down updater throughput but then I'm more concerned with reader
> throughput.  If I want faster recovery of resources I'll used the atomic
> refcounted pointer or the proxy based on it.  Slightly slower updater  
> performance
> but resources are recovered more quickly.
> 
> -- 
> Joe Seigh

						Thanx, Paul
