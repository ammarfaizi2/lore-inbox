Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132121AbRDTXq0>; Fri, 20 Apr 2001 19:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRDTXqQ>; Fri, 20 Apr 2001 19:46:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5132 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132121AbRDTXqI>; Fri, 20 Apr 2001 19:46:08 -0400
Date: Fri, 20 Apr 2001 16:45:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "D . W . Howells" <dhowells@astarte.free-online.co.uk>,
        <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem
 benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
In-Reply-To: <20010420191710.A32159@athlon.random>
Message-ID: <Pine.LNX.4.31.0104201639070.6299-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Andrea Arcangeli wrote:
>
> While dropping the list_empty check to speed up the fast path I faced the same
> complexity of the 2.4.4pre4 lib/rwsem.c and so before reinventing the wheel I
> read how the problem was solved in 2.4.4pre4.

I would suggest the following:

 - the generic semaphores should use the lock that already exists in the
   wait-queue as the semaphore spinlock.

 - the generic semaphores should _not_ drop the lock. Right now it drops
   the semaphore lock when it goes into the slow path, only to re-aquire
   it. This is due to bad interfacing with the generic slow-path routines.

   I suspect that this lock-drop is why Andrea sees problems with the
   generic semaphores. The changes to "count" and "sleeper" aren't
   actually atomic, because we don't hold the lock over them all. And
   re-using the lock means that we don't need the two levels of
   spinlocking for adding ourselves to the wait queue. Easily done by just
   moving the locking _out_ of the wait-queue helper functions, no?

 - the generic semaphores are entirely out-of-line, and are just declared
   universally as regular FASTCALL() functions.

The fast-path x86 code looks ok to me. The debugging stuff makes it less
readable than it should be, I suspect, and is probably not worth it at
this stage. The users of rw-semaphores are so well-defined (and so well
debugged) that the debugging code only makes the code harder to follow
right now.

Comments?  Andrea? Your patches have looked ok, but I absoutely refuse to
see the non-inlined fast-path for reasonable x86 hardware..

		Linus

