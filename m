Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUFUOOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUFUOOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUFUOOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 10:14:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6582 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266244AbUFUOOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 10:14:37 -0400
Date: Mon, 21 Jun 2004 16:14:14 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Adolfo =?ISO-8859-1?Q?Gonz=E1lez_Bl=E1zquez?= 
	<agblazquez_mailing@telefonica.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pdc202xx_old serious bug with DMA on 2.6.x series
In-Reply-To: <1087782099.2392.7.camel@localhost>
Message-ID: <Pine.GSO.4.58.0406211518530.5916@mion.elka.pw.edu.pl>
References: <1087253451.4817.4.camel@localhost>  <200406191846.32983.bzolnier@elka.pw.edu.pl>
  <1087686048.647.9.camel@localhost>  <200406200247.32303.bzolnier@elka.pw.edu.pl>
 <1087782099.2392.7.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Jun 2004, Adolfo [ISO-8859-1] González Blázquez wrote:

> Well, it seems that problem is solved! I'm now using 2.6.7 without
> problems. Got same perfomance on hard disks as with 2.4.x series.
>
> Disabling LBA48 for pdc20265 just made it work. This is the simple patch
> I applied:

OK, thanks.  It works but similar patch went into 2.4.23 and you are
using 2.4.25 without a problems.  Can you try this patch instead?

--- linux-2.6.7/drivers/ide/ide-probe.c	2004-06-21 15:25:51.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2004-06-21 15:29:19.901710936 +0200
@@ -897,7 +897,7 @@
 	blk_queue_segment_boundary(q, 0xffff);

 	if (!hwif->rqsize)
-		hwif->rqsize = hwif->no_lba48 ? 256 : 65536;
+		hwif->rqsize = 256;
 	if (hwif->rqsize < max_sectors)
 		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);

> diff --unified --recursive --new-file
> linux-2.6.7/drivers/ide/pci/pdc202xx_old.c
> linux/drivers/ide/pci/pdc202xx_old.c
> --- linux-2.6.7/drivers/ide/pci/pdc202xx_old.c  2004-06-16
> 07:20:17.000000000 +0200
> +++ linux/drivers/ide/pci/pdc202xx_old.c        2004-06-21
> 02:53:33.000000000 +0200
> @@ -721,6 +721,10 @@
>         hwif->tuneproc  = &config_chipset_for_pio;
>         hwif->quirkproc = &pdc202xx_quirkproc;
>
> +       /* This was present on 2.6.0-test4, maybe here is the bug */
> +       if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
> +               hwif->no_lba48 = (hwif->channel) ? 0 : 1;
> +
>         if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
>                 hwif->busproc   = &pdc202xx_tristate;
>                 hwif->resetproc = &pdc202xx_reset;
