Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272065AbRILPpz>; Wed, 12 Sep 2001 11:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271587AbRILPpp>; Wed, 12 Sep 2001 11:45:45 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:15842 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271498AbRILPpe>; Wed, 12 Sep 2001 11:45:34 -0400
Date: Tue, 11 Sep 2001 01:14:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109111919260.1581-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109110059390.1420-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2001, Marcelo Tosatti wrote:
> 
> - swapin_readahead() finds used entry on swap map. (valid_swaphandles)
> - user of this entry deletes the swap map entry, so it becomes free. Then:
> 
> CPU0					CPU1
> read_swap_cache_async()			try_to_swap_out()
> Second __find_get_page() fails
> 					get_swap_page() returns swap
> 					entry which CPU0 is trying to read
> 					from.
> swap_duplicate() for the entry
> succeeds: CPU1 just allocated it.
> 					
> add_to_swap_cache()			add_to_swap_cache()

Yes, well spotted, you are right that there's a malign race here.

It may be made more likely by my swapoff changes (not bumping swap
count in valid_swaphandles), but it's not been introduced by those
changes.  Though usually swapin_readahead/valid_swaphandles covers
(includes) the particular swap entry which do_swap_page actually
wants to bring in, under pressure that's not always so, and then
the race you outline can occur with the "bare" read_swap_cache_async
for which there was no bumping.  Furthermore, you can play your
scenario with valid_swaphandles through to add_to_swap_cache on CPU0
interposed between the get_swap_page and add_to_swap_cache on CPU1
(if interrupt on CPU1 diverts it).

So it doesn't look like the solution will be to reintroduce bumping
the swap count in valid_swaphandles.  It needs the locking here to
be properly sorted out, probably without deceptive recourse to BKL.
I'll try to think this through this evening (but won't be surprised
if someone beats me to it).

Valuable find, thank you!
Hugh

