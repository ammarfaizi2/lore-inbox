Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWEDIhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWEDIhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 04:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWEDIhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 04:37:50 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:33036 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751444AbWEDIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 04:37:49 -0400
Message-ID: <4459BD39.3080006@shadowen.org>
Date: Thu, 04 May 2006 09:37:13 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Picco <bob.picco@hp.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost>
In-Reply-To: <20060504013239.GG19859@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Picco wrote:
> Nick Piggin wrote:	[Tue May 02 2006, 10:25:57AM EDT]
> 
>>Martin J. Bligh wrote:
>>
>>>>Oh that's a 32bit kernel. I don't think the 32bit NUMA has ever worked
>>>>anywhere but some Summit systems (at least every time I tried it it 
>>>>blew up on me and nobody seems to use it regularly). Maybe it would be 
>>>>finally time to mark it CONFIG_BROKEN though or just remove it (even 
>>>>by design it doesn't work very well) 
>>>
>>>
>>>Bollocks. It works fine, and is tested every single day, on every git
>>>release, and every -mm tree.
>>
>>Whatever the case, there definitely does not appear to be sufficient
>>zone alignment enforced for the buddy allocator. I cannot see how it
>>could work if zones are not aligned on 4MB boundaries.
>>
>>Maybe some architectures / subarch code naturally does this for us,
>>but Ingo is definitely hitting this bug because his config does not
>>(align, that is).
>>
>>I've randomly added a couple more cc's.
>>
> 
> The patch below isn't compile tested or correct for those cases where
> alloc_remap is called or where arch code has allocated node_mem_map for
> CONFIG_FLAT_NODE_MEM_MAP. It's just conveying what I believe the issue is.
> 
> Andy added code to buddy allocator which doesn't require the zone's endpoints
> to be aligned to MAX_ORDER. I think the issue is that the buddy
> allocator requires the node_mem_map's endpoints to be MAX_ORDER aligned. 
> Otherwise __page_find_buddy could compute a buddy not in node_mem_map
> for partial MAX_ORDER regions at zone's endpoints. page_is_buddy will
> detect that these pages at endpoints aren't PG_buddy (they were zeroed
> out by bootmem allocator and not part of zone).  Of course the negative
> here is we could waste a little memory but the positive is eliminating
> all the old checks for zone boundary conditions.

Yes this is correct.  The buddy location algorithm uses the relative pfn
number to locate the buddy.  Both the old anew new free detect
algorithms require a struct page exist for that buddy regardless of
whether the page exists in memory.  Thus the node_mem_map needs to exist
out to a MAX_ORDER boundry in both directions.  With real machines we
would likely get this as memory is mostly in larger chunks than
MAX_ORDER and generally maximally aligned.  From what I can see we could
potentially not be allocating the end correctly but the rmap allocation
would likely be larger than the request so we'd get away with it.

> 
> SPARSEMEM won't encounter this issue because of MAX_ORDER size
> constraint when SPARSEMEM is configured. ia64 VIRTUAL_MEM_MAP doesn't
> need the logic either because the holes and endpoints are handled
> differently.  This leaves checking alloc_remap and other arches which
> privately allocate for node_mem_map.
> 
> Any how I could be totally wrong but like I said this requires more
> thought.

I'll have a go at testing this to see what difference it makes.  I think
there might be a problem with the buddy merging at zone boundries as we
are anyhow (or the code commentry is incomplete), so am going to have a
look at that at the same time.

-apw
