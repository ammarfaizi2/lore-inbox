Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291532AbSBSRcY>; Tue, 19 Feb 2002 12:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291522AbSBSRcR>; Tue, 19 Feb 2002 12:32:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12051 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291520AbSBSRcE>; Tue, 19 Feb 2002 12:32:04 -0500
Date: Tue, 19 Feb 2002 09:29:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <E16d1E8-00010D-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0202190923390.26476-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2002, Daniel Phillips wrote:
> >
> > At that point you might as well make the TLB shootdown global (ie you keep
> > track of a mask of CPU's whose TLB's you want to kill, and any pmd that
> > has count > 1 just makes that mask be "all CPU's").
>
> How do we know when to do the global tlb flush?

See above.

Basically, the algorithm is:

	invalidate_cpu_mask = 0;

	.. for each page swapped out ..

		pte = ptep_get_and_clear(ptep);
		save_pte_and_mm(pte_page(pte));
		mask = mm->cpu_vm_mask;
		if (page_count(pmd_page) > 1)
			mask = ~0UL;
		invalidate_cpu_mask |= mask;

and then at the end you just do

	flush_tlb_cpus(invalidate_cpu_mask);
	for_each_page_saved() {
		free_page(page);
	}

(yeah, yeah, add cache coherency etc).

		Linus


