Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUADO7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbUADO7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:59:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19471 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265698AbUADO7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:59:01 -0500
Date: Sun, 4 Jan 2004 14:58:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mr Amit Mehrotra <mehrotraamit@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: PCMCIA in 2.6.0 and 2.4.23 not detecting card inserts.
Message-ID: <20040104145857.A22480@flint.arm.linux.org.uk>
Mail-Followup-To: Mr Amit Mehrotra <mehrotraamit@yahoo.co.in>,
	linux-kernel@vger.kernel.org
References: <20040104143755.6022.qmail@web8203.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040104143755.6022.qmail@web8203.mail.in.yahoo.com>; from mehrotraamit@yahoo.co.in on Sun, Jan 04, 2004 at 02:37:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 02:37:55PM +0000, Mr Amit Mehrotra wrote:
> 1. PCMCIA in 2.6.0 and 2.4.23 not detecting card
> inserts

The problem seems to be caused by the kernels resource manager having
incomplete information concerning which areas of memory space are
available for use, and which are already being used for something.

> 7.4.2 output of /proc/iomem
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

> 00100000-3ffeffff : System RAM
>   00100000-0028d7d6 : Kernel code
>   0028d7d7-00340dff : Kernel data
> 3fff0000-3fff0fff : 0000:00:08.0
>   3fff0000-3fff0fff : yenta_socket

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is a 1GB box, so RAM starts at 0 up to 0x40000000, and the region
0x3fff0000 to 0x40000000 wasn't marked as in use?

> 40000000-403fffff : PCI CardBus #02
> 40400000-407fffff : PCI CardBus #02
> c5b00000-d5cfffff : PCI Bus #01
>   c8000000-cfffffff : 0000:01:00.0
>   d5c80000-d5cfffff : 0000:01:00.0
> d5e00000-d7efffff : PCI Bus #01
>   d6000000-d6ffffff : 0000:01:00.0
> dbffa000-dbffafff : 0000:00:04.0
>   dbffa000-dbffafff : sis900
> dbffb000-dbffbfff : 0000:00:03.0
> dbffc000-dbffcfff : 0000:00:03.1
> dbffd000-dbffdfff : 0000:00:03.2
> dbffe000-dbffefff : 0000:00:03.3
> dbfff000-dbffffff : 0000:00:02.3
> dc000000-dfffffff : 0000:00:00.0



> 00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
>         Subsystem: Uniwill Computer Corp: Unknown device 3000
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168
>         Interrupt: pin A routed to IRQ 17
>         Region 0: Memory at 3fff0000 (32-bit, non-prefetchable) [size=4K]
                              ^^^^^^^^

We obviously decided to allocate this resource from the resource manager.
It selected the first free address it found, which was 0x3fff0000.  This
unfortunately clashes with the ACPI data, as indicated below in the dmesg
log.

>         Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
>         Memory window 0: 40000000-403ff000 (prefetchable)
>         Memory window 1: 40400000-407ff000
>         I/O window 0: 00004000-000040ff
>         I/O window 1: 00004400-000044ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
>         16-bit legacy interface ports at 0001
> 
> 7.7 output of dmesg
> Linux version 2.6.0 (root@localhost) (gcc version
> 3.3.2) #6 Sat Jan 3 16:52:54 CST 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
>  BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
>  BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)

So it seems we aren't giving the kernel source manager the full picture.

>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffee0000 - 00000000fff0ffff (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)

These regions also do not seem to appear in /proc/iomem, which can lead
to resource allocations for devices occuring in these ranges.  This will
probably also cause bad effects.

> user-defined physical RAM map:
>  user: 0000000000000000 - 000000000009fc00 (usable)
>  user: 000000000009fc00 - 00000000000a0000 (reserved)
>  user: 00000000000f0000 - 0000000000100000 (reserved)
>  user: 0000000000100000 - 000000003fff0000 (usable)
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
...
> Linux Kernel Card Services
>   options:  [pci] [cardbus] [pm]
> Intel PCIC probe: not found.
> Yenta: CardBus bridge found at 0000:00:08.0 [1584:3000]
> Yenta: ISA IRQ list 0000, PCI irq17
> Socket status: 4d41b401

The above explains why we are reading rubbish from the PCMCIA socket status
register, and therefore not detecting card insertions.

It seems to me that the x86 resource management needs some work to make it
more robust.

Can some x86 person please look into fixing this?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
