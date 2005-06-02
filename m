Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVFBAFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVFBAFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVFBAFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:05:43 -0400
Received: from dvhart.com ([64.146.134.43]:55462 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261538AbVFBACk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:02:40 -0400
Date: Wed, 01 Jun 2005 17:02:35 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <434510000.1117670555@flay>
In-Reply-To: <429E483D.8010106@yahoo.com.au>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay> <429E483D.8010106@yahoo.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> It adds a lot of complexity to the page allocator and while
>>> it might be very good, the only improvement we've been shown
>>> yet is allocating lots of MAX_ORDER allocations I think? (ie.
>>> not very useful)
>> 
>> 
>> I agree that MAX_ORDER allocs aren't interesting, but we can hit 
>> frag problems easily at way less than max order. CIFS does it, NFS 
>> does it, jumbo frame gigabit ethernet does it, to name a few. The 
>> most common failure I see is order 3. 
>> 
> 
> Still? We had a lot of problems with kswapd not doing its
> job properly, and min_free_kbytes reserve was buggy...
> 
> But if you still trigger it, I would be interested to see
> traces. I don't frequently test things like XFS, or heavy
> gige+jumbo loads.

It gets very messy when CIFS requires a large buffer to write back
to disk in order to free memory ...

[c0000000af5e6590] [c00000000008f780] .__alloc_pages+0x3a4/0x40c (unreliable)
[c0000000af5e6670] [c0000000000afae8] .alloc_pages_current+0xac/0xd0
[c0000000af5e6700] [c00000000008f808] .__get_free_pages+0x20/0x98
[c0000000af5e6780] [c000000000094594] .kmem_getpages+0x48/0x200
[c0000000af5e6800] [c0000000000959cc] .cache_grow+0xf0/0x1f0
[c0000000af5e68b0] [c000000000095d4c] .cache_alloc_refill+0x280/0x2fc
[c0000000af5e6960] [c000000000096114] .kmem_cache_alloc+0x9c/0xc0
[c0000000af5e69f0] [c00000000008db54] .mempool_alloc_slab+0x1c/0x30
[c0000000af5e6a70] [c00000000008d96c] .mempool_alloc+0x154/0x234
[c0000000af5e6b80] [d0000000004f1ee0] .cifs_buf_get+0x28/0x74 [cifs]
[c0000000af5e6c00] [d0000000004d77d0] .smb_init+0x358/0x3c4 [cifs]
[c0000000af5e6d20] [d0000000004d90a8] .CIFSSMBWrite+0x7c/0x34c [cifs]
[c0000000af5e6e00] [d0000000004ec394] .cifs_write+0x204/0x374 [cifs]
[c0000000af5e6ef0] [d0000000004ec6d0] .cifs_partialpagewrite+0x1cc/0x2b8 [cifs]
[c0000000af5e6fc0] [d0000000004ec87c] .cifs_writepage+0xc0/0x148 [cifs]
[c0000000af5e7050] [c000000000099834] .pageout+0x138/0x1c4
[c0000000af5e7130] [c000000000099b90] .shrink_list+0x2d0/0x608
[c0000000af5e7280] [c00000000009a24c] .shrink_cache+0x384/0x610
[c0000000af5e73c0] [c00000000009ad1c] .shrink_zone+0x104/0x140
[c0000000af5e7460] [c00000000009ade0] .shrink_caches+0x88/0xac
[c0000000af5e74f0] [c00000000009af54] .try_to_free_pages+0x10c/0x280
[c0000000af5e75f0] [c00000000008f660] .__alloc_pages+0x284/0x40c
[c0000000af5e76d0] [c0000000000afae8] .alloc_pages_current+0xac/0xd0
[c0000000af5e7760] [c000000000093b30] .do_page_cache_readahead+0x12c/0x210
[c0000000af5e7840] [c000000000093e38] .page_cache_readahead+0x224/0x280
[c0000000af5e78d0] [c00000000008a664] .do_generic_mapping_read+0x118/0x470
[c0000000af5e7a30] [c00000000008adc0] .__generic_file_aio_read+0x1c0/0x208
[c0000000af5e7b00] [c00000000008ae4c] .generic_file_aio_read+0x44/0x54
[c0000000af5e7b90] [c0000000000b6dd4] .do_sync_read+0xb8/0xfc
[c0000000af5e7cf0] [c0000000000b6f60] .vfs_read+0x148/0x1ac
[c0000000af5e7d90] [c0000000000b72b8] .sys_read+0x4c/0x8c
[c0000000af5e7e30] [c000000000011180] syscall_exit+0x0/0x18

There's one example ... we can probably work around it if we try hard
enough. However, the fundamental question becomes "do we support higher
order allocs, or not?". If not fine ... but we ought to quit pretending
we do. If so, then we need to make them more reliable.

>> Keep a machine up for a while, get it thoroughly fragmented, then 
>> push it reasonably hard constant pressure, and try allocating anything
>> large. 
>> 
>> Seems to me we're basically pointing a blunderbuss at memory, and 
>> blowing away large portions, and *hoping* something falls out the
>> bottom that's a big enough chunk?
> 
> Yeah more or less. But with the fragmentation patch, it by
> no means becomes an exact science ;) I wouldn't have thought
> it would make it hugely easier to free an order 2 or 3 area
> memory block on a loaded machine.

Ummm. so the blunderbuss is an exact science? ;-) At least it fairly
consistently doesn't work, I suppose ;-) ;-)
 
> It does make MAX_ORDER allocations _possible_ when previously
> they wouldn't have been, simply by virtue of trying to put all
> memory that it knows is reclaimable in a MAX_ORDER area. When
> memory fills up and you need an order 3 allocation, you're
> more or less in the same boat AFAIKS.

If we could target specific "clustered blobs" of pages, we can stand
a hope of getting some big chunks back. I think the intent is to 
separate out the reclaimable from the non-reclaimable, to some extent
at least ... give us much better odds.
 
> Why not just have kernel allocations going from the bottom
> up, and user allocations going from the top down. That would
> get you most of the way there, wouldn't it? (disclaimer: I
> could well be talking shit here).

Not sure it's quite that simple, though I haven't looked in detail
at these patches. My point was merely that we need to do *something*.
Off the top of my head ... what happens when kernel meets user in
the middle. where do we free and allocate from now ? ;-) Once we've
been up for a while, mem is nearly all used, nearly all of the time.

Is a good discussion to have though ;-)

M.

