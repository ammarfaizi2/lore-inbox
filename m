Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVDHVx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVDHVx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 17:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVDHVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 17:53:56 -0400
Received: from hcoop.net ([63.246.10.45]:38316 "EHLO Abulafia.hcoop.net")
	by vger.kernel.org with ESMTP id S261162AbVDHVxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 17:53:06 -0400
Message-ID: <17995.130.76.32.15.1112997184.squirrel@130.76.32.15>
Date: Fri, 8 Apr 2005 14:53:04 -0700 (PDT)
Subject: IDE CMD 64x PCI driver
From: "Rob Gubler" <rob.mlist@gubler.net>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3-RC1
X-Mailer: SquirrelMail/1.4.3-RC1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am having difficultly getting the IDE CMD 64x PCI driver to work for the
CMD PCI-648 device.  I have decided to dig through kernel and driver code
to find out why and hopefully correct the problem.

I am running linux, version 2.4.21, on a PowerPC in the PCI Mezzanine Card
(PMC) form factor.  The CompactPCI Carrier board that this PowerPC card
sits in supports 2 PMC devices.  One of which is of course the PowerPC440,
provided by Artesyn, the other is the Compact Flash to IDE device provided
by CMD Technology; CMD PCI-648.

It appears that the kernel is unable to use the IRQ associated with the
CMD PCI-648 device.  I’ve traced the kernel output messages back to the
do_ide_setup_pci_device() function in drivers/ide/setup-pci.c.  In this
portion of the code it seems to...

  1.  Determine if the device can be brought up in '100% native mode'
(whatever this means)

  2.  If it cannot bring it up in native mode it then, on a function
pointer, calls init_chipset_cmd64x() defined in the CMD68{3|6|8|9} driver
code (drivers/ide/pci/cmd64x.c).  It uses the return value of this
function to assign the IRQ the system uses when communicating to the CMD
device.  The init_chipset_cmd64x() function ALWAYS returns 0.

I decided that it would be beneficial to modify the return value of this
function hoping that everything would magically work.  Needless to say
this wasn't the case.  Before having modified the cmd64x.c driver code I
found, through `lspci` that the CMD device was configured to use IRQ 25. 
So I modified the init_chipset_cmd64x() function to return the values 23 -
26 (in separate kernel builds).

I've attached portions of 3 `dmesg` outputs to this email; the first one
is the kernel with no changes, the second uses IRQ 25, and the third uses
IRQ 24.  It seems that IRQ 24 yields results that appear slightly better
than IRQ 25.  I've also attached the output of `lspci -vv`.

This is the first time I have been exposed to linux device driver / kernel
development.  I am hoping someone may have some insight as to what I
should be looking for as I dig through the kernel code, IDE code, and
cmd64x driver code.  At this point all recommendations are appreciated. 
Thank you.

Regards,

Rob Gubler

--------

DMESG: KERNEL WITH NO CHANGES

# dmesg
Linux version 2.4.21-pmppc440 (root@localhost.localdomain) (gcc version
3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)5
Artesyn PM/PPC440 Copyright 2003, Artesyn Communication Products, LLC

... snip ...

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 00:02.0
PCI: Cannot allocate resource region 1 of device 00:02.0
PCI: Cannot allocate resource region 2 of device 00:02.0
PCI: Cannot allocate resource region 3 of device 00:02.0
PCI: Cannot allocate resource region 4 of device 00:02.0
PCI: Cannot allocate resource region 4 of device 00:03.0
PCI: Cannot allocate resource region 4 of device 00:03.1
PCI: moved device 00:02.0 resource 0 (101) to 1000
PCI: moved device 00:02.0 resource 1 (101) to 1000
PCI: moved device 00:02.0 resource 2 (101) to 1010
PCI: moved device 00:02.0 resource 3 (101) to 1000
PCI: moved device 00:02.0 resource 4 (101) to 1020
PCI: moved device 00:03.0 resource 4 (101) to 1040
PCI: moved device 00:03.1 resource 4 (101) to 1080

... snip ...

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx CMD648: IDE controller at PCI slot 00:02.0
CMD648: chipset revision 1
CMD648: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:pio, hdb:pio ide1:
BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SanDisk SDCFH-1024, CFA DISK drive
hda: IRQ probe failed (0x0)
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx blk: queue c01cbcd8, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
ide0: DISABLED, NO IRQ

... snip ...


--------

DMESG: KERNEL USING IRQ 25

# dmesg

... snip ...

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx CMD648: IDE controller at PCI slot 00:02.0
CMD648: chipset revision 1
CMD648: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:pio, hdb:pio ide1:
BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SanDisk SDCFH-1024, CFA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx blk: queue c01cbcd8, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
ide0 at 0x1000-0x1007,0x100a on irq 25
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error } hda:
task_no_data_intr: error=0x04 { DriveStatusError }
hda: 2001888 sectors (1025 MB) w/1KiB Cache, CHS=1986/16/63, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0:<4>hda: dma_timer_expiry: dma status ==
0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: irq timeout: status=0x00 { }

hda: status error: status=0x00 { }

hda: drive not ready for command
hda: status error: status=0x00 { }

hda: drive not ready for command
hda: lost interrupt
hda: recal_intr: status=0x00 { }

ide0: reset: master: error (0x00?)
hda: status error: status=0x00 { }

hda: drive not ready for command
hda: status error: status=0x00 { }

hda: drive not ready for command
hda: status error: status=0x00 { }

hda: drive not ready for command
hda: status error: status=0x00 { }

hda: drive not ready for command
ide0: reset: master: error (0xd0?); slave: failed
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table



--------

DMESG: KERNEL USING IRQ 24

... snip ...

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx CMD648: IDE controller at PCI slot 00:02.0
CMD648: chipset revision 1
CMD648: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:pio, hdb:pio ide1:
BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SanDisk SDCFH-1024, CFA DISK drive
Unhandled interrupt 18, disabled
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx blk: queue c01cbcd8, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
ide0 at 0x1000-0x1007,0x100a on irq 24
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error } hda:
task_no_data_intr: error=0x04 { DriveStatusError }
hda: 2001888 sectors (1025 MB) w/1KiB Cache, CHS=1986/16/63, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0:<4>hda: dma_timer_expiry: dma status ==
0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: irq timeout: status=0x00 { }

hda: status error: status=0x00 { }

hda: drive not ready for command
hda: status error: status=0x00 { }

hda: drive not ready for command
hda: lost interrupt
hda: recal_intr: status=0x00 { }

ide0: reset: master: error (0x00?)
hda: status error: status=0x00 { }

hda: drive not ready for command
hda: status error: status=0x00 { }

hda: drive not ready for command
hda: status error: status=0x00 { }

hda: drive not ready for command
hda: status error: status=0x00 { }

hda: drive not ready for command
ide0: reset: master: error (0xd0?); slave: failed
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table




--------

LSPCI -VV OUTPUT (BEFORE DEVICE DRIVER MODIFICATION)

# lspci -vv
00:00.0 PCI bridge: IBM: Unknown device 01a7 (rev 02) (prog-if 00 [Normal
decode])

	... snip ...

00:02.0 RAID bus controller: CMD Technology Inc PCI0648 (rev 01)
        Subsystem: CMD Technology Inc PCI0648
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 25
        Region 0: I/O ports at 1000 [size=8]
        Region 1: I/O ports at 1008 [size=4]
        Region 2: I/O ports at 1010 [size=8]
        Region 3: I/O ports at 100c [size=4]
        Region 4: I/O ports at 1020 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=3 PME-

00:03.0 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
        Interrupt: pin A routed to IRQ 26

	... snip ...

00:03.1 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
        Interrupt: pin B routed to IRQ 23

	... snip ...

