Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSLaTO7>; Tue, 31 Dec 2002 14:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSLaTO7>; Tue, 31 Dec 2002 14:14:59 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:26329 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264705AbSLaTO5>; Tue, 31 Dec 2002 14:14:57 -0500
Date: Tue, 31 Dec 2002 11:29:35 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E11F01F.7040205@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212311844.gBVIiUe02655@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think the attached should do the necessary with no slow down in the slab 
> allocator.
> 
> Now all that has to happen for use with the dma pools is to wrapper 
> dma_alloc/free_coherent().

You didn't make anything store or return the dma_addr_t ... that was the
issue I was referring to, it's got to be either (a) passed up from the
very lowest level, like the pci_*() calls assume, or else (b) cheaply
derived from the virtual address.  My patch added slab support in common
cases where (b) applies.

(By the way -- I'm glad we seem to be agreeing on the notion that we
should have a dma_pool!  Is that also true of kmalloc/kfree analogues?)


> Note that the semantics won't be quite the same as the pci_pool one since you 
> can't guarantee that allocations don't cross the particular boundary 
> parameter.

Go back and look at the dma_pool patch I posted, which shows how to
handle that using extra padding.  Only one driver needed that, and
it looks like maybe its hardware spec changed so that's not an issue.

That's why the signature of dma_pool_create() is simpler than the
one for pci_pool_create() ... I never liked it before, and now I'm
fully convinced it _can_ be simpler.


 >    There's also going to be a reliance on the concept that the dma
> coherent allocators will return a page bounded chunk of memory.  Most seem 
> already to be doing this because the page properties are only controllable at 
> that level, so it shouldn't be a problem.

I think that's a desirable way to specify dma_alloc_coherent(), as handling
page-and-above.  The same layering as "normal" memory allocation.  (In fact,
that's how I had updated the docs.)

- Dave

