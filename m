Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423553AbWJaQZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423553AbWJaQZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423551AbWJaQZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:25:57 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:65263 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S1423543AbWJaQZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:25:56 -0500
Message-ID: <45477912.7070903@ti.uni-mannheim.de>
Date: Tue, 31 Oct 2006 17:25:54 +0100
From: Guillermo Marcus <marcus@ti.uni-mannheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
References: <4547150F.8070408@ti.uni-mannheim.de> <4547733B.9040801@gmail.com>
In-Reply-To: <4547733B.9040801@gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

The fact that it does not works with RAM is well documented in LDD3,
pages 430++. It says (and I tested) that remap_xxx_range does not work
in this case. They suggest a method using nopage, similar to the one I
implement.

I do not see why remap_xxx_range has the limitation, but it is there.
The question is then: can the limitation be removed, or can we implement
a new function that maps RAM all at once without the need for a nopage
implementation?

In any case, here is the code.

Best Wishes,
Guillermo


/*************************************************/

To allocate (inside an IOctl cmd):

...
retptr = pci_alloc_consistent( privdata->pdev, kmem_handle->size,
&(kmem_entry->dma_handle) );
if (retptr == NULL)
	goto kmem_alloc_mem_fail;
kmem_entry->cpua = (unsigned long)retptr;
kmem_entry->size = kmem_handle->size;
kmem_entry->id = atomic_inc_return(&privdata->kmem_count) - 1;
...


To mmap (inside mmap fops, this DOES NOT works):

...
/* Map the Buffer to the VMA */
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,10)
ret = remap_pfn_range(
		vma,
		vma->vm_start,
		__pa(kmem_entry->cpua) >> PAGE_SHIFT,
		kmem_entry->size,
		vma->vm_page_prot );
#else
ret = remap_page_range(
		vma,
		vma->vm_start,
		__pa(kmem_entry->cpua),
		kmem_entry->size,
		vma->vm_page_prot );
#endif
...


Forcing me to this:

(in mmap):

...
/* Set VM operations */
vma->vm_private_data = kmem_entry;
vma->vm_ops = &pcidriver_vm_operations;
pcidriver_vm_open(vma);
...

(and the nopage vm_ops):

...
/* Maps physical memory to user space */
struct page *pcidriver_vm_nopage(struct vm_area_struct *vma, unsigned
long address, int * type) {

pcidriver_kmem_entry_t *kmem_entry;
struct page *page = NOPAGE_SIGBUS;
unsigned long pfn_offset,pfn;
		
/* Get private data for the page */
kmem_entry = vma->vm_private_data;

/* All checks where done during the mmap_kmem call, so we can safely
 * just map the offset of the vm area to the offset of the region,
 * that is guaranteed to be contiguos */

pfn_offset = (address) - (vma->vm_start);
pfn = (__pa(kmem_entry->cpua) + pfn_offset ) >> PAGE_SHIFT;

if (!pfn_valid(pfn)) {
	mod_info("Invalid pfn in nopage() - 0x%lx \n", pfn);
	return NOPAGE_SIGBUS;
}
		
page = pfn_to_page( pfn );

get_page(page);
if (type)
	*type = VM_FAULT_MINOR;

return page;
}
...

/*************************************************/



Jiri Slaby wrote:
> Guillermo Marcus wrote:
>> Hi all,
>>
>> I recently run with the following situation while developing a PCI
>> driver. The driver allocates memory for a PCI device using
>> pci_alloc_consistent as this memory is going to be used to perform DMA
>> transfers. To pass the data from/to the user application, I mmap the
>> buffer into userspace. However, if I try to use remap_pfn_range
>> (>=2.6.10) or the older remap_page_range(<=2.6.9) for mmaping, it ends
>> up creating a new buffer, because they do not support RAM mapping, then
>> pagefaulting to the VMA and by default allocating new pages. Therefore,
>> I had to implement the nopage method and mmap one page at a time as they
>> fault.
>>
>> However, to my point of view, this is unnecessary. The memory is already
>> allocated, the memory is locked because it is consistent, and it may be
>> a (very small) performance and stability issue to do them one-by-one.
>> Why can't I simply mmap it all at once? am I missing some function? More
>> important, why can't remap_{pfn/page}_range handle it?
> 
> Piece of code please. pci_alloc_consistent calls __get_free_pages, and there
> should be no problem with mmaping this area.
> 
> regards,
