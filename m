Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268646AbUJPDqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268646AbUJPDqw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 23:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUJPDqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 23:46:52 -0400
Received: from mail.aoi-industries.com ([216.204.214.42]:58636 "EHLO
	aoi-industries.com") by vger.kernel.org with ESMTP id S268646AbUJPDqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 23:46:43 -0400
To: linux-kernel@vger.kernel.org
Subject: remap_page_range64() for PPC
Message-Id: <20041016034642.F1DD0C60D@aoi-industries.com>
Date: Fri, 15 Oct 2004 23:46:42 -0400 (EDT)
From: glenn@aoi-industries.com (Glenn Burkhardt)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing an application to run on a PowerPC with a 2.4 embedded
Linux kernel, and I want to make device registers for our custom
hardware accessable from user space with mmap().  The physical address
of the device is above the 4gb boundary (we attach to the 440's
external peripheral bus), so a standard 'remap_page_range()' call
won't work.

I've come up with a solution that appears to work, but never having
worked with the page tables before, I'm a bit nervous.  So if anyone
would give the following code a short "code review", I'd greatly
appreciate it.  I'm assuming that the page table entries created here
will be removed when a process exits as part of the normal cleanup.

The physical address passed to 'mk_pte_phys' has a value like
0x150000000ULL.  Our device has only 0x100 bytes of addresses, so a
single page table entry is enough (pages are 0x1000 long), and we'll
only make one mmap() call per device.

TNA!!



static struct EBC_DATA {
    void *baseaddr;
    phys_addr_t phys_addr;
} ebc_data[2];	/* only 2 banks used */

static inline pgprot_t pgprot_noncached(pgprot_t _prot)
{
        unsigned long prot = pgprot_val(_prot);

#if defined(__powerpc__)
        prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
#endif
        return __pgprot(prot);
}

#endif /* !pgprot_noncached */

static int mmap_ebc(struct file * file, struct vm_area_struct * vma)
{
        unsigned long address;

        if (vma->vm_pgoff) {
            printk(KERN_INFO "EBC invalid vma offset: %lx\n", vma->vm_pgoff);
            return -EINVAL;
        }

        /*
         * Use non-cached access.
         */
        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

        /* Don't try to swap out physical pages..
         * Don't dump addresses that are not real memory to a core file.
         */
        vma->vm_flags |= VM_RESERVED|VM_IO;

        /* remap_page_range64() 
           Create a page table entry for the Peripheral Bus physical
           addresses, in user space.  Need only a single page, since
           Phoenix boards have only 0x100 bytes of addresses.
         */
        struct mm_struct *mm = current->mm;
        pgd_t * dir;

        dir = pgd_offset(mm, vma->vm_start);
        if (pgd_none(*dir) || pgd_bad(*dir)) return -EINVAL;

        spin_lock(&mm->page_table_lock);

        pmd_t *pmd = pmd_alloc(mm, dir, vma->vm_start);
        if (!pmd) return -ENOMEM; 

        address = vma->vm_start & ~PGDIR_MASK;

        pte_t * pte = pte_alloc(mm, pmd, address);
        if (!pte) return -ENOMEM;

        /* Should probably add in "vma->vm_pgoff << PAGE_SHIFT" to 
           physical address here, but count on only one mmap call
           per process per EBC device.
        */
        set_pte(pte,
                mk_pte_phys(((struct EBC_DATA *)file->private_data)->phys_addr,
                            vma->vm_page_prot));
        
        spin_unlock(&mm->page_table_lock);
        
        return 0;
}
