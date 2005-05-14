Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVENH2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVENH2h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 03:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVENH2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 03:28:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:63170 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262700AbVENH21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 03:28:27 -0400
Date: Sat, 14 May 2005 00:28:26 -0700
From: Greg KH <greg@kroah.com>
To: "McMullan, Jason" <jason.mcmullan@timesys.com>, ecashin@coraid.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.11.7] ATA Over Ethernet Root, Mark 2
Message-ID: <20050514072826.GB20021@kroah.com>
References: <1116011879.9050.92.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116011879.9050.92.camel@jmcmullan.timesys>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 03:12:07PM -0400, McMullan, Jason wrote:
> Second revision of my ATA Over Ethernet root device patch, now with
> white space correction and removed debugging crud.
> 
> Any more comment, suggestions?

I'm guessing you are only testing this out on devfs?

Why not fix this up properly, and allow root devices on _any_ type of
block device that is not immediately present at "try to mount time"?  The
USB and firewire users of the world will love you...

Also, please CC the aoe maintainer, that's documented in
Documentation/SubmittingPatches :)


> +config ATA_OVER_ETH_ROOT_SHELF
> +	int "Shelf ID"
> +	depends on ATA_OVER_ETH_ROOT

Ick.  Why not use a boot parameter if you really want to use something
so icky (hint, we should rely on the name or major/minor, not something
else like this.)

> --- linux-orig/drivers/block/aoe/aoeblk.c
> +++ linux/drivers/block/aoe/aoeblk.c
> @@ -229,6 +229,7 @@
>  	gd->capacity = d->ssize;
>  	snprintf(gd->disk_name, sizeof gd->disk_name, "etherd/e%ld.%ld",
>  		d->aoemajor, d->aoeminor);
> +	strncpy(gd->devfs_name, gd->disk_name, sizeof gd->devfs_name);

You do know devfs is going away in 2 months, right?

> +#ifdef CONFIG_ATA_OVER_ETH_ROOT
> +void aoe_root(unsigned long major, unsigned long minor)
> +{
> +	struct net_device *dev;
> +
> +	printk(KERN_INFO
> +		"aoe: Waiting for root AOE device e%ld.%ld\n", major, minor);
> +
> +	/* Give hardware a chance to settle */
> +	msleep(500);
> +
> +	rtnl_shlock();
> +	/* bring loopback device up first */
> +	if (dev_change_flags(&loopback_dev, loopback_dev.flags | IFF_UP) < 0)
> +		printk(KERN_ERR "AOE Root: Failed to open %s\n", loopback_dev.name);
> +
> +	/* Setup all network devices */
> +	for (dev = dev_base; dev ; dev = dev->next) {
> +		if (dev == &loopback_dev)
> +			continue;
> +		dev_change_flags(dev, dev->flags | IFF_UP);
> +	}
> +	rtnl_shunlock();
> +
> +	/* Give drivers a chance to settle */
> +	ssleep(1);
> +
> +	do {
> +		aoecmd_cfg(major, minor);
> +		msleep(1);
> +	} while (!aoedev_bymajor_minor(CONFIG_ATA_OVER_ETH_ROOT_SHELF,CONFIG_ATA_OVER_ETH_ROOT_SLOT));

Looks like you are mixing up shelf and slot values with major and minor
numbers.  I'm confused.

> +
> +}
> +#endif
> +
>  static void
>  aoe_exit(void)
>  {
> @@ -63,6 +106,7 @@
>  	aoechr_exit();
>  	aoedev_exit();
>  	aoeblk_exit();		/* free cache after de-allocating bufs */
> +	devfs_remove("etherd");
>  }
>  
>  static int __init
> @@ -70,6 +114,8 @@
>  {
>  	int ret;
>  
> +	devfs_mk_dir("etherd");
> +	        

Should be in a separate patch, to fix up devfs issues in the driver,
right?  This goes for the other devfs calls in this patch.  That is if
you don't mind me removing them in 2 months :)

>  	ret = aoedev_init();
>  	if (ret)
>  		return ret;
> @@ -91,6 +137,9 @@
>  	printk(KERN_INFO
>  	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",
>  	       VERSION);
> +#ifdef CONFIG_ATA_OVER_ETH_ROOT
> +	aoe_root(CONFIG_ATA_OVER_ETH_ROOT_SHELF,CONFIG_ATA_OVER_ETH_ROOT_SLOT);

Again with the major/minor confusion.  I'm really confused now (you pass
the values in, yet use them as #defines in the function...)

> +#endif

And you could do this without an ifdef, if you really needed to do so.

So, my main question is, why is this patch needed?  Is it because aoe
devices aren't quite present and found quick enough during the boot
process?  If so, I suggest one of the two solutions:
	- do like the rest of the world does for usb and firewire and
	  other types of slow boot devices and use an initrd/initramfs
	  that mounts the root partition after it is properly found.
	  Distros do this all the time, so there are lots of examples to
	  pull from if you want to do this for yours.
	- fix up the patch that is floating around that allows the
	  kernel to pause and wait and not oops out if the root
	  partition is not found.  That way all users of all kinds of
	  slow devices can benefit, and driver specific hacks like this
	  are not needed.

Andrew, care to drop this from your tree until it gets sorted out?

thanks,

greg k-h
