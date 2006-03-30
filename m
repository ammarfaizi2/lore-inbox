Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWC3WB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWC3WB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWC3WB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:01:57 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43701 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751036AbWC3WB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:01:56 -0500
Date: Thu, 30 Mar 2006 17:01:55 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Howells <dhowells@redhat.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #6]
Message-ID: <Pine.LNX.4.44L0.0603301657410.4652-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David:

I've got some comments inspired by the data-dependency sections of your
memory-barrier document.

Consider this part (under WHAT ARE MEMORY BARRIERS?):

+Memory barriers ...
...  request that the sequence of memory events generated appears to other
+parts of the system as if the barrier is effective on that CPU.

Also take this paragraph (under VARIETIES OF MEMORY BARRIER):

+     A write memory barrier gives a guarantee that all the STORE operations
+     specified before the barrier will appear to happen before all the STORE
+     operations specified after the barrier with respect to the other
+     components of the system.

Now compare those two to this part (under DATA DEPENDENCY BARRIERS):

+	CPU 1		CPU 2
+	===============	===============
+	{ A == 1, B == 2, C = 3, P == &A, Q == &C }
+	B = 4;
+	<write barrier>
+	P = &B
+			Q = P;
+			D = *Q;
+
+There's a clear data dependency here, and it would seem that by the end of the
+sequence, Q must be either &A or &B, and that:
+
+	(Q == &A) implies (D == 1)
+	(Q == &B) implies (D == 4)
+
+But! CPU 2's perception of P may be updated _before_ its perception of B, thus
+leading to the following situation:
+
+	(Q == &B) and (D == 2) ????

This contradicts the earlier text.  If the write barrier functions as
advertised, then it _must_ appear to CPU 2 that B was updated before P
was.  If not then the guarantee has been violated.

It may be that the earlier parts of the text are oversimplified.  For
instance, perhaps the write barrier on CPU 1 insures that the writes
are perceived in the correct order by CPU 2's cache (or caches) but
not necessarily by CPU 2 itself.  In other words, the ordering
perception guarantees made by memory barriers _don't_ apply with
respect to all the other components of the system, but only with
respect to some of them.

In fact, wouldn't it be better to say that the ordering provided by a
write barrier applies only to other CPUs that use an appropriate read
barrier?  Certainly it doesn't apply to the actual data on the bus,
and it's not clear whether it applies to other bus masters (devices).

Or to put it another way, the only guarantee made by memory barriers
is that when the following sequence occurs:

	CPU 1			CPU 2
	===============		===============
	store X			load Y
	<write barrier>		<read barrier>
	store Y			load X

then CPU 2 won't obtain the old value of X and the new value of Y.  Is
there really any more functionality to memory barriers than just this?

(Hmmm...  What about when this occurs:

	CPU 1			CPU 2
	===============		===============
	store A in X		store B in Y
	<write barrier>		<write barrier>
	store C in Y		store D in X

What can be said in this case?  Is there any guarantee that the final
values in memory won't end up being X == A and Y == B?)

You might also want to clarify the notion of a control dependency
versus a data dependency.  I gather that the basic idea goes something
like this: Some CPUs aren't good at tracking all possible
dependencies.  For instance, while they might realize that "mov X to
Y" means Y is dependent on X, they might not realize that "mov X to Y
if Z is 0" means Y is also dependent on Z.  It's best to assume that
anything other than a straight-line value-type dependency is too
subtle for all processors to recognize.

Alan Stern

