Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVHaLma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVHaLma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVHaLm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:42:29 -0400
Received: from silver.veritas.com ([143.127.12.111]:19109 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932498AbVHaLm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:42:28 -0400
Date: Wed, 31 Aug 2005 12:44:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] Implement shared page tables
In-Reply-To: <7C49DFF721CB4E671DB260F9@[10.1.1.4]>
Message-ID: <Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com>
References: <7C49DFF721CB4E671DB260F9@[10.1.1.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 31 Aug 2005 11:42:28.0500 (UTC) FILETIME=[1090B540:01C5AE21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Dave McCracken wrote:
> 
> This patch implements page table sharing for all shared memory regions that
> span an entire page table page.  It supports sharing at multiple page
> levels, depending on the architecture.
> 
> Performance testing has shown no degradation with this patch for tests with
> small processes.  Preliminary tests with large benchmarks have shown as
> much as 3% improvement in overall results.

Hmm.  A few points.

> The patch is against 2.6.13.

So you don't have Nick's test at the start of copy_page_range():
	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
		if (!vma->anon_vma)
			return 0;
	}
Experimental, yes, but Linus likes it enough to have fast-tracked it into
his tree for 2.6.14.  My guess is that that patch (if its downsides prove
manageable) takes away a lot of the point of shared page tables -
I wonder how much of your "3% improvement".

I was going to say, doesn't randomize_va_space take away the rest of
the point?  But no, it appears "randomize_va_space", as it currently
appears in mainline anyway, is somewhat an exaggeration: it just shifts
the stack a little, with no effect on the rest of the va space.
But if it is to do more later, it may conflict with your interest.

The pud sharing and pmd sharing: perhaps they complicate the patch for
negligible benefit?

> +		if ((vma->vm_start <= base) &&
> +	    (vma->vm_end >= end))
> +		return 1;
> 
New Adventures in Coding Style ;)

But most seriously: search the patch for the string "lock" and I find
no change whatever to locking.  You're introducing page tables shared
between different mms yet relying on the old mm->page_table_lock?
You're searching a prio_tree for suitable matches to share, but
taking no lock on that?  You're counting shares in an atomic,
but not detecting when the count falls to 0 atomically?

And allied with that point on locking mms: there's no change to rmap.c,
so how is its TLB flushing and cache flushing now supposed to work?
page_referenced_one and try_to_unmap_one will visit all the vmas
sharing the page table, yes, but (usually) only the first will
satisfy the conditions and get flushed.

I'm not sure if it's worth pursuing shared page tables again or not.

You certainly need to sort the locking out to do so.  Wait a couple
of weeks and I should have sent all the per-page-table-page locking
in to -mm (to replace the pte xchging currently there): that should
give what you need for locking pts independent of the mm.

Hugh
