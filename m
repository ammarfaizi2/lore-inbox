Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTETUwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTETUwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:52:46 -0400
Received: from mail.casabyte.com ([209.63.254.226]:47877 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261188AbTETUwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:52:43 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <root@chaos.analogic.com>, "Helge Hafting" <helgehaf@aitel.hist.no>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
Date: Tue, 20 May 2003 14:05:35 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGKEGCCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.53.0305200809060.3996@chaos>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Tuesday, May 20, 2003 5:23 AM
To: Helge Hafting

> Recursive locking is a misnomer. It does during run-time that which
> should have been done during design-time. In fact, there cannot
> be any recursion associated with locking. A locking mechanism that
> allows reentry or recursion is defective, both in design, and
> implementation.

Amusing... but false...

A lock serves, and is defined by, exactly _ONE_ trait.  A lock asserts and
guarantees exclusive access to a domain (group of data or resources etc).

There is nothing inherently "one deep" about that assertion.
(Philosophically stated:)  If I say "I own this car for the next hour" and
ten minutes later say "I am taking the car to the store for twenty minutes"
there is no "violation of truth" to the two assertions.  The outer hour and
the inner twenty minutes are in no form of conflict.  Further, since there
promise of the first assertion is _*NOT*_ that the car will be free for use
after an hour, if the twenty minutes of the second assertion begins at the
58 minute mark of the sort-of-enclosing hour, thus extending the hour, you
are still ok.

More mathematically, if I write an operation "X" that, say, needs exclusive
access to the dircache for some portion of its execution, for correctness I
should lock that dircache.  Say I write a second operation "Y" that also
needs the dircache, and locks it appropriately.  If someone wants/needs to
create an operation "Alpha" that contains a number of sub operations
including X and Y, but needs to ensure the consistency of the dircache for a
range (of time/operations) larger than X, Y and the any number of operations
"n" what is to be done.

With your artificial definition of locking, the implementer of Alpha must do
one of the following:

1) Separately reimplement (copy) X and Y without locking, so that the lock
may be held by Alpha.

2) Restructure X and Y into X', X, Y', and Y such that all public uses of X
and Y remain unchanged, but X and Y are now locking wrappers around X' and
Y' so that X' and Y' may be used within Alpha.

3) (Multiply) Move the locks out of X and Y into all instances of
invocations of X and Y so that Alpha has equal and unimpeded access to X an
Y that is "identical" to every (now revised) use of X and Y.

*ALL* of the above alternatives are wrong.  At no time should a stable
operation "O" need to be recoded or restructured to be rationally used in an
enclosing operation Alpha.

In point of fact, if the lock used in X, Y, and Alpha are, by default,
recursive, Alpha can be coded as needed without having to revisit any of the
operations that Alpha invokes.  The implementer of Alpha "probably ought to"
know what X and Y and all instances of "n" do and examine need to pre-claim
locks to prevent internal deadlock as that is more expedient than making
sure that X, Y and "n" all have proper anti-deadlock back-offs.

There is no rational argument against recursive locking that can justify any
system where the creation of an outer operation should view the pathological
restructuring of existent component operations as "the right thing to do".

If you think this doesn't happen, I point you do the documentation on the
VFS and the various notations about locks having moved in and out of
operations.

The simple truth is that your statement:

> The nature of a lock is required to be such that if the locked object
> is in use, no access to that object is allowed.

is PURE FANTASY and logically junct.  Correctly stated:

The nature of a lock is required to be such that, if the locked object is in
use, no COMPETING OR OUT OF THREAD/BAND access to that object is allowed.

A recursive lock would "protect" accesses that are IN BAND and thus
completely allowed.  Period.

> Recursive locking
> implies that if the lock is in use by the same thread that locked
> it before, then access to that object is allowed.

The statement above is logically useless to your argument, that is, if the
words "recursive locking" were replaced with the word "this" or indeed "any
lock", the statement remains tautological.  "(This/Any lock) implies that if
the lock is in use by the same thread that locked it (before/previously)
then access to that object is allowed."  See how nicely true that is?

> In other words,
> if the coder (as opposed to designer) screwed up, the locking
> mechanism will allow it. If this is the way students are being
> taught to write code at the present time, all software will
> be moved off-shore in the not too distant future. There is
> absolutely no possible justification for such garbage. Just
> because some idiot wrote an article and got it published,
> doesn't mean this diatribe has any value at all.

Your assertions do nothing to address how the coder of "X" (the inner lock)
has "screwed up" by correctly coding X with the necessary lock.

Your assertions do nothing to address how the coder of "Alpha" can NOT
"screw up" if Alpha requires exclusive access to the facility lock by "X"
*AND* needs to invoke "X".

Your stance is naive and prone to induce errors in the name of an
unreasonable and logically fallacious notion of purity.

Rob.

