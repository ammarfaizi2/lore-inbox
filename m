Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUCTOZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263421AbUCTOZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:25:07 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4816
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263419AbUCTOZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:25:00 -0500
Date: Sat, 20 Mar 2004 15:25:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-ID: <20040320142550.GK9009@dualathlon.random>
References: <20040318230628.GA2050@dualathlon.random> <Pine.LNX.4.44.0403200833150.30298-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403200833150.30298-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 08:35:52AM -0500, Rik van Riel wrote:
> On Fri, 19 Mar 2004, Andrea Arcangeli wrote:
> 
> > the problem is that they will still not be mergeable if we obey to the
> > vm_pgoff. We could merge some more though. The other main issue is the
> > search in this single object for all mm, that has again the downside of
> > searching all mm. I keep track of exactly which mm to track instead,
> 
> If you read Hugh's latest code, you'll find that for all the
> non-shared pages, his code only looks at 1 mm too ...

I agree this optimization will cover the common case, that's a nice
improvement compared to the old patches.

still this doesn't solve the mremap of a shared cow region (not a direct
one), how is that solved in Hugh's current patch? Is he implementing
Linus's suggested unsharing? I don't see it implemented so I wonder how
can he swap those regions. Is that like an mlock right now?

> > But I certainly agree we could mix the two things and have 1 anon_vma
> > object per-mm instad of per-vma by losing some granularity in the
> > tracking and making the search more expensive, but then we'd need a
> > prio_tree there too and that doesn't come for free either, so I'd rather
> > spend the 12 bytes for the finegrined tracking, the prio_tree can't get
> > right which mm to scan and which not for every page, the current
> > anon_vma can.
> 
> Note that this disadvantage only holds true for pages that
> are shared between multiple processes, but not all of the
> processes in a fork group. The non-shared pages are found
> immediately with Hugh's code, so I suspect this shouldn't
> be a big disadvantage any more.
> 
> Also, we'll need the prio_tree anyway for file backed stuff.

I don't need a tree for the swapping efficiently with anon_vma (not even
the rbtree lookup with find_vma). I believe in practice anon_vma is the
most efficient design for swapping anonymous memory. If Martin can show
anon_vma slower than anonmm (in the non-swap case of SDAT bench) then I
can change my mind about it, at the moment I believe it'll not be
slower.

Also you're not going to share the same prio_tree code for the anonmm
and the inode, there's no meaningful vm_pgoff in the anonmm design.

As for the parts Hugh's claims sharable, I much prefer my
implementation, he also still leaves some PG_anon outside the
PG_map_lock, I'm quite confortable with my implementation being rock
solid, I find it simpler too (i.e. absolutely nothing to do in mremap).
I also run lots of regression tests already, the only pending bug is
Jens's device driver bug in ->nopage, that I'm asking about on l-k for
confirmation.
