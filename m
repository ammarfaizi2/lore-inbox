Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbTFSN7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 09:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbTFSN7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 09:59:53 -0400
Received: from ida.rowland.org ([192.131.102.52]:2564 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265631AbTFSN7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 09:59:46 -0400
Date: Thu, 19 Jun 2003 10:13:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030618171527.GA1415@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0306190949200.998-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another way to express some of my questions.

Consider that many of the buses in a computer system have interconnects 
that are sufficiently complicated to warrant their own driver.  For 
example, a SCSI adapter card can be regarded as an interconnect between 
a PCI bus and a SCSI bus.  A USB host controller is an interconnect 
between a PCI bus and a USB bus.  Each of these requires its own driver.

Should the interconnect's driver add a device under /sys/devices/, and if 
so, where?

Right now they don't.  For example, I have a SCSI card in my system.  It
shows up as /sys/devices/pci0/0000:00:0d.0/ -- that's the PCI bus driver's
view of the card.  It also shows up as
/sys/devices/pci0/0000:00:0d.0/host1/ -- that's the SCSI core's view of 
the same card.  So there are two devices representing the same physical 
object, and neither of them is created by the aic7xxx driver.

The same thing happens with USB.  /sys/devices/pci0/0000:00:07.2/ and 
/sys/devices/pci0/0000:00:07.2/usb1/ are two views of the same host 
controller, created by the PCI and USB bus drivers.  There's no entry 
created by the host controller driver.

Now presumably this fits the driver model okay; I haven't seen any 
requirement that _every_ device/driver combination must have an entry 
under /sys/devices/.  Still, supposing the driver _did_ want to create its 
own object, where would it go?

Would the SCSI host adapter device show up as 
/sys/devices/pci0/0000:00:0d.0/aic7xxx/host1/ -- intermediate between the 
PCI and SCSI bus driver entries?  Should it appear as 
/sys/devices/pci0/0000:00:0d.0/host1/aic7xxx/ -- under the SCSI bus entry?  
Or should it not appear under /sys/devices/ at all but somewhere else 
instead, such as /sys/class/scsi_host/host1/aic7xxx/ ?

The same questions apply to the USB host controller example.

Bear in mind that these interconnects are not the same manner of device as
a disk or a mouse.  They're not things the user normally manipulates and
they aren't accessed through /dev/.  Does that mean that they don't
deserve to go under /sys/classes/ ?


To change the topic slightly, consider this small inconsistency in sysfs.  
The IDE bus driver creates entries for each IDE channel.  So for example, 
/sys/devices/pci0/0000:00:07.1/ide0/0.0/ represents the master device on 
channel 0 whereas /sys/devices/pci0/0000:00:07.1/ide1/1.1 represents the 
slave device on channel 1.  The SCSI bus driver, on the other hand, does 
not create intermediate levels in the hierarchy for channels or targets.  
So for example, /sys/devices/pci0/0000:00:0d.0/host1/1:0:5:0/ is the entry 
for host 1, channel 0, target 5, LUN 0.  There's nothing in between the 
host level and the LUN level.

Is that the sort of decision that's left up to the bus driver author?  
Should there be any sort of enforced consistency, or doesn't it matter?

Still trying to grasp the fundamental principles at work here...

Alan Stern

