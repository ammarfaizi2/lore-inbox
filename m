Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbSJHQVp>; Tue, 8 Oct 2002 12:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSJHQVp>; Tue, 8 Oct 2002 12:21:45 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:57353 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S261386AbSJHQVm>; Tue, 8 Oct 2002 12:21:42 -0400
Message-ID: <7FAAE4DE7248554ABD8C69DD4A18289B80305A@srnamath>
From: "swayampakulaa, sudhindra" <swayampakulaa_sudhindra@emc.com>
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: mmap enrty point in a driver
Date: Tue, 8 Oct 2002 12:27:21 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iam trying to understand the mmap entry point for a driver.
This is how the mmap() is implemented 


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
  
  /* himem_buf is calculated as high_memory - PAGE_OFFSET */
  umem_addr = himem_buf + himem_buf_allocated;
  if (umem_addr == 0){
    return -ENOMEM;
  }
  himem_buf_allocated += size;
  

  virt_addr = ioremap((unsigned long)umem_addr, PAGE_SIZE);  
  if (virt_addr == 0){
    return -ENOMEM;
  }
  /* write the index into the first 4 bytes */
  writel(index, (uint32_t *)virt_addr);

    /* the values of index and *(virt_addr) do not match */
    /*                      *(virt_addr) is always -1                */
    /* Is something wrong here                                   */
    dbg_printf(0,"index is %d, *(virt_addr) is %d\n", index,
(int)readl(virt_addr));
  iounmap(virt_addr);

   

  remap_page_range(vma->vm_start, (ulong)umem_addr, 
		   vma->vm_end - vma->vm_start, vma->vm_page_prot);

  return 0;
}

Can you help me in understanding what exactly is the mmap() doing here and
if its doing it right.

