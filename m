Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWJQQ7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWJQQ7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWJQQ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:59:20 -0400
Received: from smtp-out.google.com ([216.239.45.12]:49954 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751311AbWJQQ7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:59:19 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=CIlmfbvCvAZasI7lNavDqyP8/uPpgz7YKtNvdzUW16TV3G50PFaXfhdIQIRW4+OVm
	3an0WcIhTP5n/zKnMY1fg==
Message-ID: <45350BD3.2060503@google.com>
Date: Tue, 17 Oct 2006 09:58:59 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Use min of two prio settings in calculating distress
 for reclaim
References: <4534323F.5010103@google.com> <45347951.3050907@yahoo.com.au> <45347B91.20404@google.com> <45347E89.8010705@yahoo.com.au> <4534E00C.1070301@google.com> <45350839.5010602@yahoo.com.au>
In-Reply-To: <45350839.5010602@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It'll stop the GFP_NOFS reclaimer going OOM. Yes, some other
>> bandaids might do that as well, but what on earth is the point? By
>> the time anyone gets to the lower prios, they SHOULD be setting
>> distress up - they ARE in distress.
> 
> Distress is a per-zone thing. It is precisely that way because there *are*
> different types of reclaim and you don't want a crippled reclaimer (which
> might indeed be having trouble reclaiming stuff) from saying the system
> is in distress.
> 
> If they are the *only* reclaimer, then OK, distress will go up.

So you'd rather the "crippled" reclaimer went and fire the OOM killer
and shoot someone instead? I don't see why we should penalise them,
especially as the dirty page throttling is global, and will just kick
pretty much anyone trying to do an allocation. There's nothing magic
about the "crippled" reclaimer as you put it. They're doing absolutely
nothing wrong, or that they should be punished for. They need a page.

>> The point of having zone->prev_priority is to kick everyone up into 
>> reclaim faster in sync with each other. Look at how it's set, it's meant
>> to function as a min of everyone's prio. Then when we start successfully
>> reclaiming again, we kick it back to DEF_PRIORITY to indicate everything
>> is OK. But that fails to take account of the fact that some reclaimers
>> will struggle more than others.
> 
> I don't agree that the thing to aim for is ensuring everyone is able
> to reclaim something.
> 
> And why do you ignore the other side of the coin, where now reclaimers
> that are easily able to make progress are being made to swap stuff out?

Because I'd rather err on the side of moving a few mapped pages from the
active to the inactive list than cause massive latencies for a page
allocation that's dropping into direct reclaim and/or going OOM.

>> If we're in direct reclaim in the first place, it's because we're
>> allocating faster than kswapd can keep up, or we're meant to be
>> throttling ourselves on dirty writeback. Either way, we need to be
>> freeing our own pages, not dicking around thrashing the LRU lists
>> without doing anything.
> 
> If the GFP_NOFS reclaimer is having a lot of trouble reclaiming, and so
> you decide to turn on reclaim_mapped, then it is not suddenly going to
> be able to free those pages.

Well it's certainly not going to work if we don't even try. There were
ZERO pages in the inactive list at this point. The system is totally
frigging hosed and we're not even trying to reclaim pages because
we're in deluded-happy-la-la land and we think everything is fine.

This is what happens as we kick down prio levels in one thread:

priority = 12 active_distress = 0 swap_tendency = 0 gfp_mask = d0
priority = 12 active_distress = 0 swap_tendency = 0 gfp_mask = d0
priority = 11 active_distress = 25 swap_tendency = 106 gfp_mask = d0
priority = 10 active_distress = 25 swap_tendency = 106 gfp_mask = d0
priority = 9 active_distress = 0 swap_tendency = 81 gfp_mask = d0
priority = 8 active_distress = 0 swap_tendency = 81 gfp_mask = d0
priority = 7 active_distress = 25 swap_tendency = 106 gfp_mask = d0
priority = 6 active_distress = 25 swap_tendency = 106 gfp_mask = d0
priority = 5 active_distress = 25 swap_tendency = 106 gfp_mask = d0
priority = 4 active_distress = 25 swap_tendency = 106 gfp_mask = d0
priority = 3 active_distress = 25 swap_tendency = 106 gfp_mask = d0
priority = 2 active_distress = 50 swap_tendency = 131 gfp_mask = d0
priority = 1 active_distress = 0 swap_tendency = 81 gfp_mask = d0
priority = 0 active_distress = 0 swap_tendency = 81 gfp_mask = d0

Notice that distress is not kicking up as priority kicks down (see
1 and 0 at the end). Because some other idiot reset prev_priority
back to 12.

>> All of this debate seems pretty pointless to me. Look at the code, and
>> what I fixed. It's clearly broken by inspection. I'm not saying this is
>> the only way to fix it, or that it fixes all the world's problems. But
>> it's clearly an incremental improvement by fixing an obvious bug.
> 
> It is not clearly broken. You have some picture in your mind of how you
> think reclaim should work, and it doesn't match that. Fine, but that
> doesn't make it a bug.

It's not just a picture in my mind, it clearly does not work in
practice. The bugfix is pretty trivial.

>> No wonder Linux doesn't degrade gracefully under memory pressure - we
>> refuse to reclaim when we need to.
> 
> If the zone is unable to be reclaimed from, then the priority will be
> lowered.

WHICH priority?

We have multiple different reclaimers firing. If ANY of them are really
struggling to reclaim, then we should start reclaiming mapped pages.
We want a min of all the reclaimers prios here. It's not like we're
going to go nuts and wipe the whole damned list, once we've got
back SWAP_CLUSTER_MAX of them, we should return.

>> PS. I think we should just remove temp_priority altogether, and use a
>> local variable.
> 
> Yes. I don't remember how temp_priority came about. I think it was Nikita?

OK, at least we agree on something.

M.
