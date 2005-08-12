Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVHLBgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVHLBgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 21:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVHLBgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 21:36:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7587 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932435AbVHLBgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 21:36:33 -0400
Date: Thu, 11 Aug 2005 18:37:03 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul McKenney <paul.mckenney@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/7] radix-tree: lockless readside
Message-ID: <20050812013703.GP1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au> <42FB42EF.1040401@yahoo.com.au> <42FB4311.2070807@yahoo.com.au> <42FB43A8.8060902@yahoo.com.au> <42FB43CB.5080403@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FB43CB.5080403@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 10:25:47PM +1000, Nick Piggin wrote:
> 5/7
> 
> -- 
> SUSE Labs, Novell Inc.
> 

> Make radix tree lookups safe to be performed without locks.
> Readers are protected against nodes being deleted by using RCU
> based freeing. Readers are protected against new node insertion
> by using memory barriers to ensure the node itself will be
> properly written before it is visible in the radix tree.
> 
> Also introduce a lockfree gang_lookup_slot which will be used
> by a future patch.

Interesting approach!  Don't claim to fully understand it, but
see below (search for empty lines).  In the meantime, some questions:

o	What exactly is RCU protecting?  My first guess is that
	it protects the pointers and internal nodes of the
	radix tree, but not the objects in the leaves of the
	trees (in other words, the things pointed to by the
	return value from things like radix_tree_lookup_slot()).

	But if this really is the case, then the rcu_read_lock() &
	rcu_read_unlock() pairs can be pushed down into
	radix_tree_lookup_slot() and friends.

o	The current code structure would lead me to believe that
	page_cache_get_speculative() is protected by RCU, but
	I don't see the corresponding call_rcu() or synchronize_rcu()
	that would cause this protection to be required.

	I will expand on this in a reply to the relevant patch...

						Thanx, Paul

> Index: linux-2.6/lib/radix-tree.c
> ===================================================================
> --- linux-2.6.orig/lib/radix-tree.c
> +++ linux-2.6/lib/radix-tree.c
> @@ -29,6 +29,7 @@
>  #include <linux/gfp.h>
>  #include <linux/string.h>
>  #include <linux/bitops.h>
> +#include <linux/rcupdate.h>
>  
>  
>  #ifdef __KERNEL__
> @@ -45,7 +46,9 @@
>  	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
>  
>  struct radix_tree_node {
> +	unsigned int	height;		/* Height from the bottom */
>  	unsigned int	count;
> +	struct rcu_head	rcu_head;
>  	void		*slots[RADIX_TREE_MAP_SIZE];
>  	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
>  };
> @@ -97,10 +100,17 @@ radix_tree_node_alloc(struct radix_tree_
>  	return ret;
>  }
>  
> +static void radix_tree_node_rcu_free(struct rcu_head *head)
> +{
> +	struct radix_tree_node *node =
> +			container_of(head, struct radix_tree_node, rcu_head);
> +	kmem_cache_free(radix_tree_node_cachep, node);
> +}
> +
>  static inline void
>  radix_tree_node_free(struct radix_tree_node *node)
>  {
> -	kmem_cache_free(radix_tree_node_cachep, node);
> +	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
>  }
>  
>  /*
> @@ -196,6 +206,7 @@ static int radix_tree_extend(struct radi
>  	}
>  
>  	do {
> +		unsigned int newheight;
>  		if (!(node = radix_tree_node_alloc(root)))
>  			return -ENOMEM;
>  
> @@ -208,9 +219,13 @@ static int radix_tree_extend(struct radi
>  				tag_set(node, tag, 0);
>  		}
>  
> +		newheight = root->height+1;
> +		node->height = newheight;
>  		node->count = 1;
> +		/* Make ->height visible before node visible via ->rnode */

> +		smp_wmb();
>  		root->rnode = node;

The prior two lines should instead be:

		rcu_assign_pointer(root->rnode, node);

> -		root->height++;
> +		root->height = newheight;
>  	} while (height > root->height);
>  out:
>  	return 0;
> @@ -250,9 +265,12 @@ int radix_tree_insert(struct radix_tree_
>  			/* Have to add a child node.  */
>  			if (!(tmp = radix_tree_node_alloc(root)))
>  				return -ENOMEM;
> -			*slot = tmp;
> +			tmp->height = height;
>  			if (node)
>  				node->count++;
> +			/* Make ->height visible before node visible via slot */
> +			smp_wmb();
> +			*slot = tmp;
>  		}
>  
>  		/* Go a level down */
> @@ -282,12 +300,14 @@ static inline void **__lookup_slot(struc
>  	unsigned int height, shift;
>  	struct radix_tree_node **slot;
>  
> -	height = root->height;
> +	if (root->rnode == NULL)
> +		return NULL;
> +	slot = &root->rnode;
> +	height = (*slot)->height;
>  	if (index > radix_tree_maxindex(height))
>  		return NULL;
>  
>  	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
> -	slot = &root->rnode;
>  
>  	while (height > 0) {
>  		if (*slot == NULL)
> @@ -491,21 +511,24 @@ EXPORT_SYMBOL(radix_tree_tag_get);
>  #endif
>  
>  static unsigned int
> -__lookup(struct radix_tree_root *root, void **results, unsigned long index,
> +__lookup(struct radix_tree_root *root, void ***results, unsigned long index,
>  	unsigned int max_items, unsigned long *next_index)
>  {
> +	unsigned long i;
>  	unsigned int nr_found = 0;
>  	unsigned int shift;
> -	unsigned int height = root->height;
> +	unsigned int height;
>  	struct radix_tree_node *slot;
>  
> -	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
>  	slot = root->rnode;
> +	if (!slot)
> +		goto out;
> +	height = slot->height;
> +	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
>  
> -	while (height > 0) {
> -		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
> -
> -		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
> +	for (;;) {
> +		for (i = (index >> shift) & RADIX_TREE_MAP_MASK;
> +						i < RADIX_TREE_MAP_SIZE; i++) {
>  			if (slot->slots[i] != NULL)
>  				break;
>  			index &= ~((1UL << shift) - 1);
> @@ -516,21 +539,23 @@ __lookup(struct radix_tree_root *root, v
>  		if (i == RADIX_TREE_MAP_SIZE)
>  			goto out;
>  		height--;
> -		if (height == 0) {	/* Bottom level: grab some items */
> -			unsigned long j = index & RADIX_TREE_MAP_MASK;
> -
> -			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
> -				index++;
> -				if (slot->slots[j]) {
> -					results[nr_found++] = slot->slots[j];
> -					if (nr_found == max_items)
> -						goto out;
> -				}
> -			}
> +		if (height == 0) {
> +			/* Bottom level: grab some items */
> +			break;
>  		}
>  		shift -= RADIX_TREE_MAP_SHIFT;
>  		slot = slot->slots[i];
>  	}
> +
> +	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
> +		index++;
> +		if (slot->slots[i]) {
> +			results[nr_found++] = &(slot->slots[i]);
> +			if (nr_found == max_items)
> +				goto out;
> +		}
> +	}
> +
>  out:
>  	*next_index = index;
>  	return nr_found;
> @@ -558,6 +583,43 @@ radix_tree_gang_lookup(struct radix_tree
>  	unsigned int ret = 0;
>  
>  	while (ret < max_items) {
> +		unsigned int nr_found, i;
> +		unsigned long next_index;	/* Index of next search */
> +
> +		if (cur_index > max_index)
> +			break;
> +		nr_found = __lookup(root, (void ***)results + ret, cur_index,
> +					max_items - ret, &next_index);
> +		for (i = 0; i < nr_found; i++)
> +			results[ret + i] = *(((void ***)results)[ret + i]);
> +		ret += nr_found;
> +		if (next_index == 0)
> +			break;
> +		cur_index = next_index;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(radix_tree_gang_lookup);
> +
> +/**
> + *	radix_tree_gang_lookup_slot - perform multiple lookup on a radix tree
> + *	@root:		radix tree root
> + *	@results:	where the results of the lookup are placed
> + *	@first_index:	start the lookup from this key
> + *	@max_items:	place up to this many items at *results
> + *
> + *	Same as radix_tree_gang_lookup, but returns an array of pointers
> + *	(slots) to the stored items instead of the items themselves.
> + */
> +unsigned int
> +radix_tree_gang_lookup_slot(struct radix_tree_root *root, void ***results,
> +			unsigned long first_index, unsigned int max_items)
> +{
> +	const unsigned long max_index = radix_tree_maxindex(root->height);
> +	unsigned long cur_index = first_index;
> +	unsigned int ret = 0;
> +
> +	while (ret < max_items) {
>  		unsigned int nr_found;
>  		unsigned long next_index;	/* Index of next search */
>  
> @@ -572,7 +634,8 @@ radix_tree_gang_lookup(struct radix_tree
>  	}
>  	return ret;
>  }
> -EXPORT_SYMBOL(radix_tree_gang_lookup);
> +EXPORT_SYMBOL(radix_tree_gang_lookup_slot);
> +
>  
>  /*
>   * FIXME: the two tag_get()s here should use find_next_bit() instead of
> Index: linux-2.6/include/linux/radix-tree.h
> ===================================================================
> --- linux-2.6.orig/include/linux/radix-tree.h
> +++ linux-2.6/include/linux/radix-tree.h
> @@ -51,6 +51,9 @@ void *radix_tree_delete(struct radix_tre
>  unsigned int
>  radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
>  			unsigned long first_index, unsigned int max_items);
> +unsigned int
> +radix_tree_gang_lookup_slot(struct radix_tree_root *root, void ***results,
> +			unsigned long first_index, unsigned int max_items);
>  int radix_tree_preload(int gfp_mask);
>  void radix_tree_init(void);
>  void *radix_tree_tag_set(struct radix_tree_root *root,

