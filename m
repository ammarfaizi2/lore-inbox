Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265454AbRGJEVw>; Tue, 10 Jul 2001 00:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265465AbRGJEVb>; Tue, 10 Jul 2001 00:21:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:6921 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265454AbRGJEVZ>; Tue, 10 Jul 2001 00:21:25 -0400
Date: Mon, 9 Jul 2001 21:20:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107092053130.10187-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107092112180.10220-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Jul 2001, Linus Torvalds wrote:
>
> Look:
>
> 	CPU #1					CPU #2
>
>    try_to_free_buffers()
>
> 	if (atomic_read(&bh->b_count)
>
> 					    end_buffer_io_sync()
>
> 						atomic_inc(&bh->b_count);
> 						bit_clear(BH_Locked,  &bh->b_flags);
>
> 	|| bh->b_flags & BUSY_BITS)
> 		free bh

I forgot to note that it doesn't help to re-order the tests here - but we
_could_ do

	if (bh->b_flags & BUSY_BITS)
		goto buffer_busy;
	rmb();
	if (atomic_read(&bh->b_count))
		goto buffer_busy;

together with having the proper write memory barriers in
"end_buffer_io_sync()" to make sure that the BH_Locked thing shows up in
the right order with bh->b_count updates.

In contrast, the version in pre4 doesn't depend on any memory ordering
between BH_Locked at all - it really only depends on a memory barrier
before the final atomic_dec() that releases the buffer, as it ends up
being sufficient for try_to_free_buffers() to just worry about the buffer
count when it comes to IO completion. The b_flags BUSY bits don't matter
wrt the IO completion at all - they end up being used only for "idle"
buffers (which in turn are totally synchronized by the LRU and hash
spinlocks, so that is the "obviously correct" case)

I personally think it's a hard thing to depend on memory ordering,
especially if there are two independent fields. Which is why I really
don't think that the pre4 fix is "overkill".

Oh, it does really need a

	smp_mb_before_atomic_dec();

as part of the "put_bh()". On x86, this obviously is a no-op. And we
actually need that one in general - not just for IO completion - as long
as we consider the "atomic_dec(&bh->b_flags)" to "release" the buffer.

Andrea?

		Linus

