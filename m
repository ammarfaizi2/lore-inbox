Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267811AbUHPRSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267811AbUHPRSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267809AbUHPRSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:18:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11507 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267804AbUHPRSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:18:04 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: add drive_to_key functions
Date: Mon, 16 Aug 2004 19:12:26 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815145844.GA10778@devserv.devel.redhat.com>
In-Reply-To: <20040815145844.GA10778@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161912.26595.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 16:58, Alan Cox wrote:
> Clear new remove field
> Clear pci_dev field on init
> Add functions that allow us to keep persistent (reasonably so anyway) keys
> 	not pointers to drive objects in the /proc file. Worst case is you
> 	reload the driver 64K times and get the new data not an error.
> Clean up ide_system_bus_speed docs
>
>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.8-rc3/drivers/ide/ide.c linux-2.6.8-rc3/drivers/ide/ide.c
> --- linux.vanilla-2.6.8-rc3/drivers/ide/ide.c	2004-08-09 15:51:00.000000000
> +0100 +++ linux-2.6.8-rc3/drivers/ide/ide.c	2004-08-12 17:55:05.000000000
> +0100 @@ -219,12 +219,15 @@
>  	hwif->name[3]	= '0' + index;
>
>  	hwif->bus_state	= BUSSTATE_ON;
> -
> +

whitespace damage

>  	hwif->atapi_dma = 0;		/* disable all atapi dma */
>  	hwif->ultra_mask = 0x80;	/* disable all ultra */
>  	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
>  	hwif->swdma_mask = 0x80;	/* disable all swdma */
>
> +	hwif->pci_dev = NULL;
> +	hwif->remove = NULL;
> +

not needed - memsetting to zero is done earlier

>  	sema_init(&hwif->gendev_rel_sem, 0);
>
>  	default_hwif_iops(hwif);
> @@ -321,12 +324,67 @@
>  }
>
>  /*
> - * ide_system_bus_speed() returns what we think is the system VESA/PCI
> - * bus speed (in MHz).  This is used for calculating interface PIO
> timings. - * The default is 40 for known PCI systems, 50 otherwise.
> - * The "idebus=xx" parameter can be used to override this value.
> - * The actual value to be used is computed/displayed the first time
> through. + *	ide_drive_from_key	-	turn key into drive
> + *	@kval: persistent key
> + *
> + *	Convert a key into a drive. Currently the key is packed as
> + *	[keyval] << 16 | hwif << 8 | drive_num. Caller must hold
> + *	ide_settings_sem for the duration of the returned reference
> + */
> +
> +ide_drive_t *ide_drive_from_key(void *kval)
> +{
> +	unsigned long key = (unsigned long) kval;
> +	int idx = (key >> 8) & 0xFF;
> +	int drive = key & 3;
> +	ide_hwif_t *hwif = &ide_hwifs[idx];
> +	ide_drive_t *ret;
> +
> +	key >>= 16;
> +
> +	if(hwif->configured == 0 || hwif->present == 0 ||
> hwif->drives[drive].dead || hwif->key != key) +		ret = NULL;
> +	else
> +		ret = &ide_hwifs[idx].drives[drive];
> +
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL_GPL(ide_drive_from_key);
> +
> +/*
> + *	ide_drive_to_key	-	turn drive to persistent key
> + *	@drive: drive to use
> + *
> + *	Convert drive into a key. Currently the key is packed as
> + *	[keyval] << 16 | hwif << 8 | drive_num. Caller must hold
> + *	ide_settings_sem for the duration of the returned reference
>   */
> +
> +void *ide_drive_to_key(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = HWIF(drive);
> +	unsigned long val;
> +
> +	val = (hwif->index << 8) | (hwif->key << 16) | drive->select.b.unit;
> +	return (void *)val;
> +}
> +
> +EXPORT_SYMBOL_GPL(ide_drive_to_key);

AFAICS ide_drive_[from,to]_key are to be used only from ide-proc.c
so EXPORT_SYMBOLs are not needed

> +/**
> + *	ide_system_bus_speed	-	guess bus speed
> + *
> + *	ide_system_bus_speed() returns what we think is the system VESA/PCI
> + *	bus speed (in MHz).  This is used for calculating interface PIO
> timings. + *	The default is 40 for known PCI systems, 50 otherwise.
> + *	The "idebus=xx" parameter can be used to override this value.
> + *	The actual value to be used is computed/displayed the first time
> + *	through. Drivers should only use this as a last resort.
> + *
> + *	Returns a guessed speed in Mhz
> + */
> +
>  int ide_system_bus_speed (void)
>  {
>  	if (!system_bus_speed) {
>

This change belongs to "ide DocBook fixes" patch.
