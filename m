Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbUKCBX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbUKCBX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUKCBX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:23:27 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:26035 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261175AbUKCBXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:23:18 -0500
Message-ID: <41883300.8060707@yahoo.com.au>
Date: Wed, 03 Nov 2004 12:23:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102130910.3e779d32.akpm@osdl.org> <20041102215651.GU3571@dualathlon.random> <235610000.1099435275@flay> <20041103010952.GA3571@dualathlon.random>
In-Reply-To: <20041103010952.GA3571@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Tue, Nov 02, 2004 at 02:41:15PM -0800, Martin J. Bligh wrote:
> 
>>eh? I don't see how that matters at all. After the DMA transfer, all the 
>>cache lines will have to be invalidated in every CPUs cache anyway, so
>>it's guaranteed to be stone-dead zero-degrees-kelvin cold. I don't see how
>>however hot it becomes afterwards is relevant? 
> 
> 
> if the cold page becomes hot, it means the hot pages in the hot
> quicklist will become colder. The cache size is limited, so if something
> becomes hot, something will become cold.
> 
> The only difference is that the hot pages will become cold during the
> dma if we return an hot page, or the hot pages will become cold while
> the cpu touches the data of the previously cold page, if we return a
> cold page. Or are you worried that the cache snooping is measurable?
> 
> I believe the hot-cold thing, is mostly important for the hot
> allocations not for the cold one. So that the hot allocations are served
> in a strict LIFO order, that truly matters but the cold allocations are
> a grey area.
> 
> What kind of slowdown can you measure if you drop __GFP_COLD enterely?
> 
> Don't get me wrong, __GFP_COLD makes perfect sense since it's so little
> cost to do it that it most certainly worth the branch in the
> allocator, but I don't think the hot pages worth a _reservation_ since
> they'll become cold anwyays after the I/O has completed, so then we
> could have returned an hot page in the first place without slowing down
> in the buddy to get it.
> 

I see what you mean. You could be correct that it would model cache
behaviour better to just have the last N freed "hot" pages in LIFO
order on the list, and allocate cold pages from the other end of it.

You still don't want cold freeing to pollute this list, *but* you do
want to still batch up cold freeing to amortise the buddy's lock
aquisition.

You could do that with just one list, if you gave cold pages a small
extra allowance to batch freeing if the list is full.

> 
>>If the DMA is to pages that are hot in the CPUs cache - it's WORSE ... we
>>have more work to do in terms of cacheline invalidates. Mmm ... in terms
>>of DMAs, we're talking about disk reads (ie a new page allocates) - we're
>>both on the same page there, right?
> 
> 
> the DMA snoops the cache for the cacheline invalidate but I didn't think
> it's measurable.
> 
> I would really like to see the performance difference of disabling the
> __GFP_COLD thing for the allocations and to force picking from the head
> of the list (and to always free the cold pages a the tail), I doubt you
> will measure anything.
> 

I think you want to still take them off the cold end. Taking a
really cache hot page and having it invalidated is worse than
having some cachelines out of your combined pool of hot pages
pushed out when you heat the cold page.

