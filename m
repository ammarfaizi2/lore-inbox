Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWCQP1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWCQP1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWCQP1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:27:11 -0500
Received: from silver.veritas.com ([143.127.12.111]:56333 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751201AbWCQP1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:27:08 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.03,104,1141632000"; 
   d="scan'208"; a="36028023:sNHT25704360"
Date: Fri, 17 Mar 2006 15:27:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <441A04D0.3060201@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0603171440570.31402@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
 <ada4q27fban.fsf@cisco.com> <1141948516.10693.55.camel@serpentine.pathscale.com>
 <ada1wxbdv7a.fsf@cisco.com> <1141949262.10693.69.camel@serpentine.pathscale.com>
 <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain>
 <ada3bhjuph2.fsf@cisco.com> <1142475069.6994.114.camel@localhost.localdomain>
 <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain>
 <20060315192813.71a5d31a.akpm@osdl.org> <1142485103.25297.13.camel@camp4.serpentine.com>
 <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
 <4419062C.6000803@yahoo.com.au> <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>
 <441A04D0.3060201@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Mar 2006 15:27:07.0847 (UTC) FILETIME=[40AC5570:01C649D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2006, Nick Piggin wrote:
> Hugh Dickins wrote:
> > 
> > Once __GFP_COMP is passed to the dma_alloc_coherent, as it needs to be
> > (unless going VM_PFNMAP), get_user_pages will be safe: no need for VM_IO.
> 
> But it doesn't look like dma_alloc_coherent is guaranteed to return
> memory allocated from the regular page allocator, nor even memory
> backed by a struct page.

Hmm, that's bad news.

If it's not backed by a struct page, then I guess Bryan can't be
interested in mapping it into userspace with a .nopage; so perhaps that
case is already ruled out somehow, and we needn't worry about it.  Or
should he just be using remap_pfn_range - is there a portable way to
use that with dma_alloc_coherent/pci_alloc_consistent?

I'm not a driver writer, and have no idea of these things: I think,
having got Bryan back on track with his page counts, I'd better step
aside, and let those who understand these things take him forward.

> For example, I see one that returns kmalloc()ed memory. If the pages
> for the slab are already allocated then __GFP_COMP will not do anything
> there. i386 looks like it has a path that uses ioremap...

I don't remember offhand whether passing __GFP_COMP to kmalloc does
something, nothing, errors out, or behaves erratically according to
whether the slab is already allocated.

I'd feel so much more confident if no __GFP_COMP flag were ever needed.
It seems that's how PageCompound started out, every >0-order was compound;
then some nasty code found down in ARM and some drivers that were screwed
by that, so __GFP_COMP introduced (and other trees had __GFP_NOCOMP).

Is there any chance that your split_page() work in -mm, actually addresses
precisely those places that were screwed up by universal compound pages?
So that with your split_page(), we could go back to every >0-order page
being PageCompound, without any need for __GFP_COMP.

There'd probably be a few blips to sort out, but if it seems a plausible
way forward, that's the way I'd like to go.  But I wasn't in on the
early days of PageCompound, maybe Andrew remembers the issues.  I've
appended a couple of akpm entries from ChangeLog-2.6.6 below, to help
jog memories (I'm amused to see how the compound page logic started
off using page->lru, where we've just now moved it back to).

> Now I haven't looked through all these closely like you will have, but
> I'd like to know how __GFP_COMP solves all the potential problems I
> see.

It seems I can't have looked as closely as I thought.  I was advising
Bryan on the basis of the __GFP_COMP (I added) in snd_malloc_dev_pages,
which appears to have been working.  But now I fear perhaps that was
just a rare case to support a single driver only needed on a few
architectures (not everyone exports snd_malloc_dev_pages memory into
userspace); or we have a nasty surprise in store for us there too.

Aside from the dark alleys of dma_alloc_coherent that you've mentioned,
there's the architectures which #define it to pci_alloc_consistent,
which takes no gfp_mask, so __GFP_COMP would be ignored (hence,
in part, my desire to make all >0-order pages compound).

None of what I've said above is much help to Bryan (nor is Linus'
suggestion that he allocates one page at a time, if dma_alloc_coherent
won't even give him the right kind of struct-page-backed memory):
but as I said, I'll have to step aside from pretending to advise
on what his driver should be doing.

Hugh

<akpm@osdl.org>
  [PATCH] stop using page->lru in compound pages
  
  The compound page logic is using page->lru, and these get will scribbled on
  in various places so switch the Compound page logic over to using ->mapping
  and ->private.

<akpm@osdl.org>
  [PATCH] use compound pages for hugetlb pages only
  
  The compound page logic is a little fragile - it relies on additional
  metadata in the pageframes which some other kernel code likes to stomp on
  (xfs was doing this).
  
  Also, because we're treating all higher-order pages as compound pages it is
  no longer possible to free individual lower-order pages from the middle of
  higher-order pages.  At least one ARM driver insists on doing this.
  
  We only really need the compound page logic for higher-order pages which can
  be mapped into user pagetables and placed under direct-io.  This covers
  hugetlb pages and, conceivably, soundcard DMA buffers which were allcoated
  with a higher-order allocation but which weren't marked PageReserved.
  
  The patch arranges for the hugetlb implications to allocate their pages with
  compound page metadata, and all other higher-order allocations go back to the
  old way.
  
  (Andrea supplied the GFP_LEVEL_MASK fix)
