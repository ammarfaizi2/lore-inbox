Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSHOQXe>; Thu, 15 Aug 2002 12:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSHOQXe>; Thu, 15 Aug 2002 12:23:34 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:33286 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317025AbSHOQXd>;
	Thu, 15 Aug 2002 12:23:33 -0400
Date: Thu, 15 Aug 2002 09:23:08 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: driverfs: [PATCH] remove bus and improve driver management (2.5.30)
Message-ID: <20020815162308.GC32542@kroah.com>
References: <3D5AD6BF.8060609@netscape.net> <20020815050419.GB30226@kroah.com> <3D5B885E.5000407@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5B885E.5000407@netscape.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 18 Jul 2002 14:20:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 10:54:22AM +0000, Adam Belay wrote:
> 
> my old driver tree:
> /driverfs/bus
> /driverfs/bus/pci
> /driverfs/bus/pci/drivers/agpgart
> /driverfs/bus/pci/drivers/cardbus
> /driverfs/bus/pci/drivers/parport_pc
> /driverfs/bus/usb
> 
> my new tree now:
> /driverfs/driver/
> /driverfs/driver/pci
> /driverfs/driver/pci/agpgart
> /driverfs/driver/pci/cardbus
> /driverfs/driver/pci/parport_pc
> 
> a possibility for my tree when drivers that need it convert to my 
> changes  and the driver model in general:
> /driverfs/driver/
> /driverfs/driver/pci
> /driverfs/driver/pci/agpgart
> /driverfs/driver/pci/cardbus
> /driverfs/driver/pci/parport_pc
> /driverfs/driver/pci/parport_pc/lp
> /driverfs/driver/pci/usb
> /driverfs/driver/pci/usb/hid
> 
> * I am not saying that usb has to be done this way but if you notice in 
> the first diagram (the old implementation) usb does not have any driver 
> representation with pci or if it does it is not displayed.  The lp 
> driver is significant because it is imposible to cleanly implement 3 
> levels of drivers in the current Driver Model.

Ah that makes more sense now, thanks.

But the problem is that the USB hid driver does NOT have a relationship
with a pci driver.  The USB drivers don't care about what kind of host
controller driver they talk to, _and_ that relationship isn't present.
There are quite a few USB host drivers that do not sit on the PCI bus,
but talk directly over a "system" bus to the controller (embedded
devices mostly.)

But a PCI bus could also be present, with a USB controller, and the hid
driver would be able to handle devices on it too.  So how would you show
this "dual" relationship then?

In short, I don't see the value in showing relationships between
different driver types.  But I see the value in relationships between
devices, as is shown in the root/ tree.

>     As you can now see in my new diagrams the problem I am trying to 
> solve is not how devices are represented but rather how drivers are 
> represented.  Sorry I wasn't clear.  I have completely removed bus and 
> replaced it with a driver interface.  This is better because a bus does 
> not deserve special implementations as it is a driver too.  My more 
> scaleable interface can handle both buses and drivers.

A bus is different than a driver, as drivers bind to the bus type.  In a
way, you can say a bus is nothing more than a "class", and class support
_is_ coming soon.  I think class support is what you are really looking
for, as it will be able to show you the relationship between devices
much better.

> >>   `This patch also provides user level driver management support 
> >>through the advanced features of the new interface.  It creates a file 
> >>entry named "driver" for each device.
> >>To attach a driver simply echo the name of the driver you want to 
> >>attach.  For example:
> >>#cd ./root/pci0/00:00.0
> >>#echo "agpgart" > driver
> >>
> >
> >Hm, how does this bind the driver to the device?  What if the driver
> >doesn't want to bind to this device?  And how does userspace know what
> >pci device to bind to what driver?  Does it use the information in the
> >modules.*map file?  If so, that comes directly from the drivers
> >themselves, which are the ones knowing what devices they _should_ be
> >bound to, so why not let the driver themselves do the work (well
> >actually the very small function at
> >drivers/pci/pci-driver.c:pci_match_device() does the work).
> >
> This feature is well designed, if a driver doesn't want to bind to the 
> device the request will fail.  Check the code yourself.  This is simply 
> a userspace override for the Driver Model.  This is useful because it 
> provides the user with more control over driver management.  If two 
> drivers can support the same device and the driver model selects one the 
> user doesn't want to use the user can change it.  This could even happen 
> now with ALSA and Open Sound.  Since it calls both probe and match it is 
> also a great debugging tool.  I'm currently working on a user level 
> utility that will take full advantage of this and other driver 
> management features.

Again, I don't see the advantage here.  Since you say the kernel driver
knows best, and that the kernel driver gets a say in if it really binds
to the device or not, why not just let the kernel driver do all the work
then?  I don't see how an extra step from the user will help any.
'insmod' works quite well for picking which driver you want loaded for
the devices (ALSA vs. OSS.)  Yes, it doesn't handle mixing lots of the
same device with different drivers, but I don't think that is a very
common thing (otherwise people would have complained about it by now.)

> >>To remove a driver simply echo remove to the driver file while a driver 
> >>is loaded.  For example:
> >>#echo "remove" > driver
> >>
> >
> >Again, why?  And does this force the ->remove() function to be called?
> >
> Yes this does call ->remove() among other things.  In fact it calls 
> do_driver_detach.
> Why is above.

Again, 'rmmod' does the same thing :)

thanks,

greg k-h
