Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWCPOYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWCPOYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 09:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWCPOYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 09:24:08 -0500
Received: from gold.veritas.com ([143.127.12.110]:59542 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750831AbWCPOYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 09:24:07 -0500
X-IronPort-AV: i="4.02,197,1139212800"; 
   d="scan'208"; a="57273381:sNHT32926176"
Date: Thu, 16 Mar 2006 14:24:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "Bryan O'Sullivan" <bos@pathscale.com>, rdreier@cisco.com,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <20060315213813.747b5967.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
 <ada4q27fban.fsf@cisco.com> <1141948516.10693.55.camel@serpentine.pathscale.com>
 <ada1wxbdv7a.fsf@cisco.com> <1141949262.10693.69.camel@serpentine.pathscale.com>
 <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain>
 <ada3bhjuph2.fsf@cisco.com> <1142475069.6994.114.camel@localhost.localdomain>
 <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain>
 <20060315192813.71a5d31a.akpm@osdl.org> <1142485103.25297.13.camel@camp4.serpentine.com>
 <20060315213813.747b5967.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 14:24:06.0876 (UTC) FILETIME=[48A031C0:01C64905]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006, Andrew Morton wrote:
> "Bryan O'Sullivan" <bos@pathscale.com> wrote:
> > 
> >         Bad page state at __free_pages_ok (in process 'mpi_hello', page ffff8100020e2f88)
> >         flags:0x0100000000000804 mapping:0000000000000000 mapcount:0 count:0 (Not tainted)
> 
> Someone left PG_private set on this page (!)

That's pretty sure to be from page_alloc.c's internal use of
PagePrivate, for the buddy system of free pages.

I think Bryan's problem is probably that he has allocated a
high-order page (via pci_alloc_consistent or dma_alloc_coherent),
and is then exposing the constituents of that high-order page to
userspace via nopage: when the final munmap or exit comes,
the constituent pages get freed without realizing they're
supposed to be part of one high-order page.

We had the same problem in sound/core/memalloc.c, and fixed it
by using a compound page (a high-order page in which each constituent
knows it's part of the larger whole): see the two uses of __GFP_COMP
in that file, and in particular the one where snd_malloc_dev_pages
calls dma_alloc_coherent.

Yes, as Roland suggested, it sounds sensible to use dma_alloc_coherent
throughout rather than pci_alloc_consistent, then you can pass __GFP_COMP
down with the other flags and it should work (without any PageReserved).

I haven't checked Bryan's get_pag'ing, but he seemed to have the right
idea of how it should work: was just being a bit diffident about it in
the face of the fact that it clearly wasn't working (through lack of
__GFP_COMP).

Of course, there is an alternative way of going about it, using
remap_pfn_range more (VM_PFNMAP keeping the VM away from refcounting
the pages) and nopage less.  But I think Bryan should probably keep on
with the division he already has, no strong reason to change it around.

[ snipping lots of helpful explanation and advice from Andrew ]

> If you have pages which are created by ->nopage() but which are supposed to
> be shared across forks (the VMA should use VM_DONTCOPY|VM_SHARED) then each
> time a new process starts accessing these already-existing pages it'll take
> a minor fault.

No.  That isn't how VM_DONTCOPY behaves, and I don't know what you were
thinking to bring it into the discussion there - if you have pages which
are supposed to be shared across forks, that happens without any special
flag, doesn't it?  We only teach VM_DONTCOPY in the second year,
I think Bryan would best forget it for now ;)

Oh well, I'd better say a bit on it.  VM_DONTCOPY excludes the whole vma
from being forked into the child.  So if the child tries to access one
of those addresses, the child'll get a SIGSEGV not a minor fault.  RDMA
is finding it a useful flag to get around a peculiarly frustrating issue
with get_user_pages: though that successfully pins pages, a fork followed
by parent writing to pinned private page will put a _copy_ of that page
into the parent's userspace (if child holds a reference to the original),
which likely defeats the purpose of pinning.

So far as Bryan is dealing with shared mappings, he won't be interested
in VM_DONTCOPY at all.  If he's dealing with private mappings, he might
want to consider VM_DONTCOPY if get_user_pages and fork can occur
concurrently; but it's an advanced topic, right now he wants to get
the basis working without "Bad page state"s.

He shouldn't set VM_SHM, it means nothing.  If he's dealing with real
allocated pages, he shouldn't set VM_IO (but remap_pfn_range will set
it for him if it's used).  He shouldn't set VM_RESERVED (won't do any
harm, but we're quite likely to remove it soon).  He can set VM_DONT-
EXPAND to avoid worrying about whether mremap to a larger extent,
followed by fault on that larger extent, would behave correctly.
He shouldn't set VM_LOCKED (it would make the locked_vm accounting
go wrong - unless he's careful to participate in that accounting,
as Infiniband's uverbs_mem.c creditably does).

Hugh
