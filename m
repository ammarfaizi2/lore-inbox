Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWBGGvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWBGGvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBGGvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:51:33 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:42081 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932453AbWBGGvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:51:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fLcSXClu+qniBLmtgI9wlK3z+NN6VwQdN2N/CIQO/Kf1Ru4hykLF4ffyq+inS4hEnzxNAuKeXuLm25xRlW5TiIU58AhGm+XvgWoWkGEkmRMjTi1/zC1uWfJbAczmuZ8MLdxDjsY1hTwlwdUhLzrYBUvaPYcT7xjZgSZazPvxeQE=  ;
Message-ID: <43E8436F.2010909@yahoo.com.au>
Date: Tue, 07 Feb 2006 17:51:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
References: <200602071028.30721.kernel@kolivas.org> <200602071502.41456.kernel@kolivas.org> <43E82979.7040501@yahoo.com.au> <200602071702.20233.kernel@kolivas.org>
In-Reply-To: <200602071702.20233.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tue, 7 Feb 2006 04:00 pm, Nick Piggin wrote:
> 
>>Con Kolivas wrote:
>>
>>>On Tue, 7 Feb 2006 02:08 pm, Nick Piggin wrote:
>>>
>>>>prefetch_get_page is doing funny things with zones and nodes / zonelists
>>>>(eg. 'We don't prefetch into DMA' meaning something like 'this only works
>>>>on i386 and x86-64').
>>>
>>>Hrm? It's just a generic thing to do; I'm not sure I follow why it's i386
>>>and x86-64 only. Every architecture has ZONE_NORMAL so it will prefetch
>>>there.
>>
>>I don't think every architecture has ZONE_NORMAL.
> 
> 
> !ZONE_DMA they all have, no?
> 

Don't think so. IIRC ppc64 has only ZONE_DMA although may have picked up
DMA32 now (/me boots the G5). IA64 I think have 4GB ZONE_DMA so smaller
systems won't have any other zones.

On small memory systems, ZONE_DMA will be a significant portion of memory
too (but maybe you're not targetting them either).

>>If you omit __GFP_WAIT and already test the watermarks yourself it should
>>be OK.
> 
> 
> Ok.
> 
> 

Note, it may dip lower than we would like, but the watermark checking is
already completely racy anyway so it is possible that that will happen
anyway.

>>Workstations can have 2 or more dual core CPUs with multiple threads or
>>NUMA these days. Desktops and laptops will probably eventually gain more
>>cores and threads too.
> 
> 
> While I am aware of the hardware changes out there I still doubt the 
> scalability issues you're concerned about affect a desktop. The code cost and 
> complexity will increase substantially yet I'm not sure that will be for any 
> gain to the targetted users.
> 

Possibly. Why wouldn't you want swap prefetching on servers though?
Especially on some kind of shell server, or other internet server
where load could be really varied.

> 
>>>>Why bother with the trylocks? On many architectures they'll RMW the
>>>>cacheline anyway, so scalability isn't going to be much improved (or do
>>>>you see big lock contention?)
>>>
>>>Rather than scalability concerns per se the trylock is used as yet
>>>another (admittedly rarely hit) way of defining busy.
>>
>>They just seem to complicate the code for apparently little gain.
> 
> 
> No biggie; I'll drop them.
> 

That's what I'd do for now. A concurrent spin_lock could hit right after
the trylock takes the lock anyway...

> 
>>>The code is pretty aggressive at defining busy. It looks for pretty much
>>>all of those and it prefetches till it stops then allowing idle to occur
>>>again. Opting out of prefetching whenever there is doubt seems reasonable
>>>to me.
>>
>>What if you want to prefetch when there is slight activity going on though?
> 
> 
> I don't. I want this to not cost us anything during any activity.
> 

So if you have say some networking running (p2p or something), then it
may not ever prefetch?

> 
>>What if your pagecache has filled memory with useless stuff (which would
>>appear to be the case with updatedb). 
> 
> 
> There is no way the vm will ever be smart enough to say "this is crap, throw 
> it out and prefetch some good stuff", so it doesn't matter.
> 

It can do a lot better about throwing out updatedb type stuff.

Actually I had thought the point of this was to page in stuff after the
updatedb run, but it would appear that it won't do this because updatedb
will leave the pagecache full...

>>>>- for all its efforts, it will still interact with page reclaim by
>>>>  putting pages on the LRU and causing them to be cycled.
>>>>
>>>>  - on bursty loads, this cycling could happen a bit. and more reads on
>>>>    the swap devices.
>>>
>>>Theoretically yes I agree. The definition of busy is so broad that
>>>prevents it prefetching that it is not significant.
>>
>>Not if the workload is very bursty.
> 
> 
> It's an either/or for prefetching; I don't see a workaround, just some sane 
> balance.
> 

Makes improving the rest of the VM for desktop users harder, no matter
how sane. Though I can't deny it is potentially an improvement itself
either.

>>Any code in a core system is intrusive by definition because it simply
>>adds to the amount of work that needs to be done when maintaining the
>>thing or trying to understand how things work, debugging people's badly
>>behaving workloads, etc.
> 
> 
> I'm open to code suggestions and appreciate any outside help.
> 

Hopefully you have a bit to go on. I still see difficult problems that
I'm not sure how can be solved.

> 
>>If it is going to be off by default, why couldn't they
>>echo 10 > /proc/sys/vm/swappiness rather than turning it on?
> 
> 
> Because we still swap no matter what the sysctl setting is, which makes it 
> even more useful in my opinion for those who aggressively set this tunable.
> 

Sounds like we need to do more basic VM tuning as well.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
