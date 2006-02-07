Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWBGFAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWBGFAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 00:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWBGFAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 00:00:47 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:52395 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964979AbWBGFAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 00:00:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xfY5KT4flYc8x43bCb/mZOSWF4K/dRQ5uHGuAOAfqQLvn6Vzy/Y9HbYcvDwYrNNU9y41Cl2QtHlaSJig6csOB/beWpstJ9MQGZvYv3xuoT82GuSV2wmGfCNooCgHgFaxLQ3K2K0+6k9K6SN+iQ8h3EBFOuiT4T+jW/NHhBsS5qg=  ;
Message-ID: <43E82979.7040501@yahoo.com.au>
Date: Tue, 07 Feb 2006 16:00:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
References: <200602071028.30721.kernel@kolivas.org> <43E80F36.8020209@yahoo.com.au> <200602071502.41456.kernel@kolivas.org>
In-Reply-To: <200602071502.41456.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tue, 7 Feb 2006 02:08 pm, Nick Piggin wrote:
> 
>>I have a few comments.
> 
> 
> Thanks.
> 

No problem!

> 
>>prefetch_get_page is doing funny things with zones and nodes / zonelists
>>(eg. 'We don't prefetch into DMA' meaning something like 'this only works
>>on i386 and x86-64').
> 
> 
> Hrm? It's just a generic thing to do; I'm not sure I follow why it's i386 and 
> x86-64 only. Every architecture has ZONE_NORMAL so it will prefetch there.
> 

I don't think every architecture has ZONE_NORMAL.

> 
>>buffered_rmqueue, zone_statistics, etc really should to stay static to
>>page_alloc.
> 
> 
> I can have an even simpler version of buffered_rmqueue specifically for swap 
> prefetch, but I didn't want to reproduce code unnecessarily, nor did I want a 
> page allocator outside page_alloc.c or swap_prefetch only code placed in 
> page_alloc. The higher level page allocators do too much and they test to see 
> if we should reclaim (which we never want to do) or allocate too many pages. 
> It is the only code "cost" when swap prefetch is configured off. I'm open to 
> suggestions?
> 

If you omit __GFP_WAIT and already test the watermarks yourself it should
be OK.

> 
>>It is completely non NUMA or cpuset-aware so it will likely allocate memory
>>in the wrong node, and will cause cpuset tasks that have their memory
>>swapped out to get it swapped in again on other parts of the machine (ie.
>>breaks cpuset's memory partitioning stuff).
>>
>>It introduces global cacheline bouncing in pagecache allocation and removal
>>and page reclaim paths, also low watermark failure is quite common in
>>normal operation, so that is another global cacheline write in page
>>allocation path.
> 
> 
> None of these issues is going to remotely the target audience. If the issue is 
> how scalable such a change can be then I cannot advocate making the code 
> smart and complex enough to be numa and cpuset aware.. but then that's never 
> going to be the target audience. It affects a particular class of user which 
> happens to be quite a large population not affected by complex memory 
> hardware.
> 

Workstations can have 2 or more dual core CPUs with multiple threads or NUMA
these days. Desktops and laptops will probably eventually gain more cores and
threads too.

> 
>>Why bother with the trylocks? On many architectures they'll RMW the
>>cacheline anyway, so scalability isn't going to be much improved (or do you
>>see big lock contention?)
> 
> 
> Rather than scalability concerns per se the trylock is used as yet another 
> (admittedly rarely hit) way of defining busy.
> 

They just seem to complicate the code for apparently little gain.

> 
>>Aside from those issues, I think the idea has is pretty cool... but there
>>are a few things that get to me:
>>
>>- it is far more common to reclaim pages from other mappings (not swap).
>>   Shouldn't they have the same treatment? Would that be more worthwhile?
> 
> 
> I don't know. Swap is the one that affect ordinary desktop users in magnitudes 
> that embarrass perceived performance beyond belief. I didn't have any other 
> uses for this code in mind.
> 
> 
>>- when is a system _really_ idle? what if we want it to stay idle (eg.
>>   laptops)? what if some block devices or swap devices are busy, or
>>   memory is continually being allocated and freed and/or pagecache is
>>   being created and truncated but we still want to prefetch?
> 
> 
> The code is pretty aggressive at defining busy. It looks for pretty much all 
> of those and it prefetches till it stops then allowing idle to occur again. 
> Opting out of prefetching whenever there is doubt seems reasonable to me.
> 

What if you want to prefetch when there is slight activity going on though?
What if your pagecache has filled memory with useless stuff (which would appear
to be the case with updatedb). What if you don't want to prefetch in laptop
mode at all?

> 
>>- for all its efforts, it will still interact with page reclaim by
>>   putting pages on the LRU and causing them to be cycled.
>>
>>   - on bursty loads, this cycling could happen a bit. and more reads on
>>     the swap devices.
> 
> 
> Theoretically yes I agree. The definition of busy is so broad that prevents it 
> prefetching that it is not significant.
> 

Not if the workload is very bursty.

> 
>>- in a sense it papers over page reclaim problems that shouldn't be so
>>   bad in the first place (midnight cron). On the other hand, I can see
>>   how it solves this issue nicely.
> 
> 
> I doubt any audience that will care about scalability and complex memory 
> configurations would knowingly enable it so it costs them virtually nothing 
> for the relatively unintrusive code to be there. It's configurable and helps 
> a unique problem that affects most users who are not in the complex hardware 
> group. I was not advocating it being enabled by default, but last time it was 
> in -mm akpm suggested doing that to increase its testing - while in -mm.
> 

If it is in core mm then I would very much like to see it adhere to how
everything else works, and attempt to be scalable and generalised.

Any code in a core system is intrusive by definition because it simply
adds to the amount of work that needs to be done when maintaining the
thing or trying to understand how things work, debugging people's badly
behaving workloads, etc.

If it is going to be off by default, why couldn't they
echo 10 > /proc/sys/vm/swappiness rather than turning it on?

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
