Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTETC7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 22:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTETC7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 22:59:37 -0400
Received: from mail.casabyte.com ([209.63.254.226]:39949 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S263462AbTETC7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 22:59:34 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "David Woodhouse" <dwmw2@infradead.org>, <ptb@it.uc3m.es>
Cc: "William Lee Irwin III" <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
Date: Mon, 19 May 2003 20:12:15 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGGEENCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1053297297.28446.18.camel@imladris.demon.co.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Er..

The gnome wields a morality stick, the morality stick wields itself to the
gnome's hand...
---more---
The gnome hits you... you feel better...


Your "moral position"...

(quote) I want them to either learn to comprehend locking _properly_, or
take up gardening instead. (unquote)

...is critically flawed.

In point of fact, "proper" locking, when combined with "proper" definitions
of an interface dictate that recursive locking is "better".  Demanding that
a call_EE_ know what locks a call_ER_ (and all antecedents of caller) will
have taken is not exactly good design.

Oh, don't get me wrong, I appreciate that in intimately interlocking code
you have to do some of this, but remember that "a lock" is "morally" a
declaration of need at the module interface level of abstraction.

(for instance) The current kernel design requires that (the editorial) we
need to know what locks are held when our file system hooks are called.
Statements about how some particular lock (let's call him "bob") will be
already held by the kernel when routine X is called are "bad" because they
lead to all sorts of problems when that statement becomes false later.

In the most "morally erect" interface design, the implementer of a module
would never have to worry about locking anything, or at least about the
current lock-state of anything.  In the morally perfect universe, the
declarative statement "lock that thing there" would be a smart operator that
would know what all locks, in what dependency orders, needed to be acquired
to "lock that thing there" and the system could execute that pathway of
locking automagically.

Of course, in such a world, the domestic swine would be useful as a bulk
passenger carrier because of the easy way it traverses the sky...

In the current design "we" demand that each designer learn and know what is
locked and what is not.  "We" have documents about how in version X the duty
to lock thing Y has been shifted from outside routine Z to inside.

Recursive locks (and a well defined resource allocation order, but who am I
kidding) would actually be a benefit to all on both sides of most _info and
_op structures, they would insulate design changes and improve portability.

A design where I lock things for only as long as I need them is optimal for
that contention.

If my caller does the same, regardless of my actions then his code is
optimal for those contentions too.

If neither is concerned with the other's needs then the lock intervals are
demand based and will tend to allow the bodies of code to be improved on a
"purely local" basis.

To achieve that, you need recursive locking.

I don't think for an instant that we are going to get recursive locking, but
it does make the specification of interfaces better.

It's only real down side is that it lets the lazy and the sloppy get away
with too much before getting burned.  Recursive locking plus a "lock
everything I *might* touch because my callees wont care" mentality leads to
overlocking and hard-to-find deadlocks.  Everything looks and works find for
a while until everybody, willing to pre-reserve facilities for all their
callees, starts building pool-straddling devices (USB Hard Drives, Network
Extensible File Systems, etc) and only finding their deadlocks late in the
game when things get tangled.

so we wont get recursive locking because of the 02% people who can't be
trusted with it.

But that doesn't make the recursive locking facility anything less than
superior for defining and implementing superior interfaces.

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of David Woodhouse
Sent: Sunday, May 18, 2003 3:35 PM
To: ptb@it.uc3m.es
Cc: William Lee Irwin III; Martin J. Bligh; linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.


On Sun, 2003-05-18 at 18:24, Peter T. Breuer wrote:
> The second method is used by programmers who aren't aware that some
> obscure subroutine takes a spinlock, and who recklessly take a lock
> before calling a subroutine (the very thought sends shivers down my
> spine ...).  A popular scenario involves not /knowing/ that your routine
> is called by the kernel with some obscure lock already held, and then
> calling a subroutine that calls the same obscure lock.  The request
> function is one example, but that's hardly obscure (and in 2.5 the
> situation has eased there!).

To be honest, if any programmer is capable of committing this error and
not finding and fixing it for themselves, then they're also capable, and
arguably _likely_, to introduce subtle lock ordering discrepancies which
will cause deadlock once in a blue moon.

I don't _want_ you to make life easier for this hypothetical programmer.

I want them to either learn to comprehend locking _properly_, or take up
gardening instead.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

