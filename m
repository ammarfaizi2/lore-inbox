Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVCPWWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVCPWWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVCPWWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:22:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:11217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262834AbVCPWVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:21:48 -0500
Date: Wed, 16 Mar 2005 14:21:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: noahm@csail.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-Id: <20050316142114.3f853d85.akpm@osdl.org>
In-Reply-To: <20050316183701.GB21597@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
	<20050316183701.GB21597@opteron.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Wed, Mar 16, 2005 at 04:04:35AM -0800, Andrew Morton wrote:
> > > +			if (!reclaim_state->reclaimed_slab &&
> > > +			    zone->pages_scanned >= (zone->nr_active +
> > > +						    zone->nr_inactive) * 4)
> > >  				zone->all_unreclaimable = 1;
> > 
> > That might not change anything because we clear ->all_unreclaimable in
> > free_page_bulk().  [..]
> 
> Really? free_page_bulk is called inside shrink_slab, and so it's overwritten
> later by all_unreclaimable. Otherwise how could all_unreclaimable be set
> in the first place if a single page freed by shrink_slab would be enough
> to clear it?
> 
> 	shrink_slab
> 	all_unreclaimable = 0
> 	zone->pages_scanned >= (zone->nr_active [..]
> 	all_unreclaimable = 1
> 
> 							try_to_free_pages
> 							all_unreclaimable == 1
> 							oom

Spose so.

> I also considering changing shrink_slab to return a progress retval, but
> then I noticed I could get away with a one liner fix ;).
> 
> Your fix is better but it should be mostly equivalent in pratcie. I
> liked the dontrylock not risking to go oom, the one liner couldn't
> handle that ;).

It has a problem.  If ZONE_DMA is really, really oom, kswapd will sit there
freeing up ZONE_NORMAL slab objects and not setting all_unreclaimable. 
We'll end up using tons of CPU and reclaiming lots of slab in response to a
ZONE_DMA oom.

I'm thinking that the most accurate way of fixing this and also avoiding
the "we're fragmenting slab but not actually freeing pages yet" problem is


- change task_struct->reclaim_state so that it has an array of booleans
  (one per zone)

- in kmem_cache_free, work out what zone the object corresponds to and
  set the boolean in current->reclaim_state which corresponds to that zone.

- in balance_pgdat(), inspect this zone's boolean to see if we're making
  any forward progress with slab freeing.

Probably we can do the work in kmem_cache_free() at the place where we
spill the slab magazine, to optimise things a bit.  I haven't looked at it.

But that has a problem too.  Some other task might be freeing objects into
the relevant zone instead of this one.

So maybe a better approach would be to add a "someone freed something"
counter to the zone structure.  That would be incremented whenever anyone
frees a page for a slab object.  Then in balance_pdgat we take a look at
that before and after performing the LRU and slab scans.  If it
incremented, dont' set all_unreclaimable.  And still keep the
free_pages_bulk code there as the code which takes us _out_ of the
all_unreclaimable state.

It's tricky.


