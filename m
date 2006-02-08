Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWBHMFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWBHMFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWBHMFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:05:23 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:17803 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964997AbWBHMFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:05:22 -0500
Date: Wed, 8 Feb 2006 17:40:00 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@mpdtxmail.amd.com>,
       Christoph Lameter <clameter@engr.sgi.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Message-ID: <20060208121000.GA9906@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20060205163618.GB21972@in.ibm.com> <Pine.LNX.4.62.0602070848450.24487@schroedinger.engr.sgi.com> <200602071727.18359.raybry@mpdtxmail.amd.com> <200602080036.31059.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080036.31059.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 12:36:30AM +0100, Andi Kleen wrote:
> On Wednesday 08 February 2006 00:27, Ray Bryant wrote:
> > On Tuesday 07 February 2006 10:49, Christoph Lameter wrote:
> > > On Tue, 7 Feb 2006, Bharata B Rao wrote:
> > > > I can still crash my x86_64 box with Christoph's program.
> > >
> > > So it looks like the problem is arch specific. Test program runs fine on
> > > ia64.
> > >
> > > > page = 0xffffffffffffffd8
> > > > &page->lru = 0000000000000000
> > >
> > > Yup lru field overwritten as I thought.
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > For what it is worth:
> > 
> > Christoph's test program runs fine on my 32 GB, 4 socket, 8 core Opteron 64 
> 
> Opteron 64? A new exciting upcomming product? @)
> 
> > box with 2.6.16-rc1.
> 
> Yes it also works on my test box and also some other simple tests with MPOL_BIND. 
> But we had similar reports on two different systems, so there's very likely a problem.
> Just need to reproduce it somehow. 
> 

I believe I understand why I am seeing this problem with my setup.

The zones in my machine look like this:

On node 0 totalpages: 773791
  DMA zone: 2151 pages, LIFO batch:0
  DMA32 zone: 771640 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
On node 1 totalpages: 500592
  DMA zone: 0 pages, LIFO batch:0
  DMA32 zone: 242032 pages, LIFO batch:31
  Normal zone: 258560 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0

So it can be seen that the node 0 has only DMA and DMA32 zones while
node 1 has only DMA32 and Normal zones.

The current mempolicy code assumes that the highest zone(policy_zone) that
comes under the memory policy is valid (by which I mean zone->present_pages
is non-zero) for all nodes, which is not true in my case. In this case
the policy_zone gets set to ZONE_NORMAL (highest zone here). 

When mbind'ing to node 0, bind_zonelist()(and subsequent functions) binds
the ZONE_NORMAL zone to vma->vm_policy. During the write fault, the allocator
is asked to allocate from a non-existent ZONE_NORMAL zone for node 0. This
I believe is causing the oops I am seeing. It is still not clear to me
why doesn't the allocator fail the allocations from a zone which has 
zone->present_pages=0 gracefully.

This whole problem wasn't seen on 2.6.15.2 because, bind_zonelist()
actually makes sure that the zone it is binding to has a non-zero
zone->present_pages.

Regards,
Bharata.
