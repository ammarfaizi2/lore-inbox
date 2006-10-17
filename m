Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWJQNyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWJQNyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWJQNyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:54:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:59115 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750917AbWJQNyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:54:07 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=lVEJcy9IbdAW7jBu74da5x1mWzZK/WqJcomlr7qqdfBacJepMblYC0mSDWXuDAxrk
	F8tzgDJrwn8Nm/WgYqg1w==
Message-ID: <4534E00C.1070301@google.com>
Date: Tue, 17 Oct 2006 06:52:12 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Use min of two prio settings in calculating distress
 for reclaim
References: <4534323F.5010103@google.com> <45347951.3050907@yahoo.com.au> <45347B91.20404@google.com> <45347E89.8010705@yahoo.com.au>
In-Reply-To: <45347E89.8010705@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> That's not what happens though. We walk down the priorities, fail to
>> reclaim anything (in this case, move anything from active to inactive)
>> and the OOM killer fires. Perhaps the other pages being freed are
>> being stolen ... we're in direct reclaim here. we're meant to be
>> getting our own pages.
> 
> 
> That may be what happens in *your* kernel, but does it happen upstream?
> Because I expect this patch would fix the problem
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=408d85441cd5a9bd6bc851d677a10c605ed8db5f 
> 
> 
> (together with the zone_near_oom thing)

So? I fail to see how slapping another bandaid on top of it prevents
us from fixing an underlying problem.

>> Why would we ever want distress to be based off a priority that's
>> higher than our current one? That's just silly.
> 
> Maybe there is an occasional GFP_NOFS reclaimer, and the workload 
> involves a huge number of easy to reclaim inodes. If there are some 
 > GFP_KERNEL allocators (or kswapd) that are otherwise making a meal
 > of this work, then we don't want to start swapping stuff out.
 >
> Hypothetical maybe, but you can't just make the assertion that it is 
> just silly, because that isn't clear. And it isn't clear that your 
 > patch fixes anything.

It'll stop the GFP_NOFS reclaimer going OOM. Yes, some other
bandaids might do that as well, but what on earth is the point? By
the time anyone gets to the lower prios, they SHOULD be setting
distress up - they ARE in distress.

The point of having zone->prev_priority is to kick everyone up into 
reclaim faster in sync with each other. Look at how it's set, it's meant
to function as a min of everyone's prio. Then when we start successfully
reclaiming again, we kick it back to DEF_PRIORITY to indicate everything
is OK. But that fails to take account of the fact that some reclaimers
will struggle more than others.

If we're in direct reclaim in the first place, it's because we're
allocating faster than kswapd can keep up, or we're meant to be
throttling ourselves on dirty writeback. Either way, we need to be
freeing our own pages, not dicking around thrashing the LRU lists
without doing anything.

All of this debate seems pretty pointless to me. Look at the code, and
what I fixed. It's clearly broken by inspection. I'm not saying this is
the only way to fix it, or that it fixes all the world's problems. But
it's clearly an incremental improvement by fixing an obvious bug.

No wonder Linux doesn't degrade gracefully under memory pressure - we
refuse to reclaim when we need to.

M.

PS. I think we should just remove temp_priority altogether, and use a
local variable.
