Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbULOEO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbULOEO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULOEO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:14:26 -0500
Received: from cantor.suse.de ([195.135.220.2]:64938 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261862AbULOEI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:08:57 -0500
Date: Wed, 15 Dec 2004 05:08:54 +0100
From: Andi Kleen <ak@suse.de>
To: Brent Casavant <bcasavan@sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041215040854.GC27225@wotan.suse.de>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com> <9250000.1103050790@flay> <20041214191348.GA27225@wotan.suse.de> <19030000.1103054924@flay> <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 05:24:02PM -0600, Brent Casavant wrote:
> On Tue, 14 Dec 2004, Martin J. Bligh wrote:
> 
> > --On Tuesday, December 14, 2004 20:13:48 +0100 Andi Kleen <ak@suse.de> wrote:
> > 
> > > I originally was a bit worried about the TLB usage, but it doesn't
> > > seem to be a too big issue (hopefully the benchmarks weren't too
> > > micro though)
> > 
> > Well, as long as we stripe on large page boundaries, it should be fine,
> > I'd think. On PPC64, it'll screw the SLB, but ... tough ;-) We can either
> > turn it off, or only do it on things larger than the segment size, and
> > just round-robin the rest, or allocate from node with most free.
> 
> Is there a reasonably easy-to-use existing infrastructure to do this?

No. It will be a lot of work actually, requiring new code for 
each architecture and may even be impossible on some. 
The current hugetlb code is not really suitable for this
because it requires an preallocated pool and only works
for user space.

I actually considered implementing it for x86-64 some time ago
for the modules, but then I never bothered. On AMD systems
I actually prefer to use small pages here. The reason is that
Opteron has a separated large and small pages TLB and the small
pages TLB is much bigger. When someone else uses huge TLB 
pages too (user space or kernel direct mapping) then it's actually
a good idea to use small pages.

Also it may be difficult in some cases to even allocate
such large pages even at boot and impossible to do it
later when a module loads.

Also at least on IA64 the large page size is usually 1-2GB 
and that would seem to be a little too large to me for
interleaving purposes. Also it may prevent the purpose 
you implemented it - not using too much memory from a single
node. 

Using other page sizes would be probably tricky because the 
linux VM can currently barely deal with two page sizes.
I suspect handling more would need some VM infrastructure effort
at least in the changed port. 

> I didn't find anything in my examination of vmalloc itself, so I gave
> up on the idea.
> 
> And just to clarify, are you saying you want to see this before inclusion
> in mainline kernels, or that it would be nice to have but not necessary?

I wouldn't do anything in this area unless somebody shows a benchmark /
profiling results where TLB pressure makes a clear difference. And even
then it may be not worth the effort.

-Andi

