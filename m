Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTJNJIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbTJNJIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:08:37 -0400
Received: from puck.spacetec.no ([192.51.5.29]:29198 "HELO puck.spacetec.no")
	by vger.kernel.org with SMTP id S262273AbTJNJIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:08:30 -0400
Message-ID: <3F8BBD0A.50001@spacetec.no>
Date: Tue, 14 Oct 2003 11:08:26 +0200
From: Hans Berglund <hb@spacetec.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel memory allocation and page used counter
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Rating: 0 1.6.2 4107/1000/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have reserved a bounch of 128k sized pieces of kernel memory
using addr[i] = __get_free_pages (GFP_KERNEL, 5); repeated times.

The first time the pages are used, I can DMA to this memory,
and get the data without problems. After freeing the memory
with free_pages (addr[i], 5); and allocating next time, the
kernel crashes in different ways each time when I use the memory.
Usually an oops with the message: "Unable to handle kernel paging
request at virtual address xxxxxxxx".

I have noticed that the struct page->count.counter of the first page
of each 128k chunk is incremented, but not of the remaining pages.
Then I tried to increment the counter "manually" by using get_page()
just after allocation, and the system seemed to become stable.

Do I really have to mark the pages as used, just after allocation, and
is there a kernel call to du this in one operation?
If the pages are used by others, why does the kernel crash after the
second allocation, and not the first?


I am running kernel 2.4.19, and I use the code below to do the
mapping.

All answers are appreciated.

Hans



struct page *xxx_vma_nopage (struct vm_area_struct *vma,
			      unsigned long addr, int write)
{
     int offset, block;
     void *virt_addr;
     card_t *cp;
     struct page *cpage;

     cp = vma->vm_private_data;
     offset = addr - vma->vm_start;
     if ((addr < vma->vm_start) || (addr >= vma->vm_end))
     {
	PWARNING ("nopage: Mapping out of range, start=0x%x, addr=0x%x,"
		  "end=0x%x\n",
		  (int)vma->vm_start, (int)addr, (int)vma->vm_end);
	return (0);
     }
     block = offset / KM_SIZE;         /* KM_SIZE = 128k */
     virt_addr = cp->list[block].address + (offset % KM_SIZE);
     cpage = virt_to_page (virt_addr);
     get_page (cpage);
     return (cpage);
}


struct vm_operations_struct xxx_vmops =
{
     open:   xxx_vma_open,
     close:  xxx_vma_close,
     nopage: xxx_vma_nopage,
};


int
xxx_mmap (struct file *filp, struct vm_area_struct *vma)
{
     card_t *cp = &xxxarr[MINOR(filp->f_dentry->d_inode->i_rdev)];
     vma->vm_flags |= VM_RESERVED;

     vma->vm_ops = &xxx_vmops;
     vma->vm_private_data = cp;
     xxx_vma_open(vma);
     return (0);
}


