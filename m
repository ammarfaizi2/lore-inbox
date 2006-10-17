Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWJQOJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWJQOJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWJQOJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:09:12 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41198 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751059AbWJQOJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:09:10 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=svunZkSQzzvRngYapxl8dHutC1OHC7MIvLkW1M5jrJuYYl9/8Jc1Rfi1iJ+9FttLO
	TuQm8BSQfbNwtGjfitYCQ==
Message-ID: <4534E397.8090505@google.com>
Date: Tue, 17 Oct 2006 07:07:19 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Fix bug in try_to_free_pages and balance_pgdat when they
 fail to reclaim pages
References: <453425A5.5040304@google.com> <453475A4.2000504@yahoo.com.au> <453479D2.1090302@google.com> <45347CA3.9020904@yahoo.com.au>
In-Reply-To: <45347CA3.9020904@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well, it's zone->temp_priority, which was set to DEF_PRIORITY at the
>> top of the function, though I suppose something else might have
>> changed it since.
> 
> Yes.

...

>>> If that happens, shouldn't prev_priority be set to 0?
>>
>> Yes, but it's not. We fall off the bottom of the loop, and set it
>> back to temp_priority. At best, the code is unclear.
> 
> But temp_priority should be set to 0 at that point.

It that were true, it'd be great. But how?
This is everything that touches it:

0 mmzone.h     <global>             208 int temp_priority;
1 page_alloc.c free_area_init_core 2019 zone->temp_priority =
                                         zone->prev_priority = DEF_PRIORITY;
2 vmscan.c     shrink_zones         937 zone->temp_priority = priority;
3 vmscan.c     try_to_free_pages    987 zone->temp_priority = DEF_PRIORITY;
4 vmscan.c     try_to_free_pages   1031 zone->prev_priority =
                                         zone->temp_priority;
5 vmscan.c     balance_pgdat       1081 zone->temp_priority = DEF_PRIORITY;
6 vmscan.c     balance_pgdat       1143 zone->temp_priority = priority;
7 vmscan.c     balance_pgdat       1189 zone->prev_priority =
                                         zone->temp_priority;
8 vmstat.c     zoneinfo_show        593 zone->temp_priority,

Only thing that looks interesting here is shrink_zones.

>> I suppose shrink_zones() might in theory knock temp_priority down
>> as it goes, so it might come out right. But given that it's a global
>> (per zone), not per-reclaimer, I fail to see how that's really safe.
>> Supposing someone else has just started reclaim, and is still at
>> prio 12?
> 
> But your loops are not exactly per reclaimer either. Granted there
> is a large race window in the current code, but this patch isn't the
> way to fix that particular problem.

Why not? Perhaps it's not a panacea, but it's a definite improvement.

>> Moreover, whilst try_to_free_pages calls shrink_zones, balance_pgdat
>> does not. Nothing else I can see sets temp_priority.
> 
> balance_pgdat.

That's only called from kswapd. If we're in balance_pgdat, we ARE 
kswapd. We can't fix ourself. So effectively we're doing:

while (priority--) {
	if (we reclaimed OK)
		goto out;
}
out:
prev_priority = DEF_PRIORITY;

We've just walked the whole bloody list with priority set to 0.

We failed to reclaim a few pages.

We know the world is in deep pain.

Why the hell would we elevate prev_priority?

> Unnecesary and indicates something else is broken if you are seeing
> problems here.

You think we should set prev_priority up, when we've just walked the
whole list at prio 0 and can't reclaim anything? Unless so, I fail
to see how the patch is unnecessary.

And yes, I'm sure other things are broken, but again, this fixes a
clear bug.

>> I'm inclined to think the whole concept of temp_priority and
>> prev_priority are pretty broken. This may not fix the whole thing,
>> but it seems to me to make it better than it was before.
> 
> I think it is broken too. I liked my split active lists, but at that point
> vmscan.c was in don't-touch mode.

I'm glad we agree it's broken. Whilst we await the 100th rewrite of the
VM, perhaps we can apply this simple fix?

> OK, so it sounds like temp_priority is being overwritten by the
> race. I'd consider throwing out temp_priority completely, and just
> going with adjusting prev_priority as we go.

I'm fine with that. Whole thing is racy as hell and pretty pointless
anyway. I'll make another patch up today.

>> Forward ported from an earlier version of 2.6 ... but I don't see
>> why we need extra heuristics here, it seems like a clear and fairly
>> simple bug. We're in deep crap with reclaim, and we go set the
>> global indicator back to "oh no, everything's fine". Not a good plan.
> 
> All that reclaim_mapped code is pretty arbitrary anyway. What is needed
> is the zone_is_near_oom so we can decouple all those heuristics from
> the OOM decision. 

It seems what is needed is that we start to actually reclaim pages when
priority gets low. This is a very simple way of improving that.

 > So do you still see the problem on upstream kernel
> without your patches applied?

I can't slap an upstream bleeding edge kernel across a few thousand
production machines, and wait to see if the world blows up, sorry.
If I can make a reproduce test case, I'll send it out, but thus far
we've been unsuccessful.

But I can see it happening in earlier versions, and I can read the
code in 2.6.18, and see obvious bugs.

M.
