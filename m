Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132818AbRDKSlm>; Wed, 11 Apr 2001 14:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132821AbRDKSld>; Wed, 11 Apr 2001 14:41:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15877 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132818AbRDKSlU>; Wed, 11 Apr 2001 14:41:20 -0400
Date: Wed, 11 Apr 2001 11:41:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@cambridge.redhat.com>
cc: Andrew Morton <andrewm@uow.edu.au>, David Howells <dhowells@redhat.com>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
In-Reply-To: <17325.987010583@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.31.0104111129220.17733-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Apr 2001, David Howells wrote:
>
> > These numbers are infinity :)
>
> I know, but I think Linus may be happy with the resolution for the moment. It
> can be extended later by siphoning off excess quantities of waiters into a
> separate counter (as is done now) and by making the access count use a larger
> part of the variable.

I'm certainly ok with the could being limited to "thoudands". I don't see
people being able to exploit it any practical way. But we should remember
to be careful: starting thousands of threads and trying to make them all
take page faults and overflowing the read counter would be a _nasty_
attack, It would probably not be particularly easy to arrange, but still.

Note that blocking locks are different from spinlocks: for spinlocks we
can get by with just 7 bits in a byte, and be guaranteed that that is
enough for any machine with less than 128 processors. For the blocking
locks, that is not true.

(Right now the default "max user processes" ulimit already protects us
from this exploit, I just wanted to make sure that people _think_ about
this).

So a 16-bit count is _fine_. And I could live with less.

We should remember the issue, though. If we ever decide to expand it, it
would be easy enough to make an alternative "rwsem-reallybig.h" that uses
cmpxchg8b instead, or whatever. You don't need to start splitting the
counts up to expand them past 16 bits, you could have a simple system
where the _read_ locks only look at one (fast) 32-bit word for their fast
case, and only the write lock actually needs to use cmpxchg8b.

(I think it's reasonable to optimize the read-lock more than the
write-lock: in the cases where you want to do rw-locking, the common
reason is because you reall _want_ to allow many concurrent readers. That
also implies that the read case is the common one).

So you could fairly easily expand past 16-bit counters by using a 31-bit
counter for the reader, and making the high bit in the reader count be the
"contention"  bit. Then the slow path (and the write path) would use the
64-bit operations offered by cmpxchg8b.

And yes, it's a Pentium+ instruction (and this time I -checked- ;), but by
the time you worry about hundreds of thousands of threads I think you can
safely just say "you'd better be running on a big a modern machine", and
just make the code conditional on CONFIG_PENTIUM+

So no real trickiness needed for expanding the number space, but certainly
also no real _reason_ for it at this time.

		Linus

