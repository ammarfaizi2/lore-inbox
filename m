Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311483AbSCVJiE>; Fri, 22 Mar 2002 04:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311471AbSCVJhp>; Fri, 22 Mar 2002 04:37:45 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9479 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311466AbSCVJhf>; Fri, 22 Mar 2002 04:37:35 -0500
Date: Fri, 22 Mar 2002 01:23:40 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
cc: devfs mailing list <devfs@oss.sgi.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: support for IDE devices in ide-scsi with devfs
In-Reply-To: <1016736897.3113.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10203220122490.9319-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thankyou sir I have been working towards that direction, but glad and
happy you have assisted !

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On 21 Mar 2002, Borsenkow Andrej wrote:

> Currently using ide-scsi with devfs does not allow you to use hdparm
> interface because no IDE nodes (block devices) are created. The patch
> adds this.
> 
> Related patch for devfsd that creates old compatibility links is going
> to devfs list. I do not think spcial new compatibility links are needed.
> 
> -andrej
> 
> --- linux-2.4.18-4mdk/drivers/scsi/ide-scsi.c.orig	Tue Mar  5 06:08:04 2002
> +++ linux-2.4.18-4mdk/drivers/scsi/ide-scsi.c	Thu Mar 21 21:21:31 2002
> @@ -95,6 +95,7 @@
>  	unsigned long flags;			/* Status/Action flags */
>  	unsigned long transform;		/* SCSI cmd translation layer */
>  	unsigned long log;			/* log flags */
> +	devfs_handle_t de;			/* pointer to IDE device */
>  } idescsi_scsi_t;
>  
>  /*
> @@ -502,6 +503,8 @@
>   */
>  static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi, int id)
>  {
> +	int minor = (drive->select.b.unit) << PARTN_BITS;
> +
>  	DRIVER(drive)->busy++;
>  	idescsi_drives[id] = drive;
>  	drive->driver_data = scsi;
> @@ -516,6 +519,10 @@
>  	set_bit(IDESCSI_LOG_CMD, &scsi->log);
>  #endif /* IDESCSI_DEBUG_LOG */
>  	idescsi_add_settings(drive);
> +	scsi->de = devfs_register(drive->de, "generic", DEVFS_FL_DEFAULT,
> +				     HWIF(drive)->major, minor,
> +				     S_IFBLK | S_IRUSR | S_IWUSR,
> +				     ide_fops, NULL);
>  }
>  
>  static int idescsi_cleanup (ide_drive_t *drive)
> @@ -524,6 +531,8 @@
>  
>  	if (ide_unregister_subdriver (drive))
>  		return 1;
> +	if (scsi->de)
> +		devfs_unregister(scsi->de);
>  	drive->driver_data = NULL;
>  	kfree (scsi);
>  	return 0;
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

