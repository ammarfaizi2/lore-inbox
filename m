Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVCZNhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVCZNhj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 08:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVCZNhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 08:37:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47377 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262053AbVCZNhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:37:32 -0500
Date: Sat, 26 Mar 2005 13:37:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <20050326133720.B12809@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
	tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050326113530.A12809@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sat, Mar 26, 2005 at 11:35:30AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 11:35:30AM +0000, Russell King wrote:
> In this case, we have a page which must be kept mapped at virtual address
> 0, which means the first entry in the L1 page table must always exist.
> However, user threads start from 0x8000, which is also mapped via the
> first entry in the L1 page table.
> 
> At a guess, I'd imagine that we're freeing the first L1 page table entry,
> thereby causing mm->nr_ptes to become -1.
> 
> I'll do some debugging and try to work out if that (or exactly what's)
> going on.

Ok.  What's happening is that the ARM pgd_alloc uses pte_alloc_map() to
allocate the first L1 page table.  This sets mm->nr_ptes to be one.

The ARM free_pgd knows about this, and will free this PTE at the
appropriate time.  However, exit_mmap() doesn't know about this itself,
so in the ARM case, it should BUG_ON(mm->nr_ptes != 1) if we're using
low vectors.

I guess we could hack it such that the ARM pgd_alloc decrements mm->nr_ptes
itself to keep things balanced, since free_pte_range() won't be called
for this pte.  However, I don't like that because its likely to break at
some point in the future.

Any ideas how to cleanly support this with the new infrastructure?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

