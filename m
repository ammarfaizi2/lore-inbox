Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbSLFXiF>; Fri, 6 Dec 2002 18:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267660AbSLFXiF>; Fri, 6 Dec 2002 18:38:05 -0500
Received: from holomorphy.com ([66.224.33.161]:2193 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267659AbSLFXiE>;
	Fri, 6 Dec 2002 18:38:04 -0500
Date: Fri, 6 Dec 2002 15:45:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206234524.GS9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com> <20021206054804.GK1567@dualathlon.random> <3DF049F9.6F83D13@digeo.com> <20021206145718.GL1567@dualathlon.random> <20021206151220.GD11023@holomorphy.com> <20021206233243.GP4335@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206233243.GP4335@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 12:32:43AM +0100, Andrea Arcangeli wrote:
> but note that even with rmap you don't know the pmd that points to the
> pte that you want to relocate and for the anon pages you miss
> information about mm and virtual address where those pages are
> allocated, so basically rmap is useless for doing it, you need to do the
> pagetable walking ala swap_out, in turn it's not easier at all in 2.5
> than it could been in 2.4 (but of course this is a 2.5 thing only, I
> just want to say that if it's not difficult in 2.5 it wasn't difficult
> in 2.4 either).

Actually, we do. From include/asm-generic/rmap.h:

static inline void pgtable_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
{
#ifdef BROKEN_PPC_PTE_ALLOC_ONE
	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
	extern int mem_init_done;

	if (!mem_init_done)
		return;
#endif
	page->mapping = (void *)mm;
	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
	inc_page_state(nr_page_table_pages);
}

So pagetable pages are tagged with the right information, and in
principle could even be tagged here with the pmd in page->private.

These fields are actually required for use by try_to_unmap_one(),
and something similar could be done for a try_to_move_one(). This
information remains intact with shared pagetables, and is generalized
so that the PTE page is tagged with a list of mm's (the mm_chain),
and in that case no unique pmd could be directly stored in the page,
but it could just as easily be derived from the mm's in the mm_chain.

But there's no denying it would involve a substantial amount of work.


Bill
