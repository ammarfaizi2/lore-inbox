Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUBCTnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266039AbUBCTXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:23:49 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51181 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266102AbUBCS2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:28:39 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: s0348365@sms.ed.ac.uk, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc3-mm1
Date: Tue, 3 Feb 2004 19:32:52 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040202235817.5c3feaf3.akpm@osdl.org> <200402031739.43321.s0348365@sms.ed.ac.uk>
In-Reply-To: <200402031739.43321.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402031932.52913.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 of February 2004 18:39, Alistair John Strachan wrote:
> On Tuesday 03 February 2004 07:58, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc3/2
> >.6 .2-rc3-mm1/
> >
> >
> > - There is a debug patch in here which detects when someone calls
> >   i_size_write() without holding the inode's i_sem.  It generates a
> > warning and a stack backtrace.  We know that XFS generates such a trace. 
> > It will turn itself off after the first ten warnings.  Please don't
> > report the XFS case.
> >
> > - Added the CPU hotplug code.
> >
> > - This kernel is currently broken on ppc64.  Something to do with the
> >   sched-domains patch although at this stage we do not know whether the
> >   problem lies with that patch or with the ppc64 code.
> >
> > - A big Altix update
> >
> > - Latest versions of various other developers' trees.  See below for
> >   details.
> >
> > - Various other fixes
>
> Doesn't boot on this machine. It hangs after:
>
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: Maxtor 6Y080P0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: CD-RW CR52, ATAPI CD/DVD-ROM drive
> hdd: SAMSUNG DVD-ROM SD-616Q, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> PDC20270: IDE controller at PCI slot 0000:01:09.0
> PDC20270: chipset revision 2
> PDC20270: 100% native mode on irq 17
>     ide2: BM-DMA at 0xd000-0xd007, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:pio, hdh:pio
> hde: Maxtor 6Y120P0, ATA DISK drive
> ide2 at 0xc000-0xc007,0xc402 on irq 17
> hdg: Maxtor 6Y120P0, ATA DISK drive
> ide3 at 0xc800-0xc807,0xcc02 on irq 17
> hda: max request size: 128KiB
> hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63,
> UDMA(133) /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> hde: max request size: 128KiB
>
> 30 seconds later, I get something like:
>
> hde: lost interrupt
> hde: lost interrupt

It seems kernel hangs in ide-disk.c, idedisk_setup()->write_cache()->...

> The kernel does not recover. Presumably it is a problem specific to my PDC
> IDE controller.

Do you run with Promise BIOS disabled?  If so please try booting kernel with
"hde=autotune hdg=autotune" parameters.  If still no-go, try this patch:

 linux-2.6.2-rc3-bk3-root/drivers/ide/pci/pdc202xx_new.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff -puN drivers/ide/pci/pdc202xx_new.c~pdc202xx_new_pio_fix drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.2-rc3-bk3/drivers/ide/pci/pdc202xx_new.c~pdc202xx_new_pio_fix	2004-02-03 19:19:38.946159184 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/pci/pdc202xx_new.c	2004-02-03 19:31:19.744621624 +0100
@@ -140,6 +140,7 @@ static int check_in_drive_lists (ide_dri
 	return 0;
 }
 
+#if 0
 static int pdcnew_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -241,6 +242,7 @@ static int pdcnew_tune_chipset (ide_driv
 
 	return (ide_config_drive_speed(drive, speed));
 }
+#endif
 
 static int pdcnew_new_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
@@ -294,8 +296,8 @@ static int config_chipset_for_pio (ide_d
 
 	if (pio == 5) pio = 4;
 	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, pio, NULL);
-        
-	return ((int) pdcnew_tune_chipset(drive, speed));
+
+	return pdcnew_new_tune_chipset(drive, speed);
 }
 
 static void pdcnew_tune_drive (ide_drive_t *drive, u8 pio)
@@ -590,10 +592,7 @@ static void __init init_hwif_pdc202new (
 	hwif->speedproc = &pdcnew_new_tune_chipset;
 	hwif->resetproc = &pdcnew_new_reset;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-		return;
-	}
+	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;

_


