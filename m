Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWCTNsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWCTNsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWCTNsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:48:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:10952 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932215AbWCTNsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:48:07 -0500
Date: Mon, 20 Mar 2006 19:18:20 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [1/3 PATCH] Kprobes: User space probes support- base interface
Message-ID: <20060320134820.GE8662@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320024248.426b97ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320024248.426b97ec.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 02:42:48AM -0800, Andrew Morton wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> >
> > This patch provides two interfaces to insert and remove
> > user space probes. Each probe is uniquely identified by
> > inode and offset within that executable/library file.
> > Insertion of a probe involves getting the code page for
> > a given offset, mapping it into the memory and then insert
> > the breakpoint at the given offset. Also the probe is added
> > to the uprobe_table hash list. A uprobe_module data strcture
> > is allocated for every probed application/library image on disk.
> > Removal of a probe involves getting the code page for a given
> > offset, mapping that page into the memory and then replacing
> > the breakpoint instruction with a the original opcode.
> > This patch also provides aggrigate probe handler feature,
> > where user can define multiple handlers per probe.
> > 
> > +/**
> > + * Finds a uprobe at the specified user-space address in the current task.
> > + * Points current_uprobe at that uprobe and returns the corresponding kprobe.
> > + */
> > +struct kprobe __kprobes *get_uprobe(void *addr)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma;
> > +	struct inode *inode;
> > +	unsigned long offset;
> > +	struct kprobe *p, *kpr;
> > +	struct uprobe *uprobe;
> > +
> > +	vma = find_vma(mm, (unsigned long)addr);
> > +
> > +	BUG_ON(!vma);	/* this should not happen, not in our memory map */
> > +
> > +	offset = (unsigned long)addr - (vma->vm_start +
> > +						(vma->vm_pgoff << PAGE_SHIFT));
> > +	if (!vma->vm_file)
> > +		return NULL;
> 
> All this appears to be happening without mmap_sem held?

Yes, I will make the changes to hold the mmap_sem.

> 
> > +/**
> > + * Wait for the page to be unlocked if someone else had locked it,
> > + * then map the page and insert or remove the breakpoint.
> > + */
> > +static int __kprobes map_uprobe_page(struct page *page, struct uprobe *uprobe,
> > +				     process_uprobe_func_t process_kprobe_user)
> > +{
> > +	int ret = 0;
> > +	kprobe_opcode_t *uprobe_address;
> > +
> > +	if (!page)
> > +		return -EINVAL; /* TODO: more suitable errno */
> > +
> > +	wait_on_page_locked(page);
> > +	/* could probably retry readpage here. */
> > +	if (!PageUptodate(page))
> > +		return -EINVAL; /* TODO: more suitable errno */
> > +
> > +	lock_page(page);
> 
> That's a lot of fuss and might be racy with truncate.
> 
> Why not just run lock_page()?

Yes, I will do that.

> 
> > +	uprobe_address = (kprobe_opcode_t *)kmap(page);
> > +	uprobe_address = (kprobe_opcode_t *)((unsigned long)uprobe_address +
> > +						(uprobe->offset & ~PAGE_MASK));
> > +	ret = (*process_kprobe_user)(uprobe, uprobe_address);
> > +	kunmap(page);
> 
> kmap_atomic() is preferred.
> 

Agreed.

> > +/**
> > + * Gets exclusive write access to the given inode to ensure that the file
> > + * on which probes are currently applied does not change. Use the function,
> > + * deny_write_access_to_inode() we added in fs/namei.c.
> > + */
> > +static inline int ex_write_lock(struct inode *inode)
> > +{
> > +	return deny_write_access_to_inode(inode);
> > +}
> 
> hm, this code likes to poke around in VFS internals.  It would be nice to
> have an overall description of what it's trying to do, why and how.

ok, I should probably separate VFS changes in a different patch with
proper comments. However this is required to ensure that the
executable associated with this inode on which probes are inserted
does not change. deny_write_access_to_inode() just decrements the
inode usage count to -1.

> 
> > +/**
> > + * unregister_uprobe: Disarms the probe, removes the uprobe
> > + * pointers from the hash list and unhooks readpage routines.
> > + */
> > +void __kprobes unregister_uprobe(struct uprobe *uprobe)
> > +{
> > +	struct address_space *mapping;
> > +	struct uprobe_module *umodule;
> > +	struct page *page;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	if (!uprobe->inode)
> > +		return;
> > +
> > +	mapping = uprobe->inode->i_mapping;
> > +
> > +	page = find_get_page(mapping, uprobe->offset >> PAGE_CACHE_SHIFT);
> > +
> > +	spin_lock_irqsave(&uprobe_lock, flags);
> > +	ret = remove_uprobe(uprobe);
> > +	spin_unlock_irqrestore(&uprobe_lock, flags);
> > +
> > +	mutex_lock(&uprobe_mutex);
> > +	if (!(umodule = get_module_by_inode(uprobe->inode)))
> > +		goto out;
> > +
> > +	hlist_del(&uprobe->ulist);
> > +	if (hlist_empty(&umodule->ulist_head)) {
> > +		list_del(&umodule->mlist);
> > +		ex_write_unlock(uprobe->inode);
> > +		path_release(&umodule->nd);
> > +		kfree(umodule);
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&uprobe_mutex);
> > +	if (ret)
> > +		ret = map_uprobe_page(page, uprobe, remove_kprobe_user);
> > +
> > +	if (ret == -EINVAL)
> > +		return;
> > +	/*
> > +	 * TODO: unregister_uprobe should not fail, need to handle
> > +	 * if it fails.
> > +	 */
> > +	flush_vma(mapping, page, uprobe);
> > +
> > +	if (page)
> > +		page_cache_release(page);
> > +}
> 
> That's some pretty awkward coding.  Buggy too.  It doesn't drop the
> refcount on the page if map_uprobe_page() returned -EINVAL because it's
> assuming that EINVAL meant "there was no page".  But there are multiple
> reasons for map_uprobe_page() to return -EINVAL.  If that page isn't
> uptodate, we leak a ref.
> 
> This function should be doing the checking for a find_get_page() failure,
> not map_uprobe_page().

Yes, that is buggy, will fix.


Thanks
Prasanna


-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
