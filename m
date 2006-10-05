Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWJEJ6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWJEJ6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 05:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWJEJ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 05:58:18 -0400
Received: from twin.jikos.cz ([213.151.79.26]:54742 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751314AbWJEJ6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 05:58:17 -0400
Date: Thu, 5 Oct 2006 11:57:11 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Jaroslav Kysela <perex@suse.cz>
cc: Castet Matthieu <castet.matthieu@free.fr>, Takashi Iwai <tiwai@suse.de>,
       LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] ALSA: fix kernel panic in initialization of mpu401 driver
In-Reply-To: <Pine.LNX.4.61.0610050951570.9351@tm8103.perex-int.cz>
Message-ID: <Pine.LNX.4.64.0610051155010.12556@twin.jikos.cz>
References: <Pine.LNX.4.64.0610042216240.12556@twin.jikos.cz>
 <Pine.LNX.4.61.0610050951570.9351@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Jaroslav Kysela wrote:

> Unfortunately, I do not think that it's a proper solution. I think that 
> platform device layer should play more nicely and if probe() fails for a 
> reason and if platform_device_register_simple() does not set IS_ERR(), 
> then platform_device_unregister() must be callable to free all 
> resources.

I agree.

> I would reject this patch and fix drivers/base/bus.c. The problematic 
> change is in commit f2eaae197f4590c4d96f31b09b0ee9067421a95c and this 
> patch will probably fix it:
> [PATCH] drivers/base - check if device is registered before removal
> Without this fix platform_device_unregister() might oops.
> Signed-off-by: Jaroslav Kysela <perex@suse.cz>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 12173d1..daa2390 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -428,8 +428,10 @@ void bus_remove_device(struct device * d
>  		sysfs_remove_link(&dev->kobj, "bus");
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

Yes, it (among other things) fixes the panic in MPU401 initialization.

Acked-by: Jiri Kosina <jikos@jikos.cz>

-- 
Jiri Kosina
