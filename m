Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752103AbWJXHkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbWJXHkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWJXHkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:40:08 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:46441 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752103AbWJXHkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:40:05 -0400
Message-ID: <453DC2A9.8000507@sw.ru>
Date: Tue, 24 Oct 2006 11:37:13 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, devel@openvz.org
Subject: [Q] ide cdrom in native mode leads to irq storm?
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there is node with Intel 7520-based motherboard (MSI-9136), IDE cdrom (hda) and
SATA disc and 2.6.19-rc3 linux kernel.

When I set IDE controller into the native mode, I get irq storm on the node and
this interrupt is disabled. If this interrupt is shared, the other subsystems
are stop working too.

When I switch the IDE controller into legacy mode, all works correctly.

I've tried to use noapic, acpi=off, pci=routeirq, irqpoll options but it does
not help.

This issue is reproduced on the old kernels (2.6.15-1.2054_FC5smp and latest
RHEL4 kernel) too.

Is it probably a known issue and is there any work-around?

thank you,
	Vasily Averin

bootlogs, /proc/interrupts and lspci are below:

Linux version 2.6.19-rc3 (vvs@dhcp0-157) (gcc version 3.3.5 20050117
(prerelease) (SUSE Linux)) #1 SMP Tue Oct 24 11:02:23 MSD 2006
...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH5: chipset revision 2
ICH5: 100% native mode on irq 17
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: ATAPI-CD ROM-DRIVE-52MAX, ATAPI CD/DVD-ROM drive
ide0 at 0x1490-0x1497,0x1486 on irq 17
Probing IDE interface ide1...
Probing IDE interface ide1...
...
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00ac6
ata_piix 0000:00:1f.2: MAP [ P1 -- P0 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1470 irq 14
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1478 irq 15
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x177
scsi 0:0:0:0: Direct-Access     ATA      ST380811AS       3.AA PQ: 0 ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
...
irq 17: nobody cared (try booting with the "irqpoll" option)
 [<c0145eea>] __report_bad_irq+0x2a/0xa0
 [<c014602f>] note_interrupt+0xaf/0xe0
 [<c0146888>] handle_fasteoi_irq+0xc8/0xe0
 [<c01059f9>] do_IRQ+0x69/0xd0
 [<c0103ace>] common_interrupt+0x1a/0x20
 =======================
handlers:
[<c02b30c0>] (ide_intr+0x0/0x170)
Disabling IRQ #17
...
hda: lost interrupt
ide-cd: cmd 0x3 timed out
hda: lost interrupt
ide-cd: cmd 0x3 timed out
...
hda: lost interrupt
ide-cd: cmd 0x1e timed out
hda: lost interrupt


# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:      15923      15011      22615      15936   IO-APIC-edge      timer
  1:          0          0          0          8   IO-APIC-edge      i8042
  6:          3          0          0          1   IO-APIC-edge      floppy
  8:          0          0          0          1   IO-APIC-edge      rtc
  9:          0          0          0          0   IO-APIC-fasteoi   acpi
 12:         99          0          0          6   IO-APIC-edge      i8042
 14:       3432         69        295         19   IO-APIC-edge      libata
 15:          0          0          0          0   IO-APIC-edge      libata
 17:      99999          0          0          1   IO-APIC-fasteoi   ide0
 18:          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb2
 19:       8429          0          0          1   IO-APIC-fasteoi   eth0
 21:          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb1
 22:          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb3
NMI:          0          0          0          0
LOC:      69336      69336      69338      69329
ERR:          0
MIS:          0

# lspci -vn
...
00:1f.0 0601: 8086:25a1 (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 0101: 8086:25a2 (rev 02) (prog-if 8f)
        Subsystem: 8086:24d0
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at 1490 [size=8]
        I/O ports at 1484 [size=4]
        I/O ports at 1488 [size=8]
        I/O ports at 1480 [size=4]
        I/O ports at 1460 [size=16]
        Memory at d0001800 (32-bit, non-prefetchable) [size=1K]

00:1f.2 0101: 8086:25a3 (rev 02) (prog-if 8a)
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 17
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1470 [size=16]

00:1f.3 0c05: 8086:25a4 (rev 02)
        Subsystem: 8086:24d0
        Flags: medium devsel, IRQ 16
        I/O ports at 1440 [size=32]
