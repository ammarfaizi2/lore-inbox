Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132625AbRDUOEK>; Sat, 21 Apr 2001 10:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132627AbRDUOEB>; Sat, 21 Apr 2001 10:04:01 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:44377 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132625AbRDUODy>; Sat, 21 Apr 2001 10:03:54 -0400
Date: Sat, 21 Apr 2001 16:03:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "D . W . Howells" <dhowells@astarte.free-online.co.uk>,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
Message-ID: <20010421160327.A17757@athlon.random>
In-Reply-To: <20010420191710.A32159@athlon.random> <Pine.LNX.4.31.0104201639070.6299-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0104201639070.6299-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Apr 20, 2001 at 04:45:32PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 04:45:32PM -0700, Linus Torvalds wrote:
> I would suggest the following:
> 
>  - the generic semaphores should use the lock that already exists in the
>    wait-queue as the semaphore spinlock.

Ok, that is what my generic code does.

>  - the generic semaphores should _not_ drop the lock. Right now it drops
>    the semaphore lock when it goes into the slow path, only to re-aquire
>    it. This is due to bad interfacing with the generic slow-path routines.

My generic code doesn't drop the lock.

>    I suspect that this lock-drop is why Andrea sees problems with the
>    generic semaphores. The changes to "count" and "sleeper" aren't
>    actually atomic, because we don't hold the lock over them all. And
>    re-using the lock means that we don't need the two levels of
>    spinlocking for adding ourselves to the wait queue. Easily done by just
>    moving the locking _out_ of the wait-queue helper functions, no?

Basically yes, however for the wakeup I wrote a dedicated routine that
knows how to do the wake-all-next-readers or wake-next-writer (it is not
the same helper function of sched.c).

>  - the generic semaphores are entirely out-of-line, and are just declared
>    universally as regular FASTCALL() functions.

This is what I implemented originally but then I moved the fast path inline
for the fast-path benchmark reasons. I think in real life it doesn't matter
much if the fast path is inline or not.

> The fast-path x86 code looks ok to me. The debugging stuff makes it less
> readable than it should be, I suspect, and is probably not worth it at
> this stage. The users of rw-semaphores are so well-defined (and so well
> debugged) that the debugging code only makes the code harder to follow
> right now.

yes I agree, infact I added the ->magic check only to catch uninitialized
semaphores (and this one doesn't hurt readability that much).

> Comments?  Andrea? Your patches have looked ok, but I absoutely refuse to
> see the non-inlined fast-path for reasonable x86 hardware..

In my last patch the fast path is inline as said above but it is not in asm yet
because I couldn't get convinced it was right code. I plan to return looking
into the rwsem soon. I also seen David fixed the bug and dropped the buggy
rwsem-spin.h, so I suggest to merge his code for now, after a very short look
it seems certainly better than pre5.

Andrea
