Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUCABgM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUCABgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:36:12 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:56008 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261880AbUCABgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:36:06 -0500
Message-ID: <40429228.1080301@cyberone.com.au>
Date: Mon, 01 Mar 2004 12:30:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Nikita@Namesys.COM
Subject: Re: 2.6.4-rc1-mm1
References: <20040229140617.64645e80.akpm@osdl.org>	<40428B95.1000600@cyberone.com.au> <20040229171452.2e209835.akpm@osdl.org>
In-Reply-To: <20040229171452.2e209835.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>I had one addition which is to use a "refill_counter" for inactive
>> list scanning as well so the scanning is batched up now that we don't
>> round up the amount to be done. No observed benefits, but I imagine
>> it would lower the acquisition frequency of the lru locks in some
>> cases?
>>
>
>Might do, yes.
>
>

OK I've sent you a patch to do that.

>Also I think you did some work on the inactive-vs-active list balancing?  I
>have spent precisely zero time looking at or working on that since
>2.5.nothing and it's entirely possible that it is doing something
>inappropriate.
>
>

Yes I did. I will continue to look into this.

>> Should I start testing again, or are you still doing more to vmscan?
>>
>
>Now would be a good time.  The only thing I'm likely to look at in the next
>several days is accounting for the slab fragmentation.  My current thinking
>is to solve that by making slab account for the number of objects and the
>number of pages, and to use that in shrink_dcache_memory(), so it doesn't
>touch vmscan.c at all.
>
>

My thinking is to go by number of pages. Then you get to tell the
shrinker: we scanned this many pages of LRU, so please scan an
equivalent percentage of slab *pages*.

You can then translate this to number of slab objects before scanning.

Oh, apart from that, there is still one thing that I'm not sure is
correct about slab scanning... we scan slab in response to scanning
a part of the inactive list, but we apply this pressure as if it
were a ratio of active + inactive lists.

This will cause slab to be scanned less, but my main worry is that
it makes slab scanning behaviour dependant on the ratio of active to
inactive list size: the bigger your active list, the less slab will
be scanned which I think is silly. But I might be wrong.

>> Nikita's dont-rotate-active-list.patch looks to be the only major
>> casualty. I found this patch pretty important, so I will definitely
>> like to demonstrate its benefits. One question remains, would you
>> accept the patch in its current form?
>>
>
>We should bring that back for testing, please.  I need to sit down and
>think a bit more about test suites which replicate workloads which we care
>about before making any decisions.
>
>One point I would make is that if a workload is only achieving 5% CPU
>anyway, we shouldn't optimise for it.  Sure, it's nice to be able to get it
>up to 7% but it is much more important to get the 50% CPU workload up to
>70%.  The 5% problem is a fiscal one, not an engineering one ;)
>

I agree. I'm much more interested in getting light and medium swapping
working better.

