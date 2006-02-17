Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWBQTES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWBQTES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWBQTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:04:18 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:45709 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750851AbWBQTES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:04:18 -0500
Date: Fri, 17 Feb 2006 19:03:02 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot time
In-Reply-To: <1140196618.21383.112.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0602171902400.7675@skynet>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie> 
 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>
 <1140196618.21383.112.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Dave Hansen wrote:

> On Fri, 2006-02-17 at 14:17 +0000, Mel Gorman wrote:
> > This patch adds the kernelcore= parameter for ppc64.
> >
> > The amount of memory will requested will not be reserved in all nodes. The
> > first node that is found that can accomodate the requested amount of memory
> > and have remaining more for ZONE_EASYRCLM is used. If a node has memory holes,
> > it also will not be used.
>
> One thing I think we really need to see before these go into mainline is
> the ability to shrink the ZONE_EASYRCLM at runtime, and give the memory
> back to NORMAL/DMA.
>

I consider this to be highly desirable, but I am not convinced it is a
prerequisite for zone-based-anti-frag because it is a problem that will
only affect admins specifying kernelcore= - i.e. a limited number of
people that care about getting more HugeTLB pages at runtime or removing
memory.

> Otherwise, any system starting off sufficiently small will end up having
> lowmem starvation issues.  Allowing resizing at least gives the admin a
> chance to avoid those issues.
>

The lowmem starvation issue is an existing problem for 32 bit x86 systems.
The pain is that an admin of a ppc64 machine that previously did not care
about lowmem starvation will have to start caring when kernelcore= is
used. Again, this is a new problem for ppc64 and only exists if you care
about hotplug-remove or having a soft area for HugeTLB pages.

If I think that zone-based anti-frag has a chance of getting into
mainline, I can start tackling the lowmem starvation issue as two separate
problems

1. There needs to be an ability to measure presure on lowmem at runtime to
help an admin decide if memory needs to be moved around or not. This would
have a secondary benefit for existing 32 bit x86 machines that need to
know that it is lowmem starvation and not lack of memory that is affecting
their loads and maybe an upgrade to a 64 bit machine is a good plan.

2. The ability to hot-add to a specified zone. When pressure is detected,
an admin would have the option to hot-remove from the EasyRclm area and
add the same memory back to the DMA/Normal zone. This will only work at a
pretty coarse granularity but it would be enough

I think that problem 1 already exists and is only tackled on the ppc64
with the introduction of EasyRclm. Problem 2 is new, but only exists when
the admin wants to remove memory. They need to be solved, but not
necessarily before EasyRclm is used.

> > +               if (core_mem_pfn == 0 ||
> > +                               end_pfn - start_pfn < core_mem_pfn ||
> > +                               end_pfn - start_pfn != pages_present) {
> > +                       zones_size[ZONE_DMA] = end_pfn - start_pfn;
> > +                       zones_size[ZONE_EASYRCLM] = 0;
> > +                       zholes_size[ZONE_DMA] =
> > +                               zones_size[ZONE_DMA] - pages_present;
> > +                       zholes_size[ZONE_EASYRCLM] = 0;
> > +                       if (core_mem_pfn >= pages_present)
> > +                               core_mem_pfn -= pages_present;
> > +               } else {
> > +                       zones_size[ZONE_DMA] = core_mem_pfn;
> > +                       zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;
> > +                       zholes_size[ZONE_DMA] = 0;
> > +                       zholes_size[ZONE_EASYRCLM] = 0;
> > +                       core_mem_pfn = 0;
> > +               }
>
> I'm finding this bit of code really hard to parse.
>
> First of all, please give "core_mem_size" and "core_mem_pfn" some better
> names.  "core_mem_size" in _what_?  Bytes?  Pages?  g0ats? ;)
>

bytes, but I take your point. This could be clearer.

> The "pfn" in "core_mem_pfn" is usually used to denote a physical address
> >> PAGE_SHIFT.  However, yours is actually a _number_ of pages, not an
> address, right?  Actually, as I look at it closer, it appears to be a
> pfn in the else{} and a nr_page in the if{} block.
>

It works out as number of pages but it really should be the "page number
after start_pfn that kernel memory ends and easyrclm begins". I'll rework
the code.

> core_mem_nr_pages or nr_core_mem_pages might be more appropriate.
>

It would.

> Users will _not_ care about memory holes.  They'll just want to specify
> a number of pages.  I think this:
>
> > +                       zones_size[ZONE_DMA] = core_mem_pfn;
> > +                       zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;
>
> is probably bogus because it doesn't deal with holes at all.
>

In this patch, if a region has holes in it, kernelcore is ignored because
holes would not be dealt with correctly. The check is made above with
end_pfn - start_pfn != pages_present

> Walking those init_node_data() structures in get_region() is probably
> pretty darn fast, and we don't need to be careful about how many times
> we do it.  I think I'd probably separate out the problem a bit.
>
> 1. make get_region() not care about holes.  Have it just return the
>    range of the node's pages.
> 2. make a new function (get_region_holes()??) that, given a pfn range,
>    walks the init_node_data[] just like get_region() (have them share
>    code) and return the present_pages in that pfn range.
> 3. go back to paging init, and try to properly size ZONE_DMA.  Find
>    holes with your new function, and increase its size proportionately,
>    set zholes_size[ZONE_DMA] at this time.  Make sure the user size is
>    in nr_page, _NOT_ max_pfns.
> 4. give the rest of the space to ZONE_EASYRCLM.  Call your new function
>    to properly size its zone hole(s).
> 5. Profit!
>
> This may all belong broken out in a new function.
>

Sounds reasonable enough although, as you say, it'll need a new function
at the versy least.  I'll start hitting it and see what I come up with.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
