Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272656AbRILAEx>; Tue, 11 Sep 2001 20:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272659AbRILAEn>; Tue, 11 Sep 2001 20:04:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10249 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272656AbRILAE1>; Tue, 11 Sep 2001 20:04:27 -0400
Date: Tue, 11 Sep 2001 19:40:01 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>, Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.10pre VM changes: Potential race condition on swap code
Message-ID: <Pine.LNX.4.21.0109111919260.1581-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

It seems there is a potential race caused by swap changes. The reason is
that we do not increase the swap entry on swapin readahead. The comment on
top of swap_duplicate() in read_swap_cache_async() says:

        /*
         * Make sure the swap entry is still in use.  It could have gone
         * while caller waited for BKL, or while allocating page above,
         * or while allocating page in prior call via swapin_readahead.
         */
        if (!swap_duplicate(entry))     /* Account for the swap cache */
                goto out_free_page;

The BLK protects the logic against concurrent read_swap_cache_async()
calls, but it does not protect get_swap_page() in try_to_swap_out().

I do not see what protects us (increasing the swap map entry on
valid_swaphandles on older kernels used to be the protection) against the
following race:

- swapin_readahead() finds used entry on swap map. (valid_swaphandles)
- user of this entry deletes the swap map entry, so it becomes free. Then:

CPU0					CPU1
read_swap_cache_async()			try_to_swap_out()
Second __find_get_page() fails
					get_swap_page() returns swap
					entry which CPU0 is trying to read
					from.
swap_duplicate() for the entry
succeeds: CPU1 just allocated it.
					
add_to_swap_cache()			add_to_swap_cache()


Now we got two pages on the hash tables for the "same" data. From this
point on there is no guarantee _which_ data will be returned when searched
via pagecache lookup.

Linus, Hugh ?

