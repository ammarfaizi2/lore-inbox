Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278238AbRJMBs7>; Fri, 12 Oct 2001 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278239AbRJMBst>; Fri, 12 Oct 2001 21:48:49 -0400
Received: from [208.129.208.52] ([208.129.208.52]:34577 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278238AbRJMBsc>;
	Fri, 12 Oct 2001 21:48:32 -0400
Date: Fri, 12 Oct 2001 18:54:36 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Paul Mackerras <paulus@samba.org>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <15303.37865.489986.425653@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.40.0110121834150.1505-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Paul Mackerras wrote:

> Linus Torvalds writes:
>
> > So how about just going all the way and calling it what it is:
> > "data_dependent_read_barrier()", with a notice in the PPC docs about how
> > the PPC cannot speculate reads anyway, so it's a no-op.
>
> To set the record straight, the PPC architecture spec says that
> implementations *can* speculate reads, but they have to make it look
> as if dependent loads have a read barrier between them.
>
> And it isn't speculated reads that are the problem in the alpha case,
> it's the fact that the cache can reorder invalidations that are
> received from the bus.  That's why you can read the new value of p but
> the old value of *p on one processor after another processor has just
> done something like a = 1; wmb(); p = &a.

I think that necessary condition to have a reordering of bus sent
invalidations is to have a partitioned cache architecture.
I don't see any valid reason for a cache controller of a linear cache
architecture to reorder an invalidation stream coming from a single cpu.
If the invalidation sequence for cpu1 ( in a linear cache architecture )
is 1a, 1b, 1c, ... this case can happen :

1a, 2a, 1b, 2b, 2c, 1c, ...
|       |           |
.........................

but not this :

1a, 2a, 2b, 1c, 2c, 1b, ...
|           |       |
...............><........


> My impression from what Paul McKenney was saying was that on most
> modern architectures other than alpha, dependent loads act as if they
> have a read barrier between them.  What we need to know is which
> architectures specify that behaviour in their architecture spec, as
> against those which do that today but which might not do it tomorrow.

Uhmm, an architecture that with  a = *p;  schedule the load of  *p  before
the load of  p  sounds screwy to me.
The problem is that even if cpu1 schedule the load of  p  before the
load of  *p  and cpu2 does  a = 1; wmb(); p = &a; , it could happen that
even if from cpu2 the invalidation stream exit in order, cpu1 could see
the value of  p  before the value of  *p  due a reordering done by the
cache controller delivering the stream to cpu1.




- Davide



