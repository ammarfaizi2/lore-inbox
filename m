Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWFVQux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWFVQux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWFVQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:50:53 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:2775 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1751226AbWFVQux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:50:53 -0400
Date: Thu, 22 Jun 2006 17:50:50 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
In-Reply-To: <20060622161447.GC999@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606221743040.5869@skynet.skynet.ie>
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com>
 <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com>
 <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
 <20060622161447.GC999@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Russell King wrote:

> On Thu, Jun 22, 2006 at 04:54:06PM +0100, Mel Gorman wrote:
>> On Thu, 22 Jun 2006, Franck Bui-Huu wrote:
>>> It's the default value (see memory_model.h). It means that pfn start
>>> for node 0 is 0, therefore your physical memory address starts at 0.
>>
>> I know, but what I'm getting at is that ARCH_PFN_OFFSET may be unnecessary
>> with flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch applied.
>> ARCH_PFN_OFFSET is used as
>>
>> #define page_to_pfn(page)       ((unsigned long)((page) - mem_map) + \
>>                                  ARCH_PFN_OFFSET)
>>
>> because it knew that the map may not start at PFN 0. With
>> flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch, the map will
>> start at PFN 0 even if physical memory does not start until later.
>
> Doesn't that result in a massive array of struct pages if your memory
> starts a 3GB physical and has 4K pages?

No, I should have been clear. The size of the map remains the same but 
mem_map does not point directly to NODE_DATA(0)->node_mem_map when the PFN 
of node 0 is not 0. Instead mem_map points to

NODE_DATA(0)->node_mem_map - NODE_DATA(0)->node_start_pfn

The relevant bit of code is

 	map = alloc_remap(pgdat->node_id, size);
 	if (!map)
 		map = alloc_bootmem_node(pgdat, size);
 	pgdat->node_mem_map = map + (pgdat->node_start_pfn - start);

 	/*
 	 * With FLATMEM the global mem_map is used.  This is assumed
 	 * to be based at pfn 0 such that 'pfn = page* - mem_map'
 	 * is true. Adjust map relative to node_mem_map to
 	 * maintain this relationship.
 	 */
 	map -= pgdat->node_start_pfn;

and later

 	if (pgdat == NODE_DATA(0))
 		mem_map = map;

So memory is wasted and ARCH_PFN_OFFSET isn't needed in the case where it 
is working around NODE_DATA(0)->node_start_pfn != 0

> If you have only 32MB in that
> scenario, and that was correct, you'd gobble 25MB of that just to
> store that array.  Ouch.
>

It would be a kick in the shins all right if that was the case.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
