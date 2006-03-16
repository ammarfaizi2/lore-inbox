Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752436AbWCPRWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbWCPRWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbWCPRWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:22:25 -0500
Received: from silver.veritas.com ([143.127.12.111]:45949 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1752436AbWCPRWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:22:24 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,198,1139212800"; 
   d="scan'208"; a="35982137:sNHT26092352"
Date: Thu, 16 Mar 2006 17:23:03 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142523201.25297.56.camel@camp4.serpentine.com>
Message-ID: <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org>  <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
 <1142523201.25297.56.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 17:22:23.0959 (UTC) FILETIME=[30958670:01C6491E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Bryan O'Sullivan wrote:
> On Thu, 2006-03-16 at 14:24 +0000, Hugh Dickins wrote:
> 
> > I think Bryan's problem is probably that he has allocated a
> > high-order page (via pci_alloc_consistent or dma_alloc_coherent),
> > and is then exposing the constituents of that high-order page to
> > userspace via nopage: when the final munmap or exit comes,
> > the constituent pages get freed without realizing they're
> > supposed to be part of one high-order page.
> 
> Yes, that sounds about right.  Some of the allocations in question are
> order-1, and some are higher.

I tend to say "high-order" when I ought to say ">0-order":
anything over 0-order exhibits the same problem, needing __GFP_COMP.

> > We had the same problem in sound/core/memalloc.c, and fixed it
> > by using a compound page (a high-order page in which each constituent
> > knows it's part of the larger whole): see the two uses of __GFP_COMP
> > in that file, and in particular the one where snd_malloc_dev_pages
> > calls dma_alloc_coherent.
> 
> Will do, thanks.  Will the allocator give me a compound page if I ask
> for a single page but pass __GFP_COMP, or do I need to be sure I always
> make a higher-order request if I pass that flag?

Just pass __GFP_COMP whatever the order of the request is.  In the case
of 0-order requests, it'll simply be ignored (so you don't _need_ to pass
it in that case, but it's just a waste of effort to avoid it): that page
won't be marked PageCompound, nor will it need to be - most of the time
(;)) we have no difficulty holding a single page together with itself.

The whole thing of having to pass __GFP_COMP is a nuisance, and caught
me by surprise.  Looking back at the history, it seems that when compound
pages were first introduced (by akpm), it wasn't necessary at all: asking
for a >0-order page gave you a compound page.  But then a few places
surfaced which went badly wrong that way, I think somewhere in ARM and
a couple of drivers, places which split the >0-page up again.  Perhaps
one day we should go in search of those exceptions, fix them up (maybe
Nick already did so with his split_page in -mm?), and eliminate the
need for a __GFP_COMP flag.

> > No.  That isn't how VM_DONTCOPY behaves, and I don't know what you were
> > thinking to bring it into the discussion there - if you have pages which
> > are supposed to be shared across forks, that happens without any special
> > flag, doesn't it?  We only teach VM_DONTCOPY in the second year,
> > I think Bryan would best forget it for now ;)
> 
> Heh.  Actually, in this case, I really don't want the vma to get shared
> with a child.  If the child gets a SEGV after a fork, that's intended
> behaviour, as far as I'm concerned.

Okay, fine: I didn't mean to discourage you from using VM_DONTCOPY if
it suits, I just didn't understand why Andrew was promoting its use.

> > RDMA
> > is finding it a useful flag to get around a peculiarly frustrating issue
> > with get_user_pages: though that successfully pins pages, a fork followed
> > by parent writing to pinned private page will put a _copy_ of that page
> > into the parent's userspace (if child holds a reference to the original),
> > which likely defeats the purpose of pinning.
> 
> That's a useful aside, thanks.  It sounds like I want to set VM_DONTCOPY
> on the pages I'm doing get_user_pages on too, then.
> 
> > He shouldn't set VM_SHM, it means nothing.
> 
> Is that the case for kernels prior to 2.6.15, too?

Yes, all kernels from 2.4.0 through 2.6.15: a bit was defined for it,
and a motley collection of drivers set that bit, but it wasn't used
for anything at all - not even any files in /proc.  A leftover from 2.2.

> The problem is that I need to keep a version of the driver working on
> kernels back as far as 2.6.9, in addition to the current mainline.  If
> VM_SHM meant nothing back then, too, I can remove it entirely, otherwise
> I should drop it only in the for-mainline driver, and leave the backport
> version as it stands.

You're safe to drop the VM_SHM everywhere.  But your backport driver will
have to be using PageReserved still, not relying on __GFP_COMP: although
__GFP_COMP was defined in 2.6.9 and a few earlier, it used to take effect
only when #ifdef CONFIG_HUGETLB_PAGE - only in 2.6.15 did we make it
available to all configurations.  You'll have irritating accounting
differences between the two drivers: it used to be the case that put_page
on a PageReserved page did nothing, so you had to avoid get_page on it to
get the page accounting right; we straightened that out in 2.6.15.

> >   If he's dealing with real
> > allocated pages, he shouldn't set VM_IO (but remap_pfn_range will set
> > it for him if it's used).  He shouldn't set VM_RESERVED (won't do any
> > harm, but we're quite likely to remove it soon).
> 
> Yes, I actually dropped both of these last night.
> 
> > He shouldn't set VM_LOCKED (it would make the locked_vm accounting
> > go wrong - unless he's careful to participate in that accounting,
> > as Infiniband's uverbs_mem.c creditably does).
> 
> Well, uverbs_mem.c only touches locked_vm for pages it's pinned using
> get_free_pages.  We do much the same thing in that case.
> 
> I'll try turning off VM_LOCKED for the pages we allocate, and see what
> breaks :-)

I believe uverbs_mem.c sets a good example if you want to follow it
in detail; but I think it's the only driver which does all that.

Most drivers hold a certain number of pages pinned, and even if they
make them available to userspace, we still consider them driver pages
and exempt them from locked_vm accounting.  But (as I understand it)
uverbs_mem.c makes it possible for userspace to pin down an otherwise
unlimited number of user pages for an indefinite length of time: so
they've chosen to enforce locked_vm accounting, and I applaud that.

So, if your driver allows userspace to pin an otherwise unlimited
number of user pages for an indefinite length of time, you ought
to follow uverbs_mem.c's locked_vm accounting.  But if it's only
a little, briefly, don't bother.

And I'll have confused you by mentioning that under VM_LOCKED:
I was thinking uverbs_mem.c set VM_LOCKED, but it does not, nor
should it.  Nor should you, neither at your get_user_pages, nor
when setting up your vmas (if you search the kernel source, I
think you'll find a few drivers which do set VM_LOCKED, but
they're just wrong, and it's one of the things I have to fix
when I do that trawl through them all).

Hugh
