Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVAGHWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVAGHWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVAGHWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:22:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:12676 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261296AbVAGHWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:22:30 -0500
Date: Thu, 6 Jan 2005 23:22:22 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050107072222.GB24441@kroah.com>
References: <20041027075248.GA26760@pointless.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027075248.GA26760@pointless.research.nokia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 10:52:48AM +0300, Paul Mundt wrote:
> This adds support for the SuperHyway bus currently used by sh64 and also used
> by newer sh4a cores. This just adds the common bus support, with things like
> bus scanning being architecture dependent. sh64 presently makes use of this
> for its DMAC, with further device support planned.

So it looks like you are just adding a fake "bus" driver and then
manually adding the bus devices to the root device.  Why not just
complete the conversion and register the real devices properly?

A few other comments on the patch:

> --- linux-2.6/drivers/sh/superhyway/Makefile	1970-01-01 02:00:00.000000000 +0200
> +++ sh64--stable--2.6/drivers/sh/superhyway/Makefile	2004-10-27 09:10:12.000000000 +0300
> @@ -0,0 +1,18 @@
> +#
> +# Makefile for the SuperHyway bus drivers.
> +#
> +
> +obj-$(CONFIG_SUPERHYWAY)	+= superhyway.o
> +obj-$(CONFIG_SYSFS)		+= superhyway-sysfs.o
> +
> +clean-files := devlist.h
> +
> +$(obj)/superhyway.o: $(obj)/devlist.h
> +
> +quiet_cmd_devlist = GEN     $@
> +      cmd_devlist = sed -e 's/^\#.*$$//g;s/^[ ].*$$//g;/^$$/d; \
> +		    	    s/\(0x.*\)	/	{ \1, /g;s/$$/ },/' < $< > $@
> +
> +$(obj)/devlist.h: $(src)/superhyway.ids
> +	$(call cmd,devlist)

We are depreciating device lists within the kernel.  The PCI device list
will be going away sometime in the future, and we shouldn't be adding
new ones.  Can't this just be determined from userspace instead like
'lspci' and 'lsusb' do?

> +void superhyway_create_sysfs_files(struct superhyway_device *s)
> +{
> +	struct device *dev = &s->dev;
> +
> +	device_create_file(dev, &dev_attr_perr_flags);
> +	device_create_file(dev, &dev_attr_merr_flags);
> +	device_create_file(dev, &dev_attr_mod_vers);
> +	device_create_file(dev, &dev_attr_mod_id);
> +	device_create_file(dev, &dev_attr_bot_mb);
> +	device_create_file(dev, &dev_attr_top_mb);
> +	device_create_file(dev, &dev_attr_resource);

Can you use a default attribute list instead of manually creating the
files individually?  Also, I don't see the code that removes these
attributes.  Please don't rely on the sysfs function of automatically
cleaning up the attributes when the device is removed, that might not
work in the future.

> +static struct superhyway_bus superhyway_bus = {
> +	.name	= "SuperHyway bus",
> +};

Please don't add sysfs directories that have spaces in them.  How about
"superhyway_bus" instead?

> +/**
> + * superhyway_add_device - Add a SuperHyway module
> + * @mod_id: Module ID (taken from MODULE.VCR.MOD_ID).
> + * @base: Physical address where module is mapped.
> + * @vcr: VCR value.
> + *
> + * This is responsible for adding a new SuperHyway module. This sets up a new
> + * struct superhyway_device for the module being added. Each one of @mod_id,
> + * @base, and @vcr are registered with the new device for further use
> + * elsewhere.
> + *
> + * Devices are initially added in the order that they are scanned (from the
> + * top-down of the memory map), and are assigned an ID based on the order that
> + * they are added. Any manual addition of a module will thus get the ID after
> + * the devices already discovered regardless of where it resides in memory.
> + *
> + * Further work can and should be done in superhyway_scan_bus(), to be sure
> + * that any new modules are properly discovered and subsequently registered.
> + */
> +int superhyway_add_device(unsigned int mod_id, unsigned long base,
> +			  unsigned long long vcr)
> +{
> +	struct superhyway_device *dev;
> +	int ret;
> +
> +	dev = kmalloc(sizeof(struct superhyway_device), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	memset(dev, 0, sizeof(struct superhyway_device));
> +
> +	dev->id.id = mod_id;
> +	sprintf(dev->name, "SuperHyway device %04x\n", dev->id.id);
> +
> +	superhyway_name_device(dev);
> +
> +	dev->vcr		= *((struct vcr_info *)(&vcr));
> +	dev->resource.name	= dev->name;
> +	dev->resource.start	= base;
> +	dev->resource.end	= dev->resource.start + 0x01000000;
> +	dev->dev.parent		= &superhyway_bus.dev;
> +	dev->dev.bus		= &superhyway_bus_type;
> +
> +	sprintf(dev->dev.bus_id, "%02x", superhyway_devices);
> +
> +	pr_info("    0x%04x (%s) control block at 0x%08lx\n",
> +		dev->id.id, dev->pretty_name, dev->resource.start);

Shouldn't this be a debug message?

> +static void __exit superhyway_bus_exit(void)
> +{
> +	struct superhyway_device *dev;
> +
> +	list_for_each_entry(dev, &superhyway_bus.devices, node) {
> +		device_unregister(&dev->dev);
> +		kfree(dev);
> +	}

Ick, not good, userspace could still have a reference on the device
through sysfs.  Don't kfree it here, do it in the release function
(which you need to do.)

Also, why have a local list of devices and not just use the list the
driver core provides for you?

> +struct superhyway_device {
> +	struct list_head node;
> +
> +	char name[32];
> +	char pretty_name[64];

Do you need the name and pretty_name?

> +struct superhyway_bus {
> +	struct list_head devices;
> +	struct device dev;
> +	char name[16];
> +};

Is the name really necessary?

> +/* drivers/sh/superhyway/superhyway-sysfs.c */
> +#ifdef CONFIG_SYSFS
> +void superhyway_create_sysfs_files(struct superhyway_device *);
> +#else
> +void superhyway_create_sysfs_files(struct superhyway_device *s)
> +{
> +	/* Nothing to do */
> +}
> +#endif

Why ifdef this function?  That should not be needed.

thanks,

greg k-h
