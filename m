Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTL0P6M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 10:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTL0P6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 10:58:12 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52914
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264489AbTL0P6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 10:58:09 -0500
Date: Sat, 27 Dec 2003 16:58:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohit.seth@intel.com>
Subject: Re: 2.6.0 Huge pages not working as expected
Message-ID: <20031227155816.GH1676@dualathlon.random>
References: <20031226105433.GA25970@axis.demon.co.uk> <20031226115647.GH27687@holomorphy.com> <20031226201011.GA32316@axis.demon.co.uk> <Pine.LNX.4.58.0312261226560.14874@home.osdl.org> <20031227033620.GG1676@dualathlon.random> <Pine.LNX.4.58.0312261956510.14874@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312261956510.14874@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 08:01:57PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 27 Dec 2003, Andrea Arcangeli wrote:
> > 
> > well, at least on the alpha the above mode = 1 is reproducibly a lot
> > better (we're talking about a wall time 2/3 times shorter IIRC) than
> > random placement. The l2 is huge and one way cache associative,
> 
> What kind of strange and misguided hw engineer did that?

;)

> I can understand a one-way L1, simply to keep the cycle time low, but 
> what's the point of a one-way L2? Braindead external cache controller?

dunno, though if you implement the cache coloring with that algorithm I
it run fast compared to other archs. No idea how much hardware gain one
can get with an huge one way set associative cache (with some help from
the OS to ensure it's all used and not trashed) if compared to a (tiny)
16-way associative cache.

> 
> > The current patch is for 2.2 with an horrible API (it uses a kernel
> > module to set those params instead of a sysctl, despite all the real
> > code is linked into the kernel), while developing it I only focused on
> > the algorithms and the final behaviour in production. the engine to ask
> > the allocator a page of the right color works O(1) with the number of
> > free pages and it's from Jason.
> 
> Does it keep fragmentation down?
> 
> That's the problem that Davem had in one of his cache-coloring patches: it
> worked well enough if you had lots of memory, but it _totally_ broke down
> when memory was low. You couldn't allocate higher-order pages at all after
> a while because of the fragmented memory.

what can happen is that you've a leaf at order 0 but you don't take it
and you split some order 1-MAX_ORDER page instead to get an order 0 of the
right color (same can happen with order 1 vs order 2-MAX_ORDER). So yes,
it can fragment the memory more quickly, but the very same fragment
patterns can happen w/o page coloring, it's just quicker to get into a
fragmented state.

However it defragments down perfectly if two contigous order 0 pages are
free, no difference in such case, it's just that you may end with more
non mergeable order 0 pages more quickly, but it's all quite random and
I never heard problems about that. The kernel must free cache and
possibly swap too if it fails order > 0 allocations anyways, or the
order 1 could not succeed. the swapping/cache-shrinking basically
relocates the right colored pages into non right colored pages until the
defragmentation happened.

it should be simple to add a very weak mode (the opposite of the strict
mode) that forbids the color aware allocator to split an high order page
if there's at least one page already available of the right order. That
would provide an even lesser guarantee of right coloring though. that
could be the same as non coloring at all in practice, that's why I
probably not even considered it till today. It's probably simpler to
disable it via sysctl than to implement this "weak" mode.
