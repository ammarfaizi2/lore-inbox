Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUDHA6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUDHA6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:58:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50836 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261313AbUDHA6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:58:36 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040407234525.4f775c16.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de> <1081374061.9061.26.camel@arrakis>
	 <20040407234525.4f775c16.ak@suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1081385903.9925.109.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Apr 2004 17:58:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 14:45, Andi Kleen wrote:

> diff -u linux-2.6.5-mc2-numa/mm/mempolicy.c-o linux-2.6.5-mc2-numa/mm/mempolicy.c
> --- linux-2.6.5-mc2-numa/mm/mempolicy.c-o	2004-04-07 12:07:41.000000000 +0200
> +++ linux-2.6.5-mc2-numa/mm/mempolicy.c	2004-04-07 13:07:02.000000000 +0200

<snip>

> +/* Do sanity checking on a policy */
> +static int check_policy(int mode, unsigned long *nodes)
> +{
> +	int empty = bitmap_empty(nodes, MAX_NUMNODES);
> +	switch (mode) {
> +	case MPOL_DEFAULT:
> +		if (!empty)
> +			return -EINVAL;
> +		break;
> +	case MPOL_BIND:
> +	case MPOL_INTERLEAVE:
> +		/* Preferred will only use the first bit, but allow
> +		   more for now. */
> +		if (empty)
> +			return -EINVAL;
> +		break;
> +	}
> +	return check_online(nodes);
> +}

Is there a reason you don't have a case for MPOL_PREFERRED?  You have a
comment about it in the function, but you don't check the nodemask isn't
empty...

> +/* Copy a node mask from user space. */
> +static int get_nodes(unsigned long *nodes, unsigned long *nmask,
> +		     unsigned long maxnode, int mode)
> +{
> +	unsigned long k;
> +	unsigned long nlongs;
> +	unsigned long endmask;
> +
> +	--maxnode;
> +	nlongs = BITS_TO_LONGS(maxnode);
> +	if ((maxnode % BITS_PER_LONG) == 0)
> +		endmask = ~0UL;
> +	else
> +		endmask = (1UL << (maxnode % BITS_PER_LONG)) - 1;
> +
> +	/* When the user specified more nodes than supported just check
> +	   if the non supported part is all zero. */
> +	if (nmask && nlongs > BITS_TO_LONGS(MAX_NUMNODES)) {
> +		for (k = BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
> +			unsigned long t;
> +			if (get_user(t,  nmask + k))
> +				return -EFAULT;
> +			if (k == nlongs - 1) {
> +				if (t & endmask)
> +					return -EINVAL;
> +			} else if (t)
> +				return -EINVAL;
> +		}
> +		nlongs = BITS_TO_LONGS(MAX_NUMNODES);
> +		endmask = ~0UL;
> +	}
> +
> +	bitmap_clear(nodes, MAX_NUMNODES);
> +	if (nmask && copy_from_user(nodes, nmask, nlongs*sizeof(unsigned long)))
> +		return -EFAULT;
> +	nodes[nlongs-1] &= endmask;
> +	return check_policy(mode, nodes);
> +}

In this function, why do we care what bits the user set past
MAX_NUMNODES?  Why shouldn't we just silently ignore the bits like we do
in sys_sched_setaffinity?  If a user tries to hand us an 8k bitmask, my
opinion is we should just grab as much as we care about (MAX_NUMNODES
bits rounded up to the nearest UL).

> +/* Generate a custom zonelist for the BIND policy. */
> +static struct zonelist *bind_zonelist(unsigned long *nodes)
> +{
> +	struct zonelist *zl;
> +	int num, max, nd;
> +
> +	max = 1 + MAX_NR_ZONES * bitmap_weight(nodes, MAX_NUMNODES);
> +	zl = kmalloc(sizeof(void *) * max, GFP_KERNEL);
> +	if (!zl)
> +		return NULL;
> +	num = 0;
> +	for (nd = find_first_bit(nodes, MAX_NUMNODES);
> +	     nd < MAX_NUMNODES;
> +	     nd = find_next_bit(nodes, MAX_NUMNODES, 1+nd)) {
> +		int k;
> +		for (k = MAX_NR_ZONES-1; k >= 0; k--) {
> +			struct zone *z = &NODE_DATA(nd)->node_zones[k];
> +			if (!z->present_pages)
> +				continue;
> +			zl->zones[num++] = z;
> +			if (k > policy_zone)
> +				policy_zone = k;
> +		}
> +	}
> +	BUG_ON(num >= max);
> +	zl->zones[num] = NULL;
> +	return zl;
> +}

This seems a bit strange to me.  Instead of just allocating a whole
struct zonelist, you're allocating part of one?  I guess it's safe,
since the array is meant to be NULL terminated, but we should put a note
in any code using these zonelists that they *aren't* regular zonelists,
they will be smaller, and dereferencing arbitrary array elements in the
struct could be dangerous.  I think we'd be better off creating a
kmem_cache_t for these and using *whole* zonelist structures. 
Allocating part of a well-defined structure makes me a bit nervous...

> +/* Create a new policy */
> +static struct mempolicy *new_policy(int mode, unsigned long *nodes)
> +{
> +	struct mempolicy *policy;
> +	PDprintk("setting mode %d nodes[0] %lx\n", mode, nodes[0]);
> +	if (mode == MPOL_DEFAULT)
> +		return NULL;
> +	policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
> +	if (!policy)
> +		return ERR_PTR(-ENOMEM);
> +	atomic_set(&policy->refcnt, 1);
> +	switch (mode) {
> +	case MPOL_INTERLEAVE:
> +		bitmap_copy(policy->v.nodes, nodes, MAX_NUMNODES);
> +		break;
> +	case MPOL_PREFERRED:
> +		policy->v.preferred_node = find_first_bit(nodes, MAX_NUMNODES);
> +		if (policy->v.preferred_node >= MAX_NUMNODES)
> +			policy->v.preferred_node = -1;
> +		break;
> +	case MPOL_BIND:
> +		policy->v.zonelist = bind_zonelist(nodes);
> +		if (policy->v.zonelist == NULL) {
> +			kmem_cache_free(policy_cache, policy);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +		break;
> +	}
> +	policy->policy = mode;
> +	return policy;
> +}

I'm guessing this is why you aren't checking MPOL_PREFERRED in
check_policy()?  So the user can call mbind() with MPOL_PREFERRED and an
empty nodes bitmap and get the default behavior you mentioned in the
comments?

I've got to get some dinner now...  I'll keep reading and send more
comments as I come up with them.

Cheers!

-Matt

