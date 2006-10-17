Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWJQG4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWJQG4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWJQG4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:56:18 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:63831 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932164AbWJQG4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:56:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OaVjQG31IZxqvu3BU94h8Hl4iLbETgNRKw7KwijPxtszRrTlGdwrh83YMiDyDes3h+CJnJm1wjgax0UXRg4pShGmoO7XWbwDwSEDk8aw3Zqo11lJYB65gv6WmC6B8hu2URjCKWRDZXNt1JL35R84kG70vgLlYsT0PaDvai2eeBs=  ;
Message-ID: <45347E89.8010705@yahoo.com.au>
Date: Tue, 17 Oct 2006 16:56:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Use min of two prio settings in calculating distress
 for reclaim
References: <4534323F.5010103@google.com> <45347951.3050907@yahoo.com.au> <45347B91.20404@google.com>
In-Reply-To: <45347B91.20404@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> Nick Piggin wrote:
>
>> Martin Bligh wrote:
>>
>>> Another bug is that if try_to_free_pages / balance_pgdat are called
>>> with a gfp_mask specifying GFP_IO and/or GFP_FS, they may reclaim
>>> the requisite number of pages, and reset prev_priority to DEF_PRIORITY.
>>>
>>> However, another reclaimer without those gfp_mask flags set may still
>>> be struggling to reclaim pages. The easy fix for this is to key the
>>> distress calculation not off zone->prev_priority, but also take into
>>> account the local caller's priority by using:
>>> min(zone->prev_priority, sc->priority)
>>
>>
>>
>> Does it really matter who is doing the actual reclaiming? IMO, if the
>> non-crippled (GFP_IO|GFP_FS) reclaimer is making progress, the other
>> guy doesn't need to start swapping, and should soon notice that some
>> pages are getting freed up.
>
>
> That's not what happens though. We walk down the priorities, fail to
> reclaim anything (in this case, move anything from active to inactive)
> and the OOM killer fires. Perhaps the other pages being freed are
> being stolen ... we're in direct reclaim here. we're meant to be
> getting our own pages.


That may be what happens in *your* kernel, but does it happen upstream?
Because I expect this patch would fix the problem

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=408d85441cd5a9bd6bc851d677a10c605ed8db5f

(together with the zone_near_oom thing)

>
> Why would we ever want distress to be based off a priority that's
> higher than our current one? That's just silly.


Maybe there is an occasional GFP_NOFS reclaimer, and the workload 
involves a huge
number of easy to reclaim inodes. If there are some GFP_KERNEL 
allocators (or kswapd)
that are otherwise making a meal of this work, then we don't want to 
start swapping
stuff out.

Hypothetical maybe, but you can't just make the assertion that it is 
just silly,
because that isn't clear. And it isn't clear that your patch fixes anything.

>> Workloads where non GFP_IO or GFP_FS reclaimers are having a lot of
>> trouble indicates that either it is very swappy or page writeback has
>> broken down and lots of dirty pages are being reclaimed off the LRU.
>> In either case, they are likely to continue to have problems, even if
>> they are now able to unmap the odd page.
>
>
> We scanned 122,000 odd pages. Of which we skipped over over 100,000
> of them because they were mapped, and we didn't think we had to try
> very hard, because distress was 0.


So... presumably next time, we will try harder?

>> What are the empirical effects of this patch? What's the numbers? And
>> what have you done to akpm? ;)
>
>
> Showed him a real trace of a production system blowing up?
> Demonstrated that the current heuristics are broken?
> That sort of thing.


So, what kernel did you test?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
