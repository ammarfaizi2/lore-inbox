Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966281AbWKYLrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966281AbWKYLrU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 06:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935155AbWKYLrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 06:47:20 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:45532 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S934045AbWKYLrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 06:47:19 -0500
Date: Sat, 25 Nov 2006 11:47:17 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611242056260.20312@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0611251143080.19594@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org> <20061124104422.GA23426@skynet.ie>
 <Pine.LNX.4.64.0611241924110.17508@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611242004520.3938@skynet.skynet.ie>
 <Pine.LNX.4.64.0611242056260.20312@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Hugh Dickins wrote:

> On Fri, 24 Nov 2006, Mel Gorman wrote:
>>
>> Good catch. In the page clustering patches I work on, I am doing this;
>>
>> -       page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
>> +       page = alloc_page_vma(
>> +                       set_migrateflags(gfp | __GFP_ZERO, __GFP_RECLAIMABLE),
>> +                                                               &pvma, 0);
>>
>> to get rid of the MOVABLE flag and replace it with __GFP_RECLAIMABLE. This
>> clustered the allocations together with allocations like inode cache. In
>> retrospect, this was not a good idea because it assumes that tmpfs and shmem
>> pages are short-lived. That may not be the case at all.
>> ...
>> Thanks for that clarification. I suspected that something like this was the
>> case when I removed the MOVABLE flag and used RECLAIMABLE but I wasn't 100%
>> certain. In the tests I was running, tmpfs pages weren't a major problem so I
>> didn't chase it down.
>
> I'm fairly confused as to what MOVABLE versus RECLAIMABLE is supposed to
> be meaning, and understand it's in flux, so haven't tried too hard.

A MOVABLE allocation may be moved with page migration or paged out by 
kswapd.

RECLAIMABLE on the other hand applies to short-lived allocations (like a 
socket buffer) or allocations for slab caches that may be reaped such as 
inode caches or dcache.

> Just
> so long as you understand that tmpfs data pages go out to swap under memory
> pressure, whereas ramfs pages do not, and tmpfs swap vector pages do not.
>

Right, I'll take a much closer look with this in mind and make the 
distinction. Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
