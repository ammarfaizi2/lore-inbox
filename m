Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261378AbSIWVTM>; Mon, 23 Sep 2002 17:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSIWVTM>; Mon, 23 Sep 2002 17:19:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:17417 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261378AbSIWVTJ>; Mon, 23 Sep 2002 17:19:09 -0400
Date: Mon, 23 Sep 2002 23:24:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: devicefs & sleep support for IDE
Message-ID: <20020923212411.GA19391@atrey.karlin.mff.cuni.cz>
References: <20020921210456.GA31784@elf.ucw.cz> <Pine.LNX.4.44.0209231136100.6409-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209231136100.6409-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > New patch, rediffed against 2.5.36.
> > 
> > More patches will be needed to support IDE properly (like DVD burners
> > you mentioned), but this is known to fix data corruption. It has zero
> > impact on actual I/O. It affects initialization and suspend only.
> > Please apply this time.
> 
> Basic driver model support for IDE is in 2.5.38. This just involves 
> creating an IDE bus type, and registering drives as devices. I.e. there is 
> no driver set for any of the drives. 

Yep, I saw the support and it confused me a lot.

Questions: is it possible that in hwif_register you don't need to
initialize parent?

Where is device_put of hwif->gendev? I miss it.

> I do have a couple of comments though.
> 
> > +static struct device_driver idedisk_devdrv = {
> > +	.lock = RW_LOCK_UNLOCKED,
> > +	.suspend = idedisk_suspend,
> > +	.resume = idedisk_resume,
> > +};
> 
> You don't need to initialize .lock. But, you do need a .name and .bus. The 
> driver won't even be registered unless .bus is set. 
> 
> > @@ -835,6 +837,7 @@
> >  	int		crc_count;	/* crc counter to reduce drive speed */
> >  	struct list_head list;
> >  	struct gendisk *disk;
> > +	struct device	device;		/* for driverfs */
> >  } ide_drive_t;
> 
> There is a struct device in struct gendisk; that should suffice. But note 
> that you may have to do an extra conversion in order to access it in the 
> driver callbacks. 

Thanx for info.

Ouch. There are actually two devices in struct gendisk. I choosed
disk_dev. Was it right?

> > +	struct device	device;		/* for devicefs */
> 
> Please: it's driver model support, not driverfs. And devicefs does not 
> even exist. :)

Okay, okay ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
