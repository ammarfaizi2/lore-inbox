Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUDCRY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 12:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUDCRY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 12:24:27 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14781
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261615AbUDCRYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 12:24:25 -0500
Date: Sat, 3 Apr 2004 19:24:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: anon-vma (and now filebacked-mappings too) mprotect vma merging [Re:    2.6.5-rc2-aa vma merging]
Message-ID: <20040403172426.GJ2307@dualathlon.random>
References: <20040403012612.GY21341@dualathlon.random> <Pine.LNX.4.44.0404031727320.10197-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404031727320.10197-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 06:06:49PM +0100, Hugh Dickins wrote:
> It does look more complicated than I'd hoped, a lot of that coming from
> the file-backed merging: which I like, but, we could have done it at
> any point over the last couple of years if someone had a need for it.
> Fair enough, you've discovered a need, at the same time that you have
> to attend to vm_pgoff for anons, so it makes sense to do them together.

the point is that *nobody* has a need for it, nor for the anonymous, nor
for the filebacked mappings. It's just an "optimization", not a real
need.

You're right it's not trivial, but as you can see 95% of the complexity
comes from the filebacked merging, the anon-vma merging adds up to 5% of
the complexity (i.e. calling is_mergeable_anon_vma before proceeding and
then calling anon_vma_merge while nuking the superflous vma).

> Do you realize that you could allocate just a single anon_vma to
> the mm at fork time, for all the pure anon vmas created in it later?
> And then no need for propagating anon_vma from adjacent vma, they'd
> all have the right one already and be mergeable anyway.  But I think
> you'll reject that on two grounds: you want to merge the file-backed
> vmas as much as is reasonable, so you need the code anyway for them;
> and you'd prefer your anon_vma lists to be as short as possible, to
> minimize searching at page_referenced/try_to_unmap time.
> 
> Clearly there's a tension between keeping the anon_vma lists short,
> and leaving the vmas mergable: it's natural that we should differ on
> where to strike that balance, having come to it from opposite ends.

exactly. the cost of the anonvmas is absolutely non measurable, so while
it makes sense to share the sane anon_vma for adiancent mappings that
differs only for the page protection flags, I don't want to share
anything else to boost the reverse lookup performance. I want it as
finegrined as possible, not just to have few vmas, but also to track
_only_ the interesting MM in the group, something anonmm will never be
able to do, except when the page has mapcount == 1. Sharing the same
anon_vma for everything would just slowdown the lookup, in practice
there would be no more merging at all. I believe being as finegrined as
possible will payoff, maybe one day we may even be ok to pay for some
more byte in the vma for a prio_tree on top of the anon_vma, to speedup
the lookup as much as possible (today it would only waste ram IMO). Plus
I love being able to handle mremap trasparently by-design. The ugliness
of doing a swapin + copy and calling handle_mm_fault in mremap is pretty
bad IMO. some more byte per-vma is not a problem and it'll never be
noticeable, just like not merging non adiacent mappings will never be
noticeable. So I believe the few bytes per vma are worth it, plus now it
does filebacked mprotect merging too.
