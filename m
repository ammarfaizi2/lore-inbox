Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbUB0UcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUB0Ubx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:31:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30694
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263092AbUB0Ubc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:31:32 -0500
Date: Fri, 27 Feb 2004 21:31:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040227203131.GH8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 02:08:28PM -0500, Rik van Riel wrote:
> First, let me start with one simple request.  Whatever you do,
> please send changes upstream in small, manageable chunks so we
> can merge your improvements without destabilising the kernel.
> 
> We should avoid the kind of disaster we had around 2.4.10...

2.4.10 was great success, the opposite of a disaster.

> On Fri, 27 Feb 2004, Andrea Arcangeli wrote:
> 
> > Then Andrew pointed out that there are complexity issues that objrmap
> > can't handle but I'm not concerned about the complexity issue of objrmap
> > since no real app will run into it
> 
> We've heard the "no real app runs into it" argument before,
> about various other subjects.  I remember using it myself,
> too, and every single time I used the "no real apps run into
> it" argument I turned out to be wrong in the end.

If this is an issue, than truncate() may be running into it already. So
if you're worried about the vm usage you should worrk about truncate
usage first.

> > then I can go further and add a dummy inode for anonymous mappings too
> > during COW like DaveM did originally. Only then I can remove rmap
> > enterely. This last step is somewhat lower prio.
> 
> Moving to a full objrmap from the current pte-rmap could well
> be a good thing from a code cleanliness perspective.
> 
> I'm not particularly attached to rmap.c and won't be opposed
> to a replacement, provided that the replacement is also more
> or less modular with the VM so plugging in an even more
> improved version in the future wil be easy ;)

objrmap itself should be self contained, the patch from Martin's tree is
quite small too.

> > in small machines the current 2.4 stock algo works just fine too, it's
> > only when the lru has the million pages queued that without my new vm
> > algo you'll do million swapouts before freeing the memleak^Wcache.
> 
> Same for Arjan's O(1) VM.  For machines in the single and low
> double digit number of gigabytes of memory either would work
> similarly well ...

I don't think they would work equally well. btw the vmstat I posted was
from a 16G machine btw, where the copy was stuck because of inability to
find 2G of clean cache.

> > > Then again, your stuff will also find pages the moment they're
> > > cleaned, just at the cost of a (little?) bit more CPU time.
> > 
> > exactly, that's an important effect of my patch and that's the only
> > thing that o1 vm is taking care of, I don't think it's enough since the
> > gigs of cache would still be like a memleak without my code.
> 
> ... however, if you have a hundred gigabyte of memory, or
> even more, then you cannot afford to search the inactive
> list for clean pages on swapout. It will end up using too
> much CPU time.

I'm using various techniques so that it doesn't scan million pages in
one go, and obviously I must start swapping before the very last clean
cache is recycled. What I outlined is the concept. That is to
"prioritize on clean cache", "prioritize" doesn't mean "all and only
clean cache first".

but it's true I throw cpu at the work, but there's no other way without
more invasive changes, and the cpu load is not significant during
swapping anyways, so it's not urgent to improve the vm further in 2.4.
Just using an anchor to separate the clean scan from the dirty scan
would improve things, but that as well is low priority.

> The FreeBSD people found this out the hard way, even on
> smaller systems...

the last thing I would do is to take examples from freebsd or other
unix (not only for legal reasons).

> > > Shouldn't be too critical, unless you've got more than maybe
> > > a hundred GB of memory, which should be a year off.
> > 
> > I think these effects starts to be visible over 8G, the worst thing is
> > that you can have 4G in a row of swapcache, in smaller systems the
> > lru tends to be more intermixed.
> 
> I've even seen the problem on small systems, where I used a
> "smart" algorithm that freed the clean pages first and only
> cleaned the dirty pages later.
> 
> On my 128 MB desktop system everything was smooth, until
> the point where the cache was gone and the system suddenly
> faced an inactive list entirely filled with dirty pages.
> 
> Because of this, we should do some (limited) pre-cleaning
> of inactive pages. The key word here is "limited" ;)

correct, this is why it's not a full scan, I provide a sysctl to tune
that and it's called vm_cache_scan_ratio as I wrote in the original
email. If it doesn't swap enough increasing the sysctl will swap more.

> > I think you mean he's using an anchor in the lru too in the same way I
> > proposed here, but I doubt he's using it nearly as I would, there seems
> > to be a fundamental difference in the two algorithms, with mine partly
> > covering the work done by his, and not the other way around.
> 
> An anchor in the lru list is definately needed. Some
> companies want to run Linux on systems with 256 GB or
> more memory.  In those systems the amount of CPU time
> used to search the inactive list will become a problem,
> unless we use a smartly placed anchor.
> 
> Note that I wouldn't want to use the current O(1) VM
> code on such a system, because the placement of the
> anchor isn't quite smart enough ...

this was my point about the o1 vm, making the placement of the anchor is
very non obvious, the idea itself sounds fine.

> 
> Lets try combining your ideas and Arjan's ideas into
> something that fixes all these problems.

So you here agree they're different things. Not sure if my idea is the
best for the long run either, but certainly it's needed in 2.4 to handle
such load and an equivalent solution (o1 vm is not enough IMO) will be
needed in 2.6 as well. The basic idea behind my patch may be the right
one for the long term though. However this is all low prio for 2.6 at
the moment and I didn't even list this part in the roadmap, because
first I need to avoid the rmap lockup before the machine start swapping
then I can think about this. (as far as I keep swapoff -a this is not an
issue)
