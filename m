Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUCVAdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUCVAdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:33:43 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41354
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261573AbUCVAdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:33:39 -0500
Date: Mon, 22 Mar 2004 01:34:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322003429.GE3649@dualathlon.random>
References: <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <405E23A5.7080903@pobox.com> <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org> <20040321235854.H26708@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321235854.H26708@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 11:58:54PM +0000, Russell King wrote:
> On Sun, Mar 21, 2004 at 03:51:31PM -0800, Linus Torvalds wrote:
> > That might be the minimal fix, since it would basically involve:
> >  - change whatever offensive "virt_to_page()" calls into 
> >    "dma_map_to_page()".
> >  - implement "dma_map_to_page()" for all architectures.
> > 
> > Would that make people happy?
> 
> Unfortunately this doesn't make dwmw2 happy - he claims to have machines
> which implement dma_alloc_coherent using RAM which doesn't have any
> struct page associated with it.

I would suggest to add a ->nopage_dma (or whatever other name for an
additional callback in the vm_ops) that will return a non pageable "pfn"
number (not a page_t*).  This is all the VM needs to setup the pte
properly, this callback will not know anything about the pageable stuff
(i.e. it will not have to call page_add_rmap or stuff like that).

I definitely agree a driver currently has no way to work safe if it
returns non-ram via ->nopage and it must use remap_file_pages, but OTOH
I don't like remap_file_pages myself, it's a lot nicer to use paging
even for mapping non-ram, even if you don't use scatter gather, even if
you've just an huge block of contigous physical ram, at the very least
for the scheduler latencies in a loop under the page_table_lock.

nopage_dma will be like this:

do_no_page_dma(vma, ...)
{
	pfn = vma->vm_ops->nopage_dma()
	if (pfn_valid(pfn)) {
		/*
		 * going from valid pfn to page is always ok
		 * the other way around not
		 */
		page = pfn_to_page(pfn);
		BUG_ON(page->mapping);
		if (!PageReserved(page))
			mm->rss++;
	}
	setup the pte using the pfn here, no vm accounting or pte tracking
	required since it's either non valid pfn or reserved page that
	will be ignored by the zap_pte stuff
}

do_no_page()
{
	if (!vma->vm_ops || !vma->vm_ops->nopage)
		return do_anonymous_page(mm, vma, page_table,
					pmd, write_access, address);
	if (vma->vm_ops->nopage_dma)
		return do_no_page_dma(...)
}

Then the mmu VM troubles are over, how you keep the cache of this pte
view coherent with the iommu view isn't something solvable by the mmu,
but certainly you can add whatever cache flushing callback in teh
do_no_page_dma core, that's a slow path so you can play with it from any
arch adding whatever needed library calls.

btw, on a slightly related note, I don't think this is safe in
get_user_pages in 2.6:

				if (!PageReserved(pages[i]))
					page_cache_get(pages[i]);

there's nothing preventing munmap to free the page while somebody does
I/O on the page via get_user_pages.
