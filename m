Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271614AbRIOALX>; Fri, 14 Sep 2001 20:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271613AbRIOALN>; Fri, 14 Sep 2001 20:11:13 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:43424 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271597AbRIOAKz>; Fri, 14 Sep 2001 20:10:55 -0400
Date: Sat, 15 Sep 2001 01:12:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109141747210.4708-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109150050060.1151-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Marcelo Tosatti wrote:
> 
> I would prefer to make get_swap_page() not lock the swap lock anymore,
> making it necessary to its callers to do the locking themselves. So:
> 
> try_to_swap_out() {
> 	swap_device_lock()
> 	get_swap_page()
> 	add_to_swap_cache()
> 	swap_device_unlock()
> }
> 
> read_swap_cache_async() {
> 	page = alloc_page(page)
> 	swap_device_lock()
> 	if(!swap_map[offset]) {
> 		page_cache_release(page)
> 		swap_device_unlock()
> 		return 1;
> 	}
> 	alias = __find_page()
> 	if (!alias) {
> 		swap_map[offset]++;
> 		add_to_swap_cache(page)
> 	}
> 	swap_device_unlock()
> 	rw_swap_page(page)
> }

This does gloss over the distinction between the swap_list_lock()
and the swap_device_lock(si).  The latter is the more crucial here,
but difficult to use in this way.  Though if you were to throw it
away and convert to swap_list_lock() throughout, I wonder if we'd
lose much (only gain on systems with just one swap area).  But I
wasn't daring to combine them myself.

> If you don't have that one already done, I can write it as soon as you
> answer me.

Don't wait on me: I'm not ready with my implementation yet, and
you think a lot faster than I do.  If you find you can resolve
the details, go ahead.  Beware shmem_writepage, where the one
page metamorphoses from being a file page to being a swap page.
Do you intend to scrap the BKL bracketing now?

I hope to resume tomorrow, unless you've sewn it up by then.

Hugh

