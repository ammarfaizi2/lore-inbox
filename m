Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266988AbRGIDAe>; Sun, 8 Jul 2001 23:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbRGIDAY>; Sun, 8 Jul 2001 23:00:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:41231 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266988AbRGIDAN>; Sun, 8 Jul 2001 23:00:13 -0400
Date: Sun, 8 Jul 2001 19:59:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107081227020.7044-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107081949290.18364-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Jul 2001, Linus Torvalds wrote:
>
> Anyway, having looked at the buffer case, I htink I found a potentially
> nasty bug: "unlock_buffer()" with a buffer count of zero.

[ Basic problem: write-completion race with the code that does
  "try_to_free_buffers" ]

Suggested fix:
 - every b_end_io() function should decrement the buffer count as the
   _last_ thing it does to the buffer.
 - every bh IO submitter would have to increment the bh count before
   submitting it for IO.

This way, I don't think try_to_free_buffers() can be confused: the only
thing that can suddenly start using a buffer is:
 - finding it on a buffer list (eg the BUF_DIRTY list) in order to wait on
   it or submit it for IO.
 - finding it on the hash list (ie "getblk()") during a bh lookup.

In both cases, try_to_free_buffers() owns the spinlocks that are required
for the list/hash lookup, so these things are nicely synchronized with
trying to free the buffer.

The only thing I can see that _wasn't_ synchronized with trying to free
the buffer was the IO completion, and if we make it the rule that the IO
is always handled with the buffer count elevated, and that the last thing
the IO completion does is equivalent to

	mb();	/* make sure all other bh changes are visible to other  CPU's */
	atomic_dec(&bh->b_count);	/* potentially free the bh */

then we're ok (and "unlock_buffer()" ends up acting as the "mb()", so that
part is covered). This way, if "try_to_free_buffers()" has seen
bh->b_count being zero (which is the only case where it will consider
freeing the buffer), we know that we're not racing with IO completion.

Do people agree with this, or see any holes in it?

		Linus

