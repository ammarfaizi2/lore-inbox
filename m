Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTETV3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 17:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbTETV3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 17:29:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261230AbTETV3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 17:29:16 -0400
Date: Tue, 20 May 2003 17:42:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert White <rwhite@casabyte.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGKEGCCMAA.rwhite@casabyte.com>
Message-ID: <Pine.LNX.4.53.0305201709440.1074@chaos>
References: <PEEPIDHAKMCGHDBJLHKGKEGCCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, Robert White wrote:

>
>
> -----Original Message-----
> From: Richard B. Johnson [mailto:root@chaos.analogic.com]
> Sent: Tuesday, May 20, 2003 5:23 AM
> To: Helge Hafting
>
> > Recursive locking is a misnomer. It does during run-time that which
> > should have been done during design-time. In fact, there cannot
> > be any recursion associated with locking. A locking mechanism that
> > allows reentry or recursion is defective, both in design, and
> > implementation.
>
> Amusing... but false...
>
> A lock serves, and is defined by, exactly _ONE_ trait.  A lock asserts and
> guarantees exclusive access to a domain (group of data or resources etc).
>

The "ONE" trait is incorrect.

The lock must guarantee that recursion is not allowed. Or to put
it more bluntly, the lock must result in a single thread of execution
through the locked object.


> There is nothing inherently "one deep" about that assertion.
> (Philosophically stated:)  If I say "I own this car for the next hour" and
> ten minutes later say "I am taking the car to the store for twenty minutes"
> there is no "violation of truth" to the two assertions.  The outer hour and
> the inner twenty minutes are in no form of conflict.  Further, since there
> promise of the first assertion is _*NOT*_ that the car will be free for use
> after an hour, if the twenty minutes of the second assertion begins at the
> 58 minute mark of the sort-of-enclosing hour, thus extending the hour, you
> are still ok.
>

Yes there is, in your example above after being granted access to
the "car", you start its trip to the store, but in the process you
decide to get another "permission" to use the car. The second permission
is invalid because somebody already has been granted exclusive use
of the car. If you don't already know that, then you will spend the
weekend in jail for a DUI.

> More mathematically, if I write an operation "X" that, say, needs exclusive
> access to the dircache for some portion of its execution, for correctness I
> should lock that dircache.  Say I write a second operation "Y" that also
> needs the dircache, and locks it appropriately.  If someone wants/needs to
> create an operation "Alpha" that contains a number of sub operations
> including X and Y, but needs to ensure the consistency of the dircache for a
> range (of time/operations) larger than X, Y and the any number of operations
> "n" what is to be done.
>
> With your artificial definition of locking, the implementer of Alpha must do
> one of the following:
>
> 1) Separately reimplement (copy) X and Y without locking, so that the lock
> may be held by Alpha.
>
> 2) Restructure X and Y into X', X, Y', and Y such that all public uses of X
> and Y remain unchanged, but X and Y are now locking wrappers around X' and
> Y' so that X' and Y' may be used within Alpha.
>
> 3) (Multiply) Move the locks out of X and Y into all instances of
> invocations of X and Y so that Alpha has equal and unimpeded access to X an
> Y that is "identical" to every (now revised) use of X and Y.
>
> *ALL* of the above alternatives are wrong.  At no time should a stable
> operation "O" need to be recoded or restructured to be rationally used in an
> enclosing operation Alpha.
>

You are not making any sense at all. If X needs to see the identical
results of Y, while the cache is locked, then only one lock need exist
and that lock may provide one of the following:

(1)  Either access to data before modification, i.e., before the
lock or..
(2)  Access to data after modification, i.e., after the lock...
Both for X, Y, respectively, for all of N.


> In point of fact, if the lock used in X, Y, and Alpha are, by default,
> recursive, Alpha can be coded as needed without having to revisit any of the
> operations that Alpha invokes.  The implementer of Alpha "probably ought to"
> know what X and Y and all instances of "n" do and examine need to pre-claim
> locks to prevent internal deadlock as that is more expedient than making
> sure that X, Y and "n" all have proper anti-deadlock back-offs.
>

It is not fact so there is no point to the argument. If a lock cannot
retain the state of a locked object, and prevent it from being modifed
out-of-order, then the lock isn't a lock at all. It may be an invention
that may have some use (somewhere), but it is not a lock.

> There is no rational argument against recursive locking that can justify any
> system where the creation of an outer operation should view the pathological
> restructuring of existent component operations as "the right thing to do".
>
> If you think this doesn't happen, I point you do the documentation on the
> VFS and the various notations about locks having moved in and out of
> operations.
>
> The simple truth is that your statement:
>
> > The nature of a lock is required to be such that if the locked object
> > is in use, no access to that object is allowed.
>
> is PURE FANTASY and logically junct.  Correctly stated:
>

No. It is correct.

> The nature of a lock is required to be such that, if the locked object is in
> use, no COMPETING OR OUT OF THREAD/BAND access to that object is allowed.
>

You just "invented" something that is not a lock. It is some kind
of procedure that keeps records of access and allows or disallows
access to an object based upon some knowledge of the locked resource
and policy.

> A recursive lock would "protect" accesses that are IN BAND and thus
> completely allowed.  Period.
>

This policy will usually be unknown at compile-time, and would
require some kind of knowledge base at run-time. For instance,
one could not just allow the same PID access to the same object
because, even with threads, there will be a different PID for
every attempt at access unless there is a coding error that lets
the locker of a shared resource lock the same resource again --
and this is a coding error for which there can be no justification
whatsoever.

> > Recursive locking
> > implies that if the lock is in use by the same thread that locked
> > it before, then access to that object is allowed.
>
> The statement above is logically useless to your argument, that is, if the
> words "recursive locking" were replaced with the word "this" or indeed "any
> lock", the statement remains tautological.  "(This/Any lock) implies that if
> the lock is in use by the same thread that locked it (before/previously)
> then access to that object is allowed."  See how nicely true that is?
>

It is obvious that you have some kind of adgenda that attempts
to justify some poor coding methods with some illogical logic.

> > In other words,
> > if the coder (as opposed to designer) screwed up, the locking
> > mechanism will allow it. If this is the way students are being
> > taught to write code at the present time, all software will
> > be moved off-shore in the not too distant future. There is
> > absolutely no possible justification for such garbage. Just
> > because some idiot wrote an article and got it published,
> > doesn't mean this diatribe has any value at all.
>
> Your assertions do nothing to address how the coder of "X" (the inner lock)
> has "screwed up" by correctly coding X with the necessary lock.
>

It was already locked. An attempt of the resource-holder to lock
the resource again is an error, pure and simple.

> Your assertions do nothing to address how the coder of "Alpha" can NOT
> "screw up" if Alpha requires exclusive access to the facility lock by "X"
> *AND* needs to invoke "X".
>
> Your stance is naive and prone to induce errors in the name of an
> unreasonable and logically fallacious notion of purity.
>

The stance is not unreasonable. It also corresponds to what the
QC folks call "Good Standards of Engineering Practice", etc. To
properly write code so that, at compile-time resources are known
to be locked and unlocked in the correct order, goes a long way
towards producing the correct results.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

