Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289577AbSBSDll>; Mon, 18 Feb 2002 22:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289597AbSBSDla>; Mon, 18 Feb 2002 22:41:30 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:31635 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289577AbSBSDlW>;
	Mon, 18 Feb 2002 22:41:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 04:45:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181908210.24803-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181908210.24803-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16d1E8-00010D-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 04:22 am, Linus Torvalds wrote:
> On Mon, 18 Feb 2002, Linus Torvalds wrote:
> >
> > We can, of course, introduce a "pmd-rmap" thing, with a pointer to a
> > circular list of all mm's using that pmd inside the "struct page *" of the
> > pmd. Right now the rmap patches just make the pointer point directly to
> > the one exclusive mm that holds the pmd, right?
> 
> There's another approach:
>  - get rid of "page_table_lock"
>  - replace it with a "per-pmd lock"
>  - notice that we already _have_ such a lock
> 
> The lock we have is the lock that we've always had in "struct page".

Yes, I even have an earlier version of the patch that implements a spinlock
on that bit.  It doesn't use the normal lock_page of course.

> There are some interesting advantages from this:
>  - we allow even more parallelism from threads across different CPU's.
>  - we already have the cacheline for the pmd "struct page" because we
>    needed it for the pmd count.Y
> 
> That still leaves the TLB invalidation issue, but we could handle that
> with an alternate approach: use the same "free_pte_ctx" kind of gathering
> that the zap_page_range() code uses for similar reasons (ie gather up the
> pte entries that you're going to free first, and then do a global
> invalidate later).
>
> Note that this is likely to speed things up anyway (whether the pages are
> gathered by rmap or by the current linear walk), by virtue of being able
> to do just _one_ TLB invalidate (potentially cross-CPU) rather than having
> to do it once for each page we free.
> 
> At that point you might as well make the TLB shootdown global (ie you keep
> track of a mask of CPU's whose TLB's you want to kill, and any pmd that
> has count > 1 just makes that mask be "all CPU's").
> 
> I'm a bit worried about the "lock each mm on the pmd-rmap list" approach,
> because I think we need to lock them _all_ to be safe (as opposed to
> locking them one at a time), which always implies all the nasty potential
> deadlocks you get for doing multiple locking.
> 
> The "page-lock + potentially one global TLB flush" approach looks a lot
> safer in this respect.

How do we know when to do the global tlb flush?

-- 
Daniel
