Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUFUPTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUFUPTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUFUPTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:19:50 -0400
Received: from stress.telefonica.net ([213.4.129.135]:55444 "EHLO
	tnetsmtp2.mail.isp") by vger.kernel.org with ESMTP id S264176AbUFUPTm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:19:42 -0400
Subject: Re: pdc202xx_old serious bug with DMA on 2.6.x series
From: Adolfo =?ISO-8859-1?Q?Gonz=E1lez_Bl=E1zquez?= 
	<agblazquez_mailing@telefonica.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0406211518530.5916@mion.elka.pw.edu.pl>
References: <1087253451.4817.4.camel@localhost>
	 <200406191846.32983.bzolnier@elka.pw.edu.pl>
	 <1087686048.647.9.camel@localhost>
	 <200406200247.32303.bzolnier@elka.pw.edu.pl>
	 <1087782099.2392.7.camel@localhost>
	 <Pine.GSO.4.58.0406211518530.5916@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1087831177.1119.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 17:19:38 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch works perfect! I hope this is the end of this issue.

Maybe you can answer other question i have about pdc202xx_old driver.
Altough the pdc bios shows it is on mode udma5, /proc/ide/pdc202xx shows
the controller is on dma mode UDMA4. hdparm shows disks are on udma5.
This is a bug or is normal behaviour?

Thanks again for your help!!

This is what proc says about pdc202xx:
fito@soho:~$ cat /proc/ide/pdc202xx 

                                Ultra100 on M/B Chipset.
------------------------------- General Status
---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 66 External
IO pad select                        : 10 mA
Status Polling Period                : 0
Interrupt Check Status Polling Delay : 0
--------------- Primary Channel ---------------- Secondary Channel
-------------
                enabled                          enabled 
66 Clocking     disabled                         disabled
           Mode PCI                         Mode PCI   
                FIFO Empty                       FIFO Empty  
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    yes              yes             no                no 
DMA Mode:       UDMA 4           UDMA 4          NOTSET           
NOTSET
PIO Mode:       PIO 4            PIO 4           NOTSET           
NOTSET


El lun, 21-06-2004 a las 16:14, Bartlomiej Zolnierkiewicz escribió:
> On Mon, 21 Jun 2004, Adolfo [ISO-8859-1] González Blázquez wrote:
> 
> > Well, it seems that problem is solved! I'm now using 2.6.7 without
> > problems. Got same perfomance on hard disks as with 2.4.x series.
> >
> > Disabling LBA48 for pdc20265 just made it work. This is the simple patch
> > I applied:
> 
> OK, thanks.  It works but similar patch went into 2.4.23 and you are
> using 2.4.25 without a problems.  Can you try this patch instead?
> 
> --- linux-2.6.7/drivers/ide/ide-probe.c	2004-06-21 15:25:51.000000000 +0200
> +++ linux/drivers/ide/ide-probe.c	2004-06-21 15:29:19.901710936 +0200
> @@ -897,7 +897,7 @@
>  	blk_queue_segment_boundary(q, 0xffff);
> 
>  	if (!hwif->rqsize)
> -		hwif->rqsize = hwif->no_lba48 ? 256 : 65536;
> +		hwif->rqsize = 256;
>  	if (hwif->rqsize < max_sectors)
>  		max_sectors = hwif->rqsize;
>  	blk_queue_max_sectors(q, max_sectors);
> 
> > diff --unified --recursive --new-file
> > linux-2.6.7/drivers/ide/pci/pdc202xx_old.c
> > linux/drivers/ide/pci/pdc202xx_old.c
> > --- linux-2.6.7/drivers/ide/pci/pdc202xx_old.c  2004-06-16
> > 07:20:17.000000000 +0200
> > +++ linux/drivers/ide/pci/pdc202xx_old.c        2004-06-21
> > 02:53:33.000000000 +0200
> > @@ -721,6 +721,10 @@
> >         hwif->tuneproc  = &config_chipset_for_pio;
> >         hwif->quirkproc = &pdc202xx_quirkproc;
> >
> > +       /* This was present on 2.6.0-test4, maybe here is the bug */
> > +       if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
> > +               hwif->no_lba48 = (hwif->channel) ? 0 : 1;
> > +
> >         if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
> >                 hwif->busproc   = &pdc202xx_tristate;
> >                 hwif->resetproc = &pdc202xx_reset;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

