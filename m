Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759296AbWLAJyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759296AbWLAJyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759299AbWLAJyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:54:16 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:45698 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1759297AbWLAJyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:54:13 -0500
Date: Fri, 1 Dec 2006 09:54:11 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061130173129.4ebccaa2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006, Andrew Morton wrote:

> On Thu, 30 Nov 2006 17:07:46 +0000
> mel@skynet.ie (Mel Gorman) wrote:
>
>> Am reporting this patch after there were no further comments on the last
>> version.
>
> Am not sure what to do with it - nothing actually uses __GFP_MOVABLE.
>

Nothing yet. To begin with, this is just a documentation mechanism. I'll 
be trying to push page clustering one piece at a time which will need 
this. The markings may also be of interest to containers and to pagesets 
because it will clearly flag what are allocations in use by userspace.

>> It is often known at allocation time when a page may be migrated or not.
>
> "often", yes.
>
>> This
>> page adds a flag called __GFP_MOVABLE and GFP_HIGH_MOVABLE. Allocations using
>> the __GFP_MOVABLE can be either migrated using the page migration mechanism
>> or reclaimed by syncing with backing storage and discarding.
>>
>> Additional credit goes to Christoph Lameter and Linus Torvalds for shaping
>> the concept. Credit to Hugh Dickens for catching issues with shmem swap
>> vector and ramfs allocations.
>>
>> ...
>>
>> @@ -65,7 +65,7 @@ static inline void clear_user_highpage(s
>>  static inline struct page *
>>  alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
>>  {
>> -	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
>> +	struct page *page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, vaddr);
>>
>>  	if (page)
>>  		clear_user_highpage(page, vaddr);
>
> But this change is presumptuous.  alloc_zeroed_user_highpage() doesn't know
> that its caller is going to use the page for moveable purposes.  (Ditto lots
> of other places in this patch).
>

according to grep -r, alloc_zeroed_user_highpage() is only used in two 
places, do_wp_page() (when write faulting the zero page)[1] and 
do_anonymous_page() (when mapping the zero page for the first time and 
writing). In these cases, they are known to be movable. What am I missing?

[1] I missed a call to GFP_HIGHUSER in do_wp_page() that should have been 
GFP_HIGH_MOVABLE.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
