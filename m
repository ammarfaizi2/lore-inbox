Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131814AbQLHXBK>; Fri, 8 Dec 2000 18:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132323AbQLHXBA>; Fri, 8 Dec 2000 18:01:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59033 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131814AbQLHXAm>;
	Fri, 8 Dec 2000 18:00:42 -0500
Date: Fri, 8 Dec 2000 17:30:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.LNX.4.10.10012081125580.11302-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012081715330.27010-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, Linus Torvalds wrote:

> 
> 
> On Fri, 8 Dec 2000, Alexander Viro wrote:
> > 
> > Erm... So you want to make ->commit_write() page-unlocking? Fine with me,
> > but that will make for somewhat bigger patch. Hey, _you_ are in position
> > to change the locking rules, freeze or not, so if it's OK with you...
> 
> No.
> 
> Read the code a bit more.
> 
> commit_write() doesn't start any IO at all. It only marks the buffer
> dirty.

I'm quite aware of that fact ;-) However, you said 

   On the other hand, I have this suspicion that there is an even simpler
   solution: stop using the end_buffer_io_sync version for writes
   altogether.

If that happens (i.e. if write requests resulting from prepare_write()/
commit_write()/bdflush sequence become async) we must stop unlocking pages
after commit_write(). Essentially it would become unlocker of the same
kind as readpage() and writepage() - callers must assume that page submitted
to commit_write() will eventually be unlocked.

> The dirty flush-out works the way it has always worked.
> 
> (You're right in that the dirty flusher should make sure to change
> b_end_io when they do their write-outs - that code used to just depend on 
> the buffer always having b_end_io magically set)

Hmm... IDGI. Do you want the request resulting from commit_write() ("resulting"
!= "issued") to stay sync (in that case we still need to change
block_write_full_page() since the analysis stands - it dirties blocks
unconditionally) or you want them to go async (in that case we need to change
commit_write() callers)? Could you clarify?

> Btw, I also think that the dirty buffer flushing should get the page lock.
> Right now it touches the buffer list without holding the lock on the page
> that the buffer is on, which means that there is really nothign that
> prevents it from racing with the page-based writeout. I don't like that:
> it does hold the LRU list lock, so the list state itself is ok, but it
> does actually touch part of the buffer state that is not really protected
> by the lock.
> 
> I think it ends up being ok because ll_rw_block will ignore buffers that
> get output twice, and the rest of the state is handled with atomic
> operations (b_count and b_flags), but it's not really proper. If
> flush_dirty_buffers() got the page lock, everything would be protected
> properly. Thoughts?

Umm... I don't think that we need to do it on per-page basis. We need some
exclusion, all right, but I'ld rather provide it from block_write_full_page()
and its ilk. Hell knows...
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
