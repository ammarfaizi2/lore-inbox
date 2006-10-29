Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWJ2Uxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWJ2Uxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWJ2Uxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:53:44 -0500
Received: from main.gmane.org ([80.91.229.2]:33161 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030210AbWJ2Uxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:53:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
Followup-To: gmane.linux.kernel
Date: Sun, 29 Oct 2006 15:53:12 -0500
Message-ID: <ei34bo$dhr$1@sea.gmane.org>
References: <454442DC.9050703@google.com> <20061029000513.de5af713.akpm@osdl.org> <454471C3.2020005@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18b86566.dyn.optonline.net
User-Agent: KNode/0.10.4
Cc: linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Andrew Morton wrote:
>> --- a/mm/vmalloc.c~__vmalloc_area_node-fix
>> +++ a/mm/vmalloc.c
>> @@ -428,7 +428,8 @@ void *__vmalloc_area_node(struct vm_stru
>>  area->nr_pages = nr_pages;
>>  /* Please note that the recursion is strictly bounded. */
>>  if (array_size > PAGE_SIZE) {
>> -            pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
>> +            pages = __vmalloc_node(array_size, gfp_mask & ~__GFP_HIGHMEM,
>> +                                    PAGE_KERNEL, node);
>>  area->flags |= VM_VPAGES;
>>  } else {
>>  pages = kmalloc_node(array_size,
> 
> Don't you actually *want* the page array to be allocated from highmem? So
> the gfp mask here should be just for whether we're allowed to sleep /
> reclaim (ie gfp_mask & ~(__GFP_DMA|__GFP_DMA32) | (__GFP_HIGHMEM))?
> 
> Slab allocations should be (gfp_mask &
> ~(__GFP_DMA|__GFP_DMA32|__GFP_HIGHMEM)), which you could mask in
> __get_vm_area_node
> 

Since gfp_mask there would also have GFP_ZERO, we need to mask off that too.
How about my earlier suggestion of masking off flags in __get_vm_area_node
with GFP_LEVEL_MASK?

Giri

PS: I am not sure if this mail gets to all recipients in the original
thread - I am not subscribed to lkml and I haven't found a way to reply to
all people and the group.

