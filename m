Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbSIWSfj>; Mon, 23 Sep 2002 14:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbSIWSfj>; Mon, 23 Sep 2002 14:35:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:49037 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261311AbSIWSfi>;
	Mon, 23 Sep 2002 14:35:38 -0400
Date: Mon, 23 Sep 2002 11:42:21 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Pavel Machek <pavel@ucw.cz>
cc: Andre Hedrick <andre@linux-ide.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: devicefs & sleep support for IDE
In-Reply-To: <20020921210456.GA31784@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0209231136100.6409-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> New patch, rediffed against 2.5.36.
> 
> More patches will be needed to support IDE properly (like DVD burners
> you mentioned), but this is known to fix data corruption. It has zero
> impact on actual I/O. It affects initialization and suspend only.
> Please apply this time.

Basic driver model support for IDE is in 2.5.38. This just involves 
creating an IDE bus type, and registering drives as devices. I.e. there is 
no driver set for any of the drives. 

I do have a couple of comments though.

> +static struct device_driver idedisk_devdrv = {
> +	.lock = RW_LOCK_UNLOCKED,
> +	.suspend = idedisk_suspend,
> +	.resume = idedisk_resume,
> +};

You don't need to initialize .lock. But, you do need a .name and .bus. The 
driver won't even be registered unless .bus is set. 

> @@ -835,6 +837,7 @@
>  	int		crc_count;	/* crc counter to reduce drive speed */
>  	struct list_head list;
>  	struct gendisk *disk;
> +	struct device	device;		/* for driverfs */
>  } ide_drive_t;

There is a struct device in struct gendisk; that should suffice. But note 
that you may have to do an extra conversion in order to access it in the 
driver callbacks. 

> +	struct device	device;		/* for devicefs */

Please: it's driver model support, not driverfs. And devicefs does not 
even exist. :)


Thanks,

	-pat

