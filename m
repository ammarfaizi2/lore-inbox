Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWIKQFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWIKQFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWIKQFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:05:51 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:13831 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964954AbWIKQFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:05:50 -0400
Date: Mon, 11 Sep 2006 12:05:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060909004406.GM1314@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609111149100.8409-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Paul E. McKenney wrote:

> Here is one possible sequence of events for CPU 0's mb() operation:
> 
> 1.	Mark all currently pending invalidation requests from other CPUs
> 	(but there are none).
> 
> 2.	Wait for acknowledgements for all outstanding invalidation requests
> 	from CPU 0 to other CPUs (there is one, that corresponding to the
> 	assignment to a).
> 
> 3.	At some point in this sequence, the invalidation request from
> 	CPU 1 corresponding to the assignment to b arrives.  However,
> 	it was not present before the mb() started executing, so is
> 	-not- marked.
> 
> 4.	Ensure that all marked pending invalidation requests from other
> 	CPUs complete before any subsequence loads are allowed to
> 	commence on CPU 0 (but there are no marked pending invalidation
> 	requests).
> 
> Real CPUs are much more clever about performing these operations in a way
> that reduces the probability of stalling, but the above sequence should
> be good enough for this discussion.  The assignments to a and b pass in
> the night -- there are no memory barriers forcing them to be ordered.

Ah, I see.  This explains a lot.  I now have a much clearer mental
model of how these things work.  It isn't complete, but it does have
some interesting consequences.

One insight has to do with why it is that read-mb-write succeeds
whereas write-mb-read can fail.  It comes down to this essential
asymmetry:

	Suppose one CPU writes to a memory location at about the same
	time as another CPU using a different cache reads from it.  If
	the read completes before the write then the read is certain
	to return the old value.  But if the write completes before the
	read, the read is _not_ certain to return the new value.

> See below...  But I would strongly advise nacking any patch involving
> this sort of line of reasoning, especially given that I could have
> written a significant amount of "normal" code in the time that it
> took me to analyze this, and given the error rate on the part of
> myself and of others.

This discussion has not been aimed toward writing or accepting any
patches.  It's simply an attempt to understand better how memory
barriers work.


Moving on to the read-mb-write pattern...

> OK...  The initial value of a, b, x, and y are zero, right?
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	while (x==0) relax();	x = -1;
> 	x = a;			y = b;
> 	mb();			mb();
> 	b = 1;			a = 1;
> 				while (x < 0) relax();
> 				assert(x==0 || y==0);	//???
> 
> For y!=0, CPU 1's assignment y=b must follow CPU 0's assignment b=1.
> Since b=1 follows CPU 0's memory barrier, and since y=b precedes CPU 1's
> memory barrier, any code after CPU 1's memory barrier must see the effect
> of assignments from CPU 0 preceding CPU 0's memory barrier, so that CPU
> 1's assignment a=1 comes after CPU 0's assignment x=a, and so therefore
> x=a=0 at CPU 1.  But CPU 1 also assigns x=-1.  The question the becomes
> "which assignment to x came last?".  The "while" loop on CPU 0 cannot
> exit before the assignment x=-1 on CPU 1 completes, but there is no memory
> barrier between CPU 0's "while" loop and its subsequent assignment "x=a".
> 
> However, CPU 0 must see its own accesses as occurring in order, and all
> CPUs have to see some single global ordering of a sequence of assignments
> to a -single- given variable.  So I believe CPU 0's assignment x=a must be
> seen by all CPUs as following CPU 1's assignment x=-1, implying that the
> final value of x==0, and that the assertion does not trip.
> 
> But my head hurts...

You're getting a little hung-up on those "while" loops.  They aren't
an essential feature of the example; I put them in there just to
insure that CPU 0's write to x would be visible on CPU 1.

The real point of the example is that the read of a on CPU 0 and the
read of b on CPU 1 cannot both yield 1.  I could have made the same
point in a number of different ways.  This is perhaps the simplest:

	CPU 0			CPU 1
	-----			-----
	x = a;			y = b;
	mb();			mb();
	b = 1;			a = 1;
	assert(x==0 || y==0);

I'm sure you can verify that this assertion will never fail.

It's worth noting that since y is accessible to both CPUs, it must be
a variable stored in memory.  It follows that CPU 1's mb() could be
replaced with wmb() and the assertion would still always hold.  On the
other hand, the compiler is free to put x in a processor register.
This means that CPU 0's mb() cannot safely be replaced with wmb().


Let's return to the question I asked at the start of this thread:
Under what circumstances is mb() truly needed?  Well, we've just seen
one.  If CPU 0's mb() were replaced with "rmb(); wmb();" the assertion
above might fail.  The cache would be free to carry out the operations
in a way such that the read of a completed after the write to b.

This read-mb-write pattern turns out to be vital for implementing
sychronization primitives.  Take your own example:

> Consider the following (lame) definitions for spinlock primitives,
> but in an alternate universe where atomic_xchg() did not imply a
> memory barrier, and on a weak-memory CPU:
> 
> 	typedef spinlock_t atomic_t;
> 
> 	void spin_lock(spinlock_t *l)
> 	{
> 		for (;;) {
> 			if (atomic_xchg(l, 1) == 0) {
> 				smp_mb();
> 				return;
> 			}
> 			while (atomic_read(l) != 0) barrier();
> 		}
> 
> 	}
> 
> 	void spin_unlock(spinlock_t *l)
> 	{
> 		smp_mb();
> 		atomic_set(l, 0);
> 	}
> 
> The spin_lock() primitive needs smp_mb() to ensure that all loads and
> stores in the following critical section happen only -after- the lock
> is acquired.  Similarly for the spin_unlock() primitive.

In fact that last paragraph isn't quite right.  The spin_lock()
primitive would also work with smp_rmb() in place of smb_mb().  (I can
explain my reasoning later, if you're interested.)  However
spin_unlock() _does_ need smp_mb(), and for the very same reason as
the read-mb-write pattern.  If it were replaced with "smp_rmb();
smp_wmb();" then a register-read preceding a spin_unlock() could leak
past the unlock.


So it looks like this "non-canonical" read-mb-write pattern is
essential under certain circumstances, even if it doesn't turn out to
be particularly useful in more general-purpose code.  An interesting
thing about it is that, unlike the "canonical" pattern, it readily
extends to more than two processors:

	CPU 0		CPU 1		CPU 2
	-----		-----		-----
	x = a;		y = b;		z = c;
	mb();		mb();		mb();
	b = 1;		c = 1;		a = 1;
	assert(x==0 || y==0 || z==0);

The cyclic pattern of ordering requirements guarantees that at least
one of the reads must complete before the write of the corresponding
variable.  In more detail: One of the three reads, let's say the read
of b, will complete before -- or at the same time as -- each of the
others.  The mb() forces the write of b on CPU 0 to complete after the 
read of a and hence after the read of b; thus the value of y must end
up being 0.  Extensions to more than 3 processors are left as an
exercise for the reader.  :-)


Here's another question: To what extent do memory barriers actually
force completions to occur in order?  Let me explain...

We can think of a CPU and its cache as two semi-autonomous units.
>From the cache's point of view, a load or a store initializes when the
CPU issues the request to the cache, and it completes when the data is
extracted from the cache for transmission to the CPU (for a load) or
when the data is placed in the cache (for a store).

Memory barriers prevent CPUs from reordering instructions, thereby
forcing loads and stores to initialize in order.  But this reflects
how the barriers affect the CPU, whereas I'm more concerned about how
they affect the cache.  So to what extent do barriers force
memory accesses to _complete_ in order?  Let's go through the
possibilities.

	STORE A; wmb; STORE B;

This does indeed force the completion of STORE B to wait until STORE A
has completed.  Nothing else would have the desired effect.

	READ A; mb; STORE B;

This also forces the completion of STORE B to wait until READ A has
completed.  Without such a guarantee the read-mb-write pattern wouldn't
work.

	STORE A; mb; READ B;

This is one is strange.  For all I know the mb might very well force
the completions to occur in order... but it doesn't matter!  Even when
the completions do occur in order, it can appear to other CPUs as if
they did not!  This is exactly what happens when the write-mb-read
pattern fails.

	READ A; rmb; READ B;

Another peculiar case.  One almost always hears read barriers described
as forcing the second read to complete after the first.  But in reality
this is not sufficient.

The additional requirement of rmb is: Unless there is a pending STORE
to B, READ B is not allowed to complete until all the invalidation
requests for B pending (i.e., acknowledged but not yet processed) at
the time of the rmb instruction have completed (i.e., been processed).


There are consequences of these ideas with potential implications for
RCU.  Consider, as a simplified example, a thread T0 which constantly
repeats the following loop:

	for (;;) {
		++cnt;
		mb();
		x = p;
		// Do something time-consuming with *x
	}

Now suppose another thread T1 wants to update the value of p and wait
until the old value is no longer being used (a typical RCU-ish sort of
thing).  The natural approach is this:

	old_p = p;
	p = new_p;
	mb();
	c = cnt;
	while (c == cnt)
		barrier();
	// Deallocate old_p

This code can fail, for exactly the same reason as the write-mb-read
pattern.  If the two mb() instructions happen to execute at the same
time, it's possible for T0 to set x to the old value of p while T1
sets c to the old value of cnt.  (That's how the write-mb-read pattern
fails; both reads end up seeing the pre-write values.)  Then T1's
while() loop will quickly terminate, so T1 ends up destroying whatever
old_p points to while T0 is still using it.

RCU doesn't work quite like this, but it's still worth keeping in
mind.


There are yet more implications when one starts considering
communication with peripheral devices via DMA-coherent or
DMA-consistent memory buffers.  However I don't know enough about
these topics to say anything intelligent.  And then there's
memory-mapped I/O, but that's another story...

Alan Stern

