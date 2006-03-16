Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWCPPdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWCPPdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCPPde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:33:34 -0500
Received: from mx.pathscale.com ([64.160.42.68]:37564 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751183AbWCPPde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:33:34 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 07:33:21 -0800
Message-Id: <1142523201.25297.56.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 14:24 +0000, Hugh Dickins wrote:

> I think Bryan's problem is probably that he has allocated a
> high-order page (via pci_alloc_consistent or dma_alloc_coherent),
> and is then exposing the constituents of that high-order page to
> userspace via nopage: when the final munmap or exit comes,
> the constituent pages get freed without realizing they're
> supposed to be part of one high-order page.

Yes, that sounds about right.  Some of the allocations in question are
order-1, and some are higher.

> We had the same problem in sound/core/memalloc.c, and fixed it
> by using a compound page (a high-order page in which each constituent
> knows it's part of the larger whole): see the two uses of __GFP_COMP
> in that file, and in particular the one where snd_malloc_dev_pages
> calls dma_alloc_coherent.

Will do, thanks.  Will the allocator give me a compound page if I ask
for a single page but pass __GFP_COMP, or do I need to be sure I always
make a higher-order request if I pass that flag?

> No.  That isn't how VM_DONTCOPY behaves, and I don't know what you were
> thinking to bring it into the discussion there - if you have pages which
> are supposed to be shared across forks, that happens without any special
> flag, doesn't it?  We only teach VM_DONTCOPY in the second year,
> I think Bryan would best forget it for now ;)

Heh.  Actually, in this case, I really don't want the vma to get shared
with a child.  If the child gets a SEGV after a fork, that's intended
behaviour, as far as I'm concerned.

> RDMA
> is finding it a useful flag to get around a peculiarly frustrating issue
> with get_user_pages: though that successfully pins pages, a fork followed
> by parent writing to pinned private page will put a _copy_ of that page
> into the parent's userspace (if child holds a reference to the original),
> which likely defeats the purpose of pinning.

That's a useful aside, thanks.  It sounds like I want to set VM_DONTCOPY
on the pages I'm doing get_user_pages on too, then.

> He shouldn't set VM_SHM, it means nothing.

Is that the case for kernels prior to 2.6.15, too?

The problem is that I need to keep a version of the driver working on
kernels back as far as 2.6.9, in addition to the current mainline.  If
VM_SHM meant nothing back then, too, I can remove it entirely, otherwise
I should drop it only in the for-mainline driver, and leave the backport
version as it stands.

>   If he's dealing with real
> allocated pages, he shouldn't set VM_IO (but remap_pfn_range will set
> it for him if it's used).  He shouldn't set VM_RESERVED (won't do any
> harm, but we're quite likely to remove it soon).

Yes, I actually dropped both of these last night.

> He shouldn't set VM_LOCKED (it would make the locked_vm accounting
> go wrong - unless he's careful to participate in that accounting,
> as Infiniband's uverbs_mem.c creditably does).

Well, uverbs_mem.c only touches locked_vm for pages it's pinned using
get_free_pages.  We do much the same thing in that case.

I'll try turning off VM_LOCKED for the pages we allocate, and see what
breaks :-)

	<b

