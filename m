Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTEWAIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTEWAIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:08:05 -0400
Received: from mail.casabyte.com ([209.63.254.226]:2311 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S263459AbTEWAIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:08:00 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Nick Piggin" <piggin@cyberone.com.au>, <elladan@eskimo.com>
Cc: "Rik van Riel" <riel@imladris.surriel.com>,
       "David Woodhouse" <dwmw2@infradead.org>, <ptb@it.uc3m.es>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       <root@chaos.analogic.com>
Subject: RE: recursive spinlocks. Shoot.
Date: Thu, 22 May 2003 17:19:59 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGEEKJCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3ECC4C3A.9000903@cyberone.com.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will, hopefully, be my out-comment on this thread.

Various persons in different branches of this thread are making and
repeating various inferences they have taken from my statements as if those
were my position.  I will state my position and then let most of this drop.

But First:  At some point I dropped the spinlock focus and started talking
about locking in general.  I'll take the onus for that completely.  My Bad.
Sorry.  Now that it is in the mix, however, I will have to make it part of
the position, else there will be all sorts of "but you said here that..."
kinds of possible responses.

My Position:

1) Recursive Locking has value, it is not absolutely inherently broken, bad,
or evil as some seem to believe.

There is no a-priori "somebody messed up" absolute that can be deduced
simply because a logical structure reaches code that wants to clam a
resource that the same thread, in an outer layer of abstraction, has already
claimed.  The only time it is a-priori wrong is when the locking mechanism
is designed to self-deadlock, and it is only that self-deadlock that is
"wrong by absolute definition".

2) Any application of locking (spin or otherwise) that can be written with
recursive locking can be re-written without it.

This is nearly tautology, even if it would be NP complete to prove.  This is
also _exactly_ the iterative vs. recursive design principle.  Anything that
can be written iteratively can be written recursively and vice versa.  It is
also true that many problems exhibit an inherent bias towards one or the
other of these approaches.  Any stance, in the absence of overriding
pressure, that one of these approaches should be ruled out completely for a
program or design is detrimental to that design.  A real-world example of an
overriding pressure is the absence of a real stack on the 8051
micro-controller causes the compiler to turn recursive calls into expensive
iteration anyway.  In the kernel design there are almost no such overriding
pressures.

2a) Any application that "is correct" with self-deadlocking locks will be
semantically identical using recursive locks.

2b) Persons relying on the self-deadlock behavior of a lock (spin or
otherwise) to "detect semantic errors" in a production environment are doing
a bad thing.

This is not intended, in any way, to minimize the value of catching errors
this way during development, especially in an open source project where all
sorts of stuff is being joined together.  I think, however, that we are all
disappointed when our production systems lock up, and would prefer to have
them notice the impending problem and at least print a diagnostic.
Switching a self-deadlock spinlock for a recursive spinlock with a ceiling
of one and a linked printk or stack-trace-and-oops() would be better than a
silent lockup in a production system.  The atomic spinlock system, as it
exists today, has no sense of lock owner, and so can not tell a valid wait
from a self-deadlock in an SMP setting.  All but the most critical and
private locks could do with detection and reporting in the wild because the
kernel is subject to post-development vagaries caused by people adding
modules.

3) Any lock (spin or otherwise) that is directly related to a public
interface should be considered for recursive implementation.

This point does not even come close to an assertion that all such locks
"must" or even "should" be recursive.  It is the simple statement that the
locking policy and model for any public interface should be examined for
possible value that could be developed because of rational aggregation or
reentrancy.  That decision, having been made, should be made an express part
of the interface.

4) All locks (spin or otherwise) should obviously be held for the shortest
amount of time reasonably possible which still produces the correct result.

If this needs explaining...  8-)

5) The entity who takes a lock (programmer or code, spin or otherwise) is
responsible for knowing what he is doing when he operates on a protected
resource, and even all the non-protected resources.

This is another corollary of the fact that any entity that uses a common
anything (in life or in code) is responsible for its actions.  Locking does
not ensure proper or meaningful operations will be applied to the protected
object, it only ensures that nobody else will be getting in the way.  Any
argument that contains "what if the programmer takes a lock and then
calls/invokes something that..." is specious.  The programmer who takes a
lock and/or invokes an action, bares the responsibility for his operations
whether he wrote the code locally or not.  That's just life.

=====

I will now provide one concrete and specific example of a 2.5 kernel
facility (public interface, though not one with an _operations structure)
that should be protected by a recursive lock.  This is NOT because I have a
specific application in mind, but because I can conceive of several possible
scenarios and a related body of "overriding concern".  I don't have the code
right here to say that this is, or isn't, a spinlock per se.  Analysis of
the interface documentation and the obvious presence of "some kind of lock,
probably in spinlock kinds of time quanta" is enough.

The new workqueue, and it's associated work_struct, system "really ought to
be" recursively protected.

That is, there should be a lock_workqueue() and an unlock_workqueue() added
to the public interface, and calling queue_work(), queue_delayed_work(), and
cancel_delayed_work() (etc) should be legal exactly as they exist today
(e.g. atomically), and also legal between calls of the proposed
lock_workqueue() and unlock_workqueue() functions.

Clearly using lock_workqueue() and unlock_workqueue() against "events" (the
predefined system workqueue) should be "frowned upon", but even that should
still be legal.

The reasoning is simple.  It is almost certain, or at least far from
inconceivable, that a high-performance interface with obvious/high user
visibility (In one email I used an AGP rendering pipeline), or subsystem
significance, could find itself needing to atomically perform more than one
insert/remove/modify action on a (hopefully private) work queue.

I make no statement that this would be a "good design" but I can see cases
where it could come up.  I also hope that the reader understands that there
could be other reasonable combinations/aggregations of operations other than
the two adjacent cancel operations I cite below; the dual cancel is just a
good simple but concrete possibility.

So anyway, in the current public self-deadlocking interface, if some module
writer needed to do, say, an atomic cancel of several particular
work_struct(s), but he didn't want to flush the entire workqueue, he would
be obliged to read the implementation, take the locks himself and then
hack-apart and reassemble the workqueue's linked list in local code.

This is bad, and God help the kernel if this module is loaded into a later
kernel with a tweaked workqueue semantic.

In keeping with principle 2, it is tautological that we could turn
queue_work(), queue_delayed_work(), cancel_delayed_work() et. al. into a two
layer affair with each calling their respective queue_work_not_locked()
versions internally after having claimed the lock, then publicize the
lock/unlock_workqueue() calls and all the *_not_locked() calls for people
who need aggregation.  This, however, would then more than double the size
of the interface, damage clarity, and otherwise make things ugly and un-fun.

Another principle 2 work around would be to have a "technically not
recursive" (spin)lock and build tests into the various routines that detect
the outer lock_workqueue() activity and branch around the actual lock
attempts.  That's just recursive locking in sheep's clothing.

It is much better to let this module writer construct a sequence that looks
like: lock, cancel, cancel, (whatever), unlock; that uses the regular and
well defined top-level calls like cancel_delayed_work().

The fact is, if the lock built into the workqueue system is recursive,
persons who need to make aggregate changes to a queue in an atomic way are
provided for in an optimally useful and safe way.  It is, of course,
possible that an idiot could clog up an SMP machine by misusing this outer
lock facility improperly.  But an idiot can clog up an SMP machine by
misusing almost any (spin)lock he cares to take, so that is a push.

So here is one public interface that could stand the scrutiny and has a
fairly obvious case where recursive locking is a big win, or at least a much
bigger lose for non-recursive locking combined with a near certainty of
desirable aggregate but still short-duration activities.

The workqueue example came to mind almost instantly and I would be stunned
if a simultaneously rigorous but open minded survey didn't yield at least a
few more "fairly obvious" places where a recursive locking strategy wouldn't
pay off big-time.

==== for those who need some flesh on the example, that is all that follows
====

Disclaimer: this is given an informed lay-opinion of what happens in
graphics subsystems garnered mostly from sampling manual pages and reading
magazines.  It does, however, map to other possible problem sets, so it is
good enough for this discussion.

Consider a graphics rendering module that has a "draw mesh" ioctl/interface.
A mesh is a vector of points (list of x, y coordinates and supporting data
like color etc) that combine together to make a bunch of triangles that
share vertices with their neighbors and get drawn and filled in by the
graphics card to create a possibly-non-flat object.

Consider that each graphics card has different features and optimal and
maximum sizes for things like meshes.

Now imagine you are designing the gaming driver interface (think DirectDraw
for windows etc.)  you don't want to limit the largest mesh acceptable in
the interface definition to the smallest "largest mesh" you are likely to
encounter in the cheapest video card a user might buy.

So you build in a feature that, when a mesh is submitted to the rendering
system, it gets compared to the current card, and it the mesh is "too big"
it is cut into three parts.  (the left part, the right part, and a meta-mesh
to "zipper over" the seam between the two.)

The system is also smart enough to detect an SMP machine and launch several
high-priority kernel threads to do share the rendering.  This is, after all
for a game, where display speed is the most important thing... 8-)

So now, the game sends in a mesh, which just got carved into three (or maybe
more, but lets stick with three) pieces.

So then, the game discovers that that mesh really needs to be canceled, or
the rendering engine decides that the whole thing is behind a wall and
should just be discarded to save time, or the entire frame is going to be
canceled to make up for a network delay (etc.).  If you cancel the mesh
fragments (take them out of their work queue) piece-at-a-time you might make
an ugly mess (say if only the small "zipper" segment made it onto the
display surface) and disappoint your fans and users (both players and game
programmers).

So there you have it, some programmer focused entirely on his pretty picture
simply _must_ *selectively* cull his workqueue to get rid of all of
"mesh/frame X".

He could, and probably will, walk the workqueue himself, which is highly
undesirable from a system stability standpoint.  He doesn't really care if
he globs up the SMP CPUs to do it because they would otherwise be wasting
their cycles in the more intensive task of processing data that will never
see phosphor, and he has no choice but to ignore the published interface
"just this once" because that interface would leave him with public mud on
his face as bits leaked onto CPUs between the individual cancel operations.

I can see it happening...  pretty easily in fact...  and in all sorts of
other kinds of deferred tasking models...

I can see a recursive locking making it useful for the programmer to stick
to the public interface and therefore make the system more stable...

I could also see the manual page for lock_workqueue() having a big bold
disclaimer reading "USING THIS ROUTINE IS ALMOST ALWAYS THE WRONG THING TO
DO but..."

Rob.

