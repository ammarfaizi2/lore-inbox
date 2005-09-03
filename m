Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVICFGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVICFGe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVICFGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:06:34 -0400
Received: from gold.veritas.com ([143.127.12.110]:24402 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751386AbVICFGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:06:33 -0400
Date: Sat, 3 Sep 2005 06:08:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jeff Dike <jdike@addtoit.com>
cc: Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/3] uml: share page bits handling between 2 and 3 level
 pagetables
In-Reply-To: <20050902201749.GA9104@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.61.0509030555400.14051@goblin.wat.veritas.com>
References: <20050728185655.9C6ADA3@zion.home.lan>
 <20050730160218.GB4585@ccure.user-mode-linux.org> <200508102137.28414.blaisorblade@yahoo.it>
 <20050902201749.GA9104@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Sep 2005 05:06:29.0584 (UTC) FILETIME=[3E631500:01C5B045]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, Jeff Dike wrote:
> On Wed, Aug 10, 2005 at 09:37:28PM +0200, Blaisorblade wrote:
> > Also look, on the "set_pte" theme, at the attached patch. 
> 
> +       WARN_ON(!pte_young(*pte) || pte_write(*pte) && !pte_dirty(*pte));
> 
> This one has been firing on me, and I decided to figure out why.  The
> culprit is this code in do_no_page:
> 
> 	if (pte_none(*page_table)) {
> 		if (!PageReserved(new_page))
> 			inc_mm_counter(mm, rss);
> 
> 		flush_icache_page(vma, new_page);
> 		entry = mk_pte(new_page, vma->vm_page_prot);
> 		if (write_access)
> 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> 		set_pte_at(mm, address, page_table, entry);
> 
> The first mk_pte immediately sets the pte to the protection limits of
> the VMA, regardless of the access type.  So, if it's a read access on
> a writeable page, we get a writeable, but not dirty pte, since the
> mkdirty never happens.  The exercises the warning you added.
> 
> This seems somewhat bogus to me.  If we set the pte protection to its
> limits, then the maybe_mkwrite is unneccesary.  
> 
> If we are the process in this address space, and we have a write
> access, then the maybe_mkwrite doesn't do anything because the pte is
> already writeable because the VMA has to be writeable, or we would
> have been faulted already.

Not at all.  The private, COW areas.  They may be writeable in the sense
that VM_WRITE is set, but pte_write permission cannot be in vm_page_prot,
or we'd never get the fault when to Copy On Write.

What is bogus, I think, are those places where we do the reverse:
like do_anonymous_page's pte_wrprotect of its mkpte of the ZERO_PAGE.

> If we are a debugger changing the process memory, then the vma may be
> read-only, and maybe_mkwrite is explicitly a no-op in this case.
> 
> This doesn't seem to harm our dirty bit emulation.  fix_range_common
> checks the dirty and accessed bits and disables read and write
> protection as appropriate.
> 
> So, it seems like the warning could be dropped, or perhaps made more
> selective, like checking for is_write == 0 and VM_WRITE, but then the
> test is getting complicated.
> 
> 				Heff

Jugh
