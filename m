Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVDHTEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVDHTEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVDHTEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:04:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16139 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262926AbVDHTD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:03:57 -0400
Date: Fri, 8 Apr 2005 20:03:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ian Molton <spyro@f2s.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH add support for system on chip (SoC) devices.
Message-ID: <20050408200352.C2905@flint.arm.linux.org.uk>
Mail-Followup-To: Ian Molton <spyro@f2s.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org
References: <42569300.7070008@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42569300.7070008@f2s.com>; from spyro@f2s.com on Fri, Apr 08, 2005 at 03:19:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:19:44PM +0100, Ian Molton wrote:
> This allows common drivers used in different SoC devices to be shared in 
> a clean and healthy manner, for example, the MMC function on toshiba 
> t7l66xb, tc6393xb, and Compaq IPAQ ASIC3.

Here's some comments on the patch itself.  I'm not endorsing it by
replying to it though.

> Please apply.

No.  Please review first.

> +static int soc_bus_suspend(struct device * dev, u32 state)
> +{
> +	struct device_driver * drv = dev->driver;
> +	int ret = 0;
> +
> +	if (drv && drv->suspend) {
> +		ret = drv->suspend(dev, state, SUSPEND_DISABLE);
> +		if (ret == 0)
> +			ret = drv->suspend(dev, state, SUSPEND_SAVE_STATE);
> +		if (ret == 0)
> +			ret = drv->suspend(dev, state, SUSPEND_POWER_DOWN);

Please don't use the obsolete "level" parameter.  This appears for
platform devices solely because that is how an older revision of the
Linux power management infrastructure was implemented, and it was
deemed to be wrong.  Unfortunately, platform devices never got fixed.

Therefore, it's completely wrong for any new subsystem to re-implement
this.

> +	}
> +
> +	return ret;
> +}
> +
> +static int soc_bus_resume(struct device * dev)
> +{
> +	struct device_driver * drv = dev->driver;
> +	int ret = 0;
> +
> +	if (drv && drv->resume) {
> +		ret = drv->resume(dev, RESUME_POWER_ON);
> +		if (ret == 0)
> +			ret = drv->resume(dev, RESUME_RESTORE_STATE);
> +		if (ret == 0)
> +			ret = drv->resume(dev, RESUME_ENABLE);

Ditto.

> +extern int soc_device_register(struct soc_device * dev)
> +{
> +	int i, j, rc = 0;
> +	struct platform_device *pdev = to_platform_device (dev->device.parent);

What if dev->device.parent is NULL?  Do all SoC devices have to have a
parent?  How says that the parent device has to be a platform device?

> +
> +	dev->device.bus = &soc_bus_type;
> +
> +	snprintf(dev->device.bus_id, BUS_ID_SIZE, "%s", dev->name);
> +
> +	if (dev->num_resources) {
> +		dev->parent_resource = kmalloc (dev->num_resources * sizeof (struct resource *), GFP_KERNEL);
> +		if (!dev->parent_resource)
> +			return -ENOMEM;
> +	} else
> +		dev->parent_resource = NULL;
> +	dev->num_parent_resources = 0;
> +
> +	for (i = 0; i < dev->num_resources; i++) {
> +		struct resource *res = &dev->resource[i];
> +		int best = -1;
> +
> +		res->name = dev->device.bus_id;
> +
> +		/* For now just skip bus-specific resources */
> +		if (res->flags & (IORESOURCE_BITS | IORESOURCE_SOC_VIRTUAL))
> +			continue;
> +
> +		/* We must claim the platform resource containing this subresource */
> +		for (j = 0; j < pdev->num_resources; j++) {
> +			/* Shamelessly borrowed from pci.c */
> +			struct resource *r = &pdev->resource[j];
> +			if (res->start && !(res->start >= r->start && res->end <= r->end))
> +				continue;	/* Not contained */
> +			if ((res->flags ^ r->flags) & (IORESOURCE_IO | IORESOURCE_MEM))
> +				continue;	/* Wrong type */
> +			if (!((res->flags ^ r->flags) & IORESOURCE_PREFETCH)) {
> +				best = j;	/* Exact match */
> +				break;
> +			}
> +			if ((res->flags & IORESOURCE_PREFETCH) && !(r->flags & IORESOURCE_PREFETCH))
> +				best = j;	/* Approximating prefetchable by non-prefetchable */
> +		}

This is actually something which should be fixed for platform
devices as well.  Platform devices can be heirarcial as well,
so this functionality should be abstracted from both this
_and_ PCI.

I'm sure it also applies to other buses as well.

> +		if (best >= 0) {
> +			struct resource *r = &pdev->resource[best];
> +			if ((rc = request_resource (r, res))) {
> +				printk(KERN_ERR "%s: failed to claim resource %d (at %08lx-%08lx)\n",
> +				       dev->name, i, res->start, res->end);
> +				goto err1;
> +			}
> +			dev->parent_resource[dev->num_parent_resources++] = res;

>From what I can tell, dev->parent_resource is misnamed.  It isn't about
parent resources at all, but about which resources have been successfully
requested and which haven't.  You know that already - your index 'i' tells
you how far through dev->resource[] you are, so when you come to clean up
after an error, you start from i-1 to 0.

> +		} else {
> +			if (!(res->flags & IORESOURCE_SOC_VIRTUAL)) {

What's a SoC virtual resource?

> +				printk (KERN_ERR "%s: cannot find resource %d in platform resources\n",
> +					dev->name, i);
> +				rc = -ENOENT;
> +				goto err1;
> +			}
> +		}
> +	}
> +
> +	if (!(rc = device_register(&dev->device)))
> +		return 0;
> +
> +err1:
> +	for (i = 0; i < dev->num_parent_resources; i++) {
> +		struct resource *r = dev->parent_resource[i];
> +		release_resource (r); 
> +	}
> +	if (dev->parent_resource)
> +		kfree (dev->parent_resource);
> +	return rc;
> +}
> +EXPORT_SYMBOL(soc_device_register);
> +
> +extern void soc_device_unregister(struct soc_device * dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < dev->num_parent_resources; i++) {
> +		struct resource *r = dev->parent_resource[i];
> +		release_resource (r); 
> +	}
> +
> +	if (dev->parent_resource)
> +		kfree (dev->parent_resource);
> +
> +	device_unregister(&dev->device);
> +}
> +EXPORT_SYMBOL(soc_device_unregister);

How are SoC devices freed?  With the infrastructure as currently written:

1. you can't use soc_device_register() with a data structure located in
   module data.
2. I can't see how you're handling any of the lifetime issues associated
   with the device model.

> +Why do we need a SoC bus?
> +-------------------------
> +
> +Particularly in embedded platforms, it is now becomming common to find that
> +chips are being developed to contain many 'subdevices', including video
> +display, audio, serial, USB, etc. From now on, the 'subdevices' will be
> +referred to as 'cells'.
> +
> +These cells may also share local memory pools and power control, perhaps via
> +common register sets.
> +
> +The SoC bus doesnt directly address issues relating to the above, but it does
> +provide a framework for them to be tackled, and a method for registering such
> +devices cleanly.

If:
1. this code doesn't address these issues,
2. apart from the heirarchial resource issue mentioned above,
3. using numeric IDs rather than strings to match devices to drivers

how is this any different from the existing platform device infrastructure?

> +The SoC base driver handles registration and allocation of basic resources,
> +along with any initialisation required to bring up the core of the device. It
> +is not specified wether the base driver is to handle mapping of any IO
> +regions - this is left to the discretion of the driver author to decide as
> +best fits each case. Some SoC drivers pass virtual addresses to their cell
> +drivers, others may pass physical addresses.

I don't see any support for this in the submitted code.

> +Once it has setup the struct soc_device, it simply calls soc_device_register.
> +
> +Cell drivers work much like any normal driver - they supply probe_ and remove_
> +functions, and register them in a struct soc_device_driver, via a call to
> +soc_driver_register().

Again, it appears that there has been no consideration of the lifetime
issues associated with the device model.  These issues are not taken
care of for you - failure to consider them means that it's trivially
easy to cause a kernel oops.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
