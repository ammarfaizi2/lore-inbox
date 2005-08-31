Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVHaQkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVHaQkt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVHaQkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:40:49 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:12458 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S964868AbVHaQks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:40:48 -0400
Date: Wed, 31 Aug 2005 11:40:28 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] Implement shared page tables
Message-ID: <6E5E4C275EEB99E7C5D096D9@[10.1.1.4]>
In-Reply-To: <Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com>
References: <7C49DFF721CB4E671DB260F9@[10.1.1.4]>
 <Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com>
X-Mailer: Mulberry/3.1.6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, August 31, 2005 12:44:24 +0100 Hugh Dickins
<hugh@veritas.com> wrote:

> So you don't have Nick's test at the start of copy_page_range():
> 	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
> 		if (!vma->anon_vma)
> 			return 0;
> 	}
> Experimental, yes, but Linus likes it enough to have fast-tracked it into
> his tree for 2.6.14.  My guess is that that patch (if its downsides prove
> manageable) takes away a lot of the point of shared page tables -
> I wonder how much of your "3% improvement".

Very little, actually.  The test does not create new processes as part of
the run.  The improvement is due to sharing of existing areas.

> I was going to say, doesn't randomize_va_space take away the rest of
> the point?  But no, it appears "randomize_va_space", as it currently
> appears in mainline anyway, is somewhat an exaggeration: it just shifts
> the stack a little, with no effect on the rest of the va space.
> But if it is to do more later, it may conflict with your interest.

I've been considering a future enhancement to my patch where it could share
page tables of any areas that share alignment, not just the same virtual
address.  That might allow sharing with randomization if the randomization
aligns things properly.

> The pud sharing and pmd sharing: perhaps they complicate the patch for
> negligible benefit?

The pmd sharing is necessary for ppc64 since it has to share at segment
size, plus it will be useful for very large regions.  I did pud for
completeness but you may be right that it's not useful.  It's all
configurable in any event.

>> +		if ((vma->vm_start <= base) &&
>> +	    (vma->vm_end >= end))
>> +		return 1;
>> 
> New Adventures in Coding Style ;)

New Adventures in Typos, actually :)  I'll fix.

> But most seriously: search the patch for the string "lock" and I find
> no change whatever to locking.  You're introducing page tables shared
> between different mms yet relying on the old mm->page_table_lock?
> You're searching a prio_tree for suitable matches to share, but
> taking no lock on that?  You're counting shares in an atomic,
> but not detecting when the count falls to 0 atomically?
> 
> And allied with that point on locking mms: there's no change to rmap.c,
> so how is its TLB flushing and cache flushing now supposed to work?
> page_referenced_one and try_to_unmap_one will visit all the vmas
> sharing the page table, yes, but (usually) only the first will
> satisfy the conditions and get flushed.

I'll go over the locking again.

> I'm not sure if it's worth pursuing shared page tables again or not.

The immediate clear benefits I see are a reduction in the number of page
table pages and a reduction in minor faults.  Keep in mind that faulting a
page into a shared page table makes it available to all other processes
sharing that area, eliminating the need for them to also take faults on it.

> You certainly need to sort the locking out to do so.  Wait a couple
> of weeks and I should have sent all the per-page-table-page locking
> in to -mm (to replace the pte xchging currently there): that should
> give what you need for locking pts independent of the mm.

I'll look things over in more detail.  I thought I had the locking issues
settled, but you raised some points I should revisit.

Dave McCracken

