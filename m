Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbVJ3GSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbVJ3GSq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 01:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbVJ3GSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 01:18:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:29420 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932733AbVJ3GSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 01:18:45 -0500
Subject: Re: [PATCH] .text page fault SMP scalability optimization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       olof@austin.ibm.com
In-Reply-To: <20051019090632.GC30541@x30.random>
References: <20051019075255.GB30541@x30.random>
	 <20051019011420.032ccd6d.akpm@osdl.org> <20051019090632.GC30541@x30.random>
Content-Type: text/plain
Date: Sun, 30 Oct 2005 17:17:31 +1100
Message-Id: <1130653052.29054.237.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 11:06 +0200, Andrea Arcangeli wrote:
> On Wed, Oct 19, 2005 at 01:14:20AM -0700, Andrew Morton wrote:
> > How strange.  Do you mena that all CPUs were entering the pagefault handler
> > on behalf of the same pte all the time?  That they're staying in lockstep?
> 
> Yes.

Nice catch Andrea !

> > If so, there must be a bunch of page_table_lock contention too?
> 
> Not really as much. Note also that with latest mainline the ppc64 kernel
> was going well even without this patch, it was some older codebase
> falling apart, primarly because it was still doing pte_establish there
> see:
> 
> 	young_entry = pte_mkyoung(entry);
> 	if (!pte_same(young_entry, entry)) {
> 		ptep_establish(vma, address, pte, young_entry);
> 		update_mmu_cache(vma, address, young_entry);
> 		lazy_mmu_prot_update(young_entry);
> 	}

Yes, that's one reason why I introduced ptep_set_access_flags() to be
used when relaxing access permissions to a PTE.

> So those flush actions were a bottleneck when executed by all cpus at
> the same time. But some archs still implement it like with the old
> codebase, and the patch is quite an obvious optimization that can
> clearly avoid useless tlb flushes (and that fixed the problem completely
> with the older codebase still dong ptep_establish even on ppc64).

Note that we should really pass more than just "write_access" from the
arch code. We could make good use of "execute" in some cases as well,
also knowing wether this is a real fault or the result of
get_user_pages() (in some case, the former could use more agressive TLB
pre-loading, not the later). Finally, those infos should be passed to
update_mmu_cache().

Ben.


