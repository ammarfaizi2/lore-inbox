Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265838AbTFSQve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbTFSQve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:51:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265838AbTFSQvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:51:32 -0400
Date: Thu, 19 Jun 2003 10:07:27 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Alan Stern <stern@rowland.harvard.edu>
cc: Greg KH <greg@kroah.com>, <viro@parcelfarce.linux.theplanet.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44L0.0306190949200.998-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.44.0306190946440.955-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Consider that many of the buses in a computer system have interconnects 
> that are sufficiently complicated to warrant their own driver.  For 
> example, a SCSI adapter card can be regarded as an interconnect between 
> a PCI bus and a SCSI bus.  A USB host controller is an interconnect 
> between a PCI bus and a USB bus.  Each of these requires its own driver.
> 
> Should the interconnect's driver add a device under /sys/devices/, and if 
> so, where?

No, it's already created for them. The USB controller you speak of is a 
PCI device. The driver is a PCI driver. There is already an object that 
represents the physical device in the hierarchy; you do not need to create 
a virtual one to represent it. 

> Right now they don't.  For example, I have a SCSI card in my system.  It
> shows up as /sys/devices/pci0/0000:00:0d.0/ -- that's the PCI bus driver's
> view of the card.  It also shows up as
> /sys/devices/pci0/0000:00:0d.0/host1/ -- that's the SCSI core's view of 
> the same card.  So there are two devices representing the same physical 
> object, and neither of them is created by the aic7xxx driver.
> 
> The same thing happens with USB.  /sys/devices/pci0/0000:00:07.2/ and 
> /sys/devices/pci0/0000:00:07.2/usb1/ are two views of the same host 
> controller, created by the PCI and USB bus drivers.  There's no entry 
> created by the host controller driver.

SCSI copied USB in this respect. I've always been skeptical about the
representation, though Greg had good reason to initially do this. I wonder 
if that object could be moved over /sys/class/usb-host/ these days.. 

> Now presumably this fits the driver model okay; I haven't seen any 
> requirement that _every_ device/driver combination must have an entry 
> under /sys/devices/.  Still, supposing the driver _did_ want to create its 
> own object, where would it go?

Well, what does the object represent? A per-device driver-specific object? 
Is it really a separate object, or does it have a SCSI host object 
embedded in it? Usually, from what I've seen, if there is a per-device 
driver-specific object, it contains an embedded (class) object. This 
object is what the driver registers with the infrastructure for that 
device type.

That embedded structure should contain an embedded struct class_device, 
which is registered with the class (when the driver registers it's 
object). That gives it presence under /sys/class/whatever/

It also gives the driver an object that it owns, via embedding, which it 
is free to export attributes for.

> Bear in mind that these interconnects are not the same manner of device as
> a disk or a mouse.  They're not things the user normally manipulates and
> they aren't accessed through /dev/.  Does that mean that they don't
> deserve to go under /sys/classes/ ?

No, they should still go under /sys/class. 

> To change the topic slightly, consider this small inconsistency in sysfs.  
> The IDE bus driver creates entries for each IDE channel.  So for example, 
> /sys/devices/pci0/0000:00:07.1/ide0/0.0/ represents the master device on 
> channel 0 whereas /sys/devices/pci0/0000:00:07.1/ide1/1.1 represents the 
> slave device on channel 1.  The SCSI bus driver, on the other hand, does 
> not create intermediate levels in the hierarchy for channels or targets.  
> So for example, /sys/devices/pci0/0000:00:0d.0/host1/1:0:5:0/ is the entry 
> for host 1, channel 0, target 5, LUN 0.  There's nothing in between the 
> host level and the LUN level.
> 
> Is that the sort of decision that's left up to the bus driver author?  
> Should there be any sort of enforced consistency, or doesn't it matter?

Yes. :) 

There should be consistency, but it is left up to the authors. We don't 
have the time to babysit each subsystem's sysfs exports. We anticipate a 
de facto standard to arise and everyone to conform to it, especially when 
users point out inconsistencies in them.. 


	-pat

