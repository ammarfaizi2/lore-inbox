Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbWFVBtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbWFVBtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWFVBtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:49:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:45704 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030495AbWFVBtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:49:20 -0400
Date: Wed, 21 Jun 2006 18:49:49 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul McKenney <Paul.McKenney@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 3/3] radix-tree: RCU lockless readside
Message-ID: <20060622014949.GA2202@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060408134635.22479.79269.sendpatchset@linux.site> <20060408134707.22479.33814.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408134707.22479.33814.sendpatchset@linux.site>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 04:48:48PM +0200, Nick Piggin wrote:

Pretty close, but some questions and comments interspersed.
Search for empty lines to find them.

Rough notes from review process at the end, in case anyone has
insomnia or something.

						Thanx, Paul

> Make radix tree lookups safe to be performed without locks. Readers
> are protected against nodes being deleted by using RCU based freeing.
> Readers are protected against new node insertion by using memory
> barriers to ensure the node itself will be properly written before it
> is visible in the radix tree.
> 
> Each radix tree node keeps a record of their height (above leaf
> nodes). This height does not change after insertion -- when the radix
> tree is extended, higher nodes are only inserted in the top. So a
> lookup can take the pointer to what is *now* the root node, and
> traverse down it even if the tree is concurrently extended and this
> node becomes a subtree of a new root.
> 
> "Direct" pointers (tree height of 0, where root->rnode points directly
> to the data item) are handled by using the low bit of the pointer to
> signal whether rnode is a direct pointer or a pointer to a radix tree
> node.
> 
> When a reader wants to traverse the next branch, they will take a
> copy of the pointer. This pointer will be either NULL (and the branch
> is empty) or non-NULL (and will point to a valid node).
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Index: linux-2.6/lib/radix-tree.c
> ===================================================================
> --- linux-2.6.orig/lib/radix-tree.c
> +++ linux-2.6/lib/radix-tree.c
> @@ -30,6 +30,7 @@
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
>  	unsigned long	tags[RADIX_TREE_MAX_TAGS][RADIX_TREE_TAG_LONGS];
>  };
> @@ -100,13 +103,21 @@ radix_tree_node_alloc(struct radix_tree_
>  			rtp->nr--;
>  		}
>  	}
> +	BUG_ON(radix_tree_is_direct_ptr(ret));
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
> @@ -222,11 +233,12 @@ static int radix_tree_extend(struct radi
>  	}
>  
>  	do {
> +		unsigned int newheight;
>  		if (!(node = radix_tree_node_alloc(root)))
>  			return -ENOMEM;
>  
>  		/* Increase the height.  */
> -		node->slots[0] = root->rnode;
> +		node->slots[0] = radix_tree_direct_to_ptr(root->rnode);
>  
>  		/* Propagate the aggregated tag info into the new root */
>  		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
> @@ -234,9 +246,11 @@ static int radix_tree_extend(struct radi
>  				tag_set(node, tag, 0);
>  		}
>  
> +		newheight = root->height+1;
> +		node->height = newheight;
>  		node->count = 1;
> -		root->rnode = node;
> -		root->height++;
> +		rcu_assign_pointer(root->rnode, node);
> +		root->height = newheight;
>  	} while (height > root->height);
>  out:
>  	return 0;
> @@ -258,6 +272,8 @@ int radix_tree_insert(struct radix_tree_
>  	int offset;
>  	int error;
>  
> +	BUG_ON(radix_tree_is_direct_ptr(item));
> +
>  	/* Make sure the tree is high enough.  */
>  	if (index > radix_tree_maxindex(root->height)) {
>  		error = radix_tree_extend(root, index);
> @@ -275,11 +291,12 @@ int radix_tree_insert(struct radix_tree_
>  			/* Have to add a child node.  */
>  			if (!(slot = radix_tree_node_alloc(root)))
>  				return -ENOMEM;
> +			slot->height = height;
>  			if (node) {
> -				node->slots[offset] = slot;
> +				rcu_assign_pointer(node->slots[offset], slot);
>  				node->count++;
>  			} else
> -				root->rnode = slot;
> +				rcu_assign_pointer(root->rnode, slot);
>  		}
>  
>  		/* Go a level down */
> @@ -295,11 +312,11 @@ int radix_tree_insert(struct radix_tree_
>  
>  	if (node) {
>  		node->count++;
> -		node->slots[offset] = item;
> +		rcu_assign_pointer(node->slots[offset], item);
>  		BUG_ON(tag_get(node, 0, offset));
>  		BUG_ON(tag_get(node, 1, offset));
>  	} else {
> -		root->rnode = item;
> +		rcu_assign_pointer(root->rnode, radix_tree_ptr_to_direct(item));
>  		BUG_ON(root_tag_get(root, 0));
>  		BUG_ON(root_tag_get(root, 1));
>  	}
> @@ -308,49 +325,51 @@ int radix_tree_insert(struct radix_tree_
>  }
>  EXPORT_SYMBOL(radix_tree_insert);
>  
> -static inline void **__lookup_slot(struct radix_tree_root *root,
> -				   unsigned long index)
> +/**
> + *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
> + *	@root:		radix tree root
> + *	@index:		index key
> + *
> + *	Lookup the slot corresponding to the position @index in the radix tree
> + *	@root. This is useful for update-if-exists operations.
> + *
> + *	This function cannot be called under rcu_read_lock, it must be
> + *	excluded from writers, as must the returned slot.
> + */
> +void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
>  {
>  	unsigned int height, shift;
> -	struct radix_tree_node **slot;
> -
> -	height = root->height;
> +	struct radix_tree_node *node, **slot;
>  
> -	if (index > radix_tree_maxindex(height))
> +	node = rcu_dereference(root->rnode);

If writers are excluded, why is the rcu_dereference() required?

> +	if (node == NULL)
>  		return NULL;
>  
> -	if (height == 0 && root->rnode)
> +	if (radix_tree_is_direct_ptr(node)) {
> +		if (index > 0)
> +			return NULL;
>  		return (void **)&root->rnode;
> +	}
> +
> +	height = node->height;
> +	if (index > radix_tree_maxindex(height))
> +		return NULL;
>  
>  	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
> -	slot = &root->rnode;
>  
> -	while (height > 0) {
> -		if (*slot == NULL)
> +	do {
> +		slot = (struct radix_tree_node **)
> +			(node->slots + ((index>>shift) & RADIX_TREE_MAP_MASK));
> +		node = rcu_dereference(*slot);

If writers are excluded, why is the rcu_dereference() required?

> +		if (node == NULL)
>  			return NULL;
>  
> -		slot = (struct radix_tree_node **)
> -			((*slot)->slots +
> -				((index >> shift) & RADIX_TREE_MAP_MASK));
>  		shift -= RADIX_TREE_MAP_SHIFT;
>  		height--;
> -	}
> +	} while (height > 0);
>  
>  	return (void **)slot;
>  }
> -
> -/**
> - *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
> - *	@root:		radix tree root
> - *	@index:		index key
> - *
> - *	Lookup the slot corresponding to the position @index in the radix tree
> - *	@root. This is useful for update-if-exists operations.
> - */
> -void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
> -{
> -	return __lookup_slot(root, index);
> -}
>  EXPORT_SYMBOL(radix_tree_lookup_slot);
>  
>  /**
> @@ -359,13 +378,45 @@ EXPORT_SYMBOL(radix_tree_lookup_slot);
>   *	@index:		index key
>   *
>   *	Lookup the item at the position @index in the radix tree @root.
> + *
> + *	This function can be called under rcu_read_lock, however the caller
> + *	must manage lifetimes of leaf nodes (eg. RCU may also be used to free
> + *	them safely). No RCU barriers are required to access or modify the
> + *	returned item, however.
>   */
>  void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
>  {
> -	void **slot;
> +	unsigned int height, shift;
> +	struct radix_tree_node *node, **slot;
> +
> +	node = rcu_dereference(root->rnode);
> +	if (node == NULL)
> +		return NULL;
> +
> +	if (radix_tree_is_direct_ptr(node)) {
> +		if (index > 0)
> +			return NULL;
> +		return radix_tree_direct_to_ptr(node);
> +	}
> +
> +	height = node->height;
> +	if (index > radix_tree_maxindex(height))
> +		return NULL;
>  
> -	slot = __lookup_slot(root, index);
> -	return slot != NULL ? *slot : NULL;
> +	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
> +
> +	do {
> +		slot = (struct radix_tree_node **)
> +			(node->slots + ((index>>shift) & RADIX_TREE_MAP_MASK));
> +		node = rcu_dereference(*slot);
> +		if (node == NULL)
> +			return NULL;
> +
> +		shift -= RADIX_TREE_MAP_SHIFT;
> +		height--;
> +	} while (height > 0);
> +
> +	return node;
>  }
>  EXPORT_SYMBOL(radix_tree_lookup);
>  

radix_tree_tag_set() needs a comment saying that updates must be
excluded.  Might be obvious to some, but...

Ditto for radix_tree_tag_clear().

radix_tree_tag_get() either needs a comment saying that updates must
be excluded, or needs rcu_dereference() around the access of root->rnode
near line 565.  Yes, this is test scaffolding, but...

> @@ -542,29 +593,25 @@ EXPORT_SYMBOL(radix_tree_tag_get);
>  #endif
>  
>  static unsigned int
> -__lookup(struct radix_tree_root *root, void **results, unsigned long index,
> +__lookup(struct radix_tree_node *slot, void **results, unsigned long index,
>  	unsigned int max_items, unsigned long *next_index)
>  {

Not clear on why common code isn't shared more widely among the various
lookups...  Not -exactly- the same, I know, but...

>  	unsigned int nr_found = 0;
>  	unsigned int shift, height;
> -	struct radix_tree_node *slot;
>  	unsigned long i;
>  
> -	height = root->height;
> -	if (height == 0) {
> -		if (root->rnode && index == 0)
> -			results[nr_found++] = root->rnode;
> +	height = slot->height;
> +	if (height == 0)
>  		goto out;
> -	}
> -
>  	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
> -	slot = root->rnode;
>  
>  	for ( ; height > 1; height--) {
> +		struct radix_tree_node *__s;
>  
>  		for (i = (index >> shift) & RADIX_TREE_MAP_MASK ;
>  				i < RADIX_TREE_MAP_SIZE; i++) {
> -			if (slot->slots[i] != NULL)
> +			__s = rcu_dereference(slot->slots[i]);
> +			if (__s != NULL)
>  				break;
>  			index &= ~((1UL << shift) - 1);
>  			index += 1UL << shift;
> @@ -575,14 +622,16 @@ __lookup(struct radix_tree_root *root, v
>  			goto out;
>  
>  		shift -= RADIX_TREE_MAP_SHIFT;
> -		slot = slot->slots[i];
> +		slot = __s;
>  	}
>  
>  	/* Bottom level: grab some items */
>  	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
> +		struct radix_tree_node *node;
>  		index++;
> -		if (slot->slots[i]) {
> -			results[nr_found++] = slot->slots[i];
> +		node = slot->slots[i];
> +		if (node) {
> +			results[nr_found++] = node;
>  			if (nr_found == max_items)
>  				goto out;
>  		}
> @@ -604,28 +653,54 @@ out:
>   *	*@results.
>   *
>   *	The implementation is naive.
> + *
> + *	Like radix_tree_lookup, radix_tree_gang_lookup may be called under
> + *	rcu_read_lock. In this case, rather than the returned results being
> + *	an atomic snapshot of the tree at a single point in time, the semantics
> + *	of an RCU protected gang lookup are as though multiple radix_tree_lookups
> + *	have been issued in individual locks, and results stored in 'results'.
>   */
>  unsigned int
>  radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
>  			unsigned long first_index, unsigned int max_items)
>  {
> -	const unsigned long max_index = radix_tree_maxindex(root->height);
> +	unsigned long max_index;
> +	struct radix_tree_node *node;
>  	unsigned long cur_index = first_index;
> -	unsigned int ret = 0;
> +	unsigned int ret;
> +
> +	node = rcu_dereference(root->rnode);
> +	if (!node)
> +		return 0;
> +
> +	if (radix_tree_is_direct_ptr(node)) {
> +		if (first_index > 0)
> +			return 0;
> +		results[0] = radix_tree_direct_to_ptr(node);
> +		ret = 1;
> +		goto out;
> +	}
>  
> +	max_index = radix_tree_maxindex(node->height);
> +
> +	ret = 0;
>  	while (ret < max_items) {
>  		unsigned int nr_found;
>  		unsigned long next_index;	/* Index of next search */
>  
>  		if (cur_index > max_index)
>  			break;
> -		nr_found = __lookup(root, results + ret, cur_index,
> +		nr_found = __lookup(node, results + ret, cur_index,
>  					max_items - ret, &next_index);
>  		ret += nr_found;
>  		if (next_index == 0)
>  			break;
>  		cur_index = next_index;
>  	}
> +
> +out:
> +	(void)rcu_dereference(results); /* single barrier for all results */
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(radix_tree_gang_lookup);
> @@ -635,24 +710,16 @@ EXPORT_SYMBOL(radix_tree_gang_lookup);
>   * open-coding the search.
>   */
>  static unsigned int
> -__lookup_tag(struct radix_tree_root *root, void **results, unsigned long index,
> +__lookup_tag(struct radix_tree_node *slot, void **results, unsigned long index,
>  	unsigned int max_items, unsigned long *next_index, unsigned int tag)
>  {
>  	unsigned int nr_found = 0;
>  	unsigned int shift;
> -	unsigned int height = root->height;
> -	struct radix_tree_node *slot;
> -
> -	if (height == 0) {
> -		if (root->rnode && index == 0)
> -			results[nr_found++] = root->rnode;
> -		goto out;
> -	}
> +	unsigned int height = slot->height;
>  
>  	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
> -	slot = root->rnode;
>  
> -	do {
> +	while (height > 0) {
>  		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
>  
>  		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
> @@ -683,7 +750,7 @@ __lookup_tag(struct radix_tree_root *roo
>  		}
>  		shift -= RADIX_TREE_MAP_SHIFT;
>  		slot = slot->slots[i];
> -	} while (height > 0);
> +	}
>  out:
>  	*next_index = index;
>  	return nr_found;
> @@ -707,7 +774,8 @@ radix_tree_gang_lookup_tag(struct radix_
>  		unsigned long first_index, unsigned int max_items,
>  		unsigned int tag)

Need header comment saying that pointers returned in results array
must be rcu_dereferenced() by RCU callers before use.

But would be better to just rcu_dereference() them in __lookup_tag():745.
This is zero cost on all but Alpha, and keeps the RCU effects more
localized.

Or must radix_tree_gang_lookup_tag() exclude updates?  If so, need to
say so in header comment.  Also, in this case, the rcu_dereference()
calls are unneeded.

>  {
> -	const unsigned long max_index = radix_tree_maxindex(root->height);
> +	struct radix_tree_node *node;
> +	unsigned long max_index;
>  	unsigned long cur_index = first_index;
>  	unsigned int ret = 0;
>  
> @@ -715,13 +783,27 @@ radix_tree_gang_lookup_tag(struct radix_
>  	if (!root_tag_get(root, tag))
>  		return 0;
>  
> +	node = rcu_dereference(root->rnode);
> +	if (!node)
> +		return ret;
> +
> +	if (radix_tree_is_direct_ptr(node)) {
> +		if (first_index > 0)
> +			return 0;
> +		node = radix_tree_direct_to_ptr(node);
> +		results[0] = node;
> +		return 1;
> +	}
> +
> +	max_index = radix_tree_maxindex(node->height);
> +
>  	while (ret < max_items) {
>  		unsigned int nr_found;
>  		unsigned long next_index;	/* Index of next search */
>  
>  		if (cur_index > max_index)
>  			break;
> -		nr_found = __lookup_tag(root, results + ret, cur_index,
> +		nr_found = __lookup_tag(node, results + ret, cur_index,
>  					max_items - ret, &next_index, tag);
>  		ret += nr_found;
>  		if (next_index == 0)
> @@ -743,8 +825,17 @@ static inline void radix_tree_shrink(str
>  			root->rnode->count == 1 &&
>  			root->rnode->slots[0]) {
>  		struct radix_tree_node *to_free = root->rnode;
> +		void *newptr;
>  
> -		root->rnode = to_free->slots[0];
> +		/*
> +		 * this doesn't need an rcu_assign_pointer, because
> +		 * we aren't touching the object that to_free->slots[0]
> +		 * points to.
> +		 */

I found this comment to be confusing.  Suggest something like the following:

		/*
		 * We don't need rcu_assign_pointer(), since we are
		 * simply moving the node from one part of the tree
		 * to another.  If it was safe to dereference a pointer
		 * to it before, it is still safe to dereference a
		 * pointer to it afterwards.
		 */

A few more lines, but well worth it IMHO.  Someone with a clearer
understanding of the code might be able to create a more concise
comment that still gets the idea across clearly.  ;-)

> +		newptr = to_free->slots[0];
> +		if (root->height == 1)
> +			newptr = radix_tree_ptr_to_direct(newptr);
> +		root->rnode = newptr;
>  		root->height--;
>  		/* must only free zeroed nodes into the slab */
>  		tag_clear(to_free, 0, 0);
> @@ -768,6 +859,7 @@ void *radix_tree_delete(struct radix_tre

Need header comment in radix_tree_delete() saying that if the caller
also does lock-free searches, that it is the caller's responsibility
to wait a grace period (e.g., call_rcu() or synchronize_rcu()) before
freeing or re-using the removed item.  Otherwise, people will naturally
assume that radix_tree_delete() took care of this detail for them.

For that matter, should radix_tree_delete() do a synchronize_rcu()?
My belief is "no", since radix_tree_delete() has no way of knowing whether
this particular tree is searched lock-free.  One option would be to have
some sort of option bit in the tree telling radix_tree_delete() to do
a synchronize_rcu().  It does not make sense for radix_tree_delete()
to do call_rcu(), since it has no idea what needs to be done to free
the item removed -- it could well have arbitrary frilly data structures
linked to it that also need to be freed.

Also should add comment saying that caller is responsible for excluding
other updates to this tree.  Obvious perhaps, but better safe than sorry.

>  {
>  	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
>  	struct radix_tree_node *slot = NULL;
> +	struct radix_tree_node *to_free;
>  	unsigned int height, shift;
>  	int tag;
>  	int offset;
> @@ -778,6 +870,7 @@ void *radix_tree_delete(struct radix_tre
>  
>  	slot = root->rnode;
>  	if (height == 0 && root->rnode) {
> +		slot = radix_tree_direct_to_ptr(slot);
>  		root_tag_clear_all(root);
>  		root->rnode = NULL;
>  		goto out;
> @@ -810,8 +903,11 @@ void *radix_tree_delete(struct radix_tre
>  			radix_tree_tag_clear(root, index, tag);
>  	}
>  
> +	to_free = NULL;
>  	/* Now free the nodes we do not need anymore */
>  	while (pathp->node) {
> +		if (to_free)
> +			radix_tree_node_free(to_free);
>  		pathp->node->slots[pathp->offset] = NULL;
>  		pathp->node->count--;
>  
> @@ -822,13 +918,15 @@ void *radix_tree_delete(struct radix_tre
>  		}
>  
>  		/* Node with zero slots in use so free it */
> -		radix_tree_node_free(pathp->node);
> -
> +		to_free = pathp->node;
>  		pathp--;
> +
>  	}
>  	root_tag_clear_all(root);
>  	root->height = 0;
>  	root->rnode = NULL;
> +	if (to_free)
> +		radix_tree_node_free(to_free);
>  
>  out:
>  	return slot;
> Index: linux-2.6/include/linux/radix-tree.h
> ===================================================================
> --- linux-2.6.orig/include/linux/radix-tree.h
> +++ linux-2.6/include/linux/radix-tree.h
> @@ -22,6 +22,8 @@
>  #include <linux/sched.h>
>  #include <linux/preempt.h>
>  #include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/rcupdate.h>
>  
>  #define RADIX_TREE_MAX_TAGS 2
>  
> @@ -48,6 +50,37 @@ do {									\
>  	(root)->rnode = NULL;						\
>  } while (0)
>  
> +#define RADIX_TREE_DIRECT_PTR	1
> +
> +static inline void *radix_tree_ptr_to_direct(void *ptr)
> +{
> +	return (void *)((unsigned long)ptr | RADIX_TREE_DIRECT_PTR);
> +}
> +
> +static inline void *radix_tree_direct_to_ptr(void *ptr)
> +{
> +	return (void *)((unsigned long)ptr & ~RADIX_TREE_DIRECT_PTR);
> +}
> +
> +static inline int radix_tree_is_direct_ptr(void *ptr)
> +{
> +	return (int)((unsigned long)ptr & RADIX_TREE_DIRECT_PTR);
> +}
> +
> +static inline void *__radix_tree_deref_slot(void **slot)
> +{
> +	return rcu_dereference(radix_tree_direct_to_ptr(*slot));
> +}
> +
> +#define radix_tree_deref_slot(slot) __radix_tree_deref_slot((void **)slot)
> +
> +static inline void radix_tree_replace_slot(void **slot, void *item)
> +{
> +	BUG_ON(radix_tree_is_direct_ptr(item));
> +	rcu_assign_pointer(*slot,
> +		(void *)((unsigned long)item | ((unsigned long)*slot & RADIX_TREE_DIRECT_PTR)));
> +}
> +
>  int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
>  void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
>  void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
> Index: linux-2.6/mm/migrate.c
> ===================================================================
> --- linux-2.6.orig/mm/migrate.c
> +++ linux-2.6/mm/migrate.c
> @@ -228,7 +228,7 @@ int migrate_page_remove_references(struc
>  						page_index(page));
>  
>  	if (!page_mapping(page) || page_count(page) != nr_refs ||
> -			*radix_pointer != page) {
> +			radix_tree_deref_slot(radix_pointer) != page) {
>  		write_unlock_irq(&mapping->tree_lock);
>  		return -EAGAIN;
>  	}
> @@ -249,7 +249,7 @@ int migrate_page_remove_references(struc
>  		set_page_private(newpage, page_private(page));
>  	}
>  
> -	*radix_pointer = newpage;
> +	radix_tree_replace_slot(radix_pointer, newpage);
>  	__put_page(page);
>  	write_unlock_irq(&mapping->tree_lock);
>  

Rough notes, FYA:

o	Don't the items placed into the radix tree need to be protected
	by RCU?  If not, how does the radix tree avoid handing a pointer
	to something that has recently been removed, that the caller to
	radix_tree_delete() might have already freed?

	If so, what about nfs_inode_add_request(), which adds struct
	nfs_page to a radix tree?  This structure does not appear to
	have any sort of RCU protection:

	o	nfs_inode_remove_request() invokes radix_tree_delete(),
		drops the spinlock (optionally invoking nfs_end_data_update()),
		calls nfs_clear_request() and then nfs_release_request().

	o	nfs_clear_request() invokes page_cache_release(), which
		calls put_page, which usually calls __page_cache_release(),
		which does stuff under a spinlock that cannot include
		waiting for a grace period to elapse.  But I suppose it
		could set a flag or something...

		o	__ClearPageLRU(): just clears LRU bit.

		o	del_page_from_lru(): just deletes from lru
			list and clears page-active bits if they were
			set.

	But it seems that all radix-tree operations are under a
	spinlock, so this works after all.

	Other calls to radix_tree_delete():

	o	__remove_from_page_cache() is called under
		->tree_lock in all cases, as are other non-initialization
		uses of ->page_tree.

	And that appears to be it.  So where is Ben Herrenschmidt's
	lock-free use of radix-tree lookup?  No matter -- Ben just needs
	to make sure to RCU-protect whatever the heck he is putting into
	the radix tree if he is calling the lookup functions without
	locking.  ;-)

	Probably worth a comment to radix_tree_delete() saying that the
	caller must wait for a grace period before freeing/reusing
	the item removed from the tree!  (But only if searching done
	without locking.)

o	radix_tree_shrink() -- what is to_free?  freelist?  If so, protected
	by what lock?  OK -- the reason that rcu_assign_pointer() can be
	omitted is that we are simply moving the element unchanged from
	one location in the tree to another -- if it was safe to access
	before, it is safe to access now, no additional memory barriers
	required.

	And to_free is just a local variable -- must be blind today.  :-/

	Need to make the comment more clear.

o	RCU-protected fields:

	o	radix_tree_root->rnode
	
		o	rcu_assign_pointer() in radix_tree_extend():252.

		o	rcu_assign_pointer() in radix_tree_insert():299.

		o	rcu_assign_pointer() in radix_tree_insert():319.

		o	assignment in radix_tree_extend():245 OK
			(newly allocated).

		o	access in radix_tree_insert():284 OK, as
			presumably other writes are excluded at this
			point -- we are inserting, after all...

		o	rcu_dereference() in radix_tree_lookup_slot():344.
			But comment says that writers must be excluded,
			so not needed. @@@

		o	access in radix_tree_lookup_slot():351
			(returning a pointer to the value -- but
			the caller needs to use rcu_deference() on
			returned pointer unless the caller holds a
			lock over all searches -- currently, this
			is the case, but need a comment...  Which is
			already present: "it must be excluded from
			writers, as must the returned slot".)  OK.

		o	rcu_dereference() in radix_tree_lookup():392

		o	Address arithmetic in radix_tree_lookup():410.  OK.

		o	rcu_dereference() in radix_tree_lookup():411.

		o	access in radix_tree_tag_set():446.  @@@ Need
			comment saying that other updates must be excluded.
			Given that other updates are excluded, no need
			for rcu_dereference().

		o	access in radix_tree_tag_clear():496.  @@@ Need
			comment saying that other updates must be excluded.
			Given that other updates are excluded, no need
			for rcu_dereference().

		o	access in radix_tree_tag_get():565.  @@@ Need
			comment saying that other updates must be excluded.
			Given that other updates are excluded, no need
			for rcu_dereference().  OTOH, this is only for
			the test harness -- but -someone- will figure out
			a need for it, so might as well get it right.

			Alternatively, add an rcu_dereference().

		o	rcu_dereference() in radix_tree_gang_lookup():672.

		o	rcu_dereference() in radix_tree_gang_lookup_tag():786.

		o	access in radix_tree_shrink():825.  Presumably
			updates are excluded.  Static function, so OK.

			Ditto on line 827.  Ditto for line 838 (and
			rcu_assign_pointer() not needed because element
			is being moved unchanged rather than inserted).

		o	assignment in radix_tree_delete():871.  OK since
			updates presumably excluded, but should so indicate
			in header comment.

			Ditto on line 872, 875, 915, and 927.

		o	access in radix_tree_extend():230.  OK since
			updates presumably excluded, static function,
			so no need for header comment.

	o	radix_tree_node->slots[i]

		o	rcu_assign_pointer() in radix_tree_insert():296.

		o	assignment in radix_tree_insert():305.  OK, as
			we are presumably excluding updates.

		o	rcu_assign_pointer() in radix_tree_insert():315.

		o	access in radix_tree_shrink():826.  Presumably
			updates are excluded.  Static function, so OK.

		o	assignment in radix_tree_extend():241.  OK, since
			structure newly allocated and not yet accessible
			to other CPUs.

		o	address calculation in radix_tree_lookup_slot():362 OK.

		o	rcu_dereference() in radix_tree_lookup_slot():363.
			Writers excluded, so why needed?  @@@

		o	access in radix_tree_tag_set():455.  Already
			covered in comments for ->rnode.

		o	access in radix_tree_tag_clear():507. Already covered
			in comments for ->rnode.

		o	access in radix_tree_tag_get():587. Already covered
			in comments for ->rnode.

		o	rcu_dereference() in __lookup():613.

		o	access in __lookup():632.  OK, due to earlier
			rcu_dereference() -but- caller needs to
			rcu_dereference() the returned pointers if relying
			on RCU to protect elements.  No, the needed
			rcu_dereference() is done at the end of
			radix_tree_gang_lookup(), so OK.

			@@@ Not clear on why __lookup() isn't common code
			for radix_tree_lookup() or radix_tree_lookup_slot()...

		o	access in __lookup_tag():727.  OK, pointer comparison.

			Ditto on line 744.

		o	access in __lookup_tag():745.  OK, but caller needs
			to do rcu_dereference() before using pointer...

			@@@ radix_tree_gang_lookup_tag() needs header comment
			calling for rcu_dereference() of elements of results
			array, or need rcu_dereference() on this access.

			Or must radix_tree_gang_lookup_tag() be protected
			by lock?  If so, need to say so!

		o	access in __lookup_tag():752.  Need rcu_dereference()
			unless radix_tree_gang_lookup() is to exclude
			updates (in this latter case, the header comment
			needs to say this!).  @@@

		o	access in radix_tree_shrink():835.  OK, as we
			presumably are excluding updates.

		o	assignment in radix_tree_shrink():843: Ditto.

		o	access in radix_tree_delete():890. OK, as we are
			presumably excluding updates.

		o	assignment in radix_tree_delete():911.  Ditto.
