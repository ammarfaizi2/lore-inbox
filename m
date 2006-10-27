Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945949AbWJ0Frl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945949AbWJ0Frl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbWJ0Frl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:47:41 -0400
Received: from mis011.exch011.intermedia.net ([64.78.21.10]:62251 "EHLO
	mis011.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1945949AbWJ0Frk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:47:40 -0400
Message-ID: <45419D73.1070106@qumranet.com>
Date: Fri, 27 Oct 2006 07:47:31 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
Subject: Re: [PATCH 6/13] KVM: memory slot management
References: <4540EE2B.9020606@qumranet.com> <20061026172756.D0649A0209@cleopatra.q> <200610270044.31382.arnd@arndb.de>
In-Reply-To: <200610270044.31382.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2006 05:47:39.0624 (UTC) FILETIME=[69BA8680:01C6F98B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Thursday 26 October 2006 19:27, Avi Kivity wrote:
>   
>> kvm defines memory in "slots", more or less corresponding to the DIMM
>> slots.
>>
>> this allows us to:
>>  - avoid the VGA hole at 640K
>>  - add a pci framebuffer at runtime
>>  - hotplug memory
>>
>> Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
>> Signed-off-by: Avi Kivity <avi@qumranet.com>
>>     
>
> To bring up the discussion about guest memory allocation again,
> I'd like to make a case for using defining guest real memory
> as host user, not a special in-kernel address space.
>
> You're probably aware of many of these points, but I'd like
> to list all that I can think of, in case you haven't thought
> of them:
>
> - no need to preallocate memory that the guest doesn't actually use.
>   

Well, a fully vitrualized guest will likely use all the memory it gets.  
Linux certainly will.

> - guest memory can be paged to disk.
> - you can mmap files into multiple guest for fast communication
> - you can use mmap host files as backing store for guest blockdevices,
>   including ext2 with the -o xip mount option to avoid double paging
>   

What do you mean exactly? to respond to a block device read by mmap()ing 
the backing file into the pages the host requested?

(e.g. turn a host bio read into a guest mmap)

If we allow the pages to be writable, the guest could write into the 
virtual block device just by modifying a read page (which might have be 
discarded and no longer related to the block device)

> - you can mmap packet sockets or similar to provide virtual networking
>   devices.
> - you can use hugetlbfs inside of guests
>   

This one is especially important (it also allows large pages to be used 
for kernel mapping)

> - you can mmap simple devices (e.g. frame buffer) directly into
>   trusted guests without HW emulation.
> - you can use gdb to debug the running guest address space
>   

We already do that now.

> - no need for ioctl to access or allocate guest memory
> - you can mmap a kernel image (MAP_PRIVATE) into multiple guests
>   and share instruction cache lines.
> - the kernel code doesn't need special accessors, but can use
>   asm/uaccess.h.
> - may be able to avoid a bunch of TLB flushes with nested page tables.
>   

This one is problematic.  More below.

> On the downside, I can see these points:
>
> - As you mentioned guest size on 32 bit hosts is limited to around 1G.
> - you probably have to rewrite your virtual MMU from scratch
>   

It's not that bad.  More below.

> - for optimal performance, pageable guests need something like the s390
>   pagex/pfault mechanism in the guest kernel.
> - if you want a guest not to be paged out, you need privileges to do mlock.
>   

I don't see that as a deficiency.

> - you can't use swap space in the guest if you want to avoid the
>   double paging problem (host needs to read a page from disk for the guest
>   to swap it out), or you'd have to implement a mechanism like Martin
>   Schwidefsky's page hints (cmm2) for s390.
>   

The crux of the problem is communicating host kernel vm decisions to the 
guest tlb.  There are three cases to consider:

1.  The current mmu implementation, based on emulating invlpg, mov cr3 
(the tlb flush instruction), and page faults.

Here, it is quite easy to use user pages for the guest.  On a page 
fault, get_user_page() and install the pte.  On a tlbflush or invlpg, 
transfer the dirty bit and put_page().  This automatically deals with 
multiple guest mappings for a page.

A potential problem is that the guest will lock many pages into memory, 
without any control by the kernel.  In practice, because of frequent 
guest tlb flushes, the pages will be released very often.

2. The next mmu implementation, which caches guest translations.

The potential problem above now becomes acute.  The guest will have 
kernel mappings for every page, and after a short while they'll all be 
faulted in and locked.  This defeats the swap integration which is IMO a 
very strong point.

We can work around that by periodically forcing out translations (some 
kind of clock algorithm) at some rate so the host vm can have a go at 
them.  That can turn out to be expensive as we'll need to interrupt all 
running vcpus to flush (real) tlb entries.

3. Nested page table translations, effectively doing the guest mmu in 
hardware.

I only have details of amd's implementation (I don't actually know that 
intel will have an implementation, but I can't imagine they won't compete).

AMD allows you to define a guest physical -> host physical mapping using 
the regular page table format.  Guest accesses are interpreted as 
user-mode accesses.  There is no other translation involved, so an 
access to guest physical address 0 will be translated as a user access 
to virtual address 0.

This poses a few problems to interpreting a portion of userspace as 
guest physical memory:

  a.  we need the guest physical memory to start at virtual offset 0 
(can probably be achieved by dynamic linker tricks)
  b.  we need to hide the userspace portion of the monitor from the 
guest physical address space
  c.  we need to extend host tlb invalidations to invalidate tlbs on guests

items a and b can probably be taken care of by dedicating a few pgd 
entries to the guest, and hooking host pgd entry modification to 
transfer the modified entries to a guest pgd (where they can start at 
offset 0, and not include monitor pages).

We will need to see the intel implementation when it comes out to see 
how that fits in.

Another option altogether is to allow a task to have two mm_structs, one 
for userspace and one for the guest.  This allows less messing up with 
core page table manipulations, but will require adding ways to 
manipulate this extra address space.

So, in summary:
 - definitely looks like a good direction
 - will require seeing intel nested page tables specs
 - will require intrusive changes to the Linux vm

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

