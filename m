Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270158AbTGUPTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270172AbTGUPTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:19:15 -0400
Received: from mail.iskon.hr ([213.191.128.4]:9602 "HELO mail.iskon.hr")
	by vger.kernel.org with SMTP id S270158AbTGUPTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:19:08 -0400
Date: Mon, 21 Jul 2003 17:34:08 +0200
From: Kresimir Kukulj <madmax@iskon.hr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] siimage.c - turning DMA on because of 'md' kernel thread.
Message-ID: <20030721153408.GA4317@max.zg.iskon.hr>
References: <20030718223425.GA21110@max.zg.iskon.hr> <1058568523.19558.108.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058568523.19558.108.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> On Gwe, 2003-07-18 at 23:34, Kresimir Kukulj wrote:
> > resync.  That means that disks are busy (in PIO mode), and when hdparm -d1 -X69
> > executes, system freezes [if there is no disk/little activity hdparm cludge
> > passes ok - for example, if RAID-1 is clean so there is no resync].
> 
> The newest driver should put them into DMA automatically and set the
> limit. The other changes I'll check over but certainly look like they
> may be needed.

Hm, I tried 2.4.22-pre7 and it did not set disks to DMA mode, but it did set
the limit (max_kb_per_request). With the following modification, kernel
(2.4.22-pre7) initializes both disk to UDMA133, and as far as I can see, it
works ok.

In siimage.c there is a check for Maxtor disks - they are/should be set to
UDMA100.  Is this also necessary for Seagate SATA disks ?

--------------
--- siimage.c.orig      Mon Jul 21 15:13:16 2003
+++ siimage.c   Mon Jul 21 16:56:28 2003
@@ -488,7 +488,7 @@
        struct hd_driveid *id   = drive->id;
 
        if ((id->capability & 1) != 0 && drive->autodma) {
-               if (!(hwif->atapi_dma))
+               if ((hwif->atapi_dma))
                        goto fast_ata_pio;
                /* Consult the list of known "bad" drives */
                if (hwif->ide_dma_bad_drive(drive))
---------------


And it looks like:

SiI3112 Serial ATA: IDE controller at PCI slot 02:04.0
PCI: Found IRQ 5 for device 02:04.0
PCI: Sharing IRQ 5 with 02:00.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hda: SAMSUNG CD-ROM SC-152A, ATAPI CD/DVD-ROM drive
hde: ST3120023AS, ATA DISK drive
blk: queue c0326ef8, I/O limit 4095Mb (mask 0xffffffff)
hdg: ST3120023AS, ATA DISK drive
blk: queue c0327364, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xf8800080-0xf8800087,0xf880008a on irq 5
ide3 at 0xf88000c0-0xf88000c7,0xf88000ca on irq 5
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63, UDMA(133)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63, UDMA(133)


/dev/hdg:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 14593/255/63, sectors = 234441648, start = 0
 busstate     =  1 (on)


Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 8192.0kB   ECC bytes: 4    Queue depth: 1
        Standby timer values: spec'd by standard
        r/w multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 65278
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns


[Mirror]
# hdparm -tT /dev/md3

/dev/md3:
 Timing buffer-cache reads:   128 MB in  0.24 seconds =533.33 MB/sec
 Timing buffered disk reads:  64 MB in  2.42 seconds = 26.45 MB/sec

[One plex]
# hdparm -tT /dev/hde3

/dev/hde3:
 Timing buffer-cache reads:   128 MB in  0.24 seconds =533.33 MB/sec
 Timing buffered disk reads:  64 MB in  1.82 seconds = 35.16 MB/sec

Poor results, but at least it works.

-- 
Kresimir Kukulj                      madmax@iskon.hr
+--------------------------------------------------+
Old PC's never die. They just become Unix terminals.
