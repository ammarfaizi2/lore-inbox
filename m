Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUJMAyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUJMAyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUJMAyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:54:50 -0400
Received: from lehre.fh-hagenberg.at ([193.170.124.119]:32658 "EHLO
	postfix.fhs-hagenberg.ac.at") by vger.kernel.org with ESMTP
	id S268134AbUJMAxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:53:40 -0400
Date: Wed, 13 Oct 2004 02:56:40 +0200
From: Clemens Buchacher <drizzd@aon.at>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Questions about memory barriers
Message-ID: <20041013005640.GB12351@kzelldran.lan>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0410121015480.1173-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0410121015480.1173-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 13 Oct 2004 00:53:34.0504 (UTC) FILETIME=[1114E280:01C4B0BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 10:50:01AM -0400, Alan Stern wrote:
>  * No data-dependent reads from memory-like regions are ever reordered
>  * over this barrier.  All reads preceding this primitive are guaranteed
>  * to access memory (but not necessarily other CPUs' caches) before any
>  * reads following this primitive that depend on the data return by
>  * any of the preceding reads.
> 
> Taken at face value, this implies that all reads preceding 
> read_barrier_depends are guaranteed to access memory before the barrier 
> finishes.  Even reads whose data is not used by a subsequent read.  Is 
> this right?

No. It only affects instructions that would not have completed before a
subsequent (dependent) read.

> Furthermore, the text's distinction of reads "that depend on the data
> return[ed] by any of the preceding reads" is nearly meaningless.  Almost
> any read from a non-constant location could fall into that category.  
> Consider this example:
> 
>       q = p;
>       <... millions of instructions ...>
>       read_barrier_depends();
>       d = *q;
> 
> How is the processor supposed to remember whether or not the value of q 
> depends on the earlier read of p?  Obviously it can't, so it must assume
> that such a dependency exists.  Only if q had very recently been assigned 
> a constant value would the processor know otherwise.

Exactly. And only these recent assignments, i.e. incomplete assignments, are
relevant to instruction reordering anyway. The processor cannot reorder
instructions for which execution is already over. It can move the instruction
in front of the barrier, but not in front of read instructions it depends on.

> The first code example in system.h is not informative.  It says that this
> code sequence:
> 
>               q = p;
>               read_barrier_depends();
>               d = *q;
> 
> enforces ordering.  But that means nothing; the ordering is already forced 
> by the C language definition.  After all, it's impossible for the 
> processor to load data from *q before it knows what value is stored in q.

But it _is_ possible. The technique is called 'speculative reading' (or value
prediction). The processor guesses the value of q and reads *q before it
finishes the assignment to q. If it was wrong, the read has to be repeated. But
there is a chance that the stall can be avoided.

> The other code example says that
> 
>               y = b;
>               read_barrier_depends();
>               x = a;
> 
> enforces nothing since there is no dependency between the read of "b" and
> the read of "a".  But the other documentation doesn't require such a
> dependency to exist; it only requires that the read of "a" depends on data
> from a previous read -- which is quite likely unless "a" is a statically
> allocated variable.  Was that the intention?  It's not clear; the example 
> seems to imply that read_barrier_depends enforces ordering only in 
> situations where the C language already enforces it.

It has nothing to do with the programming language. Of course data dependencies
have to be respected. But while the processor ensures data consistency of the
program it is running, instruction reordering can have undesired effects when
data is shared with programs running on other processors.

Let's analyze the example from include/asm-i386/system.h:

 * For example, the following code would force ordering (the initial
 * value of "a" is zero, "b" is one, and "p" is "&a"):
 *
 * <programlisting>
 *      CPU 0                           CPU 1
 *
 *      b = 2;
 *      memory_barrier();
 *      p = &b;                         q = p;
 *                                      read_barrier_depends();
 *                                      d = *q;
 * </programlisting> 

The memory_barrier() on CPU 0 ensures that if p points to b, b already has the
value 2 and not its original value 1 any more. So if q is assigned the value p
on CPU 1, it subsequently points to either a (which is still zero) or to b, in
which case we would expect *q to give the value 2.

If, on the other hand read_barrier_depends() was not there, the processor could
try to predict the value of q and read *q before p is assigned to q. Consider
the following case (actual order of execution):

        CPU 0                   CPU 1

                                d = *q; // predict q to become pointer to b
        b = 2;
        memory_barrier();       [ ... other instructions ... ]
        p = &b;
                                q = p;  // q points to b, prediction
                                        // turns out to be correct

Now d suddenly has the value 1, even though p never pointed to a variable
holding that value!

Clemens
