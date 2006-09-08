Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWIHIgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWIHIgg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 04:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWIHIgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 04:36:36 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:62106 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751048AbWIHIgf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 04:36:35 -0400
Date: Fri, 8 Sep 2006 09:36:33 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Avoiding fragmentation with subzone groupings v25
In-Reply-To: <20060907175848.63379fe1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609080926200.7094@skynet.skynet.ie>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
 <20060907175848.63379fe1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Andrew Morton wrote:

> On Thu,  7 Sep 2006 20:03:42 +0100 (IST)
> Mel Gorman <mel@csn.ul.ie> wrote:
>
>> When a page is allocated, the page-flags
>> are updated with a value indicating it's type of reclaimability so that it
>> is placed on the correct list on free.
>
> We're getting awful tight on page-flags.
>

Yeah, I know :(

> Would it be possible to avoid adding the flag?  Say, have a per-zone bitmap
> of size (zone->present_pages/(1<<MAX_ORDER)) bits, then do a lookup in
> there to work out whether a particular page is within a MAX_ORDER clump of
> easy-reclaimable pages?
>

An early version of the patches created such a bitmap and it was heavily 
resisted for two reasons. It put more pressure on the cache and it needed 
to be resized during hot-add and hot-remove. It was the latter issue 
people had more problems with. However, I can reimplement it if people 
want to take a look. As I see it currently, there are five choices that 
could be taken to avoid using an additional pageflag

1. Re-use existing page flags. This is what I currently do in a later
    patch for the software suspend flags
    pros: Straight-forward implementation, appears to use no additional flags
    cons: When swsusp stops using the flags, anti-frag takes them right back
          Makes anti-frag mutually exclusive with swsusp

2. Create a per-zone bitmap for every MAX_ORDER block
    pros: Straight-forward implementation initially
    cons: Needs resizing during hotadd which could get complicated
          Bit more cache pressure

3. Use the low two bits of page->lru
    pros: Uses existing struct page field
    cons: It's a bit funky looking

4. Use the page->flags of the struct page backing the pages used
    for the memmap.
    pros: Similar to the bitmap idea except with less hotadd problems
    cons: Bit more cache pressure

5. Add an additional field page->hintsflags used for non-critical flags.
    There are patches out there like guest page hinting that want to
    consume flags but not for any vital purpose and usually for machines
    that have ample amounts of memory. For these features, add an
    additional page->hintsflags
    pros: Straight-forward to implement
    cons: Increses struct page size for some kernel features.

I am leaning towards option 3 because it uses no additional memory but I'm 
not sure how people feel about using pointer magic like this.

Any opinions?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
