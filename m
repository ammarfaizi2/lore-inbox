Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSFUQWp>; Fri, 21 Jun 2002 12:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSFUQWo>; Fri, 21 Jun 2002 12:22:44 -0400
Received: from air-2.osdl.org ([65.172.181.6]:21402 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316675AbSFUQWm>;
	Fri, 21 Jun 2002 12:22:42 -0400
Date: Fri, 21 Jun 2002 09:17:18 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: sullivan <sullivan@austin.ibm.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <20020621092943.D1243@austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0206210850240.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The driverfs patch for SCSI that was recently posted was the kernel portion of 
> a device naming project that is intended to support all devices, at least the 
> ones that implement to driverfs in a standard way. There are three items that
> IMHO should be considered as part of the standard set that driverfs requires:
> 
> 1. device type - It appears that Pat is heading down this path with the class
> 	type support so maybe this is a no brainer. Currently the scsi
> 	driverfs provides a "type" file to contain this info. The current
> 	strings used are taken from the scsi_device_types[] but should be
> 	replaced with the system wide device types that driverfs will provide.

Yes, they are pretty much the same thing. 

> 2. uid - Since topology and discovery order of hardware can change, the
> 	driverfs path names to a device are also subject to change. To
> 	easily identify a device I think it's important that the driverfs
> 	bus implementations be responsible for create a unique identifier.
> 
> 	Since each bus and the devices attached to it will have varying
> 	capabilities for identifying themselves the contents for this file
> 	should probably be a variable length string.
> 
> 	Even for older devices that can't do a great job of providing info to
> 	uniquely identify themselves, the driverfs tree provides the nice
> 	topological context to fall back upon that allows at least as
> 	good of a job to be done as we do today.
> 
> 	The scsi patch currently creates uid info from the INQUIRY evpd pages
> 	and makes it available in the name file. I would prefer to see a
> 	new standard uid file and let the name file contain a descriptive 
> 	(non-unique) name.

Yes, I agree. UUIDs are needed to do any type of persistant naming (well). 
As you say, there are varying ways for determining the UUID, and some ways 
may not be present for some devices. It will be up to the various driver 
levels to determine if they can determine a better UUID than higher level 
layers.

For example, PCI by default doesn't have very good unique information. 
About the best it can do is something like munging together:

	<bus><device><function><class><subclass>

If that device is a network card, the class driver can set the UUID of the 
device to the MAC of the device. (Network cards won't be named, but it's 
only an example). (Or, the label of a disk). 

Further, if the device driver knows an even better way to ID the device, 
e.g. via a serial number on the device, it can do so. 

Some buses and their driver won't have to worry, since that information is 
mandatory in the devices. 

> 3. kdev - To create/manage/interface with the device node we need to know the
>  	kdev.

Sure. I don't have objections to this. It will likely become obvious that 
we need this later on...

> Because of coldplugging this information should be available in each
> driverfs device directory. Also, adding the driverfs path name on
> /sbin/hotplug events and allowing the consumer to retrieve the info
> from the filesystem might help simplify some of these implementations
> too.

This information should be exported, I agree. But, we could theoretically 
achieve a state where every device discovered gets a call to 
/sbin/hotplug. 

[ With initramfs, we could have the rootfs partition mounted before we 
start probing for any devices. As long as that had /sbin/hotplug, and the 
means and policy to name devices, it should work. ]

	-pat

