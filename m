Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbUB0PhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 10:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUB0PhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 10:37:05 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:27304 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262991AbUB0Pg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 10:36:56 -0500
Message-ID: <403F6413.80800@raytheon.com>
Date: Fri, 27 Feb 2004 07:36:51 -0800
From: Ross Tyler <retyler@raytheon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: how does one disable processor cache on memory allocated with
 get_free_pages?
References: <403E1DF1.9060901@raytheon.com> <1077879093.22215.328.camel@gaston>
In-Reply-To: <1077879093.22215.328.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote (more below):

>What are you trying to do exactly ?
>  
>
Thanks Ben.

Sorry, I can't tell you ... exactly.
Suffice to say, it is something very spooky.
My customer is very concerned about what I am writing to and reading 
from memory and where it ends up on the way.
To address these concerns, I need to make sure that processor cache is 
not used for some sensitive data.
I have sensitive data in (prefetchable and nonprefetchable) memory on 
some PCI devices and some in conventional memory.

My understanding so far (somebody, __please__ correct me if I am wrong) ...

O'Reilly Linux Device Drivers wrote (regarding ioremap_nocache):

> Quoting from one of the kernel headers: "It's useful if some control 
> registers are in such an area and write combining or read caching is 
> not desirable." Actually, the function's implementation is identical 
> to ioremap on most computer platforms: in situations in which all of 
> I/O memory is already visible throught noncacheable addresses, there's 
> no reason to implement a separate, noncaching version of ioremap.

O'Reilly Linux Device Drivers wrote (regarding PCI (non)prefetchable 
memory):

> The PCI device that implements I/O registers as a memory region marks 
> the difference by settings a "memory-is-prefetchable" bit in its 
> configuration register. If the memory region is marked as 
> prefetchable, the CPU can cache its contents and do all sorts of 
> optimization with it; nonprefetchable memory access, on the other 
> hand, can't be optimized because each access can have side effects, 
> exactly like I/O ports usually have.

Even though the name might suggest it, ioremap and ioremap_nocache 
methods are the same in function, when mapping prefetchable or 
nonprefetchable PCI memory, with regard to (Pentium 4) processor caching 
of this memory.
When mapping PCI memory that needs to be accessed without using (Pentium 
4) processor cache, it is sufficient to use ioremap - but using 
ioremap_nocache will not hurt.

This all confuses me, but that's OK - I have been confused before.
The safest thing seems to be to use ioremap_nocache.
This is what I will do.

Both kmalloc and get_free_pages return a kernel logical address to 
conventional physical memory.

O'Reilly Linux Device Drivers wrote (regarding a Kernel logical address):

> On most architectures, logical addresses and their associated physical 
> address differ only by a constant offset.

I believet this to be true.
I can use the __pa() macro to turn my logical address in to a physical 
address.

When accessing conventional memory without involving the processor 
cache, the only way that I (think I) know how to do this is to allocate 
the memory in the kernel (get_free_pages) and memory map (mmap) it to a 
process in a vma with the non-caching attribute set (as in 
drivers/char/mem.c).
The non-caching access must be done by the process that has done the 
mmap using the mapped address.
Access done using the address returned by the memory allocator 
(get_free_pages) will be subject to processor caching.

I know of no way to perform non-cached access to conventional memory 
other than this.
Remapping the mmap'ed memory back into the kernel in a kiobuf results in 
the same pages that were originally allocated and, I believe that, 
access through the kiobuf is no different than access to the originally 
allocated memory.

This means that there is no way (that I know of) to make non-cached 
access to conventional memory from an interrupt handler.

Benjamin Herrenschmidt wrote:

>On Fri, 2004-02-27 at 03:25, Ross Tyler wrote:
>  
>
>>Andrew,
>>
>>Thank you for taking the time to reply. I really appreciate your help.
>>
>>My understanding of ioremap_nocache is that it falls short of what I 
>>need to do.
>>It is appropriate for, say, mapping physical memory on a PCI device that 
>>is marked prefetchable (and otherwise subject to caching when mapped 
>>with ioremap) as non-caching.
>>Can you confirm my understanding?
>>    
>>
>
>No, ioremap always maps non-cacheable, this has nothing to do with
>the prefetching attribute
>
>  
>
>>If so, it will not work for me as I am not mapping physical memory but 
>>memory allocated by get_free_pages.
>>Do you concur?
>>    
>>
>
>get_free_pages() returns you physical memory...
>
>  
>
>>AFAIK, the only way to access this memory without using processor cache 
>>is to have a device driver memory map it for a process like 
>>drivers/char/mem.c does.
>>When the memory is accessed through these memory mapped pages, the 
>>access will not be cached.
>>When the memory is accessed through the get_free_pages pages, the access 
>>will be cached.
>>Concur?
>>    
>>
>
>get_free_page allocates cacheable physical memory, nothing to do
>with your PCI device... ioremap maps your device non-cacheable
>into the kernel address space.
> 
>  
>
>>In order to access this process mapped memory from outside the context 
>>of the process it was mapped for, one either needs to independently 
>>remap it for the current process (what to do in interrupt code?) or set 
>>up a kiobuf to the memory.
>>It has been my experience, however, that the pages referenced by the 
>>kiobuf are the same pages returned by get_free_pages.
>>I expect these same pages have the same (caching) attributes associated 
>>with them which would not work.
>>    
>>
>
>What are you trying to do exactly ?
>
>Ben.
>
>
>  
>


