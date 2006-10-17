Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWJQQnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWJQQnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWJQQnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:43:39 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:52671 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751308AbWJQQni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:43:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zPJW8I5nSYagieJ1eqK9LxVdnhYub8nCylzd7Qk0MCzTVaoXzsgn8I40/Pl90S4fHCEzmRZWRWXIwp+234jEKJn93JFgyNfcwqeqrqRQM0/HaGx976rm37w8lMwvry06YnfkPJE26vIBISgL72GScxgyYfBLk71Z8NpGe6OxOCQ=  ;
Message-ID: <45350839.5010602@yahoo.com.au>
Date: Wed, 18 Oct 2006 02:43:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Use min of two prio settings in calculating distress
 for reclaim
References: <4534323F.5010103@google.com> <45347951.3050907@yahoo.com.au> <45347B91.20404@google.com> <45347E89.8010705@yahoo.com.au> <4534E00C.1070301@google.com>
In-Reply-To: <4534E00C.1070301@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>> That's not what happens though. We walk down the priorities, fail to
>>> reclaim anything (in this case, move anything from active to inactive)
>>> and the OOM killer fires. Perhaps the other pages being freed are
>>> being stolen ... we're in direct reclaim here. we're meant to be
>>> getting our own pages.
>>
>>
>>
>> That may be what happens in *your* kernel, but does it happen upstream?
>> Because I expect this patch would fix the problem
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=408d85441cd5a9bd6bc851d677a10c605ed8db5f 
>>
>>
>> (together with the zone_near_oom thing)
> 
> 
> So? I fail to see how slapping another bandaid on top of it prevents
> us from fixing an underlying problem.

That is the fix for the underlying problem. The underlying problem is that
OOM was being triggered incorrectly without enough scanning. Your patch
is the bandaid which just tries to increase the amount of scanning a bit
in the hope that it holds off OOM for your workload.

>>> Why would we ever want distress to be based off a priority that's
>>> higher than our current one? That's just silly.
>>
>>
>> Maybe there is an occasional GFP_NOFS reclaimer, and the workload 
>> involves a huge number of easy to reclaim inodes. If there are some 
> 
>  > GFP_KERNEL allocators (or kswapd) that are otherwise making a meal
>  > of this work, then we don't want to start swapping stuff out.
>  >
> 
>> Hypothetical maybe, but you can't just make the assertion that it is 
>> just silly, because that isn't clear. And it isn't clear that your 
> 
>  > patch fixes anything.
> 
> It'll stop the GFP_NOFS reclaimer going OOM. Yes, some other
> bandaids might do that as well, but what on earth is the point? By
> the time anyone gets to the lower prios, they SHOULD be setting
> distress up - they ARE in distress.

Distress is a per-zone thing. It is precisely that way because there *are*
different types of reclaim and you don't want a crippled reclaimer (which
might indeed be having trouble reclaiming stuff) from saying the system
is in distress.

If they are the *only* reclaimer, then OK, distress will go up.

> The point of having zone->prev_priority is to kick everyone up into 
> reclaim faster in sync with each other. Look at how it's set, it's meant
> to function as a min of everyone's prio. Then when we start successfully
> reclaiming again, we kick it back to DEF_PRIORITY to indicate everything
> is OK. But that fails to take account of the fact that some reclaimers
> will struggle more than others.

I don't agree that the thing to aim for is ensuring everyone is able
to reclaim something.

And why do you ignore the other side of the coin, where now reclaimers
that are easily able to make progress are being made to swap stuff out?

> If we're in direct reclaim in the first place, it's because we're
> allocating faster than kswapd can keep up, or we're meant to be
> throttling ourselves on dirty writeback. Either way, we need to be
> freeing our own pages, not dicking around thrashing the LRU lists
> without doing anything.

If the GFP_NOFS reclaimer is having a lot of trouble reclaiming, and so
you decide to turn on reclaim_mapped, then it is not suddenly going to
be able to free those pages.

> All of this debate seems pretty pointless to me. Look at the code, and
> what I fixed. It's clearly broken by inspection. I'm not saying this is
> the only way to fix it, or that it fixes all the world's problems. But
> it's clearly an incremental improvement by fixing an obvious bug.

It is not clearly broken. You have some picture in your mind of how you
think reclaim should work, and it doesn't match that. Fine, but that
doesn't make it a bug.

> 
> No wonder Linux doesn't degrade gracefully under memory pressure - we
> refuse to reclaim when we need to.

If the zone is unable to be reclaimed from, then the priority will be
lowered.

> PS. I think we should just remove temp_priority altogether, and use a
> local variable.

Yes. I don't remember how temp_priority came about. I think it was Nikita?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
