Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274268AbRISXcT>; Wed, 19 Sep 2001 19:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274269AbRISXcJ>; Wed, 19 Sep 2001 19:32:09 -0400
Received: from [195.223.140.107] ([195.223.140.107]:16625 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274268AbRISXbv>;
	Wed, 19 Sep 2001 19:31:51 -0400
Date: Thu, 20 Sep 2001 01:31:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010920013153.C720@athlon.random>
In-Reply-To: <20010919232818.T720@athlon.random> <Pine.LNX.4.33.0109191611550.2507-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109191611550.2507-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Sep 19, 2001 at 04:16:13PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 04:16:13PM -0700, Linus Torvalds wrote:
> 
> On Wed, 19 Sep 2001, Andrea Arcangeli wrote:
> >
> > On Wed, Sep 19, 2001 at 08:42:39PM +0100, Hugh Dickins wrote:
> > > --- 2.4.10-pre12/mm/swap_state.c	Wed Sep 19 14:05:54 2001
> > > +++ linux/mm/swap_state.c	Mon Sep 17 06:30:26 2001
> > > @@ -23,6 +23,17 @@
> > >   */
> > >  static int swap_writepage(struct page *page)
> > >  {
> > > +	/* One for the page cache, one for this user, one for page->buffers */
> > > +	if (page_count(page) > 2 + !!page->buffers)
> >
> > this is racy, you have to spin_lock(&pagecache_lock) before you can
> > expect the page_count() stays constant. then after you checked the page
> > has count == 1, you must atomically drop it from the pagecache so it's
> > not visible anymore to the swapin lookups.
> 
> No.
> 
> Note how it is a _heuristic_ only. The "safe" answer is always to say "the
> page is in use", and note that once the page_count has dropped to 2 or
> less, it won't increase unless somebody else has a swap count..

the "somebody else has a swap count" is interesting. so we rely on the
fact any swap_duplicate is always run before the swapcache is unlocked.

Also the "> 2" should be "> 1", but really I noticed I cannot avoid
getting a reference so please apply also this patch instead of replacing
"> 2" with "> 1" (it was a race condition):

--- 2.4.10pre11aa1/mm/vmscan.c.~1~	Tue Sep 18 21:23:49 2001
+++ 2.4.10pre11aa1/mm/vmscan.c	Thu Sep 20 01:29:58 2001
@@ -415,7 +415,10 @@
 				spin_unlock(&pagemap_lru_lock);
 
 				ClearPageDirty(page);
+
+				page_cache_get(page);
 				writepage(page);
+				page_cache_release(page);
 
 				spin_lock(&pagemap_lru_lock);
 				continue;


> And we check for the "somebody else has a swap count" two lines lower.

I see.

> Do you see anything wrong with that logic?

Looks ok now :), I guess it would be good to write a comment now, so
maybe other people won't share my worry, the swap_count thing wasn't
very obvious. thanks,

Andrea
