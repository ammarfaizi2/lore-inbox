Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267015AbSLDSep>; Wed, 4 Dec 2002 13:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267016AbSLDSeo>; Wed, 4 Dec 2002 13:34:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6663 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267015AbSLDSem>;
	Wed, 4 Dec 2002 13:34:42 -0500
Message-ID: <3DEE4C84.9000507@pobox.com>
Date: Wed, 04 Dec 2002 13:42:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: James Bottomley <James.Bottomley@steeleye.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model
References: <Pine.LNX.4.33.0212041156080.924-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0212041156080.924-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> ===== drivers/base/bus.c 1.26 vs edited =====
> --- 1.26/drivers/base/bus.c	Sun Dec  1 23:22:04 2002
> +++ edited/drivers/base/bus.c	Wed Dec  4 12:02:41 2002
> @@ -228,6 +228,10 @@
>  {
>  	pr_debug("bound device '%s' to driver '%s'\n",
>  		 dev->bus_id,dev->driver->name);
> +
> +	if (dev->driver->start)
> +		dev->driver->start(dev);
> +
>  	list_add_tail(&dev->driver_list,&dev->driver->devices);
>  	sysfs_create_link(&dev->driver->kobj,&dev->kobj,dev->kobj.name);
>  }
> 
> I don't recall why the change was never done. Perhaps because of other 
> distractions, or it seemed like it would be too much of a PITA to convert 
> drivers to a two-step init sequence (though I think it could be done in a 
> compatible manner).


Possibly because of the "do it in open(2)" rule?

Ignoring the device model entirely, if a driver does a lot of 
talking-to-the-hardware in its probe phase, I consider it buggy, in 2.4 
or 2.5.

The network driver and chardev ones typically follow this rule quite 
well... probe is simple, just registering interfaces with the kernel. 
dev->open is where the driver should (and usually does) power-up the 
hardware, [re-]initialize it, etc.

So each time you come upon a driver that wants dev->driver->start(), 
look closely at the code and wonder why it can't perform the 
dev->driver->start() code in its interface's dev->open member.

	Jeff


