Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbUKOVR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUKOVR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUKOVPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:15:54 -0500
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:26053 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261724AbUKOVOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:14:20 -0500
Date: Mon, 15 Nov 2004 16:14:13 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@red.engin.umich.edu
To: Werner Almesberger <werner@almesberger.net>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
In-Reply-To: <20041115175415.X28802@almesberger.net>
Message-ID: <Pine.LNX.4.58.0411151559070.30860@red.engin.umich.edu>
References: <20041114235646.K28802@almesberger.net>
 <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu>
 <20041115175415.X28802@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, Werner Almesberger wrote:

> Rajesh Venkatasubramanian wrote:
> > Again I don't like the following approach fully. I couldn't come
> > out with a clean generalization something like rb_tree code.
>
> Hmm, GET_INDEX/get_index grows and grows, and also generates a
> hotspot for patch collisions ...
>
> And what if we took the hit and moved the key into struct
> prio_tree_node ? struct vm_area_struct.shared.vm_set already is
> one word longer than vm_area_struct.shared.prio_tree_node, so
> half of the key is free (in terms of storage - the key updates
> when vm_pgoff, vm_end, or vm_start changes aren't free). The
> other half could also be made free (in terms of storage and
> processing) with a little tweaking, e.g.  by adding
>
> 	...
> 	union {
> 		unsigned long vm_pgoff;
> 		struct vm_set {
> 			unsigned long vm_pgoff;
> 			...
> 		} vm_set;
> 		struct prio_tree_node prio_tree_node;
> 	}
> 	...
>
> #define vm_pgoff shared.vm_pgoff
>
> (Untested. This kind of #define is of course risky, so it may be
> better to just rewrite all the accesses.)


I thought about this, but this will lead to a very intrusive patch.
We have to change the meaning of vm_start and vm_end or increase
the size of vm_area_struct.


> Then, we could have
>
> 	struct prio_tree_node {
> 		unsigned long r_index, h_index;
> 		...
> 	};
>
> For the elevators, the keys (the "footprint" of a set of overlapping
> requests) are already stored as separate variables, so that could be
> migrated very easily, at no additional cost.

Why can't we have only 2 types of prio_tree. One VMA_PRIO_TREE and
another GENERIC_PRIO_TREE.

        struct generic_prio_tree_node {
		unsigned long r_index, h_index;
		struct prio_tree_node prio_tree_node;
	}

That way all new users of prio_tree code will use the
generic_prio_tree_node if possible. Moreover, we can avoid
an intrusive patch.

I am only worried about the micro-performance loss due to
get_index in the hot-paths such as vma_prio_tree_insert.

Rajesh
