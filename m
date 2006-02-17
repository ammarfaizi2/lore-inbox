Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWBQTS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWBQTS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWBQTS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:18:29 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:41449 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751324AbWBQTS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:18:28 -0500
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot
	time
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0602171902400.7675@skynet>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
	 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>
	 <1140196618.21383.112.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0602171902400.7675@skynet>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 11:17:35 -0800
Message-Id: <1140203856.21383.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 19:03 +0000, Mel Gorman wrote:
> On Fri, 17 Feb 2006, Dave Hansen wrote:
> > One thing I think we really need to see before these go into mainline is
> > the ability to shrink the ZONE_EASYRCLM at runtime, and give the memory
> > back to NORMAL/DMA.
> 
> I consider this to be highly desirable, but I am not convinced it is a
> prerequisite for zone-based-anti-frag because it is a problem that will
> only affect admins specifying kernelcore= - i.e. a limited number of
> people that care about getting more HugeTLB pages at runtime or removing
> memory.

Fair enough.  I guess it certainly shrinks the set.  But, I _really_
think we need it before it gets into the hands of too many customers.  I
hate to tell people to reboot boxes, and I hate adding boot options.

If people start using kernelcore=, we're stuck with it for a long time.
Why not just make the system flexible from the beginning?  I hate
introducing hacky boot options only to have them removed 2 kernel
revisions later when we fix it properly.

Maybe the kernelcore= patch is a good candidate to stay in -mm during
the transition time, but not ever follow along into mainline.  Dunno.

> If I think that zone-based anti-frag has a chance of getting into
> mainline, I can start tackling the lowmem starvation issue as two separate
> problems
> 
> 1. There needs to be an ability to measure presure on lowmem at runtime to
> help an admin decide if memory needs to be moved around or not. This would
> have a secondary benefit for existing 32 bit x86 machines that need to
> know that it is lowmem starvation and not lack of memory that is affecting
> their loads and maybe an upgrade to a 64 bit machine is a good plan.
> 
> 2. The ability to hot-add to a specified zone. When pressure is detected,
> an admin would have the option to hot-remove from the EasyRclm area and
> add the same memory back to the DMA/Normal zone. This will only work at a
> pretty coarse granularity but it would be enough

But, if you get the EasyRclm to DMA transition working properly, this
problem goes away.  So, if you solve a problem in the kernel, the user
gets fewer ways to screw up, _and_ you have less code to deal with that
part of the user interface.

> > Users will _not_ care about memory holes.  They'll just want to specify
> > a number of pages.  I think this:
> >
> > > +                       zones_size[ZONE_DMA] = core_mem_pfn;
> > > +                       zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;
> >
> > is probably bogus because it doesn't deal with holes at all.
> >
> 
> In this patch, if a region has holes in it, kernelcore is ignored because
> holes would not be dealt with correctly. The check is made above with
> end_pfn - start_pfn != pages_present

I missed that.  Is that my fault for not looking closely enough, or the
patch's fault for being a bit obtuse? ;)

I think it is pretty bogus to just punt when it sees a memory hole.
They really need to me dealt with properly.  Otherwise, you'll never
hear about it until a customer complains that kernelcore= isn't working
and they can't remove memory or use hugetlb pages on two "identical"
systems.

-- Dave

