Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTAYOIE>; Sat, 25 Jan 2003 09:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbTAYOIE>; Sat, 25 Jan 2003 09:08:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41290 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266434AbTAYOIC>; Sat, 25 Jan 2003 09:08:02 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kexec reboot code buffer
References: <3E31AC58.2020802@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jan 2003 07:16:27 -0700
In-Reply-To: <3E31AC58.2020802@us.ibm.com>
Message-ID: <m1znppco1w.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On my system, it appears to lock up in:
> kimage_alloc_reboot_code_pages()
> after the kexec -l.

O.k. It should come out of it eventually from what I have
seen described, the current algorithm is definitely inefficient on
your machine.
 
> I put a little printk in the loop:
>         list_for_each_safe(pos, next, &extra_pages) {
>                 struct page *page;
>                 int i;
>                 if( (listcount++%1000000) == 0 )
>                 printk("listcount:%d\n", listcount);
>                 page = list_entry(pos, struct page, list);
>                 for(i = 0; i < count; i++) {
>                         ClearPageReserved(pages +i);
>                 }
>                 list_del(&extra_pages);
>                 __free_pages(page, order);
>         }
> 
> I stopped it when it hit 1.2 billion:
> kimage_alloc_reboot_code_pages(): listcount:1213000001
> 
> First of all, this is a 16-way, 4-node NUMA-Q with 32GB of RAM.
> If the alloc_pages(GFP_HIGHUSER, order) doesn't happen on node 0,
> CPU[0-3], it will be guaranteed to get physical addresses >8GB, until
> that node is out of memory, when it will start falling other to other
> nodes' highmem.

Thanks I was afraid this might be a problem, but I was not certain
how much a practical problem it would be.  On a NUMA machine on x86
with > 4GB of memory the fact that this hangs shows it is very
definitely a problem.

> So, my real question is why you bother to allocate from HIGHMEM at all,
> when you know that you probably won't be getting what you want?  

Actually I did not know.  The common case is non-NUMA with PAE not
enabled.  In which case the odds are fairly high I will get what I
want.  And being able to allocate from 3GB instead of just 1GB is
much more polite.  The question then is how do I specify the zones
properly.

Additionally I did not start using high memory until recently when, I
rewrote my generic code.  With the rewrite it is more obvious
what I am trying to accomplish but it obviously works much less
well in the NUMA-Q corner case.  

Looking at this code a little more there is also another related
bug.  I use TASK_SIZE to figure out how large an address I can
allocate but on 64bit architectures with a 32bit subset TASK_SIZE
can be a variable instead of a constant.  For the moment I am
going to just ignore that issue as sys_kexec_load looks
like one system call that it does not make sense to emulate.  The
expected behavior on a 64bit vs. a 32bit architecture are quite
different.

> What you want is RAM with physical addresses <3GB, right?

In this case, and then later I want to allocate from physical
addresses < 4GB.  The rest of the allocations will suffer
from the same problem on the NUMA-Q.

The problem is that I have not figured out how to tell the memory
allocator just what I need, and now it has been confirmed that
with two many false positives my code takes forever.   My goal has
always been to not make kexec an undue burden on the rest of the
kernel because I am not the common case.  

Allocating DMA able memory that you can use for pci devices
has the same sort of issues.   And so far it appears there the
solution is not to allocate from memory outside of the kernels virtual
address space.  As that case is improved I may be able to ride
it's coat tails.

I guess what I want to do then is add to asm-i386/kexec.h
#ifndef HIGHMEM64G
#define GFP_KEXEC GFP_HIGHUSER
#else
#define GFP_KEXEC GFP_KERNEL
#endif

And then in kernel/kexec.c
s/GFP_HIGHUSER/GFP_KEXEC/g

That should provide a usable mechanism to control this kind of thing,
it is not perfect, but at least I will be guaranteed to get back
memory that I can use.

I wonder if it is worth it to setup a special zone and zone list for
use with kexec?

I guess I would make the standard zones something like:
/*
 * ZONE_DMA	   < 16 MB	ISA DMA capable memory
 * ZONE_NORMAL	 16-896 MB	direct mapped by the kernel
 * ZONE_PHYSMEM 896-4096 MB	memory that is accessible with the MMU disabled.
 * ZONE_HIGHMEM  > 4096MB       only page cache and user processes
 */


Or something to that effect, so I could separate out memory
below 4GB and memory above 4GB.  For the reboot code buffer it really
does not matter, as that is just one chunk of physically continuous
memory.  For the normal allocation being able to get memory anywhere
between 0-4GB on a 32bit platform is something I don't want to give
up.

Eric
