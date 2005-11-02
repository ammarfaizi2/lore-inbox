Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbVKBFIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbVKBFIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbVKBFIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:08:01 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:60006 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751501AbVKBFIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:08:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zMLAEmhUTUXT0ab64BVVuEIdm1tZhyQW5UCMxCmB7scfERE7HUV3HGu+HBBO4KecDQboTiANwcf2Yx5LklMZPuw9YM2loTg6lYdncCIXX0LcNgAx/+sABMXl/Dqr9vglz0KuDwxtzlYbsDur7nuPniJrBAI+T4kncTKi9ELrxNA=  ;
Message-ID: <43684A16.70401@yahoo.com.au>
Date: Wed, 02 Nov 2005 16:09:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Joel Schopp <jschopp@austin.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au> <214340000.1130895665@[10.10.2.4]> <43681E89.8070905@yahoo.com.au> <216280000.1130898244@[10.10.2.4]> <43682940.3020200@yahoo.com.au> <217570000.1130906356@[10.10.2.4]>
In-Reply-To: <217570000.1130906356@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>I am almost certainly never going to use memory hotplug or
>>demand paging of hugepages. I am pretty likely going to have
>>to wade through this code at some point in the future if it
>>is merged.
> 
> 
> Mmm. Though whether any one of us will personally use each feature
> is perhaps not the most ideal criteria to judge things by ;-)
> 

Of course, but I'd say very few people will. Then again maybe
I'm just a luddite who doesn't know what's good for him ;)

> 
>>It is also going to slow down my kernel by maybe 1% when
>>doing kbuilds, but hey let's not worry about that until we've
>>merged 10 more such slowdowns (ok that wasn't aimed at you or
>>Mel, but my perception of the status quo).
> 
> 
> If it's really 1%, yes, that's a huge problem. And yes, I agree with
> you that there's a problem with the rate of change. Part of that is
> a lack of performance measurement and testing, and the quality sometimes
> scares me (though the last month has actually been significantly better,
> the tree mostly builds and boots now!). I've tried to do something on 
> the testing front, but I'm acutely aware it's not sufficient by any means.
> 

To be honest I haven't tested so this is an unfounded guess. However
it is based on what I have seen of Mel's numbers, and the fact that
the kernel spends nearly 1/3rd of its time in the page allocator when
running a kbuild.

I may get around to getting some real numbers when my current patch
queues shrink.

>>Over time, I don't think it can offer any stronger a guarantee
>>than what we currently have. I'm not even sure that it would be
>>any better at all for problematic workloads as time -> infinity.
> 
> 
> Sounds worth discussing. We need *some* way of dealing with fragmentation
> issues. To me that means both an avoidance strategy, and an ability
> to actively defragment if we need it. Linux is evolved software, it
> may not be perfect at first - that's the way we work, and it's served
> us well up till now. To me, that's the biggest advantage we have over
> the proprietary model.
> 

True and I'm also annoyed that we have these issues at all. I just
don't see that the avoidance strategy helps that much because as I
said, you don't need to keep these lovely contiguous regions just for
show (or other easy-to-reclaim user pages).

The absolute priority is to move away from higher order allocs or
use fallbacks IMO. And that doesn't necessarily mean order 1 or even
2 allocations because we've don't seem to have a problem with those.

Because I want Linux to be as robust as you do.

>>I think it falls down if these higher order allocations actually
>>get *used* for anything. You'll simply be going through the process
>>of replacing your contiguous, easy-to-reclaim memory with pinned
>>kernel memory.
> 
> 
> It seems inevitable that we need both physically contiguous memory
> sections, and virtually contiguous in kernel space (which equates to
> the same thing, unless we totally break the 1-1 P-V mapping and
> lose the large page mapping for kernel, which I'd hate to do.)
>  

I think this isn't as bad an idea as you think. If it means those
guys doing memory hotplug take a few % performance hit and nobody else
has to bear the costs then that sounds great.

> 
>>However, for the purpose of memory hot unplug, a new zone *will*
>>guarantee memory can be reclaimed and unplugged.
> 
> 
> It's not just about memory hotplug. There are, as we have discussed
> already, many usage for physically contiguous (and virtually contiguous)
> memory segments. Focusing purely on any one of them will not solve the
> issue at hand ...
> 

True, but we don't seem to have huge problems with other things. The
main ones that have come up on lkml are e1000 which is getting fixed,
and maybe XFS which I think there are also moves to improve.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
