Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVBUOCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVBUOCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVBUOCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:02:03 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:45736 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261977AbVBUOBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:01:48 -0500
Message-ID: <4219A3AD.1000002@comcast.net>
Date: Mon, 21 Feb 2005 09:02:37 +0000
From: Doug McLain <nostar@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: PALFFY Daniel <dpalffy-lists@rainstorm.org>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: sata_sil data corruption
References: <Pine.LNX.4.58.0412281319001.5054@rainstorm.org> <421778E4.8060705@pobox.com> <Pine.LNX.4.58.0502211219250.23186@rainstorm.org>
In-Reply-To: <Pine.LNX.4.58.0502211219250.23186@rainstorm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sata_sil driver is without a doubt, totally hosed.  I, along with 
some others I've found on this list and google, are also getting kernel 
oops and hard freezes while loading this driver, with confirmed good 
hardware.

PALFFY Daniel wrote:
> On Sat, 19 Feb 2005, Jeff Garzik wrote:
> 
> 
>>PALFFY Daniel wrote:
>>
>>>Hi,
>>>
>>>I'm trying to set up a machine with a si3112a controller (lspci: 1095:3112
>>>(rev 01) Subsystem: 1095:6112, cheap PCI card) and a ST3200822AS Rev:
>>>3.01 disk and I see continuous silent data corruption while reading the
>>>disk. Writing seems to be ok. I have 2.6.10-ac1 built with conservative
>>>options (UP, no PREEMPT, 8k stack, no regparm). After seeing problems I
>>>tried to blacklist my drive to do MOD15, but it didn't help.
>>>
>>>Finally I did
>>>
>>>    unsigned long long i = 0;
>>>    while (write(1, &i, sizeof(i)) != -1) i++;
>>>
>>>to the only primary partition while running sata_sil. Reading it back with
>>>
>>>    unsigned long long i=0, j;
>>>    while (read(0, &j, sizeof(i)) == sizeof(i)) {
>>>        if (j != i) fprintf(stderr, "diff at %llx: read: %llx\n", i, j);
>>>        i++;
>>>    }
>>>
>>>gives similar results, but always different:
>>>diff at 5efff: read: 5ef24
>>>diff at 7ffff: read: 7ff08
>>>diff at 8ffff: read: 8ff51
>>>diff at 97fff: read: 97f00
>>>diff at affff: read: aff00
>>>diff at bffff: read: bffac
>>>diff at dffff: read: dff00
>>>diff at efffe: read: eff00
>>>diff at effff: read: eff00
>>>diff at fffbf: read: fffff
>>>and so on.
>>>
>>>Reading back the same data with the ide siimage driver worked for at least
>>>500MB without corrupted data, but dma doesn't work with that driver, this
>>>is logged on about the first read attempt:
>>>
>>>hde: dma_intr: bad DMA status (dma_stat=76)
>>>hde: dma_intr: status=0x50 { DriveReady SeekComplete }
>>>
>>>ide: failed opcode was: unknown
>>>hde: DMA disabled
>>>ide2: reset phy, status=0x00000113, siimage_reset
>>>ide2: reset: success
>>>
>>>The machine is an old Compaq Prosignia 200, with a p2 300 and
>>>0000:00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
>>>chipset. Relevant parts from dmesg:
>>>
>>>sata_sil:
>>>
>>>libata version 1.10 loaded.
>>>sata_sil version 0.8
>>>ata1: SATA max UDMA/100 cmd 0xC886A080 ctl 0xC886A08A bmdma 0xC886A000 irq 10
>>>ata2: SATA max UDMA/100 cmd 0xC886A0C0 ctl 0xC886A0CA bmdma 0xC886A008 irq 10
>>>ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
>>>ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
>>>ata1(0): applying Seagate errata fix
>>>ata1: dev 0 configured for UDMA/100
>>>scsi1 : sata_sil
>>>ata2: no device found (phy stat 00000000)
>>>scsi2 : sata_sil
>>>  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
>>>  Type:   Direct-Access                      ANSI SCSI revision: 05
>>>SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
>>>SCSI device sdb: drive cache: write back
>>>
>>>siimage:
>>>
>>>SiI3112 Serial ATA: IDE controller at PCI slot 0000:00:0a.0
>>>SiI3112 Serial ATA: chipset revision 1
>>>SiI3112 Serial ATA: 100% native mode on irq 10
>>>    ide2: MMIO-DMA , BIOS settings: hde:DMA, hdf:DMA
>>>    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
>>>Probing IDE interface ide2...
>>>hde: ST3200822AS, ATA DISK drive
>>>hde: applying pessimistic Seagate errata fix
>>>ide2 at 0xc886a080-0xc886a087,0xc886a08a on irq 10
>>>hde: max request size: 7KiB
>>>hde: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
>>>hde: cache flushes supported
>>> hde:<3>hde: dma_intr: bad DMA status (dma_stat=76)
>>>hde: dma_intr: status=0x50 { DriveReady SeekComplete }
>>>
>>>ide: failed opcode was: unknown
>>> hde1
>>>Probing IDE interface ide3...
>>>hdg: no response (status = 0xfe)
>>>hde: dma_intr: bad DMA status (dma_stat=76)
>>>hde: dma_intr: status=0x50 { DriveReady SeekComplete }
>>>
>>>ide: failed opcode was: unknown
> 
> 
> Hi,
> 
> 
>>Don't use --two-- drivers for the same hardware.
>>
>>Can you re-test with siimage disabled?
> 
> 
> Of course it was disabled while testing sata_sil and vice-versa. I've just
> tried that driver to test if the hardware was faulty. Since then, I've
> tested the same disk/controller combo in a BX based PentiumII system, and
> it worked perfectly fine, but in the Compaq machine it still failed with
> 2.6.10-ac10. So I think it might be some low-level hardware
> incompatibility...
> 
> --
> Daniel
> 			...and Linux for all.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
http://nostar.net/
