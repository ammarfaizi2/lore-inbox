Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263691AbSJGWhX>; Mon, 7 Oct 2002 18:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263692AbSJGWhX>; Mon, 7 Oct 2002 18:37:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25250 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263691AbSJGWhV>;
	Mon, 7 Oct 2002 18:37:21 -0400
Date: Mon, 7 Oct 2002 18:42:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210071231340.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210071839160.29030-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Oct 2002, Patrick Mochel wrote:

> --- a/drivers/ide/ide-probe.c	Mon Oct  7 12:19:11 2002
> +++ b/drivers/ide/ide-probe.c	Mon Oct  7 12:19:11 2002
> @@ -952,6 +952,15 @@
>  
>  EXPORT_SYMBOL(init_irq);
>  
> +static void ide_device_release(struct device * dev)
> +{
> +	ide_drive_t * drive = dev->driver_data;
> +	ide_driver_t * driver = drive->driver;
> +
> +	if (driver && driver->cleanup)
> +		driver->cleanup(drive);
> +}
> +
>  /*
>   * init_gendisk() (as opposed to ide_geninit) is called for each major device,
>   * after probing for drives, to allocate partition tables and other data
> @@ -986,6 +995,8 @@
>  			 "%s","IDE Drive");
>  		disk->disk_dev.parent = &hwif->gendev;
>  		disk->disk_dev.bus = &ide_bus_type;
> +		disk->disk_dev.driver_data = &hwif->drives[unit];
> +		disk->disk_dev.release = ide_device_release;

That is Wrong(tm).  Logics around ->cleanup() doesn't belong to driverfs.
As far as IDE code is concerned, any outside calls of ->cleanup() are
illegal.  What are you trying to achieve with that?

