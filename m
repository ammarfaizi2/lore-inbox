Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVC3RBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVC3RBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVC3RBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:01:38 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:53321 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262351AbVC3RBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:01:16 -0500
Date: Wed, 30 Mar 2005 18:00:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
In-Reply-To: <20050326150321.C12809@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0503301731210.21413@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> 
    <20050325212234.F12715@flint.arm.linux.org.uk> 
    <4244C3B7.4020409@yahoo.com.au> 
    <20050326113530.A12809@flint.arm.linux.org.uk> 
    <20050326133720.B12809@flint.arm.linux.org.uk> 
    <424568D2.7090701@yahoo.com.au> 
    <20050326150321.C12809@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Russell King wrote:
> On Sun, Mar 27, 2005 at 12:51:14AM +1100, Nick Piggin wrote:
> 
> > But I don't quite understand (should really look at the code more),
> > how come you aren't leaking memory?
> 
> The ARM free_pgd_slow() knows about this special first L1 page table, and
> knows to free it if it exists when its called.
> 
> > Do _all_ processes share this same first L1 page table?
> 
> No.  It has to be specific to each process.  Each L1 page table entry
> covers 2MB, but executables start at virtual 0x8000.

I'm not satisfied with Nick's patch because it defines FIRST_USER_ADDRESS
as FIRST_USER_PGD_NR * PGDIR_SIZE i.e. 2MB.  And if that is the first
user address, then there is no need for his patch, because the new
free_pgtables will never touch that pgd because there's no vma in it.

That's why I thought arm needed no special code for this
(overlooking the nr_ptes bug issue, sorry).

But above you say FIRST_USER_ADDRESS should actually be 0x8000?
In that case, I think we should define FIRST_USER_ADDRESS to 0,
either in every asm-arch or in asm-generic, with arm overriding
it to 0x8000 - or better, to whatever #define you already have
for that 0x8000, but I didn't find it.

If vmas can occur in between 0x8000 and 2MB, then with Nick's patch
we'd be liable to pass free_pgtables a vma with vm_start lower than
floor, which is not a case I've thought through, nor wish to.

And, whether FIRST_USER_ADDRESS is 0x8000 or 2MB,
shouldn't your arch_get_unmapped_area be enforcing it?

Hugh
