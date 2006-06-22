Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWFVPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWFVPpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWFVPpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:45:22 -0400
Received: from ns.suse.de ([195.135.220.2]:25568 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751650AbWFVPpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:45:21 -0400
Date: Thu, 22 Jun 2006 17:45:18 +0200
From: Nick Piggin <npiggin@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul McKenney <Paul.McKenney@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 3/3] radix-tree: RCU lockless readside
Message-ID: <20060622154518.GA23109@wotan.suse.de>
References: <20060408134635.22479.79269.sendpatchset@linux.site> <20060408134707.22479.33814.sendpatchset@linux.site> <20060622014949.GA2202@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622014949.GA2202@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 06:49:49PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 20, 2006 at 04:48:48PM +0200, Nick Piggin wrote:
> 
> Pretty close, but some questions and comments interspersed.
> Search for empty lines to find them.
> 
> Rough notes from review process at the end, in case anyone has
> insomnia or something.

Wow ;)
Thanks Paul.

> > +void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
> >  {
> >  	unsigned int height, shift;
> > -	struct radix_tree_node **slot;
> > -
> > -	height = root->height;
> > +	struct radix_tree_node *node, **slot;
> >  
> > -	if (index > radix_tree_maxindex(height))
> > +	node = rcu_dereference(root->rnode);
> 
> If writers are excluded, why is the rcu_dereference() required?

Good point, in earlier versions, radix_tree_lookup_slot was RCU-able,
but the direct-data patch ended that idea. I'll go through and clean
these out.

> radix_tree_tag_set() needs a comment saying that updates must be
> excluded.  Might be obvious to some, but...
> 
> Ditto for radix_tree_tag_clear().
> 
> radix_tree_tag_get() either needs a comment saying that updates must
> be excluded, or needs rcu_dereference() around the access of root->rnode
> near line 565.  Yes, this is test scaffolding, but...

Indeed. I mainly intended to document APIs that _are_ RCU-able,
but documented the negative for lookup_slot because it is similar
to lookup... but that's messy too.

I'll probably put a little table in radix-tree.h to summarise the
API synchronisation requirements, OK?

> 
> > @@ -542,29 +593,25 @@ EXPORT_SYMBOL(radix_tree_tag_get);
> >  #endif
> >  
> >  static unsigned int
> > -__lookup(struct radix_tree_root *root, void **results, unsigned long index,
> > +__lookup(struct radix_tree_node *slot, void **results, unsigned long index,
> >  	unsigned int max_items, unsigned long *next_index)
> >  {
> 
> Not clear on why common code isn't shared more widely among the various
> lookups...  Not -exactly- the same, I know, but...

Yeah it can get a bit tricky. It's gets a small cleanup now and again,
which is probably not a bad pace for our pagecache data structure ;)

> >  radix_tree_gang_lookup(struct radix_tree_root *root, void **results,

...

> > +out:
> > +	(void)rcu_dereference(results); /* single barrier for all results */

...

> > @@ -707,7 +774,8 @@ radix_tree_gang_lookup_tag(struct radix_
> >  		unsigned long first_index, unsigned int max_items,
> >  		unsigned int tag)
> 
> Need header comment saying that pointers returned in results array
> must be rcu_dereferenced() by RCU callers before use.
> 
> But would be better to just rcu_dereference() them in __lookup_tag():745.
> This is zero cost on all but Alpha, and keeps the RCU effects more
> localized.

Does the single rcu_dereference in radix_tree_gang_lookup look OK?

> 
> Or must radix_tree_gang_lookup_tag() exclude updates?  If so, need to
> say so in header comment.  Also, in this case, the rcu_dereference()
> calls are unneeded.

Ah indeed, that's confusing. Yes, the lookup_tag must exclude updates.
I guess I got too mechanical in my conversion... however, tag lookups
can be RCUified without a great deal of trouble, so I might take this
opportunity.

> > @@ -743,8 +825,17 @@ static inline void radix_tree_shrink(str
> >  			root->rnode->count == 1 &&
> >  			root->rnode->slots[0]) {
> >  		struct radix_tree_node *to_free = root->rnode;
> > +		void *newptr;
> >  
> > -		root->rnode = to_free->slots[0];
> > +		/*
> > +		 * this doesn't need an rcu_assign_pointer, because
> > +		 * we aren't touching the object that to_free->slots[0]
> > +		 * points to.
> > +		 */
> 
> I found this comment to be confusing.  Suggest something like the following:
> 
> 		/*
> 		 * We don't need rcu_assign_pointer(), since we are
> 		 * simply moving the node from one part of the tree
> 		 * to another.  If it was safe to dereference a pointer
> 		 * to it before, it is still safe to dereference a
> 		 * pointer to it afterwards.
> 		 */
> 
> A few more lines, but well worth it IMHO.  Someone with a clearer
> understanding of the code might be able to create a more concise
> comment that still gets the idea across clearly.  ;-)

That's pretty good, I just made a couple of tiny changes, what do you think?
                /*
                 * We don't need rcu_assign_pointer(), since we are simply
                 * moving the node from one part of the tree to another. If
                 * it was safe to dereference the old pointer to it
                 * (to_free->slots[0]), it will be safe to dereference the new
                 * one (root->rnode).
                 */

> 
> > +		newptr = to_free->slots[0];
> > +		if (root->height == 1)
> > +			newptr = radix_tree_ptr_to_direct(newptr);
> > +		root->rnode = newptr;
> >  		root->height--;
> >  		/* must only free zeroed nodes into the slab */
> >  		tag_clear(to_free, 0, 0);
> > @@ -768,6 +859,7 @@ void *radix_tree_delete(struct radix_tre
> 
> Need header comment in radix_tree_delete() saying that if the caller
> also does lock-free searches, that it is the caller's responsibility
> to wait a grace period (e.g., call_rcu() or synchronize_rcu()) before
> freeing or re-using the removed item.  Otherwise, people will naturally
> assume that radix_tree_delete() took care of this detail for them.
> 

I've tried to get that message across in the radix_tree_lookup_slot
comment, if they're using RCU lookups. Enough? I guess I'll add it
to the locking summary too.

> For that matter, should radix_tree_delete() do a synchronize_rcu()?
> My belief is "no", since radix_tree_delete() has no way of knowing whether
> this particular tree is searched lock-free.  One option would be to have
> some sort of option bit in the tree telling radix_tree_delete() to do
> a synchronize_rcu().  It does not make sense for radix_tree_delete()
> to do call_rcu(), since it has no idea what needs to be done to free
> the item removed -- it could well have arbitrary frilly data structures
> linked to it that also need to be freed.

Agreed, I think "no". In the current (locked) radix-tree, the caller is
still responsible to manage lifetimes of the data (leaf) nodes.

> 
> Also should add comment saying that caller is responsible for excluding
> other updates to this tree.  Obvious perhaps, but better safe than sorry.
> 

Yeah, I'll try to make all this a bit clearer in the locking summary.

> Rough notes, FYA:
> 
> o	Don't the items placed into the radix tree need to be protected
> 	by RCU?  If not, how does the radix tree avoid handing a pointer
> 	to something that has recently been removed, that the caller to
> 	radix_tree_delete() might have already freed?

Yes, they'll need to be protected by something. In the lockless pagecache,
they are never freed, so that isn't an issue. But other users (Ben's
irq patch perhaps, unless it uses the slot pointers directly) will have to
be careful.

> 
> 	If so, what about nfs_inode_add_request(), which adds struct
> 	nfs_page to a radix tree?  This structure does not appear to
> 	have any sort of RCU protection:

Well if they retain their existing locking, there shouldn't be a problem.
(as you say below...)

> 	But it seems that all radix-tree operations are under a
> 	spinlock, so this works after all.
> 
> 	Other calls to radix_tree_delete():
> 
> 	o	__remove_from_page_cache() is called under
> 		->tree_lock in all cases, as are other non-initialization
> 		uses of ->page_tree.
> 
> 	And that appears to be it.  So where is Ben Herrenschmidt's
> 	lock-free use of radix-tree lookup?  No matter -- Ben just needs
> 	to make sure to RCU-protect whatever the heck he is putting into
> 	the radix tree if he is calling the lookup functions without
> 	locking.  ;-)
> 
> 	Probably worth a comment to radix_tree_delete() saying that the
> 	caller must wait for a grace period before freeing/reusing
> 	the item removed from the tree!  (But only if searching done
> 	without locking.)
> 
> o	radix_tree_shrink() -- what is to_free?  freelist?  If so, protected
> 	by what lock?  OK -- the reason that rcu_assign_pointer() can be
> 	omitted is that we are simply moving the element unchanged from
> 	one location in the tree to another -- if it was safe to access
> 	before, it is safe to access now, no additional memory barriers
> 	required.
> 
> 	And to_free is just a local variable -- must be blind today.  :-/
> 
> 	Need to make the comment more clear.

Yeah, to_free is just a redundant node that is being chopped off the top
of the tree. It does go through a grace period of course, because lockless
lookups can still be referencing it.

> 
> o	RCU-protected fields:

...

Thanks very much Paul. Very thorough review.

I'll send out an incremental diff with changes.

Nick
