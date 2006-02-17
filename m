Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWBQRRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWBQRRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 12:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWBQRRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 12:17:42 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:28295 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751141AbWBQRRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 12:17:42 -0500
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot
	time
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
In-Reply-To: <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
	 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 09:16:58 -0800
Message-Id: <1140196618.21383.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 14:17 +0000, Mel Gorman wrote:
> This patch adds the kernelcore= parameter for ppc64.
> 
> The amount of memory will requested will not be reserved in all nodes. The
> first node that is found that can accomodate the requested amount of memory
> and have remaining more for ZONE_EASYRCLM is used. If a node has memory holes,
> it also will not be used.

One thing I think we really need to see before these go into mainline is
the ability to shrink the ZONE_EASYRCLM at runtime, and give the memory
back to NORMAL/DMA.

Otherwise, any system starting off sufficiently small will end up having
lowmem starvation issues.  Allowing resizing at least gives the admin a
chance to avoid those issues.

> +               if (core_mem_pfn == 0 ||
> +                               end_pfn - start_pfn < core_mem_pfn ||
> +                               end_pfn - start_pfn != pages_present) {
> +                       zones_size[ZONE_DMA] = end_pfn - start_pfn;
> +                       zones_size[ZONE_EASYRCLM] = 0;
> +                       zholes_size[ZONE_DMA] =
> +                               zones_size[ZONE_DMA] - pages_present;
> +                       zholes_size[ZONE_EASYRCLM] = 0;
> +                       if (core_mem_pfn >= pages_present)
> +                               core_mem_pfn -= pages_present;
> +               } else {
> +                       zones_size[ZONE_DMA] = core_mem_pfn;
> +                       zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;
> +                       zholes_size[ZONE_DMA] = 0;
> +                       zholes_size[ZONE_EASYRCLM] = 0;
> +                       core_mem_pfn = 0;
> +               }

I'm finding this bit of code really hard to parse. 

First of all, please give "core_mem_size" and "core_mem_pfn" some better
names.  "core_mem_size" in _what_?  Bytes?  Pages?  g0ats? ;)

The "pfn" in "core_mem_pfn" is usually used to denote a physical address
>> PAGE_SHIFT.  However, yours is actually a _number_ of pages, not an
address, right?  Actually, as I look at it closer, it appears to be a
pfn in the else{} and a nr_page in the if{} block.  

core_mem_nr_pages or nr_core_mem_pages might be more appropriate.

Users will _not_ care about memory holes.  They'll just want to specify
a number of pages.  I think this:

> +                       zones_size[ZONE_DMA] = core_mem_pfn;
> +                       zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;

is probably bogus because it doesn't deal with holes at all.

Walking those init_node_data() structures in get_region() is probably
pretty darn fast, and we don't need to be careful about how many times
we do it.  I think I'd probably separate out the problem a bit.

1. make get_region() not care about holes.  Have it just return the
   range of the node's pages.
2. make a new function (get_region_holes()??) that, given a pfn range,
   walks the init_node_data[] just like get_region() (have them share
   code) and return the present_pages in that pfn range.
3. go back to paging init, and try to properly size ZONE_DMA.  Find
   holes with your new function, and increase its size proportionately,
   set zholes_size[ZONE_DMA] at this time.  Make sure the user size is
   in nr_page, _NOT_ max_pfns.
4. give the rest of the space to ZONE_EASYRCLM.  Call your new function
   to properly size its zone hole(s).
5. Profit!

This may all belong broken out in a new function.  

-- Dave

