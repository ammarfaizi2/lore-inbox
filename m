Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWBGECO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWBGECO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 23:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWBGECN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 23:02:13 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:184 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964969AbWBGECM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 23:02:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: implement swap prefetching
Date: Tue, 7 Feb 2006 15:02:41 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org
References: <200602071028.30721.kernel@kolivas.org> <43E80F36.8020209@yahoo.com.au>
In-Reply-To: <43E80F36.8020209@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071502.41456.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006 02:08 pm, Nick Piggin wrote:
> Con Kolivas wrote:
> > Andrew et al
> >
> > I'm resubmitting the swap prefetching patch for inclusion in -mm and
> > hopefully mainline. After you removed it from -mm there were some people
> > that described the benefits it afforded their workloads. -mm being ever
> > so slightly quieter at the moment please reconsider.
>
> I have a few comments.

Thanks.

> prefetch_get_page is doing funny things with zones and nodes / zonelists
> (eg. 'We don't prefetch into DMA' meaning something like 'this only works
> on i386 and x86-64').

Hrm? It's just a generic thing to do; I'm not sure I follow why it's i386 and 
x86-64 only. Every architecture has ZONE_NORMAL so it will prefetch there.

> buffered_rmqueue, zone_statistics, etc really should to stay static to
> page_alloc.

I can have an even simpler version of buffered_rmqueue specifically for swap 
prefetch, but I didn't want to reproduce code unnecessarily, nor did I want a 
page allocator outside page_alloc.c or swap_prefetch only code placed in 
page_alloc. The higher level page allocators do too much and they test to see 
if we should reclaim (which we never want to do) or allocate too many pages. 
It is the only code "cost" when swap prefetch is configured off. I'm open to 
suggestions?

> It is completely non NUMA or cpuset-aware so it will likely allocate memory
> in the wrong node, and will cause cpuset tasks that have their memory
> swapped out to get it swapped in again on other parts of the machine (ie.
> breaks cpuset's memory partitioning stuff).
>
> It introduces global cacheline bouncing in pagecache allocation and removal
> and page reclaim paths, also low watermark failure is quite common in
> normal operation, so that is another global cacheline write in page
> allocation path.

None of these issues is going to remotely the target audience. If the issue is 
how scalable such a change can be then I cannot advocate making the code 
smart and complex enough to be numa and cpuset aware.. but then that's never 
going to be the target audience. It affects a particular class of user which 
happens to be quite a large population not affected by complex memory 
hardware.

> Why bother with the trylocks? On many architectures they'll RMW the
> cacheline anyway, so scalability isn't going to be much improved (or do you
> see big lock contention?)

Rather than scalability concerns per se the trylock is used as yet another 
(admittedly rarely hit) way of defining busy.

> Aside from those issues, I think the idea has is pretty cool... but there
> are a few things that get to me:
>
> - it is far more common to reclaim pages from other mappings (not swap).
>    Shouldn't they have the same treatment? Would that be more worthwhile?

I don't know. Swap is the one that affect ordinary desktop users in magnitudes 
that embarrass perceived performance beyond belief. I didn't have any other 
uses for this code in mind.

> - when is a system _really_ idle? what if we want it to stay idle (eg.
>    laptops)? what if some block devices or swap devices are busy, or
>    memory is continually being allocated and freed and/or pagecache is
>    being created and truncated but we still want to prefetch?

The code is pretty aggressive at defining busy. It looks for pretty much all 
of those and it prefetches till it stops then allowing idle to occur again. 
Opting out of prefetching whenever there is doubt seems reasonable to me.

> - for all its efforts, it will still interact with page reclaim by
>    putting pages on the LRU and causing them to be cycled.
>
>    - on bursty loads, this cycling could happen a bit. and more reads on
>      the swap devices.

Theoretically yes I agree. The definition of busy is so broad that prevents it 
prefetching that it is not significant.

> - in a sense it papers over page reclaim problems that shouldn't be so
>    bad in the first place (midnight cron). On the other hand, I can see
>    how it solves this issue nicely.

I doubt any audience that will care about scalability and complex memory 
configurations would knowingly enable it so it costs them virtually nothing 
for the relatively unintrusive code to be there. It's configurable and helps 
a unique problem that affects most users who are not in the complex hardware 
group. I was not advocating it being enabled by default, but last time it was 
in -mm akpm suggested doing that to increase its testing - while in -mm.

Cheers,
Con
