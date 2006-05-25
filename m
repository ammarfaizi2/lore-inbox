Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWEYKXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWEYKXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWEYKXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:23:48 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:39903 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965106AbWEYKXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:23:47 -0400
Message-ID: <348552623.15442@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 18:23:46 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: + radixtree-look-aside-cache.patch added to -mm tree]
Message-ID: <20060525102346.GD4996@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <44754472.1030906@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44754472.1030906@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 03:45:22PM +1000, Nick Piggin wrote:
> >Introduce a set of lookup functions to radix tree for the read-ahead logic.
> >Other access patterns with high locality may also benefit from them.
> >
> 
> Your radix tree stuff doesn't _seem_ like a bad idea, but I would be
> much more comfortable if it was in a completely different patchset.
> Ie. implement your readahead stuff using the current radix-tree API,
> then show eg. 15% CPU reduction on workload X when using look-aside
> cache for blah.
> 
> It is more complexity, and the intention might be nice, but it might
> not actually help as much (or at all) as you think: eg. it might
> increase cache footprint and actually slow things down.

I have oprofile numbers against the look-aside cache:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113231595618167&w=2

Indeed, there's not much gain. It's ok to remove it.

> >
> >- radix_tree_lookup_parent(root, index, level)
> >	Perform partial lookup, return the @level'th parent of the slot at
> >	@index.
> >
> >- radix_tree_cache_xxx()
> >	Init/Query the cache.
> >- radix_tree_cache_lookup(root, cache, index)
> >	Perform lookup with the aid of a look-aside cache.
> >	For sequential scans, it has a time complexity of 64*O(1) + 
> >	1*O(logN).
> >
> >	Typical usage:
> >
> >  void func() {
> > +       struct radix_tree_cache cache;
> > +
> > +       radix_tree_cache_init(&cache);
> >         read_lock_irq(&mapping->tree_lock);
> >         for(;;) {
> > -               page = radix_tree_lookup(&mapping->page_tree, index);
> > +               page = radix_tree_cache_lookup(&mapping->page_tree, 
> > &cache, index);
> >         }
> >         read_unlock_irq(&mapping->tree_lock);
> >  }
> >
> 
> Still not really convinced with this. I can't see why you shouldn't just
> use a gang lookup or "scan" type function. Let's take your real example:
> 
> +static pgoff_t find_segtail_backward(struct address_space *mapping,
> +					pgoff_t index, unsigned long 
> max_scan)
> +{
> +	struct radix_tree_cache cache;
> +	struct page *page;
> +	pgoff_t origin;
> +
> +	origin = index;
> +	if (max_scan > index)
> +		max_scan = index;
> +
> +	cond_resched();
> 
> BTW. cond_resched here? It should normally be in the caller if they expect
> really high latency.

Right, will remove it.

> +	radix_tree_cache_init(&cache);
> +	read_lock_irq(&mapping->tree_lock);
> +	for (; origin - index < max_scan;) {
> +		page = radix_tree_cache_lookup(&mapping->page_tree,
> +							&cache, --index);
> +		if (page) {
> +			read_unlock_irq(&mapping->tree_lock);
> +			return index + 1;
> +		}
> +	}
> +	read_unlock_irq(&mapping->tree_lock);
> 
> 
> This should just be a scan_page_backward (not scan_hole), should it not?
> I didn't find other usages of the radix tree cache after a quick scan, but
> if you point them out, let's see if they can't be replaced with something
> else.

Sure ok. The radix tree cache is trivial to remove.

However this function is not performance critical, so I'd like to
rest on the poor man's scan_page_backward() implementation :)

> >int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
> >-void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
> >-void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
> >+void *radix_tree_lookup_parent(struct radix_tree_root *, unsigned long,
> >+							unsigned int);
> >+void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned 
> >long);
> >void *radix_tree_delete(struct radix_tree_root *, unsigned long);
> >+unsigned int radix_tree_cache_count(struct radix_tree_cache *cache);
> >+void *radix_tree_cache_lookup_parent(struct radix_tree_root *root,
> >+				struct radix_tree_cache *cache,
> >+				unsigned long index, unsigned int level);
> >
> 
> Nitpick: I don't really like the name lookup_parent. No better suggestions
> though ;)
> 
> But the function seems really nasty for an exported API: callers should
> have no concept of the internals of the data structure. If you just need
> it to implement these inline functions, maybe prepend it with a double
> underscore.

It was once named lookup_node, and was distasted by Christoph Lameter.
Maybe we can settle with __radix_tree_lookup_parent() and only use it
inside radix-tree.c/.h.

> >+void *radix_tree_lookup_parent(struct radix_tree_root *root,
> >+				unsigned long index, unsigned int level)
> >{
> >	unsigned int height, shift;
> >-	struct radix_tree_node **slot;
> >+	struct radix_tree_node *slot;
> >
> >	height = root->height;
> >
> >	if (index > radix_tree_maxindex(height))
> >		return NULL;
> >
> >-	if (height == 0 && root->rnode)
> >-		return (void **)&root->rnode;
> >-
> >	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
> >-	slot = &root->rnode;
> >+	slot = root->rnode;
> >
> >
> 
> This couldn't work: we have direct data now in -mm (unless that's been 
> thrown out).

Should be ok: the while loop below will be skipped if height == 0.

> >-	while (height > 0) {
> >-		if (*slot == NULL)
> >+	while (height > level) {
> >+		if (slot == NULL)
> >			return NULL;
> >
> >-		slot = (struct radix_tree_node **)
> >-			((*slot)->slots +
> >-				((index >> shift) & RADIX_TREE_MAP_MASK));
> >+		slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
> >		shift -= RADIX_TREE_MAP_SHIFT;
> >		height--;
> >	}
> >
> >-	return (void **)slot;
> >+	return slot;
> >+}

> >+EXPORT_SYMBOL(radix_tree_lookup_parent);
> >void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long 
> >index)
> >{
> >-	return __lookup_slot(root, index);
> >+	struct radix_tree_node *node;
> >+
> >+	node = radix_tree_lookup_parent(root, index, 1);
> >+	return node->slots + (index & RADIX_TREE_MAP_MASK);
> >}
> >EXPORT_SYMBOL(radix_tree_lookup_slot);
> >
> 
> radix_tree_lookup_parent can return NULL, right? Oops.

Thanks, I'm amazed that it didn't crashed my machine ;)

Regards,
Wu
