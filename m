Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbQLTSmh>; Wed, 20 Dec 2000 13:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLTSm1>; Wed, 20 Dec 2000 13:42:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7478 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130093AbQLTSmU>; Wed, 20 Dec 2000 13:42:20 -0500
Date: Wed, 20 Dec 2000 19:09:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001220190946.B11662@athlon.random>
In-Reply-To: <20001220162456.G7381@athlon.random> <Pine.LNX.4.21.0012201543010.1613-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0012201543010.1613-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Dec 20, 2000 at 03:48:06PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 03:48:06PM -0200, Rik van Riel wrote:
> On Wed, 20 Dec 2000, Andrea Arcangeli wrote:
> > On Thu, Dec 21, 2000 at 01:57:15AM +1100, Andrew Morton wrote:
> > > If a task is on two waitqueues at the same time it becomes a bug:
> > > if the outer waitqueue is non-exclusive and the inner is exclusive,
> > 
> > Your 2.2.x won't allow that either. You set the
> > `current->task_exclusive = 1' and so you will get an exclusive
> > wakeups in both waitqueues. You simply cannot tell register in
> > two waitqueue and expect a non-exlusive wakeup in one and an
> > exclusive wakeup in the other one.
> 
> Why not?  Having a wake-all wakeup on one event and a
> wake-one wakeup on another kind of event seems perfectly
> reasonable to me at a first glance. Is there something
> I've overlooked ?

I think you overlooked, never mind. I only said kernel 2.2.19pre2 won't allow
that either. I'm not saying it's impossible to implement or unrasonable.

> > > Anyway, it's academic.  davem would prefer that we do it properly
> > > and move the `exclusive' flag into the waitqueue head to avoid the 
> > > task-on-two-waitqueues problem, as was done in 2.4.  I think he's
> > 
> > The fact you could mix non-exclusive and exlusive wakeups in the
> > same waitqueue was a feature not a misfeature. Then of course
> > you cannot register in two waitqueues one with wake-one and one
> > with wake-all but who does that anyways?
> 
> The "who does that anyways" argument could also be said about
> mixing exclusive and non-exclusive wakeups in the same waitqueue.
> Doing this seems rather confusing ... would you know any application
> which needs this ?

wake-one accept(2) in 2.2.x unless you want to rewrite part of the TCP stack to
still get select wake-all right (the reason they was mixed in whole 2.3.x was
the same reason we _need_ to somehow mix non-excusive and exlusive waiters in
the same waitqueue in 2.2.x to provide wake-one in accept).

And in 2.2.x the "who does that anyways" is much stronger, since _only_
accept is using the exclusive wakeup.

> I think it would be good to have the same semantics in 2.2 as
> we have in 2.4. [..]

2.3.0 born for allowing O(1) inserction in the waitqueue because only that
change generated and huge amount of details that was not possible to handle in
2.2.x.

> [..] If there is a good reason to go with the
> semantics Andrea proposed [..]

NOTE: I'm only talking about 2.2.19pre2, not 2.4.x. I didn't suggested anything
for 2.4.x and I'm totally fine with two different waitqueues. I even wanted to
differentiate them too in mid 2.3.x to fix accept that was FIFO but still
allowing insertion in the waitqueue in O(1), but didn't had the time to rework
the TCP stack and the rest of wake-one users.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
