Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSJaQp1>; Thu, 31 Oct 2002 11:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSJaQn1>; Thu, 31 Oct 2002 11:43:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15746 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262653AbSJaQl5>; Thu, 31 Oct 2002 11:41:57 -0500
Date: Thu, 31 Oct 2002 11:50:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: need h/e/l/p:  PM -> RM in machine_real_start
In-Reply-To: <200210311430.g9VEUh3p014195@wildsau.idv.uni.linz.at>
Message-ID: <Pine.LNX.3.95.1021031112938.12292A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, H.Rosmanith (Kernel Mailing List) wrote:

>  
> hello,
> 
> arch/i386/kernel/process.c exports a "machine_real_start" function, which
> can be used to execute arbitary 16bit realmode code. I've got this to
> work so far, by writing a small helper-module which copies 16bit code
> supplied from userland and passes it to "machine_real_start", which in
> turn, after switching to real mode, executes that particular code.
[SNIPPED...]

> 
> what is needed is the BIOS. I wonder if it is at all possible to use
> the BIOS again after linux once had run without jumping to 0xffff:0
> does linux make use of the memory at 0x40? I'm pretty sure that it
> will be possible to e.g. invoke 0x10 (video), since that is located
> in ROM, but what about RAM. does linux make use of <1Mb area anyway,
> that is, 2^20 (A20) the area which can be addresses with 20 bits of
> address-lines (4bit segreg + 16bit offset).
>

The BIOS is most-likely shadowed at 0x000f0000, what you see is
not the BIOS ROM. The BIOS ROM exists at 0xfffff000, on some
as low as 0xffffe000, to start execution at 0xfffffff0, and can only
be accessed in 32-bit mode or after a reset-event when the CS
descriptor cache contains 0xffff. The first load of the CS resets
these bits.

Linux leaves the BIOS area alone, but interrupts may not be directly
usable because Linux loads a different IDT and reprograms the IO-APIC,
which is used in place of the interrupt controller if it exists.

You need to reload the IDT once in real-mode. Documentation states
that it is "ignored", but the reload is necessary to get the default
interrupt-table to work. I think you can just reload with any memory
operand (reload junk). If you were transitioning from real to 32-bit
and back, you would save the current one "SIDT", before loading the
32-bit one "LIDT". Since you don't know where the previous one was saved,
(if ever) you can't reload it.


> well, BIOS is one thing, hardware is another. I seem not to be able
> to get *any* interrupt, allthough I really tried in various ways.
> write an ISR which increments a character in the upper left corner,
> modify all 256 interrupt vectors to point to the ISR, re-enable interrupts,
> (sti), unmask all interrupts (out 0x21,0; out 0xa1,0). but no matter
> what I do - press a key (IRQ1) or program 8253 (IRQ0) - I just can't
> see the ISR is being called.
>

Whatever interrupt controllers are used, they are programmed differently
in Linux than the BIOS expects. You would need to reprogram them, not
difficult, just a few instructions (check free-BIOS) or other references.

> I also seem to have a very obsolete paper the port assignment of the
> PC. do you know of any sources (perferrably on the web) which gives
> a complete overview of portadresses used by the PC?

Check free-BIOS


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


