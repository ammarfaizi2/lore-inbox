Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268975AbTBWWRP>; Sun, 23 Feb 2003 17:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268980AbTBWWRO>; Sun, 23 Feb 2003 17:17:14 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:1749 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S268975AbTBWWRN>; Sun, 23 Feb 2003 17:17:13 -0500
Date: Sun, 23 Feb 2003 17:27:20 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
In-Reply-To: <20030223212432.J20405@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302231648360.2559-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, Russell King wrote:

> On Sun, Feb 23, 2003 at 04:01:10PM -0500, Scott Murray wrote:
> > Having beaten out something roughly similiar for the cPCI hotplug code, 
> > I have a couple of comments:
> > 1) The description of pci_remove_bus_device says "informing the drivers 
> >    that the device has been removed", yet unless I'm missing some sysfs
> >    wrinkle, no call will be made to an attached driver's remove callback.
> 
> pci_remove_all_bus_devices => pci_remove_bus_device =>
>  pci_remove_device => device_unregister => device_del =>
>   bus_remove_device => device_release_driver => driver->remove

Okay, cool.  My cursory browsing of drivers/base/core.c missed this,
my apologies.
 
> > 2) The recursive bus handling in pci_remove_bus_device should probably 
> >    call pci_proc_detach_bus
> 
> Good catch - I'll create a new patch for Monday.
> 
> >    and potentially should also update the parent bridge's subordinate
> >    field.
> 
> Yes - I think this is something we may consider when sorting out the
> insertion.

Your previous example wouldn't, but depending on how the BIOS assigns bus 
numbers at boot time, I could see some docking station hardware suffering 
from the problems I see on cPCI.  For example, if the BIOS does not leave 
a hole in the bus numbers for the docking station's bridge, and there 
happens to be another bridge on the laptop, then you would have the same 
overlapping range problem after docking that I see after hot-inserting a 
peripheral card with a bridge.

> However, whether x86 PCs will survive bus renumbering or not remains to
> be seen.  We currently try to leave as much of the configuration intact
> from the BIOS.

I suspect I'm going to have to try and find out sooner or later, as all of 
the x86 based cPCI system boards that I've seen use either Phoenix or 
Award BIOSes that started their lives in desktop PCs.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


