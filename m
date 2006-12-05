Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968547AbWLESKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968547AbWLESKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968549AbWLESKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:10:16 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:51642 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968547AbWLESKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:10:14 -0500
Date: Tue, 5 Dec 2006 18:10:11 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that may be migrated
Message-ID: <20061205181010.GD20614@skynet.ie>
References: <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org> <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org> <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com> <20061204120611.4306024e.akpm@osdl.org> <Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com> <20061204131959.bdeeee41.akpm@osdl.org> <Pine.LNX.4.64.0612041337520.851@schroedinger.engr.sgi.com> <20061204142259.3cdda664.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061204142259.3cdda664.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/12/06 14:22), Andrew Morton didst pronounce:
> On Mon, 4 Dec 2006 13:43:44 -0800 (PST)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > On Mon, 4 Dec 2006, Andrew Morton wrote:
> > 
> > > What happens when we need to run reclaim against just a section of a zone?
> > > Lumpy-reclaim could be used here; perhaps that's Mel's approach too?
> > 
> > Why would we run reclaim against a section of a zone?
> 
> Strange question.  Because all the pages are in use for something else.
> 

Indeed. If trying to get contiguous pages, we would need to reclaim within a
PFN range. However, lumpy-reclaim will be doing something like that already
so the code can be reused.

> > > We'd need new infrastructure to perform the
> > > section-of-a-zone<->physical-memory-block mapping, and to track various
> > > states of the section-of-a-zone.  This will be complex, and buggy.  It will
> > > probably require the introduction of some sort of "sub-zone" structure.  At
> > > which stage people would be justified in asking "why didn't you just use
> > > zones - that's what they're for?"
> > 
> > Mel aready has that for anti-frag. The sections are per MAX_ORDER area 
> > and the only states are movable unmovable and reclaimable. There is 
> > nothing more to it. No other state information should be added. Why would 
> > we need sub zones? For what purpose?
> 
> You're proposing that for memory hot-unplug, we take a single zone and by
> some means subdivide that into sections which correspond to physically
> hot-unpluggable memory.  That certainly does not map onto MAX_ORDER
> sections.

Not exactly because implies we are just going to do something zone-like
to prevent kernel allocations ever using unpluggable memory in which
case we should just use zones.

The idea instead would be that unmovable allocations would reside at the
lower PFNs only but not 100% strictly enforced. I group MAX_ORDER_NR_PAGES
together based on their type of allocation but selecting which block of
pages to use for an allocation type is relatively rare because we depend on
the free-lists to contain free pages of a specific type.

The failure case is where at some point during the lifetime of the system,
there were a very large number of active unmovable allocations that scattered
throughout the address space (large number of processes with large numbers
of page tables might trigger it). When that happens, anti-frag would have
failed to offline large portions of memory simply because of the workloads
quantity of unmovable pages was too large and it fell back rather than
going OOM due to zone restrictions.

> 
> > > > Then we should be doing some work to cut down the number of unmovable 
> > > > allocations.
> > > 
> > > That's rather pointless.  A feature is either reliable or it is not.  We'll
> > > never be able to make all kernel allocations reclaimable/moveable so we'll
> > > never be reliable with this approach.  I don't see any alternative to the
> > > never-allocate-kernel-objects-in-removeable-memory approach.  
> > 
> > What feature are you talking about?
> 
> Memory hot-unplug, of course.
> 
> > Why would all allocations need to be movable when we have a portion for 
> > unmovable allocations?
> 
> So you're proposing that we take a single zone, then divide that zone up
> into two sections.  One section is non-hot-unpluggable and is for
> un-moveable allocations.  The other section is hot-unpluggable and only
> moveable allocations may be performed there.
> 
> If so, then this will require addition of new infrastructure which will be
> to some extent duplicative of zones and I see no reason to do that: it'd be
> simpler to divide the physical memory arena into two separate zones.
> 
> If that is not what you are proposing then please tell us what you are
> proposing, completely, and with sufficient detail for us to work out what
> the heck you're trying to tell us.  Please try to avoid uninformative
> rhetorical questions, for they are starting to get quite irritating. 
> Thanks.

Anti-frag groups pages based on type (unmovable, reapable, movable). Each
type has it's own set of free-lists which we use as much as possible. When
those lists deplete, we look at the free-lists for the other types, steal
a free block and put it on the requested allocations free lists.

For anti-frag to help hotplug-remove of a section, the MAX_ORDER_NR_PAGES
needs to be the same as the number of pages in a section. In most cases,
this is not unreasonable as sections tend to be fairly small.

To hot-remove a DIMM, we need to keep unmovable pages out of DIMMS. The
proposal is to keep unmovable pages at the lower PFNs so that DIMMS belonging
to the higher DIMMS remain freeable. As anti-frag clusters MAX_ORDER_NR_PAGES,
you need to select what blocks of MAX_ORDER_NR_PAGES are used a bit more
carefully. You can do this in three ways, depending on how aggressive we're
willing to be.

Option 1: Search for the largest free block in the other lists. Of those
	blocks, select the one with the lowest PFN.
Pros: Easy, very little work
Cons: No guarantee that a large free block is also a low PFN

Option 2: Remember what the highest unmovable PFN is. Take all the free
	pages in the next MAX_ORDER_NR_PAGES block and put them on the
	unmovable free lists. Pageout or migrate all other pages in that block
Pros: Keeps unmovable pages at the lower pfns as much as possible
Cons: More code required, more IO and page copying. Workloads with
	sudden spikes in the number of unmovable pages may cause problems

Option 3: Similar to 2, keep track of the highest unmovable PFN is. When
	the free lists for unmovable pages are depleted, search for all
	movable and reclaimable pages below that PFN (probably via the LRU)
	and move them out of the way. Try again. If it still fails, then
	take the next MAX_ORDER_NR_PAGES as in option 2
Pros: Would be pretty strict about keeping unmovable pages out of the way. The
	failure case is when there are as many unmovable pages as there is
	physical memory in which case, you're not unplugging anyway
Cons: More scanning when unmovable freelists deplete, more IO and page copying

This is not the same as zones which would prevent kernel allocations taking
place in ZONE_MOVABLE. That approach leaves you with a kernel that will still
fail e1000 allocations due to external fragmentation in the allowable zone
and kernel allocations might trigger OOM because all the free memory was
in ZONE_MOVABLE.

The options above should not require zone infrastructure other than the
LRU lists for scanning.

Is this sufficient detail?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
