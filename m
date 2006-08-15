Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965328AbWHOJVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965328AbWHOJVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbWHOJVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:21:33 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:44960 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965328AbWHOJVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:21:32 -0400
Date: Tue, 15 Aug 2006 13:20:56 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060815092055.GA1092@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <20060815002724.a635d775.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060815002724.a635d775.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 15 Aug 2006 13:20:58 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 12:27:24AM -0700, Andrew Morton (akpm@osdl.org) wrote:
> On Mon, 14 Aug 2006 15:04:03 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > 
> > Design of allocator allows to map all node's pages into userspace thus
> > allows to have true zero-copy support for both sending and receiving
> > dataflows.
> 
> If the pages can be order-1 or higher then they'll need to be compound
> pages so that the kernel gets the page's refcounting correct if the user
> tries to perform direct-io against them (get_user_pages()).
> 
> And compound pages use ->lru for internal metadata - see prep_compound_page().

It is tricky - pages are not marked as compound, I split them manually
into 0-order ones after they were allocated as higher order.
I do that exactly for purpose of freein lru list.

> > +static avl_t avl_node_id[NR_CPUS];
> > +static struct avl_node **avl_node_array[NR_CPUS];
> > +static struct list_head *avl_container_array[NR_CPUS];
> > +static struct avl_node *avl_root[NR_CPUS];
> > +static struct avl_free_list *avl_free_list_head[NR_CPUS];
> > +static spinlock_t avl_free_lock[NR_CPUS];
> 
> There will be heaps of cacheline pingpong accessing these arrays.  I'd have
> though that
> 
> static struct whatever {
> 	avl_t avl_node_id;
> 	struct avl_node **avl_node_array;
> 	struct list_head *avl_container_array;
> 	struct avl_node *avl_root;
> 	struct avl_free_list *avl_free_list_head;
> 	spinlock_t avl_free_lock;
> } __cacheline_aligned_in_smp whatevers[NR_CPUS];
> 
> would be better.

Yes, I is better.

> > +typedef unsigned long value_t;
> > +typedef u16 avl_t;
> 
> Do we really need the typedefs?
> 
> If so, these have too generic names for globally-scoped identifiers.

It came from AVL tre implementation - generally it is better to operate
with one type so it could be replaced easily - for example is someone
will decide to use it not only for networking and thus 16bits will not
be enough one should only change above typedef.

> > +static inline struct avl_node *avl_get_node(avl_t id, int cpu)
> > +{
> > +	avl_t idx, off;
> > +
> > +	if (id >= AVL_NODE_NUM)
> > +		return NULL;
> > +	
> > +	idx = id/AVL_NODES_ON_PAGE;
> > +	off = id%AVL_NODES_ON_PAGE;
> > +
> > +	return &(avl_node_array[cpu][idx][off]);
> > +}
> 
> Too big to inline.

If you think so...

> > +static inline struct avl_node *avl_get_node_ptr(unsigned long ptr)
> > +{
> > +	struct page *page = virt_to_page(ptr);
> > +	struct avl_node *node = (struct avl_node *)(page->lru.next);
> > +
> > +	return node;
> > +}
> 
> Probably OK.
> 
> > +static inline void avl_set_node_ptr(unsigned long ptr, struct avl_node *node, int order)
> > +{
> > +	int nr_pages = 1<<order, i;
> > +	struct page *page = virt_to_page(ptr);
> > +	
> > +	for (i=0; i<nr_pages; ++i) {
> > +		page->lru.next = (void *)node;
> > +		page++;
> > +	}
> > +}
> 
> Too big

Ugh, it has a loop, will uninline.

> > +static inline int avl_get_cpu_ptr(unsigned long ptr)
> > +{
> > +	struct page *page = virt_to_page(ptr);
> > +	int cpu = (int)(unsigned long)(page->lru.prev);
> > +
> > +	return cpu;
> > +}
> 
> Too big

I think it is ok - it the same as avl_get_cpu_ptr() above only return
value differs.

> > +static inline void avl_set_cpu_ptr(unsigned long ptr, int cpu, int order)
> > +{
> > +	int nr_pages = 1<<order, i;
> > +	struct page *page = virt_to_page(ptr);
> > +			
> > +	for (i=0; i<nr_pages; ++i) {
> > +		page->lru.prev = (void *)(unsigned long)cpu;
> > +		page++;
> > +	}
> > +}
> 
> Too big

Yep.

> > +static inline enum avl_balance avl_compare(struct avl_node *a, struct avl_node *b)
> > +{
> > +	if (a->value == b->value)
> > +		return AVL_BALANCED;
> > +	else if (a->value > b->value)
> > +		return AVL_RIGHT;
> > +	else
> > +		return AVL_LEFT;
> > +}
> 
> Might be too big.
> 
> > +static inline void avl_set_left(struct avl_node *node, avl_t val)
> > +{
> > +	node->left = val;
> > +}
> > +
> > +static inline void avl_set_right(struct avl_node *node, avl_t val)
> > +{
> > +	node->right = val;
> > +}
> > +
> > +static inline void avl_set_parent(struct avl_node *node, avl_t val)
> > +{
> > +	node->parent = val;
> > +}
> 
> Not too big ;)

That's good :)

> > +static inline void avl_rotate_complete(struct avl_node *parent, struct avl_node *node, int cpu)
> > +{
> > +	avl_set_parent(node, parent->parent);
> > +	if (parent->parent != AVL_NODE_EMPTY) {
> > +		if (parent->pos == AVL_RIGHT)
> > +			avl_set_right(avl_get_node(parent->parent, cpu), node->id);
> > +		else
> > +			avl_set_left(avl_get_node(parent->parent, cpu), node->id);
> > +	}
> > +	avl_set_parent(parent, node->id);
> > +}
> > +
> > +static inline void avl_ll(struct avl_node *node, int cpu)
> > +{
> > +	struct avl_node *parent = avl_get_node(node->parent, cpu);
> > +	struct avl_node *left = avl_get_node(node->left, cpu);
> > +	
> > +	avl_rotate_complete(parent, node, cpu);
> > +	avl_set_left(node, parent->id);
> > +	node->pos = parent->pos;
> > +	parent->pos = AVL_LEFT;
> > +	if (!left) {
> > +		avl_set_right(parent, AVL_NODE_EMPTY);
> > +	} else {
> > +		avl_set_parent(left, parent->id);
> > +		left->pos = AVL_RIGHT;
> > +		avl_set_right(parent, left->id);
> > +	}
> > +}
> > +
> > +static inline void avl_rr(struct avl_node *node, int cpu)
> > +{
> > +	struct avl_node *parent = avl_get_node(node->parent, cpu);
> > +	struct avl_node *right = avl_get_node(node->right, cpu);
> > +
> > +	avl_rotate_complete(parent, node, cpu);
> > +	avl_set_right(node, parent->id);
> > +	node->pos = parent->pos;
> > +	parent->pos = AVL_RIGHT;
> > +	if (!right)
> > +		avl_set_left(parent, AVL_NODE_EMPTY);
> > +	else {
> > +		avl_set_parent(right, parent->id);
> > +		right->pos = AVL_LEFT;
> > +		avl_set_left(parent, right->id);
> > +	}
> > +}
> > +
> > +static inline void avl_rl_balance(struct avl_node *node, int cpu)
> > +{
> > +	avl_rr(node, cpu);
> > +	avl_ll(node, cpu);
> > +}
> > +
> > +static inline void avl_lr_balance(struct avl_node *node, int cpu)
> > +{
> > +	avl_ll(node, cpu);
> > +	avl_rr(node, cpu);
> > +}
> > +
> > +static inline void avl_balance_single(struct avl_node *node, struct avl_node *parent)
> > +{
> > +	node->balance = parent->balance = AVL_BALANCED;
> > +}
> > +
> > +static inline void avl_ll_balance(struct avl_node *node, int cpu)
> > +{
> > +	struct avl_node *parent = avl_get_node(node->parent, cpu);
> > +
> > +	avl_ll(node, cpu);
> > +	avl_balance_single(node, parent);
> > +}
> > +
> > +static inline void avl_rr_balance(struct avl_node *node, int cpu)
> > +{
> > +	struct avl_node *parent = avl_get_node(node->parent, cpu);
> > +
> > +	avl_rr(node, cpu);
> > +	avl_balance_single(node, parent);
> > +}
> 
> All way too big.
> 
> (Yes, avl_rr_balance() has a single callsite, as does avl_ll_balance(), but
> they each have separate copies of the very large avl_rr())

Ok, it should be even better for icache to uninline them.

> > +	/*
> > +	 * NTA steals pages and never return them back to the system.
> > +	 */
> 
> That's the only code comment in this entire 882-line file?

:) understood.

-- 
	Evgeniy Polyakov
