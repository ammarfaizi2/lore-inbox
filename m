Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275523AbTHMVcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275528AbTHMVcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:32:08 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:19466 "EHLO
	mail4.cybertrails.com") by vger.kernel.org with ESMTP
	id S275523AbTHMVbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:31:21 -0400
Date: Wed, 13 Aug 2003 14:31:08 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Deep call trace from PCMCIA CF eject
Message-Id: <20030813143108.658248b9.dickson@permanentmail.com>
In-Reply-To: <200308131950.16912.bzolnier@elka.pw.edu.pl>
References: <20030813072456.35d62460.dickson@permanentmail.com>
	<20030813175311.B20676@flint.arm.linux.org.uk>
	<200308131950.16912.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 19:50:16 +0200, Bartlomiej Zolnierkiewicz wrote:

> On Wednesday 13 of August 2003 18:53, Russell King wrote:
> >
> > The problem is IDE - ide_unregister() does the following:
> >
> >         spin_lock_irq(&ide_lock);
> > ...
> >         blk_unregister_region(MKDEV(hwif->major, 0),
> > MAX_DRIVES<<PARTN_BITS);
> >
> > Since blk_unregister_region is sleepy, and sleeping with a spinlock
> > held is a big NO NO, it's an IDE problem not a PCMCIA problem.  It
> > should be calling blk_unregister_region with a spinlock held.
> 
> Yep, thanks.
> This patch should be sufficient until ide locking rework is ready.
> 
> --bartlomiej
> 
>  drivers/ide/ide.c |   23 +++++++++++------------
>  1 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff -puN drivers/ide/ide.c~ide-unregister-bandaid drivers/ide/ide.c
> --- linux-2.6.0-test2-bk7/drivers/ide/ide.c~ide-unregister-bandaid	2003-08-13 19:39:13.281512048 +0200
> +++ linux-2.6.0-test2-bk7-root/drivers/ide/ide.c	2003-08-13 19:43:49.900459576 +0200
> @@ -778,6 +778,17 @@ void ide_unregister (unsigned int index)
>  	/* More fucked up locking ... */
>  	spin_unlock_irq(&ide_lock);
>  	device_unregister(&hwif->gendev);
> +
> +	/*
> +	 * Remove us from the kernel's knowledge
> +	 */
> +	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
> +	for (i = 0; i < MAX_DRIVES; i++) {
> +		struct gendisk *disk = hwif->drives[i].disk;
> +		hwif->drives[i].disk = NULL;
> +		put_disk(disk);
> +	}
> +	unregister_blkdev(hwif->major, hwif->name);
>  	spin_lock_irq(&ide_lock);
>  
>  #if !defined(CONFIG_DMA_NONPCI)
> @@ -793,18 +804,6 @@ void ide_unregister (unsigned int index)
>  		hwif->dma_prdtable = 0;
>  	}
>  #endif /* !(CONFIG_DMA_NONPCI) */
> -
> -	/*
> -	 * Remove us from the kernel's knowledge
> -	 */
> -	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
> -	for (i = 0; i < MAX_DRIVES; i++) {
> -		struct gendisk *disk = hwif->drives[i].disk;
> -		hwif->drives[i].disk = NULL;
> -		put_disk(disk);
> -	}
> -	unregister_blkdev(hwif->major, hwif->name);
> -
>  	old_hwif			= *hwif;
>  	init_hwif_data(index);	/* restore hwif data to pristine status */
>  	hwif->hwgroup			= old_hwif.hwgroup;
> 


Much, much better.  Here's the log entries during an eject and insert.

Eject:

Aug 13 14:15:48 violet cardmgr[1552]: executing: './ide check hde'
Aug 13 14:15:49 violet cardmgr[1552]: executing: './ide stop hde'
Aug 13 14:15:49 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 13 14:15:49 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug 13 14:15:49 violet kernel: hde: Write Cache FAILED Flushing!
Aug 13 14:15:49 violet cardmgr[1552]: + /dev/hde1 umounted
Aug 13 14:15:49 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.
Aug 13 14:15:50 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 13 14:15:50 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug 13 14:15:50 violet kernel: hde: Write Cache FAILED Flushing!
Aug 13 14:15:50 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 14:15:50 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 14:15:50 violet /sbin/hotplug: no runnable /etc/hotplug/ide.agent is installed


Insert:

Aug 13 14:17:04 violet cardmgr[1552]: socket 1: ATA/IDE Fixed Disk
Aug 13 14:17:08 violet kernel: hde: LEXAR ATA_FLASH, CFA DISK drive
Aug 13 14:17:08 violet kernel: hdf: probing with STATUS(0x00) instead of ALTSTATUS(0x0a)
Aug 13 14:17:08 violet kernel: hdf: probing with STATUS(0x00) instead of ALTSTATUS(0x0a)
Aug 13 14:17:08 violet kernel: ide2 at 0x100-0x107,0x10e on irq 3
Aug 13 14:17:08 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 14:17:08 violet kernel: hde: max request size: 128KiB
Aug 13 14:17:08 violet kernel: hde: 62976 sectors (32 MB) w/1KiB Cache, CHS=984/2/32
Aug 13 14:17:08 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 14:17:08 violet kernel:  hde: hde1
Aug 13 14:17:08 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 13 14:17:08 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug 13 14:17:08 violet kernel: hde: Write Cache FAILED Flushing!
Aug 13 14:17:08 violet kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Aug 13 14:17:09 violet /sbin/hotplug: no runnable /etc/hotplug/ide.agent is installed
Aug 13 14:17:08 violet cardmgr[1552]: executing: './ide start hde'
Aug 13 14:17:09 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 14:17:09 violet kernel:  hde: hde1
Aug 13 14:17:09 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 14:17:09 violet cardmgr[1552]: + /dev/hde1 on /mnt/card type vfat (rw,gid=500,uid=500)
Aug 13 14:17:09 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.
Aug 13 14:17:20 violet ntpd[2231]: kernel time discipline status change 1

	-Paul

