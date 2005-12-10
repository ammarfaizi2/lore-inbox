Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbVLJS0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbVLJS0l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 13:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbVLJS0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 13:26:41 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:32015 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161023AbVLJS0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 13:26:40 -0500
Date: Sat, 10 Dec 2005 13:25:42 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] vm: enhance __alloc_pages to prioritize pagecache eviction when pressed for memory
Message-ID: <20051210182542.GA3862@localhost.localdomain>
References: <20051207220401.GB13577@hmsreliant.homelinux.net> <20051209162901.71728620.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209162901.71728620.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 04:29:01PM -0800, Andrew Morton wrote:
> Neil Horman <nhorman@tuxdriver.com> wrote:
> >
> > Hey all-
> >      I was recently shown this issue, wherein, if the kernel was kept full of
> > pagecache via applications that were constantly writing large amounts of data to
> > disk, the box could find itself in a position where the vm, in __alloc_pages
> > would invoke the oom killer repetatively within try_to_free_pages, until such
> > time as the box had no candidate processes left to kill, at which point it would
> > panic.
> 
> That's pretty bad.  Are you able to provide a description which would permit
> others to reproduce this?
> 
I can provide you what was provided to me (It'll have to wait 'till, monday, as
thats where my notes are).  The origional reproducer requires multiple nodes in
a cluster with more than 4GB of ram to write 16GB of data to a common NFS share,
but I think it can be reproduced with a single system with sufficient ram
(specifically more than 4GB IIRC) writing to an NFS share.

> >  /*
> > + * Writeback nr_pages from pagecache to disk synchronously
> > + * blocks until the writeback is complete
> > + */
> > +void clean_pagecache(long nr_pages)
> > +{
> > +	struct writeback_control wbc = {
> > +		.bdi            = NULL,
> > +		.sync_mode      = WB_SYNC_ALL,
> > +		.older_than_this = NULL,
> > +		.nr_to_write    = nr_pages,
> > +		.nonblocking    = 0,
> > +	};
> > +
> > +	writeback_inodes(&wbc);
> > +}
> 
> Interesting.
> 
> > +/*
> >   * Start writeback of `nr_pages' pages.  If `nr_pages' is zero, write back
> >   * the whole world.  Returns 0 if a pdflush thread was dispatched.  Returns
> >   * -1 if all pdflush threads were busy.
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -949,6 +949,16 @@ rebalance:
> >  	reclaim_state.reclaimed_slab = 0;
> >  	p->reclaim_state = &reclaim_state;
> >  
> > +	/*
> > +	 * We're pinched for memory, so before we try to reclaim some 
> > +	 * pages synchronously, lets try to force some more pages out
> > +	 * of pagecache, to raise our chances of this succeding.
> > +	 * specifically, lets write out the number of pages that this
> > +	 * allocation is requesting, in the hopes that they will be
> > +	 * contiguous
> > +	 */
> > +	clean_pagecache(1<<order);
> > +
> >  	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask);
> 
> I suspect that we shuld be passing more than (1<<order) into
> clean_pagecache() - if we're going to do this sort of writeback then we
> might as well do a decent amount.  Maybe something like (number of pages on
> the eligible LRUs * proportion of dirty memory) or something.  But then,
> page reclaim does writeback off the LRU, so none of this should be
> needed...   Need to work out why it broke.
> 
Understood, but I think if userspace is filling pagecache at a sufficient rate, then
a non-I/O bound process preforming a memory allocation in kernel space will
be able to trigger the oom killer before the set of active pdflush tasks have
flushed enough pagechace to free up sufficient lowmem to satisfy the request.
By adding the above writeback, we can block the allocation until at least some
amount of lowmem is freed.  I understand what your saying though, about flushing
a decent amount, if were going to flush synchronously at all.  I can re-work the
patch to flush more pagecache when we trigger.  The only reason I used 1<<order
was because I didn't want to be too agressive and stall the system while we
flushed out more pagecache than we needed to.

Of course, I could be off base on all of this.  As I mentioned to Ingo, I'm
really trying to get more involved in vm work, so I just getting used to some of
the code here.  But I can say that this patch fixes the problem I describe
above, and given my limited understanding, it makes sense to me.

> And we should not be calling into filesystem writeback unless the caller
> specified __GFP_FS.
I'll take your word for this here, but I'm not sure why that needs to be the
case.  My intent here was to free pagecache, whenever a lowmem allocation fails.
I understand that the pagecache itself may well be in highmem, but a certain
amount of lowmem is used to track and manage that pagecache allocation, and by
flushing pagecache we free that lowmem up, hopefully in a sufficient amount to
allow the allocation at hand to procede.

I'll post the full reproducer monday morning/afternoon.

Thanks & Regards
Neil
 
