Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSEVWhu>; Wed, 22 May 2002 18:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSEVWhu>; Wed, 22 May 2002 18:37:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55109 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315162AbSEVWhr>; Wed, 22 May 2002 18:37:47 -0400
Date: Thu, 23 May 2002 00:35:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        riel@surriel.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020522223512.GN21164@dualathlon.random>
In-Reply-To: <384590000.1022102334@flay> <Pine.LNX.4.33.0205221421180.1531-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 02:23:39PM -0700, Linus Torvalds wrote:
> 
> On Wed, 22 May 2002, Martin J. Bligh wrote:
> > 
> > If we could get the apps (well, Oracle) to co-operate, we could just use
> > clone ;-) Having this transparent for shmem segments would be really nice.
> 
> The thing is, we won't get Oracle to rewrite a lot for a completely
> threaded system. And clone does _not_ come with a way to share only parts

actually not using threads also provides a bit more of protection across
the different ""threads"", but OTOH the shm part could be corrupted
anyways if there's a bug.

> of the VM, and never will - that's fundamentally against the way "struct 
> mm_struct" works. 
> 
> Oracle is apparently already used to magic shmem-like things, so doing 
> that is probably acceptable to them.

For x86 using largepages is the first prio, the relevance of sharing
pagetables is near to nothing compared to 4M pages.  As HPA said at the
last kernel summit during the commetary of either the VM or the Oracle
speech (and I'm not sure if everybody understood what he said), without
PAE 4M pages just provides shared pagetables because there's nothing
anymore to share, and no the pgd cannot be shared because the fact is
not clone() is our problem since the first place.

With PAE there's to share the pmd but if you actually do the math the
pmd for a worth of 3G of address space the pmd is 12k per task,
it doesn't really matter at all, with 4000 tasks all mapping the same
1.5G shm segment the amount of sharable pmd memory is reduced to
24Mbytes, who cares about 24Mbytes with 4000 tasks working on 1.5G of
ram each (in particular with a much more powerful tlb caching on such
ram virtual addresses)? At the very least it is a very secondary
interest, and it cannot make differnces at all without PAE.

On x86-64 as well we use a single top level pte for all the tasks (only
the first top level entry changes in the mm switches) so again using 2M
pages would be more than enough there too as much as in x86 PAE (like if
x86-64 would be 3 level pages like PAE x86). Of course there we can go
way above 1.5G of shm mapped per task, so at some point as the shm size
incrase, the pmd sharing may get more relevance but I don't see it as a
short term issue at least.

As last thing, we'll also need to enforce a large enough MAX_ORDER to be
able to allocate 2/4M pages, I hoped we could turn it down and to save
cpu cycles as soon as all the hashtable allocations will be finally
rewritten to use the bootmem allocator, and that won't be possible
anymore, but it's not a showstopper, desktops are idle all the time
anyways.

Andrea
