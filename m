Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWCaVBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWCaVBs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWCaVBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:01:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:61148 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932207AbWCaVBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:01:48 -0500
Date: Fri, 31 Mar 2006 16:01:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Howells <dhowells@redhat.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #7] 
In-Reply-To: <7739.1143818524@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44L0.0603311551340.5091-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, David Howells wrote:

> Thanks for that, but can you reconsider your comments in terms of the [try #7]
> I've just released?  That stuff has changed a fair amount.

Here you go...


Comment #1:  Under GUARANTEES, the first item says:

+ (*) On any given CPU, dependent memory accesses will be issued in order, with
+     respect to itself.  This means that for:
+
+	Q = P; D = *Q;
+
+     the CPU will issue the following memory operations:
+
+	Q = LOAD P, D = LOAD *Q
+
+     and always in that order.

This is not true for CPUs that indulge in speculative loads.  Such a
processor might do this:

	X = LOAD A, Q = LOAD P, if (Q == A) then D = X else D = LOAD *Q

where A is an address the processor had some reason for trying out and
X is an internal register.  The final effect is the same, of course,
but the actual sequence of memory operations is different.  Perhaps
what you really wanted to say here is that (in the absence of
interference from other CPUs or devices) D will always get the value
in *P, not the value that Q pointed at before the first assignment.


Comment #2:  Your writeup doesn't always make it clear that data
dependency barriers are a _lightweight_ form of read barriers.  When
one needs to enforce proper ordering of two reads that have a data
dependency one can use either type of barrier, but a data dependency
barrier will impose less overhead on execution speed.  On most
architectures it imposes no overhead at all, whereas a read barrier
can cause a significant pipeline stall.

So for example, under VARIETIES OF MEMORY BARRIERS, part (2), you
write:

+     A data dependency barrier is a weaker form of read barrier.  In the case
+     where two loads are performed such that the second depends on the result
+     of the first (eg: the first load retrieves the address to which the second
+     load will be directed), a data dependency barrier would be required to
+     make sure that the target of the second load is updated before the address
+     obtained by the first load is accessed.

You shouldn't say a data dependency barrier "would be required"; you
should say it "would suffice".  Similar examples occur later, in the
DATA DEPENDENCY BARRIERS section.  You write:

+To deal with this, a data dependency barrier must be inserted between the
+address load and the data load:

Again, any form of read barrier would work; a data dependency barrier
is simply the best choice.


Comment #3:  Your description of how memory barriers work in general
terms isn't very satisfying.  Under WHAT ARE MEMORY BARRIERS? you say:

+They request that the sequence of memory events generated appears to other
+parts of the system as if the barrier is effective on that CPU.

But then later on it turns out that the sequence of memory events
doesn't have to appear that way on the bus.  And it might not appear
that way to devices using memory-mapped I/O.  And it might not appear
that way to other CPUs if they have split caches.  (And if the other
CPUs do speculative loads or speculative branch prediction, it doesn't
matter how the sequence appears to them anyway.)  It's hard to tell
which other parts of the system _do_ see the barrier's effect.  By the
time all these caveats and exceptions are factored in, it's far from
clear that memory barriers do anything at all!

A better approach IMHO would be to provide a programmer's-eye-view of
what barriers can accomplish.  A pragmatic approach that does not try
to explain what's going on behind the scenes.

Here's what this would amount to for the most common usage of memory
barriers:

	CPU 1			CPU 2
	===============		===============
		{X = 1, Y = 2}
	store 3 in X		load Y
	<write barrier>		<read barrier>
	store 4 in Y		load X

In this situation, the barriers guarantee that CPU 2 will not end up
seeing X == 1 && Y == 4.  This is pretty much _all_ that read barriers
do.

Another aspect involves write/write interactions.  Consider this scenario:

	CPU 1			CPU 2
	===============		===============
	store 1 in X		store 2 in Y
	<write barrier>		<write barrier>
	store 3 in Y		store 4 in X

Is it guaranteed that the final values in memory won't end up being
X == 1 && Y == 2?  I don't know, and from your document it's hard to
tell.  In practice barriers are not often used this way, anyhow.

A similar bottom-line description can be given for the permeable sorts
of barriers provided by the locking mechanisms.  Suppose that
initially X = 1 and Y = 2.  Suppose that CPU 1 follows any of these
four procedures:

	CPU 1		CPU 1		CPU 1		CPU 1
	============	============	============	============
	LOCK L		store 3 in X	store 3 in X	LOCK L
	store 3 in X	LOCK L		LOCK L		store 3 in X
	store 4 in Y	store 4 in Y	UNLOCK L	UNLOCK L
	UNLOCK L	UNLOCK L	store 4 in Y	store 4 in Y

(in other words, X is written before the UNLOCK and Y is written after
the LOCK).  Finally, suppose that CPU 2 follows any of these four
procedures:

	CPU 2		CPU 2		CPU 2		CPU 2
	============	============	============	============
	LOCK L		load Y		load Y		LOCK L
	load Y		LOCK L		LOCK L		load Y
	load X		load X		UNLOCK L	UNLOCK L
	UNLOCK L	UNLOCK L	load X		load X

(in other words, Y is read before the UNLOCK and X is read after the
LOCK).  Then the lock's implicit barrier guarantees that CPU 2 won't
end up seeing X == 1 && Y == 4.  Of course, the first possibility in
each row is the one that occurs most frequently.

(Variants of these procedures in which CPU 1 stores X and loads Y
while CPU 2 loads X and stores Y -- as in the next comment -- also
apply, since the lock's barriers are general, albeit permeable.)


Comment #4:  Your description of general memory barriers omits an
important point.  You say:

+     A general memory barrier is a combination of both a read memory barrier
+     and a write memory barrier.  It is a partial ordering over both loads and
+     stores.

A general barrier is more than a combination of a read barrier and a
write barrier.  Such a combination would guarantee only that all reads
before the barrier will complete before any reads after, and all
writes before the barrier will complete before any writes after.  But
in fact a general memory barrier also guarantees that all reads before
the barrier will complete before any writes after, and all writes
before the barrier will complete before any reads after.

This can be expressed in the programmer'-eye-view as follows:

	CPU 1			CPU 2
	===============		===============
		{X = 1, Y = 2}
	store 3 in X		store 4 in Y
	<general barrier>	<general barrier>
	load Y			load X

won't end up with CPU 1 seeing Y == 2 and CPU 2 seeing X == 1.  Also

	CPU 1			CPU 2
	===============		===============
		{X = 1, Y = 2}
	load Y			load X
	<general barrier>	<general barrier>
	store 3 in X		store 4 in Y

won't end up with CPU 1 seeing Y == 4 and CPU 2 seeing X == 3.  I can't
think of any other guarantees made by general memory barriers beyond
these two (together with guarantees listed above for read and write
barriers, since a general barrier can be used in place of either).


Comment #5:  You might want to clarify the notion of a control
dependency versus a data dependency.  I gather that the basic idea
goes something like this: Some CPUs aren't good at tracking all
possible dependencies.  For instance, while they realize that "mov X
to Y" means Y is dependent on X, they might not realize that "mov X to
Y if Z is 0" means Y is also dependent on Z.  Or they might not
realize that "jmp if Z is 0" means that all following operations are
dependent on Z.

Given these failings, it's best to assume that anything other than a
straight-line value-type dependency is too subtle for all processors
to recognize.  For such situations a full read barrier should be used
rather than a data dependency barrier.

Alan Stern

