Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135314AbREEUVe>; Sat, 5 May 2001 16:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135318AbREEUVY>; Sat, 5 May 2001 16:21:24 -0400
Received: from quasar.osc.edu ([192.148.249.15]:13478 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S135314AbREEUVN>;
	Sat, 5 May 2001 16:21:13 -0400
Date: Sat, 5 May 2001 16:18:19 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Terry Barnaby <terry@beam.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on mmap(2) with kernel alocated memory
Message-ID: <20010505161819.A8134@quasar.osc.edu>
In-Reply-To: <3AF2A732.5D4BF81F@beam.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i-nntp2
In-Reply-To: <3AF2A732.5D4BF81F@beam.demon.co.uk>; from terry@beam.demon.co.uk on Fri, May 04, 2001 at 01:57:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

terry@beam.demon.co.uk said:
> I am trying to mmap() into user space a kernel buffer  and am having
> problems.
> I have a simple test example, can someone please tell me what I have got
> wrong ?
> 
> In a driver I do:
>     uint*    kva;
> 
>     kva = (uint*)kmalloc(4096, GFP_KERNEL);
>     *kva = 0x11223344;
>     printk("Address: %p %lx %x\n", kva, virt_to_phys(kva), *kva);
> 
> Now in some simple user program I do:
> 
> #include <stdio.h>
> #include <string.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <fcntl.h>
> 
> int main(int argc, char** argv){
>  int fm;
>  char* p;
>  uint* pi;
>  uint v;
>  uint add = 0x74b000;
> 
>  if((fm = open("/dev/mem", O_RDWR)) < 0)
>   return 1;
> 
>  p = mmap(0, 128 * 1024 * 1024, PROT_READ|PROT_WRITE, MAP_SHARED, fm,
> 0);
>  printf("Mapped: %p\n", p);
> 
>  lseek(fm, add, SEEK_SET);
>  read(fm, &v, sizeof(v));
>  printf("V: %x\n", v);
> 
>  pi = (uint*)(p + add);
>  printf("Vmmap: %p %x\n", pi, *pi);
> 
>  close(fm);
>  return 0;
> }
> 
> The value of add is hardcoded to the value printed for the physical
> address in the drivers prink routine.
> The lseek/read from the /dev/mem device yields the value 0x11223344.
> However the mmap method also on /dev/mem yields the value 0.
> 
> Whats wrong with my mmap() or kalloc() ?

Executive summary:

    mmap of /dev/mem gives different values than lseek/read of /dev/mem

Using lseek/read gives back bits of physical memory, but dereferencing
a pointer into the mmaped area mostly gives zeroes.

The file-system specific mmap routine, mmap_mem, calls
remap_page_range to do the work of remapping the physical pages
into user space.  But eventually in remap_pte_range there's a check

	if ((!VALID_PAGE(page)) || PageReserved(page))
		set_pte(pte, mk_pte_phys(phys_addr, prot));

And the effect is that only the reserved pages and those outside
of the physical memory space get mapped.  This isn't intuitive for
/dev/mem, but is it the intended behavior?

You could replicate those 80 odd lines of remap_page_range and helpers
to get a version without the PageReserved test.  Yuk.

Quick hack:
    SetPageReserved(virt_to_page(kva));

but you may want to undo that (Clear...) before kfree-ing the page,
as I'm not sure what will be confused by that.

Longer term solution:  write your own mmap routine in the driver,
have the user code open /dev/my-driver, and mmap() on that instead
of going through /dev/mem with a hardcoded address.

    		-- Pete
