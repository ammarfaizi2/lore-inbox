Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291854AbSBTOGq>; Wed, 20 Feb 2002 09:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291859AbSBTOGf>; Wed, 20 Feb 2002 09:06:35 -0500
Received: from dsl-213-023-038-089.arcor-ip.net ([213.23.38.89]:3489 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291854AbSBTOG3>;
	Wed, 20 Feb 2002 09:06:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Wed, 20 Feb 2002 15:10:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.com>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202190923390.26476-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202190923390.26476-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16dXRt-0001Lo-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 06:29 pm, Linus Torvalds wrote:
> On Tue, 19 Feb 2002, Daniel Phillips wrote:
> > Linus Torvalds wrote:
> > > At that point you might as well make the TLB shootdown global (ie you
> > > keep track of a mask of CPU's whose TLB's you want to kill, and any pmd 
> > > that has count > 1 just makes that mask be "all CPU's").
> >
> > How do we know when to do the global tlb flush?
> 
> See above.
> 
> Basically, the algorithm is:
> 
> 	invalidate_cpu_mask = 0;
> 
> 	.. for each page swapped out ..
> 
> 		pte = ptep_get_and_clear(ptep);
> 		save_pte_and_mm(pte_page(pte));
> 		mask = mm->cpu_vm_mask;
> 		if (page_count(pmd_page) > 1)
> 			mask = ~0UL;
> 		invalidate_cpu_mask |= mask;
> 
> and then at the end you just do
> 
> 	flush_tlb_cpus(invalidate_cpu_mask);
> 	for_each_page_saved() {
> 		free_page(page);
> 	}

Silence is the sound of me researching tlb shootdowns, ipi's and the like, to 
prepare for doing this work.  We don't have a flush_tlb_cpus at the moment, 
however it doesn't look hard to write.  We don't have save_pte_and_mm either, 
and it seems that it's only valid in the case the page table use count is 
one, otherwise we need a page table reverse mapping scheme, a practical and 
worthwhile optimization, but not essential to get something working.

<rant>
This topic is very poorly covered in terms of background material.  What 
information there is seems to be scattered through various Intel manuals or 
old lkml posts, or tucked away in professional seminars and higher level 
computer engineering courses.  Once again we have a situation where hackers 
are divided into two groups: those that know the material and haven't got 
time or inclination to document it, or those that don't know it and aren't 
willling to admit that for fear of seeming ignorant.
</rant>

Davem has done a nice job of documenting the existing tlb operations, what's 
missing is the information required to construct new ones.  Can anybody out 
there point me to a primer, or write one?

Looking at the current try_to_swap_out code I see only a local invalidate, 
flush_tlb_page(vma, address), why is that?  How do we know that this mm could 
not be in context on another cpu?

-- 
Daniel
