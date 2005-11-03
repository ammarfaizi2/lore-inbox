Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbVKCXjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbVKCXjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbVKCXjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:39:42 -0500
Received: from dvhart.com ([64.146.134.43]:45487 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030535AbVKCXjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:39:41 -0500
Date: Thu, 03 Nov 2005 15:39:36 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <53860000.1131061176@flay>
In-Reply-To: <Pine.LNX.4.64.0511031459110.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au><Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au><Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu><1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu><1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu><1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu><436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost><43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]><4369824E.2020407@yahoo.com.au><306020000.1131032193@[10.10.2.4]><1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org><Pine.LNX.4.58.0511031613560.3571@skynet>
 <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org><309420000.1131036740@[10.10.2.4]><Pine.LNX.4.64.0511030918110.27915@g5.osdl.org><311050000.1131040276@[10.10.2.4]><314040000.1131043735@[10.10.2.4]><Pine.LNX.4.64.0511031102590.27915@g5.osdl.org> <43370000.1131057466@flay> <Pine.LNX.4.64.0511031459110.27915@g5.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahh, you're right, there's a totally separate watermark for highmem.
> 
> I think I even remember this. I may even be responsible. I know some of 
> our less successful highmem balancing efforts in the 2.4.x timeframe had 
> serious trouble when they ran out of highmem, and started pruning lowmem 
> very very aggressively. Limiting the highmem water marks meant that it 
> wouldn't do that very often.
> 
> I think your patch may in fact be fine, but quite frankly, it needs 
> testing under real load with highmem.
> 
> In general, I don't _think_ we should do anything different for highmem at 
> all, and we should just in general try to keep a percentage of pages 
> available. Now, the percentage probably does depend on the zone: we should 
> be more aggressive about more "limited" zones, ie the old 16MB DMA zone 
> should probably try to keep a higher percentage of free pages around than 
> the normal zone, and that in turn should probably keep a higher percentage 
> of pages around than the highmem zones.

Hmm. it strikes me that there will be few (if any?) allocations out of 
highmem. PPC64 et al dump everything into ZONE_DMA though - so those should
be uncapped already.
 
> And that's not because of fragmentation so much, but simply because the 
> lower zones tend to have more "desperate" users. Running out of the normal 
> zone is thus a "worse" situation than running out of highmem. And we 
> effectively never want to allocate from the 16MB DMA zone at all, unless 
> it is our only choice.

Well it's not 16MB on the other platforms, but ...

> We actually do try to do that with that "lowmem_reserve[]" logic, which 
> reserves more pages in the lower zones the bigger the upper zones are (ie 
> if we _only_ have memory in the low 16MB, then we don't reserve any of it, 
> but if we have _tons_ of memory in the high zones, then we reserve more 
> memory for the low zones and thus make the watermarks higher for them).
> 
> So the watermarking interacts with that lowmem_reserve logic, and I think 
> that on HIGHMEM, you'd be screwed _twice_: first because the "pages_min" 
> is limited, and second because HIGHMEM has no lowmem_reserve.
> 
> Does that make sense?

Yes. So we were only capping highmem before, now I squint at it closer.
I was going off a simplification I'd written for a paper, which is
not generally correct. I doubt frag is a problem in highmem, so maybe
the code is correct as-is. We only want contig allocs for virtual when
it's mapped 1-1 to physical (ie the kernel mapping) or real physical
things. 

I suppose I could write something to trawl the source tree to check
that assumption, but it feels right ...

M.
