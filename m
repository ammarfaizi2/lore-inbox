Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVALXQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVALXQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVALXPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:15:24 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:42128 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261244AbVALXM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:12:29 -0500
Date: Wed, 12 Jan 2005 23:12:26 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Avoiding fragmentation through different allocator
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB008C77C45@fmsmsx406.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0501122247390.18142@skynet>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB008C77C45@fmsmsx406.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Tolentino, Matthew E wrote:

> Hi Mel!
>

Hi.

First off, I think the differences in our approaches are based on
motiviation. I'm tackling fragmentation where as you were tackling
hotplug. That distinction will be the root of a lot of "why are you doing
that?" type questions. This is a failing of my part as I'm only beginning
to get back to grips with memory-management-related fun.

> >Instead of having one global MAX_ORDER-sized array of free
> >lists, there are
> >three, one for each type of allocation. Finally, there is a
> >list of pages of
> >size 2^MAX_ORDER which is a global pool of the largest pages
> >the kernel deals with.
>
> I've got a patch that I've been testing recently for memory
> hotplug that does nearly the exact same thing - break up the
> management of page allocations based on type - after having
> had a number of conversations with Dave Hansen on this topic.
> I've also prototyped this to use as an alternative to adding
> duplicate zones for delineating between memory that may be
> removed and memory that is not likely to ever be removable.

I considered adding a new zone but I felt it would be a massive job for
what I considered to be a simple problem. I think my approach is nice
and isolated within the allocator itself and will be less likely to
affect other code.

On possibility is that we could say that the UserRclm and KernRclm pool
are always eligible for hotplug and have hotplug banks only satisy those
allocations pushing KernNonRclm allocations to fixed banks. How is it
currently known if a bank of memory is hotplug? Is there a node for each
hotplug bank? If yes, we could flag those nodes to only satisify UserRclm
and KernRclm allocations and force fallback to other nodes. The danger is
that allocations would fail because non-hotplug banks were already full
and pageout would not happen because the watermarks were satisified.

(Bear in mind I can't test hotplug-related issues due to lack of suitable
hardware)

> I've
> only tested in the context of memory hotplug, but it does
> greatly simplify memory removal within individual zones.   Your
> distinction between areas is pretty cool considering I've only
> distinguished at the coarser granularity of user vs. kernel
> to date.  It would be interesting to throw KernelNonReclaimable
> into the mix as well although I haven't gotten there yet...  ;-)
>

If you have already posted a version of the patch (you have feedback so I
guess it's there somewhere), can you send me a link to the thread where
you introduced your approach? It's possible that we just need to merge the
ideas.

> >Once a 2^MAX_ORDER block of pages it split for a type of
> >allocation, it is
> >added to the free-lists for that type, in effect reserving it.
> >Hence, over
> >time, pages of the related types can be clustered together. This means
> >that if we wanted 2^MAX_ORDER number of pages, we could linearly scan a
> >block of pages allocated for UserReclaimable and page each of them out.
>
> Interesting.  I took a slightly different approach due to some
> known delineations between areas that are defined to be non-
> removable vs. areas that may be removed at some point.  Thus I'm
> only managing two distinct free_area lists currently.  I'm curious
> as to the motivation for having a global MAX_ORDER size list that
> is allocation agnostic initially...

It's because I consider all 2^MAX_ORDER pages in a zone to be equal where
as I'm guessing you don't. Until they are split, there is nothing special
about them. It is only when it is split that I want it reserved for a
purpose.

However, if we knew there were blocks that were hot-pluggable, we could
just have a hotplug-global and non-hotplug-global pool. If it's a UserRclm
or KernRclm allocation, split from hotplug-global, otherwise use
non-hotplug-global. It'd increase the memory requirements of the patch a
bit though.

> is it so that the pages can
> evolve according to system demands (assuming MAX_ORDER sized
> chunks are eventually available again)?
>

Exactly. Once a 2^MAX_ORDER block has been merged again, it will not be
reserved until the next split.

> It looks like you left the per_cpu_pages as-is.  Did you
> consider separating those as well to reflect kernel vs. user
> pools?
>

I kept the per-cpu caches for UserRclm-style allocations only because
otherwise a Kernel-nonreclaimable allocation could easily be taken from a
UserRclm pool. Over a period of time, the UserRclm pool would be harder to
defragment. Even if we paged out everything and dumped all buffers, there
would still be kernel non-reclaimable allocations that have to be moved.
The concession I would make there is that allocations for caches could use
the per-cpu caches as they are easy to get rid of.

> >-	struct free_area	free_area[MAX_ORDER];
> >+	struct free_area	free_area_lists[ALLOC_TYPES][MAX_ORDER];
> >+	struct free_area	free_area_global;
> >+
> >+	/*
> >+	 * This map tracks what each 2^MAX_ORDER sized block
> >has been used for.
> >+	 * When a page is freed, it's index within this bitmap
> >is calculated
> >+	 * using (address >> MAX_ORDER) * 2 . This means that pages will
> >+	 * always be freed into the correct list in free_area_lists
> >+	 */
> >+	unsigned long		*free_area_usemap;
>
> So, the current user/kernelreclaim/kernelnonreclaim determination
> is based on this bitmap.  Couldn't this be managed in individual
> struct pages instead, kind of like the buddy bitmap patches?
>

Yes, but it would be a waste of memory and the struct page flags are
already under a lot of pressure (In fact, I am 99.9999% certain that those
bits are at a premium and Andrew Morton at least will be fierce unhappy if
I try and use another one). As I only care about a 2^MAX_ORDER block of
pages, I only need two bits per 2^MAX_ORDER pages to track them.
Per-page, I would need one bit per page which would be a fierce waste of
memory.

> I'm trying to figure out one last bug when I remove memory (via
> nonlinear sections) that has been dedicated to user allocations.
> After which perhaps I'll post it as well, although it is *very*
> similar.  However it does demonstrate the utility of this approach
> for memory hotplug - specifically memory removal - without the
> complexity of adding more zones.
>

When you post that, make sure linux-mm is cc'd and I'll certainly see it.
On the linux-kernel mailing list, I might miss it. Thanks

-- 
Mel Gorman
