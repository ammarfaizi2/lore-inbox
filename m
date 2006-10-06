Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWJFHxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWJFHxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWJFHxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:53:06 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49734 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750729AbWJFHxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:53:03 -0400
Date: Fri, 6 Oct 2006 09:53:34 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, Jaroslav Kysela <perex@suse.cz>,
       Jiri Kosina <jikos@jikos.cz>, Castet Matthieu <castet.matthieu@free.fr>,
       Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Driver core: Don't ignore error returns from probing
Message-ID: <20061006095334.3cdebcc0@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
References: <20061005175852.GC15180@suse.de>
	<Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 17:03:24 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> Index: 18g20/drivers/base/bus.c
> ===================================================================
> --- 18g20.orig/drivers/base/bus.c
> +++ 18g20/drivers/base/bus.c
> @@ -453,8 +453,10 @@ void bus_remove_device(struct device * d
>  		remove_deprecated_bus_links(dev);
>  		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
>  		device_remove_attrs(dev->bus, dev);
> -		dev->is_registered = 0;
> -		klist_del(&dev->knode_bus);
> +		if (dev->is_registered) {
> +			dev->is_registered = 0;
> +			klist_del(&dev->knode_bus);
> +		}
>  		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
>  		device_release_driver(dev);
>  		put_bus(dev->bus);
> Index: 18g20/drivers/base/core.c
> ===================================================================
> --- 18g20.orig/drivers/base/core.c
> +++ 18g20/drivers/base/core.c
> @@ -485,7 +485,8 @@ int device_add(struct device *dev)
>  	if ((error = bus_add_device(dev)))
>  		goto BusError;
>  	kobject_uevent(&dev->kobj, KOBJ_ADD);
> -	bus_attach_device(dev);
> +	if ((error = bus_attach_device(dev)))
> +		goto AttachError;
>  	if (parent)
>  		klist_add_tail(&dev->knode_parent, &parent->klist_children);
>  
> @@ -504,6 +505,8 @@ int device_add(struct device *dev)
>   	kfree(class_name);
>  	put_device(dev);
>  	return error;
> + AttachError:
> +	bus_remove_device(dev);
>   BusError:
>  	device_pm_remove(dev);
>   PMError:

Hm, I don't think we should call device_release_driver if
bus_attach_device failed (and I think calling bus_remove_device if
bus_attach_device failed is unintuitive). I did a patch that added a
function which undid just the things bus_add_device did (here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115816560424389&w=2),
which unfortunately got lost somewhere... (I'll rebase and resend.)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
