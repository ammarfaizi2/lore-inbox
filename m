Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSFYTDV>; Tue, 25 Jun 2002 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSFYTDS>; Tue, 25 Jun 2002 15:03:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10140 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315547AbSFYTDL>;
	Tue, 25 Jun 2002 15:03:11 -0400
Date: Tue, 25 Jun 2002 11:58:06 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <Pine.LNX.4.44.0206251146440.9420-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0206251140060.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > You want the ancestral relationship for several reasons. You'd wouldn't
> > power down such a device on PM transitions or during shutdown, but you
> > would stop I/O transactions. The drivers for these devices should recogize
> > it's a remote device and handlethis. And, if you were to remove the bridge
> > device (the network card, etc), you want the devices behind it and their
> > logical mappings to go away gracefully.
> 
> Ok, so what's your take on: NBD (iSCSI without all the SCSI crap),
> software RAID, LVM, ramdisk, partitions (a degenerate case of volume
> management), loopback, and filesystems. All but the last are block devices
> that want to be treated just like disks and will want to know about things
> like PM transitions, etc. Filesystems haven't made it into the tree
> because we've got that info elsewhere and we've been assuming they're
> leafnodes, but if we put loopback devices on top of them, that's no longer
> the case. It'd be cleaner globally if this were all explicit in the driver
> tree.

This is a topic that has come up several times in the last couple days in 
Ottawa. I don't promise to have a complete solution, but this what I have 
so far:

You have two things: a physical device and a number of logical interfaces
to communicate with the device. iSCSI devices, local disks, video devices, 
mice, and joysticks are all physical devices and deserve a place in the 
device tree. 

RAID, LVM, DRI, and the input layer are all logical interfaces to physical 
devices. The drivers are the conduit between the logical and the physical. 
Drivers register devices with the logical interfcaces as their attached. 
It's up to the driver to register with the interfaces, which they already 
do. If registration gets generalized and centralized, you get internal 
linkage between the interfaces and the devices. This is essentially the 
device class voodoo that I've been talking about. 

Concerning power management, if we have a list of interfaces, and each had 
a suspend callback, you could notify the interfaces before you walked the 
device tree. Maybe this could take care of verifying the devices can 
suspend and failing if it's doing I/O that's too important to stop. 

[ We could also create a swap interface that we skip over when we notify 
these interfaces. Then we walk the tree and save state to the swap 
devices. Then, tell the swap devices to suspend, which can notify the 
devices to actually go to sleep....maybe..]

	-pat

