Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266519AbRGGS4D>; Sat, 7 Jul 2001 14:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266525AbRGGSzx>; Sat, 7 Jul 2001 14:55:53 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:20755 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266519AbRGGSzd>; Sat, 7 Jul 2001 14:55:33 -0400
Date: Sat, 7 Jul 2001 11:54:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33L.0107071542420.17825-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107071146320.31249-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jul 2001, Rik van Riel wrote:
>
> Not at all. Note that try_to_swap_out() will happily
> create swap cache pages with a very high page->age,
> pages which are in absolutely no danger of being
> evicted from memory...

That seems to be a bug in "add_to_swap_cache()".

In fact, I do not see any part of the whole path that sets the page age at
all, so we're basically using a completely uninitialized field here (it's
been initialized way back when the page was allocated, but because it
hasn't been part of the normal aging scheme it has only been aged up,
never down, so the value is pretty much random by the time we actually add
it to the swap cache pool).

Suggested fix:

	--- v2.4.6/linux/mm/swap_state.c        Tue Jul  3 17:08:22 2001
	+++ linux/mm/swap_state.c       Sat Jul  7 11:49:13 2001
	@@ -81,6 +81,7 @@
	                BUG();
	        flags = page->flags & ~((1 << PG_error) | (1 << PG_arch_1));
	        page->flags = flags | (1 << PG_uptodate);
	+       page->age = PAGE_AGE_START;
	        add_to_page_cache_locked(page, &swapper_space, entry.val);
	 }

Does that make a difference for people?

That would certainly help explain why aging doesn't work for some people.

		Linus

