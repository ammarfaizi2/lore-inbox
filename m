Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbTFSUcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbTFSUcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:32:10 -0400
Received: from mail2.megatrends.com ([155.229.80.16]:49413 "EHLO
	atl-ms1.megatrends.com") by vger.kernel.org with ESMTP
	id S265507AbTFSUcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:32:00 -0400
Message-ID: <8CCBDD5583C50E4196F012E79439B45C1C711B@atl-ms1.megatrends.com>
From: Vinesh Christopher <vineshc@ami.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Vinesh Christopher <vineshc@ami.com>
Subject: Memory corruption in mmap whe  accessing more than 4K (Page Size)
Date: Thu, 19 Jun 2003 16:57:32 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a driver which allocates 2MB of contiguous physical memory 
using get_free_pages(). A user-mode program has to access this memory 
using mmap(). The user mode repeatedly opens the driver, mmap the memory
access the memory for some time , then munmaps the memory and closes the 
memory. After some period of time, the kernel / process crashes and panics

If I use only 4K (Page Size) of memory, then it does not happen. Is there 
any restriction or any other way to access them?


struct page *
sample_vma_nopage(struct vm_area_struct *vma,unsigned long address, int
write)
{
	unsigned long offset;
	unsigned long physaddr;
	struct page *page = NOPAGE_SIGBUS;

	/* Compute the offset */
	offset = (address - vma->vm_start) + VMA_OFFSET(vma);

	/* Get the page in the 2MB buffer where the offset begins */	
	physaddr = MyBuffer +offset;
	page = virt_to_page(__va(physaddr));

	/* Increment the count */
	get_page(page);

	return page;
}



struct 
vm_operations_struct sample_vm_ops = 
{
    open	:  sample_vma_open,
    close	:  sample_vma_close,
    nopage	:  sample_vma_nopage,
};


int 
videocap_mmap(struct file *filp, struct vm_area_struct *vma)
{

    /* Check if the offsets are aligned */
    if (VMA_OFFSET(vma) & (PAGE_SIZE-1))                
    {
	TRACE_ERROR("mmap() received unaligned offsets. Cannot map \n"); 
        return -ENXIO; 
    }

    vma->vm_flags |= VM_RESERVED;
    vma->vm_private_data = NULL;
    vma->vm_ops = &sample_vm_ops;
	
    sample_vma_open(vma);
    return 0;
}


Any help will be appreciated

Regards
Samvinesh Christopher


P.S: Iam not in the mailing list. So please CC to me @ vineshc@ami.com
