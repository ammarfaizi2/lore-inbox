Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbUB0WuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbUB0WuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:50:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:54971 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263136AbUB0WtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:49:22 -0500
Subject: Re: how does one disable processor cache on memory allocated with
	get_free_pages?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Tyler <retyler@raytheon.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <403F6413.80800@raytheon.com>
References: <403E1DF1.9060901@raytheon.com>
	 <1077879093.22215.328.camel@gaston>  <403F6413.80800@raytheon.com>
Content-Type: text/plain
Message-Id: <1077921618.23344.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 09:40:19 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 02:36, Ross Tyler wrote:
> Benjamin Herrenschmidt wrote (more below):
> 
> >What are you trying to do exactly ?
> >  
> >
> Thanks Ben.
> 
> Sorry, I can't tell you ... exactly.
> Suffice to say, it is something very spooky.
> My customer is very concerned about what I am writing to and reading 
> from memory and where it ends up on the way.
> To address these concerns, I need to make sure that processor cache is 
> not used for some sensitive data.

That's plain wrong. It's even a total nonsense imho. And you cannot
map memory non-cacheable just "like that", it will be mapped cacheable
via the linear kernel mapping and on a lot of CPUs, that double mapping
will lead into interesting things, like CPU checkstops.

> I have sensitive data in (prefetchable and nonprefetchable) memory on 
> some PCI devices and some in conventional memory.

Disabling cache because of "data sensitivity" is a no-no. If somebody
can "peek" at your cache, that person can even more easily peek at
your main memory.

> My understanding so far (somebody, __please__ correct me if I am wrong) ...
> 
> O'Reilly Linux Device Drivers wrote (regarding ioremap_nocache):
> 
> > Quoting from one of the kernel headers: "It's useful if some control 
> > registers are in such an area and write combining or read caching is 
> > not desirable." Actually, the function's implementation is identical 
> > to ioremap on most computer platforms: in situations in which all of 
> > I/O memory is already visible throught noncacheable addresses, there's 
> > no reason to implement a separate, noncaching version of ioremap.

This is partially incorrect.

ioremap maps IO devices in non-cacheable mappings. ioremap_nocache is
something that should die. It was introduced to allow non-cacheable
remapping of some portions of RAM, but that cannot be done reliably
in an architecture neutral way and triggers the problems I mentioned
above.

> O'Reilly Linux Device Drivers wrote (regarding PCI (non)prefetchable 
> memory):
> 
> > The PCI device that implements I/O registers as a memory region marks 
> > the difference by settings a "memory-is-prefetchable" bit in its 
> > configuration register. If the memory region is marked as 
> > prefetchable, the CPU can cache its contents and do all sorts of 
> > optimization with it; nonprefetchable memory access, on the other 
> > hand, can't be optimized because each access can have side effects, 
> > exactly like I/O ports usually have.

This is also misleading. The CPU will not "cache" the content of
PCI prefetchable memory because it has the prefetchable bit. The CPU
is _allowed_ to cache it in that sense that you are allowed, if you
explicitely do so, to create a cacheable mapping on top of a
prefetchable memory region, but we usually don't do that and ioremap
certainly doesn't know if the address you are passing it is for a
prefetchable region or not :)

What can happen usually is that prefetchable space of PCI devices
is gathered into a separate decoding region of the north bridge wich
is allowed to do read-ahead and byte coalescing and such things...

> Even though the name might suggest it, ioremap and ioremap_nocache 
> methods are the same in function, when mapping prefetchable or 
> nonprefetchable PCI memory, with regard to (Pentium 4) processor caching 
> of this memory.
> When mapping PCI memory that needs to be accessed without using (Pentium 
> 4) processor cache, it is sufficient to use ioremap - but using 
> ioremap_nocache will not hurt.

ioremap_nocache is non portable and should die. Don't use it.

> This all confuses me, but that's OK - I have been confused before.
> The safest thing seems to be to use ioremap_nocache.
> This is what I will do.

No, just use ioremap.

> Both kmalloc and get_free_pages return a kernel logical address to 
> conventional physical memory.

Yes.

> O'Reilly Linux Device Drivers wrote (regarding a Kernel logical address):
> 
> > On most architectures, logical addresses and their associated physical 
> > address differ only by a constant offset.
> 
> I believet this to be true.

This is only true for kernel addresses allocated in low memory, this is
_not_ true for pages obtained by vmalloc.

> I can use the __pa() macro to turn my logical address in to a physical 
> address.

What for ? You are not supposed to use ioremap on a memory address.

If you intend to pass the address to some devive doing DMA, then you
need to use the pci_dma operations to get a dma_addr_t suitable
for passsing to a PCI device, which may be different than a
phsycial address, depending on the platform.

> When accessing conventional memory without involving the processor 
> cache, the only way that I (think I) know how to do this is to allocate 
> the memory in the kernel (get_free_pages) and memory map (mmap) it to a 
> process in a vma with the non-caching attribute set (as in 
> drivers/char/mem.c).

If you do that, you end up with 2 mappings, one cacheable, one non
cacheable, of the same memory. Even if you do not actually use the
cacheable one, processor prefetch may well cause lines of cache for
this mapping to get in the cache. Concurrent cacheable and non cacheable
access to the same memory area will result at best in data corruption,
at worst into CPU checkstops.

Do not do that. There is no point in making memory uncacheable. If
you are really _that_ concerned about leaving your data in the CPU
cache (which doesn't make sense to me), you can always make sure you
1) disable interrupts when playing with your critical data, 2)
flush the CPU cache, 3) re-enable interrupts. But that won't buy you
any additional security imho.

> The non-caching access must be done by the process that has done the 
> mmap using the mapped address.

mmap is for userland processes, yes. You can also use vmap for in-kernel
mappings. But as I said above, this is evil. 

> Access done using the address returned by the memory allocator 
> (get_free_pages) will be subject to processor caching.
> 
> I know of no way to perform non-cached access to conventional memory 
> other than this.
> Remapping the mmap'ed memory back into the kernel in a kiobuf results in 
> the same pages that were originally allocated and, I believe that, 
> access through the kiobuf is no different than access to the originally 
> allocated memory.
> 
> This means that there is no way (that I know of) to make non-cached 
> access to conventional memory from an interrupt handler.

Well... you could use vmap instead of mmap to create a kernel mapping
as I explained above. But I also told you why you should not do that
anyway.

Ben.


