Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVASNRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVASNRu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 08:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVASNRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 08:17:50 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:7129 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261716AbVASNRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 08:17:37 -0500
Date: Wed, 19 Jan 2005 13:17:30 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Avoiding fragmentation through different allocator
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB008D16A9E@fmsmsx406.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0501191223220.8296@skynet>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB008D16A9E@fmsmsx406.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, Tolentino, Matthew E wrote:

> >I considered adding a new zone but I felt it would be a massive job for
> >what I considered to be a simple problem. I think my approach is nice
> >and isolated within the allocator itself and will be less likely to
> >affect other code.
>
> Just for clarity, I prefer this approach over adding zones,
> hence my pursuit of something akin to it.
>

Ok, cool.

> >On possibility is that we could say that the UserRclm and KernRclm pool
> >are always eligible for hotplug and have hotplug banks only
> >satisy those
> >allocations pushing KernNonRclm allocations to fixed banks. How is it
> >currently known if a bank of memory is hotplug? Is there a
> >node for each
> >hotplug bank? If yes, we could flag those nodes to only
> >satisify UserRclm
> >and KernRclm allocations and force fallback to other nodes.
>
> The hardware/firmware has to tell the kernel in some way.  In
> my case it is ACPI that delineates between regions that may be
> removed.  No, there isn't a node for each bank of hot-plug
> memory.  The reason I was pursuing this was to be able to
> avoid coarse granularity distinctions like that.

As there is not a node for each hotplug bank, this has to happen at the
zone level. Architectures have the option of defining their own
memmap_init() although only ia64 take advantage of it. If we wanted to be
able to identify hotplug pages in an independant manner, we woulc
implement memmap_init() for hotplug and fill zone->free_area_usemap
accordingly. Currently the bitmap in there has two bits for each
2^MAX_ORDER block that looks like;

00 = Kernel non-reclaimable
10 = Kernel reclaimable
01 = User reclaimable

So, we could say 11 is for hotplug memory. Alternatively if it is possible
to have a system that consists entirely of hotplug memory, we could add a
third bit. As it is one bit per 2^MAX_ORDER pages in the system, it would
not be a big chunk of memory.

The question is what to do with that information then. We can't just say
that User pages go to hotplug regions as that will introduce two problems.
One of balancing and the second of what happens when an unreclaimable page
is in a bank we want to move without page migration in place.

> >The danger is
> >that allocations would fail because non-hotplug banks were already full
> >and pageout would not happen because the watermarks were satisified.
>
> Which implies a potential need for balancing between user/kernel
> lists, no?
>

If we're not careful, yes and I have a gut-feeling that says we should not
need to be balancing anything for hotplug.

> >If you have already posted a version of the patch (you have
> >feedback so I
> >guess it's there somewhere), can you send me a link to the thread where
> >you introduced your approach? It's possible that we just need
> >to merge the
> >ideas.
>
> No, I hadn't posted it yet due to chasing a bug.  However, perhaps
> now I'll instead focus on adding the necessary hotplug support
> into your patch, hence merging the hotplug requirements/ideas?
>

I've no problem with that. It's just a case of how we use the information
exactly.

> >It's because I consider all 2^MAX_ORDER pages in a zone to be
> >equal where
> >as I'm guessing you don't. Until they are split, there is
> >nothing special
> >about them. It is only when it is split that I want it reserved for a
> >purpose.
> >
> >However, if we knew there were blocks that were hot-pluggable, we could
> >just have a hotplug-global and non-hotplug-global pool. If
> >it's a UserRclm
> >or KernRclm allocation, split from hotplug-global, otherwise use
> >non-hotplug-global. It'd increase the memory requirements of
> >the patch a
> >bit though.
>
> Exactly.  Perhaps this could just be isolated via the
> CONFIG_MEMORY_HOTPLUG build option, thus not increasing the memory
> requirements in the common case...
>

I think so. The changes would be removing pages from the global pool with
macros rather than directly and having the hotplug and non-hotplug
versions.

We just need to think more of what happens when a kernel allocation comes
along, fixed memory is depleted but there is plenty of hotplug memory
left.

-- 
Mel Gorman
