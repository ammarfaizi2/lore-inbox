Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292216AbSBTTOH>; Wed, 20 Feb 2002 14:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292217AbSBTTOD>; Wed, 20 Feb 2002 14:14:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9860 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292216AbSBTTNu>; Wed, 20 Feb 2002 14:13:50 -0500
Date: Wed, 20 Feb 2002 14:16:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jason Yan <jasonyanjk@yahoo.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: paging question
In-Reply-To: <20020220182600.PTIU27257.tomts11-srv.bellnexxia.net@abc337>
Message-ID: <Pine.LNX.3.95.1020220134323.9669A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Jason Yan wrote:

> Hi,
> 
> I have a question about the code to enable  to initialize page 
> tables in linux/arch/i386/head.S
> 
> I search the internet again and again but fail to find any answer
> so far, maybe you gurus can help me out, here it goes:
> 
> 48         cld
> 49         movl $(__KERNEL_DS),%eax
> 50         movl %eax,%ds
> 51         movl %eax,%es
> 52         movl %eax,%fs
> 53         movl %eax,%gs
> 81 /*
> 82  * Initialize page tables
> 83  */
> 84         movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
> 85         movl $007,%eax  /* "007" doesn't mean with right to kill, but
> 86                                    PRESENT+RW+USER */
> 87 2:      stosl
> 88         add $0x1000,%eax
> 89         cmp $empty_zero_page-__PAGE_OFFSET,%edi
> 90         jne 2b
>    
> I remove the SMP code.  According the setup.S, gdt_table is setup as
> gdt_table:		
> 			#.quad 0x0000000000000000;	// null
> 			#.quad 0x0000000000000000;	// not used
> 			#.quad 0x00cf9a000000ffff;	// 0x10 kernel 4GB code at 0x00000000
> 			#.quad 0x00cf92000000ffff;	// 0x18 kernel 4GB data at 0x00000000
> 
> 1) So, what's in %eax after line 49 ?  0x0 ?
> 2) Isn't __PAGE_OFFSET 0xC0000000 ? what's the result of $pg0-__PAGE_OFFSET ?
> 
> Thanks,
> 
> Jason

The discriptor for the segments are in the gdt_table. They each consist
of a start a length a type and a granularity. They are not NUMBERS. They
are parameters that the CPU understands. They define the linear address
space, to be accessed, and the protections for that address space. They
have nothing to do with paging.

The GDT element, so defined, is called a selector or a segment. Each
of the elements is a guad-word. The offset, neglecting the first
element is 0x18 for the data-segment. Therefore KERNEL_DS is really
0x18. This is loaded into a register (%eax), and then loaded into
the relevant segments. You can't load a segment register directly
with a value. You have to transfer the contents of another register
or memory into that segment.

Paging, is different. First somewhere there has to be a 1:1 translation
of physical to virtual addresses so that the kernel can always access
page-tables. These page-tables are some place where there is such a
correspondance. Then, every page that exists, anywhere, has a page-table
entry. These PTEs can be marked as present or not to generate traps
(page faults). The PTEs allow any physical chunk of memory (page) from
anywhere, to be mapped into a processes virtual address space. The mapping
creates, in addition to a 0->ffffffff virtual address range for every
process, a boundary, called PAGE_OFFSET. To user-mode programmers, it
doesn't exist. Only in kernel-mode does it mean anything and, in fact,
macros have been defined to hide its meaning. In the Intel machines, the
kernel uses virtual addresses just like processes do. However, above the
address-range where there is a 1:1 virtual:physical address translation,
the virtual address comes out to be virtual = physical | PAGE_OFFSET. You
should never use this knowledge in any module or you will find that
it will break (and you get to keep the pieces) when new kernel versions
are available.

> 2) Isn't __PAGE_OFFSET 0xC0000000 ? what's the result of $pg0-__PAGE_OFFSET ?
If my hex-math is correct,  bff00000.  But don't use numbers. Let the
compiler/assembler do the math between labels. That way, you can add stuff
and it still works.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

