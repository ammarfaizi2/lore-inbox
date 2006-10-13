Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWJMWiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWJMWiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWJMWiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:38:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:9393 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751957AbWJMWiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:38:24 -0400
Date: Fri, 13 Oct 2006 15:39:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061013223925.GH1722@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061013165112.GB1722@us.ibm.com> <Pine.LNX.4.44L0.0610131411420.8165-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610131411420.8165-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 02:30:15PM -0400, Alan Stern wrote:
> On Fri, 13 Oct 2006, Paul E. McKenney wrote:
> 
> > Just for full disclosure, my experience has been than formal models
> > of memory ordering are not all that helpful in explaining memory ordering
> > to people.  They -can- be good for formal verification, but their
> > track record even in that area has not been particularly stellar.
> > 
> > Formal verification of a particular -implementation- is another story,
> > that has worked -very- well -- but I am hoping for some machine
> > independence!
> 
> Well, this sort of simple formal model would have been helpful in 
> explaining memory ordering to _me_!  :-)  Already in the course of this 
> discussion we have ferretted out one or two significant points which the 
> standard explanations fail to mention.
> 
> (That was why I started this whole thing.  There was a clear sense that
> the standard write-ups were too vague and incomplete, but there was no way
> to know what they were leaving out or how they were misdirecting.)

So maybe a formal approach in some sort of appendix.  Having two different
ways of looking at it can be helpful, I must agree.

> > My thought earlier was to allow transitivity in the case of stores and
> > loads to a single variable.  You later argued in favor of taking the
> > less-restrictive-to-hardware approach of only allowing transitivity for
> > CPUs whose last access to the variable in question was via an atomic
> > operation.  My "seen" approach would work for all CPU architectures
> > that I am familiar with, but your approach would also work for a few
> > even-more obnoxious CPUs that someone might someday build.
> > 
> > I have not yet decided which approach to take, will write things up
> > and talk to a few more CPU architects.
> 
> Okay.  Let me know what they say.

One down...  Several to go.

> >  The choices are:
> > 
> > 1.	The spin_lock() operation is special, and makes all prior
> > 	critical sections for the given lock visible.  (Your approach.)
> > 	Since a CPU cannot tell spin_lock() from a hole in the
> > 	ground (OK, outside of a few research efforts), this would
> > 	seem to come down to an atomic operation.
> > 
> > 2.	Seeing a given value of a particular variable has the same
> > 	effect with respect to memory barriers as having seen any
> > 	earlier value of that variable.  (My approach.)
> > 
> > I believe that any code that works on a CPU that does #1 would also
> > work on a CPU that does #2, but not vice versa.  If true, this would
> > certainly be a -major- point in favor of your approach.  ;-)
> 
> Doesn't #2 imply #1?  #2 means that seeing any spin_lock for a given lock
> variable would have the same effect as having seen all the previous
> spin_lock's for that lock, from which you could prove that all the effects
> of prior critical sections for that lock would be visible.

Yes, I believe that #2 is "stronger" in that any system that adheres to
#2 runs any software designed with #1 in mind.  However, it is possible
to write code that works on a system adhering to #2, but which fails 
to work on a system adhering to #1.  The classic Dekker or Lamport
mutual-exclusion algorithms (with memory barriers added) would be examples.
They have no atomic operations, so would not work on a system that did
#1 but not #2.

Ewww...  How about __kfifo_get() and __kfifo_put()?  These have no atomic
operations.  Ah, but they are restricted to pairs of tasks, so pairwise
memory barriers should suffice.

> > Agreed, I have no problem with globally ordered sequences for the values
> > taken on by a single variable.  Or for the sequence of loads and stores
> > performed by a single CPU -- but only from that CPU's viewpoint (other
> > CPUs of course might see different orderings).
> > 
> > > The thing is, your objection to these terms has to do with the lack of
> > > a single global linear ordering.  The fact that they imply a linear 
> > > ordering should be okay, provided you accept that it is a _local_ 
> > > ordering -- it makes sense only in the context of a single CPU.
> > 
> > If we are looking at a single CPU, then yes, a single global linear
> > order for that CPU's accesses does make sense.
> > 
> > > For example, in the program
> > > 
> > > 	ld(A)
> > > 	mb()
> > > 	st(B)
> > > 
> > > the load and the store really are very strongly ordered by the mb().  The
> > > CPU is prevented from rearranging them in ways that it normally would.  
> > > Sure, when you look at the results from the point of view of a different
> > > CPU this ordering might or might not be apparent -- but it's still there
> > > and very real.
> > >
> > > So perhaps the best terms would be "locally precedes" and "locally 
> > > follows".
> > 
> > Here I must disagree, at least for normal cached memory (MMIO I
> > discuss later).  Yes, there are many -implementations- of computer
> > systems that behave this way, and such implementations are indeed more
> > intuitively appealing to me than others, but it is really is possible to
> > create implementations where the CPU executing the above code really
> > does execute it out of order, where the rest of the system really
> > does see it out of order, and where it is up to the other CPU or the
> > interconnect to straighten things out based on the memory barriers.
> > For one (somewhat silly) example, imagine a system where each cache
> > line contained per-CPU sequence numbers.  A CPU increments its sequence
> > number when it executes a memory barrier, and tags cache lines with the
> > corresponding sequence number.  Would anyone actually do this?  I doubt
> > it, at least with today's technology.  But there are more subtle tricks
> > that can have this same effect in some situations.
> > 
> > Again, the ordering will only be guaranteed to take effect if the
> > memory barriers are properly paired.
> 
> So you disagree with my example, but do you agree with using the term
> "locally precedes"?  The "locally" emphasizes that the ordering exists
> only from the point of view of a single CPU, which you say is perfectly
> acceptable.
> 
> If not, then how about "logically precedes"?  This points out the 
> distinction with "physically precedes" -- a notion which may not have any 
> clear meaning on a particular implementation.

For the pairwise memory barriers, I really like "conditionally precedes",
which makes it very clear that the observation of order is not automatic.
On both CPUs, and explicit memory barrier is required (with the exception
of MMIO, where the communication is instead with an I/O device).

For the single-variable case and for the single-CPU case, just plain
"precedes" works, at least as long as you are not doing fine-grained
timings that can allow you to observe cache lines in motion.  But if
you are doing that, you had better know what you are doing anyway.  ;-)

							Thanx, Paul
