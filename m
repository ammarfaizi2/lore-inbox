Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268846AbUJMPZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268846AbUJMPZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUJMPZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:25:35 -0400
Received: from ida.rowland.org ([192.131.102.52]:8964 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S268846AbUJMPZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:25:30 -0400
Date: Wed, 13 Oct 2004 11:25:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Clemens Buchacher <drizzd@aon.at>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Questions about memory barriers
In-Reply-To: <20041013005640.GB12351@kzelldran.lan>
Message-ID: <Pine.LNX.4.44L0.0410131043460.1181-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004, Clemens Buchacher wrote:

> On Tue, Oct 12, 2004 at 10:50:01AM -0400, Alan Stern wrote:
> >  * No data-dependent reads from memory-like regions are ever reordered
> >  * over this barrier.  All reads preceding this primitive are guaranteed
> >  * to access memory (but not necessarily other CPUs' caches) before any
> >  * reads following this primitive that depend on the data return by
> >  * any of the preceding reads.
> > 
> > Taken at face value, this implies that all reads preceding 
> > read_barrier_depends are guaranteed to access memory before the barrier 
> > finishes.  Even reads whose data is not used by a subsequent read.  Is 
> > this right?
> 
> No. It only affects instructions that would not have completed before a
> subsequent (dependent) read.

Does it _affect_ those instructions, or does it simply wait until those
instructions have completed?  And how does the processor know, when it
executes the barrier, which pending reads will be depended on (and so must
be completed) and which won't?

The impression I get from what you wrote below is that the barrier
instruction causes the processor to abandon all speculative reads until
any already-issued reads have completed.  Isn't that essentially the same
as saying that no speculative (i.e., non-constant) read can be moved back
past the barrier and that the barrier won't finish until all
already-issued reads have completed (in other words, these reads can't be
moved forward past the barrier)?

> > The first code example in system.h is not informative.  It says that this
> > code sequence:
> > 
> >               q = p;
> >               read_barrier_depends();
> >               d = *q;
> > 
> > enforces ordering.  But that means nothing; the ordering is already forced 
> > by the C language definition.  After all, it's impossible for the 
> > processor to load data from *q before it knows what value is stored in q.
> 
> But it _is_ possible. The technique is called 'speculative reading' (or value
> prediction). The processor guesses the value of q and reads *q before it
> finishes the assignment to q. If it was wrong, the read has to be repeated. But
> there is a chance that the stall can be avoided.

> It has nothing to do with the programming language. Of course data dependencies
> have to be respected. But while the processor ensures data consistency of the
> program it is running, instruction reordering can have undesired effects when
> data is shared with programs running on other processors.
> 
> Let's analyze the example from include/asm-i386/system.h:
> 
>  * For example, the following code would force ordering (the initial
>  * value of "a" is zero, "b" is one, and "p" is "&a"):
>  *
>  * <programlisting>
>  *      CPU 0                           CPU 1
>  *
>  *      b = 2;
>  *      memory_barrier();
>  *      p = &b;                         q = p;
>  *                                      read_barrier_depends();
>  *                                      d = *q;
>  * </programlisting> 
> 
> The memory_barrier() on CPU 0 ensures that if p points to b, b already has the
> value 2 and not its original value 1 any more. So if q is assigned the value p
> on CPU 1, it subsequently points to either a (which is still zero) or to b, in
> which case we would expect *q to give the value 2.
> 
> If, on the other hand read_barrier_depends() was not there, the processor could
> try to predict the value of q and read *q before p is assigned to q. Consider
> the following case (actual order of execution):
> 
>         CPU 0                   CPU 1
> 
>                                 d = *q; // predict q to become pointer to b
>         b = 2;
>         memory_barrier();       [ ... other instructions ... ]
>         p = &b;
>                                 q = p;  // q points to b, prediction
>                                         // turns out to be correct
> 
> Now d suddenly has the value 1, even though p never pointed to a variable
> holding that value!

Okay, I get it.  The example would be even clearer if you stipulate that 
initially q = &b; that would give the CPU a good reason for speculatively 
fetching the value of b.

This seems like a devilishly easy sort of thing to overlook!

Alan Stern

