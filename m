Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310606AbSCTWMG>; Wed, 20 Mar 2002 17:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310295AbSCTWL6>; Wed, 20 Mar 2002 17:11:58 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19349 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310606AbSCTWLp>; Wed, 20 Mar 2002 17:11:45 -0500
Date: Wed, 20 Mar 2002 14:10:57 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <147140000.1016662257@flay>
In-Reply-To: <20020320212341.M4268@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, March 20, 2002 21:23:41 +0100 Andrea Arcangeli <andrea@suse.de> wrote:

> On Wed, Mar 20, 2002 at 11:09:05AM -0800, Martin J. Bligh wrote:
>> 1. A good place to put the process pagetables. We only use up the amount 
>> of virtual address space (vaddr space) for one task's pagetables - if we map 
>> them into ZONE_NORMAL 
> 
> we need to walk pagetables not just from the current task and mapping
> pagetables there would decrase the user address space too much.

How much? By calculations I've heard 3Mb or 6Mb, depending on whether
64Gb support is on or not. Doesn't seem like a lot to me. And as I said in my
original email, we could steal this from either user space or kernel space.

> I think you're missing the problem with mainline. There is no shortage
> of virtual address space, there is a shortage of physical ram in the
> zone normal.  So we cannot keep them in zone normal (and there's no such
> thing as "mapping in zone_normal"). Maybe I misunderstood what you 
> were saying.

The top 128Mb of kernel virtual space is the obvious choice if we're taking
it from kernel space, I wouldn't steal it from the ZONE_NORMAL area (though 
I don't think shifting the 896Mb barrier down by 6Mb would kill anyone). 

>> through kmap (atomic or persistent), we pay dearly in tlbflushes.
>> 
>> 2. A good place to make a per-task kmap area. This would be on a pool system similar to
>> the current persistent kmap. We would potentially do only a local cpu tlb_flush_all when
> 
> that would not be similar. There would be only 1 entry per "serie", so
> there would be 1 virtual page for the pagecache and 1 virtual page for
> the pagetables, two pages only in total per-process. It would not be a
> real "pool", just two entries and there would not be a page->virtual
> cache because the page->virtual has to be global. Plus even better,
> those persistent kmaps couldn't block, so I wouldn't need to do the
> _under_lock thing for pte_alloc.

Not sure I grok the above - you mean like the atomic_kmap stuff? The problem
with that is you have to do a tlb_flush_one per access - if we have a pool
we can do a *local* tlb_flush_all per N accesses (where N is sizeof pool).
And as we do a local tlb_flush_all per context switch anyway, we can
probably avoid doing *any* tlbflush in all but the heaviest pool usage if
we're clever about accounting.

> The only difference between this and my scalable kmap outlined in the
> previous emails, is that you won't need to pin the task because the
> mapping will be migrated with the userspace (we must avoid to enable
> lazy-tlb from kernel if we need to use kmaps though). Plus there won't
> be the risk of stalling due running out of entries (so it couldn't
> block).

That seems like a good difference to me. Rik pointed this problem out to
me a couple of months ago, which is why I threw that concept away.

Martin.
