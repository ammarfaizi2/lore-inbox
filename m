Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267080AbRGJSqQ>; Tue, 10 Jul 2001 14:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbRGJSp4>; Tue, 10 Jul 2001 14:45:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13953 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267082AbRGJSpr>; Tue, 10 Jul 2001 14:45:47 -0400
Date: Tue, 10 Jul 2001 14:45:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jonathan Lundell <jlundell@pobox.com>
cc: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <p05100312b770f20411a0@[207.213.214.37]>
Message-ID: <Pine.LNX.3.95.1010710142459.19170A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Jonathan Lundell wrote:

> At 1:35 PM -0400 2001-07-10, Richard B. Johnson wrote:
> >Unlike some OS (like VMS), a context-switch does not occur
> >when the kernel provides services for the calling task.
> >Therefore, it was most reasonable to have the kernel exist within
> >each tasks address space. With modern processors, it doesn't make
> >very much difference, you could have user space start at virtual
> >address 0 and extend to virtual address 0xffffffff. However, this would
> >not be Unix. It would also force the kernel to use additional
> >CPU cycles when addressing a tasks virtual address space,
> >i.e., when data are copied to/from user to kernel space.
> 
> Certainly the shared space is convenient, but in what sense would a 
> separate kernel space "not be Unix"? I'm quite sure that back in the 

I explained why it would not be Unix.


> AT&T days that there were Unix ports with separate kernel (vs user) 
> address spaces, as well as processors with special instructions for 

No. The difference between kernel and user address space is protection.
Let's say that you decided to revamp all the user space to go from
0 to 2^32-1. You call the kernel with a pointer to a buffer into
which you need to write kernel data:

You will need to set a selector that will access both user and
kernel data at the same time. Since the user address space is
paged, this will not be possible, you get one or the other, but
not both. Therefore, you need to use two selectors. In the case
of ix86 stuff, you could set DS = KERNEL_DS and ES = a separately
calculated selector that represents the base address of the caller's
virtual address space. Note that you can't just use the caller's
DS or ES because they can be changed by the caller.

Then you can move data from DS:OFFSET to ES:OFFSET, but not the
other way. If you need to move data the other way, you need DS: = a
separately calculated selector that represents the base address of the
caller's virtual address space, and ES = KERNEL_DS. Then you can copy from
ES:OFFSET to ES:OFFSET (as before), but the data goes the other way.

With the same virtual address space for kernel and user, you
don't need any of this stuff. The only reason we have special
functions (macros) for copy to/from, is to protect the kernel
from crashing when the user-mode caller gives it a bad address.

It all tasks were cooperative, you could use memcpy() perfectly
fine (or rep movsl ; rep movsw ; rep movsb).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


