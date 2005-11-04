Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVKDQW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVKDQW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbVKDQW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:22:59 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:62685 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751610AbVKDQW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:22:58 -0500
Date: Fri, 4 Nov 2005 16:22:39 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.64.0511031102590.27915@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0511041553590.22563@skynet>
References: <4366C559.5090504@yahoo.com.au>
 <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au>
 <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu>
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au>
 <306020000.1131032193@[10.10.2.4]><1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org><Pine.LNX.4.58.0511031613560.3571@skynet><Pine.LNX.4.64.0511030842050.27915@g5.osdl.org><309420000.1131036740@[10.10.2.4]>
 <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]>
 <314040000.1131043735@[10.10.2.4]> <Pine.LNX.4.64.0511031102590.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Linus Torvalds wrote:

>
>
> On Thu, 3 Nov 2005, Martin J. Bligh wrote:
> >
> > Ha. Just because I don't think I made you puke hard enough already with
> > foul approximations ... for order 2, I think it's
>
> Your basic fault is in believing that the free watermark would stay
> constant.
>
> That's insane.
>
> Would you keep 8MB free on a 64MB system?
>
> Would you keep 8MB free on a 8GB system?
>
> The point being, that if you start with insane assumptions, you'll get
> insane answers.
>
> The _correct_ assumption is that you aim to keep some fixed percentage of
> memory free. With that assumption and your math, finding higher-order
> pages is equally hard regardless of amount of memory.
>
> Now, your math then doesn't allow for the fact that buddy automatically
> coalesces for you, so in fact things get _easier_ with more memory, but
> hey, that needs more math than I can come up with (I never did it as math,
> only as simulations with allocation patterns - "smart people use math,
> plodding people just try to simulate an estimate" ;)
>

My math is not that great either, so here is a simulation.

Setup: Reboot the machine which is a quad xeon xSeries 350 with 1.5GiB of
RAM. Configure /proc/sys/vm/min_free_kbytes to try and keep 1/8th of
physical memory free. This is to keep in line with your suggestion that
fragmentation is low when there is a higher percentage of memory free.

Load: Run a load - 7 kernels compiling simultaneously at -j2 which gives
loads between 10-14. Try and get 50% worth of physical memory in 4MiB
pages (1024 contiguous pages) while compiling. When the test ends and the
system is quiet, try again. 4MiB in this case is a single HugeTLB page.

Here are the results;

2.6.14-rc5-mm1-clean (OOM killer disabled) Allocating Under Load
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        24
Failed allocs:         136
DMA zone allocs:       0
Normal zone allocs:    16
HighMem zone allocs:   8
% Success:            15

2.6.14-rc5-mm1-mbuddy-v19 Allocating Under Load
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        24
Failed allocs:         136
DMA zone allocs:       0
Normal zone allocs:    11
HighMem zone allocs:   13
% Success:            15

Not a lot of difference there and the success rate is not great.
mbuddy-v19 is a bit better at the normal zone and that's about it. These
results are not surprising as kswapd is making no effort to get contiguous
pages. Under a load of 7 kernel compiles, kswapd will not free pages fast
enough.

When the test ends and the system is quiet, try and get 80% of physical
memory in large pages. 4 attempts are made to satisfy the requests to give
kswapd lots of time.

2.6.14-rc5-mm1-clean (OOM killer disabled) Allocating while rested
Order:                 10
Allocation type:       HighMem
Attempted allocations: 300
Success allocs:        159
Failed allocs:         141
DMA zone allocs:       0
Normal zone allocs:    46
HighMem zone allocs:   113
% Success:            53

Mainly highmem there.

2.6.14-rc5-mm1-mbuddy-v19 Allocating while rested
Order:                 10
Allocation type:       HighMem
Attempted allocations: 300
Success allocs:        212
Failed allocs:         88
DMA zone allocs:       0
Normal zone allocs:    102
HighMem zone allocs:   110
% Success:            70

Look at the big difference in the number of successful allocations in
ZONE_NORMAL because the kernel allocations were kept together. Experience
has shown me that failure to get higher success rates depended on per-cpu
pages and the number of kernel pages that leaked to other areas (56 over
the course of this test). Kernel pages leaking was helped a lot by setting
min_free_kbytes higher than the default.

I then ported forward the linear scanner and ran the tests again. The
linear scanner does two things - finds linear reclaimable pages using
information provided by anti-defrag and drains the per-cpu caches. I'll
post the linear scanner code if people want to look at it but it's really
crap. It's slow, works too hard and doesn't try to hold on to the pages
for the process reclaiming the pages are just some of it's problems. I
need to rewrite it almost from scratch and avoid all the mistakes but it's
a path that is hit *only* if you are allocating high orders.

2.6.14-rc5-mm1-mbuddy-v19-lnscan Allocating under load
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        155
Failed allocs:         0
DMA zone allocs:       0
Normal zone allocs:    12
HighMem zone allocs:   143
% Success:            96

Mainly got it's pages back from highmem which is always easier as long as
PTE pages are not in the way.

2.6.14-rc5-mm1-mbuddy-v19-lnscan Allocating while rested
Order:                 10
Allocation type:       HighMem
Attempted allocations: 300
Success allocs:        275
Failed allocs:         0
DMA zone allocs:       0
Normal zone allocs:    133
HighMem zone allocs:   142
% Success:            91

That is 71% of physical memory available in contiguous blocks with the
linear scanner but that code is not ready. anti-defrag on it's own as it
is today was able to get 55% of physical memory in 4MiB chunks.

This is provided without performance regressions in the normal case
everyone cares about. In my tests, there are minor improvements on aim9
which is artificial, and gained a few seconds on kernel build tests which
people do care about.

Does these patches still make no sense to you? Lower fragmentation that
does not impact the cases everyone cares about? If so, why?

To get the best possibly results, a zone approach could still be built on
top of this and it seems as if it's worth developing. At the cost of some
configuration, the zone would give *hard* guarantees on the available
number of large pages and anti-defrag would give best effort everywhere
else. By default without configuration, you would get best-effort.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
