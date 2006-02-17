Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWBQThu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWBQThu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWBQThu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:37:50 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:9360 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751303AbWBQTht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:37:49 -0500
Date: Fri, 17 Feb 2006 19:36:33 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot time
In-Reply-To: <1140203856.21383.124.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0602171923180.7675@skynet>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie> 
 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie> 
 <1140196618.21383.112.camel@localhost.localdomain>  <Pine.LNX.4.58.0602171902400.7675@skynet>
 <1140203856.21383.124.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Dave Hansen wrote:

> On Fri, 2006-02-17 at 19:03 +0000, Mel Gorman wrote:
> > On Fri, 17 Feb 2006, Dave Hansen wrote:
> > > One thing I think we really need to see before these go into mainline is
> > > the ability to shrink the ZONE_EASYRCLM at runtime, and give the memory
> > > back to NORMAL/DMA.
> >
> > I consider this to be highly desirable, but I am not convinced it is a
> > prerequisite for zone-based-anti-frag because it is a problem that will
> > only affect admins specifying kernelcore= - i.e. a limited number of
> > people that care about getting more HugeTLB pages at runtime or removing
> > memory.
>
> Fair enough.  I guess it certainly shrinks the set.  But, I _really_
> think we need it before it gets into the hands of too many customers.  I
> hate to tell people to reboot boxes, and I hate adding boot options.
>

Ok, hard to argue with that logic but we knew we were going to be dealing
with some sort of tunable when zone-based-anti-frag was first discussed.

> If people start using kernelcore=, we're stuck with it for a long time.
> Why not just make the system flexible from the beginning?  I hate
> introducing hacky boot options only to have them removed 2 kernel
> revisions later when we fix it properly.
>
> Maybe the kernelcore= patch is a good candidate to stay in -mm during
> the transition time, but not ever follow along into mainline.  Dunno.
>

I would like to see this in -mm getting a trial while I work on the moving
pages from EasyRclm to DMA/HighMem problem. I feel that there is a logical
progression from kernelcore= boot option to a sysctl (or something
similar) that is adjustable at runtime. When the code exists to size the
zone at runtime, it can be built on top of the majority of this patchset.
They are not mutually exclusive.

Before even trying to get into -mm though, I should fix the
dealing-with-memory-holes-on-ppc first (more below).

> > If I think that zone-based anti-frag has a chance of getting into
> > mainline, I can start tackling the lowmem starvation issue as two separate
> > problems
> >
> > 1. There needs to be an ability to measure presure on lowmem at runtime to
> > help an admin decide if memory needs to be moved around or not. This would
> > have a secondary benefit for existing 32 bit x86 machines that need to
> > know that it is lowmem starvation and not lack of memory that is affecting
> > their loads and maybe an upgrade to a 64 bit machine is a good plan.
> >
> > 2. The ability to hot-add to a specified zone. When pressure is detected,
> > an admin would have the option to hot-remove from the EasyRclm area and
> > add the same memory back to the DMA/Normal zone. This will only work at a
> > pretty coarse granularity but it would be enough
>
> But, if you get the EasyRclm to DMA transition working properly, this
> problem goes away.  So, if you solve a problem in the kernel, the user
> gets fewer ways to screw up, _and_ you have less code to deal with that
> part of the user interface.
>

Well, they'll have different ways to screw up. Once the EasyRclm zone can
be resized, they might decide to migrate it all to DMA and then cannot
hotplug anything putting them back in square one. I need to think about
this a bit more to see how it'll work in practice.

> > > Users will _not_ care about memory holes.  They'll just want to specify
> > > a number of pages.  I think this:
> > >
> > > > +                       zones_size[ZONE_DMA] = core_mem_pfn;
> > > > +                       zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;
> > >
> > > is probably bogus because it doesn't deal with holes at all.
> > >
> >
> > In this patch, if a region has holes in it, kernelcore is ignored because
> > holes would not be dealt with correctly. The check is made above with
> > end_pfn - start_pfn != pages_present
>
> I missed that.  Is that my fault for not looking closely enough, or the
> patch's fault for being a bit obtuse? ;)
>

c) all of the above. This section of the patch is not winning any prizes
for clarity.

> I think it is pretty bogus to just punt when it sees a memory hole.
> They really need to me dealt with properly.

Your previous mail about having a function similar to get_region() that
returns the number of present pages in a pfn range feels like the right
approach. I'll work on this before touching zone resizing and post another
version.

> Otherwise, you'll never
> hear about it until a customer complains that kernelcore= isn't working
> and they can't remove memory or use hugetlb pages on two "identical"
> systems.
>

Bah, you're right, I just am not too keen on admitting it on a Friday
evening :).

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
