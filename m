Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758377AbWK0QcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758377AbWK0QcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758376AbWK0QcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:32:23 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:22663 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1758375AbWK0QcW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:32:22 -0500
Date: Mon, 27 Nov 2006 16:32:20 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Mel Gorman <mel@skynet.ie>,
       Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611260039070.27769@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0611271628260.18063@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org> <20061124104422.GA23426@skynet.ie>
 <Pine.LNX.4.64.0611241924110.17508@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611251058350.6991@woody.osdl.org>
 <Pine.LNX.4.64.0611260039070.27769@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2006, Hugh Dickins wrote:

> On Sat, 25 Nov 2006, Linus Torvalds wrote:
>> On Fri, 24 Nov 2006, Hugh Dickins wrote:
>>>
>>> You need to add in something like the patch below (mutatis mutandis
>>> for whichever approach you end up taking): tmpfs uses highmem pages
>>> for its swap vector blocks, noting where on swap the data pages are,
>>> and allocates them with mapping_gfp_mask(inode->i_mapping); but we
>>> don't have any mechanism in place for reclaiming or migrating those.
>>
>> I think this really just points out that you should _not_ put MOVABLE into
>> the "mapping_gfp_mask()" at all.
>>
>> The mapping_gfp_mask() should really just contain the "constraints" on
>> the allocation, not the "how the allocation is used". So things like "I
>> need all my pages to be in the 32bit DMA'able region" is a constraint on
>> the allocator, as is something like "I need the allocation to be atomic".
>>
>> But MOVABLE is really not a constraint on the allocator, it's a guarantee
>> by the code _calling_ the allocator that it will then make sure that it
>> _uses_ the allocation in a way that means that it is movable.
>>

Later, MOVABLE might be a constraint. For example, hotpluggable nodes may 
only allow MOVABLE allocations to be allocated.

>> So it shouldn't be a property of the mapping itself, it should always be a
>> property of the code that actually does the allocation.
>>
>> Hmm?
>
> Not anything I feel strongly about, but I don't see it that way.
>
> mapping_gfp_mask() seems to me nothing more than a pragmatic way
> of getting the appropriate gfp_mask down to page_cache_alloc().
>

And that is important for any filesystem that uses generic_file_read(). As 
page_cache_alloc() has no knowledge of the filesystem, it depends on the 
mapping_gfp_mask() to determine if the pages are movable or not.

> alloc_inode() initializes it to whatever suits most filesystems
> (currently GFP_HIGHUSER), and those who differ adjust it (e.g.
> block_dev has good reason to avoid highmem so sets it to GFP_USER
> instead).  It used to be the case that several filesystems lacked
> kmap() where needed, and those too would set GFP_USER: what you call
> a constraint seems to me equally a property of the surrounding code.
>
> If __GFP_MOVABLE is coming in, and most fs's are indeed allocating
> movable pages, then I don't see why MOVABLE shouldn't be in the
> mapping_gfp_mask.  Specifying MOVABLE constrains both the caller's
> use of the pages, and the way they are allocated; as does HIGHMEM.
>

>From what I've seen, the majority of filesystems are suitable for using 
__GFP_MOVABLE and it would be clearer to have GFP_HIGH_MOVABLE as the 
default and setting GFP_HIGHUSER in filesystems like ramfs.

> And we shouldn't be guided by the way tmpfs (ab?)uses that gfp_mask
> for its metadata allocations as well as its page_cache_alloc()s:
> that's just a special case.  Though the ramfs case is more telling
> (its pagecache pages being not at present movable).
>
> Hugh
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
