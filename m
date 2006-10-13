Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751735AbWJMSaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbWJMSaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWJMSaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:30:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53509 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751732AbWJMSaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:30:24 -0400
Date: Fri, 13 Oct 2006 14:30:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061013165112.GB1722@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610131411420.8165-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Paul E. McKenney wrote:

> Just for full disclosure, my experience has been than formal models
> of memory ordering are not all that helpful in explaining memory ordering
> to people.  They -can- be good for formal verification, but their
> track record even in that area has not been particularly stellar.
> 
> Formal verification of a particular -implementation- is another story,
> that has worked -very- well -- but I am hoping for some machine
> independence!

Well, this sort of simple formal model would have been helpful in 
explaining memory ordering to _me_!  :-)  Already in the course of this 
discussion we have ferretted out one or two significant points which the 
standard explanations fail to mention.

(That was why I started this whole thing.  There was a clear sense that
the standard write-ups were too vague and incomplete, but there was no way
to know what they were leaving out or how they were misdirecting.)


> My thought earlier was to allow transitivity in the case of stores and
> loads to a single variable.  You later argued in favor of taking the
> less-restrictive-to-hardware approach of only allowing transitivity for
> CPUs whose last access to the variable in question was via an atomic
> operation.  My "seen" approach would work for all CPU architectures
> that I am familiar with, but your approach would also work for a few
> even-more obnoxious CPUs that someone might someday build.
> 
> I have not yet decided which approach to take, will write things up
> and talk to a few more CPU architects.

Okay.  Let me know what they say.

>  The choices are:
> 
> 1.	The spin_lock() operation is special, and makes all prior
> 	critical sections for the given lock visible.  (Your approach.)
> 	Since a CPU cannot tell spin_lock() from a hole in the
> 	ground (OK, outside of a few research efforts), this would
> 	seem to come down to an atomic operation.
> 
> 2.	Seeing a given value of a particular variable has the same
> 	effect with respect to memory barriers as having seen any
> 	earlier value of that variable.  (My approach.)
> 
> I believe that any code that works on a CPU that does #1 would also
> work on a CPU that does #2, but not vice versa.  If true, this would
> certainly be a -major- point in favor of your approach.  ;-)

Doesn't #2 imply #1?  #2 means that seeing any spin_lock for a given lock
variable would have the same effect as having seen all the previous
spin_lock's for that lock, from which you could prove that all the effects
of prior critical sections for that lock would be visible.


> Agreed, I have no problem with globally ordered sequences for the values
> taken on by a single variable.  Or for the sequence of loads and stores
> performed by a single CPU -- but only from that CPU's viewpoint (other
> CPUs of course might see different orderings).
> 
> > The thing is, your objection to these terms has to do with the lack of
> > a single global linear ordering.  The fact that they imply a linear 
> > ordering should be okay, provided you accept that it is a _local_ 
> > ordering -- it makes sense only in the context of a single CPU.
> 
> If we are looking at a single CPU, then yes, a single global linear
> order for that CPU's accesses does make sense.
> 
> > For example, in the program
> > 
> > 	ld(A)
> > 	mb()
> > 	st(B)
> > 
> > the load and the store really are very strongly ordered by the mb().  The
> > CPU is prevented from rearranging them in ways that it normally would.  
> > Sure, when you look at the results from the point of view of a different
> > CPU this ordering might or might not be apparent -- but it's still there
> > and very real.
> >
> > So perhaps the best terms would be "locally precedes" and "locally 
> > follows".
> 
> Here I must disagree, at least for normal cached memory (MMIO I
> discuss later).  Yes, there are many -implementations- of computer
> systems that behave this way, and such implementations are indeed more
> intuitively appealing to me than others, but it is really is possible to
> create implementations where the CPU executing the above code really
> does execute it out of order, where the rest of the system really
> does see it out of order, and where it is up to the other CPU or the
> interconnect to straighten things out based on the memory barriers.
> For one (somewhat silly) example, imagine a system where each cache
> line contained per-CPU sequence numbers.  A CPU increments its sequence
> number when it executes a memory barrier, and tags cache lines with the
> corresponding sequence number.  Would anyone actually do this?  I doubt
> it, at least with today's technology.  But there are more subtle tricks
> that can have this same effect in some situations.
> 
> Again, the ordering will only be guaranteed to take effect if the
> memory barriers are properly paired.

So you disagree with my example, but do you agree with using the term
"locally precedes"?  The "locally" emphasizes that the ordering exists
only from the point of view of a single CPU, which you say is perfectly
acceptable.

If not, then how about "logically precedes"?  This points out the 
distinction with "physically precedes" -- a notion which may not have any 
clear meaning on a particular implementation.

Alan Stern

