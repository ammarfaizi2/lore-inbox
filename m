Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277129AbRJDUdA>; Thu, 4 Oct 2001 16:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277212AbRJDUcv>; Thu, 4 Oct 2001 16:32:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277129AbRJDUcj>; Thu, 4 Oct 2001 16:32:39 -0400
Date: Thu, 4 Oct 2001 16:32:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ian Thompson <ithompso@stargateip.com>
cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: RE: How can I jump to non-linux address space?
In-Reply-To: <NFBBIBIEHMPDJNKCIKOBEEIACAAA.ithompso@stargateip.com>
Message-ID: <Pine.LNX.3.95.1011004155938.1774A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Ian Thompson wrote:

> Helge,
> 
> Thanks for your advice!  It's brought up a couple of other question, if you
> don't mind:
> 
> > The kernel can get to know - all you need is code that maps the
> > ROM address range into some available virtual address range.
> > Look at device driver code - they do such mapping for ROM and/or
> > memory-based io regions.
> 
> I've seen the mapping of the single RAM address range, but I don't see where
> it is possible to add in another range for ROM.  What functions should I
> look for that do this mapping?
> 
> > Do that ROM code work when the MMU has remapped its adresses so it
> > appears at some adress completely different from the bus address?  (only
> > if it contains relative jumps only - no absolute addresses.) Does
> > it work with 4G segments?  Does it work at all in protected mode,
> > with all interrupts routed to the linux kernel instead of the bios?
> > Does this code expect to find something (data, device interfaces,
> > vga memory) at certain addresses?  If so, this must be mapped too.
> 
> I've run this code (in ROM) successfully before starting the kernel.  I
> believe the cache is disabled, and interrupts are not needed (and are off).
> The code does not refer to anything within the kernel.  I've tried turning
> off the MMU completely before branching, but this seems to hang the system.
> =(
> 
> Any ideas of what I should look for to turn off, aside from just shutting
> down the MMU?  If I map the ROM address range into a virtual addr range,
> won't I run into problems once I'm running the code, such as physical
> addresses being interpreted by virtual ones?
> 
> btw, this is running on an XScale (strongARM).
> 
> Thanks again,
> -ian

All kernel addresses, including "physical" addresses are virtual.
There is a PTE to map your specific memory area, on a page-by-page
basis, to a virtual address. You are normally accessing memory
using that virtual address (both code and data).

If you want to turn OFF the virtual addressing, you have to first
jump or call a procedure, that is properly relocated, somewhere
that the virtual and physical addresses are the same. The first
one megabyte is such a location. It is complex and has to be done
in the correct order or else you can't "get back".

A typical way, on an ix86, is to make a binary array from the code
you want to execute, relocated from an object file, to some offset
such as 0x1000.

You use ioremap() to create a virtual address from 0x1000. Then
you copy the relocated code, currently in some array, to the relocated
address (0x1000), using the cookie returned from ioremap(). Then you
disable interrupts on your local CPU via a spinlock, you make a long
(FAR) call to your relocated code. In the code, you can disable the paging
bit and set DS, ES to the page-table selector, which looks at linear
addressing. Now you can see and access everything as 32-bit linear
address-space. Careful, you can't allow interrupts and you can't use the
stack because neither it, nor the stack-selector has been set. You can
do "your" thing, with global memory then you restore the previous
selectors to DS and ES, re-enable paging, then do a FAR return.
The code after the return unlocks the spin-lock and you are
home free.

I any step isn't done correctly, you will crash the processor ;^).
This shows up as though you hit the reset switch.

# insmod module.o <SPLAT> <FLASH>
Award Modular BIOS V45pg Copyright(c) 1998 Award Software, Inc.
Memory test : 0011240 Ok
Pres DEL to enter SETUP


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


