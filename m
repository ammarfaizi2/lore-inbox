Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbUCMSP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbUCMSP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:15:28 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34570
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263153AbUCMSPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:15:23 -0500
Date: Sat, 13 Mar 2004 19:16:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: anon_vma RFC2
Message-ID: <20040313181606.GO30940@dualathlon.random>
References: <20040310080000.GA30940@dualathlon.random> <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com> <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu> <20040312172600.GC30940@dualathlon.random> <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu> <Pine.LNX.4.58.0403131246580.28574@ruby.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403131246580.28574@ruby.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 12:55:09PM -0500, Rajesh Venkatasubramanian wrote:
> 
> > The only problem is mremap() after a fork(), and hell, we know that's a
> > special case anyway, and let's just add a few lines to copy_one_pte(),
> > which basically does:
> >
> >	if (PageAnonymous(page) && page->count > 1) {
> >		newpage = alloc_page();
> >		copy_page(page, newpage);
> >		page = newpage;
> >	}
> >	/* Move the page to the new address */
> >	page->index = address >> PAGE_SHIFT;
> >
> > and now we have zero special cases.
> 
> This part makes the problem so simple. If this is acceptable, then we
> have many choices. Since we won't have many mms in the anonmm list,
> I don't think we will have any search complexity problems. If we really
> worry again about search complexity, we can consider using prio_tree
> (adds 16 bytes per vma - we cannot share vma.shared.prio_tree_node).
> The prio_tree easily fits for anonmm after linus-mremap-simplification.

prio_tree with linus-mremap-simplification makes no sense to me. You
cannot avoid checking all the mm with the prio_tree and that is the only
complexity issue introduced by anonmm vs anon_vma.


prio_tree can only sit on top of anon_vma, not on top of
anonmm+linus-unshare-mremap (and yes, I cannot share
vma.shared.prio_tree_node) but pratically it's not needed for the
anon_vmas.
