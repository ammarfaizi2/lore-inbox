Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVI0Ne5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVI0Ne5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVI0Ne5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:34:57 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:38303 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964940AbVI0Ne4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:34:56 -0400
Date: Tue, 27 Sep 2005 14:34:40 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Paul Jackson <pj@sgi.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, mrmacman_g4@mac.com,
       jschopp@austin.ibm.com, akpm@osdl.org, lhms-devel@lists.sourceforge.net,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, kravetz@us.ibm.com
Subject: Re: [PATCH 1/9] add defrag flags
In-Reply-To: <20050926224439.056eaf8d.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0509271415460.12421@skynet>
References: <4338537E.8070603@austin.ibm.com> <43385412.5080506@austin.ibm.com>
 <21024267-29C3-4657-9C45-17D186EAD808@mac.com> <1127780648.10315.12.camel@localhost>
 <20050926224439.056eaf8d.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Paul Jackson wrote:

> Dave wrote:
> > I think Joel simply made an error in his description.
>
> Looks like he made the same mistake in the actual code comments:
>
> +/* Allocation type modifiers, group together if possible
> + * __GPF_USER: Allocation for user page or a buffer page
> + * __GFP_KERNRCLM: Short-lived or reclaimable kernel allocation
> + */
> +#define __GFP_USER	0x40000u /* Kernel page that is easily reclaimable */
> +#define __GFP_KERNRCLM	0x80000u /* User is a userspace user */
>
> I'd guess you meant to write more like the following:
>
> #define __GFP_USER   0x40000u /* Page for user address space */
> #define __GFP_KERNRCLM 0x80000u /* Kernel page that is easily reclaimable */
>

yep

> And the block comment seems to needlessly repeat the inline comments,
> add a dubious claim, and omit the interesting stuff ...  In other words:
>
>     Does it actually matter if these two bits are grouped, or not?  I
>     suspect that some of your other code, such as shifting the gfpmask by
>     RCLM_SHIFT bits, _requires_ that these two bits be adjacent.  So the
>     "if possible" in the comment above is misleading.
>

The "if possible" must be misleading. The bits have to beside each other
as assumptions are made later in the code about this. The "group together"
comment refers to the patches that are allocated with gfp flags that
include __GFP_USER or __GFP_KERNNORCLM. Those pages should be "grouped
together if possible". The bits must be grouped that way.

>     And I suspect that gfp.h should contain the RCLM_SHIFT define, or
>     at least mention in comment that RCLM_SHIFT depends on the position
>     of the above two __GFP_* bits.
>
>     And I don't see any mention in the comments in gfp.h that these
>     two bits, in tandem, have an additional meaning - both bits off
>     means, I guess, not reclaimable, well at least not easily.
>
> My HARDWALL patch appears to already be in Linus's kernel, so you
> probably also need to do a global substitute of all instances in
> the kernel of __GFP_HARDWALL, replacing it with __GFP_USER.

I am not sure if that is a good idea as I will explain later.

> Here
> is the list of files I see affected, with a count of the number of
> __GFP_HARDWALL strings in each:
>
>     include/linux/gfp.h:4
>     kernel/cpuset.c:6
>     mm/page_alloc.c:2
>     mm/vmscan.c:4
>
> The comment in the next line looks like it needs to be changed to match
> the code change:
>
> +#define __GFP_BITS_SHIFT 21	/* Room for 20 __GFP_FOO bits */
>
> On the other hand, why did you change __GFP_BITS_SHIFT?  Isn't 20
> enough - just enough?
>

Yep, you're right, it is just enough.

> Why was the flag change in fs/buffer.c:grow_dev_page() to add the
> __GFP_USER bit, not to add the __GFP_KERNRCLM bit?

Because these are buffer pages that get reclaimed very quickly. The
KERNRCLM pages are generally slab pages. These can be reclaimed by reaping
certain slab patches but it's a very hit and miss behavior. Trust me, the
whole scheme works better if buffer pages are treated as __GFP_USER pages,
not __GFP_KERNRCLM.

> Aha - I just read one of the comments above that I cut+pasted.
> It says that __GFP_USER means user *OR* buffer page.  That certainly
> explains the fs/buffer.c code using __GFP_USER.  But it causes me to
> wonder if we can equate __GFP_USER with __GFP_HARDWALL.

I don't think it should be.

> I'm reluctant,
> but more on principal than concrete experience, to modify the meaning
> of hardwall cpusets to constrain both user address space pages *AND*
> buffer pages.  How open would you be to making buffers __GFP_KERNRCLM
> instead of __GFP_USER?
>

Not very open at all. I would prefer to have an additional flag than do
that. The anti-fragmentation does not work anywhere near as well when
buffer pages are KERNRCLM pages. It's because there are large number of
pages that are easily reclaimable by cleaning the buffers and discarding
them. If they were mixed with slab pages, it would not be very effective
when we try to make a large allocation.

> If you have good reason to keep __GFP_USER meanin either user or buffer,
> then perhaps the name __GFP_USER is misleading.
>

Possibly but we are stuck for terminology here. It's hard to think of a
good term that reflects the intention.

> What sort of performance claims can you make for this change?

I don't have figures for this patchset. The figures I do have are for
another version that I'm currently trying to merge with Joels. In my own
set, there are no performance regressions or gains.

> How does
> it impact kernel text size?

Again, based on my own patchset but the figures should be essentially the
same as Joel's;

linux-2.6.13-clean/vmlinux
   text    data     bss     dec     hex filename
2992829  686212  212708 3891749  3b6225 linux-2.6.13-clean/vmlinux

linux-2.6.13-mbuddy-v14/vmlinux
   text    data     bss     dec     hex filename
2995335  687852  212708 3895895  3b7257 linux-2.6.13-mbuddy-v14/vmlinux

Is that what you are looking for?

> Could we see a diffstat for the entire
> patchset?

Don't have this at the moment

> Under what sort of loads or conditions would you expect
> this patchset to do more harm than good?
>

I cannot think of a case where it does more harm. At worst, it does not
help fragmentation. For that to happen, the system needs to be very
heavily loaded under heavy memory pressure for a long time with
RCLM_NORCLM pages been retained for very long periods of time even after
loads ease. In this case, fallbacks will eventually fragment memory.

A second case where it could hurt is in allocator scalability over a large
number of CPUs as there are now additional per-cpu lists. I am having
trouble thinking of a test case that would trigger this case though.
Someone used to dealing with large numbers of processors might be able to
make a suggestion.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
