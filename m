Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbQLHTTL>; Fri, 8 Dec 2000 14:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbQLHTTB>; Fri, 8 Dec 2000 14:19:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58122 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130696AbQLHTSp>; Fri, 8 Dec 2000 14:18:45 -0500
Date: Fri, 8 Dec 2000 10:48:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.GSO.4.21.0012081301160.27010-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012081037160.11302-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, Alexander Viro wrote:
> 
> Fix: postpone changing ->b_end_io until the call of ll_rw_block(); if by
> the time of ll_rw_block() some fragments will still have IO in progress -
> wait on them.
> 
> Comments?

Yes.

On the other hand, I have this suspicion that there is an even simpler
solution: stop using the end_buffer_io_sync version for writes
altogether.

It's really only __block_prepare_write() that can mark the buffers for
sync writes, and even that case is fairly bogus: it really only wants to
mark the non-upto-date buffers that it wants to _read_ for sync IO, it
just "knows" that it is ok to change every buffer it sees. It isn't.

Moving the 

	bh->b_end_io = end_buffer_io_sync;

into the read-path should be sufficient (hell, we should move the
"ll_rw_block(READ, 1, &bh)" away, and make it one single read with

	ll_rw_block(READ, wait_bh-wait, wait);

at the end of the loop.

If we do it that way, there is no way the two can clash, because a
non-up-to-date buffer head won't ever be touched by the write path, so we
can't get this kind of confusion.

Al? I'd really prefer this alternative instead. Do you see any problems
with it?

(New rule that makes 100% sense: NOBODY sets "bh->b_end_io" on any buffer
that he isn't actually going to do IO on.  And if there is pending IO on
the buffer, it had better only be of the same type as the one you're going
to do).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
