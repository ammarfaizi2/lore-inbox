Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263280AbUKBDDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbUKBDDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S514525AbUKBDDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 22:03:44 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:16061 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272007AbUKBCyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 21:54:15 -0500
Message-ID: <4186F6D3.6010909@yahoo.com.au>
Date: Tue, 02 Nov 2004 13:54:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random>
In-Reply-To: <20041102022122.GJ3571@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Nov 01, 2004 at 11:34:19PM +0100, Andrea Arcangeli wrote:
> 
>>On Mon, Nov 01, 2004 at 10:03:56AM -0800, Martin J. Bligh wrote:
>>
>>>[..] it was to stop cold
>>>allocations from eating into hot pages [..]
>>
>>exactly, and I believe that hurts. bouncing on the global lock is going to
>>hurt more than preserving an hot page (at least on a 512-way). Plus the
>>cold page may very soon become hot too.
> 
> 
> I've read your reply via the web in some archive since my email is down
> right now (probably some upgrade is underway).
> 
> 
> with global I mean the buddy lock, which is global for all cpus.
> 

Hmm... yeah they global, but also per-zone. And most of the
page activity will be coming from the node local CPUs hopefully.

I guess the exception could be things like ZONE_NORMAL for big
highmem systems, but I think we don't want to be doing too much
more to accomodate those dinosaurs nowadays.


> The idea that the quicklist is meant to take the lock once every X pages
> is limiting. The object is to never ever have to enter the buddy, not
> just to "buffer" allocations. The two separated cold/hot lists prevents
> that. As far as there's a single page available we should use it since
> bouncing the cacheline is very costly.
> 

Well yeah. I'm still unconvinced that the cacheline is bouncing
all that much.. I'm sure some of the guys at SGI will have profiles
lying around for their bigger systems though.

> It's really a question if you believe the cache effects are going to be
> more significant than the cacheline bouncing on the zone lock. I do
> believe the latter is several order of magnitude more severe issue.
> Hence I allow fallbacks both ways (I even allow fallback across the zero
> pages that carry more info than just an hot cache). Mainline doesn't
> allow any fallback at all instead and that's certainly wrong.
> 
> BTW, please apply PG_zero-2-no-zerolist-reserve-1 on top of PG_zero-2
> too if you're going to run any bench (PG_zero-2 alone doesn't give
> zeropages to non-zero users and I don't like it that much even if it
> mirrors the quicklists better). And to make a second run to disable the
> idle clearing sysctl you can just write 0 into the last entry of the
> per_cpu_pages syctl.
> 
> If you can run the bench with several cpus and with with mem=1G that
> will put into action other bugfixes as well.
> 
> 
>>Plus you should at least allow an hot allocation to eat into the cold
>>pages (which didn't happen IIRC).
> 
> 
> all I could see is that it doesn't fallback in 2.6.9, and that's fixed
> with the single list of course ;). Plus I provide hot-cold caching on
> the zero list too (zero list guarantees all pages have PG_zero set, but
> that's the only difference with the hot-cold list). cold info is
> retained in the zero list too so you can freely allocate with __GFP_ZERO
> and __GFP_COLD, or even __GFP_ZERO|__GFP_ONLY_ZERO|__GFP_COLD etc...
> 

OK well I guess any changes are a matter for the numbers to decide,
speculation only gets one so far :)

(Great to see you're getting more time to work on 2.6 BTW).
