Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUEJTcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUEJTcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUEJTcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:32:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43394 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261347AbUEJTcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:32:07 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Date: Mon, 10 May 2004 21:25:51 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <409F4944.4090501@keyaccess.nl>
In-Reply-To: <409F4944.4090501@keyaccess.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405102125.51947.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Rene, can you test these (incremental) patches?

[PATCH] set drive->wcache only on the first ->open() call

--- linux/drivers/ide/ide-disk.c.orig   2004-05-07 15:05:46.000000000 +0200
+++ linux/drivers/ide/ide-disk.c        2004-05-07 18:30:09.544793448 +0200
@@ -1758,6 +1758,8 @@
                if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
                        drive->doorlocking = 0;
        }
+       if (drive->usage != 1)
+               return 0;
        drive->wcache = 0;
        /* Cache enabled? */
        if (drive->id->csfo & 1)


Patch below reverts handling of flush cache to be _exactly_ the same
as in 2.4 (no unknown commands on ->suspend() and ->shutdown()).

[PATCH] ide: don't send cacheflush to drives that don't understand it #2

--- linux/drivers/ide/ide-disk.c.orig 2004-05-07 18:30:09.000000000 +0200
+++ linux/drivers/ide/ide-disk.c        2004-05-07 18:34:18.766905928 +0200
@@ -1758,7 +1758,7 @@
                if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
                        drive->doorlocking = 0;
        }
-       if (drive->usage != 1)
+       if (drive->usage != 1 || !drive->removable)
                return 0;
        drive->wcache = 0;
        /* Cache enabled? */

On Monday 10 of May 2004 11:20, Rene Herman wrote:
> Good day.
>
> The 2.6.6-rc3 -> 2.6.6-final changes to ide-disk.c unfortunately make my
> machine complain loudly both at boot and reboot:

These warnings are _harmless_.

Your drives have write cache support
but don't understand flush cache commands.

> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD7409: IDE controller at PCI slot 0000:00:07.1
> AMD7409: chipset revision 7
> AMD7409: not 100% native mode: will probe irqs later
> AMD7409: 0000:00:07.1 (rev 07) UDMA66 controller
>      ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
> hda: Maxtor 6Y120P0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: PLEXTOR DVD-ROM PX-116A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63,
> UDMA(66)
>   hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 > hda2
> hda3 hda4
>   hda2: <bsd: hda14 hda15 hda16 hda17 hda18 >
>   hda4: <minix: hda19 hda20 >
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: Write Cache FAILED Flushing!
>
> The disk, 6Y120P0, is a new-ish Maxtor "DiamondMax Plus 9", 120G, 8M
> cache. Controller is an AMD756. Same complaints on reboot. Reverting the
> rc3->final changes to ide-disk.c fixes/supresses them again.
>
> Rene.

