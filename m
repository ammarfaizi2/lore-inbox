Return-Path: <linux-kernel-owner+w=401wt.eu-S1751695AbXANWs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbXANWs3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 17:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbXANWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 17:48:29 -0500
Received: from manchmal.in-ulm.de ([217.10.9.201]:4662 "EHLO
	manchmal.in-ulm.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbXANWs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 17:48:28 -0500
X-Greylist: delayed 1476 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 17:48:27 EST
Date: Sun, 14 Jan 2007 23:23:48 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: linux-kernel@vger.kernel.org
Subject: it821x trouble since 2.6.18
Message-ID: <1168811634@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are ITE 8212-based controllers installed in some of my
computers. I had always skipped the build-in RAID things and used them
as plain controllers.

1. Beginning with 2.6.18 there was some trouble, basically slowed data
transfer, sometimes even a totally stalled system (I cannot reproduce
the latter though).

Diffing dmesg of 2.6.17.x and 2.6.18.x (same for 2.6.19):

 Probing IDE interface ide2...
 hde: SAMSUNG VA34324A, ATA DISK drive
 hde: Performing identify fixups.
 ide2 at 0xd000-0xd007,0xd402 on irq 10
 hde: max request size: 128KiB
-hde: 8446032 sectors (4324 MB) w/478KiB Cache, CHS=14896/9/63, BUG
+hde: 8446032 sectors (4324 MB) w/478KiB Cache, CHS=14896/9/63, BUG DMA OFF
  hde:hde: recal_intr: status=0x51 { DriveReady SeekComplete Error }
 hde: recal_intr: error=0x04 { DriveStatusError }
 ide: failed opcode was: unknown
+hde: irq timeout: status=0xd0 { Busy }
+ide: failed opcode was: unknown
+ide2: reset: master: ECC circuitry error
+hde: recal_intr: status=0x51 { DriveReady SeekComplete Error }
+hde: recal_intr: error=0x04 { DriveStatusError }
+ide: failed opcode was: unknown
  hde1 hde2 < hde5 hde6 >

OK, there was "BUG" up to and including 2.6.17 but the disk(s) worked
without any problem. 

Not surprisingly the disk throughput was affected by that. Comparing
"hdparm -tT /dev/hde":

2.6.17
/dev/hde:
 Timing cached reads:    88 MB in  2.01 seconds =  43.72 MB/sec
 Timing buffered disk reads:   26 MB in  3.21 seconds =   8.10 MB/sec

2.6.18
/dev/hde:
 Timing cached reads:    90 MB in  2.04 seconds =  44.01 MB/sec
 Timing buffered disk reads:   16 MB in  3.14 seconds =   5.10 MB/sec


2. Trying to understand what has happened I found the main difference
is not in the driver but in ide-dma.c:

--- linux-2.6.17.14/drivers/ide/ide-dma.c   2006-06-18 01:49:35.000000000 +0000
+++ linux-2.6.18.6/drivers/ide/ide-dma.c    2006-09-20 03:42:06.000000000 +0000
@@ -752,7 +750,7 @@
                        goto bug_dma_off;
                printk(", DMA");
        } else if (id->field_valid & 1) {
-               printk(", BUG");
+               goto bug_dma_off;
        }
        return;
 bug_dma_off:


and reverting that change returns the old transfer rates. But that is
probably not a good idea.


3. To increase confusion: I had learned the ite8212 chip is close to
the cmd/sil680, and patching siimage.c had been a solution to get
support for 8212 before it showed up in the kernel.

So I tried this again:

--- ORG/linux-2.6.19.2/drivers/ide/pci/siimage.c    2006-11-29 21:57:37.000000000 +0000
+++ NEW/linux-2.6.19.2/drivers/ide/pci/siimage.c    2007-01-14 17:59:03.000000000 +0000
@@ -52,6 +52,7 @@
                case PCI_DEVICE_ID_SII_1210SA:
                        return 1;
                case PCI_DEVICE_ID_SII_680:
+               case PCI_DEVICE_ID_ITE_8212:
                        return 0;
        }
        BUG();
@@ -1082,6 +1083,7 @@

 static struct pci_device_id siimage_pci_tbl[] = {
        { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+       { PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8212,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 #ifdef CONFIG_BLK_DEV_IDE_SATA
        { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
        { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},


and disabled CONFIG_BLK_DEV_IT821X - and now the disk is even faster
than before:

/dev/hde:
 Timing cached reads:    88 MB in  2.01 seconds =  43.71 MB/sec
 Timing buffered disk reads:   34 MB in  3.02 seconds =  11.25 MB/sec


So it seems the problem is it82xx.c at least for my controllers.


4. Now there is 2.6.19 and the new ata driver model. So I tried that
one, too:

Booting with 
| CONFIG_PATA_IT821X=m
stalls the system upon module load. The last kernel messages were

ata1.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port failed to respond (30 secs, Status 0xd0)
Buffer I/O error on device sda, logical block 0


Patching the sil driver again:

--- ORG/linux-2.6.19.2/drivers/ata/pata_sil680.c	2006-11-29 22:57:37.000000000 +0100
+++ NEW/linux-2.6.19.2/drivers/ata/pata_sil680.c	2007-01-14 21:05:24.000000000 +0100
@@ -349,6 +349,7 @@

 static const struct pci_device_id sil680[] = {
        { PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_680), },
+       { PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8212), },

        { },
 };


brings again a fast access:

/dev/sda:
 Timing cached reads:    88 MB in  2.01 seconds =  43.73 MB/sec
 Timing buffered disk reads:   34 MB in  3.03 seconds =  11.24 MB/sec


although dmesg does not look perfectly well:

pata_sil680 0000:00:0d.0: version 0.3.2
sil680: BA5_EN = 0 clock = 00
sil680: BA5_EN = 0 clock = 00
sil680: 100MHz clock.
PCI: setting IRQ 10 as level-triggered
PCI: Assigned IRQ 10 for device 0000:00:0d.0
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ata1: PATA max UDMA/100 cmd 0xD000 ctl 0xD402 bmdma 0xE000 irq 10
ata2: PATA max UDMA/100 cmd 0xD800 ctl 0xDC02 bmdma 0xE008 irq 10
scsi0 : pata_sil680
ata1.00: ATA-4, max UDMA/33, 8446032 sectors: LBA
ata1.00: Drive reports diagnostics failure. This may indicate a drive
ata1.00: fault or invalid emulation. Contact drive vendor for information.
ata1.00: configured for UDMA/33
scsi1 : pata_sil680
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG VA34324A JG10 PQ: 0 ANSI: 5
SCSI device sda: 8446032 512-byte hdwr sectors (4324 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 8446032 512-byte hdwr sectors (4324 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda


5. OK, there's a workaround but I'd really like to avoid such cludges.
Is there anything I could try next?

    Christoph

Some more things:
- This is not related to the hard disk. I've also tested others, same
  results.
- According to the bios the controller set the mode to UDMA-2 ("U2").
  Faster disks are recognized accordingling e.g. "U5" but
  using the patched siimage hdparm -i tells that are in udma2 only.
- The it8212_noraid option didn't help either. There is only a single
  disk attached.
- The mainboard is a rather old ALI15X3, CPU ist AMDK6 at 366 MHz.
  Chances are that different boards do not show such effects.
- The controller's firmware is quite old (1.4.1.6) but update failed.
  There are two jumpers but they are not documented.

PS: No need to Cc: me in replies.
