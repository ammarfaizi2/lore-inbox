Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSFTPkL>; Thu, 20 Jun 2002 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSFTPkK>; Thu, 20 Jun 2002 11:40:10 -0400
Received: from chaos.analogic.com ([204.178.40.224]:33411 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315171AbSFTPkH>; Thu, 20 Jun 2002 11:40:07 -0400
Date: Thu, 20 Jun 2002 11:42:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: devnull@adc.idt.com
cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: >3G Memory support
In-Reply-To: <Pine.GSO.4.31.0206201010340.13158-100000@bom.adc.idt.com>
Message-ID: <Pine.LNX.3.95.1020620110247.20919A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002 devnull@adc.idt.com wrote:

> > >
> > > When i compiled my kernel, i set CONFIG_HIGHMEM4G.
> > >
> > > Does this mean that all my programs should be able to address 4G ?
> >
> > No.  It means the kernel can access all 4GB of memory.  For memory above
> > the 950MB that it can directly map, it needs to use dynamic mappings
> > (kmap).  User space is always 3GB virtual space per process, regardless
> > of the highmem setting.
> 
> Is there a way to make a process in the user space to able to access 4GB
> at all. What limits user space to 3GB.
> 
> If not in current 2.4.x / 2.5.x, is this something planned in the future
> releases ?
> 
> Thanks for your time.

The Intel 32-bit processors provide 32-bit virtual address space which
is, in Unix/Linux machines, shared between the kernel and the process.

If you add address space to the process, you need to take it away from
the kernel and vice-versa. The result is that each process gets its own
data and (usually) code, but shares the kernel. Each process also gets
to share, via memory-mapping, major portions of runtime-libraries like
the 'C' runtime library. Even though code is shared, it takes up
address-space.

The kernel can use RAM that does not exist in the 'lower 32-bits' to
satisfy virtual RAM. This is the "High memory" option. Nevertheless,
a task ends up with 32-bits of address space.

The "fix" is to either wait for 64-bit machines, at which time users
will complain that they can't address all 64 bits, or re-do the kernel
as a VAX/VMS kind of virtual memory system.

It is, in principle, possible for user virtual address space to range
from 0 to 0xffffffff. The kernel could have its own virtual address
space which is not shared at all. The problem is there is only one
set of page tables on Intel machines. You would have to make two, or
more, in an area where there is a 1:1 virtual to physical address-
translation, you would have to transition to that area, disable paging,
flush the cache, load the kernel page-tables, enable paging, then
call/execute kernel code every time you made a kernel system call.
Oh yes, you have to do the reverse to return control to the user who
called the kernel code. Copying data to/from kernel space would be
a bear. The physical address of any user buffer would have to be
mapped into the kernel's address space (like a mailbox), on the off-
chance that the kernel might need to access it. Nasty.

This would make system calls take milliseconds instead of microseconds.

FYI, you can explore user-address possibilities with simple 'C' code:

#include <stdio.h>
char data;
int main()
{
  char stack;
  unsigned long avail;

  avail = 0xffffffff - (long)&stack;
  printf("Address available above stack %08lx\n", avail);
  avail = 0xffffffff - (long)&data;
  printf("Address available above data %08lx\n", avail);
  avail = 0xffffffff - (long)main;
  printf("Address available above code %08lx\n", avail);
}




Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

