Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUDHP2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUDHP2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:28:36 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27814
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262022AbUDHP2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:28:33 -0400
Date: Thu, 8 Apr 2004 17:28:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rmap: nonlinear truncation
Message-ID: <20040408152830.GC31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081441480.7010-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404081441480.7010-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 02:51:20PM +0100, Hugh Dickins wrote:
> If you truncate the file beneath a nonlinear vma, your anon_vma
> warns in __remove_from_page_cache then BUGs in page_referenced.
> My anonmm leaves the pages unfreeable until the vma is unmapped.
> pte_chains treats them as anonymous and can swap them out.  None
> of us is right (allocating swap violates strict commit accounting).
> I think we need to fix nonlinear truncation properly at last, I'm
> looking at Daniel's invalidate_mmap_range patch from a month ago,
> to see if we can springboard off that.

I want to fix nonlinear to avoid to remove pages from the pagecache
while they're still unmapped. There's a reason I added that WARN_ON,
that signals somebody is doing a mistake.

I should have giveup with the nonlinear hack and I should have made it
a privilegied operation under CAP_IPC_LOCK without care of the arguments
from nonlinear advocates, now I regret it, I hate nonlinear but I give
it the paging and a BUG is what I get back from it (and I'm not going to
return just page->mapping is NULL, I want that BUG in there, it's
nonlinear that's broken, and I cannot check the vmas & VM_NONLINEAR
there if I don't have the mapping first), there's no way to swap
nonlinear efficiently anyways, nonlinear is a brute hack in the vm (yeah
there's a way if you waste a fixed amount of ram for every mapping of
each page that you intend to later swap like rmap was doing but that's a
not acceptable overhead especially for the nonlinaer usages on 32bit
arch plus there's no way I'll ever waste 8 bytes per-page in the mem_map
just for nonlinear, if something it has to allocate memory dynamically
externally similar to that the radix tree does for the dirty list in -mm
etc.. so the pte_chains are totally worthless anyways for swapping
nonlinear w/o costant overhead).

So I believe nonlinaer is now going into CAP_IPC_LOCK even if we do
truncate right infact I recommend people to always use mlock on top of
nonlinear since swapping nonlinear is derimental for the VM so I'd
expect from most usages mlock privilegies are needed anyways and this
will avoid nonlinear to work and mlock not, I've a sysctl in my tree
that I keep enabled by default that gives
mlock/shmget(SHM_HUGETLB)/shmget(SHM_LOCK) to all users w/o privilegies
so it's trivial to tweak.
