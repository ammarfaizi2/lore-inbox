Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281513AbRKRG3i>; Sun, 18 Nov 2001 01:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281531AbRKRG33>; Sun, 18 Nov 2001 01:29:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281513AbRKRG3U>; Sun, 18 Nov 2001 01:29:20 -0500
Date: Sat, 17 Nov 2001 22:24:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <ehrhardt@mathematik.uni-ulm.de>, <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <20011118051023.A25232@athlon.random>
Message-ID: <Pine.LNX.4.33.0111172220300.1290-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Nov 2001, Andrea Arcangeli wrote:
>
> I also agree the patch shouldn't matter, but one suspect thing is the
> fact add_to_swap_cache goes to clobber in a non atomic manner the page
> lock.

.. you mean __add_to_page_cache(), not add_to_swap_cache().

And nope, not really. It does use plain stores to page->flags, and I agree
that it is ugly, but if the page was locked before calling it, all the
stores will be with the PG_lock bit set - and even plain stores _are_
documented to be atomic on x86 (and on all other reasonable architectures
too).

> so yes, we hold the page lock both in swap_out and in
> shrink_cache, but swap_out can drop it for a moment and then later
> pretend to be the onwer again without a real trylock.

No, it doesn't get dropped for a moment. The bit is always set, and
somebody else who tries to lock the page will never see it clear, and can
never succeed in locking it.

Is the __add_to_page_cache() playing with the page flags ugly? It sure is.
I'd _almost_ call it buggy, but not because of PG_locked, but because of
all the other bits it does horrible things to. It's one of those
borderline cases, but I don't think it's borderline wrt the lock bit.

		Linus

