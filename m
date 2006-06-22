Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161458AbWFVXC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161458AbWFVXC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161457AbWFVXCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:02:55 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:54680 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161454AbWFVXCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:02:53 -0400
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	 <20060619175253.24655.96323.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 01:02:27 +0200
Message-Id: <1151017347.15744.135.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 21:52 +0100, Hugh Dickins wrote:
> On Mon, 19 Jun 2006, Peter Zijlstra wrote:

> > +static inline int is_shared_writable(unsigned int flags)
> > +{
> > +	return (flags & (VM_SHARED|VM_WRITE|VM_PFNMAP)) ==
> > +		(VM_SHARED|VM_WRITE);
> > +}
> > +
> 
> Andrew asked for the inclusion of VM_PFNMAP to be commented there,
> I don't believe that's enough: a function called "is_shared_writable"
> should be testing precisely that, or people will misuse it.
> 
> Either you change the name to "is_shared_writable_but_not_pfnmap"
> or somesuch, or you split out the VM_PFNMAP test, or you do away
> with the function and make the tests explicit inline.  As before,
> my instinctive preference is the latter: I really want to see what's
> being tested (especially in do_wp_page); but perhaps it'll just look
> too ugly all over - give it a try and see.

*sight*, thats it, explicit it will be :-)

> > +	/*
> > +	 * This is not fully correct in the light of trapping write faults
> > +	 * for writable shared mappings. However since we're going to mark
> > +	 * the page dirty anyway some few lines downward, we might as well
> > +	 * take the write fault now.
> > +	 */
> 
> I don't understand what you're getting at here: please explain,
> what is not fully correct and why?  In mail first, then we can
> decide what the comment should say, or if it should be removed.
> follow_page isn't making a pte writable, so what's the issue?

I have no idea either, I reread this part earlier today and found it one
big brainfart. It does indeed seem to do the right thing.

> > -	if (unlikely(vma->vm_flags & VM_SHARED)) {
> > +	if (unlikely(is_shared_writable(vma->vm_flags))) {
> 
> Most interesting line in the series, yes, and I'd find it
> easier to think through if it showed the flags test explicitly:
> 	if ((vma->vm_flags & (VM_SHARED|VM_WRITE|VM_PFNMAP)) ==
> 		(VM_SHARED|VM_WRITE))
> 
> Yes, Andrew, you're right it's a change in behaviour from David's
> page_mkwrite patch.  I've realized that when I was originally
> reviewing David's patch, I believed do_wp_page was mistaken to be
> doing COW on VM_SHARED areas.  But Linus has since asserted very
> forcefully that it's intentional, that ptrace poke on a VM_SHARED
> area which is currently not !VM_WRITE should COW it, so I mentioned
> that to Peter.
> 
> Has he got the test right there now?  Ummm... maybe: my brain
> exploded weeks ago.  Several strangenesses collide here, I'll
> try again tomorrow, maybe others will argue it to certainty before.

I don't think the VM_PFNMAP is needed here, but it doesn't hurt either.
Like said, I'll do explicits from now on.

> > @@ -1084,18 +1086,13 @@ munmap_back:
> >  		error = file->f_op->mmap(file, vma);
> >  		if (error)
> >  			goto unmap_and_free_vma;
> > +
> 
> Do you really need this blank line?

:-) uhu..

> > +	/*
> > +	 * Tracking of dirty pages for shared writable mappings. Do this by
> > +	 * write protecting writable pages, and mark dirty in the write fault.
> > +	 *
> > +	 * Modify vma->vm_page_prot (the default protection for new pages)
> > +	 * to this effect.
> > +	 *
> > +	 * Cannot do before because the condition depends on:
> > +	 *  - backing_dev_info having the right capabilities
> > +	 *    (set by f_op->open())
> 
> Is that so, backing_dev_info set by f_op->open()?
> And how would that be a problem here if it were so?

useless information indeed, a remnant from old times when I placed the
vm_page_prot modification between the two calls, shall remove.

> > +	 *  - vma->vm_flags being fully set
> > +	 *    (finished in f_op->mmap(), which could call remap_pfn_range())
> > +	 *
> > +	 *  Also, cannot reset vma->vm_page_prot from vma->vm_flags because
> > +	 *  f_op->mmap() can modify it.
> > +	 */
> > +	if (is_shared_writable(vm_flags) && vma->vm_file)
> > +		mapping = vma->vm_file->f_mapping;
> > +	if ((mapping && mapping_cap_account_dirty(mapping)) ||
> > +			(vma->vm_ops && vma->vm_ops->page_mkwrite))
> 
> The only way "mapping" might be set is just above.
> Wouldn't it all be clearer (though more indented) if you said
> 
> 	if (is_shared_writable(vm_flags) && vma->vm_file) {
> 		mapping = vma->vm_file->f_mapping;
> 		if ((mapping && mapping_cap_account_dirty(mapping)) ||
> 				(vma->vm_ops && vma->vm_ops->page_mkwrite)) {
> 			vma->vm_page_prot = whatever;
> 		}
> 	}
> 
> Or no need for "mapping" here at all if you change
> mapping_cap_account_dirty(vma->vm_file->f_mapping)
> to do the right thing with NULL.

Made it one big if stmt, perhaps too big, we'll see.

> 
> > +		vma->vm_page_prot =
> > +			__pgprot(pte_val
> > +				(pte_wrprotect
> > +				 (__pte(pgprot_val(vma->vm_page_prot)))));
> > +
> 
> In other mail I've suggested saving vm_page_prot above, and
> changing it here only if the driver's ->mmap did not change it.

Yes, that was a very good suggestion and has already been incorporated,
thanks.

> I remain uneasy about interfering with the permissions expected by
> strange drivers, but can't really justify my paranoia.  Certainly
> you're right to exclude VM_PFNMAPs from this interference, that's
> important; I'd be less uneasy if you also exclude VM_INSERTPAGEs,
> they're strange too - but at least they're dealing with proper struct
> pages, so should be able to handle an unexpected do_wp_page; that
> leaves the driver nopage cases, which again should be okay now you're
> (one way or another) protecting specially added vm_page_prot flags.

VM_INSERTPAGE thou shall have.

> I guess I'm just paranoid; it's irritating me that we do not have
> the right backing_dev_infos in place and having to hack around it.

Sad situation but true.

> > +static int page_mkclean_file(struct address_space *mapping, struct page *page)
> > +{
> > +	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
> > +	struct vm_area_struct *vma;
> > +	struct prio_tree_iter iter;
> > +	int ret = 0;
> > +
> > +	BUG_ON(PageAnon(page));
> > +
> > +	spin_lock(&mapping->i_mmap_lock);
> > +	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
> > +		int protect = mapping_cap_account_dirty(mapping) &&
> > +			is_shared_writable(vma->vm_flags);
> > +		ret += page_mkclean_one(page, vma, protect);
> 
> You have a good point here, one I'd completely missed: because a vma
> may have been recently mprotected !VM_WRITE, you have to check readonly
> mappings too.  Perhaps worth a comment.  But I think "is_shared_writable"
> is not the best test here: just test for VM_SHARED vmas, they're the
> only ones which can be mprotected to/from shared writable.  And then
> I think you don't need to pass down an additional "protect" argument?
> It's only being called for mapping_cap_account_dirty mappings anyway,
> isn't it?

Well, no, not anymore. I thought to make it actually do what its name
said it does: clean the page's PTEs (I am even pondering about
implementing the anonymous branch).

In that light, its now called for each page.


New patch will follow shortly since I can't seem to sleep anyway...



