Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTAAVlM>; Wed, 1 Jan 2003 16:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTAAVlL>; Wed, 1 Jan 2003 16:41:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31500 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264756AbTAAVlK>; Wed, 1 Jan 2003 16:41:10 -0500
Date: Wed, 1 Jan 2003 21:49:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com, parisc-linux@parisc-linux.org
Subject: "vmalloc", friends and GFP flags
Message-ID: <20030101214933.A26434@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
	parisc-linux@parisc-linux.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This mail is being copied to the XFS and PARISC mailing lists.  You should
probably trim the reply list as appropriate.

I've just been looking over the state of the ARM {dma,pci}_alloc_consistent
wrt interrupts etc in 2.5.53, and decided to have a look around this area
for other users.  I stumbled across the following unsafe areas.

a) parisc.  Looking at pa11_dma_alloc_consistent:

   pa11_dma_alloc_consistent
	-> map_uncached_pages
		-> (eventually) map_pmd_uncached
			-> pte_alloc_kernel
				-> pte_alloc_one_kernel

	static inline pte_t *
	pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
	{
	        pte_t *pte = (pte_t *) __get_free_page(GFP_KERNEL);
        	if (likely(pte != NULL))
	                clear_page(pte);
        	return pte;
	}

   End result is that if pa11_dma_alloc_consistent() is called from
   IRQ context, parisc calls __get_free_page using GFP_KERNEL.
   Calling __get_free_page with GFP_KERNEL from IRQ context appears
   to be unsafe (always has been.)

b) xfs. XFS contains this bit of code:

	static __inline unsigned int flag_convert(int flags)
	{
		...
	        if (flags & KM_NOSLEEP)
        	        return GFP_ATOMIC;
	        /* If we're in a transaction, FS activity is not ok */
        	else if ((current->flags & PF_FSTRANS) || (flags & KM_NOFS))
	                return GFP_NOFS;
        	else
	                return GFP_KERNEL;
	}

	void *kmem_alloc(size_t size, int flags)
	{
		...
                rval = __vmalloc(size, flag_convert(flags), PAGE_KERNEL);
		...
	}

   Ok, so xfs can pass GFP_ATOMIC, GFP_NOFS and GFP_KERNEL to __vmalloc.
   However, do these flags actually ensure what they suggest they do?

   Lets look at __vmalloc:

	void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot)
	{
		...
        	area = get_vm_area(size, VM_ALLOC);
		...
	}

   and get_vm_area:

	struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
	{
		...
        	area = kmalloc(sizeof(*area), GFP_KERNEL);
		...
	}

   Also, look at the PMD and PTE allocation functions, which also use
   GFP_KERNEL.

   Answer to the above question: no.  Is this unsafe?  Probably.

Now, what does this all have to do with ARM and pci_alloc_consistent.
It's the same problem, only I have a BUG_ON() in there to catch uses
from IRQ context, which needs to disappear eventually.  (This is
mainly a requirement for USB to work.)

However, before this can happen, I believe I'd need the following:

1. allocation of vm areas (via get_vm_area and friends) needs to become
   IRQ-safe.

   - vmlist_lock needs to become IRQ safe (but its held during vread/vwrite)
   - kmalloc of vm_structs needs to have gfp flags passed in

2. allocation of page tables (via pmd_alloc_kernel / pte_alloc_kernel)
   needs to become IRQ-safe.

   - pmd_alloc_kernel / pte_alloc_kernel needs to have gfp flags passed in
   - map_vm_area would also need gfp flags

The same solution also fixes the two instances described above.

I suspect, however, that the vmlist_lock change will be unacceptable
to many people however.  This doesn't affect XFS nor parisc, but would
mean that I'd need to completely rewrite the ARM consistent memory
allocation to use none of the above (which I think is the right
approach, but means _all_ of the above becomes S.E.P. 8))

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

