Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132393AbQLHULG>; Fri, 8 Dec 2000 15:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132603AbQLHUK4>; Fri, 8 Dec 2000 15:10:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4621 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132393AbQLHUKl>; Fri, 8 Dec 2000 15:10:41 -0500
Date: Fri, 8 Dec 2000 11:39:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.GSO.4.21.0012081353170.27010-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012081125580.11302-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, Alexander Viro wrote:
> 
> Erm... So you want to make ->commit_write() page-unlocking? Fine with me,
> but that will make for somewhat bigger patch. Hey, _you_ are in position
> to change the locking rules, freeze or not, so if it's OK with you...

No.

Read the code a bit more.

commit_write() doesn't start any IO at all. It only marks the buffer
dirty.

The dirty flush-out works the way it has always worked.

(You're right in that the dirty flusher should make sure to change
b_end_io when they do their write-outs - that code used to just depend on 
the buffer always having b_end_io magically set)

> Hrm. Why not move setting ->b_end_io to ll_rw_block() while we are at it?
> Or into ll_rw_block() wrapper...

That's too big a change right now, but yes, in theory. That would make
sure that nobody could ever forget to set the "completion" handler.

In the meantime, let's just enforce it for ll_rw_block: make sure that
there is a 1:1 mapping between setting b_end_io and doing a ll_rw_block
(and let's make sure that there are no more of these non-local rules any
more).

Btw, I also think that the dirty buffer flushing should get the page lock.
Right now it touches the buffer list without holding the lock on the page
that the buffer is on, which means that there is really nothign that
prevents it from racing with the page-based writeout. I don't like that:
it does hold the LRU list lock, so the list state itself is ok, but it
does actually touch part of the buffer state that is not really protected
by the lock.

I think it ends up being ok because ll_rw_block will ignore buffers that
get output twice, and the rest of the state is handled with atomic
operations (b_count and b_flags), but it's not really proper. If
flush_dirty_buffers() got the page lock, everything would be protected
properly. Thoughts?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
