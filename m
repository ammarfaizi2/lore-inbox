Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWEDPWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWEDPWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWEDPWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:22:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:31177 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751501AbWEDPWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:22:04 -0400
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
From: Dave Hansen <haveblue@us.ibm.com>
To: Bob Picco <bob.picco@hp.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060504013239.GG19859@localhost>
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de>
	 <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de>
	 <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>
	 <20060504013239.GG19859@localhost>
Content-Type: text/plain
Date: Thu, 04 May 2006 08:21:06 -0700
Message-Id: <1146756066.22503.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't thought through it completely, but these two lines worry me:

> + start = pgdat->node_start_pfn & ~((1 << (MAX_ORDER - 1)) - 1);
> + end = start + pgdat->node_spanned_pages;

Should the "end" be based off of the original "start", or the aligned
"start"?

(using decimal math to make it easy) ... 

Let's say that MAX_ORDER comes out to be 10 pages.  node_start_pfn is 9,
and the node's end pfn is 21.  node_spanned_pages will be 12.  "start"
will get rounded down to 0.  "end" will be "start" (0) +
node_spanned_pages (12), so 12.  "end" then gets rounded up to 20.
However, this is not sufficient space for the mem_map as the node
*actually* ended at 21.

I think that "end" needs to be calculated without rounding down the
start_pfn, or the node_spanned_pages number needs to be rounded up in
the same way that "end" is.

Does that sound right? 

Also, it might look nicer if there was an intermediate variable
something like this:

	#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))

Take a look at the loop below, I've also used ALIGN() from kernel.h for
the "end" alignment.  I think it is just a drop-in replacement.  

        /* ia64 gets its own node_mem_map, before this, without bootmem */
        if (!pgdat->node_mem_map) {
               unsigned long size, start, end;
               struct page *map;

               /*
                * The zone's endpoints aren't required to be MAX_ORDER
                * aligned but the node_mem_map endpoints must be in order
                * for the buddy allocator to function correctly.
                */
               start = pgdat->node_start_pfn & ~(MAX_ORDER_NR_PAGES - 1);
               end = start + pgdat->node_spanned_pages;
               end = ALIGN(end, MAX_ORDER_NR_PAGES);
               size =  (end - start) * sizeof(struct page);
               map = alloc_remap(pgdat->node_id, size);
               if (!map)
                       map = alloc_bootmem_node(pgdat, size);
               pgdat->node_mem_map = map + (pgdat->node_start_pfn - start);
       }

-- Dave

