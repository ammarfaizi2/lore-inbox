Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUAHTFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUAHTFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:05:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42883 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265501AbUAHTFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:05:44 -0500
Date: Thu, 8 Jan 2004 14:08:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ryan Underwood <nemesis-lists@icequake.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI parport irq sharing?
In-Reply-To: <20040108181615.GA20930@dbz.icequake.net>
Message-ID: <Pine.LNX.4.53.0401081340240.25165@chaos>
References: <20040108181615.GA20930@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004, Ryan Underwood wrote:

>
> Hi,
>
> Does parport_pc have the capability to share IRQs?  I have a PCI
> parallel card with two ports on it:
>
> parport0: PC-style at 0x3bc (0x7bc), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> parport1: PC-style at 0xc400 (0xc800), irq 9, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
> parport1: irq 9 in use, resorting to polled operation
> parport2: PC-style at 0xcc00 (0xd000) [PCSPP,TRISTATE]
>
> parport0 is the mb's builtin parallel port, and parport1/parport2 are
> the two ports on the PCI card.  IRQ 9 is taken by USB already.  But
> since it's a modern PCI card, it would stand to reason that it should be
> able to share the IRQ with another PCI device, no?  Unfortunately, my
> application requires interrupt-driven operation.
>
> /proc/interrupts:
> CPU0
>   0:     276501          XT-PIC  timer
>   1:       1196          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   7:          7          XT-PIC  parport0
>   8:          4          XT-PIC  rtc
>   9:    2724988          XT-PIC  acpi, usb-ohci
>  10:       8745          XT-PIC  eth0
>  11:          0          XT-PIC  CMI8738-MC4
>  12:          0          XT-PIC  PS/2 Mouse
>  14:      16219          XT-PIC  ide0
>  15:         29          XT-PIC  ide1
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
>
> Kernel 2.4.24
>
> thanks,
>
> --
> Ryan Underwood, <nemesis@icequake.net>
>

To share interrupts requires that the interrupting device
generate a level instead of an edge. The parallel ports
that exist in "super I/O chips" and in bare boards, produce
edges. If you have a special parallel port in a PCI slot, it
should generate levels because the PCI specification demands
that it does.

Since IRQ7 (the dedicated, edge, ISA parallel port interrupt)
should never go to any PCI slot, I don't see how it could
ever report using that. Perhaps it's a bug or the BIOS allowed
it to be configured that way (remove IRQ7 from the PCI bus).
This should make something else show up on the PCI bus.
Move the board to another slot and see if the shared problem
still remains.

The driver should be smart enough to know that if the interrupt
was obtained from the PCI bus, then it can allocate it shared.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


