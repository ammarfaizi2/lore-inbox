Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274283AbRISXtl>; Wed, 19 Sep 2001 19:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274281AbRISXta>; Wed, 19 Sep 2001 19:49:30 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:40635 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S274277AbRISXtU>; Wed, 19 Sep 2001 19:49:20 -0400
Date: Thu, 20 Sep 2001 00:51:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
In-Reply-To: <20010919232818.T720@athlon.random>
Message-ID: <Pine.LNX.4.21.0109200022360.1221-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Andrea Arcangeli wrote:
> On Wed, Sep 19, 2001 at 08:42:39PM +0100, Hugh Dickins wrote:
> > --- 2.4.10-pre12/mm/swap_state.c	Wed Sep 19 14:05:54 2001
> > +++ linux/mm/swap_state.c	Mon Sep 17 06:30:26 2001
> > @@ -23,6 +23,17 @@
> >   */
> >  static int swap_writepage(struct page *page)
> >  {
> > +	/* One for the page cache, one for this user, one for page->buffers */
> > +	if (page_count(page) > 2 + !!page->buffers)
> 
> this is racy, you have to spin_lock(&pagecache_lock) before you can
> expect the page_count() stays constant. then after you checked the page
> has count == 1, you must atomically drop it from the pagecache so it's
> not visible anymore to the swapin lookups.

Locking on pagecache_lock is no way to stabilize page count, but this
doesn't need it stabilized: it's just checking there's nothing but us
which can be interested in the page.  Okay, we now know that
read_swap_cache_async can get "interested" in surprising pages (when
the swap entry it asks for has meanwhile been replaced), but I don't
see how that endangers the logic here - it could briefly bump count
too high to pass the "don't write" test, but that errs on the safe side.

If you think this racy, how come you still allow "exclusive_swap_page"
use elsewhere?  Actually, I think these tests would be better replaced
by use of "exclusive_swap_page", wouldn't they?  But perhaps I'll find
I'm off-by-one when I try it tomorrow.

> Another way to fix the race is to change lookup_swap_cache to do
> find_lock_page instead of find_get_page, and then check the page is
> still a swapcachepage after you got it locked (that was the old way,
> somebody changed it and introduced the race, I like lookup_swap_cache to
> use find_get_page so I dropped such check to fix it, it was a minor
> optimization but yes probably worthwhile to reintroduce after addressing
> this race in one of the two ways described).

Well, I certainly agree the system can survive without this optimization,
and I wouldn't want to restore it if it were buggy.  I just don't see
the scenario you're afraid of, and nobody had questioned it before.

> It is also buggy, if something it should be "page_count(page) != 1" (not
> != 2).

I don't think so: as the comment says, one for the page cache,
one for the caller of writepage, one (perhaps) for page->buffers.

Hugh

