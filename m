Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTJLLPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJLLPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:15:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42756 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263451AbTJLLP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:15:28 -0400
Date: Sun, 12 Oct 2003 12:15:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@redhat.com>, <Matt_Domsch@Dell.com>,
       <marcelo.tosatti@cyclades.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <20031011160318.GK16013@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0310121213080.4598-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Oct 2003, Andrea Arcangeli wrote:
> On Sat, Oct 11, 2003 at 03:48:31PM +0200, Andrea Arcangeli wrote:
> > 
> > I believe the more correct fix is to hold the pagemap_lru_lock during
> > __add_to_page_cache. The race exists between pages with PG_lru set (in
> > the lru) that are being added to the pagecache/swapcache. Holding both
> > spinlocks really avoids the race, your patch sounds less obviously safe
> > (since the race still happens but it's more "controlled") and a single
> > spinlock should be more efficient than the flood of atomic bitops
> > anyways. Comments?  Hugh?

I agree.  (I imagine some processors might implement that atomic flood
quite efficiently, but most not.)

> basically the race could only happen by running __add_to_page_cache on a
> page that was in the lru already. So it could happen with anon pages and
> shm too, never with plain pagecache. It's all about the PG_lru and
> PG_active bitflag. Both of them can only be changed inside the
> pagemap_lru_lock. So taking the pagemap_lru_lock will avoid the race.
> Can anybody see any race with this patch applied on top of 2.4.23pre7?
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.23pre7/anon-lru-race-better-fix-1
> 
> I believe this is cleaner and faster than the flood of bitops, since
> it's 2 atomic instructions only and it only happens in the paths where
> the race had a chance to trigger, so all the critical pagecache paths
> aren't affected at all anymore by the slowdown.

I believe your patch is correct, and prefer it to the atomic flood.

But I thought it almost coincidental that the racy cases happen to use
add_to_page_cache_unique rather than add_to_page_cache, and deserved
comment: until I noticed _nothing_ now uses add_to_page_cache, so
please just delete it from filemap.c and pagemap.h - it wasn't
exported, so no issue with out-of-tree modules (sorry, looks like
cleanup I should have done when I updated shmem.c in 2.4.22).

And maybe add __lru_cache_add (inline? FASTCALL?) for the
		if (!TestSetPageLRU(page))
			add_page_to_inactive_list(page);
so you don't have to drop pagemap_lru_lock before lru_cache_add.

> For the page_alloc.c changes, they must not make a difference so I
> backed them out.

I agree on that too: I think Rik did it for atomicity throughout,
to make the safety obvious; but in practice it was already safe.

However, I'm still not satisfied by your patch.  The patch
which will satisfy me is to remove all that bit clearing from
__add_to_page_cache, leaving just a LockPage, doing the clearing
in one go in __free_pages_ok.  In most cases, a page cannot be added
to page cache more than once before it's freed, so in those cases
it doesn't matter which stage we clear them.

The exceptions are normal swap (being deleted from swap cache under
pressure then readded later) and tmpfs: but __add_to_page_cache's
clearing does not help those cases, they compensate for it as much
as benefit.  PG_arch_1 needs more checking than I've time for now
(though I think it'll turn out okay), and probably -pre8 is the
wrong point for a change of this kind.

Hugh

