Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBCRse>; Sat, 3 Feb 2001 12:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129114AbRBCRs0>; Sat, 3 Feb 2001 12:48:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22281 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129066AbRBCRsI>; Sat, 3 Feb 2001 12:48:08 -0500
Date: Sat, 3 Feb 2001 09:47:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "Robert H. de Vries" <rhdv@rhdv.cistron.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] POSIX timers for 2.4.1
In-Reply-To: <20010203153310.B30376@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.10.10102030922030.8824-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Feb 2001, Jamie Lokier wrote:

> Robert H. de Vries wrote:
> > Hi Linus,
> > c. setitimer() can be used only once in a given process, you can have
> >    up to 32 (configurable) POSIX timers at the same time in your process.
> 
> Why is there a limit?  With such a small limit, any library that wants
> to use its own private timers is going to have to agree a way to
> multiplex with other libraries, and you're back to setitimer().

There's a limit, simply because the thing is implemented as an array. Ugh.

It also doesn't handle the old itimers with the new ones, so you end up
having _both_ the three hardcoded timers _and_ the new timers. Which I
think is rather ugly.

Quite frankly, I'd much rather have the current real/prof/virt itimers
expanded to lists instead (ie _three_ lists: the behaviour of
real/prof/virt timers are very different, and trying to mix them on one
list would be horrible), with the magic timer ID value of zero being the
one that the old itimer() functions work on.

That way, CLONE_ITIMERS would also do something sane (which it doesn't do
with the current POSIX timer patch - it will clone the posix itimers but
not the old itimers).

Also note that the POSIX itimer patch with CLONE_ITIMERS seems to be
horribly buggy: it will save off "timer->it_process", but the process may
not actually EXIST any more by the time the timer is called: exiting only
decrements the usage count, which may be elevated due to clone's etc.

In short, there's not a way in hell I will apply this patch any time soon.
It has real implementation bugs that will cause oopses and
possible lockups (sending signals to non-existent tasks), and I think it
has design problems too.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
