Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVHCUAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVHCUAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 16:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVHCUAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 16:00:47 -0400
Received: from amdext4.amd.com ([163.181.251.6]:50839 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S262433AbVHCUAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 16:00:44 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] VM: add vm.free_node_memory sysctl
Date: Wed, 3 Aug 2005 14:59:22 -0500
User-Agent: KMail/1.8
cc: "Martin Hicks" <mort@sgi.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Linux MM" <linux-mm@kvack.org>, "Andrew Morton" <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050801113913.GA7000@elte.hu>
 <20050803142440.GQ26803@localhost>
 <20050803143855.GA10895@wotan.suse.de>
In-Reply-To: <20050803143855.GA10895@wotan.suse.de>
MIME-Version: 1.0
Message-ID: <200508031459.22834.raybry@mpdtxmail.amd.com>
X-WSS-ID: 6EEFFDC41UW7222803-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 August 2005 09:38, Andi Kleen wrote:
> On Wed, Aug 03, 2005 at 10:24:40AM -0400, Martin Hicks wrote:
> > On Wed, Aug 03, 2005 at 04:15:29PM +0200, Andi Kleen wrote:
> > > On Wed, Aug 03, 2005 at 09:56:46AM -0400, Martin Hicks wrote:
> > > > Here's the promised sysctl to dump a node's pagecache.  Please
> > > > review!
> > > >
> > > > This patch depends on the zone reclaim atomic ops cleanup:
> > > > http://marc.theaimsgroup.com/?l=linux-mm&m=112307646306476&w=2
> > >
> > > Doesn't numactl --bind=node memhog nodesize-someslack do the same?
> > >
> > > It just might kick in the oom killer if someslack is too small
> > > or someone has unfreeable data there. But then there should be
> > > already an sysctl to turn that one off.
> >
Hmmm.... What happens if there are already mapped pages (e. g. mapped in the 
sense that pages are mapped into an address space) on the node and you want 
to allocate some more, but can't because the node is full of clean page cache 
pages?   Then one would have to set the memhog argument to the right thing to 
keep the existing mapped memory from being swapped out, right?  Is the data 
to set that argument readily available to user space?  Martin's patch has the 
advantage of targeting just the clean page cache pages.

The way I see this, the problem is that clean page cache pages >>should<< be 
easily available to be used to satisfy a request for mapped pages.   This 
works correctly in non-NUMA Linux systems.  But in NUMA Linux systems, we 
keep tripping over this problem all the time, particularly in the  HPC space, 
and patches like Martin's come about as an attempt to solve this in the VMM.
(We trip over this in the sense that we end up allocating off node storage 
because the current node is full of page cache pages.)

The best answer we have at the present time is to run a memory hog program 
that forces the clean page cache pages to be reclaimed by putting the node in 
question under memory pressure, but this seems like an indirect way to solve 
the problem at hand which is, really, to quickly release those page cache 
pages and make them available for user programs to allocate.  So the most 
direct way to fix this is to fix it in the VMM rather than depending on a 
memory hog based work-around of some kind.   Perhaps we haven't gotten the 
right set of patches together to do this, but my take is that is where the 
fix belongs. 

And, just for the record (  :-)  ), this is not just an Altix problem.  
Opterons are NUMA systems too, and we encounter exactly this same problem in 
the HPC space on 4-node systems.  
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

