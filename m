Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760289AbWLFH1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760289AbWLFH1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 02:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760288AbWLFH1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 02:27:15 -0500
Received: from cantor.suse.de ([195.135.220.2]:45368 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760286AbWLFH1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 02:27:14 -0500
Date: Tue, 5 Dec 2006 23:26:51 -0800
From: Greg KH <greg@kroah.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       e1000-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Update Documentation/pci.txt
Message-ID: <20061206072651.GG17199@kroah.com>
References: <456404E2.1060102@jp.fujitsu.com> <20061122182804.GE378@colo.lackof.org> <45663EE8.1080708@jp.fujitsu.com> <20061124051217.GB8202@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124051217.GB8202@colo.lackof.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 10:12:17PM -0700, Grant Grundler wrote:
> On Fri, Nov 24, 2006 at 09:38:00AM +0900, Hidetoshi Seto wrote:
> > Grant Grundler wrote:
> > >Hidetoshi,
> > >I have a nearly finished rewrite of Documentation/pci.txt.
> > >Can you drop this patch for now on my promise to integrate
> > >your proposed text?
> > 
> > No problem at all.
> 
> Thanks - I've posted pci.txt-05 on:
> 	http://www.parisc-linux.org/~grundler/pci.txt-05
> 
> and appended it below.
> 
> pci.txt-03 is the last version I posted.
> pci.txt-04 contains all feedback from Andi Kleen and Randi Dunlap
>            (plus a few other minor changes)
> pci.txt-05 reverts pci_enable_device/pci_request_resource ordering to
> 	reflect current reality. But I've added a comment to remind us
> 	about the issue. Also added Section 10/11 from Hidetoshi-san.
> 	A few minor other changes as well.
> 
> If this looks good, I'll post a diff for gregkh.

This looks very good, thanks for doing this work.  I do have a few minor
comments:

> 1. pci_register_driver() call
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> PCI device drivers call pci_register_driver() during their
> initialization with a pointer to a structure describing the driver
> (struct pci_driver):
> 
> 	field name	Description
> 	----------	------------------------------------------------------
> 	id_table	Pointer to table of device ID's the driver is
> 			interested in.  Most drivers should export this
> 			table using MODULE_DEVICE_TABLE(pci,...).
> 
> 	probe		This probing function gets called (during execution
> 			of pci_register_driver() for already existing
> 			devices or later if a new device gets inserted) for
> 			all PCI devices which match the ID table and are not
> 			"owned" by the other drivers yet. This function gets
> 			passed a "struct pci_dev *" for each device whose
> 			entry in the ID table matches the device. The probe
> 			function returns zero when the driver chooses to
> 			take "ownership" of the device or an error code
> 			(negative number) otherwise.
> 			The probe function always gets called from process
> 			context, so it can sleep.
> 
> 	remove		The remove() function gets called whenever a device
> 			being handled by this driver is removed (either during
> 			deregistration of the driver or when it's manually
> 			pulled out of a hot-pluggable slot).
> 			The remove function always gets called from process
> 			context, so it can sleep.
> 
> 	save_state	Save a device's state before it is suspended.

There is no such callback.  We have "suspend", "suspend_late",
"resume_early", and "resume".  You might want to update this.

> 
> 	suspend		Put device into low power state.
> 
> 	resume		Wake device from low power state.
> 
> 	enable_wake	Enable device to generate wake events from a low power
> 			state.
> 
> 			(Please see Documentation/power/pci.txt for descriptions
> 			of PCI Power Management and the related functions.)


> 
> 
> The ID table is an array of struct pci_device_id entries ending with an
> all-zero entry.  Each entry consists of:
> 
> 	vendor,device	Vendor and device ID to match (or PCI_ANY_ID)
> 
> 	subvendor,	Subsystem vendor and device ID to match (or PCI_ANY_ID)
> 	subdevice,
> 
> 	class		Device class, subclass, and "interface" to match.
> 			See Appendix D of the PCI Local Bus Spec or
> 			include/linux/pci_ids.h for a full list of classes.
> 			Most drivers do not need to specify class/class_mask
> 			as vendor/device is normally sufficient.
> 
> 	class_mask	limit which sub-fields of the class field are compared.
> 			See drivers/scsi/sym53c8xx_2/ for example of usage.
> 
> 	driver_data	Data private to the driver.
> 			Most drivers don't need to use driver_data field.
> 			Best practice is to use driver_data as an index
> 			into a static list of equivalent device types,
> 			instead of using it as a pointer.

Perhaps mention the PCI_DEVICE() and PCI_DEVICE_CLASS() macros to set
these fields properly?

> Have a table entry {PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID}

PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) is a bit smaller :)

> to have probe() called for every PCI device known to the system.
> 
> New PCI IDs may be added to a device driver pci_ids table at runtime
> as shown below:
> 
> echo "vendor device subvendor subdevice class class_mask driver_data" > \
> /sys/bus/pci/drivers/{driver}/new_id
> 
> All fields are passed in as hexadecimal values (no leading 0x).
> Users need pass only as many fields as necessary:
> 	ovendor, device, subvendor, and subdevice fields default
> 	to PCI_ANY_ID (FFFFFFFF),
> 	oclass and classmask fields default to 0
> 	odriver_data defaults to 0UL.

What's with the "o"s here?

> Once added, the driver probe routine will be invoked for any unclaimed
> PCI devices listed in its (newly updated) pci_ids list.
> 
> Device drivers must initialize use_driver_data in the dynids struct
> in their pci_driver struct prior to calling pci_register_driver in order
> for the driver_data field to get passed to the driver. Otherwise, only a
> 0 (zero) is passed in that field.

Note that _no one_ uses this field, so it might go away soon...

> When the driver exits, it just calls pci_unregister_driver() and the PCI layer
> automatically calls the remove hook for all devices handled by the driver.
> 
> Please mark the initialization and cleanup functions where appropriate
> (the corresponding macros are defined in <linux/init.h>):
> 
> 	__init		Initialization code. Thrown away after the driver
> 			initializes.
> 	__exit		Exit code. Ignored for non-modular drivers.
> 	__devinit	Device initialization code. Identical to __init if
> 			the kernel is not compiled with CONFIG_HOTPLUG, normal
> 			function otherwise.
> 	__devexit	The same for __exit.
> 
> Tips on marks:
> 	o The module_init()/module_exit() functions (and all initialization
>           functions called _only_ from these) should be marked __init/__exit.
> 
> 	o The struct pci_driver shouldn't be marked with any of these tags.
> 
> 	o The ID table array should be marked __devinitdata.
> 
> 	o The probe() and remove() functions (and all initialization
> 	  functions called only from these) should be marked __devinit
> 	  and __devexit.
> 
> 	o If the driver is not a hotplug driver then use only
> 	  __init/__exit and __initdata/__exitdata.

No, don't say this, pci drivers are not "hotplug drivers", and since
CONFIG_HOTPLUG is really hard to turn off these days, don't confuse
people with the devinit stuff.  Everyone gets it wrong...

> 	o Pointers to functions marked as __devexit must be created using
> 	  __devexit_p(function_name).  That will generate the function
> 	  name or NULL if the __devexit function will be discarded.

I really recommend just not using any of these for almost all PCI
drivers, as the space savings just really isn't there...

thanks,

greg k-h
