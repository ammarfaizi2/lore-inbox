Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275752AbRJ3Rad>; Tue, 30 Oct 2001 12:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJ3RaX>; Tue, 30 Oct 2001 12:30:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49935 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275752AbRJ3RaP>; Tue, 30 Oct 2001 12:30:15 -0500
Date: Tue, 30 Oct 2001 09:28:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: need help interpreting 'free' output.
In-Reply-To: <20011030180616.M1340@athlon.random>
Message-ID: <Pine.LNX.4.33.0110300917520.8603-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
>
> It is still interesting to hear if it makes a big performance differece
> under swap though. In particular it would be very nice to keep inodes
> with pagecache in it out of the unused-inode-list, but it would need
> additional bitkeeping in inode.c.

Yes. I'm worried about the fact that icache shrinking was one of the top
CPU users under heavy swapout, so I'd like to do _something_. The LRU
approach is probably the cleanest and least random approach.

> I'm also wondering why you dropped the early-cow for the write swapins,
> just to avoid managing the anon pages in the lru in do_swap_page and to
> have the logic only in once place? I kept the early-cow logic so I only
> get 1 page fault for every write-swapped-in pages.

I only dropped it because the locking rules for how exclusive swap pages
work were too unclear, and I wanted to have the "remove on write" in just
one place.

Then I cleaned up the logic and made the thing use the pagecache lock
properly and turned it into "remove_exclusive_swap_page()", and now I'm
not worried about it any more, so I'm considering moving it back again.

HOWEVER, _then_ I started wondering about whether the thing needs to be
removed from the swap cache at all, and came to the conclusion that for
the only case we really care about (and the only case where we _can_
re-use the swap cache page), we don't actually need to remove it from the
cache in the first place.

I think we should just share the page, and make the WP (and early-COW in
do_swap_page()) logic just be

	/* Are we now the only user? */
	if (swap_count(page) == 1 && page_count(page) == 2) {
		pte = pte_mkwrite(pte_mkdirty(mk_pte(page,  vma->vm_page_prot))
		install_pte();
		return;
	}

There's no real reason to remove the page from the swap cache - that only
means that we have to wait for the page to unlock (because you need to
lock the page in order to remove the buffers that you need to remove
_before_ you free the swap entry) and other crap that has no real point to
it.

When we fork() and possibly share the page non-exclusively, we will
_already_ mark the page read-only and do the COW - so after that point we
will correctly just copy the page on demand.

Much simpler, I think.

Does anybody see why we have to remove it from the swap cache at all?

		Linus

