Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753554AbWKCVqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbWKCVqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWKCVqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:46:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753554AbWKCVqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:46:37 -0500
Date: Fri, 3 Nov 2006 13:46:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061103134633.a815c7b3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 12:58:24 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> Interleave allocation often go over large sets of nodes. Some nodes
> may have tasks on them that heavily use memory

"heavily used" means "referenced" and maybe "active" and maybe "dirty".
See below.

> and rely on node local
> allocations to get optimium performance. Overallocating those nodes may
> reduce performance of those tasks by forcing off node allocations and
> additional reclaim passes. It is better if we try to avoid nodes
> that have most of its memory used and focus on nodes that still have lots
> of memory available.
> 
> The intend of interleave is to have allocations spread out over a set of
> nodes because the data is likely to be used from any of those nodes. It is
> not important that we keep the exact sequence of allocations at all times.
> 
> The exact node we choose during interleave does not matter much if we are
> under memory pressure since the allocations will be redirected anyways
> after we have overallocated a single node.

Am not clear on what that means.

> This patch checks for the amount of free pages on a node. If it is lower
> than a predefined limit (in /proc/sys/kernel/min_interleave_ratio) then

You mean /proc/sys/vm

> we avoid allocating from that node. We keep a bitmap of full nodes
> that is cleared every 2 seconds when draining the pagesets for
> node 0.

Wall time is a bogus concept in the VM.  Can we please stop relying upon it?

> Should we find that all nodes are marked as full then we disregard
> the limit and continue allocate from the next node round robin
> without any checks.
> 
> This is only effective for interleave pages that are placed without
> regard to the address in a process (anonymous pages are typically
> placed depending on an interleave node generated from the address).
> It applies mainly to slab interleave and page cache interleave.
> 
> We operate on full_interleave_nodes without any locking which means
> that the nodemask may take on an undefined value at times. That does
> not matter though since we always can fall back to operating without
> full_interleave_nodes. As a result of the racyness we may uselessly
> skip a node or retest a node.

This design relies upon nodes having certain amounts of free memory.  This
concept is bogus.  Because it treats clean pagecache which hasn't been used
since last Saturday as "in use".  It is not in use.

This false distinction between free pages and trivially-reclaimable pages
is specific to particular workloads on particular machines hence this
design is not generally useful.


Perhaps a better design would be to key the decision off the page reclaim
scanning priority.

> 
> Index: linux-2.6.19-rc4-mm2/Documentation/sysctl/vm.txt
> ===================================================================
> --- linux-2.6.19-rc4-mm2.orig/Documentation/sysctl/vm.txt	2006-11-02 14:18:59.000000000 -0600
> +++ linux-2.6.19-rc4-mm2/Documentation/sysctl/vm.txt	2006-11-03 13:12:04.006734590 -0600
> @@ -198,6 +198,28 @@ and may not be fast.
>  
>  =============================================================
>  
> +min_interleave_ratio:
> +
> +This is available only on NUMA kernels.
> +
> +A percentage of the free pages in each zone.  If less than this
> +percentage of pages are in use then interleave will attempt to
> +leave this zone alone and allocate from other zones. This results
> +in a balancing effect on the system if interleave and node local allocations
> +are mixed throughout the system. Interleave pages will not cause zone
> +reclaim and leave some memory on node to allow node local allocation to
> +occur. Interleave allocations will allocate all over the system until global
> +reclaim kicks in.
> +
> +The mininum does not apply to pages that are placed using interleave
> +based on an address such as implemented for anonymous pages. It is
> +effective for slab allocations, huge page allocations and page cache
> +allocations.
> +
> +The default ratio is 10 percent.
> +

That has several typos and grammatical mistakes.

> +	VM_MIN_INTERLEAVE=39,	/* Limit for interleave */

I think we recently decided to set all new sysctl number to CTL_UNNUMBERED.
 Eric, can you remind us of the thinkin there please?

> --- linux-2.6.19-rc4-mm2.orig/mm/mempolicy.c	2006-11-02 14:19:37.000000000 -0600
> +++ linux-2.6.19-rc4-mm2/mm/mempolicy.c	2006-11-03 13:12:04.181552934 -0600
> @@ -1118,16 +1118,60 @@ static struct zonelist *zonelist_policy(
>  	return NODE_DATA(nd)->node_zonelists + gfp_zone(gfp);
>  }
>  
> +/*
> + * Generic interleave function to be used by cpusets and memory policies.
> + */
> +nodemask_t full_interleave_nodes = NODE_MASK_NONE;
> +
> +/*
> + * Called when draining the pagesets of node 0
> + */
> +void clear_full_interleave_nodes(void) {
> +	nodes_clear(full_interleave_nodes);
> +}

coding style.

> +int __interleave(int current_node, nodemask_t *nodes)
> +{
> +	unsigned next;
> +	struct zone *z;
> +	nodemask_t nmask;
> +
> +redo:
> +	nodes_andnot(nmask, *nodes, full_interleave_nodes);
> +	if (unlikely(nodes_empty(nmask))) {
> +		/*
> +		 * All allowed nodes are overallocated.
> +		 * Ignore interleave limit.
> +		 */
> +		next = next_node(current_node, *nodes);
> +		if (next >= MAX_NUMNODES)
> +			next = first_node(*nodes);
> +		return next;
> +	}
> +
> +	next = next_node(current_node, nmask);
> +	if (next >= MAX_NUMNODES)
> +		next = first_node(nmask);
> +
> +	/*
> +	 * Check if node is overallocated. If so the set it to full.
> +	 */
> +	z = &NODE_DATA(next)->node_zones[policy_zone];
> +	if (unlikely(z->free_pages <= z->min_interleave_pages)) {
> +		node_set(next, full_interleave_nodes);
> +		goto redo;
> +	}
> +	return next;
> +}

This function would benefit from an introductory comment.


