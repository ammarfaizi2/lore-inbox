Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWBGDIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWBGDIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWBGDIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:08:43 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:1463 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932444AbWBGDIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:08:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=f+6MmCsWKgRsKTX+zTTR5XmKaGtPpM3dExTXl+ZqGcUMj31t9Dl69tawz+b09J7S1fjODpCxhj3TXor324xbyy0ttv+dUqMxmZHe5K9kiLZ0d356Kr6YpM2acOG4sATHr+ZB4IgVhIgq3eQEom/VJ/3ctmqj1i/ZnwajmYPRFqQ=  ;
Message-ID: <43E80F36.8020209@yahoo.com.au>
Date: Tue, 07 Feb 2006 14:08:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
References: <200602071028.30721.kernel@kolivas.org>
In-Reply-To: <200602071028.30721.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Andrew et al
> 
> I'm resubmitting the swap prefetching patch for inclusion in -mm and hopefully
> mainline. After you removed it from -mm there were some people that described
> the benefits it afforded their workloads. -mm being ever so slightly quieter
> at the moment please reconsider.
> 

I have a few comments.

prefetch_get_page is doing funny things with zones and nodes / zonelists
(eg. 'We don't prefetch into DMA' meaning something like 'this only works
on i386 and x86-64').

buffered_rmqueue, zone_statistics, etc really should to stay static to
page_alloc.

It is completely non NUMA or cpuset-aware so it will likely allocate memory
in the wrong node, and will cause cpuset tasks that have their memory swapped
out to get it swapped in again on other parts of the machine (ie. breaks
cpuset's memory partitioning stuff).

It introduces global cacheline bouncing in pagecache allocation and removal
and page reclaim paths, also low watermark failure is quite common in normal
operation, so that is another global cacheline write in page allocation path.

Why bother with the trylocks? On many architectures they'll RMW the cacheline
anyway, so scalability isn't going to be much improved (or do you see big
lock contention?)

Aside from those issues, I think the idea has is pretty cool... but there are
a few things that get to me:

- it is far more common to reclaim pages from other mappings (not swap).
   Shouldn't they have the same treatment? Would that be more worthwhile?

- when is a system _really_ idle? what if we want it to stay idle (eg.
   laptops)? what if some block devices or swap devices are busy, or
   memory is continually being allocated and freed and/or pagecache is
   being created and truncated but we still want to prefetch?

- for all its efforts, it will still interact with page reclaim by
   putting pages on the LRU and causing them to be cycled.

   - on bursty loads, this cycling could happen a bit. and more reads on
     the swap devices.

- in a sense it papers over page reclaim problems that shouldn't be so
   bad in the first place (midnight cron). On the other hand, I can see
   how it solves this issue nicely.


> Cheers,
> Con
> ---
> This patch implements swap prefetching when the vm is relatively idle and
> there is free ram available. The code is based on some early work by Thomas
> Schlichter.
> 

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
