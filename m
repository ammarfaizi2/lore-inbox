Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUKBBve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUKBBve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270335AbUKAX3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:29:44 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:5353 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S376422AbUKAWY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:24:59 -0500
Date: Mon, 1 Nov 2004 23:24:43 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin J Bligh <mjbligh@us.ibm.com>
Subject: Re: PG_zero
Message-ID: <20041101222443.GF3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418671AA.6020307@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 04:26:02AM +1100, Nick Piggin wrote:
> Not sure if this is wise. Reclaimed pages should definitely be cache
> cold. Other freeing is assumed cache hot and LRU ordered on the hot
> list which seems right... but I think you want the cold list for page
> reclaim, don't you?

I retain hot and cold info in the same list. That avoids wasting ram.

I call it hot-cold quicklist.

> Could the API be made nicer by clearing the page for you if it didn't
> find a PG_zero page?

That's what get_zeroed_page is already doing with my patch applied, I
natively and trasparently support the feature via the API already
existing for it (and it also makes sure to clear PG_zero since there's
no guarantee that the user will free the page after clearing it again).

> I have the feeling that it might not be worthwhile doing zero on idle.

yes, it only boost 200% one workload, for the rest it seems a noop, but
I'm very far from being memory bound on my test boxes. the sysctl will
disable it at runtime, we can make it enabled or disabled by default by
tweaking the static setting to 1 or to 0 at compile time.

> You've got chance of blowing the cache on zeroing pages that won't be
> used for a while. If you do uncached writes then you've changed the
> problem to memory bandwidth (I guess doesn't matter much on UP).

normally the cpu is really perfectly idle, only in a few cases we clear
pages and it starts clearing the hot caches first. Plus the refiling may
find already PG_zero pages from the buddy and it will not do any
clearpage at all.

> It seems like a good idea to do zero pages in the page allocator if
> at all (rather than slab), but I guess you don't want to complicate
> it unless it shows improvements in macro benchmarks.
> 
> Sorry my feedback isn't much, it is not based on previous experience.

I serously doubt any previous experience is any similar to what I've
implemented, but I completely missed any previous experience (probably
because I was doing mostly 2.4 work when you were developing 2.5), so I
may be completely wrong, but certainly lots of things are going wrong in
the current per-cpu lists and those are all fixed, plus this is mostly
for the pte_quicklist that has been dropped by mistake from 2.6 (just
got a compliant for it from SGI saying latency is too high, and that's
what driven me at doing PG_zero, to close that bug but underway I found
many more wrong things, and eventually I figured out the only design I
would ever let my cpu use to do idle zeroing on top of what I already
implemented, but I certainly agree that's the least interesting part of
the patch).
