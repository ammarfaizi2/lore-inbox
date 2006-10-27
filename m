Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946209AbWJ0Hh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946209AbWJ0Hh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 03:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946213AbWJ0Hh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 03:37:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:4551 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1946209AbWJ0Hh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 03:37:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 6/13] KVM: memory slot management
Date: Fri, 27 Oct 2006 09:37:11 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
References: <4540EE2B.9020606@qumranet.com> <200610270044.31382.arnd@arndb.de> <45419D73.1070106@qumranet.com>
In-Reply-To: <45419D73.1070106@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610270937.11646.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 October 2006 07:47, Avi Kivity wrote:
> Arnd Bergmann wrote:
> > - no need to preallocate memory that the guest doesn't actually use.
> >   
> 
> Well, a fully vitrualized guest will likely use all the memory it gets.  
> Linux certainly will.

Only if it does lots of disk accesses that load stuff into
page/inode/dentry cache. Single-application guests don't necessarily
do that.

> > - guest memory can be paged to disk.
> > - you can mmap files into multiple guest for fast communication
> > - you can use mmap host files as backing store for guest blockdevices,
> >   including ext2 with the -o xip mount option to avoid double paging
> >   
> 
> What do you mean exactly? to respond to a block device read by mmap()ing 
> the backing file into the pages the host requested?
> 
> (e.g. turn a host bio read into a guest mmap)

The idea would be to mmap the file into the guest real address space.
With -o xip, the page cache for the virtual device would basically
reside in that high address range.

Guest users reading/writing files on it cause a memcopy between guest
user space and the host file mapping, done by the guest file system
implementation.

The interesting point here is how to handle a host page fault on the
file mapping. The solution on z/VM for this is to generate a special
exception for this that will be caught by the guest kernel, telling
it to wait until the page is there. The guest kernel can then put the
current thread to sleep and do something else, until a second exception
tells it that the page has been loaded by the host. The guest then
wakes up the sleeping thread.

This can work the same way for host file backed (guest block device)
and host anonymous (guest RAM) memory.

> If we allow the pages to be writable, the guest could write into the 
> virtual block device just by modifying a read page (which might have be 
> discarded and no longer related to the block device)

In your virtual mmu (or nested page table), you need to make sure that
the page is mapped with the intersection of the guest vm_prot and host
vm_prot into guest users.

> 2. The next mmu implementation, which caches guest translations.
> 
> The potential problem above now becomes acute.  The guest will have 
> kernel mappings for every page, and after a short while they'll all be 
> faulted in and locked.  This defeats the swap integration which is IMO a 
> very strong point.
> 
> We can work around that by periodically forcing out translations (some 
> kind of clock algorithm) at some rate so the host vm can have a go at 
> them.  That can turn out to be expensive as we'll need to interrupt all 
> running vcpus to flush (real) tlb entries.

Don't understand. Can't one CPU cause a TLB entry to be flushed on all
CPUs?

>   a.  we need the guest physical memory to start at virtual offset 0 
> (can probably be achieved by dynamic linker tricks)

Yes, dosemu does the same for vm86.

>   b.  we need to hide the userspace portion of the monitor from the 
> guest physical address space

That depends on your trust model. You could simply say that you expect
the guest real mode to have the same privileges as the host application
(your monitor), and not care if a guest can shoot itself in the foot
by overwriting the monitor.

>   c.  we need to extend host tlb invalidations to invalidate tlbs on guests

I don't understand much about the x86 specific memory management,
but shouldn't a TLB invalidate of a given page do the right thing
on all CPUs, even if they are currently running a guest?

	Arnd <><
