Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTDXPDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTDXPDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:03:01 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12030 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263140AbTDXPDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:03:00 -0400
Date: Thu, 24 Apr 2003 17:14:46 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Let ide interfaces choose a parent device
In-Reply-To: <1051190571.12880.32.camel@gaston>
Message-ID: <Pine.SOL.4.30.0304241711130.19564-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24 Apr 2003, Benjamin Herrenschmidt wrote:

> Hi !
>
> Right now, the parent struct device of IDE interfaces is forced to be
> either the pci_dev or some not-yet implemented legacy node. This is
> wrong as non-PCI ide interfaces may well hang off different bus types.
> For PowerMac, for example, I'm defining a bus type for Apple's "MacIO"
> ASIC and ide/ppc/pmac.c will hang off a device on that bus.
>
> The following patch will let the HWIF fill the parent pointer and only
> put it's "default" stuff in there if it's NULL.

It seems PCI HWIFs are already doing this in ide_pci_setup_ports().

For me patch is okay.

--
Bartlomiej

> --- 1.40/drivers/ide/ide-probe.c	Fri Apr 18 17:58:55 2003
> +++ edited/drivers/ide/ide-probe.c	Thu Apr 24 15:15:15 2003
> @@ -696,10 +696,12 @@
>  	strncpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
>  	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
>  	hwif->gendev.driver_data = hwif;
> -	if (hwif->pci_dev)
> -		hwif->gendev.parent = &hwif->pci_dev->dev;
> -	else
> -		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
> +	if (hwif->gendev.parent == NULL) {
> +		if (hwif->pci_dev)
> +			hwif->gendev.parent = &hwif->pci_dev->dev;
> +		else
> +			hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
> +	}
>  	device_register(&hwif->gendev);
>
>  	if (hwif->mmio == 2)

