Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUCZPnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUCZPnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:43:41 -0500
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:3050 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S264054AbUCZPnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:43:39 -0500
Date: Fri, 26 Mar 2004 10:43:17 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@ruby.engin.umich.edu
To: Andrea Arcangeli <andrea@suse.de>
cc: akpm@osdl.org, torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
 fix
In-Reply-To: <20040326075343.GB12484@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0403261013480.672@ruby.engin.umich.edu>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain>
 <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
 <20040325225919.GL20019@dualathlon.random> <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu>
 <20040326075343.GB12484@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrea,

There is a problem with the prio_tree merge. As usual it is
related to VM_NONLINEAR. When I was reading Hugh's nonlinear
patch, I recalled this problem.

Currently, with the prio_tree search in try_to_unmap, you will
not check all the nonlinear vmas. Earlier, with a list walk it
was not a problem. But, now in try_to_unmap we only select vmas
that map a given page. That's meaningless for nonlinear vmas.

I think the fix is straight-forward. My plan is to add a
"list_head i_mmap_nonlinear" to the address_space and use the
list to find all nonlinear vmas in try_to_unmap_inode.

In sys_remap_file_pages, we can do something like below:

if (!(vma->vm_flags & VM_NONLINEAR)) { /* vma is not already nonlinear */
	__vma_prio_tree_remove(&mapping->i_mmap_shared, vma)
	list_add_tail(&vma->shared.vm_set.list,
			&mapping->i_mmap_nonlinear);
}

Urggh. That forces us to take i_shared_sem in sys_remap_file_pages.

Please let me know if you have any better idea. Otherwise, tonite
I will send you a patch for 2.6.5-rc2-aa4.

Thanks,
Rajesh


