Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274262AbRISXRj>; Wed, 19 Sep 2001 19:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274260AbRISXR3>; Wed, 19 Sep 2001 19:17:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55056 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274261AbRISXRM>; Wed, 19 Sep 2001 19:17:12 -0400
Date: Wed, 19 Sep 2001 16:16:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: pre12 VM doubts and patch
In-Reply-To: <20010919232818.T720@athlon.random>
Message-ID: <Pine.LNX.4.33.0109191611550.2507-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Sep 2001, Andrea Arcangeli wrote:
>
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

No.

Note how it is a _heuristic_ only. The "safe" answer is always to say "the
page is in use", and note that once the page_count has dropped to 2 or
less, it won't increase unless somebody else has a swap count..

And we check for the "somebody else has a swap count" two lines lower.

(And the swap count is stable at 1 while the page is locked, because
nobody can increase the swap count without locking the page and dropping
it from their VM).

Do you see anything wrong with that logic?

			Linus

