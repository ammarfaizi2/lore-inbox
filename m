Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWANSaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWANSaq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWANSaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:30:46 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:25015 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750751AbWANSaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:30:46 -0500
Date: Sat, 14 Jan 2006 18:29:28 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lhms-devel@lists.sourceforge.net,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] BUG: gfp_zone() not mapping zone modifiers correctly
 and bad ordering of fallback lists
In-Reply-To: <1137205485.7130.81.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0601141813380.26232@skynet>
References: <20060113155026.GA4811@skynet.ie>  <20060113121652.114941a3.akpm@osdl.org>
 <1137205485.7130.81.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Dave Hansen wrote:

> On Fri, 2006-01-13 at 12:16 -0800, Andrew Morton wrote:
> > mel@csn.ul.ie (Mel Gorman) wrote:
> > > build_zonelists() attempts to be smart, and uses highest_zone() so that it
> > > doesn't attempt to call build_zonelists_node() for empty zones.  However,
> > > build_zonelists_node() is smart enough to do the right thing by itself and
> > > build_zonelists() already has the zone index that highest_zone() is meant
> > > to provide. So, remove the unnecessary function highest_zone().
> >
> > Dave, Andy: could you please have a think about the fallback list thing?
>
> It's bogus.  Mel, I didn't take a close enough look when we were talking
> about it earlier, and I fear I led you astray.  I misunderstood what it
> was trying to do, and though that the zone_populated() check replaced
> the highest_zone() check, when they actually do completely different
> things.
>
> highest_zone(zone_nr) actually means, given these "zone_bits" (which is
> actually a set of __GFP_XXXX flags), what is the highest zone number
> that we could possibly use to satisfy an allocation with those __GFP
> flags.
>

True, but what is passed in is not "zone_bits", but a ZONE_something type.
Given the bits __GFP_HIGHMEM, it would return ZONE_HIGHMEM. What actually
happens is highest_zone(ZONE_HIGHMEM) gets called and returns ZONE_DMA.
The fallback lists then look like;

[17179569.184000] Dumping pgdat fallback lists
[17179569.184000] 0   Normal      DMA
[17179569.184000] 1      DMA
[17179569.184000] 2  HighMem   Normal      DMA
[17179569.184000] 3      DMA

This currently happens to work. It goes wrong when an additional zone is
created unless more bits are consumed for the zone modifiers than is
really required.

The additional zone is for a zone-based approach to anti-fragmentation.

> We can't just get rid of it.  If we do, we might put a highmem zone in
> the fallback list for a normal zone.  Badness.
>

That would be obviously broken, but I am having trouble seeing how it
could happen as with this patch, we start with the highest possible zone
that can be used and count back.

> So, Mel, I have couple of patches that I put together that the two
> copies of build_zonelists(), and move some of build_zonelists() itself
> down into build_zonelists_node(), including the highest_zone() call.
> They're no good to you by themselves.  But, I think we can make a little
> function to go into the loop in build_zonelists_node().  The new
> function would ask, "can this zone be used to satisfy this GFP mask?"
> We'd start the loop at the absolutely highest-numbered zone.  I think
> that's a decently clean way to do what you want with the reclaim zone.
>

Ok.

> In the process of investigating this, I noticed that Andy's nice
> calculation and comment for GFP_ZONETYPES went away.  Might be nice to
> put it back, just so we know how '5' got there:
>
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ac3461ad632e86e7debd871776683c05ef3ba4c6
>
> Mel, you might also want to take a look at what Linus is suggesting
> there.
>
> -- Dave
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
