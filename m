Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVEKPGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVEKPGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVEKPGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:06:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46037 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261168AbVEKPFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:05:42 -0400
Date: Wed, 11 May 2005 08:04:54 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Joe Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU + SMR for preemptive kernel/user threads.
Message-ID: <20050511150454.GA1343@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <opsqivh7agehbc72@grunion> <opsqkajto6ehbc72@grunion> <20050510165512.GA1569@us.ibm.com> <opsqkzxij0ehbc72@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opsqkzxij0ehbc72@grunion>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 06:40:20PM -0400, Joe Seigh wrote:
> On Tue, 10 May 2005 09:55:12 -0700, Paul E. McKenney <paulmck@us.ibm.com>  
> wrote:
> 
> > Here is what I thought you were suggesting for the updater:
> >
> > 	Remove item from list
> > 	Send IPIs to all CPUs, relying on exact interrupts (which might
> > 		not be present on all CPUs) to serialize the instruction
> > 		streams of the other CPUs
> > 	Wait for all IPIs to complete
> > 	Wait until there are no hazard pointers referencing the item
> > 		before freeing.
> 
> Well, anything that acts as a memory barrier, occurs frequently or
> can be made to do so, and can be monitored.  For the inital user
> thread implementations I used unix signals (pthread_kill).  Worked
> ok on OS X but pretty much tanked on Linux.  So no signals as a
> common unix user thread implementation of this.  It would have to be
> /proc type information that would let you infer the threads in question
> had done something that synchronized memory.  I don't mess around in
> the Linux kernel so I can't make any specific suggestions there.

OK, I was thinking in terms of the kernel.

> You're the expert there.

"We", LKML, rather than "me".

> > For the traverser:
> >
> > 	1. allocate hazard pointer (SW engr problem: what to do if
> > 		allocation fails?  If deeply nested, holding locks, &c?)
> > 	2. retry:
> > 	3. Pick up pointer, store into hazard pointer.
> > 	4. Tell the compiler not to reorder memory references across this point
> > 	5. If hazard pointer does not match the pointer, goto retry.
> > 	6. begin critical section
> >
> > If the updater and traverser run concurrently, the interrupt forces
> > serialization -- look at all the possible interleavings to see this:
> > 1.	Before this point, the traverser cannot see the removed element.
> > 2.	Ditto.
> > 3.	Ditto.
> > 4.	Before this point, the traverser might have stored a pointer to
> > 	the remove element into the hazard pointer, but will see the
> > 	disappearance when it returns from interrupt.
> > 5.	Ditto.
> > 6.	At this point, the hazard pointer has been set, and the
> > 	interrupt will force memory ordering.
> 
> Right, the memory ordering on 6 means the updater is guaranteed to see
> the hazard pointer set if it has a valid value.

OK.  Note that the CPU would be free to reorder.  The IPIs suppress
this reordering, but only when needed.

> > Similar reasoning when the traverser NULLs the hazard pointer.
> 
> Setting the hazard pointer to NULL requires release semantics to ensure
> prior accesses to the element complete before the element is deleted.
> That's an MFENCE on Intel, membar #StoreStore+#LoadStore on sparc, and
> lwsync on powerpc.  Or you could wait an additional RCU grace period
> to ensure those prior accesses complete before deleting the element if
> you have RCU set up to track memory synchronization.
> 
> RCU "read" access is kind of like a lock.  And when you release
> a lock, you need release memory synchronization semantics to prevent
> accesses occurring outside of the critical region, the end of which
> in this case would be defined by the store of NULL into the hazard pointer.

In classic RCU, the release is supplied by the context switch.  In your
scheme, couldn't you do the following on the update side?

	1.  Gather up all the hazard pointers.
	2.  Send IPIs to all other CPUs.
	3.  Check the hazard pointers gathered in #1 against the
	    blocks to be freed.

The read side would do the following when letting go of a hazard pointer:

	1.  Prevent the compiler from reordering memory references
	    (the CPU would still be free to do so).
	2.  Set the hazard pointer to NULL.
	3.  begin non-critical-section code.

Checking where the IPI is received by the read side:

1.  Before this point, the updater would have seen the non-NULL hazard
    pointer (if the hazard pointer referenced the data item that was
    previously removed).
2.  Ditto.
3.  Before this point, the hazard pointer could be seen as NULL, but
    the read-side CPU will also have stopped using the pointer (since
    we are assuming precise interrupts).

Again, not sure if all CPUs support precise interrupts.  The ones that I
am familiar with do, at least for IPIs.

> Additionally if you replace any non NULL hazard pointer value you will  
> need to use
> release semantics.

The trick is that the IPI provides the release semantics, but only
when needed.  Right?

> There might be something you can do to avoid the extra RCU wait but
> I'd have to study it a little more to get a better handle on the
> trade offs.

True, there will need to be either two RCU waits or two rounds of IPIs.

> > Or am I missing something?  Or is there some CPU that Linux supports that
> > does inexact interrupts?
> 
> It's not the interrupts per se that are of interest here, it's the memory
> synchronization.  If interrupts are a problem, you could always find  
> something
> that does synchronization in a more orderly manner, or put explicit memory
> synchronization in the interrupt handler to force exactitude for this  
> particular
> case.

The interrupts provide the memory synchronization (if the CPU does not
cause a memory barrier on interrupt, one simply places a memory barrier
in the IPI handler).  The trick is that the memory barriers are not
executed except when they are needed.  This provides performance benefits
when updates are rare compared to read-side critical sections.

But again, assumes that the CPU provides precise interrupts.

> > I must admit that I am not completely comfortable with this approach --  
> > it
> > needs to be beaten up pretty thoroughly with both testing and theoretical
> > analysis.  And there might well be a flaw in my reasoning above.  ;-)
> >
> 
> I suppose I should do some kind of formal analysis of this.  I'm figuring  
> out
> if this technique is interesting enough first before I go through all that  
> work.

Hard to say without some experimentation.

							Thanx, Paul

> -- 
> Joe Seigh
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
