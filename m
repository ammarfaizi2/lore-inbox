Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268117AbTBXGFq>; Mon, 24 Feb 2003 01:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268167AbTBXGFq>; Mon, 24 Feb 2003 01:05:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56589 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268117AbTBXGFp>;
	Mon, 24 Feb 2003 01:05:45 -0500
Date: Sun, 23 Feb 2003 22:08:10 -0800
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
Message-ID: <20030224060810.GB31528@kroah.com>
References: <Pine.LNX.4.44.0302231054420.11584-100000@home.transmeta.com> <Pine.LNX.4.44.0302231531450.2559-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302231531450.2559-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 04:01:10PM -0500, Scott Murray wrote:
> 1) The description of pci_remove_bus_device says "informing the drivers 
>    that the device has been removed", yet unless I'm missing some sysfs
>    wrinkle, no call will be made to an attached driver's remove callback.

It gets called after device_unregister() is called on the pci device,
through the driver core, and is actually done in the pci_device_remove()
function in driver/pci/pci-driver.c

Hm, I just realized that the pci hotplug drivers were calling the remove
function twice (once on their own, and then through sysfs), this patch
will fix that.

> > Can't you just fix up the current users to use "pci_remove_bus_device()". 
> > The breakage seems a bit spiteful ;)
> 
> The current device removal code in all of the PCI hotplug drivers are 
> based to varying degrees on sets of callbacks driven by the pci_visit_* 
> family of functions, and will hence need varying amounts of rework to be 
> able to just call pci_remove_bus_device instead.  My cPCI hotplug driver 
> and the ACPI based driver are likely the easiest to change over, since 
> they attempt none of the more sophisticated resource management tricks 
> that the Compaq and IBM drivers do.

It shouldn't be that tough to convert the Compaq and IBM drivers, I'll
work on it tonight and test on hardware tomorrow.

thanks,

greg k-h
