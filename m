Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbSLLU4k>; Thu, 12 Dec 2002 15:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbSLLU4j>; Thu, 12 Dec 2002 15:56:39 -0500
Received: from smtp03.web.de ([217.72.192.158]:59167 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S267488AbSLLU4i>;
	Thu, 12 Dec 2002 15:56:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Pinning kernel memory
Date: Thu, 12 Dec 2002 22:04:15 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <1039712449.3df8c0c183dfe@rumms.uni-mannheim.de> <Pine.LNX.4.50L.0212121814450.17748-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.50L.0212121814450.17748-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212122204.16019.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Oliver Neukum mailed me a similar answer, too.

So it looks as my problem was an other one, but setting the pages reserved 
solved it.
The problem was that I remapped these kernel pages into user space and 
accessing this remapped memory always leaded to a SIGBUS. And since setting 
the pages reserved "pins" them, I thought they were swapped out...

I don't know if that is the correct way I do it, and if anyone can tell me how 
it should be done I'll be interested...

  Thomas Schlichter

P.S.: Here are some of the lines from the code I wrote that should show what I 
mean... ;-)

int mem_init_module(void)
{
  struct page *page;

~~~ cut ~~~

  // allocate mem_size bytes of physical continuous kernel memory
  page = alloc_pages( GFP_KERNEL, order );
  if( !page )
  {
    printk( "<1>kernel_mem.o: could not get %d bytes of kernel memory\n", 
mem_size );
    return -ENOMEM;
  }
  mem_addr = page_address( page );

  // pin the memory
  while( page < virt_to_page(mem_addr + mem_size) )
    SetPageReserved( page++ );

~~~ cut ~~~

  return 0;  // initialization successful
}

int mem_mmap( struct file *filp, struct vm_area_struct *vma )
{
  unsigned long offset;     // byte offset from start address
  unsigned long physical;   // physical start address
  unsigned long vsize;      // size in virtual address space
  unsigned long psize;      // size in physical address space

  offset = vma->vm_pgoff << PAGE_SHIFT;
  physical = virt_to_bus(mem_addr) + offset;
  vsize = vma->vm_end - vma->vm_start;
  psize = mem_size - offset;

  printk( "<1>kernel_mem.o: mmap offset %lu, physical %#010lx, vsize %lu, 
psize %lu\n", offset, physical, vsize, psize );

  // virtual range is fully mapped to physical address space ?
  if ( vsize > psize )
  {
    printk("<1>kernel_mem.o: mmap failed as vsize > psize\n");
    return -EINVAL;
  }

  // do the remapping
  remap_page_range( vma->vm_start, physical, vsize, vma->vm_page_prot );

  // register memory operations to the kernel tables (like file operations)
  vma->vm_ops = &mem_vm_ops;

  // invoke the vma_open routine (which actually does nothing)
  mem_vma_open( vma );

  return 0;
}


Am Donnerstag, 12. Dezember 2002 21:15 schrieb Rik van Riel:
> On Thu, 12 Dec 2002, Thomas Schlichter wrote:
> > I want to create a big area of unswappable, physical continuous kernel
> > memory for hardware testing purposes. Currently I allocate the memory
> > using alloc_pages(GFP_KERNEL, order) and after this I pin it using
> > SetPageReserved(page) for each page.
>
> Kernel memory is never swappable, so there is no need to "pin it".
>
>
> Rik

