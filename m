Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSHOFEk>; Thu, 15 Aug 2002 01:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSHOFEk>; Thu, 15 Aug 2002 01:04:40 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:20229 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316574AbSHOFEj>;
	Thu, 15 Aug 2002 01:04:39 -0400
Date: Wed, 14 Aug 2002 22:04:20 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: driverfs: [PATCH] remove bus and improve driver management (2.5.30)
Message-ID: <20020815050419.GB30226@kroah.com>
References: <3D5AD6BF.8060609@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5AD6BF.8060609@netscape.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 18 Jul 2002 03:48:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 14, 2002 at 10:16:31PM +0000, Adam Belay wrote:
>    This patch removes bus.c from the Driver Model and replaces it with 
> a more advanced and scaleable driver subsystem.  
> 
> The following diagram illustrates the current Driver Model 
> implementation for drivers:
> bus->    pci->    parport_pc
>                           agpgart
>                           cardbus
>              usb->    
>                           hid
> 

Hm, I'm a bit slow, but even with your second drawings, I still don't
understand this.  Can you add | and - lines to the drawing, it would
help me understand what you are trying to show here.

>    Lets say that the usb bus is connected to pci0.  Notice how the usb 
> driver has no linkage to the pci driver.  It should in order to take 
> full advatage of the power management and other features of the driver 
> model.

But there is a pci driver that implements the USB "bridge" from PCI to
usb.  It's a pci driver, and it shows up in the full device tree as
joining PCI to USB.  It's called uhci-hcd, ohci-hcd, or ehci-hcd
depending on the type of PCI USB controller you have.

> Of course the usb bus could create another driver and register 
> it to pci but that would be wasteful and overly complicated.

Um, I don't understand, this is already there.

> Also notice that parport_pc could have a printer attached to it.  The
> lp driver would control this device but there is no way to represent
> the lp driver in the current model since only buses can have child
> drivers.

Have you looked at the /root directory in the driverfs mount?  It shows
all the devices hooked together like you are talking about.

Yes, the bus subdirectories are separate, but that's because they focus
on bus specific stuff, not the interlinking between the busses.  That's
shown in the /root tree.

> The following diagram illustrates the driver implementation after this 
> patch: (this assumes that the listed driver have been converted to the 
> Driver Model)

<plug>
My latest patches to convert the USB code to use the driver model are
at:
	bk://linuxusb.bkbits.net/usb-2.5-driver
It's working pretty well now, thanks to the patches from Pat that are in
Linus's latest bk tree.
</plug>

> driver->    pci->    usb->                hid
>                              parport_pc->    lp
>                              agpgart
>                              cardbus

Again, I don't quite understand the drawing, sorry.

>    Notice that this implementation not only solves the problems listed 
> earlier but also it is more scalable because it lists the drivers by 
> thier true relationship to one another.  These changes actually reduce 
> the total amount of code as well as the complexity of the entire system 
> resulting in better efficiency and perhaps even less memory consumption.

But what's the problem you are trying to solve?  How the devices
interact in the global device tree?  That's already shown properly.  Or
am I missing something here?

>    `This patch also provides user level driver management support 
> through the advanced features of the new interface.  It creates a file 
> entry named "driver" for each device.
> To attach a driver simply echo the name of the driver you want to 
> attach.  For example:
> #cd ./root/pci0/00:00.0
> #echo "agpgart" > driver

Hm, how does this bind the driver to the device?  What if the driver
doesn't want to bind to this device?  And how does userspace know what
pci device to bind to what driver?  Does it use the information in the
modules.*map file?  If so, that comes directly from the drivers
themselves, which are the ones knowing what devices they _should_ be
bound to, so why not let the driver themselves do the work (well
actually the very small function at
drivers/pci/pci-driver.c:pci_match_device() does the work).

> To remove a driver simply echo remove to the driver file while a driver 
> is loaded.  For example:
> #echo "remove" > driver

Again, why?  And does this force the ->remove() function to be called?

> If you read the driver file you will get the name of the loaded driver 
> if a driver is loaded.  For example:
> #cat driver
> output: agpgart

Now this is a nice idea.  But I was thinking of moving the symlink from
the bus/pci/devices to be under the specific driver in
bus/pci/drivers/foo_driver.  That would show you at a simple glance
which driver is bound to which device.  But putting the name in the
device entry in the /root tree would be good enough too.

> This patch is against 2.5.30.  The following still needs to be done:
> 1.) port to 2.5.31

Watch out, there are lots of driver model changes already in Linus's
tree (post 2.5.31.)

thanks,

greg k-h
