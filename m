Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263223AbUCNAXI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUCNAXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:23:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50948
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263223AbUCNAXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:23:06 -0500
Date: Sun, 14 Mar 2004 01:23:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: anon_vma RFC2
Message-ID: <20040314002348.GQ30940@dualathlon.random>
References: <20040310080000.GA30940@dualathlon.random> <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com> <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu> <20040312172600.GC30940@dualathlon.random> <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu> <Pine.LNX.4.58.0403131246580.28574@ruby.engin.umich.edu> <20040313181606.GO30940@dualathlon.random> <Pine.GSO.4.58.0403131426590.12823@blue.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403131426590.12823@blue.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 02:40:09PM -0500, Rajesh Venkatasubramanian wrote:
> Agreed. prio_tree is only useful for anon_vma. But, after
> linus-unshare-mremap, the anon_vma patch can be modified
> (simplified ?) a lot. You don't need any as.anon_vma, as.vma
> pointers in the page struct. You just need the already existing
> page->mapping and page->index, and a prio_tree of all anon vmas.

what you are missing is that we don't need a prio_tree at all with
anonmm+linus-unshare-mremap, prio tree can make sense only with
anon_vma, not with anonmm. the vm_pgoff is meaningless with anonmm.
find_vma (and the rbtree) already does the trick with anonmm. the
linus-unshare-mremap guarantees that a certain physical page will be
only at a certain virtual address in every mm, so prio_tree taking pgoff
into account isn't needed there, find_vma is more than enough.

any prio_tree can't fix anyways the problem that anonmm will force
the vm to scan all mm at the page->index address, even for a newly
allocated malloc region. that is optimized away by anon_vma, plus
anon_vma avoids the early-COW in mremap. the relevant downside of
anon_vma is that it takes some more byte in the vma to provide those
features.
