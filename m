Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTFQTfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTFQTfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:35:38 -0400
Received: from ida.rowland.org ([192.131.102.52]:11012 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264902AbTFQTfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:35:36 -0400
Date: Tue, 17 Jun 2003 15:49:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@osdl.org>
cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44.0306161540110.908-100000@cherise>
Message-ID: <Pine.LNX.4.44L0.0306171329370.621-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Patrick Mochel wrote:

> > Are you sure?  Suppose a pcmcia disk drive is plugged in to that socket.  
> > Why is a disk driver going to name its object "pcmcia_socket0"?  It must
> > be the pcmcia socket driver that owns the object, not the disk driver.  So 
> > then where does the disk driver put the disk-related attributes?  Don't 
> > say in /sys/class/pcmcia_socket/pcmcia_socket0/device/, because the driver 
> > doesn't own that object either.
> 
> Well, are you talking about a socket or a disk? Obviously, those are very 
> different devices, and hence have very different objects that you create 
> for them. 
> 
> One way or another, you should be exporting attributes under the directory 
> of the object that you create. If it's a socket, put it under the socket 
> directory above. If it's a disk, then it will have a directory in another 
> location for which you can export attributes. 
> 
> Do you have a specific example, or are you just hypothesizing? 

I have a specific example.  I want to create attribute files to export the
state of the usb-storage driver for each of the devices it manages.  The
problem is that the driver doesn't create the objects representing the
devices themselves -- that's done by the SCSI core.  Usb-storage acts more
like a transport conduit or a SCSI host driver.  But creating attributes
without creating the objects they belong to doesn't fit your model, so no
wonder I ran into trouble.

[Parenthetically, I don't see what's so bad about creating attributes for 
objects you don't own.  Provided it's guaranteed that after 
device_remove_file() returns no one will call the attribute's show() or 
store() methods, and provided you are made aware (by some other mechanism) 
when the object needs to go away, what harm can result?]

There are still aspects of the whole thing I find confusing or illogical.  
Consider this requirement, that attributes should only be created for
objects that the software owns.  In practice this must lead to the
creation of several objects for each actual device, because each different
layer of software managing that device will need to have its own object.  
For example, on my system the master device on the first PCI IDE channel
is a hard disk, hda in fact.  This means that
/sys/devices/pci0/0000:00:07.1/ide0/0.0/ and /sys/block/hda/ refer to the
same physical device.  One is created by the IDE bus driver, the other by
a block device driver.  Granted, there are links from one to the other,
but it still indicates that the organization of sysfs reflects the
software organization of the kernel as much as the physical organization
of the computer system.

This will have to be true in general.  A device is attached to a bus, so
there will be an object created by the bus driver as well as an object
created by the device driver.  Both refer to the same actual physical
device; that there are two sysfs nodes is an artifact of the way the
kernel is written.  And in fact, there are probably cases where the two
drivers live in the same program module and so only need to create own
object which they can jointly own.  In other cases the device driver
doesn't need to register its device in sysfs at all, so there's only the
bus driver's object.

Furthermore, the organization of sysfs itself is difficult to follow.  
Object representing physical devices are supposed to live in the hierarchy
below /sys/devices/, right?  Except for things like disks, which live
below /sys/block/.  And other things that live elsewhere.  It's not at all
clear where to look when searching for the object that represents a
particular device.  What's the principle for deciding whether to put
something under /sys/devices/ or /sys/class/ ?  I notice that the SCSI
system has put objects representing my USB CD-RW drive in
/sys/devices/pci0/0000:00:07.2/usb1/1-1/1-1:0/host0/ and in
/sys/class/scsi_host/host0/ .  These objects are created by the same
software and represent the same thing -- why does there need to be two of
them?  At a minimum, why shouldn't one be a link to the other?  How come
they contain differing attributes? -- and if I were to look for a
particular attribute, how would I know which directory to look in?

In the absence of a firm organizational policy, sysfs will become a 
nightmare of objects, attributes, and links distributed all over the place 
higgledy-piggledy, and no one will know where anything goes.  Now maybe 
things aren't as bad as I've made out, especially seeing as how I'm 
relatively new to all this.  But if there is some such policy, it doesn't 
appear to be clearly stated anywhere.

Sorry for rambling on and maybe appearing a bit sarcastic at times.

Alan Stern

