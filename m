Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277512AbRJ3Sab>; Tue, 30 Oct 2001 13:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277509AbRJ3SaW>; Tue, 30 Oct 2001 13:30:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277512AbRJ3SaR>; Tue, 30 Oct 2001 13:30:17 -0500
Date: Tue, 30 Oct 2001 10:28:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: need help interpreting 'free' output.
In-Reply-To: <20011030191612.S1340@athlon.random>
Message-ID: <Pine.LNX.4.33.0110301017240.12018-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
> > delete it. So the logic might be something like
> >
> > 	remove = 0;
> > 	if ((vm_swap_full() && (remove = exclusive_swap_cache_delete())) ||
> > 	    only_swap_user()) {
>
> I preferred the previous exclusive_swap_page logic. It couldn't race
> because we had the lock on the page, it's equivalent

It is _not_ equivalent.

Think for five seconds about what you just wrote..

   "It couldn't race because we had the lock on the page.."

In short: the old code needed to get the page lock. In fact, it needed to
get the page lock even for reads that don't need it at all - only because
there could be a write from another process that shared the swap page.

Ie we optimized for the very very uncommon case. Sharing swap pages is
uncommon in itself, and it only happens when they _really_ aren't accessed
over a fork() etc. In short, writing the code to deal with that by default
is the wrong optimization.

Now, the _common_ case is that the page is truly exclusive, and you don't
want to lock the page - because locking the page means that you can pause
for a _long_ time waiting for the page to be written out when there is IO
pending.

This is especially true since we need to get the swap device lock
_anyway_, so locking the page is (a) inefficient and (b) overkill.

The new re-org gets no new locks, and drops the page lock, allowing people
to do the optimization without holding the page locked, which in turn
means that you don't need to wait for potential IO to complete just to
read a value from a page that you already have in memory.

> if we remove all write-swapins from the swap cache those pages cannot be
> in flight,

What?

The page is busy being written out by another process - the page is locked
but up-to-date. We have _no_ reason to not give it immediately.

This is something we do for all page cache pages - go read
filemap_nopage() etc. They don't wait for data that is up-to-date.

> So I don't see how an anonymous page can be in flight.

It's being swapped out. What's so hard to see about that? Look at
mm/vmscan.c: writepage-> swap_writepage().

The page is up-to-date but locked (it's obviously up-to-date, or we
wouldn't be able to write it out). It won't be unlocked until the IO has
completed, which is, under heavy swap load, easily half a second. Why do
you want to wait for that?

			Linus

