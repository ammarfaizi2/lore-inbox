Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277559AbRJ3TX5>; Tue, 30 Oct 2001 14:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277598AbRJ3TXq>; Tue, 30 Oct 2001 14:23:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46597 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277559AbRJ3TXk>; Tue, 30 Oct 2001 14:23:40 -0500
Date: Tue, 30 Oct 2001 11:21:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: need help interpreting 'free' output.
In-Reply-To: <20011030195828.X1340@athlon.random>
Message-ID: <Pine.LNX.4.33.0110301117220.12145-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
>
> So in short we only need to replace the lock_page with a TryLockPage
> (plus your wait_on_page if page is not uptodate to catch the major
> faults) and here we go, faster than pre5.

Wrong.

If _anybody_ accesses the page unlocked, you cannot do the swap_count() at
all, because then you don't have anything that serializes the accesses to
swap_count vs page_count any more.

Sure, it will _look_ like it is working (because 99.9% of the time we tend
to have exclusive pages anyway), but the fact is that the old scheme
_depended_ on swap_in getting the page lock - not just for testing, but
for everybody else who wasn't even _interested_ in testing, but just
wanted to increment the page could and decrement the swap count.

See?

Do you _now_ understand why pre5 does this atomically? It needs to test
the swap count _and_ the page count atomically under the same lock.

The page lock ha NOTHING to do with anything. If we ever have any user
that does not take the page lock (and you now seem to realize why we want
to have such users), the pagelock is WORTHLESS, because suddenly it
doesn't end up protecting the counts at all.

So making it a trylock doesn't help. See?

			Linus

