Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSKZEpq>; Mon, 25 Nov 2002 23:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSKZEpq>; Mon, 25 Nov 2002 23:45:46 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:37303 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262807AbSKZEpo>; Mon, 25 Nov 2002 23:45:44 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 25 Nov 2002 20:52:46 -0800
Message-Id: <200211260452.UAA22120@adam.yggdrasil.com>
To: greg@kroah.com
Subject: Re: [PATCH] Module alias and table support
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org, perex@suse.cz,
       rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah wrote:
>On Mon, Nov 25, 2002 at 07:26:27PM -0800, Adam J. Richter wrote:
[...]
>> 	If we're going to use strings for device ID matching,
>> then we can consolidate all of the xxx_device_id types into one:
>> 
>> 
>> struct device_id {
>> 	const char	*pattern;
>> 	/* In practice, many drivers want scalar driver data, many
>> 	   want an integer, and a few could benefit from having both.
>> 	   Alternatively, we could have no extra match data at all
>> 	   and make drivers declare a parallel table, for it, but
>> 	   most drivers only have a few ID's to match, so the cost of
>> 	   providing these fields is small. */
>> 	int		match_scalar;
>> 	void		*match_ptr;
>> };

>Nice idea, but how are you going to get the pre-processor to generate a
>string with the proper pattern, based on a bunch of flags and integers?
>(not to say it can't be done, just tricky stuff...)

	We won't.  What I meant by "eventually" (below) is when
drivers are converted to do this natively.  Initially, I would run a
hacked version of depmod to output appropriate string-based device_id
table declarations and append them to the corresponding .c files, at
least for pci, usb and maybe isapnp.  The others can probably more
easily be done manually.

	number of module_device_id tables in my linux-2.5.49 tree:
		pci		206
		usb	 	 80
		isapnp		 21
		input		  8
		parisc		  7
		parport		  3 (a patch I submitted long ago)
		ieee1394	  1

		Total		326

>> 	There would be a long period of backward compatability wrappers
>> and porting to use the interface directly, but eventually we would have:
>> 
>> 	- only one kind of module device table for generating module aliases,

>Very nice goal.

>> 	- device ID matching consolidated into drivers/base,

>Sorry, can't be fully done.  A number of drivers really want to poke
>around at the device before they say they really claim the device.  So
>we still need to call into them somehow.

	We already have a solution.  A device is only attached if
device_driver->probe() returns zero.  If ->probe() fails, device_attach
continues checking for other possible drivers.

>> 	- No need for user level programs to query devices to generate
>> 	  hotplug information (goodbye pcimodules, usbmodules,
>> 	  isapnpmodules),

>I think these can almost already go away now, with the info we have in
>sysfs.

>> 	- Zero changes to user or kernel needed to add a new hotplug
>> 	  bus type (just drop the driver modules in /lib/modules/nnn/
>> 	  and run depmod).

>That is also a very nice goal.

>Again, nice idea, have any idea how the code would look?

	Yes.  I envision replacing bus_type.match() with something
like this:

/* include/linux/device.h: */

typedef int (*dev_id_callback_t)(struct device *dev, const char *id,void *arg);
/* Return values:
	> 1: Sucess. Do not call the function again.  Return the result code.
	0: Not matched.  Call the function with the next device ID, if any.
	   If no more device ID's, return 0.
	< 0: Error.  Abort, returning the error code.
*/

struct bus_type {
	...
	void	(*for_each_id)(struct device *dev, dev_id_callback_t callback,
			       void *arg);
}

/* drivers/base/bus.c: */

/* dev_id_callback functions */
static int try_this_driver(struct device *dev, const char *id, void *arg)
{
	struct device_driver *drv = arg;

	if (wildcard_match(drv->pattern, id))
		return bus_match(dev, drv, id);
	else
		return 0;
}


static int try_every_driver_and_modprobe(struct device *dev, const char *id,
	    				  void *arg)
{
	int result = 0;
	int try;
	try = 0;
	for(;;) {
		list_for_each(entry,&bus->drivers) {
			struct device_driver * drv =
				container_of(entry,struct device_driver,bus_list);
			result = try_this_driver(dev, id, drv);
			if (result)
				return result;
		}
		if (try++ != 0)
			return result;
		request_module(id); /* or call hotplug or whatever */
	}
	BUG();	/* NOTREACHED */
	return -1;
}

static int device_attach(struct device *dev)
{
	...
	error = (*bus->for_each_id)(dev, try_every_driver_and_modprobe, NULL);
}

static int driver_attach(struct device_driver *drv)
{
	...
        list_for_each(entry,&bus->devices) {
                struct device *dev =container_of(entry,struct device,bus_list);
		result = (*bus->for_each_id)(dev, try_this_driver, drv);
		...
	}
}

/* In drivers/pci/pci-driver.c: */


void pci_for_each_id(struct device *dev, dev_id_callback_t callback,
		      void *arg)
{
	struct pci_dev *pcidev = to_pci_dev(dev);
	char id[100];

	sprintf(id, "pci-vendor=%04x-prod=%04x-...", pcidev->vendor,
		pcidev->product, ...);
	return (*callback)(dev, id, arg);
}


/* In drivers/usb/usb.c: */


void usb_for_each_id(struct device *dev, dev_id_callback_t callback,
		      void *arg)
{
	/* Maybe do this on a per-interface basis as the current USB
	   code does, but assuming that it is per-device illustrates
	   the multiple callback functionality, different from PCI. */

	struct usb_device *dev = to_usb_dev(dev);
	char id[100];
	int result;

	for_each_configuration(config, dev) {
		for_each_interface(intf, config, dev) {
			sprintf(id, "usb-vendor=%04x-prod=%04x-...",
				usbdev->vendor, usbdev->product,
				configuration_data, inteface_data, etc. ...);
			result = (*callback)(dev, id, arg);
			if (result != 0)
				return result;
		}
	}
}


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
