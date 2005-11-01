Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVKAOlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVKAOlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVKAOlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:41:35 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:26050 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750818AbVKAOle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:41:34 -0500
Date: Tue, 1 Nov 2005 14:41:27 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051101135651.GA8502@elte.hu>
Message-ID: <Pine.LNX.4.58.0511011358520.14884@skynet>
References: <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]>
 <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet>
 <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Ingo Molnar wrote:

> * Mel Gorman <mel@csn.ul.ie> wrote:
>
> > The set of patches do fix a lot and make a strong start at addressing
> > the fragmentation problem, just not 100% of the way. [...]
>
> do you have an expectation to be able to solve the 'fragmentation
> problem', all the time, in a 100% way, now or in the future?
>

Not now, but I expect to make 100% on demand in the future for all but
GFP_ATOMIC and GFP_NOFS allocations. As GFP_ATOMIC and GFP_NOFS cannot do
any reclaim work themselves, they will still be required to use smaller
orders or private pools that are refilled using GFP_KERNEL if necessary.
The high order pages would have to be reclaimed by another process like
kswapd just like what happens for order-0 pages today.

> > So, with this set of patches, how fragmented you get is dependant on
> > the workload and it may still break down and high order allocations
> > will fail. But the current situation is that it will defiantly break
> > down. The fact is that it has been reported that memory hotplug remove
> > works with these patches and doesn't without them. Granted, this is
> > just one feature on a high-end machine, but it is one solid operation
> > we can perform with the patches and cannot without them. [...]
>
> can you always, under any circumstance hot unplug RAM with these patches
> applied? If not, do you have any expectation to reach 100%?
>

No, you cannot guarantee hot unplug RAM with these patches applied.
Anecdotal evidence suggests your chances are better on PPC64 which is a
start but we have to start somewhere. The full 100% solution would be a
large set of far reaching patches that would touch a lot of the memory
manager. This would get rejected because the patches should have have
arrived piecemeal. These patches are one piece. To reach 100%, other
mechanisms are also needed such as;

o Page migration to move unreclaimable pages like mlock()ed pages or
  kernel pages that had fallen back into easy-reclaim areas. A mechanism
  would also be needed to move things like kernel text. I think the memory
  hotplug tree has done a lot of work here
o Mechanism for taking regions of memory offline. Again, I think the
  memory hotplug crowd have something for this. If they don't, one of them
  will chime in.
o linear page reclaim that linearly scans a region of memory reclaims or
  moves all the pages it. I have a proof-of-concept patch that does the
  linear scan and reclaim but it's currently ugly and depends on this set
  of patches been applied.

These patches are the *starting* point that other things like linear page
reclaim can be based on.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
