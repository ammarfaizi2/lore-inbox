Return-Path: <linux-kernel-owner+w=401wt.eu-S1754431AbWLTLvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbWLTLvT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754447AbWLTLvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:51:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43783 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431AbWLTLvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:51:18 -0500
Date: Wed, 20 Dec 2006 11:51:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Raisch <RAISCH@de.ibm.com>
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: do we have mmap abuse in ehca ?, was Re:  mmap abuse in ehca
Message-ID: <20061220115116.GA25709@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <hnguyen@de.ibm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20061219113502.GA1416@infradead.org> <OF78487656.FBBD715F-ONC125724A.00287BE6-C125724A.002F4756@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF78487656.FBBD715F-ONC125724A.00287BE6-C125724A.002F4756@de.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 09:36:23AM +0100, Christoph Raisch wrote:
> let me first try to show what functionality we need...
> The ehca userspace driver needs 2 types of kernel/hw memory mapped into
> userspace,
> 
> 1) 4k pages provided by HW, one per queue, mostly used for signalling
>    from userspace to hardware that new send/receive/poll queue entries are
>    available. In kernel that's the typical candidate for ioremap.
>    For these areas we use ehca_mmap_register to do the actual mapping into
>    a mm
> 2) the actual queue memory itself, which has been allocated by
>    get_zeroed_page(GPF_KERNEL). These pages need to be written by userspace
> and
>    read by the ehca, or the other way around
>    For these areas we use ehca_mmap_nopage to do the mapping into
>    a mm
> 
> 
> 
> let me try to explain what we thought this code should do....
> 
> Christoph Hellwig wrote on 19.12.2006 12:35:02:
> >
> > Folks, could you explain what this code is actually trying to do.
> > Just to quote it in a little more detail the code looks like this:
> >
> > int ehca_mmap_nopage(u64 foffset, u64 length, void **mapped,
> >                      struct vm_area_struct **vma)
> > {
> this is what a anonymous mapping request from userspace would do.
> We didn't want to reimplement the complete mmap code in a driver

Yes, this function is what an anonoyomus _shared_ mmap would do from
userspace.  And there is absolutely zero reason to do such an anonymous
mmap from kernel space at all.  There's a very nice mmap sysall for
it and it's what you should use.

> unfortunately you don't get back a vma ...

And that's for a reason.  

> ...but you need the vma for installing nopage handlers
> therefore:

As you absoutley must not install nopage handlers on anonymous vmas.
If you want a mmap you need a filedescriptor to map and can easily
install handlers and flags into your ->mmap routine.

> >    *vma = find_vma(current->mm, (u64)*mapped);
> >    if (!(*vma)) {
> >       down_write(&current->mm->mmap_sem);
> >       do_munmap(current->mm, 0, length);
> >       up_write(&current->mm->mmap_sem);
> >       ehca_gen_err("couldn't find vma queue=%p", *mapped);
> >       return -EINVAL;
> >    }
> >
> ...that should be straight forward file mmap code
> The memory we're using shouldn't be handled by copy on write,
> should not be swapped, its used by DMA from the hardware.
> And it shouldn't get merged
> In case of a fork we would like to get a pagefault in the new process if
> he accesses this queue and a unchanged forking process.
> Is VM_RESERVED ok for that type of vma?

No, the whole code is completely broken.  You need to implement an
mmap routine on your own file descriptor and simply nack it by
pages you got from alloc_page

> >    ret = remap_pfn_range((*vma), (*vma)->vm_start,
> >                physical >> PAGE_SHIFT,
> >                vsize,
> >                (*vma)->vm_page_prot);
> >
> > Aside from the very questionably naming of ehca_mmap_nopage this maps
> > anonymous shared memory into a random location in the calling process
> > from something that is not defined to change the callers address space,
> 
> these mappings occur exactly when the user calls create_qp and create_cq,
> an ib user actually "wants" to have these queues in its adress space.
> We though that the closest we could get to a mmap(NULL,...) from userspace.

If user wants queues in it's address space the user (or rather a library)
should call mmap on the device files for your queue pairs.  Remember we
have this nice abstraction in unix where a device is a file you can do
operations and not something that magically appears in your process like
certain z/OS abstractions ;-)

To repeat it remap_pfn_range is just fine, it just really needs to be
called from ->mmap.  Alternatively you could also do a demand faulting
variant using vm_insert_page that might provide further advantages.

> > then racy looks up the vma for it and sets the VM_RESERVED flags and
> > vm ops on this anonoymous vma.
> could you explain where the race comes in?
> How would that be different from a user calling mmap?

The find_vma looks up the vma at the address you previously installed
your hacked vma.  But there is no exclusion against other threads
unmapping that region in the meantime, so you affectively mess with
a random vma.

> > This is definitly not
> > how the mmap infrastructure should be used.
> >
> > I'd go as far as saying do_mmap(_pgoff) should not be exported at all,
> > but we'd need to fix similar braindamage in drm first.
> Maybe we shouldn't have looked at that driver how to use mmap
> within the kernel while examining HOW to implement what we needed.
> What other methods would you suggest?
> Is there already a "proper" usage pattern for what we need in the
> kernel?

Pretty much every other mmap routine ;-)

remap_pfn_range useage is obviously really trivial with a mmap routine,
it's just a few lines of code when done proper, e.g. take a look at
drivers/char/mbcs.c:

int mbcs_gscr_mmap(struct file *fp, struct vm_area_struct *vma)
{
        struct cx_dev *cx_dev = fp->private_data;
	struct mbcs_soft *soft = cx_dev->soft;

	if (vma->vm_pgoff != 0)
		return -EINVAL;

	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

	if (remap_pfn_range(vma,
			    vma->vm_start,
			    __pa(soft->gscr_addr) >> PAGE_SHIFT,
			    PAGE_SIZE,
			    vma->vm_page_prot))
		return -EAGAIN;
		
	return 0;
}

That's it.  if you dont need it you can remove the noncached setting, if
you need you can add more checks, etc.

Similary for the nopage variant you can just keep your nopage handle
and have a trivial no-op ->mmap routine similar to drivers/kvm/kvm_main.c:

static int kvm_dev_mmap(struct file *file, struct vm_area_struct *vma)
{
        vma->vm_ops = &kvm_dev_vm_ops;
	return 0;
}

Note directly related but also important is that instead of abusing
vm_pgoff for switching the type of mmap region you should
simply have different nopage routines and vma_operations for them -
the only code shared by the different case in ehca_nopage is the
get_page() anyway.
