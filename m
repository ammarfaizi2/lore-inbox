Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWJQRPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWJQRPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWJQRPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:15:00 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:39595 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751128AbWJQRO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:14:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Y5T5uB3FnIodhO1Hr12PSUZP+bnqZWsIRM/QvL/5NRm+DHHj+E+XEi9SPgO7lCLUslLNlXQFgCOSsOsOn56JeutgmR9ESD1bMGAyYuNsXyUPt9RJV7PkxVR7YTxpwRHN95RmDbNqRkWMoVrkHGc8wMC9j60K19OLXG5rNpk9ryE=  ;
Message-ID: <45350F92.7010207@yahoo.com.au>
Date: Wed, 18 Oct 2006 03:14:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Use min of two prio settings in calculating distress
 for reclaim
References: <4534323F.5010103@google.com> <45347951.3050907@yahoo.com.au> <45347B91.20404@google.com> <45347E89.8010705@yahoo.com.au> <4534E00C.1070301@google.com> <45350839.5010602@yahoo.com.au> <45350BD3.2060503@google.com>
In-Reply-To: <45350BD3.2060503@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
>> Distress is a per-zone thing. It is precisely that way because there 
>> *are*
>> different types of reclaim and you don't want a crippled reclaimer (which
>> might indeed be having trouble reclaiming stuff) from saying the system
>> is in distress.
>>
>> If they are the *only* reclaimer, then OK, distress will go up.
> 
> 
> So you'd rather the "crippled" reclaimer went and fire the OOM killer
> and shoot someone instead?

No, so I fixed that.
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=408d85441cd5a9bd6bc851d677a10c605ed8db5f

> I don't see why we should penalise them,
> especially as the dirty page throttling is global, and will just kick
> pretty much anyone trying to do an allocation. There's nothing magic

How does dirty page throttling kick anyone trying to do an allocation?
It kicks at page dirtying time.

> about the "crippled" reclaimer as you put it. They're doing absolutely
> nothing wrong, or that they should be punished for. They need a page.

When did I say anything about magic or being punished? They need a page
and they will get it when enough memory gets freed. Pages being reclaimed
by process A may be allocated by process B just fine.

>> I don't agree that the thing to aim for is ensuring everyone is able
>> to reclaim something.
>>
>> And why do you ignore the other side of the coin, where now reclaimers
>> that are easily able to make progress are being made to swap stuff out?
> 
> 
> Because I'd rather err on the side of moving a few mapped pages from the
> active to the inactive list than cause massive latencies for a page
> allocation that's dropping into direct reclaim and/or going OOM.

We shouldn't go OOM. And there are latencies everywhere and this won't
fix them. A GFP_NOIO allocator can't swap out pages at all, for example.

>> If the GFP_NOFS reclaimer is having a lot of trouble reclaiming, and so
>> you decide to turn on reclaim_mapped, then it is not suddenly going to
>> be able to free those pages.
> 
> 
> Well it's certainly not going to work if we don't even try. There were
> ZERO pages in the inactive list at this point. The system is totally
> frigging hosed and we're not even trying to reclaim pages because
> we're in deluded-happy-la-la land and we think everything is fine.

So that could be the temp_priority race. If no progress is being made
anywhere, the current logic (minus races) says that prev_prio should
reach 0. Regardless of whether it is GFP_NOFS or whatever.

> This is what happens as we kick down prio levels in one thread:
> 
> priority = 12 active_distress = 0 swap_tendency = 0 gfp_mask = d0
> priority = 12 active_distress = 0 swap_tendency = 0 gfp_mask = d0
> priority = 11 active_distress = 25 swap_tendency = 106 gfp_mask = d0
> priority = 10 active_distress = 25 swap_tendency = 106 gfp_mask = d0
> priority = 9 active_distress = 0 swap_tendency = 81 gfp_mask = d0
> priority = 8 active_distress = 0 swap_tendency = 81 gfp_mask = d0
> priority = 7 active_distress = 25 swap_tendency = 106 gfp_mask = d0
> priority = 6 active_distress = 25 swap_tendency = 106 gfp_mask = d0
> priority = 5 active_distress = 25 swap_tendency = 106 gfp_mask = d0
> priority = 4 active_distress = 25 swap_tendency = 106 gfp_mask = d0
> priority = 3 active_distress = 25 swap_tendency = 106 gfp_mask = d0
> priority = 2 active_distress = 50 swap_tendency = 131 gfp_mask = d0
> priority = 1 active_distress = 0 swap_tendency = 81 gfp_mask = d0
> priority = 0 active_distress = 0 swap_tendency = 81 gfp_mask = d0
> 
> Notice that distress is not kicking up as priority kicks down (see
> 1 and 0 at the end). Because some other idiot reset prev_priority
> back to 12.

Fine, so fix that race rather than papering over it by using the min
of prev_priority and current priority.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
