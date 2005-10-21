Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVJUTpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVJUTpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 15:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVJUTpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 15:45:35 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:65297 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965130AbVJUTpe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 15:45:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <94e67edf0510210922l7c4ab3can8cef0f34cdc2a0fd@mail.gmail.com>
References: <94e67edf0510210922l7c4ab3can8cef0f34cdc2a0fd@mail.gmail.com>
X-OriginalArrivalTime: 21 Oct 2005 19:45:33.0070 (UTC) FILETIME=[FFC85AE0:01C5D677]
Content-class: urn:content-classes:message
Subject: Re: XIP probelm
Date: Fri, 21 Oct 2005 15:45:32 -0400
Message-ID: <Pine.LNX.4.61.0510211518330.14869@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: XIP probelm
Thread-Index: AcXWd//S4ghKUqI6Tiy0vkl1IUbRsw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Sreeni" <sreeni.pulichi@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Oct 2005, Sreeni wrote:

> Hi,
>
> I have a montavista XIP kernel running on ARM and my kernel will be in
> the flash. Since its XIP, I know that the ".text" portion of the
> kernel will be executed from flash but that ".data" needs to be placed
> in SDRAM. Now my question is - based on what offset this data will be
> placed?
>
> My SDRAM physicall address starts at 3000_0000 and flash starts at
> 0100_0000. when i allocated a global variable in the kernel module and
> when i try to check its actually physical address using virt_to_phys,
> its giving me the address in the range of 0100_0000 ~ 0600_0000 which
> is my flash (the PAGE_OFFSET doesn't work in case of XIP).
>
> Can you please help in knowing the physical address of my .data
> portion in this situation.
>
> Thanks
> Shree
>

I don't know about the ARM in particular, but if you look
in ../arch/arm/boot/compressed/vmlinux.lds.in, you will see
that this linker-file simply allocates the start addresses
of each section as the next available address. The same
is true of ../arch/arm/boot/bootp.lds. If you expect to
have code the data elements and stack accessed at a
specific physical offset, you modify the linker files().

Note that "." means "right here", just like '$' in many
assemblers. You can specify a physical offset simply
as:

ENTRY(_start)
SECTIONS
{
   . = 0x01000000  <== like this for code
   .text : {
    ...
    ... }
    .rodata : { }
    . = 0x30000000 <== like this data
    .data : {  }
    .bss  : {  }
}

In the above, we have put .rodata (initialized ASCII stuff)
right after the code in the .text section. You may need to
extract this from the binary blob to put into your NVRAM.

Also, any initialzed data needs to be relocated to your
writable SDRAM and the .bss stuff needs to be zeroed.
This is non-trivial. You may want to create a ".reloc"
section which contains your initialized data, put it
in your flash, and relocate it at startup.

Basically executing-in-place is BAD. Flash should exist
in some little window where the code gets sucked out,
loaded at the correct offset in RAM, then you jump
there and close the little window. RAM, even SDRAM,
is cheaper than NAND FLASH. You can boot instantly
even as I have shown.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
