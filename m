Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbTCICXW>; Sat, 8 Mar 2003 21:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbTCICXW>; Sat, 8 Mar 2003 21:23:22 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:8584 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262365AbTCICXU>;
	Sat, 8 Mar 2003 21:23:20 -0500
Date: Sun, 9 Mar 2003 03:33:43 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030309023343.GA3519@vana.vc.cvut.cz>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308191237.GA26374@kroah.com> <20030308194714.GA7340@vana.vc.cvut.cz> <20030308195117.GE26374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308195117.GE26374@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Scroll to the end...]

> The case where while probe() is called, the module is unloaded.
> Same thing for remove().
> 
> That's all.
> 
> > After driver calls pci_unregister_driver,
> > it is sure that there are no other users of this pci driver.
> 
> Sure, but that's not the case of what we are protecting here.  We want
> pci_unregister_driver() (which is usually called from the module_exit()

Usually! pci_unregister_driver has nothing to do with module_exit(), unless
there is some rule which says that pci_unregister_driver may be called
from module_exit() only.

> function), to not be called if we are in the middle of calling either
> probe() or release().
> 
> Do you have a way of protecting the race that is described by Russell
> here that differs from my patch?

There must be normal subsystem locking which prevents you from such race.

Russel King wrote:

> Load PCI driver.

> PCI driver registers using pci_module_init(), and adds itself to sysfs.

> Hot-plugin a PCI device which uses this driver.  sysfs matches the PCI
> driver, and calls the PCI drivers probe function.

> The probe function calls kmalloc or some other function which sleeps
> (or gets preempted, if CONFIG_PREEMPT is enabled.)

> We switch to another thread, which happens to be rmmod for this PCI
> driver.  We remove the driver since it has a use count of zero.

> We switch back to the PCI driver.  Oops.

Both calls to ->probe (& ->remove) must happen under same lock which
is used by pci_(un)register_driver. Driver expects that there is no
device registered after return from pci_unregister_driver, and
your if (try_module_get())... violates this - you simply skip call
to ->remove if module is in unloading state - although I see no reason
why you could not enter driver's ->remove function long before
pci_unregister_driver is called.

Also pci_unregister_driver() expects ->remove to be called for all
registered devices. If you'll guard this call by try_module_get(),
no device will get unregistered from driver, causing memory leaks or
even crashes.

Well, and after reading sysfs code: there is no problem (I would be
really surprised otherwise), as both hotplug event and driver 
registration/removal are guarded by bus->subsys.rwsem semaphore, 
so pci_unregister_driver() succeeds after previous ->remove 
(or ->probe or ...) finishes.

Just make sure that people do not call device_release_driver
unless they really know what they are doing. Proper interface is
bus_remove_device or bus_remove_driver...
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

					
