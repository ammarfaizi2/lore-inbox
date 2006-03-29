Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWC2TMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWC2TMG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWC2TMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:12:06 -0500
Received: from khc.piap.pl ([195.187.100.11]:14858 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750834AbWC2TME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:12:04 -0500
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: IDE CDROM tail read errors
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 29 Mar 2006 21:11:56 +0200
Message-ID: <m3wtedrrpf.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have performed some CD-ROM read tests. Any thoughts?

The CD-ROM disc is a single Fedora Core 5 disc 1, TDK 650 MB CD-RW 4-speed.
This CD-RW was erased with "cdrecord blank=fast" before writing FC5d1
to it (cdrecord FC-5-i386-disc1.iso with no padding, default = TAO mode).
cdrecord is FC5's cdrecord-2.01.01.0.a03-3 (i386).

# ls -l FC-5-i386-disc1.iso 
687235072 Mar 21 00:13 FC-5-i386-disc1.iso

Both machines run vanilla kernels (with Alan's PATA libata patch in one
case).

# cdrecord -toc

first: 1 last 1
track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: 1
track:lout lba:    335566 (  1342264) 74:36:16 adr: 1 control: 4 mode: -1

FC-5-i386-disc1.iso size = 335564 * 2048 bytes, not sure why TOC has
2 more sectors (8 512B sectors) but I'm not a CD expert.

--------------------------------------------------------------------

1. machine 1, VIA KT333 chipset, NEC DVD_RW ND-4550A IDE drive (secondary
   master, no other IDE devices), Linux 2.6.15 with drivers/ide driver:

# cat /dev/cdrom > img-15.iso
cat: /dev/cdrom: Input/output error

# cat /dev/cdrom > img-15a.iso
cat: /dev/cdrom: Input/output error

# ls -l
-rw-r--r-- 1 root root 687177728 Mar 29 15:51 img-15.iso
-rw-r--r-- 1 root root 687177728 Mar 29 15:58 img-15a.iso

The files are just truncated FC5d1 images (57344 bytes missing).

# cat /sys/block/hdc/size
1342264 (as in TOC)

VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:DMA, hdd:pio
hdc: _NEC DVD_RW ND-4550A, ATAPI CD/DVD-ROM drive
hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 1342144
Buffer I/O error on device hdc, logical block 167768
...

Failed sector numbers are 1342144 - 1342256 (increments by 8),
logical blocks numbers are 167768 - 167782 (= sector numbers / 8).

It looks like an obvious prefetch bug but given the track length
(in TOC) I'm not sure.

--------------------------------------------------------------------

2. machine 1, the same VIA KT333 and NEC 4550A, Linux 2.6.16 + Alan's
   PATA libata 2.6.16-ide1 patch:

# cat /sys/block/sr0/size
1342264 (i.e., the same as with 2.6.15 + drivers/ide)

# cat /dev/cdrw > img-16a.iso
cat: /dev/cdrw: Input/output error

# cat /sys/block/sr0/size
1342256 (looks like it has been adjusted to .iso image size / 512 when
         the first I/O error occured)

# cat /dev/cdrw > img-16b.iso
# cat /dev/cdrw > img-16c.iso

All three files (including img-16a.iso) are exact copies of the original
FC5d1 image.

ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x7808 irq 15
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover = 10
FIT t.act8b = 10, t.rec8b = 8, t.active = 9, t.recover = 9
ata4: dev 0 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata4: dev 0 ATAPI, max UDMA/33
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover = 10
FIT t.act8b = 10, t.rec8b = 8, t.active = 9, t.recover = 9
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
ata4: dev 0 configured for UDMA/33
scsi3 : pata_via
  Vendor: _NEC      Model: DVD_RW ND-4550A   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 05
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray

end_request: I/O error, dev sr0, sector 1342256
Buffer I/O error on device sr0, logical block 167782
end_request: I/O error, dev sr0, sector 1342256
Buffer I/O error on device sr0, logical block 167782

(the above errors are printed at the end of first "cat", subsequent
"cat" commands are silent).

--------------------------------------------------------------------

3. An old 440BX notebook with CD-224E CD-ROM, Linux 2.6.16 and
drivers/ide driver.

The results are essentially identical to the first case - 2.6.15
with drivers/ide driver.

PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N020ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 39070080 sectors (20003 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA

(Errors etc.)
-- 
Krzysztof Halasa
