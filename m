Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130535AbQLHTn5>; Fri, 8 Dec 2000 14:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132161AbQLHTns>; Fri, 8 Dec 2000 14:43:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15838 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131154AbQLHTnj>;
	Fri, 8 Dec 2000 14:43:39 -0500
Date: Fri, 8 Dec 2000 14:13:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.LNX.4.10.10012081037160.11302-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012081353170.27010-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, Linus Torvalds wrote:

> It's really only __block_prepare_write() that can mark the buffers for
> sync writes, and even that case is fairly bogus: it really only wants to
> mark the non-upto-date buffers that it wants to _read_ for sync IO, it
> just "knows" that it is ok to change every buffer it sees. It isn't.
> 
> Moving the 
> 
> 	bh->b_end_io = end_buffer_io_sync;
> 
> into the read-path should be sufficient (hell, we should move the
> "ll_rw_block(READ, 1, &bh)" away, and make it one single read with
> 
> 	ll_rw_block(READ, wait_bh-wait, wait);
> 
> at the end of the loop.

Erm... So you want to make ->commit_write() page-unlocking? Fine with me,
but that will make for somewhat bigger patch. Hey, _you_ are in position
to change the locking rules, freeze or not, so if it's OK with you...

> If we do it that way, there is no way the two can clash, because a
> non-up-to-date buffer head won't ever be touched by the write path, so we
> can't get this kind of confusion.
> 
> Al? I'd really prefer this alternative instead. Do you see any problems
> with it?

If I understood you right - no problems.  I can do such patch, just give
me a couple of hours to recheck the locking rules.  BTW, what do you
think about the following:
	* add_to_page_cache() is not exported and never used. Kill?
	* __lock_page() is called only in lock_page(). Make the latter
inlined wrapper or kill the former?
	* rw_swap_page_base() would be simpler if it didn't leave unlocking the
page to caller - right now all callers do
	if (!rw_swap_page_base(...))
		UnlockPage(page);
	* ramfs_writepage() needs UnlockPage()
	* udf_adinicb_writepage() doesn't
	* brw_page() needs liposuction. _Badly_. Just read it.
	* Documentations/filesystems/Locking needs an update.
I can toss any subset of the above into patch - just tell...
 
> (New rule that makes 100% sense: NOBODY sets "bh->b_end_io" on any buffer
> that he isn't actually going to do IO on.  And if there is pending IO on
> the buffer, it had better only be of the same type as the one you're going
> to do).

Hrm. Why not move setting ->b_end_io to ll_rw_block() while we are at it?
Or into ll_rw_block() wrapper...
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
