Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266950AbRGHR7p>; Sun, 8 Jul 2001 13:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266945AbRGHR7Z>; Sun, 8 Jul 2001 13:59:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:52487 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266944AbRGHR7U>; Sun, 8 Jul 2001 13:59:20 -0400
Date: Sun, 8 Jul 2001 10:58:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33L.0107081241280.22014-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107081039420.7044-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Jul 2001, Rik van Riel wrote:
>
> ... Bingo.  You hit the infamous __wait_on_buffer / ___wait_on_page
> bug. I've seen this for quite a while now on our quad xeon test
> machine, with some kernel versions it can be reproduced in minutes,
> with others it won't trigger at all.

Hmm.. That would explain why the "tar" gets stuck, but why does the whole
machine grind to a halt with all other processes being marked runnable?

> I hope there is somebody out there who can RELIABLY trigger
> this bug, so we have a chance of tracking it down.
>
> > tar
> > Trace; c012f2da <__wait_on_buffer+6a/8c>
> > Trace; c01303c9 <bread+45/64>

I wonder if "getblk()" returned a locked not-up-to-date buffer.. That
would explain how the buffer stays locked forever - the "ll_rw_block()"
will not actually submit any IO on a locked buffer, so there won't be any
IO to release it.

And it's interesting to see that this happens for a _inode_ block, not a
data block - which could easily have been dirty and scheduled for a
write-out. So I wonder if there is some race between "write buffer and try
to free it" and "getblk()".

The locking in "try_to_free_buffers()" is rather anal, so I don't see how
this could happen, but..

That still doesn't explain why everybody is busy running. I'd have
expected all the processes to end up waiting for the page or buffer, not
stuck in a live-lock.

		Linus

