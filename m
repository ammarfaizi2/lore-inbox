Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVJ1Cmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVJ1Cmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 22:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbVJ1Cmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 22:42:52 -0400
Received: from hera.kernel.org ([140.211.167.34]:6563 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965062AbVJ1Cmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 22:42:52 -0400
Date: Thu, 27 Oct 2005 19:35:48 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: magnus.damm@gmail.com, clameter@sgi.com, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-ID: <20051027213548.GB8128@logos.cnet>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <aec7e5c30510201857r7cf9d337wce9a4017064adcf@mail.gmail.com> <20051022005050.GA27317@logos.cnet> <aec7e5c30510230550j66d6e37fg505fd6041dca9bee@mail.gmail.com> <20051024074418.GC2016@logos.cnet> <aec7e5c30510250437h6c300066s14e39a0c91be772c@mail.gmail.com> <20051025143741.GA6604@logos.cnet> <aec7e5c30510260004p5a3b07a9v28ae67b2982f1945@mail.gmail.com> <20051027150142.GE13500@logos.cnet> <20051027134347.56d29cfa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051027134347.56d29cfa.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On Thu, Oct 27, 2005 at 01:43:47PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > The fair approach would be to have the
> >  number of pages to reclaim also relative to zone size.
> >
> >  sc->nr_to_reclaim = (zone->present_pages * sc->swap_cluster_max) /
> >                                  total_memory;
> 
> You can try it, but that shouldn't matter.  SWAP_CLUSTER_MAX is just a
> batching factor used to reduce CPU consumption.  If you make it twice as
> bug, we run DMA-zone reclaim half as often - it should balance out.

But you're not taking the relationship between DMA and NORMAL zone 
into account?

I suppose that a side effect of such change is that more allocations
will become serviced from the NORMAL/HIGHMEM zones ("more intensively
reclaimed") while less allocations will become serviced by the DMA zone
(whose scan/reclaim progress should now be _much_ lighter than that of
the NORMAL zone). ie DMA zone will be much less often "available" for
GFP_HIGHMEM/GFP_KERNEL allocations, which are the vast majority.

Might be talking BS though.

What else could explain this numbers from Magnus, taking into account
that a large number of pages in the DMA zone are used for kernel text,
etc. These unbalancing seems to be potentially suboptimal (and result
in unpredictable behaviour depending from which zone pages becomes
allocated from):

"$ cat /proc/zoneinfo | grep present
        present  4096
        present  225280
        present  30342
                                                                                                                                              
$ cat /proc/zoneinfo | grep tscanned
        tscanned 151352
        tscanned 3480599
        tscanned 541466
                                                                                                                                              
"tscanned" counts how many pages that has been scanned in each zone
since power on. Executive summary assuming that only LRU pages exist
in the zone:
                                                                                                                                              
DMA: each page has been scanned ~37 times
Normal: each page has been scanned ~15 times
HighMem: each page has been scanned ~18 times"

I feel that I'm reaching the point where things should be confirmed
instead of guessed (on my part!).
