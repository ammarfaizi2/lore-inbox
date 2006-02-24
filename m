Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWBXGC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWBXGC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWBXGC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:02:58 -0500
Received: from ozlabs.org ([203.10.76.45]:37776 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932653AbWBXGC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:02:57 -0500
Date: Fri, 24 Feb 2006 17:02:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: Strict page reservation for hugepage inodes
Message-ID: <20060224060224.GG28368@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
	linux-kernel@vger.kernel.org
References: <20060224002929.GB27750@localhost.localdomain> <20060223181447.65423db6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223181447.65423db6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 06:14:47PM -0800, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > These days, hugepages are demand-allocated at first fault time.
> > There's a somewhat dubious (and racy) heuristic when making a new
> > mmap() to check if there are enough available hugepages to fully
> > satisfy that mapping.
> > 
> > A particularly obvious case where the heuristic breaks down is where a
> > process maps its hugepages not as a single chunk, but as a bunch of
> > individually mmap()ed (or shmat()ed) blocks without touching and
> > instantiating the pages in between allocations.  In this case the size
> > of each block is compared against the total number of available
> > hugepages.  It's thus easy for the process to become overcommitted,
> > because each block mapping will succeed, although the total number of
> > hugepages required by all blocks exceeds the number available.  In
> > particular, this defeats such a program which will detect a mapping
> > failure and adjust its hugepage usage downward accordingly.
> > 
> > The patch below is a draft attempt to address this problem, by
> > strictly reserving a number of physical hugepages for hugepages inodes
> > which have been mapped, but not instatiated.  MAP_SHARED mappings are
> > thus "safe" - they will fail on mmap(), not later with a SIGBUS.
> > MAP_PRIVATE mappings can still SIGBUS.  (Actually SHARED mappings can
> > technically still SIGBUS, but only if the sysadmin explicitly reduces
> > the hugepage pool between mapping and instantiation)
> > 
> > This patch appears to address the problem at hand - it allows DB2 to
> > start correctly, for instance, which previously suffered the failure
> > described above.
> > 
> > I'm not terribly convinced that I don't need some more locking, but if
> > so it's far from obvious what.  VFS synchronization baffles me.
> > 
> > Signed-off-by: David Gibson <dwg@au1.ibm.com>
> > 
> > Index: working-2.6/mm/hugetlb.c
> > ===================================================================
> > --- working-2.6.orig/mm/hugetlb.c	2006-02-17 14:44:04.000000000 +1100
> > +++ working-2.6/mm/hugetlb.c	2006-02-20 14:10:24.000000000 +1100
> > @@ -20,7 +20,7 @@
> >  #include <linux/hugetlb.h>
> >  
> >  const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
> > -static unsigned long nr_huge_pages, free_huge_pages;
> > +static unsigned long nr_huge_pages, free_huge_pages, reserved_huge_pages;
> >  unsigned long max_huge_pages;
> >  static struct list_head hugepage_freelists[MAX_NUMNODES];
> >  static unsigned int nr_huge_pages_node[MAX_NUMNODES];
> > @@ -94,21 +94,87 @@ void free_huge_page(struct page *page)
> >  
> >  struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
> >  {
> > +	struct inode *inode = vma->vm_file->f_dentry->d_inode;
> >  	struct page *page;
> >  	int i;
> > +	int use_reserve = 0;
> > +
> > +	if (vma->vm_flags & VM_MAYSHARE) {
> > +		unsigned long idx;
> > +
> > +		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
> > +			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
> 
> That hurt my brain.  It's the offset into the radix tree, isn't it?  Index
> into the file in HPAGE_SIZE units?

Yes.  Comment added.

> > +		if (idx < inode->i_blocks)
> > +			use_reserve = 1;
> 
> i_blocks is being used for something, not clear what.  Needs big comment,
> please.

Done.

> > +	if (! use_reserve) {
> > +	if (!page)
> 
> no-space-after-! is preferred, please.

Ok.

> > +}
> > +
> > +int hugetlb_reserve_for_inode(struct inode *inode, unsigned long npages)
> 
> Nice comment needed here, please.  Not only for posterity - they should be
> in there up-front to aid in patch review.
> 
> > +{
> > +	struct address_space *mapping = inode->i_mapping;
> > +	unsigned long pg;
> > +	long change_in_reserve = 0;
> > +	struct page *page;
> > +	int ret = -ENOMEM;
> > +
> > +	read_lock_irq(&inode->i_mapping->tree_lock);
> > +	for (pg = inode->i_blocks; pg < npages; pg++) {
> 
> So `npages' is in fact the highest-desired pagecache index?  Or is it
> highest-desired+1?  I think it needs a better name (npages sorta implies a
> delta, not an absolute value) and it needs a comment-borne description of
> whether it's inclusive or exclusive, so we can check for offs-by-one.

It's highest-desired+1, or "number of guaranteed available pages".
Comments added, parameter name changed to 'newtotal'.

> > +		page = radix_tree_lookup(&mapping->page_tree, pg);
> > +		if (! page)
> > +			change_in_reserve++;
> > +	}
> > +
> > +	for (pg = npages; pg < inode->i_blocks; pg++) {
> > +		page = radix_tree_lookup(&mapping->page_tree, pg);
> > +		if (! page)
> > +			change_in_reserve--;
> 
> Should that be "if (page)"?  Am all confused now.

No - we're looking just for uninstantiated pages.  Instantiated pages
are already locked in, so we don't need to account them as reserved.

> > +	}
> > +	spin_lock(&hugetlb_lock);
> > +	if ((change_in_reserve > 0)
> > +	    && (change_in_reserve > (free_huge_pages-reserved_huge_pages))) {
> > +		printk("Failing:  change=%ld   free=%lu\n",
> > +		       change_in_reserve, free_huge_pages - reserved_huge_pages);
> > +		goto out;
> > +	}
> > +
> > +	reserved_huge_pages += change_in_reserve;
> > +	inode->i_blocks = npages;
> > +
> > +	ret = 0;
> > +
> > + out:
> > +	spin_unlock(&hugetlb_lock);
> > +	read_unlock_irq(&inode->i_mapping->tree_lock);
> 
> Yes, hugetlb_lock protects free_huge_pages.  And as Nick says, this lock
> coupling is undesirable.
> 
> The code does a bunch of calculations based upon a radix-tree probe.  Once
> we've dropped tree_lock, some other process can come in and make those
> calculations no-longer-true.  So, assuming that all other places which
> modify the radix-tree are also updating free_huge_pages/reserved_huge_pages
> under hugetlb_lock (are they?) then yeah, we need to hold both locks
> throughout.
> 
> hugetlb_lock is almost a tight, innermost lock.  Unfortunately we also call
> __free_pages in one spot while holding it.  The code could be reworked so
> we don't do that.

Ah.. __free_pages().. yes, so Nick wasn't dreaming that lock
constraint after all.

Urg... I've gone to dropping the lock in update_and_free_page().  I'm
pretty sure that's safe, although the fact that it won't be obvious
the lock is dropped in the called functions worries me.

> (Be aware that there are a coupld of hugetlb.c patches queued in -mm).

Ok.. I found Nick's hugepage-allocator-cleanup.patch, but nothing else
(looking for "huge" or "htlb" in patch-list).

> >  static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> >  	struct inode *inode = file->f_dentry->d_inode;
> > -	struct address_space *mapping = inode->i_mapping;
> > -	unsigned long bytes;
> >  	loff_t len, vma_len;
> >  	int ret;
> >  
> > @@ -113,13 +74,8 @@ static int hugetlbfs_file_mmap(struct fi
> >  	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
> >  		return -EINVAL;
> >  
> > -	bytes = huge_pages_needed(mapping, vma);
> > -	if (!is_hugepage_mem_enough(bytes))
> > -		return -ENOMEM;
> > -
> >  	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
> >  
> > -	mutex_lock(&inode->i_mutex);
> 
> What was that protecting?

Um.. oops.  I'm not sure, but I've no idea why I took it out.
Actually, yes I do, I think I had added an extra i_mutex section in a
draft, I guess I wasn't thinking and removed this as well when I took
it out.

> >  	file_accessed(file);
> >  	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
> >  	vma->vm_ops = &hugetlb_vm_ops;
> > @@ -129,13 +85,22 @@ static int hugetlbfs_file_mmap(struct fi
> >  	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
> >  		goto out;
> >  
> > -	ret = 0;
> > +	if (inode->i_blocks < (len >> HPAGE_SHIFT)) {
> 
> What locking does i_blocks use?   tree_lock, I thought?

Um... bloody good question.  Doesn't look to be tree_lock (though that
would be awfully conveninent for my purpose).  Comments in fs.h and
fs/stat.c suggest i_lock.  Which also appears to be a leaf lock, to
which I doubt we wish to introduce a dependency (in either direction)
with tree_lock.

Eck.. I'm going to have to go back and think about this harder.  I
think I'll need to store the reserved page count somewhere other than
i_blocks, in private inode data or similar.

> >  static void hugetlbfs_delete_inode(struct inode *inode)
> >  {
> > -	if (inode->i_data.nrpages)
> > -		truncate_hugepages(&inode->i_data, 0);
> > +	truncate_hugepages(inode, 0);
> 
> This optimisation was removed because there might be a reservation in the
> inode (yes?)

Yes.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
