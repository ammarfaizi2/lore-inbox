Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUEMAYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUEMAYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 20:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUEMAYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 20:24:38 -0400
Received: from bern.wildisoft.net ([66.80.62.108]:16398 "EHLO
	bern.wildisoft.net") by vger.kernel.org with ESMTP id S263734AbUEMAYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 20:24:33 -0400
Date: Wed, 12 May 2004 17:24:20 -0700 (PDT)
From: Patrick Wildi <patrick@wildi.com>
X-X-Sender: patrick@bern.wildisoft.net
To: dobrev <dobrev666@prostak.org>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Craig Bradney <cbradney@zip.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
In-Reply-To: <40A270D6.1070802@prostak.org>
Message-ID: <Pine.LNX.4.58.0405121720540.11847@bern.wildisoft.net>
References: <409F4944.4090501@keyaccess.nl> <1084280198.9420.5.camel@amilo.bradney.info>
 <40A0FB04.1000902@prostak.org> <200405122007.46784.bzolnier@elka.pw.edu.pl>
 <40A270D6.1070802@prostak.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, dobrev wrote:

>
>
> Bartlomiej Zolnierkiewicz wrote:
>
> >On Tuesday 11 of May 2004 18:10, dobrev wrote:
> >
> >
> >>Craig Bradney wrote:
> >>
> >>
> >>>On Tue, 2004-05-11 at 13:24, Rene Herman wrote:
> >>>
> >>>
> >>>>Bartlomiej Zolnierkiewicz wrote:
> >>>>
> >>>>
> >>>>>Rene, can you send me copies of /proc/ide/hda/identify and
> >>>>>/proc/ide/hdc/identify?
> >>>>>
> >>>>>
> >>>>Sure, attached. Quite sure you wanted hdc though? That's a DVD-ROM.
> >>>>
> >>>>
> >>>>
> >>>>>I still would like to know why these drives don't accept flush cache
> >>>>>commands (or it is a driver's bug?).
> >>>>>
> >>>>>
> >>>>No idea I'm afraid. Seems at least new Maxtor drives are affected. Both
> >>>>the "120P0" (120G, 8M cache) and "L0" (120G, 2M cache) were reported in
> >>>>this thread.
> >>>>
> >>>>
> >>>At a guess the 80P0 drives will also be affected (80G, 8mb cache), but
> >>>as yet I havent tried 2.6.6 on the boxes with them. Tonight if theres
> >>>time.
> >>>
> >>>Craig
> >>>
> >>>
> >>I have Maxtor 6Y060L0 and is also affected. Now I am with 2.6.5.
> >>
> >>
> >
> >Please see http://bugme.osdl.org/show_bug.cgi?id=2672
> >
> >
>
> Yes, I know.
>
> >
> >
> >>SvrWks IDE controller also have problems with 2.6.6 because the drive
> >>works in mdma2 mode.
> >>When in 2.6.5 the transfer mode is udma2.
> >>
> >>
> >
> >UDMA2 on OSB4?  Weird.
> >
> >from serverwoks.c:
> >
> >	/* If we are about to put a disk into UDMA mode we screwed up.
> >	   Our code assumes we never _ever_ do this on an OSB4 */
> >
> >	if(dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4 &&
> >		drive->media == ide_disk && speed >= XFER_UDMA_0)
> >			BUG();
> >
> >I need more data: .config (2.6.5/2.6.6) and full dmesg output (2.6.5/2.6.6).
> >
> >
>
> Yes, it's a OSB4.
> I attached files you need. .config is the same.
> The problem is that when in 2.6.6 hdparm  reports that the drive is much
> slower than 2.6.5
> 2.6.6 => 13 MB/s
> 2.6.5 => 23 MB/s
> When I  remove the code related to serverworks.c (see bellow) in
> patch-2.6.6 transfer is like 2.6.5.

I believe what happens, is that with the old logic UDMA disks on
OSB4 "fell through the cracks" in svwks_config_drive_xfer_rate().
It was basically a noop (unintentionally) and the settings were
left at whatever BIOS set them to.
Looking through some old threads, it looks like UDMA was considered
not safe on an OSB4.

Patrick

> >
> >
> >>Probably because of this (from patch-2.6.6):
> >>diff -Nru a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
> >>--- a/drivers/ide/pci/serverworks.c     Sun May  9 19:33:36 2004
> >>+++ b/drivers/ide/pci/serverworks.c     Sun May  9 19:33:36 2004
> >>@@ -472,7 +472,9 @@
> >>                                int dma = config_chipset_for_dma(drive);
> >>                                if ((id->field_valid & 2) && !dma)
> >>                                        goto try_dma_modes;
> >>-                       }
> >>+                       } else
> >>+                               /* UDMA disabled by mask, try other DMA
> >>modes */+                               goto try_dma_modes;
> >>                } else if (id->field_valid & 2) {
> >> try_dma_modes:
> >>                        if ((id->dma_mword & hwif->mwdma_mask) ||
> >>
> >>
>
>
>
>
>
