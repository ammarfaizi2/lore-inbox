Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVKJFYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVKJFYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 00:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKJFYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 00:24:24 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:31374 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751093AbVKJFYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 00:24:24 -0500
Date: Thu, 10 Nov 2005 13:25:38 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 04/16] radix-tree: look-aside cache
Message-ID: <20051110052538.GA6585@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20051109134938.757187000@localhost.localdomain> <20051109141448.974675000@localhost.localdomain> <437286BD.4000107@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437286BD.4000107@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Nov 10, 2005 at 10:31:09AM +1100, Nick Piggin wrote:
> Does this cache add much performance compared with simple repeated
> lookups? If the access patterns are highly local, the top of the
> radix tree should be in cache.
It just guarantees constant lookup time for small/large files.

My context based read-ahead code has been quite tricky just to avoid many radix
tree lookups. I made it much simple and robust in the recent versions by just
scanning through the cache. With the help of look-aside cache, the performance
remains comparable with the tricky one. Sorry, the oprofile log was overwrote.
But if you do need some numbers about the cache, I'll make one.

> 
> I worry that it is a fair bit of extra complexity for something
> slow like the IO path - however I haven't looked at how you use the
> cache.
Most are one-liners, except radix_tree_cache_lookup_node(). Which is about 10
lines. Currently it is always called with a constant @level, where inline can
help. Only several speed critical functions call it, so I guess icache misses
will not be a big problem. But I do feel it ugly to expose internal data
structures in .h :(
> 
> >Most of them are best inlined, so some macros/structs in .c are moved into 
> >.h.
> >
> 
> I would not inline them. You'd find that the extra icache misses
> that costs outweighs the improvements for larger functions.
> 
> >+
> >+struct radix_tree_node {
> >+	unsigned int	count;
> >+	void		*slots[RADIX_TREE_MAP_SIZE];
> >+	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
> >+};
> >+
> 
> Would be much nicer if this weren't declared in the header file, so
> people don't start trying to use the nodes where they shouldn't.
> This ought to be possible after uninlining a couple of things.
Ok. I'll try it.
> 
> > struct radix_tree_root {
> > 	unsigned int		height;
> > 	gfp_t			gfp_mask;
> > 	struct radix_tree_node	*rnode;
> > };
> > 
> >+/*
> >+ * Support access patterns with strong locality.
> >+ */
> 
> Do you think you could provide a simple 'use case' for an overview
> of how you use the cache and what calls to make?
Ok, here it is:

 void func() {
+       struct radix_tree_cache cache;
+
+       radix_tree_cache_init(&cache);
        read_lock_irq(&mapping->tree_lock);
        for(;;) {
-               page = radix_tree_lookup(&mapping->page_tree, index);
+               page = radix_tree_cache_lookup(&mapping->page_tree, &cache, index);
        }
        read_unlock_irq(&mapping->tree_lock);
 }

> 
> >+struct radix_tree_cache {
> >+	unsigned long first_index;
> >+	struct radix_tree_node *tree_node;
> >+};
> >+
> 
> >+static inline void radix_tree_cache_init(struct radix_tree_cache *cache)
> >+{
> >+	cache->first_index = 0x77;
> >+	cache->tree_node = NULL;
> >+}
> >+
> >+static inline int radix_tree_cache_size(struct radix_tree_cache *cache)
> >+{
> >+	return RADIX_TREE_MAP_SIZE;
> >+}
> >+
> >+static inline int radix_tree_cache_count(struct radix_tree_cache *cache)
> >+{
> >+	if (cache->first_index != 0x77)
> >+		return cache->tree_node->count;
> >+	else
> >+		return 0;
> >+}
> >+
> 
> What's 0x77 for? And what happens if your cache gets big enough that
> the first index is 0x77?
Sorry for the ugly code. It is better written as:
        if (cache->first_index & RADIX_TREE_MAP_MASK)
                return 0;
        else
                return cache->tree_node->count;

The 0x77 is an invalid value that will be detected in radix_tree_cache_lookup_node():

        mask = ~((RADIX_TREE_MAP_SIZE << (level * RADIX_TREE_MAP_SHIFT)) - 1);

--->    if ((index & mask) == cache->first_index)
                return cache->tree_node->slots[i];

        node = radix_tree_lookup_node(root, index, level + 1);

It can be initialized to 1, 0xFF, or any i that (i & RADIX_TREE_MAP_MASK != 0).
I'd better just init it as RADIX_TREE_MAP_MASK.

Regards,
Wu
