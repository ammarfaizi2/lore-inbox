Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269557AbUINRCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbUINRCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbUINQMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:12:36 -0400
Received: from mirapoint5.brutele.be ([212.68.203.254]:18272 "EHLO
	mirapoint5.brutele.be") by vger.kernel.org with ESMTP
	id S269460AbUINQFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:05:35 -0400
Date: Tue, 14 Sep 2004 18:05:30 +0200
To: linux-kernel@vger.kernel.org
Subject: pdc202xx_new + software raid0 freezes on array writes
Message-ID: <20040914160530.GA729@evilgeek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Mc Aulay <pmcaulay@evilgeek.net>
X-Junkmail-Status: score=24/50, host=mirapoint5.brutele.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

[NOTE: Please CC replies to me personally as I'm not a list subscriber.
Thank you.]

I was wondering if anyone could help me at all with a little problem I'm
having.

I have 4 Western Digital 200GB hard disks (WDC WD2000JB) in a software
RAID0 setup, two each connected to a Promise Ultra100TX2 (PDC20268) and
an Ultra133TX2 (PDC20269) (pdc202XX_new driver compiled into the
kernel).  The system itself is a K6-2 450Mhz CPU on an ATX mainboard of
unknown brand using the ALi M1541/5229 chipset (ALI15X3).  It boots from
a seperate Seagate (ST38410A) hard disk connected to the on-board
controller.

Whenever I try to write more than a certain amount (which is variable,
about 10 to 60 MB) *to* the RAID array, the whole system locks up
silently, hard.  No more network, no Oops, syslog entry or console
message, the magic SysRq key doesn't work, keyboard LEDs are dead.  The
only way to get the system back up is via a hard reset or power cycle.

But I can read as much as I like *from* the array just fine.  Smaller
writes work fine as well.

I've reproduced this with kernel versions 2.4.23 and 2.4.27 with a
variety of compilation options to no effect, as well as fiddling with
kernel boot parameters, hdparm settings, testing the RAM, flashing the
Ultra100TX2 BIOS so they both are version 2.20.0.15, increasing the PCI
latency and checking the PnP settings for IRQ and DMA channels in the
(AMI) BIOS, moving the PCI cards around, changing the cables, and
checking the cooling.  There is no APIC so I can't use the NMI oopser.
I've defined ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h
and PDC202XX_DEBUG_DRIVE_INFO and PDC202XX_DECODE_REGISTER_INFO in
drivers/ide/pci/pdc202xx_new.h.  Not a peep.  Dmesg reports nothing
irregular during boot.  Current kernel version is "Linux version 2.4.27
(pmcaulay@chernobyl) (gcc version 2.95.4 20011002 (Debian prerelease))
#10 Tue Sep 14 00:06:09 CEST 2004".

If I disable DMA on the drives that make up the RAID array (using
hdparm), I get lots of syslog entries like these every time something is
written and the system freezes for a little while (1-2 seconds) on every
bus reset:

kernel: hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }
kernel:
kernel: hdg: drive not ready for command
kernel: hdg: status timeout: status=0xd0 { Busy }
kernel:
kernel: PDC202XX: Secondary channel reset.
kernel: hdg: drive not ready for command
kernel: ide3: reset: success

(Controller, channel and drive varies.)

The system does not always lock up permanently however, and disk writes
sometimes complete correctly.  This is the only way I could get it to
work at all, but the system isn't exactly usable this way (the
stuttering also affects ssh sessions and the console, and very large
writes eventually lead to bad crashes which occasionally damage the
filesystem).

Other thoughts:
- The same combination of controllers and drives used to work fine with
  a Pentium 166 + Intel Triton mainboard, but I'm no longer sure which
  kernel version I was using at the time.
- There were no problems writing to a 80GB Hitachi DeskStar on any
  channel of either Promise controllers, but I didn't test all channels
  at the same time.
- I've swapped out the UltraTX2 for a Highpoint Rocket133 (hpt302, using
  vendor driver 1.2 which pretends to be SCSI, not IDE) and the array
  still crashes, but not quite as often.
- If I connect all drives to the HPT302 everything works fine (the
  pdc20268 is still installed but not connected).
- Disks connected to the on-board IDE controllers have no problems.

lspci -v:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP System Controller
        Flags: bus master, slow devsel, latency 128
        Memory at e0000000 (32-bit, non-prefetchable) [size=4M]
        Capabilities: [b0] AGP version 1.0

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, slow devsel, latency 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=128
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: cda00000-cfafffff
        Prefetchable memory behind bridge: c9800000-cd8fffff

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 128, IRQ 11
        Memory at dffff000 (32-bit, non-prefetchable) [size=4K]

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
        Flags: bus master, medium devsel, latency 0

00:0e.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 01)
        Flags: bus master, medium devsel, latency 128, IRQ 10
        Memory at cd9ff000 (32-bit, prefetchable) [size=4K]
        I/O ports at df00 [size=32]
        Memory at dfe00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at dfd00000 [disabled] [size=1M]

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if fa)
        Flags: bus master, medium devsel, latency 32, IRQ 14
        I/O ports at ffa0 [size=16]

00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. 20268
        Flags: bus master, 66Mhz, slow devsel, latency 128, IRQ 9
        I/O ports at dfa0 [size=8]
        I/O ports at dff0 [size=4]
        I/O ports at df90 [size=8]
        I/O ports at dfe0 [size=4]
        I/O ports at df40 [size=16]
        Memory at dfff8000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at dffe0000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1

00:12.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d69 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Flags: bus master, 66Mhz, slow devsel, latency 128, IRQ 12
        I/O ports at df80 [size=8]
        I/O ports at df68 [size=4]
        I/O ports at ded0 [size=8]
        I/O ports at df60 [size=4]
        I/O ports at dea0 [size=16]
        Memory at dfff4000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at dffd0000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2135
        Flags: bus master, 66Mhz, medium devsel, latency 128
        Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
        Memory at ca000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at cf8f0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

-- 
Peter Mc Aulay <pmcaulay@evilgeek.net>

