Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWJQUOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWJQUOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWJQUOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:14:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41096 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751262AbWJQUNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:13:55 -0400
Date: Tue, 17 Oct 2006 13:15:00 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061017201500.GI2062@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061017172710.GD2062@us.ibm.com> <Pine.LNX.4.44L0.0610171454340.3627-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610171454340.3627-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 03:42:07PM -0400, Alan Stern wrote:
> On Tue, 17 Oct 2006, Paul E. McKenney wrote:
> 
> > OK.  My thought would be to clearly state that memory barriers are needed
> > only in the following two cases: (1) for MMIO and (2) for sharing memory
> > among multiple CPUs.
> 
> And then also state that for all other cases, "conditionally precedes" is 
> the same as "precedes".

Or that "conditionally precedes" is not to be used except for describing
the action of memory barriers.

> > > 	If you are in the single-CPU case then just plain "precedes" 
> > > 	works fine for normal memory accesses (MMIO is handled
> > > 	specially).
> > > 
> > > 	But when multiple CPUs access the same variable all ordering
> > > 	is "conditional"; each CPU must use a memory barrier to
> > > 	guarantee the desired ordering.
> > 
> > "There -is- no ordering!"  (Or was that "There -is- no spoon"?)  ;-)
> 
> (Ceci n'est pas un CPU!)

I wonder what our CPUs thought while processing that sentence.  ;-)

> If there is no ordering then what does "conditionally precedes" mean?  
> Perhaps you would prefer to write instead:
> 
> 	... each CPU must use a memory barrier to obtain the apparent
> 	effect of the desired ordering.
> 
> Or even:
> 
> 	... each CPU must use a memory barrier to satisfy the "condition"
> 	in "conditionally precedes".

"There -is- no ordering" was a bit extreme, even for me.  ;-)

> > You know, I am not sure we are ever going to reconcile our two
> > viewpoints...
> > 
> > Your view (I believe) is that each execution produces some definite
> > order of loads and stores, with each load and store occurring at some
> > specific point in time.  Of course, a given load or store might be visible
> > at different times from different CPUs, even to the point that CPUs
> > might disagree on the order in which given loads and stores occurred.
> 
> Maybe so, but I am willing to converse in terms which assume no definite 
> ordering.  Which makes the term "conditionally precedes" difficult to 
> justify, since the word "precedes" implies the existence of an ordering.

My hope is to come up with something that is semi-comfortable for both
viewpoints.

> > My view is that individual loads and stores are complex operations, each
> > of which takes significant time to complete.  A pair of these operations
> > can therefore overlap in time, so that it might or might not make sense
> > to say that the pair occurred in any order at all -- nor to say that
> > any given load or store happens at a single point in time.  I described
> > this earlier as loads and stores being "fuzzy".
> > 
> > The odds of you (or anyone) being able to pry me out of my viewpoint
> > are extremely low -- in fact, if such a thing were possible, the
> > odds would be represented by a negative number.  The reason for this
> > admittedly unreasonable attitude is that every time I have strayed from
> > this viewpoint over the past decade or two, I have been brutally punished
> > by the appearance of large numbers of subtle and hard-to-find bugs.
> > My intuition about sequencing and ordering is so strong that if I let
> > it gain a foothold, it will blind me to the possibility of these bugs
> > occurring.  I can either deny that the loads and stores happen in any
> > order whatsoever (which works, but is very hard to explain), or assert
> > that they take non-zero time to execute and can therefore overlap.
> 
> That's different from saying "There -is- no ordering!"  For example, if 
> loads and stores take non-zero time to execute and can therefore overlap, 
> then they can be ordered by their start times or by their end times.  Or 
> you could set up a partial ordering: One access comes before another if 
> its end time precedes the other's start time.
> 
> These might not be _useful_ orderings, but they do exist.  :-)

"Zen and the art of memory-barrier placement".  ;-)

> > That said, I do recognize that my viewpoint is not universally applicable.
> > 
> > Someone using locking will probably be much more productive if they
> > leverage their intuition, assuming that locks are acquired and released
> > in a definite order and that all the memory references in the critical
> > sections executing in order, each at a definite point in time.  After all,
> > the whole point of the locking primitives and their associated memory
> > barriers is to present exactly this illusion.  It is quite possible that
> > it is better to use a viewpoint like yours when thinking about MMIO
> > accesses -- and given your work in USB and PCI, it might well be very
> > difficult to pry -you- out of -your- viewpoint.
> > 
> > But I believe that taking a viewpoint very similar to mine is critical
> > for getting the low-level synchronization primitives even halfway correct.
> > (Obscene quantities of testing are required as well.)
> > 
> > So, how to proceed?
> > 
> > One approach would be to demonstrate counter-intuitive results with a
> > small program (and I do have several at hand), enumerate the viewpoints,
> > and then use examples.
> 
> That sounds like a pedagogically useful way to disturb people out of their 
> complacency.

Guilty to charges as read!

> > Another approach would be to use a formalism.  Notations such as ">p"
> > (comes before) and "<p" (comes after) for program order and ">v"/"<v"
> > for order of values in a given variable have been used in the past.
> > These could be coupled with something vaguely resembling you suggestion
> > for loads and stores: l(v,c,l) for load from variable "v" by CPU "c"
> > at code line number "l" and s(v,c,l,n) for store to variable "v" by CPU
> > "c" at code line number "l" with new value "n".  (In the examples below,
> > "l" can be omitted, since there is only one of each per CPU.)
> > 
> > If we were to take your choice for the transitivity required for locking,
> > we would need to also define an ">a"/"<a" or some such denoting a
> > chain of values where the last assignment was performed atomically
> > (possibly also by a particular CPU).  In that case, ">v"/"<v" would
> > denote values separated by a single assignment.  However, for simplicity
> > of nomenclature, I am taking my choice for this example -- if there is
> > at least one CPU that actually requires the atomic operation, then the
> > final result will need the more complex nomenclature.
> > 
> > Then take the usual code, with all variables initially zero:
> > 
> > 	CPU 0			CPU 1
> > 
> > 	A=1			Y=B
> > 	smp_mb()		smp_mb()
> > 	B=1			X=A
> > 
> > Then the description of a memory barrier ends up being something like
> > the following:
> > 
> > 	Given the following:
> > 	
> > 		l(B,1,) >p smp_mb() >p l(A,1,), and
> > 		s(A,0,,1) >p smp_mb() >p s(B,0,,1):
> > 
> > 	Then:
> > 
> > 		s(B,0,,1) >v l(B,1,) -> s(A,0,,1) >v l(A,1,).
> > 
> > This notation correctly distinguishes the following two cases (all
> > variables initially zero):
> > 
> > 	CPU 0			CPU 1			CPU 2
> > 
> > 	A=1			while (B==0);		while (C==0);
> > 	smp_mb()		C=1			smp_mb()
> > 	B=1						assert(A==1) <fails>
> > 
> > and:
> > 
> > 	CPU 0			CPU 1			CPU 2
> > 
> > 	A=1			while (B==0);		while (B<2);
> > 	smp_mb()		B++			smp_mb()
> > 	B=1						assert(A==1) <succeeds>
> > 
> > In the first case, we don't have s(B,0,,1) >v l(C,2,).  Therefore,
> > we cannot rely on s(A,0,,1) >v l(A,2,).  In the second case, we do
> > have s(B,0,,1) >v l(B,2,), so s(A,0,,1) >v l(A,2,) must hold.
> 
> Using your notion of transitivity for all accesses to a single variable, 
> yes.

Yep.  In your scenario, both assertions could fail.

> > My guess is that this formal approach is absolutely required for the
> > more mathematically inclined, but that it will instead be an obstacle
> > to understanding (in fact, an obstacle even to reading!) for many people.
> > 
> > So my thought is to put the formal approach later on as reference material.
> > And probably to improve the notation -- the ",,"s look ugly.
> > 
> > Thoughts?
> 
> I agree; putting this material in an appendix would improve readability of
> the main text and help give a single location for a formal definition of
> the SMP memory access model used by Linux.

Cool!

> And yes, the notation could be improved.  For instance, in typeset text
> the CPU number could be a subscript.  For stores the value could be
> indicated by an equals sign, and the line number could precede the
> expression.  Maybe even use "lo" and "st" to make the names easier to 
> perceive.  You'd end up with something like this:  17:st_0(A = 2).  Then
> it becomes a lot cleaner to omit the CPU number, the line number, or the
> value.

Interesting approach -- I will play with this.

> > PS.  One difference between our two viewpoints is that I would forbid
> >      something like "s(A,0,,1) >v s(B,0,,1)", instead permitting ">v"/"<v"
> >      to be used on loads and stores of a single variable, with the exception
> >      of MMIO.  My guess is that you are just fine with orderings of
> >      assignments to different variables.  ;-)
> 
> Earlier I defined two separate kinds of orderings: "comes before" and
> "sequentially precedes".  My "comes before" is essentially the same as
> your "<v", applying only to accesses of the same variable.  You don't have
> any direct analog to "sequentially precedes", which is perhaps a weakness:  
> It will be harder for you to denote the effect of a load dependency on a
> subsequent store.  My "sequentially precedes" does _not_ require the
> accesses to be to the same variable, but it does require them to take
> place on the same CPU.

This is similar to my ">p"/"<p" -- or was your "sequentially precedes"
somehow taking effects of other CPUs into account.

> >      My example formalism for a memory barrier says nothing about the
> >      actual order in which the assignments to A and B occurred, nor about
> >      the actual order in which the loads from A and B occurred.  No such
> >      ordering is required to describe the action of the memory barrier.
> 
> Are you sure about that?  I would think it was implicit in your definition
> of "<v".  Talking about the order of values in a variable during the past
> isn't very different from talking about the order in which the
> corresponding stores occurred.

My "<v" is valid only for a single variable.  A computer that reversed
the order of execution of CPU 0's two assignments would be permitted,
as long as the loads on CPU 1 and CPU 2 got the correct values.

For an extreme example, consider mapping the code onto a dataflow
machine -- as long as the data dependencies are satisfied, the time
order is irrelevant.

> For that matter, the whole concept of "the value in a variable" is itself
> rather fuzzy.  Even the sequence of values might not be well defined: If
> you had some single CPU do nothing but repeatedly load the variable and
> note its value, you could end up missing some of the values perceived by
> other CPUs.  That is, it could be possible for CPU 0 to see A take on the
> values 0,1,2 while CPU 1 sees only the values 0,2.

Heck, if you have a synchronized clock register with sufficient accuracy,
you can catch different CPUs thinking that a given variable has different
values at the same point in time.  ;-)

							Thanx, Paul
