Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312138AbSCTUY1>; Wed, 20 Mar 2002 15:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312136AbSCTUYR>; Wed, 20 Mar 2002 15:24:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31321 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312134AbSCTUYG>; Wed, 20 Mar 2002 15:24:06 -0500
Date: Wed, 20 Mar 2002 21:23:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020320212341.M4268@dualathlon.random>
In-Reply-To: <127930000.1016651345@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 11:09:05AM -0800, Martin J. Bligh wrote:
> 1. A good place to put the process pagetables. We only use up the amount of virtual
> address space (vaddr space) for one task's pagetables - if we map them into ZONE_NORMAL 

we need to walk pagetables not just from the current task and mapping
pagetables there would decrase the user address space too much.

> (as current mainline) we use up vaddr space for *all* task's pagetables - if we map them 

I think you're missing the problem with mainline. There is no shortage
of virtual address space, there is a shortage of physical ram in the
zone normal. So we cannot keep them in zone normal (and there's no such
thing as "mapping in zone_normal"). Maybe I misunderstood what you were
saying.

> through kmap (atomic or persistent), we pay dearly in tlbflushes.
> 
> 2. A good place to make a per-task kmap area. This would be on a pool system similar to
> the current persistent kmap. We would potentially do only a local cpu tlb_flush_all when

that would not be similar. There would be only 1 entry per "serie", so
there would be 1 virtual page for the pagecache and 1 virtual page for
the pagetables, two pages only in total per-process. It would not be a
real "pool", just two entries and there would not be a page->virtual
cache because the page->virtual has to be global. Plus even better,
those persistent kmaps couldn't block, so I wouldn't need to do the
_under_lock thing for pte_alloc.

The only difference between this and my scalable kmap outlined in the
previous emails, is that you won't need to pin the task because the
mapping will be migrated with the userspace (we must avoid to enable
lazy-tlb from kernel if we need to use kmaps though). Plus there won't
be the risk of stalling due running out of entries (so it couldn't
block).

At the top of the email I said "we need to walk pagetables not just from
the current task" and infact this single virtual entry reserved for the
pagetable handling will go and map pagetables of any task in the
system as we do just now with /proc etc..

So the idea of those 2 virtual pages per-task sounds nice compared to my
scalar per-cpu kmap idea, no scheduler hacks necessary and no risk to stall.
The cons (probably the reason I didn't even considered the possibility
of user the user-address-space) is the significant breakage that it will
make to the arch code (like the fact page faults will have to stop at
PAGE_OFFSET-NR_SERIES*PAGE_SIZE, the stack has to start two pages
before and certainly some more detail) but for 2.5 it may be worthwhile.
Also to avoid walking user pagetables at every kmap, we'd need a pointer
to the pte entry from the task structure, that also will need to be
collected somehow. Certainly it can work and as said it has some
advantage compared to the scalar kmap.

The concern about the out-of-contxt kmaps (from kernel threads etc..) is
nothing to worry about too, they can all be atomic, copy-user is the
only reason we need the persistence, and copy-user needs a context to
run. So it would be fine for that too. So with this design we'd have a
kind of atomic-but-persistent kmaps.

Still is missing the page->virtual cache so it remains inferior to the
current kmap-persistent-cache-pool on UP for example, but it is
certainly the best for your scalability needs in NUMA-Q.

Andrea
