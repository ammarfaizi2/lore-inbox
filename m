Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTEXCbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 22:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTEXCbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 22:31:31 -0400
Received: from mail.casabyte.com ([209.63.254.226]:13327 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261874AbTEXCb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 22:31:28 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "William Lee Irwin III" <wli@holomorphy.com>,
       "Nikita Danilov" <Nikita@Namesys.COM>
Cc: "Nick Piggin" <piggin@cyberone.com.au>, <elladan@eskimo.com>,
       "Rik van Riel" <riel@imladris.surriel.com>,
       "David Woodhouse" <dwmw2@infradead.org>, <ptb@it.uc3m.es>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       <root@chaos.analogic.com>
Subject: RE: recursive spinlocks. Shoot.
Date: Fri, 23 May 2003 19:39:08 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGMEMJCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030523121838.GY8978@holomorphy.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William's comment below, and its direct ancestor from Nikita, seem to
support the recursive locking approach to the locking (of some) resources.
I didn't go into number 4 myself because I was (rightly) sure that the terms
"shortest amount of time reasonably possible" and "correct result" would be
points of contention.

If Nikita's case 1 is indeed "better" on an SMP system (I take no official
position, even though one could be easily deduced from the sum of my
previous arguments... 8-)

> spin_lock(&lock);
> list_for_each_entry(item, ...) {
>   do something with item;
> }
> spin_unlock(&lock);

and case 2 is "worse"

> list_for_each_entry(item, ...) {
>   spin_lock(&lock);
>   do something with item;
>   spin_unlock(&lock);
> }

and since each workqueue primitive op is essentially:

workqueue_op() {
  lock_workqueue()
  perform_actual_primitive_op()
  unlock_workqueue()
}

Then the existing solution of calling several workqueue operations as they
exist today (provable by induction) always decompose to case 2.

Calling just one workqueue_op is nominally case 1 (and indistinguishable
from case 2 when the list-length is 1).

So the existing model, for successive (aggregate) workqueue ops greater than
one nets the SMP unfriendly and non-optimal result described in case 2.
(ignoring, for now, the ratio of locked to unlocked instructions in each
particular primitive)

IF, however, an aggregator knows he is going to do several ops in succession
(and wants the aggregation to be atomic) and takes the recursive lock in an
outer context manually, then the event stream:

lock_wokrqueue()
list_for_each_entry(item...) {
  some_workque_op(current_item)
}
unlock_workqueue()

by induction actually becomes:

lock_wokrqueue()
list_for_each_entry(item...) {
  lock_workqueue(); // Factoring point
  perform_actual_primitive_op();
  unlock_workqueue();  // Factoring point
}
unlock_workqueue();

At the marked "factoring points" the code is effectively reduced from taking
a lock to something like "if owner == me then increment/decrement
lock_depth" because the ownership is tautological at all factoring points.
(As is the presence of the lock data in the cache etc(?).  But even if
everything is inline the compiler probably still can't get rid of the test
because the parts of the lock are almost certainly declared volatile.)

This leads to a couple of questions (not rhetorical, I genuinely don't
know): (and answers probably very by platform)

1) Does the barrier() and test_and_set() operators (e.g. xchgb on an x86),
when executed on the non-lock-owner CPU(s) invalidate the relevant cache
element(s) of the CPU that owns the lock?

If not

2) Do we care that (in a recursive lock) the alterations of the "depth"
value will invalidate the cache elements of the non-owner CPU(s) that are
waiting for the lock to free up (given that the final unlock will commit at
least one such invalidate anyway)?

If the answer (to #1) is that the owning CPUs cache is not invalidated by a
competitors active competition, then recursive locking is extremely cheap
even if the compiler can't get rid of the conditional.

regardless (and this one is a little rhetorical 8-)

3) Does the always-evaluated conditional (owner == me) and its associated
low-level jump/branch impose sufficient unacceptable cost compared to the
complexity of the actual protected operations on the proposed public
interface(s) to justify always forcing the case-2 model? (e.g. most
manhandle_workqueue operations in the example are way more complex than the
cost of the ever-evaluated conditional.)

and of course, for any considered public interface:

4) Do the primitive operations of each/any considered interface perform most
of their task (over the domain of time) with the lock held or released?

5) For a particular interface, does the flexibility of a recursive lock
outweigh the probability of someone coding each/any stupid error and/or the
costs of adding the code to prevent same?

That is, for any public interface that is selected for recursive locking
there will always be some set of primitive operations which can't *ever*
make sense when aggregated (invoked with the lock held in the aggregating
context).  In the case of the workqueue example, if you take the lock and
then call the wait-for-workqueue-to-empty-itself call, you will wait forever
because no CPU can take a task off of the queue 'cause it's locked...  And
as obvious as that may be to most people, there are going to be people out
there making those kinds of mistakes.  The follow-on decision to add
check-primitives to various attractive nuisances is non free.

Rob.

-----Original Message-----
From: William Lee Irwin III [mailto:wli@holomorphy.com]
Sent: Friday, May 23, 2003 5:19 AM
To: Nikita Danilov
Cc: Robert White; Nick Piggin; elladan@eskimo.com; Rik van Riel; David
Woodhouse; ptb@it.uc3m.es; Martin J. Bligh;
linux-kernel@vger.kernel.org; root@chaos.analogic.com
Subject: Re: recursive spinlocks. Shoot.


On Fri, May 23, 2003 at 11:22:11AM +0400, Nikita Danilov wrote:
> and suppose they both are equally correct. Now, in (2) total amount of
> time &lock is held is smaller than in (1), but (2) will usually perform
> worse on SMP, because:
> . spin_lock() is an optimization barrier
> . taking even un-contended spin lock is an expensive operation, because
> of the cache coherency issues.

All good. Also, the arrival rate (i.e. frequency of lock acquisition)
is more important to lock contention than hold time, so they're actually
not being as friendly to big SMP as the comment from Robert White would
suggest. The arrival rate tends to be O(cpus) since whatever codepath
pounds on a lock on one cpu can be executed on all simultaneously.


-- wli

