Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277829AbRJIQuy>; Tue, 9 Oct 2001 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277822AbRJIQur>; Tue, 9 Oct 2001 12:50:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21733 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277829AbRJIQuY>; Tue, 9 Oct 2001 12:50:24 -0400
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 9 Oct 2001 08:45:15 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/09/2001 10:50:47 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Oct 08, 2001 at 06:55:24PM -0700, Paul E. McKenney wrote:
> > This is a proposal to provide a wmb()-like primitive that enables
> > lock-free traversal of lists while elements are concurrently being
> > inserted into these lists.
>
> I've discussed this with you before and you continue to have
> completely missed the point.

It would not be the first point that I have completely missed, but
please read on.  I have discussed this algorithm with Alpha architects,
who tell me that it is sound.

> Alpha requires that you issue read-after-read memory barriers on
> the reader side if you require ordering between reads.  That is
> the extent of the weakness of the memory ordering.

I agree that Alpha requires "mb" instructions to be executed on the
reading CPUs if the reading CPUs are to observe some other CPU's writes
occuring in order.  And I agree that the usual way that this is done
is to insert "mb" instructions between the reads on the read side.

However, if the reading CPU executes an "mb" instruction between the
time that the writing CPU executes the "wmb" and the time that the writing
CPU executes the second store, then the reading CPU is guaranteed to
see the writes in order.  Here is how this happens:


     Initial values: a = 0, p = &a, b = 1.


     Writing CPU              Reading CPU

     1) b = 2;

     2) Execute "wmb" instruction

     3) Send a bunch of IPIs

                         4) Receive IPI

                         5) Execute "mb" instruction

                         6) Indicate completion

     7) Detect completion

     8) p = &b

The combination of steps 2 and 5 guarantee that the reading CPU will
invalidate the cacheline containing the old value of "b" before it
can possibly reference the new value of "p".  The CPU must read "p"
before "b", since it can't know where "p" points before reading it.

> Sparc64 is the same way.

I can believe that "membar #StoreStore" and friends operate in the same
way that the Alpha memory-ordering instructions do.  However, some of
the code in Linux seems to rely on "membar #SYNC" waiting for outstanding
invalidations to complete.  If this is the case, then "membar #SYNC"
could be used to segregate writes when the corresponding reads are
implicitly ordered by data dependencies, as they are during pointer
dereferences.

> This crap will never be applied.  Your algorithms are simply broken
> if you do not ensure proper read ordering via the rmb() macro.

Please see the example above.  I do believe that my algorithms are
reliably forcing proper read ordering using IPIs, just in an different
way.  Please note that I have discussed this algorithm with Alpha
architects, who believe that it is sound.

But they (and I) may well be confused.  If so, could you please
show me what I am missing?

                              Thanx, Paul

