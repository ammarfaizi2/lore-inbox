Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSHJPj4>; Sat, 10 Aug 2002 11:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSHJPj4>; Sat, 10 Aug 2002 11:39:56 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:38666 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317036AbSHJPjz>;
	Sat, 10 Aug 2002 11:39:55 -0400
Date: Sat, 10 Aug 2002 08:40:18 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [linux-usb-devel] [RFC] USB driver conversion to use "struct device_driver"
Message-ID: <20020810154018.GB32083@kroah.com>
References: <20020810001005.GA29490@kroah.com> <200208101157.28759.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208101157.28759.oliver@neukum.name>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sat, 13 Jul 2002 14:27:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 11:57:28AM +0200, Oliver Neukum wrote:
> Am Samstag, 10. August 2002 02:10 schrieb Greg KH:
> > Hi all,
> 
> > The USB subsystem only binds drivers to USB "interfaces".  A USB device
> > may have many "interfaces", so a single device may have many drivers
> > attached to it, handling different portions of it (think of a USB
> > speaker, which has a audio driver for the audio stream, and a HID driver
> > for the speaker buttons.)  Because of this I had to create a "empty"
> > device driver that I attach to the USB device structure.  This ensures
> > it shows up properly in the driverfs tree, and that no USB drivers try
> > to bind to it.
> 
> Hi,
> 
> the probe/disconnect changes are an improvement.
> But what do we call a device? IMHO the device in
> terms of driverfs is the interface, thus the usb_device
> should be seen as a bus, which interfaces are attached to.

Hm, I don't really understand your question, but I'll try to explain
how I did this.

Both struct usb_device and struct usb_interface now have a struct
device.  This is because _both_ things need to show up in the driverfs
tree.  I tried only making interfaces be devices (which is more of what
the USB core code things of as devices), but the tree just didn't make
much sense.  Also, a USB device contains such things as the control
pipe, and the usb descriptors and strings.  So it is useful to show the
device, as that's where you get the device name and serial number from :)

Does that help?

Try looking at the usb driverfs implementation as it is in 2.5.30, both
the interfaces and the main device show up in the tree, I didn't change
this.  All this patch does is start to use "struct device_driver", and
bind the drivers to the interfaces, _which_ is what the USB core has
always done (no change in functionality here.)  What this allows us to
do is remove (eventually) the USB list of devices, and remove some other
device list logic, as well as clean up the probe/disconnect interface.

thanks,

greg k-h
