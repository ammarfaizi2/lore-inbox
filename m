Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316042AbSETORy>; Mon, 20 May 2002 10:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSETORx>; Mon, 20 May 2002 10:17:53 -0400
Received: from [195.223.140.120] ([195.223.140.120]:57104 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316042AbSETORv>; Mon, 20 May 2002 10:17:51 -0400
Date: Mon, 20 May 2002 16:15:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
Message-ID: <20020520141523.GB21806@dualathlon.random>
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020520043040.GA21806@dualathlon.random> <3CE887CE.80E08048@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 10:21:18PM -0700, Andrew Morton wrote:
> I've seen a vague report from the IBM team which indicates that -aa VM does
> not solve the ZONE_NORMAL-full-of-buffer_heads lockup.  The workload was
> specweb on a 16 gig machine, I believe.

I didn't see any bugreport, could you pass it over. I was confident such
bug is gone since a few weeks but of course if there are still problems
I'd like to know.

Note also that if the excessive number of bh is due rawio or O_DIRECT
that's not a VM issue.

> I did a quickie patch early this month which simply strips buffers
> away from pages at each and every opportunity - that fixed it of
> course.  At the end of the run, ZONE_NORMAL had 250 MB free, as
> opposed to zero with 2.4.18-stock.
>
> I think this is a better approach than memclass_related_bhs().
> Because it proactively makes memory available in ZONE_NORMAL
> for blockdev pages.  If we minimise the amount of memory which
> is consumed by buffer_heads then we maximise the amount of
> memory which is available to inodes and indirects.   Sure,

With memclass_related_bhs() we automatically maximixed the amount of ram
available as inodes/indirects and everything else ZONE_NORMAL, after
that you can consider all the unlocked bh as free memory, just like if
it was other cache. The whole point of memclass_related_bhs is that it
renders the bh an atomically shrinkable cache, so we can left it there
until we run low in lowmem, then we will shrink them just fine. Actually
I see it would be better to start freeing the bh than the zone_normal
memory, the cache in the zone_normal is more important, so you may argue
about page replacement decisions, but the VM should just work correctly
as if the bh are free.

> the buffers cache the disk mapping.  But the inodes and indirects
> cache the same information which *much* better packing density.
> Sure, there's some extra CPU cost in reestablishing the mapping,
> but in the no-buffer_heads testing I'm doing on 2.5 it is unmeasurable.
> 
> Currently, we're effectively allowing buffer_heads to evict useful
> pagecache data.  We have to perform additional I/O to get that back.
> 
> In other words: once we've finished I/O, just get rid of the
> damn things.   Bit radical for 2.4 maybe.

Well, I'm doing a superset of that at the moment, I drop it and I also
know when it's the time to do it. So to implement the "drop lazily any
bh ASAP" it would be a matter of a few liner, can do that, I'm only a
bit worried that the thing become measurable in some overwrite intensive
workload. We would introduce additional not scalable get_blocks in the
overwrite paths. But overall I agree with you it's probably most
certainly worse to shrink the normal pagecache, but my solution
guarantees no runtime difference for example in a zone_normal machine.
Also in 2.5 you shrunk the bh quite a bit so it's a lighter entity to
refill.

Anyways the point is that you shouldn't run out of normal zone anymore
and non highmem won't see any change in the behaviour with the
highmem/bh balance fix. If this is not the case that is the real
problem, everything else is a performance optimization.

One bad thing actually is that if there's somebody re-reading endlessy
the page and constantly keeping it in the active list, such page may
keep the bh allocated for no good reasons, but again, if there are too
many bh pinned that way eventually we'll get more aggressive against the
active list so it would(/should) be again mostly a performnace issue.

> > ...
> > 
> > About rmap design I would very much appreciate if Rik could make a
> > version of his patch that implements rmap on top of current -aa
> 
> That would be good to see.  I believe Rik is offline for a week

Indeed. A strict rmap patch would also make it easier an integration in
2.5, I think rmap like -preempt O(1) scheduler, your bio based async
flushed rewrite following the inodes then the dirty pages in the inode,
and all the other non-showstopper issues (unlike pte-highmem, vm fixes
etc..) are one of the ideal items to research during 2.5, I don't think
it makes much sense to keep them on top of 2.4.

> or three, so he may not see your words.

Ok. We CC'ed Rik so I assume it won't get lost in the mail flood.

Andrea
