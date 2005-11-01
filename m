Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVKAUbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVKAUbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVKAUbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:31:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:1201 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751157AbVKAUbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:31:49 -0500
Message-ID: <4367D0AD.3070900@austin.ibm.com>
Date: Tue, 01 Nov 2005 14:31:41 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030235440.6938a0e9.akpm@osdl.org> <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu> <200511011223.43841.rob@landley.net>
In-Reply-To: <200511011223.43841.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>The set of patches do fix a lot and make a strong start at addressing
>>>the fragmentation problem, just not 100% of the way. [...]
>>
>>do you have an expectation to be able to solve the 'fragmentation
>>problem', all the time, in a 100% way, now or in the future?
> 
> 
> Considering anybody can allocate memory and never release it, _any_ 100% 
> solution is going to require migrating existing pages, regardless of 
> allocation strategy.
> 

Three issues here.  Fragmentation of memory in general, fragmentation of usage, 
and being able to have 100% success rate at removing memory.

We will never be able to have 100% contiguous memory with no fragmentation. 
Ever.  Certainly not while we have non-movable pieces of memory.  Even if we 
could move every piece of memory it would be impractical.  What these patches do 
for general fragmentation is to keep the allocations that never will get freed 
away from the rest of memory, so that memory has a chance to form larger 
contiguous ranges when it is freed.

By separating memory based on usage there is another side effect.  It also makes 
possible some more active defragmentation methods on easier memory, because it 
doesn't have annoying hard memory scattered throughout.  Suddenly we can talk 
about being able to do memory hotplug remove on significant portions of memory. 
    Or allocating these hugepages after boot.  Or doing active defragmentation. 
  Or modules being able to be modules because they don't have to preallocate big 
pieces of contiguous memory.

Some people will argue that we need 100% separation of usage or no separation at 
all.  Well, change the array of fallback to not allow kernel non-reclaimable to 
fallback and we are done.  4 line change, 100% separation.  But the tradeoff is 
that under memory pressure we might fail allocations when we still have free 
memory.  There are other options for fallback of course, the fallback_alloc() 
function is easily replaceable if somebody wants to.  Many of these options get 
easier once memory migration is in.  The way fallback is done in the current 
patches is to maintain current behavior as much as possible, satisfy 
allocations, and not affect performance.

As to the 100% success at removing memory, this set of patches doesn't solve 
that.  But it solves the 80% problem quite nicely (when combined with the memory 
migration patches).  80% is great for virtualized systems where the OS has some 
choice over which memory to remove, but not the quantity to remove.  It is also 
a good start to 100%, because we can separate and identify the easy memory from 
the hard memory.  Dave Hansen has outlined in separate posts how we can get to 
100%, including hard memory.

>>can you always, under any circumstance hot unplug RAM with these patches
>>applied? If not, do you have any expectation to reach 100%?
> 
> 
> You're asking intentionally leading questions, aren't you?  Without on-demand 
> page migration a given area of physical memory would only ever be free by 
> sheer coincidence.  Less fragmented page allocation doesn't address _where_ 
> the free areas are, it just tries to make them contiguous.
> 
> A page migration strategy would have to do less work if there's less 
> fragmention, and it also allows you to cluster the "difficult" cases (such as 
> kernel structures that just ain't moving) so you can much more easily 
> hot-unplug everything else.  It also makes larger order allocations easier to 
> do so drivers needing that can load as modules after boot, and it also means 
> hugetlb comes a lot closer to general purpose infrastructure rather than a 
> funky boot-time reservation thing.  Plus page prezeroing approaches get to 
> work on larger chunks, and so on.
> 
> But any strategy to demand that "this physical memory range must be freed up 
> now" will by definition require moving pages...

Perfectly stated.
