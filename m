Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279725AbRJ3BZi>; Mon, 29 Oct 2001 20:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279723AbRJ3BZ2>; Mon, 29 Oct 2001 20:25:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4874 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279715AbRJ3BZQ>; Mon, 29 Oct 2001 20:25:16 -0500
Date: Mon, 29 Oct 2001 17:23:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: do_swap_page() in -pre4
In-Reply-To: <3BDDE188.766CF4BB@zip.com.au>
Message-ID: <Pine.LNX.4.33.0110291711290.7733-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, Andrew Morton wrote:
> Linus Torvalds wrote:
> >
> > On Mon, 29 Oct 2001, Andrew Morton wrote:
> > >
> > > That UnlockPage() looks wrong to me?
> >
> > You're right. I'll fix it and make a pre5, it's obviously left-overs from
> > before..

pre5 fixed (along with some other things, like remobing from the LRU list
in all cases where needed..)

> OK.  Could you please add mm->page_table_lock to this comment:
>
> + *
> + * Ordering:
       mm->page_table_lock ->
> + *     swap_lock ->
	    swap_device_lock() ->
> + *             pagemap_lru_lock ->
> + *                     pagecache_lock

is what it should be. If that doesn't look right, holler.

I don't think any other locking really changed, except the LRU and the
pagecache lock used to be the other way around.

Oh, the thing that _did_ change was that getting the page lock used to
also freeze the swap_map count for that page. Which meant much too much
locking of pages on swapin (which in turn meant that you couldn't just
re-attach the page while it was being written out).

pre5 makes the new rules clearer, I think (ie we check the swap count
under the swap lock, and we check the page count under the pagecache lock,
so there should be no "subtle" rules wrt the page lock at all. The page
lock has no bearing on the swap count at all).

I've tested pre5 by running X and konqueror in 40MB of RAM, and I tested
pre4 by swapping heavily in 2GB or ram (which only goes to show you how
forgiving 2G is even if you have almost 3BG in swap - the UnlockPage and a
few other things were very clear in 40MB and never showed up with tons
of memory).

It behaves well here, although in the low-memory tests I think there I've
found what appears to be a KDE process startup race condition (ie KDE is
not happy about swapping heavily and starting new processes - looks like
the communication setup is racy or something).

Testers appreciated,

		Linus

