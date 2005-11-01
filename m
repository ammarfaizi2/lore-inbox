Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVKAS64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVKAS64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVKAS64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:58:56 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:31656
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751112AbVKAS6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:58:55 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Tue, 1 Nov 2005 12:58:04 -0600
User-Agent: KMail/1.8
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie> <45430000.1130858744@[10.10.2.4]> <1130859193.14475.104.camel@localhost>
In-Reply-To: <1130859193.14475.104.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011258.06059.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 09:33, Dave Hansen wrote:
> On Tue, 2005-11-01 at 07:25 -0800, Martin J. Bligh wrote:
> > > I really don't think we *want* to say we support higher order
> > > allocations absolutely robustly, nor do we want people using them if
> > > possible. Because we don't. Even with your patches.
> > >
> > > Ingo also brought up this point at Ottawa.
> >
> > Some of the driver issues can be fixed by scatter-gather DMA *if* the
> > h/w supports it. But what exactly do you propose to do about kernel
> > stacks, etc? By the time you've fixed all the individual usages of it,
> > frankly, it would be easier to provide a generic mechanism to fix the
> > problem ...
>
> That generic mechanism is the kernel virtual remapping.  However, it has
> a runtime performance cost, which is increased TLB footprint inside the
> kernel, and a more costly implementation of __pa() and __va().

Ok, right now the kernel _has_ a virtual mapping, it's just a 1:1 with the 
physical mapping, right?

In theory, if you restrict all kernel unmovable mappings to a physically 
contiguous address range (something like ZONE_DMA) that's at the start of the 
physical address space, then what you could do is have a two-kernel-monte 
like situation where if you _NEED_ to move the kernel you quiesce the system 
(as if you're going to swsusp), figure out where the new start of physical 
memory will be when this bank goes bye-bye, memcpy the whole mess to the new 
location, adjust your one VMA, and then call the swsusp unfreeze stuff.

This is ugly, and a huge latency spike, but why wouldn't it work?  The problem 
now becomes finding some NEW physically contiguous range to shoehorn the 
kernel into, and that's a problem that Mel's already addressing...

Rob
