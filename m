Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbULOEuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbULOEuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULOEuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:50:05 -0500
Received: from ns.suse.de ([195.135.220.2]:24783 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261874AbULOEtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:49:32 -0500
Date: Wed, 15 Dec 2004 05:49:27 +0100
From: Andi Kleen <ak@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andi Kleen <ak@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041215044927.GF27225@wotan.suse.de>
References: <p73acsg1za1.fsf@bragg.suse.de> <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 10:40:20PM +0000, Ian Pratt wrote:
> I really think the best approach is to get arch xen into
> mainstream Linux, and then work toward integrating i386, x86_64
> and xen. From our point of view, the first stage of this is to

I think that's definitely the wrong way. Also in Linux 
the standard strategy is to first clean up and restructure/refactor 
code and then merge, not the other way round.

> increase the number of files that are shared unmodified between
> i386 and xen/i386 (i.e. linked from xen into i386). There's
> already many such files, but with a few relatively simple changes
> to i386 we could get quite a few more.

That will still have most of the disadvantages I listed.

> 
> > Currently it's already difficult enough to get people to
> > add fixes to both i386 and x86-64, adding fixes to three
> > or rather four (xen32 and xen64) architectures will be quite bad.
> > In practice we'll likely get much worse code drift and missing
> > fixes. Also I still suspect Ian is underestimating how much
> > work it is long term to keep an Linux architecture uptodate.
> 
> We're actually very well setup to handle this, having been doing
> it for some time. Whenever Linus issues a new mainstream patch,
> we have a script that rewrites the patch to duplicate the hunks
> that apply to i386 such that they also hit files that we've
> modified in xen/i386. This way we keep arch xen/i386 in perfect
> sync with i386. It takes discipline, but we're pretty good at it
> now.

That won't anymore at some time. I found this out on x86-64.
It works at the beginning, but eventually the code drift gets
so much that it's near impossible to apply any hunk and you
have to redo everything. One reason for that is that in Linux
code often gets restructured, which makes it very difficult
for such mechanized merging procedures to work long term.

Also you have to review every change anyways.

> > I cannot imagine the virtualization hooks are intrusive anyways. The
> > only things it needs to hook idle and the page table updates,
> > right?
> 
> It's rather more complicated than that if you want a clean
> interface that gives good performance. We've taken a very
> benchmark-driven approach to minimise the overhead of
> virtualization. The aim is to have such a small overhead that
> people are happy running virtualized the whole time. I think this
> is a really important aim.

Can you please be a bit more precise on that? What exactly do you
need? 

> 
> > Doing that cleanly in the existing architectures shouldn't be that
> > hard.
> 
> I've appended a list of some of the areas we need to modify. I
> think you may have underestimated what needs to happen.

Ok that's a start.

> 
> > I suspect xen64 will be rather different from xen32 anyways
> > because as far as I can see the tricks Xen32 uses to be
> > fast (segment limits) just plain don't work on 64bit
> > because the segments don't extend into 64bit space.
> > So having both in one architecture may also end up messy.
> 
> We have subdirectories for the i386 and x86_64 specific files,
> along with a common directory for stuff which is shared between
> the two e.g. virtual interrupt control etc.

Ok, but I think there will be significant differences in the 
64bit part and meshing both together will get extremly messy.

What's your strategy for example to merge changes from arch/x86_64
to xen64? I don't think the way you described above will work 
in any way.

>  
> > Also the other thing I'm worried about is that there is no clear
> > specification on how the Xen<->Linux interface works.
> 
> We have an interface manual in the Xen bk repo, but I acknowledge
> that we haven't always been totally prompt in keeping it up to
> date and fully detailed. Now the Xen2 interface is frozen, that
> should be fixable. Even so, it hasn't prevented other independent
> groups porting OSes to Xen e.g. NetBSD, FreeBSD, Plan9.
> 
> Ian


Comments on some issues:

You are saying you ran benchmarks on each of them and it turns
out to be too slow to emulate them in the standard architectural
way? At least for some of them it's hard to believe.

> 
> Differences between i386 and xen/i386 files:
> - irq setup

Already two different ways (MSI and non MSI). Adding a third
is probably feasible.

> - pci bus scanning

We already have at least three different ways to do that, adding
a fourth wouldn't be very messy I guess.

> - gdt/ldt must be in dedicated read-only pages

That can be probably done in the standard kernel
(without the actual read protection bit) 

> - gdt/ldt install/updates

gdt load could be just trapped, it only happens once
at startup. 

LDT i can see some effort needed, but it's already
only at a single function in a header file.

> - debug register updates

This shouldn't be performance critical. Why is it not
simply emulated by the hypervisor?

> - pte quicklist/cache

i386 had a pte quicklist some time ago. I think there were
plans anyways to readd it. 

> - pmd/pgd are read-only pages

I suspect this just needs another include layer like the existing
PAE/non PAE layer.

> - highmem pte mapping
> - dma memory allocation
> - idle loop

This is already pluggable (e.g. ACPI has its own) 

> - different fixmap
> - *_to_* macros differ (like page_to_phys)
> - *_val macros (pte_val, pmd_val)

Can be also handled like 2/3 levels I bet.

> - inb/outb

Why is it not trapped? 

> - switching cr3
> - cr4 updates
> - a few cpu flags need to be cleared
> - msr access

Why don't you just simply trap it? MSRs are normally
not performance critical (except on x86-64 for the context switch
but you didn't seem to have attacked that at all yet ;-) 

> - wbinvd call
> - mtrr access

Same.

For all of these it would seem much cleaner to me to just
provide instruction emulation in the Hypervisor.

> - io permission handling

What is different? 

> - ioremap 
> - access to hardware memory
> - interrupt enabling/disabling
> - setup of trap gates
> - tlb flush

This is already well separated, shouldn't be a big issue 
to make it different.

> - fpu stack switches
> - user/kernel mode test

That can be just changed everywhere in i386 without ill effects.

> - different segment selectors since the kernel runs in ring1
> - pagefault handler stack layout is different
> - startup is in 32-bit mode

That's a good cleanup anyways. The early boot interface
between 16 and 32bit should be clearly defined and then
a general 32bit booting interface be defined. There are various
other people who would like to have this too. I had some plans
to do the equivalent on x86-64 with a 64bit boot interface.

> - start of day initialization is different
> - start of day memory probing and pagetable setup

Sounds similar to EFI. 

> - trap/fault handling
> - timer is virtualized

Details?

First impression is that there is much cleanup potential and that
there should be probably some discussion on each of these items. 

-Andi
