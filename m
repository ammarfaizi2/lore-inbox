Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUBCX4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUBCX4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:56:36 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48589 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266217AbUBCX4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:56:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: s0348365@sms.ed.ac.uk
Subject: Re: 2.6.2-rc3-mm1
Date: Wed, 4 Feb 2004 01:00:40 +0100
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <20040202235817.5c3feaf3.akpm@osdl.org> <200402031932.52913.bzolnier@elka.pw.edu.pl> <200402032347.36489.s0348365@sms.ed.ac.uk>
In-Reply-To: <200402032347.36489.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402040100.40682.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 of February 2004 00:47, Alistair John Strachan wrote:
> On Tuesday 03 February 2004 18:32, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 03 of February 2004 18:39, Alistair John Strachan wrote:
> > > On Tuesday 03 February 2004 07:58, Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-r
> > > >c3 /2 .6 .2-rc3-mm1/
> > > >
> > > > <...>
> > > >
> > >
> > > Doesn't boot on this machine. It hangs after:
> > >
> > > NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
> > >     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
> > >     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> > > hda: Maxtor 6Y080P0, ATA DISK drive
> > > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > hdc: CD-RW CR52, ATAPI CD/DVD-ROM drive
> > > hdd: SAMSUNG DVD-ROM SD-616Q, ATAPI CD/DVD-ROM drive
> > > ide1 at 0x170-0x177,0x376 on irq 15
> > > PDC20270: IDE controller at PCI slot 0000:01:09.0
> > > PDC20270: chipset revision 2
> > > PDC20270: 100% native mode on irq 17
> > >     ide2: BM-DMA at 0xd000-0xd007, BIOS settings: hde:pio, hdf:pio
> > >     ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:pio, hdh:pio
> > > hde: Maxtor 6Y120P0, ATA DISK drive
> > > ide2 at 0xc000-0xc007,0xc402 on irq 17
> > > hdg: Maxtor 6Y120P0, ATA DISK drive
> > > ide3 at 0xc800-0xc807,0xcc02 on irq 17
> > > hda: max request size: 128KiB
> > > hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63,
> > > UDMA(133) /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> > > hde: max request size: 128KiB
> > >
> > > 30 seconds later, I get something like:
> > >
> > > hde: lost interrupt
> > > hde: lost interrupt
> >
> > It seems kernel hangs in ide-disk.c, idedisk_setup()->write_cache()->...
> >
> > > The kernel does not recover. Presumably it is a problem specific to my
> > > PDC IDE controller.
> >
> > Do you run with Promise BIOS disabled?  If so please try booting kernel
> > with "hde=autotune hdg=autotune" parameters.  If still no-go, try this
> > patch:
>
> Neither suggestion changes the behaviour. I've got the BIOS enabled, but in
> the past it's made no difference. I still see lost interrupts.

Please try this debugging patch to see it hangs on
idedisk_setup()->write_cache().

--- linux/drivers/ide/ide-disk.c	2004-02-04 00:57:49.000000000 +0100
+++ linux-2.6.2-rc3-bk3/drivers/ide/ide-disk.c	2004-02-04 00:58:58.571025744 +0100
@@ -1668,8 +1668,10 @@
 #endif	/* CONFIG_IDEDISK_MULTI_MODE */
 	}
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
+	printk(KERN_INFO "%s: before write_cache()\n", drive->name);
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
+	printk(KERN_INFO "%s: after write_cache()\n", drive->name);
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 	if (drive->using_dma)

