Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289487AbSBSDZ3>; Mon, 18 Feb 2002 22:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289532AbSBSDZT>; Mon, 18 Feb 2002 22:25:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46861 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289487AbSBSDZF>; Mon, 18 Feb 2002 22:25:05 -0500
Date: Mon, 18 Feb 2002 19:22:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <Pine.LNX.4.33.0202181822470.24671-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0202181908210.24803-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Feb 2002, Linus Torvalds wrote:
>
> We can, of course, introduce a "pmd-rmap" thing, with a pointer to a
> circular list of all mm's using that pmd inside the "struct page *" of the
> pmd. Right now the rmap patches just make the pointer point directly to
> the one exclusive mm that holds the pmd, right?

There's another approach:
 - get rid of "page_table_lock"
 - replace it with a "per-pmd lock"
 - notice that we already _have_ such a lock

The lock we have is the lock that we've always had in "struct page".

There are some interesting advantages from this:
 - we allow even more parallelism from threads across different CPU's.
 - we already have the cacheline for the pmd "struct page" because we
   needed it for the pmd count.

That still leaves the TLB invalidation issue, but we could handle that
with an alternate approach: use the same "free_pte_ctx" kind of gathering
that the zap_page_range() code uses for similar reasons (ie gather up the
pte entries that you're going to free first, and then do a global
invalidate later).

Note that this is likely to speed things up anyway (whether the pages are
gathered by rmap or by the current linear walk), by virtue of being able
to do just _one_ TLB invalidate (potentially cross-CPU) rather than having
to do it once for each page we free.

At that point you might as well make the TLB shootdown global (ie you keep
track of a mask of CPU's whose TLB's you want to kill, and any pmd that
has count > 1 just makes that mask be "all CPU's").

I'm a bit worried about the "lock each mm on the pmd-rmap list" approach,
because I think we need to lock them _all_ to be safe (as opposed to
locking them one at a time), which always implies all the nasty potential
deadlocks you get for doing multiple locking.

The "page-lock + potentially one global TLB flush" approach looks a lot
safer in this respect.

		Linus

