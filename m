Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313487AbSDEU0p>; Fri, 5 Apr 2002 15:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313493AbSDEU0Z>; Fri, 5 Apr 2002 15:26:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313487AbSDEU0Q>; Fri, 5 Apr 2002 15:26:16 -0500
Date: Fri, 5 Apr 2002 15:27:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: halfdead <halfdead@daphnes.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: weird IDT issue
In-Reply-To: <Pine.LNX.4.33.0204052125250.15770-100000@daphnes.ro>
Message-ID: <Pine.LNX.3.95.1020405150455.1257A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, halfdead wrote:

> hey! i experience a weird IDT issue on kernels 2.4.x. what i want to do is
> finding the address of a certain IDT gate but when i try to read memory
> from ring0 at that location it segfaults. the code is in assembler.
> 
> .bss
> idtr:
> .double
> .text
> 
> get_gate:
> 	movl	$0x80, %eax
> 	sidt	idtr

# Store contents of IDT into idtr, in space you own. Okay so far even
though '.double' isn't correct. It should be:

.section .bss
idtr:	.long[2]
.section .text

> 	movl	idtr+2, %ebx

This should put the PHYSICAL address of the base into ebx.

> 	leal	(%ebx, %eax, 8), %ebx

Now you are going to sum the physical address in ebx with 0x80 and 8
index, putting the result into ebx. Hmmm...

> 	movw	(%ebx), %cx 	<- segfault
> 

Now you are going to access something in some strange location that
is either not mapped or you don't own.

> i cannot find out why is this happening.. i would apreciate any help that
> i can get.
> 
> - halfdead
> 

In the first place, addresses in the IDT are physical. They are mapped
in an area where there is a 1:1 correspondence between virtual and
physical. You either need to set DS to that descriptor before you
access (where the page-table is, I forget its name) it or mmap that
address so you can access it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

