Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318825AbSIISlS>; Mon, 9 Sep 2002 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318815AbSIISlF>; Mon, 9 Sep 2002 14:41:05 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:14788 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S318806AbSIISjk>; Mon, 9 Sep 2002 14:39:40 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Daniel Phillips'" <phillips@arcor.de>, <root@chaos.analogic.com>,
       "'David S. Miller'" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 11:41:52 -0700
Message-ID: <01a701c25830$91223d90$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E17oTFW-0006qo-00@starship>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Daniel Phillips [mailto:phillips@arcor.de]
Sent: Monday, September 09, 2002 11:27 AM
To: imran.badr@cavium.com; root@chaos.analogic.com
Cc: 'David S. Miller'; linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..


On Monday 09 September 2002 20:12, Imran Badr wrote:
> But my question here still begging an answer: What would be the portable
way
> to calculate kernel logical address of that user buffer?

>Could you please post your code for doing the kmalloc and mmap?
>
>--
>Daniel


Sure, in mmap():

size = vma->vm_end - vma->vm_start;
if(size % PAGE_SIZE)
{
	printk(KERN_CRIT "mmap: size (%ld) not multiple of PAGE_SIZE.\n", size);
	return -ENXIO;
}

offset = vma->vm_pgoff<<PAGE_SHIFT;
if(offset & ~PAGE_MASK)
{
	printk(KERN_CRIT "mmap: offset (%ld) not aligned.\n", offset);
	return -ENXIO;
}

kmalloc_ptr = (Uint8 *)kmalloc(size+(2*PAGE_SIZE), GFP_KERNEL);
if(kmalloc_ptr == NULL)
{
	printk(KERN_CRIT "mmap: not enough memory.\n");
	return -ENOMEM;
}

/* align it to page boundary */
kmalloc_area = (Uint8 *)(((Uint32)kmalloc_ptr + PAGE_SIZE -1) & PAGE_MASK);

/* reserve all pages */
for(virt_addr = (Uint32)kmalloc_area; virt_addr < (Uint32)kmalloc_area +
size; virt_addr +=PAGE_SIZE)
{
	mem_map_reserve(virt_to_page(virt_addr));
}

/* lock the area*/
vma->vm_flags |=VM_LOCKED;

if(remap_page_range(vma->vm_start,
			virt_to_phys((void *)(Uint32)kmalloc_area),
			size,
			PAGE_SHARED))
{
	printk(KERN_CRIT "mmap: remap page range failed.\n");
	return -ENXIO;
}


vma->vm_ops = &pkp_vma_ops;
vma->vm_private_data = kmalloc_ptr;
return 0;



This works just fine on my i386 platform (SMP ,non-SMP). Now in my ioctl()
entry I get the kernel logical address by using the following code:

adr = user_address;
pgd_offset(current->mm, adr);
if (!pgd_none(*pgd)) {
	pmd = pmd_offset(pgd, adr);
	if (!pmd_none(*pmd)) {
		ptep = pte_offset(pmd, adr);
		pte = *ptep;
		if(pte_present(pte)) {
			kaddr  = (unsigned long) page_address(pte_page(pte));
			kaddr |= (adr & (PAGE_SIZE - 1));
		}
	}
}

Now for DMA, I get bus address by using virt_to_bus(kaddr). So, is there any
portablility issue in this scheme?

Thanks,
Imran.






