Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbUJWQav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUJWQav (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUJWQau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:30:50 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:31893 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261228AbUJWQ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:28:39 -0400
Message-ID: <417A86AC.2080505@yahoo.com.au>
Date: Sun, 24 Oct 2004 02:28:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au> <20041022165809.GH14325@dualathlon.random> <4179DF23.4030402@yahoo.com.au> <20041023095955.GR14325@dualathlon.random> <417A30EE.1030205@yahoo.com.au> <20041023110334.GS14325@dualathlon.random>
In-Reply-To: <20041023110334.GS14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Sat, Oct 23, 2004 at 08:22:38PM +1000, Nick Piggin wrote:
> 
>>It is an unlikely scenario, but it is definitely good for robustness.
>>Especially on small memory systems where the amount allocated doesn't
>>have to be that large.
>>
>>Let's say a 16MB system pages_low ~= 64K, so we'll also say we've
> 
> 
> btw, thinking the watermarks linear with the amount of memory isn't
> correct. the watermarks for zone normal against zone normal (i.e. the
> current pages_xx of 2.6) should have an high and low limit indipendent
> on the memory size of the machine. the low limit is what the machine
> needs to avoid locking up in the PF_MEMALLOC paths. So it obviously has
> absolutely nothing to do with the amount of ram in the machine.
> 

No, you are right there of course. However, I think 64K will be the
reality in this case because I just did a sysrq+M and took a look
at my ZONE_DMA (ie. 16MB) limits.

However, it does have something to do with the amount of concurrency
in the system - the chance of multiple tasks in PF_MEMALLOC on a larger
system (with more tasks, more CPUs) will increase of course.

> 64k sounds way too low even for a PDA that doesn't swap, still there are
> PF_MEMALLOC paths in the dcache and fs methods.
> 
> but this is just a side note, let's assume 64k would be sane in this
> workload (a page size smaller than 4k that in turn requires less ram to
> execute method on each page object would make it sane for example).
> 

Maybe - I haven't really looked at those paths at all... but yeah it
is a peripheral issue. We can continue that in another thread sometime
:)

> 
>>currently got 64K free. Someone then wants to do an order 4 allocation
>>OK they succeed (assuming memory isn't fragmented) and there's 0K free.
>>
>>Which is bad because you can now get deadlocks when trying to free
>>memory.
> 
> 
> I got what you mean, I misread that code sorry, you're perfectly right
> about order being needed in that code.
> 
> In 2.4 I had to implement it too of course, it's just much cleaner than
> 2.6.
> 
> static inline unsigned long zone_free_pages(zone_t * zone, unsigned int order)
> {
> 	long free = zone->free_pages - (1UL << order);
> 	return free >= 0 ? free : 0;
> }
> 
> 
> 	for (;;) {
> 		zone_t *z = *(zone++);
> 		if (!z)
> 			break;
> 
> 		if (zone_free_pages(z, order) > z->watermarks[class_idx].low) {
> 			page = rmqueue(z, order);
> 			if (page)
> 				return page;
> 		}
> 	}
> 
> 
> this compares with your 2.6 code:
> 
> 	for (i = 0; (z = zones[i]) != NULL; i++) {
> 		min = z->pages_min;
> 		if (gfp_mask & __GFP_HIGH)
> 			min /= 2;
> 		if (can_try_harder)
> 			min -= min / 4;
> 		min += (1<<order) + z->protection[alloc_type];
> 
> 		if (z->free_pages < min)
> 			continue;
> 
> 		page = buffered_rmqueue(z, order, gfp_mask);
> 		if (page)
> 			goto got_pg;
> 	}
> 

Although you put 2.6 in a bad light with this code ;)
__GFP_HIGH and can_try_harder are pretty important... It
does look like the continue could be replaced with the
2.4 version's negated if statement to be a bit cleaner

> When I was reading "z->free_pages < min" in your code, I was really
> reading like my code here "zone_free_pages(z, order) > z->watermarks[class_idx].low"
> I was taking for given the free_pages - 1UL<<order was already accounted
> in z->free_pages, because I hidden that calculation in a method so I'm
> not used to think about it while reading alloc_pages (I assumed that
> thing was already accounted for in a different function like in 2.4).
> 
> Sorry if I'm biased but I read and modified 2.4 many more times than
> 2.6.
> 

That's OK.

> 
>>Oh if you've still got the three watermarks then that may work -
>>I thought you meant getting rid of one of the *completely*.
>>
>>But I'm still not sure what advantage you see in moving from
>>pages_xxx + protection to a single watermark.
> 
> 
> then what advantage you get to compute pages_xx + protection at runtime
> when reading a pages_xx that already contains the protection would be
> enough? I avoid computations at runtime and I keep the localized in the
> watermark generation. I doubt it makes much difference but this is the
> way I did in 2.4 and it looks cleaner to me, plus this avoids me to
> reinvent the wheel.
> 

In kswapd you really just want the pages_xxx value (well, pages_high).

