Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUKAX0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUKAX0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381724AbUKAXZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:25:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1703 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S310570AbUKAWGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:06:09 -0500
Date: Mon, 01 Nov 2004 14:05:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: PG_zero
Message-ID: <172560000.1099346733@flay>
In-Reply-To: <20041101215709.GD3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <20041030140732.2ccc7d22.akpm@osdl.org> <20041030224528.GB3571@dualathlon.random> <43630000.1099236900@[10.10.2.4]> <20041101215709.GD3571@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, November 01, 2004 22:57:09 +0100 Andrea Arcangeli <andrea@novell.com> wrote:

> On Sun, Oct 31, 2004 at 07:35:03AM -0800, Martin J. Bligh wrote:
>> I'll non-micro-benchmark stuff for you on big machines if you want, but I've 
>> wasted enough time coding this stuff already ;-)
>> 
>> BTW, the one really useful thing the whole page zeroing stuff did was to
>> shift the profiled cost of page zeroing out to the routine acutally using
>> the pages, as it's no longer just do_anonymous_page taking the cache hit.
> 
> I'm not a big fan of the idle zeroing myself despite I implemented it.
> The only performance difference I can measure is the microbenchmark
> running 3 times faster, everything else seems the same.
> 
> However the real point of the patch is to address all other issues with
> the per-cpu list and to fixup the lack of pte_quicklist in 2.6, and to
> avoid wasting zeropages (like the pte_quicklists did) by sharing them
> with all other page-zero users.
>  
> I'm fine to drop the idle zeroing stuff, it just took another half an
> hour to add it so I did it just in case (it can be already disabled via
> sysctl of course).
> 
> btw, how did you implement idle zeroing? had you two per-cpu lists,
> where the idle zeroing only refile across the two per-cpu lists like I
> did? 

I did a nasty hack (I was just testing perf). I think Andy added another 
per-cpu queue, when he redid my stuff properly.

> Did you address the COW with zeropage? the design I did for it is
> the only one I could imagine beneficial at all, I would never attempt
> taking any spinlock on the idle task.

I really don't see much point in the COW'ed zeropage thing - it just
generates more minor faults. From the stuff I measured, I couldn't find
anything that read from an allocated page, and never wrote to it. I've
turned it off before, and just given them their own page straight away,
and it had no perf impact.

> No idea if you also were just
> refiling pages across two per-cpu lists. I need two lists anyways, one
> is the hot-cold one (shared to avoid wasting memory like 2.6 mainline)
> and one is the zero-list that is needed to avoid the lack of
> pte_quicklists and to cache the PG_zero info (it actually renders
> pte_quicklists obsolete since they're less optimal at utilizing zero
> resources).

Yeah, fair enough. the only issue is that I think cold allocators could
steal hot pages the way you're doing it (ie if we set up a big DMA).

> Plus the patch fixes other issues like trying all per-cpu
> lists in the classzone before falling back to the buddy allocator.

Yeah, that seems like a good thing to do ... except on machines with
big highmem, won't we exhaust ZONE_NORMAL much quicker?

> It
> removes the low watermark and other minor details. The idle zeroing is
> just a minor thing in the whole patch, the point of PG_zero is to create
> an infrastructure in the main page allocator that is capable of caching
> already zero data like ptes.
> 
> So far this in practice has been an improvement or a noop, and it solves
> various theoretical issues too, but I still need to test on some bigger
> box and see if it makes any difference there or not... But since it's
> rock solid here, it was good enough for posting ;)

Heh. If it's the same as what you posted before, I'll do a sniff test on
one of teh big boxes here.

M
