Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278379AbRJSMlG>; Fri, 19 Oct 2001 08:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278380AbRJSMk5>; Fri, 19 Oct 2001 08:40:57 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15506 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S278379AbRJSMkl>; Fri, 19 Oct 2001 08:40:41 -0400
Date: Fri, 19 Oct 2001 13:42:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] free more swap space on exit()
In-Reply-To: <Pine.LNX.4.33L.0110180247460.6440-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.21.0110191157110.939-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Rik van Riel wrote:
> 
> At the moment, the kernel frees the following things at
> exit() / exec() time:
> 1) memory in the process page tables + swapcache belonging
>    to these pages
> 2) swap space used by the process (refcount decrement)

Yes, it has the information readily to hand to do so.
We did go through a phase of not freeing swap+cache there,
but Linus got Marcelo to reinstate it - because swapoff
wasted so much time on them then, or other reasons?

> However, it does NOT free:
> 3) swap cache and space belonging to the process, where the
>    page is in RAM (and the swap cache) but NOT in the process'
>    page tables

Yes, which is asymmetric, but it doesn't currently do so for fear
of the repeated hash lookup overhead on a large address space?
and Linus' preference for letting them be dealt with by regular
memory recycling mechanisms in the course of time.  Similar
patches have been rejected or ignored in the past.

> The attached patch fixes the problem by simply looking up the
> address in the swap cache and freeing the page if it's there.

The pages (and their swap) will be found and freed later by vmscan
when memory pressure demands.  And vm_enough_memory (over-)allows
for the interim.  Does out_of_memory allow for it?  I _think_ the
answer is currently "yes" in -linus, but "no" in -ac; but both
might benefit from a proper count of such pages.

Am I right in thinking "the problem" you allude to is that these
stale swap cache pages clog up the lists, and useful cache pages
get reclaimed for other use meanwhile, before the stale swap cache
pages get discovered further down the list?  And that this cannot
be solved by keeping counts of such pages: which would be lighter
than hash lookups, and good for knowing we have a glut of swap
stales, but no use for actually finding what's best to free?

Your patch looks good to me, if measurements confirm it's a win.

I wanted to find some obscure race there, but failed.  What I would
like is a comment in find_swap_and_swap_cache, between the swap_free
and the find_trylock_page, making it explicit that the page found by
find_trylock_page may not be "ours" at all: once that swap_free has
been done, something else (usually vmscanning, maybe swapoff, maybe
another) could come in and do the delete_from_swap_cache on what was
"our" page and swap, and either or both be reallocated to other use.
If the new use of the swap entry passes the exclusive_swap_cache test
(unlikely), then it's still okay for us to delete_from_swap_cache.

And I'd prefer you not to add find_trylock_page at all, nor rewrite
__find_lock_page.  The latter rewrite just makes the point that we
already have far too many variants on __find_get_grab_lock_page in
filemap.c (and undoes some inlining): adding yet another variant
for just a single use doesn't make anything clearer for me.  Its
page->mapping check is unnecessary: exclusive_swap_page will check
PageSwapCache.  And its page->index check is unnecessary: if you
end up catching some other exclusive swap page here, it too is
fair game for delete_from_swap_cache.  Please just find_get_page
and TryLockPage within free_swap_and_swap_cache?

Hugh

