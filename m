Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291863AbSBTOOP>; Wed, 20 Feb 2002 09:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291868AbSBTOOH>; Wed, 20 Feb 2002 09:14:07 -0500
Received: from dsl-213-023-038-089.arcor-ip.net ([213.23.38.89]:10657 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291863AbSBTOOC>;
	Wed, 20 Feb 2002 09:14:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Wed, 20 Feb 2002 15:18:30 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, mingo@redhat.com,
        Andrew Morton <akpm@zip.com.au>, manfred@colorfullife.com,
        wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.21.0202191801430.15103-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0202191801430.15103-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16dXZm-0001Lv-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 07:11 pm, Hugh Dickins wrote:
> On Tue, 19 Feb 2002, Linus Torvalds wrote:
> > On Tue, 19 Feb 2002, Daniel Phillips wrote:
> > > >
> > > > At that point you might as well make the TLB shootdown global (ie you keep
> > > > track of a mask of CPU's whose TLB's you want to kill, and any pmd that
> > > > has count > 1 just makes that mask be "all CPU's").
> > >
> > > How do we know when to do the global tlb flush?
> > 
> > See above.
> > 
> > Basically, the algorithm is:
> > 
> > 	invalidate_cpu_mask = 0;
> > 
> > 	.. for each page swapped out ..
> > 
> > 		pte = ptep_get_and_clear(ptep);
> > 		save_pte_and_mm(pte_page(pte));
> > 		mask = mm->cpu_vm_mask;
> > 		if (page_count(pmd_page) > 1)
> > 			mask = ~0UL;
> > 		invalidate_cpu_mask |= mask;
> > 
> > and then at the end you just do
> > 
> > 	flush_tlb_cpus(invalidate_cpu_mask);
> > 	for_each_page_saved() {
> > 		free_page(page);
> > 	}
> > 
> > (yeah, yeah, add cache coherency etc).
> 
> It's a little worse than this, I think.  Propagating pte_dirty(pte) to
> set_page_dirty(page) cannot be done until after the flush_tlb_cpus,

You mean, because somebody might re-dirty an already cleaned page?  Or are
you driving at something more subtle?

> if the ptes are writable: and copy_page_range is not setting "cow", so not
> write protecting, when it's a shared writable mapping.  Easy answer is
> to scrap "cow" there and always do the write protection; but I doubt
> that's the correct answer.

Nope.  For shared mmaps you'd get tons of unecessary faults.

> swap_out could keep an array of pointers to
> ptes, to propagate dirty after flushing TLB and before freeing pages,
> but that's not very pretty.

It's not horrible, not worse than the already-existing tlb_remove_page
code anyway.  I think we're not stopped here, just slowed down for some
head scratching.

-- 
Daniel
