Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbULNWoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbULNWoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbULNWn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:43:29 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:1744 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261711AbULNWkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:40:41 -0500
To: Andi Kleen <ak@suse.de>
cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea 
In-reply-to: Your message of "14 Dec 2004 19:59:50 +0100."
             <p73acsg1za1.fsf@bragg.suse.de> 
Date: Tue, 14 Dec 2004 22:40:20 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Stunned silence I guess - merging an architecture is
> > usually much more controversial ;)
> 
> In my opinion it's still an extremly bad idea to have arch/xen
> an own architecture. It will cause a lot of work long term
> to maintain it, especially when it gets x86-64 support too.
> It would be much better to just merge it with i386/x86-64.

Andi, I totally agree that merging into i386 could be a long term
goal. However, its just not feasible right now. The changes
required are way too intrusive. We put considerable effort into
investigating this approach, but came to the conclusion that with
the current structure of arch i386 it was going to be way too
messy. 

I really think the best approach is to get arch xen into
mainstream Linux, and then work toward integrating i386, x86_64
and xen. From our point of view, the first stage of this is to
increase the number of files that are shared unmodified between
i386 and xen/i386 (i.e. linked from xen into i386). There's
already many such files, but with a few relatively simple changes
to i386 we could get quite a few more.

> Currently it's already difficult enough to get people to
> add fixes to both i386 and x86-64, adding fixes to three
> or rather four (xen32 and xen64) architectures will be quite bad.
> In practice we'll likely get much worse code drift and missing
> fixes. Also I still suspect Ian is underestimating how much
> work it is long term to keep an Linux architecture uptodate.

We're actually very well setup to handle this, having been doing
it for some time. Whenever Linus issues a new mainstream patch,
we have a script that rewrites the patch to duplicate the hunks
that apply to i386 such that they also hit files that we've
modified in xen/i386. This way we keep arch xen/i386 in perfect
sync with i386. It takes discipline, but we're pretty good at it
now.

> I cannot imagine the virtualization hooks are intrusive anyways. The
> only things it needs to hook idle and the page table updates,
> right?

It's rather more complicated than that if you want a clean
interface that gives good performance. We've taken a very
benchmark-driven approach to minimise the overhead of
virtualization. The aim is to have such a small overhead that
people are happy running virtualized the whole time. I think this
is a really important aim.

> Doing that cleanly in the existing architectures shouldn't be that
> hard.

I've appended a list of some of the areas we need to modify. I
think you may have underestimated what needs to happen.

> I suspect xen64 will be rather different from xen32 anyways
> because as far as I can see the tricks Xen32 uses to be
> fast (segment limits) just plain don't work on 64bit
> because the segments don't extend into 64bit space.
> So having both in one architecture may also end up messy.

We have subdirectories for the i386 and x86_64 specific files,
along with a common directory for stuff which is shared between
the two e.g. virtual interrupt control etc.
 
> Also the other thing I'm worried about is that there is no clear
> specification on how the Xen<->Linux interface works.

We have an interface manual in the Xen bk repo, but I acknowledge
that we haven't always been totally prompt in keeping it up to
date and fully detailed. Now the Xen2 interface is frozen, that
should be fixable. Even so, it hasn't prevented other independent
groups porting OSes to Xen e.g. NetBSD, FreeBSD, Plan9.

Ian

Differences between i386 and xen/i386 files:
- irq setup
- pci bus scanning
- gdt/ldt must be in dedicated read-only pages
- gdt/ldt install/updates
- debug register updates
- pte quicklist/cache
- pmd/pgd are read-only pages
- highmem pte mapping
- dma memory allocation
- idle loop
- different fixmap
- *_to_* macros differ (like page_to_phys)
- *_val macros (pte_val, pmd_val)
- inb/outb
- switching cr3
- cr4 updates
- a few cpu flags need to be cleared
- msr access
- wbinvd call
- mtrr access
- io permission handling
- ioremap 
- access to hardware memory
- interrupt enabling/disabling
- setup of trap gates
- tlb flush
- fpu stack switches
- user/kernel mode test
- different segment selectors since the kernel runs in ring1
- pagefault handler stack layout is different
- startup is in 32-bit mode
- start of day initialization is different
- start of day memory probing and pagetable setup
- trap/fault handling
- timer is virtualized
- smp addtl. cpu startup
- smp ipi's



