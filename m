Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVCZNvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVCZNvU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 08:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVCZNvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 08:51:20 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:13229 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262063AbVCZNvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:51:17 -0500
Message-ID: <424568D2.7090701@yahoo.com.au>
Date: Sun, 27 Mar 2005 00:51:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk> <20050326133720.B12809@flint.arm.linux.org.uk>
In-Reply-To: <20050326133720.B12809@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> Ok.  What's happening is that the ARM pgd_alloc uses pte_alloc_map() to
> allocate the first L1 page table.  This sets mm->nr_ptes to be one.
> 
> The ARM free_pgd knows about this, and will free this PTE at the
> appropriate time.  However, exit_mmap() doesn't know about this itself,
> so in the ARM case, it should BUG_ON(mm->nr_ptes != 1) if we're using
> low vectors.
> 
> I guess we could hack it such that the ARM pgd_alloc decrements mm->nr_ptes
> itself to keep things balanced, since free_pte_range() won't be called
> for this pte.  However, I don't like that because its likely to break at
> some point in the future.
> 
> Any ideas how to cleanly support this with the new infrastructure?
> 

Hmm, in that case it could be just a problem with that BUG_ON() -
it wasn't there before... but it seems like a very useful test,
especially with all this new work going on, so it would be a shame
not to run it in releases.

But I don't quite understand (should really look at the code more),
how come you aren't leaking memory? Do _all_ processes share this
same first L1 page table? If so, can it be allocated with a more
specialised function? If not, can nr_ptes be decremented in the
place where it is freed?

/me goes to bed now - I'll have a bit of a look tomorrow.

Nick

