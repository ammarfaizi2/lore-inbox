Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263531AbSJHT4V>; Tue, 8 Oct 2002 15:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263525AbSJHTzS>; Tue, 8 Oct 2002 15:55:18 -0400
Received: from web21409.mail.yahoo.com ([216.136.232.79]:33345 "HELO
	web21409.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263479AbSJHTyN>; Tue, 8 Oct 2002 15:54:13 -0400
Message-ID: <20021008195954.34505.qmail@web21409.mail.yahoo.com>
Date: Tue, 8 Oct 2002 12:59:54 -0700 (PDT)
From: Ankit <ankitsl@yahoo.com>
Subject: mmap driver entry point 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iam using this driver to fetch me some memory in
my user space application by calling mmap with the
file descriptor got by opening the device file for
this driver.
mmap(0, length, flags, flags, fd, offset)

and the mmap entry point in the driver is implemented
as below:

In the implementation, it tries to write an index into
the first four bytes, which i use to store in my
internal structures( to later reference it through the
index), before zeroing out the buffer. But the index
is always -1.

I dont understand the part where its getting the
physical address to map.
whats the high_memory and whats the PAGE_OFFSET.
Can you help me in understanding what exactly is the
mmap() doing here and
if its doing it right.


himem_buf_allocated = 0;

int xxx_mmap(struct file *filp,
		  struct vm_area_struct *vma)
{
  unsigned long size;
  char * virt_addr;
  int		index;

  size = vma->vm_end - vma->vm_start;
  if ((size % PAGE_SIZE) != 0){
    size = (size / PAGE_SIZE) * PAGE_SIZE + PAGE_SIZE;
  }

  /* himem_buf_size is 0x80000000 */
  if (size + himem_buf_allocated >= himem_buf_size){
    
    return -ENOMEM;
  }
  
  /* himem_buf is calculated as high_memory -
PAGE_OFFSET */
  umem_addr = himem_buf + himem_buf_allocated;
  if (umem_addr == 0){
    return -ENOMEM;
  }
  himem_buf_allocated += size;
  

  virt_addr = ioremap((unsigned long)umem_addr,
PAGE_SIZE);  
  if (virt_addr == 0){
    return -ENOMEM;
  }
  /* write the index into the first 4 bytes */
  writel(index, (uint32_t *)virt_addr);

    /* the values of index and *(virt_addr) do not 
       match.   *(virt_addr) is always -1 .
       Is something wrong here    */
    dbg_printf(0,"index is %d, *(virt_addr) is %d\n",
index,(int)readl(virt_addr));
  iounmap(virt_addr);

   

  remap_page_range(vma->vm_start, (ulong)umem_addr, 
		   vma->vm_end - vma->vm_start, vma->vm_page_prot);

  return 0;
}


__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
