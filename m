Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbTCaEQb>; Sun, 30 Mar 2003 23:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbTCaEQb>; Sun, 30 Mar 2003 23:16:31 -0500
Received: from holomorphy.com ([66.224.33.161]:45503 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261404AbTCaEQ3>;
	Sun, 30 Mar 2003 23:16:29 -0500
Date: Sun, 30 Mar 2003 20:27:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030331042729.GQ30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030330231945.GH2318@x30.local>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 01:19:45AM +0200, Andrea Arcangeli wrote:
> Didn't you break the linux x86 ABI in mmap? the file offset must be a
> multiple of the softpagesize and binary apps can break with -EINVAL with
> pgcl. The workaround is to allocate it in anon mem but it's not coherent
> if somebody does a change to the binary with MAP_SHARED, so still broken
> semantics. In theory we could also have aliasing in the cache, but it
> doesn't seem a good idea.

No, that's why it's nontrivial. Otherwise it'd be something like
linux-vax' VPAGE_SIZE vs. PAGE_SIZE. I (and Hugh before me) went
around fixing up pagetable walks and various other things so that they
understand they're looking at pieces of pages instead of whole pages in
order to preserve EXEC_PAGE_SIZE and ABI compatibility.

I can answer more questions about what goes on to make this happen if
need be.


On Mon, Mar 31, 2003 at 01:19:45AM +0200, Andrea Arcangeli wrote:
> Since you have access to such a machine, can you please try to boot
> 2.4.21pre5aa2 on such a machine? That must boot just fine too according
> to my math, however, there will be little normal zone left, compared to
> your kernel with pgcl. But 700M of normal zone are still nothing versus
> the 64G of ram, what I mean is that even pgcl isn't guaranteeing general
> purpose usability of the box (despite making it much more usable).

It seems to do well with AIM7 with 10000 tasks, so I'm happy. I can
trigger the usual suite of issues with excessive numbers of open files
and various vfs caches bloating beyond reason, but it's unrelated to
pgcl itself and I've made as much room as is possible in a 3/1 split.

I literally have to justify the time used on this kind of hardware for
such exercises (in fact, everything I do on the things), so there had
better be a compelling reason to believe it will be usable and
meaningful for me to ask for more time on it to do that. There are some
very high costs associated with putting these things together even if
only temporarily.

I'm relatively skeptical the case for 2.4.x testing will be considered
compelling enough, especially as 2.4 distro trees are declining in
importance in anticipation of 2.6-based distros, and especially as the
timeline for this affair is expected to stretch out to a long while
from now, most likely until after 2.6.0 release.


On Mon, Mar 31, 2003 at 01:19:45AM +0200, Andrea Arcangeli wrote:
> Note that 2.5 mem_map is bigger due rmap, my 2.4 w/o the rmap slowdown
> should boot just fine w/o pgct that breaks the linux x86 ABI and in turn
> binary apps at runtime.

It doesn't break ABI, so I'm not terribly concerned. The single largest
component to it and why it is difficult is ensuring it doesn't break ABI.

The rmap bits seem to make page replacement behave quite well (not that
these kinds of machines really want to do page replacement at all), and
they don't seem to bite even with 10000 full-blooded processes given the
latest suites of pagetable handling speedup patches available, so I'm
not worried much about them.

And I think I can stop worrying about the size of struct page now that
I can shrink mem_map[] by (almost) arbitrary power of 2 constant factors.


On Mon, Mar 31, 2003 at 01:19:45AM +0200, Andrea Arcangeli wrote:
> I believe pgcl is very interesting for x86 long term, and for all archs
> not providing a flexible hard-page-size. The larger softpagesize can
> increase performance, 4k page size is too small these days, especially
> on a 64bit arch, infact this softpagesize feature would be most
> interesting for x86-64 even in the long term (for a totally different
> reason of why you find it most interesting today on the 32bit x86 64G
> boxes ;). so it sounds like a good thing to have for mainline >=2.5
> regardless. All it matters is that you don't try to make the page
> allocator returning anything smaller than the softpagesize to avoid
> losing reliability of allocations for core data structures.

PAGE_SIZE is the allocation unit and none of that is changed so we're
safe with respect to allocation reliability. There are enough other
benefits of this, for instance, larger filesystem blocksize support and
(well, not sure how it pans out in practice) some prefaulting benefits
for it to be of wider interest than highmem support.


-- wli
