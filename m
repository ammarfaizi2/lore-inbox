Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268929AbRG0TSs>; Fri, 27 Jul 2001 15:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268930AbRG0TSa>; Fri, 27 Jul 2001 15:18:30 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2065 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268929AbRG0TST>; Fri, 27 Jul 2001 15:18:19 -0400
Date: Fri, 27 Jul 2001 10:46:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Pavel Machek <pavel@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, <linux-scsi@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
In-Reply-To: <20010727091858.C10787@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.33.0107271029340.21738-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Fri, 27 Jul 2001, Matthew Dharm wrote:
>
> It looks like I missed an important discussion in the torrent of e-mail
> that I receive... could someone give me the 30-second executive summary so
> I can look at what may need to change in usb-storage?

The basic summary is that we had this (fairly common) way of waiting for
certain events by having a locked semaphore on the stack of the waiter,
and then having the waiter do a "down()" which caused it to block until
the thing it was waiting for did an "up()".

This works fairly well, _but_ it has a really small (and quite unlikely)
race on SMP, that is not so much a race of the idea itself, as of the
implementation of the semaphores. We could have fixed the semaphores, but
there were a few reasons not to:

 - the semaphores are optimized (on purpose) for the non-contention case.
   The "wait for completion" usage has the opposite default case
 - the semaphores are quite involved and architecture-specific, exactly
   due to this optimization. Trying to change them is painful as hell.

So instead, I introduced the notion of "wait for completion":

	struct completion event;

	init_completion(&event);
	.. pass of event pointer to waker ..
	wait_for_completion(&event);

where the thing we're waiting for just does "complete(event)" and we're
all done.

This has the advantage of being a bit more obvious just from a syntactic
angle about what is going on. It also ends up being slightly more
efficient than semaphores because we can handle the right expected case,
and it also avoids the implementation issue that made for the race in the
first place.

Switching over to the new format is really trivial:

 struct semaphore	-> struct completion
 init_MUTEX_LOCKED	-> init_completion
 DECLARE_MUTEX_LOCKED	-> DECLARE_COMPLETION
 down()			-> wait_for_completion()
 up()			-> complete()

and you can in fact maintain 2.2.x compatibility by just having a 2.2.x
compatibility file that does the reverse mappings.

In case anybody cares, the race was that Linux semaphores only protect the
accesses _inside_ the semaphore, while the accesses by the semaphores
themselves can "race" in the internal implementation. That helps make an
efficient implementation, but it means that the race was:

	cpu #1				cpu #2

	DECLARE_MUTEX_LOCKED(sem);
	..
	down(&sem);			up(&sem);
	return;
					wake_up(&sem.wait) /*BOOM*/

where the waker still touches the semaphore data structure after the
sleeper has become happy with it no longer being locked - and free'd the
data structure by virtue of freeing the stack.

		Linus

