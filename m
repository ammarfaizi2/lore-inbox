Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTEVC6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 22:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTEVC6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 22:58:41 -0400
Received: from mail.casabyte.com ([209.63.254.226]:30734 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262459AbTEVC6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 22:58:35 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Rik van Riel" <riel@imladris.surriel.com>
Cc: "David Woodhouse" <dwmw2@infradead.org>, <ptb@it.uc3m.es>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
Date: Wed, 21 May 2003 20:11:14 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGMEIICMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.50L.0305212059500.6321-100000@imladris.surriel.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Rik van Riel [mailto:riel@surriel.com]On Behalf Of Rik van Riel

> So call_EE_ messes with the data structure which call_ER_
> has locked, unexpectedly because the recursive locking
> doesn't show up as an error.

Yes and no.  It all hinges on that nonsensical use of "unexpectedly".

(I'll be using fully abstract examples from here on out to prevent the
function call police from busting me again on a technicality... 8-)

call_EE_ is an operator invoked by call_ER_, call_ER_ is changing the
protected structure/data/state call_ER_ locked by invoking call_EE_ against
it.  Nothing "unexpected" has happened because call_ER_ invoked call_EE_ for
a reason and with the expectation that call_EE_ would do whatever it is
designed to do.  Invoking call_EE_ is an imperative command to "mess with
the structure" if that is what call_EE_ is supposed to be doing.  When you
call atomic_inc(something) you expect something to be "messed with" in a
particular way.  Is the fact that "something" got bigger by one "an error"?
Nope.  How about if it precision wrapped to zero?  Probably not, but if it
is, that is a larger semantic problem, not a problem with atomic_int() or
your use thereof.  Whenever anybody holds a lock they are expected to
understand what the operations they invoke will do to the protected
resource.  The fact that the operator asserts nested ownership for the
duration of its nested operation is mathematically provable as a non-issue.
If you don't know what an operator is going to do, you shouldn't be invoking
it in the kernel in the first place.  (or anywhere else for that matter. 8-)
If an operator does something it isn't supposed to do, the operator is
broken by any and every measure regardless of locking.

How hard is this to understand?

(Looking back at "my original message" in this thread I exactly cede the
point that what recursive locking give you on the well-behaved interface end
it can take back from you on the lazy and/or stupid programmer end.)

We already demand that the programmer who uses any operation inside the
kernel understand the requirements and dangers of that operation.  It is
implicit that if you play with some pointer protected by a lock you are
going to lock it, and unlock it, and not trash it etc.  That is already a
covenant inside the walls of the kernel.

Holding a lock nets you a guarantee that "only the operations you invoke
will change the protected data". The fact that some of those operations
might be function calls is a given.  The recursive lock concept adds exactly
one "new feature", with recursive locks, you can call functions that
themselves contain sections that want to make that same assertion.  Without
recursive locks you are instantly barred from calling an existing function
(that presumably exists for its own rights a purposes) that does exactly
what you need to do, if that function itself wants to make sure that only it
is changing the protected data.

How much sense does that make as a restriction?  "You cannot call that
function, it demands exclusive access to the data you have already claimed
for the express purpose of modifying via function call(s)."  That is like
getting your car towed away because didn't move it after the police put a
boot on the wheel.

That is actually the whole thing.  As it is today, if a move (of a file)
were implemented as a link and an unlink, (and if those two routines needed
to lock something which I am informed they do not 8-], and you were
implementing the move after-the-fact for some reason) then the move function
would have to be a copy of link and unlink function text now living in a new
third function with the locking rearranged.  But now we are maintaining two
essentially identical copy of the code for links and unlinks. (or you would
move the locks out of the "real" unlink and link and wrapper them with ...
etc, od nausium, amen 8-)

When you take the steps to allow aggregation across/around an interface you
(just as you do today) define what any given routine is supposed to do and
what it will/should dirty.  If the implementers of the "inside" of the
interface (e.g. the guy who filled in the file_operations structure in his
driver) does his job then the code has a well defined behavior.  It is
expected that "whangle_inode_list" will "whangle" the inode list, whatever
"whangle" means in this usage.

The value of the recursive lock is that it lets the guy who comes along
later work completely within the clearly defined set of sub-operations.
That is, that programmer can know, if he has claimed the inode list lock,
that the only entity who "whangled" it was the entity he called, and if
there was another operator on the list "bojum", if he never called
"bojum_inode_list" then bojum didn't happen, or if it did, it happened in
the course of the explicitly invoked whangle.  This knowledge exists
independently of whangle's need to make sure that nobody bojum(s) while the
whangle is taking place.

At the aggregation level it would be "dumb" to something like

boo()
{
  lock_thingy;
  void* X = fetch_internal_thingy_pointer();
  some_thingy_operations->whangle();
  tingy_use_without_revalidation(X);
  unlock_thingy;
}

without the sure and simple knowledge that whangle() will not invalidate X.
But this is no more difficult a mental leap than knowing whether or not
free(X) will invalidate X.

If you "know" X can not be invalidated by any "legal" whangle() then this
code is okay, and can be used with every possible some_thingy_operations
structure.  If you don't know this, then this is bad code.

The thing is, by defining the thingy_operations standard, and including the
fact that lock_thingy protects certain data and states, and "whangle" never
"bojums" (or whatever assertions we can or cant make for "any thingy") then
we have clearly defined an interface.

An other programmer, before or after the creation of any given thingy driver
could, if he needs an "atomic" operation "snark" that is a whangle, a bojum,
and another whangle in that specific order with no exposure to others trying
to whangle, bojum, or snark, could easily write snark.  Without recursive
locking "snark" would have to look like

snark() {
  some_thingy->whangle()
  some_thingy->bojum()
  some_thingy->whangle()
}

but this snark would not be atomic, it doesn't lock anything.  If each
operation is done inside a "hopefully minimum" unlock, the danger is still
very real.

snark() { // meaningless snark
  lock_thingy;
  unlock_thingy; thingy->whangle(); lock_thingy;
  unlock_thingy; thingy->bojum(); lock_thingy;
  unlock_thingy; thingy->whangle(); lock_thingy;
  unlock_thingy;
}

Clearly if snark is at a higher level of abstraction from whangle and bojum,
and snarks are mutually exclusive, then we can just put in a snark_lock.
But really if we "want to" lock thingy(s) individually instead of blocking
all snarks what really are the alternatives to recursive locking?

In fact, placing the entire onus on the aggregators to properly use their
parts (operators and function calls) and be wary of side effects, places
that onus exactly where it belongs.  Someone capable of composing the
abstraction is not likely to be tripped up by it.

We know that "reading a file moves the read pointer" and so forth.  If
someone implements a set of operations in a thingy_operations struct that
pisses all over things it shouldn't be touching, that person is to blame for
their bad code.  If someone else using a thingy_operations struct does so
without a care as to what the operations do, then they are to blame.  This
is actually no more complex than knowing that if I atomic_inc(some_value),
its going to "get larger", with the caveat of zero-wrap hanging over my
head.

There will always be the cases where some particular aggregation is not now
safe and never will be.  An example from before, if the deltafs (unionfs?)
were to try to mount the same device as the front and base elementary file
systems they would be doomed to failure.

Aggregate use is invaluable, but it also requires as much understanding of
programming in this kind of environment as anything else.  It also allows
for the construction of some incredible dependencies "at runtime" and a
proper aggregate entity should be ready to deal with that.  These are not
insurmountable, but they are real costs.  You can't protect everyone from
themselves.

The win is that, for the deltafs example, if you never violate your
constituent components interfaces (e.g. the etx3 front-side file system
semantics and data), you can co-own their elements and make "bigger
promises" "for free" by leveraging the mature code.

A well defined interface with recursive locks is no more difficult to
maintain  and generally exist within, than a well designed interface with
self-deadlocking locks, it just has more "depth" (if you will forgive the
quasi-pun) because of the opportunities for aggregation.

Both beat the hell out of an interface definition that has to have all its
code "fixed" because a lock needs to move from "callers responsibility" to
"callees responsibility" or vice-versa in the next version.

This stuff is much clearer at the application level.  Make an MT-Safe Deque
template that can work "over" both an MT-Safe List.  The locking needs to be
promoted to the Deque.  If you want to view the contents as both the Deque
and the List then the locking can't be in both separately, nor can it be in
just one (gets obscure, but has to do with the "wait for object" nature of a
Deque not being part of a List).  If the locks are recursive, the Deque can
be implemented without private access to the list's naughty bits.  User
calls Deque->Push which calls List->PutOnTail the lock is set twice, the
end.  View as list, view as deque, it all works.  When you add the "wait for
object" version of Pop, List isn't suddenly considered broken, but it is
completely up to the writer of Deque to do what is necessary.  There is some
magic to wrapping a recursive structure around posix_mutex to yield a
recursive entity that is useful with a posix_condition, but that is a
totally different post.  8-)

The point it, you *can* and indeed *must* apportion responsibility with any
public interface anyway, so using recursive locking in a public interface
adds far more than it costs.

Rob.

PS and again, I am not advocating that every lock "must be" recursive, just
the ones tied to public interfaces (say, those expected to be used by
functions named in any legal module _operations struct) need to be
considered for recursion.  Clearly the per-CPU locks and such are not
candidates for recursion.  There is a distinction to be made, and refusing
the value of recursive locking is not making a distinction, it is clapping
ones ears to ones head and dancing about under the assumption that since it
isn't right in some instances it is wrong in all instances.

