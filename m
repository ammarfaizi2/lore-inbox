Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbRGJEFS>; Tue, 10 Jul 2001 00:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265445AbRGJEFI>; Tue, 10 Jul 2001 00:05:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46344 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265437AbRGJEEw>; Tue, 10 Jul 2001 00:04:52 -0400
Date: Mon, 9 Jul 2001 21:03:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <20010710045617.J1594@athlon.random>
Message-ID: <Pine.LNX.4.33.0107092053130.10187-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jul 2001, Andrea Arcangeli wrote:
>
> it seems to me there's a bit of overkill in the pre4 fix.

It may look that way, but look closer..

>						 First of all
> such race obviously couldn't happen with the async_io and kiobuf
> handlers, the former because the page stays locked so the bh cannot go
> away with the locked page, the latter because the bh are private not
> visible at all to the vm. Playing with the b_count for those two cases
> are just wasted cycles.

No. Playing with the bh count for those two makes the rules be the same
for everybody, because the sync_io handler needs it, and then we might as
well just make it a general rule: IO in-flight shows up as an elevated
count. It also makes sense from a "reference count" standpoint - the
buffer head count really means "how many references do we have to it", and
the reference from a IO request is very much a reference.

> Also somebody should explain me why end_buffer_write exists in first
> place, it is just wasted memory and icache.

Now that I agree with, we could just get rid of one of them.

> This is the way I would have fixed the smp race against pre3. Can you
> see anything that isn't fixed by the below patch and that is fixed by
> pre4?

I can. I "fixed" it your way at first, and it doesn't actually help a
thing.

Look:

	CPU #1					CPU #2

   try_to_free_buffers()

	if (atomic_read(&bh->b_count)

					    end_buffer_io_sync()

						atomic_inc(&bh->b_count);
						bit_clear(BH_Locked,  &bh->b_flags);

	|| bh->b_flags & BUSY_BITS)
		free bh

						if (waitqueue_active(&bh->b_wait))
							wakeup(&bh->b_wait);
						atomic_dec(&bh->b_count);


See? Your patch with the b_count stuff inside end_buffer_io_sync() fixes
absolutely _nothing_ - we still have exactly the same issue.

You can fix it with some interesting memory barriers inside the
try_to_free_buffers() logic, but by that time my fix is (a) much more
obvious and (b) faster too.

Notice how my fix actually has the same number of atomic operations as
your fix, except my fix actually _fixes_ the race?

(Yeah, I'm not counting the async IO ones - those I admit are not
necessary, but at the same time I really prefer to have the different IO
paths look as similar as possible. And see the reference count issue).

			Linus

