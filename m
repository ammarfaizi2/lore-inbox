Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbUCZR5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUCZR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:57:50 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31402
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264094AbUCZR5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:57:48 -0500
Date: Fri, 26 Mar 2004 18:58:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: akpm@osdl.org, torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040326175842.GC9604@dualathlon.random>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain> <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu> <20040325225919.GL20019@dualathlon.random> <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu> <20040326075343.GB12484@dualathlon.random> <Pine.LNX.4.58.0403261013480.672@ruby.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403261013480.672@ruby.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 10:43:17AM -0500, Rajesh Venkatasubramanian wrote:
> 
> Hi Andrea,
> 
> There is a problem with the prio_tree merge. As usual it is
> related to VM_NONLINEAR. When I was reading Hugh's nonlinear
> patch, I recalled this problem.
> 
> Currently, with the prio_tree search in try_to_unmap, you will
> not check all the nonlinear vmas. Earlier, with a list walk it
> was not a problem. But, now in try_to_unmap we only select vmas
> that map a given page. That's meaningless for nonlinear vmas.
> 
> I think the fix is straight-forward. My plan is to add a
> "list_head i_mmap_nonlinear" to the address_space and use the
> list to find all nonlinear vmas in try_to_unmap_inode.
> 
> In sys_remap_file_pages, we can do something like below:
> 
> if (!(vma->vm_flags & VM_NONLINEAR)) { /* vma is not already nonlinear */
> 	__vma_prio_tree_remove(&mapping->i_mmap_shared, vma)
> 	list_add_tail(&vma->shared.vm_set.list,
> 			&mapping->i_mmap_nonlinear);
> }
> 
> Urggh. That forces us to take i_shared_sem in sys_remap_file_pages.
> 
> Please let me know if you have any better idea. Otherwise, tonite
> I will send you a patch for 2.6.5-rc2-aa4.

I agree this will fix it. If a better fix comes to mind I will let you
know, in the meantime this fix will be welcome (despite the i_mmap_sem
in remap_file_pages) and I will merge it in the next prio-tree patch.
Thanks!
