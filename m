Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261479AbTC0XXq>; Thu, 27 Mar 2003 18:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbTC0XXq>; Thu, 27 Mar 2003 18:23:46 -0500
Received: from amdext2.amd.com ([163.181.251.1]:16259 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S261479AbTC0XXh>;
	Thu, 27 Mar 2003 18:23:37 -0500
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Message-ID: <99F2150714F93F448942F9A9F112634CA54B47@txexmtae.amd.com>
From: ravikumar.chakaravarthy@amd.com
To: root@chaos.analogic.com
cc: linux-kernel@vger.kernel.org
Subject: RE: Unable to turn paging on!!
Date: Thu, 27 Mar 2003 17:34:20 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 129D550A1644510-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, 
   I tried 2 different cases. 
1. Loading and executing the kernel from 0x800000 (physical address 8M), so that the page tables are set up beyond 8M location.
2. Loading and ececuting the kernel from 0xdf000000 (physical address. This is a PCI memory card)

In the first case, I set up the initial page table entries as below
arch/i386/head.S

.org 0x1000
ENTRY(swapper_pg_dir)
        .long 0x00804007
        .fill 1,4,0
        .long 0x00802007
        .long 0x00803007
        .fill 0x2fe,4,0
        /* default: 766 entries */
        .long 0x00802007
        .long 0x00803007
        /* default: 254 entries */
        .fill 0xfc,4,0
.org 0x2000
ENTRY(pg0)

.org 0x3000
ENTRY(pg1)

/*
 * empty_zero_page must immediately follow the page tables ! (The
 * initialization loop counts until empty_zero_page)
 */

.org 0x4000
ENTRY(pg2)

I also set the memory in 0x00800400, to contain 0 ( this is for the IDT entry) and 0x00800400+0x70*4 to contain 0x70007 (this is for the GDT entry).


Arch/i386/Head.S

/*
 * Initialize page tables
 */
        movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
        movl $007,%eax          /* "007" doesn't mean with right to kill, but
                                   PRESENT+RW+USER */
        addl $0x800000,%eax
2:      stosl
        add $0x1000,%eax
        cmp $empty_zero_page-__PAGE_OFFSET,%edi
        jne 2b




This seems to work fine, after all the necessary changes in the boot loader and the kernel sources to load and execute the kernel from 0x800000 physical address.



However when I try the same now from 0xdf000000 (physical address, that's where my PCi memory card is).

It fails when the page bit is set in arch/i386/head.S
movl %eax,%cr0          /* ..and set paging (PG) bit */


I am using the x86 architecture and according to the manual there is a HWCR bit that forces all page tables to assume they are in cachable DRAM for performance reasons. I enabled it so that the hardware will look in the MTRR's/IO range registers for page table accesses. It still gives me the same error.

Following is how I setup the page table.

.org 0x1000
ENTRY(swapper_pg_dir)
        .long 0xdf004007
        .fill 0x37b,4,0
        .long 0xdf002007
        .long 0xdf003007
        .fill 0x2,4,0
        /* default: 766 entries */
        .long 0xdf002007
        .long 0xdf003007
        /* default: 254 entries */
        .fill 0x7e,4,0

I set the memory at 0xdf004000 to contain 0(IDT entry) and 0xdf004000+0x70*4 to contain 0x70007(GDT entry).

and arch/i386/head.S changes
      movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
        movl $007,%eax          /* "007" doesn't mean with right to kill, but
                                   PRESENT+RW+USER */
        addl $0xdf000000,%eax
2:      stosl
        add $0x1000,%eax
        cmp $empty_zero_page-__PAGE_OFFSET,%edi
        jne 2b




I think I am missing something specific to architecture. Any idea why??


-Ravi


-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Wednesday, March 26, 2003 2:36 PM
To: Chakaravarthy, Ravikumar
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to turn paging on!!

On Wed, 26 Mar 2003 ravikumar.chakaravarthy@amd.com wrote:

> I tweaked the kernel and boot loader to load the kernel at 0xdf000000,
> physical address. I did the following changes to setup the
> initial page table.
>
> However during boot, in arch/i386/kernel/head.S when the paging bit is set
>        movl %eax,%cr0          /* ..and set paging (PG) bit */
>
> My computer hangs!!
>
> Any idea why??
>
>   -Ravi
[SNIPPED...]
Because you can't just abitrarily change stuff around. For instance,
The PTE must be accessible as well as the GTD and the IDT when you
enable paging. In your code, you just mapped them out!
When you change the mapping, there MUST be a 1:1 physical to virtual
relationship for these descriptors. That's why they are in "low" memory.

To make this clear, let's assume you are running normally and you
want to turn the paging off. If you are at a normal virtual address,
you can't do that without crashing. You need to jump (or call) somewhere
that the physical and the virtual address are the same. Then you can
turn off paging (as long as you don't get any interrupts). Once
your EIP is at an address where there is a 1:1 correspondence
between a physical and virtual address, you can turn this off at
will. You need to turn it on before you "return".

There is nothing "magic" about low memory. You could build the GDT,
the IDT, and PTEs at 0xfff00000 and as long at the PTEs did a 1:1
mapping for this address __and__ your code that executed the mov CR0
instruction was up where there is a 1:1 mapping for the code, too.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


