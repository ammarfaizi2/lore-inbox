Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273366AbRINLny>; Fri, 14 Sep 2001 07:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273365AbRINLnn>; Fri, 14 Sep 2001 07:43:43 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:51442 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S273364AbRINLna>; Fri, 14 Sep 2001 07:43:30 -0400
Date: Fri, 14 Sep 2001 12:45:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109131901240.4163-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109141229190.1372-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, Marcelo Tosatti wrote:
> > > 
> > > CPU0			CPU1			CPU2
> > > do_swap_page()		try_to_swap_out()	swapin_readahead()
.....
> > > BOOM.
> > > 
> > > Now, if we get additional references at valid_swaphandles() the above race
> > > is NOT possible: we're guaranteed that any get_swap_page() will not find
> > 
> > Err I mean _will_ find the swap map entry used and not use it, then.
> > 
> > > the swap map entry used. See?

Yes, I see it now: had trouble with the line wrap!

Sure, that's one of the scenarios we were talking about, and getting
additional references in valid_swaphandles will stop that particular
race.

It won't stop the race with "bare" read_swap_cache_async (which can
happen with swapoff, or with vm_swap_full deletion if multithreaded),
and won't stop the race when valid_swaphandles->swap_duplicate comes
all between try_to_swap_out's get_swap_page and add_to_swap_cache.

The first of those is significantly less likely than swapin_readahead
instance.  The second requires interrupt at the wrong moment: can
certainly happen, but again less likely.

Adding back reference bumping in valid_swaphandles would reduce the
likelihood of malign read_swap_cache_async/try_to_swap_out races,
but please don't imagine it's the final fix.

Hugh

