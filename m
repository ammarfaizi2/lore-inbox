Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUCLQiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUCLQiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:38:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55309
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262293AbUCLQi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:38:27 -0500
Date: Fri, 12 Mar 2004 17:39:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312163910.GZ30940@dualathlon.random>
References: <20040312155652.GW30940@dualathlon.random> <Pine.LNX.4.44.0403121602520.5118-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403121602520.5118-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 04:12:10PM +0000, Hugh Dickins wrote:
> > you're right about vma_split, the way I implemented it is wrong,
> > basically the as.vma/PageDirect idea is falling apart with vma_split.
> > I should simply allocate the anon_vma without passing through the direct
> 
> Yes, that'll take a lot of the branching out, all much simpler.

indeed.

> Simpler still to allocate it earlier?  Perhaps too wasteful.

one trouble with allocate it earlier is that insert_vm_struct would need
to return a -ENOMEM retval, plus things like MAP_PRIVATE don't
necessairly need an anon_vma ever (true anon mappings tends to need it
always instead ;).

So I will have to add a anon_vma_prepare(vma) near all SetPageAnon.
that's easy.  Infact I may want to coalesce the two things together, it
will look like:

int anon_vma_prepare_page(vma, page) {
	if (!vma->anon_vma) {
		vma->anon_vma = anon_vma_alloc()
		if (!vma->anon_vma)
			return -ENOMEM;
		/* single threaded no locks here */
		list_add(&vma->anon_vma_node, &anon_vma->anon_vma_head);
	}
	SetPageAnon(page);

	return 0;
}

I will have to handle a retval failure from there, that's the only
annoyance of removing the PageDirect optimization, I really did the
PageDirect mostly to leave all the anon_vma allocations to fork().

Now it's the exact opposite, fork will never need to allocate any
anon_vma anymore, it will only boost the page->mapcount.
