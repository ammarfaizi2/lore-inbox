Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbTGKWe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267196AbTGKWe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:34:57 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:51884 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267190AbTGKWed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:34:33 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.75 does not boot - TCQ oops
Date: Fri, 11 Jul 2003 16:58:09 -0400
User-Agent: KMail/1.5.2
References: <200307102251.42787.ivg2@cornell.edu> <20030711082817.GE843@suse.de> <20030711083437.GG843@suse.de>
In-Reply-To: <20030711083437.GG843@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307111658.09925.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch confirmed to work - the machine boots.
Unfortunately the long term result looked something like:

Objects Without Names: 2580
Empty Lost Dirs Removed: 12294
Dirs Linked to lost+found: 192
Dirs Without Stats Data: 141
....

Most massive fs corruption I've ever had. 
Twice. (I tried it again to get a log, but I don't know if it will be 
helpful).

I blamed the reiserfs bk work at first (which I applied along with your tcq 
patch), but I noted that the fs only gets corrupted with a tcq-enabled kernel 
(every time it seems...).

The machine boots and the filesystem (reiserfs) check says:
Zero bit found in on-disk bitmap after the last valid bit. Switching to 
fix-fixable pass. After which it detects various types of corruption.
(eventually it breaks with fork: Cannot allocate memory - is this a 
fsck.reiserfs problem?)

Here's parts of a log with fastboot on (skip the fs check).
The reiser filesystem had just been repaired, and here it breaks again.
I don't know if I should be sending this to you, but I think tcq causes the 
corruption, since non-tcq 2.5.75 and 2.5.74 appear to run fine.

Kernel command line: auto BOOT_IMAGE=2.5.75-2 ro root=306 single fastboot
...

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L080AVVA07-0, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R1102, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63, UDMA(100)
hda: tagged command queueing enabled, command queue depth 8
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
.....
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
....

Reiserfs journal params: device hda6, size 8192, journal first block 18, max 
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda6) for (hda6)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
Real Time Clock Driver v1.11
Adding 512024k swap on /dev/hda5.  Priority:-1 extents:1
vs-4080: reiserfs_free_block: free_block (hda6:895404)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895260)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895259)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895258)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895257)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895256)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895255)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895254)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895253)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895249)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895248)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895247)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895246)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895245)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895244)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895243)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895242)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895241)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895240)[dev:blocknr]: bit 
already cleared
vs-4080: reiserfs_free_block: free_block (hda6:895187)[dev:blocknr]: bit 
already cleared

> --- drivers/ide/ide-dma.c~	2003-07-11 10:21:04.492561920 +0200
> +++ drivers/ide/ide-dma.c	2003-07-11 10:25:28.183474808 +0200
> @@ -572,10 +572,6 @@
>  	if (HWIF(drive)->ide_dma_host_on(drive))
>  		return 1;
>
> -#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
> -	HWIF(drive)->ide_dma_queued_on(drive);
> -#endif
> -
>  	return 0;
>  }
>
> --- drivers/ide/ide-disk.c~	2003-07-11 10:30:51.783280160 +0200
> +++ drivers/ide/ide-disk.c	2003-07-11 10:31:09.873530024 +0200
> @@ -1665,6 +1665,10 @@
>  	drive->no_io_32bit = id->dword_io ? 1 : 0;
>  	if (drive->id->cfs_enable_2 & 0x3000)
>  		write_cache(drive, (id->cfs_enable_2 & 0x3000));
> +
> +#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
> +	HWIF(drive)->ide_dma_queued_on(drive);
> +#endif
>  }
>
>  static int idedisk_cleanup (ide_drive_t *drive)

