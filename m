Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbUCLVSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUCLVSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:18:04 -0500
Received: from reformers.mr.itd.umich.edu ([141.211.93.147]:52393 "EHLO
	reformers.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262992AbUCLVQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:16:58 -0500
Date: Fri, 12 Mar 2004 16:16:54 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@sapphire.engin.umich.edu
To: riel@redhat.com
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312172600.GC30940@dualathlon.random>
Message-ID: <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu>
References: <20040310080000.GA30940@dualathlon.random>
 <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
 <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu>
 <20040312172600.GC30940@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> I think your approach could work (reverse map by having separate
>> address
>> spaces for unrelated processes), but I don't see any good "page->index"
>> allocation scheme that is implementable.

>> Or did I totally mis-understand what you were proposing?

> You're absolutely right.  I am still trying to come up with
> a way to do this.
> [snip]

> I just can't think of any now ...

Atleast one solution exists. It may be just an academic solution, though.

Add a new prio_tree root "remap_address" to anonmm address_space
structure.

struct anon_remap_address {
	unsigned long old_page_index_start;
	unsigned long old_page_index_end;
	unsigned long new_page_index;
	struct prio_tree_node prio_tree_node;
}

For each mremap that expands the area and moves the page tables, allocate
a new anon_remap_address struct and add to remap_address tree.

The page->index does not change ever. Take the page->index and walk
remap_address tree to find all remapped addresses. Once a list of
all remapped addresses are found, it's easy to find the interesting
vmas (again using a different prio_tree). Finding all remapped addresses
may involve recursion, that's bad.

Rajesh
