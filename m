Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVKQOtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVKQOtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVKQOtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:49:17 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:6107 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750987AbVKQOtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:49:16 -0500
Date: Thu, 17 Nov 2005 14:49:01 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Robin Holt <holt@sgi.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Russ Anderson <rja@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to handle a hugepage with bad physical memory?
In-Reply-To: <20051117144332.GC4316@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.58.0511171445300.29264@skynet>
References: <20051116131012.GE4573@lnx-holt.americas.sgi.com>
 <Pine.LNX.4.62.0511161155380.16434@schroedinger.engr.sgi.com>
 <20051117144332.GC4316@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005, Robin Holt wrote:

> On Wed, Nov 16, 2005 at 11:58:13AM -0800, Christoph Lameter wrote:
> > On Wed, 16 Nov 2005, Robin Holt wrote:
> >
> > > Russ Anderson recently introduced a patch into ia64 that changes MCA
> > > behavior.  When the MCA is caused by a user reference to a users memory,
> > > we put an extra reference on the page and kill the user.  This leaves
> > > the working memory available for other jobs while causing a leak of the
> > > bad page.
> > >
> > > I don't know if Russ has done any testing with hugetlbfs pages.  I preface
> > > the remainder of my comments with a huge "I don't know anything"
> > > disclaimer.
> > >
> > > With the new hugepages concept, would it be possible to only mark
> > > the default pagesize portion of a hugepage as bad and then return the
> > > remainder of the hugepage for normal use?  What would we basically need
> > > to do to accomplish this?  Are there patches in the community which we
> > > should wait to see how they progress before we do any work on this front?
> >
> > On IA64 we have one PTE for a huge page in a different region, so we
> > cannot unmap a page sized section. Other architectures may have PTEs for
> > each page sized section of a huge page. For those it may make sense
> > (but then the management of the page is done via the first page_struct,
> > which likely results in some challenging VM issues).
>
> Christoph,
>
> I think you misunderstood me.  I was talking about killing the process.
> All the mappings get destroyed.  I want to reclaim as much of that huge
> page as possible.
>
> Once everything is cleared up, I would like to break the huge page back
> into normal-size pages and free those.
>

Then for each struct page making up that huge page, clear all the flags
(see how the flags are cleared in mm/page_alloc.c#bad_page()), set the
count to 1 (set_page_count(page, 1)) and free it as an order 0 page
(__free_page(page, 0)). Some will end up on the per-cpu lists and if the
lists are full, they will end up on the zone free lists as expected. This
is similar to what happens when the buddy allocator is being setup so look
at mm/bootmem.c#free_all_bootmem_core(pg_data_t) to get an idea of what
has to happen.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
