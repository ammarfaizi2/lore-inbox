Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbTL3QSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbTL3QSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:18:14 -0500
Received: from ldd055.emirates.net.ae ([217.165.96.55]:1028 "EHLO athena")
	by vger.kernel.org with ESMTP id S265734AbTL3QSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:18:09 -0500
Date: Tue, 30 Dec 2003 20:20:29 +0400 (GST)
From: Amit Gurdasani <amitg@alumni.cmu.edu>
X-X-Sender: amitg@athena
To: Adam Belay <ambx1@neo.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
In-Reply-To: <20031229143711.GA3176@neo.rr.com>
Message-ID: <Pine.LNX.4.56.0312301951280.1156@athena>
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:> It's a pre-PnP SB16 from 1994, as far as I can tell -- IRQ, I/O port and DMA
:> channels can be set only by setting jumpers. I suppose I could pull the card
:> out and set its IRQ setting to something the modem won't claim.
:
:Because of detection limitations in legacy hardware, you may have to notify
:the Plug and Play Layer that your device is using irq 5.  Booting with the
:parameter pnp_reserve_irq=5 will prevent resource conflicts with the legacy
:SB16 device.

Thanks, now the PnP layer does not attempt to allocate IRQ 5.

:> ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
:> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
:> ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
:> parport0: irq 7 detected
:
:Hmm, it shouldn't be reporting irq 0.  The probbing code may be confused.
:I would guess it is on irq 4.

Ah.

:> Additionally, pnpdump says the modem can only claim an IRQ line from among
:> 3, 4, 5, 7, 9, 10, 11, 12 or 15 in various configurations.
:
:It appears that you have an unresolvable resource conflict.  I'm working on
:a more flexable resource manager for the 2.7 kernel.

Great, thanks. I look forward to it. :) Here's what I get when I try to
enable the modem:

pnp: Unable to assign resources to device 01:01.00.

:For now, I recommend that you disable one of your serial ports in your BIOS
:configuration interface and try booting with pnp_reserve_irq=5.

I guess I could do that, since I'm not using ttyS0 anyway. In any case,
forcing the modem to use IRQ 4 via isapnptools does allow the modem to
function.

:Alternatively you could try enabling PnPBIOS support.  There's a slight chance
:that the pci code will reroute ide2 to 14 (assuming ide2 is pci), leaving room
:for your modem on 9.  You'll still need to reserve irq 5 as stated above.

PnPBIOS support is already enabled:

Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd20
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbd48, dseg 0xf0000
pnp: 00:0a: ioport range 0x208-0x20f has been reserved
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver

ide2 is indeed PCI, a Silicon Image 680-based PCI ATA interface, but it's
using IRQ 9:

SiI680: IDE controller at PCI slot 0000:00:13.0
PCI: Found IRQ 9 for device 0000:00:13.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 9
    ide2: MMIO-DMA at 0xc8800000-0xc8800007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xc8800008-0xc880000f, BIOS settings: hdg:pio, hdh:pio
hde: WDC AC34300L, ATA DISK drive
hdf: MAXTOR 6L080L4, ATA DISK drive
ide2 at 0xc8800080-0xc8800087,0xc880008a on irq 9
hde: max request size: 64KiB
hde: 8406720 sectors (4304 MB) w/256KiB Cache, CHS=8896/15/63, UDMA(33)
 /dev/ide/host2/bus0/target0/lun0: p1
hdf: max request size: 64KiB
hdf: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host2/bus0/target1/lun0: p1 p2

Thanks,

Amit
