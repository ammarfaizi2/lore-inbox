Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbUB0TJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbUB0TJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:09:30 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:36692 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262939AbUB0TIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:08:34 -0500
Date: Fri, 27 Feb 2004 14:08:28 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
In-Reply-To: <20040227173250.GC8834@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, let me start with one simple request.  Whatever you do,
please send changes upstream in small, manageable chunks so we
can merge your improvements without destabilising the kernel.

We should avoid the kind of disaster we had around 2.4.10...

On Fri, 27 Feb 2004, Andrea Arcangeli wrote:

> Then Andrew pointed out that there are complexity issues that objrmap
> can't handle but I'm not concerned about the complexity issue of objrmap
> since no real app will run into it

We've heard the "no real app runs into it" argument before,
about various other subjects.  I remember using it myself,
too, and every single time I used the "no real apps run into
it" argument I turned out to be wrong in the end.

> So my current plan is to do objrmap for all file mappings first

If this can be integrated cleanly without too many bad corner
cases, sure ...

> then convert remap_file_pages to do the pagetable walk instead of
> relying on rmap,

I'm not convinced, though that could also be because I'm not
sure exactly what you're planning.  I'll start arguing for
or against your changes here once I know exactly what they'll 
look like ;)

> then I can go further and add a dummy inode for anonymous mappings too
> during COW like DaveM did originally. Only then I can remove rmap
> enterely. This last step is somewhat lower prio.

Moving to a full objrmap from the current pte-rmap could well
be a good thing from a code cleanliness perspective.

I'm not particularly attached to rmap.c and won't be opposed
to a replacement, provided that the replacement is also more
or less modular with the VM so plugging in an even more
improved version in the future wil be easy ;)

> in small machines the current 2.4 stock algo works just fine too, it's
> only when the lru has the million pages queued that without my new vm
> algo you'll do million swapouts before freeing the memleak^Wcache.

Same for Arjan's O(1) VM.  For machines in the single and low
double digit number of gigabytes of memory either would work
similarly well ...

> > Then again, your stuff will also find pages the moment they're
> > cleaned, just at the cost of a (little?) bit more CPU time.
> 
> exactly, that's an important effect of my patch and that's the only
> thing that o1 vm is taking care of, I don't think it's enough since the
> gigs of cache would still be like a memleak without my code.

... however, if you have a hundred gigabyte of memory, or
even more, then you cannot afford to search the inactive
list for clean pages on swapout. It will end up using too
much CPU time.

The FreeBSD people found this out the hard way, even on
smaller systems...

> > Shouldn't be too critical, unless you've got more than maybe
> > a hundred GB of memory, which should be a year off.
> 
> I think these effects starts to be visible over 8G, the worst thing is
> that you can have 4G in a row of swapcache, in smaller systems the
> lru tends to be more intermixed.

I've even seen the problem on small systems, where I used a
"smart" algorithm that freed the clean pages first and only
cleaned the dirty pages later.

On my 128 MB desktop system everything was smooth, until
the point where the cache was gone and the system suddenly
faced an inactive list entirely filled with dirty pages.

Because of this, we should do some (limited) pre-cleaning
of inactive pages. The key word here is "limited" ;)

> I think you mean he's using an anchor in the lru too in the same way I
> proposed here, but I doubt he's using it nearly as I would, there seems
> to be a fundamental difference in the two algorithms, with mine partly
> covering the work done by his, and not the other way around.

An anchor in the lru list is definately needed. Some
companies want to run Linux on systems with 256 GB or
more memory.  In those systems the amount of CPU time
used to search the inactive list will become a problem,
unless we use a smartly placed anchor.

Note that I wouldn't want to use the current O(1) VM
code on such a system, because the placement of the
anchor isn't quite smart enough ...

Lets try combining your ideas and Arjan's ideas into
something that fixes all these problems.

kind regards,

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

