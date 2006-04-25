Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWDYUaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWDYUaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWDYUaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:30:25 -0400
Received: from bay101-f11.bay101.hotmail.com ([64.4.56.21]:50414 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932153AbWDYUaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:30:24 -0400
Message-ID: <BAY101-F118C89513BC38408E90CDAF4BF0@phx.gbl>
X-Originating-IP: [70.132.20.2]
X-Originating-Email: [djanssen1@hotmail.com]
In-Reply-To: <5.1.0.14.2.20060425130439.00bc0008@exchange.plxtech.com>
From: "Sam Abu-Nassar" <djanssen1@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Using remap_pfn_range causes system hang on app close in 2.6.15 & up
Date: Tue, 25 Apr 2006 20:30:23 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 25 Apr 2006 20:30:24.0473 (UTC) FILETIME=[14D15C90:01C668A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I posted this query a couple of weeks ago regarding a problem with 
remap_pfn_range.  I was able to resolve the issue and I thought I would post 
my findings in case it helps someone else or results in a kernel fix.  I 
will try to keep this short.

In a nutshell, my driver support user APIs that maps system RAM or a PCI BAR 
space to user space.  What I did not mention in my original post is that my 
driver performed a sort of custom protocol when mmap() is called.  Since 
mmap() really only provides a limited amount of space (the offset field) 
that I can use to pass additional information to my driver, I had 
implemented a custom protocol, which works as follows:

1.  API calls mmap to obtain a user virtual address
2.  Drivers mmap routine stores the VMA in an internal list and returns ok.
3.  API then issues a custom IOCTL to driver to complete mapping with 
additional info
4.  Driver retrieves VMA from internal list and performs mapping with 
io/remap_pfn_range, depending upon whether it's to system RAM or a PCI BAR.

The mappings always work fine, but starting with 2.6.15, the system freeezes 
when the file descriptor is closed.  I tried numerous tests and compared my 
code with existing drivers, such as /dev/mem.  Here is what I found:

The fix involved moving my calls to io/remap_pfn_range into my 
Dispatch_mmap() routine.  Once I did this, the system no longer crashed.  I 
still implement sending some custom information to the driver, but now I use 
special values in the offset field, remembering that the offset is 
eventually shifted by PAGE_SIZE by the time it reaches the driver.  My 
driver code essentially did not change.  In effect, all I really did was 
move it to the driver's mmap() routine.

I should mention that my original protocol has worked fine in kernels 2.2, 
2.4, and up to 2.6.14.  Some change to the VM subsystem in 2.6.15 broke my 
original code.  I don't believe there should be an issue with calling 
remap_pfn_range outside of the driver's mmap() routine, but I am not a 
kernel developer, so I could be wrong in my assumption.  One of my customers 
posed this question to Nick Piggin, and he seemed to think there should not 
be a problem with this.

Hope this helps,

-Sam Abu-Nassar

>I currently have a module for a PCI device that maps system memory to user
>space with remap_pfn_range().  The system memory is acquired through
>dma_alloc_coherent (i.e. __get_free_pages).  The driver works fine on all
>2.4 kernels and all 2.6 kernels up to 2.6.14.  The failure seems to only
>occurs on 2.6.15 & up.
>
>The issue occurs when the application exists and/or the file descriptor is
>closed if the application maps the RAM buffer.  Sometimes kernel log
>messages appear regarding the page _mapcount being invalid (-1).  So, it
>must be when the VMM attempts to release page mappings.  Generally, the
>system hangs and sometimes, after a moment or two, a kernel panic message
>arises (see below).
>
>I am able to avoid the issue if my module does not call remap_pfn_range().
>I realize that there were some significant changes in this function in
>kernel 2.6.15, but I can't see what I am doing wrong.  I've tried various
>tests, all with the same result, including:
>
>- Removing the VM_RESERVED flag (remap_pfn_range sets it anyway)
>- Tried setting & not setting PG_reserved on the allocated pages
>- Tried setting & not setting PG_locked on the allocated pages
>- Tried holding the mmap semaphore during the call to remap_pfn_range
>
>I've checked the parameters to remap_pfn_range and they seem to be ok.
>There are no alignment issues and the physical address is page shifted.  
>The
>VMA is passed pretty much directly from mmap().
>
>I'm pretty sure the changes in 2.6.15 with remap_pfn_range are causing 
>this.
>   I've read through the logs regarding the changes and about the new
>vm_insert_page() function, but it is my understanding that remap_pfn_range
>should still work ok for my case.  All my driver needs to do here is to
>simply map contiguous system pages to user space.
>
>Has anyone else run into issues with using remap_pfn_range and kernels
>2.5.15 & up?  Are there any new special requirements for using this in a
>module.  I've looked at the /dev/mem mmap code and I do not see anything
>obviously different from my code.  I appreciate any comment/suggestions you
>may have
>
>Thanks in advance,
>
>-Sam Abu-Nassar
>
>Here is some more info and the code snip:
>
>KERNEL LOG
>-------------------
>Line 555 in rmap.c is where the kernel panic is:
>http://www.kernel.org/hg/linux-2.6/?f=106a2be54bb7;file=mm/rmap.c
>
><0>Eeek! page_mapcount(page) went negative! (-1)
><0>  page->flags = 80000404
><0>  page->count = 1
><0>  page->mapping = 00000000
><0>------------[ cut here ]------------
><0>kernel BUG at mm/rmap.c:560!
><0>invalid opcode: 0000 [#1]
><1>last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed
><4>Modules linked in: Pci9656_dbg(U) autofs4 hidp rfcomm l2cap
>bluetooth sunrpc
>dm_mirror dm_mod video button battery ac ipv6 lp parport_pc parport
>floppy nvram
>ehci_hcd uhci_hcd sky2 snd_via82xx gameport snd_ac97_codec
>snd_ac97_bus snd_seq
>_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss
>snd_pcm
>snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device
>i2c_viapro s
>nd i2c_core soundcore ext3 jbd
><0>CPU:    0
><4>EIP:    0060:[<c014852d>]    Not tainted VLI
><4>EFLAGS: 00010286   (2.6.15-1.2054_FC5 #1)
><0>EIP is at page_remove_rmap+0x63/0x7b
><0>eax: ffffffff   ebx: c15e7a00   ecx: ef1fcee8   edx: c02fbeaf
><0>esi: b7f97000   edi: ee564e5c   ebp: 00000020   esp: ef1fcef4
><0>ds: 007b   es: 007b   ss: 0068
><0>Process Test (pid: 3493, threadinfo=ef1fc000 task=f7ca5000)
><0>Stack: <0>c15e7a00 c0142db5 00000000 f6b12cd4 ef1fcf60 00340efa
>00000000 0000
>0001
><0>       b7fa7000 ef49bb7c f6af1500 c03e022c 00000000 ffffffff
>f6af1554 ef49bb7
>c
><0>       b7fa7000 00000000 ef1fcf60 f6af690c f6af1500 ef1fcfa0
>c0145644 fffffff
>f
><0>Call Trace:
><0> [<c0142db5>] unmap_vmas+0x285/0x48d     [<c0145644>]
>exit_mmap+0x50/0xc0
><0> [<c01184bd>] mmput+0x1c/0x8f     [<c011d012>] do_exit+0x1a5/0x6c8
><0> [<c011d5b9>] sys_exit_group+0x0/0xd     [<c0102bc1>]
>syscall_call+0x7/0xb
>
>
>CODE SNIP
>---------------
>Buffer Allocation Code
>======================
>     // Allocate system buffer
>     pMemObject->pKernelVa =
>         dma_alloc_coherent(
>             pdx->pPciDevice->dev,
>             pMemObject->Size,     // 64k
>             &BusAddress,
>             GFP_KERNEL | __GFP_NOWARN
>             );
>
>     // Store the bus address
>     pMemObject->BusPhysical = (U64)BusAddress;
>
>     // Tag all pages as reserved
>     for (....)
>         SetPageReserved( virt_to_page(virt_addr) );
>
>     // Get CPU physical address of buffer
>     pMemObject->CpuPhysical = virt_to_phys( pMemObject->pKernelVa );
>
>
>Buffer Mapping Code in mmap()
>=============================
>
>     // Get CPU physical address of buffer
>     AddressToMap = pMemObject->CpuPhysical;
>
>     // Set the region as reserved
>     vma->vm_flags |= VM_RESERVED;
>
>     // Map system memory
>     rc =
>         remap_pfn_range(
>             vma,
>             vma->vm_start,
>             AddressToMap >> PAGE_SHIFT,
>             vma->vm_end - vma->vm_start,
>             vma->vm_page_prot
>             );


