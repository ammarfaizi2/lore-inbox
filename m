Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271329AbRINVyK>; Fri, 14 Sep 2001 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271309AbRINVyA>; Fri, 14 Sep 2001 17:54:00 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:56984 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271329AbRINVxr>; Fri, 14 Sep 2001 17:53:47 -0400
Date: Fri, 14 Sep 2001 22:55:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109141456410.4708-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109142125120.2124-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Marcelo Tosatti wrote:
> On Fri, 14 Sep 2001, Hugh Dickins wrote:
> > 
> > It won't stop the race with "bare" read_swap_cache_async (which can
> > happen with swapoff, or with vm_swap_full deletion if multithreaded),
> 
> Could you please make a diagram of such a race ? 

I first tried the swapoff one, but that doesn't work out (without a
further degree of improbability): we're rescued from the race there
because swapoff disallows get_swap_page from that swap area, so
although the entry read_swap_cache_async is trying for may have been
freed while it waited, it won't get reallocated in try_to_swap_out.

Unless you imagine swapon immediately after the swapoff, making
the same entry available again; or, I suppose rather more likely,
swapoff failing with -ENOMEM, so it all becomes reavailable.
Anyway, let's try the multithreaded vm_swap_full deletion instead:

CPU0					CPU1

do_swap_page's lookup of entry
doesn't find it in the cache, so
drops page_table lock, waits for BKL.
					Another thread faults on the same
					page, suppose this is the one which
					wins BKL, proceeds without delay
					to replace entry by pte, notices
					exclusive swap page and vm_swap_full,
					deletes entry from swap cache and
					swap_frees it completely.
Gets BKL, tries swapin_readahead,
but for simplicity let's suppose
that does nothing at all (e.g.
entry is for page 1 of swap -
which valid_swaphandles adjusts
to 0, but 0 always SWAP_MAP_BAD
so it breaks immediately).  So
"bare" read_swap_cache_async.
					Due to some shortage, enters try_to_
					free_pages, down to try_to_swap_out,
					get_swap_page gives entry just freed.
swap_duplicate
					add_to_swap_cache
add_to_swap_cache

> > and won't stop the race when valid_swaphandles->swap_duplicate comes
> > all between try_to_swap_out's get_swap_page and add_to_swap_cache.
> 
> Oh I see:
> 
> CPU0			CPU1
> 
> try_to_swap_out()	swapin readahead
> 
> get_swap_page()
> 			valid_swaphandles()
> 			swapduplicate()
> add_to_swap_cache()
> 			add_to_swap_cache()
> 
> BOOM.
> 
> Is that what you mean ?

Yes, that's that one.

> Right. Now I see that the diagram I just wrote (thanks for making me
> understand it :)) has been there forever. Ugh. 

Glad to be of service!  But it was you who made me see the danger of
these two contrary uses of add_to_swap_cache can be: one adding a
newly allocated page for an old swap entry, the other adding an
old page for a newly allocated swap entry.

It's fairly clear that the read_swap_cache_async instance should be
doing its check for whether the page is already in the cache, within
the necessary locking instead of before it.  Then, with appropriate
locking in swapfile.c, we can get rid of BKL bracketing around
swapin_readahead and read_swap_cache_async too.

The same check may be added into add_to_swap_cache for try_to_swap_out,
but would be additional overhead.  At present I'm giving get_swap_page
a *page argument, and letting it add_to_swap_cache inside its locking
(lock ordering then prohibits __delete_from_swap_cache from doing its
swap_free itself), so read_swap_cache_async cannot squeeze in between
the two stages.  But when I've pulled it together and looked it over,
it may seem preferable just to go with the additional check instead.

Hugh

