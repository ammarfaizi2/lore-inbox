Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317016AbSFQVHX>; Mon, 17 Jun 2002 17:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSFQVHW>; Mon, 17 Jun 2002 17:07:22 -0400
Received: from amdext2.amd.com ([163.181.251.1]:9647 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S317016AbSFQVHT>;
	Mon, 17 Jun 2002 17:07:19 -0400
From: richard.brunner@amd.com
X-Server-Uuid: 18a6aeba-11ae-11d5-983c-00508be33d6d
Message-ID: <39073472CFF4D111A5AB00805F9FE4B609BA6712@txexmta9.amd.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: another new version of pageattr caching conflict fix for
 2.4
Date: Mon, 17 Jun 2002 16:07:11 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1110900B494829-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Making the AGP Aperture write-back cacheable is not good from
a performance perspective. (I can't comment on which is better 
from a Linux Kernel perspective).

An Aperture Page can be made
cache-coherent depending on the implementation
and the AGP 3.0 spec provides an
architectural way of specifying and controlling these as
well.  But, by default the area is not made cache-coherent
due to the performance loss and the lack of software to take
advantage of it -- the two play off against each
other. 

Making it cache-coherent causes every AGP access to
snoop processor caches and this can be quite a hit in
performance when you consider the predominant AGP software
model. Most software that takes advantage of AGP is still
using the old Intel model of uncacheable, the majority of
data placed in the Aperture are read-only structures for the
AGP device -- such as vertex lists, locked vertex arrays,
and texture data. For the most part this fits the current
paradigm of throwing textures and vertices at the graphics
device. The only graphics area found so far that could
benefit from a coherent aperture is video capture data which
streams in from the graphics device and requires CPU
post-processing.



-Rich ...
[richard.brunner@amd.com    -- (360)-867-0654]
[Senior Member, Technical Staff, SW R&D @ AMD]

> -----Original Message-----
> From: Albert D. Cahalan [mailto:acahalan@cs.uml.edu]
> Sent: Sunday, June 16, 2002 5:09 PM
> To: ak@suse.de
> Cc: ebiederm@xmission.com; ak@suse.de; andrea@suse.de; 
> bcrl@redhat.com;
> linux-kernel@vger.kernel.org; Brunner, Richard; Langsdorf, Mark
> Subject: Re: another new version of pageattr caching conflict fix for
> 2.4
> 
> 
> Andi Kleen writes:
> 
> >> the same problems if the agp aperture was marked 
> write-back, and the
> >
> > AGP aperture is uncacheable, not write-back.
> >
> >> memory was marked uncacheable.  My gut impression is to 
> just make the
> >> agp aperture write-back cacheable, and then we don't have to change
> >> the kernel page table at all.  Unfortunately I don't 
> expect the host
> >
> > That would violate the AGP specification.
> >
> >> bridge with the memory and agp controllers to like that mode,
> >> especially as there are physical aliasing issues.
> >
> > exactly.
> 
> You can do whatever you want, as long as...
> 
> 1. you have cache control instructions and use them
> 2. the bridge ignores the coherency protocol (no machine check)
> 
> Most likely you should make the AGP memory write-back
> cacheable. This requires some care regarding cache lines,
> but ought to be faster.
> 
> >>> Fixing the MTRRs is fine, but it is really outside the 
> scope of my patch.
> >>> Just changing the kernel map wouldn't be enough to fix 
> wrong MTRRs,
> >>> because it wouldn't cover highmem.
> >>
> >> My preferred fix is to use PAT, to override the buggy mtrrs.  Which
> >> brings up the same aliasing issues.  Which makes it related but
> >> outside the scope of the problem.
> >
> > I don't follow you here. IMHO it is much easier to fix the 
> MTRRs in the
> > MTRR driver for those rare buggy BIOS (if they exist - I've 
> never seen one)
> > than to hack up all of memory management just to get the 
> right bits set.
> > I see no disadvantage of using the MTRRs and it is lot simpler than
> > PAT and pte bits.
> 
> For non-x86 one must "hack up all of memory management" anyway.
> 
> Example: There aren't any MTRRs on the PowerPC, but every page
> has 4 memory type bits. It's not OK to map something more than
> one way at the same time. Large "pages" (256 MB each) are used
> to cover all of non-highmem physical memory.
> 
> 
> 
> 
> 

